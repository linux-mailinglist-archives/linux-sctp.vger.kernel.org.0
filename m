Return-Path: <linux-sctp+bounces-124-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F268B53D2
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA39B1C2186C
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Apr 2024 09:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A92200CD;
	Mon, 29 Apr 2024 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qGQsLqkt"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38D5224D1;
	Mon, 29 Apr 2024 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381817; cv=none; b=HHii0zp6LEjoJiRKZQXmZuz7Nh2b93/H85a4ywQm3ryzoX/2wldu+6R1aoeRipPBjtMuafUhtjrp1Ha4WRxPvuDgWpmYvcOKHWN43Nqb6zAuOr1KWJYqYbt1rWahWQWyJFhgMZ2I5wnEQTdQY/YZOnmYYOOXVvic1/8K++zhV+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381817; c=relaxed/simple;
	bh=JCEQupHXJ+tkNvOBRsa9m9cZZODkY17RLMgKjTrOzpE=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=UOhIIuErav3q/IWlgG9NBguhMDvxpo4m+kZDDKqWy2j6BoxXpc+us3BceglCSALhT9qYcBNbNsyMpA5AGJXPi/ygwEY0EB3eB4MlgdU+U8n46mW3h/653STRdVMRzOypkNdy5O8uccjG6j7eRiyCfZ56YuNQghkLYIbdkpTNz3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qGQsLqkt; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240429091011euoutp01ab39328e612eefbb1da6f27d60e6554e~KtSy-1jID1578015780euoutp01a;
	Mon, 29 Apr 2024 09:10:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240429091011euoutp01ab39328e612eefbb1da6f27d60e6554e~KtSy-1jID1578015780euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714381812;
	bh=VuilUByJ0LtKm+xptdy8ctZuIBRrbQ5ec4mZTZCp5zc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=qGQsLqkteHXzuXhaDiTcgLtvWqvtbVRvFQjFmUZBx5IuBG0JHHOJXg4+5E+VNcLcW
	 BEGhHTTkUn+v1pXlmNp/5o6P1P0gyeU/R7tMWlrLYBp42s6rANvK/uDX5TSK058awG
	 dKpHgmRUAjW5k3cV2dEI4D26WB0gJgEgVa2MinhY=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240429091011eucas1p23c6ce3310f6053e925722ddbc0db75ec~KtSywbKwI3241832418eucas1p2D;
	Mon, 29 Apr 2024 09:10:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.FC.09620.3F36F266; Mon, 29
	Apr 2024 10:10:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240429091011eucas1p261d5bc784704bdecf38a3b986d1579f0~KtSyLX01Z3241832418eucas1p2C;
	Mon, 29 Apr 2024 09:10:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240429091011eusmtrp228e2f8f528e2752d51ae5da4b1bcd076~KtSyHrrc92623926239eusmtrp23;
	Mon, 29 Apr 2024 09:10:11 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-50-662f63f36f29
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 47.5C.08810.2F36F266; Mon, 29
	Apr 2024 10:10:10 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240429091010eusmtip2f6fcf2c8d163580cff9460a583e94e3d~KtSxvYLur2987829878eusmtip2d;
	Mon, 29 Apr 2024 09:10:10 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 29 Apr 2024 10:10:10 +0100
Date: Mon, 29 Apr 2024 11:10:05 +0200
From: Joel Granados <j.granados@samsung.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexander
	Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>,
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
Subject: Re: [PATCH v5 5/8] net: Remove ctl_table sentinel elements from
 several networking subsystems
