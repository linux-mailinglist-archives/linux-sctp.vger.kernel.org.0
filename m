Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ADF737EC6
	for <lists+linux-sctp@lfdr.de>; Wed, 21 Jun 2023 11:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjFUJLv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 21 Jun 2023 05:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjFUJK7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 21 Jun 2023 05:10:59 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1011BF5;
        Wed, 21 Jun 2023 02:10:25 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091023euoutp01ec65ee83be0b4972b071be6b6ce46ddd~qoYnSztar1413414134euoutp01V;
        Wed, 21 Jun 2023 09:10:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621091023euoutp01ec65ee83be0b4972b071be6b6ce46ddd~qoYnSztar1413414134euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338623;
        bh=1jgxo9l2TtPgCBIdPe/y+ojPYkgw4g2+N3N/h90OAdE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=rc2oPNlJp42Fpp8u3rDtoPvzPqisaQYsIMpfprmtb7MP8tuJ9U2DITmdFrRyh/Qzc
         pT0tpbD15aITOcFnJmRIyANBOAePJqI0eBRt9OPkUkkR8nwz853xesTVcq38ltVct+
         co62GQHfMbXW3m9DCqqdfu7acJ67HlfjK3RPgyGg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621091023eucas1p122d19ce002f66c6e8a0adbd2e3a30ad4~qoYmz9mgx2848828488eucas1p1W;
        Wed, 21 Jun 2023 09:10:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id BF.8E.11320.E7EB2946; Wed, 21
        Jun 2023 10:10:23 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa~qoYmASvrd0547605476eucas1p1v;
        Wed, 21 Jun 2023 09:10:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091022eusmtrp236bd2250119bdac5fe33daa3c529b4fd~qoYl7iO_G2182221822eusmtrp2g;
        Wed, 21 Jun 2023 09:10:22 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-c8-6492be7e5d77
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CF.0F.10549.D7EB2946; Wed, 21
        Jun 2023 10:10:22 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091021eusmtip237d1f3e24e19ae8cad088c863d5c07c2~qoYlj-NWC1796317963eusmtip2T;
        Wed, 21 Jun 2023 09:10:21 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:20 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
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
        Martin Schiller <ms@dev.tdt.de>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <bridge@lists.linux-foundation.org>, <dccp@vger.kernel.org>,
        <linux-wpan@vger.kernel.org>, <mptcp@lists.linux.dev>,
        <lvs-devel@vger.kernel.org>, <rds-devel@oss.oracle.com>,
        <linux-afs@lists.infradead.org>, <linux-sctp@vger.kernel.org>,
        <linux-s390@vger.kernel.org>,
        <tipc-discussion@lists.sourceforge.net>,
        <linux-x25@vger.kernel.org>
