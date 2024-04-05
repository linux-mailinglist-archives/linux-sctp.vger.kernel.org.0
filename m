Return-Path: <linux-sctp+bounces-60-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC63A899E60
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Apr 2024 15:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F532873E0
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Apr 2024 13:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5A16D9BA;
	Fri,  5 Apr 2024 13:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YKhX3vsr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FE16D4FF;
	Fri,  5 Apr 2024 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324052; cv=none; b=W+QcWlksg8NbOP19gT1zfwpZYBe1loxKUUY3eov7T1nLF/IF+GCjsQrj7x2BaQtIIB+rru5ncuItdHQZh2fH6uxRhMf5f8kxUcVzhhPiLoDTqMjwEZh2f365UEMfvpa88+c9Q1FQD3I1NMR5eEzv7g6ADtQHtHTAZGHUaboe3Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324052; c=relaxed/simple;
	bh=LJj/6K9S0mccLf8EzL0tHISHfup0kONjt4pdLG952wc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=L+jkd/K7nSJIY7eKRSmcYMNDScK7m6nj3NiTEf5A5RqjpENk2u9NRpUgG91O2FZMkkMUeYH/5F450J6clGNFQJmF8aGNbifalj8uwU55Qs1V4eDCj6Lp9WG5J8kCA/lK3XNwlCq8DnIAnm4j9y2IHh9f4I6IzKrgmkKxZvSweoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YKhX3vsr; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240405133401euoutp0130e9bdebb3e41d400edfa9e541a3840a~DZaS-L9et0180601806euoutp01z;
	Fri,  5 Apr 2024 13:34:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240405133401euoutp0130e9bdebb3e41d400edfa9e541a3840a~DZaS-L9et0180601806euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712324041;
	bh=i+a4M7yICQ2HnP92i8Uv6JJWR1edpPHj8jQXZpZYBH4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=YKhX3vsrA71sZeueE+2+MgNpe71G3PLv4t4SN6kD8caKNpwMl0UBDtLeuO2mObwiD
	 dwf35oPYrx7CMhrIrJ2KyMWZTpLXasIrnmh5Gj1fWMcyMHtpPj68JGhl01Ql4gy5i6
	 gk/EctOtGYb6SPs3o1drGd49WVWPSiDlcygGXDoE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240405133401eucas1p180bf7886e5501a175873e1fa6d28381b~DZaSwD5pi2523125231eucas1p1e;
	Fri,  5 Apr 2024 13:34:01 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.83.09539.9CDFF066; Fri,  5
	Apr 2024 14:34:01 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240405133400eucas1p17a657be41afd1be881bbb599e769968a~DZaSKzIvA2124621246eucas1p1f;
	Fri,  5 Apr 2024 13:34:00 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240405133400eusmtrp15f4b2e2b477b0577c76ad47d2a727a34~DZaSJSYyi1386013860eusmtrp1Y;
	Fri,  5 Apr 2024 13:34:00 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-54-660ffdc93c52
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 94.A3.09146.8CDFF066; Fri,  5
	Apr 2024 14:34:00 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240405133400eusmtip2bf1c1d03faee0a07935c7405979e5cff~DZaR2giF20852408524eusmtip2m;
	Fri,  5 Apr 2024 13:34:00 +0000 (GMT)
