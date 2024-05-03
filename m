Return-Path: <linux-sctp+bounces-152-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284278BAC2A
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 14:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966B71F2357E
	for <lists+linux-sctp@lfdr.de>; Fri,  3 May 2024 12:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FA6153505;
	Fri,  3 May 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SnHYkXy9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A653E15250F;
	Fri,  3 May 2024 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714738703; cv=none; b=gxbRx7jc6cOuyMPVQXA6FyMPZNV8ZhNyPbuJ44d2lg0JAHIS4Ny17bexsPWqEHOXZGjcX8gB2mr2uxkSH4OqIsMJtszHO+ywrAdshUlsY2U9xpE7e5OaLTxf4WkjAxmcyGIl9pSyZmgWEWHstMfAcD0Y1TDd0rSDgFDXPDGQ0AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714738703; c=relaxed/simple;
	bh=cmfWgaMxH5BtPG4dJB0UOwo/OvdXctu1yPlA65z+kA4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=Z+ozj8Dc+achOiadzGi1SWVeKJsW8+ieNCwzQFs5Ln6WdkeMimRtHwLGIawFfPnaMrVH7IJvz3JqvvDHsOm3EoeotrRmFHQd3ldjdjOo+9rEKgJ/WGe59yVXPfk8b4lZDinpFpqC0g+OBib+udlJcRKgDrEueNLywmZAELN2Nx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SnHYkXy9; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240503121817euoutp010d8f19ada1356105b585983a5f997487~L_cKeLkWV2142121421euoutp013;
	Fri,  3 May 2024 12:18:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240503121817euoutp010d8f19ada1356105b585983a5f997487~L_cKeLkWV2142121421euoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714738697;
	bh=A0TItHvFiI4MXmTIwizFYD6SMF5HgKQq2bcMIGrti/E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SnHYkXy9QCQLcSKi+H4Er9z6MY+UIedvCXoFfxd1I1l2BN6wVdvq4Ri12qG82w6oY
	 TTjvJgHLtCkSj2LnPvwlkVmfHLnGz9DV+SLNw0B6ZenUtqRzNOfhKXeU9S1bnrD+0q
	 vDHuQmAAcd7cfcf5H7JbFNE6iF1o1L8MfE5KKWGM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240503121817eucas1p2a3694d62da04be733e781d39787620e2~L_cKGE_G63266732667eucas1p2_;
	Fri,  3 May 2024 12:18:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 1E.C0.09620.806D4366; Fri,  3
	May 2024 13:18:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240503121816eucas1p17004cad2ee2fb60c0b57a92b31323faa~L_cJhM7Xv2763827638eucas1p1h;
	Fri,  3 May 2024 12:18:16 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240503121816eusmtrp2f31ca9bd529296dd75e3afb86dd45aa6~L_cJeAHy32311023110eusmtrp2p;
	Fri,  3 May 2024 12:18:16 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-93-6634d608b296
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.35.08810.806D4366; Fri,  3
	May 2024 13:18:16 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240503121815eusmtip227e52315081afef166d7d4df1e380a96~L_cJH1Vv50271902719eusmtip2E;
	Fri,  3 May 2024 12:18:15 +0000 (GMT)
Received: from localhost (106.210.248.112) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 3 May 2024 13:18:15 +0100
Date: Fri, 3 May 2024 14:18:11 +0200
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
Subject: Re: [PATCH net-next v6 8/8] ax.25: x.25: Remove the now superfluous
 sentinel elements from ctl_table array
