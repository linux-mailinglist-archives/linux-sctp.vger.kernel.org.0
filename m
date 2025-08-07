Return-Path: <linux-sctp+bounces-595-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116DAB1DD88
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Aug 2025 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77BF18A0CCE
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Aug 2025 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCC202F8E;
	Thu,  7 Aug 2025 19:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mm+YRI2M"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937E4AEE2;
	Thu,  7 Aug 2025 19:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754595616; cv=none; b=k9UyPZPGEhlwNiPz2gGyzXAboiS9fBsHPEcW8XDsLSqMxqwZNZ0MKXM96cjgrjsUN6tNA7TtcQuRjYAxwkXbtJC86clWgowvmuhKn8mrEG395aYh6dRK7x8AYAFTigs+h7e43fe3BkHa/aHhvUjiCsRSRr7NnnY73tWsEjZT5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754595616; c=relaxed/simple;
	bh=EZIEeOnW1Z0fE8adlPk3i3tVG6j/UoYNBYyEH7vY/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfHr/FLk1ZAPH81Y43KKhh1gVdvtcj1APpQUv7AqfMIlV84lloBgy/d/ZCCisJLSv9tNQD/JFMPzWO9YbO4Xj3Mu0eCyb+E9ScnN8o4scX5BIy5LjL6iiTJZN5D92XerZnESqaZrRosb9afGXPnOpih1h7t/Yl6Foo2f0vkIYuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mm+YRI2M; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e75668006b9so1447837276.3;
        Thu, 07 Aug 2025 12:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754595614; x=1755200414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTGv50AjxFne2hYKUgwleceqM6cCsBh+NvLVhbsB/64=;
        b=Mm+YRI2MV+XOo8zEGpwLg3OX4wk7rAIeRMMT9IGZY3aUKckkvFG3VLizqcs8FyCZPs
         xluc2YqoukuhXmkHwt6SktKyywOZffKipRlRYDHYUx02Hz9lJm9TciR11+aJkcIX3RBU
         SPgDQMF0TvQjteCGy/4hhklIqvjtJXuBv7omYHqDLVvhYxn0fzDPPpp9GRa9c5x1TNFg
         fl2qtRAEsGMmj/dNMJwbYNa0x+//suJF5y3Hn44XvJshzNstRQRYwt3H92J0T8esAJEV
         +pvbBDKKYRra4cU9XdbN0jMzG5i4MJpS/s4uSgeqCTt+Q1RYLnKl2O95/BdoENeq6eoH
         AxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754595614; x=1755200414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTGv50AjxFne2hYKUgwleceqM6cCsBh+NvLVhbsB/64=;
        b=JDEYNDBu7C2JJo+Zbob1QkB8qWKmQU9faPSkDJ15ATkc8pKvWQO/ZRZu6caY9KUYl4
         lRZFu9R8FppOJnlBanowV+rTgwQxgM+aBOxu4LQsC0WZTqBCkJEcp5UQkQQU7dMQpqz4
         xVBb8pwL/7igFIKcoknapx67unDQjDf2dIWO2jPCSSzU2i/wlEcFy/0elRQLyCYpkkT/
         T62NyUqswG/LIHQ8NczCQUMS8g1aCQkxLzzuBiw2fgM6KUQbYBERHDeBAZBfUI5xMtE7
         4tcrpopfsUGYJSiVaQ+QTaoPQQij8zh4Kds8YCI/sy6dvlmEVQK7yYFRdS/2fy1NOkJ5
         xO8A==
X-Forwarded-Encrypted: i=1; AJvYcCXl4XcLEqoZp5R0E8Wp9LkvGTJ8J0SPyMZPndBbnQfMmleMvFYX0j5ypm/oMbT9gZdlfDJvJ0RctCql@vger.kernel.org
X-Gm-Message-State: AOJu0YxFOzsdShgkt86WkIaRgTddhz6wjFi6I1hG8EDJPpGamtYq8Dak
	cK0o8dWSOdbLqVNUutgGbUMxZKPx7vClNhiiwCvvOzEFdJXMeQ3SGq4GN7+ngw==