Subject: [PATCH 06/11] sysctl: Add size to register_net_sysctl function
Date:   Wed, 21 Jun 2023 11:09:55 +0200
Message-ID: <20230621091000.424843-7-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTVxid++7LAkzkERy5RTtMUWq1LRZb8ZtWOtBlfNp2yg+tDD+0EV4R
        FGQIoNRRgYCyFA1LoQHKYlmCbDMQgoACpcomNVbQIIIoEEVEoixKokAJoR3+nfOd79x7zp25
        QiwuFdgL/YNCuZAgyRFHviWtbjVoPjzdmOL7UWwlBS2R26G97J4A5urOYph6+JgH2ZoYGua0
        iXyYiH5NQ0V9LAW61iEBqJNKESSOrQNZzQyCkfNDPOgpes4HxW/tCAZnhmgwnLMCRYKMAn16
        FgU31ed4kGYsxCDvdIE7tQMUdNdn8+FRSxIN8nwZBl3eUx70pxbR0HwlF8FQpZ4CWe4kBtnU
        MAajso0HN5IWMCi7HlHQK9ch+OtsIw+6KqMF8DKnHUNr3hqQV3TS0Cfr4MPL6+MIMsZvY7h1
        eQN0Ti9QcKN6igdT2e/BQ7mGhlSlioKG+FkBqDQBENWlFsCwVovdXdm+oRnMTtzoQGxO2QnW
        aNjMqkruUmzi1THM1mUOCFh1sxObVxXGVl2M57PXSsopVn6hGbHVBafZ1N5ixI5WKxDbkDdF
        eTp4W+7w5Y74h3MhWz7/0fLQ6O9dvGB1CXVc+SKNF4nyZ1ACEgoJ8wkxGkITkKVQzCgRKczN
        wAnIYpFMI6L/daNZmEJk5FYXbRJMhgdpSsosFCNinE+j/t96cvvJMqlBpCy1gGey8JkPiGa8
        H5uE1UyOFSnOmRSYCGau0ORxZhFlSmLL7CTqGGuTgWaciGoslmcai5gdpP+O0Hy1AzmjzUAm
        bMG4Ec2wfimSiLEhHYqRJYwXd2Q1WdiMCflzdBSbveuJtvEPvhmfJJ2qPsqM9VZkrvpbM/6K
        jCruL+/bkrE2lcCM15GFutylYoRJRaRp/rnATEoRKYqaWT7pMxLTM7Ls8CDRcxew+YVXkd5n
        NuZAq0iKOmN5LCJxZ8RytCFzRYXMFRUyV1TIQ/gisuPCpIF+nHRrEHfMWSoJlIYF+Tn7HA2s
        Qov/6fp82/QlVDz2wrkFUULUgogQO64WvV2V4isW+UoifuZCjh4ICTvCSVvQWiHtaCd6363D
        R8z4SUK5wxwXzIX8p1JCC/tIyvNpcsMbL/pVc7mkLa4x3Ekp13dPBrpHnYg/Tpef8radb5H/
        MpB8UFjwd8pYrf5gfOZPuq3Z/JtNYtWnxn8qXUq/uV87Z19z7UtdhIe2ljWuv3VYa+0Qli7u
        H4zw2Ktz3/46TnjbiZu3hWqbQG2Ev0Xz7E0fJ7cqvCkyumGbNPwL2URP39fus4mhl04OezQd
        +z6gUOP6YEtFyu7OWpFdZNpghiu+t7vWUO/bp6vbv59Ys3d69/WRtxw7ug2Wz15t3JNwzv7U
        AYMyFIK91m9amyTJz756frJAMbqnS1/i7bUvOpn4GiPu7tr17jvayHS+4s13nmF7mYCsdBy+
        5uNtl38YdKSlhyQum3GIVPIv28QTHr4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVDUZRzGfX/H7iKz+QOW/A3pqEtYGaws55dAImvs1zQ1/GFZNgQ7sMMR
        V7vgeJCgCxhnyzEqy7WgLKAGscAKkgxuxH1Eq2AGIfcZhwskJBKw0wz/Pe/zfT/PM9+Z9+Xg
        pg9ZFpzA0AixJFQUzGftJtpfNv9lc7E+3c92Xo2DNsYZWu78yYb12is46IcmSMjpjiVgvS+J
        BXOX/yWg7F4cBmNNw2zQpNxGkDS9D2TVywhGfxgm4aFqgQVZ11sQDC4PE7CaagxZiTIM5q9m
        Y/CbJpWEzLUiHORtQui9O4CB7l4OC8a1KQTIC2Q4jClnSOjPUBHQcD8fwXD5PAay/Gc4yPQj
        OKyVNJPQlbKBQ0nHOAaP5WMIfrlST0JH+WU2rOS14NCkfBXkZW0EPJG1smClfRbBtdlHOPz+
        8+vQtrSBQVelngR9zpswJO8mIKOkCoO6hOdsqOoOgksdGjaM9PXhHk7Mk+FlnJnrakVM3p0L
        zNrqEaaq9A+MSWqcxplaxQCb0TRYMUp1JKO+lcBifi39EWPkhQ2IqbwZzWQ8LkbMZGUWYuqU
        eszzwGmBmyQsMkJ8MCBMGnGM/5UQ7ARCFxDYObgIhPbOXu/YOfKPurv5iYMDz4glR919BAGT
        uR1kuKYUO1uymEnGoIJllIiMODTlQD/NLMES0W6OKVWE6J7SGcIw2EdXLD0iDdqMftGbyNrS
        ptQiouOVbxuAakSX5hZsJ7Eoa7p7th/fGvCoPGM65YEabR1w6j5BTyhUmx0cjhn1Ia2J3bMF
        EJQVXTUdR27ZXMqN7u/lGMoO0PF917YzjahjdPfIPGEodqPzF3TbPpcyoVuzRrd9fPO+rDob
        N2iafjA5iRtyLOm++hssg/6O1q+PIzniKXbgih24YgeuRPgtxBNHSkP8Q6RCgVQUIo0M9Rf4
        hoWo0ebz1jStVtagvOlFgRZhHKRFNAfn87j71el+plw/0bnzYkmYtyQyWCzVIsfNNdNwC3Pf
        sM3/ERrhLXSydRQ6OLnYOro42fP3cj8K/15kSvmLIsTfiMXhYsn/HMYxsojBvLt7M4JOnH2r
        2KLY5j0vOdc9jLt/pfOzqpc45XB4lPw73Z1su/u5wuU1XkXduVPmlqocRfuS32K1t03jnEnO
        UM8XDdY14Vjyt++vFjakuk40HzRz5fo4G/8zsRoVFTuYFH7d47z9lMdYWeMnz4KOm4x0jgbW
        VA/q0vy9Ooem9lCiyhszU1DYHo2F6Po9V6wORUzE5bv5Rx3+8hVeboD2ZO0uvU70xs2NtEMX
        651VuxoaVwpfnOr6+ulAI7snWmVaHP/Buz72DubJ3Pi1QF3STx6Lamte0VR22oWPyxM7LCMr
        Tie7Xuriw4nahU8Him+3HUpkzBLO+F59njem8TxZNJe8F+MT0gCR8AgukYr+A/zhRFhnBAAA
X-CMS-MailID: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
X-Msg-Generator: CA
X-RootMTR: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091022eucas1p1c097da50842b23e902e1a674e117e1aa@eucas1p1.samsung.com>
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

In order to remove the end element from the ctl_table struct arrays, we
explicitly define the size when registering the targets.
The register_net_sysctl function is an indirection function that gets a
new argument. All the functions that call into regster_net_sysctl, in
turn, pass a new size of array argument.

In general the callers of register_net_sysctl need to add a size
argument calculated by ARRAY_size on the ctl_table array. The following
files are the ones that fall in this "easy" category:
	drivers/infiniband/core/iwcm.c
	drivers/infiniband/core/ucma.c
	drivers/net/vrf.c
	include/net/net_namespace.h
	net/appletalk/sysctl_net_atalk.c
	net/ax25/sysctl_net_ax25.c
	net/bridge/br_netfilter_hooks.c
	net/core/neighbour.c
	net/core/sysctl_net_core.c
	net/dccp/sysctl.c
	net/ieee802154/6lowpan/reassembly.c
	net/ipv4/devinet.c
	net/ipv4/ip_fragment.c
	net/ipv4/route.c
	net/ipv4/sysctl_net_ipv4.c
	net/ipv4/xfrm4_policy.c
	net/ipv6/addrconf.c
	net/ipv6/netfilter/nf_conntrack_reasm.c
	net/ipv6/reassembly.c
	net/ipv6/xfrm6_policy.c
	net/llc/sysctl_net_llc.c
	net/mpls/af_mpls.c
	net/mptcp/ctrl.c
	net/netfilter/ipvs/ip_vs_ctl.c
	net/netfilter/ipvs/ip_vs_lblc.c
	net/netfilter/ipvs/ip_vs_lblcr.c
	net/netfilter/nf_conntrack_standalone.c
	net/netfilter/nf_log.c
	net/netrom/sysctl_net_netrom.c
	net/phonet/sysctl.c
	net/rds/ib_sysctl.c
	net/rds/sysctl.c
	net/rds/tcp.c
	net/rose/sysctl_net_rose.c
	net/rxrpc/sysctl.c
	net/sctp/sysctl.c
	net/smc/smc_sysctl.c
	net/tipc/sysctl.c
	net/unix/sysctl_net_unix.c
	net/x25/sysctl_net_x25.c
	net/xfrm/xfrm_sysctl.c

An additional size function was added to the following files in order to
calculate the size of an array that is defined in another file:
	include/net/ipv6.h
	net/ipv6/icmp.c
	net/ipv6/route.c
	net/ipv6/sysctl_net_ipv6.c

