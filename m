Return-Path: <linux-sctp+bounces-133-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AB68B8766
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C0B21C218B2
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B9502B2;
	Wed,  1 May 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qtjfimlG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75BD482F4;
	Wed,  1 May 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714554987; cv=none; b=VlPsjZAIIf2c9RRZrDoG/VbU6apQqB32aX2o1e8wu3eq63GmAgSVrg6vAi/IkLzvD8d0GNb69+PpL7ilhe/VL8Z4gQlAcvyqqYYMQeDQKwm3SFi8qYLutS2c9OihFiHXftb5PQwwyHA33YQu84asoKV5AUJx9tI71QSyAZJkAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714554987; c=relaxed/simple;
	bh=Bh9hPo2uey5lp23nsLdXOm90vyuVIwTkNvDgSmEOXq8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=jZtc99Cm4PanMAXQtWFb4j74c9Gx5agxLJSeDuiwZXS41guKw+XV5B1vgkbJbncapDtzMR26BRupKNk5+g+W7rtuDgkd/AokwyQnUij/7CH9HPHPh/y1bq+v4Y+balHrQ2rRkZ4gMh54wcngiL7QdNzbQ0IO+bKd66ZcwCSyN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qtjfimlG; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240501091622euoutp0185062aa4c3a99a27921905bcb8f2a125~LUqwcVgkR0419604196euoutp01A;
	Wed,  1 May 2024 09:16:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240501091622euoutp0185062aa4c3a99a27921905bcb8f2a125~LUqwcVgkR0419604196euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714554982;
	bh=5IGaB0xRZYtjliALLSGXpUihG1E6qjKnUGlfcVQzZ1I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qtjfimlGHbq5/hF+JLl8nhyG/6SrdDTPVWuo6f+Z/hrnSqbcVIs/Rs95GmglC9FCy
	 K4UJYONi8Bi14WpSE0AyZGm7xZafwtwlJqsCXOMYGENE9/kFQY4/egfa9XH0/fohSm
	 FBpETMovwcjIMv+k/7phXTIyIcDfZiTLWa3uQkGA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240501091621eucas1p2b2c7ce9b2c8cc3831fb047063b819cf8~LUqwIAHw42837328373eucas1p2z;
	Wed,  1 May 2024 09:16:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id AE.8E.09875.56802366; Wed,  1
	May 2024 10:16:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240501091621eucas1p2c3ccea8dafd966d43988e22a23eead6c~LUqvh_fcP3008530085eucas1p2l;
	Wed,  1 May 2024 09:16:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240501091621eusmtrp1fb724c878928a0f89f2f93afabd24c18~LUqvgZuNc2733527335eusmtrp1G;
	Wed,  1 May 2024 09:16:21 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-28-663208658582
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id DC.F4.08810.56802366; Wed,  1
	May 2024 10:16:21 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240501091620eusmtip131dc9f3268c7188765a5db272b94006c~LUqvNBdzi3152531525eusmtip1E;
	Wed,  1 May 2024 09:16:20 +0000 (GMT)
