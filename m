Return-Path: <linux-sctp+bounces-126-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 662AA8B54F9
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E0F1F223E7
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C34A36AF3;
	Mon, 29 Apr 2024 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dBl3C2bA"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427D72C85F;
	Mon, 29 Apr 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385996; cv=none; b=YtxuI29P7OBEyOQp7Tqg5P2qStsM9d5nE5HH6Md+5eupuu8+/Olm5ULAJs94zgCi4ga9EqVYUb8JNlm6mkwNZGbyJLHRLRjYzP8ItqpZ87mHjGi7pi2sx4Av4jKWTBObteQQyq4ErgE/W6liKcaCoSB1/D54zUzR+4JB5J6/KYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385996; c=relaxed/simple;
	bh=X9ck40ZTSI+kf1mVi+Se7yCLCw9737QuqI9rEevVPUs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=ljWxrZpI0YNjRMleI4sCoD4Dm+wppOLMFKhdVU/9A7AyAHh7Q9CCfyYWTPzFjXKy5BShKm2dLD3WSrSq91CWCwZUNJn1P0/WiKjiIkhIAbnaYWuPwpwx9BxdR4t7/NdkbTwI6AmL4e1NxaVHzOdBOb4k5NV+PtC9r1Jj2ISyhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dBl3C2bA; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240429101945euoutp02002e682ba16b4b496889457f10b26668~KuPiBnHy13169831698euoutp02m;
	Mon, 29 Apr 2024 10:19:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240429101945euoutp02002e682ba16b4b496889457f10b26668~KuPiBnHy13169831698euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714385985;
	bh=zr0XwXdxmnacF/KSXQrVKckrNkkyaMgJG065ePEyTo8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=dBl3C2bA1yzE2odXdAtnrQhs0QprYhleJf5sFkJIKcT46akLpMPsCXx3J3h2pmWSp
	 Wv5IICaieNNTw9R0G34tbqbg1i9XougxrinI1nuRcxA7+245Q7xHLXE5KCrqsz3UrU
	 x7vIjmPbvG8mhgWjbogK7nHsObHlxSmN942so0hg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240429101945eucas1p2d3ad865d3c4f1d7017d8b1e85c04518a~KuPhxy66u0372603726eucas1p2r;
	Mon, 29 Apr 2024 10:19:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id D8.A1.09875.1447F266; Mon, 29
	Apr 2024 11:19:45 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240429101944eucas1p14923dce6c3f3a7d34a5c11e0ae0fc2e7~KuPhMXQgS3267532675eucas1p1C;
	Mon, 29 Apr 2024 10:19:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240429101944eusmtrp283f2f2a30a6030efd8c3bd5c308216cf~KuPhK4gPC3196831968eusmtrp26;
	Mon, 29 Apr 2024 10:19:44 +0000 (GMT)
X-AuditID: cbfec7f4-11bff70000002693-ea-662f7441fe4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F9.F5.09010.0447F266; Mon, 29
	Apr 2024 11:19:44 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240429101944eusmtip1eb371740c999409b462afd14fa7f0578~KuPgz8l322330323303eusmtip1e;
	Mon, 29 Apr 2024 10:19:44 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 29 Apr 2024 11:19:37 +0100
