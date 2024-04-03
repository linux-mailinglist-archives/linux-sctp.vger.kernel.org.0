Return-Path: <linux-sctp+bounces-59-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECA7899587
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Apr 2024 08:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90CD285B1F
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Apr 2024 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572D12C1A2;
	Fri,  5 Apr 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vLL9rtI/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467602C1AE;
	Fri,  5 Apr 2024 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298953; cv=none; b=haVN7symei8zouhJC+IfhylEnL3BJCgHCxCW9g2Jb/vY4C/XpXRIu+rjN0J/orq3RGosKQhZCcjKne6VprOomymU/blx/GKuHIwSePLjQn6NleQSAqbBSlerbmbJHyU+ENZ1pkRRzEuodZbG+yHXaMSKSPFlQVr9KWIgDS8kdDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298953; c=relaxed/simple;
	bh=cO1PzXnsl05Oi3CJR79NBSXRD97u81UbzHGkGAWcnc4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=b/hDR6ld7SJYZVbEXhJNLyx6ntFFG2XJ9vpNjNA9AamBG7VcuAJwpYHAWPeeO1Hka9DofODSiOe4y4zTUWRoFMc68RsnxyRtwqQ4bgzXo3rPX35Co1v5gS8MxfiqldaN1yzb7Qi1faFyMB1qYT8QUbNwfaPWeBo6z6sy8e9xZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vLL9rtI/; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240405063549euoutp024dc9ce480a65aa6b4cf156e048429c46~DTtKHMJ1a2835028350euoutp02_;
	Fri,  5 Apr 2024 06:35:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240405063549euoutp024dc9ce480a65aa6b4cf156e048429c46~DTtKHMJ1a2835028350euoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712298949;
	bh=hG667JlBEGcijqfQ0bCFe89iWwdz0RQupU+vCJJh7gI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=vLL9rtI/oHdfrQxFN0DLwcMDnqDors74/koymRS2310QBWeyv31yIBpwkwkoUeTSo
	 lltrcZvZd/Ns7rpxicR/PWoV+HTsmfTk3gKUVuElEScvN+2fE0ruZYylFndr2yGBkj
	 TKK9WQk2MZCNyikCJPXKZA6A0NNdI2Tce2aB5uAE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240405063549eucas1p125a1262ad66664a4616735348ea5a6aa~DTtJ6z7b90623506235eucas1p1C;
	Fri,  5 Apr 2024 06:35:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 8D.85.09552.4CB9F066; Fri,  5
	Apr 2024 07:35:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240405063548eucas1p1500de4f04b0d27fca8f29a1f02ce90b8~DTtJTtNbV3228332283eucas1p1h;
	Fri,  5 Apr 2024 06:35:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240405063548eusmtrp15c48b857f1e330de8c899a3144758be0~DTtJSCSo-2498024980eusmtrp1I;
	Fri,  5 Apr 2024 06:35:48 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-38-660f9bc43f5c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 28.88.09146.4CB9F066; Fri,  5
	Apr 2024 07:35:48 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240405063548eusmtip14193961009864e00ad20f3c07538b0c9~DTtI_kPvT1565515655eusmtip1k;
	Fri,  5 Apr 2024 06:35:48 +0000 (GMT)
