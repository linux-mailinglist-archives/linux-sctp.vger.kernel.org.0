Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C56738301
	for <lists+linux-sctp@lfdr.de>; Wed, 21 Jun 2023 14:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjFULth (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 21 Jun 2023 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFULtf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 21 Jun 2023 07:49:35 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E102E10E6;
        Wed, 21 Jun 2023 04:49:32 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621114930euoutp01007ea2375933ef64cd5e6966fc60621f~qqjiTWtbe2666626666euoutp017;
        Wed, 21 Jun 2023 11:49:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621114930euoutp01007ea2375933ef64cd5e6966fc60621f~qqjiTWtbe2666626666euoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687348170;
        bh=PzMFvtKImw0dyYUTQxJ85oPhNKqG7Ykb5TiTJxlLD3g=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=gk+dh4W96w3bDafhN3F6jFGT6xHg1On7iXDg6B0+71afDjwkoxfY27aCQ/7ZeiTBH
         iahKK2uIJ+DLBiybih0z2KlK6SBqsdOaavCW3V3VHOFYqFOtUkHUaCvVcyOQOZcIjq
         vF2IY+axGL3C9MOa7pO2em8ceYC7jhMcJ2l8xAIU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621114930eucas1p16288fc041fac6ffafc8151afaad6cf47~qqjiE7i8T1710517105eucas1p1h;
        Wed, 21 Jun 2023 11:49:30 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AB.66.37758.9C3E2946; Wed, 21
        Jun 2023 12:49:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621114929eucas1p21b07cc0d2a9abfae3db39a067b2f4b48~qqjhiqicq1496914969eucas1p2c;
        Wed, 21 Jun 2023 11:49:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621114929eusmtrp251db038dd20ae318cf8fda0bac2bc107~qqjhhVTaL1909019090eusmtrp2p;
        Wed, 21 Jun 2023 11:49:29 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-40-6492e3c96cac
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 45.CB.14344.9C3E2946; Wed, 21
        Jun 2023 12:49:29 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621114929eusmtip1cdf3a9c0f8460aa240cd59df77c318a0~qqjhM_G7J2609026090eusmtip1q;
        Wed, 21 Jun 2023 11:49:29 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 12:49:28 +0100
Date:   Wed, 21 Jun 2023 13:49:27 +0200
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
        "Florian Westphal" <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "Simon Horman" <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
        "Remi Denis-Courmont" <courmisch@gmail.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        David Howells <dhowells@redhat.com>,
        "Marc Dionne" <marc.dionne@auristor.com>,
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
Message-ID: <20230621114927.woeidgxx5jhtchxt@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="xne6trb3st3pnm7t"
Content-Disposition: inline
In-Reply-To: <f95b7489-8654-435c-bc74-da1eac479fba@kadam.mountain>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTa1CUZRTH53nfdy9AyMtq+gzSqCBOihGOOBwprJymeRssnaYPZU25wRug
        sCgrBTIOyK4K7AAbKLeIiyAs99uC3CGQOwEVsUhcAhaSBQG5BRhLC4vlTN9+53/+/+ec8+Hh
        k4JJnhnfXXSV9RYJPSy4hlRp02rna61jkS62hQkOUB9oDy05v/Ngvfw2CQsjf3JgLvEmDxK6
        pBSsq2RcmAl6RkFexU0CxptGeVAalo1ApjEHSckSAnXEKAd60ue4EBfbgmB4aZSC1XAjiAuV
        EDAb/T0B3aXhHLizdp8Eedsx6H0wSMCvFQlcmKgPo0CeIiFhPHmKAwNR6RTUVSchGM2fJUCS
        NE+CZGGMhDVFMwc6wzZIUHRMENAnH0fQcLuGAx35QTxYTmwhoSl5N8jz2ijol7RyYbl9GkHM
        9G8k/FJ1ENoWNwjoLF7gwELCqzAi76IgSqEkoDJkhQfKrotwo6OUB2MqFfm2PdM/ukQyM52t
        iEnM8WfWVo8wysxHBCN7qCGZ8vhBHlNaZ8UkF/kwRVkhXGagt4rLNGbmEoz8Xh1iitMCmKi+
        DMQ8Lo5D5/afN3zThfVw/4b1fv3UBUO3HyJGOJenTH3VvX+jQKQwCUUGfEzb4WR1ARmKDPkC
        WoGwunF+u1hEOPin2u1iAeHanAfU80ibapGnb2QgLFOGo39df02EkpsuAV2CcF3fFlO0Fa5o
        SCU2mUsfxV3TA1v6Lh1r16OozTBJV5rgkYr2LdNO2gnPBUZzN9mYtsfLVWGEnk1xa5x6aw2S
        9sXSEbVuMl/He3GGlr8pG9CncazmGU+/qSVW1aRy9Xwdtyn7ic1ZmI58CRfIMraymH4Xzwwe
        1nt2Yk2zcjtrjjfKk7b9UbrztXM8fZGNcPqNJULvegNLe9TbiXdw0Po9Uv/oDtz3xFS/5w4c
        WRqzLRvj4FsCvfsQzh6apuTIMv6Fy+JfuCz+v8v08lGcXDnP/Z9sjdNTpkg9O+K8vFkqGfGy
        0B7WR+zpyoqPi9hvbcRCT7GPyNXG2cuzCOl+YLu2eakMKTRPbeoRwUf16KAuPFqQ3Y3MKJGX
        iLXYZfxKUaSLwNhF6HeN9fb60tvHgxXXo718ymKPsbVjq7OAdhVeZS+x7GXW+3mX4BuYBRLp
        A3aezPGInvWS+7kbheTJT142TzsbL5B9N9cuvXsmpTP3feeea7jKL63IYtb9wJjJx7rf5Vl0
        vlsmf3Ku41GtbWZZgZ/1pCXqCq52PDToxr41ZHDK11cgiP6gIWZ5KNjc4XSh1jfBdvCPDlzj
        eiJp4L2nqV6iS3ZhJ5paNGf9dwfMSkWhP8c+9P/UvUwyfMb8wJSH0bhoyEo8+ZV73o8flRVG
        D2vjx5hUZdC+Am1AeeLnwV4eh82ofKy66LJSodqn2XCI8NnvvvLZav9CY0hn4KzVhSvVHz5e
        EVr1OJ0sG1B/nR5l2WuUiwzowbtXCmpkjhnXa0wNv5jOMnGy1DbckoosKLGb8NgR0lss/Acs
        5NzR/AQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeUyTZxzH87zv274FQ6iA+obBpgiJQy2U84eiccQtr+4yJrjDENbJG44B
        xR6E6QhIxy2siEEKDFDGjdwwwOoQB3JDHFJAiKMcTkQOC4zbteuWmey/T75XnjzJj4ObxJLm
        HP9gCSMKFgRasQ2Jru2HY4c7Jq752A8s7oGWSFdoL3tCwlZjLA6a8WcsWMiOJiGr73sCtlSJ
        bJiL2iCgvCkag6k2NQn1SaUIEmcsQFa3jGDyBzULBgoW2KBIb0fwdFlNwFryDlAkyDCYT8vE
        oL8+mQXX1/NxkHfyYfDnMQx+a8piw3RLEgHymzIcpnJfsGA0tYCA5rs5CNQV8xjIcl7hINNM
        4LBe9JAFvUmvcSjqnsZgSD6F4EHsPRZ0V0SRsJLdjkNb7m6Ql3cSMCLrYMNK1yyCG7OPcXik
        tIbOpdcY9NZoWKDJOgDj8j4CUotqMbgTv0pCbV8AXOmuJ2FCpcJPuNIj6mWcnuvtQHR22WV6
        fc2Wri0exujEX2dwujFjjKTrm23o3GopXV0Sz6ZHB5VsurX4NkbLbzUjuuanCDp1qBDRf9Qo
        0Jm9X/LcRUKphNnrJxRLjlmd54MDj+8GPAcnNx7f0dXriIOzld1xdx8m0D+UEdkd/4rn90tM
        DxbyfGfY7y1JeCQqME5ABhyK60R1qpbIBGTIMeHmI6qzW4b0hgVVtfSYpWdTanMwga0PLSJq
        NGPkn0YdogrSo3FdiuDaUE0P8jAds7mHqL7Z0b91My1vb6USugLObTSmklVKUmeYcj+kFiLT
        2Do24rpSK8okTL9ag1HyhmFcb+ykOhSThI5xbigV05qgDXG0/BZVuM3RyQZcDyp9ZoPUP3U/
        pbqXx9ZzOKXZmkZyZJrxxlLGG0sZ/y3pZVtqaPv5/+WDVMHNF7iej1Hl5fNELiJLkBkjFQf5
        BokdeGJBkFga7Mu7IAyqRtorqG9bq21AxTOLvBaEcVALstY21ZWl/cicCBYGM1ZmRpbV13xM
        jHwE315iREJvkTSQEbcgZ+03puDmuy4ItScVLPHmu9g7851c3Oyd3VwcrfYYnQqJE5hwfQUS
        5huGCWFE//YwjoF5JOZ4IqtBlBtQlWOxevSifUBxeGQmqRk3Fh8cCYtwC3l3sGGfoccHMtmO
        7bqqqI8GztvNpwzOhQSevRJaXHZbOTEcEnY6KDt8Yp/fxmh+yuez52BnlsajYsy1V+jtHLTm
        6XSYUYHI3ZqrqbJcz2xNS4+Wzlf6/PljWYebJG548+O0qgNX31vtL75q3XPLZLIwM7Pg2aEb
        Z0rvhz+pu/Rdre8uUzvi4oTynTsuJ5eexp2dwiIwyVbg5a89ToaNBW7e/8IrL/+TlPiwilQb
        m/LKT71SDLs+c4jScO1fWQ7kLi0PY28rXnrGJJs9uvvy+vs9R45mnd6POQ3szud5TikV1f4l
        5wYlU1aE2E/At8VFYsFfjwJp7poEAAA=
X-CMS-MailID: 20230621114929eucas1p21b07cc0d2a9abfae3db39a067b2f4b48
X-Msg-Generator: CA
X-RootMTR: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa@eucas1p1.samsung.com>
        <20230621091000.424843-7-j.granados@samsung.com>
        <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
        <f95b7489-8654-435c-bc74-da1eac479fba@kadam.mountain>
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

--xne6trb3st3pnm7t
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 01:49:54PM +0300, Dan Carpenter wrote:
> On Wed, Jun 21, 2023 at 12:47:30PM +0300, Dan Carpenter wrote:
> > The patchset doesn't include the actual interesting changes, just a
> > bunch of mechanical prep work.
> >=20
>=20
> I was wrong here, the patchset just hadn't all hit the mailing lists.
not even. It was that the patch got mangled by some error on my side.

> I can't apply this patchset to anything.  I tried linux-next, net, and
> net-next.  So it's hard to review.
All this applies cleanly to mcgrof's sysctl-next branch here
https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=3Ds=
ysctl-next

>=20
> It looks like ensure_safe_net_sysctl() never got update to use
> table_size...
Done. I realized this while checking out your other comments. thx.

>=20
> You could easily write a static checker test to print a warning any time
> that ->procname is checked for NULL.  I have attached a Smatch check.
> You would need to added to check_list.h and recompile.
Awesome!!!, I had been doing this with coccinelle, I'll recompile with
smatch and see if I get extra hits. Thx!
>=20
> net/sysctl_net.c:130 ensure_safe_net_sysctl() warn: checking ->procname '=
ent->procname'
Done. Will be available in V2

>=20
> regards,
> dan carpenter
>=20

Best
--=20

Joel Granados

--xne6trb3st3pnm7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS48UACgkQupfNUreW
QU8P6wv+JBI5ELQO0rQlbgdRdUTqyimzPcdhSxOT8QeXa/qKyYDEV+KhvzEMZap0
0yiZFvImIwiv6dp/2opPovNRg1qLPT6jIoadBpMtglkCwRcyEH9HCX77M+R75wnz
eGelorE8pyLVRRRfz0vIOe+cSOT3K3W6t+JeaaVpDKIUQk/5RNsirkOjC/499F+3
QphT45CRPGAdiVjtKnEmkiCYwBVu4w2WiZn6MgN8Poq8eS+g88bfq1X33HbbOrAE
+xgFe/74kvzkeOAQ25zYT1oQVslt4dkE7ypD3JY5TC7PaFIa4/bVSQ233awpvNgP
0gdYX5kqUjjS5kDE5Br2kToneRo8n4D8xO3Q/0uXjvqjonOmarRtfBXuxkIvfpTL
y4aAcmIcU4xLvQdYoETV+2vNqUfxaHzIlRukxzVIZNcRYU4FN2jUKjQv5fNf2frE
CGQ8KJwhsUjQVIkm5jyVdhxrw8AmWbzthNWUKJW82kxDAQ6AOJbZWb+C4HPQ+39P
70ZNs++G
=sqdF
-----END PGP SIGNATURE-----

--xne6trb3st3pnm7t--
