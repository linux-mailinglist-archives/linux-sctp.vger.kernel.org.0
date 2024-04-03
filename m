Return-Path: <linux-sctp+bounces-58-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA874899579
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Apr 2024 08:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 576061F2281C
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Apr 2024 06:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAED2421D;
	Fri,  5 Apr 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="itp/SGTi"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753451C290;
	Fri,  5 Apr 2024 06:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298949; cv=none; b=mXZHUc4W+ZJzrnjBl+pDQFNcwUC4vvsZ85qNTuBcxtp2XY7F6Zq8gQUZJ0sWDh7bxIhJBt2dCSDsRIAqb93H7gAmvZkqKZhaohImdyRY3KNK1EfRW49YjcWH2kyGM0PoklEKImq8agycUGDk97kfdHW6ct5299Ape/Op0OOkLH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298949; c=relaxed/simple;
	bh=ikYDLn4Ym4RSvRYw/MJO6iKHulOv0NjFGcOsdIQTkHk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=bAyeN+tyuKxnm8itVLwvFUvXyNxRNkHMViHQ3AJb9b6xuPwk8g5Rg6aImNm1Iaq+W5aSbo5JP9iXS5XtEpTyVDyfjQMm3rjH3KIOa5aiUBLoNVTnpAJPR5Gm+kyLIGA/PxYEyKn2vAD5eakn8J5zgildazYVGhoDpvVaHagdKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=itp/SGTi; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240405063543euoutp017caa354157006bc1f61d80529ba50133~DTtEjAQed1754517545euoutp01J;
	Fri,  5 Apr 2024 06:35:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240405063543euoutp017caa354157006bc1f61d80529ba50133~DTtEjAQed1754517545euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712298943;
	bh=N7Xk/dqXP1U7JVC+aqhzvUwaPlnQWGEnhGrG4RTCnYM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=itp/SGTi2KY3001kxEzNTe4JO1ixuRif/PHcEZopCR/ThlW+PCAwOppVIUIVs0r5g
	 ys+4wUrSRboZ6xjZit8bH2bHUTBfLp7CMo6eJx+GjsI4bw0ya31JItGz/bVMttt4ur
	 qxZQNdpPRMKMZ5NN9VH5cUark/R3Z1nPY3fy2l5U=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240405063543eucas1p250905f5211a05d8b253a15262f3744d4~DTtETUjcs1221112211eucas1p2k;
	Fri,  5 Apr 2024 06:35:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id A2.85.09552.EBB9F066; Fri,  5
	Apr 2024 07:35:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240405063542eucas1p190ab901f5f6faa28cff00f183b9749bb~DTtDsmHF20623506235eucas1p14;
	Fri,  5 Apr 2024 06:35:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240405063542eusmtrp1b0b10e8e5ca74e71f569e868d048abf1~DTtDp-qN62498024980eusmtrp1z;
	Fri,  5 Apr 2024 06:35:42 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-20-660f9bbe2cb8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 1C.B2.10702.EBB9F066; Fri,  5
	Apr 2024 07:35:42 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240405063542eusmtip16105856c5e39365274c85e3ba56c334c~DTtDTjI3S0803908039eusmtip1Q;
	Fri,  5 Apr 2024 06:35:42 +0000 (GMT)
