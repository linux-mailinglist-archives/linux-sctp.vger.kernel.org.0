Return-Path: <linux-sctp+bounces-1240-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 64usH49pJGpp6AEAu9opvQ
	(envelope-from <linux-sctp+bounces-1240-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 06 Jun 2026 20:40:15 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7064E0B5
	for <lists+linux-sctp@lfdr.de>; Sat, 06 Jun 2026 20:40:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gsJClNQf;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1240-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1240-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C30030276A2
	for <lists+linux-sctp@lfdr.de>; Sat,  6 Jun 2026 18:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCF43B83FC;
	Sat,  6 Jun 2026 18:39:37 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDF3B8949
	for <linux-sctp@vger.kernel.org>; Sat,  6 Jun 2026 18:39:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780771177; cv=none; b=kaP3P2Mo+PPkGiTlLotdQ1fAUCe7uw9c2zMLfJp0vlNnQUo/sPOnMP3g/ivn3OP6Jbb8gB3s5yl4oRnLiul7UhLb2o6a02+mY+AFpwgM5QRG4Xts+z5dftIUFmrePCJRc4ICmpPwO9v2wTR9wRAFUUQyS5LPoBzTd63dl6bix/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780771177; c=relaxed/simple;
	bh=hoInznijmXNcAlLWUOC8ZbwHn/36szbur3eTTIq96ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bdnChC5M64ZQLxbScUDpde3TYhgUmyID/zr8Kv0JIH8bOGhRrBR7ah4HqjDEuW7PQIb6oRt/GzbKJ85jDWvrLLYv+dXW6sua4hkpKAdnLq55ImglBVjO50rFpsPvRIJvTQtAM3I0XmJHMoAiL0+A5cNUlsfG+eOnVTml+n0G2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsJClNQf; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9159f631656so351523085a.1
        for <linux-sctp@vger.kernel.org>; Sat, 06 Jun 2026 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780771165; x=1781375965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BtPhLti09zjexvIxGQdE7OP+nneYPm4H1afCVbrLWGo=;
        b=gsJClNQfbVPdCTWQ8XzPk+xuvph/vNCFedKaThvpTzTlY8q+d78d1YrEavVSGRv+OF
         1RQgfuvZ8oUY5q2z8ZdTz84rkWGpWJDs0EbSrjwwJoHDBbIqxRTT20BU12QzLV9c1GkF
         snch88O4yHo9Au0yMZfUvpd6Zku3WEiY72DR0um+ixIF1yl7rVbEP6UA535JzU3TGvbG
         79WoVyMHU6WihQJaRJCEFQRSdfs1ohKEseUvA4EMXH6LmADavdmazTRs/5/RrY1FLGkU
         ygNGRZ6GKZMe9vhhYJvKFvWzuG+n1n5HQVIphghy5c2WOaSVlrWKJWSc/5MhuIcejFP4
         OT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780771165; x=1781375965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtPhLti09zjexvIxGQdE7OP+nneYPm4H1afCVbrLWGo=;
        b=r3FD/tnCYRvI+ENFrbAUcxCfA4XTN3J7c1HnhUOcw/Q2rEuBIPpW7QDF4oNDuTixxg
         khxuHqfiYRZEbpocl5YJXKF2Dh78zr6KLca2fGWeJEiIE6g2A+2i4JLrIJ686TwfgGyY
         OAQaLXYD4AIVwxyKpCpeB26VLbLOKbEyui+Wwac0TXVN+/YAWJmAnte3qX+nLHl4Jtvy
         3Oo0fww+CP/nQVcS/rYgJt1wtW5JP5MA7Mp4NwWwNTpPeO9FP8igCycl8mrDN4QvrAyd
         NDPzpdrGRpDLzCCIzlJulR8hQsVjxGprtuYFUVT9N5xZU27VePNN80ERYjFV/x1Ffxvb
         y9Cg==
X-Forwarded-Encrypted: i=1; AFNElJ+Rl1NUDpkYlvZ34SL8JGeCp5KVAdV52Nhc8GiXAEdOXvcItcY8wHP6saQROpxzBvBM8FAJkrgJOPz4@vger.kernel.org
X-Gm-Message-State: AOJu0YyysH0B3nXJZUVYuNJDUlYEzx2TIRzfl1Mt2DFxj0+0XprhBM5e
	bh26nSHG/s6LgrQvmorTK5gTqqkyVgVug61+Sv0Z/qjR0UDJ/ycq8Oq3
X-Gm-Gg: Acq92OFyCnnIRcpcfrY1zUIrmNWXuziGjm4T9YMVk0EJ2xbB52l41ketZghhIPE7JGe
	TzZ1IDml6sEcGqK6R53eAoQEu0dRBzVBP99Sv7MVog4/oc9UzWEAFico835C34Zv6Kfc8g7jnyR
	UTf1XYbMdThaUarS0Cy4r9ycEdgStW2y+xXc/zHmKs8aB0+fwTS5wqJzQx0PNdVMIhxYmH6wlju
	XxJXdeeI1Hl943wC1jHoE8sdKoIiszwX94iy5Pw2cEe+jfNaw9I0UszgCaOR0SiZXGZ/ALveSz9
	CZ+ahvO1SfG2trzNtJMKPvlbTuQUFMJf+WHrmjWJ73uef84cWBv0hSOGQcvymdZRUyfQVkqDBmV
	eDWdVVXJGlc7iQmv5h69fxiuG+V8PXfht5Y6fna59z6WbZzNpa4SAviAJ8o030PBi8Fi1t7aUZd
	uPZbC5VEGnuvD8FGH+9q4ju5bGH6js5rGVOF0RXg8wclutA8DXYGKgLH9C+tFgDLxvqYpTiZIis
	3drF0xuF/dRhIjCRAulX3ufs05g7uY=
X-Received: by 2002:a05:620a:44cf:b0:915:92f3:54e2 with SMTP id af79cd13be357-915ad0a9f9emr1008248685a.6.1780771164573;
        Sat, 06 Jun 2026 11:39:24 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3d2384sm1223549985a.39.2026.06.06.11.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 11:39:23 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vlad Yasevich <vladislav.yasevich@hp.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
Date: Sat,  6 Jun 2026 14:38:21 -0400
Message-ID: <20260606183821.1688525-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1240-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[michaelbommarito@gmail.com,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2B7064E0B5

__sctp_rcv_asconf_lookup() in net/sctp/input.c only checks that the ASCONF
chunk can hold the ADDIP header and a parameter header, then calls
af->from_addr_param(), which reads the full address (16 bytes for IPv6)
trusting the parameter's declared length.

An unauthenticated peer can send a truncated trailing ASCONF chunk that
declares an IPv6 address parameter but stops after the 4-byte parameter
header; reached from the no-association lookup path, from_addr_param() then
reads uninitialized bytes past the parameter.

Impact: an unauthenticated SCTP peer makes the receive path read up to 16
bytes of uninitialized memory past a truncated ASCONF address parameter.

The sibling __sctp_rcv_init_lookup() bounds parameters with
sctp_walk_params(); this path open-codes the fetch and omits the bound.
Verify the whole address parameter lies within the chunk before
from_addr_param() reads it, the same class of fix as commit 51e5ad549c43
("net: sctp: fix KMSAN uninit-value in sctp_inq_pop").

Fixes: df2185771439 ("[SCTP]: Update association lookup to look at ASCONF chunks as well")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2:
- Regenerate from net/main so the patch has index lines and applies
  cleanly (Xin Long).
- Use unsigned int for the decoded length and compare it against the
  remaining parameter space after the ADDIP header (David Laight).
v1: https://lore.kernel.org/all/20260604175803.2142975-1-michael.bommarito@gmail.com/

 net/sctp/input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index e119e460ccde0..c63d42500aa28 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1197,13 +1197,26 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	struct sctp_af *af;
 	union sctp_addr_param *param;
 	union sctp_addr paddr;
+	unsigned int param_space;
+	unsigned int plen;
 
 	if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_paramhdr))
 		return NULL;
 
+	param_space = ntohs(ch->length) - sizeof(*asconf);
+
 	/* Skip over the ADDIP header and find the Address parameter */
 	param = (union sctp_addr_param *)(asconf + 1);
 
+	/* The whole address parameter must lie within the chunk before
+	 * af->from_addr_param() reads the variable-length address; otherwise a
+	 * truncated trailing ASCONF chunk lets it read uninitialized bytes past
+	 * the parameter.
+	 */
+	plen = ntohs(param->p.length);
+	if (plen < sizeof(struct sctp_paramhdr) || plen > param_space)
+		return NULL;
+
 	af = sctp_get_af_specific(param_type2af(param->p.type));
 	if (unlikely(!af))
 		return NULL;
-- 
2.53.0