Received: from localhost (106.210.248.68) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 1 May 2024 10:16:20 +0100
Date: Wed, 1 May 2024 11:16:14 +0200
From: Joel Granados <j.granados@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, Steffen
	Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Matthieu Baerts <matttbe@kernel.org>, Mat
	Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Ralf
	Baechle <ralf@linux-mips.org>, Remi Denis-Courmont <courmisch@gmail.com>,
	Allison Henderson <allison.henderson@oracle.com>, David Howells
	<dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, Marcelo
	Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
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
Subject: Re: [PATCH v4 1/8] net: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240501091614.7r6wded6quegxr6z@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="kxagwr5qamp3g4z2"
Content-Disposition: inline
In-Reply-To: <20240429082219.3qev2nzftzp2gecc@joelS2.panther.com>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTbVATZxSFfXc3yYJgl2jrO6C2pKBWUDTa8Wqtyqjt2hk7jtP+qJ2WprKo
	rQSagCAd20BAhUgMYsunfFpAosESCKCoJCpIoIBVLDpSBwSpSMEaCB8qlLA4dab/7jn7nPue
	+2NpUpxEu9N75WGcQi7bJxE6U6ba0ealHC0NWj6c5wcW1WroqE4QgCr2EAFxVRMUmPI1BEy0
	9xDwouowCbaOHgFk5xmFkNkcS8GLPzRCuHmyi4D+mGcUGM7HEdBd2ykCU6IegT7mHgUVPcNC
	0PTOA3X5EIKuY50CuFXwRAijBcUiuD/UScGodiakJagJaNQEQ2V7FwUtJq0AdNYVcLuinYCb
	5zOF0FLTIICHlkQKdLlqErpzHgvgXnIBBTUXsxF0lgwQoM5+SoLa9oCEsaI6ATQlTpCQbigm
	oU3XjeDK4UsCaCyJEYE96zoJF7NVFNTmvAE6g5UCe0MfgpS+VhJ+r/YC6+AEAU1GmwBsmYsh
	uaiMgAvxIyIoa/4GrGNWAh4M9whhom0DRDeaRBv92budQyTb31SP2Kwz37MZqhsUOza6hC07
	fYdgNVd7SbYqvV3Emmq82ZzScPa55VcRW1ocL2SvnT5LsFUda1hdXg1ijad+3O6503ldILdv
	735O4bf+K+c9DefyUeiYS+RISRKhQvEzE5ATjZlV+GrRA1ECcqbFTBHCqofGaTGIsKYni3BQ
	YsaGsN5MvEzoNVqChwoRNjQ1U7yYhM5ohxEvjAgPlNeQjgjFeOH4MRvlmIWML27uuzflz5n0
	Y41pU2mSqRZjrf2SMAHR9GwmECclKx2jK7MR1/e7OHBXxg3Xp3VNrSGZSPz82nGBAyEZD1w4
	TjtsJ8YfZ/amUHxRCU5MPTld+iC2lt2dKo2ZGy64sfUX0pHFzGZ890okz8zGvXVlIn6ehxuS
	j1I8n4zw5fEnIl7oES6IHpre+h6OvdU1nfDH2YZyAb90Fm77243vOQsfN6VMv+WKjxwS8/RC
	rP+zj9Kht9NfuSz9lcvS/7uMt31xzoWnwv/ZPrgg9zHJz+9jg2GAykGiYjSXC1cG7+aUUjkX
	sUwpC1aGy3cv2xUSXIom/9SG8brBSlTY+88yCyJoZEFek+HOc/oW5E7JQ+ScZI7riVy/ILFr
	oOxAFKcICVCE7+OUFuRBU5K5rt6Bb3JiZrcsjPuW40I5xcuvBO3kriK0a8eP6NgvtwyxI0Ge
	iWs1qwZ707ul+favd55tSf6sdtCcusBno27+xdfdpM0f+vrVj1col1879uxdt3bniKdESknA
	pk93IdkVa+hYsb0InnUtXxn7RVxYlMemQtmaYz+YFdsbK4nXON/LZvMsDZu5NCJaVnugwy7Z
	FhfpPeT1c+T8kMFNdcaO9dEeLndq1yy437CVvm4ZcZG/890pv6i3GhWLzvnuz7lkT6nI3dwq
	Vm/Z9tfq6oczfnp8++PfjmbgCNvBoKbFbqEZ9/uPSD85Mb5o9YWVM1IP7CDCzQvNjyTKrdlh
	bQHl66RFyD1qg29c65OsF7d8hKbPS1yknh990KP2eaTYIaGUe2QrlpAKpexfXewBpyQFAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTa0xTZxjedy5tQXDHyrYjkmzrNDiVQpHq20UdJjMc0en8MZZtOGj0CGpL
	SVvMZCFWy0XagVWcaK2ADBFhFqSIgNzCJo6LojAdTjoECwgiwqpyhxW7ZSb797zP7fvyJi8P
	5xdxPXl7otSsMkoqE3BciaaZG1Yflue/2+9etQvUadZAV6WOBE18IgYJ5bMElP6ox2DW2ofB
	dHkSDvauPhIysy0cMLXEEzD9u54DbWdtGAwdniTAXJGAQU99NxdKUwoQFBzuIOBq3ygH9ANe
	oL3yAoHtaDcJv+UOc2A8N58LnS+6CRhPnQendVoMmvVyKLPaCLhdmkqCoVEE965aMWirMHHg
	dm0TCb11KQQYzmlx6Ml6QkJHWi4BtVWZCLoLn2GgzfwLB639EQ4TeTdIuJUyi4PRnI9Du6EH
	wc9J1SQ0Fx7mwsuMX3GoytQQUJ/1NhjMjQS8bBpEkD54F4fWyiXQ+HwWg1sWOwl20zJIyyvB
	4FryGBdKWvZC40QjBo9G+zgw2/4xHGou5QZuYP7ofoEzQ7caEJPx03fMGc0dgpkYX86UXLyP
	MfpfBnCm3GjlMqW1S5ms4hhmqu4ylynOT+Yw1y9ewpjyLgljyK5FjCXn4GfvfyVcq1TEqNn3
	IhUq9TrB1yLwF4okIPQPkAhFq9bs+MhfLPBdv3YXK9uzn1X6rg8XRuqrGsjoMbdvHw9YCA1K
	mqdDLjyaCqAL9KmYDrny+NR5RLf2PiScghd9+fld0okX0lP3dBynaQTRlh+GSOdgQXRO4Qya
	cxHUEjp5wv4qzaFW0i2DHfgc9nDw8ZbTxFwApyr5dEN/NXdOWEjtovOqvncIPJ47FUg3DLk5
	S8/gdEJ7xqun3akFdMNp26tSnNpPm4wa7pwfpxbTF2Z4c7QLtYE2DaT/82sBnXLqLObEcbR9
	uhcZ0ELja03G15qM/zU56eV0+0w/9j96BZ177gnuxOtos/kZkYW4+ciDjVHJI+QqkVAllati
	oiKEOxXyYuQ4l9L6cUsZyhgYEdYhjIfq0BJHsruo4DbyJKIUUazAw/3EOd/dfPdd0gOxrFIR
	poyRsao6JHZs8Rju+dZOheP2otRhotV+YlHAaomfWLJ6leAd903RR6R8KkKqZvexbDSr/DeH
	8Vw8NRhx0vb5g8jeZv+VPtbqmMSN9VLPooroBQ+rA7xr3HTilmDloUsh1OVgc+bYopkti2mN
	R+fkqKuIjLeGTMaFTAhbjyvlEbae7WWKKxl3OtKVPluW9vumDYbmhXllfRIkXhnhHTxTuCM6
	qH734/lftuzz8ivcBmEybU2DqVcVuCA8f1/VGyM1sabQE3FHho+HeMg1ys0+n37Bu2ZMzfG+
	3iuTnHoQKz54qdJMvvnn/K1U0rag7QnyxE2BbZMFOx/cFKbluKmrcmSuyRvf/VB97HqN5CT9
	9IPUpz3eoX3frFhkOR97c39ncVpT80jNsubs7KnwC5v3JnaUTRUNB3ke2Lz1Pr9mhYBQRUpF
	y3GlSvo33vQ56sMEAAA=
