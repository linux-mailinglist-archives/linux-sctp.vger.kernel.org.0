Return-Path: <linux-sctp+bounces-62-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97289B86E
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Apr 2024 09:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8148028353F
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Apr 2024 07:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9982561D;
	Mon,  8 Apr 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R4igch+N"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EAE2576E;
	Mon,  8 Apr 2024 07:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561502; cv=none; b=Gu4p7a/1YW86BExy7b6+HbQc+5V00Zm9ptdqlDl65yoyfbn3zFN/IAYUVA8vUsyHm38ufM9gJa2SC5FO9wITwVuX8dRQTY/V2IYjMyUALeiALIFFbMsHaY8RDarszHbSh8KCELisc4WIqtJ9nBmlmoWdQnSSsU3m+lF5pTNm+nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561502; c=relaxed/simple;
	bh=lmsBm5nTnffgSx2fS/ryKsYEj/upOdvS9elDu44URUg=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=UtEMZdJ1z/lvf1NtUxBWEaKTxHfr5IFqPc3yHLUkwz4jj+tDm4OAZ1ZWUieTEvSoLLLojpTUHnIT0STMhEu7QXOY2+CELlwMf3uOo2oWIqn/UHQS+FfNw2yitburOkUXqJdDow0Box0OSiCUqhmXRn4/76YVekkTsNQqvWg2TfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R4igch+N; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240408072050euoutp02410e3d635aa40075dd940878b76f66a4~EPQUwTE-M0578505785euoutp02B;
	Mon,  8 Apr 2024 07:20:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240408072050euoutp02410e3d635aa40075dd940878b76f66a4~EPQUwTE-M0578505785euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712560850;
	bh=dic+LWsSv8Akr20ymbAxctCZm+7tnRnSHjjKdWufs+M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=R4igch+NX9vZcyEjz9xuRWmkA2q91FagNMFNpqwDiitOV/D+OsI7RYwSyzHBsmqyX
	 ZbUGCEyohbKzcPinP/cCJzFkJJPMzO2eVGE/eOVVrc004e5YNvgIGJZePbaWm9q22j
	 YVQMOM9+DH6PHsDVg1joqLelPhU4kImKEQjIhdvY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240408072050eucas1p1a8c0beb906ba7d9b12d86046bb4fa42d~EPQUi2_Q42048920489eucas1p1M;
	Mon,  8 Apr 2024 07:20:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id CB.3B.09624.2DA93166; Mon,  8
	Apr 2024 08:20:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240408072049eucas1p2bc84263f53c4eb375742a6739a2f8fbd~EPQTyuEjs2668926689eucas1p2J;
	Mon,  8 Apr 2024 07:20:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240408072049eusmtrp113df4514d474d7cbd59d368c0190ea5e~EPQTvd1e20866108661eusmtrp1J;
	Mon,  8 Apr 2024 07:20:49 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-fe-66139ad20952
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id ED.02.09010.1DA93166; Mon,  8
	Apr 2024 08:20:49 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240408072049eusmtip1eaef4a235fff5b1d93272c279edd8416~EPQTa7RNP0059900599eusmtip13;
	Mon,  8 Apr 2024 07:20:49 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 8 Apr 2024 08:20:48 +0100
