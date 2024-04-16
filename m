Return-Path: <linux-sctp+bounces-72-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06768A675D
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 11:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5212F284723
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B6D86248;
	Tue, 16 Apr 2024 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="akGBHeQw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E993FE2A;
	Tue, 16 Apr 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713260771; cv=none; b=ToWlLNY4aM3uv35ipRbqb2ErI+FyAYnfJ4a5hPh/wNCaOnST1p2HYytErvcxmxC8/aMZLeGMkLOT94LJiVDVJQtFmd6vtqJDavkg97nk/x0FyeOwJWEOoR9IcfgQ+H/edDDrqG/3gx32VsN0m+tGQ9UB+IDtxlXWyfY1Na6t4dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713260771; c=relaxed/simple;
	bh=uXQMpkZp5QlQNFUNub6ZSj3OPwnbQNxhmGJCwt/zU8s=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=ENkmeGGCDLK6p0B3X2JpCaTMGU236ND0jeBkkWDl8CV2xJ2eTwi/GwVIHtlU5ArZST6fsTt8qRICBgC6+6EZ4XveIqXSqmPaE4QF1sdfnmMmcSLYzjIWLZIrFBglQsoU0b8+GGj56DyZqVxrX4lwXUpq8HPzG8zd4qSy1Bl6PV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=akGBHeQw; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240416094603euoutp01a63210abc6544e168a540e59677af9d6~GuZZOPdH92260422604euoutp01D;
	Tue, 16 Apr 2024 09:46:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240416094603euoutp01a63210abc6544e168a540e59677af9d6~GuZZOPdH92260422604euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713260763;
	bh=GHjgo16yMr2ICjYjoTR5zqnRFYJVBWHEV2Cr4i030JI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=akGBHeQwVoWQ0SlsvhKcvMjX3S58ezAaAJ4w6rWLoe7iRISvthzZGBiuQOAui9aic
	 SkfUBlHVljNVZ0/Jx+5ffsJ3flw5Dpd2MMfKrOZBujcK9cHJoTlNialbChxNxSQQiI
	 Mtfi/aAKmcn9jL4dAVbgGuywAhoGlgtA3zljEoyc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240416094603eucas1p19f7a948d2bb067938601f7d21af77da3~GuZY9Yv-L2964929649eucas1p1B;
	Tue, 16 Apr 2024 09:46:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 6F.AC.09875.AD84E166; Tue, 16
	Apr 2024 10:46:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240416094602eucas1p13dc1f72cc2fc8f0025860a4826b33bac~GuZYU4A2m2696126961eucas1p1q;
	Tue, 16 Apr 2024 09:46:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240416094602eusmtrp27349951c78142cb3cfd1638b0a98d520~GuZYSrJS02835728357eusmtrp2O;
	Tue, 16 Apr 2024 09:46:02 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-76-661e48daf588
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 4D.C9.08810.AD84E166; Tue, 16
	Apr 2024 10:46:02 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240416094602eusmtip1907d198c6ca6f10cddd6f00a0f55dea8~GuZX8vk1l2186321863eusmtip1g;
	Tue, 16 Apr 2024 09:46:02 +0000 (GMT)
