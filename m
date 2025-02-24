Return-Path: <linux-sctp+bounces-352-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66AAA41D11
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 12:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0A3E17BC5E
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 11:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A424326E15D;
	Mon, 24 Feb 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYJtztpp"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D9E26E153;
	Mon, 24 Feb 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395997; cv=none; b=TUQksiBNcv5BPB2WQa+CvskFnd/COppjK6TRIMtcJbGeO3Kbn7OMQdGHO1FsJJ03TeRErdQ1d0vtNcmyuojY65lvtDa7oK2iIsvUaAYZHGiW0HqAgkb53pmD217pccz7+7m2KE3ZKrjvcTCJq7jDTCXqmf/qA2LHyp7fD/+Pd5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395997; c=relaxed/simple;
	bh=gNhpMd6xhiiiI7IQjUh5qom9njguHMcExPCIvyTQ+oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eBMZ1zCHDr1mMou2i1Nzhvn+eG+jbOerRskku71p2n6/ow84evFxFHVWVnVWYAtOWB7mkuaiRhrliWuXfNivNy45mAMlTIvkkNYfOcVxSKcoLDCid+sn3m0DfZ+p6JdHZqCUm/1Rju/r5NvSAFLll8TDI5MfJth0Mp+CEc6bFJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYJtztpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EBFC4CEE6;
	Mon, 24 Feb 2025 11:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395997;
	bh=gNhpMd6xhiiiI7IQjUh5qom9njguHMcExPCIvyTQ+oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYJtztppVaYV0rSMzKY16Lmu9W8L9YQzYpbrOT00uZG2y509JHc91qIIjfJCZTkNF
	 qE/ObRvOMwG9fjn8LYVZNR1FcyD3qdoUPP/6AvJlWYQej07NJyHW6reBVpZm//NOQ/
	 p332jqd+H0+9wWVKGk6R9qJOssvQIA3nDPDbLtJ9M8x4uHijUqG3UdTL/VJDgv7QKO
	 FUS0fKXtwnc9QH7hNKpLHrg2TpBhoagqFiX7clyNoUW7zGcVPLAITeP8dcYuvilaf0
	 DNhhxCRAZJpPmDEpodqL2CTIbgLPuOIY9iaupN+7thFasiP+4/Lau1a0H+cA3Ydvmh
	 ZNX5goPZuB4kQ==
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
Subject: [PATCH AUTOSEL 6.6 18/20] sctp: Fix undefined behavior in left shift operation
Date: Mon, 24 Feb 2025 06:19:11 -0500
Message-Id: <20250224111914.2214326-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
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


