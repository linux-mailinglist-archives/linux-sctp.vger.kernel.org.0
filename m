Return-Path: <linux-sctp+bounces-617-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E516B2B31B
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 23:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4D0587928
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4662749D7;
	Mon, 18 Aug 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyY0MN2a"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD12737FB;
	Mon, 18 Aug 2025 20:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550639; cv=none; b=oz8spKRBdRLxyLvIh/RIiryFMgJHBYo98gpdKpTVV9Lvi6Rz9FhSTIIEBRK7UPnO4dInlf1D8WhJkpBqGpHWZEBqCDXrW9VkIhoUs4Jv7lnAwqS3qOIu3kX/xDCFT36xTwJ9t8kixjJCMW4E/APf4vTTvjLay0p+2Y/a6FUgSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550639; c=relaxed/simple;
	bh=hemVKD6Np66HkPp6f8nWyquNzdmm4lwZm5EWfMVFXvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TSVkamlcpWRIDb0Um8x2mnEYyuY/1kgdrphGKiW3C7Zjd97Eyj3sliGblg9p3wc2Z9oi1573V+YDEMuDlnUlokcbSbVytosbYDxpKeCIHB8dX4+Ny2qxlnF/ApGg/hulrVmpKPTmgStmU7J8HRIjv13qANvt59ZOENgEIbI96Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyY0MN2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121CFC116B1;
	Mon, 18 Aug 2025 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755550639;
	bh=hemVKD6Np66HkPp6f8nWyquNzdmm4lwZm5EWfMVFXvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CyY0MN2awMtY8pHhkCz8via2MJTYZGoD2me232CH8E6zMZmz27/RmXv6J0k2wiHDX
	 hSNub/H/r9zWyEtHNsD7fDOO4oDY/Q5P5EtOkjPVOWlnDbGAhLN8VPihL/bvJPbZBk
	 Vkf/6ORhqeCj+uLmeOGZ3zchIcg8uCkSC/CNOL9jHkZifeW6sDg/bh/PszUPvvl34t
	 jhwbb0CU6KXLBa415nmBwchhSLhY1Ap5dPf4OVuoAfpCoNV60v5r++7ChVNvxwezKj
	 yYhB1y53j/amEqJKGINlVzCDJaIGFU3Pi6BFWZyuKhTW76SQ9B7v1uiPBcWuvXgRmK
	 voRT0eXLV8qaA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	Xin Long <lucien.xin@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net-next v3 2/5] sctp: Fix MAC comparison to be constant-time
Date: Mon, 18 Aug 2025 13:54:23 -0700
Message-ID: <20250818205426.30222-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818205426.30222-1-ebiggers@kernel.org>
References: <20250818205426.30222-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prevent timing attacks, MACs need to be compared in constant time.
Use the appropriate helper function for this.

Fixes: bbd0d59809f9 ("[SCTP]: Implement the receive and verification of AUTH chunk")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 net/sctp/sm_make_chunk.c | 3 ++-
 net/sctp/sm_statefuns.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 3ead591c72fd3..d099b605e44a7 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -29,10 +29,11 @@
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <crypto/hash.h>
+#include <crypto/utils.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/net.h>
@@ -1786,11 +1787,11 @@ struct sctp_association *sctp_unpack_cookie(
 			*error = -SCTP_IERROR_NOMEM;
 			goto fail;
 		}
 	}
 
-	if (memcmp(digest, cookie->signature, SCTP_SIGNATURE_SIZE)) {
+	if (crypto_memneq(digest, cookie->signature, SCTP_SIGNATURE_SIZE)) {
 		*error = -SCTP_IERROR_BAD_SIG;
 		goto fail;
 	}
 
 no_hmac:
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d7878..d4d5b14b49b3f 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -28,10 +28,11 @@
  *    Kevin Gao		    <kevin.gao@intel.com>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <crypto/utils.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/net.h>
@@ -4414,11 +4415,11 @@ static enum sctp_ierror sctp_sf_authenticate(
 	sctp_auth_calculate_hmac(asoc, chunk->skb,
 				 (struct sctp_auth_chunk *)chunk->chunk_hdr,
 				 sh_key, GFP_ATOMIC);
 
 	/* Discard the packet if the digests do not match */
-	if (memcmp(save_digest, digest, sig_len)) {
+	if (crypto_memneq(save_digest, digest, sig_len)) {
 		kfree(save_digest);
 		return SCTP_IERROR_BAD_SIG;
 	}
 
 	kfree(save_digest);
-- 
2.50.1


