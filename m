Return-Path: <linux-sctp+bounces-350-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1BBA41C96
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 12:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74ADF16F356
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA2D263F40;
	Mon, 24 Feb 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNc5Ktpr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD532263F3B;
	Mon, 24 Feb 2025 11:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395876; cv=none; b=g/2j+IDcRWXmLPi6/VADyzdibQHy5B05CNCAweWnd4Qc8c544yRyfNx5NcLO4tiohobg0zAUAcLhyaYdtKovddGoYEp4Muo905ntuhVmWVXZTE6yiHfbftQctEgYGk4ihj3AcYCnG9rF0gO+BHYCJu6tSe1ZF10MixO/kx+ooXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395876; c=relaxed/simple;
	bh=gNhpMd6xhiiiI7IQjUh5qom9njguHMcExPCIvyTQ+oE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WDg7hkybpq9Xd/JDsDQ1IR124/ItdV+OJ4/qs6FoIA68R8rSQJFeCHvGGL+VlDAgeYvtgIz2jAIpt5MMgWbHb6bfKLyAWFccwbckex/PFZgYv9kYEGXSl22vRt2i49SjSRr//l7DKsaWrte5+di19193VMCqUKbpF1x9IodJEiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNc5Ktpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1869C4CEE8;
	Mon, 24 Feb 2025 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395876;
	bh=gNhpMd6xhiiiI7IQjUh5qom9njguHMcExPCIvyTQ+oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CNc5KtprbqCNQ4w9RoIk+aEJwg09V2Du4/RGGPEsvzZumUx8zUhgtyUCGKtRlyOQO
	 t9YUbq6rWmIMV3+Wn0Nxbdwe1Y61xDWtgFbpO1hY01KJ5MrBGUENCq3fVPYj+s7x4F
	 iaY3TMWbD5B/me3XJ4+Ak7VJLafE6ZOfXOsQrJoBI8EocTdyn/QjnDY3kD3KyIBG9K
	 sbmjJ0tMuK0bl2b1PtnXkKIbM4ZUT0FAZ1Tt0/jvT0OIFdDI32X158m90DaC7sFaxT
	 QYm9Vv7a8wfLc36tnsZx4hafr0B6/6LZCREX1cLFk7at5Xbiw0l6yN81MJ2JdHP0Y5
	 d9G6NWxCdonFg==
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
Subject: [PATCH AUTOSEL 6.13 30/32] sctp: Fix undefined behavior in left shift operation
Date: Mon, 24 Feb 2025 06:16:36 -0500
Message-Id: <20250224111638.2212832-30-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111638.2212832-1-sashal@kernel.org>
References: <20250224111638.2212832-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.4
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


