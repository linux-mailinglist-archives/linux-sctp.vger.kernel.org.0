Return-Path: <linux-sctp+bounces-203-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B614495B5B3
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E65B286026
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCC01C9EAF;
	Thu, 22 Aug 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAUoSl74"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA8A1C9EB0;
	Thu, 22 Aug 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331503; cv=none; b=tRqhtVkWBwLaLikffC0cwJLqV6RGlbr878015azXxo8ryORPxUdHyaEwR7TnF6Yz6+4poaxHQ3udWqdqKhNY7UWqWE4hsqBerdgeM7sChgLnSIp9k/o5OTmjgBwd4hcSLZXIGI/evZFvTFuvVul6cxMsTx3dZzwt6fa8d5XTqOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331503; c=relaxed/simple;
	bh=kF0i1MzJsWLy9CcYYmy/E6kuWuGGi+D7KzvUyYUw16E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NSxrzdlCy0MDqw5MxK7omILLAUjQctT7yt6enKVD/7KTkWyfGMgBvr2C3CAtWsbf4cjPJ6NtKcdC52+IEiUMD044lKechpdpI9jkuBgUSn74S7S4xWbuELjWO9nI0qm+vZ7jOnh/5MwjoLVca77oTKL0dVPwSf2DvbA7MN8NOK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAUoSl74; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DE1C4AF0B;
	Thu, 22 Aug 2024 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331502;
	bh=kF0i1MzJsWLy9CcYYmy/E6kuWuGGi+D7KzvUyYUw16E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WAUoSl74zSKjlj2L1lDabL9bhIHhUs4r7GzQi6cFn0UDKjjG2oITFIqfPyhTRQFNi
	 lrQwEanNo5gFHoqOmuReFrDBKIxZSyqNypWmL43YdPCSCKQek8ENnXvNuJczw6DBVq
	 DkliPUDGTOGBe+K47yC/CZy/vIzlIkPnks9g3facJ3WIGPu3TMbVl2zBbQmDBPALzQ
	 hdrZTVy9WcV4NtjDW/zcZEvA9rSh6nzU9y7Xf5lU3D1Xt1DCCnqIIVHJmpqlCWELae
	 z2zgPjQ5UkvRWfrtUtNnG4QstGK8uDheXrH/ACrOahPv6Lgl3T3BeCB1Sn4nF1MmWX
	 GcUejg0P3ABcw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:30 +0100
Subject: [PATCH net-next 09/13] net: sched: Correct spelling in headers
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-9-3a98971ce2d2@kernel.org>
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

Correct spelling in pkt_cls.h and red.h.
As reported by codespell.

Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/pkt_cls.h | 2 +-
 include/net/red.h     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/pkt_cls.h b/include/net/pkt_cls.h
index 41297bd38dff..4880b3a7aced 100644
--- a/include/net/pkt_cls.h
+++ b/include/net/pkt_cls.h
@@ -491,7 +491,7 @@ int __tcf_em_tree_match(struct sk_buff *, struct tcf_ematch_tree *,
 			struct tcf_pkt_info *);
 
 /**
- * tcf_em_tree_match - evaulate an ematch tree
+ * tcf_em_tree_match - evaluate an ematch tree
  *
  * @skb: socket buffer of the packet in question
  * @tree: ematch tree to be used for evaluation
diff --git a/include/net/red.h b/include/net/red.h
index 802287d52c9e..159a09359fc0 100644
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -40,7 +40,7 @@
 	max_P should be small (not 1), usually 0.01..0.02 is good value.
 
 	max_P is chosen as a number, so that max_P/(th_max-th_min)
-	is a negative power of two in order arithmetics to contain
+	is a negative power of two in order arithmetic to contain
 	only shifts.
 
 
@@ -159,7 +159,7 @@ static inline u32 red_maxp(u8 Plog)
 static inline void red_set_vars(struct red_vars *v)
 {
 	/* Reset average queue length, the value is strictly bound
-	 * to the parameters below, reseting hurts a bit but leaving
+	 * to the parameters below, resetting hurts a bit but leaving
 	 * it might result in an unreasonable qavg for a while. --TGR
 	 */
 	v->qavg		= 0;
@@ -340,7 +340,7 @@ static inline unsigned long red_calc_qavg_no_idle_time(const struct red_parms *p
 {
 	/*
 	 * NOTE: v->qavg is fixed point number with point at Wlog.
-	 * The formula below is equvalent to floating point
+	 * The formula below is equivalent to floating point
 	 * version:
 	 *
 	 * 	qavg = qavg*(1-W) + backlog*W;
@@ -375,7 +375,7 @@ static inline int red_mark_probability(const struct red_parms *p,
 	   OK. qR is random number in the interval
 		(0..1/max_P)*(qth_max-qth_min)
 	   i.e. 0..(2^Plog). If we used floating point
-	   arithmetics, it would be: (2^Plog)*rnd_num,
+	   arithmetic, it would be: (2^Plog)*rnd_num,
 	   where rnd_num is less 1.
 
 	   Taking into account, that qavg have fixed

-- 
2.43.0