In this file we add the additional argument:
	net/sysctl_net.c

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/infiniband/core/iwcm.c          |  3 +-
 drivers/infiniband/core/ucma.c          |  4 +-
 drivers/net/vrf.c                       |  3 +-
 include/net/ipv6.h                      |  2 +
 include/net/net_namespace.h             |  4 +-
 net/appletalk/sysctl_net_atalk.c        |  4 +-
 net/ax25/sysctl_net_ax25.c              |  3 +-
 net/bridge/br_netfilter_hooks.c         |  2 +-
 net/core/neighbour.c                    |  3 +-
 net/core/sysctl_net_core.c              |  5 +-
 net/dccp/sysctl.c                       |  3 +-
 net/ieee802154/6lowpan/reassembly.c     |  6 +-
 net/ipv4/devinet.c                      |  6 +-
 net/ipv4/ip_fragment.c                  |  6 +-
 net/ipv4/route.c                        |  6 +-
 net/ipv4/sysctl_net_ipv4.c              |  6 +-
 net/ipv4/xfrm4_policy.c                 |  3 +-
 net/ipv6/addrconf.c                     |  3 +-
 net/ipv6/icmp.c                         |  5 ++
 net/ipv6/netfilter/nf_conntrack_reasm.c |  3 +-
 net/ipv6/reassembly.c                   |  6 +-
 net/ipv6/route.c                        |  5 ++
 net/ipv6/sysctl_net_ipv6.c              | 13 +++--
 net/ipv6/xfrm6_policy.c                 |  3 +-
 net/llc/sysctl_net_llc.c                |  9 ++-
 net/mpls/af_mpls.c                      | 75 +++++++++++++------------
 net/mptcp/ctrl.c                        |  3 +-
 net/netfilter/ipvs/ip_vs_ctl.c          |  3 +-
 net/netfilter/ipvs/ip_vs_lblc.c         |  5 +-
 net/netfilter/ipvs/ip_vs_lblcr.c        |  5 +-
 net/netfilter/nf_conntrack_standalone.c |  8 ++-
 net/netfilter/nf_log.c                  |  5 +-
 net/netrom/sysctl_net_netrom.c          |  3 +-
 net/phonet/sysctl.c                     |  4 +-
 net/rds/ib_sysctl.c                     |  4 +-
 net/rds/sysctl.c                        |  5 +-
 net/rds/tcp.c                           |  3 +-
 net/rose/sysctl_net_rose.c              |  4 +-
 net/rxrpc/sysctl.c                      |  3 +-
 net/sctp/sysctl.c                       |  7 ++-
 net/smc/smc_sysctl.c                    |  3 +-
 net/sysctl_net.c                        | 10 +---
 net/tipc/sysctl.c                       |  3 +-
 net/unix/sysctl_net_unix.c              |  3 +-
 net/x25/sysctl_net_x25.c                |  4 +-
 net/xfrm/xfrm_sysctl.c                  |  3 +-
 46 files changed, 176 insertions(+), 103 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 2b47073c61a6..20627a894c89 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -1193,7 +1193,8 @@ static int __init iw_cm_init(void)
 		goto err_alloc;
 
 	iwcm_ctl_table_hdr = register_net_sysctl(&init_net, "net/iw_cm",
-						 iwcm_ctl_table);
+						 iwcm_ctl_table,
+						 ARRAY_SIZE(iwcm_ctl_table));
 	if (!iwcm_ctl_table_hdr) {
 		pr_err("iw_cm: couldn't register sysctl paths\n");
 		goto err_sysctl;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index bf42650f125b..f737ab0de883 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1863,7 +1863,9 @@ static int __init ucma_init(void)
 		goto err1;
 	}
 
-	ucma_ctl_table_hdr = register_net_sysctl(&init_net, "net/rdma_ucm", ucma_ctl_table);
+	ucma_ctl_table_hdr = register_net_sysctl(&init_net, "net/rdma_ucm",
+						 ucma_ctl_table,
+						 ARRAY_SIZE(ucma_ctl_table));
 	if (!ucma_ctl_table_hdr) {
 		pr_err("rdma_ucm: couldn't register sysctl paths\n");
 		ret = -ENOMEM;
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bdb3a76a352e..edd8f2ba5595 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1979,7 +1979,8 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 	/* init the extra1 parameter with the reference to current netns */
 	table[0].extra1 = net;
 
-	nn_vrf->ctl_hdr = register_net_sysctl(net, "net/vrf", table);
+	nn_vrf->ctl_hdr = register_net_sysctl(net, "net/vrf", table,
+					      ARRAY_SIZE(vrf_table));
 	if (!nn_vrf->ctl_hdr) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7332296eca44..37c2737be083 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1274,7 +1274,9 @@ static inline int snmp6_unregister_dev(struct inet6_dev *idev) { return 0; }
 
 #ifdef CONFIG_SYSCTL
 struct ctl_table *ipv6_icmp_sysctl_init(struct net *net);
+size_t ipv6_icmp_sysctl_table_size(void);
 struct ctl_table *ipv6_route_sysctl_init(struct net *net);
+size_t ipv6_route_sysctl_table_size(void);
 int ipv6_sysctl_register(void);
 void ipv6_sysctl_unregister(void);
 #endif
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 78beaa765c73..e6ffe77516eb 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -472,12 +472,12 @@ struct ctl_table;
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
 struct ctl_table_header *register_net_sysctl(struct net *net, const char *path,
-					     struct ctl_table *table);
+					     struct ctl_table *table, size_t table_size);
 void unregister_net_sysctl_table(struct ctl_table_header *header);
 #else
 static inline int net_sysctl_init(void) { return 0; }
 static inline struct ctl_table_header *register_net_sysctl(struct net *net,
-	const char *path, struct ctl_table *table)
+	const char *path, struct ctl_table *table, size_t table_size)
 {
 	return NULL;
 }
