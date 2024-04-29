Return-Path: <linux-sctp+bounces-122-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E718B5301
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5AA28243C
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 08:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE5317582;
	Mon, 29 Apr 2024 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pcfTn42F"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9FD171A2;
	Mon, 29 Apr 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378956; cv=none; b=Me2l3tqUh3UVhs6IFM+e2IFvUY/of82kR4UvHVwVCfN4xRf2ez1p26ubZxenjApWWUfdS4x1cAMFIR78iQdnjFbwtY+me/rAY7vsLZ4OlRFhUZDMSIa46GzxdQObsz5WSMHk+CXuubWfpwKwy71g1Bb6XGBqHkGJDJ0GnL+t8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378956; c=relaxed/simple;
	bh=vmQhFu9Z85eG7EcW0AhW8K6S1CagXduaCcOVel3TAkA=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=L3yjejGX/QK8yoIFsmot2I1BtgpvYQgYRDgWx0JPwEHjpRiHNv45deGym6WyamyA0+98CsmvNVja8Vlm+QWhNx44n4R/uuvHqMoDZ3IjSIXgpA+gD5FHZsKrcKuuYHNU5HVLUXRlqAg1UOzsmEPt2NIdkunteDWmbnNlSSUL+Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pcfTn42F; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240429082225euoutp01536672162a2d44007903f57508dd6fed~KspFqHRCi2679526795euoutp01C;
	Mon, 29 Apr 2024 08:22:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240429082225euoutp01536672162a2d44007903f57508dd6fed~KspFqHRCi2679526795euoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714378945;
	bh=EDH8ncm+HQnqFKkgYGDoPqiCQ/PFbOlGzBOCb0L0yaY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pcfTn42FAJB4wthO3/smmoMKM8XfCwMy6wGzDbE+RlPsp3iKbDqz7ryUdQGb1ybAP
	 DIWQpakAkWXZZTbGDrqaZinY+v7Zp2L+hf1fF5tKlypXWP7UwArjKx0vL185tGltsD
	 tJ3XOk5TGj+u07oTvlSwoxBxOPIa2pN9IrQpOKMA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240429082225eucas1p16feedfcc95a38a247de5770fd234838b~KspFWp07b1984019840eucas1p1E;
	Mon, 29 Apr 2024 08:22:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id C9.E4.09875.1C85F266; Mon, 29
	Apr 2024 09:22:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240429082224eucas1p19fe32106f867ab99be67ddd41f488c73~KspEu3Zia0429804298eucas1p1B;
	Mon, 29 Apr 2024 08:22:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240429082224eusmtrp1b450c16f3386e7aa7e696cc524dc8b0a~KspEpk53Q1048210482eusmtrp1Y;
	Mon, 29 Apr 2024 08:22:24 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-f2-662f58c1dde2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 20.CD.09010.0C85F266; Mon, 29
	Apr 2024 09:22:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240429082224eusmtip2ed71f104a9669c0a8721bf44a77f9871~KspEUcgZZ2916229162eusmtip2D;
	Mon, 29 Apr 2024 08:22:24 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 29 Apr 2024 09:22:23 +0100
Date: Mon, 29 Apr 2024 10:22:19 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, Steffen
	Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Matthieu Baerts <matttbe@kernel.org>, Mat
	Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Ralf
	Baechle <ralf@linux-mips.org>, Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>, David Howells
	<dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Marcelo
	Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
	<lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu
	<tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Trond
	Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, Ying Xue
	<ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, Pablo Neira Ayuso
	<pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Florian
	Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, Nikolay
	Aleksandrov <razor@blackwall.org>, Simon Horman <horms@verge.net.au>, Julian
	Anastasov <ja@ssi.bg>, Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain
	<mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dccp@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<mptcp@lists.linux.dev>, <linux-hams@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <rds-devel@oss.oracle.com>,
	<linux-afs@lists.infradead.org>, <linux-sctp@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<tipc-discussion@lists.sourceforge.net>, <linux-x25@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<bridge@lists.linux.dev>, <lvs-devel@vger.kernel.org>
