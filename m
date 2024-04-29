Return-Path: <linux-sctp+bounces-127-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E9A8B5507
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 12:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED5B2B20B21
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445D3A1D3;
	Mon, 29 Apr 2024 10:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RSpw6nIp"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA92D05D;
	Mon, 29 Apr 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385997; cv=none; b=e8eECQiLmtMkPlXxeJn/Y2V2l63ZXnga3MVhatyNNLurhHFuxQyZgpNGBtS1ATWmrJxSqNX97CrlVWbSejC8ynPwcwA0AvrzpMCBBR270g2tRcwb4aMuuvcgBD+Z7XS1itTN2B6Kc/mqtMP45CFuHu66l86iHp6LcgYfZBi5ukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385997; c=relaxed/simple;
	bh=+xuPfbXvhD2U4XcHwIfiRxmnbADxy6SiZ2zq4uWs7iw=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=eHcMeS37GRliDblLAeiJJbB8AFvnXMaZoE+BGY/ponNxZvkYTbELiTFwEEdYlAWZjmUbSGZOVoXduDbIXLBbh/5PvR22YR+5ITf40Vdry2bkmzZa+QTyePFQxFiMf6pbwb6stPQi9r3STqXVBzmMMGn3HkPLxcI46Q2nimc+noc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RSpw6nIp; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240429101946euoutp02bcba7df2dd482b14951a0e09fb36b1f1~KuPive-7J3135131351euoutp02A;
	Mon, 29 Apr 2024 10:19:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240429101946euoutp02bcba7df2dd482b14951a0e09fb36b1f1~KuPive-7J3135131351euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714385986;
	bh=IsX0/OYWENCn2AKVFXUYtEljPBkMSVXjMzGVqGRtqqY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=RSpw6nIps+sB50xXUP2hQnx6gtzdn+JgtCcQ4OlLWC6ZzJSQMDtlsdSqdimIxS1sj
	 qutuFkfucSGuffUxWbbS2RUljuWojvrqprbWBHZqfjwUNfs+tBW2GMMy75pHczIH6E
	 YGSTVsEeFqLVJowZ9tsPLPtdu8TXdkhRatlSQ1qo=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240429101946eucas1p16e7be4f597183714ed35d847022021d5~KuPiaF5TY2266622666eucas1p14;
	Mon, 29 Apr 2024 10:19:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 3D.CC.09620.1447F266; Mon, 29
	Apr 2024 11:19:45 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240429101945eucas1p2dc8fc97bb946c330b71475078348f67e~KuPhxHl0R2151621516eucas1p2Y;
	Mon, 29 Apr 2024 10:19:45 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240429101945eusmtrp1d65903bf5cdc9f7d12521f49410530aa~KuPhvnvd_1698316983eusmtrp1C;
	Mon, 29 Apr 2024 10:19:45 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-9e-662f7441cf35
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.2A.08810.1447F266; Mon, 29
	Apr 2024 11:19:45 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240429101944eusmtip1f78b789847ce17b03a0ec2e1131a8947~KuPhaVhcL0051600516eusmtip1G;
	Mon, 29 Apr 2024 10:19:44 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 29 Apr 2024 11:19:44 +0100
