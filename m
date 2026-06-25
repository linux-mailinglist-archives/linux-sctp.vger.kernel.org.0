Return-Path: <linux-sctp+bounces-1291-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 04GfBhY6PWohzggAu9opvQ
	(envelope-from <linux-sctp+bounces-1291-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 16:24:22 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5B26C6990
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 16:24:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ghto8w2p;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1291-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1291-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C8572301AB91
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2C13672AC;
	Thu, 25 Jun 2026 14:24:09 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A46D36827E
	for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 14:24:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782397448; cv=none; b=nkM5BY09cWhTrFHK+ClZ1Ri0znGLMgSnowrudWKHCfYYAXQUhOaVdxLMa1vGuxJLPE4KADj2FSQSsSBpil5JPi1q/9ntrJsN80F+RJZRr9Xdh9sCc3r8kBe3HSQPOYADFFl1iCq8qcp22V2DMzL3l7Mi7FaAIAS+rDiagJVK6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782397448; c=relaxed/simple;
	bh=rCIrhKaVvNsvBmWDzhf3JByNk8xelVBOQxmn+E99qrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CBCJ+P7mB2yyYrtIHZLLLKeHE3AhaZYdKnnnF+7fCZsV9fpppxijYn8P/qgfeQ+cV3A9XI1bdudX4V17Hq6k/Xtb32dGqdByGSYhrmcftsCGYgNR9pSmEFyhhrk43bYZlTIaHF+QUcBt8cgJcllgbrPQXT497G+AFmVcMasKJHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ghto8w2p; arc=none smtp.client-ip=209.85.128.43
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49249072f03so13489195e9.0
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 07:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782397446; x=1783002246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c5/8DfMwYFHn82COsAU7YI6hnYfW2lO8oL7jTwFmEsY=;
        b=Ghto8w2pcGq+cRzAObj7GCDoVMbUEAvzA6ntf+vY8mkbNiDM/qudMiOwuhqJvM454j
         /8wk5nqFlPLh7OYgkqiioPuB+3+AnMLuudH7SWj1ZxhWEOXzM7CaNQXekRv8sNOBoY89
         BewZ7JzfJXTw81xXYUVOg1YfQY2QWf4Oy4F2LooKSyobNtp/R3J7qzl5cHkKZuCQSPl2
         LAqOChn5OsQJmWcIGVdYddLtLke2Ya+K/RHphKUvCXlhHS9Df3p/FIQ9yMCwCc0WbNRw
         /EiP2BO19FibKD4MivPAWZSnBKCApenhIXk27wWT4F8eh1mkA74mytVTZYH5nKiitFKa
         Pxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782397446; x=1783002246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c5/8DfMwYFHn82COsAU7YI6hnYfW2lO8oL7jTwFmEsY=;
        b=jih3+PHAbNZnq0slz3mF9fDn8E6mqgp7I3RbJGK7bW2Sql5zAdbsJWSyh/HUKipQ7Y
         9hIgn3oxMKiROvD2H69iJErdbKKKuXP3gb86i7h427tuUp1Mki681wC88yoDYH76x4BV
         /s3MGgxd+jfQBT14BLtjFsXgwFUVJe74/9LeSp25wz6+v2DDCZAcKjJ01cdij7K5oXe3
         8EAOO64uAjmsNnp26TR0M6TzvnBW0LK0aoFAeaqpmjXQCa1p2oW4fpsCzjJSKb25+rNJ
         Dy2/ZJhgdEL17qTNDGLLC3xBU/m5E9rSsB6ggqypVFeQQzqKuWdxyBxEwQ7c+YN0S4WV
         2Cdg==
X-Forwarded-Encrypted: i=1; AFNElJ9oKnllIsaClHXhTJNdrXgLadI1V1x9SroCT4N48a10cthtVCnBUbzSVVNne26ngCOW3Tg26IrpPSEH@vger.kernel.org
X-Gm-Message-State: AOJu0YzVp6Xrkk8B22i1Ndfx7tDqy03HAoKKxbt6ZPhtjfVcm0Pe1ZOv
	ox+QgIQr5BwX68mBivn1u/mV9uNVDBLO8jG1dWI5Y8OfCuZyMong3Aai
X-Gm-Gg: AfdE7ckp6gFkote/+veCpBvJ0zH/1gXqHAHQy//myPQP/mgOhTrA/Mno/OkjReageRK
	h0b2wWcSQt9mKv0KR7Zd5dFukdUyXuaD3Yci1jmFHz5mzC9Ovan1S5MvGq4Hu5Yx7MiK3mN/7Lp
	519kBynoJA2MQuBTUFEzuxV1gXRRjxaCN0IhXgUDZmhaAiqQKpGdBUpTEKs5LpMrBbjqW/TmH1U
	L9NXgbuNobNu6Jw+dGWrB8h9lGDtej9WrLv3t5AeA6PkoZJjMTe4RA6kQ51NyNHVoL6mHznVc6N
	dP65tRnbD3LiLOUCItYLjvPKhW+bD7sSnn/cfN1e5w6Yzd4NiP6+PzKMHFi4x2kOk/D9AG97DBH
	y1dXc8Nzz60nNHxOwJKShsi7lr4dYgd633rI7A2BjQPaSPi+GYZ178Y35qP2+n37kEdOZMNlm/f
	JPmrELlIGoVoH7R/pALgBQ1j6viw==
X-Received: by 2002:a05:600c:8b25:b0:492:40a1:1e16 with SMTP id 5b1f17b1804b1-4926684a70bmr39636275e9.8.1782397445676;
        Thu, 25 Jun 2026 07:24:05 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268fc0d36sm1997075e9.2.2026.06.25.07.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 07:24:05 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH net v2] sctp: fix SCTP_RESET_STREAMS stream list length limit
