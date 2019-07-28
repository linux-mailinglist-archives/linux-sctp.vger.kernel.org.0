Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7335678146
	for <lists+linux-sctp@lfdr.de>; Sun, 28 Jul 2019 21:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfG1Tl0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 28 Jul 2019 15:41:26 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46986 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfG1Tl0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 28 Jul 2019 15:41:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so57570171qtn.13;
        Sun, 28 Jul 2019 12:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hw/FJV6kNbX3dJG9xz1ZqY6bUwNkBImddv944G3I5jU=;
        b=KWFF2mjNn41Vga7hU6YdR46+FUsGUX61tK4/Zxgf2GT01FJjx28cpAYBdbCg2uNuW/
         uDJmj9DWNJRczTUUuhjjsTo0jnsQ3I+LyNyYTE03tY3VYrZVunepnzb/zlxtPF/qcq4h
         g0yoxHDjwbaPDD+zJv6ZKmE4zgtajsufTv2eTsvH2AnnP9rzSrIWD80RUFAEd8JJwvbp
         wOctnEjW19HzAXdYbZIo//nuUYw4EMnxXvip3Ul/USPqpcpwZPFaAPmUZ4o1Oxp8mQRr
         aI8dx35Rk9rH6FQxKiodroZz0JX84V5UTezmoacSFZTUtC7DMq+D49zK2oHI3L0E44KC
         coDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hw/FJV6kNbX3dJG9xz1ZqY6bUwNkBImddv944G3I5jU=;
        b=Q7tUgIl6AbReh+Qx8uVhGp4KJVtFfF1ohNrqAfh5XeKsCPttMAJ/u6kI1m8Bjf+QTx
         UhJxifKfHpvcg43Q6s2rb17CCZMXvFsNwHMpf1zC9O2Efjq/oDp4yhGhR4H0IEbHMpnl
         az4SD5UZinn9E2NKo6m5TxyEjMKBINuBriYSiu2FGdxIC+St8vyPBK/3geYmUaP8G4XI
         qWQGbTINzHmSTwhhQsmFDBFGait1hsjoGznNZU5zwjSPSv5Ebda42EOtNEvXMnUH0gE0
         d1t/7QVsT502hxS0IIT4JKYaUweJZvE/deFFCnBlEtq/dEYWa3aBwkl4gLGgZa67kQTT
         Dq+A==
X-Gm-Message-State: APjAAAVz/9vFBCpRITgB5im6Qk313Bp3//jf4+6HZhlIX1qx7SSVBG35
        F8BqHqB5mUMy5+PxgpKrx+o=
X-Google-Smtp-Source: APXvYqzbuUC9Ijr0q1lB3Uh0HyXwzMwxTDDVXBn4zgxhsxAzcNDkf7xNL4N/ewB363U9UpPOvGSfog==
X-Received: by 2002:a0c:bd86:: with SMTP id n6mr77563621qvg.183.1564342885155;
        Sun, 28 Jul 2019 12:41:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:a0af:c6c5:7c31:69b:3f23])
        by smtp.gmail.com with ESMTPSA id m5sm24797882qkb.117.2019.07.28.12.41.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 12:41:24 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 2031CC1BCD; Sun, 28 Jul 2019 16:41:22 -0300 (-03)
Date:   Sun, 28 Jul 2019 16:41:22 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sctp: fix GCC8+ -Wpacked-not-aligned warnings
Message-ID: <20190728194122.GN6204@localhost.localdomain>
References: <1564174659-21211-1-git-send-email-cai@lca.pw>
 <20190726213045.GL6204@localhost.localdomain>
 <4A42819C-32E5-4869-8A3B-0D4F9DF1B53C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A42819C-32E5-4869-8A3B-0D4F9DF1B53C@lca.pw>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Jul 28, 2019 at 01:05:25PM -0400, Qian Cai wrote:
