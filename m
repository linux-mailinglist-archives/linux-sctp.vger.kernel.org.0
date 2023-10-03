Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B1E7B6F6B
	for <lists+linux-sctp@lfdr.de>; Tue,  3 Oct 2023 19:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjJCRSC (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 3 Oct 2023 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRSC (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 3 Oct 2023 13:18:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A519B;
        Tue,  3 Oct 2023 10:17:58 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d81d09d883dso1331538276.0;
        Tue, 03 Oct 2023 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696353478; x=1696958278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb5FncLmK/6xLgSJbWEt2S1RaiVztE4ZnTVks9Ca9QY=;
        b=VCz8umS73mwdmXHYjaVfZJfBpacu9miPCT5mYZnCdoYwwse29sLYyKt6ht0r5ZJPpK
         P/mjdmMllft9/arc7ACwsKQCCv7dzjhlGaJAGrMf+nDWr7CbXm6AhQmZYWz2KCThj99v
         PJY8aNp5PmZ3kgOuV1ii/t+oigk84oqtTFPi/aad8QI5R8Fxh25jMR4HUQCSf2tW/pRb
         1bey5BeYlkq4wCKkxxB7CW3ico6uDg9YuR279Zfy4kfqTe6yrMUcZynb5iAlguXNtQEB
         75/RpYE2zN8sQvk980sxlnKeGEaMKlHLJ92j+Cga8OHbOekG7UHNUAZD5kS1rrc+q9Kd
         ix5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696353478; x=1696958278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb5FncLmK/6xLgSJbWEt2S1RaiVztE4ZnTVks9Ca9QY=;
        b=khNbAAL9XXFgXFzt5E+CNcjJ2pVCPsUch5sNCXGMgiR6yCFxHtmqhUh6hlSOtD4WQu
         sgqfObGpMfzEikd1P9hrJiZDEamFDSewUzHfHS6bAk0cI1IcQmQUHW4sHkq5NLYhHdRJ
         +B6yOm8YZc/BLlwCCwIV5vhzjm+LiDO1KepR7ElkQT+ft3t/5XvEduyTjQDNirniA3KZ
         lara6pBi+7t1mdycf8JTE7pXM6APL0pMZg46d4JmrxaH/s1SznIpIOHMRjfq4bN87qZs
         9sFRya4Wnz+xWXaBfwtna0hAg2MN1eHii5RH68P+eEDxsfxhK5uFj1qBTs2RTYmQVAxa
         aTzA==
X-Gm-Message-State: AOJu0YzPoVUfD6jv5wEWC9qPCHs0f/znmQY26ujY6Rvq5oQgATDIf97t
        7oRevoEl97P9fCiHhoYIgkV6Urkh/lYqvg==
X-Google-Smtp-Source: AGHT+IGb6IrIGEaYnTV0e9D5+qFj79TKELflWVOuhOvvwQR9OvAewlBwt+CZyiyJpP0E4Urhs9ox+g==
X-Received: by 2002:a25:8702:0:b0:d89:469a:536d with SMTP id a2-20020a258702000000b00d89469a536dmr13330721ybl.47.1696353477720;
        Tue, 03 Oct 2023 10:17:57 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h1-20020a0cf401000000b0065d0dcc28e3sm633041qvl.73.2023.10.03.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 10:17:57 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Simon Horman <horms@kernel.org>
Subject: [PATCHv2 nf 1/2] netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
Date:   Tue,  3 Oct 2023 13:17:53 -0400
Message-Id: <73f4a01458ecac38616447e66a79fe5ef989400c.1696353375.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1696353375.git.lucien.xin@gmail.com>
References: <cover.1696353375.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

In Scenario A and B below, as the delayed INIT_ACK always changes the peer
vtag, SCTP ct with the incorrect vtag may cause packet loss.

Scenario A: INIT_ACK is delayed until the peer receives its own INIT_ACK

  192.168.1.2 > 192.168.1.1: [INIT] [init tag: 1328086772]
    192.168.1.1 > 192.168.1.2: [INIT] [init tag: 1414468151]
    192.168.1.2 > 192.168.1.1: [INIT ACK] [init tag: 1328086772]
  192.168.1.1 > 192.168.1.2: [INIT ACK] [init tag: 1650211246] *
  192.168.1.2 > 192.168.1.1: [COOKIE ECHO]
    192.168.1.1 > 192.168.1.2: [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: [COOKIE ACK]

Scenario B: INIT_ACK is delayed until the peer completes its own handshake

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
    192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *

This patch fixes it as below:

In SCTP_CID_INIT processing:
- clear ct->proto.sctp.init[!dir] if ct->proto.sctp.init[dir] &&
  ct->proto.sctp.init[!dir]. (Scenario E)
- set ct->proto.sctp.init[dir].

In SCTP_CID_INIT_ACK processing:
- drop it if !ct->proto.sctp.init[!dir] && ct->proto.sctp.vtag[!dir] &&
  ct->proto.sctp.vtag[!dir] != ih->init_tag. (Scenario B, Scenario C)
- drop it if ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
  ct->proto.sctp.vtag[!dir] != ih->init_tag. (Scenario A)

In SCTP_CID_COOKIE_ACK processing:
- clear ct->proto.sctp.init[dir] and ct->proto.sctp.init[!dir].
  (Scenario D)

Also, it's important to allow the ct state to move forward with cookie_echo
and cookie_ack from the opposite dir for the collision scenarios.

There are also other Scenarios where it should allow the packet through,
addressed by the processing above:

Scenario C: new CT is created by INIT_ACK.

Scenario D: start INIT on the existing ESTABLISHED ct.

Scenario E: start INIT after the old collision on the existing ESTABLISHED
ct.

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
  (both side are stopped, then start new connection again in hours)
  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 242308742]

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2:
- use __be32 for vtag variable to make Sparse unhappy, as Simon noticed.
- add Fixes tag, as Simon suggested.
- replace "ih == NULL" with "!ih", as checkpatch.pl suggested.
---
 include/linux/netfilter/nf_conntrack_sctp.h |  1 +
 net/netfilter/nf_conntrack_proto_sctp.c     | 43 ++++++++++++++++-----
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/linux/netfilter/nf_conntrack_sctp.h b/include/linux/netfilter/nf_conntrack_sctp.h
index 625f491b95de..fb31312825ae 100644
--- a/include/linux/netfilter/nf_conntrack_sctp.h
+++ b/include/linux/netfilter/nf_conntrack_sctp.h
@@ -9,6 +9,7 @@ struct ip_ct_sctp {
 	enum sctp_conntrack state;
 
 	__be32 vtag[IP_CT_DIR_MAX];
+	u8 init[IP_CT_DIR_MAX];
 	u8 last_dir;
 	u8 flags;
 };
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index b6bcc8f2f46b..c6bd533983c1 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -112,7 +112,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 /* shutdown_ack */ {sSA, sCL, sCW, sCE, sES, sSA, sSA, sSA, sSA},
 /* error        */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can't have Stale cookie*/
 /* cookie_echo  */ {sCL, sCL, sCE, sCE, sES, sSS, sSR, sSA, sCL},/* 5.2.4 - Big TODO */
-/* cookie_ack   */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can't come in orig dir */
+/* cookie_ack   */ {sCL, sCL, sCW, sES, sES, sSS, sSR, sSA, sCL},/* Can't come in orig dir */
 /* shutdown_comp*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sCL, sCL},
 /* heartbeat    */ {sHS, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
 /* heartbeat_ack*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
@@ -126,7 +126,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK_MAX] = {
 /* shutdown     */ {sIV, sCL, sCW, sCE, sSR, sSS, sSR, sSA, sIV},
 /* shutdown_ack */ {sIV, sCL, sCW, sCE, sES, sSA, sSA, sSA, sIV},
 /* error        */ {sIV, sCL, sCW, sCL, sES, sSS, sSR, sSA, sIV},
-/* cookie_echo  */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV},/* Can't come in reply dir */
+/* cookie_echo  */ {sIV, sCL, sCE, sCE, sES, sSS, sSR, sSA, sIV},/* Can't come in reply dir */
 /* cookie_ack   */ {sIV, sCL, sCW, sES, sES, sSS, sSR, sSA, sIV},
 /* shutdown_comp*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sCL, sIV},
 /* heartbeat    */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
@@ -412,6 +412,9 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			/* (D) vtag must be same as init_vtag as found in INIT_ACK */
 			if (sh->vtag != ct->proto.sctp.vtag[dir])
 				goto out_unlock;
+		} else if (sch->type == SCTP_CID_COOKIE_ACK) {
+			ct->proto.sctp.init[dir] = 0;
+			ct->proto.sctp.init[!dir] = 0;
 		} else if (sch->type == SCTP_CID_HEARTBEAT) {
 			if (ct->proto.sctp.vtag[dir] == 0) {
 				pr_debug("Setting %d vtag %x for dir %d\n", sch->type, sh->vtag, dir);
@@ -461,16 +464,18 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 		}
 
 		/* If it is an INIT or an INIT ACK note down the vtag */
-		if (sch->type == SCTP_CID_INIT ||
-		    sch->type == SCTP_CID_INIT_ACK) {
-			struct sctp_inithdr _inithdr, *ih;
+		if (sch->type == SCTP_CID_INIT) {
+			struct sctp_inithdr _ih, *ih;
 
-			ih = skb_header_pointer(skb, offset + sizeof(_sch),
-						sizeof(_inithdr), &_inithdr);
-			if (ih == NULL)
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
+			if (!ih)
 				goto out_unlock;
-			pr_debug("Setting vtag %x for dir %d\n",
-				 ih->init_tag, !dir);
+
+			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
+				ct->proto.sctp.init[!dir] = 0;
+			ct->proto.sctp.init[dir] = 1;
+
+			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
 			ct->proto.sctp.vtag[!dir] = ih->init_tag;
 
 			/* don't renew timeout on init retransmit so
@@ -481,6 +486,24 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			    old_state == SCTP_CONNTRACK_CLOSED &&
 			    nf_ct_is_confirmed(ct))
 				ignore = true;
+		} else if (sch->type == SCTP_CID_INIT_ACK) {
+			struct sctp_inithdr _ih, *ih;
+			__be32 vtag;
+
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
+			if (!ih)
+				goto out_unlock;
+
+			vtag = ct->proto.sctp.vtag[!dir];
+			if (!ct->proto.sctp.init[!dir] && vtag && vtag != ih->init_tag)
+				goto out_unlock;
+			/* collision */
+			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
+			    vtag != ih->init_tag)
+				goto out_unlock;
+
+			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
+			ct->proto.sctp.vtag[!dir] = ih->init_tag;
 		}
 
 		ct->proto.sctp.state = new_state;
-- 
2.39.1