Date: Thu, 25 Jun 2026 16:23:54 +0200
Message-ID: <20260625142354.2600-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1291-lists,linux-sctp=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:alhouseenyousef@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE5B26C6990

SCTP_RESET_STREAMS carries a flexible array of u16 stream IDs, but the
optlen clamps treat USHRT_MAX as a byte count and then multiply
sizeof(__u16) by the fixed header size.

That caps the copied and validated option buffer at about 64 KiB, which
rejects valid requests containing more than about half of the u16 stream
ID range.

Use struct_size_t() for the maximum struct sctp_reset_streams layout
instead, so the bound matches the flexible array described by
srs_number_streams.

Fixes: 5960cefab9df ("sctp: add a ceiling to optlen in some sockopts")
Acked-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
Changes in v2:
- Add Fixes and Acked-by tags from Xin Long.
- v1: https://lore.kernel.org/r/20260624122213.4052-1-alhouseenyousef@gmail.com

 net/sctp/socket.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 66e12fb0c..b8f13044a 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4111,8 +4111,9 @@ static int sctp_setsockopt_reset_streams(struct sock *sk,
 	if (optlen < sizeof(*params))
 		return -EINVAL;
 	/* srs_number_streams is u16, so optlen can't be bigger than this. */
-	optlen = min_t(unsigned int, optlen, USHRT_MAX +
-					     sizeof(__u16) * sizeof(*params));
+	optlen = min_t(unsigned int, optlen,
+		       struct_size_t(struct sctp_reset_streams, srs_stream_list,
+				     USHRT_MAX));
 
 	if (params->srs_number_streams * sizeof(__u16) >
 	    optlen - sizeof(*params))
@@ -4598,8 +4599,8 @@ static int sctp_setsockopt(struct sock *sk, int level, int optname,
 	if (optlen > 0) {
 		/* Trim it to the biggest size sctp sockopt may need if necessary */
 		optlen = min_t(unsigned int, optlen,
-			       PAGE_ALIGN(USHRT_MAX +
-					  sizeof(__u16) * sizeof(struct sctp_reset_streams)));
+			       PAGE_ALIGN(struct_size_t(struct sctp_reset_streams,
+							srs_stream_list, USHRT_MAX)));
 		kopt = memdup_sockptr(optval, optlen);
 		if (IS_ERR(kopt))
 			return PTR_ERR(kopt);
-- 
2.54.0

