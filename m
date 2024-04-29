Return-Path: <linux-sctp+bounces-128-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D288B5898
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 14:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94101C22C1A
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A14C2D0;
	Mon, 29 Apr 2024 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="H2pTpbEr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC9BA39;
	Mon, 29 Apr 2024 12:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394015; cv=none; b=URUMgUeyTZtznTGis+V9YHVyKLyHx74QMmS7VS/lvfDLvH6hAAWA6V+Kck2Q1Dcd2wjZ1SlP5qIrmgy1midn9YhFzXw8wQk4MKgWORyFz+WpGoAzUPKndqtjK5x3VOxLQodTHm1wdzubyaC9ihhXFpE5W+tMUyiW+CkPf49uK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394015; c=relaxed/simple;
	bh=juNXwS6wpR2PLZyRNDfo3bupSrh+PpTDROC5eoTaw/s=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=BUyxJRBtcrcI4c+ELtSVtplTK0sZ6o1fF01VUgy21YNZHl7ICc241+aoZ6atYI86ryTs2OriQdC+sjf46+2uJy0u9b6vWJUkqnFYaoRvH8lBXRjvth9txdRGkWub6XOQFtsUt+jLnLmYHbip6ozoKqE/pLq1tqvuXAzqJLVr+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=H2pTpbEr; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240429123328euoutp027dae7183246557533cf373cc91f3f9cd~KwESQATfh1884318843euoutp02a;
	Mon, 29 Apr 2024 12:33:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240429123328euoutp027dae7183246557533cf373cc91f3f9cd~KwESQATfh1884318843euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714394008;
	bh=AXDDcGD/4AFto+e5em02vH0HOEDFIlA5Qzecd5Gcqmw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=H2pTpbErZdurhm0+nZD10LcsEFYFjg0KjfhFvs9FMhQcLMNFf7iXtsJlmd/ydcG+M
	 e4eIN0sv0QGH/C0dxwlakkuTPMZz32un1MUsmYnX3niiIlieMZWP1MHcTS22Cr/ym9
	 8xwzHDtt79HQ+thVjRvX2M01KeENipy/iBam3HUs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240429123328eucas1p15b2d49351c4814e2cf3c2380e70d8fab~KwER2kArF2234922349eucas1p1T;
	Mon, 29 Apr 2024 12:33:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id BC.00.09875.8939F266; Mon, 29
	Apr 2024 13:33:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240429123327eucas1p2d9b70e1b269ea0a0b4e873483863ff6e~KwERPo7OT2290822908eucas1p2m;
	Mon, 29 Apr 2024 12:33:27 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240429123327eusmtrp2bc0d95d65b274af5b4443f433ed52312~KwEROGjIO1148711487eusmtrp22;
	Mon, 29 Apr 2024 12:33:27 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-83-662f9398ce12
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 33.EC.09010.7939F266; Mon, 29
	Apr 2024 13:33:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240429123327eusmtip162ef757df91b13a466d3bd516b82d5c0~KwEQ5Qr320978609786eusmtip1r;
	Mon, 29 Apr 2024 12:33:27 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 29 Apr 2024 13:33:26 +0100
