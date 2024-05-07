Return-Path: <linux-sctp+bounces-158-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A18BDCD6
	for <lists+linux-sctp@lfdr.de>; Tue,  7 May 2024 10:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E001C2312F
	for <lists+linux-sctp@lfdr.de>; Tue,  7 May 2024 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7887813C83E;
	Tue,  7 May 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OaCt/I82"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9EC13C825;
	Tue,  7 May 2024 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715068952; cv=none; b=ZxUnZ3PGcJ4s4/sVnCJmRfqnR4icuARsY2jq/HffYbth7X7E3fZy/R69vIT0QOPEVKSFbKcDF+E+Iorm2V9iYBZ0qvJNhzWJf1ZYMmmMhwuGa+I7qJT+RX/0wIeNMQRnsQ//IFzknRfkjn0DIn8eFF2iBBBg0KNbpAdTEg0G/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715068952; c=relaxed/simple;
	bh=eVuJaWmf6K+6Q7+mij6ttOAXRmIGKtXLtFRjx9VCUhU=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=t1uRzGdm3g52b1uewkew8SMc+PjjwmPrZYlxhrqkTp0OQmYrKnR4CuwYQsBQ3T+MiDT/ix22xexGFmM+g5h86ixOPJ8Xf5wUJ0NopiSF6nsBg6Myb2QEhJ6oFtVT8DLfEzCqqEBakQ1Wxi2yMX6G76bp2N2NqaIZc/jiSoz9dRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OaCt/I82; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240507080226euoutp01ffb1c9ea68a4ba254d5e06cfea0a15ef~NJh6jrufP1475714757euoutp01N;
	Tue,  7 May 2024 08:02:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240507080226euoutp01ffb1c9ea68a4ba254d5e06cfea0a15ef~NJh6jrufP1475714757euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715068946;
	bh=bM6BO+kXomYK6wu5Oe2x75rmz5FGAnqZz6OZvwI6EI8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OaCt/I8263CIse6EAHirslaA+XjPx3S99X0Lnu+QkIer/c0VKj8SFlQ3zGajYKMOr
	 LYHYoCwD/OM250G6eDa95qO5w5nzjQVjBgP5yR0c7DVdlluAmL+6rTNVU6/ftVtthh
	 whD4dNzZqSg6CHoctLNTdfvbH/llcfrspgm6hywo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240507080225eucas1p100839565bf9accbaa12bd4b6d3ce75ea~NJh6UAr6t1360813608eucas1p1P;
	Tue,  7 May 2024 08:02:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F5.3E.09875.110E9366; Tue,  7
	May 2024 09:02:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240507080225eucas1p2ecd684015a8497b39ba48a3cbf7ff117~NJh5t9EE63198231982eucas1p2j;
	Tue,  7 May 2024 08:02:25 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240507080225eusmtrp1c4d5b256ccf9962d4d861eb6994c583a~NJh5r3Gwh1695816958eusmtrp1e;
	Tue,  7 May 2024 08:02:25 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-73-6639e011d550
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.32.09010.010E9366; Tue,  7
	May 2024 09:02:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240507080224eusmtip1557a07acc6af3e10765745c779036cca~NJh5VdlXv1570615706eusmtip19;
	Tue,  7 May 2024 08:02:24 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 7 May 2024 09:02:24 +0100
Date: Tue, 7 May 2024 10:02:19 +0200
From: Joel Granados <j.granados@samsung.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexander Aring
	<alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Miquel
	Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Matthieu Baerts <matttbe@kernel.org>, Mat
	Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Remi
	Denis-Courmont <courmisch@gmail.com>, Allison Henderson
	<allison.henderson@oracle.com>, David Howells <dhowells@redhat.com>, Marc
	Dionne <marc.dionne@auristor.com>, Marcelo Ricardo Leitner
	<marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Wenjia Zhang
	<wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D. Wythe"
	<alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, Wen Gu
	<guwen@linux.alibaba.com>, Trond Myklebust
	<trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, Chuck
	Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil Brown
	<neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jon Maloy
	<jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, Martin Schiller
	<ms@dev.tdt.de>, Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik
	<kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Simon Horman
	<horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, Joerg Reuter
	<jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
	<keescook@chromium.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dccp@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <mptcp@lists.linux.dev>,
	<linux-hams@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, <linux-afs@lists.infradead.org>,
	<linux-sctp@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
	<linux-x25@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <bridge@lists.linux.dev>,
	<lvs-devel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 8/8] ax.25: x.25: Remove the now superfluous
 sentinel elements from ctl_table array
