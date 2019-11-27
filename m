Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4F610B00E
	for <lists+linux-sctp@lfdr.de>; Wed, 27 Nov 2019 14:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfK0NWv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 27 Nov 2019 08:22:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32974 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfK0NWv (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 27 Nov 2019 08:22:51 -0500
Received: by mail-qk1-f194.google.com with SMTP id c124so15021671qkg.0;
        Wed, 27 Nov 2019 05:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bT7huAeaJrxOt/OOAz/dFRoPCvzkLXC6+YmTWjfXTjU=;
        b=JBaM3J5ssSF+BZ6b+O3zzUEQftJP89cPjMRg84yki/9rIK6RQXOEDffPsp+VMJc0zl
         X97czddDf5v7dvcBxglRyZ4HZxPvbjBr397v8zfV/00XIhSFwyqM0u1DqNknVfRom+SZ
         Aae4ZX8aVKZWg9JaaBMWAstrhjIpexBMJAqtrzKzNmH1AVbp3UHv6yEEo7qC1chn28km
         dzuHhXlQS7xsl0ec4FzfPWV1CuTXPzYIti7+PNz7isfQUqY8Shcp0llWDrWMY0YQN3ev
         HdstfSmZvAP3W8qBZPs+mblWJRpde7rGkmU4o/7VSEdrSL9e+V6qajS6Vm8IZghXEmQw
         y1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bT7huAeaJrxOt/OOAz/dFRoPCvzkLXC6+YmTWjfXTjU=;
        b=EE12TAWmQ+8LkY0LWe6hvuYo4KJL+vGKoEqvgUNeKwAUXqeqeIEoWmDpaBWoooyndt
         kjAQyyafHnfROBSEyDtk9M4Lz6wyJHTvoLiSfwiodohD0WK38Jmo6edYxhsv2AXE45wr
         e9N425fIov/VcsL5hcmOD8A8cIwxOw9oUh/iUiVi+ST0+nJcd0bxGiCnyS1d9CUMVkNd
         URPaUefBmoU1iJTmD38kZhGeV2xo433GqNPckr6vPmwnUhudoUJxKD4l7kCK21poXl0K
         QufSjyHViSc/v5KEfonxyGCTVNOEADEHW5doflZOBvVWIP1/aWpbbSyl0E3BdC4xnOrw
         +sTw==
X-Gm-Message-State: APjAAAXCZ2E94KCD7p/hk5aMSFda7/YZ2NAJs7ctqleuh24JZcSJPeh2
        +J/KXG5baTk1sjUFSirgeDHpGii+SD9Lww==
X-Google-Smtp-Source: APXvYqxRxWHwQcE23vnQEloXZ4T2uJ+AnMKnvlWVgfZJXrna+veWEeRcoNzcofK0h6mJIZn2XO20Pg==
X-Received: by 2002:a05:620a:15f8:: with SMTP id p24mr4298620qkm.438.1574860970402;
        Wed, 27 Nov 2019 05:22:50 -0800 (PST)
Received: from localhost.localdomain ([2001:1284:f013:3bac:6dc2:4a4b:b6a6:4365])
        by smtp.gmail.com with ESMTPSA id y131sm2314498qkb.29.2019.11.27.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:22:49 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C9D88C510E; Wed, 27 Nov 2019 10:22:46 -0300 (-03)
Date:   Wed, 27 Nov 2019 10:22:46 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org,
        syzbot <syzbot+6dcbfea81cd3d4dd0b02@syzkaller.appspotmail.com>,
        davem <davem@davemloft.net>,
        Alexander Potapenko <glider@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KMSAN: uninit-value in __crc32c_le_base
Message-ID: <20191127132246.GN388551@localhost.localdomain>
References: <00000000000004b2df0598075fc8@google.com>
 <20191127060138.GB227319@sol.localdomain>
 <CADvbK_fOZ+kLiOOOXN-qUzDC2376-UxHmg1L6xiAFRR6=+re3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvbK_fOZ+kLiOOOXN-qUzDC2376-UxHmg1L6xiAFRR6=+re3w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Nov 27, 2019 at 04:49:46PM +0800, Xin Long wrote:
> On Wed, Nov 27, 2019 at 2:02 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Looks like a bug in net/sctp/ where it's passing uninitialized memory into the
> > crc32c() function.  SCTP maintainers, can you please take a look?
> Thanks.
> 
> The issue was caused by:
> transport->ipaddr set with uninit addr param, which was passed by:
> 
>   sctp_transport_init net/sctp/transport.c:47 [inline]
>   sctp_transport_new+0x248/0xa00 net/sctp/transport.c:100
>   sctp_assoc_add_peer+0x5ba/0x2030 net/sctp/associola.c:611
>   sctp_process_param net/sctp/sm_make_chunk.c:2524 [inline]
> 
> where 'addr' is set by sctp_v4_from_addr_param(), which doesn't initialize the
> padding of addr->v4.
> 
> later when calling sctp_make_heartbeat(), hbinfo.daddr(=transport->ipaddr)
> will become the part of skb, and the issue occurs.

Sweet.

> 
> The fix should be:
> 
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 09050c1d5517..0e73405eba4f 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -2516,6 +2516,7 @@ static int sctp_process_param(struct
> sctp_association *asoc,
>   if (ipv6_only_sock(asoc->base.sk))
>   break;
>  do_addr_param:
> + memset(&addr, 0, sizeof(addr));
>   af = sctp_get_af_specific(param_type2af(param.p->type));
>   af->from_addr_param(&addr, param.addr, htons(asoc->peer.port), 0);
>   scope = sctp_scope(peer_addr);
> @@ -3040,6 +3041,7 @@ static __be16 sctp_process_asconf_param(struct
> sctp_association *asoc,
>   if (unlikely(!af))
>   return SCTP_ERROR_DNS_FAILED;
> 
> + memset(&addr, 0, sizeof(addr));
>   af->from_addr_param(&addr, addr_param, htons(asoc->peer.port), 0);

In sctp_v4_from_addr_param() itself seems cleaner.
(Ditto for sctp_v4_to_addr_param() and related ones, like
sctp_v4_dst_saddr())

These functions shouldn't trust that the caller initializes the
memory. They are dealing with ipv4 but they know that the buffer
they are writting into is larger and the size of it.

  Marcelo
