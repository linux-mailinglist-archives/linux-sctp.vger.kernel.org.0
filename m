Return-Path: <linux-sctp+bounces-642-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3233BF6A3F
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 15:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6869134F808
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 13:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83091337B97;
	Tue, 21 Oct 2025 13:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWNjZXq8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFEB337B99
	for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 13:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051716; cv=none; b=BAKS3a1OPp92+3K+umQmdQorV7axyX+SvfE/ILysjEujPHvaIu9106NOo7734za1NSNWVnNc2QgraJvRfj0X+CAmNXpGf0DybdWAKoSeOgR4u8DL+cwX/uxLQzQ+8cWPNzNdBU1sU/kkP5RNXaw//hK4S1WhRG3pXishuz8naUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051716; c=relaxed/simple;
	bh=/6e4Ptuqnezl7IG4EEoTOuL0lZT0IuoppTJCNRC7C4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aDiEOKtjikNcpmZ4E7iNc2pqbDXBRGTvRUlU3z0BEdmZxjhffBZF5hFdu5AePoXLVg+R7FoGwVNANjOgf689mycAvzLZDiB/XUNSOyaz7rj26Fv3S1nmcnyLzcXEqASkMFLoAF5rocnKicp1vXbjULPHBLKs74W79Xi4+j//gkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWNjZXq8; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-579363a4602so5611957e87.0
        for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 06:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761051712; x=1761656512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyY2Eyt9nzPKJbJW/4VOy5YSdTPy2ZRF5S/Kzk7Ode8=;
        b=kWNjZXq80o/qoZVI+9DD+JK1Oet5mMlhG9MQTquN/CWrh42hu7s5/uZQlXgMh1tznv
         0P+ObtgxnXWVARYezIInwqP0Zw2wOf1wnHux69aTuSVHZuiJHgf91wwnCLBAJN50gVPy
         FbyXgd2E8iZFwJleCe/C8r5pgnQE6XiCK5dA9vaAG3n54MvCJj5M2NcgyWCLAXb3Uw1a
         1ZPPel6rCtDKrMrpvyAfJNS1ZuFS5E4UIrMPyRNatK0dS0fNiVUrnAh6FiKD0j7buKtW
         /KDgltGDwivQNyKhGv7TEsbI/ccSMF84JagS2h/nOAh1aAv2otJqAMZajQHvLWFVZDDR
         3yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761051712; x=1761656512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyY2Eyt9nzPKJbJW/4VOy5YSdTPy2ZRF5S/Kzk7Ode8=;
        b=nLkpUGGMUqVdbdzskG1Swbt61ZgwPT+iuEcSnK2OCMT76DUtt+E3oFHNKPuq3YlqKH
         wkBJRQa3LefMiGR+xabAcwjc+tB+DiO+2POA6WaBa09/Z78vgKvefb+aeJiPvrRgm3Rs
         ksZ9LnHBFv3qjFR2blnGTaksbKbx0UJ/DP9K2cmWiuMFJvGEGHMlxYhQMBCYKlGP9oiP
         4RQlxT35eBYYfgzTwLcBQiGqlFwU1E4VHF3Ev2F2KnrYp8XipS8PSE7zJWFV/tStKUG0
         BHkLz4a99w/6I5x5E9dobSxUNjNsnYWEdPuLf30pMBxSWSX0bm17gIlUHu7nUW2EDDfJ
         zuNw==
X-Forwarded-Encrypted: i=1; AJvYcCWUAWbVlbZvL0kHCqzwegn1IklbfZgKQ+NNeStPsAXSGl6iZFNAukLgtUYbhCfaPFPWcjCBq4zYu8rx@vger.kernel.org
X-Gm-Message-State: AOJu0YwN87J8AGzXSPErmwdlFNNtlVCbvTDERKRYXlTEVwfBSEK+NnAM
	w4e1+7qEtqEI2DxNqYsrf96CCCI7s9eorMOM8RM5SDt2q7VdgbtXpD4V