Message-ID: <20240507080219.xp6m5lyx5mt655yg@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="3yuuqqhcvvnk6kqm"
Content-Disposition: inline
In-Reply-To: <21f76a94-1b35-4cf7-914d-e341848b0b9e@moroto.mountain>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTfUxTVxjGc+5HW5l1l0rmibow+XCGOZDNyGumDqdzN/vDmBjDhku0wysw
	obAWlGHYqtCiINhZB5MRQFwAWykMoYAfjHQIWipgRAVSUCqFrIKiUL4EOup1mcn++z3v+zw5
	5znJEZESrWi5KFqWwMll0hgfgQdlbJ5u/9Dz0caD69QNa8GkDIH+axk0KNPUBKjqXRQYL2QS
	4OodImCuPp2Esf4hGgqLLwtgtEAlhPz2NArmHmQK4OnxlxQYrqgIsDfbhGDM0iPQH7dSUDs0
	KYBMx0pIrXEiGDhto6GzZFQA0yU6ITx02iiYzn4LzmWkEmDJjIW63gEKOozZNGjMwXC/tpeA
	u1fyBdDR2ErDoCmLAs35VBLsRU9osGpLKGi8XojAVvGMgNTCFySkjj0mYaashYa2LBcJeQYd
	CV0aO4K/0htosFQcF8JEwU0SrhcqKWguegc0BjMFE63DCHKH75FgHncR0HZ5jIax/DXQ5V5q
	y6oJuHpySgjV7d+BecZMwOPJIQG4uj6FYxajMHQr22NzkuzTtluILbh0lP1NeYdiZ6YD2OqL
	3QSb2eQg2fq8XiFrbPRni6oS2VnTH0K2SndSwFrvXxOw9f0bWU1xI2Iv//7TLp9wj00HuJjo
	w5w8aMt+j6ixM6fo+D5JUl6ak1Cik0wGEokwsx5XVa7JQB4iCVOGcJqqkeLFOMIWXRfKQIsW
	xBjC15uxm92BDmUPzZtKEbaWVb5OLJg6KmpIXlQhfPFEsdAdoRg/PGfPJdwsYNbi9mEr6Wav
	BZ6f075Kk8yvEqxuqHwVWMok4tIn6a9MYiYUG+c6Ec+e+Na5AcrNJJOE1UOFpLsEyazApfMi
	Ny5ituHaRm/+pquw80IfxXMKNlf3EO6jMHN7MbbU3BXwi+34dP3Ua16KHS3VQp5X4lbtKYoP
	aBH+c35UyAs9wiXHnATv+gSndQ68TmzFt62XEP+qS3DXiCd/zyX4jDGX5MdifEIt4d2rsb5v
	mNIg37w3muW90Szvv2b8eC0uuvpC8L/xB7jk/BOS583YYHhGFSGhDi3jEhWxkZziIxl3JFAh
	jVUkyiIDI+Jiq9DCX22dbxmvQ6WO54EmRIiQCfkthG2V+g60nJLFyTgfL/GN9JCDEvEB6Q/J
	nDxunzwxhlOY0AoR5bNM7H/Am5MwkdIE7hDHxXPyf7eEaNFyJRFtarb4lE+rAjflhK1b7L83
	e/GeI/cLftHcDDvq7bgxW3vP76X2q7aBVSObN6SnhOdHT20c16RIApqP1nXSE8nEZOjHTNbb
	Tbq/40JinOej5+32nX2D3ttyRgpco+9t6XPc0YfdpXwnvNSf28qdG1RZ629Wdv/o+OLbU00z
	DwMCuyVh4oioZNm+d59/86BhX35w+B5i74TfHO6ZHIioMNgyU2y7YncMzqo99lvjRx/t3lxV
	m13XOh3hX786yVLT/f7PsxU54b7lLLfrs4czQQkh7NT6kaHRs9uTvXU76Ud3iO6zK2Xm4O8T
	Arq+HG5J397/tdfu0PjYIP/nh8Tyw7fveR6qsfpQiihpcAApV0j/AfPhAtomBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0yTZxTG836XtkjYPlvdvjAStUrGmKuU6+kiTIMun4FETZguGAeNFpFB
	iy1lTiMrFERbL0WjjMsAwZWbKwpYBBWxOhyVAWbCmBQcBcQpE5CLgpautVlmsv9+eZ7zPO/J
	mxwOzr3I9uTslaZI5FJxIp+1iLi7cKf/E+pPUZzfZNtaMKlCYPCahgRV5mEMshrtBBjLtBjY
	+0cxsDVm4zA1OEpCcWkdCyaKsthQ2JlJgO13LQueZbwiwNCUhcFIq5UNxuPVCKozLAQ0jL5g
	gfaJF6gvzyAYPmkl4b5+ggVz+io2PJyxEjB3wh3yNGoM2rVJcKV/mIAu4wkSdGYh9DT0Y/Bb
	UyELulrukvDIdJwA3Tk1DiMlT0mwnNYT0HK9GIG1ZhwDdfFzHNRTQzjMV9whoeO4HYd8QxUO
	vboRBLeym0lor8lgw2zRLzhcL1YR0FryHugMZgJm744hyB3rxsE8bcego26KhKlCH+h1mqcr
	6jG4evQlG+o7E8A8b8Zg6MUoC+y9n0F6u5G9bj3zwDqDM8862hBTdOEgU6C6RzDzc75MfeUf
	GKO9/QRnGvP72YyxxZspqVUyr02X2Ext1VEWY+m5xmIaB0WMrrQFMXXnv9vCjxaslcuUKZLl
	8TJFSih/hxD8BUIRCPwDRQJhQMjOT/2D+GvC1u6WJO5NlcjXhMUK4sd708lkC3f/1K3vkQpl
	UxrkxqGpQLpL9YDUoEUcLvUjoke7O9guw4u+NN1NuphHv+7RsFxDk4i+XaXBnAaXqkX0dQM4
	maBW0baR3Dc6i1pNd45ZcCcvcfCC7TThDOPUWS59uSn9TSuPUtLlT7PfDHlQ62ij7T5yvfAY
	o39NP4O5jMV0W94w4WScSqXHtEOO9TgO/oAuX+A40Y0KpxtalrkWXUHPlA0QLj5ET9keIR3i
	5b9VlP9WUf5/RS7Zl+5d+Av7n/wxrT/3FHdxKG0wjBMliF2FlkiUiqQ9SQp/gUKcpFBK9wh2
	yZJqkeNcjK1z9VdQ5ZNJgQlhHGRCqxxJ68XqLuRJSGVSCX+Jx8/ZIXFcj93ibw9I5LIYuTJR
	ojChIMcv5uCeS3fJHLcnTYkRBvsFCQODRX5BouAA/vsem5KPiLnUHnGK5GuJJFki/zeHcdw8
	VVhkSE91843glvTYF7LdvDXtKSEFpsEPbbc0oY/TloYpVpZ/nlDcwBdEugtg483MyLjHgZur
	th9LU9hvxu64GV62/svQnQurovdHRjetDFN+EV6nS8sciDpjjzzYd+NqVEJfwaWjc+6pgZHh
	MRnn9cf2Hdl1T7/lUMXWh8RwfE118/xXvMrGFX05PN7JjXu9/M7+VLrNEmzRbN4Q/oP3clNT
	j89S2WTupmcbvlGfLD8RO+0dPPD3hc5li3n7uZyovEcRUq8yi8fsBImtrLxqSojAV2+NCChM
	zOS/0/XuQXOa1bYtJ8D3QWU3P8/nQHeS1Kx/fnj75KvGl7J9fZxTH23QJidwvd35hCJeLPTF
	5QrxP3FAyGDDBAAA