Received: from localhost (106.210.248.128) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 16 Apr 2024 10:46:00 +0100
Date: Tue, 16 Apr 2024 11:45:56 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <devnull+j.granados.samsung.com@kernel.org>, <Dai.Ngo@oracle.com>,
	<alex.aring@gmail.com>, <alibuda@linux.alibaba.com>,
	<allison.henderson@oracle.com>, <anna@kernel.org>, <bridge@lists.linux.dev>,
	<chuck.lever@oracle.com>, <coreteam@netfilter.org>, <courmisch@gmail.com>,
	<davem@davemloft.net>, <dccp@vger.kernel.org>, <dhowells@redhat.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <fw@strlen.de>,
	<geliang@kernel.org>, <guwen@linux.alibaba.com>,
	<herbert@gondor.apana.org.au>, <horms@verge.net.au>, <ja@ssi.bg>,
	<jaka@linux.ibm.com>, <jlayton@kernel.org>, <jmaloy@redhat.com>,
	<jreuter@yaina.de>, <kadlec@netfilter.org>, <keescook@chromium.org>,
	<kolga@netapp.com>, <kuba@kernel.org>, <linux-afs@lists.infradead.org>,
	<linux-hams@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <linux-x25@vger.kernel.org>,
	<lucien.xin@gmail.com>, <lvs-devel@vger.kernel.org>,
	<marc.dionne@auristor.com>, <marcelo.leitner@gmail.com>,
	<martineau@kernel.org>, <matttbe@kernel.org>, <mcgrof@kernel.org>,
	<miquel.raynal@bootlin.com>, <mptcp@lists.linux.dev>, <ms@dev.tdt.de>,
	<neilb@suse.de>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
	<pablo@netfilter.org>, <ralf@linux-mips.org>, <razor@blackwall.org>,
	<rds-devel@oss.oracle.com>, <roopa@nvidia.com>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <tipc-discussion@lists.sourceforge.net>,
	<tom@talpey.com>, <tonylu@linux.alibaba.com>,
	<trond.myklebust@hammerspace.com>, <wenjia@linux.ibm.com>,
	<ying.xue@windriver.com>
