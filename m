Return-Path: <linux-sctp+bounces-68-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6B28A47F0
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Apr 2024 08:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC79D1C21691
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Apr 2024 06:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6ECF9F0;
	Mon, 15 Apr 2024 06:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ERV9rHLV"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFACF510;
	Mon, 15 Apr 2024 06:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161903; cv=none; b=I16CW9h7wkRbFiCuqc0p4APWJSA9clqFvaumbULOfgwaNRCJ6+7Fr5jHP8UTTLbxPjscuHmokAC38rNGN+aWgEPWqs3iPA0cnc1KyUo4nF1oVwe0Vo3QyWa4uZykAmOoWyOp2SsB78MkijlIdh8O/664L7kgHaapWahtMus0rDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161903; c=relaxed/simple;
	bh=dIpMorwvcjEcFIs7BXGPzjLGTI/qN5cCdG54c8G6u6I=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=dXdyFC65xycVxNm4i1KBRhqq6LI7pF9MVTHkP/8xxrOO5y/qCo91yIwIOKHb1N5oyw0Co/gNGy5TLVZl8jYSM8fSuMqFWjGHxVce0sSn5q0aRoJ575MfAxh8AgNMQClfQqSwODA91hPrn83fK+EC2HFpcbHhSbd2fUrFCo4+UgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ERV9rHLV; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240415061813euoutp02d4ab7dfe0773524854f6060b40e5a93d~GX6pDsjYh1490514905euoutp02V;
	Mon, 15 Apr 2024 06:18:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240415061813euoutp02d4ab7dfe0773524854f6060b40e5a93d~GX6pDsjYh1490514905euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1713161893;
	bh=eNr2YGP1v+MnG9QRbYR4UIWo2Mx+qaBfAW2TIUf8pk0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ERV9rHLVBat+fo9IBDp/Hka1GmgTo99aqUCB3b7aSuMfh6S/it+2UV4yjvBgf4lpf
	 sCSS7LNtj/zRpj4BcCJnY6/DDEOnS4upaH6HVM1jCYP5xuIOMZFxXzhY35xzKQQuPA
	 O2ToMWZ4PXatstYZ1+Hh0nCb7mL3wREyYFmA84Zw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240415061812eucas1p1871a07d54e857a4d6203d9ae01643998~GX6osyF2F1247012470eucas1p1u;
	Mon, 15 Apr 2024 06:18:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 21.D8.09620.4A6CC166; Mon, 15
	Apr 2024 07:18:12 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240415061812eucas1p1ff6ae6b6eeb996525ffa4bb28090d076~GX6oE0yrW1022010220eucas1p19;
	Mon, 15 Apr 2024 06:18:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240415061812eusmtrp10e4c6ec364e62bf73915fa567506d049~GX6oDR2uN2218222182eusmtrp1o;
	Mon, 15 Apr 2024 06:18:12 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-13-661cc6a4a5ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 26.72.09010.3A6CC166; Mon, 15
	Apr 2024 07:18:11 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240415061811eusmtip119769eaa9d0d8bdf9c622f51ae1af21a~GX6ntJEyG0507205072eusmtip1Z;
	Mon, 15 Apr 2024 06:18:11 +0000 (GMT)
