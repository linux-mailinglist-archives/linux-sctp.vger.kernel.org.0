Return-Path: <linux-sctp+bounces-132-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A98B75F6
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Apr 2024 14:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9EC2284E3C
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Apr 2024 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3659D171E4D;
	Tue, 30 Apr 2024 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bVxPN267"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0B171650;
	Tue, 30 Apr 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480894; cv=none; b=ZA7ueKobep28nZoF4HSznHPSzxs9vBta9g8L3WINbvAoTLhzXncqVv3ycUgfq+SfZ+Edsjjk6Wf3AQMBXGSqHRfWqKw4CO4R8/+FWJieL3WOKCZjBCYP9E42q1zuLPIVlmN1poXbOYjyGRBfMPxThJg52cmjVpwktkoSqcG9hqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480894; c=relaxed/simple;
	bh=9v5nbIyTk29DQD7K8yfF9zFZjD5rlyG1NzU6KgBfAeo=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=qCS0+eQK9Aqg75VXszQYeBltBtfDQ11gJMioaMfQguFl7nVLnWgiC7MyODuvlTUiSbzTsVrKq9k90JNLACg5CVDDMo3oTcu+NlY2njLahvJI1pM4FnHNu2uhk7PJinuKa5fC3uoM5BIpni+eH+PVEyHd+EpCl6K1GNLY8tr9r58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bVxPN267; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240430124123euoutp02dae4cc936cdd34776578b5f692aaef5a~LD0emysCv2912729127euoutp02K;
	Tue, 30 Apr 2024 12:41:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240430124123euoutp02dae4cc936cdd34776578b5f692aaef5a~LD0emysCv2912729127euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714480883;
	bh=ee6hOge47N/ZUZL/n09Dop1nA6z21xPJS7cNGpe348M=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bVxPN267bjohfRSlay34PZ1s31TIerml/wNMQuGtS3y+UFt9HaX8oXXaq+8k18y0Q
	 2gf73U9j+w1mh4g8WYeR0ARw4DTULSGmJ4IAiWTvOuiGoIb2Ce6oX4v12e1Goks2zm
	 PqTwcojlqolN4YbR4wxYZuqxjS7XJzp8pRBbhglc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240430124123eucas1p112ecb22e58892e0197f6992f62e6ef6b~LD0eXm6fx2825228252eucas1p1G;
	Tue, 30 Apr 2024 12:41:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id CD.3D.09624.3F6E0366; Tue, 30
	Apr 2024 13:41:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240430124122eucas1p1878107fc7b05ea2dc0c4f8b4e37e0bbb~LD0dv7cJd2825428254eucas1p1z;
	Tue, 30 Apr 2024 12:41:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240430124122eusmtrp2892d70f7322ac2914bbd949ffe915179~LD0duZtTh1688716887eusmtrp2c;
	Tue, 30 Apr 2024 12:41:22 +0000 (GMT)
X-AuditID: cbfec7f2-c11ff70000002598-2e-6630e6f38b4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 04.C6.09010.2F6E0366; Tue, 30
	Apr 2024 13:41:22 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240430124122eusmtip11f9eb40338d7a273674f7912309dba07~LD0dLgJxf0368603686eusmtip1y;
	Tue, 30 Apr 2024 12:41:22 +0000 (GMT)
