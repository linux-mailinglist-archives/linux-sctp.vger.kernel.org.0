Return-Path: <linux-sctp+bounces-285-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C29C74BA
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Nov 2024 15:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37C3E1F215F1
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Nov 2024 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13142AE93;
	Wed, 13 Nov 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WDPcLms2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4147D433CB
	for <linux-sctp@vger.kernel.org>; Wed, 13 Nov 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509320; cv=none; b=CqwGd5zlHV/gKj70Ip/VLB4OOnlYsCGK+btvkQHGlYmcISZc1kRzGPbqcFIMJT6zFcVG8JiuOGCTo+9vhXzf1L+xmurEAY5LJIt4ZIuDwsMktoHf4fHV8XzcVlaxhL2Q6sKeETLYUzVY7IlIeohcMRJz3E5tiVIyJ83hjeCrBdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509320; c=relaxed/simple;
	bh=7AqwuIIajl3uN68NwpTNsqmhDVUm0ZhPbp0j/41s8kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3MpKvWfxSAqtq6eAAmqrZzO6OHVkUtLqJWAejVkTXQGmyJvVW3jOBodlsBbvpg2ati0rDBkRDOIER3l/uU9qzwntazQSdxerqt6qgPk5W+yLuDuHTY+9OjSdnHX2cwGQpxjC401k9AXAQeuIMg7/LM1ym9drbaUDMaFiqIfhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WDPcLms2; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731509316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3qRm8jB7U8ddgiJrGdGcNqdS4keaO/DQW1NYUZQlCa0=;
	b=WDPcLms2es67wax1OzwGWoyN/vecjS+U2Ji79XXvSCN56OeOy5Ya3XFNs5sLvXZcno3T4X
	qF8+5DH6VbHNU/j5Mc7LutGlpzZr8caHaXPXQZ2Z4s8mg++Gpi/kOCtjCMlub0H0Tz/Z2S
	vU9o26uy+n+IXAicIGmIddZhqNOd0IY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sctp: Remove commented out code
Date: Wed, 13 Nov 2024 15:47:52 +0100
Message-ID: <20241113144751.243799-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove commented out code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/sctp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 836a7e200f39..812011d8b67e 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -222,7 +222,6 @@ struct sctp_datahdr {
 	__be16 stream;
 	__be16 ssn;
 	__u32 ppid;
-	/* __u8  payload[]; */
 };
 
 struct sctp_data_chunk {
-- 
2.47.0


