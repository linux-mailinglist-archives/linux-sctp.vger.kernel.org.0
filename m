Return-Path: <linux-sctp+bounces-1227-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAEOHIYsHmqohgkAu9opvQ
	(envelope-from <linux-sctp+bounces-1227-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Jun 2026 03:06:14 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F018626C7B
	for <lists+linux-sctp@lfdr.de>; Tue, 02 Jun 2026 03:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0519300E72B
	for <lists+linux-sctp@lfdr.de>; Tue,  2 Jun 2026 01:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF8330D25;
	Tue,  2 Jun 2026 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfv77ot8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27C432F770
	for <linux-sctp@vger.kernel.org>; Tue,  2 Jun 2026 01:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362370; cv=none; b=F+ZHYGWhKlQON5UPy5RB5gu8SiCPNhAqIvdytJJOUR/LPYSjgu2y7IqUcPF9BeIz3GbzktG1AYTR7/dzMLCqp6QZws26+uQDYCgFP+XeeRAkwnM61n2n0N9E1f+FcssDD2iNaaRv9PkddTUvj156HRxf3RnC6OOSpjn/KkUFy5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362370; c=relaxed/simple;
	bh=SPuNjNp8A0Zl/TJKGXESaD4k1bO4yqVtv1eunXpANEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xu+gaQUSqTMwVTp23tiqo+8sbTTw/aD2vHBNDTTZD/rGA4ZA8rxnrpXW8eQZZqFSXvmZZyTJQTABQXuOETs4q3keKH+Zc+0zCArrzEePjEHbidEblSKA2muql8YY5asTFSd78B5r3hKFLt8ba1Tim8fQz9hd2PSWoHcdLGeKHw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfv77ot8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9157b895c57so10618485a.3
        for <linux-sctp@vger.kernel.org>; Mon, 01 Jun 2026 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780362368; x=1780967168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MSDNDfUs/NxbWcXNNg7qyqWhJd8aRin4937n/eP10yc=;
        b=kfv77ot85zAVXhQ5OH78csxA7j4d+qXUh/UZSGEfj8bt9V4LfkT3DDqkTh0OLELzl1
         rLJ7yi1InCnB/Qr/C3sKteS3BWWgYnaqQeO9LMg+/NF/p4ixb4A7QG9dVvmPenqxrA8/
         Wc+8/N5d3bkmzhvJtO5RAYpDpAHWBIX16H+00pWoccaPbgwUF7Qucm4XTiXQLaGMuuRW
         CdGpNEGlLXkTnWFNKwZrOJTmHiYfDA+kzAysh+ov2qgB0Shkbv4wkTUutLQWeulP+EMb
         RzI0Rx77Y2jxul1zQzGesIwf671gy5DzrJLh/E77GLfAeytdl1NfyA1UizRq/bWlSvFY
         P96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780362368; x=1780967168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSDNDfUs/NxbWcXNNg7qyqWhJd8aRin4937n/eP10yc=;
        b=bvhquTNAGgigK31HCcYOF9vHRHFttKfX1LXKq0PvVE9idf2uRIENU0DthR+ASR7RiX
         +UBft1uTfEIiWb+irr75ptkYJhzfmY4K1bDC/0FR5Sdj482GSy0mwTsmgHJ0TBIT4XnS
         l79ep5S9U0yyUra4YETTkMdK1luUL5TTrfp1UburB/WXh/qGaXduy9HMwyJtfGMB5HQN
         5DJw5TSbK5RJcjlaYdbZcEWZCa3Pn8HfCv3Ha5R5kJgvGWBBMu9wcNy1vPQkda1C0Odn
         S7UfwOXc4q/gcdmCj/V77I6JLLOxHGto1nTxDi30HfjzkF4dsNrdS4RdH5u6sPOvgtQJ
         VBoA==
X-Forwarded-Encrypted: i=1; AFNElJ9UNAGBopjx5HqbP0zHOtyhi/R9CgLVJ3mmOV9MLXH6UZSX41vUhuTxsg+yBgq+SblPzkQPFDqwR2uc@vger.kernel.org
X-Gm-Message-State: AOJu0YxH8nrQGaTXvjGXPrSxc6I+7J8l2tuJcN1RGdoLvp+aunYUxP0f
	vcXdDZexi1BtQSTqUbcx26JT0hqhDQUoV+YQYxLjbOt6y9+6kFThUopt
X-Gm-Gg: Acq92OHIVjPs83mrk7ppXiisp5gc5BJ+pl4j6vAFGMcMFsfqufC1rmZLyj+1v5/XAh+
	D1dazfECcX+SYzXCzuFT1BuJx4krTCmnrvieDyOxF+oO8oeYGqnCJMYR6YrSzjVPNybezQbaZJU
	tf1kic7/teMx9ZvYymw2aKN0fU1t03xNyoqeFu08rG/lb5tlkdXBEgndm/VdfyKGYfuAN1vfz6j
	sM3TE6xi0fCZHR59Gt+V0CXeha+tqnDL9Whjf8EbDzEzaWU0/fA7FnHQkT7xn9l5FIWMrWSEdZR
	tXNMSiQzgn5izMDbLfRA8zsbi+8S/CINVDbXabeN6DuD1ITJDZw0sV8DDjrCKCO6ay/Be3YthOa
	efuCuf95yYdLGFB+8XVP6dw0s06h3TkxJqIFsZkb9vY5L42arqvXJ9KCwQbb9mndsMmuDWKIGkw
	7N0p/QYCn6qW1rRXLqOF3sXJ5nN0G4Htdey5+aeOt86s+8IKR9uN5Rn5PdgNhL+zjF9SZT1kN0G
	0HUuSgbVDxQo0NNo/6acfGw+1eiavmahY95z2B2BImw3Et6piaz39j0/YbJWQIKQ9UwOrjSZRw5
	EBbOeJS8JKI=
X-Received: by 2002:a05:620a:a28b:10b0:915:2404:bfe9 with SMTP id af79cd13be357-9153d96abf4mr1604595085a.9.1780362367772;
        Mon, 01 Jun 2026 18:06:07 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153244de53sm1190856485a.8.2026.06.01.18.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 18:06:07 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Brian Geffon <bgeffon@google.com>
Subject: [PATCH net] sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
Date: Mon,  1 Jun 2026 21:06:06 -0400
Message-ID: <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-1227-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-sctp];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1F018626C7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a listening SCTP server processes a COOKIE_ECHO chunk, the cached
peer INIT chunk embedded after the cookie is parsed and its parameters
are later walked by sctp_process_init() using sctp_walk_params().

