Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37D77664CF
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Jul 2023 09:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjG1HI2 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 28 Jul 2023 03:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjG1HI1 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 28 Jul 2023 03:08:27 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EB12680;
        Fri, 28 Jul 2023 00:08:26 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230728070825euoutp02e0189b80afb139f4dff8be57f53016c8~19lrhq8M23066530665euoutp02q;
        Fri, 28 Jul 2023 07:08:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230728070825euoutp02e0189b80afb139f4dff8be57f53016c8~19lrhq8M23066530665euoutp02q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690528105;
        bh=Qum+fxM7RBPyl8y3MhCFLGsyQrNSjW2pNwmJJVFVq4U=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ryd3VYtm0+5rgl/Shny/9cY+Tj/A5M5yV/5VlzG9N+GJ3NbDcO4bM1OYc0q28zV65
         oUeMqDN9GZwlD9QiZqcZd5ZAR3EVT7QFc6rgCAXftVkbPbdP3NVePOsfjOIFA5j52B
         +27c461AwFCTUU/15FQthDkMYdDYJ3KOG5ChwGvw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230728070825eucas1p124d2c559172bf02d7e919934a78f9bc8~19lrUuP_A1311313113eucas1p1I;
        Fri, 28 Jul 2023 07:08:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.5C.11320.86963C46; Fri, 28
        Jul 2023 08:08:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230728070824eucas1p239506fe062a80030f37e790fada1ac50~19lq3mhpq2942129421eucas1p2B;
        Fri, 28 Jul 2023 07:08:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230728070824eusmtrp28cd58d9b2c8f37b17869ccf540f7eae9~19lq2gvF32588125881eusmtrp2k;
        Fri, 28 Jul 2023 07:08:24 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-d5-64c36968e8ba
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7C.D5.14344.86963C46; Fri, 28
        Jul 2023 08:08:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230728070824eusmtip1e6b70b6317fdef07d815019042b4f5da~19lqnXEG-1864518645eusmtip14;
        Fri, 28 Jul 2023 07:08:24 +0000 (GMT)
