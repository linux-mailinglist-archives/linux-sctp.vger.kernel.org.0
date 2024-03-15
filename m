Return-Path: <linux-sctp+bounces-38-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5399387CF9C
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Mar 2024 15:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781D01C227FB
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Mar 2024 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA63C680;
	Fri, 15 Mar 2024 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="G2Tv4oet"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07ACB18EA8;
	Fri, 15 Mar 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514725; cv=none; b=rgcvH+phdQupfxIAKNfIgZEVHfc+63ITbRNWTlDrW/h5XfPwbdGHfL++T2HGxf0cD3P9fqAAYNi4J+EZbmFR7ovV3TNdl/ZhdyruPBP2HrHdukINBDDDJetG5XcYNQIgdchMFDu2b5K3tGJGsloVd+y5Z2CtlzxG6Z9Hp/Hvfdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514725; c=relaxed/simple;
	bh=QkAlNJ9V9qppiro/zSbEdW694RBnZkoeHZrahCOadSs=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=BRh1Vfp16onm/9TCZHDqNmwVEhfnt9VjudysgjwtNsCDRxMG9yI1nUMwPGN8pMc+K645N1c+4/dusrbtuZlGheZUg7RZgvwD0DVkM6oqi3IlvcXnM3LtnOFsXqjgvEEP2XnqdDcVncaQsFAaYQtr0GZU5WDuU9rNL4cD6+Zw2CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=G2Tv4oet; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240315145834euoutp0208e17bee17510a43114d2abc73c66d9e~8_BH9XOku2978829788euoutp02f;
	Fri, 15 Mar 2024 14:58:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240315145834euoutp0208e17bee17510a43114d2abc73c66d9e~8_BH9XOku2978829788euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710514714;
	bh=QkAlNJ9V9qppiro/zSbEdW694RBnZkoeHZrahCOadSs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G2Tv4oet03CghGKOrgieijfEl82FvjQVZBL+NfoG15HFyo9VIUHcvPRvsG82TfUwJ
	 dX7pxAXAb9YPyNG2TKDc8iEY570oeA5ZpY68L1+/6ZETCD+YW+AwjxiTIrcFxIsFOl
	 Mk2mYfgH8Xod4xWY0H6rRKtWJgy98o37Oog1PoZk=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240315145834eucas1p263d507b6e6b1b2347755a3b8a3d110c2~8_BHm31sC0659706597eucas1p2F;
	Fri, 15 Mar 2024 14:58:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 62.5F.09539.A1264F56; Fri, 15
	Mar 2024 14:58:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240315145833eucas1p213fce847384eb45d99b496e63aeef842~8_BHARDUI1048010480eucas1p2_;
	Fri, 15 Mar 2024 14:58:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240315145833eusmtrp1d4283c4c3365474281127eb3980b7d32~8_BG_cMhB2583725837eusmtrp1-;
	Fri, 15 Mar 2024 14:58:33 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-32-65f4621a921a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B2.BC.09146.91264F56; Fri, 15
	Mar 2024 14:58:33 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240315145833eusmtip25fac59b9345218f02603c4bc99e60c97~8_BGowIxW0792607926eusmtip2S;
	Fri, 15 Mar 2024 14:58:33 +0000 (GMT)
