Return-Path: <linux-sctp+bounces-202-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90895B5AE
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CE70285D27
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE6C1C9EBD;
	Thu, 22 Aug 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm7wIYWi"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6AB1C9EAF;
	Thu, 22 Aug 2024 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331498; cv=none; b=UpTgaKl35xz+Btp0VAW0xUifNa0yOvVHrUiulT++F5G3Us/DfZatpKwuDSD5UiNQDYoKf2Qo6CmQ95C0sAA7HY27hIObexHuv87iZr+G51mecfpUqaOVwReSZ49NvPRWq7FfOX7u0XjeXJIYr49eTyaexL7d4Q0Ej94kt5buz0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331498; c=relaxed/simple;
	bh=YDvZmFYAizPriWxQVuMB4neFv3KPn+mi3kSktdBTF6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vzn3SIzurHUKtUz/AdyUe8h0AMN6UlNErYa9NymojsCtZosgJn3m8YDGOX0rozIURU4HXwdodkvMJEF5qAKV7uy9+lcyF9z5k64XmTK5uiSC7qt1V5P7pA5KtXjxxVN3rcZ2wK1cbOfjkLjWnAjc0MfPAAnJ6DZepczoeoNZFFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm7wIYWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C174DC4AF0E;
	Thu, 22 Aug 2024 12:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331498;
	bh=YDvZmFYAizPriWxQVuMB4neFv3KPn+mi3kSktdBTF6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gm7wIYWiBQ91o2k7KotMrTVXZxZsv7NJhblbjtiieLJQwX5ydvh7t7BDQYRACAtbj
	 K08hcx3kBdZIxRRI1eZ3CcidGVhFHbZ41KxDciTCZXQV4BXbbUWKblyLAnEYqF7njZ
	 dQuWfHDXRNbGlwcXD3rFYzOEFcf9lQqCv+4HuZ87ZC4FNkhLfWqqwOn0xBufv2hZX1
	 zlPoSrnK5yj3l2rBj30HUUgi+Jth0z4XfXr+0tKe/4sGZ2AzmGk7z5W1ASJtjcN0hL
	 lWv779kgFeU4YCb4dSExwaqCnlilbequDM2ORh89RESudr+wC3hsWxQKEh9sOZuTaQ
	 yvGzgpkhvfBGw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:29 +0100
Subject: [PATCH net-next 08/13] NFC: Correct spelling in headers
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-8-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in NFC headers.
As reported by codespell.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/nfc/nci.h | 2 +-
 include/net/nfc/nfc.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/nfc/nci.h b/include/net/nfc/nci.h
index e82f55f543bb..dc36519d16aa 100644
--- a/include/net/nfc/nci.h
+++ b/include/net/nfc/nci.h
@@ -332,7 +332,7 @@ struct nci_core_init_rsp_1 {
 	__le32	nfcc_features;
 	__u8	num_supported_rf_interfaces;
 	__u8	supported_rf_interfaces[];	/* variable size array */
-	/* continuted in nci_core_init_rsp_2 */
+	/* continued in nci_core_init_rsp_2 */
 } __packed;
 
 struct nci_core_init_rsp_2 {
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 3d07abacf08b..3a3781838c67 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -80,7 +80,7 @@ struct nfc_ops {
 #define NFC_ATR_REQ_GT_OFFSET 14
 
 /**
- * struct nfc_target - NFC target descriptiom
+ * struct nfc_target - NFC target description
  *
  * @sens_res: 2 bytes describing the target SENS_RES response, if the target
  *	is a type A one. The %sens_res most significant byte must be byte 2
@@ -230,10 +230,10 @@ static inline void nfc_set_parent_dev(struct nfc_dev *nfc_dev,
 }
 
 /**
- * nfc_set_drvdata - set driver specifc data
+ * nfc_set_drvdata - set driver specific data
  *
  * @dev: The nfc device
- * @data: Pointer to driver specifc data
+ * @data: Pointer to driver specific data
  */
 static inline void nfc_set_drvdata(struct nfc_dev *dev, void *data)
 {
@@ -241,7 +241,7 @@ static inline void nfc_set_drvdata(struct nfc_dev *dev, void *data)
 }
 
 /**
- * nfc_get_drvdata - get driver specifc data
+ * nfc_get_drvdata - get driver specific data
  *
  * @dev: The nfc device
  */

-- 
2.43.0


