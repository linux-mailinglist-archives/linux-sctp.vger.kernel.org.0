Return-Path: <linux-sctp+bounces-197-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957EF95B596
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57FF1C23518
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA881C9EA9;
	Thu, 22 Aug 2024 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFFIqqIz"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343841C9DE6;
	Thu, 22 Aug 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331475; cv=none; b=RP9KkyuC1ni28bF2v7X3Mq0nmrhiYMPvTG3UzoKJO3fKxoImnO0GexHEXAZXK1m69l60OH3GmFR50/6gJ+5I2PUpDRWFVVSD37Q749uOj5ADH2ysgXhZnv/zieGWw+FUusd+rwYK0tI0s1SLYx7XQsgelwNAEDdsjVoa4O1ll44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331475; c=relaxed/simple;
	bh=aoDmRguQsPBl3mfUQ7HyZo4oxrUzK2ttranhJ6ZLxN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPKIMVwzHbRXHXvwBbya2fbZdri3K5gDeivenZE2u85liB8UlxcdefxsGUqdgNdPzEVfesDVbnX535tI+ckSOKLzoRFSF1Mr25opUy5dJxvYKCqMOWHEe1cE9BE0LjQeauao2wKovA/AB+crgZt31oIsojOqCxTRF/MGLtF0ogw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFFIqqIz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BCBC4AF09;
	Thu, 22 Aug 2024 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331474;
	bh=aoDmRguQsPBl3mfUQ7HyZo4oxrUzK2ttranhJ6ZLxN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aFFIqqIzWjVF5OBcXMtTxl/Ig7NLPEuUvBWz0VIYkZZSJVaz4ma6sPEYWt+101UJ2
	 mkbIQZXe+EsQipq/TpBcZJ47zI5W1pkGfX0L5BCCvmJelju2QH+FUFdpjGOvjvshtA
	 uNnitf2p0JN9zp6QJ8VPsFxzElmVXakEFATGwNE2R+d3dAHli/n2Xy7X/2osxmFb4S
	 uIytClNKvJiX/FxiRHF78EYdoxmW/Ua/s4sEaOAqDbucB5QGKXdq2lBazGDnw1nC7c
	 m81iN+2bEZrnefRvy9aV5/nlXvmiWgSHsX6UpHnBgdHM6FZG4s9NDlyjGAIGrarWtq
	 5DTJBUWhZjiYg==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:24 +0100
Subject: [PATCH net-next 03/13] ip_tunnel: Correct spelling in ip_tunnels.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-3-3a98971ce2d2@kernel.org>
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
 include/net/ip_tunnels.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1db2417b8ff5..6194fbb564c6 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -573,7 +573,7 @@ static inline u8 ip_tunnel_get_ttl(const struct iphdr *iph,
 		return 0;
 }
 
-/* Propogate ECN bits out */
+/* Propagate ECN bits out */
 static inline u8 ip_tunnel_ecn_encap(u8 tos, const struct iphdr *iph,
 				     const struct sk_buff *skb)
 {

-- 
2.43.0


