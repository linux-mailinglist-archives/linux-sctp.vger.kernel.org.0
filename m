Return-Path: <linux-sctp+bounces-323-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B06A2E0B6
	for <lists+linux-sctp@lfdr.de>; Sun,  9 Feb 2025 22:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637697A28D6
	for <lists+linux-sctp@lfdr.de>; Sun,  9 Feb 2025 21:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D45E22FACE;
	Sun,  9 Feb 2025 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="inIYdf6P"
X-Original-To: linux-sctp@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B76922F3B3
	for <linux-sctp@vger.kernel.org>; Sun,  9 Feb 2025 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739134858; cv=none; b=YoW5+kvUNHLsZCfDNqcoGZaU8mq0DDpmy/dY/8oFN0a7Xas3azNTfhX6cqip7Fm3r1ZiUZJXg5jEy3rr7SbGC2eNUaaPqLMFHC4XhNC63fYxnBVfm1c+72bbt4cVz9fE7Cs5Gi8csmjOt8Vp/BOJ1eUN8wV5gRwIQ6QI5NlkLDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739134858; c=relaxed/simple;
	bh=NHnejRiD4F+bD2f1fFm4I4nrdOgw35XCjt6JvGxyuYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nvqFftbm+i0oQtITAMCrulG/bWAHJG9k5Hp7WCBQxCEAd8/nq2MkaF7+jHokJ+55g5dgn0m1RhJt0u8CiryBX+amDCJ9oQwyMhi7SC7MyIWB2vT/2L7JI/wVjao1Ba5tQoCDJiIwe558T2nNMzdiG8mywU4U+RELo974xQuDpOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=inIYdf6P; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739134852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qIkHZdlJgBI8XSQLEeTxcPGCocchQWHaTTHt7yTbJBA=;
	b=inIYdf6PGGNyyYc8JDFhCUMXsCOokl5OQY/wOPwXtl9PAEhzMjAwpudEuHKasw5jHL/G7T
	Ns2pEW/ls6A4R+0mvhYYoe7vlXBPcQmN7ZLvftQf0R4IUGjKUEIb/9Y3pUDoYiiDWZWCFa
	4e0T404PNDip4xkvhP6tMez7zCxiFtA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] sctp: Remove commented out code
Date: Sun,  9 Feb 2025 22:00:24 +0100
Message-ID: <20250209210024.5413-2-thorsten.blum@linux.dev>
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
2.48.1


