Return-Path: <linux-sctp+bounces-153-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2DA8BAC40
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 14:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F862284A98
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 12:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C306153514;
	Fri,  3 May 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ud0EBoUo"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82F01534E0;
	Fri,  3 May 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738856; cv=none; b=gWzIZABzJ9KSJTe/RZ9Ed2Q81EQ5BnQSqvxCtPjrtOvPwo8qSg+WD9ZbEa0T5NuAVLPiyG3Xx9Je/Pgbp/dsKJnkHkc/HHAIkWOI8cc3aBaLDiGeH85HV5/pTp2jlK3kOXvasPv37m81iFji/6qHAWeIifcERwKt3ssBDA/SkM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738856; c=relaxed/simple;
	bh=P7877xZS/qK/eu7Hxv52EGfjidIH8eaSu2XZpRUTzxw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=WcEPVH44TtXJjpJQGsTQPRLyoD1urn1AP3r55Q+jgdJWEk8gvNlOrfp/d9hvxPvms+7XeZdIvRWFkciKuf5YYwocrlNSL1AM/8CdLBi+tdCfswz010g9R4em/kG3upnHf0SD1tGtGKFFNQZloWhCSerqHpajfnrILAgLXDvXmtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ud0EBoUo; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240503122052euoutp018aa1cadee93a8762b730f610728c56dd~L_eamMYz_2575925759euoutp01f;
	Fri,  3 May 2024 12:20:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240503122052euoutp018aa1cadee93a8762b730f610728c56dd~L_eamMYz_2575925759euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714738852;
	bh=ChYO52Frll/2V8tZSIFPH+OWfVA2NCG99nH5WnSQdXg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ud0EBoUoR4NJHxdSghj3wxw8M8Zkmtmoqkq4NocvVq1/4CDqFd7Bu9YhPQlyfPvCp
	 /6Q8s1WntYWJlAw+hmB0P+vdkkmwEgH+UzHHQd+Xn4IMBufUId7NhzlmGmbqBLsbou
	 9IrA+FyVZB9DXzWJPxYKTDnFWaK2pU20Lyioqkig=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240503122051eucas1p18b42d803afd8b128cb8338c16eef2a04~L_eaRBiKY1522615226eucas1p1j;
	Fri,  3 May 2024 12:20:51 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 16.41.09620.3A6D4366; Fri,  3
	May 2024 13:20:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240503122051eucas1p26a8c48d017423c18f71a50192e3cf575~L_eZkNLLv0643506435eucas1p2D;
	Fri,  3 May 2024 12:20:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240503122051eusmtrp1d051d1d384af0db40fe13aada94983c7~L_eZg37ea1344913449eusmtrp1G;
	Fri,  3 May 2024 12:20:51 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-5e-6634d6a39f25
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F3.95.08810.2A6D4366; Fri,  3
	May 2024 13:20:50 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240503122050eusmtip246a6d4bd6c605848b5b0d3e45e86ec21~L_eZKMzI20319103191eusmtip2Z;
	Fri,  3 May 2024 12:20:50 +0000 (GMT)
Received: from localhost (106.210.248.112) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 3 May 2024 13:20:49 +0100
Date: Fri, 3 May 2024 14:20:45 +0200
From: Joel Granados <j.granados@samsung.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	David Ahern <dsahern@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Remi Denis-Courmont
	<courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>,
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
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
Subject: Re: [PATCH net-next v6 0/8] sysctl: Remove sentinel elements from
 networking