Received: from localhost (106.210.248.212) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Fri, 5 Apr 2024 14:33:59 +0100
Date: Fri, 5 Apr 2024 09:15:31 +0200
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
Message-ID: <20240405071531.fv6smp55znlfnul2@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="h65h3fnxnuqgv2vq"
Content-Disposition: inline
In-Reply-To: <20240328194934.42278-1-kuniyu@amazon.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTaVBTVxj1vi0BG/sExVt0uiA4rdpQHGf8aNVSu/BmOhbH6Q+rUys2T0Qg
	KJG6UDuRRSQBZMQWiRAQbViiQCEN4FIRWUxAwKKFUlCJLIogaliESKjh2daZ/jvn3HPuPefH
	FZMuqWJ3cbB8Nx8hDwz1YJwpY+1407umyVe3vfeXxRmqlCug64KKBmXsIQLiKqYoMJ5SEzDV
	2UfAZEU8CdauPhqyckoZyGiKpWCyVc1AS2Y3AQ+jbRQUnosjoKfWIgJjkh6BPrqDgrK+MQbU
	/Qsg5tcRBN1HLDTc0D1iYFxXIILbIxYKxpNnQroqhoAGdRiUd3ZT0GxMpkGXeJaBFLMP/FHW
	SUDLuQwGmivraeitSqIg5WQMCT3ZD2joSNVRUHkxC4GlaIiAmKwnJMRY75IwkVdHQ2PSFAma
	wgIS2lJ6EFyJ/42GhqJoEYxqr5JwMUtJQW22G6QUmikYrR9AkDZwk4TfL3iCeXiKgMZSKw3W
	jLchNc9AwPmEpyIwNO0A84SZgLtjfQxMtX3ot4bLa1bRXLtlhOQeNpoQpz0TxZ1QXqe4ifHF
	nCH/T4JTV/eTXIWmU8QZK7247JJI7lnVLyKupCCB4WryzxJcRZcvl5JTidZ5bHReKeNDg7/j
	I7xXb3HenpRlInY+dNtrGotllCjHVYWcxJhdjq9eu4BUyFnswuYhPDqqfUGGET5qbmAEYkV4
	vMFMq5B4OmK8EyLouQg3Dt5H/5rKDkYTAjEg3NtejByPUKwn1qa3TGOGXYqbBjpIB57DvoMP
	FybSjgDJlkqwKaGVdhy4stvw01s90wEJ64ev3LxMCng2NqV3Uw5MsnvxTycNjKMSyc7HuXax
	Q3ZiV+DLE1dfNF2IHxStFHYewGZD+3Q3zF57Bd8Z7iAEzyf4+OBGweOK++sMIgEvwPWpiZTg
	T0X4kv2RSCB6hHUHRwjB9QGOvdH9IvERHrQeZIRLZ+G2wdlCzVn4qDGNFGQJPnzIRXAvwvpb
	A1QKWqh5aZjmpWGa/4YJshS3/Xjs//ISrDv5gBTwKlxYOERlI1EBmsdHKsKCeIWPnN8jVQSG
	KSLlQdJvw8NK0PO/Wm+ve1KOMvsfS6sQIUZVyPN52FKsb0bulDxcznvMkaj9JNtcJLLAffv5
	iPBvIiJDeUUVmi+mPOZJvGRv8C5sUOBuPoTnd/IR/5wSYid3JTH3XrK0J/jr6vW2kXMxa8JP
	H/c/Eaa3Sb12GDYHtLttjdd1bvBM2Fw5Kf7YL65r0zq9tzRf0hrVO7DB356hza1vOpaoeOux
	XRTifcBW8ZpMvW7J+gDb6j2bZvhmBTyZ6T/zVLuxvDjc//aX93O+6nWupkprX5+x98YP9fsj
	7YO7bJKoVa5vLpc1RLXKrGn93td3pJ5Z5f4Zu+XTn6X2zEdOh3WyZWO+z2ruVcbNqQs+v3C9
	ZthkWfv92mpl36VivHGXZCihw3KnJ371ikixJWPLvRq6qKhh2HvJF76LLO9/HpBdoq2+NBdl
	bGrW5S4VNZ/WrJka9twnXTw5FL5blb51WbW2RW31oBTbA30WkxGKwL8B0oUGfSYFAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0yTZxTGfb9Lv4Jp/KSKn+AWUzHZQAtVLqeLMDTRfRqzuItb4txKI+Uy
	LjUtJehmRkBEC2iNMYaKgM51QGdraQFRYAgOoVwH4i2UjVokQgNqQe4wsFlmsv9+73PO8+Sc
	Nzlc3Osm5cONT06RKZKliQKOJ9G6cL9/a/P8qpigdudGaEgPg4EaNQnpJ09hkFW9SEDlzzkY
	LNqGMJivzsbBNTBEQtE1MwcKOk8SMP8ohwM9VxwYjGbMEmC4nYXBYJOdgso8PQJ9Rh8BVUOT
	HMgZ3gCZFRMIHOfsJDzQveTAtK6Mgr8m7ARMn10J+epMDNpykuCWzUFAV+VZEnS5NzigsYrg
	YZUNg57bBRzoqm8l4XlDHgGaq5k4DBaPkNB3QUdAfW0RArtxDIPMotc4ZLqe4TBTcp+EjrxF
	HLSGMhweawYRNGbXkdBmzKDgTWEzDrVF6QQ0FXuDxmAl4E2rE8ElZy8O3TV+YB1fxKDD7CLB
	VfABXCixYHDnzBQFls7vwTpjxeDZ5BAHFh9/HLmLLelSk+xT+wTOjna0ILbwtx/Yy+l/EuzM
	tD9rKX2CsTn3hnG2Wmuj2Mr6zWxxuYqdazBRbHnZGQ77R+kNjK0eELOaa/XogOCQcIdCrkqR
	bYyTK1PCBd+IYJtQJAbhtmCxULQ97NuPtoUIAiN2RMsS41NlisCIKGFcj9ZMHHV6p+UZm6l0
	VMxXIy6XoYOZyr8T1MiT60X/gpj+GjOlRh5L+gbGNN5LupnPzD1Uc9xNrxBTce4U5n5YEKPT
	G992EbQfU5jfg5aZQ29hOp19+DKvoT9kThtyyWUDTpt4jFPf+bbAp2OYqf7BtwYeHck09t7F
	3amtiGluHaHchdVMS76DWGacTmVsHU/I5blx2pf5dYG7LHvQYczdmWbSvc4mZsS4wz31CcY1
	/xxpEF/7TpD2nSDtf0FueQtTXdHH+Z8cwOiujuBuDmcMhjGiGFFlaI1MpUyKTVKKhEppklKV
	HCs8Ik8qR0vnUtk0bb6FCodfCRsQxkUNyG/Jab+p70I+RLI8WSZYw8uJ5MV48aKlx47LFHKJ
	QpUoUzagkKVfPI/7rD0iX7q95BSJKDQoRBQcKg4KEYduF6zj7T16WupFx0pTZAky2VGZ4l8f
	xvXwScdW54q7V3xCx2wNlkb47tvc2ysKj9e6Ht7BH3EDo8LKcwPfN+6J5Zu+POjTaZH46jcF
	DHnu3//13cMV2kONA/YXPWPrAvhJT9OyS85JnZdgxXftLe/xHk2I7RfruxKuMD/yuUdqHgum
	j2EoYmGmfXb0QZuJYAu/qnLNOrzF+etflBJ54VZV5tzE+i2afThluyepbynqCKBt/o7JE6mp
	Duz1yGRjo393amSo12e75yjs89hVRtVxicgsnzuQldHktWvtzsUoiemnoZ3XLd1ZebVfNB2+
	Hri9LcSSPfVSsqfG2lanTzO0rwzUjad+ahLX/W5OiK7oDw/wz927W375YNZ5AaGMk4r8cYVS
	+g8887p5wwQAAA==