However, the chunk header length of this cached INIT chunk was not
validated against the remaining buffer in the COOKIE_ECHO payload. If
the length field is inflated, the parameter walk can run beyond the
actual received data, leading to out-of-bounds reads and potential
memory corruption during later parameter handling (e.g. STATE_COOKIE
processing and kmemdup() copies).

Add a bounds check in sctp_unpack_cookie() to ensure the cached INIT
chunk length does not exceed the available data in the COOKIE_ECHO
buffer before it is used.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_make_chunk.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index de86ac088289..85264862fb6b 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1730,6 +1730,7 @@ struct sctp_association *sctp_unpack_cookie(
 	struct sctp_signed_cookie *cookie;
 	struct sk_buff *skb = chunk->skb;
 	struct sctp_cookie *bear_cookie;
+	struct sctp_chunkhdr *ch;
 	enum sctp_scope scope;
 	unsigned int len;
 	ktime_t kt;
@@ -1759,6 +1760,10 @@ struct sctp_association *sctp_unpack_cookie(
 	cookie = chunk->subh.cookie_hdr;
 	bear_cookie = &cookie->c;
 
+	ch = (struct sctp_chunkhdr *)(bear_cookie + 1);
+	if (ntohs(ch->length) > len - fixed_size)
+		goto malformed;
+
 	/* Verify the cookie's MAC, if cookie authentication is enabled. */
 	if (sctp_sk(ep->base.sk)->cookie_auth_enable) {
 		u8 mac[SHA256_DIGEST_SIZE];
-- 
2.47.1


