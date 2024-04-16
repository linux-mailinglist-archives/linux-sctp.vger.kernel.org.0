Return-Path: <linux-sctp+bounces-73-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2E78A7125
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2241AB2279F
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03B3131BB9;
	Tue, 16 Apr 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oQA3y6Km"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81911130492;
	Tue, 16 Apr 2024 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284323; cv=none; b=etO/SzJxwr50cJ/MTTfVkWxQm0INqhPRIUFUUS7y/AcnNvNy1GCAsXF/jo7VbwtOpWDY8C+7owgiXIm2qfOBnXLlfI9gRh0+HnpL7bRo3pXJD0Ih/Qr5F4fLs6MwQeWc2Lixsqr1h12jD918Jp2+L0SaCK9GLpZXaal4fFubGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284323; c=relaxed/simple;
	bh=TMe84rkKVnERfDW7pnotvDYbq5M96tycRe0wAzXGtTE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=cK4V1282Jq825iOMsdQ7LwVDRLXh15dLoIXdtq8qrHmJGUIPwbHbPQWvv2ucCbKjqktTDhZSTp3c5BK8HUk2HNygwCCJlYRztFShSHffqa2pj43CxIa0Ccnb6hk9j3hnjHQQUKy3CuIUoASIaPmgYsIYdb7boPusk20bdpodWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oQA3y6Km; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240416161834euoutp016ed8e3413fe609790c0d8dbf9feac414~GzwGfGfWW3240132401euoutp019;
	Tue, 16 Apr 2024 16:18:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240416161834euoutp016ed8e3413fe609790c0d8dbf9feac414~GzwGfGfWW3240132401euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713284314;
	bh=h+c9h4XaiZkjioKXCmApqXr79Ng5aLpw1//8aiqZHc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oQA3y6KmBKthx8qB9iE4BR3H6yqJ6FukwNapodgwSnRYzAL31g2zz1LG0XV+UMQtL
	 4zQb3hb/qbUPieVGupbzz8vixmzqZg/dtu/87j1Ox0AjkK/QGpaLghlYR8LlHkWnMB
	 IcVLcJI4qek4WgTYJyN7I9My/dEfKwnCG6u2qbyY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240416161833eucas1p2933e7709d8615304a664fce5197722dc~GzwGP5yav1903019030eucas1p2N;
	Tue, 16 Apr 2024 16:18:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 88.0B.09624.9D4AE166; Tue, 16
	Apr 2024 17:18:33 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240416161833eucas1p12e7e5db7e46bb558f0b7e7b7c0f3a17d~GzwFfH9zE2936029360eucas1p1t;
	Tue, 16 Apr 2024 16:18:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240416161833eusmtrp13acb475819bd914644dc864e75f24f1b~GzwFdvMoW2276022760eusmtrp1Q;
	Tue, 16 Apr 2024 16:18:33 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-dd-661ea4d9ad2d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D1.78.09010.8D4AE166; Tue, 16
	Apr 2024 17:18:32 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240416161832eusmtip2f37c2e32456a165bc55314d3e78c49a2~GzwFH_cTH1934419344eusmtip27;
	Tue, 16 Apr 2024 16:18:32 +0000 (GMT)
Received: from localhost (106.210.248.3) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 16 Apr 2024 17:18:31 +0100
Date: Tue, 16 Apr 2024 14:32:12 +0200
From: Joel Granados <j.granados@samsung.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>,
	<devnull+j.granados.samsung.com@kernel.org>, <Dai.Ngo@oracle.com>,
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
	<netfilter-devel@vger.kernel.org>, <pablo@netfilter.org>,
	<ralf@linux-mips.org>, <razor@blackwall.org>, <rds-devel@oss.oracle.com>,
	<roopa@nvidia.com>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <tipc-discussion@lists.sourceforge.net>,
	<tom@talpey.com>, <tonylu@linux.alibaba.com>,
	<trond.myklebust@hammerspace.com>, <wenjia@linux.ibm.com>,
	<ying.xue@windriver.com>
