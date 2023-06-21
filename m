Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD7F738303
	for <lists+linux-sctp@lfdr.de>; Wed, 21 Jun 2023 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjFUMD6 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 21 Jun 2023 08:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjFUMDf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 21 Jun 2023 08:03:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5176B1737;
        Wed, 21 Jun 2023 05:03:30 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621120328euoutp02c5707f1f8db51fe5712290c971959904~qqvutf1pT0885508855euoutp02y;
        Wed, 21 Jun 2023 12:03:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621120328euoutp02c5707f1f8db51fe5712290c971959904~qqvutf1pT0885508855euoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687349008;
        bh=UhbTj7rbSuIz0wQAIgRbt5npWj7iwCf9ys8+fT26dmg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=GKxv5RAvXgxBewzVmQQ972Cjcp5klA3uKmvo3IQPk3I6RYA1PA6V4xOCUWVaFLxNl
         JDUWVOuWvxr33giiXju03VnTLQDdGSgCl3k4Izp8oglyncIxJ9ZI6d8HydRQb71iZ8
         7mXk6Jouf9L3c4d+NVR0ASAr4r9Y8BUUs95K6b78=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621120328eucas1p1fda92019a773b938e579c6b1330f6749~qqvuerCuc1536715367eucas1p15;
        Wed, 21 Jun 2023 12:03:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B4.C9.37758.F07E2946; Wed, 21
        Jun 2023 13:03:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621120327eucas1p1c148cfc468823fbd592e0f24992d7b74~qqvt8HnZl1538815388eucas1p1p;
        Wed, 21 Jun 2023 12:03:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230621120327eusmtrp14df30445bdb3be5d54096bf3a264c34f~qqvt67ZKp0101701017eusmtrp1F;
        Wed, 21 Jun 2023 12:03:27 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-b9-6492e70f7e30
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C7.5B.10549.F07E2946; Wed, 21
        Jun 2023 13:03:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621120327eusmtip1c54e59bf6315793873fd19bfdbc5cd8c~qqvtlH5Nz2473324733eusmtip1A;
        Wed, 21 Jun 2023 12:03:27 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 13:03:26 +0100
