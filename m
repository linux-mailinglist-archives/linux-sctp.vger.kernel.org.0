Return-Path: <linux-sctp+bounces-730-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EFEC2830C
	for <lists+linux-sctp@lfdr.de>; Sat, 01 Nov 2025 17:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CE99189A556
	for <lists+linux-sctp@lfdr.de>; Sat,  1 Nov 2025 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012B26561E;
	Sat,  1 Nov 2025 16:37:22 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E885A34D3A7;
	Sat,  1 Nov 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015042; cv=none; b=jMVwiLhfm3jMvWxaCZuKlLv6G3WzzI5CpsTV3n7aGwMmsM1J/I997zKFhtAyozgMszZ7GGMxYk59zcjPaTz8Vit9Q98i7Rk4oNPt4BrpbJBoAXzgmbO7HJ4TCetzFF37CMOQzQ9T7cXMDRmc9c3RJnv+Kc1GidGWmUX0VhlTtC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015042; c=relaxed/simple;
	bh=B+ip0vUVqEsJmoaAWpIRIaah/ynRxJ2G5jP6uXOcx1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aOlWiJNCEIDk0YhUOlPONEb0yonIiTT5gm03Q+saiTtNcOwS+h+uKzvwLsiNB0G6S4gaqFPrYPZuix9k3wFKIHXWHtDiK0/Nhdu3LgvyaisNLfqWbKRvNe5MgkcR2LgKkRWvFKSHmUZIPWkDcgaR3ltQ/F2/pBCdUxjevEc11Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: fe40d808b74011f0a38c85956e01ac42-20251102
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD_SPF, CIE_UNKNOWN, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:48c632b1-43e4-4524-afb9-81608eb814f5,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-20
X-CID-INFO: VERSION:1.3.6,REQID:48c632b1-43e4-4524-afb9-81608eb814f5,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:80434152ae953d646c7bde4402a63861,BulkI
	D:251102003116LS0FDXU4,BulkQuantity:2,Recheck:0,SF:10|66|78|102|850,TC:nil
	,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: fe40d808b74011f0a38c85956e01ac42-20251102
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(120.228.9.121)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1751878440; Sun, 02 Nov 2025 00:37:01 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH] sctp: make sctp_transport_init() void
Date: Sun,  2 Nov 2025 00:36:56 +0800
Message-Id: <20251101163656.585550-1-hehuiwen@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sctp_transport_init() is static and never returns NULL. It is only
called by sctp_transport_new(), so change it to void and remove the
redundant return value check.

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
---
 net/sctp/transport.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 4d258a6e8033..97da92390aa7 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -37,10 +37,10 @@
 /* 1st Level Abstractions.  */
 
 /* Initialize a new transport from provided memory.  */
-static struct sctp_transport *sctp_transport_init(struct net *net,
-						  struct sctp_transport *peer,
-						  const union sctp_addr *addr,
-						  gfp_t gfp)
+static void sctp_transport_init(struct net *net,
+				struct sctp_transport *peer,
+				const union sctp_addr *addr,
+				gfp_t gfp)
 {
 	/* Copy in the address.  */
 	peer->af_specific = sctp_get_af_specific(addr->sa.sa_family);
@@ -83,8 +83,6 @@ static struct sctp_transport *sctp_transport_init(struct net *net,
 	get_random_bytes(&peer->hb_nonce, sizeof(peer->hb_nonce));
 
 	refcount_set(&peer->refcnt, 1);
-
-	return peer;
 }
 
 /* Allocate and initialize a new transport.  */
@@ -98,16 +96,12 @@ struct sctp_transport *sctp_transport_new(struct net *net,
 	if (!transport)
 		goto fail;
 
-	if (!sctp_transport_init(net, transport, addr, gfp))
-		goto fail_init;
+	sctp_transport_init(net, transport, addr, gfp);
 
 	SCTP_DBG_OBJCNT_INC(transport);
 
 	return transport;
 
-fail_init:
-	kfree(transport);
-
 fail:
 	return NULL;
 }
-- 
2.25.1


