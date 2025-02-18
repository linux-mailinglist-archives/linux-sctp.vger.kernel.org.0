Return-Path: <linux-sctp+bounces-343-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB191A394A6
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Feb 2025 09:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B726E3B2980
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Feb 2025 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2C22B5B5;
	Tue, 18 Feb 2025 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXFmkTlR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BB622B5AB;
	Tue, 18 Feb 2025 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866345; cv=none; b=sOjC93P+/Cuu+7iS6Q2D+thPX4a34pahOiSa3sty1Tt0IbKCYi87g/kHbgq7XOXRgH//zmTntyyg9xTWSMrp1DsadMMp32UkTAlpGZUudbtoe5e3DVsXeiQH/otYSk6uVyKESaK3jcFU7C96tZiALtz15jWNiFeiBdAnik+r7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866345; c=relaxed/simple;
	bh=VDDF0drE0v6aM8n2GdZ900DDcfak8917AYeCfZSSyMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e9oD3A5HrJgG0HgGIkNX+igXgc/HQDyJC9d5yJVjtg45K6DcPmDMtq2GkjWf21dSTvH1DYj19AdZYqZqIeTzVclAlhBvZ8DBJvqCTzddjaG4MWplLxOObfQ7lJiokFn31Ucf+NoA+pRgwIXMSOq9/P/1LdDdugvRRcfINcvKqGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXFmkTlR; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22104c4de96so43462635ad.3;
        Tue, 18 Feb 2025 00:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739866343; x=1740471143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOp0J6pj2QhljoJSRa5U74JabHLSILEyEQi3fxw4PJM=;
        b=DXFmkTlRohhCs1FizfVZqOR2kca3VPaULBDrro7065c156gYpBygzcQ+CRSbM3NzJm
         hbtA2kP2hkylsfYRFqdWTKDLcwCLthv3iQQOvMI5XIA8xeFYzQ7dtIMMGzR4dzQw6e6J
         /s755nqTmq9Gt0YAnzHvn3tiM4O7c4eLbbjEshE5TUvpBrbEKT/m2mejyUExNJfrzkqI
         /5LXrkzkBkciLGlxl1G9SWca1LPTVuEDIt+bHDtZ5KumhO0HE0XA/LNhBOEloDEHrV0u
         xvfwRqUk0Lou2ViEGewEG3GNZsskCw7/6w6gsS+2w0KMaODqZtIaBWkeIMJf2KNGQIso
         5VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866343; x=1740471143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOp0J6pj2QhljoJSRa5U74JabHLSILEyEQi3fxw4PJM=;
        b=KyTapWt06oXpl7OkkLgrxCz6sSmNWIdtgghpKSBQpderyhKnvZisTCmbDUBNxBp8DO
         R9NN4fT5k6T+WFKjxgV9ELa1x9InjpUYlFaBd6uQzy+GFlGbotV2x33WmmPY4xzwV+HU
         FcuLJNNNLxp95AWxgSBpNO8mP89OSmMASOjFQlJjGCN16n1b+syrVL/W2D5TSDlZ3DMM
         zOey/RrL3ILrVGqjyqsJSLNMdPbp118IXUSo5DkOE7Bs2Bhaxvo4GNBpv7Cganqlpp4U
         X+KiaV6muG8qfn/teOODqip0aR/rIYGNxwT8UwDzF0zGWZ1XMW1X5/oLwQ1O6U6ZDo9R
         VDRw==
X-Forwarded-Encrypted: i=1; AJvYcCUS+1do6vJ+8g974OqZweLNeQQPPRq0xL7dtt23YAUziA/IKOi/BUm9bbrkVwIQkzkINB1XOWkA@vger.kernel.org, AJvYcCVeUAHI96dwKbmjJ7bZEUF9D0AgAeR7pgEAsh/gNQq0NScbHwyy9x8t91T0Dj3QcWZt3pq45I1hYWL3t0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUl9IMClvXqiwJWalzUf9G7ZQnFr9vA1lnYDUhwrC6kcqKW/u
	/mKrSYma3mR2rrl1EcRrVNW/L2RBe4e7GDauaYERqoNAPzm+4tDRogi0zPeP
X-Gm-Gg: ASbGncv1dwGiUzWB2GIoagruk8vCejNIeQpgU/ePkEA60O3LKa2CZUEZzFsqgdKbK/c
	ORClNfQ+NJgd3D9oTcqJnErAdoqg4WwmE+3FIGQFZA9NYLg+MXatk6RsWX+dzlAyElY9yobUKWf
	SiUT37S6eOkx8V1NDQUm+5Jk1C0g0f6e6T7cSjACkmoarV5FcRanEIQs3cIgIKgLHKS4RmvHAKN
	D4Tr12/Z9AUjXhKLtlms5cDzh5HSSjDAfhkSEgsyb2qvH4pLT+u4di0DBfJFzElVmm3/cb0hY4S
	uyKNzOMGgHqX1S537OOJ
X-Google-Smtp-Source: AGHT+IFOJzWqTtD0VGVy/7gzR52hP2VG/n0XwVxVK5cql1UwPXceP2mIyhCVePXU5Bhd4zk6pU/IQA==
X-Received: by 2002:a17:902:ec83:b0:21f:5933:b3eb with SMTP id d9443c01a7336-22104087bc1mr162223775ad.31.1739866343320;
        Tue, 18 Feb 2025 00:12:23 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d537d0f2sm83726135ad.105.2025.02.18.00.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 00:12:22 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>
Subject: [PATCH net] sctp: Fix undefined behavior in left shift operation
Date: Tue, 18 Feb 2025 16:12:16 +0800
Message-ID: <20250218081217.3468369-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to the C11 standard (ISO/IEC 9899:2011, 6.5.7):
"If E1 has a signed type and E1 x 2^E2 is not representable in the result
type, the behavior is undefined."

Shifting 1 << 31 causes signed integer overflow, which leads to undefined
behavior.

Fix this by explicitly using '1U << 31' to ensure the shift operates on
an unsigned type, avoiding undefined behavior.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 net/sctp/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index c241cc552e8d..bfcff6d6a438 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -735,7 +735,7 @@ struct sctp_chunk *sctp_process_strreset_tsnreq(
 	 *     value SHOULD be the smallest TSN not acknowledged by the
 	 *     receiver of the request plus 2^31.
 	 */
-	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1 << 31);
+	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1U << 31);
 	sctp_tsnmap_init(&asoc->peer.tsn_map, SCTP_TSN_MAP_INITIAL,
 			 init_tsn, GFP_ATOMIC);
 
-- 
2.43.0