Date:   Wed, 21 Jun 2023 14:03:24 +0200
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
Message-ID: <20230621120324.cl2admxrku7ilecm@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="je5dyz423x2mm343"
Content-Disposition: inline
In-Reply-To: <5aba7eee-7a6e-4f3b-9921-e4220d479346@kadam.mountain>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTaVBTZxSG+917kxuwkUu05RuX1qJoq6h1rPV0rFtHO7dl2tH+YNpilwi3
        LtWgiViXsYKJpZKCkbQgIWAEgSARZEtVEDGUEJZJqKJgxC2CKAJSQ6zYBku42DrTf895z3m/
        c94fn4iUdNMTRBtk2zi5TLopWOhPma2D9tkBXclRb+arACyxC8FmukqD93Q8Ce5bXQLoz9xP
        g96hosDbqhZC376/KCg8s5+ATquLBnNiAQJ19yRQlnsQdBx0CaAlt18IaYdtCG54XBQMJo2B
        tAQlAQ9S0gloNicJ4OcnOSRoGubB5V+vEXDxjF4IdyyJFGiOKknoNNwXQLs2l4Lqs0cQuIoe
        EKA88pAEpfs2CU+MdQKwJz4lwdh0h4A2TSeCmvgqATQV7aPhUaaNBKvhZdAUNlDgVNYL4VFj
        D4LUnkskXKicBg0DTwmwl7oF4Na/Drc0Dgq0xjICKg48pqHMsRHimsw03G5tJZctZJ0uD8n2
        2esRm2nazT4ZnMmW5V8hWPVv3SR7WneNZs3VIayhJIYtOX5AyLZfrhSytfknCFaTVY3Y0mN7
        WW1bHmLvlqahVVM+9383itu0YTsnn7vka//1Kqub3nJk9Y7s2Ho6FsUtT0B+Isy8hc+rYwUJ
        yF8kYYwI/16nJvhiAGF7ZS3JF26Ej9sOoWeWoqsFlI8lTB7CKaqX/h1SF3eNOsoRbjdeEvqm
        KCYE601e2sdCJhQ7etpJH48f5iGvlvIZSKY4AN8/c2VkxTgmDPfHpoyYxcxCnG1sFPAciOvT
        OkZWk8wO3Nh8YfhR0TBPxHlDIp/sx7yHE4ayCP7Sqbi1KlvI8x7cUOYcyYYZ3Yu4XTNE8o0V
        2K7sFPA8DnfXldE8T8KN2p8o3qBF+NxQP80XBQjnxnlGVyzCqpaOUcdyvM+bRfouwsxY3NYb
        yB86FiebU0dlMf7xBwk/PR0XXO+hNGiq7rlouuei6f6Lxsuh2FDxUPg/eRbOPXqf5HkxLix8
        QBkQfRwFcTGKzes4xXwZ990chXSzIka2bk5k9OYSNPwFG4fqPKeQsfuPORZEiJAFTRs2u04W
        NKMJlCxaxgWPF08uSY6SiKOkO3dx8uiv5DGbOIUFTRRRwUHiWYvrIyXMOuk27luO28LJn3UJ
        kd+EWCLx2Pf3OgTfOHsLBg/XPXbsX/H++RBJQMj4Mdu5+erUyvCNq0gP+vK1vKXpb9huNC/I
        vElFBIW/Y33bzzT3lx4mSFpVQ1BFM0pnqD/1ZohyFzSHHhLB3SUZe3qXJZ0YU6vbNXtStr0p
        4UPB0shTN4tDZVktyRfvXepqNk936Hp2hjNma4S+RdgX1rvyujh76w5sy4lImRxhyKqm1u6O
        11cqukrDzmUEWNJj2hb5l7yyrOKDor6cm+VfrHKbIj6KVn/y5/y/nWFxU/KDxY3Fe1VnSzYc
        vHtwwaPa8hdUa67nmOrDHLUfO+NXnFzz2daBwJWei8k1Jqv3ctrSzNy1leGvam2rAyXBlGK9
        dN5MUq6Q/gOuFxqq/QQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA2WTeUxUVxTGc997s0ClTgHbF4qpGbW1iCPDesANG6vPNI3FNqmlWhzlCbQw
        4AwQlFqRgbDrAFOEYRUKDjAFWZVFi4DsBWMrIAMah60sZSk7MtCBaVOT/ve73/nOd05ucti4
        YRjLhO0h9KVFQoEnl6lPtK429u3ZPBznahGTbgS1QXbQpFSxQFMRhsPMy2EGTKWFsiClI4QA
        TVcUEyaCXxFQUBmKwWCDmgXlMfkIokZNQVI2h2DghpoBv+dMMSEpsQnBizk1AUvX34CkSAkG
        kwnJGDwuv84A2XI2DtIWPnTe7cPgt8oUJgzVxhAgvSXBYTBjjAG98TkE1NxPR6AunMRAkv4X
        DpKZfhyWFY0MaI9Zw0HRNoRBt3QQQV3YAwa0FQazYD6tCYeGjLdBWtBCQI+kmQnzreMIbo4/
        xeFJ9Q5omV3DoL1khgEzKbvgpbSDgHhFKQZVEYssKO34Fq61lbOgv6sLd7SjetRzODXR3oyo
        NGUgtbxkRpXmPsOoqPpRnKqQ97Go8pqdVEaxH1WcF8GkejurmdSj3J8xSppZg6iSn65S8d23
        EfVHSRL6bJszb7/I28+X3ubuLfY9wP2aD5Y8vj3wLK3teXwruzMOljbcvQf3u9KeHv60aO/B
        szz3lepUlk+qU8DzRSUjCK05RiI9NsmxJgtV+UQk0mcbcrIR2Vq0ROgKpmTR7FOGjo3Ilc5I
        ps40jcjE+rv/PMoQmdyYjq+7CM5OMkWpYa0zk2NOdoz3bujGWl7VxG+MwDlFm8nxaOXGCCPO
        J+RUUAJznQ04dmSWopWhSy3ByMX2PzFd4S2yOWlgowHn+JMrqVKtia3ld8nbq+x1WY/zERm5
        monpVt1Odj3IYur4CjmjGUJSZCR/LUn+WpL8vySdbEZ2r45g/5N3kzm3xnAdHyALCiaJDMTK
        Q8a0n9jLzUvM54kFXmI/oRvvvLdXMdJeQXnDUsk9lDY6zatFGBvVoh3aTvWd/MfIhBB6C2mu
        scHW4jhXQwNXwaXLtMjbReTnSYtrkY32G2Nxky3nvbUnJfR14dta2PCtbe0tbOxtrbjvGBz3
        CRcYctwEvvR3NO1Di/7tw9h6JkGYUraWWcbJjksWygOvvbiYbXa00HxZ7xzuiG0VfPl8/ljZ
        p0myYYPhNx1ORs9dPb1wwZl2jp1wSntSdXSfbKwo49QHoydufv+DwoXKyx25f655pX5gu9Px
        qdGkaNmNTd8kmF+qyBP0q6ot3VxPvwe4/i7VRQ+72KIFh4Ue4S+D4QGWuUt1XAV3LtFlpdP4
        w/DA5ODiKy3dASGiQ1Uhn0ccqfQ/+/6zrPm+6cVDNWcO3/tY9jBo/thD10R986k9s6FfjJLW
        r0Ymuo3Zl+f8fy3TUFamyqKUlFM/suvrdnes7ev8KmfyxCOZ15GIDlOJmTJDvoW609TeoqIa
        GIc3yS+UqU8KVJNcQuwu4JvhIrHgb+hkHU2aBAAA
