Return-Path: <linux-sctp+bounces-71-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A798A65E7
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADB61C21451
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF27415574E;
	Tue, 16 Apr 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TByiiSen"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050273BBEC
	for <linux-sctp@vger.kernel.org>; Tue, 16 Apr 2024 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713255531; cv=none; b=O7Tf0KyObGJT/mAa/vgBWzCTY43Ymd/9iKP1lWOaQb3O+Y6nxEC6zP/TBGTaPjajzLTIM2vSEe67MXuYKvEMjMpvYk7f51vcsEuUvnQQ+d4/0Gep24gjGtgvC8BE0JjftVYvPs9CNfAS4hJOgNgQLJacQ2kZAgxP2b4DyQGBGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713255531; c=relaxed/simple;
	bh=WSUcYTGfMiJPS6dBoWIy1OiuZHDqhA72PAGbwoqjEHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qo+WG/EC+twzVaKdk4BSxcuSYlWAChO2/jDTUepVlCvUEfTlOGubGonSFugZtsQg9UMQ3znuLWpK/UKZvxbfZH7IGrGATNfb22WnJV7idSHqgZfg1iiUzfHtufKDOPumKIrheRospeP7NPkn11IOq6li9GyBxjGTfjjzSA2VU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TByiiSen; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713255529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sx9FIAo9TZjFdKuhika+AQetmZMIT9vu9nUh+3JKCOQ=;
	b=TByiiSen8u4aSXJIcOd8ZEvHzJ1U8Izegjbg0vUe7+kU55q01CaBCCds/86hosbbmARQWZ
	uFNPqUQIlAVqsVjxpRhoiT4PZyXfUqjAGHzVy2nIkE/wnPu51iHD057H8lfoyAwzq0zZbV
	S/LoLmJ64E/oz1JfvlTyAQPDixFuCRQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-3_g_CLvTOVGnVyeOgpaKEA-1; Tue, 16 Apr 2024 04:18:47 -0400
X-MC-Unique: 3_g_CLvTOVGnVyeOgpaKEA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a51a65f488cso86113766b.1
        for <linux-sctp@vger.kernel.org>; Tue, 16 Apr 2024 01:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713255526; x=1713860326;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sx9FIAo9TZjFdKuhika+AQetmZMIT9vu9nUh+3JKCOQ=;
        b=X/QyEt89uqDyQHT4o0JlEcLTSmw9Of+Y41kXIIo+XPWXn1kPK2MxXmnwIvnDtcElDj
         +aiCN70k7C+oiVXklPbT6RJAguxckzfDew3rM24wCfYbe9AR9WXLEYBVKZIzM9tJlDyP
         X9E4BPWKcBegc+JWmp/DTrNFwWVXX+6DdJICzfQib4bomBn/v1y1lRrt4KZ9wP54Vld3
         Z516Le6yIaz6olmj+Pr5LSvJRhZT9SFox8ziwAbf/8wnWNuEpyJla3a75g0GupqBWir3
         QHZwSoIpzM4CbVKNziXGw4rRWt8IXpoINjx+xRE1tdqhsaaOfxgV0xu1AnvpYHNeADW1
         qHKw==
X-Forwarded-Encrypted: i=1; AJvYcCU1bxFvDtm70NVx1RwVXjoMrd3Lk+rL1GijYdzRKfhxNf4uwRZ7s20+Eu1iT5iUEhEn7ZguQTxG9eE0lTAyZ6YzroNvtuXI2bAgAA==
X-Gm-Message-State: AOJu0YzE/rEwxWQkdBafqcYsa+kv2mEkMtk6qASpdlNmEyERkyb7Vo1q
	pF2i9YyVh9xLb1t7JcZ5JJ2bi6K7ldQQrHsquSdJf3Ytdm54/Z5+XAOhFbei6Qq4akmL3Hmsm6D
	QVp9ExW4+Ks6puNM2o6157JspRUNKKmHXEbPWCHaWrRU/1ZxeUkzQM+6M4DE=
X-Received: by 2002:a17:906:4ecf:b0:a52:6535:d078 with SMTP id i15-20020a1709064ecf00b00a526535d078mr3213794ejv.7.1713255526683;
        Tue, 16 Apr 2024 01:18:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeWubKk9sfU5n4Eg4r0fgR17oDosoRykSHGnpq+PCrNmzGMeRZ2HKjVJzu/+KOc5EhcE24Ng==
X-Received: by 2002:a17:906:4ecf:b0:a52:6535:d078 with SMTP id i15-20020a1709064ecf00b00a526535d078mr3213728ejv.7.1713255526227;
        Tue, 16 Apr 2024 01:18:46 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-31.dyn.eolo.it. [146.241.231.31])
        by smtp.gmail.com with ESMTPSA id gf14-20020a170906e20e00b00a51e6222200sm6539922ejb.156.2024.04.16.01.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:18:45 -0700 (PDT)
