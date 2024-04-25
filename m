Return-Path: <linux-sctp+bounces-102-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A58B2D57
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 00:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE56B22F11
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 22:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850EB156226;
	Thu, 25 Apr 2024 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQHjP+/I"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2895E12BF28;
	Thu, 25 Apr 2024 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714085889; cv=none; b=UKjIzWySvO4bE+i+R07JJinYA6FOo2fgfdBFLJ3wQsJ0Ok25V2DCMWZBkQBYtSET2LC27Og0tYkdXfrFfv03nMyQkP9h1Lncpdki3gcPrmb5lFvQhoHvgaKk2sdzBM2nGSLhUCDDRygz1qY/K/P0Xw/qlOeyUpgQChD9V6DnhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714085889; c=relaxed/simple;
	bh=KZ6d6tmhKGWfhPvc5pe1zvmWKH4eLy2i/SVKQGqyco4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1vIRoD0mqVvzd8eT81Nx2JjmImmwuRoGApm7OfcIEB5r5siU77rQvOIqfyBWoBcXS7m1f/U+fkG12v5/s/R8XCY5r65N4mlj/rmGVwdfN2HctNxdKYVFd8toU0YMA5PjN9VHxnOPywOXT5opCRreZhCqQ36x9VUUBYu/SZ04Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQHjP+/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3902C113CC;
	Thu, 25 Apr 2024 22:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714085888;
	bh=KZ6d6tmhKGWfhPvc5pe1zvmWKH4eLy2i/SVKQGqyco4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XQHjP+/IEP3Hod/NE4TIvhSjSrvdrjAy9k2SyFIAJjFzNY8+Nh3Sx4POcNt5btuMm
	 3im4slzGoWYkGm7TS50kvWPPVYBYIGT0/MZhkPK2muqrQmmbWC0GyjmcZ0ybOYTxW9
	 SMkcyLR9W1KlZ7QqBNuRE0iMGbU80vuL7IHG1jEi41QYuf83RSpP92ZQTtRVvOQLlr
	 v3hS48+RITvJrg9TWBKbL4CriqzPOg3Tsg+Vt50QKETrvCXiqDRTehoqDAJ9x/Y1u/
	 a3230EtuGUq8KzmygdeZcglcAOIPu4ukSmpzRXKV2jvztr04ZgWZjoIRpRbueNQj+A
	 zP3uYbLEZ8C/g==
Date: Thu, 25 Apr 2024 15:58:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Cc: j.granados@samsung.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Alexander
 Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern
 <dsahern@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, Geliang Tang
 <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Remi
 Denis-Courmont <courmisch@gmail.com>, Allison Henderson
 <allison.henderson@oracle.com>, David Howells <dhowells@redhat.com>, Marc
 Dionne <marc.dionne@auristor.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Wenjia Zhang
 <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe"
 <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
 <guwen@linux.alibaba.com>, Trond Myklebust
 <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
 Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jon Maloy
 <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Martin Schiller
 <ms@dev.tdt.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman
 <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Joerg Reuter
 <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
 <keescook@chromium.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
 linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] net: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240425155804.66f3bed5@kernel.org>
In-Reply-To: <20240425-jag-sysctl_remset_net-v4-1-9e82f985777d@samsung.com>
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
	<20240425-jag-sysctl_remset_net-v4-1-9e82f985777d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Apr 2024 14:02:59 +0200 Joel Granados via B4 Relay wrote:
> -	for (i =3D 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
> +	for (i =3D 0; i < tabel_size; i++)
>  		table[i].data =3D (char *)net + (uintptr_t)table[i].data;
> =20
>  	net->mpls.ctl =3D register_net_sysctl_sz(net, "net/mpls", table,
> -					       ARRAY_SIZE(mpls_table));
> +					       tabel_size);

../net/mpls/af_mpls.c: In function =E2=80=98mpls_net_init=E2=80=99:
../net/mpls/af_mpls.c:2676:25: error: =E2=80=98tabel_size=E2=80=99 undeclar=
ed (first use in this function); did you mean =E2=80=98table_size=E2=80=99?
 2676 |         for (i =3D 0; i < tabel_size; i++)
      |                         ^~~~~~~~~~
      |                         table_size
../net/mpls/af_mpls.c:2676:25: note: each undeclared identifier is reported=
 only once for each function it appears in
../net/mpls/af_mpls.c:2660:16: warning: unused variable =E2=80=98table_size=
=E2=80=99 [-Wunused-variable]
 2660 |         size_t table_size =3D ARRAY_SIZE(mpls_table);
      |                ^~~~~~~~~~
--=20
netdev FAQ tl;dr:
 - designate your patch to a tree - [PATCH net] or [PATCH net-next]
 - for fixes the Fixes: tag is required, regardless of the tree
 - don't post large series (> 15 patches), break them up
 - don't repost your patches within one 24h period

pw-bot: cr