X-CMS-MailID: 20230621120327eucas1p1c148cfc468823fbd592e0f24992d7b74
X-Msg-Generator: CA
X-RootMTR: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa@eucas1p1.samsung.com>
        <20230621091000.424843-7-j.granados@samsung.com>
        <dab06c20-f8b0-4e34-b885-f3537e442d54@kadam.mountain>
        <5aba7eee-7a6e-4f3b-9921-e4220d479346@kadam.mountain>
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

--je5dyz423x2mm343
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Dan

On Wed, Jun 21, 2023 at 01:23:52PM +0300, Dan Carpenter wrote:
> On Wed, Jun 21, 2023 at 12:47:30PM +0300, Dan Carpenter wrote:
> > The patchset doesn't include the actual interesting changes, just a
> > bunch of mechanical prep work.
> >=20
> > On Wed, Jun 21, 2023 at 11:09:55AM +0200, Joel Granados wrote:
> > > diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lo=
wpan/reassembly.c
> > > index a91283d1e5bf..7b717434368c 100644
> > > --- a/net/ieee802154/6lowpan/reassembly.c
> > > +++ b/net/ieee802154/6lowpan/reassembly.c
> > > @@ -379,7 +379,8 @@ static int __net_init lowpan_frags_ns_sysctl_regi=
ster(struct net *net)
> > >  	table[1].extra2	=3D &ieee802154_lowpan->fqdir->high_thresh;
> > >  	table[2].data	=3D &ieee802154_lowpan->fqdir->timeout;
> > > =20
> > > -	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table);
> > > +	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table,
> > > +				  ARRAY_SIZE(lowpan_frags_ns_ctl_table));
> >=20
> > For example, in lowpan_frags_ns_sysctl_register() the sentinel is
> > sometimes element zero if the user doesn't have enough permissions.  I
> > would want to ensure that was handled correctly, but that's going to be
> > done later in a completely different patchset.  I'm definitely not going
> > to remember to check.
>=20
> On reflecting the patch is obviously wrong.  It should be pass zero as
> table_size in that case.  See diff at the end.
yes

>=20
> There is a similar bug in neigh_sysctl_register() where we use memset to
> zero out the whole table.  And another in __ip_vs_lblc_init().  I used
> the smatch cross function database
> 	`smdb.py where ctl_table procname | grep '(null)' | grep min-max`
> to make a list of functions which set procname to zero.
Awesome. That is homework on my part for V2. It gives me a way forward.
Thx!!!

>=20
> Probably we should add a WARN_ON() if procname is zero in the new code
> which doesn't use sentinels.
Yes

>=20
> regards,
> dan carpenter
>=20
> drivers/char/random.c          | proc_do_uuid                   | (struct=
 ctl_table)->procname | 0
> fs/proc/proc_sysctl.c          | new_dir                        | (struct=
 ctl_table)->procname | 48,3906148897379000352