Received: from localhost (106.210.248.50) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 5 Apr 2024 07:35:47 +0100
Date: Wed, 3 Apr 2024 12:59:13 +0200
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
Message-ID: <20240403105913.o5jc45ijxjixbapw@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="w6pan44lwventsuw"
Content-Disposition: inline
In-Reply-To: <20240403091625.lk35wt2iqkvabrmr@joelS2.panther.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTa1BUZRj2O7ddNteOiPElODorIBpBVOarlooZc6ofyeBMZk3KyAFJWHBX
	wss4rYAscrFNmhjxAkisy21RWFeWixIqCDhchAKNy3BXWBRcQEFlE46WM/173ucy3/P8+MSk
	bZJ4kThIvo9XyP2CZYyEMlZO1r9749SbAe9pJkioUK2GrtI4GlTRMQQcNVkpMGbEE2BtHyDg
	uUlNgqVrgIbUc4UMnK6PpuB5SzwDTWd6CXgQ+ZQCffFRAvoqu0VgTMxBkBPZRsHlgccMxA86
	QtSlcQS9P3fT0KwdYWBSmy2CzvFuCiaPvwEn46IIuBUfAkXtvRQ0GI/ToE3IY0BT4wl/XW4n
	oKn4NAMN5bU09FckUqBJjyKhL22IhrYkLQXlZakIuvMfEhCV+oiEKEsPCVO6KhrqEq0kpOiz
	SWjV9CG4pr5Cw638SBFMnL1JQlmqioLKtLdAo6+hYKLWjCDZ/CcJt0udoGbMSkBdoYUGy2lX
	SNIZCCg59kQEhvofoGaqhoCexwMMWFs3bNzE6RriaO5u9zjJPairRtzZ3EPcKVUjxU1NruQM
	WXcILv76IMmZUtpFnLHcmUsrCOeeVVwUcQXZxxjuRlYewZm61nCac+Voi2y75GN/PjjoR17h
	sX6nZPfz0n5R2L3F+289/JtQoSoch2zEmP0QD8SoqTgkEduyOoTHGy2McIwhXNxseKlYEG69
	eR+9iiQVDBOCcB7hP34ZIv91XVA9pYWjEGGNqepFRCymWCc8OiSZSTOsG643t5Ez2I5dgWP1
	CbN+ki2U4upjLfSMsIANwE86+mazUnYjvjNpN0NL2fm4+mQvNYNJdj8e6bw5ayFZB3x+WjxD
	27Be+FFZ7iyNWRl+nPOF0PkwrjHcne2M2ca5+F5mBiMIm/FvsYkvhy3Ag1UGkYAdcW1SAiUE
	khC+Oj0iEo4chLVHxgnBtQ5HN/e+THjhYcsRRnh5Hm4dni/0nIdPGJNJgZbi2Bhbwe2CczrM
	lAYtS3ltWcpry1L+WybQbjit5BHzP/odrE0fIgX8CdbrH1JpSJSN7PlwZUggr/xAzke4K/1C
	lOHyQPddoSEF6MVfrZ2uGi9CusFR9wpEiFEFcnoR7r6Q04AWUfJQOS+zk8ZvlAbYSv39Dhzk
	FaE7FOHBvLICOYgpmb3U2X8Jb8sG+u3j9/B8GK94pRJim0UqQr1kbvDowYgdYRJHz7oyx/eX
	R/20YCl9NKGkLtt0QM6nZT3ri81fHOG2+sqmL22UrrX2zVt+Z24nF3dcdzkhu+ZPbt57uFTh
	7usTWuSgECV+HVAtXtvyedGRFdOuprUj285kX+7o1JoHFm7fMzGV71O5bPQbXUTYymjfjwa3
	9Y2OLamXW8vcntgmj9nfX7EmMnPOBovXLpnoO5/+zp0lnnYxid96SrSpuou+q6gpffPC9Qcj
	jDZBLt7LzeYgc5xzaL/xs+8N1/O7vCzenfWuVFOTNc/De+/VS7mf/up976tDW5caHDJGG99O
	d1H7zFnX7LW1J1S9yiOzyZWbM5wud1+r3t1zpV1GKXf7ea4kFUq/fwBFmmt5JgUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0yTZxTGeb9bC67zGxT3Dl3UBjZls1IEPThRZJB924zTmP3DsmnBjzst
	tgU3xa2hitoKsrCMiIyLbChFy7jIbbJ0TGCCAcSJwkCkcgkXZVJvVIRRm2Um++/J7zzPk5OT
	HCHpel7gIYxRaHiVQh4vYVyotrmW/jWXTy+O9GmpxdCo3QCDl/Q0aA+nEXCkbp6C6iIDAfP9
	owQ8rztKgnVwlIb8M5UM5HYcpuD5TQMD138YIuB+6jMKTPVHCBhutgigOr0UQWlqHwU1o08Y
	MIwvA93FRwiGTlpo+LP4bwZmio0CGHhkoWAmYxGc0usIuGpIgNr+IQo6qzNoKD5xgYHMVhl0
	1/QTcL0+l4FOcxsNI43pFGQW6kgYLpigoS+rmAJzQz4CS9kUAbr8aRJ01rsk2M610NCePk9C
	jslIwq3MYQS/H/2VhqtlqQJ4nPcHCQ35WgqaC5ZApqmVgsdtkwiyJ2+Q0HXJE1ofzhPQXmml
	wZq7CrLOVRHwy/GnAqjqiIVWWysBd5+MMjB/a0tQMHeuU09zvZZHJHe//Qri8s4f5E5rr1Gc
	bcabqyrpITjD5XGSq8vpF3DVZi+uoCKJm20sF3AVxuMM11RygeDqBgO4zDNmtEMSJt2kUiZp
	+BXRSrUmUPKZDHylsgCQ+voFSGXrNny+0ddfsnbzpr18fEwyr1q7eY80+my9jU4cefNLY4+7
	FjVhPXIWYtYPZ1XcI+zalf0J4dG6IAdfhssf3qAd2g3PdusZPXJZ8DxAuKt3kHQEKhEeu7dG
	j4RCivXEDyZc7Jhh38Udk30vLGJ2NT5mOkHbsyRbLsKTpR0vBm5sJH56exjZsyI2CPfMiB39
	qQS2mCYYu0fEvoavnBqi7Jpkk3HXaBVj95PsUnx2TmjHzuxWPN1w/kUNZiX4SelHjpUPYevz
	EZSJ3HJeKsp5qSjnvyIH9sa35saI/+F3cHHhBOnQgdhkmqIKkMCIxHySOiEqQS2TquUJ6iRF
	lDRCmVCBFl6lunmmshbljT+QNiJCiBqR50LS8nNpJ/KgFEoFLxGLDEGiSFfRXvlXB3iVcrcq
	KZ5XNyL/hRt+S3q4RygX/k6h2S1b7+Mv81sf4OMfsH6d5HXRh4nH5K5slFzDx/F8Iq/6N0cI
	nT20hDnycGyJV1FwZ3jvJ92hPmNFtQerhftJ9++Wh8wu3pVxsm25Uwp6IyhoTfTN/V88e7/s
	1dAPprZ8I2SvJYeL0UCY153YouTmwriQK9v2zWxJ+RgFGyt2BLZE6H5rWRU/5vv1vrGUKlXb
	XJNm/MbAaienyqVnm840l2ybm56+/dcSMfcjfVQiUU0f8ah/ZpvYmnsgZaWS3VDh7hIbb3p4
	aWMXH1a2fXuG/1vm6OzxwE3BF2MGQhMfo4aaOM+k/sqEzojsjZqVO3fHpb2X/L3x+p6BkGXh
	l9OjonfODilS7rSko1emumTz4c4XdG+njZvF8qV1VdqaNgyLNtu8Pt11aMgz0jo7IKHU0XKZ
	N6lSy/8BW/wH478EAAA=