Date: Mon, 8 Apr 2024 09:20:43 +0200
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
Message-ID: <20240408072043.j5p3dcyalm5yrozo@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="a36pnpbxxry3pzoc"
Content-Disposition: inline
In-Reply-To: <20240405222658.3615-1-kuniyu@amazon.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeUxUVxTGc982M1TwAUZulCpSpBUVi9X2VK1So/aVNpFg26RNrJ3CA5HN
	zIhLGxvKqmyOLIJTEMRkGAcc6YDoqMAULchABAVZJoAwDJIiLmVHWQo8jSb973e+73z3nvPH
	EZN2aeIl4sDQQ7wsVBrszFhRpVUT9WvvK+39P0xvXgSVEZ9A9814GiKiYwmI0c9QUHohgYCZ
	jj4CpvRxJAx199GQk1fMQFZ9NAVTLQkMNGZbCHga+ZIC7fUYAnqrzCIoTSpAUBDZTsHVvjEG
	EvodIerKCALLKTMNTarnDEyoNCJ4OGKmYCL5HTgbH0VAXUIIXOuwUNBQmkyDKvESAwqjBzRf
	7SCg8XoWAw2GWhoeVSZRoDgfRUJv7mMa2lNVFBjKchCYLz8jICpnkISooR4SXqirabibNEOC
	UqshoVXRi+BWXDkNdZcjRTB67g4JZTkRFFTlLgaF1kjBaO0AgoyBByTcv+kCxuEZAu4WD9Ew
	lPUBpKpLCLhxclwEJfUHwPjCSEDPWB8DM63bPLdz6oZ4mjOZR0ju6d0axJ0r/JX7I+Iexb2Y
	cONKLrYRXMLtfpLTKztEXKlhJZerC+cmK/8UcTrNSYb7++IlgtN3f8op8gzI2/kHqy1+fHDg
	YV62butPVvsHux6IDg46Hs3R/RiBTA7xSCLG7AasnX5OzbEdq0ZYkxEYj6xmeRjhtKk2RiiG
	EM6/pBC9TujTz9CCkY/wqDrlTZdpYooSCh3CDbpJei5CsS64JUUzzwy7BtcPtJNzvIhdhU9o
	E+efItlia5yRcRrNGfasPx7v7J1na9YT95ieEQLb4pqzlvlpSfYo1k1OzfaIZ3kpzp8Wz8kS
	9mM8Vq0lhVFX4JELnZTAx7GxxETM/YXZBwuwuaARCcYOfK+ujxHYHvdXl7za0xHXpiZSQiAV
	4Yrp5yKhKEBY9fsIIXRtxtFNlleJz3FF3tj8RJi1wa1PbIVBbXBKaQYpyNb4RKyd0O2KCzoH
	KAV6T/nWasq3VlO+WU2Q3XFrehrzP3k1Vp1/TAr8GdZqn1G5SKRBDny4PCSAl3uE8kfc5dIQ
	eXhogLtvWIgOzR5r7XT14DWU3f+veyUixKgSucyGzUUFDWgJFRoWyjsvst6z0dbfztpPeuwX
	Xha2TxYezMsr0VIx5exgvdJvOW/HBkgP8UE8f5CXvXYJsWRJBOG9Xd8jfjjsPtTlF9P87rJy
	+wX3DdmrmsW7vyxav0nF9rTGpGxw+Wjr09kb3Ha5sJz18qlZX9Z27Ksz/6zLDAyjG31vbvzW
	a2DNE0nQkdbvJY9O7ewW5e8sDHIqMuzd1/V+tCu1OCt9f4LPvd1qvUe8W7bGxslk41vmWFgz
	8bXGx8lZ3jm+MO5MUnnqbabpeFrXptEQ29+W29MHv9nlMHZ4MsD4yJjputdjpPt07MKWYnPQ
	ahfvXVnLMo8Frc08fGXS1Fa2uMkpZWfFHYlPnjrFMu6yqSVqbJdX+7hFnNxhsfs51vPAns0v
	e1c0lQR/d6P8Vt/aHONf0i9cYTjWNSY8c4tBku7vTMn3Sz3cSJlc+h9Ib7zGJwUAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTf1DTZRzHe76/NrXZBMzvoXW6w/JX0wHDD56KaZ7fugzT6xdewcIvw4JN
	NuDMrJCBwPDHwstwiBuQEzadMWEyE+WwmPwQUFTQGxhjQCExdU5FBQJXl3f993ren/f7/Tz3
	3H24uJ+FE8jdKktmFTJJgoCaTDSO2jvfuKz1j1tiuiCA2rSl0H1WTUJaxm4MMm1jBFhLcjEY
	6+zHYMSWhYOnu58EXfEpCg63ZBAw0p5LQVuhC4Oh9CcEmM9kYtBb5+SAda8JgSndQcDp/ocU
	5A7MAlWlF4Frv5OEq4Y7FAwbjBy45XUSMLxvChxSqzBoyk2Eqk4XAa3WfSQY9pygQNMgguun
	OzFoO3OYgtaaRhL6avcSoClS4dCrv02C44CBgJpqHQLnSTcGKt09HFSeHhwel9pJaN47hoPW
	bMShQ9OL4ELWORKaTqZz4MGRizhU69IIqNO/DBpzAwEPGgcR/Dh4DYcrZ4Og4f4YBs2nPCR4
	Ds+DA6UVGPyS84gDFS1fQMPjBgx6HvZTMNYRsWo1U9qqJpmbTi/ODDXXI+bI8a+ZgrTLBPN4
	eAFTUXYDY3J/HcAZm7aTw1hr5jJ6SwrztLacw1iMORTzW9kJjLF1hzOa4hq0QRAlXK6QpySz
	s+PlyuQVgs0iCBaKwkEYHBouFIUs/XRZsFiweOXyLWzC1lRWsXhljDC+QW8jtt2ZtV2nuYvS
	UMcMNZrEpfmhtO2Hg6QaTeb68Y8i+syAB/MNZtHl96+RPvann15XUz7TXURXlbQQvoMF0b8b
	rZwJF8EPotvzjM8SFH8R3TLowCc4gD+fzjbveXYFzi/n0cNZR5+Z/Plx9KOuXjTBPP4quuem
	G/O11iDacKX0n8E0uv6Qi5hgnJ9K5/+UN97KHeeZ9LFR7oQ8iR9GP7Sbcd9T59Deki7Cx9/Q
	npE+pEH+2ueatM81af9r8smLaFulg/qfvJA2FN3GfbyCNpvdhB5xjCiATVEmShOVwUKlJFGZ
	IpMKY+WJFjS+MNa64YoqVDZwV1iLMC6qRUHjSefPplYUSMjkMlYQwNsknhbnx9si+WoHq5BH
	K1ISWGUtEo9/4/d44PRY+fj2yZKjRWFLxKLQsPAl4vCwEMEM3tvbsiV+fKkkmf2SZbexin9z
	GHdSYBoWw8Pr1hJ5a485/0iMUL7zpuDgfpejMTLakL1aPzd/Tk/mPGPSdx9y+0JGNiUnfa7K
	KLAf2fwo8rWkDRZ3Zt96R39qPqv66PyFmwWKre/9qR6tbPKavu2q9uzMckvx1IzdDyJdhwrX
	TJfuZI4e1zVpn+66vSWnyrs+iHo/JNISXtpiLyE+kX/QvmlZ/kslEoN0f8y614uag2c66lVD
	67dbrxa8EDafU51eP7/Rf05pHLrhLpReWjiC7O53u7ra1OL2qRt3DRtUo2UbI6QmeXxEcTn/
	xZzzfQFRutmxUz97NfatHQP7yCmF93qj3Odu5f315IBr0Z2P7byLpkunX5Gvo9YqoioFhDJe
	IlqAK5SSvwH5lVNtxQQAAA==