Subject: Re: [PATCH v4 1/8] net: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240429082219.3qev2nzftzp2gecc@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="qllvl7vwgf26ul7h"
Content-Disposition: inline
In-Reply-To: <20240426071944.206e9cff@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTfUxTdxTd773Xviez7lmM/IZdJgw2gooyXbiG+cE05i1Z1MQZyZLNsfFE
	pnzYAjqJsXyIQilUiQgdUpBRELAoYLGKDquDURCYqAMHmCKOCQyEUhgwYMLDzGT/nXvOuSfn
	/nEZUnqGcWaCQyN4eWjAQVexA2WsGW9cddt/9b41Vp0UzEofsFYliUAZn0DACdMMBcY8FQEz
	HT0ETJlOkmCz9ohAd6FcDFlN8RRM/aYSQ8v5bgIGYicpMFw/QcCzmi4ajOpiBMWx7RRU9oyJ
	QdUrg7irdgTdqV0ieKB/IYZxfRENT+xdFIynvAmZSXEENKhC4FpHNwXNxhQRaCze8Kiyg4CW
	61liaK6uF8EfZjUFmtw4Ep7l9ImgPU1PQfVNHYKu0kEC4nTDJMTZnpIwUVgrgkb1DAlaQxEJ
	rZpnCO6cvCWChtJYGkazfyHhpk5JQU3OUtAYLBSM1vcjONf/kIT7VW5gGZkhoLHcJgJblgek
	FVYQcCPxbxoqmr4Dy4SFgKdjPWKYad0EMQ1GerMf97jLTnIDjXWIyy6J5n5Q/kpxE+OeXMXF
	NoJT3e0lOZO2g+aM1e5cTlkk94/5Cs2VFSWKuZ8vXiI4k3U9p7lQjbjyH4/vdPnC4eNA/mBw
	FC9fvfFrh/3FnWY6/Dx7JD31NqlEdyVJaAGD2XW4syYDJSEHRsoWIlzaoRcJwwjCpwy/zw82
	hMfy2shXK9r8HkoQChAeSi4Qzwpzrvyr2wShHOGMitvUrECx7lhdmzSHxexK3NTfPpe0hHXD
	8eWZc0kkWyXFKaO3XiYxjCMbiE+nKWY9EnYzTriTQQt4Ma7L7J7LIdkjWJd/mZy1k+wyXDDN
	zNILWG8coy5FQlEXbM/rpAR8DFsqHhMCvrcQWyvdBLwV2+s1tIAdcW9txTyW4fq05LlqmE1D
	+KfpF7QwFCOsj7HPJ/ni+Afd8xt+WGe4KpothNlFuPWvxULPRfiM8Rwp0BJ8KkEquN/HxZ39
	lAa9p33tMu1rl2n/u0ygV+KcG8Pi/9ErsD63jxTwBmwwDFI5iC5CTnykIiSIV3wYyh/2UgSE
	KCJDg7y+DQspQy9ftX66duQaKugd8jIjgkFm5PZyuetycTNypkLDQnnXJZKyrBX7pJLAgO+P
	8vKwvfLIg7zCjJYxlKuTxD3wXV7KBgVE8Ad4PpyXv1IJZoGzkkh2qz3s6DfeWs9/lr4m2kfZ
	ppPFEjb/u6mno7b6GE2Jz4cb0ge0vdnHPbZ/807gAI0+8TIvL9gj67uQXLd1aLjPcWKHn2/e
	Qt9dZmLyUzY+2cU996iLhyloe3Zi01TMW6s+uh8mO2teYtvhqWaqsuVOvYf+nIzavW2wYTR9
	V/CVLzs9mmVL2zZFFNXa45Xeb29Z4TT48MU9H63njHRifUv3xlT/k1GTcYGWDYXamFzloyPW
	TdFZ/ik7R3VBqjfW7oTBdVM3nDTPt910DD/L7VGvPSbZ29B86atRX6ZxkCtanjA5YZc9ua9P
	KUvd7WBFCQdKHJI+4EZUW6aPfX5I7Gmq7C9xpRT7A7w9Sbki4F80KRtCJQUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTZxjG851z2lM0JWcF5hmSDBgmC2qlCPIyFdlfOy5OzYg63Rbt4ChO
	aFlLceA2KuUiZWg3tjkKykVBbiv3YhEcFgUpCjhRQMCFe+QiykWFAV2hW2ay/37f8z7Pkzdf
	8vJwQQnpyDsuCWdlEnGIK3cV0bzU+Hhj3SebjnqY7rqAUekDfTVqDihj4zGIM5gJ0F9KwsDc
	O4LBoiEBh+m+EQ5kZJdzIb01loDFjiQu3L8wiMHTmL8I0FXHYTDU0E+CPrkQQWFMDwFVIy+5
	kDTqBKrKWQSD5/o50J77jAtzuQUk/DnbT8Dc2dWQqlZhcCcpFK72DhLQpj/LAY1JBA+rejG4
	X53Ohba6Zg4MG5MJ0GSpcBjKHONAT0ouAXW1GQj6iycxUGVM4aCaHsBhPq+RAy3JZhy0ugIc
	OjVDCOoTrnPgTnEMCS8u3sahNkNJQEPmm6DRmQh40TyO4Pz4Axz+qHED04wZg5byaQ5Mp78L
	KXkVGFxLfEVCReuXYJo3YTDwcoQL5s4dcPqOnvR/n3nUP4szT1uaEHOx6BSTprxHMPNz7kxF
	fhfGJN0cxRmDtpdk9HXrmMwyBbNgLCWZsoJELnMr/zeMMfT5MprsOsSUX47e63JIuE0mVYSz
	zsFSefh2109F4CkU+YLQ08tXKNrs8/l7nt6um/y2BbEhxyNY2Sa/I8Lgn7LqybA06uupZ0aO
	Ehn5amTDoykvWpszQiyzgMpBtHribavuRJfOPOBY2Y5eeKjmqtEqi+c5oosaspH1UY7oKVUV
	vuwiqHV0cqN6pYlLbaBbx3tWdHvKjY4tTyWWAzhVI6Cbnlwnlwd2VBCdV/v9SoBP+dPx9b+S
	1tZBjO5aHPhn8AbdlDq4wjgVQXfGZ1pMPAuvpa8s8ZZlG0pEn04uRtZVXejZS48JK39LTy8O
	Iw2y077WpH2tSftfk1V2pzuXnmD/k9fTuVljuJW30zrdJJGJyAJkzyrkocdC5Z5CuThUrpAc
	EwZKQ8uQ5Vz0DXMVV1H+6HOhEWE8ZERulmR/SWEbciQkUgnras8vS19/VMAPEkdGsTLpYZki
	hJUbkbflG3/AHR0CpZbbk4QfFm3x8BZ5bfH18Pbdstl1DX9n2BmxgDomDmdPsGwYK/s3h/Fs
	HJWY35XdHUbZtcDL1Pn21s+Gq2dK825scF9j160oDCj9Zmtwe9oFp56A2P0LrxpSD/LEbpm1
	Dm7skfZu0e+5Hw0mEqsVIQej9QNYlEGlC5OaHXYuHvhwosL24in1SI2z76qxYMkj4mQt32df
	itLws/+NxElsIFoxaquZOLRW3Ol8L4DYf7Qq54Rc0LFL9EvkgeS9afuUH8xE/Zg/wDdtJT+W
	JwizPIvKc65v3BPtonLI31PZZOiObGlbyo8JmvWKVZsf7FqYsb09q9th6Kr87mbx3criNuOM
	fwNRX7V45quSg5NHvLTc3YeaztFXv2jz2WeM49x6J6tDLKyefPjWUMTYyWs+w66EPFgscsdl
	cvHfO0a9isMEAAA=