Message-ID: <20240503121811.fsmriwsgugzm2o7i@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="a6ejzfnlx7y2ity4"
Content-Disposition: inline
In-Reply-To: <ZjJAikcdWzzaIr1s@hog>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTa0xTZxj2O+e0PTBLTgvTTzBDUBeGijBNeBfdZMuMR4OZi8uSOYNDOYCT
	e2Xq5jaUm5aAnU0gVrDVbRWp1gG1WEBEJCjlptyKCBgLDIYIarkPZJaDm8n+Pd9zy/P++GhS
	qqRd6f1RB7m4qOAIT6EjZayabFhDt64P9dVe8YOKBH94XCoXQEJSCgHJplkKjL+mETDb2UfA
	jCmVBNvjPgGoLxQKIbshiYIZS5oQho7/TYG+OJmA3iqrCIzpOgS64x0UFPWNCyFtYCkkXhtF
	0HPKKoBm7TMhTGrzRPBo1ErBZMZbcEaeSEBtWiRc7+yh4J4xQwAKsx+0FnUS0FScLYR75TUC
	+LMinQLF+UQSejVPBNCh1FJQfkONwHp1mIBE9QsSEm3dJEzl3hFAffosCSp9Hgltil4Et1PL
	BFB79bgIxs7dJeGGOoGCKs0iUOjNFIzVDCLIGmwhwTwyS0B9oU0AtmwvaLOLylwDASUnJ0Rg
	aPgWzFNmArrH+4Qw27YJjtUaRdBtsZABAWy7dZRkh+qrEXvu8g/s2YT7FDs16c0aLj0g2LTK
	AZI1qTpFrLF8JaspiGenK/JFbEHeSSFrevwBq7hQjtjC335m+wvPoB0euxw3hnAR+7/j4tZ+
	9I1jeE3DUxST8fbh7EeFKAF1SeTIgcbMemxq1AvlyJGWMrkIJ2tsArsgZUYQHs6S8IIN4bET
	g+TrRKalhOSFiwhn6n6n/nVll1oQ/zAgPN2kEMkRTVPMClw14mJPC5nVuGGwY67JhfHCPanG
	uSaSeSbBE41ZQrvgzMTji09S50xiJgDX1Q4IeCzB1Wd6KDsmmcM4ZVwz108ybvjiS9pOOzDL
	cWvZoIhfuhxXFuXM4x+x2dBO8LhuIVbY9vL4U3zlWBfFY2c8cMcw71+KZ01qwr4NM0qEb758
	JuIfOoS1x0bnmzbgpOae+cTHuK7jMrIPwowTbnsq4Xc64dPGLJKnxfhEipR3v4t1XYOUAi1X
	vXGZ6o3LVP9dxtOrsabkhfB/9CqsPf+E5PGHWK8fpjRIlIcWc/GyyDBOti6KO+QjC46UxUeF
	+eyLjixAr/5qzcs7o9dR7sBznwpE0KgCrXgVtv6hu4dcqajoKM7TRbxKuS5UKg4JPvI9Fxe9
	Jy4+gpNVIDea8lwsXhnizkmZsOCD3AGOi+HiXqsE7eCaQBw1uFn2S/O+3N00kxuJN3uFTxuX
	+fd75Bc+Gvurmsj4etEi3+rIq+Ol3e5r5ZlU+mhHpW64R6xacnSkeWdgnfNX0t6nsf2bPbbs
	xptil3q27opR7PE9uGCDZOeS+1k5pwO6HgaxgSPXHH/ZWGLZ5zvk0L3tdrKn+pZX7Rpp6IBy
	U5m1aWjv4Xz1rfO5Qcuit86kKKFSG/2JB3nIqSUkSON2tqHS/ye5qrmx84H0RcrCsbwdETcl
	uq3vHR3pr+kyF5cX1DxnLpW5HtCLnaeDJmhH35n2jVve2Rkb84VTi/uSrYkTpqneyfdLkz7b
	vtLfOyew9Iih3f3zBQ+Zbfjusu31zuHr5Z6ULDzYz5uMkwX/A+Apb7kmBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTe0xTdxTe797bBzqSWireoFlmccYhq5SXB1Tkjy1ekxlx/rO5BzZ6FQe0
	rA+cOrS2agWGq2AkIJMq8pCy8mhXrK+wzhQpFbqo0Bk6ofLYgIE8FAGho9ZlJvvvO993vu+c
	nOSwcW49K4R9QCynpWJRGp+5iGidb/7jA3ZH9L6Ivhk2WJXroedmDgOUJ05hcNLiJcBclouB
	1z2AwZxFg8NEzwADSi8bmVDSfoKAuc5cJoyoZgkwXD+JQZ/NwwJznh6BXtVFQOPAFBNyB1eA
	+udnCHp/8DDgQcVTJkxXVLPg8TMPAdNnFkNRjhoDR246XHP3EuA0n2GA1i6EjkY3BvevlzDB
	2dTKgH5rHgHaS2oc+nRDDOgqqCCg6VYpAk/tKAbq0nEc1BNPcJipamZAW54Xh2JDNQ4ubR+C
	XzW3GeCoVbHg+cW7ONwqVRJg0wWD1mAn4HnrMILC4Yc42Ce9GLQZJxgwUbIGXD6xoMqEwY3s
	FywwtX8N9hk7Bk+mBpjgdW2G4w4zC550duKJidQjzzOcGmlrQdTFmiPUBeVvBDUzHUaZrv6O
	Ubl3BnHKUuxmUeam9yhdg4J6aa1nUQ3V2UzK0hNHaS83Icp45Rj1p7EIJa3cJdgolSjk9Lsp
	Epl8E/9zIUQKhHEgiIyOEwij1n8ZHxnDX5ewcS+ddiCTlq5L2C1IqXdUMzK+X/rtkOEBoURd
	S3JQAJvkRJPnO2/gOWgRm8spR2S+tZDhF1aQ9ZMPX+Mg8mVHDtPfNIbIlnIPw1+YEGlWaRfs
	bDbBWUXaJnk+A5MTTrYPd+E+zOOsIXs15lcTcM7TJeTfBb2YTwjiKMjKIc2rpkBOInnPMfg6
	9AUi3c4zTL+whGwp6iV8GOdkklVNKuQbhnOWk5XzbB8dwAklO24Ps/ybhpJ3Gn98jbPIibl+
	pEVBxW8kFb+RVPxfkp8OI13zf2H/o9eSFZeGcD/eRBoMo4QOsaoRj1bI0veny4QCmShdphDv
	F+yRpDeghX8x26aN19DFwTGBFWFsZEWrFpyeOr0ThRBiiZjm8wLXFkTt4wbuFR06TEslyVJF
	Gi2zopiFK57FQ5bukSw8n1ieLIyNiBFGx8ZFxMTFRvGXBW7NOC3icvaL5HQqTWfQ0n99GDsg
	RIkdPPrdrXMJ+tj13fmLHnS1lAvbZw/Ik8pUY47HqL87a6VMw2si6IHPtkRGZdaowrPPb+fr
	An6qMWfezH7u5XbPms+Kjcuzdh+ZHx2v/Ei/LXRD4Tn9y/Z481XLV82J+JXJ1rtlB7PtcssW
	19wMLyEvWZrT//Qb6bgp3Fx+NPiRKHjXztptm9dc2BqBDx5P+uL9yNTNq5OPP4zlfVzYcPjD
	X44Gn7qz5fyy2tBDU9d77hWlusfP1dlWr9SNSTQpx0wJ92XUZa5nx+IR9c4NtqHTO0YNB038
	PufkMZfq07rmPaTnnZB4tuOTWeehjPy31G/biO32+FWdlEYjHMe7lWW9PS4dn5CliIRhuFQm
	+geeXN9SxAQAAA==