> 
> 
> > On Jul 26, 2019, at 5:30 PM, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> > 
> > On Fri, Jul 26, 2019 at 04:57:39PM -0400, Qian Cai wrote:
> >> There are a lot of those warnings with GCC8+ 64bit,
> >> 
> >> In file included from ./include/linux/sctp.h:42,
> >>                 from net/core/skbuff.c:47:
> >> ./include/uapi/linux/sctp.h:395:1: warning: alignment 4 of 'struct
> >> sctp_paddr_change' is less than 8 [-Wpacked-not-aligned]
> >> } __attribute__((packed, aligned(4)));
> >> ^
> >> ./include/uapi/linux/sctp.h:728:1: warning: alignment 4 of 'struct
> >> sctp_setpeerprim' is less than 8 [-Wpacked-not-aligned]
> >> } __attribute__((packed, aligned(4)));
> >> ^
> >> ./include/uapi/linux/sctp.h:727:26: warning: 'sspp_addr' offset 4 in
> >> 'struct sctp_setpeerprim' isn't aligned to 8 [-Wpacked-not-aligned]
> >>  struct sockaddr_storage sspp_addr;
> >>                          ^~~~~~~~~
> >> ./include/uapi/linux/sctp.h:741:1: warning: alignment 4 of 'struct
> >> sctp_prim' is less than 8 [-Wpacked-not-aligned]
> >> } __attribute__((packed, aligned(4)));
> >> ^
> >> ./include/uapi/linux/sctp.h:740:26: warning: 'ssp_addr' offset 4 in
> >> 'struct sctp_prim' isn't aligned to 8 [-Wpacked-not-aligned]
> >>  struct sockaddr_storage ssp_addr;
> >>                          ^~~~~~~~
> >> ./include/uapi/linux/sctp.h:792:1: warning: alignment 4 of 'struct
> >> sctp_paddrparams' is less than 8 [-Wpacked-not-aligned]
> >> } __attribute__((packed, aligned(4)));
> >> ^
> >> ./include/uapi/linux/sctp.h:784:26: warning: 'spp_address' offset 4 in
> >> 'struct sctp_paddrparams' isn't aligned to 8 [-Wpacked-not-aligned]
> >>  struct sockaddr_storage spp_address;
> >>                          ^~~~~~~~~~~
> >> ./include/uapi/linux/sctp.h:905:1: warning: alignment 4 of 'struct
> >> sctp_paddrinfo' is less than 8 [-Wpacked-not-aligned]
> >> } __attribute__((packed, aligned(4)));
> >> ^
> >> ./include/uapi/linux/sctp.h:899:26: warning: 'spinfo_address' offset 4
> >> in 'struct sctp_paddrinfo' isn't aligned to 8 [-Wpacked-not-aligned]
> >>  struct sockaddr_storage spinfo_address;
> >>                          ^~~~~~~~~~~~~~
> >> Fix them by aligning the structures and fields to 8 bytes instead.
> >> 
> >> Signed-off-by: Qian Cai <cai@lca.pw>
> >> ---
> >> include/uapi/linux/sctp.h | 18 +++++++++---------
> >> 1 file changed, 9 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
> >> index b8f2c4d56532..e7bd71cde882 100644
> >> --- a/include/uapi/linux/sctp.h
> >> +++ b/include/uapi/linux/sctp.h
> > 
> > These changes gotta be more careful, if possible at all. As is, it's breaking UAPI.
> 
> Could you please elaborate how this breaks userspace? I read through all the information
> I can find about UAPI and still have no clue. All I can see if that some field alignments changed
> which are expected, and it still take on 3 cachelines which should not hurt the performance.

For example on the struct I pointed below, if an application is
compiled using the old headers, sctp_paddrparams->spp_hbinterval is at
offset 132. But with this patch, it will change to 136. Then with a
kernel with this patch, it will look for the field at the wrong place.