diff --git a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
index d945b7c0176d..30dcbbb8aeff 100644
--- a/net/appletalk/sysctl_net_atalk.c
+++ b/net/appletalk/sysctl_net_atalk.c
@@ -47,7 +47,9 @@ static struct ctl_table_header *atalk_table_header;
 
 int __init atalk_register_sysctl(void)
 {
-	atalk_table_header = register_net_sysctl(&init_net, "net/appletalk", atalk_table);
+	atalk_table_header = register_net_sysctl(&init_net, "net/appletalk",
+						 atalk_table,
+						 ARRAY_SIZE(atalk_table));
 	if (!atalk_table_header)
 		return -ENOMEM;
 	return 0;
diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index 2154d004d3dc..06afbc14b783 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -159,7 +159,8 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 		table[k].data = &ax25_dev->values[k];
 
 	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
-	ax25_dev->sysheader = register_net_sysctl(&init_net, path, table);
+	ax25_dev->sysheader = register_net_sysctl(&init_net, path, table,
+						  ARRAY_SIZE(ax25_param_table));
 	if (!ax25_dev->sysheader) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 1a801fab9543..ebbaef748a48 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1135,7 +1135,7 @@ static int br_netfilter_sysctl_init_net(struct net *net)
 
 	br_netfilter_sysctl_default(brnet);
 
-	brnet->ctl_hdr = register_net_sysctl(net, "net/bridge", table);
+	brnet->ctl_hdr = register_net_sysctl(net, "net/bridge", table, ARRAY_SIZE(brnf_table));
 	if (!brnet->ctl_hdr) {
 		if (!net_eq(net, &init_net))
 			kfree(table);
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ddd0f32de20e..aa5ad1cfc9b1 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3842,7 +3842,8 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
 		p_name, dev_name_source);
 	t->sysctl_header =
-		register_net_sysctl(neigh_parms_net(p), neigh_path, t->neigh_vars);
+		register_net_sysctl(neigh_parms_net(p), neigh_path, t->neigh_vars,
+				    ARRAY_SIZE(t->neigh_vars));
 	if (!t->sysctl_header)
 		goto free;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 782273bb93c2..aa615f22507b 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -712,7 +712,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
 			tmp->data += (char *)net - (char *)&init_net;
 	}
 
-	net->core.sysctl_hdr = register_net_sysctl(net, "net/core", tbl);
+	net->core.sysctl_hdr = register_net_sysctl(net, "net/core", tbl,
+						   ARRAY_SIZE(netns_core_table));
 	if (net->core.sysctl_hdr == NULL)
 		goto err_reg;
 
@@ -745,7 +746,7 @@ static __net_initdata struct pernet_operations sysctl_core_ops = {
 
 static __init int sysctl_core_init(void)
 {
-	register_net_sysctl(&init_net, "net/core", net_core_table);
+	register_net_sysctl(&init_net, "net/core", net_core_table, ARRAY_SIZE(net_core_table));
 	return register_pernet_subsys(&sysctl_core_ops);
 }
 
diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index ee8d4f5afa72..1140748858b0 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -99,7 +99,8 @@ static struct ctl_table_header *dccp_table_header;
 int __init dccp_sysctl_init(void)
 {
 	dccp_table_header = register_net_sysctl(&init_net, "net/dccp/default",
-			dccp_default_table);
+						dccp_default_table,
+						ARRAY_SIZE(dccp_default_table));
 
 	return dccp_table_header != NULL ? 0 : -ENOMEM;
 }
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index a91283d1e5bf..7b717434368c 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -379,7 +379,8 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 	table[1].extra2	= &ieee802154_lowpan->fqdir->high_thresh;
 	table[2].data	= &ieee802154_lowpan->fqdir->timeout;
 
-	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
+	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table,
+				  ARRAY_SIZE(lowpan_frags_ns_ctl_table));
 	if (hdr == NULL)
 		goto err_reg;
 
@@ -411,7 +412,8 @@ static int __init lowpan_frags_sysctl_register(void)
 {
 	lowpan_ctl_header = register_net_sysctl(&init_net,
 						"net/ieee802154/6lowpan",
-						lowpan_frags_ctl_table);
+						lowpan_frags_ctl_table,
+						ARRAY_SIZE(lowpan_frags_ctl_table));
 	return lowpan_ctl_header == NULL ? -ENOMEM : 0;
 }
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5deac0517ef7..6360425dfcb2 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2587,7 +2587,8 @@ static int __devinet_sysctl_register(struct net *net, char *dev_name,
 
 	snprintf(path, sizeof(path), "net/ipv4/conf/%s", dev_name);
 
-	t->sysctl_header = register_net_sysctl(net, path, t->devinet_vars);
+	t->sysctl_header = register_net_sysctl(net, path, t->devinet_vars,
+					       ARRAY_SIZE(t->devinet_vars));
 	if (!t->sysctl_header)
 		goto free;
 
@@ -2720,7 +2721,8 @@ static __net_init int devinet_init_net(struct net *net)
 		goto err_reg_dflt;
 
 	err = -ENOMEM;
-	forw_hdr = register_net_sysctl(net, "net/ipv4", tbl);
+	forw_hdr = register_net_sysctl(net, "net/ipv4", tbl,
+				       ARRAY_SIZE(ctl_forward_entry));
 	if (!forw_hdr)
 		goto err_reg_ctl;
 	net->ipv4.forw_hdr = forw_hdr;
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 69c00ffdcf3e..3d7a82a900b5 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -615,7 +615,8 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
 	table[2].data	= &net->ipv4.fqdir->timeout;
 	table[3].data	= &net->ipv4.fqdir->max_dist;
 
-	hdr = register_net_sysctl(net, "net/ipv4", table);
+	hdr = register_net_sysctl(net, "net/ipv4", table,
+				  ARRAY_SIZE(ip4_frags_ns_ctl_table));
 	if (!hdr)
 		goto err_reg;
 
@@ -640,7 +641,8 @@ static void __net_exit ip4_frags_ns_ctl_unregister(struct net *net)
 
 static void __init ip4_frags_ctl_register(void)
 {
-	register_net_sysctl(&init_net, "net/ipv4", ip4_frags_ctl_table);
+	register_net_sysctl(&init_net, "net/ipv4", ip4_frags_ctl_table,
+			    ARRAY_SIZE(ip4_frags_ctl_table));
 }
 #else
 static int ip4_frags_ns_ctl_register(struct net *net)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 98d7e6ba7493..883f4f1ee056 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3615,7 +3615,8 @@ static __net_init int sysctl_route_net_init(struct net *net)
 	}
 	tbl[0].extra1 = net;
 
