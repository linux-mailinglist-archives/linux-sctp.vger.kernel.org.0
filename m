Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 056D23A4A4A
	for <lists+linux-sctp@lfdr.de>; Fri, 11 Jun 2021 22:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhFKUox convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 11 Jun 2021 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFKUow (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 11 Jun 2021 16:44:52 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734BDC061574
        for <linux-sctp@vger.kernel.org>; Fri, 11 Jun 2021 13:42:54 -0700 (PDT)
Received: from smtpclient.apple (unknown [IPv6:2a02:8109:1140:c3d:2862:40f8:5936:1a27])
        (Authenticated sender: macmic)
        by mail-n.franken.de (Postfix) with ESMTPSA id 1C059721E2809;
        Fri, 11 Jun 2021 22:42:49 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: The new sysctl and socket option added for PLPMTUD (RFC8899)
From:   tuexen@freebsd.org
In-Reply-To: <CADvbK_c0dmke8Ei2sLiVqZ2ExgcmZyuPwpHBgW9g6Cjdi+rzug@mail.gmail.com>
Date:   Fri, 11 Jun 2021 22:42:48 +0200
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <E64A2DFD-9D39-470C-BA32-459B34F8B410@freebsd.org>
References: <CADvbK_c0dmke8Ei2sLiVqZ2ExgcmZyuPwpHBgW9g6Cjdi+rzug@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 11. Jun 2021, at 22:20, Xin Long <lucien.xin@gmail.com> wrote:
> 
> Hi, Michael,
> 
> In the linux implementation of RFC8899, we decided to introduce one
> sysctl and one socket option for users to set up the PLPMUTD probe:
> 
> 1. sysctl -w net.sctp.plpmtud_probe_interval=1
> 
> plpmtud_probe_interval - INTEGER
>        The interval (in milliseconds) between PLPMTUD probe chunks. These
>        chunks are sent at the specified interval with a variable size to
>        probe the mtu of a given path between 2 associations. PLPMTUD will
I guess you mean "between 2 end points" instead of "between 2 associations".

I'm not sure what it means:

I assume, you have candidate 1400, 1420, 1460, 1480, and 1500.

Assume you sent a probe packet for 1400. Aren't you sending the
probe packet for 1420 as soon as you get an ACK for the probe packet
of size 1400? Or are you waiting for plpmtud_probe_interval ms?
>        be disabled when 0 is set.
> 
>        Default: 0
> 
> 2. a socket option that can be used per socket, assoc or transport
> 
> /* PLPMTUD Probe Interval socket option */
> struct sctp_probeinterval {
>        sctp_assoc_t spi_assoc_id;
>        struct sockaddr_storage spi_address;
>        __u32 spi_interval;
> };
> 
> #define SCTP_PLPMTUD_PROBE_INTERVAL    133
> 
> 
> The value above will enable/disable the PLPMUTD probe by setting up the probe
> interval for the timer. When it's 0, the timer will also stop and
> PLPMUTD is disabled.
> By this way, we don't need to introduce more options.
OK.
> 
> We're expecting to keep consistent with BSD on this, pls check and
> share your thoughts.
Looks good to me.

Best regards
Michael
> 
> Thanks.