> 
> > 
> > -before
> > +after patch
> > 
> > struct sctp_paddrparams {
> >        sctp_assoc_t               spp_assoc_id;         /*     0     4 */
> > -       struct __kernel_sockaddr_storage spp_address __attribute__((__aligned__(1))); /*     4   128 */
> > -       /* --- cacheline 2 boundary (128 bytes) was 4 bytes ago --- */
> > -       __u32                      spp_hbinterval;       /*   132     4 */
> > -       __u16                      spp_pathmaxrxt;       /*   136     2 */
> > -       __u32                      spp_pathmtu;          /*   138     4 */
> > -       __u32                      spp_sackdelay;        /*   142     4 */
> > -       __u32                      spp_flags;            /*   146     4 */
> > -       __u32                      spp_ipv6_flowlabel;   /*   150     4 */
> > -       __u8                       spp_dscp;             /*   154     1 */
> > 
> > -       /* size: 156, cachelines: 3, members: 9 */
> > +       /* XXX 4 bytes hole, try to pack */
> > +
> > +       struct __kernel_sockaddr_storage spp_address __attribute__((__aligned__(8))); /*     8   128 */
> > +       /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> > +       __u32                      spp_hbinterval;       /*   136     4 */
> > +       __u16                      spp_pathmaxrxt;       /*   140     2 */
> > +       __u32                      spp_pathmtu;          /*   142     4 */
> > +       __u32                      spp_sackdelay;        /*   146     4 */
> > +       __u32                      spp_flags;            /*   150     4 */
> > +       __u32                      spp_ipv6_flowlabel;   /*   154     4 */
> > +       __u8                       spp_dscp;             /*   158     1 */
> > +
> > +       /* size: 160, cachelines: 3, members: 9 */
> > +       /* sum members: 155, holes: 1, sum holes: 4 */
> >        /* padding: 1 */
> > -       /* forced alignments: 1 */
> > -       /* last cacheline: 28 bytes */
> > -} __attribute__((__aligned__(4)));
> > +       /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
> > +       /* last cacheline: 32 bytes */
> > +} __attribute__((__aligned__(8)));
> > 
> > 
> >> @@ -392,7 +392,7 @@ struct sctp_paddr_change {
> >> 	int spc_state;
> >> 	int spc_error;
> >> 	sctp_assoc_t spc_assoc_id;
> >> -} __attribute__((packed, aligned(4)));
> >> +} __attribute__((packed, aligned(8)));
> >> 
> >> /*
> >>  *    spc_state:  32 bits (signed integer)
> >> @@ -724,8 +724,8 @@ struct sctp_assocparams {
> >>  */
> >> struct sctp_setpeerprim {
> >> 	sctp_assoc_t            sspp_assoc_id;
> >> -	struct sockaddr_storage sspp_addr;
> >> -} __attribute__((packed, aligned(4)));
> >> +	struct sockaddr_storage sspp_addr __attribute__((aligned(8)));
> >> +} __attribute__((packed, aligned(8)));
> >> 
> >> /*
> >>  * 7.1.10 Set Primary Address (SCTP_PRIMARY_ADDR)
> >> @@ -737,8 +737,8 @@ struct sctp_setpeerprim {
> >>  */
> >> struct sctp_prim {
> >> 	sctp_assoc_t            ssp_assoc_id;
> >> -	struct sockaddr_storage ssp_addr;
> >> -} __attribute__((packed, aligned(4)));
> >> +	struct sockaddr_storage ssp_addr __attribute__((aligned(8)));
> >> +} __attribute__((packed, aligned(8)));
> >> 
> >> /* For backward compatibility use, define the old name too */
> >> #define sctp_setprim	sctp_prim
> >> @@ -781,7 +781,7 @@ enum  sctp_spp_flags {
> >> 
> >> struct sctp_paddrparams {
> >> 	sctp_assoc_t		spp_assoc_id;
> >> -	struct sockaddr_storage	spp_address;
> >> +	struct sockaddr_storage	spp_address __attribute__((aligned(8)));
> >> 	__u32			spp_hbinterval;
> >> 	__u16			spp_pathmaxrxt;
> >> 	__u32			spp_pathmtu;
> >> @@ -789,7 +789,7 @@ struct sctp_paddrparams {
> >> 	__u32			spp_flags;
> >> 	__u32			spp_ipv6_flowlabel;
> >> 	__u8			spp_dscp;
> >> -} __attribute__((packed, aligned(4)));
> >> +} __attribute__((packed, aligned(8)));
> >> 
> >> /*
> >>  * 7.1.18.  Add a chunk that must be authenticated (SCTP_AUTH_CHUNK)
> >> @@ -896,13 +896,13 @@ struct sctp_stream_value {
> >>  */
> >> struct sctp_paddrinfo {
> >> 	sctp_assoc_t		spinfo_assoc_id;
> >> -	struct sockaddr_storage	spinfo_address;
> >> +	struct sockaddr_storage	spinfo_address __attribute__((aligned(8)));
> >> 	__s32			spinfo_state;
> >> 	__u32			spinfo_cwnd;
> >> 	__u32			spinfo_srtt;
> >> 	__u32			spinfo_rto;
> >> 	__u32			spinfo_mtu;
> >> -} __attribute__((packed, aligned(4)));
> >> +} __attribute__((packed, aligned(8)));
> >> 
> >> /* Peer addresses's state. */
> >> /* UNKNOWN: Peer address passed by the upper layer in sendmsg or connect[x]
> >> -- 
> >> 1.8.3.1
> 