Received: from localhost (106.210.248.50) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 5 Apr 2024 07:35:39 +0100
Date: Wed, 3 Apr 2024 11:16:25 +0200
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
Subject: Re: [PATCH v2 4/4] ax.25: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240403091625.lk35wt2iqkvabrmr@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="u37e6yueaf43q4xz"
Content-Disposition: inline
In-Reply-To: <20240328194934.42278-1-kuniyu@amazon.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTaVBTZxSG/e6WKzRyjVQ+xY6dVJ1CrftytBWV4nhHO1PHP7WOU0r1orYQ
	nESqtVtIAJHNjLjUgCaiYgDBliUIuCAqSFBABUQmKMTEjAiIRERQoMSrrTP995z3Pe/5zvnx
	saRsPzuR3arYLigVIWFyxoMyV/TXfnox1St01slbBJSrF0LbuXga1NGxBMQUD1NgPp5AwHCL
	k4DB4t0kuNqcNBjS8xlIq42mYPBOAgO3j9gJ6NK8pCC3JIYAR4VNAuakbATZGisFRc4+BhLa
	J4G2sBeBfa+NhvqMbgb6M7IkcL/XRkF/siccjtcScD0hHM622CmoMyfTkJGYw4DOMhsai1oI
	uF2SxkBdWTUND8uTKNAd05LgMD6mwZqSQUHZeQMC25knBGgNPSRoXQ9IGDBV0lCTNEyCPjeL
	hCadA8Hl3RdouH5GI4HnR6+RcN6gpqDCOB50uRYKnld3IDjU0UDCrXNTwPJsmICafBcNrrSP
	IcVUQEDpnhcSKKj9ASwDFgIe9DkZGG5auiyQN9XF03yzrZfku2qqEH/09C98qvomxQ/0+/MF
	mXcJPuFKO8kX61skvLlsKm/Mi+Rflf8t4fOy9jD81cwcgi9uW8Tr0svQGvl6j883CWFbfxKU
	MwO+89hiGpq/Teu7s8nsQGpUPz4ejWYxNw8fKb1BxSMPVsaZEO57cR+JxTOEUwsPvnFcCLf1
	9ZBvIyfimmjROIWw+sBB4t8u6/FLpFjkI2zUdBHuCMVNwXE5DsbNDDcd13ZYX4/y5vxwXG7i
	61Ekly/FVXvu0G5jHBeKX9xzIDdLuWW4u7CKEHksrjpsp9xMcjtxhT1zhNkR9sWnhli3PJpb
	iC8NXKPdMubkuC97lbj1b9hS0Px6UczdfA8ftl5FohGEHzbkESKPw+2VBRKRJ+HqlERKDKQg
	fHGoWyIW2QhnRPW+SXyGo+vtbxLLcacrihFfHoObOseKe47B+8yHSFGW4rhYmdg9DWff66B0
	6CP9O5fp37lM/99lojwdG0t7mP/Jn+CMY49JkZfg3NwnlBFJspCPEKkK3yyo5iqEHTNUIeGq
	SMXmGRsjwvPQyGetHqrsPYtM7U9nlCOCReVoykjY9ld2HZpIKSIUgtxbmrBMGiqTbgr5eZeg
	jAhWRoYJqnLky1JyH+nUTZMFGbc5ZLvwoyBsE5RvXYIdPVFNRC3Y0P9KYdixZE1hXBCxfsO6
	jd/f9Ww8HWj5lZo2O6D9+B1N1qhZw2mLdd2xG+XI2hqu7V/s50x66a1pHHsjtiE0jSJYZ+Xg
	ypLUWc2++8ty1nxh7vTSxduT596uNpz+M912IzjG7DDs3vcoOfPR01ZXoGpO/eX0tppxXyXL
	nIlFFas/xOscfeF/5Pub0+st3/iQZc+7e4i1yzuWXs6b11oXJHuYZYzxTg9YmRMZvHj1B8FR
	a2ey79f4eDUPms/P36XQr2IvqCJP+H494YzfhVq/Rb3OUUWe/p0rgrp6lLz+kH4Fe7F08hKv
	wme2A6ceTdA0R5cELFhwKTjg92+/nHNSNdd0RU6ptoTM9ieVqpB/APXZk9wnBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0yTZxSH936XtrA0fgLiK5pl6UoycFaLXE4nMOeC+VjM5pjRZWzTqh8g
	0mJacNPNpVIRBFEm6mZhgEwR6KiCUO6OVUFpDTDlJhMYCKLQiAhy6UQG1mUm++/J75znlzdv
	cgSkUxHfTbBLGcOplPIoEc+Rsjy/3rXiSvqCsFUpeS5g0vhBb3USDZpDhwmIr5ilwPhLMgGz
	XYMEzFQkkDDWO0hDVs5lHmQ0HaJgpj2ZB7d/7ifgUdzfFBgq4wkYqO/jgzFFj0Afd5eCssFJ
	HiQPLQNt6VME/cf7aGjJfcyD6dwCPvQ87aNg+tjrcCZJS8DNZAWUd/VT0Gw8RkPu0UIepJql
	0FbWRcDtygweNNdaaLhvSqEg9ayWhIHsYRrupuVSUFuThaDv4ggB2qwnJGjH7pFgy7tOQ2PK
	LAk6QwEJHakDCK4mXKHh5sU4Pkxk3iChJktDQX22K6QazBRMWKwIfrS2knCrWgzm8VkCGi+P
	0TCW8Tak5ZUQUHVkig8lTZFgtpkJuDc5yIPZjvfWrmPzmpNotrPvKck+amxAbOav37Lpmj8o
	1jbtyZbk3yHY5GtDJFuh6+Kzxlp3Nrs4ln1mKuKzxQVHeGxdfiHBVvTK2NScWrRR9LnEXxUd
	G8O9GRGtjgkQhUrBSyKVgcTLWyaRrvb78l0vH9HKQP+dXNSuvZxqZeA2ScSMrhPtObj0m5mc
	XqRBt1yTkIMAM974XGIHnYQcBU7MeYRPXjlM2wfLcNF460t2xs/aknj2pVGE+yv/emlcRngs
	vQvNb1GMGCcWDvDmmce8g5usd8l5dmE8cKLh6AuBZIqE2KpvejFwZsLwVPfAC1nIrMWPSxsI
	e6sF4RuWYb59sBA3nOmn5plk9uIHOuucLJjjpfjCc8F87MD44d9tN+j5GDMiPKn/0P7qA3hs
	5j5KRc66V4p0rxTp/iuyx5644/lD4n/xcpx7dpi0cwA2GEaobMQvQC5crFoRrlB7SdRyhTpW
	GS7ZEa0oRnP3YqyfLilH+UOjEhMiBMiExHNm3yV9M3KjlNFKTuQiTF4rDHMS7pTv28+poreq
	YqM4tQn5zP3iD6Tboh3Rc8enjNkq9V3lI/X2la3ykfmuFi0WBu9JlDsx4fIYbjfH7eFU/3qE
	wMFNQ7i3f1w4lXji0oYGWOPpnni65k7Pd5mLJx+V705YLy6VxZ8c7xzuGT03Kqn49LTiYJ2z
	wltzVWzhJrrl7VGW7KCIFmb5eFnz5rrtDiaVzaxblreC2x5QucRf+1Er/+CCevfzSzJdta9V
	Bf+5qPrJcOAHbTIKl65pf39TwOL1gdQB4a4NCZ9Nzqw//aA16HjsQ32wVR+aJVD7bLGItlHG
	Uz2d57/v+WJTdUjJVuKNfb6XrA9zfguJKfvkBLvFuXC/09fd4qojaZJWj43KKFttc0n+1FvF
	1yZG9PGmSMd1HsEt/PAFOaeEcaGSgsjG7tyF5q9+sg1eqAvKjIjPWLhZHDLiEVoaJKLUEXKp
	J6lSy/8BW/yY6MQEAAA=