Date: Mon, 29 Apr 2024 12:05:48 +0200
From: Joel Granados <j.granados@samsung.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David Ahern" <dsahern@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Remi Denis-Courmont
	<courmisch@gmail.com>, "Allison Henderson" <allison.henderson@oracle.com>,
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
	"Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>, Xin Long
	<lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher
	<jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu
	<tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>, Trond
	Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker
	<anna@kernel.org>, "Chuck Lever" <chuck.lever@oracle.com>, Jeff Layton
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
Subject: Re: [PATCH v5 8/8] ax.25: x.25: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240429100548.cl4b3wx7lww3yejl@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="io5uz7byzuh34bpr"
Content-Disposition: inline
In-Reply-To: <ZiyxJFnJimaRr9nK@hog>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTW1ATdxTG57+7yQZq6IKM/geY4WJpqXeUTg+jtmB92Ic+SG2t40xLGV3B
	CgETwFsdIyBKkIuCUJBC8BKQtGAhRhApDFqJAYlUKqhEhiRAJ3KxYlCuKWGxdaZvv/N955tz
	zsMRkW55Ig/RXkk8J5VERPsJnSntnQnDqtD4NXvWtt0KhGb5x9B3UyEAeUoqASfq7BRoL6YT
	YDcOEjBTd5KEsb5BAZRcqBFCkSGFgpmudCGMJE1RUHnjBAH9d0w0aDPUCNRJPRRcH3wlhHSr
	FyRfsyGwZJkE0Kl6LoQJVQUNvTYTBROZ70CBIpmAtvQYqDVaKLivzRRAtj4QHl43EvDgRpEQ
	7je1CmCgOYOC7NJkEvqVzwTQk6OioKmhBIGpapSA5JIXJCSPmUmYLG8RQHuGnYTCygoSurP7
	Edw6+ZsA2qqSaBgv1pHQUCKn4I5yCWRX6ikYbx1CkD/0Jwn6l3YC2mvGBDBWFADdDjOnXENA
	fdprGjSG70E/qSfA/GpQCPbuT+F4m5YGc1cXGRLCPjbZSHak/S5ii38+wp6Xd1Ds5MRyVnPl
	EcGm37aSbF2hkWa1Tf6ssjqBnW7+lWarK9KEbF1fMJt9oQmxNZeOsX/VFKCtvjudN+7movcm
	ctI1n3znHDVuaRDGKV0P3lPqKDmacFEgJxFmgrBi2k4rkLPIjSlHWGEsFvDFS4RfXL6G+GIM
	4aSOXOJNpMVgXDDKEL46bqL/7RrOG1lwahAuyjHSjgjF+ONaXSPpYCGzEhuGeubZnQnAlpNa
	0hEgmUlXPFzRMR9YzETj81kD801iJgQXT+XQPLviuwUWysEkcxBfHUiZmyaaY09cNityyE7M
	MpxbbllY1RfbLj6leD6K9ZrHhGMWZn5fhO/1Wmne2IJnFQrE82JsbdEs6F64Nec0xQdyEG6c
	fU7zhRph1XHbwogNOKXTspAIxe1/lAkcG2HGBXcPu/KLuuCz2nySl8X4VKob3/0+Vj8dorLR
	ssK3Tit867TC/07j5ZVYWf9C+D95BVaVPiN53oQrK0cpJaIr0FIuQRYTycnWS7gDq2URMbIE
	SeTqXbEx1WjuXVtnW2y1qNz69+pmRIhQM3pvLmy6qr6PPChJrITzcxdXF63Y4ybeHXHoMCeN
	DZcmRHOyZuQpovyWiv13e3NuTGREPLeP4+I46RuXEDl5yIn9QdrPRr3Wr3I6vMN7w87t8cSj
	d6vq8kO/cN51kM4XSnP3Hvpp25MTpcd+CPas3X/I92jLN+PyFVGJZvWR0P5QH5lTbFka1EeX
	+Ozymx7evm7pwNONQZ7rnC433hZ7+ffbwrjTU57sw/yJA30Bm1blXVuSeripdio5VhxwJtD7
	cqa5f1BlP64p8H4dHiyJa7mSunb/h0A9P9c+mWqQmAd6t0QrHwSHzf6ytdrAMhkqn9LEjX26
	7lONnZulIQrjPd0Z69m4iq4hfflMlibMfBO+bMvzCKiP+ZZJKN5csK37SZ3k7NcffZB0rsN9
	Z7hufMeI177Pe6cv0Xm+txb9qAuxqqe/SvSjZFERgctJqSziH4ZCIl4pBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeUyTdxjH83uPtkjqyuXeIFkEMTGwFcrlU4MMw+bemSxbzBLMzIJVXg6F
	wtpCECerICBlIBtuC7UUhMk4HHKtUDaQoXIURgG5xqHh7AaoQ45a5BjQLTPZf5/f9/l+v3ny
	Sx4Obl3JtueEi2WMRCyKcGLtIjo2WsfeOipzC3EvmbGAZvkhGP9FQYL8SgoGydpNAjSF6Rhs
	jhkwWNem4rA4biAhr6CaBSr9FQLWB9NZ8DTxJQHl9ckYTLdMsEGTUYagLHGUgFqDkQXpsw6Q
	9NMygqlrEyT0Ff3FAlNRKRseL08QYMq0hBxFEgad6ZFQNzZFQLcmk4QsnQAGascweFivYkF3
	UwcJM80ZBGTdTMJhOn+OhNHsIgKaGvIQTNx5hkFS3nMckhYncVgtbiWhK2MTB2V5KQ5DWdMI
	7qU2ktB5J5ENK+o2HBry5AS05O+BrHIdASsd8wi+m+/HQbe0iUFX9SIJi6qDMLQ9zC6uweDn
	tBdsqNGfA92qDoNJo4EFm0Nvw+VODRsmBwdxf396eGIZp592tSNaffsifUPeQ9CrJhe6puR3
	jE6/P4vTWuUYm9Y0HaDzq2LoteZKNl1VmsaiteNCOqugCdHV339B/1Gdgz5y/ITvK4mKkTH7
	wqKksiNOpwTgwRcIge/hJeQLPA99etjD28nNzzeYiQiPZSRufqf5YQ+S34lWW8VlD9/C5ci4
	W4EsOBTPi2rVjyEF2sWx5t1CVMlvd0nzwIGqXOr/h22otQEFy2xaQJSipQYzP6oRtawrwLZd
	BO8AVdd2F99mFu9NSj8/usO2vIPUVKoG3w7gvFUr6n5/xU7AhhdB3bg2s2Pi8vwp9ctstrn1
	BaJ6Bs2tXJ4V1Z4zRWwzzoulklYebgU4W7yX+mGDsy1b8PZT14unMPOqjtRy4SPCzJeoxfUZ
	lIVslK80KV9pUv7XZJZdqKGNP7H/ya5U0c053MxHqPLyZ0Q+YpciWyZGGhkaKRXwpaJIaYw4
	lH82KrIKbd2LpsVUXYfUswv8ZoRxUDNy3kpOVJR1I3tCHCVmnGy5VSrXEGtusOhCPCOJCpLE
	RDDSZuS99Y1f4fZ2Z6O2jk8sCxL4uHsLvHyE7t5CH0+n17nvR18VWfNCRTLmPMNEM5J/cxjH
	wl6OFWsLY0fiTqWwWICXxB4zwKP37pXujQlYsPITuno65/f2ug3rCz7GvlZmksd/NLkOeF8m
	jSEfNqrP1IYf9m+Q8h0TngR2xrs7I1W3nU/vzH61xNU1PoG9wNYnB27mvnbSLvez8+K1grYl
	B8vF9qoKndbZK04bQozsvriuTFuTWNakNHExvbzlVwvT0a6y49mi8H192LfBdZdkEQqi5bHf
	yLsn92hz3niwn1GIj8mnwnLnCpefp9ZVfR6Q4BsXaeiz1DeeoFT1tSYHF4egD+ieuavG1dKN
	6TPT38QauYN2gW7r8bdLiKLo/j6bEwEFqi91F2baG58YzvWTVrGnU4ROhDRMJHDBJVLR3zvr
	51XEBAAA