Subject: Re: [PATCH v3 1/4] networking: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240416094556.cv4k3uqthqqpln3h@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ebocjdihejx32jpt"
Content-Disposition: inline
In-Reply-To: <20240415231210.22785-1-kuniyu@amazon.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTaVBTZxSG/e6WQEWvgco3Su0Ul2kptdUuHruhjlPvjMXW+sOOU7VMuYAI
	wSbi1lJjAhrZxNJKQSRsDZFIbCFEFsUMRZCoEIoKUqISQWYwgiUiBYSUcHHqTP895z3ve75z
	fnxiUvKTeJ54h3Q3L5OGRPkznpSpfqT5jQ5uQdhbBa3vQ61iBXSdT6RBEX+YgIRKFwWmgiQC
	XLZeAsYrj5Dg7OqlQZNfxkB2czwF421JDLSe6iagXzlGgaEqgYCeersITCl6BHplJwXneocZ
	SOrzA1X5EILuY3YarmsfMTCiLRbBnSE7BSOpL0BmooqAq0nRUGHrpsBqSqVBm1zCQJplGdw8
	ZyOgtSqbAav5Cg33a1MoSMtTkdCT+4CGznQtBeYLGgT2swMEqDSDJKic90gY1TXQ0JTiIiHL
	UExCe1oPgj+O1NBw9axSBE9yLpNwQaOgoD53LqQZLBQ8ueJAkOG4QcKf5xeB5bGLgKYyJw3O
	7FchXWckoProPyIwNkeCZdRCwL3hXgZc7UGr1nA6ayLNddiHSK6/qRFxOWe+404qWihudCSA
	M56+RXBJdX0kV5llE3Em82IutzSWe1r7u4grLT7KcJdOlxBcZddKLi3fjD733+L5YSgftWMP
	L3vz4689I2xFt0W7TvD7nhoKGAU6viEReYgx+w5OKbyG3CxhdQjfuxOXiDwn+THCE5cviYSG
	E+HMwahngTatjhFMRQifOj5CC8Wk6ZazjhSKcoSHzz1g3BGKXYybSs5QbmbYQNzs6CTd7MO+
	htWG5Kk0yZZ54cajbbS74c3uxJYsx1TYi12F64bVIoHn4MbM7qlBJLsP30nXTg4ST/J8XDQh
	dsse7Apcfv8kKay6ECvthbTAcdhi7CDcb2G2ZSYu0x+aNq3FLQkJjMDeuK/BKBLYD7sqNdOB
	dIQvTjwSCYUeYe2hIUJwfYDjr3dPJ1bjzsyiqY0wOwu3P5wjLDoL/2jKmJa9sPqwRHAvwfrb
	DioNLcx67rSs507L+u80QQ7EudWDzP/k17E27wEp8EfYYBigcpGoGPnysfLocF6+XMrvXSoP
	iZbHSsOXfhMTXYomP+uViYbHFaio7++ltYgQo1q0aDJs/01vRfMoaYyU9/fxivd+KUziFRqy
	/wAvi9kui43i5bVovpjy9/VaHPoyL2HDQ3bzO3l+Fy971iXEHvMUxItaK54TeJAIPLDBsvnu
	nqGtpgFp5omqma6HCqOu+tpZqeTa3ct+XRGxrSt+terXt+yK27D1ujfj2R3WVbGpQeb4QdUS
	75ux7UtzfuONn80leyJzPl23xFpzPor1+eQLZVhGe++oRnJ3iWN8cP/NfogJ/iunKaDG3PPL
	ewtjdEcinInMKx2pHraCdbM1eV3JlrZ9A6PK/s2bDs2InF1Bz01XRASrq+CYLml10NgALi9T
	RY4Vfn8pOnTBSHbhynq5eONXtvp3/fLHbaXDu+9vUQYf7A3aob4YDHHbFPi0MX7GmrdPfqb2
	O7F8Zsp+dZT4YVCA9tuajQMV2/PGXNb1W/bGRvr6U/KIkGUBpEwe8i+cf3vQJwUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeVBTZxTF/d6WAAUj0frErZPq1FKMRlluqGvHP15d2k6t1bYuTfWhqCSa
	BAboOEaWCoFIHJ1BI0KUNkXAaASCuEJEwGDD5oKOaBNZFKKUsklkKRE7dab//eac75zvzp25
	XNzXxPHjhkuVrFwq2S2gPInq4cqmuQ+ZGWHzq1wTwKIKAfsVNQmqhF8wSCwZIcCcnYLBSFMb
	BkMlB3HotreRkHW6gIKMmgQChu6nUNBwshmDl3GvCTBeSsSgpcLBAbMmD0Fe3CMCitv6KUhp
	nwbxRb0ImtMcJNwx/EXBgCGXA096HQQMHPKC4+p4DG6nRMDFpmYCas2HSDCknqVAaxXBveIm
	DBouZVBQW1pNQqtFQ4D2VDwOLfoOEh4dMRBQejULgeNcJwbxWX/jEN/9FAdXTiUJNs0IDjpj
	Lg6N2hYENw5eI+H2uTgO9GVW4XA1S0VAhf590BqtBPRVOxGkO+/iUH9lFlh7RjCwFXST0J0x
	B47kFGJwOfkVBwprdoLVZcXgaX8bBSONS5d9xuTUqknmoaMXZ17abiEmM/9n5oSqjmBcA/5M
	4ZkHGJNS3o4zJbomDmMunc3oL0QygxYTh7mQm0wxN8+cxZgSu5jRni5FXwm+Fy6SyyKV7Ac7
	ZArlYsEPIlggFIlBuCBQLBQtDNkUuiBIMG/Jom3s7vAoVj5vyY/CHab+k9ieo2x0R1UZUqG0
	L9TIg0vzAun7hhxKjTy5vrzfEH00L48zZkyjTT13yTHm04P31G8fdSH6Qd1z5DZ8eUWIrk/3
	cjPBm03bzuYTbqZ4AXSN8xHu5om8j+kkYyrpDuM8kzftzKt5Y/B5u2irzkm52Zu3jC7vT+KM
	/VCN6OYzf7w1JtC3jje/acV5UXR60YtRnTvKU+nfh7lu2YMXQhe1nsDHJv2QjnP8+nbqfXT3
	UCvSIr7unSbdO026/5rGZH+6cfg59j/5E9pwqgMf48W00dhJ6BEnF01kIxUR2yMUIqFCEqGI
	lG4XbpVFXECj92KuGCi4iDLbu4QWhHGRBc0aTTrO59UiP0Iqk7KCid4J/Olhvt7bJDGxrFy2
	RR65m1VYUNDoGg/jfpO2ykaPT6rcIgqeHyQKDBbPDxIHLxRM9v58T5LEl7ddomR3seweVv5v
	DuN6+KmwgICrzpvjaO2X0ameM6P9Y7i5zyxr1mRMXaeMr7n/9BhsK+/71kZ4VG44rNGvrs9a
	f0yRXiYd3/WTQVURu7R4bfnKB0lhe48PvV7ZMykq2XEjQLLfywTZ4tay9x7XtVkbXs1I04Rn
	Hx03XP71kxdVVY/nSIY0g117v1m/iapXLpnbYhajyTPyp6QfCG14daB+fOdGYkNP4WRCfl12
	edV3rSsqp5HnNX8iByd0XZjPM00cFfipV6And/ZHrglrl3vo6+w7s6+bSJ/UmdT0mNWFaSHM
	RvvWBHtiSOPqWH74oE8+v6B41WZb2XmBa8WAefOqZI/May6nc8q+/VF+5didrkvGawJCsUMi
	8sflCsk/bruVFcQEAAA=