Message-ID: <20240503122045.6uvwnijtem3sbcl5@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="5cnssdcq4of6gbri"
Content-Disposition: inline
In-Reply-To: <ZjJCANEjFK890VCA@hog>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1CUVRjGPd9l94Na/VwxjoipoA2jZJFar0WI5Yyfo39YM2WTzSTGB15g
	cXYlKbMQEJQNRDYFls1F0JVYZk2BlcUw2pTFhbjJVSDl5hIXIZcVwQu5fFjO9N/vfZ73Oed9
	z8xhSOkJxoPZJdvHy2VBYV4iV8pYPl79ak7TqpDX24a8wRz9FnT+kkhDdFw8AYdNkxQYc5QE
	THbYCHhsSiDB3mmjQZtdIAJNTRwFj5uVIrgb85ACQ8lhAnrLu8RgTNIj0Me0U3DJNiYCZb8n
	xBY5EPQc66KhQTcignFdnhhuObooGE9+ATISYwmoUoZDcUcPBbXGZBpSrH7QdKmDgBslGhHU
	llXScMecREHK6VgSerMGaGhX6SgoK9Ui6Do/TECs9h4JsfZuEiZyLTRUJ02SoDbkkdCS0ovg
	94QrNFSdjxHD/VMVJJRqoykoz3oJUgxWCu5XDiJIG2wkwTo6SUB1gZ0Gu8YHWpymKreQgMtH
	H4ihsGY3WCesBHSP2UQw2bIWDlUZxdDd3EwGBnI3uxwkd7f6OuJO5R/gMqPrKG5ifBlX+FMr
	wSmv9pOcSd0h5oxlS7msi5HcI/MFMXcx76iIM3Wu4VKyyxBXcOY7rq8gA21Z/KmrfzAftutL
	Xv5awHbXnem2RHLvSWlU3J0SOho1zkpELgxmV+Ge42MoEbkyUjYX4b8a1KTTkLKjCN879rZg
	2BE+kpdNPEt0FhWLBOMcwkd/OE7/2+UoPT1dFCJ8rS516iyKXYJbB86KnCxifXHNYPuU7sb6
	4J4EI+kMkOzIbPygPm2qaQ67Faem9dNOlrCBOP9GMxJ4Nr6e0UM5mWSj8JXW++JExDzl+fjc
	E8Ypu7DeWFWRQwqjeuOrl34UC3wQWwtvEs67MPvHi/hk62MkGOtxfmkfJfAc3G8pnA544krV
	95QQUCH865MRsVDoEdYdcky/xjs4rqFnOrEO912vnJoIszNxy9BsYdCZONWYRgqyBB+Jlwrd
	r2D9n4NUCvJWP7ea+rnV1P+tJsi+OOvyPdH/5OVYd3qAFPhdbDAMU1lInIfc+UhFeCivWCnj
	969QBIUrImWhK76ICL+Inv7WyicWRzHK7f97hRkRDDKjJU/DXT/ra5EHJYuQ8V5ukuWqlSFS
	SXDQV1/z8ojP5ZFhvMKM5jOUl7tkafBCXsqGBu3j9/D8Xl7+zCUYF49o4ojl2w3b99jbiNGA
	zms7ihYcOJiU+7FfSIT/xr5hdWUrag7cbNbZH23zYNebDq5O3lS6RjailM/4ZEHu4s0zVBcy
	CUf3nt0NOkWwKr0tVrGrXTlra3xFusa40kWiYhb51rtlr121ofoC3n97oHGTxNP2/ofLNR8l
	NLUUnx0L8LHQc9fd3hjXV5enn1kVzm7O8F8GD3Yrkx9a6nbUOIIvL1yoXVDw2zclhO2Dwz7M
	vJA3NLcOqLaFKUcPZXq/5zlQe8ZwTjuvufHNepO+IIcxybec8PGJGnIvT/2sxX2oyb/T9+X0
	tvj8zPVu2oAI66LsPsPW1RrzRnZYZhkqksydcWL45HkvSrEzyG8ZKVcE/QO9braWKAUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTVxzHc+697S0ubBXQnWCTacVI6qgUAX/gA0ymuZpscZuZZEZZoxWZ
	tiUt4MSpHbSiEBDoJhGFIigWMCgPCwhMrAZ5WVg6aHFUpYAd0ImI6HACo3aLS/bf55zv43dy
	kh+H9LpO+3JiZfEShUx8iM9eQHXM3nsYUNQbvD+w3BwERtVaGGhMY4FKfZIATf0cBYbidALm
	bA4CZupTSZgccLBAV1TNhgtdagpmLOlseJr8FwUVNzUEDLfYaTBklCMoT+6noNbxig3pozxI
	uTGFYOiMnQW/ljxjw3RJGQ2PpuwUTGe+B+fSUgjoTJdCnW2Igm5DJguy2kXQW2sjwHzzAhu6
	mztY8MSYQUHWxRQShgvHWNCvLaGguUmHwH5tnIAU3XMSUiYHSXitv8cCU8YcCXkVZSRYs4YR
	3En9mQWd15JpeFnQSkKTTkVBS+FiyKpop+BlhxNBrrOHhPYXcwSYqidZMHnBH6wuUauvIaDh
	9J801HR9C+2v2wkYfOVgw5w1An7oNNAwaLGQkZHMA/sUyTw1tSGm4OpR5rzqF4p5PS1gakr7
	CCb97ijJ1OfZaMbQvIIprEpg3hgraaaq7DSbqR8IY7KKmhFTfekE83v1ObR92dfC9Qp5Qrxk
	6QG5Mn4Df5cIgoSiMBAGBYcJRWvW7g4PCuGv3rh+n+RQbKJEsXrjN8ID6uwrZNyPXt+NFzuQ
	Cpk/SEMeHMwNxgM36thpaAHHi3sZYb3WQrgFHq580cNyszd+05v2j2kC4dLGesJ9qEG4/8wg
	crkorh/uG7vMdjGb+zHucvaTLvbh+uOhVAPpCpDcZwvxH9qhtyO8uTtxTu7o2xGe3Eh81WxB
	7tZahB/UNhNuYSFuOzdEpSHOfDoRN51MdOMSfGWW43J4cJdjbWsx6X7pcny3Np928zE8OfME
	ZSHvvP8U5b0ryntX5HKQXAG2zo4Q/7tehUsujpFu3oArKsapQkSXIR9JglIaI1WKhEqxVJkg
	ixHulUur0Py6GFqmq+tQweiE0IgIDjIiv/mk/Xp5N/KlZHKZhO/juUq7Zr+X5z7xkSSJQh6t
	SDgkURpRyPwnZpO+i/bK53dPFh8tCg0MEQWHhgWGhIWu4X/ouTXulNiLGyOOlxyUSOIkin9z
	BMfDV0XcWZIjDv+I91WO88wn0Q1f3io+HBs8kLy9M7LRtnvTMGeXOtt3aGeCaXPSqZ9GVrRq
	dmD06dJlJyacfpbF0okMnUWTaGuk802GiMJtm+NCNZk8r4rnx3UrcwPC15vyHYu++Oy3dcIR
	jxh94MFA8ZP7ld+v29qTf2t50NnpTKkUddvU1Z+Pb4kS7uEd2aJ/TtUuiTgeZd6mF+c+YsSH
	H7fe9tl2vjfa5/FRTbFArRFYo3HSngj6lPf9yuJNppyaKIo+PrVsccq+AFncrOLqzMLZqnsP
	eTtSzbKbt5PaOsiWxC1vTpY6tdld7wcU+aCSE9yqoxus/taVfQ22S+FnDccEdWY+pTwgFglI
	hVL8N7I8wO/DBAAA
