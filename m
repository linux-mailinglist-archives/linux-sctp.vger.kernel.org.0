Return-Path: <linux-sctp+bounces-103-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F048B30F3
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 08:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E191F24236
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 06:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4DF13BC18;
	Fri, 26 Apr 2024 06:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o3gAAC4D"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9913BADA;
	Fri, 26 Apr 2024 06:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714114782; cv=none; b=CKtCHCWXFDvR1ZE5ActtLoe0cbfXwL2s1+Fgxed+h5oLaLH2FyZ+M4yaK4B3InBFyLqrLkUmNsJw/HTARJGwwOWNYtqduAnT0x7RzTBWMWqEY/N9BYZkUQQVw9K5dLU3vr/e36RGNyD/mKUHAOoiCR8l0SkiRVS45EBUeIqAwHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714114782; c=relaxed/simple;
	bh=VegRhdx8vhbP1fdPNReSsBiQd6jF0kNOXjrPgTBgW2g=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=mvkJ82DunPAxXJWQMEVQzI6kTK9nEE1z0kPO7eQdP/lOzRV9YAS3/WRnrXy4TEapc8R65cEEqx8M3ZGHvRaFG7y3uyVrspaEQQs3lp9sB5Ju3Kad12OvAs98cAyucCLdtpuucrqil6c0bL41g+7XxKg297N986QBvToxZcCYsng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=o3gAAC4D; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240426065937euoutp027cea4fdb8852804e5cac02c0bf0ab966~Jwk8Ih6jH1312713127euoutp02C;
	Fri, 26 Apr 2024 06:59:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240426065937euoutp027cea4fdb8852804e5cac02c0bf0ab966~Jwk8Ih6jH1312713127euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714114777;
	bh=RAahLIMOGiGmOJ9Ik/GbtwXwXyGGxOO3w+fnlrkOweI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=o3gAAC4DRR19i8p+CY7Jaz+Qo7PWP06ureHe9d/TcZriAHZ2f3aAxLOXB8qIqAjmJ
	 c0zR+f5CxaDOMhWQSuyRA1I6WXwTVGjbpwksc0S34zwT5P9PHBqZAExdEPB+VC3oYY
	 1EA1odNQZ9TB3mOjACaztmiuamJXVODpZ1+3kfMI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240426065937eucas1p17e6e14a8fa83a831e1f46436d35ff764~Jwk74nzHJ2936429364eucas1p1F;
	Fri, 26 Apr 2024 06:59:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 19.CD.09620.9D05B266; Fri, 26
	Apr 2024 07:59:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240426065936eucas1p2971394a913727d431786adef9db8e9b4~Jwk7TFZ3o0634906349eucas1p2L;
	Fri, 26 Apr 2024 06:59:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240426065936eusmtrp2aa3306842099a9b2cba9d4fa0c84649c~Jwk7RY8kS1910019100eusmtrp2Y;
	Fri, 26 Apr 2024 06:59:36 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-9d-662b50d95d99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 51.F1.08810.8D05B266; Fri, 26
	Apr 2024 07:59:36 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240426065936eusmtip1d5ad5eb9c96b466fadc134bb0b11d2c7~Jwk63eBOi1002010020eusmtip1x;
	Fri, 26 Apr 2024 06:59:36 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 26 Apr 2024 07:59:35 +0100