Date: Mon, 29 Apr 2024 14:33:15 +0200
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
Subject: Re: [PATCH v5 1/8] net: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240429123315.og27yehofzz6cui3@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="mkjhnfepoqc4wfnh"
Content-Disposition: inline
In-Reply-To: <Zi9gG82_OKnLlFI2@hog>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeVDUZRjHfX/X/iA3FwR5By0TpJAItDyevKKmmX42E0qTY4czucaPI2Gh
	XUk6HFeWQxawBZRjuVZxuAcUcLmyaCvA5ZQ8AEFjhTAk14AFIWVjWcpm+u/zPM/3+7zP88y8
	LGmfzDqzwZLDvFQiDnFhbClt00zHSxmp3gHrx1PsQSffAoPfKmmQR8cSEFNnpkCbn0CAeWCE
	gMd1cSRMDI7QkHe2ioHszmgKHt9IYOB+1F8UlNfHEDDcZBCANqkUQWlUPwU1I9MMJIyuAsVF
	E4Khbww0XC14wMBMQYkAbpsMFMycfAoylQoC2hJCoXZgiIIu7UkaVPoNcL1mgIBf6rMZ6Gps
	peE3XRIFqjMKEoY192joTy2goPFSHgJDhZEARd44CYqJOyTMFjXT0JFkJkFdXkJCj2oYwY9x
	39HQVhElgKncFhIu5ckpaNKsAFW5noKp1jEE6WPXSNBPmgnoqJqgYSLbHXosxdSiagIa4h8K
	oLrzU9DP6gm4Mz3CgLnnNTjephXAnRs3SB8frs9gIrn7HZcRl1v2FZclv0JxszMeXHVxL8El
	/DRKcnXqAQGnbXTjNJUR3CPdBQFXWRLPcHWDr3Kqs42Iqzp3jLtblYn2rPnQdrs/HxL8OS/1
	3nnANqhMfoIJn3aILJt4X47O2ymRDYtFG3FLcjxpYXtREcKxuQeUyHaeJxGOv1SIrMEEwo/6
	m+YDdsFRMhxmzRciXJzTTPwrSlV2LwZVCFdUN9CWvpTIDbdXGhfeYESeuHOsf4EdRO54KE5L
	Wgyk6IEdftidzlgKy0X+WNlURFhYKPLBvypaGCvb4cuZQ5RlDFIUieum9llxJS6cYy0KG5Er
	Tr97WmBdbQ025d+irHwU66v7FmbDovaluNlUT1sLb2JzT8aiaDkeba5eNK/C5rq8RUMqwt/P
	PRBYg1KEC46bCKtqG46+OrToeB1njnYu3uhp3PPHwoHJeUzRppPWtBCfiLW3qp/HpbfGKBVy
	Vf9nM/WTzdRPNlMv9PHEmoZx5n/pF3HBmXuklXfg8nIjpUGCEuTER8hCA3nZyxL+iJdMHCqL
	kAR6fRIWWonmf2rrXPNkLSoc/dNLhwgW6dDaebPhfGkXcqYkYRLexUEYlOwdYC/0F3/xJS8N
	+1gaEcLLdGglS7k4Cd38V/P2okDxYf4Qz4fz0n+qBGvjLCeidbJxx5UveJrr8bjNVJHyFcnW
	0TjNFnq2WGUeYOoDTj+TGeX73oF1S/M/yDKJ3RNdfMschhzf7Zg0HhbaLNt8sDfGWdo/mNUb
	ePH6Dk3NzW1pGXqnU23q3S2Rb4ca9jsSR7u1m/ggj+GNqCQ8vfs51mt9QEVUefOJtGPrvMMc
	riVns1krDgo2tzNH7AK7xzr9go/7+7qe+4yRzQ3npPnuTYsJYfev1nwU1udkTMz3+2G6t83f
	03D7wk25egk3slMRwO6IrZ3m/H7u2rTzUOQUsfcUmbA2bxlduMR3l3FPylZZxK7MxOvvbG/M
	cViS/Wxs7O637gpzv67d9/sb08YrS5VR7i6ULEi8wYOUysR/A5ne7BEkBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTdxTH97v3trdAYJeH7ook0yqLwVkoLw8bIJuJ3m267JH42Is1chU3
	2kJb2JgxKxSGlgB1ZHEgk4IbEzCVl8WCTtbNqoUBgjy2UJFShAEKjDfyGKVbZrL/Pr/vOd9z
	vvklh4d7VJLevOMSBSuTiOL4XGeicfmWZcfZXP+jAQtjW8Go3Al919QcUKZ9hUG6YYUA/YVM
	DFYsgxgsGTJwmOwb5EBhcTUXClrSCFjqyuTC49QnBOjq0jEYMFlJ0GeVIyhP7SGgdnCWC5nD
	PqC6Mo3AlmPlwL2ScS7Ml5SR0DttJWA+2wXy1CoMmjLFcNViI6BVn80BjVkInbUWDNrrCrjQ
	2tDIgYfGLAI0RSocBrQjHOjJLSGg4XohAuvlMQxUhX/hoJrsx2Hh4i0ONGet4JCvK8OhWzOA
	4JeMnzjQdDmVhJnzt3G4XqgkwKRdDxqdmYCZxlEEZ0c7cDBPrWDQXD3JgcmCbdBtL+ZerMGg
	/vQcCTUtn4B5wYxB/+wgF1a6d0FKk56E/q4uPCqK+cM6jTOPm+8g5vylE8w55V2CWZj3Y2pK
	f8eYzF+HccaQbyEZfYMvo61KZBaNlSRTVXaayxj6whhNcQNiqr//khmqzkNvbX5PEC6TJirY
	TbFSuSKC/74QAgXCMBAEBocJhEE7P3wpMITvHxkew8YdT2Jl/pEfC2JrG4ux+GmvzyusXYQS
	6dzViMejqWC6bECqRs48D+oHRN/8eQqpkdOq7kNXTnVwHOxJL3aquY6mCURXDOcQjkc1oovu
	FGL2LoLypX+rGsPtzKVepFtGe9bYi9pG2zL0uN2AU+Pu9KNc25rBk4qhq+/Pra1zpaLoB6rb
	/6yYQ3RG6SLpKLjTd/JshJ1xKonObf6aY8+NUxvpH5d5dtmJ2kKfHfqGdETdTE9fuE84+CQ9
	ufQQaZBn/lOT8p+alP/fJIfsR3cv/4n9T95OlxSN4A6OoHW6MUKLyDLkxSbKxcfE8kCBXCSW
	J0qOCY5IxVVo9V70pvmaq6h0eEJgRBgPGdHWVae1orwVeRMSqYTle7nGnvE/6uEaI0r+gpVJ
	o2WJcazciEJWv/EM7r3uiHT1+CSKaGFoQIgwODQsICQsNIj/nOtr8adEHtQxkYL9lGXjWdm/
	Pozn5K3E1lU8z9GG1h2SZbvxW/0PJCi0yZGzuxtfySn2kWxPV7b5tho8yEcfdQ6l6rdUoA80
	6evqr9dol03aZrfxppqEmwuLu3o3lLtH35ghTS2Ro322/Zp7IUji5m8OeqAyuDgHZTTlfLvx
	Tadr+5TlO84dCFZeam8rH/COnb8bbnrjlL49YItlQvzk9h6ZE7k7tetg2b6GF7I7UsSS0FDP
	5CyLtoT39glTWn1+SppLQ/yGw0F9OpPfq3OrEYMPvrO79HVlVYQiYlNPDH7F7IPWt0e//K47
	93BWpNPSXl5bskQ9kmmstT37zA3K7VoSfXJ/JUuOJ5gMnw18d6hjb1NvmvMk0cgn5LEioR8u
	k4v+BuqhOnzEBAAA
