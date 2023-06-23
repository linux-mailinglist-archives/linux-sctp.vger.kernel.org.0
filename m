Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4473B9EE
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Jun 2023 16:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjFWOVo (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 23 Jun 2023 10:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjFWOVl (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 23 Jun 2023 10:21:41 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C0410D;
        Fri, 23 Jun 2023 07:21:39 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230623142135euoutp02ae6a33511d52b0b0b504882654455cb1~rT65bzABM1867918679euoutp02f;
        Fri, 23 Jun 2023 14:21:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230623142135euoutp02ae6a33511d52b0b0b504882654455cb1~rT65bzABM1867918679euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687530095;
        bh=EgzcpvZ110/Utd/BaTe+KyRVTbIhIRUuMj7pUOodDxE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ETe9c3rm/p2XZgv3Ceh0yrmfAmcg2qlIz1sjDvOaYg8GlmoJPOMkGEfoeYhJjRehJ
         HdcZbFb+T34Edu1rZVZ90DO5tLfjKLCB3+iwOBoLqpKKRFK1x9egjtJPLLeDDVrt4J
         e0E+5F5x1q8IymLwOMsyBu8kCfmKCdwYu+Uu3BDc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230623142135eucas1p1e36f7df193b7fc51a7ad909b2f480d22~rT65PlnIT0130301303eucas1p1B;
        Fri, 23 Jun 2023 14:21:35 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7F.E0.37758.F6AA5946; Fri, 23
        Jun 2023 15:21:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230623142134eucas1p1e0ca2a2f429fe04b29b601b2be447465~rT64t7Ug92670826708eucas1p19;
        Fri, 23 Jun 2023 14:21:34 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230623142134eusmtrp2f2d6c9ddd29b1ba5960ea982a92d478f~rT64riU0r2632226322eusmtrp2F;
        Fri, 23 Jun 2023 14:21:34 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-d8-6495aa6f2f92
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0A.47.10549.E6AA5946; Fri, 23
        Jun 2023 15:21:34 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230623142134eusmtip21ff9a185de52342f854270c8ce4a01d1~rT64Nf6Ch2977929779eusmtip2C;
        Fri, 23 Jun 2023 14:21:34 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (106.1.227.72) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jun
        2023 15:21:31 +0100
Date:   Fri, 23 Jun 2023 16:21:26 +0200
From:   Joel Granados <j.granados@samsung.com>
To:     Dan Carpenter <dan.carpenter@linaro.org>
CC:     <mcgrof@kernel.org>, <linux-rdma@vger.kernel.org>,
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
Message-ID: <20230623142126.rgdabyokvuwshhmj@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="swgbxx6ykpv57frf"
Content-Disposition: inline
In-Reply-To: <5aba7eee-7a6e-4f3b-9921-e4220d479346@kadam.mountain>
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (106.1.227.71) To
        CAMSVWEXC02.scsc.local (106.1.227.72)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBJsWRmVeSWpSXmKPExsWy7djPc7r5q6amGEw4yWtxYs1tdou/O9uZ
        LT7MawWyrnezWUw4ZWhxbftdJovLu+awWTw71MtiMWFhM7PF0wWvWS3uTF7GYnFg73xGi+b5
        n5gtbkx4ymhxZn0Tu8WxBWIWE9adYrE4t/kzq8WW81kOwh6bVnWyedy5tofNY/OSeo/JN5Yz
        erzYPJPRY/eCz0web3+fYPK4sOwNm8fnTXIBnFFcNimpOZllqUX6dglcGfs3bWMvOOhdcfPc
        QfYGxh/WXYycHBICJhJde9cygdhCAisYJVbtk4CwvzBKTJkS0cXIBWR/ZpR4PfUMC0zDgdsH
        2CASyxklXny8zAJXdWBZHxvcqIWbPEBsFgFViXfPloN1swnoSJx/c4cZxBYBsv/9nQzWzCyw
        ikXiyOxPYM3CAt4SHxqmAdkcHLwC5hL/5jqBhHkFBCVOznwCNodZoELiTMNEFpASZgFpieX/
        OEDCnAJOEl3/FjFBHKoscX3fYjYIO1mi5c9fJpBVEgJdXBJPZ7awQiRcJJZv/gXVICzx6vgW
        dghbRuL/zvlQDZMZJfb/+8AO4axmlFjW+BWqw1qi5coTqA5Hiaa/i5hBLpIQ4JO48VYQ4lA+
        iUnbpkOFeSU62oQgqtUkVt97wzKBUXkWktdmIXltFsJrEGEdiQW7P7FhCGtLLFv4mhnCtpVY
        t+49ywJG9lWM4qmlxbnpqcXGeanlesWJucWleel6yfm5mxiBCfb0v+NfdzCuePVR7xAjEwfj
        IUYVoOZHG1ZfYJRiycvPS1US4ZXdNClFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0
        xJLU7NTUgtQimCwTB6dUAxNvZ1zZL834baXvJ7YIXGWLfaj02IYt0nPNzPo5k1WfKJqLacfs
        tLu/P2Y7k8er3cJCj6c1bgx/dL3cYGfOzAVnZ83tsGKXN1deIHo059bC/fl3jk53O7hla9ZD
        J8WO0ycbDko/2D6d+fCjdr2PNxm4ysvcJ0eV87YGWPlOjD3ys0t1xxKJ2AOL6lZOWatzIjX5
        /M0rdwQ5DZZut65ner79zvNL39Vnh0y/ytacXjKhq7x+ZeSaJe/axUSSFDdu/WLR07Dn9WV+
        t7cSbgnSC1PfhR5YW5h9V5JR2W/RgvhJ0sUnXaPOHQpRuyl/Z/2JU5LtluufH/YpdHvjdl85
        KtbJZU3Yr+89Wwvc3sibCTIpsRRnJBpqMRcVJwIAEoZaySsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsVy+t/xe7p5q6amGLR+1bE4seY2u8Xfne3M
        Fh/mtQJZ17vZLCacMrS4tv0uk8XlXXPYLJ4d6mWxmLCwmdni6YLXrBZ3Ji9jsTiwdz6jRfP8
        T8wWNyY8ZbQ4s76J3eLYAjGLCetOsVic2/yZ1WLL+SwHYY9NqzrZPO5c28PmsXlJvcfkG8sZ
        PV5snsnosXvBZyaPt79PMHlcWPaGzePzJrkAzig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMT
        Sz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jOl7XzIX7Peu2LP7CEsD4zfrLkZODgkBE4kDtw+w
        dTFycQgJLGWU+P9kHSNEQkZi45errBC2sMSfa11QRR8ZJc6efM8CkhASWMEocfx6HIjNIqAq
        8e7ZcrA4m4COxPk3d5hBbBEg+9/fySwgzcwCq1gkjsz+xAaSEBbwlvjQMA3I5uDgFTCX+DfX
        CWLBZiaJH+feMoHU8AoISpyc+QRsKLNAmcTDuTvA6pkFpCWW/+MACXMKOEl0/VvEBHGossT1
        fYvZIOxkiUl7fjFOYBSehWTSLCSTZiFMgghrSdz495IJQ1hbYtnC18wQtq3EunXvWRYwsq9i
        FEktLc5Nzy021CtOzC0uzUvXS87P3cQITDTbjv3cvINx3quPeocYmTgYDzGqAHU+2rD6AqMU
        S15+XqqSCK/spkkpQrwpiZVVqUX58UWlOanFhxhNgaE4kVlKNDkfmALzSuINzQxMDU3MLA1M
        Lc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYduzof2xx+YlWxo5LP3YKxuwTy4g4smZ5
        Zv4yqZsZc1kcvS4FrJqq/4XLxZahx3c+o+ejz+EZt7L/L/9kcykva/eLI5Nv1ruy5157v0C9
        Mnbu+YwY0eScosXLkrOvRE+bLiN7ZMcdw59cj6QjTFZL26hbtz3csoth2t6yr2/+T8zJD441
        SpS4oW9yXuUF06QH/u9EmE+777gkHMe8pstJRqowMLnQYKOOe4WIucnv3+7r/W9vX/zhMHM8
        r9l3E9kDsmYvVXZFJ/eoafdmXfRO02/Y1GKy9XXf7MrLvocY0mYf2Ml14ZzP6fuMDIb8l49m
        WHsZzBC1X6u/bYJmtFLA7CVr+5Xnb+yxydAS1G9XYinOSDTUYi4qTgQAtD7I48kDAAA=
X-CMS-MailID: 20230623142134eucas1p1e0ca2a2f429fe04b29b601b2be447465
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

--swgbxx6ykpv57frf
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Just answering to dan and the lists to avoid noise

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
>=20
> There is a similar bug in neigh_sysctl_register() where we use memset to
> zero out the whole table.  And another in __ip_vs_lblc_init().  I used
> the smatch cross function database
> 	`smdb.py where ctl_table procname | grep '(null)' | grep min-max`
> to make a list of functions which set procname to zero.
>=20
> Probably we should add a WARN_ON() if procname is zero in the new code
> which doesn't use sentinels.
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
> net/netfilter/nf_log.c         | netfilter_log_sysctl_init      | (struct=
 ctl_table)->procname | 0-u64max
^^^ : These are all false positives as non-sentinel procname gets
set to a string on the register sysctl path.

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
> net/ipv6/addrconf.c            | addrconf_sysctl_addr_gen_mode  | (struct=
 ctl_table)->procname | 0
> net/phonet/sysctl.c            | proc_local_port_range          | (struct=
 ctl_table)->procname | 0
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
^^^ : procname gets set to NULL but is not used to register. just as a
temp ctl_table. Can be ignored.

> net/core/neighbour.c           | neigh_sysctl_register          | (struct=
 ctl_table)->procname | 0
^^^ : This is one is tricky. I had handled the case where the sentinel
is cleared by setting procname to NULL.

> net/netfilter/ipvs/ip_vs_lblc.c | __ip_vs_lblc_init              | (struc=
t ctl_table)->procname | 0-u64max
> net/netfilter/ipvs/ip_vs_lblcr.c | __ip_vs_lblcr_init             | (stru=
ct ctl_table)->procname | 0-u64max
^^^ : These two where caught by your check. THX!!!!!!

> net/netfilter/ipvs/ip_vs_ctl.c | ip_vs_control_net_init_sysctl  | (struct=
 ctl_table)->procname | 0-u64max
^^^ : This one is another one that was caught.
For this file I noticed that we setup the entire ctl_table for both privile=
ged
and unprivileged users. It seems that we could just skip all the setup
needed for the unprivileged user. Please tell me and I can maybe come
with a patch for that.

> net/ipv6/route.c               | ipv6_route_sysctl_init         | (struct=
 ctl_table)->procname | 0-u64max
> net/ieee802154/6lowpan/reassembly.c | lowpan_frags_ns_sysctl_register | (=
struct ctl_table)->procname | 0-u64max
> net/xfrm/xfrm_sysctl.c         | xfrm_sysctl_init               | (struct=
 ctl_table)->procname | 0-u64max
> net/ipv4/route.c               | sysctl_route_net_init          | (struct=
 ctl_table)->procname | 0-u64max
^^^ : caught by your check!

In total you caught 8 valid errors.

Thx again.

Best

--=20

Joel Granados

--swgbxx6ykpv57frf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmSVqmMACgkQupfNUreW
QU9g2wv/TmhtYGAUfhchEJ5DYrqk7RdbDAd+0qI8p6L0euVZ8FFDfVZODTOUVA9/
mvmcT0HvLEy23U3mrCbC2e49Yn7EiKs87UMXHsQRXMwMSfRN8+i5Mnaz7Fd1AZmh
e1EuAk+Y0K2AW8KaO/Av4yVqWc289VgEyPJABABeEh44pitZ9THyHjuuR8+/4yKN
NvPpl5x3pbrQ1OMGD9yUiDtJZ1rYZ0Qpus7pXZcbFMOoZa1VNRzhorx1PuqlN5fA
eusGeiqE32G6z4B1bEOMzJ0Vw4a5fyzOToVPCACfak78WfrnF4LNeClh02gEZVJh
3Vc0OVySb4DD3v51KWvUFowmbL1OB7pnsIk147h9PqwRpmlCWGmx44QUejXBAkF/
O6wMW1SxWEGFVCFc2OX/cTf2JLLEdqACpDw7vzi8OUMZ4TSv4MMXpmEztGByCjZy
6e8Bh3SNVZVC7lUkxZFp1oWl2J2dfXh/J0LwJMz2m0Ev1sEFAgKVosISHUzq3+Aw
YPXJThO2
=HDho
-----END PGP SIGNATURE-----

--swgbxx6ykpv57frf--