X-CMS-MailID: 20240416094602eucas1p13dc1f72cc2fc8f0025860a4826b33bac
X-Msg-Generator: CA
X-RootMTR: 20240415231242eucas1p2c2b98fffb9b4752a3771f343d7a53dfe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240415231242eucas1p2c2b98fffb9b4752a3771f343d7a53dfe
References: <20240412-jag-sysctl_remset_net-v3-1-11187d13c211@samsung.com>
	<CGME20240415231242eucas1p2c2b98fffb9b4752a3771f343d7a53dfe@eucas1p2.samsung.com>
	<20240415231210.22785-1-kuniyu@amazon.com>

--ebocjdihejx32jpt
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 04:12:10PM -0700, Kuniyuki Iwashima wrote:
> From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.o=
rg>
> Date: Fri, 12 Apr 2024 16:48:29 +0200
> > From: Joel Granados <j.granados@samsung.com>
=2E..
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

That is fair. It is a big chunk:). I'll put the trivial patches together
to avoid having an 18 commits to instead have 8. This is my proposal
based on MAINTAINERS file:

### Not in MAINTAINERS / Orphaned
net/core/neighbour.c
net/core/sysctl_net_core.c
net/ieee802154/6lowpan/reassembly.c
net/mpls/af_mpls.c
net/unix/sysctl_net_unix.c
net/dccp/sysctl.c

### NETWORKING
net/ipv4/devinet.c
net/ipv4/ip_fragment.c
net/ipv4/route.c
net/ipv4/sysctl_net_ipv4.c
net/ipv4/xfrm4_policy.c
net/ipv6/addrconf.c
net/ipv6/icmp.c
net/ipv6/reassembly.c
net/ipv6/route.c
net/ipv6/sysctl_net_ipv6.c
net/ipv6/xfrm6_policy.c

### RDS
net/rds/ib_sysctl.c
net/rds/sysctl.c
net/rds/tcp.c

### SUNRPC
net/sunrpc/sysctl.c
net/sunrpc/xprtrdma/svc_rdma.c
net/sunrpc/xprtrdma/transport.c
net/sunrpc/xprtsock.c

### LLC/MTCP/NETROM/PHONET/ROSE/RXRPC/SCTP/SMC/TIPC/x.25/IPSEC
net/llc/sysctl_net_llc.c
net/mptcp/ctrl.c
net/netrom/sysctl_net_netrom.c
net/phonet/sysctl.c
net/rose/sysctl_net_rose.c
net/rxrpc/sysctl.c
net/sctp/sysctl.c
net/smc/smc_sysctl.c
net/tipc/sysctl.c
net/x25/sysctl_net_x25.c
net/xfrm/xfrm_sysctl.c