X-CMS-MailID: 20240503122051eucas1p26a8c48d017423c18f71a50192e3cf575
X-Msg-Generator: CA
X-RootMTR: 20240501132233eucas1p16e1fc882424c452216dfe4941a85b00b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240501132233eucas1p16e1fc882424c452216dfe4941a85b00b
References: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
	<CGME20240501132233eucas1p16e1fc882424c452216dfe4941a85b00b@eucas1p1.samsung.com>
	<ZjJCANEjFK890VCA@hog>

--5cnssdcq4of6gbri
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 03:22:08PM +0200, Sabrina Dubroca wrote:
> 2024-05-01, 11:29:24 +0200, Joel Granados via B4 Relay wrote:
> > From: Joel Granados <j.granados@samsung.com>
> >=20
=2E..
> > Changes in v6:
> > - Rebased onto net-next/main.
> > - Besides re-running my cocci scripts, I ran a new find script [9].
> >   Found 0 hits in net/
> > - Moved "i" variable declaraction out of for() in sysctl_core_net_init
> > - Removed forgotten sentinel in mpls_table
> > - Removed CONFIG_AX25_DAMA_SLAVE guard from net/ax25/ax25_ds_timer.c. It
> >   is not needed because that file is compiled only when
> >   CONFIG_AX25_DAMA_SLAVE is set.
> > - When traversing smc_table, stop on ARRAY_SIZE instead of ARRAY_SIZE-1.
> > - Link to v5: https://lore.kernel.org/r/20240426-jag-sysctl_remset_net-=
v5-0-e3b12f6111a6@samsung.com
>=20
> I pointed out a few tiny details in the ax25 patch but either way, the
> series looks good to me. Thanks!
>=20
> Series:
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Thx

>=20
> Note that you could have kept the ack/reviewed-by on patch 4 since it
> was not modified. Jeff and Chuck, your reviews got lost in the repost.
Indeed. I have been having issues with my b4. Have posted this
https://lore.kernel.org/tools/20240503120506.p7g5nn6jocrrdlck@joelS2.panthe=
r.com/
which explains my situation.

Best

--=20

Joel Granados

--5cnssdcq4of6gbri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY01p0ACgkQupfNUreW
QU9SCgv/VIk7NMd2yQ3hulxzejcxW6S/b6dZ6K7ic5J57PU2QFBvRetZIyFq2N9t
GG5SeYL41RHHYdbPTRJTtiSl7xwehiCwd/zuPIk0GleGqx4uAQl7BSPrwtNy8yrc
7bQk43ybLjOf1Px4fNQZe1mzJmf4arJ3e5+Nf0MR12j8S8h0cM3P6wa9VoyCRUEp
x9bcnu5Ba4RE7n+Cuk3ryQeDXDD6ep7tWYIsC9uLv8lE3KonJe7AWVI1eBwAa4N+
dfKYd85qjpPELXO5OwQRBWtSZqSHv/Hhh8UNN/Pfvi/VX3U0xmqoLekZ83fyuo0y
AvWuimfR/w/UkBbXj36NRInZCVecxeG/XNsICbqZa5/MiyLbW+lTKmLvhHnFwfnA
NvH244sKwdmgRzlHJ2lBByULIDLFx/TtLVbNzlrQEFNQ0NOOmLTuW0SSJCZsJdtl
aD41vkxQC+DHwCoSFNkbSKCNev6L4Z706NSOWNEXUutCxPLJVzzXPKtuIgZSv4EO
asOIUoAd
=ghZc
-----END PGP SIGNATURE-----

--5cnssdcq4of6gbri--

