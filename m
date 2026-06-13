Return-Path: <linux-sctp+bounces-1259-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kNGMFcnpLWqWmgQAu9opvQ
	(envelope-from <linux-sctp+bounces-1259-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 14 Jun 2026 01:37:45 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 995636800C6
	for <lists+linux-sctp@lfdr.de>; Sun, 14 Jun 2026 01:37:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OLRXuij3;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1259-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1259-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56F163013257
	for <lists+linux-sctp@lfdr.de>; Sat, 13 Jun 2026 23:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C310A2D238A;
	Sat, 13 Jun 2026 23:37:42 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4FC25F98B
	for <linux-sctp@vger.kernel.org>; Sat, 13 Jun 2026 23:37:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781393862; cv=none; b=Su9Q0q0hGeB0q368Jm3F2TOEeUhl0sq9efkedndm93QOGTY4RYI4Az3WyQ28iQOqtDYI7FUDeB1mKqOm0qHDsysvPOdTAHxXbHyMOH9U8Q+RvFVRR5GKVtolN2sJzH8Pl9TH/eZ2uKgml/Ud//g0L3cKIuJRTMkblKE7LQdCvi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781393862; c=relaxed/simple;
	bh=hz6zYyFk7HQyfq1WKk7VOLFoK6b6E5XOC2nsqH+EwAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rvnna5cC27jyEXbz9Yhz9bY/Di1Hl1Mjo6zA65QCdenYwYpEk0Mbo4TL9sIoYARy0Wa+S7YZF6cpvD4Bih7UzU/QaKA3S0EHbPW+JjD1ef/ON2r/trr09tkCWDiXsf/sCN2uFxi7cYYDZiY1Bub2yUlq0VHUcoHe3wbZ4nUUKeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLRXuij3; arc=none smtp.client-ip=74.125.82.196
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-3074adb8fcaso2112104eec.0
        for <linux-sctp@vger.kernel.org>; Sat, 13 Jun 2026 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781393861; x=1781998661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwbr30/uVIOuFvTEW39sce956F6NZBmS5KEMVuOXVwM=;
        b=OLRXuij34kkqHzz7cUECYOOw2f6+/t7+zH2c1crODhh0PyOVKqNIAU+lUYjMlKsX+u
         CI/esC+gCtbRC7zgh3FgzbOgZbl/GzlNGiB+xYz0/OaiH5bCCu0hyU/Is53hE676qckS
         jRfT+sJBO6Lq76wsi7Jqyq+Y3ENhw8JHHBc+vkVCpm77fRMN9Btld8M5bAvMBQvp42kh
         eBLfzXe6XCLHhpZFycnFfdCbUQTSZbGSBXdEfQ4LwanXKreQZoWm+wlVTFSuDeeIm1a7
         85MZdj9ENdDrjADeA787cKqOWJM6exbVkQ9gqWSddnKDZTUU8C8N1/AVsJ70lpb+Z2uu
         ph+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781393861; x=1781998661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fwbr30/uVIOuFvTEW39sce956F6NZBmS5KEMVuOXVwM=;
        b=LH8tzw9RkbX+wuJfrZ+V3s0pXAqfqQ7mgwXYyD+TXbm7QzMBzZAX9O1Wc82eXp/unu
         OyPj5ccmNeGEkAjs3sfXhr3Ji7kxiOJbUr2k7awM+Ce+NQ08DxAuy75rV0W4hu1LgnCI
         +TFiZ80PDq791JT/gVJUQDVnHbGw7u0wl0xsdYmnsBhWYZB2w5WG+REwRemA60MaXS+0
         850mU+BGE15kPj8ilpJABvysYfObN2okyTr+UlTD0xuLl06pP8uqz0bhmOCHTwERrQjI
         IMKxrcjbtZjr0snr4y/9gTa9dvvPzgNKo99EsamXdA9PoHRPtswvkxezZWY5OhVTehTb
         0TNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ycBuaYByEWu2F7XDqWrjpVldrgF9Vok/KzY4j/l12IuQjZ0dZa5LJG4bUfh9NloVpiLlZheF4CLAB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zpNdQO/A7n/AngQxRku9WtK1Aj3dmkz6PIbhOWkrFBGOhIeK
	31iG0ZtWFxZdrHKhJNMCvAhGAfsZwEyhjlSQsN3ZZCaCWng/apL4VsmmzlZakZuf
X-Gm-Gg: Acq92OGYOEc1J3wHZyLJO5D2DnfXf+FY1tH7mJTVFWXWNP9QNpsvGOTizo9X+Lm28J+
	y4kS/JRGbAZ8C8F2Hb/bGpeKpHwNSICd+IM4pGCl5l0XWQmrh8ZEse/ZMDL+KwolwGsMvttb9kX
	czXOY3UdskRHCBMZ2k698PgKbZjaMiQA9E0mqjVXXXVnqzlm57NjPuXaptS+EJrYcq8FYlISh1U
	1PtNSpfS2aqxjLmAbZ2hQnB7Z9PEIeJFPRvEhBOjA/VN8EHFaBKxSokkd5n1yL6p01Ag6gR2d+I
	re52RjSatRVCdt3N6a69bY0gC8/F2C6wWtDVP9TSv+v/QYd1rKwM1KB39qsrWYj+Jh4MVU/8fWp
	gr9nIJzrRp8rEBUmrLcygP55238cZaYVZ7eRTwFy8ekT7KhL90ILyzBW+lMjwu8eJDc2o+zt4ON
	NYsDDV4l/yYfs5qTcCUofrkMNPZhUFZ49INOcvPhUFoPP2TI1nFkHhssSFH4M6OjcEa8DLxAxNF
	wi9hiGe2rRxlwKNTRFixgwi5LTmD3a7dY/xg+oL3ra+7+hGTHz7Yh6T0obe/Cav3x14gKLKlAYF
	s78aqCpfq4XUiFUdrMYT+ifZvaDV
X-Received: by 2002:a05:7300:a599:b0:304:dddb:f8 with SMTP id 5a478bee46e88-3082026a517mr5088995eec.35.1781393860695;
        Sat, 13 Jun 2026 16:37:40 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e4898c0sm9453982eec.3.2026.06.13.16.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 16:37:40 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] sctp: correct CONFIG_SCTP_DBG_OBJCNT macro name in comment
Date: Sat, 13 Jun 2026 16:37:25 -0700
Message-ID: <20260613233725.162470-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1259-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:enelsonmoore@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[enelsonmoore@gmail.com,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 995636800C6

A comment in <net/sctp/sctp.h> incorrectly refers to
CONFIG_SCTP_DBG_OBJCOUNT instead of CONFIG_SCTP_DBG_OBJCNT. Correct it.

Discovered while searching for CONFIG_* symbols referenced in code but
not defined in any Kconfig file.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 include/net/sctp/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 58242b37b47a..60b073fd3ed8 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -303,7 +303,7 @@ void sctp_dbg_objcnt_init(struct net *);
 
 static inline void sctp_dbg_objcnt_init(struct net *net) { return; }
 
-#endif /* CONFIG_SCTP_DBG_OBJCOUNT */
+#endif /* CONFIG_SCTP_DBG_OBJCNT */
 
 #if defined CONFIG_SYSCTL
 void sctp_sysctl_register(void);
-- 
2.43.0