X-CMS-MailID: 20240507080225eucas1p2ecd684015a8497b39ba48a3cbf7ff117
X-Msg-Generator: CA
X-RootMTR: 20240501131616eucas1p28a33eeb55f6c084a0751e5b7b7d91d78
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240501131616eucas1p28a33eeb55f6c084a0751e5b7b7d91d78
References: <20240501-jag-sysctl_remset_net-v6-0-370b702b6b4a@samsung.com>
	<20240501-jag-sysctl_remset_net-v6-8-370b702b6b4a@samsung.com>
	<CGME20240501131616eucas1p28a33eeb55f6c084a0751e5b7b7d91d78@eucas1p2.samsung.com>
	<ZjJAikcdWzzaIr1s@hog> <20240503121811.fsmriwsgugzm2o7i@joelS2.panther.com>
	<21f76a94-1b35-4cf7-914d-e341848b0b9e@moroto.mountain>

--3yuuqqhcvvnk6kqm
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 06:23:14PM +0300, Dan Carpenter wrote:
> On Fri, May 03, 2024 at 02:18:11PM +0200, Joel Granados wrote:
> > On Wed, May 01, 2024 at 03:15:54PM +0200, Sabrina Dubroca wrote:
> > > 2024-05-01, 11:29:32 +0200, Joel Granados via B4 Relay wrote:
> > > > From: Joel Granados <j.granados@samsung.com>
> > > > diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> > > > index c4f8adbf8144..c50a58d9e368 100644
> > > > --- a/net/ax25/ax25_ds_timer.c
> > > > +++ b/net/ax25/ax25_ds_timer.c
> > > > @@ -55,6 +55,7 @@ void ax25_ds_set_timer(ax25_dev *ax25_dev)
> > > >  	ax25_dev->dama.slave_timeout =3D
> > > >  		msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
> > > >  	mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
> > > > +	return;
> > >=20
> > > nit: return not needed here since we're already at the bottom of the
> > > function, but probably not worth a repost of the series.
> > >=20
> > Thx. I will not repost, but I have changed them locally so they are
> > there in case a V7 is required.
> >=20
>=20
> It's a checkpatch.pl -f warning so we probably will want to fix it
> eventually.

