Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22E1388067
	for <lists+linux-sctp@lfdr.de>; Tue, 18 May 2021 21:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhERTUp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Tue, 18 May 2021 15:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245640AbhERTUo (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 18 May 2021 15:20:44 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8080C061573
        for <linux-sctp@vger.kernel.org>; Tue, 18 May 2021 12:19:26 -0700 (PDT)
Received: from smtpclient.apple (unknown [IPv6:2a02:8109:1140:c3d:e0c4:9f6d:2867:98f4])
        (Authenticated sender: macmic)
        by drew.franken.de (Postfix) with ESMTPSA id EB24F721E2806;
        Tue, 18 May 2021 21:19:23 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
From:   Michael Tuexen <tuexen@freebsd.org>
In-Reply-To: <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
Date:   Tue, 18 May 2021 21:19:21 +0200
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <DE8A113C-DF80-412E-A5C1-C0731E1757E2@freebsd.org>
References: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
 <81B0ED00-D281-445B-83C7-7BE65DC0FD8E@freebsd.org>
 <CADvbK_eKp+1OUT1+DLdv5w5_Azsh7W3F46p=3hCoiP8c13bEFg@mail.gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



> On 18. May 2021, at 20:33, Xin Long <lucien.xin@gmail.com> wrote:
> 
> On Tue, May 18, 2021 at 1:38 PM Michael Tuexen <tuexen@freebsd.org> wrote:
>> 
>>> On 18. May 2021, at 18:43, Xin Long <lucien.xin@gmail.com> wrote:
>>> 
>>> Hi, Michael,
>>> 
>>> We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
>>> and to make this be controlled by setsockopt with
>>> SCTP_PEER_ADDR_PARAMS, as in
>>> 
>>> https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:
>>> 
>>> we need another two flags to add for spp_flags:
>>> 
>>> SPP_PLPMTUD_ENABLE
>>> SPP_PLPMTUD_DISABLE
>>> 
>>> Do you think it makes sense? if yes, does the RFC6458 need to update?
>>> if not, do you have a better suggestion for it?
>> It is great new that you want to implement RFC 8899. I plan to do the
>> same for the FreeBSD stack.
>> 
>> In my view, RFC 8899 is the right way to implement PMTU discovery.
>> So I will just use the SPP_PMTUD_ENABLE and SPP_PMTUD_DISABLE. I don't
>> think that the user needs to control which method is used.
>> I you want to support multiple versions, I would make that
>> controllable via a sysctl variable. But I think for FreeBSD, support
>> for RFC 8899 will be the only way of doing PMTU discovery. There
>> might be multiple choices for details like how to do the searching,
>> how long to wait for some events. These will be controllable via
>> sysctl.
>> 
>> So in my view, there is no need to extend the socket API. What do you think?
> OK, that makes sense to me.
> 
> Another thing I want to know your opinion on is:  do you think the HB
> should be created
> separately for PLPMTUD probe, instead of reusing the old HB that
> checks the link connectivity?
Yes. I think testing for connectivity is conceptually different
from testing a particular PMTU. When testing for PMTU, I think
about sending probe packets. Not that they consist of a HB chunk
bundled with a PAD chunk.
> As the HB for PLPMTUD probe might get lost, which we don't want to
> affect the link's
> connectivity.
Yes, I agree completely.

Best regards
Michael
> 
>> 
>> Best regards
>> Michael
>>> 
>>> Thanks.
>> 