Received: from localhost (106.210.248.223) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 28 Jul 2023 08:08:23 +0100
Date:   Fri, 28 Jul 2023 09:08:22 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
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
Message-ID: <20230728070822.nfxb36kvvd7dio2a@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="3lhbyvnp3aqbgl2h"
Content-Disposition: inline
In-Reply-To: <ZMFgZHsnhrXNIQ53@bombadil.infradead.org>
X-Originating-IP: [106.210.248.223]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTaVBTZxSG+917c5PAhLmy+Ql0rFBpixRb25HPUuhil9tOfzDTP9rVKLfs
        gUmgVagDFFFIBDJipSxioJkQgSIDIZTFCEFBNkkLRcCYKYEAAzgQoQSFhgIXW2f673nPed85
        5/w4PNx5jfTgRYoSGLFIGONNOhDajkf9L0dGtoe9MpeLIX1qIBprkXJQcf8ZAlU3ZWDI0mHm
        ooYpG4lkM15oULVAonVFHOqVxaL5S0UYMmhzOGigqZhEk/psAslL03FkUcxykDFPRSDztXkM
        PVZ3ctCd7HUcqXsnMTQstwDUfk7HQb3XfuCiDoU7Wu6ZA+hO3SIHjcn7CZSn1mCoOWuFi8Zt
        UyRK69Vy0epKMfn2HrqkKpkuSv2NoB8/8qM1V0cwurHwPpfWtu6lFbWJdJ3ajx6dDaZrK7JI
        unHsEC0vawX0dF0BoK2WUYI2qOZIel73Bxnq8pnDm2FMTOS3jHh/yDGHCHl6I4iv8Tx5t55J
        BVXuUsDnQep1ePZ+Ji4FDjxnSg3g+aXL22IJQNl8A2DFIoCDzRriSaTgbg6HbZQDqD4/jv3r
        yjfbuKyoB1CnzMI2IwS1F7anXwKbTFL+sH/OiG+yK/Ui1Mmzt9I4VcCH9QW/b5lcqA+h1V62
        NU9ABcKhpo5t3gG7Cia2GKdOwpE/TRt+3gZ7wnI7bxP51EHYrdzNbuoD25SrXJZPw27N6NYo
        SF10hPcK0zls4z2YutYJWHaBM52a7YAXXG+8sh3IA/CGfYHLikoAVWl/YawrCJ4ZnNhOvAPL
        7AZscwtIOcHhBzvYPZ3gBW0+zpYFMPOsM+v2hZWmOUIOfAqfuqzwqcsK/7uMLftDRfND8n/l
        fVBVOouzHAyrq+cJBeBWgJ1MoiQ2nJEcEDHfBUiEsZJEUXjAibjYWrDxFD32zqVfQfmMNUAP
        MB7Qg+c3wuaaSgPwIERxIsbbVdAdqg9zFoQJTyUx4rivxYkxjEQPPHmE907BvuCuE85UuDCB
        iWaYeEb8pIvx+B6pWFkQv8u6y2nxsCpx2fFnzKmPdDPlZy8j69iazriQnuw9sNJi9Bkp+eb6
        UC4vxEROYSFeFSVfMr0/YnUqXBsRGEUEP3Pv1FTJrltDKwN9jtG1TiZzw99HawS7VRf6Fien
        Gw96yWJo/2F+2v5y99UrlqttKa3hrTcSbAEr18uj9OaMl+QHPlY2fPHwl9PPJk0EyC5/2sLv
        KpouTUvOGo/PdDku6zmW23kzJdoz543FoZIPXjjqe0vpeztIefNzt+LxUMtzF3Ptx2FbS0I1
        X+omSJLOru4xRmT+5PX9YfFH+a7uQRmfHPoqRWGQvIaizi0J+eRbo1UPupflt5tsdfnvH3n3
        iDchiRC+6oeLJcJ/AIEgf2SPBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA2WSf1CTdRzH/W7P8+yBWj2Npd+mSU3tbOJgyI/vOvlx1OljXZcW3XkmwZLn
        2C7YaGP8qOtCsUAQbkUhm6iDFAZ5UwdMIA91FBSOH0YSCmaMNgzw1oT4qdBgdXnXf6/7fN6v
        933vex+SzSsnBKRCmcGolbJUIeGPXVvsuL1VrmhLDik6tR7ZciPR8KVCHFX0HMaQueVTFnK2
        Ozjo4ugMgYrG1qGfq/8k0JJRhexFachddpyFeq0lOOprqSCQy1aMIV1lHhs5jeM4GiqtxpDj
        nJuF5k0dOOouXmIjk93FQgM6J0Bt+a04sp87xEHtxtVo+toEQN31kzga1vVgqNTUwELfHpnl
        oJGZUQIdtFs5aGG2goh9nj559iP6eO51jJ6fE9ENtTdZdLPhNoe2XtlEGy1aut4kom+NR9GW
        uiME3TwspXVVVwB9t14PaI/zFkb3Vk8QtLv1BrE7YJ94u1qlzWCek6s0GVHCdyQoVCyRInFo
        mFQs2RaZ8FJouDA4ensyk6rIZNTB0UliednYm+nmtdknLn8PckHd6kLgR0IqDOp/KcELgT/J
        o84AOGZyAt9iHbwwdQP3cQB80F9I+EIeAIumrv9jNAJYcNSELacwahNsyytbsQkqCPZMDLGX
        mU9thq26YtaywKaO+cGls43E8iKA2gk9i1UrMpeKhP0t7Ziv9T6AVrOF7Vs8BX/U/74SYlOZ
        sGfksreJ9PJaWLNILqMfFQE7Twf6XroBXj29wPHxx3DyoQvoQIDhkSLDI0WG/4p8YxEcWPzj
        /+MtsLpynO3jKGg2uzEj4NQBPqPVpKWkaULFGlmaRqtMER9QpVmA9yyt7XMNTaB2zCO2ARYJ
        bGCj13Sc/6YXCDClSskI+dzO3bZkHjdZlvMho1YlqrWpjMYGwr2/+Dlb8PQBlffGlRmJkoiQ
        cElYhDQkXBqxTbiGuyu9QMajUmQZzPsMk86o//VYpJ8gl6WIv/PeF5lnkpY+4f/W3iXwFL5s
        KX/98Xv3k2pfTT1VEhPbtDXkq7+mm7pHB/amTD2xY5ehe08C+XagI+ex/qyctwY1934qxfZf
        HX5W+Cuec2Jhh7PDHBdenR/hOBj4yneXXMXUvCZrzfnp/dF5aCM/rkQA4rmrRH2NI8YXFVMJ
        XwbxRPrDhvQ6xdzsC/5h8kq5arSAK2i+6Roar6msmwoGXdoL8880XQzYQkoHa1+beDcoPz4x
        9mEc3tx3940NloYZbG+9Liy7N1Nf4+q6w3sQtD43i0rk8/Ay0rGKN6qMN8r3bf4aTsZ8oDT9
        MPeke2xPc1V5yqHOmMEe+2cnqZijeLYQ08hlEhFbrZH9DbOD1zsrBAAA
X-CMS-MailID: 20230728070824eucas1p239506fe062a80030f37e790fada1ac50
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--3lhbyvnp3aqbgl2h
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
On further inspection, I have dropped this part of the patch as there is
no real reason to move the mpls_table up the file. I'll comment this in
the new cover letter
>=20
>   Luis

--=20

Joel Granados

--3lhbyvnp3aqbgl2h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmTDaWYACgkQupfNUreW
QU/68gv+P47PIm5nu/CZnpp6uod9hTLumW0n2GsP/jLYIUvXVJHO9gtSYY8+G6EP
p1IUx5D0qtSHqv7OxVAzrxX63AarjiRYZsD0ocIwfaJsSHFk7zXswRrm59PoEy7Q
00UgQIY/u30jDcSHTIq9OEuvX0wExPElHNtp08psZZIbaF6QylEemqfSnJ21YFNc
A44bqIsrTlor9EIuw0rxLcJ7ozCsY0RgaZ7Hc0XE15kqJcoYimMI369R6x+L5d7H
TxMc+xII07Sd8oNqTAKf8FgKk6v1D+LV6MVfUUuafSYuaDGQVHCkrd0xKnlBo+oC
f8cSmYkxxrrwEq7fgKhUvvA9Bw1h2d4nXtLH6DgAnj3aMxfqvX1VGw7BtE/E2a1a
idlmcB8D17LQCt/VXEuCnD1rFiQQoQYdWUNWlwIBuXVVDZ5k5WSQUcgQAyXXaNpS
KRtvOO7XtsXUqBBJ5rG/d9XLEM+FJ95kmgdts6i1DbsbIeJCY6ixSc8UL5F53z2e
MVDcle5T
=PdNZ
-----END PGP SIGNATURE-----

--3lhbyvnp3aqbgl2h--