X-CMS-MailID: 20240405063542eucas1p190ab901f5f6faa28cff00f183b9749bb
X-Msg-Generator: CA
X-RootMTR: 20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a
References: <20240328-jag-sysctl_remset_net-v2-4-52c9fad9a1af@samsung.com>
	<CGME20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a@eucas1p2.samsung.com>
	<20240328194934.42278-1-kuniyu@amazon.com>

--u37e6yueaf43q4xz
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 12:49:34PM -0700, Kuniyuki Iwashima wrote:
> From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.o=
rg>
> Date: Thu, 28 Mar 2024 16:40:05 +0100
> > This commit comes at the tail end of a greater effort to remove the
> > empty elements at the end of the ctl_table arrays (sentinels) which will
> > reduce the overall build time size of the kernel and run time memory
> > bloat by ~64 bytes per sentinel (further information Link :
> > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> >=20
> > When we remove the sentinel from ax25_param_table a buffer overflow
> > shows its ugly head. The sentinel's data element used to be changed when
> > CONFIG_AX25_DAMA_SLAVE was not defined.
>=20
> I think it's better to define the relation explicitly between the
> enum and sysctl table by BUILD_BUG_ON() in ax25_register_dev_sysctl()
>=20
>   BUILD_BUG_ON(AX25_MAX_VALUES !=3D ARRAY_SIZE(ax25_param_table));
>=20
> and guard AX25_VALUES_DS_TIMEOUT with #ifdef CONFIG_AX25_DAMA_SLAVE
> as done for other enum.
This is a great idea. I'll also try to look and see where else I can add
the explicit relation check.

Thx for the review

>=20
>=20
> > This did not have any adverse
> > effects as we still stopped on the sentinel because of its null
> > procname. But now that we do not have the sentinel element, we are
> > careful to check ax25_param_table's size.
> >=20
> > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > ---
> >  net/ax25/sysctl_net_ax25.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
> > index db66e11e7fe8..e55be8817a1e 100644
> > --- a/net/ax25/sysctl_net_ax25.c
> > +++ b/net/ax25/sysctl_net_ax25.c
> > @@ -141,8 +141,6 @@ static const struct ctl_table ax25_param_table[] =
=3D {
> >  		.extra2		=3D &max_ds_timeout
> >  	},
> >  #endif
> > -
> > -	{ }	/* that's all, folks! */
> >  };
> > =20
> >  int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
> > @@ -155,7 +153,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
> >  	if (!table)
> >  		return -ENOMEM;
> > =20
> > -	for (k =3D 0; k < AX25_MAX_VALUES; k++)
> > +	for (k =3D 0; k < AX25_MAX_VALUES && k < ARRAY_SIZE(ax25_param_table)=
; k++)
> >  		table[k].data =3D &ax25_dev->values[k];
> > =20
> >  	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
> >=20
> > --=20
> > 2.43.0

