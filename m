Return-Path: <linux-sctp+bounces-589-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343C8B0E27C
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 19:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5B2AC2CFF
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48699280CE0;
	Tue, 22 Jul 2025 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj5xUgp9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB4280A56;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204719; cv=none; b=HNkgBkWVAvh7lAJ9whPNXUW4DyUI2BPrf1oVIA5bodeZltNDfHp5dnTqDtsK+hupOR0Jr6ZngPfT4XsA0SZPY7y/eto5kBkiBadVrCrcEfTJHCz8KDLBzimi38LUl1CHIDrnb4N0/2AgEJ6sNQmOrMk5FuzrcVEG7qU4pq1Bl6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204719; c=relaxed/simple;
	bh=XaHeIrVkz+npBlw1lyf0qJblIEHGZQRxwothP5DgXpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oy+mxgx2Er2UyrYhFhX2qxUaQbFQAde+qtyAQIK6/Cw2pZ4ws8Ing86VPtGdQ9lvNvvhXF74QNaeXOSKzbjD0FZ9gcHBw4akIySWnKDrFRKageM3O5kfluN3ZyhLoCTr8SN4L7g9e2ORcxAK5uuQGUlNVDEwjDUnYb9UaztWczE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj5xUgp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C418C4CEF7;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204716;
	bh=XaHeIrVkz+npBlw1lyf0qJblIEHGZQRxwothP5DgXpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tj5xUgp9KQ+VF0Wd1AYYCmGk4/nQ5DWiP7ILBiUrnvuGZjbaCieFkxmcWQcAuZPXD
	 dir1N8q2XCnfd8GlHFMqlZcDYQBbbVMKqmmOrVTY7I4ViQBuCqn4BPkcrniRSML6tV
	 /g5eK40lPYYPwql2757wx4M1U4g845dnVfANTVay4IXjc0bJhHQAIwzPl5d1xFEsGs
	 S4Mhe0iR54QBhh1/3jlLaQLT5TgOQo0fcoZtPdIC2awlU6gB1J5cGQr8N0B201fk0U
	 hxqpPPPqorj2P1gPrvA0yjIu0smr9SyuZTpO6tlzjoQRuSnv/6PCkh4KDyClyD+Bic
	 HDAmZKUC9NTqw==
From: Kees Cook <kees@kernel.org>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 2/3] wireguard: peer: Replace sockaddr with sockaddr_inet
Date: Tue, 22 Jul 2025 10:18:32 -0700
Message-Id: <20250722171836.1078436-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722171528.work.209-kees@kernel.org>
References: <20250722171528.work.209-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=kees@kernel.org; h=from:subject; bh=XaHeIrVkz+npBlw1lyf0qJblIEHGZQRxwothP5DgXpo=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn1x1+waS/6eaXHauGh7Jlr3071DrVkMA9uNtHtVvsr8 3Aq55mPHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNxSWL4n+DN9V/bobTOfGpT abnPvEvdApF7tLTXJr22/XDoid3WGIY/nJcY52twtuzIOPChRDHhGxfX2rB7v5z+697k7dTheML ABQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As part of the removal of the variably-sized sockaddr for kernel
internals, replace struct sockaddr with sockaddr_inet in the endpoint
union.

No binary changes; the union size remains unchanged due to sockaddr_inet
matching the size of sockaddr_in6.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: <wireguard@lists.zx2c4.com>
Cc: <netdev@vger.kernel.org>
---
 drivers/net/wireguard/peer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/peer.h b/drivers/net/wireguard/peer.h
index 76e4d3128ad4..718fb42bdac7 100644
--- a/drivers/net/wireguard/peer.h
+++ b/drivers/net/wireguard/peer.h
@@ -20,7 +20,7 @@ struct wg_device;
 
 struct endpoint {
 	union {
-		struct sockaddr addr;
+		struct sockaddr_inet addr;     /* Large enough for both address families */
 		struct sockaddr_in addr4;
 		struct sockaddr_in6 addr6;
 	};
-- 
2.34.1


