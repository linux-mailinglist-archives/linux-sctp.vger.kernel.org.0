Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB970763873
	for <lists+linux-sctp@lfdr.de>; Wed, 26 Jul 2023 16:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjGZOIR (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 26 Jul 2023 10:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjGZOHz (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 26 Jul 2023 10:07:55 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA372D79;
        Wed, 26 Jul 2023 07:07:11 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140710euoutp01c2f546dc7d3f1d81abe0dae631a5e49c~1cAuVUlpK3202132021euoutp01d;
        Wed, 26 Jul 2023 14:07:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230726140710euoutp01c2f546dc7d3f1d81abe0dae631a5e49c~1cAuVUlpK3202132021euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380430;
        bh=eEG+9wdw3V8Mgi0svvwops3ImN3rHxuCM63fKfPTemk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uWx8l9YdqTEEanl4fst1oxCka5BL0LmY4ps6UXSWAHtP5+SRaG1qjszyujdxRJ7Or
         lT7zvmjLA/eSHfMQHDnFmo5uCnRJsEZCgGyG39pn8P6mH47tJcLEfvPgwzupbzd5tq
         hgwffHObaZK+iAJLPsuy89JF2Eg5y+Pd3VVLQGzM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726140709eucas1p23a046bfe707387d5086c45b0e7bb332c~1cAuDXBhz0677606776eucas1p2r;
        Wed, 26 Jul 2023 14:07:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.76.42423.D8821C46; Wed, 26
        Jul 2023 15:07:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc~1cAtfR7ue0711407114eucas1p2p;
        Wed, 26 Jul 2023 14:07:09 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140709eusmtrp19711e67c27de29be1bdc849ddf5f81f5~1cAtdj1EQ2391823918eusmtrp1X;
        Wed, 26 Jul 2023 14:07:09 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-9a-64c1288d4904
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.C7.10549.D8821C46; Wed, 26
        Jul 2023 15:07:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140708eusmtip206258e4e07c8a2754ecc16260081f003~1cAtKZYNv3056730567eusmtip2e;
        Wed, 26 Jul 2023 14:07:08 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, "David S. Miller" <davem@davemloft.net>,
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
        Jan Karcher <jaka@linux.ibm.com>
Cc:     willy@infradead.org, keescook@chromium.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        mptcp@lists.linux.dev, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 11/14] networking: Update to register_net_sysctl_sz
Date:   Wed, 26 Jul 2023 16:06:31 +0200
Message-Id: <20230726140635.2059334-12-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxjOd87paWlSdiwEvxQTtzoMFocjI+EzAzdwZicxu5gw2GRmdvYM
        kJtpKTrGlnIZcl+3NjJaMAVHV1EgcqlSHUrHQEYtbMoKxCWUq6MY7hTQwagHM/8973PJ+7zJ
        y8OFPaSIl5iazshTpclikk+Yu9bsr5UGdsheLy3cj6yqMOS8VcRBlX15BGqwfIuhia5RLro+
        5SZR8fQuVHvbCdAD4xyJNg1pyFacgmYv6DHUby7joPuWShJNWksJpK7OxdGEwcVBDzVGAo02
        zmJo3dTNQfbSTRyZbJMYGlRPAPTr+XYOsjXmcFGXwQ+t9M4AZG9e5CCnuo9AGlMLhm4WrnLR
        mHuKRNk2Mxc9Wa0k3xbTF69+RetVfxD0+pqEbrk8hNFtur+5tPlOAG1oUtLNJgk97Iqgm+oK
        SbrNeZBW19wB9KPmCkDPTwwTdL9xhqRn2wfID32P88NlTHJiBiM/cOgkP8GsnyTO3K0A5/I2
        WjgqYPi6CHjxIBUKTT3l3CLA5wkpE4D2TgfGDksAOuqvbSuLAKrHH+PPI84CN8kKPwNoadVv
        R/4BcNA+RnpcJLUf9s08xD2CL6Ui4fDTeo5nwKl2HLYtZHM8Lh/qMKy758Y8mKACYHHB+DNe
        QB2CV7JZDKndMN9RDjzYa4u/XO/e9uyAPRXjhAfjW57cVv2zbZD6jQ8vOSpJNvwOdEzatov7
        wOnuFi6Ld8FeTQnBBjQA3t6Y47LDFQCN2csY63oT5j0Y3xJ4Wyv2wUbLAZaOhDUb/ZiHhpQ3
        HHy8gy3hDX8wl+MsLYAF+ULW/Sosq9USLBZBx/227Wo0bKrWAzV4RffCOboXztH9v9cA8Dqw
        k1EqUuIZRUgqczZYIU1RKFPjg0+lpTSBrW/v3eheuAGqpueDrQDjASuAPFzsKwj5tF0mFMik
        X2Yy8rTP5MpkRmEF/jxCvFMQFNFzSkjFS9OZJIY5w8ifqxjPS6TCSoJ7Y11hbSLBnyLDeRhf
        a0lW/pVfonxiVYUsROXUJJXta0+sSnyPm9u5fLIkPOVWz54TZafH1zKrZcvz/34SZz9yBJbV
        2e4JE3Scq9VRtQhsLsW+G/f+gCB0UqtN6NQEhYbdHKtt/WlvVkRFVqxPd7jz+5UP3M27uQ1n
        Jdcl1zRv4N9k2BsOu9LGHkV2ShovHQ3qGPl8xG/gRnTmCZHyeJbI8JJ2aGnqu/XF/hEy+rQ1
        gAaRB/0l6Xv4o9aXP2qZ6zoWlROoVt+lxn6vj/KOjsmLMdjekrsuZiStGF1xQ3q/xKqSvU3n
        jjWEZlUezf645osfA2XaDv9foCWGWDU+BWJCkSANkeByhfQ/9OFHGlwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xbdRTH87uvXuqY167oDVmypQ4fMO+4vPYrobjMhN25xEcy57J3AzeU
        jFJsi9l0xOI2LO26dSNsQhvsllEKDhehPNUKNYJKeekYE4sLc22xgAUfK+AEW9Bk/33P+XxO
        zvnjkKioFY8nC4q0vLpIXighhFj/ct/PL5ie68lLNjlI6NZth5OfG3BoHTqDwU+6ziLQ13tP
        ANsDYQIagxth3ZeTAN6yzxFwxaaCHqMShi5bEDjcdh6HP3RZCeh3mzBovnoahT7bNA69lXYM
        3rsZQuCSow+Hg6YVFDo8fgTeMfsA/OoDFw49N98XwF7bk/BB/wyAgy1/4HDSPITBSocTgZ9V
        LAjgL+EAAcs8bQL494KV2CHham+8y1l0Ixi3tJjIORt+RLjOmgkB19adwNmaS7gWRyI3Pi3j
        mhsrCK5zUsqZr3UDbqqlGnDzvnGMG7bPEFzINUq8Jj7AZKlVJVp+s0Kl0cokB1mYwrBSyKSk
        SRk2dfvhzJR0ybbsrDy+sOBtXr0t+xijaLP4seJvqsGJM8tOXAdspQYQQ9JUGj2pDxMGICRF
        VB2gr35fgxsAGQHxdNges+ZsoB/eNvznBADtGr6ARQFBbaWHZrxoFIgpM0F3l/eDaIFSgyjt
        /WcBRK0N1Et040AYiWaMSqCN+vt4NMdS2fTHZWuZpjbR5WNXVv2YSL+hKbzaF1Ey+lyVT7Dm
        P0F/W31/dTMa8U+3WlAzoGoeQTWPIBtAGoGYL9Eo85UaltHIlZqSonwmV6VsBpH/aetdbOkA
        tcF5xg0QErgBTaIScSx7yJUnis2Tn3yHV6uOqksKeY0bpEfuvojGx+WqIg9YpD3KZiSns2kZ
        0uR0aUaq5KnY3cV6uYjKl2v54zxfzKv/n0PImHgdko9X9bGqucx9B84qnwmIRo+Mb7HkyJJe
        /fq9vX4FDd7wD+4kNrU6/fsarm+uCDFpi7eC9TOO0dLHSnM6q7S/rp+9nrrS8bSm3l11Ijvu
        slFxjDEk5az/zXo34QaB7q9D0x7mD7yYJZ6rD7GGc2U/LVzyzv+168ipQEd5+7Ne08Ir/IfC
        7/RbvVNvllGV6ubX7160eZOme0Y+3WVl70zoJU2zfUsFtYco0/K647rbXY/rhfWV6MSFqT0n
        18l2fLFzjBwLjohdAz37k+Mattipl+euqTMf9F/JaX/+94OnQp4Ez6wxt9rtPN/YdGm8oPyt
        PXv/rB8P1onLDw8ljQipjzaKJZhGIWcTUbVG/i/j4pEQyAMAAA==
X-CMS-MailID: 20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc@eucas1p2.samsung.com>
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

This is part of the effort to remove the sentinel (last empty) element
from the ctl_table arrays. We update to the new function and pass it the
array size. Care is taken to mirror the NULL assignments with a size of
zero (for the unprivileged users). An additional size function was added
to the following files in order to calculate the size of an array that
is defined in another file:
    include/net/ipv6.h
    net/ipv6/icmp.c
    net/ipv6/route.c
    net/ipv6/sysctl_net_ipv6.c

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/net/ipv6.h                  |  2 +
 net/core/neighbour.c                |  8 +++-
 net/core/sysctl_net_core.c          |  3 +-
 net/ieee802154/6lowpan/reassembly.c |  8 +++-
 net/ipv4/devinet.c                  |  3 +-
 net/ipv4/ip_fragment.c              |  3 +-
 net/ipv4/route.c                    |  8 +++-
 net/ipv4/sysctl_net_ipv4.c          |  3 +-
 net/ipv4/xfrm4_policy.c             |  3 +-
 net/ipv6/addrconf.c                 |  3 +-
 net/ipv6/icmp.c                     |  5 ++
 net/ipv6/reassembly.c               |  3 +-
 net/ipv6/route.c                    | 13 ++++--
 net/ipv6/sysctl_net_ipv6.c          | 16 +++++--
 net/ipv6/xfrm6_policy.c             |  3 +-
 net/mpls/af_mpls.c                  | 72 +++++++++++++++--------------
 net/mptcp/ctrl.c                    |  3 +-
 net/rds/tcp.c                       |  3 +-
 net/sctp/sysctl.c                   |  4 +-
 net/smc/smc_sysctl.c                |  3 +-
 net/unix/sysctl_net_unix.c          |  3 +-
 net/xfrm/xfrm_sysctl.c              |  8 +++-
 22 files changed, 116 insertions(+), 64 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7332296eca44..63ba68536a20 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1274,7 +1274,9 @@ static inline int snmp6_unregister_dev(struct inet6_dev *idev) { return 0; }
 
 #ifdef CONFIG_SYSCTL
 struct ctl_table *ipv6_icmp_sysctl_init(struct net *net);
+size_t ipv6_icmp_sysctl_table_size(void);
 struct ctl_table *ipv6_route_sysctl_init(struct net *net);
+size_t ipv6_route_sysctl_table_size(struct net *net);
 int ipv6_sysctl_register(void);
 void ipv6_sysctl_unregister(void);
 #endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ddd0f32de20e..adc7fc4ff9bf 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3779,6 +3779,7 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 	const char *dev_name_source;
 	char neigh_path[ sizeof("net//neigh/") + IFNAMSIZ + IFNAMSIZ ];
 	char *p_name;
+	size_t neigh_vars_size;
 
 	t = kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCOUNT);
 	if (!t)
