Return-Path: <linux-sctp+bounces-205-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427E195B5BE
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5F41F210BA
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3861C9EC5;
	Thu, 22 Aug 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS3CgNf5"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47C1C9DF8;
	Thu, 22 Aug 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331512; cv=none; b=ZVOsS4INadhN/67D8V7gpwdHiHAR8dSdfNnVbxCHeb+FYOnacnW2BjpadJDlcRGCuywGPsOpBFPzZmoTPmDDBRmuILBna3QTH5/Of0F8BxgATYJ8a07vmI9xG85JY1/KAEGOodun2gY8pBQwKD2Ytkpw+cbAlbYyd2hpCwrdD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331512; c=relaxed/simple;
	bh=bP6X9S/zzyvosLaDMQbLpcIvi+6Smhxy03E6rOislg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R0wIY6jQbs0baNIOb9I289gFg7Ena9f87//zlDQk6O/003PNdLVLUa4COWgo+hq6IgOy4nc5ihAf2YRqHKpS6VQG0yJKmALfkQMqx36bWxjmQbae+fdixAgsM2IWM5kYCrG1odyWgTRpGENm0wDC4zerCoqsvg0fAJgHIYw05AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS3CgNf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2D6C4AF10;
	Thu, 22 Aug 2024 12:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331512;
	bh=bP6X9S/zzyvosLaDMQbLpcIvi+6Smhxy03E6rOislg0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gS3CgNf5v87AA62IAwlLeVbxQXp7ymoD07KgZ1z/7RWN/wQXOOb3eAPnm2pVm/ag/
	 jtc9SFKpj3qiGP1crxfAtaZ5mlD0fitQ/Ve5kJiRQTWgn9AtV5aQJ3s4ClxRb2nwgb
	 jMOXv05xsx/xd3VNN7tetKROuscyQ2a4NpHocKSIVLPi3zmm+IdLALLVimuhq9RddH
	 mQfR11vgP8QzxqDb9UFGxJka3cUKRAm3LM1KajryN9yk5lWYxQ/NMVzG/FFlZSMb2J
	 JwvcxTT+Q3wIQmbkTL5xhFns6b+WlWSJkuOP35qLC4QpuBypens4sczolwHb90sE4r
	 vR0Qm5hmb+hXw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:32 +0100
Subject: [PATCH net-next 11/13] x25: Correct spelling in x25.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-11-3a98971ce2d2@kernel.org>
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

Correct spelling in x25.h
As reported by codespell.

Cc: Martin Schiller <ms@dev.tdt.de>
Cc: linux-x25@vger.kernel.org
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/x25.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 597eb53c471e..5e833cfc864e 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -81,7 +81,7 @@ enum {
 
 #define	X25_DEFAULT_WINDOW_SIZE	2			/* Default Window Size	*/
 #define	X25_DEFAULT_PACKET_SIZE	X25_PS128		/* Default Packet Size */
-#define	X25_DEFAULT_THROUGHPUT	0x0A			/* Deafult Throughput */
+#define	X25_DEFAULT_THROUGHPUT	0x0A			/* Default Throughput */
 #define	X25_DEFAULT_REVERSE	0x00			/* Default Reverse Charging */
 
 #define X25_SMODULUS 		8

-- 
2.43.0