X-CMS-MailID: 20240501091621eucas1p2c3ccea8dafd966d43988e22a23eead6c
X-Msg-Generator: CA
X-RootMTR: 20240425225817eucas1p21d1f3bcedc248575285a74af88e66966
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240425225817eucas1p21d1f3bcedc248575285a74af88e66966
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
	<20240425-jag-sysctl_remset_net-v4-1-9e82f985777d@samsung.com>
	<CGME20240425225817eucas1p21d1f3bcedc248575285a74af88e66966@eucas1p2.samsung.com>
	<20240425155804.66f3bed5@kernel.org>
	<20240426065931.wyrzevlheburnf47@joelS2.panther.com>
	<20240426071944.206e9cff@kernel.org>
	<20240429082219.3qev2nzftzp2gecc@joelS2.panther.com>

--kxagwr5qamp3g4z2
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 10:22:19AM +0200, Joel Granados wrote:
> On Fri, Apr 26, 2024 at 07:19:44AM -0700, Jakub Kicinski wrote:
> > On Fri, 26 Apr 2024 08:59:31 +0200 Joel Granados wrote:
> > > Sorry about this. I pulled the trigger way too early. This is already
> > > fixed in my v4.
> > > >       |                ^~~~~~~~~~
> > > > --=20
> > > > netdev FAQ tl;dr:
> > > >  - designate your patch to a tree - [PATCH net] or [PATCH net-next]
> I'll add "net" to my V6. I wont change the my base commit which is
> v6.9-rc1.
Actually, I added net-next and rebased onto net-next/main. Please advise
if I need to rebase to some other branch in
pub/scm/linux/kernel/git/netdev/net-next

Best

--=20

Joel Granados

--kxagwr5qamp3g4z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYyCF4ACgkQupfNUreW
QU95/Qv/X8C3z+cUo5mFZSH58JGLjuIFRnItgNnJEsWPKxRWReISYkCaty681/oU
CncRPcbCh4zH0r+DsBl7Xd9HS7JhqeB32eucmqy/z69+qJE2OOR6RjJCAP/+/byy
5rHGpkWngTnn9Yau3W0F1I8G+sqSVnVDdOZucZ6/MlhBpbYiDQcp+rgeHnT+c/6z
YAFVuQtHBuVXfWLw8wb3rzHvNRGy6BA8slN0vM1JguHp4StbFz0jaJnhA+0M8lZJ
sucA8jryk6C9tr3bi4l5fOcsfdIZrljIt1ZJZzO7rjpVrLQRsgtec3JSZH6ySkqs
E8xl7P335ASWdVK18TGWdQ1LcG/X9QEk61Pcrk62O92DUh7exe1N29JENjKtJ/h2
vjG6phdtdeVwCrlC2XrSSZ6pZzSi52zDWd7GssuA21G7rtxWyIaKyDs4WbuaISpe
SPbpyrDhvRrM/7B/kGi7WJX40zPeuAPcOQApOKpg2vT2FlmlruQtOmF683lfB3u2
o8diyPqJ
=WVyX
-----END PGP SIGNATURE-----

--kxagwr5qamp3g4z2--

