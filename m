Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4489738350
	for <lists+linux-sctp@lfdr.de>; Wed, 21 Jun 2023 14:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjFULgg (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 21 Jun 2023 07:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjFULge (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 21 Jun 2023 07:36:34 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE36E6C;
        Wed, 21 Jun 2023 04:36:30 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621113629euoutp012b7600df2066e4bf78303bced9a8ed4e~qqYKol0t21354513545euoutp01p;
        Wed, 21 Jun 2023 11:36:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621113629euoutp012b7600df2066e4bf78303bced9a8ed4e~qqYKol0t21354513545euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687347389;
        bh=xi7eTGf/eo7hL99txpODdPbOTqM8SUp1Uvq7GSYr9t0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=HjKp+av5H9OWz9N+piZmYV0JdOXyasDQu7fP+oVjXb7Y+kVM0Io3ajx0enmD93+1o
         QfCtJMzVFDU6VNsScQsUkuUaPpqyeN3tDl929Z9gJ11rJnIBnBf90vEPEmWbs2ovDI
         ArrLVq+1RFmQTKQQj7R4dAFkdlj57Bg06J9ZJDN0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621113628eucas1p18dc4a47d820546aae77b120440703891~qqYKc3a9o2370123701eucas1p1k;
        Wed, 21 Jun 2023 11:36:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 29.2E.11320.CB0E2946; Wed, 21
        Jun 2023 12:36:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621113628eucas1p18b8b3a6f7d1ef4aba77c09ed055cfee7~qqYJsMEWT2369923699eucas1p1j;
        Wed, 21 Jun 2023 11:36:28 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621113628eusmtrp26515415e90323d1e726f7d3ea7190824~qqYJq3vSy1151411514eusmtrp2f;
        Wed, 21 Jun 2023 11:36:28 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-89-6492e0bc5391
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 29.E9.14344.BB0E2946; Wed, 21
        Jun 2023 12:36:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621113627eusmtip20349e9f78906bf813c43fd84e62c8aad~qqYJYzSLB2263722637eusmtip2C;
        Wed, 21 Jun 2023 11:36:27 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 12:36:26 +0100
Date:   Wed, 21 Jun 2023 13:36:25 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <mcgrof@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Remi Denis-Courmont <courmisch@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>,
        Martin Schiller <ms@dev.tdt.de>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-hams@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
        <coreteam@netfilter.org>, <bridge@lists.linux-foundation.org>,
        <dccp@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
        <mptcp@lists.linux.dev>, <lvs-devel@vger.kernel.org>,
        <rds-devel@oss.oracle.com>, <linux-afs@lists.infradead.org>,
        <linux-sctp@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        <linux-x25@vger.kernel.org>
Subject: Re: [PATCH 06/11] sysctl: Add size to register_net_sysctl function
Message-ID: <20230621113625.o54p6qfvr5duskfb@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="hjmbaevabjqfrodd"
Content-Disposition: inline
In-Reply-To: <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2VTa1BUZRie75yzu4dV7ICOfIOUite4mZbypuJk1nSmrJxGh7QG25ETIrDY
        riSVxXIXCN0BExeJRVRYXC5yW+K2EhSwQKyjKIir5MqaIcIGrLHczHWxnOnf8zzv87zf+/z4
        aNL5vsCVDhYf4iRiUag7X0hpmq1677rf0wJf0SpXQaPMF1oLbwpgujqRhNE7f/DAnB0vgCx9
        HAXT3Sl8GIqZpKC4Jp4AU7NRAJpUNYKUATeIrbQg6D9u5EFXnpkPilOtCPosRgqsx+aAIjmW
        gOGTpwm4rDnGgxMT50mQt62F61W3CLhak8WHe42pFMjPxJJgynnAA0N6HgUN9UoExpJhAmKV
        IyTEjt4lYULVwoPO1MckqDruEdAjNyFoStTyoKMkRgCPsltJaM5ZCPLiNgp6Y3V8eNQ+iCBj
        8BoJV+qWQ9vYYwI6y0d5MJq1Gu7I9RSkqyoIqE0aF0CF/gBEd2gEcLe7m3zDl+01Wkh2qFOH
        2OzCb9gJqwdbUXCDYFN+GSDZ6sxbAlbTsILNKYtgyy4k8VnD9To++2tBEcHKcxsQW34uik3v
        yUfs/XIF2rFkj3BzIBca/CUnWbPlM+H+tqP+B+M9Ig0qPSlDWe7JyIHGzGu4IqaJTEZC2plR
        IVx2+grPTsYQbq1vpuxkFGFTWinvWWSwSzbrykf4bpNW8K8rqb2PsJNKhFUlSsoWoZgVeNys
        ImyYz3hh/aCBtOEFT/DMdPrTN0im9AX8oOYGsg3mM+9hs+wkPxnRtCPji2u/X2yTHRknrFP0
        P91JMpH44bgC2Swkswjnz9A22YF5Ex+3/kbYL12Gu7Vn+Xb8LW6r6J3Vc+fi87dX2/FbuGP6
        vsCO5+OBlopZ7IYfVyufdsFMOsKXZswCO1EjnBdtmd20Ccd19c8mtuKY6VzSdhBm5uGeh072
        O+fhNE3GrOyIjyY4290rsfr2ICVHyzKfa5b5XLPM/5rZZS+cUzvC/5/sifPOPCDt2A8XFw9T
        OUhwAblwEdKwIE66Tswd9pGKwqQR4iCffeFhZejJB2yfaRn7CeUP/OXTiAgaNaLlT8LGi+rL
        yJUSh4s59wWOL5alBTo7Boq++pqThO+VRIRy0ka0iKbcXRw9/XT7nJkg0SEuhOMOcpJnU4J2
        cJURPledwiqdjtw+fDDrgHnkpXOSS5tk83RLGzav3kZHG46QXlPv7hqZWh9t3WJJ6ftkqaWL
        v+HVyL8r6fOaMX/XUs8St76dU94rV3mJVZMBKfFrNuzZeG1D1Zw9Ud4ZoeXqocC3PxiQGyR7
        UxK2Ltbu8HlZnkje6dromZ02afUcT6j78f0v3MrjwgsUf/r5vz5TYOosCggK293bNmbJ+NkS
        h1Qf7fJeuLN198fD4VpRx4l2l2UJwaeOH/qcMF3xD3C49c4S/+2FRZVDIb5VP0zkLV1SP/Xp
        qoJ1OFdduH7uxfVJwVG7hB92d+l6z9Ykud9MvuRX1i8WKo8YVn4XsqjGtEYWv/1ieXOkOyXd
        L1rrQUqkon8A7wAmHvsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTe0yTZxTG937f1wsysnKRfWMsaoVsQVdo5XIwApM/6secm1tiZCpohS+A
        o4W0heHGAqM4EIFW2HBchoAIBRHGrSgIQea4FATnuA0BRwVEaAAFVEBwdN3ikv33O+c8z3Pe
        vMlh4xbxLBt2iEROSyWiUC5zE9G53jb6fsOfaYFOa00u0BLrBu1l91iwdj0Bh4WxhwyYzz3D
        gpyeeALWBs4xYTZulYDy+jMYTLTqWKBJuYLg3LQtKGqXEIwrdQzoLZpnQuaP7QjuL+kIWE41
        hcwkBQZzGdkY3NGkMuD7lcs4qLR86K8bweD3+hwmTLakEKDKV+AwkTfDgOH0IgKaGy8i0FXM
        YaC4+AQHxcIDHFbUbQzoTnmJg7prEoNB1QSCXxKaGNBVEceCp7ntOLTmWYOqXEvAkKKDCU87
        9Qgu6PtwuHvDDrSLLzHorl5gwELOezCm6iEgXV2DQcPZ5yyo6TkF33ZpWPBgYAD/wI0a0i3h
        1Gx3B6Jyy76mVpYdqJqSPzDq3K1pnLqeNcKiNM32VF5VBFVVepZJDfffYFK/llzFKFVBM6Kq
        C2Oo9MFiRE1VZ6KDW4/w9kjDIuT01uAwmdyDe5QPAh7fHXgCZ3cef5eb326BC9fRc08gHRoS
        SUsdPU/wgtUjhYxwhUNU6vlOVizK4iYhEzbJcSb1vbGMJLSJbcG5jMj8hhVkHNiSlYt9DCNb
        ki/6k5hG0WNElix9909Ri8ieoQ6WQUVw7Mnn82rMwEzOTrJHP4wb2GqD19fSCYMB51S+QeqT
        ywjDwJKzn5yPzdhIYrPNOG5kQ/IWY+gqIhvHVv9ebcYxJzsyxwmDBudEktcSQ4z4Nlm8zjYo
        TDjepHL5NmZ86HZyoOkS08jfkAtrk0iFLLP+E5T1KijrVZBBgXMcyMH1R9j/2jvIovwZ3Mge
        ZHn5HJGHWKXIio6QiYPEMgFPJhLLIiRBvIAwcRXaOAFN63LNNVQy/ZjXgjA2akF2G07dz1fu
        IBtCEiahuVZm71SlBVqYBYpOf0VLw45LI0JpWQty2fjD87jN5oCwjXuSyI/zXZ1c+M6u7k4u
        7q67uG+a+YQniiw4QSI5/QVNh9PSf30Y28QmFjt8fyYyY/TLxflPTkZ5F/LdVk1JGtKKT/Q+
        U5p8Nlv7ro+66ZijKPHm5x+hOXzz1Lh94riX0E8TXTEm8JPndDa+0LnXvWUdv1fo05592pY7
        2sf1FHtat+3W1vRLP05a+rRgx8LBRb6QqBtWBlhuee3ScHDJqZ/mUrZFxcTFaIQqdGtErKrv
        8S/N0e6/97DvpuuB3xbF+45sy/bPDdBGTzWGzAxOeEl89/pz5R/K8SiCEAk6K82fCe22qxJM
        F8MPmT0yyQo5fHvf0Yx5ZZGtr0eC9kmO6PXKHyxaBdIZ8wMn9RcSRrPbXLytC2TZh47t9I0W
        pnslO3h4Jfv53VUJrypNuYQsWMR3wKUy0V9edMuAlwQAAA==
X-CMS-MailID: 20230621113628eucas1p18b8b3a6f7d1ef4aba77c09ed055cfee7
X-Msg-Generator: CA
X-RootMTR: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa@eucas1p1.samsung.com>
        <20230621091000.424843-7-j.granados@samsung.com>
        <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
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

--hjmbaevabjqfrodd
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 12:47:30PM +0300, Dan Carpenter wrote:
> The patchset doesn't include the actual interesting changes, just a
> bunch of mechanical prep work.
Yep, The thread got mangled on the way out. But hopefully the rest of
the patch made its way to the lists and maintainers.

>=20
> On Wed, Jun 21, 2023 at 11:09:55AM +0200, Joel Granados wrote:
> > diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowp=
an/reassembly.c
> > index a91283d1e5bf..7b717434368c 100644
> > --- a/net/ieee802154/6lowpan/reassembly.c
> > +++ b/net/ieee802154/6lowpan/reassembly.c
> > @@ -379,7 +379,8 @@ static int __net_init lowpan_frags_ns_sysctl_regist=
er(struct net *net)
> >  	table[1].extra2	=3D &ieee802154_lowpan->fqdir->high_thresh;
> >  	table[2].data	=3D &ieee802154_lowpan->fqdir->timeout;
> > =20
> > -	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table);
> > +	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table,
> > +				  ARRAY_SIZE(lowpan_frags_ns_ctl_table));
>=20
> For example, in lowpan_frags_ns_sysctl_register() the sentinel is
> sometimes element zero if the user doesn't have enough permissions.  I
> would want to ensure that was handled correctly, but that's going to be
> done later in a completely different patchset.  I'm definitely not going
> to remember to check.
Very good catch! I have fixed this as well as ensure_safe_net_sysctl
that was missing a table_size arg.