-	net->ipv4.route_hdr = register_net_sysctl(net, "net/ipv4/route", tbl);
+	net->ipv4.route_hdr = register_net_sysctl(net, "net/ipv4/route", tbl,
+						  ARRAY_SIZE(ipv4_route_netns_table));
 	if (!net->ipv4.route_hdr)
 		goto err_reg;
 	return 0;
@@ -3775,6 +3776,7 @@ int __init ip_rt_init(void)
  */
 void __init ip_static_sysctl_init(void)
 {
-	register_net_sysctl(&init_net, "net/ipv4/route", ipv4_route_table);
+	register_net_sysctl(&init_net, "net/ipv4/route", ipv4_route_table,
+			    ARRAY_SIZE(ipv4_route_table));
 }
 #endif
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 40fe70fc2015..1821f403efc0 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1500,7 +1500,8 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 		}
 	}
 
-	net->ipv4.ipv4_hdr = register_net_sysctl(net, "net/ipv4", table);
+	net->ipv4.ipv4_hdr = register_net_sysctl(net, "net/ipv4", table,
+						 ARRAY_SIZE(ipv4_net_table));
 	if (!net->ipv4.ipv4_hdr)
 		goto err_reg;
 
@@ -1538,7 +1539,8 @@ static __init int sysctl_ipv4_init(void)
 {
 	struct ctl_table_header *hdr;
 
-	hdr = register_net_sysctl(&init_net, "net/ipv4", ipv4_table);
+	hdr = register_net_sysctl(&init_net, "net/ipv4", ipv4_table,
+				  ARRAY_SIZE(ipv4_table));
 	if (!hdr)
 		return -ENOMEM;
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 9403bbaf1b61..ec1d68dbffc3 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -178,7 +178,8 @@ static __net_init int xfrm4_net_sysctl_init(struct net *net)
 		table[0].data = &net->xfrm.xfrm4_dst_ops.gc_thresh;
 	}
 
-	hdr = register_net_sysctl(net, "net/ipv4", table);
+	hdr = register_net_sysctl(net, "net/ipv4", table,
+				  ARRAY_SIZE(xfrm4_policy_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3797917237d0..68a2925c66a5 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7086,7 +7086,8 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 
 	snprintf(path, sizeof(path), "net/ipv6/conf/%s", dev_name);
 
-	p->sysctl_header = register_net_sysctl(net, path, table);
+	p->sysctl_header = register_net_sysctl(net, path, table,
+					       ARRAY_SIZE(addrconf_sysctl));
 	if (!p->sysctl_header)
 		goto free;
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 9edf1f45b1ed..4159662fa214 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1226,4 +1226,9 @@ struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
 	}
 	return table;
 }
+
+size_t ipv6_icmp_sysctl_table_size(void)
+{
+	return ARRAY_SIZE(ipv6_icmp_table_template);
+}
 #endif
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index d13240f13607..dca8e0aabc51 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -87,7 +87,8 @@ static int nf_ct_frag6_sysctl_register(struct net *net)
 	table[2].data	= &nf_frag->fqdir->high_thresh;
 	table[2].extra1	= &nf_frag->fqdir->low_thresh;
 
-	hdr = register_net_sysctl(net, "net/netfilter", table);
+	hdr = register_net_sysctl(net, "net/netfilter", table,
+				  ARRAY_SIZE(nf_ct_frag6_sysctl_table));
 	if (hdr == NULL)
 		goto err_reg;
 
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 5bc8a28e67f9..0688261202de 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -470,7 +470,8 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
 	table[1].extra2	= &net->ipv6.fqdir->high_thresh;
 	table[2].data	= &net->ipv6.fqdir->timeout;
 
-	hdr = register_net_sysctl(net, "net/ipv6", table);
+	hdr = register_net_sysctl(net, "net/ipv6", table,
+				  ARRAY_SIZE(ip6_frags_ns_ctl_table));
 	if (!hdr)
 		goto err_reg;
 
@@ -499,7 +500,8 @@ static struct ctl_table_header *ip6_ctl_header;
 static int ip6_frags_sysctl_register(void)
 {
 	ip6_ctl_header = register_net_sysctl(&init_net, "net/ipv6",
-			ip6_frags_ctl_table);
+					     ip6_frags_ctl_table,
+					     ARRAY_SIZE(ip6_frags_ctl_table));
 	return ip6_ctl_header == NULL ? -ENOMEM : 0;
 }
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index e3aec46bd466..a35470576077 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6450,6 +6450,11 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
 
 	return table;
 }
+
+size_t ipv6_route_sysctl_table_size(void)
+{
+	return ARRAY_SIZE(ipv6_route_table_template);
+}
 #endif
 
 static int __net_init ip6_route_net_init(struct net *net)
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 94a0a294c6a1..29f121f513a6 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -275,17 +275,21 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 	if (!ipv6_icmp_table)
 		goto out_ipv6_route_table;
 
-	net->ipv6.sysctl.hdr = register_net_sysctl(net, "net/ipv6", ipv6_table);
+	net->ipv6.sysctl.hdr = register_net_sysctl(net, "net/ipv6",
+						   ipv6_table,
+						   ARRAY_SIZE(ipv6_table_template));
 	if (!net->ipv6.sysctl.hdr)
 		goto out_ipv6_icmp_table;
 
 	net->ipv6.sysctl.route_hdr =
-		register_net_sysctl(net, "net/ipv6/route", ipv6_route_table);
+		register_net_sysctl(net, "net/ipv6/route", ipv6_route_table,
+				    ipv6_route_sysctl_table_size());
 	if (!net->ipv6.sysctl.route_hdr)
 		goto out_unregister_ipv6_table;
 
 	net->ipv6.sysctl.icmp_hdr =
-		register_net_sysctl(net, "net/ipv6/icmp", ipv6_icmp_table);
+		register_net_sysctl(net, "net/ipv6/icmp", ipv6_icmp_table,
+				    ipv6_icmp_sysctl_table_size());
 	if (!net->ipv6.sysctl.icmp_hdr)
 		goto out_unregister_route_table;
 