@@ -3790,11 +3791,13 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 		t->neigh_vars[i].extra2 = p;
 	}
 
+	neigh_vars_size = ARRAY_SIZE(t->neigh_vars);
 	if (dev) {
 		dev_name_source = dev->name;
 		/* Terminate the table early */
 		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
 		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
+		neigh_vars_size = NEIGH_VAR_BASE_REACHABLE_TIME_MS;
 	} else {
 		struct neigh_table *tbl = p->tbl;
 		dev_name_source = "default";
@@ -3841,8 +3844,9 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 
 	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
 		p_name, dev_name_source);
-	t->sysctl_header =
-		register_net_sysctl(neigh_parms_net(p), neigh_path, t->neigh_vars);
+	t->sysctl_header = register_net_sysctl_sz(neigh_parms_net(p),
+						  neigh_path, t->neigh_vars,
+						  neigh_vars_size);
 	if (!t->sysctl_header)
 		goto free;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 782273bb93c2..03f1edb948d7 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -712,7 +712,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
 			tmp->data += (char *)net - (char *)&init_net;
 	}
 
-	net->core.sysctl_hdr = register_net_sysctl(net, "net/core", tbl);
+	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl,
+						      ARRAY_SIZE(netns_core_table));
 	if (net->core.sysctl_hdr == NULL)
 		goto err_reg;
 
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index a91283d1e5bf..6dd960ec558c 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -360,6 +360,7 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 	struct ctl_table_header *hdr;
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
+	size_t table_size = ARRAY_SIZE(lowpan_frags_ns_ctl_table);
 
 	table = lowpan_frags_ns_ctl_table;
 	if (!net_eq(net, &init_net)) {
@@ -369,8 +370,10 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 			goto err_alloc;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			table[0].procname = NULL;
+			table_size = 0;
+		}
 	}
 
 	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