Date: Fri, 26 Apr 2024 08:59:31 +0200
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
Message-ID: <20240426065931.wyrzevlheburnf47@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="6aeoqlr4wnxytbye"
Content-Disposition: inline
In-Reply-To: <20240425155804.66f3bed5@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUxTVxjGc+69vS2wbpdi9FiMmwwM6gbicL4wNyUac7OvaMzG3KLCxlWZ
	ULWFKTNmlVL5/tiQCFgoCEMELAq1CgJiN0QKQxzoUPmQApIBCoLlGzq6Ytz+e97n/T3nnOeP
	IyBF8QKxIFASwkkl/kFOtC2luzXZ+O6D7Wv2rY1SikEv3wBdFTE8kEecIkBZZqZAlxNLgLm9
	j4DZskgSRrv6eKA+V0qD6k4EBbN/xdLQnNFDwLPwaQo05UoCem8Z+aCLL0RQGN5GwdW+cRpi
	+5eB4ooJQU+ikQctecM0TOYV8KHTZKRgMsEO0mIUBDTEBsO19h4KmnQJPEgyeMD9q+0ENJer
	aGiqrufBE308BUnZChJ6swZ40JacR0F1pRqBsXiIAIV6hATFaDcJU/m1PGiMN5OQrikgoTWp
	F8FvkVU8aCgO58NY5m0SKtVyCm5lLYYkjYGCsfpBBGcG75HwZ4UzGF6YCWgsHeXBqMoVkvO1
	BFyPnuCD9s73YJgyENA93keDuXUTnGzQ8Tf7sA+NJpJ91liH2Myi4+xZ+V2KnZpczWovPCDY
	2N/7SbYsvZ3P6qpd2KySUHZGf5nPlhRE02zNhYsEW9blxSadq0Zsae5P21d8bbsxgAsK/IGT
	un/kZ3sgLTwRHb7ncKyozE6O4pgYZCPAjCd+PNBCxyBbgYjJR1ido0fW4QXC2TUqZKFEzCjC
	fcYTLxMzF1MWEucRTslrXkjMQ7MZfTzrUIpwR93j+UEgoBgXnN2DLWmaeQffGWwjLXoR44wj
	StMoC08yFSKcMFZFW3gHJgD/nCyzSCGzGSvqfC24kLHHdWk9lMUmmWP4didtlY74/JzAQtgw
	HrgyNh5Zn7kCm3I6KKs+gQ3ah4TlIsz88Ro+3annWxdbsTL6+QLkgPtrtQv+MmwuUy8EkhG+
	MTfMtw6FCOedNBFW6gMc0dKzkPDBas2Vf+ti5nXc+tTeYpPz8hfdGdJqC3HUKZGVXokLOwap
	JPR2+n+apb9qlv6qmVWuwsXl7v9zLaevwXnZA6RVf4g1miEqC/EL0BIuVBa8n5O9J+GOusn8
	g2Whkv1u3x0KLkHzv7R+rtZ0DeX3P3fTI0KA9Mh5Pmy8VNiExJTkkIRzWiR88Nx1n0gY4B/2
	Iyc9tFcaGsTJ9MhRQDktEboEvMmJmP3+IdxBjjvMSV9uCYGNWE4UZHI3vi2/fHzE46zt0tkD
	ezdmbHF29UwNlyZ/Jlet21Cwm107POO4bUwQdrPG3XtnzeLGSzvMDlrv3vzJXPL0Q78rvUca
	PENy2h4dfEMlJIyVqdfsSGhTl4gucN6pGXteNER5rR/+fOtGpV+K21P33UcqPEf23U0cpG9s
	+lXsOFG1pzh65JHXVqlpR71Y/GVofOc3yr/X3VwVeF1jFzJrd3q6bknTel/bmQGf5UO7dnUr
	WhML475apWyc8Dn1yNvGw0Y1e3Svb9zFt3LHPwla6eXutlPR8CzMOfBJZPrSp7mRpdqK492a
	iY/vSg1jRSN17m3TEpncqXZL03L79+9TgydiPkVfOFGyA/4eq0mpzP8f5hGj+SAFAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfUxTZxTGfe+9vS2Qmivg9gaZU4KbQSkUCpw6P9jM4jXLEv1ny8ac6+AC
	TltMP4xDndWqYFmxzsEEERAdasGiFIE6IKw4GODAyUQ0LdMCMj4UHSKWFRhNt8xk//3Oc57n
	yZs3OQLS38wPEmxTqDmlQrYjhPal2mdaHOE9m1YkRx57sRJs2jh4UKfngfbQEQIOW2cpqD6b
	RcCsY5CAaWsGCeMPBnlQVGKhoaDzEAXTd7Jo6DrdT8Djg39RYL52mICBZicfqg1lCMoO2imo
	GZykIWs4GHRXJxD0H3Py4LfSJzS4Sk18+H3CSYEr2w/y9DoCbmTJodbRT8HN6mweGNvE0F3j
	IKDrWgENNxvbefDQZqDAeEZHwkDxCA/sJ0opaKwvQuCsGCNAV/QnCbrxPhKmLrTwoMMwS0K+
	2URCj3EAQVNGAw9uVBzkw/PCn0moL9JS0Fz8ChjNbRQ8bx9F8N3obRJu1YVC27NZAjos4zwY
	L1gOJy5UEfDD0Rd8qOr8Atqm2gjomxykYbZnHRy4Uc2Pf5u955wg2ccdrYgtLN/DntL+SrFT
	rjC26uJdgs26Pkyy1nwHn61uXMYWV2pYt+0Kn600HaXZny5eIljrAylrLGlErOXc/k1LPxat
	VqZp1NyS1DSVek1IghiiRGIpiKIkUpE4Om7LqqiYkIi1q5O4Hdt2ccqItZ+JUg1GC9rZFbD7
	uNNEa5Ge0SMfAWYk2H0ph/awP/M9wgbza149GF95dpvn5QDs7tbPeXznPE8R7m5o/2ewIJzz
	vJPQI4GAYpbhM/3YE6CZlbhz1E56OJAJxYcseZTHTzJ1/rh1qIHvWQQwSfhC/deUJytk4rGu
	9UNv5xEC5+QOEh6PkFmAW/P6KQ+TzC6cXTBFevwkswifnxF4ZB9GjOuzDMj70KV44mwv5eV9
	eHz6ITKigPyXmvJfasr/r8krv4ndhbf+L6/ApWdGSC+vwWbzGFWM+CYUyGlU8hS5SixSyeQq
	jSJFlJgmr0Rzx1Ld7LLUosLhpyIbIgTIhkLnks7LZTdREKVIU3AhgcK7T5cn+wuTZF+mc8q0
	rUrNDk5lQzFzn3icDFqYmDZ3eQr1VnFsZIxYEiuNjJHGRoe8Kty4M1Pmz6TI1Nx2jtvJKf/N
	EQKfIC0RGDE0KR27oj/3Vm+57l4NR4e+ozYFNp/O0/yYkv4w6f1d5UIL78CQ/Y95l32Pvksb
	rJ9e6k62x4c9+fZ8rzx7hDgvL07I/8S9vWeEZwgcl0j0AxUdQvdouu/96f1te+vnhysSDLLM
	3OvlPjZc94vPhug97o2PxvZJniy5HynZvDjDwZS899X6/fYoxrbujbM9cYZEv+MwbD3duW37
	3lMX4+pOzGzI1X4UHrdlc90Cag+qer3LtNxgzS1tOvWNy+IXn7pYj1yak58vmlcrDZ9pOllh
	T2/Ru5hNj2pykhcGO8Kp9eq+erYkM3vJ7rKrnCxnfvkqq47ovxMd1Gxq+GA6eTKEUqXKxGGk
	UiX7G1ARo/DBBAAA
