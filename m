Return-Path: <linux-sctp+bounces-586-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20291B0E273
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F491C84951
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC95927EC78;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKNKGse8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C927E07B;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753204716; cv=none; b=O2AUiCwJXuJgSoqFzR4o/MKyAEf+fI9MMMEsh1XmJ9sqA1ISbRw3dp+97tFa79LjRHxt8SIdDhegyW1u9W5MDQcbiH2sjgpUR9k6Qo9xLe8j8KYo0BXi14mgR9kSPRkdoBjjeNIEusfqiDAEUseFfcvw1jTnGJ6t+7LUFRP/T0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753204716; c=relaxed/simple;
	bh=hKrFfWopkwsW7B2AHVN42+Qytuzm974Tmy5ORbFhuiw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTTbpBUu8v8AzTAmoA9W5h4WZ62rcaBEHsVcJqjYd79JtrsTGJTXxXR9I9KzxUSuDVj1h+B8brJYZO6j4J0afd7Nbxo1Jpx/T4p0aPf1NUQXjwC8i8htIiQIOndQ8QJUFvDj4rGHykdWvEEPEY8C2ozhrQmZ/co6sBZcXSuMTFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKNKGse8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3ADC4CEF6;
	Tue, 22 Jul 2025 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753204716;
	bh=hKrFfWopkwsW7B2AHVN42+Qytuzm974Tmy5ORbFhuiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sKNKGse8eGdOlxo2VuWBWdfYHko0GJTL4K9Hl9HBQGkHeolTrDHtRlbDeEo986F+q
	 jE75o5VTAgf6LrPrOk2DLTAykPW0tnBaD6eWGJ5rnuJDwV3Ccle8dkI4VZ/mlz4Lu8
	 093RzU1fuVG4knHzmf/ZUPvv3Omz/TUBvJBgSWgSAuULhN4UzBC3m39ipIJaPEHEmH
	 yUTa8ZW2P1UHAlqWE0401f/rs8M0RtF1/MATcYD2RW04moc9Rd7wHJXkWaFFFdxcJJ
	 dYoha0ltrg7/9pDplDaYkBTI8Ah2Xi1MHd+dM0XIzvrnz/1CvqAyhNFyG6+bjiWDtn
	 jIwL8eOwhqs1A==
From: Kees Cook <kees@kernel.org>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	linux-kernel@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 3/3] sctp: Replace sockaddr with sockaddr_inet in sctp_addr union
Date: Tue, 22 Jul 2025 10:18:33 -0700
Message-Id: <20250722171836.1078436-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722171528.work.209-kees@kernel.org>
References: <20250722171528.work.209-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239; i=kees@kernel.org; h=from:subject; bh=hKrFfWopkwsW7B2AHVN42+Qytuzm974Tmy5ORbFhuiw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn1x18GvmBYyG99a/fba1pvYpQmiBTem5S06N6J1C/q3 UUPe7/0dpSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEyk9CLD//TrN9I4bZ9JPA3h LDbinLMm8K9ER+PX0CURNhpT2NOsDjL8MzsYOSthCYdLxI2rHbVnu39JvQyN2VjZsW9Oe6BBcLU VMwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

As part of the removal of the variably-sized sockaddr for kernel
internals, replace struct sockaddr with sockaddr_inet in the sctp_addr
union.

No binary changes; the union size remains unchanged due to sockaddr_inet
matching the size of sockaddr_in6.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <linux-sctp@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
---
 include/net/sctp/structs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 1ad7ce71d0a7..8a540ad9b509 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -51,9 +51,9 @@
  * We should wean ourselves off this.
  */
 union sctp_addr {
+	struct sockaddr_inet sa;	/* Large enough for both address families */
 	struct sockaddr_in v4;
 	struct sockaddr_in6 v6;
-	struct sockaddr sa;
 };
 
 /* Forward declarations for data structures. */
-- 
2.34.1