Received: from localhost (106.210.248.173) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 15 Mar 2024 14:58:32 +0000
Date: Fri, 15 Mar 2024 15:58:30 +0100
From: Joel Granados <j.granados@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, "Steffen
 Klassert" <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Matthieu Baerts <matttbe@kernel.org>, "Mat
 Martineau" <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, "Ralf
 Baechle" <ralf@linux-mips.org>, Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>, David Howells
	<dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, "Marcelo
 Ricardo Leitner" <marcelo.leitner@gmail.com>, Xin Long
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
Subject: Re: [PATCH 0/4] sysctl: Remove sentinel elements from networking
Message-ID: <20240315145830.e3sl57eytsosngeb@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="onm3lc3zkynvura4"
Content-Disposition: inline
In-Reply-To: <20240314154248.155d96a4@kernel.org>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfVBUZRTGe+/XLuA610XhDcwSgSE1Ck09fmBSUbeZmpTKcWq01riCCOjs
	QlqMhoAu7opsMEUiCoryLSCsu6wCyyCisAQoauQsEAuEISLyIQICsV4cnem/33me87zznD9e
	MSn9Rewk3hkaxstDZcEujC2lqx5teMtp+xD/TrWKgcrIVdBeqqIhMuYwAYcMUxTo0tUETLV0
	EzBhUJIw2N5NQ+qZYgZSGmIomPhTzUDTyU4C+qLGKci/dIiArmqLCHRxuQhyo8wU6LtHGFD3
	zIfoi8MIOuMtNNzK6GdgNCNHBG3DFgpGj9nBcVU0AXXqEChp6aSgUXeMBk2tF9zRtxDQdCmF
	gcYKEw3/VMZRoDkdTUJX2n0azIkZFFSUpSKwFDwkIDp1gITowQ4SxrKu0VAfN0VCcn4OCc2a
	LgRXlOU01BVEieDxqesklKVGUlCd5gCa/FoKHpt6EST13ibhZqkr1A5NEVBfPEjDYIoHJGZp
	Cbh85IkItA1BUDtWS0DHSDcDU83vwcE6nWiDD3fXMkxyffU1iDuVF8GdiLxBcWOjizlt9l8E
	p67qITlDcouI01W4cWlF4dzTygsirijnCMNdzT5PcIb21ZzmTAXiis/+vHHh17br/PngnT/w
	8rfXf2cb2PFb0B69ZJ/+zjAZicx2KmQjxuy7OGXsJrKylM1CWHlsmm2neQjhkjuDImEYRPhJ
	Xir1PFGgN9KCkYmwOcr0YqtmZHwmfxHhk6UnGGuEYt1wlVr5jBl2KW7oNZNWnsu64pji45Q1
	QLLXpfipcpS2GvbsJzinoGvaEIsl7AZ8pmGrVZawc3DN8c5nNUh2H76elUBYV0jWGWdOiq2y
	DeuF9UkdpNB0ER5OeMQIvB/Xau8SAv8xC/dVuQj8IW4tUM5cZo97rmlFAs/HpsSjz6phNhFh
	42S/SBhyEc44ODzz0locc6tzJuGDRyz1jLUQZmfj5gdzhJ6zcYIuiRRkCY49LBW23XFuay+l
	QYuSX7os+aXLkl9cJshLcdrlAeZ/8hKccfo+KbA3zs9/SKUhUQ5y5MMVIQG8wiuU3+upkIUo
	wkMDPL/fHVKEpn+qafLaQAk62fPIsxIRYlSJXKfDlsLcRuREhe4O5V3mSg4sfMRLJf6yH3/i
	5bu/lYcH84pK5CymXBwlbv6v81I2QBbG7+L5Pbz8uUuIbZwiCY/R5VrvV20vvPLF765VfY5G
	JutXS+Z2P/mQIcCkjgr76k33BdnEra4VqfZfGjtKgnTpBuf0RCm9nJuQObLJxTFbBoyb/MK5
	He3G97VNu25/tODzbZMyh+7YVt3mFtXHTSY3Ol5VXn109TJfDds+79PY9XV22yqilPqVtI/m
	wKTveY95BtIvre1G9Gf96uA1Rvc5sRExCsk5Tp6+Kvvq+AdTbaqbCfjfwHubrhSeDYswP4hD
	Ra+Jt3bcSxxY672hcMJ3zUPub5clzfGxbxw9VXGo1+ebQim3ZSSwxr3cqWrd7L0bz93bPMt/
	hyzunOZ+0rK2B3n0yvay/Q4rxv3N9avFy33sXChFoMxrMSlXyP4Di5z3OyQFAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTZxiH/c45Pa2XZmeU6bG6RDuYhmm1CPJ2Q4VM3XHZzJiJMTNGOz0r
	OtqyXnTOzHETJhUsNhkBERC1AjoqLReroqRT1IqgUxlTGNLSEpHAEFAolw6oy0z235PfLV++
	5OXhARe4Qt5upZZVK2VxInIGcWf85l9L5349wC5vuywEe0IEtF9J50BCSioGh2w+AqpO6THw
	tXZiMGZLw6G/vZMDBUVWEvIaUwgY+0NPwoMTHRj0JI0QUHbpEAbuOicXqjLOITiX1EJAdecr
	EvRd8yG5chBBx1EnBx6a/iZh2FTKhbZBJwHDmTMhJz0Zg3q9Ai62dhBwryqTAwaHBJqqWzF4
	cCmPhHu1dzjgsWcQYDiZjIO78DkHWowmAmprChA4zb0YJBe8wCG534WDt/gmBxoyfDjklpXi
	0GxwI/gt7SoH6s1JXHiZfwuHmoIEAuoKZ4OhzEHAyzvdCLK7H+Hw+5UgcAz4MGiw9nOgP28x
	GIsrMLh8eIgLFY17wOF1YOB61UmCr3kNJNZXcaOimcfOQZzpabiNmPzzB5jjCfcJxjscwlSU
	/Ikx+utdOGPLbeUyVbXBTKFFx4zay7mMpfQwydwo+RVjbO1SxlBUixjr6Z++WPiVOFKt0mnZ
	BbEqjXaVaKsEQsUSKYhDw6RiyYqIbR+GhouWrY7cxcbt3suql63eIY496e7G4iv53xsfNuAJ
	6PHMdDSdR1NhtLn6GicdzeAFUGcQ3Wsp4fiN+XT5wKPXLKBHm9JJf6gP0X2exNeNSkT/Ut42
	lSKoYPq6Po2cZJJaQjd2t+CTHEgF0SnWHGKygFO3AuikorYpQ0BtoEvN7gmDx+NTUXRR4zb/
	6A1Ej92yTY3yqbfp2zkdxCTj1F46c8AzlcepefTZcd6kPJ2S0NXZLtz/0vfowWN9pJ9/pPvH
	PMiABLlvLOW+sZT735JfDqGbx59h/5M/oE0nn+N+XkWXlfUShYhbigJZnUYhV2gkYo1ModEp
	5eKdKoUFTZxLVd2w9SLK7+oT2xHGQ3YUNNF0Xjh3DwkJpUrJigL5Bxf2sQH8XbL9P7Bq1Xa1
	Lo7V2FH4xC9m4cJ3dqombk+p3S5ZuTxcErZSujxcunKFaA5/Q/zPsgBKLtOy37JsPKv+t4fx
	pgsTMN3nnatEVv3GxIUPIuLyhmaHf5S7c9aWtft164zbhLOr4Um/iXc39eLwyPqz8/e8+hSP
	NX4mtQW6qz01BwTyefsq2qcpVOKN9zcFyzN9YcINR7SVT2JuOt2K3hiyIvjMoHrt5vr3ZZuO
	FC/xJZrKj+V1nWZjI87TcsGXxTrH5ewaQcEzeZbFK46qY08Y142hFTvmLJrxbNrTa963XKci
	XUZXci05eiW6Ibrrquab7I+PtjszxvgxA0vnise1axK3Nm052BOWk53uZt5d01xuXhz2yQgz
	EhgS+ij0Oxupbx2dtcw8tO9Gqq1t/wKLxjLPl695EbRpkTfr6fG7PM9mSjd+VURoYmWSEFyt
	kf0DO6fsqMMEAAA=
