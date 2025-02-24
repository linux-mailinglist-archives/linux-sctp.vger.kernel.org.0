Return-Path: <linux-sctp+bounces-356-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF90BA41D7A
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 12:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5DF176336
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C752561A9;
	Mon, 24 Feb 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAqOArFn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642652561A0;
	Mon, 24 Feb 2025 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396081; cv=none; b=G98X40bDcecvQdB/Ae4fd9dCUT47jvanfcZIbM+S7bvGk2bhTG5DYUDYksI7td4gN8i+0cjZSspMqzx3wnc1ndBVda4m7aIaTeATGTwlm6vpnPju/4MSIucdgdc+OQRfVPvu2IN9Yp9VQMOfWLyXZ6b/NDWBVKJ8YQkWx8wTGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396081; c=relaxed/simple;
	bh=9afY757v31G/u4/cA1tFUd2NgpHJZ6SIDg0Ev4eo5EQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYot2dLFLuz6LdSeORwIVP73Bn49Xqphul0y+QUEI2EwUb62rYZS5SH8F8ECSuywZP0i0RAunS8rMLBWRMpRWYOVoFUEoHlMqf6BcmFP3g1xMRp0AO/zVoKukIyw7fFjRpCj7sL8aVOEs8/Q+BlibsZHHIkNkwQAoLrLDqJhqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAqOArFn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ABEC4CED6;
	Mon, 24 Feb 2025 11:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396081;
	bh=9afY757v31G/u4/cA1tFUd2NgpHJZ6SIDg0Ev4eo5EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAqOArFnhPs7fBhURpVhNYmkDucOlL/QC/P6V69Hvx+oQ+lIcWuUbtkhMUfEtQJME
	 JAUYTmYQKrvb5v8yyKWEKceycTAHXdRAEocvwY/CMkh0zKAK3NAOIiMKKGKxYSkeJK
	 sGPFNAMrsIhsP2apG3CRfahvjhE2H1rLTIfZYDrXHAVf9S2MSAaOm1zCktVksJ05J7
	 yAbGYDnL8NiDpokq3EM0pUnwQLOfecm0ke9aGf58u3g8/qNSZdpJz1v3A9cJmj7ID/
	 v99kONDO1hr0AfrMXqL6vDFc2cc5MmT/jREpXWTbGRHwYNpuV68LEO3Y9i/umXjaTW
	 AoeupRe75VHkA==
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
Subject: [PATCH AUTOSEL 5.4 3/4] sctp: Fix undefined behavior in left shift operation
Date: Mon, 24 Feb 2025 06:21:11 -0500
Message-Id: <20250224112115.2215137-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112115.2215137-1-sashal@kernel.org>
References: <20250224112115.2215137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.290
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
index ca8fdc9abca5f..08cd06078fab1 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -736,7 +736,7 @@ struct sctp_chunk *sctp_process_strreset_tsnreq(
 	 *     value SHOULD be the smallest TSN not acknowledged by the
 	 *     receiver of the request plus 2^31.
 	 */
-	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1 << 31);
+	init_tsn = sctp_tsnmap_get_ctsn(&asoc->peer.tsn_map) + (1U << 31);
 	sctp_tsnmap_init(&asoc->peer.tsn_map, SCTP_TSN_MAP_INITIAL,
 			 init_tsn, GFP_ATOMIC);
 
-- 
2.39.5