Date: Mon, 29 Apr 2024 11:32:43 +0200
From: Joel Granados <j.granados@samsung.com>
To: Julian Anastasov <ja@ssi.bg>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
	<stefan@datenfreihafen.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"David Ahern" <dsahern@kernel.org>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Remi
	Denis-Courmont <courmisch@gmail.com>, Allison Henderson
	<allison.henderson@oracle.com>, David Howells <dhowells@redhat.com>, Marc
	Dionne <marc.dionne@auristor.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Wenjia Zhang
	<wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe"
	<alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
	<guwen@linux.alibaba.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, "Chuck
 Lever" <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil
	Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jon Maloy
	<jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Martin Schiller
	<ms@dev.tdt.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
	<kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman
	<horms@verge.net.au>, Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain
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
Subject: Re: [PATCH v5 6/8] netfilter: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240429093243.3luxenn3qffruyif@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="ism7n6dg7qigbra6"
Content-Disposition: inline
In-Reply-To: <d78c6353-99b9-41f8-0c54-19eb86e1fce3@ssi.bg>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1BUZRjG5zuXPQdymcPK6DcKI+AFvCTZpL2o2TrT5KmpmWaackozSQ6K
	3JQFJSxduSobAtKgELHLJUQINFhXARVcBXS5qUgQAeayutwEdFkVCDfhYDnTf8/3PM9v5nn/
	+FhSlsrOY/2Dw4TQYJ9Ad4k9pasda3p9Y5iX3xsdvXagV74N9y4m0KCMiSMgttxGgS5XRYCt
	y0zAZHk8CZZ7ZhrUOWUSyGyOoWCyTSWBoagJCkoqYgm4X2tkQJdYhKAoqpOC8+anElD1O0P0
	OSsCU5KRhjv5IxIYyy9k4K7VSMHYsdcgPSGagAZVEFzoMlFwU3eMhmTDKvj9fBcBLRWZErhZ
	XU/DA30iBcnZ0STc1wzQ0JmaT0H1JTUC45lhAqLVj0mItvSQMF5QR0NToo2EjJJCEtqT7yO4
	Gn+ZhoYzUQw8ybpOwiW1koJazRxILjFQ8KR+EMGJwVYSbl9cBIZRGwFNZRYaLJmekFqgJaDy
	6DMGtM27wTBuIKDnqVkCtvZ34XCDjoGetjZSLuc7jFaSH2q6gfisXw/wPylvUfz42DJee/oP
	gldd6yf58owuhtdVL+Y1peH83/rfGL608KiErzldTPDl97z55JxqxJflHfrE7Uv79b5CoP8+
	IdRrw3b7XYVtreSeApeI1JE+UolUOAHZsZh7CzdXpTMJyJ6VcQUIFx9JQ+JjFOEf48ZmEgvC
	5uE/qZfIOc0kLQanEG6xDhP/tiauXp1ByhDOfZjNTCEUtxj/PHhlGpdwK3DzYCeZgFjWiXPF
	lsrvpvokN+6Ic1Jr6Sl/NrcbT9zym6pLOTmOUaVQonbEN9JN05rkIvBQdqdkqk5y8/Gp5+yU
	bcetxaP1eRJxqBu25nbPjP4eG7Qd0zsxd2sWzrWYaDF4D/+gPEyKejbur9MyonbGtnL1DJCK
	cNXzEUZ8FCGcf9hKiK11OOaOaYbYiNtrtdOLMOeA2x86ikMd8HHdCVK0pfhInExsL8FF3YNU
	MlqY8cppGa+clvHfaaK9AmsqH//fXo7zswdIUb+DS0qGKQ1iCtFcIVwRtFNQvBks7F+p8AlS
	hAfvXLkjJKgUvfir9c/rRi+gU/2PVuoRwSI9WvQCNp4tuonmUcEhwYK7k7Q0c7mfTOrr822k
	EBrydWh4oKDQo/ks5T5Xuth3gSDjdvqECQGCsEcIfZkSrN08JaHdqpI/sy2tOLjmuqbPY710
	FGVYnsTX8e5eB524LfJfzjmnmM7La8KlZjrOIa2xIKpY4cqH+PWs1hz8qn7bvkn1g/cjif7t
	E4lLOq95HNAr59yNHdBaZ5Wsk474R/xV7O1yjXM49PEXG407GqPVa7dwnTE9txs895oNWxn3
	BZrNQ+3evUYPv+09G5QtkR+Zgpy+ceuuunKkude7tTa2b0VNUsC6Vdxexvvyfpea41V7eyNS
	hLABnafxZItra/bncQEfXvTqa5af7V7o4Z9g3aPfdOFK49rNA26b1nw6mRLPLjjpavL0y1ot
	Q0EV/o0fpPU9epZo+CxPJvgv3eZ5YjxpgL3tTil2+axaRoYqfP4BGd9KHSYFAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTZxjGcy49rTjcsVz8wnRCp8GhFopcXpg4xLCcJW5xyRYWzMQGD6CD
	lrXFTdFYKYrAkBJmxIpclFVoJyAgdwx2gAoEcHLTgUoBG5F4GSCClI7aLTPZf8/7e5/nyZcv
	eXkEv5TrwtsvUbAyiThWQNmRHYs3hzcHKzyjvE6Wu4JB6Q8jjWkcUCafxOFEnYWE6kvpOFiG
	TTiY61IImBoxcSD/YiUFud3JJJgH0il4lvSGhNL6EziMtxm5UJ2hx0CfNERCjWmWgvSJ1aC6
	NoPBWKaRA73aFxTMaXVceDhjJGHu9HI4l6bCoTM9DmqHx0joqT7NAXW7CPprhnG4W59LQU9z
	BwceGzJIUBeqCBgveMqBoWwtCc1N+RgYy57joMr/iwDV1CgB88U3OdCVYSFAU6ojYFA9jsHv
	Kdc50FmWxIVXebcIaMpXktBW4Azq0nYSXnVMYnB2so+APxrXQfu0BYeuyikOTOVugOziKhwa
	Ul9zoar7ALTPt+MwOmuiwDL4KRzvrObC6MAAERzM3DfOEMyzrtsYk/dbInNeeYdk5uc8mKqS
	eziT3jJBMHWaYS5T3byeKahIYBYMV7lMhS6VYlpLruBM3UgAo77YjDGVRcd2uYULt8qkCQrW
	NUYqVwQJdovAWygKAKG3T4BQtMX/u0BvX4Hntq372Nj9B1mZ57a9wpicn49T8do1PxXeauEq
	sVSUhi3jIdoHXSswc9IwOx6f/hVDrx5qcNtiNbo63cexaQe00J9G2UwvMdTfkPPPUImhoa5B
	wuoi6fXowuQN0qopehPqnhxa4jyeI+2KphqOWP0EPb8StZpLSCt3oA+gN3eirHZ7Ohglp2e9
	jfLpTBzV1K+18ZXo9rmxt5ygD6LznXWUNUrQH6DLizwrXkYHoumOIsr2Tjc0c+kBadNH0ZT5
	MabGHDTvNGneadL812TDHmhw8Qn+P7wRaQufEjYdhEpLn5MFGFeHObIJ8rjoOLm3UC6OkydI
	ooWR0rgKbOlYqtvmqmqxkomXQgOG8zADtm4paSzX92AupEQqYQWO9hW5G6P49vvEhw6zMmmE
	LCGWlRsw36U/zCJcnCKlS5cnUUSI/Lx8RT5+AV6+AX5bBKvsP48/JebT0WIF+z3LxrOyf3M4
	b5mLEv9yZ2AEa8qU7TCvcuqcjeQf3SPUhhs/DC8Kyh2tDFmZfVR0qHhPeeSjkO2FL9z6/DxQ
	/VdhCU9UXW7OfWcSDfVf8Pcqn8y+39rKDxpoXJHYFVgePOi78x4+3/SN6FvRe561oSvCdpc5
	v9bc/aGs8aMqk7q37OKReMuCe4g+TB+ekTyhjHOKrSia/njCP/KTMw92n1XN5NG+p9ruu4/t
	Uscf+/OR7tnlWf3IFZ+QsRz3zS5rwSlUvgst99f3rqncIckqlphP+Ry+UbjBfnvFQWFkyiZB
	WNJZbUxLINnW0xPWJG2q/yVzdvT6cyoiNHdQr+Ml/vjZG7uvyUum1Jf8/AuKYT0ISHmMWORB
	yOTivwEr8bPfwQQAAA==