Received: from localhost (106.210.248.128) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 15 Apr 2024 07:18:11 +0100
Date: Fri, 12 Apr 2024 16:50:00 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: <Dai.Ngo@oracle.com>, <alex.aring@gmail.com>,
	<alibuda@linux.alibaba.com>, <allison.henderson@oracle.com>,
	<anna@kernel.org>, <bridge@lists.linux.dev>, <chuck.lever@oracle.com>,
	<coreteam@netfilter.org>, <courmisch@gmail.com>, <davem@davemloft.net>,
	<dccp@vger.kernel.org>, <devnull+j.granados.samsung.com@kernel.org>,
	<dhowells@redhat.com>, <dsahern@kernel.org>, <edumazet@google.com>,
	<fw@strlen.de>, <geliang@kernel.org>, <guwen@linux.alibaba.com>,
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
Message-ID: <20240412145000.4nrf5sufnwjltdl4@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="7o7lzmim7rza4zom"
Content-Disposition: inline
In-Reply-To: <20240405222658.3615-1-kuniyu@amazon.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTa0yTZxTH87y3FrTstRB85LYF1Divcy7bcZOp02Xvsi/L5rJFN7XKK6JS
	TAuOTZdVCqJQHRcTZkGuppZWiwJWUBBWJ2gBwQsMCeBaijjAG8ilgHSUVzOTffud/zn/c3mS
	R0xK08R+4gh5NK+Qy/YEM56UucbZuORUTcCOd4pvvQUW1Qdgq0iiQRV/iICEchcF5oJkAlwd
	PQS8KE8kYdDWQ0NOfgkDWY3xFLz4K5mBOycdBDyOG6fAdCmBgO4auwjMR40IjHHtFFzsGWEg
	uTcA1BeGEDh+s9NwV/eUAafOIIL7Q3YKnMdmwIkkNQH1yZFQ1uGgoMl8jAad5iwDKdbl0HKx
	g4A7l7IYaKquo+GB5SgFKXlqErpz+2hoT9dRUF2Zg8Be9IQAdc4ACerBLhLG9LU03DzqIkFr
	MpDQmtKN4GriFRrqi+JEMJx9nYTKHBUFNbm+kGKyUjBc148go7+ZhNsVc8H63EXAzZJBGgaz
	FkC6vpSAy0dGRVDauAusY1YCukZ6GHC1rl7zCadvSqK5NvsQyT2+eQNx2Wf2c5mqWxQ35lzI
	lRbeI7jkP3tJrlzbIeLM1fO43OIYbsJyXsQVG44w3LXCswRXblvJpeRXoy+DN3quCuP3ROzj
	Fcs+3uq5c9jRTe8t9o1tadOSKnTQOwl5iDH7HtakOYkk5CmWsnqEGyqTKSF4jnDF42FGCAYR
	Vp18Qb6yPCt2UW6WsqcRfvj7YoGnih71iwTDBYQt9YW0O0Gx83Bm9TjhZoZdjBv726cb+bBv
	48MmDe02kGyJBGdkpCJ3wpvdgUc7u6dZwq7BqsSTIoFn4RsnHNOTSTYW379ydorFU+yPT0+K
	3bIH+z4eqTW9XDQEx9lP0QL/gq2lbYTADTNx/tX9bitm1+Pb2dsE2Rv31paKBA7Adema6ZfA
	bDrCVZNPRUJgRFh3cOhlo49w/F3HS8daXJU/goSmXrj10SxhTS+cZs4gBVmCDx+SCtXzsbGz
	n0pBIdrXDtO+dpj2v8MEeTHOvTzA/E9ehHV5faTAodhkekLlIpEBzeZjlJHhvHKFnP9xqVIW
	qYyRhy/dHhVZjKa+at1k7VAZ0vc+W2pBhBhZ0Nwps/2csQn5UfIoOR/sI2kJmrNDKgmT/fQz
	r4jaoojZwystyF9MBc+WzAt7k5ey4bJofjfP7+UVr7KE2MNPRaxtu1ul9tBsKKAMQd6mtZvz
	tF+v6/O6LLG6xgbOZdKZP1Rv6iOzmtvl34Z2XP+jbaLr3YlPmYLZK2rVSyoffthPhR9gNQud
	m6IXbE/v/M62bE7tymvNw3idMrViK1Eylqr4xx6S0DX/9EBOB26f2eAbpaqTNSz6NXY8pCov
	MKImQj+YWDS+O2Gybb7hG1PDrm2T1560Rtua4w6y9UGGLmPf3/vK7hhsx3U+1OflRs1QqaOI
	+r5gy4PR0OceLOd0bnhj89aM6N0DZ+5tnDBViXGv7LNVLn9ZgyszQBt7oNd86bh0/YJb2V8E
	rg618WR8mU/ajMLz+l1fVZT5BfpvkUTgq8GUcqds+UJSoZT9C4A/UzIlBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeUyTdxjH93uvFhjbSwF9xxBIhcyhVloFHqYy55i+u5hxcYs4p52WY9CW
	teBQ59JwCHK4LiQyCkK9Oo5Z5bAcgqmonIZzCCzUhQoShckEFEGhA8oyk/33+X2f5/vNN7/k
	4eK8Eo4LN0IWI1HIxFF8ypZomWswrT1X7xrqc/2qP9Sp/GGgJpUEVeJxDJKqLAQYzqVhYDEN
	YzBblYzDxMAwCflnyyjIbUskYLYnjYKu04MYPIp/ToC+OgmDoXozBwwZxQiK4/sJqBieoiDt
	oSskXHmCYPAnMwm/6/6mYFpXxIE/n5gJmD5pB9mpCRjcTpNCpWmQgHbDSRJ06RcpUDcL4U6F
	CYOu6lwK2o0tJNyvyyBAfSYBhyHtCAn9mToCjLX5CMyXxjBIyB/HIWHiHg4zBQ0ktGZYcNDo
	i3DoVQ8huJF8jYTbl+I58DSvEYfafBUB9dploNY3E/C0ZRRB1mg3Dp01ntA8acGgtWyChInc
	VZBZUI7B1RPPOFDe9i00zzRjcG9qmAJL77tbtrIF7akk+4f5Cc4+am1CbN5vR9kcVQfBzkx7
	s+WFfRibdvMhzlZpTBzWYPRitaWx7Iu6Eg5bWnSCYm8VXsTYqoEAVn3WiHbwQwSbFPLYGIlH
	uFwZs5m/RwgigTAABKINAQLhev+974h8+esCNx2UREUckijWBe4XhPecPxJ9eVlc4biZUiEL
	LxXZcBl6A/O41EKkIlsuj76AmL8aenHrwJUpmewmrezIvLiTSlmXHiNm8tRxzPq4gpjaQePi
	FkF7MTnG59gCU/Qapm20fzHJiX6bSdGnkwsGnC6xZ6aTLywaHOlQ5tndIbTA9vQWRpV8mmNN
	NSJG11mwNHBgmrIHiQXG6UOM2pI134M7z28yv85xF2Qb2o+ZatAv1V7JxJvPL9U+xkzM3kdq
	5Kh5KUnzUpLmvySr7M30zj3A/ievZnRnRnArb2b0+jFCizhFyEkSq5SGSZUigVIsVcbKwgQH
	5NJSNH8vhvrp8kpU+PCxoA5hXFSHPOed5svF7ciFkMllEr6T/R23N0J59gfFh49IFPJ9itgo
	ibIO+c5/48+4i/MB+fzxyWL2Cf18fIUb/AJ8fAP81vOX238YnSLm0WHiGEmkRBItUfzrw7g2
	Lirs45XDTl8PiRrLtt5z/sarUiqNWNvbtWNUduO9xJvun3zWsTuoyzHsvG/1se/41UeDPiqm
	edFuG/nb13jwqxODtyjiCO+mwMN2haYQt73Z6a9GNYbd9GzMq0mqMHK4ts6rE1o+p9BXP8Zn
	RWz/JUM79gXZ9oHaIX1Nd8BGSqgxRHUHzYqqLt/19M9b8bpNZEX093H05Hhch92evmCHsR7h
	KxlsSX90iuDWD9X6iEx6eFde5G53uahtU2VMT4hml4njHLlz/yopyV2eFLwiDv/USXnp0Fsj
	7p2nRvpale9nBT3ICY39Mr28lKT9HQ33u44MpOy5vjPJq6E/UyvdluaS57Ht2mt8QhkuFnrj
	CqX4H55nv5fEBAAA
