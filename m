Return-Path: <linux-sctp+bounces-1197-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIC0Le0l7mn0qwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1197-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:49:17 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E54A46A6EF
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61208300E611
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 14:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E12366816;
	Sun, 26 Apr 2026 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drDRW9oD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA72314B66
	for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214941; cv=none; b=iT4LlqS8vto476csdMWg6c1TRTnc17VeuSbfwZrQlBEdfOh6+RjfSkf63V1CiIiULLoj3GnqtJR2BNX9lrkJvKv9Xnps9TkfIG+wCQKivPmGpEm0feUd1AIKuXjf07W/ZdhqFexPb6OoDFLF6s8kmq9Udf623xDjFwCjeijKUPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214941; c=relaxed/simple;
	bh=EzaF9ukZm+IAKve3Rcdx43rJkgsEruseuaZXvOJfxUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSOPoLr/FZYMy4n6J4j//Bblcu7FxNfaD2PBIfmZ5UtQFyG7RBxyVxgKvvi6Q42MsLNaUlfDrOyFeHJNHIUaiZb/u0AexQvZLjBZ9LfANFMExXizppAviciE6F/Tnya0QtyH+210DOq0r5GuKYJVduOix4K1xzxM08/KYaeOaeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drDRW9oD; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a58057d7baso113209106d6.1
        for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 07:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214939; x=1777819739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pagQ43wFSn3iS5OfTh2ag4EpAzA+S21IQdQp4DAN0tc=;
        b=drDRW9oDKstVlaxXvZmK7xt0hNw0a+hWj1qkNKcTFwMMcBlivtzWqtXDFHf0fcpr8U
         Jium+jf3yPX1QcY1TGs9u9XBni6BmJeQJk10fGoZdtJQSg0+hxXuwU4DPS5CL9S7jDWh
         KkflcSraz8MADhna7IscqciRiJUSLDDNsNRKWFMOtSDxfQAelGM0Y/XpFqRnQut2sDtF
         TEBhq4je2/DXQpy8vvelvtroAQ1Fso2P9cmqQL6XZ0I/Wg7mb+GbQ43SF1eN+C057Tx1
         6S9QE18KAIOkfHJup+ksoRGDBPlKrKDSrXCju+YoSRfWZxXCrP6Dm30G6q4sEleLcefs
         bmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214939; x=1777819739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pagQ43wFSn3iS5OfTh2ag4EpAzA+S21IQdQp4DAN0tc=;
        b=BQrO0H+Lbruj17LZFXnV0DXRGKBxccGdZJR9nQCgv2C0lshsKdIc45y9rTJkAt1Sz6
         DjLwDCYclksz3RyAO2biePweKEeddMEibpzWedEq7ONs0Lr3VwWd9y8k9YM9hHsYLewv
         nI7lhk89vboYU40qvqbaqjBXAPgVEDoUa9wjcdQ0EmUNFZDH/foBXQuhlKlsmd0rynbU
         5ONwVf53MWasMUan1xPlo1rE6YNYkoLgVHilSTKEvY8lk+eyG6AhuAdSB6Lsj6O8faqs
         X95QuTbOUs616287vH3AGbO+4BNCew2amIl/rKNz6hnP5ZA5xdww9EiqHXkdQkL8+pI+
         LAhA==
X-Forwarded-Encrypted: i=1; AFNElJ+9IBJcoyXdEGivaqzATJxWPpKa7UJg1SgJAbAT0tzsvCgU9ZLqL8DebqvLt2BRu5i36b1AFjbefMNN@vger.kernel.org
X-Gm-Message-State: AOJu0YzPL4TAfR177GW1BPKisMSGtA1jTz61PJbPhqlS1MlYNtKKxaVX
	0jb4ljX5M1J6jqQ3MnGKAnGIWwg1Ok8ZQUZk5dHAS37ECZxg4IiKnuqr
