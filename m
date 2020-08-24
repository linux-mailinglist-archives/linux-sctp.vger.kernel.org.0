Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603C924FC37
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Aug 2020 13:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHXLCj (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 24 Aug 2020 07:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgHXLCi (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 24 Aug 2020 07:02:38 -0400
X-Greylist: delayed 931 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 24 Aug 2020 04:02:38 PDT
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFD5C061573
        for <linux-sctp@vger.kernel.org>; Mon, 24 Aug 2020 04:02:38 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.89)
        (envelope-from <laforge@gnumonks.org>)
        id 1kAA0A-00010P-Aj; Mon, 24 Aug 2020 12:46:58 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.94)
        (envelope-from <laforge@gnumonks.org>)
        id 1kAA02-00GAtC-8C; Mon, 24 Aug 2020 12:46:50 +0200
Date:   Mon, 24 Aug 2020 12:46:50 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     Pau Espin Pedrol <pespin@sysmocom.de>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: Re: SCTP multi-homed association (::1)->(::1+127.0.0.1) attempting
 HEARTBEAT on 127.0.0.1->127.0.0.1
Message-ID: <20200824104650.GC3822842@nataraja>
References: <552de663-8aeb-ff84-a425-988da88ca5cd@sysmocom.de>
 <20200821201704.GN3399@localhost.localdomain>
 <44227020-4061-9fc9-0175-e64de5c22e15@sysmocom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44227020-4061-9fc9-0175-e64de5c22e15@sysmocom.de>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Pau and list,

On Mon, Aug 24, 2020 at 12:00:27PM +0200, Pau Espin Pedrol wrote:

> Quick similar scenario setup would be something like:
> 
> SERVER:
> server_fd = socket(AF_INET6, SCTP, STREAM);
> sctp_bindx(server_fd, "127.0.0.1", "::1");
> listen(server_fd); accept(server_fd);
> 
> CLIENT:
> client_fd = socket(AF_INET6, SCTP, STREAM);
> sctp_bindx(client_fd, "::1");
> sctp_connectx(client_fd, "::1");
> 
> And then after client connects ::1<->::1 and gains info about server's
> 127.0.0.1 address, it tries to INIT 127.0.0.1->127.0.0.1 despite it was
> never bound to 127.0.0.1.

Thanks for reducing the example to the above.  I think it should be pretty
clear now.  The client side kernel SCTP is misbehaving here.

One minor amendment:  I don't think it's a question of whether or not the client
side socket ever was bound to 127.0.0.1.  The key issue here is that the client side
socket was not bound to any IPv4 address at all.

Sidenote: What I also find puzzling is that both sockets in your example are
created as AF_INET6 sockets, not as AF_UNSPEC.  But let's stay focused on the 
actual problem here: A client-side socket being exclusively bound to IPv6 adresses
attempting to send INIT chunks from an IPv4 address!

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