X-Gm-Gg: ASbGncvZ+4qMktzW4PWj7f6NxoStOJYzNLzu61Yp/gQmo1VJOtXEEMclAn3cJh6HJph
	Dt4NYJg2uUwxV5y1ikOfkKckCN7vPx7HwWuc3Y3+2g/pn6TaW42VsztkRD6q1HpftQ8syBvsZ/o
	ojtOmfMFutIGlkf+Q2rV18TbU9jUcX1/WIXMO7H+5kQbitylS37ScPjeGdHaoXiELBxd0A712XO
	3qtsfVREmFXjIpzVGKieLItUaoAP/kiKSrY6wdm7ogx6evyXozypZClP5NRjCi81lyWuf/fO04H
	9G7iw90cnyAtd/D/sHf0WWrVT4xiS25HZmhVMyn45B/nSkO4jpGx4eDhESkvESvn42BSPoZoSST
	5eIDuRT5jp+ax3RlJ3cBqi6ld2Pduq45rsAAPUz9Dnf3EeFqIKa0X+nLE0f2rztNfRRjbeKjoJB
	iVB2bAtrEXhctgCeylR7VA93Z6FUE=
X-Google-Smtp-Source: AGHT+IGS9wuVDvvevxvg8K71lROg6rYpbM4tkxXD2Kfjl5l0kw3W7LqaDVVdOT+MS4gADMX6EMuH1A==
X-Received: by 2002:a05:6512:e8b:b0:57c:2474:372b with SMTP id 2adb3069b0e04-591d8584a95mr5461765e87.49.1761051711762;
        Tue, 21 Oct 2025 06:01:51 -0700 (PDT)
Received: from home-server.lan ([82.208.126.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1b37dsm3624098e87.87.2025.10.21.06.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:01:50 -0700 (PDT)
From: Alexey Simakov <bigalex934@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Alexey Simakov <bigalex934@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v2 net] sctp: avoid NULL dereference when chunk data buffer is missing
Date: Tue, 21 Oct 2025 16:00:36 +0300
Message-Id: <20251021130034.6333-1-bigalex934@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

chunk->skb pointer is dereferenced in the if-block where it's supposed
to be NULL only.

chunk->skb can only be NULL if chunk->head_skb is not. Check for frag_list
instead and do it just before replacing chunk->skb. We're sure that
otherwise chunk->skb is non-NULL because of outer if() condition.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 90017accff61 ("sctp: Add GSO support")
Signed-off-by: Alexey Simakov <bigalex934@gmail.com>
---

v2 - change the condition in if-block and update
its location for preventing potential memory leak
per Marcelo Ricardo Leitner's suggestion.

link to v1: https://lore.kernel.org/lkml/20251015184510.6547-1-bigalex934@gmail.com/

 net/sctp/inqueue.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5c1652181805..f5a7d5a38755 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -169,13 +169,14 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 				chunk->head_skb = chunk->skb;
 
 			/* skbs with "cover letter" */
-			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len)
+			if (chunk->head_skb && chunk->skb->data_len == chunk->skb->len) {
+				if (WARN_ON(!skb_shinfo(chunk->skb)->frag_list)) {
+					__SCTP_INC_STATS(dev_net(chunk->skb->dev),
+							 SCTP_MIB_IN_PKT_DISCARDS);
+					sctp_chunk_free(chunk);
+					goto next_chunk;
+				}
 				chunk->skb = skb_shinfo(chunk->skb)->frag_list;
-
-			if (WARN_ON(!chunk->skb)) {
-				__SCTP_INC_STATS(dev_net(chunk->skb->dev), SCTP_MIB_IN_PKT_DISCARDS);
-				sctp_chunk_free(chunk);
-				goto next_chunk;
 			}
 		}
 
-- 
2.34.1