X-CMS-MailID: 20240429101944eucas1p14923dce6c3f3a7d34a5c11e0ae0fc2e7
X-Msg-Generator: CA
X-RootMTR: 20240426121030eucas1p111f2e449982e47627d8efd9c9782990d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240426121030eucas1p111f2e449982e47627d8efd9c9782990d
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
	<20240426-jag-sysctl_remset_net-v5-6-e3b12f6111a6@samsung.com>
	<CGME20240426121030eucas1p111f2e449982e47627d8efd9c9782990d@eucas1p1.samsung.com>
	<d78c6353-99b9-41f8-0c54-19eb86e1fce3@ssi.bg>

--ism7n6dg7qigbra6
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 03:09:45PM +0300, Julian Anastasov wrote:
>=20
> 	Hello,
>=20
> On Fri, 26 Apr 2024, Joel Granados via B4 Relay wrote:
>=20
> > From: Joel Granados <j.granados@samsung.com>
> >=20
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which will
> > reduce the overall build time size of the kernel and run time memory
> > bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> >=20
> > * Remove sentinel elements from ctl_table structs
> > * Remove instances where an array element is zeroed out to make it look
> >   like a sentinel. This is not longer needed and is safe after commit
> >   c899710fe7f9 ("networking: Update to register_net_sysctl_sz") added
> >   the array size to the ctl_table registration
> > * Remove the need for having __NF_SYSCTL_CT_LAST_SYSCTL as the
> >   sysctl array size is now in NF_SYSCTL_CT_LAST_SYSCTL
> > * Remove extra element in ctl_table arrays declarations
> >=20
> > Acked-by: Kees Cook <keescook@chromium.org> # loadpin & yama
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  net/bridge/br_netfilter_hooks.c         | 1 -
> >  net/ipv6/netfilter/nf_conntrack_reasm.c | 1 -
> >  net/netfilter/ipvs/ip_vs_ctl.c          | 5 +----
> >  net/netfilter/ipvs/ip_vs_lblc.c         | 5 +----
> >  net/netfilter/ipvs/ip_vs_lblcr.c        | 5 +----
> >  net/netfilter/nf_conntrack_standalone.c | 6 +-----
> >  net/netfilter/nf_log.c                  | 3 +--
> >  7 files changed, 5 insertions(+), 21 deletions(-)
>=20
> ...
>=20
> > diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_=
ctl.c
> > index 143a341bbc0a..50b5dbe40eb8 100644
> > --- a/net/netfilter/ipvs/ip_vs_ctl.c
> > +++ b/net/netfilter/ipvs/ip_vs_ctl.c
>=20
> ...
>=20
> > @@ -4286,10 +4285,8 @@ static int __net_init ip_vs_control_net_init_sys=
ctl(struct netns_ipvs *ipvs)
> >  			return -ENOMEM;
> > =20
> >  		/* Don't export sysctls to unprivileged users */
> > -		if (net->user_ns !=3D &init_user_ns) {
> > -			tbl[0].procname =3D NULL;
> > +		if (net->user_ns !=3D &init_user_ns)
> >  			ctl_table_size =3D 0;
> > -		}
> >  	} else
> >  		tbl =3D vs_vars;
> >  	/* Initialize sysctl defaults */
>=20
> 	We are in process of changing this code (not in trees yet):
>=20
> https://marc.info/?t=3D171345219600002&r=3D1&w=3D2
>=20
> 	As I'm not sure which patch will win, the end result should
> be this single if-block/hunk to be removed.
Thx for the heads up. I have made a note of it in case this set ends up
being after yours.


