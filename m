Return-Path: <linux-sctp+bounces-1345-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3w/rGSkAV2qlEAEAu9opvQ
	(envelope-from <linux-sctp+bounces-1345-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Jul 2026 05:36:09 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4826D75A517
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Jul 2026 05:36:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="DNnqsjS/";
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1345-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1345-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5BA3301D60C
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Jul 2026 03:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879A142BC3D;
	Wed, 15 Jul 2026 03:36:02 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0333AF64B
	for <linux-sctp@vger.kernel.org>; Wed, 15 Jul 2026 03:35:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086561; cv=none; b=cerfeY/TkfAyf5lGmEqwbFg1hlQNE1NSe02mbsB8m5OBAVl5Hf4zwnN63KnnweM9T35o6urlMll25y5n8pgbNvfQz0WzmrQfJ+ohnCOKjAihaREk+uEUi+GYrm2ch3hy6i+Crxl8+smV3DWmLTS6XfiUX+Wgear4HMOD2idiKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086561; c=relaxed/simple;
	bh=tl9QUY60ANTH63SkBkkbYRa0mh0qVb/cgU5n6BRSkZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMnOFccfIf/DlFsrt9NKkQ5kuzYZDFvhEJnuJLgLuSfvRXGjtqoVG1BGtCTkz7nxbNoQwtjcFnfxkDO9+/MmEyY2Cqg/WWvpUEyGzOLAViluNipMi7Zq1MGneJYRBZMiQQfpPcjyP7GDvMA+aPFVP5Eh6SPCe6FqYfgSaVvJb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNnqsjS/; arc=none smtp.client-ip=209.85.214.173
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ceaf8a1265so41224635ad.2
        for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2026 20:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784086546; x=1784691346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ymvDeDodxFq3HgKKLyUeM3rErvPvsmK6UFUvd0diOrc=;
        b=DNnqsjS/SImdPVPfjMWu7EObi0d4fFvdi6Qh/LoBCMXyzl6EC2z9KefqXjWnBTBo/k
         49qF5y4HmxaVTxTTsUnDB5CBWczBe9sl0fmax03fbyy1eGd8Wh49AvM5HgoOYXNbC4o4
         bfQAqVsfoksuVfsPqg8SvDSRBlo2UxdqaVuPs6V4LjVhcnNYU+S/RjmwBTNlHCajx720
         5cT+k/4qL+wt+37uCRMQq6+iQ6I9UlQ7YhCJReFrw7mT2xGGoWGRYBzNIJ9ewhodzSeu
         T/B4rZzBzPwxcKVOuHFtPJfBkT3btPaI4TmsBx40K9wJ4/Rw1gZ59kai9/+DHpMXVaPw
         dIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784086546; x=1784691346;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ymvDeDodxFq3HgKKLyUeM3rErvPvsmK6UFUvd0diOrc=;
        b=lLrz58+HUjmOtxEQsC8Pq6BwBCH/PstRyrcG+je6xz7OEcXz8k3fCPJK0IdXEFug4T
         xO3WC9gPdtJGMzx/PbTYTeayS1YOPrkBuCy/mwp82SVmp+fkLgiNL02WivwPkH5F8P/x
         s+7haZYD6I+AJ7o90eOGrnHqnlmdFxhzvbWPOg7N1W2F2y636Aq6gg7hHoR1Tvtkdhxf
         L7tR1dNitYw+bLtoD1v7GKgKQnOO1KgUo0fqXcgn+6HcwuRwg5a4PDtLmlCxexGjMKJL
         xtfOkdNCO/z/UVE56Q3c/YRfqR4EXMl9yW5IC91zVTQzq2vJyD0iEZ5An919T9Q/VspH
         LOdw==
X-Forwarded-Encrypted: i=1; AHgh+RrlZJVoW+XJUp9oWIQ33mYGzYLToaaEFFof4MZV2awZSQgIhvmgc3aXALSisuEsrcRnqveuIxoQSzBX@vger.kernel.org
X-Gm-Message-State: AOJu0YzCAXKgctanUCZX4qBIC4aTo/aM/M9x2N0swMNw4Z+SzFbaM3NK
	c01iJN2W2ho4CnLolZcr2LhK3T+Gs/Uzd1XdT1juiPFOh4y/+42Yebqd
X-Gm-Gg: AfdE7cnv/rHVo+7Sq3NFyAqqHbJYal8CUuQoJBDG9oFYe6tEgJuwBkHWVGmdAi6Tete
	x5rTl4VEwbKAwdvosTLbsTmJEQ+LEa7+V2QC1lWpNQnbpD6vi01pCh0I2ZQaFEh6z2vdaA79uz6
	67vAxxgvG9Lbgg4aWPSs6Ia1B6wPW++7TvhWRlsP6adKO50KlZv0WTDUkHNawiTrllFOupuzTx5
	8lx6Uhl+t3IPCi5iikxmtvYtvkDODuAflDNvgRnde4sVdhT6J8GWDPKe+010Ewr5G3FASkuKtRb
	t2ic9vh0S+qER/0vOitOm2P/LZGHfjNGPyUrseZ6CmhrqPHDsQ1d4P8pJOIV2+voGt+ymlFG7y0
	MGHrR0ZTpF5BAu2djYqLjYLmcBteIqOoqfqYD6Qhwp65wZ62hERuvnE1jOQPb7hadwAqGC9L1c5
	6+ip/TBuLTV3piJa9sMg0RmQiXTL1ruVX5U6m7gEKE3DsR
X-Received: by 2002:a17:903:2a88:b0:2cc:5f9f:54ed with SMTP id d9443c01a7336-2cef12fe180mr53236485ad.27.1784086546202;
        Tue, 14 Jul 2026 20:35:46 -0700 (PDT)
Received: from localhost.localdomain ([2404:2280:2000:8007:d87:748:d87:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm125464325ad.65.2026.07.14.20.35.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 20:35:45 -0700 (PDT)
From: MingXuan <omeux327@gmail.com>
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
	MingXuan <omeux327@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] sctp: diag: fix uninitialized stack leak via INET_DIAG_LOCALS/PEERS
Date: Wed, 15 Jul 2026 11:35:36 +0800
Message-ID: <20260715033536.64963-1-omeux327@gmail.com>
X-Mailer: git-send-email 2.50.1
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1345-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[omeux327@gmail.com,linux-sctp@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:omeux327@gmail.com,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[omeux327@gmail.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4826D75A517

inet_diag_msg_sctpladdrs_fill() copies sizeof(union sctp_addr) (28 bytes,
the size of sockaddr_in6) from each sctp_sockaddr_entry.a into the netlink
INET_DIAG_LOCALS attribute and then only zeroes the bytes from offset 28 to
sizeof(sockaddr_storage).  The same pattern is used by
inet_diag_msg_sctpaddrs_fill() for INET_DIAG_PEERS.

The IPv4 address-filling helpers sctp_v4_from_addr_param() and
sctp_v4_from_skb() only initialize the sockaddr_in portion (16 bytes) of the
union sctp_addr; the trailing 12 bytes (offset 16..27, the sockaddr_in6-only
region) are left uninitialized.  Those bytes are propagated verbatim through
sctp_add_bind_addr() (which copies sizeof(union sctp_addr)=28 bytes) and then
copied straight to userspace by the diag fill functions, leaking 12 bytes of
kernel stack residue per local/peer address to any process that can issue a
SOCK_DIAG_BY_FAMILY dump for IPPROTO_SCTP.

Fix it by computing the actually-initialized length of the address from its
sa_family (struct sockaddr_in for AF_INET, the whole union otherwise) and
copying only that many bytes into an already-zeroed sockaddr_storage slot, so
the uninitialized tail is never read and never reaches userspace.

Fixes: 8f840e47f190cbe61a96945c13e9551048d42cef ("sctp: add the sctp_diag.c file")
Cc: stable@vger.kernel.org
Signed-off-by: MingXuan <omeux327@gmail.com>
---
 net/sctp/diag.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index d758f5c3e06e..12557e924cc2 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -85,8 +85,12 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 	info = nla_data(attr);
 	rcu_read_lock();
 	list_for_each_entry_rcu(laddr, address_list, list) {
-		memcpy(info, &laddr->a, sizeof(laddr->a));
-		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
+		size_t addr_len = laddr->a.sa.sa_family == AF_INET ?
+				  sizeof(struct sockaddr_in) :
+				  sizeof(struct sockaddr_in6);
+
+		memset(info, 0, addrlen);
+		memcpy(info, &laddr->a, addr_len);
 		info += addrlen;
 
 		if (!--addrcnt)
@@ -113,9 +117,12 @@ static int inet_diag_msg_sctpaddrs_fill(struct sk_buff *skb,
 	info = nla_data(attr);
 	list_for_each_entry(from, &asoc->peer.transport_addr_list,
 			    transports) {
-		memcpy(info, &from->ipaddr, sizeof(from->ipaddr));
-		memset(info + sizeof(from->ipaddr), 0,
-		       addrlen - sizeof(from->ipaddr));
+		size_t addr_len = from->ipaddr.sa.sa_family == AF_INET ?
+				  sizeof(struct sockaddr_in) :
+				  sizeof(struct sockaddr_in6);
+
+		memset(info, 0, addrlen);
+		memcpy(info, &from->ipaddr, addr_len);
 		info += addrlen;
 	}
 
-- 
2.50.1 (Apple Git-155)