According to [1] the patchset has already been applied. So I'll just
send another patch for it to be applied on top.

Thx for pointing this out.


[1] https://patchwork.kernel.org/project/netdevbpf/patch/20240501-jag-sysct=
l_remset_net-v6-1-370b702b6b4a@samsung.com/
--=20

Joel Granados

--3yuuqqhcvvnk6kqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmY54AoACgkQupfNUreW
QU9Dbgv+Op/tVXQJ7NdTua64j7NUxRCzHsjHQRU3hdSkupwQI/OaUY7bGGoodczt
iNNg2J0Y0JSmRdASM/aOD7s7SaOxFKiYEe+2VsUZz/BzFO2Y2v3NI2RiwnSQh4wi
kEJJfiJnfq3F5Kmie/WyXxmzU/2oSKFykgNJ11RddJnduusi+dU5l6qCymKxRjZg
SX5SB1waJpZkGTnuevMNqF/GWr9DK1kAAU6OBKZO/lUneHDGag6yX3qPbKZJslJZ
s16Z/mlzepR8cxQH3beDzfirydf2IlOH8HZh4WVH76mloTq2lQknnkdcqi+18eP1
PE8600acZK1jILUXHGxMpMkLM1PAWARbwV2NWpdv1eFt2t1BEap/sVfaSy03EJpx
LluZY7QlJy2LQs4alGQmme51crtM0ej6zbEF/MjTgPC5rtdsaKYxm8AUqMUTpZXK
9seDYkN4LcV0sAb8ckQgOEfnNnDEezQ2koX8si4S1g4d7SZaGkNTpC/56oH4zk6T
wbHvE20c
=sLD8
-----END PGP SIGNATURE-----

--3yuuqqhcvvnk6kqm--

