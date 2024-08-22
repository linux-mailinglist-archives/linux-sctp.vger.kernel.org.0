Return-Path: <linux-sctp+bounces-198-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67395B59B
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AA61F23EC3
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAE51C9EBD;
	Thu, 22 Aug 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPuzq8iz"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8D318452D;
	Thu, 22 Aug 2024 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331479; cv=none; b=skR8m4raVHMJvMM60UIbvUYfzVAXZl0Ljs2OvdugXBPKxvRzOazqeJZfnecso3pweyq7zoyOBeXRdHJ1FXMeGbtUYQLrJ733kTQsuWPd1267B7bfggs5x5oigbXSJMis1Wk2Y4F9r81xhq18EIUgNsXwLCMu9UPSMeaPxN01QkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331479; c=relaxed/simple;
	bh=8i+z42JB2yg0vXt5In+j5y887Xpzvf3HKmKMTvgBK0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IP9AURRcQg+1PJ74ZrT9Q0Q0VJEj0JWZL7RYRy+u687dqj6UOj7bkQ+49udNM+ZwMLlhjenGSFeKYf91Dp+EAZnidILmen2eF9nMTakYp2Qkz5wESVcwPv8f+Avzp7Trg1U37wJH28++fCPB0rc9MQorseqKqL1t0S/keXfOcWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPuzq8iz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3150EC32782;
	Thu, 22 Aug 2024 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331479;
	bh=8i+z42JB2yg0vXt5In+j5y887Xpzvf3HKmKMTvgBK0Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XPuzq8izDGuDD73+S4V8YF84CDmyoR+GS0hIrx0GM3DxbobxYQwKGr+Lncgj0z0Fb
	 PyestM1qM9U48pzmUgqH12IvM0vm0wTRiF0UKx82waxMoDmOTvJ8SZMXfjHqbU7cc2
	 NofMgoxXk6zYa2AsNI+F3kucM/63sfdaTCgEQJfGuhxLc35y7ssOcAyXk1mY6MZoLw
	 O+XSZ3+0lXMde0frjyFcUp9YWCxinM2MG+8EhgGI7+d8phfCmp0P8ZOwsljx5UZvw4
	 4ciqZ369pbzmAyb1EuLZAE8AW0qJziJ/r6lKm7a0I/3RvrVWFOyYUTKVhtuinQhyd/
	 gYvQcEQPpPuBw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:25 +0100
Subject: [PATCH net-next 04/13] ipv6: Correct spelling in ipv6.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-4-3a98971ce2d2@kernel.org>
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

Correct spelling in ip_tunnels.h
As reported by codespell.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/ipv6.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index e7113855a10f..248bfb26e2af 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -851,7 +851,7 @@ static inline int __ipv6_addr_diff32(const void *token1, const void *token2, int
 	 *	we should *never* get to this point since that
 	 *	would mean the addrs are equal
 	 *
-	 *	However, we do get to it 8) And exacly, when
+	 *	However, we do get to it 8) And exactly, when
 	 *	addresses are equal 8)
 	 *
 	 *	ip route add 1111::/128 via ...
@@ -973,7 +973,7 @@ static inline __be32 ip6_make_flowlabel(struct net *net, struct sk_buff *skb,
 	hash = skb_get_hash_flowi6(skb, fl6);
 
 	/* Since this is being sent on the wire obfuscate hash a bit
-	 * to minimize possbility that any useful information to an
+	 * to minimize possibility that any useful information to an
 	 * attacker is leaked. Only lower 20 bits are relevant.
 	 */
 	hash = rol32(hash, 16);

-- 
2.43.0


