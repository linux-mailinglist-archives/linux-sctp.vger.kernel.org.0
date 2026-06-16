Return-Path: <linux-sctp+bounces-1266-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id s+pYMkCaMGqzUwUAu9opvQ
	(envelope-from <linux-sctp+bounces-1266-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 02:35:12 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C933B68AF57
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 02:35:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="mzsVCq5/";
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1266-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1266-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBCF13012779
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 00:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307A2673AA;
	Tue, 16 Jun 2026 00:34:24 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DC26B2AD
	for <linux-sctp@vger.kernel.org>; Tue, 16 Jun 2026 00:34:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570064; cv=none; b=QSAFqSbUn2Jfi3Xt11RPxS1Ld0K3KFPnXqp0iOEdiDN3eDF4f1ySmvGwhMrRIjCjlqEpybzJR2rDsRkDBEUAvpeYU+SV7giLcjl6D3OnEuZwYKsaxNwnprkEdX2kKdULM341At9mteCGFnVw2HRrRjDiP432lkV8rTpmgvAwus0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570064; c=relaxed/simple;
	bh=l9JlPjQcu1ChcPkgW6cjZ2djwDvkPk1ZZNWlckWA6jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6KPYt/w5exXPu4xv6hAYyIHGqD1aAD2H70SGHckyIa4YJ80oUCqQ80Hote9lGezaxe3EiAO8d8aXK5QOryWG1A4iLTSJTTHgzaKfPOhpgFo9RCdWqMqMxf0FWX03NL1KZaOWWNeMSIhWW2+FKsTcy981A0BioJSJT+5vZuLeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzsVCq5/; arc=none smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8cce77eb087so34958756d6.1
        for <linux-sctp@vger.kernel.org>; Mon, 15 Jun 2026 17:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570061; x=1782174861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79uBSJJ9yseMUfmE66NnuGl7TUvlgfEgST1FBf23YNQ=;
        b=mzsVCq5/6eX4k29iSg5lC+/Z8NHC35CDQYHxWzOqOlH7Y7ehAFEoGC7ZhBGsPjwpjl
         IEZRzAAAJ8mQRQDCkkUjgZtVR7RnLRaRxhaHqcoKTvJjVxKgQkYd2b1FY6h5eUAblIe5
         aUQcMBiQMx64gKBy6KciujRkuCyp4ngD2qzqamrUFTjm9F/KPTeBNvRMSfceSejY5mEI
         MMpyqcfzkRxzxoau/wO5yhTFnIWIPF4tSOPD+BV80S3v01JKAFC83Yd79A3kXHvsnqWO
         6P20UvH6vwf7PuhIZE7qVBPiNvq1EfO721F9Dh5i4hT7AEOtgsZrKfgnccEvl8P2P/Np
         trrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570061; x=1782174861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79uBSJJ9yseMUfmE66NnuGl7TUvlgfEgST1FBf23YNQ=;
        b=RKOilWw4I7nxJnZyD9Tdh2xB3pX/gKIIEerSojHTzk2AuOy7ti9gpvmECPayPSXSM5
         r5ZIf6fmNgYKkU7Dpf3T3Wn3F7Tv57N/+JUMW+/CeipxtqoPLNzoc/QtLM4ZvdydHTt8
         IabBAs2W0rcXSat3CjjeYTlva4E7W6Zq/0dU+793cF74RUoEAEV6Lslt2oXUMEE4zvtJ
         vsNwWkqAvyltSZExqNuapGo0z22EkrYxutzMRbWPZl1amFswCOvNM6gGSffs+8m1FoFX
         /UFuDXRjmnajCxAK727Mkx/4VG06KHxAAHSEC1DlYEkKMSuU3Xko4zmAvbJR1vgEzPVR
         5d9A==
X-Forwarded-Encrypted: i=1; AFNElJ+KH9wf2n/clKB/j5Okjc5kZEobGH4wvGcLb4wRmmVVEppEVAUlba73sVU1//oISZBjBItM2uZlbJk0@vger.kernel.org
X-Gm-Message-State: AOJu0YweoxO+EVnPaUkakFipTiYQAtjaD/q2aDGVxvVHvaEV5xm4/Iua
	uRPkr8l5DHglHQ1icfqEtwi8Ur4w1m0Vbb+AirhIefXJekypa9LUyINs
X-Gm-Gg: Acq92OHtOTH7FwNwgH466+HrhldZ3LA2hn8ChUPZw0F1GKhA6uOOoagxvT2WdxQL9Yl
	xY4v9prUWD6FukJQQwHbF/V79HAodssDGYkftD9hCpcO6ZLQcWg3GGjMEh/SYERjlwALVudZhmc
	eoI/lV9I8wHfQZV7o9z4Y35mr7PR9jG/rKIdJ2lc92Jemy7pSaecfPSOkUZj7UDs6QVmHgcGthO
	PuKpKekL3xSlmn0gyYjq9p+ZhT/PVEQ1rmWlOvr7tW4ai8NoxOVKa3eafMhxmMxLWPVs00wJkZd
	G9RRE3FcK1sGiT6QUV1cydQoGKsMRBBffXjkCsfu6CdfgFA8pi3E1xnfL46G+4HZDct04wQzVYi
	NNtz7CL+KA6AU1+7BYAYV/1dvucCXR5ML6GbEcjom/sj+j+onoolk4SQFZYABuUwyX5Oa3VCu2f
	JdbZqgvNteZJZLQ0zWLI8CDtIgxX224DUu8VQlbjLF4nLYtkyBx4XsLFlgbJzq8ZOBeo4/7zdkJ
	Sh6yroTP5gElDhUlT8O7kRJgMcxZUPL8fjjAipRNAo+JS/cNPG9N2IJ9PtbPwgz7aJ72tT96JlS
X-Received: by 2002:a05:6214:2509:b0:8cc:ce4d:1d92 with SMTP id 6a1803df08f44-8d32f693831mr284245826d6.41.1781570061353;
        Mon, 15 Jun 2026 17:34:21 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f132178csm16794326d6.7.2026.06.15.17.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:34:20 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net 1/2] sctp: factor out INIT verification failure handling