X-Gm-Gg: AeBDieslHcRvcCbluQ+YqH30WTTbVnrbiJQaem/Y4Wj+LMVMiHzFza5X4DfGRqAlIMF
	LIsiOCoFMgxIDfhK+kmKMUj7p5zMNZr93ghyYm6aC3W9OdvAn9974nZNmHCWcxqBKsQYc8Qspp+
	XSU97VmPSkDTR5FHIy3Qw8tm02VjTrnjFyolKJl518sAGojITe6zeo1ocJ7uWPayFHfYktwiUsL
	VQVwNKJ1diXQRtD9gWv1P9XnxgaMD0h8/5nMOEedHVRnUVRXKgQyw4MIAvwKpYlQX+XiUaWXAFz
	nA9m2HaM7MtGSAmsFiVkQyOe//ABVg9kf5OS+Dld8Ld9nf8n4wdWGZIbaRYPZSwbJYq9UQdsHVl
	+DVBSLU35ef2yInhG+BDP56VkITNo5gtPEqRC38Rt+EZRssb7Ls99SBvns118qNb9It1NFHyPed
	WQy0qMru+iYnXC4vAU6IdcomOo4YdL/c/7zEUEELx2Akge+IIs3ug8zTf6Bt8oBv4UmlC1szD/X
	XNd5WuHW7qBC1eRHD6GyiJHcDCEpQGZP96xnNpGCc0fFA9w+59XZQNHCNO3aGW5BL2EYk+pF5Y=
X-Received: by 2002:a05:6214:43c8:b0:8ac:b1ad:3a1f with SMTP id 6a1803df08f44-8b0281108f1mr602566766d6.35.1777214938809;
        Sun, 26 Apr 2026 07:48:58 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm232579146d6.48.2026.04.26.07.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:48:57 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yi Chen <yiche.cy@gmail.com>
Subject: [PATCH net v2 1/2] netfilter: skip recording stale or retransmitted INIT
Date: Sun, 26 Apr 2026 10:46:40 -0400
Message-ID: <ee56c3e416452b2a40589a2a85245ac2ad5e9f4b.1777214801.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1777214801.git.lucien.xin@gmail.com>
References: <cover.1777214801.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E54A46A6EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1197-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

An INIT whose init_tag matches the peer's vtag does not provide new state
information. It indicates either:

- a stale INIT (after INIT-ACK has already been seen on the same side), or
- a retransmitted INIT (after INIT has already been recorded on the same
  side).

In both cases, the INIT must not update ct->proto.sctp.init[] state, since
it does not advance the handshake tracking and may otherwise corrupt
INIT/INIT-ACK validation logic.

Allow INIT processing only when the conntrack entry is newly created
(SCTP_CONNTRACK_NONE), or when the init_tag differs from the stored peer
vtag.

Note it skips the check for the ct with old_state SCTP_CONNTRACK_NONE in
nf_conntrack_sctp_packet(), as it is just created in sctp_new() where it
set ct->proto.sctp.vtag[IP_CT_DIR_REPLY] = ih->init_tag.

Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index 645d2c43ebf7..7e10fa65cbdd 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -466,9 +466,13 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
 			if (!ih)
 				goto out_unlock;
 
-			if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
-				ct->proto.sctp.init[!dir] = 0;
-			ct->proto.sctp.init[dir] = 1;
+			/* Do not record INIT matching peer vtag (stale or retransmitted INIT). */
+			if (old_state == SCTP_CONNTRACK_NONE ||
+			    ct->proto.sctp.vtag[!dir] != ih->init_tag) {
+				if (ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir])
+					ct->proto.sctp.init[!dir] = 0;
+				ct->proto.sctp.init[dir] = 1;
+			}
 
 			pr_debug("Setting vtag %x for dir %d\n", ih->init_tag, !dir);
 			ct->proto.sctp.vtag[!dir] = ih->init_tag;
-- 
2.47.1


