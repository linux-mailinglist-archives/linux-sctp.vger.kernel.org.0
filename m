Return-Path: <linux-sctp+bounces-1235-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EgijNLW8IWpLMwEAu9opvQ
	(envelope-from <linux-sctp+bounces-1235-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 19:58:13 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 477BC642757
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 19:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gs17Tqkp;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1235-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1235-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 526D5300C82D
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Jun 2026 17:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0994A4C9561;
	Thu,  4 Jun 2026 17:58:10 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B506C4502F
	for <linux-sctp@vger.kernel.org>; Thu,  4 Jun 2026 17:58:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595889; cv=none; b=HSH5gdicAfo/9XVl0YiqZ3THoaMgQEWqC/jDjuZuxas59v/yArqjaQys583JeiNLssDk7HVmzfD0+puq9BZ9SxSMaopUy4UG1ItJSceTAj3+AT9nko/Y4Nwf4aMR8RIyylE6EhSX6G3EoYtGVl0oGslc4omEmF123rBcbVivhB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595889; c=relaxed/simple;
	bh=QgKf+3clhhMLNlggfZvWCRY5iz5ATGH7muhRFNw4wbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGAGQCZhAYXjgKz2DUtCe+RtmvxdMZtDNb3Dk0JjhmQsMme4gDowcd6JmJiNDIAb6OkYU5sqPv3Tb0fb11Z30hqyF/hLk8yQojoq4udBgs620VdA2Lfylx38cjWzlPL/MGHYXivYcNaMAuyW6X4JvpcXhNcQv6Fh7HYHEb/+7Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs17Tqkp; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91574384cc2so117577185a.2
        for <linux-sctp@vger.kernel.org>; Thu, 04 Jun 2026 10:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780595888; x=1781200688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2qQO5dPJpJPnmsYjavZ2xiv11ddii1u7KjXOe802ZBo=;
        b=gs17Tqkpe7H4tRM33lhFgoJhiitdUIk24IfI+FDCTBJTy19KIFT/6H++WiYWJbfCHr
         xIr5hmCSyWBh+d7P1r3EKgTfbqBcr3HzL6HLGMVPAW8N0XIzW+zpo8N2ZpHsyrZLQBQz
         w5+Qfr44orLZf4CODGigGAvRVhnOfwL6p8Csr+upT+ZvrZMvIbgZ/5fpHosYFPyNGz2u
         Od8pXuwb4jVxH7lmxPAew/ofAMiAWsnGTNGT+iNDecq3n7mAV8OoMxYdUWwO+eEK84SX
         XQGaJX9Nh/BaVUB0sGMJ8N2229XXkWWks5PZLqOuTaw6J5sJJ4F06lEcVuvKNItrnUWY
         7U8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780595888; x=1781200688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qQO5dPJpJPnmsYjavZ2xiv11ddii1u7KjXOe802ZBo=;
        b=IeWCHYV1fpWapJz8Y+abGTnTEFMsItispfnlEY5HeqppXPWfnCk0M3W2CH2oO2SaTa
         eeIPLXeGL6a1ZUWfltk3LlhYciZb+I3ISKkK+Kv44jvYQGXIuzchxj7tI4j8EPyR+FWr
         DrLPGrI8OZFHH62qnU96Gmc3BQwG+E2C6WAGA06J2zJ5OUbxalp8f6Yuo1fW26TdZNou
         3iLT1HmAsD60VIWPTYAoTD90by4LjqiVhH9CTWlp4CVgzFUrJXljIKPDE02m4Of+ty7L
         fvjG3vnxhzm2WabkUe/Kf5oUxVbt9A8MABCCMmaLrVjW/tiLjKOmD0lREQjiSMKv10kC
         lSlw==
X-Forwarded-Encrypted: i=1; AFNElJ8uU12zNDI54nQhtH2yDH3u8m/sQ/TPUTurU/CFtY0QweOhATkgpf8PIGEUW0uy0alN+tcv6eUQiGxO@vger.kernel.org
X-Gm-Message-State: AOJu0YxC8ZxVCw0o4CLIcB+rAUfFyDL0+GooOuibOeI3PoteZMHRcwul
	p3VveUiDWIindefDUwb92QnQ9gQvagx4ZQlOjKaTeiNsMuUyYbCaMj3L
X-Gm-Gg: Acq92OH6hsND+KuQYpCW9YBQYlFdytQkNlqXH10cm2NMTKAa5QmYUO85I0+V4zru7Mp
	zZm/zB5g2V7Cs/v1zp2n84uN2rNGoHWOoWuVK8DsIp8kLywSwXBKNJGJbss2UcQqXbCypUWTGqr
	BkZghO4+niZ0gggu4jqEfrv0HYApgekkW729ZjrSvDGQQi7H9dx8RxRNXCz/nGKhRY9VIPABDBS
	+4RG/1UXExXZj1m2jg1PjUX8GTxSJqpg42HnldvFqTn6WANYGwmdhjo+z6sXXWC3XRTqfQr9uhO
	eOIjeq/bvGZUfugSBOu4J9Ibbb3KexQqmqZB/sUxT3dywuGEBia3N72jllW2q4sjZrC3bhfqrAy
	yfBjKfiOASGpYW8orF6tNrizMCjyc9j2dox4Fec0iTKRto1EHh5lcW44eBodXqTXXZtVCaX3uwb
	0tFMveGj8vfri8DsA/xwyoVttyBi2Dh3ScVvO1C4uZz7WOLc2C8oUxu7IhxU29puaD1lM5fIRyB
	XlYUizj9DK0+XjBdfxdnuumWT4dJSc=
X-Received: by 2002:a05:620a:480a:b0:8c9:f8e5:9f12 with SMTP id af79cd13be357-915a9e0a7c5mr25895485a.57.1780595887710;
        Thu, 04 Jun 2026 10:58:07 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381abfsm650227285a.27.2026.06.04.10.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 10:58:07 -0700 (PDT)
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
Subject: [PATCH net] sctp: fix uninit-value in __sctp_rcv_asconf_lookup()
Date: Thu,  4 Jun 2026 13:58:03 -0400
Message-ID: <20260604175803.2142975-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1235-lists,linux-sctp=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 477BC642757

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
 net/sctp/input.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sctp/input.c b/net/sctp/input.c
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1196,6 +1196,7 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	struct sctp_addip_chunk *asconf = (struct sctp_addip_chunk *)ch;
 	struct sctp_af *af;
 	union sctp_addr_param *param;
 	union sctp_addr paddr;
+	__u16 plen;
 
 	if (ntohs(ch->length) < sizeof(*asconf) + sizeof(struct sctp_paramhdr))
 		return NULL;
@@ -1204,6 +1205,16 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	/* Skip over the ADDIP header and find the Address parameter */
 	param = (union sctp_addr_param *)(asconf + 1);
 
+	/* The whole address parameter must lie within the chunk before
+	 * af->from_addr_param() reads the variable-length address; otherwise a
+	 * truncated trailing ASCONF chunk lets it read uninitialized bytes past
+	 * the parameter.  Mirror the bound sctp_walk_params() applies on the
+	 * INIT path.
+	 */
+	plen = ntohs(param->p.length);
+	if (plen < sizeof(struct sctp_paramhdr) ||
+	    (u8 *)param + plen > (u8 *)ch + ntohs(ch->length))
+		return NULL;
+
 	af = sctp_get_af_specific(param_type2af(param->p.type));
 	if (unlikely(!af))
 		return NULL;

