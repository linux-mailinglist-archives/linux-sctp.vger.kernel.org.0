Return-Path: <linux-sctp+bounces-349-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C048AA411B5
	for <lists+linux-sctp@lfdr.de>; Sun, 23 Feb 2025 21:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C7D03B546C
	for <lists+linux-sctp@lfdr.de>; Sun, 23 Feb 2025 20:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18D8EEB5;
	Sun, 23 Feb 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZcqU6b25"
X-Original-To: linux-sctp@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98E846F
	for <linux-sctp@vger.kernel.org>; Sun, 23 Feb 2025 20:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740343605; cv=none; b=ZMoYDIFuz0jwF2WxuIX1bH7B+X6Op8qnILMUWmpjgyHxceX1YwME8LUhM4HtXhdGDJDFQCJ+1aMey4m5+vCAGikArqXGHL6tM6z6QJLLaL1pQB/sSkDZu0sDe7JFgKXb7SJHDAWkgL+WmaRBYbBYIbHQJpRmflFl+u7SMQLtQbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740343605; c=relaxed/simple;
	bh=yiBlED7Er+79WUdSAwX3nMETMxNgXccfcRJLbl9a+3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raqbVskNLSqgTfTpbOndDLtPfSE56q9I4kmEioH94fo/iHnquiTaPsbf4Z/w3xfMbZhiJSz6YDiSsaC7yUb+BN/zKAMt6spiBcyVJXmKbWbkH+ZbCVLBfAbZ305L3YSynlEvUy/t+4XnRVT3zm3lBwRy3gzN42OB3ZsiGpzLWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZcqU6b25; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740343601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=08QzHP3bP7KO+u09LJ+0D9dSqxkLj1k8AYQJMF6TyWY=;
	b=ZcqU6b25GdDRR4L8CfFzuPIVYtHztbmotSU/lX9mDicghWIXYEZfd9mipMGjO1gE10uoTW
	B/b1H3xvPaJ4lt7VWdHDq4QDKB16AAVOs/lhi6nL/6P0kLCXHZX0H/DaTYGVt37NYEsHRu
	q8ayk9YW2SajD7rhuhOiI4xgTTM9g/Q=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Kees Cook <kees@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] sctp: Remove unused payload from sctp_idatahdr
Date: Sun, 23 Feb 2025 21:45:07 +0100
Message-ID: <20250223204505.2499-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove the unused payload array from the struct sctp_idatahdr.

Cc: Kees Cook <kees@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/linux/sctp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/sctp.h b/include/linux/sctp.h
index 836a7e200f39..0b0228578153 100644
--- a/include/linux/sctp.h
+++ b/include/linux/sctp.h
@@ -239,7 +239,6 @@ struct sctp_idatahdr {
 		__u32 ppid;
 		__be32 fsn;
 	};
-	__u8 payload[0];
 };
 
 struct sctp_idata_chunk {
-- 
2.48.1