X-CMS-MailID: 20240408072049eucas1p2bc84263f53c4eb375742a6739a2f8fbd
X-Msg-Generator: CA
X-RootMTR: 20240405222730eucas1p16a0790be308342130a19a5b489ffae1e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240405222730eucas1p16a0790be308342130a19a5b489ffae1e
References: <20240405071531.fv6smp55znlfnul2@joelS2.panther.com>
	<CGME20240405222730eucas1p16a0790be308342130a19a5b489ffae1e@eucas1p1.samsung.com>
	<20240405222658.3615-1-kuniyu@amazon.com>

--a36pnpbxxry3pzoc
Content-Type: text/plain; charset="iso-8859-1"
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
thx. I'll solve it like this then

>=20
>=20
> >=20
> > ```
> > void ax25_ds_set_timer(ax25_dev *ax25_dev)
> > {
> > #ifdef COFNIG_AX25_DAMA_SLAVE
> >         if (ax25_dev =3D=3D NULL)        =B7=B7=B7/* paranoia */
> >                 return;
> >=20
> >         ax25_dev->dama.slave_timeout =3D
> >                 msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOU=
T]) / 10;
> >         mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
> > #else
> >         return;
> > #endif
> > }
> >=20
> > ```
> >=20
> > I'm not too familiar with this, so pointing me to the "correct" way to
> > handle this would be helpfull.
>=20
> Also, you will need to guard another use of AX25_VALUES_DS_TIMEOUT in
> ax25_dev_device_up().
Yes. I had noticed this already. This was a trivial one though, so I did
not ask about it.

Thx.

Best

--=20

Joel Granados

--a36pnpbxxry3pzoc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYTmsoACgkQupfNUreW
QU9ICwv6A6h0aHFqNdUCkstNuQDQL6/IKZsdnmejFWMbFZKYFjyGWo1/Qa5SnEmf
5aN4REQAWpaHGznkRrbgZHVET5CqmXOIbIvP/+AZsENF0RfL0CZW6hcEjRMUF6tb
jpJ8KT/wl2xmmvfCcZkV3rymYiOxwtp2lMdUM7Zx5QZ33CaStmeKvfoA8ngQX3Ri
u2fO/A856mzsUuUvYqJsCRqNfe9LQZQ7uFEY+0f31BpCagdivfXyFpvFk7Ol0tvB
k7DExa1ndy/G92OzYPEOsTdzRv9xlujgnBVHIapZ2Le6aZ1YGplwI3X+m1n7kNjV
X10vWmuQOZ81xz2n3ZjdCPmu6VfWkwyBfkaVJ/ehqjYkfQ8+s80iSRxU/g6EV2oX
fsfSUYyolzz1Vp8nllQRiWuygSAIeaLlpXl+vwa7rQKSdLYXsoC8YqM/gEBUThe3
X/KQMPBl7qYM2CqAkoar8omqvkBratmAJwScZQEqZxGmosEn4KWDWc4de3toUFCR
JsRQKj4e
=iYz3
-----END PGP SIGNATURE-----

--a36pnpbxxry3pzoc--