X-CMS-MailID: 20240429101945eucas1p2dc8fc97bb946c330b71475078348f67e
X-Msg-Generator: CA
X-RootMTR: 20240427081456eucas1p2618580c2e3463ebed3192108249d505c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240427081456eucas1p2618580c2e3463ebed3192108249d505c
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
	<20240426-jag-sysctl_remset_net-v5-8-e3b12f6111a6@samsung.com>
	<CGME20240427081456eucas1p2618580c2e3463ebed3192108249d505c@eucas1p2.samsung.com>
	<ZiyxJFnJimaRr9nK@hog>

--io5uz7byzuh34bpr
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 10:14:36AM +0200, Sabrina Dubroca wrote:
> 2024-04-26, 12:47:00 +0200, Joel Granados via B4 Relay wrote:
> > diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> > index c4f8adbf8144..8f385d2a7628 100644
> > --- a/net/ax25/ax25_ds_timer.c
> > +++ b/net/ax25/ax25_ds_timer.c
> > @@ -49,12 +49,16 @@ void ax25_ds_del_timer(ax25_dev *ax25_dev)
> > =20
> >  void ax25_ds_set_timer(ax25_dev *ax25_dev)
> >  {
> > +#ifdef CONFIG_AX25_DAMA_SLAVE
>=20
> Is this really needed? Looks like this file is only compiled when this
> config is set:
>=20
> grep ax25_ds_timer net/ax25/Makefile
> ax25-$(CONFIG_AX25_DAMA_SLAVE) +=3D ax25_ds_in.o ax25_ds_subr.o ax25_ds_t=
imer.o
Good point. I had missed this detail when addressing
https://lore.kernel.org/oe-kbuild-all/202404040301.qzKmVQGB-lkp@intel.com/.
Thx for pointing it out. I'll remove the guards for V6.

Best

>=20
>=20
> >  	if (ax25_dev =3D=3D NULL)		/* paranoia */
> >  		return;
> > =20
> >  	ax25_dev->dama.slave_timeout =3D
> >  		msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
> >  	mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
> > +#else
> > +	return;
> > +#endif
> >  }
>=20
> --=20
> Sabrina
>=20

--=20

Joel Granados

--io5uz7byzuh34bpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYvcPsACgkQupfNUreW
QU8kOgv/Szgz25tSMOfSIaZpyg2Cpnxp4UcX7u5vIz6oeGkD9oVszd+E6XY5iMw8
4K2SSlMe0P4Z0OJhzl/kXrvweAvKKkVhqA/OQcSUb2XTaqiEQU1tcnif+JrqK4jB
DkpPeP5wF8bLnYIoQxlyn44qkEnZCTVU5xX3eVB8Gt8Pc/JlV5M4H4gG+O62C277
WeGuBsSUqBiRPpowjmv9a7q0NMnubQpbGsL8XDoTLhDd6ymzGtwI3QcTTS9WcYY7
wDs7+59o3pCZ5+WBkyXvTGoWibP6WKzIpoXh1RPpey74uIu3wsxpJ8nYyaXy1Tp/
A5TscEgHgU/V5pg9xfTeEWD9Cokep+yYumVvL8LiqtDNH1g7dNGtyf1QuCkKAtH3
Q652w5aEB+gyyqv7uDlWVeK2BzM9WfhksxVeDTZAXxi5MPkQFnsxqzXs0ONL4k+R
6w1r+BCxo+5TS2iyTapH9PGhkgK6WY2Fv747fpiSfDiJILXrTBD8qWI0woE2dPWI
WZbNe4bq
=lZ5V
-----END PGP SIGNATURE-----

--io5uz7byzuh34bpr--

