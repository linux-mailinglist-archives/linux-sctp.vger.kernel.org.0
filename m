Return-Path: <linux-sctp+bounces-732-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 779AFC29DF2
	for <lists+linux-sctp@lfdr.de>; Mon, 03 Nov 2025 03:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23491886B02
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Nov 2025 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0782285C8D;
	Mon,  3 Nov 2025 02:37:57 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF614B953;
	Mon,  3 Nov 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762137477; cv=none; b=d4n02TiufXR0oewzJZ8XsLvwq4uhPhU8tE+h8f23L4CMKVxOW0fsVwxMPrB23m/AI0M6JrQtEtgWuHb6ry6MQ4Yuc0jh3Exnm8nDQ5TpXW8jnTS906boZLU8AIeIoBuwFuclt9wHHoM+KykoCHHjllS3P27L6t4razpzE9dXoSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762137477; c=relaxed/simple;
	bh=ukUqwcz+sBycHhzxiy3W2SxXQ9SQb3q3ms/hTRSiMeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZOdxAbP6yoC5QAILvxIDwXDrgZIR2XFNkUz7yIVyzDrDqNw9vmxrFfYDl/fMqGplNjTvPi9bZzpkwKp4GNdtjlh9RIxFLtyl5m9JGQgc+xVwyPj5amrm8FzT1MFT697OIOPIgPAaAJVR6jE2c3BwzbZqBiMhERdeTbLruPuNiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0f923836b85e11f0a38c85956e01ac42-20251103
X-CTIC-Tags:
	HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:70b6d226-dd85-46cd-9c65-14e7c3b71550,IP:15,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-20
X-CID-INFO: VERSION:1.3.6,REQID:70b6d226-dd85-46cd-9c65-14e7c3b71550,IP:15,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-30,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-20
X-CID-META: VersionHash:a9d874c,CLOUDID:e02db1f34bb1bcb1bddb34349392fd38,BulkI
	D:2511031037396H4RK8JP,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|850,TC:
	nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0f923836b85e11f0a38c85956e01ac42-20251103
X-User: hehuiwen@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <hehuiwen@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1359740398; Mon, 03 Nov 2025 10:37:37 +0800
From: Huiwen He <hehuiwen@kylinos.cn>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Cc: Huiwen He <hehuiwen@kylinos.cn>
Subject: [PATCH v2] sctp: make sctp_transport_init() void
Date: Mon,  3 Nov 2025 10:36:19 +0800
Message-Id: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
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
Changes in v2:
- Remove the 'fail' label and its path as suggested by Xin Long.
- Link to v1: https://lore.kernel.org/all/20251101163656.585550-1-hehuiwen@kylinos.cn

 net/sctp/transport.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 4d258a6e8033..0d48c61fe6ad 100644
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
@@ -96,20 +94,13 @@ struct sctp_transport *sctp_transport_new(struct net *net,
 
 	transport = kzalloc(sizeof(*transport), gfp);
 	if (!transport)
-		goto fail;
+		return NULL;
 
-	if (!sctp_transport_init(net, transport, addr, gfp))
-		goto fail_init;
+	sctp_transport_init(net, transport, addr, gfp);
 
 	SCTP_DBG_OBJCNT_INC(transport);
 
 	return transport;
-
-fail_init:
-	kfree(transport);
-
-fail:
-	return NULL;
 }
 
 /* This transport is no longer needed.  Free up if possible, or
-- 
2.25.1