Message-ID: <be056435353af60a564f457c79dacc16c6ea920e.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] networking: Remove the now superfluous sentinel
 elements from ctl_table array
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	devnull+j.granados.samsung.com@kernel.org
Cc: Dai.Ngo@oracle.com, alex.aring@gmail.com, alibuda@linux.alibaba.com, 
 allison.henderson@oracle.com, anna@kernel.org, bridge@lists.linux.dev, 
 chuck.lever@oracle.com, coreteam@netfilter.org, courmisch@gmail.com, 
 davem@davemloft.net, dccp@vger.kernel.org, dhowells@redhat.com,
 dsahern@kernel.org,  edumazet@google.com, fw@strlen.de, geliang@kernel.org,
 guwen@linux.alibaba.com,  herbert@gondor.apana.org.au, horms@verge.net.au,
 j.granados@samsung.com, ja@ssi.bg,  jaka@linux.ibm.com, jlayton@kernel.org,
 jmaloy@redhat.com, jreuter@yaina.de,  kadlec@netfilter.org,
 keescook@chromium.org, kolga@netapp.com, kuba@kernel.org, 
 linux-afs@lists.infradead.org, linux-hams@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-sctp@vger.kernel.org, linux-wpan@vger.kernel.org, 
 linux-x25@vger.kernel.org, lucien.xin@gmail.com, lvs-devel@vger.kernel.org,
  marc.dionne@auristor.com, marcelo.leitner@gmail.com, martineau@kernel.org,
  matttbe@kernel.org, mcgrof@kernel.org, miquel.raynal@bootlin.com, 
 mptcp@lists.linux.dev, ms@dev.tdt.de, neilb@suse.de,
 netdev@vger.kernel.org,  netfilter-devel@vger.kernel.org,
 pablo@netfilter.org, ralf@linux-mips.org,  razor@blackwall.org,
 rds-devel@oss.oracle.com, roopa@nvidia.com,  stefan@datenfreihafen.org,
 steffen.klassert@secunet.com,  tipc-discussion@lists.sourceforge.net,
 tom@talpey.com, tonylu@linux.alibaba.com,  trond.myklebust@hammerspace.com,
 wenjia@linux.ibm.com, ying.xue@windriver.com
Date: Tue, 16 Apr 2024 10:18:42 +0200
In-Reply-To: <20240415231210.22785-1-kuniyu@amazon.com>
References: <20240412-jag-sysctl_remset_net-v3-1-11187d13c211@samsung.com>
	 <20240415231210.22785-1-kuniyu@amazon.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-04-15 at 16:12 -0700, Kuniyuki Iwashima wrote:
> From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.o=
rg>
> Date: Fri, 12 Apr 2024 16:48:29 +0200
> > From: Joel Granados <j.granados@samsung.com>
> >=20
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which
> > will reduce the overall build time size of the kernel and run time
> > memory bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> >=20
> > * Remove sentinel element from ctl_table structs.
> > * Remove extra element in ctl_table arrays declarations
> > * Remove instances where an array element is zeroed out to make it look
> >   like a sentinel. This is not longer needed and is safe after commit
> >   c899710fe7f9 ("networking: Update to register_net_sysctl_sz") added
> >   the array size to the ctl_table registration
> > * Replace the for loop stop condition that tests for procname =3D=3D NU=
LL with
> >   one that depends on array size
> > * Removed the "-1" that adjusted for having an extra empty element when
> >   looping over ctl_table arrays
> > * Removing the unprivileged user check in ipv6_route_sysctl_init is
> >   safe as it is replaced by calling ipv6_route_sysctl_table_size;
> >   introduced in commit c899710fe7f9 ("networking: Update to
> >   register_net_sysctl_sz")
> > * Replace empty array registration with the register_net_sysctl_sz call=
.
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  net/core/neighbour.c                | 5 +----
> >  net/core/sysctl_net_core.c          | 9 ++++-----
> >  net/dccp/sysctl.c                   | 2 --
> >  net/ieee802154/6lowpan/reassembly.c | 6 +-----
> >  net/ipv4/devinet.c                  | 5 ++---
> >  net/ipv4/ip_fragment.c              | 2 --
> >  net/ipv4/route.c                    | 8 ++------
> >  net/ipv4/sysctl_net_ipv4.c          | 7 +++----
> >  net/ipv4/xfrm4_policy.c             | 1 -
> >  net/ipv6/addrconf.c                 | 5 +----
> >  net/ipv6/icmp.c                     | 1 -
> >  net/ipv6/reassembly.c               | 2 --
> >  net/ipv6/route.c                    | 5 -----
> >  net/ipv6/sysctl_net_ipv6.c          | 4 +---
> >  net/ipv6/xfrm6_policy.c             | 1 -
> >  net/llc/sysctl_net_llc.c            | 8 ++------
> >  net/mpls/af_mpls.c                  | 3 +--
> >  net/mptcp/ctrl.c                    | 1 -
> >  net/netrom/sysctl_net_netrom.c      | 1 -
> >  net/phonet/sysctl.c                 | 1 -
> >  net/rds/ib_sysctl.c                 | 1 -
> >  net/rds/sysctl.c                    | 1 -
> >  net/rds/tcp.c                       | 1 -
> >  net/rose/sysctl_net_rose.c          | 1 -
> >  net/rxrpc/sysctl.c                  | 1 -
> >  net/sctp/sysctl.c                   | 6 +-----
> >  net/smc/smc_sysctl.c                | 1 -
> >  net/sunrpc/sysctl.c                 | 1 -
> >  net/sunrpc/xprtrdma/svc_rdma.c      | 1 -
> >  net/sunrpc/xprtrdma/transport.c     | 1 -
> >  net/sunrpc/xprtsock.c               | 1 -
> >  net/tipc/sysctl.c                   | 1 -
> >  net/unix/sysctl_net_unix.c          | 1 -
> >  net/x25/sysctl_net_x25.c            | 1 -
> >  net/xfrm/xfrm_sysctl.c              | 5 +----
> >  35 files changed, 20 insertions(+), 81 deletions(-)
>=20
> You may want to split patch based on subsystem or the type of changes
> to make review easier.

I agree with Kuniyuki. I think the x25 chunks can me moved in the last
patch, and at least sunrpc and rds could go in separate patches,
possibly even xfrm and smc.

Thanks,

Paolo