Received: from localhost (106.210.248.68) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 30 Apr 2024 13:41:21 +0100
Date: Tue, 30 Apr 2024 14:41:16 +0200
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
Subject: Re: [PATCH v5 1/8] net: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <20240430124116.vcgeggkcwtbbvibm@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="kslkfvepsb4lk7db"
Content-Disposition: inline
In-Reply-To: <Zi-zbrq43dnlsQBY@hog>
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe1CUVRjG53y3XQj0A01PaGhcCi+oNFavmUqkzddUWjkTM8VM7sjnfRfb
	hVTIXAG5bVwEE1jABSokFiG5LCAhzGpLrNxMlIWBbBcQRVBkQVwvEOuu5Uz//c77vM953+fM
	HCHpelLoJtwtCeWlEtE+D8aR0ugsrb7mG6t2rKrSOYBW/hYYf0ugQR4dQ8CxmmkKND8qCJju
	HSTgSU0sCWbjIA2q/HIGstuiKXjSqWDgTuQjCkrOHSNgQGcSgCZRjUAd2UNB1eAkA4qhhRBV
	OYGgP9lEQ0fBKAOWgiIBXJ8wUWBJegEyE6IIaFaIobq3n4J2TRINKXo/uFbVS8CVc9kMtDdc
	ouGGNpGClLwoEgZyb9PQk1ZAQUOdCoGp9C4BUaoxEqLMfSQ8LGykoTVxmgRlSREJhpQBBBdi
	z9PQXBopgPun/iChTiWnQJc7D1JK9BTcvzSMIH34Kgn68WkCWsvNNJizfcBgFdMKKwiojX8g
	gIq2PaB/qCegb3KQgWnDBjjarBFAX2cn6e/PdZsmSO5OaxPiThVHcFnyyxT30LKUq/ili+AU
	F4dIrkbZK+A0Dd5cblkY91h7VsCVFcUzXI1xDZeS34C48p+OcDfLM9Enr3zh+E4wv2/3N7x0
	5fptjrsuthvJ/fo5BzMGLLQctc1OQA5CzK7Gp5IVdAJyFLqyhQhfSWxDtsM4wmcMBrtiRlgz
	3kU9s8QaWyibcBrh2owOwb9d0XHNdksFwnkTZbTVQrHeePhWNGllhl2O24Z7nvJc1gf3x2pI
	q4FkR13wgz/TGaswhw3GCbpCwsrOrD/uVkXa2QU3ZfY/3YNkD+K7j4wzo4UzvACfnhJayw6s
	JzYZWwnbqh44MSPHzoexvqKbsM7CbIsTbqzNYmzCRtwUVWzPNgcPNVYIbLwQT9eo7IY0hOun
	RgW2gxrhgqMT9mvX4uiOfrvjXZw5ZH0/4QzPwoYRF9uis3CqJp20lZ1xXIyrrftVrP5rmEpB
	nsrnoimfi6b8L5qtvBzn1o4x/ysvwwV5t0kbr8MlJXepXCQoQvP5MJl4Jy/zk/AHVshEYlmY
	ZOeK7SHiMjTzXS9NNY5Vo5yheyu0iBAiLfKaMZt+VbcjN0oSIuE95jqfyFu5w9U5WHQonJeG
	fCUN28fLtGiBkPKY7+wdvIh3ZXeKQvm9PL+flz5TCaGDm5zwU25NjdsSjhYPVo38XPf6weOH
	vwucDHwg/9hStHnJlK/P2ojV8vigx+Hjf587oPBa+CZ+sl608oNbvtp76jMQed5HSYWtd5gU
	eyaN7KCvv6Zq/NDsXZy+xf1k8g9NydTx9/pjSk1cbVBdWrfL1CF9RC/+dGPeCSc2OCOUmdgE
	7tUd+dzLF48FvgGb3BoMJz+a3eHsJMq5/O126YXqrd9HBmwIchec3lO7ecrxqDlwb/KV1Iil
	18q+rnm79cjetXGqbkn9YiOMeN88cZXtLG4JOFu/xHNcvKV9kVw3eval/J6s8DXLKkWf/R6T
	tCdt3YulX37eEVA61NU17/2WbVsfzfOq1JVbujwo2S6R31JSKhP9A5+WkVQpBQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTZxjG951zesGNWG7zDFmmFRKGrFBuvizKyFzM8Q8XMrcwt2zYwAHk
	0mILZrq4Aa0gFKSAIjCEIpNxURQKlSI6LIRLuW5TLkpdKFCUq4ogMKEDumUm++/3vc/7PHny
	JS8bt65m2bOPCWNpsVAQxWVuITrX2vQfPDe6h7pX62xAG78HRhpTGRAvS8LgjMZEgLpEjoFJ
	P4HBqiYZh/mRCQYUXVYxoaBXRsDqgJwJs4l/EVDVcAaD8VYDC9TplQgqE4cJuDnxkgnySQeQ
	1i0gGMswMOBe6VMmLJdWsODPBQMBy+fehLxUKQZd8mio148R0Kc+xwCFjg/9N/UY/NFQwIS+
	pk4GGLXpBCiKpTiMK6cYMJxdSkDT7SIEhutzGEiLnuMgnR/FYaWsjQE96SYc8qsqcBhUjCNo
	Tr7DgK7riSxYLGzH4XZRPAGtyrdBUaUjYLFzGsHF6fs46F6YMOhRzTNgvsAZBjfE7LJaDG6l
	LLGgtjcCdCs6DEZfTjDBNPgRJHSpWTA6MID7+1MPDAs4NdvTgajCq99TP8X/RlAryy5UbfkQ
	RslbJnFKk69nUeomJ0pZE0e90lazqJqKFCalGfGlFJebEKX6+UfqsSoPBez8irdXLIqLpXeE
	iySx+7hf88GDx/cFnoeXL4/vueebDz28uW5+e0PoqGMnaLGb31FeeJI8LKbd5ruuBhkzHnVv
	TUUWbJLjRSaPdBOpaAvbmnMFkTn1q4RZcCCrX9xnmNmGfNWfyjQvPUNkcm4lMj9qEXkhs3Bz
	i+A4kdNPZPgGMzmuZO/08CbbcpzJsWQ1vmHAOU+tyJnsMWxDsOGEkKpHS2iDLTn+5IOiRMyc
	2o6RmqxszCxYkR15Y5udcM4J8sylhvUe7HXeTv6yxt4YW3B2kYaRHsxclUum5176h0+T86tG
	pEA2+a8l5b+WlP9fknnsQg6uPcH+N95NlhZP4WbeR1ZVzRFKxKpAtnScJDosWuLBkwiiJXHC
	MF6wKLoGrd+LunW5th6VTz7jaRHGRlrkuO403KjsQ/aEUCSkubaW54vdQq0tQwQnT9FiUZA4
	LoqWaJH3+jdm4vZ2waL14xPGBvF93L35Xj6+7t6+Pp7cbZYHY84KrDlhglg6kqZjaPG/Poxt
	YR+P1XZERuwPU3UG6t+xttDK6fPiqjTXZn3QlXKjtNn+jcefL8ZkfvqecXdU07WWmQPTDmk/
	ZMzxGMW80l7lqSP9+q0Fh3gTWX7XdgkDzwaLxDmq3LQbXdsMkBeT9e2QIqnU5aL8rsTJechL
	bYKAWce3th5vbCz77H2fbrt7SV/udU4szzCdLilJ+F3rei3V99b+h852aDpge/7a4YrrRupQ
	dEbzF3c0ASPOo3mRJQkvCn00IlyrDmMtth1893hPqNLr6MxAzJGQu54TjsTJZJm88pPDdXz+
	fFzhkvHCvp4DgUuPHu6cbZN1pESQHTsUUUMtv9bpaGVBjmR86uN2K6ekzqtDXEISLuC74GKJ
	4G9+5KdBxAQAAA==