>=20
> > diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> > index dc5165d3eec4..6f96aae76537 100644
> > --- a/net/mpls/af_mpls.c
> > +++ b/net/mpls/af_mpls.c
> > @@ -1395,6 +1395,40 @@ static const struct ctl_table mpls_dev_table[] =
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
> > +
> >  static int mpls_dev_sysctl_register(struct net_device *dev,
> >  				    struct mpls_dev *mdev)
> >  {
> > @@ -1410,7 +1444,7 @@ static int mpls_dev_sysctl_register(struct net_de=
vice *dev,
> >  	/* Table data contains only offsets relative to the base of
> >  	 * the mdev at this point, so make them absolute.
> >  	 */
> > -	for (i =3D 0; i < ARRAY_SIZE(mpls_dev_table); i++) {
> > +	for (i =3D 0; i < ARRAY_SIZE(mpls_dev_table) - 1; i++) {
>=20
> Adding the " - 1" is just a gratuitous change.  It's not required.
> It makes that patch more confusing to review.  And you're just going
> to have to change it back to how it was if you remove the sentinel.
Removed this for convenience. Thx.


>=20
> >  		table[i].data =3D (char *)mdev + (uintptr_t)table[i].data;
> >  		table[i].extra1 =3D mdev;
> >  		table[i].extra2 =3D net;
> > @@ -1418,7 +1452,8 @@ static int mpls_dev_sysctl_register(struct net_de=
vice *dev,
> > =20
> >  	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
> > =20
> > -	mdev->sysctl =3D register_net_sysctl(net, path, table);
> > +	mdev->sysctl =3D register_net_sysctl(net, path, table,
> > +					   ARRAY_SIZE(mpls_dev_table));
> >  	if (!mdev->sysctl)
> >  		goto free;
> > =20
> > @@ -1432,6 +1467,7 @@ static int mpls_dev_sysctl_register(struct net_de=
vice *dev,
> >  	return -ENOBUFS;
> >  }
> > =20
> > +
Oops. thx. fixed

>=20
> Double blank line.
>=20
> >  static void mpls_dev_sysctl_unregister(struct net_device *dev,
> >  				       struct mpls_dev *mdev)
> >  {
>=20
> regards,
> dan carpenter

--=20

Joel Granados

--hjmbaevabjqfrodd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS4LkACgkQupfNUreW
QU/f/Av/R9arMJ/TiZiqAogcW91VL9TisCyhWWoGaao2pCurV0d4vQIZ22no1jLz
HOEQ8SmtnWRZeyVNdgB7JZ5LM1wEGu3I/NnYEThVwKKblsSErfTYdUKTi5VyBDUj
UjuPXKvJPdKhW8XwN/d5gKHeY8ugeCZI82AEKP3qqv/p+Tsai8fqlTU4frjB77C2
pi6zJv+WXkEUknsHnTZQJBV+TL+UJaghgjkhV0QWf8n0dzveTLsK7XhKQxszk067
fos0Ckxs3JrFiC8eWPX7/Qm8H2qg64O2Y51uD8ahz0EcUWxV8f1UDk4PsgUvACu1
oEVx/n+aGQGKiOafURew4esnRnmhet8t8EkTGoEQaxqsU7jXnClyR5DWTrVDnT3c
YHUavHdXH0qCFQoTXaa2YWcds8WpmPuzEDQLnAmhoOKr8C4+NUri6y0HGdBTwHcG
rQCCd2NcjGCEepKDVkuvJkoMkfj72FpOK+jb+M7K0JQIsRKxKDhPLo31xiesBx05
mm4+Slxp
=d3wP
-----END PGP SIGNATURE-----

--hjmbaevabjqfrodd--