@@ -379,7 +382,8 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 	table[1].extra2	= &ieee802154_lowpan->fqdir->high_thresh;
 	table[2].data	= &ieee802154_lowpan->fqdir->timeout;
 
-	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
+	hdr = register_net_sysctl_sz(net, "net/ieee802154/6lowpan", table,
+				     table_size);
 	if (hdr == NULL)
 		goto err_reg;
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5deac0517ef7..89087844ea6e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2720,7 +2720,8 @@ static __net_init int devinet_init_net(struct net *net)
 		goto err_reg_dflt;
 
 	err = -ENOMEM;
-	forw_hdr = register_net_sysctl(net, "net/ipv4", tbl);
+	forw_hdr = register_net_sysctl_sz(net, "net/ipv4", tbl,
+					  ARRAY_SIZE(ctl_forward_entry));
 	if (!forw_hdr)
 		goto err_reg_ctl;
 	net->ipv4.forw_hdr = forw_hdr;
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 69c00ffdcf3e..a4941f53b523 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -615,7 +615,8 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
 	table[2].data	= &net->ipv4.fqdir->timeout;
 	table[3].data	= &net->ipv4.fqdir->max_dist;
 
-	hdr = register_net_sysctl(net, "net/ipv4", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
+				     ARRAY_SIZE(ip4_frags_ns_ctl_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 98d7e6ba7493..e7e9fba0357a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3592,6 +3592,7 @@ static struct ctl_table ipv4_route_netns_table[] = {
 static __net_init int sysctl_route_net_init(struct net *net)
 {
 	struct ctl_table *tbl;
+	size_t table_size = ARRAY_SIZE(ipv4_route_netns_table);
 
 	tbl = ipv4_route_netns_table;
 	if (!net_eq(net, &init_net)) {
@@ -3603,8 +3604,10 @@ static __net_init int sysctl_route_net_init(struct net *net)
 
 		/* Don't export non-whitelisted sysctls to unprivileged users */
 		if (net->user_ns != &init_user_ns) {
-			if (tbl[0].procname != ipv4_route_flush_procname)
+			if (tbl[0].procname != ipv4_route_flush_procname) {
 				tbl[0].procname = NULL;
+				table_size = 0;
+			}
 		}
 
 		/* Update the variables to point into the current struct net
@@ -3615,7 +3618,8 @@ static __net_init int sysctl_route_net_init(struct net *net)
 	}
 	tbl[0].extra1 = net;
 
-	net->ipv4.route_hdr = register_net_sysctl(net, "net/ipv4/route", tbl);
+	net->ipv4.route_hdr = register_net_sysctl_sz(net, "net/ipv4/route",
+						     tbl, table_size);
 	if (!net->ipv4.route_hdr)
 		goto err_reg;
 	return 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 2afb0870648b..6ac890b4073f 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1519,7 +1519,8 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 		}
 	}
 
-	net->ipv4.ipv4_hdr = register_net_sysctl(net, "net/ipv4", table);
+	net->ipv4.ipv4_hdr = register_net_sysctl_sz(net, "net/ipv4", table,
+						    ARRAY_SIZE(ipv4_net_table));
 	if (!net->ipv4.ipv4_hdr)
 		goto err_reg;
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 9403bbaf1b61..57ea394ffa8c 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -178,7 +178,8 @@ static __net_init int xfrm4_net_sysctl_init(struct net *net)
 		table[0].data = &net->xfrm.xfrm4_dst_ops.gc_thresh;
 	}
 
-	hdr = register_net_sysctl(net, "net/ipv4", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
+				     ARRAY_SIZE(xfrm4_policy_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e5213e598a04..d615a84965c2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7085,7 +7085,8 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 
 	snprintf(path, sizeof(path), "net/ipv6/conf/%s", dev_name);
 
-	p->sysctl_header = register_net_sysctl(net, path, table);
+	p->sysctl_header = register_net_sysctl_sz(net, path, table,
+						  ARRAY_SIZE(addrconf_sysctl));
 	if (!p->sysctl_header)
 		goto free;
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 65fa5014bc85..a76b01b41b57 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1229,4 +1229,9 @@ struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
 	}
 	return table;
 }
+
+size_t ipv6_icmp_sysctl_table_size(void)
+{
+	return ARRAY_SIZE(ipv6_icmp_table_template);
+}
 #endif
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 5bc8a28e67f9..5ebc47da1000 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -470,7 +470,8 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
 	table[1].extra2	= &net->ipv6.fqdir->high_thresh;
 	table[2].data	= &net->ipv6.fqdir->timeout;
 
-	hdr = register_net_sysctl(net, "net/ipv6", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
+				     ARRAY_SIZE(ip6_frags_ns_ctl_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..51c6cdae8723 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6447,14 +6447,19 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
 		table[8].data = &net->ipv6.sysctl.ip6_rt_min_advmss;
 		table[9].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
 		table[10].data = &net->ipv6.sysctl.skip_notify_on_dev_down;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			table[1].procname = NULL;
 	}
 
 	return table;
 }
+
+size_t ipv6_route_sysctl_table_size(struct net *net)
+{
+	/* Don't export sysctls to unprivileged users */
+	if (net->user_ns != &init_user_ns)
+		return 0;
+
+	return ARRAY_SIZE(ipv6_route_table_template);
+}
 #endif
 
 static int __net_init ip6_route_net_init(struct net *net)
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 94a0a294c6a1..888676163e90 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -275,17 +275,23 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 	if (!ipv6_icmp_table)
 		goto out_ipv6_route_table;
 
-	net->ipv6.sysctl.hdr = register_net_sysctl(net, "net/ipv6", ipv6_table);
+	net->ipv6.sysctl.hdr = register_net_sysctl_sz(net, "net/ipv6",
+						      ipv6_table,
+						      ARRAY_SIZE(ipv6_table_template));
 	if (!net->ipv6.sysctl.hdr)
 		goto out_ipv6_icmp_table;
 
-	net->ipv6.sysctl.route_hdr =
-		register_net_sysctl(net, "net/ipv6/route", ipv6_route_table);
+	net->ipv6.sysctl.route_hdr = register_net_sysctl_sz(net,
+							    "net/ipv6/route",
+							    ipv6_route_table,
+							    ipv6_route_sysctl_table_size(net));
 	if (!net->ipv6.sysctl.route_hdr)
 		goto out_unregister_ipv6_table;
 
-	net->ipv6.sysctl.icmp_hdr =
-		register_net_sysctl(net, "net/ipv6/icmp", ipv6_icmp_table);
+	net->ipv6.sysctl.icmp_hdr = register_net_sysctl_sz(net,
+							   "net/ipv6/icmp",
+							   ipv6_icmp_table,
+							   ipv6_icmp_sysctl_table_size());
 	if (!net->ipv6.sysctl.icmp_hdr)
 		goto out_unregister_route_table;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index eecc5e59da17..8f931e46b460 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -205,7 +205,8 @@ static int __net_init xfrm6_net_sysctl_init(struct net *net)
 		table[0].data = &net->xfrm.xfrm6_dst_ops.gc_thresh;
 	}
 
-	hdr = register_net_sysctl(net, "net/ipv6", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
+				     ARRAY_SIZE(xfrm6_policy_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index bf6e81d56263..5bad14b3c71e 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1396,6 +1396,40 @@ static const struct ctl_table mpls_dev_table[] = {
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
@@ -1419,7 +1453,8 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 
 	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
 
-	mdev->sysctl = register_net_sysctl(net, path, table);
+	mdev->sysctl = register_net_sysctl_sz(net, path, table,
+					      ARRAY_SIZE(mpls_dev_table));
 	if (!mdev->sysctl)
 		goto free;
 
@@ -2637,38 +2672,6 @@ static int mpls_platform_labels(struct ctl_table *table, int write,
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
@@ -2689,7 +2692,8 @@ static int mpls_net_init(struct net *net)
 	for (i = 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
 		table[i].data = (char *)net + (uintptr_t)table[i].data;
 
-	net->mpls.ctl = register_net_sysctl(net, "net/mpls", table);
+	net->mpls.ctl = register_net_sysctl_sz(net, "net/mpls", table,
+					       ARRAY_SIZE(mpls_table));
 	if (net->mpls.ctl == NULL) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..43e540328a52 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -150,7 +150,8 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 
-	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
+	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
+				     ARRAY_SIZE(mptcp_sysctl_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index c5b86066ff66..2dba7505b414 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -565,7 +565,8 @@ static __net_init int rds_tcp_init_net(struct net *net)
 	}
 	tbl[RDS_TCP_SNDBUF].data = &rtn->sndbuf_size;
 	tbl[RDS_TCP_RCVBUF].data = &rtn->rcvbuf_size;
-	rtn->rds_tcp_sysctl = register_net_sysctl(net, "net/rds/tcp", tbl);
+	rtn->rds_tcp_sysctl = register_net_sysctl_sz(net, "net/rds/tcp", tbl,
+						     ARRAY_SIZE(rds_tcp_sysctl_table));
 	if (!rtn->rds_tcp_sysctl) {
 		pr_warn("could not register sysctl\n");
 		err = -ENOMEM;
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index a7a9136198fd..f65d6f92afcb 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -612,7 +612,9 @@ int sctp_sysctl_net_register(struct net *net)
 	table[SCTP_PF_RETRANS_IDX].extra2 = &net->sctp.ps_retrans;
 	table[SCTP_PS_RETRANS_IDX].extra1 = &net->sctp.pf_retrans;
 
-	net->sctp.sysctl_header = register_net_sysctl(net, "net/sctp", table);
+	net->sctp.sysctl_header = register_net_sysctl_sz(net, "net/sctp",
+							 table,
+							 ARRAY_SIZE(sctp_net_table));
 	if (net->sctp.sysctl_header == NULL) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index b6f79fabb9d3..3ab2d8eefc55 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -81,7 +81,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
 			table[i].data += (void *)net - (void *)&init_net;
 	}
 
-	net->smc.smc_hdr = register_net_sysctl(net, "net/smc", table);
+	net->smc.smc_hdr = register_net_sysctl_sz(net, "net/smc", table,
+						  ARRAY_SIZE(smc_table));
 	if (!net->smc.smc_hdr)
 		goto err_reg;
 
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 500129aa710c..3e84b31c355a 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -36,7 +36,8 @@ int __net_init unix_sysctl_register(struct net *net)
 		table[0].data = &net->unx.sysctl_max_dgram_qlen;
 	}
 
-	net->unx.ctl = register_net_sysctl(net, "net/unix", table);
+	net->unx.ctl = register_net_sysctl_sz(net, "net/unix", table,
+					      ARRAY_SIZE(unix_table));
 	if (net->unx.ctl == NULL)
 		goto err_reg;
 
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 0c6c5ef65f9d..7fdeafc838a7 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -44,6 +44,7 @@ static struct ctl_table xfrm_table[] = {
 int __net_init xfrm_sysctl_init(struct net *net)
 {
 	struct ctl_table *table;
+	size_t table_size = ARRAY_SIZE(xfrm_table);
 
 	__xfrm_sysctl_init(net);
 
@@ -56,10 +57,13 @@ int __net_init xfrm_sysctl_init(struct net *net)
 	table[3].data = &net->xfrm.sysctl_acq_expires;
 
 	/* Don't export sysctls to unprivileged users */
-	if (net->user_ns != &init_user_ns)
+	if (net->user_ns != &init_user_ns) {
 		table[0].procname = NULL;
+		table_size = 0;
+	}
 
-	net->xfrm.sysctl_hdr = register_net_sysctl(net, "net/core", table);
+	net->xfrm.sysctl_hdr = register_net_sysctl_sz(net, "net/core", table,
+						      table_size);
 	if (!net->xfrm.sysctl_hdr)
 		goto out_register;
 	return 0;
-- 
2.30.2