> fs/proc/proc_sysctl.c          | new_links                      | (struct=
 ctl_table)->procname | 4096-ptr_max
> arch/arm64/kernel/fpsimd.c     | vec_proc_do_default_vl         | (struct=
 ctl_table)->procname | 0
> arch/arm64/kernel/armv8_deprecated.c | register_insn_emulation        | (=
struct ctl_table)->procname | 0-u64max
> kernel/sysctl-test.c           | sysctl_test_api_dointvec_null_tbl_data |=
 (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_api_dointvec_table_maxlen_un=
set | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_api_dointvec_table_len_is_ze=
ro | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_api_dointvec_table_read_but_=
position_set | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_dointvec_read_happy_single_p=
ositive | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_dointvec_read_happy_single_n=
egative | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_dointvec_write_happy_single_=
positive | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_dointvec_write_happy_single_=
negative | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_api_dointvec_write_single_le=
ss_int_min | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl-test.c           | sysctl_test_api_dointvec_write_single_gr=
eater_int_max | (struct ctl_table)->procname | 7612622206476333056
> kernel/sysctl.c                | proc_do_static_key             | (struct=
 ctl_table)->procname | 0
> kernel/kexec_core.c            | kexec_limit_handler            | (struct=
 ctl_table)->procname | 0
> kernel/bpf/syscall.c           | bpf_stats_handler              | (struct=
 ctl_table)->procname | 0
> net/core/sysctl_net_core.c     | rps_sock_flow_sysctl           | (struct=
 ctl_table)->procname | 0
> net/core/sysctl_net_core.c     | set_default_qdisc              | (struct=
 ctl_table)->procname | 0
> net/core/neighbour.c           | neigh_sysctl_register          | (struct=
 ctl_table)->procname | 0
> net/netfilter/ipvs/ip_vs_lblc.c | __ip_vs_lblc_init              | (struc=
t ctl_table)->procname | 0-u64max
> net/netfilter/ipvs/ip_vs_lblcr.c | __ip_vs_lblcr_init             | (stru=
ct ctl_table)->procname | 0-u64max
> net/netfilter/ipvs/ip_vs_ctl.c | proc_do_defense_mode           | (struct=
 ctl_table)->procname | 0
> net/netfilter/ipvs/ip_vs_ctl.c | proc_do_sync_threshold         | (struct=
 ctl_table)->procname | 0
> net/netfilter/ipvs/ip_vs_ctl.c | proc_do_sync_ports             | (struct=
 ctl_table)->procname | 0
> net/netfilter/ipvs/ip_vs_ctl.c | ipvs_proc_est_nice             | (struct=
 ctl_table)->procname | 0
> net/netfilter/ipvs/ip_vs_ctl.c | ipvs_proc_run_estimation       | (struct=
 ctl_table)->procname | 0
> net/netfilter/ipvs/ip_vs_ctl.c | ip_vs_control_net_init_sysctl  | (struct=
 ctl_table)->procname | 0-u64max
> net/netfilter/nf_log.c         | netfilter_log_sysctl_init      | (struct=
 ctl_table)->procname | 0-u64max
> net/sctp/sysctl.c              | proc_sctp_do_hmac_alg          | (struct=
 ctl_table)->procname | 0
> net/sctp/sysctl.c              | proc_sctp_do_rto_min           | (struct=
 ctl_table)->procname | 0
> net/sctp/sysctl.c              | proc_sctp_do_rto_max           | (struct=
 ctl_table)->procname | 0
> net/sctp/sysctl.c              | proc_sctp_do_auth              | (struct=
 ctl_table)->procname | 0
> net/sctp/sysctl.c              | proc_sctp_do_udp_port          | (struct=
 ctl_table)->procname | 0
> net/sctp/sysctl.c              | proc_sctp_do_probe_interval    | (struct=
 ctl_table)->procname | 0
> net/ipv6/route.c               | ipv6_route_sysctl_init         | (struct=
 ctl_table)->procname | 0-u64max
> net/ipv6/addrconf.c            | addrconf_sysctl_addr_gen_mode  | (struct=
 ctl_table)->procname | 0
> net/ieee802154/6lowpan/reassembly.c | lowpan_frags_ns_sysctl_register | (=
struct ctl_table)->procname | 0-u64max
> net/xfrm/xfrm_sysctl.c         | xfrm_sysctl_init               | (struct=
 ctl_table)->procname | 0-u64max
> net/phonet/sysctl.c            | proc_local_port_range          | (struct=
 ctl_table)->procname | 0
> net/ipv4/route.c               | sysctl_route_net_init          | (struct=
 ctl_table)->procname | 0-u64max
> net/ipv4/sysctl_net_ipv4.c     | ipv4_local_port_range          | (struct=
 ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | ipv4_privileged_ports          | (struct=
 ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | ipv4_ping_group_range          | (struct=
 ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | proc_tcp_congestion_control    | (struct=
 ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | proc_tcp_available_congestion_control | =
(struct ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | proc_allowed_congestion_control | (struc=
t ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | proc_tcp_fastopen_key          | (struct=
 ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | proc_tcp_available_ulp         | (struct=
 ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | proc_tcp_ehash_entries         | (struct=
 ctl_table)->procname | 0
> net/ipv4/sysctl_net_ipv4.c     | proc_udp_hash_entries          | (struct=
 ctl_table)->procname | 0
>=20
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan=
/reassembly.c
> index a91283d1e5bf..749238d38014 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -360,6 +360,7 @@ static int __net_init lowpan_frags_ns_sysctl_register=
(struct net *net)
>  	struct ctl_table_header *hdr;
>  	struct netns_ieee802154_lowpan *ieee802154_lowpan =3D
>  		net_ieee802154_lowpan(net);
> +	size_t table_size =3D ARRAY_SIZE(lowpan_frags_ns_ctl_table);
> =20
>  	table =3D lowpan_frags_ns_ctl_table;
>  	if (!net_eq(net, &init_net)) {
> @@ -369,8 +370,10 @@ static int __net_init lowpan_frags_ns_sysctl_registe=
r(struct net *net)
>  			goto err_alloc;
> =20
>  		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns !=3D &init_user_ns)
> +		if (net->user_ns !=3D &init_user_ns) {
>  			table[0].procname =3D NULL;
> +			table_size =3D 0;
> +		}
>  	}
> =20
>  	table[0].data	=3D &ieee802154_lowpan->fqdir->high_thresh;
> @@ -379,7 +382,7 @@ static int __net_init lowpan_frags_ns_sysctl_register=
(struct net *net)
>  	table[1].extra2	=3D &ieee802154_lowpan->fqdir->high_thresh;
>  	table[2].data	=3D &ieee802154_lowpan->fqdir->timeout;
> =20
> -	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table);
> +	hdr =3D register_net_sysctl(net, "net/ieee802154/6lowpan", table, table=
_size);
>  	if (hdr =3D=3D NULL)
>  		goto err_reg;
> =20

--=20

Joel Granados

--je5dyz423x2mm343
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSS5wsACgkQupfNUreW
QU9ERQwAgEMy70wE4h18ynQTGRx76Q41zwefjWXFjEGR0K3NIsFmJQ0zHEbUM4QJ
IAZlo1uMboPLnI3bAsabEclKxOWcFy09FHUrVxLBEA2W6++zEHwohyoCKbOTxX47
T8PRYwwPkowWc4cF1iRrHsJlBU9xPYDzNpwFIM/hx/OFxPgcs4jpLZPN9i49q0Lx
ikkO54H2IHbPeRQb65JbXwFqG4KwDDJw3Y4pdmItfiqSuRqTmAS+9yLSOqnMn6Nc
f3C8/IzSg+3FYe4VBKnDur0si+IDxn+BOCHTJoPr+J/Lb9wk8/ZtS3dtxy+wf/41
CdEhbC17uw6GqbdzvAh6uENWMUfACrEPQnjZmu1IulsnpaP2U6fOJNRvVuibR9vh
KwdpxWSezi8xZ29gYfJbYjl5ckpT1H9zZhaSO23hgYzq7KVLr45hR/A+IQGamBYc
K/GWPGudYiQgXWTyk+CUA6rCvIVQDY0g92E5iONzE9JweFTG9pCFztodAJL16fPI
wgfgt0fB
=XFZg
-----END PGP SIGNATURE-----

--je5dyz423x2mm343--
