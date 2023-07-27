Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F23A765407
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Jul 2023 14:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbjG0MeA (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 27 Jul 2023 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjG0Md7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 27 Jul 2023 08:33:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A52A128;
        Thu, 27 Jul 2023 05:33:57 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230727123355euoutp011fa6bb3dcb52f181f616466d2d83a260~1uYmBa5aY2650726507euoutp01E;
        Thu, 27 Jul 2023 12:33:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230727123355euoutp011fa6bb3dcb52f181f616466d2d83a260~1uYmBa5aY2650726507euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690461235;
        bh=ESao0eb/63+IOmT+CrRxQc0TcsKVTFJG1DZ6DhG4oFk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=QrhkT+yHOVk6ZIQla3AsA+uw6V4Vt4grecFFjbwNuJUE8j5OpswY67jc3l+cDZCqw
         x6iXvYkVOpHUahtsSIc2vfjHMusn/pKQPzDaZDmefklc/76rcACjcV/KVj9TV3tz81
         t8we/+oAUc8vdeX9RlalMwoRWC809Fq6daSbc9Hw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230727123355eucas1p121bfab9abf76d47b1fd2f6401b827ca0~1uYluVjjE2818128181eucas1p1k;
        Thu, 27 Jul 2023 12:33:55 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B8.EF.42423.23462C46; Thu, 27
        Jul 2023 13:33:54 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230727123354eucas1p17dfd7ad69206f1e22095fa2fa74cc46c~1uYlObG3o2951129511eucas1p1n;
        Thu, 27 Jul 2023 12:33:54 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230727123354eusmtrp1774137adf3f8a42b8db0385aedd59942~1uYlMOYAG0066900669eusmtrp1a;
        Thu, 27 Jul 2023 12:33:54 +0000 (GMT)
X-AuditID: cbfec7f2-25927a800002a5b7-d1-64c26432a8d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 20.4D.10549.23462C46; Thu, 27
        Jul 2023 13:33:54 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230727123354eusmtip1feb09772860766eae1779718ee7beb64~1uYk--V7o1930419304eusmtip1F;
        Thu, 27 Jul 2023 12:33:54 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 27 Jul 2023 13:33:53 +0100
Date:   Thu, 27 Jul 2023 14:33:52 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "Stefan Schmidt" <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "Santosh Shilimkar" <santosh.shilimkar@oracle.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, <willy@infradead.org>,
        <keescook@chromium.org>, <josh@joshtriplett.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
        <mptcp@lists.linux.dev>, <linux-rdma@vger.kernel.org>,
        <rds-devel@oss.oracle.com>, <linux-sctp@vger.kernel.org>,
        <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 11/14] networking: Update to register_net_sysctl_sz