X-CMS-MailID: 20240415061812eucas1p1ff6ae6b6eeb996525ffa4bb28090d076
X-Msg-Generator: CA
X-RootMTR: 20240405222730eucas1p16a0790be308342130a19a5b489ffae1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240405222730eucas1p16a0790be308342130a19a5b489ffae1e
References: <20240405071531.fv6smp55znlfnul2@joelS2.panther.com>
	<CGME20240405222730eucas1p16a0790be308342130a19a5b489ffae1e@eucas1p1.samsung.com>
	<20240405222658.3615-1-kuniyu@amazon.com>

--7o7lzmim7rza4zom
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 03:26:58PM -0700, Kuniyuki Iwashima wrote:
> From: Joel Granados <j.granados@samsung.com>
> Date: Fri, 5 Apr 2024 09:15:31 +0200
> > On Thu, Mar 28, 2024 at 12:49:34PM -0700, Kuniyuki Iwashima wrote:
> > > From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kern=
el.org>
> > > Date: Thu, 28 Mar 2024 16:40:05 +0100
> > > > This commit comes at the tail end of a greater effort to remove the
> > > > empty elements at the end of the ctl_table arrays (sentinels) which=
 will
> > > > reduce the overall build time size of the kernel and run time memory
> > > > bloat by ~64 bytes per sentinel (further information Link :
> > > > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.o=
rg/)
> > > >=20
> > > > When we remove the sentinel from ax25_param_table a buffer overflow
> > > > shows its ugly head. The sentinel's data element used to be changed=
 when