X-CMS-MailID: 20240405133400eucas1p17a657be41afd1be881bbb599e769968a
X-Msg-Generator: CA
X-RootMTR: 20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a
References: <20240328-jag-sysctl_remset_net-v2-4-52c9fad9a1af@samsung.com>
	<CGME20240328195008eucas1p2fc32577c64a80424c10f30e4f69fc11a@eucas1p2.samsung.com>
	<20240328194934.42278-1-kuniyu@amazon.com>

--h65h3fnxnuqgv2vq
Content-Type: text/plain; charset="iso-8859-1"
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

When I remove AX25_VALUES_DS_TIMEOUT from the un-guarded build it
complains in net/ax25/ax25_ds_timer.c (ax25_ds_set_timer). Here is the
report https://lore.kernel.org/oe-kbuild-all/202404040301.qzKmVQGB-lkp@inte=
l.com/.

How best to address this? Should we just guard the whole function and do
nothing when not set? like this:

```
void ax25_ds_set_timer(ax25_dev *ax25_dev)
{
#ifdef COFNIG_AX25_DAMA_SLAVE
        if (ax25_dev =3D=3D NULL)        =B7=B7=B7/* paranoia */
                return;

        ax25_dev->dama.slave_timeout =3D
                msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) =
/ 10;
        mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
#else
        return;
#endif
}

```

I'm not too familiar with this, so pointing me to the "correct" way to
handle this would be helpfull.

Thx in advance.

Best

--=20

Joel Granados

--h65h3fnxnuqgv2vq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYPpRMACgkQupfNUreW
QU+GdwwAk+SQw0o7uu63t5QC8II75UQQXXzD86NcnboVLtTTKuPbn2y+rcWUY7tu
RfnrQvG2ui15fSX0cYv66um6AIlYtvOAjlKfh5wBAA3YZQdmnSTGuHW8vcu5B6Iu
WdjX4C12SNI/7Y8S7yLZurWvE5QrS/RHQ5sHtDfNm/HUmIoylsHmbuNvwxrOdzFH
xxfDDdCrT5jxjVmr0Ctx3tJEmAHnkUD5voVBT1p6bJNNUOdYK986gsCYlgJpYuqE
J3hSfJnhAnMGJcmtfnTXwoaje7XN5opqF9qaSinY7HaEoidu6pRGCA/M8a6N+PT7
wBYhl0umuMOOBkqS7o0HtadAx6yv2fO7sOiZl4ZXvA9fRWam40n2CvKGZmF2koPs
KRllZIQ+Uh+pbfhN9g6w0Mbjb10W9sFaZdN7CsEKKk6nxmkmgH/2PmmNhwYkdgXG
7SLMAqeOLP/ZtTEypd2LzGdpLvjZq54jgAcB2c3cQI8jb4eogkqaMeazsf247+zt
i5D8SOSY
=Yv9S
-----END PGP SIGNATURE-----

--h65h3fnxnuqgv2vq--

