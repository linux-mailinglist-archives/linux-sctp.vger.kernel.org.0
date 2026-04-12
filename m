Return-Path: <linux-sctp+bounces-1173-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOm8Aufg22ngIAkAu9opvQ
	(envelope-from <linux-sctp+bounces-1173-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 20:13:59 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D423E5593
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 20:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E1063002A37
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410F43624BC;
	Sun, 12 Apr 2026 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+IoMKxO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA2934104B
	for <linux-sctp@vger.kernel.org>; Sun, 12 Apr 2026 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017635; cv=none; b=SdYpehU6XwvPK1qlAFjj1/S1vK2GHLW5RfoSXiZeaU/RSuQdTTuSxHj1JUfOGrDRH6M1KYlV1lcq8FN3fFJU3DPEgQbgiohn6kd1HatoBKuYjKeS1/P7Bhny62/b+6PN0dpx0tbuvwoE4jSybGwQGML8w5xix0Zo9peszs8+LMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017635; c=relaxed/simple;
	bh=NhZM8bs3RhTPz673fFJW80axbNGRWxEwHZSZjykdlLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eo9pneKTH4KM7n9AGL3/2/GIinYKb0PmhrYsRguzug+4Qoa+NYvuyGlT6avNIE46LjUTV7jEXO52LDtzkAlwgUJhwOu9FGYVId5N594176aBWO/5X5aJOYNMcA/7K8CjFn1y1pByaNDyRP9Gj6BIzBWCWH+PnTKB6Vymau6n7TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+IoMKxO; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8d00cf835b7so449557485a.1
        for <linux-sctp@vger.kernel.org>; Sun, 12 Apr 2026 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776017633; x=1776622433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BUvMH4jKlGMfrlBo9fO9WI9tZfaDnciCa8LXMEtn274=;
        b=R+IoMKxOk3l4PcsB99+AUq9BrC5WktRbK/lTyoE5TcJw/6GyU9QCcKeKOyPByw+bvl
         sgI9Izs+r1cO8kV/AMepbK1iTHHwZLFFSczrk6W+iS5Vhkz9LELsintlXBjgaaYHV2tF
         YB8HBaOPs6b/zbMFTTgISHEx6waOOPlTKCqiQNgVh/cJ35yE6u1zmuU9H25WBupKR4xl
         J4oejynawbn4YWk4ZSFTCkGuLdQbC1QHWAxTvlVqrcfs4R40OmkNdy9To78NnANeKhhT
         arnae0CPynk43CPSQXX6vK77co701uOZHQ6Oke+/9/IHoFpPrMrzaYCDqj3rDGitaUqH
         ftCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776017633; x=1776622433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUvMH4jKlGMfrlBo9fO9WI9tZfaDnciCa8LXMEtn274=;
        b=XzsWO/M5zKZT5rmFWy12NttM4/Y2nFItKUAdZxhaEz0zTyxa1hCXsTBrYyKXF5tOEK
         ixm+nawohxp8JrcBjqcZUzTCPc5fKmpBsz5HJhetF5MmuzTNn02+jJZNZMO/5tRuKO/7
         MPs1nFP52Vl7JA/JlV/VPG9OcpN4qP+UcRzdOugLs5rjAM+z1sJwPx68wxF7tPSWfX+s
         O9YFgTn6hYwSSfO47dIyigbBY3vPBA+Q4XP68N4grQdW6+zyoMWuvR2f3r1SOjYBf2b+
         TYrHlK+TFQK7kIG+OFaNNpomqaR56qsnk9Pazg1Phvbgg/+TYcZsylvGacW9ByAmTTl/
         zVxw==
X-Forwarded-Encrypted: i=1; AJvYcCUjT/nTcnSXA6U4DPHtzmbO+mJBBYJ20bmONjWwe5FPWsG2DPMgaU27sR2j37L3liFFfNZ5df0SYZbV@vger.kernel.org
X-Gm-Message-State: AOJu0YzEpeIhCG5sme+u8f8vx8Nz2ACvtPvJYIWRsI8yJPx0JC8fAJxr
	W3RZcpQ2B/itIdaA8UaVlPYMmoNgeiq1tSvDsO5Oy4Rx8825QNdh6jwQ
X-Gm-Gg: AeBDies+sMlRz9ek4sKnCoU/rHbt52mbpCBXSTlvVgzDtWPc0nEHTvZ7ILzEeJVwl1n
	p2BJ1mWhb5oeVme0o++NMqmpNuQbx+/hPEMzDK8OaY0sha5vTDBEyocSdOcZ75kpXrPLlEi3MvL
	C2FH6QvOVkeCqFclIIAcmxWep4NIYwhPYL1Vn6KPcSmKWKHHX2hKoF/JJeHtUynHucaDQSVVUks
	8KeveBsrFatX6OelrikS5K529nbDd6CETgdM3zxOBuWRve6OTYGYJRxicfRXDaXB1B4QK8BBWjD
	/Jh8KDXDahNdXzvGBIFQwdq1pHWj1MEx9JvFsxGkQ3/oF38X36DzRfT4Y9mBvxzkYnhMUe9qnUx
	9I+66aGYYlB1bTFuQGxZG9WY+UhZCLJoZQ3ivnIJTEt0QCXEC2WPlNtl1Gte0KulYzv4BLZAaAN
	2fPtX9UZu6T+PSdwn1jL+Nrmm7kEEmBNFl++UMljscNa3gBVijN4DuDqnr7mMFtjjqDt9NGI7gG
	sCUi+pkobBT0XaSoVqoQHHSCtnMJJUTLnrRt9KDI2/BjcVM1UQf7aYwT9nMb8LO
X-Received: by 2002:a05:620a:4722:b0:8db:de3:92a1 with SMTP id af79cd13be357-8ddcf6b5bedmr1591752085a.48.1776017632893;
        Sun, 12 Apr 2026 11:13:52 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6b895sm700538685a.31.2026.04.12.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 11:13:52 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: fix missing encap_port propagation for GSO fragments
Date: Sun, 12 Apr 2026 14:13:51 -0400
Message-ID: <ea65ed61b3598d8b4940f0170b9aa1762307e6c3.1776017631.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1173-lists,linux-sctp=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-sctp];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 60D423E5593
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

encap_port in SCTP_INPUT_CB(skb) is used by sctp_vtag_verify() for
SCTP-over-UDP processing. In the GSO case, it is only set on the head
skb, while fragment skbs leave it 0.

This results in fragment skbs seeing encap_port == 0, breaking
SCTP-over-UDP connections.

Fix it by propagating encap_port from the head skb cb when initializing
fragment skbs in sctp_inq_pop().

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/inqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index f5a7d5a38755..a024c0843247 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -201,6 +201,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 
 			cb->chunk = head_cb->chunk;
 			cb->af = head_cb->af;
+			cb->encap_port = head_cb->encap_port;
 		}
 	}
 
-- 
2.47.1


