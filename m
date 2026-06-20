Return-Path: <linux-sctp+bounces-1275-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l9RBHoitNmouDAcAu9opvQ
	(envelope-from <linux-sctp+bounces-1275-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 17:11:04 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6148F6A90F1
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 17:11:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bvGxtRUO;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1275-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1275-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3AEF130046B8
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBA4396561;
	Sat, 20 Jun 2026 15:10:59 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AA6395AFE
	for <linux-sctp@vger.kernel.org>; Sat, 20 Jun 2026 15:10:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968259; cv=none; b=NzPXNvw/2cCa1+p0M+T6VJmMV2m1S81VXpZFHxtxgQjlGFJfQb0fOLboMknjU+p3MNSxG3mMHImd1Yvp1aM+Pkte7XWYw+wTFiC2lLokL+twJrjLu8OKi5aGZT2i5kLw37DQvmJmUOrYu/zCcBf6Xu+QUXd1aLg0gNvJMtnSpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968259; c=relaxed/simple;
	bh=nM9bCXK3N/lq6TM2lsXDXTNL1v0ITcN7gA/rt5hbbVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBggNanq/yi84U3HssgbdGBftEgRnEUx7HAPNTM2r+NgwRfo0cUm2/n2GqAI3IeQXqJKhpFtSKM5CEn+CojtX6eS5HrGjwZjziNaJGc9R1oEjjgWmi/hDeGxdsBGI5jw8cb0J+C4LUy1mEWZtQ6GKhZ6v7LoxaqDe/44V7fj3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvGxtRUO; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8dd74f90e3eso30838826d6.2
        for <linux-sctp@vger.kernel.org>; Sat, 20 Jun 2026 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781968257; x=1782573057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzA9ScnXVH8tConPvNNlqSftFL+N4sg+bX/Nnsu2/ck=;
        b=bvGxtRUOsZe+e8eNF/QSctuiVkQr0wqY0yr11iahe1v/9eO8zHEngMne5yci2Xq1y0
         aZVX0aDk0JUfuNbnC8FUG63/lW3M5MK96/X/uE3ORaPPR94OfliECDLKFk2xqzeB9GWN
         9epXEWrLTlcbl5pCNrWqsRSx5UVXj/amX4al1UVb7tcs7VVc0XgWRO4qM8PP098lfcBC
         Nz3/TrscUA230XE14bHTUyRY4iYmUGvAFrttgFrbJyHgUV+W2DFEaRrYqY1r88Tv4EGR
         kg8CEUONyPGpxIvy46Ilkfz0jlXCIQKTAH8sXw9Gcos4Q8iIZototLYS7aey83Xzit2f
         xZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781968257; x=1782573057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzA9ScnXVH8tConPvNNlqSftFL+N4sg+bX/Nnsu2/ck=;
        b=Yosf7vDyOdyzUuBGJR4c8AS/062byM0oLQhu2zWnfXbJAd8XC5wtjisfV+zzim3Jj8
         mdi2qktIjntxj6dhVkCVivsrfZPF1Mqlz+Rz4fzSZ+ot/hJjn+RAvwuJDQEcrkq2USIX
         Ir6uGn7EmT93GcUcq93EfzUaNsbmRB5kMWuoqW6m7sXSjmjcWzBzKCmZa5o5rGDHHEsp
         B04NKJippuV9opwY8Hz2hFj+FTKEMCHcMzEzXX1J1sh+7eJSmNWaWRBiRPpApOMRhuYs
         zKu5cMLfCsmcUMXbs3vXoo6Uk15rQgmLjEuoqfsLu8tE0/bXLuLzWiH9EcvXSmqirREj
         3cUA==
X-Forwarded-Encrypted: i=1; AFNElJ+Wkt5Yl36J1tc6RjAiQrhkb6bOnRQ8JWRlbW+ZXN+EE47r7ffOIHCP4gaiIIis8ldFZQ1G9OgkJWkK@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxdUabFNZRxFhbjIidgxAo6VMzLre+7418DLp7WVpX9WRYBnR
	pCkSXyDK13s9VDODAYUnecQj/JRwi9d0zRRXTlJ9MCSrYQH9hhbqcbNb
X-Gm-Gg: AfdE7ckYj4T53wtILApXj0sNSC4UBIYpB0VP8X2oBGyH8EL5SjYJSIW/LG0rxC3IKHM
	Ne4HFKVbERAD5pphI62W/Y6Fo8aalWMZKYG83o0xOYO3M5XGTtQJo7FTaxEB6WBj1BqCJk3+8oC
	nU6Hd1H2KSHfopuMyMzUoKk7r5kiOx0XoC8E74uOlydxf7SG8LNefb1m9tYkUU2RXz04emkSixG
	rqpVlDldRiWi98Zx9HPBfKy80iqAErYTHGgK3ms3yTSh1n2GmM2slsWbLjsVXTSlCNhfyUlosWq
	OTSuKO1uUn+5hkPOeQ/0NgRT0FUqxrl/BBAF+ZPog3xIDPDTL6pBRJCtLOHAk+8wnQtRPNC7zC4
	gF78YHaXuQjBb7oA2DrbYIfX8oeWyknzQBH+/ZAFuvPmdqX8LlJecm4S4M1u7lcIdE0g2vRkCrn
	xdRnnjmPa9+0FhK17evXRtSH4iu50Cm8ftJBwBwy3EWpoqtFDA8BUcDpN0sjtsb2cIsw7Qv0VlN
	4T5/7UxUYNI4NlaD6PQ2GvioOpBee0NSZe+QonpqMpOAh6GM1I2tUyGucWbohEzXQ==
X-Received: by 2002:a05:6214:1308:b0:8e0:6eca:ba7f with SMTP id 6a1803df08f44-8e06ecabac5mr24066146d6.40.1781968256538;
        Sat, 20 Jun 2026 08:10:56 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde21csm34402146d6.26.2026.06.20.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:10:55 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net v2 1/2] sctp: factor out INIT verification failure handling