Message-ID: <20240429091005.rl5fg42dtpiqdha2@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="7yt4vfjhttuopq7n"
Content-Disposition: inline
In-Reply-To: <ZivEOtGOWVc0W8Th@hog>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeVBTVxjFve+9LGCjj5iRWxarWMQBRSm2ftpNGGd8dZzW6T9V2yll4Cla
	1gQoXRjDvlXLCA6CyN5AiUQaaEJALFIFDKvVWoqAEEJhAIUSAgWV1JDYOtP/fuece+Z+3525
	fFJ4nu/APxkayYpD/YNduLaUqmWxe7shYMfxndeHN0KzdDcMX03ngDQxmYAkjYkCVWkGAaaB
	MQKealJIMAyPcaCwpIYL+d2JFDz9PYMLdy7pCXgU/5gCRX0SAaMtOh6ozsgRyOP7KVCPLXAh
	Y8IJEn4yItB/p+PAXdkMFxZllTx4YNRRsHh2NeSmJxDQkRECdQN6CnpUZzmQqfWCe+oBAu7U
	53Ohp6mdA382n6EgsziBhNGiSQ70Z8koaGosRKC7Mk1AQuEsCQmGERKWKlo50HXGREKeopKE
	3sxRBL+kXONAx5V4HswXtJHQWCiloKVoPWQqtBTMt08hyJn6jQTtnImArhoDBwz5W6HXHGZV
	1BLQkPY3D2q7T4F2SUvAyMIYF0y970Jch4q3z4fp0xlJ5lHXLcQUXP6auSi9TTFLi+5M7Q9/
	EEzGjQmS0eQN8BhVkytTpIxinjT/yGOUlWlcRjO8h8ksaUJMTdlpZrwmFx3edMz2rUA2+GQ0
	K97xzme2QbfvF/DCL9jFDKVeI6Toxpp0ZMPH9C7crn7ISUe2fCFdgfDMbCPXIuYQTpXlUxZh
	QPii/BLxvNI1uWANyhFuqlYQ/55KKVRaRQ3Cxpx0ylyhaFdclV1FmplLb8PdU/0rLKK3Yn2K
	ijQXSLpeiLU5yyuFdXQQLm64t8ICeh++3T9HWNgO38rVr/gkHYNliebb+M/YEZcv881oQ2/G
	w2ofy6SbsLF0kLJwLNbW9q3MhumbL+HJqRJrsB+XpZ/nWXgdnmittbITNmkKrYUshH9enuFZ
	hBxhWZzR+hhv4sS7emvDBytMlynzFJheg3sf2lnmXIPPqXJIiy3AqclCy+ktWD44RWWizXkv
	bJb3wmZ5/21msbfhooZZ7v9sDywrniQt/DZWKKapIsSrRPZslCTkBCvxDmW/8JT4h0iiQk94
	BoSFKNGz39q+3GqsQxUTf3k2I4KPmtGrz8q6ankPcqBCw0JZF5FAme9xXCgI9P/yK1Yc5ieO
	CmYlzciRT7nYC1wDX2GF9An/SPZzlg1nxc9Tgm/jICXSNGTsheN1NvNzL6/mJW/rDNdJ1k6P
	Rz/xk8dmF58TDN1Jy/bo31DRlxQhDHcLGlJ7H4ko/zbOY8E0vXOV9/2QprEbfsGfyES5h9kE
	1f5g549vinRrW8YjTK8dXU5+7Fs2rtuozvI7PbL90K6nRtFUb0yp27jbsbZVBQ4BSb8GOg9u
	6HxvfeSh1sBUp+g3wg+67b1yUHdg0Bj2aU73fOekwvNII7vnUFX0hwKxrGp5wXtLLPGNVMb5
	oOVoKWEc7d4vMA7ov09pf71I2XDMx7h7YKzYS+08s0N6Mi1swj5J5/6RVmTr4+ciOtCn9nXW
	uvmeijbEa97PcyyvJq5fVT6oFu5tc6EkQf5e7qRY4v8P9UkEhSgFAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTa0xTZxjH955zeoEFc+SyvTJCpIMMEQtVwAdUwDCTs7hk24dNh9mkwSPo
	aEtaYAoxVopjFtBDdHPUctONIcitlQI6takbKiIoCrINMJQiGzeRO05gQLfMZN9+ef6X98mb
	PELSuUbgLjwgT2KVcmmCiO9I3V241bNhPDZgf+B4XyBY1Juh9yctD9QZXxFwvGGRAtOFLAIW
	uwcImG/IJGGid4AHheeNfNC3ZlAw/ziLDw/zbQSMpv9FQeWV4wT0N1oFYMopR1Ce3kVB3cAM
	H7IGPUBTO4XAdsrKg0clY3yYKykTwJMpKwVzJ1+HPK2GgOYsGdR32yi4bzrJA65JAh113QQ8
	vKLnw33zXR48teRQwBVrSOgvGuJB1+kSCszXChFYq54RoCkcJ0Ez0UfCi9JbPGjJWSRBV1lG
	QifXj+Bm5nUeNFelC2C64DYJ1wrVFDQWvQFcZRMF03eHEZwdbiehaXKRgBbjBA8m9L7QuSye
	Lr1MwNUTswK43HoQml40EdA3M8CHxc4IONZsEkRuZ36zTpHMaMsdxBRcSmPOqR9QzIs5P+by
	xV8JJuvnQZJp0HULGJPZhykyJDMvLTUCxlB2gs809IYy3HkzYozfH2X+MOahD72ixVuViuQk
	dm28QpW0TbRHAhvFklAQbwwKFUs2bf4sbGOwKCB86z424UAKqwwIjxHHj5aeEiR+u/rQmRmO
	p0aWVVrkIMR0EG4ZmqG0yFHoTP+AcHbfGGEXPHDNZDvPzi74ZYeWbzc9R/hcZ84/CSPCGkMd
	ueyiaB9ccaZihfm0P24d7lphV9oX2zJN5HKApOudsfkX28oTLnQ8Lr7aQS2zEx2JH3RNEvbW
	WYRt2bXILqzGd/JsKyaSTsFNgxeXTMIlfgv/uCBcRgf6bdxbt92+qReeutBD2fkInph/ijjk
	onulSPdKke6/IvvYD3cu/Pn/8XpcUjxE2nkbrqx8RhUhQRlyZZNVsjiZSiJWSWWqZHmcOFYh
	M6ClezE1zhnrUcHgc7EFEUJkQd5LSWt1+X3kTskVclbk6mTQr9/v7LRPejiVVSr2KpMTWJUF
	BS/9Yi7p7harWDo+edJeSUhgsCQoJDQwODRkk+hNp/cSv5Y603HSJPYLlk1klf/mCKGDu5qI
	+Dx8ZH5y15bsT7jooPc95d7VZ0tSvZ033HOtmF0oHKtOd1vjsaet/dEHNF+rCK3/Zs278+4S
	mT+OvNH6qV5xvf35ViVCxEcDbWd2VNAcR97zzFXWRT7YdTDKjY2UNQeFSPeIA8wJ66Lpm3G5
	5W4Z0dqG7fEjQXWbClOU+R7eJ+CdssabnrqdR7mra/fnp3LfCbN3p9YeHklzUNf4xazb/Tis
	1EvRU+zfm9a26khwtGH+tcO+EYFsn9FLL3KJ8g+PDevf6Y/ujCw+O2S44WctG17/8e/64z6J
	t+LMKG/Q0e9LiTHnUsIT9WmV4/iTgoyUtqqo7kG3Y6LbW0anawocYkSUKl4q8SOVKunfWLkE
	AcQEAAA=
