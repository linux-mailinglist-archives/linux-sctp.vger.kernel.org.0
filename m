Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360171F1009
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 23:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFGVof convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 17:44:35 -0400
Received: from 87-60-149-219-cable.dk.customer.tdc.net ([87.60.149.219]:35070
        "EHLO i1.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgFGVof (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 7 Jun 2020 17:44:35 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Jun 2020 17:44:32 EDT
Received: from i1.dk (localhost [127.0.0.1])
        by i1.dk (Postfix) with ESMTP id A12F928E1B71
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 21:35:19 +0000 (UTC)
Received: from isjsys.localnet (unknown [10.0.0.2])
        by i1.dk (Postfix) with ESMTPA
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 21:35:19 +0000 (UTC)
From:   Ivan Skytte =?ISO-8859-1?Q?J=F8rgensen?= <isj-sctp@i1.dk>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: packed structures used in socket options
Date:   Sun, 07 Jun 2020 23:35:19 +0200
Message-ID: <2213135.ChUyxVVRYb@isjsys>
In-Reply-To: <23a14b44bd5749a6b1b51150c7f3c8ba@AcuMS.aculab.com>
References: <CBFEFEF1-127A-4ADA-B438-B171B9E26282@lurchi.franken.de> <B69695A1-F45B-4375-B9BB-1E50D1550C6D@lurchi.franken.de> <23a14b44bd5749a6b1b51150c7f3c8ba@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sunday, 7 June 2020 22:21:41 CEST you wrote:
> From: Michael Tuexen
> > Sent: 07 June 2020 18:24
> > > On 7. Jun 2020, at 19:14, David Laight <David.Laight@ACULAB.COM> wrote:
> > >
> > > From: Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
> > >> Sent: 07 June 2020 16:15
> > >>> On 7. Jun 2020, at 15:53, David Laight <David.Laight@ACULAB.COM> wrote:
> > >>>
> > >>> From: Michael Tuexen
> > >>>>
> > >>>> since gcc uses -Werror=address-of-packed-member, I get warnings for my variant
> > >>>> of packetdrill, which supports SCTP.
> > >>>>
> > >>>> Here is why:
> > >>>>
> > >>>>
> > >>
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sctp.h?h=v5
> > >>>> .7
> > >>>> contains:
> > >>>>
> > >>>> struct sctp_paddrparams {
> > >>>> 	sctp_assoc_t		spp_assoc_id;
> > >>>> 	struct sockaddr_storage	spp_address;
> > >>>> 	__u32			spp_hbinterval;
> > >>>> 	__u16			spp_pathmaxrxt;
> > >>>> 	__u32			spp_pathmtu;
> > >>>> 	__u32			spp_sackdelay;
> > >>>> 	__u32			spp_flags;
> > >>>> 	__u32			spp_ipv6_flowlabel;
> > >>>> 	__u8			spp_dscp;
> > >>>> } __attribute__((packed, aligned(4)));
> > >>>>
> > >>>> This structure is only used in the IPPROTO_SCTP level socket option SCTP_PEER_ADDR_PARAMS.
> > >>>> Why is it packed?
> > >>>
> > >>> I'm guessing 'to remove holes to avoid leaking kernel data'.
> > >>>
> > >>> The sctp socket api defines loads of structures that will have
> > >>> holes in them if not packed.
> > >>
> > >> Hi David,
> > >> I agree that they have holes and we should have done better. The
> > >> kernel definitely should also not leak kernel data. However, the
> > >> way to handle this shouldn't be packing. I guess it is too late
> > >> to change this?
> > >
> > > Probably too late.
> > > I've no idea how it got through the standards body either.
> > > In fact, the standard may actually require the holes.
> >
> > No, it does not. Avoiding holes was not taken into account.
> 
> It depends on whether the rfc that describes the sockops says
> the structures 'look like this' or 'contain the following members'.
> 
> > It should have been, but this was missed. Authors of all
> > kernel implementation (FreeBSD, Linux, and Solaris) were involved.
> 
> Sounds like none of the right people even looked at it.

I was involved. At that time (September 2005) the SCTP API was still evolving (first finalized in 2011), and one of the major users of the API was 32-bit programs running on 64-bit kernel (on powerpc as I recall). When we realized that the structures were different between 32bit and 64bit we had to break the least number of programs, and the result were those ((packed)) structs so 32-bit programs wouldn't be broken and we didn't need a xxx_compat translation layer in the kernel.

I don't have access to TSVWG mailing list archive that far back but I found I wrote this summary here:

On Sunday, 25 September 2005 21:36:05 CEST Ivan Skytte Jørgensen wrote:
> I followed the discussion in tsvwg mailing list. My interpretation of the few 
> answers is that this is a "quality of implementation issue" and that padding 
> fields are allowed but won't get into the RFC because it is an implementation 
> issue.


So RFC6458 allows padding but doesn't list them.


Incidentally, at that time (and perhaps still) sockaddr_storage had different alignement between 32-bit programs and 64-bit programs, and the multicast structures used in setsockopt() (group_req, group_source_req and  group_filter) had/has the same problem.


/isj



