Return-Path: <linux-sctp+bounces-1306-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /CR7Hqd/SGr9qwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1306-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 04 Jul 2026 05:36:07 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E527068A1
	for <lists+linux-sctp@lfdr.de>; Sat, 04 Jul 2026 05:36:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="THW046e/";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1306-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1306-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86B27300BEAA
	for <lists+linux-sctp@lfdr.de>; Sat,  4 Jul 2026 03:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC635B63F;
	Sat,  4 Jul 2026 03:36:02 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1527D2749DF
	for <linux-sctp@vger.kernel.org>; Sat,  4 Jul 2026 03:35:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783136162; cv=none; b=qA9gUWx1TnnzPof5+3tdFPg7QjfpcDwVLGMtb3Uv6diwmx2lHSfrhurzqUMNP8YR00JXZxhqkUlp8qPicTMBGMOJGLJ5A+3i7HrVkyyK04Cpr3mOIchBJOlBjaRaES+n5XcO5acgBZV6R1EiGrAfqzYXvTKdsL+pAoNtoORZETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783136162; c=relaxed/simple;
	bh=ThuPvzUSoYy43zilZk9Przuhu7j/1v83Yf48qsTni30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uA7iPAX0vw4CLODTRw0qP3SsKfDedG8B1GXO69iahNymuJnbeMleZZ9dCQ39VscLIdprP5y4OrmLnpCn7n3LmtYbHNKDZHhlApDwxIBxxS93teaMyrrg9vh841OVOUrWjMsj7Wmo4BCaNYYJJcwzMpWfLX6wTM4YjnZ0DEwvkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THW046e/; arc=none smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8478a25f268so729033b3a.2
        for <linux-sctp@vger.kernel.org>; Fri, 03 Jul 2026 20:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783136159; x=1783740959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=troEzZKmFC4zyspQLdq3bYm3HWpLnTsTSmm94slF8L0=;
        b=THW046e/WRq56mbmEGdJWLfhVVqPPBVG4C8nsaSrpSgPLeXWyv4mexUyYGMjOnDs4U
         QQQW0YCX5Maiq9TCoKzETlAUjwEig1ZkvYjsAuBgyjigaLLa5CwIpB7OxLTQ6nLU7449
         pxCZzsI30B+5BFm+aHlTEHA7X3KBBHgr2P3n1XZW5PE4QdXSbQEN8vY/0Khk2Paz2M9H
         7CwmNpVT+JhqxZneq7R30nBTwUu5ZOySquhRLthVAwKFB1Bq08zWPI5NpXZH45cjjAUB
         ycOIeOs4Lu3doNysvUzKpxCQzjhKKRCFhFGoErzF1bWmzLfP/3L5pbA2HelD+lbd/5Jo
         97jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783136159; x=1783740959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=troEzZKmFC4zyspQLdq3bYm3HWpLnTsTSmm94slF8L0=;
        b=CpQIBIsBtoeh30fGC4CS1EhrKv4ftULNA0DOM28Nz46a4ryemOCvSXDwg2zeERWzQc
         T78OBlqq5Do59H48hEP3LZ5rtNNcq8NMFE3REvJq7XR4N8/Kh6Y71wmo0KDGWS//gVJS
         QRxUIznUm86YIJ3tRQSPMhaIYssJEqq/Qz2R89UkTGRz3de5ZHwTXiDCcHmx6US4NQto
         H1NXwrF3e8NW3+vgqn6793DXVGRN01hVt4gwaWOB92f229uYmpIXENdW05qUBuAOlvg5
         7X5C4hVdiNIxRdrPm/roBQ3rh5nYtsaQNHkvkaf3yXlF8wsbkYtMqy9QIiP/6o7YDHwN
         wLWw==
X-Gm-Message-State: AOJu0Yzdlbdh7fJO3ybdIa6ZMmL4ens1Z7F1WDJgdXGBdz9F/D9sh6pT
	3+ege3laB28YsSkPvnMamPLTZQtB7vcGN7D89frvT9/03SbMnXJ2JgmGxtESQhuZfus=
X-Gm-Gg: AfdE7cmEQcuS+4xw/eFXad89wmhEkSa9sGdyHEE0LInDEbSdvf/i1unVjDBLHgwtxMT
	FQeJWqDpYCzsrV7uy9wOuuGAKl2b9xxZZEVte2372J/Umz2ESV01vze64oA5fCDqJWGhLEQZWKv
	b6ByH7nKFrloceHF8tkZIDtEhikCnk0KfRomPLz/A2wDbERVQJbXaNFncP4a4p9V16bUgjED80n
	UI+hr1+nibL01Vs1XQwli4VCKp74Csvbpb1h4LcXS0xe6DsnBZpSs3Oc/AGycuvv52LLQMOS2HF
	wqkI89C8u391e91qEDid4ot63/436w+4sQH0zwtCc1on5F6VEWRHq5qFMzLBttLv+hdTD8hoXIw
	h7nBaDFEZnMpLRBqQjROeE9QdRQX8PdEvOux+29UaRz7ddgai2+oh/FSGUqJOtweaXncItKieQY
	viZz6Wd0SHZ3ruUjy8jKHGm0zcNnp539SJkCW9HnCCnwfB/7HmIco5njWOsw==