X-Gm-Gg: ASbGnctcmc6rz/jmeaMi+lwPBmX3l4gC4tGgHlzzbpzrEaDoW3inbLd/gM8uOZp4idm
	hVT6snH1+LhZ9r0snarSYm4hBD+f5OaxRL/8vCSxaKWAXfPQXGLMye3fIm8/xE4elWJjzQ7655S
	8xeJK+aR1tb69QxhCI17yZCN2O5a7ByUsYT7DzI2o6Hm1EFEaw0Z+ElQ4ZJnP+21x+mJwXq12iT
	uRaipL2yVOJLD01NVeISX32O+KdIl9O8bbQqFArMOyXCueYv8WSSi1VXu1G+U5gLuraBHZT8SXF
	Ze2VoCHVaSDv4fIrupOeDRZ5n1dQ3ops8PTB1cWeakvob3tLoUl2lK7bGjBtAaHXEa80IcvuBCU
	IkGDvI8VCGNKfIKZVw/XxhfhF+EwFUsMlMRa0IMTR9F02osNwg3WRFT6JnAy946E=
X-Google-Smtp-Source: AGHT+IGxyN/ZEThXz0KUcvWci5mn4HMf3lqHzYz3qlPewTV14gBqawdMOu/5V9WKX6IK2gkG7TeXAQ==
X-Received: by 2002:a05:6902:2882:b0:e8e:2a6b:251f with SMTP id 3f1490d57ef6-e904b62e457mr592000276.32.1754595613593;
        Thu, 07 Aug 2025 12:40:13 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8fe073284fsm6025644276.21.2025.08.07.12.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 12:40:13 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Subject: [PATCH net] sctp: linearize cloned gso packets in sctp_rcv
Date: Thu,  7 Aug 2025 15:40:11 -0400
Message-ID: <dd7dc337b99876d4132d0961f776913719f7d225.1754595611.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A cloned head skb still shares these frag skbs in fraglist with the
original head skb. It's not safe to access these frag skbs.

syzbot reported two use-of-uninitialized-memory bugs caused by this:

  BUG: KMSAN: uninit-value in sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
   sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
   sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:998
   sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
   sctp_backlog_rcv+0x397/0xdb0 net/sctp/input.c:331
   sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1122
   __release_sock+0x1da/0x330 net/core/sock.c:3106
   release_sock+0x6b/0x250 net/core/sock.c:3660
   sctp_wait_for_connect+0x487/0x820 net/sctp/socket.c:9360
   sctp_sendmsg_to_asoc+0x1ec1/0x1f00 net/sctp/socket.c:1885
   sctp_sendmsg+0x32b9/0x4a80 net/sctp/socket.c:2031
   inet_sendmsg+0x25a/0x280 net/ipv4/af_inet.c:851
   sock_sendmsg_nosec net/socket.c:718 [inline]

and

  BUG: KMSAN: uninit-value in sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
   sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
   sctp_inq_push+0x2a3/0x350 net/sctp/inqueue.c:88
   sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
   sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
   __release_sock+0x1d3/0x330 net/core/sock.c:3213
   release_sock+0x6b/0x270 net/core/sock.c:3767
   sctp_wait_for_connect+0x458/0x820 net/sctp/socket.c:9367
   sctp_sendmsg_to_asoc+0x223a/0x2260 net/sctp/socket.c:1886
   sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2032
   inet_sendmsg+0x269/0x2a0 net/ipv4/af_inet.c:851
   sock_sendmsg_nosec net/socket.c:712 [inline]

This patch fixes it by linearizing cloned gso packets in sctp_rcv().

Fixes: 90017accff61 ("sctp: Add GSO support")
Reported-by: syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com
Reported-by: syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 2dc2666988fb..7e99894778d4 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -117,7 +117,7 @@ int sctp_rcv(struct sk_buff *skb)
 	 * it's better to just linearize it otherwise crc computing
 	 * takes longer.
 	 */
-	if ((!is_gso && skb_linearize(skb)) ||
+	if (((!is_gso || skb_cloned(skb)) && skb_linearize(skb)) ||
 	    !pskb_may_pull(skb, sizeof(struct sctphdr)))
 		goto discard_it;
 
-- 
2.47.1


