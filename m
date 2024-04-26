Return-Path: <linux-sctp+bounces-114-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1662A8B372F
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDAD284560
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 12:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DBF145FE1;
	Fri, 26 Apr 2024 12:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jvkom9kI"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41258145B31;
	Fri, 26 Apr 2024 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134395; cv=none; b=aNSG8cDVzJTqFVMG1VQXHq2UuUg5bp/9hFxU3fCu5MxJNOIlaBOmpd0VUdYDtT9NvLZ3LJa/5UOfiawitohOdWtvzFCIxMXXcfDNoItPk1DmLZMXIPqwLKJ80r5CVwdhz4UOJCWsZYlgP0lshIW0jSU4osUsmtOpGa130xEKjj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134395; c=relaxed/simple;
	bh=Pbkg/ngrAoqu+aQpDwFHA6fzbz8gCEVgjlmTJ3VIByg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQSDTBq2198AJ+hIcTVnJIA8F1MOvvhgCV+ZFJACXgiqDp4XKsxPHPUwXThFc9TiEK4cYe3q9oIfQ0kHWc9axdO4Sxqvr98iLRGsWsRFUC2ULOvYtqJyLOh+ZEib1D+/MWFgU5vncDjrbYvrNFJVCZ/S9CvB5HGE2R0jKiTiIO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jvkom9kI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985C2C113CD;
	Fri, 26 Apr 2024 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714134394;
	bh=Pbkg/ngrAoqu+aQpDwFHA6fzbz8gCEVgjlmTJ3VIByg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Jvkom9kIZ6ZoOCRjQjn9a0bkl2urlzt/qUolqWeJKwBFTg0g/7qNVw8NASFDVe1i0
	 UEDHmza8cBYDEs4zV4FiBfzE1KP4Xs3iwpDeddUSaVFQ275fbh13J8R5lFHG+Pl41U
	 u1oZ31xr1Pqd8GpjAVce1gnK8O5Jc5GfLUatTtJl2xwQFK6Yny9BdiUfqI3OpO35r7
	 QJUUsUOhhmKM1vtgZWe9PRrmEgFMvC39cxG/VoPhkkuQ6Mh0ekMCqXwMq4uQz37ErB
	 0O3D8PsJ5ccCBkjlAaGCHuVwfTMiRUzGl2tVWLuUPtwkPUcCnuP6/52faA7avqlwqf
	 81oQdZ2Lk8R1g==
Message-ID: <6b05026f14b6b1e1067876f3bc1c07266dfe2ac2.camel@kernel.org>
Subject: Re: [PATCH v5 4/8] net: sunrpc: Remove the now superfluous sentinel
 elements from ctl_table array
From: Jeffrey Layton <jlayton@kernel.org>
To: j.granados@samsung.com, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Alexander Aring <alex.aring@gmail.com>, Stefan
 Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>,  Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,  Ralf
 Baechle <ralf@linux-mips.org>, Remi Denis-Courmont <courmisch@gmail.com>,
 Allison Henderson <allison.henderson@oracle.com>, David Howells
 <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
 <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Trond
 Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
 <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Neil Brown
 <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,  Dai Ngo
 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jon Maloy
 <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Martin Schiller
 <ms@dev.tdt.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
 <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,  Simon
 Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Joerg Reuter
 <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
 <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 dccp@vger.kernel.org,  linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
 linux-hams@vger.kernel.org,  linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com,  linux-afs@lists.infradead.org,
 linux-sctp@vger.kernel.org,  linux-s390@vger.kernel.org,
 linux-nfs@vger.kernel.org,  tipc-discussion@lists.sourceforge.net,
 linux-x25@vger.kernel.org,  netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev,  lvs-devel@vger.kernel.org
Date: Fri, 26 Apr 2024 08:26:28 -0400
In-Reply-To: <20240426-jag-sysctl_remset_net-v5-4-e3b12f6111a6@samsung.com>
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
	 <20240426-jag-sysctl_remset_net-v5-4-e3b12f6111a6@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 (3.52.0-1.fc40app1) 
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-26 at 12:46 +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
>=20
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>=20
> * Remove sentinel element from ctl_table structs.
>=20
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  net/sunrpc/sysctl.c             | 1 -
>  net/sunrpc/xprtrdma/svc_rdma.c  | 1 -
>  net/sunrpc/xprtrdma/transport.c | 1 -
>  net/sunrpc/xprtsock.c           | 1 -
>  4 files changed, 4 deletions(-)
>=20
> diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
> index 93941ab12549..5f3170a1c9bb 100644
> --- a/net/sunrpc/sysctl.c
> +++ b/net/sunrpc/sysctl.c
> @@ -160,7 +160,6 @@ static struct ctl_table debug_table[] =3D {
>  		.mode		=3D 0444,
>  		.proc_handler	=3D proc_do_xprt,
>  	},
> -	{ }
>  };
> =20
>  void
> diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdm=
a.c
> index f86970733eb0..474f7a98fe9e 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma.c
> @@ -209,7 +209,6 @@ static struct ctl_table svcrdma_parm_table[] =3D {
>  		.extra1		=3D &zero,
>  		.extra2		=3D &zero,
>  	},
> -	{ },
>  };
> =20
>  static void svc_rdma_proc_cleanup(void)
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transp=
ort.c
> index 29b0562d62e7..9a8ce5df83ca 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -137,7 +137,6 @@ static struct ctl_table xr_tunables_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec,
>  	},
> -	{ },
>  };
> =20
>  #endif
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index bb9b747d58a1..f62f7b65455b 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -160,7 +160,6 @@ static struct ctl_table xs_tunables_table[] =3D {
>  		.mode		=3D 0644,
>  		.proc_handler	=3D proc_dointvec_jiffies,
>  	},
> -	{ },
>  };
> =20
>  /*
>=20

Reviewed-by: Jeffrey Layton <jlayton@kernel.org>