Date: Sat, 20 Jun 2026 11:09:21 -0400
Message-ID: <afa5f899e970da8efb28013293ec63fa19cd47b4.1781968162.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1781968162.git.lucien.xin@gmail.com>
References: <cover.1781968162.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1275-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6148F6A90F1

Extract the duplicated INIT/INIT-ACK error handling logic into a new
helper, sctp_abort_on_init_err().

Several state functions open-code the same pattern after
sctp_verify_init() fails: construct an ABORT with error causes if
available, send it when allocation succeeds, or fall back to T-bit ABORT
handling when no error chunk is present. INIT-ACK handling also includes
additional teardown logic for malformed packets.

Move this logic into sctp_abort_on_init_err() to reduce duplication and
centralize INIT/INIT-ACK failure handling.

No functional change intended. The helper will be used in a subsequent
patch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2:
  - Pass cid to sctp_abort_on_init_err().
  - Delete chunk param from sctp_abort_on_init_err() and get chunk from
    arg param.
  - Jump to label 'out:' when err_chunk is NULL and cid is INIT_ACK in
    sctp_abort_on_init_err(), noted by Sashiko.
---
 net/sctp/sm_statefuns.c | 187 ++++++++++++++++++----------------------
 1 file changed, 85 insertions(+), 102 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 9b23c11cbb9e..8c636f045e45 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -68,6 +68,13 @@ static void sctp_send_stale_cookie_err(struct net *net,
 				       const struct sctp_chunk *chunk,
 				       struct sctp_cmd_seq *commands,
 				       struct sctp_chunk *err_chunk);
+static enum sctp_disposition sctp_abort_on_init_err(
+					struct net *net,
+					const struct sctp_endpoint *ep,
+					const struct sctp_association *asoc,
+					enum sctp_cid cid, void *arg,
+					struct sctp_cmd_seq *commands,
+					struct sctp_chunk *err_chunk);
 static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 					struct net *net,
 					const struct sctp_endpoint *ep,