X-CMS-MailID: 20240503121816eucas1p17004cad2ee2fb60c0b57a92b31323faa
X-Msg-Generator: CA
X-RootMTR: 20240501131616eucas1p28a33eeb55f6c084a0751e5b7b7d91d78
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240501131616eucas1p28a33eeb55f6c084a0751e5b7b7d91d78
References: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
	<20240501-jag-sysctl_remset_net-v6-8-370b702b6b4a@samsung.com>
	<CGME20240501131616eucas1p28a33eeb55f6c084a0751e5b7b7d91d78@eucas1p2.samsung.com>
	<ZjJAikcdWzzaIr1s@hog>

--a6ejzfnlx7y2ity4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 03:15:54PM +0200, Sabrina Dubroca wrote:
> 2024-05-01, 11:29:32 +0200, Joel Granados via B4 Relay wrote:
> > From: Joel Granados <j.granados@samsung.com>
> >=20
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which will
> > reduce the overall build time size of the kernel and run time memory
> > bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> >=20
> > Avoid a buffer overflow when traversing the ctl_table by ensuring that
> > AX25_MAX_VALUES is the same as the size of ax25_param_table. This is
> > done with a BUILD_BUG_ON where ax25_param_table is defined and a
> > CONFIG_AX25_DAMA_SLAVE guard in the unnamed enum definition as well as
> > in the ax25_dev_device_up and ax25_ds_set_timer functions.
>                                 ^^
> nit:                            not anymore ;)
> (but not worth a repost IMO)
>=20
>=20
> > diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> > index c4f8adbf8144..c50a58d9e368 100644
> > --- a/net/ax25/ax25_ds_timer.c
> > +++ b/net/ax25/ax25_ds_timer.c
> > @@ -55,6 +55,7 @@ void ax25_ds_set_timer(ax25_dev *ax25_dev)
> >  	ax25_dev->dama.slave_timeout =3D
> >  		msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
> >  	mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
> > +	return;
>=20
> nit: return not needed here since we're already at the bottom of the
> function, but probably not worth a repost of the series.
>=20
Thx. I will not repost, but I have changed them locally so they are
there in case a V7 is required.

Best
--=20

Joel Granados

--a6ejzfnlx7y2ity4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY01gIACgkQupfNUreW
QU9//gwAjwm2crD0MhJ7OyswQb0Bxm/HhmEwnomCQHNxXo2qKrIBpMOS3dpgmCeX
hOvysHMzkUBRGf7mQm0veqdHNb4ZdZfRelo1i3GHxmlWlIx8J2hcZTDG8TUz6hJv
poTVkndbEa6q2rBVNPhoLnxjqLcE3yOOGvZeJv75CklJ3V/rrrBSBpSQvgisz2Rc
2lH29Ih2Lh2n1V8beefQHxMV9dbvkeiyhEpZJOCLbapjSFF8YiWjHrTDsVj74zxw
f981wsUNdFhVv0tdfKDReFydDtXT0cUw5VpHeHTbpoK08KCDc4QFw0Gxr8ycxXXt
XUYdpIioVBoSGc3I1PWDUUDfZEBawE+LVoZryY+7kEz7PJuCaryhFfkXSaXC8l0y
ODfJAEMDUeKM+xGgXgaT0kK6kb2jltciYS9/JBw38uqw7d9jHR7AYD3QTKaa1atx
hguSiJrXappxRJZDX1VvmgV9lC1Y4cAgQQJJhXnI2/Ok88cvgDfPCECVwQiTxxrp
D7SGN60B
=MN3V
-----END PGP SIGNATURE-----

--a6ejzfnlx7y2ity4--

