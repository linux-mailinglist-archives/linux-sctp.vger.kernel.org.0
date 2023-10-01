Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11ABB7B484C
	for <lists+linux-sctp@lfdr.de>; Sun,  1 Oct 2023 17:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjJAPHz (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 1 Oct 2023 11:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjJAPHy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 1 Oct 2023 11:07:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93570D9;
        Sun,  1 Oct 2023 08:07:51 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4197bb0a0d9so16751441cf.3;
        Sun, 01 Oct 2023 08:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696172870; x=1696777670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uUcV+Z9d+ZbN189XwOZEn5wIKxAIgH34VNcGHPGRlFI=;
        b=dx6pheS6I84feKP9kd9bGRi+MufB4OhUSmympxyi7CYNnG+zc+U/gfZtT/wPAbdPWi
         Q9oNW6kp8qKsDftJIBRjZsP/av7LD8Ot7DFVpbT9L92sf2md4z6KDVPYYmIC98VFSpFW
         vnkKZ5ijKHyEM3LaZrD0Vzk5p6zAnkla1YulEnEQupNYHzEVHzC1pJm6o8pYXau+3vKc
         DGEyqXwbRc6eJ5ZxGEmMViGtv48+sEmr10Idh5TYmYs6ztNmFd2cHufnfP/p7ZaX2lZ7
         P9bbwXqcSPkPOPsxEhEvROjQWuYunhfS3oHWvBkTF4T7fUU7ZhHqz+5nt9UCp7P/tLKw
         N55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696172870; x=1696777670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uUcV+Z9d+ZbN189XwOZEn5wIKxAIgH34VNcGHPGRlFI=;
        b=DclKkXwGmbXJIyWV2v4Ws+VKR7rdFiZ+0kMsmzAT8zmzoXALzJbTYfN6GqpGpjWW2w
         K5c2eMtrb7H2L5Tp2IJ0SHkbfy/kXJJ5B0OynhkoSVIIBo41wk4Tsf/g4dH4AVStVdZy
         SSwrcBjLLS/hFj62smrqLoIG5aLrsH4q1rLqOBgtUY1HLokCxVsYrHUh+OvPKUsL18Hn
         +V3ehQymjzBHDAJ4iW8YR2BTboATwPoArktotABUWWosuaqNooK3EEl88/IKsm/3AU/x
         Mn6ZtQoI4yI7V32GAaaVupvtQmyMlZfIkgwu8WkKRQuFAOu9Ig08l1NMgifs85KtdDLa
         YGFQ==
X-Gm-Message-State: AOJu0YxvgzE75BoDMQhniioYXnRgTWzLgYxK7hupflAR3mOU8Q479Y7D
        km4J5pwwfz6P8oCggyqdvvke8mSh5hZX5A==
X-Google-Smtp-Source: AGHT+IGuhEsxgWFjtArRcyX04Q3eCD+hFfxJv09vftqdRE+XjdoUqH4x+ybNbgVRF6zU/iK+MCU0Mw==
X-Received: by 2002:a05:622a:1047:b0:417:9e48:44d7 with SMTP id f7-20020a05622a104700b004179e4844d7mr11351168qte.1.1696172870159;
        Sun, 01 Oct 2023 08:07:50 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id jv24-20020a05622aa09800b00417d56d432asm8074938qtb.40.2023.10.01.08.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 08:07:49 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH nf] netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
Date:   Sun,  1 Oct 2023 11:07:48 -0400
Message-Id: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
- clear ct->proto.sctp.init[dir] and ct->proto.sctp.init[!dir]. (Scenario D)

Also, it's important to allow the ct state to move forward with cookie_echo
and cookie_ack from the opposite dir for the collision scenarios.

There are also other Scenarios where it should allow the packet through,
addressed by the processing above:

Scenario C: new CT is created by INIT_ACK.

Scenario D: start INIT on the existing ESTABLISHED ct.

Scenario E: start INIT after the old collision on the existing ESTABLISHED ct.

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
  (both side are stopped, then start new connection again in hours)
  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 242308742]

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/linux/netfilter/nf_conntrack_sctp.h |  1 +
 net/netfilter/nf_conntrack_proto_sctp.c     | 41 ++++++++++++++++-----
 2 files changed, 33 insertions(+), 9 deletions(-)

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
index b6bcc8f2f46b..91aee286d503 100644
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
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
 			if (ih == NULL)
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
+			u32 vtag;
+
+			ih = skb_header_pointer(skb, offset + sizeof(_sch), sizeof(*ih), &_ih);
+			if (ih == NULL)
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