Subject: Re: [PATCH v3 1/4] networking: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240416123212.nrgpuix3dhkmfbzq@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="arc6idvhr2tglhrq"
Content-Disposition: inline
In-Reply-To: <be056435353af60a564f457c79dacc16c6ea920e.camel@redhat.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1BUdRTH+9179+6KLV12KX+DZoqShUJSpqc0n6XX0VHLPyKnRhi4osjD
	dqUgs5AF0UV0cymT1wLmykNWhXUVQaSNhy4GKE9RbFiXFoFEgVVAYWO9ODrjf5/zPecz95zf
	zBWRkt9EbqJtYTs5WZh/iDvtRBkqh2q8bvwxdcvcv3s9wRi9ANpLlAKIjt1LQFyRnQLDsQQC
	7G1WAkaK4knob7cKQJNVSENqbSwFI80JNNSnWQi4F/OYAt2FOAI6Ks1CMCTmIciLuUXBOesj
	GhK6poDirA2B5ZBZAA3a+zQMaXOF8I/NTMHQwYlwVKkg4GpCKJxvs1BQZzgoAO2BfBpUJh9o
	OtdGQP2FVBrqyqoF8K8xkQJVpoKEjoxuAdxSaykou6hBYD7VS4BC00eCov8OCcPZVQKoSbST
	kKzLJaFF1YHgr/hSAVw9FSOEh+mXSbioiaagMuMNUOlMFDys7kFwpKeRhOslM8E0YCegprBf
	AP2p74A6W09A8f5BIehrg8E0bCLgziMrDfaWJUuXs9l1SgHbaraR7L2aK4hNP7mLTYm+RrHD
	Q56sPucGwSaUd5FsUXKbkDWUebAZBRHsE+MZIVuQu59mK3LyCbao/SNWlVWGNrhvcloUyIVs
	+46TvbfYz2mrPUGNdjS4RGZq+8hoFOesRBNEmJmH0zp1pBI5iSRMNsLX2kbGiwGET2tKhHzR
	j3B7/E3imZKjiEN84wTClt5Lz6f2FOeP+4UIlx+vIB0KxXjgjuZy5GCamYNre249zV2ZGbh7
	5DLtEEimSow7Ux8/HZIy27EpuYd2sJhZis9Wd5A8u+ArRy2Ug0kmEl/45fgYi8Z4Mj4xKnLE
	ExgWJ2U2IX7V6VhX20DxvBub9K2E41uYufIqNpuHab7xKT6vqhHyLMVdVfpxnoKr1QcoXlAj
	fGn0vpAv8hDW7rGNv8ZCHNtgGTeW4bKUlqcbYcYZt/znwi/qjA8bjpB8LMb79kr46bdx3u0e
	SoVmJL9wWvILpyU/P42P5+CM4j76pXg21mZ2kzx/gnW6XioDCXPRJC5CHhrEyX3CuO+95f6h
	8oiwIO+A8NACNPa7Vo9W9Z1HaV0PvI2IECEjmjkmm0/n1SE3Kiw8jHN3FcdK39wiEQf6R/3A
	ycI3yyJCOLkRTRZR7pPEHoFvcRImyH8nt53jdnCyZ11CNMEtmpjf2XXa69i6DeRXQs3G11ev
	/RJ1rJll4O4GpKxK/LXx3MDNkE22kDVWaUqU9IOVReqNwVNju4VLTlwvMGU3mGNcSuTiubNr
	dOnVt5uy7MEPj8t8xDp5U7Dfu7agk1HrzwRWLbT0TZzuXjS64GvfAmXSrAfLPvz9SUBzaUVd
	Vqvey2dzqXX9IXudJP3PwbKAafqfNLleWWnTIpfvS9ncWOG84uNgpa9xRZKhJa7ix0VLC90k
	921LSL9vDgrWba9IbVy98PDnoz2DEqnUuy9gduVrZ6yv+MYv3t1kXZtqmb4yX7GKix8ovyzL
	UX9xPWtXVH3prrstnx3zeuTqMe/n91Uebt82SOcvTnKn5Fv9fTxJmdz/f4S0r8gpBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTdxTH/d17e1vc0EpR79At2kliulkoFDxd8JFlSy7LsviHWzLN5hq4
	gtoHttQ9zBakoFIESkCmFQR8lNeE8bCIw0mqIhRjOxSsW4HRgmQUZViF8WrX2i0z2X+f8z3n
	+83JSQ4HD2tkR3D2KdIZlUIq45NLiR7v7cFN9gtv7I1+bBeDOWMzDLfrWJCRdRSD7DYfAabz
	uRj4BsYwWGw7hoNneIwF5eeaSSi1ZhGw+CCXhHtlIxg8yZwnoP5qNgajnU42mPLqENRlOgho
	HZshIXd8LWgvP0cwUuBkwX3jnyTMGmvZMPTcScBs/itwWqfF4E6uHK4MjBBgM+WzwHjiEgl6
	iwj6WwcwuHe1lARbRw8LHpnzCNBXanEYrXCzwFFkJKDjWjkCZ8MkBtrypzhoPS4c5qpvs+Bu
	ng8HQ30tDnb9KIIbx35mwZ2GTDZMn+3C4Vp5BgGdFatAX28hYLpnAsH3E3049LZvAMszHwZ3
	mz0s8JRuhKLqFgx+yvmLDS3W/WCZs2DgmhkjwWfftv1dutqmY9G/Op/j9JO73Yg++8Nh+kzG
	LwQ9NyugW2oeYnTuzXGcbjMMsGlTRyRd0aShF8yNbLqpNoekb9Vcwui2YQmtP9eBdvB3CRNU
	Sk06sy5VqU7fwt8tghihSALCGLFEKIrd/Nk7MXH8qK0JyYxs3yFGFbX1C2GqXasj0npXfFVR
	OIRlIO0yHQrhUFwxVaPNRgEO415ElNG4PqivpRqf9bGCzKMW+nWkDi31z0wh6nbr9X+KZkQd
	OTX3wk1wI6nRBzdfMMl9m7JOOPAAh3PfpNyLXS8MOPdWKOUuGmQHGjzuAcpimCADHMrdTl3u
	GcWDqTkYlZOdzQo2VlDdp0eIAOPcQ1Tp74GdOH5eQ1V5OQE5hEtTxZX9KLjqeqreep8I8reU
	Z/ER0iOe4aUkw0tJhv+SgrKAsnv/wP4nv0UZK914kLdQ9fWTRAVi16JwRqOWp8jVMUK1VK7W
	KFKESUp5E/L/i6lztuUKqhmfEpoRxkFmtMHvdP5YZ0MRhEKpYPjhoVm81/eGhSZLv/6GUSn3
	qDQyRm1Gcf4zFuIRK5OU/udTpO8RxUfHicTxkug4SXwsf3VoYtpxaRg3RZrOHGCYNEb1rw/j
	hERkYLB5tdablXQwa++qeCH+Pr1c4ZgS9H7auu1z0/HhZv6IZuM6HD+zKSay8bHMdbZ5RlFu
	trzqEsc/beLYY2dk0wuupWWJj5n+ecFr7I/XamDhS897ndVXf0voXba8Shd3fuWOglZ5Vrji
	4WDiZTI2jO86v1j5XQivLpnXlFBDr/nE1n4jsVZf5xa4lxjm91dtPzQdNX7R0VByhK3Zrbz+
	YZo0uezoPtOsJtxlG9zJiy7buatAdbDLunxJ/gfWR0eijBeKo91Dp4uTxpSn5iXKtsMlDbLS
	B91DXonPVtDZUygebpjMjLVJtjlOHKVL+pQTfaJi0TXmozjRzAFve/pJD59Qp0pFAlyllv4N
	Xa6R4cQEAAA=
