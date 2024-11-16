Return-Path: <linux-sctp+bounces-286-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2C9CFFDA
	for <lists+linux-sctp@lfdr.de>; Sat, 16 Nov 2024 17:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFBB22849EF
	for <lists+linux-sctp@lfdr.de>; Sat, 16 Nov 2024 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6838385;
	Sat, 16 Nov 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oVbntF+K"
X-Original-To: linux-sctp@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66782C8C7
	for <linux-sctp@vger.kernel.org>; Sat, 16 Nov 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774515; cv=none; b=WjqSZbSWW8JtiGZsKuH/uqFc2kN1metc9N/qEx7z64WUKkMzH+uZhWaiJgFFls0h8F5AiCfLsrw5MGt7oIqjD9ydhiYq8ajwvwAX+j9Tl6/2DmO/YwZ208bHzDujPGUjmaUb9xpnWX7ez8sGgRZFGNJGrymBOsRx6vbnOP2JjGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774515; c=relaxed/simple;
	bh=kOAI5lix9Ed17w5NCYaMHAZuqm5vJa1RMZ7TPcrnMmw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r1U2y/xIjNCIsLYSS8AoByrXsScxrW8me2brl27AmR/+ggdw3i3RmAGXBmRs3Qf20Bu9+lLq4KmSy36yCA31AwMPwB546QcJmEqB1fZCAtnoQP8+z260dft4WoVKsRSeUNeVySKgEyG4nOl+L3PH3dNuNTADwtO2+Tc/mSuWnpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oVbntF+K; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731774510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YfwACum2e9ImWiqsDCrhshsPNGyjoxiAESW2iCRRMW4=;
	b=oVbntF+KoeCVNKrPqFHT3XZLLUtnR6mR8WoNGaa3Wg7ciapVbFvwnvzInmCx2rWwTpVP4y
	2Spsp9dC88vrdbG42KgYvBL69oXtXfYCsPWC1+dXD2BUYpRj/+/BkdUQrjlGOSvrmz9Vao
	UfCJLVGbMUO4B10tLtYprLCJu4xD+eA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sctp: Replace zero-length array with flexible array member
Date: Sat, 16 Nov 2024 17:28:24 +0100
Message-ID: <20241116162825.33164-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated zero-length array with a modern flexible array
member in the struct sctp_idatahdr.

Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 836a7e200f39..19eaaf3948ed 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -239,7 +239,7 @@ struct sctp_idatahdr {
 		__u32 ppid;
 		__be32 fsn;
 	};
-	__u8 payload[0];
+	__u8 payload[];
 };
 
 struct sctp_idata_chunk {
-- 
2.47.0


