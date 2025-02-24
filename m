Return-Path: <linux-sctp+bounces-353-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8738A41D36
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 12:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A5116DD0B
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC49260A48;
	Mon, 24 Feb 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/NtZH1Q"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6527FE9D;
	Mon, 24 Feb 2025 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396029; cv=none; b=boAR5ttnx3IWX47Ybj9+M6NbzHF5IlrAttWrZ++h7thuzHa1+NdEInP62qE5Y5yrEvmmkF6nZnf3JilkfF7ifvMBkJ1bqeUU6naDg26zwwUFutE41GMiDlYAhK0MJhMxZ1r+waBjgmkJ0Y7lBGq/wpoLSodqCNP3cdMDqvnS7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396029; c=relaxed/simple;
	bh=Aw1AhRCRe0h7xFMnZoKTzgHuSv27yUk9wz8rZ4NUg7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mEvMK1Akw/qK/balfpMjsqX3eKuA7xNNxSRlmvpfRw1KCtP1VNfdHAKaBAdzI0D77W+CJS8pL1ll5tYZ+YhSxHVq7d+ZHxfftSntlMxTCdXBWu9FFy8rELrkL2V3Bs13llQ68982LYvFSeirsxMOvSobCks27HSE1Bb1YOjZY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/NtZH1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A666CC4CED6;
	Mon, 24 Feb 2025 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396028;
	bh=Aw1AhRCRe0h7xFMnZoKTzgHuSv27yUk9wz8rZ4NUg7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/NtZH1QQ2Jg6XtZmmJlXjVVSft7bDwD8q8Ptl2+fANJibANherP0LjYgMalZEO/O
	 885xykmuJWr0SC6eo4lb2H+/pDNKUn2/fSCNGiUVGXYvQZplfOjaB0nCTD8LIdHaXh
	 55I5raTZxkPY2eKR4Ji9q+s1ETjHSN/TDMNFsgW/NRG2Io2bWYihPaA3vGYGDq5yHi
	 ekyFOU5f+k2SYZVa6AmZo2UawwsBXdGuy9AWa48TMlVV3IAN60jXMh50P/gUgWsbkS
	 8tynSD11y2sp85fU98O96YVQl2VKXUpCC3rgIVTgov8pLlm5eVXq9Zh2Gicjb9mW6x
	 vl8NskWnEyO3g==
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
Subject: [PATCH AUTOSEL 6.1 11/12] sctp: Fix undefined behavior in left shift operation
Date: Mon, 24 Feb 2025 06:19:59 -0500
Message-Id: <20250224112002.2214613-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112002.2214613-1-sashal@kernel.org>
References: <20250224112002.2214613-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
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
index ee6514af830f7..0527728aee986 100644
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


