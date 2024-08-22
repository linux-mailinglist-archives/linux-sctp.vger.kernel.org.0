Return-Path: <linux-sctp+bounces-199-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC5295B59E
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 568A4284CBA
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFD31C9DFD;
	Thu, 22 Aug 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eslZwG4K"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC91C9DFF;
	Thu, 22 Aug 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331484; cv=none; b=SpU1imSWZ64vZxhbOaP4SZ4idRSPElOXNiifQgXL/tNDxCc2q35H3fxX3xkqiK2RqlT6lp2LRNgihNzuMhsqpD+XTFo7Vb93U08fHJUpgbaA4XD2PQCTlOzwOPDcaqWTN1qKgxKFB9cNmQXg2dmlMYJxWSIttw5z9bCpQ3pCvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331484; c=relaxed/simple;
	bh=mOChusB6cjD3IP4W23e2AcjRdNTClAGuLDf5cynThUU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gQduZnwLqHsNEzVEb5dFmFk9F/zDiIOA+7fCKpzgMBbwNxkb/cPi4cH2kfLh9DuqMiGKMavMzpA7QImRjDWAbusiK0fjjZ870lXqR1YGCfOR6B0A3dselqwSYtagSrjezDw5vxIVXOd2rn0SWzPlzV2kecT38Kr8I/33z3bMaUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eslZwG4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDCFC4AF0B;
	Thu, 22 Aug 2024 12:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331484;
	bh=mOChusB6cjD3IP4W23e2AcjRdNTClAGuLDf5cynThUU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eslZwG4KBeAY16U1Kd0k4cQ2OoynMg6zc8sw2ramG6P6+nZgEpWAdutUHzc8nnLk5
	 gSJR2Fe31hn/MEG4uCjIs0QWidYOU+f88RjsE7osolwK+BEpeMXxtZCx2P7/mzVZgp
	 /P8jO10q33nLMEezB2KjxuKR01Fx+LZhDI3S6Fs9Zm6AaTmctadyKd+CvnolZw/zIx
	 EKvuLdvI9d5nqNiSDFuVEU7P9Ojy6MZpPFFmxR6KJz+8ABrbtconHBaM56vZ+FxJb3
	 pmGIGzCsTv6EEOdxSQMlNuycWKe4G6m0+jjdH8ipxcDdLeHzAJ0wPXzy20dvzbATe1
	 4fVK5NMWUevwQ==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:26 +0100
Subject: [PATCH net-next 05/13] bonding: Correct spelling in headers
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-5-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in bond_3ad.h and bond_alb.h.
As reported by codespell.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/bond_3ad.h | 5 ++++-
 include/net/bond_alb.h | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
index 9ce5ac2bfbad..2053cd8e788a 100644
--- a/include/net/bond_3ad.h
+++ b/include/net/bond_3ad.h
@@ -231,7 +231,10 @@ typedef struct port {
 	mux_states_t sm_mux_state;	/* state machine mux state */
 	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
 	tx_states_t sm_tx_state;	/* state machine tx state */
-	u16 sm_tx_timer_counter;	/* state machine tx timer counter(allways on - enter to transmit state 3 time per second) */
+	u16 sm_tx_timer_counter;	/* state machine tx timer counter
+					 * (always on - enter to transmit
+					 *  state 3 time per second)
+					 */
 	u16 sm_churn_actor_timer_counter;
 	u16 sm_churn_partner_timer_counter;
 	u32 churn_actor_count;
diff --git a/include/net/bond_alb.h b/include/net/bond_alb.h
index 9dc082b2d543..e5945427f38d 100644
--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -53,7 +53,7 @@ struct slave;
 
 
 struct tlb_client_info {
-	struct slave *tx_slave;	/* A pointer to slave used for transmiting
+	struct slave *tx_slave;	/* A pointer to slave used for transmitting
 				 * packets to a Client that the Hash function
 				 * gave this entry index.
 				 */

-- 
2.43.0