X-CMS-MailID: 20240430124122eucas1p1878107fc7b05ea2dc0c4f8b4e37e0bbb
X-Msg-Generator: CA
X-RootMTR: 20240429085414eucas1p11b3790e4687b8dc8ef02fe0f54bc9c55
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240429085414eucas1p11b3790e4687b8dc8ef02fe0f54bc9c55
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
	<20240426-jag-sysctl_remset_net-v5-1-e3b12f6111a6@samsung.com>
	<CGME20240429085414eucas1p11b3790e4687b8dc8ef02fe0f54bc9c55@eucas1p1.samsung.com>
	<Zi9gG82_OKnLlFI2@hog> <20240429123315.og27yehofzz6cui3@joelS2.panther.com>
	<Zi-zbrq43dnlsQBY@hog>

--kslkfvepsb4lk7db
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:49:18PM +0200, Sabrina Dubroca wrote:
> 2024-04-29, 14:33:15 +0200, Joel Granados wrote:
> > On Mon, Apr 29, 2024 at 10:53:47AM +0200, Sabrina Dubroca wrote:
> > > 2024-04-26, 12:46:53 +0200, Joel Granados via B4 Relay wrote:
=2E..
> > > >  {
> > > > +	size_t table_size =3D ARRAY_SIZE(mpls_table);
> > >=20
> > > This table still has a {} as its final element. It should be gone too?
> > Now, how did that get away?  I'll run my coccinelle scripts once more to
> > make sure that I don't have more of these hiding in the shadows.
>=20
> I didn't spot any other with a dumb
>=20
>     sed -n '<line>,^};/p' <file>

I used a coccinelle script:
  * ran it with `make coccicheck MODE=3Dpatch SPFLAGS=3D"--in-place --debug=
" COCCI=3Dscript.cocci`
  * script:
    ```
    virtual patch

    @r1@
    identifier ctl_table_name;
    @@

    static struct ctl_table ctl_table_name[] =3D {
    ...
    -, {}
    };
    ```

and a gawk script
  * ran it with `for f in $(git grep -l "struct ctl_table") ; do script $f =
; done`
  * script:
    ```
    #!/usr/bin/gawk -f

    BEGINFILE {
      RS=3D","
      has_struct =3D 0
    }

    /(static )?(const )?struct ctl_table/ {
      has_struct =3D 1
    }

    has_struct && /^(\n)?[\t ]*{(\n)*[\t ]*}/ {
      print "Filename : " FILENAME ", Record Number : " FNR
    }
    ```

At this point the coccinelle script gives me too many false positives
but the gawk is spot on. Thx for the sed one. Will make a note of it.

Best


--=20

Joel Granados

--kslkfvepsb4lk7db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmYw5uwACgkQupfNUreW
QU9l3wwAkqQQGkCIH8hoA/NcwLoETQ0VaIIcpgRXYq3d+WvE3iHimlD4zkeOxvel
saZJ2dmttK0T+DjmrV7XMvEyH1DchjlJBSB9xRl9+0NgwfP7q40MBgRJXptfl/FI
BDavrylIYGWdP5XAldlUfQiH/NDmx1gXbjuUNZvJXpZxd2qY6fLDBC3yoYGL/Ucq
uhu9JJUZgXWVLZbB+mTdA3dLCzwJN6coxzuAxFTnqbpLj69Ds6vj47jG4aeg8Xf/
QcQ3HPuwPt5OCswVu6WExaB6Yz/b5TLnQzN1dgMWsMTMHWo3/+GNGUIfAffxtpwc
AMzd1dqvwIXvx6EZilpayO0Y052Fd91CuqR/OcKmz60BntOM6hxjIecGmqMdcKhZ
0YN3i6Tmk/VCmg6i95066V5fFlzbCoWTarpG0ozYzEQJNPY4y/bhCSGFtNn5eXJQ
IdAUXFCJcyhfOWPGRMNkLl+XhgCOvopNTj4rQ1w1ynnxBXt7FKMG68chVXnad8Bc
54MD/HbU
=Dpqe
-----END PGP SIGNATURE-----

--kslkfvepsb4lk7db--

