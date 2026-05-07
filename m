Return-Path: <linux-sctp+bounces-1202-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFUVF6Fx/GkEQQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1202-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 07 May 2026 13:04:01 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A10974E7308
	for <lists+linux-sctp@lfdr.de>; Thu, 07 May 2026 13:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E0C301F5D4
	for <lists+linux-sctp@lfdr.de>; Thu,  7 May 2026 10:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902623EFD30;
	Thu,  7 May 2026 10:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1qBTvls"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880E3EDABB
	for <linux-sctp@vger.kernel.org>; Thu,  7 May 2026 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778151503; cv=none; b=Y5aTLbLHh/aHOc6SmuBlsaUyl8OOOfJisocy+9YGEAs3iXCSDupoHDyKXWlCKGbnvfsIJ+cWYGgC/lcMx1QJYvMSlt/fJm0Es3YwCpEQsf/BnXH5+sXNfRDs8UZEEsujjjagPtk/1NzvCELt5ZcTzNXAJ0TI1PUX7C0G0TAr60c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778151503; c=relaxed/simple;
	bh=KDyR+OrrNlAu2ayv0jsJpH01ZNNW8r/iaESMvFPjkq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITS/NxlKrCVnm5R/dVhmASzCVhyTRH562uSQKf3a2E0hILsdaqu5/O+eM8qVGRUC4NMyCqARvFmlWx1O8fAZveRrE3RRqHd9yujVAek9U4n/qK1z7ZHnNoLJSD7vmkVmmZDfWUwpZOhpxtfiZ+8mrvMr0X4bM1buHz1nW84uN9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1qBTvls; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-393800f638bso5257141fa.1
        for <linux-sctp@vger.kernel.org>; Thu, 07 May 2026 03:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778151480; x=1778756280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8sM4rzQ8tb7rg7dRckHCV2LR59wwtkKewjtgiOctmrs=;
        b=n1qBTvls4DJVk/iqJi6DofzH31O6QK5iudBlgDM/w1CAXIAbDH4ZV8Wn/0vVyQYvNK
         vUgNmr6u1cOZgUmJhtmyOPU7fC5P/J11Kquh5SqlGyzb6B3Krxc+CgDzfAcdSHj8NoVc
         xrotp/UsDyR9/71btKQqvUf3s86QkFVwYH5bgSmrhmdmzTVIkfjpfCKa2rRwbVmmE/3L
         lRetR/XrmU9MXRnBULlW32R0JzyU9ULQgEMiadsLz0tf0S86OUsUfpHT913hrKsuQ2Co
         nscrWcGA/UIRmkaFEqwq1iLOZAJlsDsNNlWeCJo1CzePH0JdF6bn2Kjs6Dp4xhRzM/4B
         Wi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778151480; x=1778756280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sM4rzQ8tb7rg7dRckHCV2LR59wwtkKewjtgiOctmrs=;
        b=iu3WDFpRxmr0eqwgWsJvcc8dNp9RRBU+5kEmdpJ2xfyiJ9jqYpSZqHRNcTjgjEscXe
         r0al6p6Y6T563aFAOGWdecENpxPYmFL2NU3cJSOehD62iX92VTS1TNH+RThJXv8FsSHI
         Eahx0YOIuImsqI4c974Cyf0KBVViZ9vlIXrsreq9+GHU5wo6MjhYhv/Xd1tDZrBJqXa8
         qniWHnk+QEC2cznal/5ngEAE2k4rLCHXL/AjzPeb9puGnPLlNnKFVJmFm9uQ+jtEl4wO
         yI2tlDo8O8xEfayAE+0Ordh++Yxm0m5MLzEVwX0dKFT13SbABsq/+pFexrMwOTLViRb1
         g9rA==
X-Forwarded-Encrypted: i=1; AFNElJ/CfVq8leru6Fyuq9ldwkNKNLjalcRtAQrpdd+JaneMpxKK7XYiCNJU2PZ5YMI6L+Gw6N6kxqDtUeeC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy0U6NLuNYruOxM3Vzzbp8l0i00p+DoDek3YlZkjffPHCbLpCQ
	rn7YXe0nvg8bNGn0neEowW4kP+g9pASD6ufqmMR2sUreR9boWZWdhOxc
X-Gm-Gg: AeBDievCzniZX/cqGBxaHctPSp+9/XNg5TTeBDgh4qUAEZe21+XPRXP2PfvUCwf5tt9
	5iOXMoJ80EkFDw9Qe2pudCmfJmztvPE310HYGqlNDO01zX9HcG7TiY5yJrvXS+QBXQ8x4cQrKTd
	jdm30jnbt1wXi7ZOMA34/BK4mMi0635MdYJxAc6dcggBXa5DVfyoN+kaFxbwj/7y5E+lsTBmoCS
	dow1caEj7GeeolUS2ccyGdeuColDjEIt17dcdZoMQwB7YiXnWIjMqE9MFsTAO3OOO6AVwn90IgB
	YL01HPjDlYTM0jN2tAREvC2EScHJngAKrk+cSCez1SoW6HBWFV97//YRKlHh2RbkVyfEMUmVzW5
	Ub/vVZESCNnacNs7o27RV62tPF78I/1m7zj2QPFZaIm35Tj278AUFZLVjJNxcKjXRcFUAwqVOd4
	Zm4MKvMXAo4wYh12TV4s3fpm33k5rNV4X35MahqPfo0o+jTXeNIbuIMI3fW4yAg86BGSjodCbFY
	94=
X-Received: by 2002:a05:6512:1154:b0:5a2:b8cf:39ce with SMTP id 2adb3069b0e04-5a887ae02a0mr2768403e87.10.1778151480147;
        Thu, 07 May 2026 03:58:00 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5533962e87.65.2026.05.07.03.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 03:57:59 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
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
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 1/2] sctp: Fix typo in comment
Date: Thu,  7 May 2026 13:57:58 +0300
Message-ID: <20260507105758.25728-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A10974E7308
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1202-lists,linux-sctp=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[shofiqtest@gmail.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Fix a typo in a comment in sctp_endpoint_destroy(): "releated" should
be "related".

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 net/sctp/endpointola.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
index 8d342b5141..dfb1719275 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -209,7 +209,7 @@ static void sctp_endpoint_destroy(struct sctp_endpoint *ep)
 		return;
 	}
 
-	/* SCTP-AUTH: Free up AUTH releated data such as shared keys
+	/* SCTP-AUTH: Free up AUTH related data such as shared keys
 	 * chunks and hmacs arrays that were allocated
 	 */
 	sctp_auth_destroy_keys(&ep->endpoint_shared_keys);
-- 
2.54.0.windows.1


