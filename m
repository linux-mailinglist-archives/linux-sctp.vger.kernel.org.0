Return-Path: <linux-sctp+bounces-355-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47964A41D68
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 12:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81A53BB310
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2025 11:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F8726137E;
	Mon, 24 Feb 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMoM/Y3/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49724889A;
	Mon, 24 Feb 2025 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740396071; cv=none; b=nMLghFq/HLE0Sw9wuM3tgvuXpbQ5gynbk+LlnNvQwcyXtqH8HmUz+uI4jQDVHg6QoF/47FyvWtrICVs7mIDMpGJzceCOa/bRTaRwtthkETTcsogefrYVZekFMBkJ55XzOlBvIYqs+ioLyhG/1t0cE3G62zB9IWLcG3l+iw8MQX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740396071; c=relaxed/simple;
	bh=Aw1AhRCRe0h7xFMnZoKTzgHuSv27yUk9wz8rZ4NUg7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrNA2a+i399ZxLr71/j46vOFeOqFDhk3IUQrWxVMjhmtJukgvX+DuRRTJa22CrKg6u5WbAg7rcuSKUdqzp0PfLqJOMeUFjSgK++Mclc+EOr2Nr8anuVQ9LPkqn4L3OxWCkJ1FWWzxpf3Vn5QTNmemqn0c+jsugXM7HGJEf+xNzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMoM/Y3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532CAC4CEEA;
	Mon, 24 Feb 2025 11:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396070;
	bh=Aw1AhRCRe0h7xFMnZoKTzgHuSv27yUk9wz8rZ4NUg7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMoM/Y3/woXVofZ6+D6PJJbsjjgZUOA7PCJkkNhYWfzoMHdphDgY9tQjpE2zgGsy+
	 VYayWwNnhI1/+7YAEh4zvF6cqDVvXDgsCZEzs43b1pMsEWxS0CT3NxNPnvQ9pQKQ1X
	 tvX+ITs5fVLHwSuLD8Fj9O75kl4RD+JBpXBwdav0hbHUf0J8o5yamIwC61fTTVtgac
	 20/TjghnyrWEJnD/OAU16dWGw4GFu92g4QvVd0gucspA24r96o46mWC5iechF53OhT
	 0aDX6PcYVM3kBIFfVSjgvtW3EIWRyQD8XrGb96qXQ2q1WiHQPKMAPMuEhC/zMVGGpc
	 7wMnUMUcVTgIA==
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
Subject: [PATCH AUTOSEL 5.10 6/7] sctp: Fix undefined behavior in left shift operation
Date: Mon, 24 Feb 2025 06:20:49 -0500
Message-Id: <20250224112051.2215017-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112051.2215017-1-sashal@kernel.org>
References: <20250224112051.2215017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
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