Message-ID: <20230727123352.tz4orwpczgkzgout@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="hkodhcvqkudu4q33"
Content-Disposition: inline
In-Reply-To: <ZMFgZHsnhrXNIQ53@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0xTZxjG951zes4pruxQDHxcIgrqEJDbCHwILC5Z2MlcAtn+cCHz0tAT
        wEFLWlCmmQGmqDhcpQYBEQsy5LIBA6wDFsa6AeNiKZNtgG5CB0igUoGOcok46sHNZP/93vd5
        ni/v88dH4+JV0pVOkqVxCpkk2ZO0I7RdKwN7g6U6aaB+cB/SZYah8e9yBahk4AyB6lrPYmiy
        y0ihO4+sJLo4446GKp+Q6JlGjvovpiBzwTUMGbSXBOheawmJpnR5BFKVfYajSc2sAD1QVxLI
        WG/G0GpVtwDp857hqKp/CkPDqkmAfjzXLkD99dkU6tI4oaU+E0D6pkUBGlcNEEhd1YyhtgvL
        FPrL+ohEWf1aCq0tl5D7d7ClX51ir2UOEuzqig/bXD2CsS3Ff1CstmMXq2lMZ5uqfNjR2Si2
        seYCybaMh7Oq8g7ATjcVAXZ+cpRgDZUmkjW3/0rGOsbZRUq55KTjnCLgzaN2iaqJLCz1iltG
        Qf4SyAQFTrlASEMmBOpqVkEusKPFTBWAmpJh0iaIGQuAxutuvLAIYHbrEHiRWLNYCV64BeCC
        cQz/1zV8R0vxw20A+1tLN2w0TTC74MOf3relScYPDpge4DbeynjDdlUeZvPjzA0hbPvaRNkE
        R+YdOL9eTthYxITBrqudgGcH2FM08XyPMxlw6m4ZaXsfZ9zgrXXahkImFPZWePCHesEfKtYo
        nj+Fvc2jGM+FW+Ci5j2e34YN5nObxRzhTHfzpt8d9qk/f14SMmoAv19/QvFDLYCVWX9vvhQB
        zwxNbCbeguXrBsx2BGTs4fBjB/5Me5ivvYrzaxE8nyPm3bth7Z8mQgW8il8qVvxSseL/ivFr
        P6hpW/j/2hdWls3iPEfBujozoQFUDXDm0pUpCZwySMad8FdKUpTpsgT/eHlKI9j4En3r3Qvf
        gusz8/46gNFAB3ZuhI0NtQbgSsjkMs5zq6g3VicVi6SST05yCvkRRXoyp9QBN5rwdBb5RvXE
        i5kESRr3McelcooXKkYLXTOxwLHTFmHhqyuN8tiwQx6n0koMX5qT9IVjhe1LO8KNIa/djg6Y
        z349MuUNZUWZomWE8BUdHv8tLLTonjDYl7GmHlBbpNIPm34/ts1SMRhXLdi+bPpmMdLpl+Up
        +wzrQXRpVth41hLjtWff3ajl4tWOnw99JJJVJwnEsvPvRvc0aEOZ1IzLnhEGnAu0iktdlO7Z
        4P7joC05Lt2B03V+vtNuTZ3h+VA/F2N09Tqau8fsfWQ24APtzQO7Y3K8w4KrXQSnn25v0GGK
        Tv8GD6dXxAePRXRtUx93rp6by1uLi7kcfz8kbu8NQQE1SLdG78dF9Q+/qD1ZmFgzcvhE4JpM
        7jCc8NSTUCZKgnxwhVLyD3dk40WNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSe0xTVxzHd+69vS0O5rU8PAMStcPBcFzayuOAoMu2zItxiZnLNll8VHsH
        OtpiHwwkzrphXHGwYs14jlRAVsQUbRWETcY6HhkQqHMoIITHVlBg6VC3ykMYtVlmsv8+5/d9
        nJOTHw/nF5GBvMNyNauUS9IE5Cqia6ljOEIstUmF9268iGzaWDT2fS4HlfXmEMjcdApDjvZx
        LmqYdJHozFQw+rX6TxItGxWo+4wMOb8uxZC9Pp+DbjWVkWjClkcg/fnPceQwTnPQkKGaQON1
        TgzNmzo4qCdvGUem7gkM9esdAP10upmDuus+46J2YwD6u2sGoB7rQw4a0/cSyGC6iqHvdI+5
        6DfXJIlOdtdz0cLjMvK1DUz5pWymVHuTYObnwpmrNQMY01gyzGXqWzYyRouGsZrCmcHpRMZy
        UUcyjWNxjL6iBTD3rMWAmXUMEoy9eoZknM195C7fZDpBqdCo2fWpCpU6UfChCIlpURyixVFx
        tGhz7N54cbQgcmuClE07nMEqI7ceoFP7+wuw9LNBmYOlWkwLzgXkAi8epKLgwiMXkQtW8fjU
        BQBdI9eBRwiGVx71cTzsCxdv55Ie0yyANRWLuOdwDcD8vMoVF49HUBvhSOs77gBJvQp7Z4Zw
        N/tRYbBZn4e5/Tj1jRecu2Qg3IIvtR3OLlU8ZR8qFrYXtgFP6QMA680W3COsgT8X//7UhFMZ
        cPTOZcx9GU4FwW+XeG70omJgZ9U6z0Nfgj9WLXA9fBw+fDIB9MC35JmikmeKSv4r8ozDYf/S
        /f+PN8Hq89O4hxOh2ewkjIB7EfixGpUsRaYS0SqJTKWRp9CHFDILWFnL+vY563VQPjVL2wDG
        AzYQspIcv1xrB4GEXCFnBX4+nbtsUr6PVJJ1jFUq9is1aazKBqJXPrEAD/Q/pFjZcbl6vyhG
        GC2KiokTRsfFbBas9UlK/0LCp1IkavZjlk1nlf/mMJ5XoBarFST17BT6T+7IjPSeCqWHKoOm
        W9ue57acoOePvmev09wRrlve9yAYM1x7/3TOEfPEkcq7YYlLHxy9ad2QVHw/U2/Yk7OYNzBV
        sqm8eBsI2f1Lti8Tei7NMapzJuu+yuR0phcMh2ypMiSHqe1N8R0ZJ18WzDMWjbOoLUM3QI32
        5Xc08LKNf+AHvQsHJ6188U5OBHzBsi1LaHrryq3AnN3eN2qPW/pDHca+avunF3SNyuKANyvX
        CFpeD+byUw6euj0zNBUyOjC2fl/0jiDzgYIfntBfip/z/0hbiCWYiu7ueXcmK8S/wTWX9EnX
        2WM+dWvfbt+yOuJEa3C88K9X/N7o3DtSIyBUqRJROK5USf4Bb+3wOysEAAA=