X-CMS-MailID: 20240416161833eucas1p12e7e5db7e46bb558f0b7e7b7c0f3a17d
X-Msg-Generator: CA
X-RootMTR: 20240416081854eucas1p102081018d3e61cd9a250ab62f46b4e8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240416081854eucas1p102081018d3e61cd9a250ab62f46b4e8a
References: <20240412-jag-sysctl_remset_net-v3-1-11187d13c211@samsung.com>
	<20240415231210.22785-1-kuniyu@amazon.com>
	<CGME20240416081854eucas1p102081018d3e61cd9a250ab62f46b4e8a@eucas1p1.samsung.com>
	<be056435353af60a564f457c79dacc16c6ea920e.camel@redhat.com>

--arc6idvhr2tglhrq
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:18:42AM +0200, Paolo Abeni wrote:
> On Mon, 2024-04-15 at 16:12 -0700, Kuniyuki Iwashima wrote:
> > From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel=
=2Eorg>
> > Date: Fri, 12 Apr 2024 16:48:29 +0200
> > > From: Joel Granados <j.granados@samsung.com>
=2E..
> > >  net/rxrpc/sysctl.c                  | 1 -
> > >  net/sctp/sysctl.c                   | 6 +-----
> > >  net/smc/smc_sysctl.c                | 1 -
> > >  net/sunrpc/sysctl.c                 | 1 -
> > >  net/sunrpc/xprtrdma/svc_rdma.c      | 1 -
> > >  net/sunrpc/xprtrdma/transport.c     | 1 -
> > >  net/sunrpc/xprtsock.c               | 1 -
> > >  net/tipc/sysctl.c                   | 1 -
> > >  net/unix/sysctl_net_unix.c          | 1 -
> > >  net/x25/sysctl_net_x25.c            | 1 -
> > >  net/xfrm/xfrm_sysctl.c              | 5 +----
> > >  35 files changed, 20 insertions(+), 81 deletions(-)
> >=20
> > You may want to split patch based on subsystem or the type of changes
> > to make review easier.
>=20
> I agree with Kuniyuki. I think the x25 chunks can me moved in the last
> patch, and at least sunrpc and rds could go in separate patches,
> possibly even xfrm and smc.

