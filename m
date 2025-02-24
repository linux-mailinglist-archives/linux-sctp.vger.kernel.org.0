Return-Path: <linux-sctp+bounces-351-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FA8A41CEB
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 12:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC423BDB11
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 11:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C86267F44;
	Mon, 24 Feb 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjS81hmm"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B63267B99;
	Mon, 24 Feb 2025 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395951; cv=none; b=MHdiBdg60qWvIsott0/GF7SXOtpnDoyWEHURPIaIvXqhPLM5oA5odBDAmW7Ti1TJ3jATDxtXVI5xoD8uRE48An+96PWuqCRX5yiv4totxQGa++RaNy+oeO/1LZCD1OZCvnztWkhJMkmmCXPzGTL/YI4NjsNfrOTyRYiwp8pVo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395951; c=relaxed/simple;
	bh=gNhpMd6xhiiiI7IQjUh5qom9njguHMcExPCIvyTQ+oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRYOaELA70zvFwDqpNMGHYOI908JbuO2W4+XrUJq3E/8tzi/q8NuMjWgvH6yhYv7sVzurjl8Spcogu2dDbQIPsblBuTCk0LHh4x4aYe1i4lzSOiSFVavbLLmK0Lhi3yieZ+oWNSVfwODqwphvHPaYlNa1ZF/N1ZYdAqmUiUIg4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjS81hmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CBBC4CEE6;
	Mon, 24 Feb 2025 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395950;
	bh=gNhpMd6xhiiiI7IQjUh5qom9njguHMcExPCIvyTQ+oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjS81hmmhGBxah9AF3h+osKhV0f7bQpHN74v07x3fhisLG3Z/ZT1yc/hAHN1+pkI7
	 2ZbpNxD9a0T65+P01yXw29EPx0BxcDBnKXo+oTkqZGqsCVp7z6OZt7i/wyBa1uLFNn
	 8TjKu5Evmh8FG41wImeX+uxyNUuQ/mXGVnNi6E0FGLH9KNNTZZJkiHSEkEMcOTVhDC
	 04hMs0FYFgZQnoY/Zlj+qKuSny8rvH89vRsOp4El5eDFmwDDduWmIRccvX2SF7TSMy
	 tY3nHt0chbKtXpZW/1cQcnheMwxwiUTAH6pHg6U4HHVfpFjkD2O6QxrxFxOE+D8Y4i
	 UhzgDjdAPeJUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yu-Chun Lin <eleanor15x@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 26/28] sctp: Fix undefined behavior in left shift operation
Date: Mon, 24 Feb 2025 06:17:57 -0500
Message-Id: <20250224111759.2213772-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit

From: Yu-Chun Lin <eleanor15x@gmail.com>

[ Upstream commit 606572eb22c1786a3957d24307f5760bb058ca19 ]

According to the C11 standard (ISO/IEC 9899:2011, 6.5.7):
"If E1 has a signed type and E1 x 2^E2 is not representable in the result
type, the behavior is undefined."

Shifting 1 << 31 causes signed integer overflow, which leads to undefined
behavior.

Fix this by explicitly using '1U << 31' to ensure the shift operates on
an unsigned type, avoiding undefined behavior.

Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
Link: https://patch.msgid.link/20250218081217.3468369-1-eleanor15x@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index c241cc552e8d5..bfcff6d6a4386 100644
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
2.39.5