X-CMS-MailID: 20240429123327eucas1p2d9b70e1b269ea0a0b4e873483863ff6e
X-Msg-Generator: CA
X-RootMTR: 20240429085414eucas1p11b3790e4687b8dc8ef02fe0f54bc9c55
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240429085414eucas1p11b3790e4687b8dc8ef02fe0f54bc9c55
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
	<20240426-jag-sysctl_remset_net-v5-1-e3b12f6111a6@samsung.com>
	<CGME20240429085414eucas1p11b3790e4687b8dc8ef02fe0f54bc9c55@eucas1p1.samsung.com>
	<Zi9gG82_OKnLlFI2@hog>

--mkjhnfepoqc4wfnh
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 10:53:47AM +0200, Sabrina Dubroca wrote:
> 2024-04-26, 12:46:53 +0200, Joel Granados via B4 Relay wrote:
> > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > index 6973dda3abda..a84690b13bb9 100644
> > --- a/net/core/sysctl_net_core.c
> > +++ b/net/core/sysctl_net_core.c
> [...]
> > @@ -723,12 +722,11 @@ static __net_init int sysctl_core_net_init(struct=
 net *net)
> >  		if (tbl =3D=3D NULL)
> >  			goto err_dup;
> > =20
> > -		for (tmp =3D tbl; tmp->procname; tmp++)
> > -			tmp->data +=3D (char *)net - (char *)&init_net;
>=20
> Some coding style nits in case you re-post:
Thx. I will, so please scream if you see more issues.

>=20
> > +		for (int i =3D 0; i < table_size; ++i)
>=20
> move the declaration of int i out of the for (), it's almost never
> written this way (at least in networking)
done

>=20
> > +			(tbl + i)->data +=3D (char *)net - (char *)&init_net;
>=20
>                         tbl[i].data =3D ...
>=20
> is more in line with other similar functions in the rest of net/
done

>=20
>=20
> [...]
> > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > index 6dab883a08dd..ecc849678e7b 100644
> > --- a/net/mpls/af_mpls.c
> > +++ b/net/mpls/af_mpls.c
> [...]
> > @@ -2674,6 +2673,7 @@ static const struct ctl_table mpls_table[] =3D {
> > =20
> >  static int mpls_net_init(struct net *net)
> >  {
> > +	size_t table_size =3D ARRAY_SIZE(mpls_table);
>=20
> This table still has a {} as its final element. It should be gone too?
Now, how did that get away?  I'll run my coccinelle scripts once more to
make sure that I don't have more of these hiding in the shadows.

Thx for your feedback

Best

--=20

Joel Granados

--mkjhnfepoqc4wfnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYvk4cACgkQupfNUreW
QU9RsQv8C71HsQc8Vg7luamuUmm0Not2QdsN7GJDowWizIp5iePr8Jrm0Hq4Rz0n
gUg/1uGHm+xIjZ5Aujscvqcy3CrS9vDrlHJfX+2BB5e5ZGOWBfxMJbTSjy4clUvh
kDrWEb8qKRjg6nnHgON0LMHY3lRPd5CPiDYaBu+9ZGgglD+QgFQRXTjLkRKUXACR
n7HsKeK2xWtWThEejoLQD69q+8yP6qeY2dIWUkQYAVcqRKeGO2UCfnTZxvPkRRbN
vNHyUo8XgVs+ZKRMhRBRfkGGNgAslX7kCyLdjhKpSclplQGj8N0MnVXQOiqzSliM
+RcpLFb/Wt11cE1Ww9/ujfJH5rlc5tYUnrR0VKN04J5lbyXE46nSGfOlw75dbabe
8tHH4PNWE3hDroaoscF1+uTc6G4Lkz+1DcUPtjbxdvYS4xv8klh7mtRNqLQhzOYb
yZ/3PmqjHaFZoxIjag3UtJWBjmG7n1p7E+WDd7Yu2bESLTvifEZ6zDWYBrEuHdJ9
mxZGDMB8
=LvuX
-----END PGP SIGNATURE-----

--mkjhnfepoqc4wfnh--