X-CMS-MailID: 20230727123354eucas1p17dfd7ad69206f1e22095fa2fa74cc46c
X-Msg-Generator: CA
X-RootMTR: 20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc@eucas1p2.samsung.com>
        <20230726140635.2059334-12-j.granados@samsung.com>
        <ZMFgZHsnhrXNIQ53@bombadil.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--hkodhcvqkudu4q33
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 11:05:24AM -0700, Luis Chamberlain wrote:
> On Wed, Jul 26, 2023 at 04:06:31PM +0200, Joel Granados wrote:
> > This is part of the effort to remove the sentinel (last empty) element
> > from the ctl_table arrays. We update to the new function and pass it the
> > array size. Care is taken to mirror the NULL assignments with a size of
> > zero (for the unprivileged users). An additional size function was added
> > to the following files in order to calculate the size of an array that
> > is defined in another file:
> >     include/net/ipv6.h
> >     net/ipv6/icmp.c
> >     net/ipv6/route.c
> >     net/ipv6/sysctl_net_ipv6.c
> >=20
>=20
> Same here as with the other patches, the "why" and size impact should go =
here.
> I'll skip mentioning that in the other patches.
Indeed. FYI: I answered in your original feedback.

>=20
> > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > index bf6e81d56263..5bad14b3c71e 100644
> > --- a/net/mpls/af_mpls.c
> > +++ b/net/mpls/af_mpls.c
> > @@ -1396,6 +1396,40 @@ static const struct ctl_table mpls_dev_table[] =
=3D {
> >  	{ }
> >  };
> > =20
> > +static int mpls_platform_labels(struct ctl_table *table, int write,
> > +				void *buffer, size_t *lenp, loff_t *ppos);
> > +#define MPLS_NS_SYSCTL_OFFSET(field)		\
> > +	(&((struct net *)0)->field)
> > +
> > +static const struct ctl_table mpls_table[] =3D {
> > +	{
> > +		.procname	=3D "platform_labels",
> > +		.data		=3D NULL,
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D mpls_platform_labels,
> > +	},
> > +	{
> > +		.procname	=3D "ip_ttl_propagate",
> > +		.data		=3D MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D proc_dointvec_minmax,
> > +		.extra1		=3D SYSCTL_ZERO,
> > +		.extra2		=3D SYSCTL_ONE,
> > +	},
> > +	{
> > +		.procname	=3D "default_ttl",
> > +		.data		=3D MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D proc_dointvec_minmax,
> > +		.extra1		=3D SYSCTL_ONE,
> > +		.extra2		=3D &ttl_max,
> > +	},
> > +	{ }
> > +};
>=20
> Unless we hear otherwise from networking folks, I think this move alone
> should probably go as a separate patch with no functional changes to
> make the changes easier to review / bisect.

Ok. I'll take it out in its own commit and prepend it as a preparation
patch.

thx for the feedback
Best

Joel Granados

--hkodhcvqkudu4q33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTCZC8ACgkQupfNUreW
QU++Cgv+L+FesAof5vpcRR2uXQ6W1aCB2JYlyD4lhEiA2jdr7vqQcYM5arelBnZ3
zLPO574TF5h9CcWe/fec4Cxt5UqisMDcprEwz867PZjsAnbEYD1at9ECzkPSWi+6
FFh9/UJA1Trh3xlYmuGMt7QCfGauxBj/8uX2uvCZYCfdLkms1Fl7tznqCdYowhNy
HfWTnAAg7obXUhb9TcrmYmrcKdAvU7julEHblDunvyamW78pfLwBZf0QMiJD0rJA
y4u3GMOeNvK4cWOZXZcTkGDmL3J19POwGEER3WCqBzNZKgMkZwlMOxcF1ExXZMze
OUWv0MnkaqJCBqpX+ZoAmtpV14hCV6Hd8jyh9ACVIrwm1IBqz3Kznpis7HvX8S+c
LLuBb7Cn5CDNHQ+Y293dIhjVYhY4nYQ8l9K3N4GKj53ge6/zCfFgYGKnDdv310gO
tqje0Ur0CQwUR47VCq23yqJ/FrNvokpoDLcsDZ+T0vVsx6Ekj8SoQlH3V3FaBEiN
1/E+oc6T
=hoeA
-----END PGP SIGNATURE-----

--hkodhcvqkudu4q33--