--=20

Joel Granados

--u37e6yueaf43q4xz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYNHmkACgkQupfNUreW
QU9fpAv/V+3/izS8SFMirWyciVnKdoJrmVBsF8hQm+Rl2pYODrbHb98QR2VXqYAA
obWYFUsHPBIRPhnwtWK4wOUpYjeavZUAa5M3pkVsCZvB1c1YT+HXKNmejNB0zZlh
vKO3wNon0gXKjuFUDKptPcTQQN71Whfi0QD7jHGAU0jR8tBRLVSNiqN+FlyTT5ZY
e058hfkPY19gTxx3Igp6rtxw5uxWPDXCbuZLhvRQ6TOyFBs7pxCpwSYnE8MjIxxu
TpCF4wl12yNHFwySifpvqF1sxp6TIEbmkmYhKjxGu5JY7ZxrMHuqMDSeqcOT7aj1
xzfrvk5iUpGheARqyK+1QEoyYiLHYCQo9a8F9KlTJQJOwqVfXtBUYTz21demWx1R
WwcJfePp1yjkcvZPM6yZoKQk3FAS+OlbbtH7iZ4SfPnlhqpFdKvE/kCxDZ2wvOav
HMjQx9a08CL5VcXF8rowUt+FYuLRUe4wkODIQOMLHZXCuq3giKeFYEX8cfFteHj1
668CEtfJ
=6gPd
-----END PGP SIGNATURE-----

--u37e6yueaf43q4xz--