>=20
>=20
> >=20
> > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > index 552719c3bbc3..b0327402b3e6 100644
> > --- a/net/core/neighbour.c
> > +++ b/net/core/neighbour.c
> > @@ -3728,7 +3728,7 @@ static int neigh_proc_base_reachable_time(struct =
ctl_table *ctl, int write,
> > =20
> >  static struct neigh_sysctl_table {
> >  	struct ctl_table_header *sysctl_header;
> > -	struct ctl_table neigh_vars[NEIGH_VAR_MAX + 1];
> > +	struct ctl_table neigh_vars[NEIGH_VAR_MAX];
> >  } neigh_sysctl_template __read_mostly =3D {
> >  	.neigh_vars =3D {
> >  		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_PROBES, "mcast_solicit"),
> > @@ -3779,7 +3779,6 @@ static struct neigh_sysctl_table {
> >  			.extra2		=3D SYSCTL_INT_MAX,
> >  			.proc_handler	=3D proc_dointvec_minmax,
> >  		},
> > -		{},
> >  	},
> >  };
> > =20
> > @@ -3807,8 +3806,6 @@ int neigh_sysctl_register(struct net_device *dev,=
 struct neigh_parms *p,
> >  	if (dev) {
> >  		dev_name_source =3D dev->name;
> >  		/* Terminate the table early */
>=20
> You can remove this comment.
Why? I do not think we should remove it because it is what the change to
neigh_vars_size is doing.

>=20
>=20
> > -		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
> > -		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
> >  		neigh_vars_size =3D NEIGH_VAR_BASE_REACHABLE_TIME_MS + 1;
> >  	} else {
> >  		struct neigh_table *tbl =3D p->tbl;
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index 6973dda3abda..46f5143e86be 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> > @@ -660,7 +660,6 @@ static struct ctl_table net_core_table[] =3D {
> >  		.proc_handler	=3D proc_dointvec_minmax,
> >  		.extra1		=3D SYSCTL_ZERO,
> >  	},
> > -	{ }
> >  };
> > =20
> >  static struct ctl_table netns_core_table[] =3D {
> > @@ -697,7 +696,6 @@ static struct ctl_table netns_core_table[] =3D {
> >  		.extra2		=3D SYSCTL_ONE,
> >  		.proc_handler	=3D proc_dou8vec_minmax,
> >  	},
> > -	{ }
> >  };
> > =20
> >  static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
> > @@ -715,7 +713,8 @@ __setup("fb_tunnels=3D", fb_tunnels_only_for_init_n=
et_sysctl_setup);
> > =20
> >  static __net_init int sysctl_core_net_init(struct net *net)
> >  {
> > -	struct ctl_table *tbl, *tmp;
> > +	struct ctl_table *tbl;
> > +	size_t table_size =3D ARRAY_SIZE(netns_core_table);
>=20
> When you add a new variable, please keep reverse xmas tree.
Thx for pointing this out. Was not aware of this quirk in net code. Will
include it for my next version.

>=20
> Also, you can reuse this variable for the following
> register_net_sysctl_sz(), but it's inconsistent in the
> this patch..
>=20
>   table_size
>   * sysctl_route_net_init
>   * ipv4_sysctl_init_net
>=20
>   ARRAY_SIZE
>   * __addrconf_sysctl_register
>   * ipv6_sysctl_net_init
>   * mpls_dev_sysctl_register
>   * sctp_sysctl_net_register
>=20
>=20
> > =20
> >  	tbl =3D netns_core_table;
> >  	if (!net_eq(net, &init_net)) {
> > @@ -723,8 +722,8 @@ static __net_init int sysctl_core_net_init(struct n=
et *net)
> >  		if (tbl =3D=3D NULL)
> >  			goto err_dup;
> > =20
> > -		for (tmp =3D tbl; tmp->procname; tmp++)
> > -			tmp->data +=3D (char *)net - (char *)&init_net;
> > +		for (int i =3D 0; i < table_size; ++i)
> >  	.devinet_vars =3D {
=2E..
> >  		.extra1		=3D SYSCTL_ONE,
> >  	},
> > -	{ }
> >  };
> > =20
> >  static __net_init int ipv4_sysctl_init_net(struct net *net)
> >  {
> >  	struct ctl_table *table;
> > +	size_t table_size =3D ARRAY_SIZE(ipv4_net_table);
>=20
> nit: keep reverse xmax tree order.
Ok.

>=20
>=20
> > =20
> >  	table =3D ipv4_net_table;
> >  	if (!net_eq(net, &init_net)) {
> > @@ -1517,7 +1516,7 @@ static __net_init int ipv4_sysctl_init_net(struct=
 net *net)
> >  		if (!table)
> >  			goto err_alloc;
> > =20
> > -		for (i =3D 0; i < ARRAY_SIZE(ipv4_net_table) - 1; i++) {
=2E..
> > =20
> >  static int __addrconf_sysctl_register(struct net *net, char *dev_name,
> > @@ -7197,7 +7194,7 @@ static int __addrconf_sysctl_register(struct net =
*net, char *dev_name,
> >  	if (!table)
> >  		goto out;
> > =20
> > -	for (i =3D 0; table[i].data; i++) {
> > +	for (i =3D 0; i < ARRAY_SIZE(addrconf_sysctl); i++) {
>=20
>                         ^^^
Did you mean reuse variable here? What does this mean?

>=20
>=20
> >  		table[i].data +=3D (char *)p - (char *)&ipv6_devconf;
> >  		/* If one of these is already set, then it is not safe to
> >  		 * overwrite either of them: this makes proc_dointvec_minmax
> > diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> > index 1635da07285f..91cbf8e8009f 100644
> > --- a/net/ipv6/icmp.c
> > +++ b/net/ipv6/icmp.c
> > @@ -1206,7 +1206,6 @@ static struct ctl_table ipv6_icmp_table_template[=
] =3D {
> >  		.extra1		=3D SYSCTL_ZERO,
=2E..
> > -	{ }
> >  };
> > =20
> >  static int __net_init ipv6_sysctl_net_init(struct net *net)
> > @@ -264,7 +262,7 @@ static int __net_init ipv6_sysctl_net_init(struct n=
et *net)
> >  	if (!ipv6_table)
> >  		goto out;
> >  	/* Update the variables to point into the current struct net */
> > -	for (i =3D 0; i < ARRAY_SIZE(ipv6_table_template) - 1; i++)
> > +	for (i =3D 0; i < ARRAY_SIZE(ipv6_table_template); i++)
>=20
>                         ^^^
Did you mean reuse variable here? What does this mean?
>=20
>=20
> >  		ipv6_table[i].data +=3D (void *)net - (void *)&init_net;
> > =20
> >  	ipv6_route_table =3D ipv6_route_sysctl_init(net);
> > diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> > index 42fb6996b077..499b5f5c19fc 100644
> > --- a/net/ipv6/xfrm6_policy.c
> > +++ b/net/ipv6/xfrm6_policy.c
> > @@ -184,7 +184,6 @@ static struct ctl_table xfrm6_policy_table[] =3D {
> >  		.mode		=3D 0644,
> >  		.proc_handler   =3D proc_dointvec,
> >  	},
> > -	{ }
> >  };
> > =20
> >  static int __net_init xfrm6_net_sysctl_init(struct net *net)
> > diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
> > index 8443a6d841b0..72e101135f8c 100644
> > --- a/net/llc/sysctl_net_llc.c
> > +++ b/net/llc/sysctl_net_llc.c
> > @@ -44,11 +44,6 @@ static struct ctl_table llc2_timeout_table[] =3D {
> >  		.mode		=3D 0644,
> >  		.proc_handler   =3D proc_dointvec_jiffies,
> >  	},
> > -	{ },
> > -};
> > -
> > -static struct ctl_table llc_station_table[] =3D {
> > -	{ },
> >  };
> > =20
> >  static struct ctl_table_header *llc2_timeout_header;
> > @@ -56,8 +51,9 @@ static struct ctl_table_header *llc_station_header;
> > =20
> >  int __init llc_sysctl_init(void)
> >  {
> > +	struct ctl_table empty[1] =3D {};
> >  	llc2_timeout_header =3D register_net_sysctl(&init_net, "net/llc/llc2/=
timeout", llc2_timeout_table);
> > -	llc_station_header =3D register_net_sysctl(&init_net, "net/llc/statio=
n", llc_station_table);
> > +	llc_station_header =3D register_net_sysctl_sz(&init_net, "net/llc/sta=
tion", empty, 0);
>=20
> Do we really need this ... ??
That is a good question, but its something that needs to be address
outside this patchset. I'm just keeping current behaviour.

>=20
>=20
> > =20
> >  	if (!llc2_timeout_header || !llc_station_header) {
> >  		llc_sysctl_exit();
> > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > index 6dab883a08dd..e163fac55ffa 100644
> > --- a/net/mpls/af_mpls.c
> > +++ b/net/mpls/af_mpls.c
> > @@ -1393,7 +1393,6 @@ static const struct ctl_table mpls_dev_table[] =
=3D {
> >  		.proc_handler	=3D mpls_conf_proc,
> >  		.data		=3D MPLS_PERDEV_SYSCTL_OFFSET(input_enabled),
> >  	},
> > -	{ }
> >  };
> > =20
> >  static int mpls_dev_sysctl_register(struct net_device *dev,
> > @@ -2689,7 +2688,7 @@ static int mpls_net_init(struct net *net)
> >  	/* Table data contains only offsets relative to the base of
> >  	 * the mdev at this point, so make them absolute.
> >  	 */
> > -	for (i =3D 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
> > +	for (i =3D 0; i < ARRAY_SIZE(mpls_table); i++)
>=20
>                         ^^^
>=20
>=20
> >  		table[i].data =3D (char *)net + (uintptr_t)table[i].data;
> > =20
> >  	net->mpls.ctl =3D register_net_sysctl_sz(net, "net/mpls", table,
> > diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> > index 13fe0748dde8..8bf7c26a0878 100644
> > --- a/net/mptcp/ctrl.c
> > +++ b/net/mptcp/ctrl.c
=2E..
> > =20
> >  	net->xfrm.sysctl_hdr =3D register_net_sysctl_sz(net, "net/core", tabl=
e,
> >  						      table_size);
> >=20
> > --=20
> > 2.43.0
> B

Thx for the review

Best
--=20

Joel Granados

--ebocjdihejx32jpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYeSNMACgkQupfNUreW
QU8rEQv+MUi7fm5oXY0H9hoW3rH7wTOOXoaWiXD+2m4X9BCFtR+IO7Hbi4TCr+vb
jnK7Yvsbcj8krLpOAr3GlcUtn7MvnzUBu4gR2vQ1PWNrHdZfVF2h+qb6R4lBazhK
Ri7yXSJrCB2IdfryrmFqvFCwBQjVvZv5B8p8vK2BtIRqSN6N2acqMmp5UbfE6HWj
pvFakjOfrMPY6XUabRE3+P3xMHOqlBEtgugMwlLQ++0MG+6URTFeXYt7Av0iTwas
xkK/6Kx7G5p+4qTYrfm48BP51HyIFhzbE5Tapp7ytO3xHvXyRBm04Nw6Gj2Ta7W0
7HlDyKSiZNwGVf2wElQfifKlgJPZUmSdz4x87++8QSPdv8omF8qiR0PSWPSSIjhh
NxKUMRp3TnxCHEu3opx9NODX2JWD5dUoAJ7iCLctAYu7QHk1Oj5uoT8CCmzLwcSJ
IcrwHRFVUjfe5mgmC2MnVB/uvqWPstV1ntAQY6mxXIx3L/QxRC3SlKgEZS4X7jS5
u+CGwYd+
=O6yr
-----END PGP SIGNATURE-----

--ebocjdihejx32jpt--