X-CMS-MailID: 20240429091011eucas1p261d5bc784704bdecf38a3b986d1579f0
X-Msg-Generator: CA
X-RootMTR: 20240426151357eucas1p15ffbd34b12f74980e6a75a797a322030
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240426151357eucas1p15ffbd34b12f74980e6a75a797a322030
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
	<20240426-jag-sysctl_remset_net-v5-5-e3b12f6111a6@samsung.com>
	<CGME20240426151357eucas1p15ffbd34b12f74980e6a75a797a322030@eucas1p1.samsung.com>
	<ZivEOtGOWVc0W8Th@hog>

--7yt4vfjhttuopq7n
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 05:13:37PM +0200, Sabrina Dubroca wrote:
> 2024-04-26, 12:46:57 +0200, Joel Granados via B4 Relay wrote:
> > diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> > index a5946d1b9d60..bd0b7e2f8824 100644
> > --- a/net/smc/smc_sysctl.c
> > +++ b/net/smc/smc_sysctl.c
> > @@ -90,7 +90,6 @@ static struct ctl_table smc_table[] =3D {
> >  		.extra1		=3D &conns_per_lgr_min,
> >  		.extra2		=3D &conns_per_lgr_max,
> >  	},
> > -	{  }
> >  };
>=20
> There's an ARRAY_SIZE(smc_table) - 1 in smc_sysctl_net_init, shouldn't
> the -1 be removed like you did in other patches?
>=20
>=20
> int __net_init smc_sysctl_net_init(struct net *net)
> {
> 	struct ctl_table *table;
>=20
> 	table =3D smc_table;
> 	if (!net_eq(net, &init_net)) {
> 		int i;
>=20
> 		table =3D kmemdup(table, sizeof(smc_table), GFP_KERNEL);
> 		if (!table)
> 			goto err_alloc;
>=20
> 		for (i =3D 0; i < ARRAY_SIZE(smc_table) - 1; i++)
This is a very good catch !!!! Thx a lot!! I'll put this into my V6.

> 			table[i].data +=3D (void *)net - (void *)&init_net;
> 	}
>=20
> 	net->smc.smc_hdr =3D register_net_sysctl_sz(net, "net/smc", table,
> 						  ARRAY_SIZE(smc_table));
> [...]
>=20
> --=20
> Sabrina
>=20

--=20

Joel Granados

--7yt4vfjhttuopq7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYvY+0ACgkQupfNUreW
QU/otAv9HIGYm6aL0iZA6OnAA8ofA0pI4BIiXrsHkVwfajwHsHry9FPCeEhtmc7j
QuYQNoz9zC1RAQx2Y7C6jNRoMA4YHla4cM3DcI57b5pqdFi8RF0CQw2wb16fHGM7
VZ4dAIAfBWYTpJX/VRAJFw1C03VAzKqw/ovvseztFBdsHvYY0YKvJVK+cUfGpDdq
uMJNHQBf8KM+0IJElRp1Iyj6tG9PQzOt6WcO6DKLI+w7BZEZBF8cHcncciBL/7eQ
6rHfGdpsOfaDQfo0eRkkt29JWE8Qk/bEaxN+XtFIx/IwsMdkiJpeKTlbyN7695Ec
EWHs/7eXApIRuygigPzJL+Jgv5quPu9Q6l6rM6ENt69D9mPSjmk9oU9nNDxvEX8U
BbEcjPUENhNU525lJkOgukqEy0eZBWYwnjORfJgKuIMuZCrn/7FDta6cUJOn6CMc
/uMSewEjnwU1hNcpvGfRmdLx6jMbrq/ypdLfwwuoXS+HIKHjv0z+xyPxy6i8ZFYA
rxq7J46v
=xUgz
-----END PGP SIGNATURE-----

--7yt4vfjhttuopq7n--