No problem. I'll put x25 and ax.25 patches together into one commit.
Thx

Best

--=20

Joel Granados

--arc6idvhr2tglhrq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYeb8sACgkQupfNUreW
QU9IgQv/f3B6o6CgzcLe66voGeH52C4Mqq88G+CAPi1Y55DViplwGANdfK6EBoDN
6Uzq/iW+1nx0YiieJ0iErfZYCed7fAx2cY90xhYzfiJk3+e0xJGOzirNFxHFI0oL
/AdldpRWTtKVIjqOLxy8V75vvztbqeUhe7WrLg59RD3bDhmRtwXp/VsJ7bfe+HjC
lUB3RjWgKUyR0J8eRFAi0cq3JgnpPHxOyHmr6RUrARc/MEm/fXh+L/GiipQLOjMM
3AiwB/v96pvRP+gjjIVHvB87IAZYCrpeLlx5YKpxNg6z3YxKf+unw2DrwXrbsduD
Uxd0fgyicGQFvBbm4eSG/49a5uByExNlmH7aldYY1QuSbCVgTCFc/85ybpbyufFJ
k0MgrMSr4J7H+kxulOrh3U0NW7qhZXo0HGc6isvypx0qZARcVunY/pLIqyyGsInv
V6iNf9SGHFSR5BL81V0wQVuPrRaIgae5oho/2EzF8x5dCuwZtIc3oW5dfmk0Nlr4
EsKgK3Yv
=6qGD
-----END PGP SIGNATURE-----

--arc6idvhr2tglhrq--