@@ -325,7 +332,7 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 	struct sctp_chunk *chunk = arg, *repl, *err_chunk;
 	struct sctp_unrecognized_param *unk_param;
 	struct sctp_association *new_asoc;
-	struct sctp_packet *packet;
+	enum sctp_cid cid;
 	int len;
 
 	/* 6.10 Bundling
@@ -373,34 +380,12 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
-	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
+	cid = chunk->chunk_hdr->type;
+	if (!sctp_verify_init(net, ep, asoc, cid,
 			      (struct sctp_init_chunk *)chunk->chunk_hdr, chunk,
-			      &err_chunk)) {
-		/* This chunk contains fatal error. It is to be discarded.
-		 * Send an ABORT, with causes if there is any.
-		 */
-		if (err_chunk) {
-			packet = sctp_abort_pkt_new(net, ep, asoc, arg,
-					(__u8 *)(err_chunk->chunk_hdr) +
-					sizeof(struct sctp_chunkhdr),
-					ntohs(err_chunk->chunk_hdr->length) -
-					sizeof(struct sctp_chunkhdr));
-
-			sctp_chunk_free(err_chunk);
-
-			if (packet) {
-				sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
-						SCTP_PACKET(packet));
-				SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
-				return SCTP_DISPOSITION_CONSUME;
-			} else {
-				return SCTP_DISPOSITION_NOMEM;
-			}
-		} else {
-			return sctp_sf_tabort_8_4_8(net, ep, asoc, type, arg,
-						    commands);
-		}
-	}
+			      &err_chunk))
+		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
+					      err_chunk);
 
 	/* Grab the INIT header.  */
 	chunk->subh.init_hdr = (struct sctp_inithdr *)chunk->skb->data;
@@ -525,7 +510,7 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	struct sctp_init_chunk *initchunk;
 	struct sctp_chunk *chunk = arg;
 	struct sctp_chunk *err_chunk;