Date: Mon, 15 Jun 2026 20:33:33 -0400
Message-ID: <6fb546c80126a410349e724045ce16a41413c8a6.1781570014.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1781570014.git.lucien.xin@gmail.com>
References: <cover.1781570014.git.lucien.xin@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-1266-lists,linux-sctp=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C933B68AF57

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
 net/sctp/sm_statefuns.c | 171 +++++++++++++++++-----------------------
 1 file changed, 72 insertions(+), 99 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 9b23c11cbb9e..544f308ee527 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -68,6 +68,14 @@ static void sctp_send_stale_cookie_err(struct net *net,
 				       const struct sctp_chunk *chunk,
 				       struct sctp_cmd_seq *commands,
 				       struct sctp_chunk *err_chunk);
+static enum sctp_disposition sctp_abort_on_init_err(
+					struct net *net,
+					const struct sctp_endpoint *ep,
+					const struct sctp_association *asoc,
+					const struct sctp_chunk *chunk,
+					void *arg,
+					struct sctp_cmd_seq *commands,
+					struct sctp_chunk *err_chunk);
 static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 					struct net *net,
 					const struct sctp_endpoint *ep,
@@ -325,7 +333,6 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 	struct sctp_chunk *chunk = arg, *repl, *err_chunk;
 	struct sctp_unrecognized_param *unk_param;
 	struct sctp_association *new_asoc;
-	struct sctp_packet *packet;
 	int len;
 
 	/* 6.10 Bundling
@@ -375,32 +382,9 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 	err_chunk = NULL;
 	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
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
+		return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
+					      commands, err_chunk);
 
 	/* Grab the INIT header.  */
 	chunk->subh.init_hdr = (struct sctp_inithdr *)chunk->skb->data;
@@ -525,7 +509,6 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	struct sctp_init_chunk *initchunk;
 	struct sctp_chunk *chunk = arg;
 	struct sctp_chunk *err_chunk;
-	struct sctp_packet *packet;
 
 	if (!sctp_vtag_verify(chunk, asoc))
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
@@ -548,50 +531,9 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	err_chunk = NULL;
 	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
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
+		return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
+					      commands, err_chunk);
 
 	/* Tag the variable length parameters.  Note that we never
 	 * convert the parameters in an INIT chunk.
@@ -1522,7 +1464,6 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	struct sctp_unrecognized_param *unk_param;
 	struct sctp_association *new_asoc;
 	enum sctp_disposition retval;
-	struct sctp_packet *packet;
 	int len;
 
 	/* 6.10 Bundling
@@ -1566,31 +1507,9 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	err_chunk = NULL;
 	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
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
+		return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
+					      commands, err_chunk);
 
 	/*
 	 * Other parameters for the endpoint SHOULD be copied from the
@@ -1691,7 +1610,6 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 nomem_retval:
 	if (new_asoc)
 		sctp_association_free(new_asoc);
-cleanup:
 	if (err_chunk)
 		sctp_chunk_free(err_chunk);
 	return retval;
@@ -6485,6 +6403,61 @@ static void sctp_send_stale_cookie_err(struct net *net,
 	}
 }
 
+static enum sctp_disposition sctp_abort_on_init_err(
+					struct net *net,
+					const struct sctp_endpoint *ep,
+					const struct sctp_association *asoc,
+					const struct sctp_chunk *chunk,
+					void *arg,
+					struct sctp_cmd_seq *commands,
+					struct sctp_chunk *err_chunk)
+{
+	enum sctp_error error = SCTP_ERROR_NO_RESOURCE;
+	struct sctp_packet *packet;
+	struct sctp_chunkhdr *ch;
+
+	if (!err_chunk)
+		return sctp_sf_tabort_8_4_8(net, ep, asoc, SCTP_ST_CHUNK(0),
+					    arg, commands);
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
+	if (chunk->chunk_hdr->type != SCTP_CID_INIT_ACK) {
+		if (!packet)
+			return SCTP_DISPOSITION_NOMEM;
+		return SCTP_DISPOSITION_CONSUME;
+	}
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


