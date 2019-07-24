Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6C72F1D
	for <lists+linux-sctp@lfdr.de>; Wed, 24 Jul 2019 14:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfGXMkv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 24 Jul 2019 08:40:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40193 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfGXMku (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 24 Jul 2019 08:40:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id a15so45257736qtn.7
        for <linux-sctp@vger.kernel.org>; Wed, 24 Jul 2019 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9fe7Ac4GIQFLmV9u4Mnmjc7Pb/vYveuhViGTlk7NZEI=;
        b=nSKA2c/2lFRTbIXQxvDjrJ/LElrDF7mpwMeJ3T62fOB+Lq3VAASajJdVTISRwzJ2tY
         VZXiMfNg05Z5MYhNrAf1HXfhpRrydGTcefl1T5HYaD1+HlV/Er16V+Rsjj2CS9B3eDvp
         VlY/xIJCCboa7uTnQYvFeWpw5/jkyBlkhe5GM6CKJnrUfqE2x+awCjhR6zA2aRDU2ymC
         5Bak/ll/uBG1/De2Tsp4SyF5i3cQskkTUc/yMbi9svrqPwKPZhvTvxRRRiQ2nmsmtLdp
         7KYD19yAW+LYA6P9Tf06FbreePhwm7ZcZhXhRU4pvPNYh5YTC3CiW3jbC3IgkF3BSLhr
         prJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9fe7Ac4GIQFLmV9u4Mnmjc7Pb/vYveuhViGTlk7NZEI=;
        b=QBb3yH/eJEsLnWOgb2mChRg5yb3VOxo9k4gdBx6RWP5OY189vPBT87ekv28g54bhRo
         ze41BTuw/e2kWh9Zq1wZpx5t4mAZ4h5nMu3UedkfUhdiZvDOgv+Ew+b/ErlOdR4DPCjn
         n7YSa8E34wM640OFoJ52Thk+BgnNkO+7lGuYREMoQ5r8iOSQzM1um5PDQzwJI4Rms2Yo
         1VDCPqrUQNLv6AN0yvlRGklUj6ghdHwZr9HP2SHP3p0TZNDSDSXXSqd/4poiq5AVbcFE
         2dLyvNatT2CewV+JRSV9suFjbJ+1afxN4v2qZZ9I3asRDLmXQFZfceJXGQ2KJv0sFtFw
         yguw==
X-Gm-Message-State: APjAAAXrC35QNaCt+QDDY0A9TJL+X41UfPE5gRYVwbw6j8EBQ3gQEOKM
        H1SZ8D8mR25ummm18FTJlOc=
X-Google-Smtp-Source: APXvYqwmnsqQp2VhH5/7p30CXD6FBhZwGS4B4f5pgCtqtVaCpcEOMjjQ31xb0gXmqi1UXKaDju82Sw==
X-Received: by 2002:a0c:d4eb:: with SMTP id y40mr57772117qvh.30.1563972049760;
        Wed, 24 Jul 2019 05:40:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:2135:7c3d:d61c:7f11:969d])
        by smtp.gmail.com with ESMTPSA id u4sm20681186qkb.16.2019.07.24.05.40.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 05:40:49 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C6489C0AAD; Wed, 24 Jul 2019 09:40:46 -0300 (-03)
Date:   Wed, 24 Jul 2019 09:40:46 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Jianwen Ji <jijianwen@gmail.com>, linux-sctp@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH v2 lksctp-tools] testlib: improve test_bind function
Message-ID: <20190724124046.GE6204@localhost.localdomain>
References: <20190724103930.13727-1-jijianwen@gmail.com>
 <20190724113836.GB7212@hmswarspite.think-freely.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724113836.GB7212@hmswarspite.think-freely.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jul 24, 2019 at 07:38:36AM -0400, Neil Horman wrote:
> On Wed, Jul 24, 2019 at 06:39:30PM +0800, Jianwen Ji wrote:
> > Try to bind again if the errno is EADDRINUSE.
> > Some tests failed to run sometimes, here is one snapshot:
> > 
> >    ...
> > 
> >    test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-many style invalid hb demand
> >    test_sockopt.c 26 BROK : bind: Address already in use
> >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > 
> >    ...
> > 
> >    test_1_to_1_sendmsg.c 10 PASS : sendmsg() on a closed association - EPIPE
> >    test_1_to_1_sendmsg.c 11 BROK : bind: Address already in use
> >    DUMP_CORE ../../src/testlib/sctputil.h: 145
> > 
> > The reason is that it closed a socket and then created a new socket
> > to bind the same socket address as before, which was not released
> > yet.
> > 
> > Signed-off-by: Jianwen Ji <jijianwen@gmail.com>
> > ---
> >  src/testlib/sctputil.h | 24 +++++++++++++++++++++---
> >  1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
> > index 9dbabd4..5b807c7 100644
> > --- a/src/testlib/sctputil.h
> > +++ b/src/testlib/sctputil.h
> > @@ -54,6 +54,7 @@
> >  #endif
> >  
> >  #include <string.h>
> > +#include <unistd.h>
> >  
> >  typedef union {
> >  	struct sockaddr_in v4;	
> > @@ -72,6 +73,10 @@ typedef union {
> >  #endif
> >  #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
> >  
> > +#ifndef MAX_BIND_RETRYS
> > +#define MAX_BIND_RETRYS 10
> > +#endif
> > +
> >  #define SCTP_IP_BCAST  	htonl(0xffffffff)
> >  #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
> >  
> > @@ -140,9 +145,22 @@ static inline int test_socket(int domain, int type, int protocol)
> >  
> >  static inline int test_bind(int sk, struct sockaddr *addr, socklen_t addrlen)
> >  {
> > -	int error = bind(sk, addr, addrlen);
> > -        if (-1 == error)
> > -                tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > +	int error = 0, i = 0;
> > +
> > +	do {
> > +		if (i > 0) sleep(1); /* sleep a while before new try... */
> > +
> > +		error = bind(sk, addr, addrlen);
> > +		if (-1 == error && errno != EADDRINUSE) {
> > +			tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > +		}
> > +
> > +		i++;
> > +		if (i >= MAX_BIND_RETRYS) {
> > +			tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> > +		}
> > +	} while (error < 0 && i < MAX_BIND_RETRYS);
> > +
> >  	return error;
> >  }
> >  
> > -- 
> > 2.14.5
> > 
> > 
> I don't think this is really going to do much.  If a socket isnt released then
> its not likely to be released in the amount of time it takes to iterate over
> this loop 10 times, and theres no guarantee that it will in the future.  If we
> want to ensure avoid EADDRINUSE, the second bind should probably just use
> SCTP_TESTPORT_2, instead of reusing _1

Agree. I'll go farther: if the test doesn't have a strict need on a
specific port number, it should let the kernel assign one. That way it
will also stress the port allocator.  Most of the tests can bind
without specifying a port and then ask which port it got.

  Marcelo