X-CMS-MailID: 20240429082224eucas1p19fe32106f867ab99be67ddd41f488c73
X-Msg-Generator: CA
X-RootMTR: 20240425225817eucas1p21d1f3bcedc248575285a74af88e66966
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240425225817eucas1p21d1f3bcedc248575285a74af88e66966
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
	<20240425-jag-sysctl_remset_net-v4-1-9e82f985777d@samsung.com>
	<CGME20240425225817eucas1p21d1f3bcedc248575285a74af88e66966@eucas1p2.samsung.com>
	<20240425155804.66f3bed5@kernel.org>
	<20240426065931.wyrzevlheburnf47@joelS2.panther.com>
	<20240426071944.206e9cff@kernel.org>

--qllvl7vwgf26ul7h
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 07:19:44AM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2024 08:59:31 +0200 Joel Granados wrote:
> > Sorry about this. I pulled the trigger way too early. This is already
> > fixed in my v4.
> > >       |                ^~~~~~~~~~
> > > --=20
> > > netdev FAQ tl;dr:
> > >  - designate your patch to a tree - [PATCH net] or [PATCH net-next]
I'll add "net" to my V6. I wont change the my base commit which is
v6.9-rc1.

> > >  - for fixes the Fixes: tag is required, regardless of the tree
There are no actual fixes to mainline commits. So I shouldn't add the
"Fixes" tag on any of these.

> > >  - don't post large series (> 15 patches), break them up
This series is 8 patches, so I'm well bellow the 15 cap value.

> > >  - don't repost your patches within one 24h period
That means that my V5 came around 80 minutes to soon. I'll keep these in
mind for next time.

>=20
> I guess you didn't bother reading the tl;dr I put in here.. SMH.
I completely missed it as I thought that it was just another quirky
signature to be ignored:). I put my comments and questions inline.

--=20

Joel Granados

--qllvl7vwgf26ul7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYvWLoACgkQupfNUreW
QU/6gQv5AVi70PGzBT0pFhWY9REMqt5qZvq+7EBoozprbzToN6FXuguZD9euYdn/
uMeQqJJkGrEO3bLpcWBLVe50fNv9wYvjDVy/0Ldupako05iFTjXz2hu6v6Nz7XYC
O2xoRB1TGEb8NEKrD7UbQlDWh2Anf/2kzJLiJfOnZg8MHqbgKVyfNfGohYiXduLF
iQ2qgHRsJxO79ky1mbqnKHSBaYbpMeneINOz6Pn34aNO5jyILk0lay0yNq1N9iBa
LoKKHqC2GD43Je8g8MyjeRAbyjV9CefbCjcLodSMb+XtOWjcIt2DkBsSwH5cuPNV
+hHXdZsdguYypQoI0QwZb/EVxaIiE7qpPr//1AOwN7hU/Ip1oKlqIBcefzEnxzn8
tVlPUDQdlM2PgRVTi8ULG+vcEOKFN0S5m5IkLhnT9HZp8qvlXkrohLSaj81fi7fF
6fl/dtbpHrfq2Rgts/N1MdssaHn1Auo7MmWK7M21Wj9ZgPwbcs0s/lptEX4HI0Z8
IRXj+fT4
=jm4U
-----END PGP SIGNATURE-----

--qllvl7vwgf26ul7h--