X-Received: by 2002:a05:6a21:1507:b0:3bf:9fe1:c24 with SMTP id adf61e73a8af0-3c03e1eeaa7mr2184488637.2.1783136159260;
        Fri, 03 Jul 2026 20:35:59 -0700 (PDT)
Received: from fx.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f1595e912sm26868465eec.31.2026.07.03.20.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 20:35:58 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: linux-sctp@vger.kernel.org
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: validate STALE_COOKIE cause length before reading staleness
Date: Fri,  3 Jul 2026 20:35:46 -0700
Message-ID: <20260704033545.2438373-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,asu.edu];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1306-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-sctp@vger.kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:xmei5@asu.edu,m:bestswngs@gmail.com,m:stable@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72E527068A1

When an ERROR chunk with a STALE_COOKIE cause is received in the
COOKIE_ECHOED state, sctp_sf_do_5_2_6_stale() reads the 4-byte Measure
of Staleness that follows the cause header:

	err   = (struct sctp_errhdr *)(chunk->skb->data);
	stale = ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));

err is the first cause in the chunk, not the STALE_COOKIE cause that
caused the dispatch, and nothing guarantees the staleness field is
present. sctp_walk_errors() only requires a cause to be as long as the
4-byte header, so for a STALE_COOKIE cause of length 4 the read runs
past the cause, and for a minimal ERROR chunk past skb->tail. The value
is echoed to the peer in the Cookie Preservative of the reply INIT,
leaking uninitialized memory.

sctp_sf_cookie_echoed_err() already walks to the STALE_COOKIE cause, so
check its length there and pass it to sctp_sf_do_5_2_6_stale(), which
reads that cause instead of the first one. A STALE_COOKIE cause too
short to hold the staleness field is discarded.

The read is reachable by any peer that can drive an association into
COOKIE_ECHOED, including an unprivileged process using a raw SCTP socket
in a user and network namespace.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/sctp/sm_statefuns.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index d23d935e128e..3893b44448b3 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -74,7 +74,8 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 					const struct sctp_association *asoc,
 					const union sctp_subtype type,
 					void *arg,
-					struct sctp_cmd_seq *commands);
+					struct sctp_cmd_seq *commands,
+					struct sctp_errhdr *err);
 static enum sctp_disposition sctp_sf_shut_8_4_5(
 					struct net *net,
 					const struct sctp_endpoint *ep,
@@ -2529,9 +2530,15 @@ enum sctp_disposition sctp_sf_cookie_echoed_err(
 	 * errors.
 	 */
 	sctp_walk_errors(err, chunk->chunk_hdr) {
-		if (SCTP_ERROR_STALE_COOKIE == err->cause)
-			return sctp_sf_do_5_2_6_stale(net, ep, asoc, type,
-							arg, commands);
+		if (err->cause != SCTP_ERROR_STALE_COOKIE)
+			continue;
+		/* The staleness is only meaningful if the cause is long
+		 * enough to hold it; a shorter one is malformed.
+		 */
+		if (ntohs(err->length) < sizeof(*err) + sizeof(__be32))
+			break;
+		return sctp_sf_do_5_2_6_stale(net, ep, asoc, type,
+					      arg, commands, err);
 	}
 
 	/* It is possible to have malformed error causes, and that
@@ -2573,13 +2580,13 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 					const struct sctp_association *asoc,
 					const union sctp_subtype type,
 					void *arg,
-					struct sctp_cmd_seq *commands)
+					struct sctp_cmd_seq *commands,
+					struct sctp_errhdr *err)
 {
 	int attempts = asoc->init_err_counter + 1;
-	struct sctp_chunk *chunk = arg, *reply;
 	struct sctp_cookie_preserve_param bht;
 	struct sctp_bind_addr *bp;
-	struct sctp_errhdr *err;
+	struct sctp_chunk *reply;
 	u32 stale;
 
 	if (attempts > asoc->max_init_attempts) {
@@ -2590,8 +2597,6 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 		return SCTP_DISPOSITION_DELETE_TCB;
 	}
 
-	err = (struct sctp_errhdr *)(chunk->skb->data);
-
 	/* When calculating the time extension, an implementation
 	 * SHOULD use the RTT information measured based on the
 	 * previous COOKIE ECHO / ERROR exchange, and should add no
-- 
2.43.0