>=20
> Regards
>=20
> --
> Julian Anastasov <ja@ssi.bg>
>=20

--=20

Joel Granados

--ism7n6dg7qigbra6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYvaToACgkQupfNUreW
QU+SSwv+L+03hxc8J2P/i5B1B0mUQVpmedwuNIg1F6QSEgnsIAQzagQUlBPPFYhC
9+gNBsEpUMPb2PVXyRXpd3QQm0XPgv43A38qO27lQYg1VPpf+zpzosrvz0lJaoo/
BesbgCri6d6bPmpgGfq4BuYWksB0jvU/Ci63m7Qz5wKcG5hM0G7jEHggHJkz8BWP
8i4SO8Fwb0pbbd7Hwqb1hUJd1uk+coHhyknMfIwmVFPPTN9C1COJFgFE9YiCT9zq
9L1d/uWcu0n9sB7MzW93vrPrMYZ1xeIvWrYwXI05Wr3FnTYXGhSpnZcMUN7rHorj
EQv06C97YKmL3HiTPcIxtxGxjG1v3U+RZZ49wxo56yiNPT/kECnkTFT+7GxJ+/4d
HkB8WMPpqP6PRbPNLJdm94ynbyi8N6+4fgscCSLRuAeiyVqNGXmvLsY3NZWJmpGl
UBeeGwtDSjq9oVM5y9hiKeBbljcUbPpBiHZIuZ0qvm/P02md5XTdbdRJEYjMpxjq
LcjGNoOh
=+2c9
-----END PGP SIGNATURE-----

--ism7n6dg7qigbra6--