X-CMS-MailID: 20240405063548eucas1p1500de4f04b0d27fca8f29a1f02ce90b8
X-Msg-Generator: CA
X-RootMTR: 20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a
References: <20240328-jag-sysctl_remset_net-v2-4-52c9fad9a1af@samsung.com>
	<CGME20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a@eucas1p2.samsung.com>
	<20240328194934.42278-1-kuniyu@amazon.com>
	<20240403091625.lk35wt2iqkvabrmr@joelS2.panther.com>

--w6pan44lwventsuw
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 11:16:25AM +0200, Joel Granados wrote:
> On Thu, Mar 28, 2024 at 12:49:34PM -0700, Kuniyuki Iwashima wrote:
> > From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel=
=2Eorg>
> > Date: Thu, 28 Mar 2024 16:40:05 +0100
> > > This commit comes at the tail end of a greater effort to remove the
> > > empty elements at the end of the ctl_table arrays (sentinels) which w=
ill
> > > reduce the overall build time size of the kernel and run time memory
> > > bloat by ~64 bytes per sentinel (further information Link :
> > > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org=
/)
> > >=20
> > > When we remove the sentinel from ax25_param_table a buffer overflow
> > > shows its ugly head. The sentinel's data element used to be changed w=
hen
> > > CONFIG_AX25_DAMA_SLAVE was not defined.
> >=20
> > I think it's better to define the relation explicitly between the
> > enum and sysctl table by BUILD_BUG_ON() in ax25_register_dev_sysctl()
> >=20
> >   BUILD_BUG_ON(AX25_MAX_VALUES !=3D ARRAY_SIZE(ax25_param_table));
> >=20
> > and guard AX25_VALUES_DS_TIMEOUT with #ifdef CONFIG_AX25_DAMA_SLAVE
> > as done for other enum.
> This is a great idea. I'll also try to look and see where else I can add
> the explicit relation check.
>=20
> Thx for the review
>=20
> >=20
> >=20
> > > This did not have any adverse
> > > effects as we still stopped on the sentinel because of its null
> > > procname. But now that we do not have the sentinel element, we are
> > > careful to check ax25_param_table's size.
> > >=20
> > > Signed-off-by: Joel Granados <j.granados@samsung.com>
> > > ---
> > >  net/ax25/sysctl_net_ax25.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >=20
> > > diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
> > > index db66e11e7fe8..e55be8817a1e 100644
> > > --- a/net/ax25/sysctl_net_ax25.c
> > > +++ b/net/ax25/sysctl_net_ax25.c
> > > @@ -141,8 +141,6 @@ static const struct ctl_table ax25_param_table[] =
=3D {
> > >  		.extra2		=3D &max_ds_timeout
> > >  	},
> > >  #endif
> > > -
> > > -	{ }	/* that's all, folks! */
> > >  };
> > > =20
> > >  int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
> > > @@ -155,7 +153,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
> > >  	if (!table)
> > >  		return -ENOMEM;
> > > =20
> > > -	for (k =3D 0; k < AX25_MAX_VALUES; k++)
> > > +	for (k =3D 0; k < AX25_MAX_VALUES && k < ARRAY_SIZE(ax25_param_tabl=
e); k++)
And with the BUILD_BUG_ON we don't need to do the `k <
ARRAY_SIZE(ax25_param_table)` any longer. Win/win :)

> > >  		table[k].data =3D &ax25_dev->values[k];
> > > =20
> > >  	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
> > >=20
> > > --=20
> > > 2.43.0
>=20
> --=20
>=20
> Joel Granados



--=20

Joel Granados

--w6pan44lwventsuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYNNoEACgkQupfNUreW
QU/2xwv+MItPQYrz+S6dRg4Ai/4AcELCorzBdY4bODL7PVt21oRNRzkdPrq6w6ju
ZFVkQH/WIICFHeGJ9RJGwF/e3xOzwTpg3GK0xE0s3YT4eO2R/dzV7LyIGklp7WT2
bsnrm2zhkiKp7OZHIhHUze9HniHLvoBiJPVAMMe3YXMkEtrjxfqLOVNnyKxuHjdD
1QuYwZvFvCXZt/1y0B/vvCeaq+hlNidK29TRRU0Bmqb4jE9WYTYtBkwxLDPw9mNo
kZ3nbaxct86hWGyWHXS9mYjySkRbS2JqHXYoDV+u0S51ufVgo7crYSL9E93t0hu2
O6wCfXcUw2vcypp/jivDaSw5x9ULQWg4ITiWl3wxxsaRjoUwVl7IfOk1nQYwOsCE
K138v1DytuqhzXRyLYYf6yEfug89HG762oB0V3UAxqx6uYQlpc99DhP2ejynYco2
Ae8GVoKvakSl5NpefEu2btStO3NdM9rueEYF77z5oIYhbkC0YnkyJZz6zDtMQY/M
7yoIH3I9
=Ju+L
-----END PGP SIGNATURE-----

--w6pan44lwventsuw--