@@ -335,7 +339,8 @@ int ipv6_sysctl_register(void)
 {
 	int err = -ENOMEM;
 
-	ip6_header = register_net_sysctl(&init_net, "net/ipv6", ipv6_rotable);
+	ip6_header = register_net_sysctl(&init_net, "net/ipv6", ipv6_rotable,
+					 ARRAY_SIZE(ipv6_rotable));
 	if (!ip6_header)
 		goto out;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index eecc5e59da17..27efdb18a018 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -205,7 +205,8 @@ static int __net_init xfrm6_net_sysctl_init(struct net *net)
 		table[0].data = &net->xfrm.xfrm6_dst_ops.gc_thresh;
 	}
 
-	hdr = register_net_sysctl(net, "net/ipv6", table);
+	hdr = register_net_sysctl(net, "net/ipv6", table,
+				  ARRAY_SIZE(xfrm6_policy_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
index 8443a6d841b0..195296ba29f0 100644
--- a/net/llc/sysctl_net_llc.c
+++ b/net/llc/sysctl_net_llc.c
@@ -56,8 +56,13 @@ static struct ctl_table_header *llc_station_header;
 
 int __init llc_sysctl_init(void)
 {
-	llc2_timeout_header = register_net_sysctl(&init_net, "net/llc/llc2/timeout", llc2_timeout_table);
-	llc_station_header = register_net_sysctl(&init_net, "net/llc/station", llc_station_table);
+	llc2_timeout_header = register_net_sysctl(&init_net,
+						  "net/llc/llc2/timeout",
+						  llc2_timeout_table,
+						  ARRAY_SIZE(llc2_timeout_table));
+	llc_station_header = register_net_sysctl(&init_net, "net/llc/station",
+						 llc_station_table,
+						 ARRAY_SIZE(llc_station_table));
 
 	if (!llc2_timeout_header || !llc_station_header) {
 		llc_sysctl_exit();
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index dc5165d3eec4..6f96aae76537 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1395,6 +1395,40 @@ static const struct ctl_table mpls_dev_table[] = {
 	{ }
 };
 
+static int mpls_platform_labels(struct ctl_table *table, int write,
+				void *buffer, size_t *lenp, loff_t *ppos);
+#define MPLS_NS_SYSCTL_OFFSET(field)		\
+	(&((struct net *)0)->field)
+
+static const struct ctl_table mpls_table[] = {
+	{
+		.procname	= "platform_labels",
+		.data		= NULL,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= mpls_platform_labels,
+	},
+	{
+		.procname	= "ip_ttl_propagate",
+		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "default_ttl",
+		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= &ttl_max,
+	},
+	{ }
+};
+
 static int mpls_dev_sysctl_register(struct net_device *dev,
 				    struct mpls_dev *mdev)
 {
@@ -1410,7 +1444,7 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 	/* Table data contains only offsets relative to the base of
 	 * the mdev at this point, so make them absolute.
 	 */
-	for (i = 0; i < ARRAY_SIZE(mpls_dev_table); i++) {
+	for (i = 0; i < ARRAY_SIZE(mpls_dev_table) - 1; i++) {
 		table[i].data = (char *)mdev + (uintptr_t)table[i].data;
 		table[i].extra1 = mdev;
 		table[i].extra2 = net;
@@ -1418,7 +1452,8 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 
 	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
 
-	mdev->sysctl = register_net_sysctl(net, path, table);
+	mdev->sysctl = register_net_sysctl(net, path, table,
+					   ARRAY_SIZE(mpls_dev_table));
 	if (!mdev->sysctl)
 		goto free;
 
@@ -1432,6 +1467,7 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 	return -ENOBUFS;
 }
 
+
 static void mpls_dev_sysctl_unregister(struct net_device *dev,
 				       struct mpls_dev *mdev)
 {
@@ -2636,38 +2672,6 @@ static int mpls_platform_labels(struct ctl_table *table, int write,
 	return ret;
 }
 
-#define MPLS_NS_SYSCTL_OFFSET(field)		\
-	(&((struct net *)0)->field)
-
-static const struct ctl_table mpls_table[] = {
-	{
-		.procname	= "platform_labels",
-		.data		= NULL,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= mpls_platform_labels,
-	},
-	{
-		.procname	= "ip_ttl_propagate",
-		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-	{
-		.procname	= "default_ttl",
-		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= &ttl_max,
-	},
-	{ }
-};
-
 static int mpls_net_init(struct net *net)
 {
 	struct ctl_table *table;
@@ -2688,7 +2692,8 @@ static int mpls_net_init(struct net *net)
 	for (i = 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
 		table[i].data = (char *)net + (uintptr_t)table[i].data;
 
-	net->mpls.ctl = register_net_sysctl(net, "net/mpls", table);
+	net->mpls.ctl = register_net_sysctl(net, "net/mpls", table,
+					    ARRAY_SIZE(mpls_table));
 	if (net->mpls.ctl == NULL) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..42dfc834e5c6 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -150,7 +150,8 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 
-	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
+	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table,
+				  ARRAY_SIZE(mptcp_sysctl_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 62606fb44d02..abbd30ee3ce0 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -4353,7 +4353,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 #endif
 
 	ret = -ENOMEM;
-	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl);
+	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl,
+					       ARRAY_SIZE(vs_vars));
 	if (!ipvs->sysctl_hdr)
 		goto err;
 	ipvs->sysctl_tbl = tbl;
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 1b87214d385e..254eb3b61e15 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -570,8 +570,9 @@ static int __net_init __ip_vs_lblc_init(struct net *net)
 	ipvs->sysctl_lblc_expiration = DEFAULT_EXPIRATION;
 	ipvs->lblc_ctl_table[0].data = &ipvs->sysctl_lblc_expiration;
 
-	ipvs->lblc_ctl_header =
-		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblc_ctl_table);
+	ipvs->lblc_ctl_header = register_net_sysctl(net, "net/ipv4/vs",
+						    ipvs->lblc_ctl_table,
+						    ARRAY_SIZE(vs_vars_table));
 	if (!ipvs->lblc_ctl_header) {
 		if (!net_eq(net, &init_net))
 			kfree(ipvs->lblc_ctl_table);
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index ad8f5fea6d3a..0e39a4fd421f 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -755,8 +755,9 @@ static int __net_init __ip_vs_lblcr_init(struct net *net)
 	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
 	ipvs->lblcr_ctl_table[0].data = &ipvs->sysctl_lblcr_expiration;
 
-	ipvs->lblcr_ctl_header =
-		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblcr_ctl_table);
+	ipvs->lblcr_ctl_header = register_net_sysctl(net, "net/ipv4/vs",
+						     ipvs->lblcr_ctl_table,
+						     ARRAY_SIZE(vs_vars_table));
 	if (!ipvs->lblcr_ctl_header) {
 		if (!net_eq(net, &init_net))
 			kfree(ipvs->lblcr_ctl_table);
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 169e16fc2bce..a3b2029ef098 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1106,7 +1106,8 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
 		table[NF_SYSCTL_CT_BUCKETS].mode = 0444;
 	}
 
-	cnet->sysctl_header = register_net_sysctl(net, "net/netfilter", table);
+	cnet->sysctl_header = register_net_sysctl(net, "net/netfilter", table,
+						  ARRAY_SIZE(nf_ct_sysctl_table));
 	if (!cnet->sysctl_header)
 		goto out_unregister_netfilter;
 
@@ -1207,8 +1208,9 @@ static int __init nf_conntrack_standalone_init(void)
 	BUILD_BUG_ON(NFCT_INFOMASK <= IP_CT_NUMBER);
 
 #ifdef CONFIG_SYSCTL
-	nf_ct_netfilter_header =
-		register_net_sysctl(&init_net, "net", nf_ct_netfilter_table);
+	nf_ct_netfilter_header = register_net_sysctl(&init_net, "net",
+						     nf_ct_netfilter_table,
+						     ARRAY_SIZE(nf_ct_netfilter_table));
 	if (!nf_ct_netfilter_header) {
 		pr_err("nf_conntrack: can't register to sysctl.\n");
 		ret = -ENOMEM;
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 8a29290149bd..755f9cf570ce 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -479,7 +479,8 @@ static int netfilter_log_sysctl_init(struct net *net)
 				(void *)(unsigned long) i;
 		}
 		nf_log_sysctl_fhdr = register_net_sysctl(net, "net/netfilter",
-							 nf_log_sysctl_ftable);
+							 nf_log_sysctl_ftable,
+							 ARRAY_SIZE(nf_log_sysctl_ftable));
 		if (!nf_log_sysctl_fhdr)
 			goto err_freg;
 	}
@@ -489,7 +490,7 @@ static int netfilter_log_sysctl_init(struct net *net)
 
 	net->nf.nf_log_dir_header = register_net_sysctl(net,
 						"net/netfilter/nf_log",
-						table);
+						table, ARRAY_SIZE(nf_log_sysctl_table));
 	if (!net->nf.nf_log_dir_header)
 		goto err_reg;
 
diff --git a/net/netrom/sysctl_net_netrom.c b/net/netrom/sysctl_net_netrom.c
index 79fb2d3f477b..c02b93fd9d4f 100644
--- a/net/netrom/sysctl_net_netrom.c
+++ b/net/netrom/sysctl_net_netrom.c
@@ -145,7 +145,8 @@ static struct ctl_table nr_table[] = {
 
 int __init nr_register_sysctl(void)
 {
-	nr_table_header = register_net_sysctl(&init_net, "net/netrom", nr_table);
+	nr_table_header = register_net_sysctl(&init_net, "net/netrom",
+					      nr_table, ARRAY_SIZE(nr_table));
 	if (!nr_table_header)
 		return -ENOMEM;
 	return 0;
diff --git a/net/phonet/sysctl.c b/net/phonet/sysctl.c
index 0d0bf41381c2..0fd0fcb00505 100644
--- a/net/phonet/sysctl.c
+++ b/net/phonet/sysctl.c
@@ -86,7 +86,9 @@ static struct ctl_table phonet_table[] = {
 
 int __init phonet_sysctl_init(void)
 {
-	phonet_table_hrd = register_net_sysctl(&init_net, "net/phonet", phonet_table);
+	phonet_table_hrd = register_net_sysctl(&init_net, "net/phonet",
+					       phonet_table,
+					       ARRAY_SIZE(phonet_table));
 	return phonet_table_hrd == NULL ? -ENOMEM : 0;
 }
 
diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index e4e41b3afce7..102fd4a18df7 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -114,7 +114,9 @@ void rds_ib_sysctl_exit(void)
 
 int rds_ib_sysctl_init(void)
 {
-	rds_ib_sysctl_hdr = register_net_sysctl(&init_net, "net/rds/ib", rds_ib_sysctl_table);
+	rds_ib_sysctl_hdr = register_net_sysctl(&init_net, "net/rds/ib",
+						rds_ib_sysctl_table,
+						ARRAY_SIZE(rds_ib_sysctl_table));
 	if (!rds_ib_sysctl_hdr)
 		return -ENOMEM;
 	return 0;
diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index e381bbcd9cc1..5abd2730a1bc 100644
--- a/net/rds/sysctl.c
+++ b/net/rds/sysctl.c
@@ -102,8 +102,9 @@ int rds_sysctl_init(void)
 	rds_sysctl_reconnect_min = msecs_to_jiffies(1);
 	rds_sysctl_reconnect_min_jiffies = rds_sysctl_reconnect_min;
 
-	rds_sysctl_reg_table =
-		register_net_sysctl(&init_net, "net/rds", rds_sysctl_rds_table);
+	rds_sysctl_reg_table = register_net_sysctl(&init_net, "net/rds",
+						   rds_sysctl_rds_table,
+						   ARRAY_SIZE(rds_sysctl_rds_table));
 	if (!rds_sysctl_reg_table)
 		return -ENOMEM;
 	return 0;
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index c5b86066ff66..2e90a2570d3b 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -565,7 +565,8 @@ static __net_init int rds_tcp_init_net(struct net *net)
 	}
 	tbl[RDS_TCP_SNDBUF].data = &rtn->sndbuf_size;
 	tbl[RDS_TCP_RCVBUF].data = &rtn->rcvbuf_size;
-	rtn->rds_tcp_sysctl = register_net_sysctl(net, "net/rds/tcp", tbl);
+	rtn->rds_tcp_sysctl = register_net_sysctl(net, "net/rds/tcp", tbl,
+						  ARRAY_SIZE(rds_tcp_sysctl_table));
 	if (!rtn->rds_tcp_sysctl) {
 		pr_warn("could not register sysctl\n");
 		err = -ENOMEM;
diff --git a/net/rose/sysctl_net_rose.c b/net/rose/sysctl_net_rose.c
index d391d7758f52..4f5a1e8b6c54 100644
--- a/net/rose/sysctl_net_rose.c
+++ b/net/rose/sysctl_net_rose.c
@@ -117,7 +117,9 @@ static struct ctl_table rose_table[] = {
 
 void __init rose_register_sysctl(void)
 {
-	rose_table_header = register_net_sysctl(&init_net, "net/rose", rose_table);
+	rose_table_header = register_net_sysctl(&init_net, "net/rose",
+						rose_table,
+						ARRAY_SIZE(rose_table));
 }
 
 void rose_unregister_sysctl(void)
diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
index ecaeb4ecfb58..2b5824416036 100644
--- a/net/rxrpc/sysctl.c
+++ b/net/rxrpc/sysctl.c
@@ -131,7 +131,8 @@ static struct ctl_table rxrpc_sysctl_table[] = {
 int __init rxrpc_sysctl_init(void)
 {
 	rxrpc_sysctl_reg_table = register_net_sysctl(&init_net, "net/rxrpc",
-						     rxrpc_sysctl_table);
+						     rxrpc_sysctl_table,
+						     ARRAY_SIZE(rxrpc_sysctl_table));
 	if (!rxrpc_sysctl_reg_table)
 		return -ENOMEM;
 	return 0;
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index a7a9136198fd..233f37f0fa28 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -612,7 +612,8 @@ int sctp_sysctl_net_register(struct net *net)
 	table[SCTP_PF_RETRANS_IDX].extra2 = &net->sctp.ps_retrans;
 	table[SCTP_PS_RETRANS_IDX].extra1 = &net->sctp.pf_retrans;
 
-	net->sctp.sysctl_header = register_net_sysctl(net, "net/sctp", table);
+	net->sctp.sysctl_header = register_net_sysctl(net, "net/sctp", table,
+						      ARRAY_SIZE(sctp_net_table));
 	if (net->sctp.sysctl_header == NULL) {
 		kfree(table);
 		return -ENOMEM;
@@ -634,7 +635,9 @@ static struct ctl_table_header *sctp_sysctl_header;
 /* Sysctl registration.  */
 void sctp_sysctl_register(void)
 {
-	sctp_sysctl_header = register_net_sysctl(&init_net, "net/sctp", sctp_table);
+	sctp_sysctl_header = register_net_sysctl(&init_net, "net/sctp",
+						 sctp_table,
+						 ARRAY_SIZE(sctp_table));
 }
 
 /* Sysctl deregistration.  */
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index b6f79fabb9d3..9404123883c0 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -81,7 +81,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
 			table[i].data += (void *)net - (void *)&init_net;
 	}
 
-	net->smc.smc_hdr = register_net_sysctl(net, "net/smc", table);
+	net->smc.smc_hdr = register_net_sysctl(net, "net/smc", table,
+					       ARRAY_SIZE(smc_table));
 	if (!net->smc.smc_hdr)
 		goto err_reg;
 
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 8ee4b74bc009..1757c18ea065 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -161,18 +161,12 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 }
 
 struct ctl_table_header *register_net_sysctl(struct net *net,
-	const char *path, struct ctl_table *table)
+	const char *path, struct ctl_table *table, size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-
 	if (!net_eq(net, &init_net))
 		ensure_safe_net_sysctl(net, path, table);
 
-	for (entry = table; entry->procname; entry++)
-		count++;
-
-	return __register_sysctl_table(&net->sysctls, path, table, count);
+	return __register_sysctl_table(&net->sysctls, path, table, table_size);
 }
 EXPORT_SYMBOL_GPL(register_net_sysctl);
 
diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
index 9fb65c988f7f..b9cbc3b359aa 100644
--- a/net/tipc/sysctl.c
+++ b/net/tipc/sysctl.c
@@ -96,7 +96,8 @@ static struct ctl_table tipc_table[] = {
 
 int tipc_register_sysctl(void)
 {
-	tipc_ctl_hdr = register_net_sysctl(&init_net, "net/tipc", tipc_table);
+	tipc_ctl_hdr = register_net_sysctl(&init_net, "net/tipc", tipc_table,
+					   ARRAY_SIZE(tipc_table));
 	if (tipc_ctl_hdr == NULL)
 		return -ENOMEM;
 	return 0;
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 500129aa710c..92f3bc3cd704 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -36,7 +36,8 @@ int __net_init unix_sysctl_register(struct net *net)
 		table[0].data = &net->unx.sysctl_max_dgram_qlen;
 	}
 
-	net->unx.ctl = register_net_sysctl(net, "net/unix", table);
+	net->unx.ctl = register_net_sysctl(net, "net/unix", table,
+					   ARRAY_SIZE(unix_table));
 	if (net->unx.ctl == NULL)
 		goto err_reg;
 
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index e9802afa43d0..4d7c2ee41943 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -76,7 +76,9 @@ static struct ctl_table x25_table[] = {
 
 int __init x25_register_sysctl(void)
 {
-	x25_table_header = register_net_sysctl(&init_net, "net/x25", x25_table);
+	x25_table_header = register_net_sysctl(&init_net, "net/x25",
+					       x25_table,
+					       ARRAY_SIZE(x25_table));
 	if (!x25_table_header)
 		return -ENOMEM;
 	return 0;
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 0c6c5ef65f9d..d04b25a47575 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -59,7 +59,8 @@ int __net_init xfrm_sysctl_init(struct net *net)
 	if (net->user_ns != &init_user_ns)
 		table[0].procname = NULL;
 
-	net->xfrm.sysctl_hdr = register_net_sysctl(net, "net/core", table);
+	net->xfrm.sysctl_hdr = register_net_sysctl(net, "net/core", table,
+						   ARRAY_SIZE(xfrm_table));
 	if (!net->xfrm.sysctl_hdr)
 		goto out_register;
 	return 0;
-- 
2.30.2