-	struct sctp_packet *packet;
+	enum sctp_cid cid;
 
 	if (!sctp_vtag_verify(chunk, asoc))
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
@@ -546,52 +531,12 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
-	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
+	cid = chunk->chunk_hdr->type;
+	if (!sctp_verify_init(net, ep, asoc, cid,
 			      (struct sctp_init_chunk *)chunk->chunk_hdr, chunk,
-			      &err_chunk)) {
-
-		enum sctp_error error = SCTP_ERROR_NO_RESOURCE;
-
-		/* This chunk contains fatal error. It is to be discarded.
-		 * Send an ABORT, with causes.  If there are no causes,
-		 * then there wasn't enough memory.  Just terminate
-		 * the association.
-		 */
-		if (err_chunk) {
-			packet = sctp_abort_pkt_new(net, ep, asoc, arg,
-					(__u8 *)(err_chunk->chunk_hdr) +
-					sizeof(struct sctp_chunkhdr),
-					ntohs(err_chunk->chunk_hdr->length) -
-					sizeof(struct sctp_chunkhdr));
-
-			sctp_chunk_free(err_chunk);
-
-			if (packet) {
-				sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
-						SCTP_PACKET(packet));
-				SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
-				error = SCTP_ERROR_INV_PARAM;
-			}
-		}
-
-		/* SCTP-AUTH, Section 6.3:
-		 *    It should be noted that if the receiver wants to tear
-		 *    down an association in an authenticated way only, the
-		 *    handling of malformed packets should not result in
-		 *    tearing down the association.
-		 *
-		 * This means that if we only want to abort associations
-		 * in an authenticated way (i.e AUTH+ABORT), then we
-		 * can't destroy this association just because the packet
-		 * was malformed.
-		 */
-		if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
-			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-
-		SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
-		return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
-						asoc, chunk->transport);
-	}
+			      &err_chunk))
+		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
+					      err_chunk);
 
 	/* Tag the variable length parameters.  Note that we never
 	 * convert the parameters in an INIT chunk.
@@ -1522,7 +1467,7 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	struct sctp_unrecognized_param *unk_param;
 	struct sctp_association *new_asoc;
 	enum sctp_disposition retval;
-	struct sctp_packet *packet;
+	enum sctp_cid cid;
 	int len;
 
 	/* 6.10 Bundling
@@ -1564,33 +1509,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
-	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
+	cid = chunk->chunk_hdr->type;
+	if (!sctp_verify_init(net, ep, asoc, cid,
 			      (struct sctp_init_chunk *)chunk->chunk_hdr, chunk,
-			      &err_chunk)) {
-		/* This chunk contains fatal error. It is to be discarded.
-		 * Send an ABORT, with causes if there is any.
-		 */
-		if (err_chunk) {
-			packet = sctp_abort_pkt_new(net, ep, asoc, arg,
-					(__u8 *)(err_chunk->chunk_hdr) +
-					sizeof(struct sctp_chunkhdr),
-					ntohs(err_chunk->chunk_hdr->length) -
-					sizeof(struct sctp_chunkhdr));
-
-			if (packet) {
-				sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
-						SCTP_PACKET(packet));
-				SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
-				retval = SCTP_DISPOSITION_CONSUME;
-			} else {
-				retval = SCTP_DISPOSITION_NOMEM;
-			}
-			goto cleanup;
-		} else {
-			return sctp_sf_tabort_8_4_8(net, ep, asoc, type, arg,
-						    commands);
-		}
-	}
+			      &err_chunk))
+		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
+					      err_chunk);
 
 	/*
 	 * Other parameters for the endpoint SHOULD be copied from the
@@ -1691,7 +1615,6 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 nomem_retval:
 	if (new_asoc)
 		sctp_association_free(new_asoc);
-cleanup:
 	if (err_chunk)
 		sctp_chunk_free(err_chunk);
 	return retval;
@@ -6485,6 +6408,66 @@ static void sctp_send_stale_cookie_err(struct net *net,
 	}
 }
 
+static enum sctp_disposition sctp_abort_on_init_err(
+					struct net *net,
+					const struct sctp_endpoint *ep,
+					const struct sctp_association *asoc,
+					enum sctp_cid cid, void *arg,
+					struct sctp_cmd_seq *commands,
+					struct sctp_chunk *err_chunk)
+{
+	enum sctp_error error = SCTP_ERROR_NO_RESOURCE;
+	struct sctp_chunk *chunk = arg;
+	struct sctp_packet *packet;
+	struct sctp_chunkhdr *ch;
+
+	if (!err_chunk) {
+		if (cid == SCTP_CID_INIT_ACK)
+			goto out;
+		return sctp_sf_tabort_8_4_8(net, ep, asoc, SCTP_ST_CHUNK(0),
+					    arg, commands);
+	}
+
+	ch = err_chunk->chunk_hdr;
+	packet = sctp_abort_pkt_new(net, ep, asoc, arg,
+				    (__u8 *)ch + sizeof(*ch),
+				    ntohs(ch->length) - sizeof(*ch));
+
+	sctp_chunk_free(err_chunk);
+
+	if (packet) {
+		sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
+				SCTP_PACKET(packet));
+		SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
+		error = SCTP_ERROR_INV_PARAM;
+	}
+
+	if (cid != SCTP_CID_INIT_ACK) {
+		if (!packet)
+			return SCTP_DISPOSITION_NOMEM;
+		return SCTP_DISPOSITION_CONSUME;
+	}
+
+out:
+	/* SCTP-AUTH, Section 6.3:
+	 *    It should be noted that if the receiver wants to tear
+	 *    down an association in an authenticated way only, the
+	 *    handling of malformed packets should not result in
+	 *    tearing down the association.
+	 *
+	 * This means that if we only want to abort associations
+	 * in an authenticated way (i.e AUTH+ABORT), then we
+	 * can't destroy this association just because the packet
+	 * was malformed.
+	 */
+	if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
+		return sctp_sf_pdiscard(net, ep, asoc, SCTP_ST_CHUNK(0), arg,
+					commands);
+
+	SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
+	return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
+				      asoc, chunk->transport);
+}
 
 /* Process a data chunk */
 static int sctp_eat_data(const struct sctp_association *asoc,
-- 
2.47.1