> > > > CONFIG_AX25_DAMA_SLAVE was not defined.
> > >=20
> > > I think it's better to define the relation explicitly between the
> > > enum and sysctl table by BUILD_BUG_ON() in ax25_register_dev_sysctl()
> > >=20
> > >   BUILD_BUG_ON(AX25_MAX_VALUES !=3D ARRAY_SIZE(ax25_param_table));
> > >=20
> > > and guard AX25_VALUES_DS_TIMEOUT with #ifdef CONFIG_AX25_DAMA_SLAVE
> > > as done for other enum.
> >=20
> > When I remove AX25_VALUES_DS_TIMEOUT from the un-guarded build it
> > complains in net/ax25/ax25_ds_timer.c (ax25_ds_set_timer). Here is the
> > report https://lore.kernel.org/oe-kbuild-all/202404040301.qzKmVQGB-lkp@=
intel.com/.
> >=20
> > How best to address this? Should we just guard the whole function and do
> > nothing when not set? like this:
>=20
> It seems fine to me.
>=20
> ax25_ds_timeout() checks !ax25_dev->dama.slave_timeout, but it's
> initialised by kzalloc() during dev setup, so it will be a noop.

Just sent v3 with this change.


--=20

Joel Granados

--7o7lzmim7rza4zom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYZShgACgkQupfNUreW
QU+ckAv/ZCwg3conSwfw9FdBTIyF2Tr/m3ucbFQrfwVIpiZTkJxAeSTbI2tY6LyI
C7kdP6J8fHU7V7HjjCfYKXahRksz5KiH4DQn0RuHOxJD22HRLHz0r6wS2Kh3E4i5
MQGuMNR45oLJRShpLRXA8jGmtPTk8Y6xyUewumuNSArW9h69nfphXIhrbf2oEdXL
xrZhKTUATlK1jQKrfU07h3iXfaaqClzMdyIPJ9T0nkD0L1njo2JtkIqA9YXTQOtb
D9pYMA07IVXpjJfp8/Q49xxEam5P+LgGLN/0+wv9Wu9FZZcpHHF5fFtnAU40//YX
/mfuYehx5eo3iStDmWqpwacOTVxOY2dKTEXmXlsNbaRNi+RmlExJ313YCjS/J1M/
FW5v4W8JGMygK6IFZj1+sWUrryBc5V5KGErp9oldNUHsl6TY47ImmMN8gBU7okO/
vKw2oVt3Zi5Pm9W373Qbrz05AnT/koa/h2w0tbvaHoWjkgqSqpuPXdLHCFxpqViz
0PNrCcrH
=YAL9
-----END PGP SIGNATURE-----

--7o7lzmim7rza4zom--