X-CMS-MailID: 20240426065936eucas1p2971394a913727d431786adef9db8e9b4
X-Msg-Generator: CA
X-RootMTR: 20240425225817eucas1p21d1f3bcedc248575285a74af88e66966
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240425225817eucas1p21d1f3bcedc248575285a74af88e66966
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
	<20240425-jag-sysctl_remset_net-v4-1-9e82f985777d@samsung.com>
	<CGME20240425225817eucas1p21d1f3bcedc248575285a74af88e66966@eucas1p2.samsung.com>
	<20240425155804.66f3bed5@kernel.org>

--6aeoqlr4wnxytbye
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 03:58:04PM -0700, Jakub Kicinski wrote:
> On Thu, 25 Apr 2024 14:02:59 +0200 Joel Granados via B4 Relay wrote:
> > -	for (i =3D 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
> > +	for (i =3D 0; i < tabel_size; i++)
> >  		table[i].data =3D (char *)net + (uintptr_t)table[i].data;
> > =20
> >  	net->mpls.ctl =3D register_net_sysctl_sz(net, "net/mpls", table,
> > -					       ARRAY_SIZE(mpls_table));
> > +					       tabel_size);
>=20
> ../net/mpls/af_mpls.c: In function =E2=80=98mpls_net_init=E2=80=99:
> ../net/mpls/af_mpls.c:2676:25: error: =E2=80=98tabel_size=E2=80=99 undecl=
ared (first use in this function); did you mean =E2=80=98table_size=E2=80=
=99?
>  2676 |         for (i =3D 0; i < tabel_size; i++)
>       |                         ^~~~~~~~~~
>       |                         table_size
> ../net/mpls/af_mpls.c:2676:25: note: each undeclared identifier is report=
ed only once for each function it appears in
> ../net/mpls/af_mpls.c:2660:16: warning: unused variable =E2=80=98table_si=
ze=E2=80=99 [-Wunused-variable]
>  2660 |         size_t table_size =3D ARRAY_SIZE(mpls_table);
Sorry about this. I pulled the trigger way too early. This is already
fixed in my v4.
>       |                ^~~~~~~~~~
> --=20
> netdev FAQ tl;dr:
>  - designate your patch to a tree - [PATCH net] or [PATCH net-next]
>  - for fixes the Fixes: tag is required, regardless of the tree
>  - don't post large series (> 15 patches), break them up
>  - don't repost your patches within one 24h period
>=20
> pw-bot: cr

--=20

Joel Granados

--6aeoqlr4wnxytbye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYrUNMACgkQupfNUreW
QU8Lzgv/TJmurVNSgO2iDBVQ8bKTLVZCDWpkqOISTJcAhPeC7GVAN0DUGnndUsYY
VWlk378kGRgh4o4vkVoT+vDFGcLfekyBZ7A7+1Hch+Ej8pBi3ehx+O6lrTIvfSLP
WLzkYqO7D1w7m8im/Bxj5D3i3d1oGVY4SYptq2ZFMzwecJMwEVxKTd12FPvaKDWj
3dIO/lGPDyMckpa1NNjioclQH/3bjchV7EN9vMgX9tq031kCW6IHzijIecYxoxC1
03w84MltO003waD5EsSw7/V14Db62XqxmYwMXzIv4MLe0prEc7s18scPpP9nJOpF
1oHVmtXm/iz9O1E6r+cuiGGZTNMF8NOF7XfmgosExm43utnVXCzjouGOn5FbFd8O
hZ6YkOLlQaNXi6B8TveTe0PKN8h0TzKporAIjD6vuKpaSRrM2i74Mo7870R6STD5
niiT2phZNFuC2ezKpGVCgY67f87SnHLmu1uXbDdoI7aVATzEWUNwDp6V7DHP0vB5
+KgDXCQs
=+u1k
-----END PGP SIGNATURE-----

--6aeoqlr4wnxytbye--

