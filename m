Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1672DC6
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jul 2019 13:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfGXLjH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 07:39:07 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:50038 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfGXLjH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 07:39:07 -0400
Received: from cpe-2606-a000-111b-6140-0-0-0-162e.dyn6.twc.com ([2606:a000:111b:6140::162e] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1hqFbr-0006RK-IF; Wed, 24 Jul 2019 07:39:05 -0400
Date:   Wed, 24 Jul 2019 07:38:36 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Jianwen Ji <jijianwen@gmail.com>
Cc:     linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v2 lksctp-tools] testlib: improve test_bind function
Message-ID: <20190724113836.GB7212@hmswarspite.think-freely.org>
References: <20190724103930.13727-1-jijianwen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724103930.13727-1-jijianwen@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jul 24, 2019 at 06:39:30PM +0800, Jianwen Ji wrote:
> Try to bind again if the errno is EADDRINUSE.
> Some tests failed to run sometimes, here is one snapshot:
> 
>    ...
> 
>    test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
>    test_sockopt.c 26 BROK : bind: Address already in use
>    DUMP_CORE ../../src/testlib/sctputil.h: 145
> 
>    ...
> 
>    test_1_to_1_sendmsg.c 10 PASS : sendmsg() on a closed association - EPIPE
>    test_1_to_1_sendmsg.c 11 BROK : bind: Address already in use
>    DUMP_CORE ../../src/testlib/sctputil.h: 145
> 
> The reason is that it closed a socket and then created a new socket
> to bind the same socket address as before, which was not released
> yet.
> 
> Signed-off-by: Jianwen Ji <jijianwen@gmail.com>
> ---
>  src/testlib/sctputil.h | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
> index 9dbabd4..5b807c7 100644
> --- a/src/testlib/sctputil.h
> +++ b/src/testlib/sctputil.h
> @@ -54,6 +54,7 @@
>  #endif
>  
>  #include <string.h>
> +#include <unistd.h>
>  
>  typedef union {
>  	struct sockaddr_in v4;	
> @@ -72,6 +73,10 @@ typedef union {
>  #endif
>  #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
>  
> +#ifndef MAX_BIND_RETRYS
> +#define MAX_BIND_RETRYS 10
> +#endif
> +
>  #define SCTP_IP_BCAST  	htonl(0xffffffff)
>  #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
>  
> @@ -140,9 +145,22 @@ static inline int test_socket(int domain, int type, int protocol)
>  
>  static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
>  {
> -	int error = bind(sk, addr, addrlen);
> -        if (-1 == error)
> -                tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> +	int error = 0, i = 0;
> +
> +	do {
> +		if (i > 0) sleep(1); /* sleep a while before new try... */
> +
> +		error = bind(sk, addr, addrlen);
> +		if (-1 == error && errno != EADDRINUSE) {
> +			tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> +		}
> +
> +		i++;
> +		if (i >= MAX_BIND_RETRYS) {
> +			tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> +		}
> +	} while (error < 0 && i < MAX_BIND_RETRYS);
> +
>  	return error;
>  }
>  
> -- 
> 2.14.5
> 
> 
I don't think this is really going to do much.  If a socket isnt released then
its not likely to be released in the amount of time it takes to iterate over
this loop 10 times, and theres no guarantee that it will in the future.  If we
want to ensure avoid EADDRINUSE, the second bind should probably just use
SCTP_TESTPORT_2, instead of reusing _1

Neil