X-CMS-MailID: 20240315145833eucas1p213fce847384eb45d99b496e63aeef842
X-Msg-Generator: CA
X-RootMTR: 20240314224256eucas1p292b70c755674fe9311d190a8b50e1ce1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240314224256eucas1p292b70c755674fe9311d190a8b50e1ce1
References: <20240314-jag-sysctl_remset_net-v1-0-aa26b44d29d9@samsung.com>
	<CGME20240314224256eucas1p292b70c755674fe9311d190a8b50e1ce1@eucas1p2.samsung.com>
	<20240314154248.155d96a4@kernel.org>

--onm3lc3zkynvura4
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 03:42:48PM -0700, Jakub Kicinski wrote:
> On Thu, 14 Mar 2024 20:20:40 +0100 Joel Granados via B4 Relay wrote:
> > These commits remove the sentinel element (last empty element) from the
> > sysctl arrays of all the files under the "net/" directory that register
> > a sysctl array. The merging of the preparation patches [4] to mainline
> > allows us to just remove sentinel elements without changing behavior.
> > This is safe because the sysctl registration code (register_sysctl() and
> > friends) use the array size in addition to checking for a sentinel [1].
>=20
> Thanks, but please resend after the merge window, we don't apply
> code to -next until -rc1 is cut.
of course. I'll resend after -rc1 hits kernel.org.

Best

--=20

Joel Granados

--onm3lc3zkynvura4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmX0YhUACgkQupfNUreW
QU8cEAv+M1Ewqt08SIopWKdreIIqD2kzMZ3Ql+7uN752tp2sVtVbFjjrO8sKICiz
g6Oiqw0mocBQd7wjnGLc5+VxeYK+5VG4geP6jecNsNgGRdSaXdEqSzqf60Ri+nq5
etfLQbWjO306ZcZGEitSwDxTJhoG00IwTZdu1zXhsypcNAW46xVEnSuT1tdx3wB9
7CoVy5hYg+KrYrLGfAPbG2g9iOOTG4jNFL3SjiiqNb/1qhknf4D0CL8f0v/5yYM8
J0ple4a3xlyODh5hiN7PBuOveQd7hLZMeK3/WhByQn9QSe3sc5J7Ue5I40jtQ+1p
14ahVOh5+Dh9bxxKdVzjnx2FXbG7MF6ZdOw9LarYon3W2xx++UfLA9SF4X9f+Z+C
WwPzCt7Yk/WmShpqM1KCOVAUwcNtdF2Jttyk2vKqWDB//02sqhtO+ndueWvLNgti
3H427shFf9/ctykv2dQmthRviho30MSC9eB3BcjmUL8SE5G6WwMb/csBkkV+DG3d
0widvqRM
=vtM5
-----END PGP SIGNATURE-----

--onm3lc3zkynvura4--

