Return-Path: <linux-sctp+bounces-1267-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MUd6A1CaMGrAUwUAu9opvQ
	(envelope-from <linux-sctp+bounces-1267-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 02:35:28 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF168AF64
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 02:35:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=faLrCcF7;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1267-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1267-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2754E301401E
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jun 2026 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493122773CA;
	Tue, 16 Jun 2026 00:34:25 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17211A9FBD
	for <linux-sctp@vger.kernel.org>; Tue, 16 Jun 2026 00:34:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570065; cv=none; b=UTsbXQ7wGTXN6uSNFKXNeIwFjJ8HcD+Nim6d05ApNf98h6mES2DnXpNYEg1/Qx0I8V+MS8VHyXSW7ajfZwfmR+j2biWAHSAxFZpAGnHO2rK79HzWtJKoogCA0acJz5WMNpsWoBdNMo0si2hOA6Q2VgcVE0wL+MOd+xB58o8HkhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570065; c=relaxed/simple;
	bh=aY8xn1ZK/MAimDg6/PX3B9LVgXQNUUeznYM37qg3c7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqIVBw6dM4J3IKWhqpmQyVSTU8XGbOr5WhTQS+D97W1X2nshc+1enkduXs+MeaMuBLyQJn1q4m/rydRF271FHePy7SVFHS1ZUaF8MkTOKCeBqbAEivMgJhrDQEppjz21Rk0rI5Ddcm6oKDr4YRsjeUz+REvBbRS8A2rZj/iMeYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faLrCcF7; arc=none smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5178a42caa3so41942241cf.1
        for <linux-sctp@vger.kernel.org>; Mon, 15 Jun 2026 17:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781570063; x=1782174863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=52m6IQ7AlTbQvy6czYmDGwVADQkx7UZsBBaNoscqguQ=;
        b=faLrCcF7B+enlP9VDV33vjvuRzoxjXNQ/v5josXzFRD7AVVfw61tGKEBhgkeI2ndzT
         QzvxBb7Oca8EBmaEa/32rY+Tyo8XfL4cip2hdJHVM03lH01mWaTWPE0W+aJJnnj2DUpS
         Chsh9/970fMQDsuUEPC3DhJwYnshBe63fwdBuCwCLEfBMa4a8Tf0HrZH5PwMQX12wlTH
         QDX0NU/tW+XGIMbQB9h0Noefh6dxO3kubYXuYv07B03q+Y9Voa0SV1gRP0sYMLuu70Hh
         9sxSfwBL0mwMAKrmfPLAFqpHmqb1clziZYEP+0/J5cuKG+Tnf8WbIDV+2/sxN1sIQhfh
         3Odw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570063; x=1782174863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=52m6IQ7AlTbQvy6czYmDGwVADQkx7UZsBBaNoscqguQ=;
        b=esyHm8eSFUFYo0XaoWpb+fbnVt7/VRpZHdLcx2w4xgV0R7SeS8GqGR4fh9qaezwkzf
         eFTWZz66jMwf2LNfGdoSFgw3gEpHar33QF+7xbGAXqtSjwTNOm65xO1aG5Q8CQkPKzC5
         CpwV33sBVG3AKkGjfn4x1r4uKT4AQn5NUaab9na70W9EDtdTmnlh/iUumxptFl5dBly1
         ntf93nV0dXuTjG6xBsDoFAA8p8mDE/Qq8yQEoxFrU7SDPhTvBpVcqcR2NP9eq3KI54Do
         BQ5g7Hd+2ZC3l0JwunFlU5nvagZPiLJSMDJ7OzsNGf6qssCk7Tn7t/VilGKWxql0BVsY
         UBCQ==
X-Forwarded-Encrypted: i=1; AFNElJ9pAHC3kRstNcQQz831CQofiGOO8xcLMyR8xrZsf70srBBNjwH+qKtEdOY0Vu5RRrqsq1kTZoM4tOgI@vger.kernel.org
X-Gm-Message-State: AOJu0YwG7ciSEgPLYRjAr5yPBykWJLfy2w4OzNZOTyW4RlOyBOp7u8p1
	U+hNsAMal8xq3EU74x5fRRYtyLKPqpZWdgnN8ybionrHn+HoWU7bEWEY
X-Gm-Gg: Acq92OFy6PZQltajSkFYWVQpyqBK5AXqM9ceUsuXPW7aSEg7Qoj889Wg5N2mJrDl0ry
	5yjsZ5WUIGtnGo/zUPvTINUsHyCu1waeRe5kxRo85YjdCWJhBsL1SehkWh9ElQQPzgp39x1YSiy
	ufmfnomeKnWidZmrfIQhvOdUb/VF8zokb8s76gP/FD/Hi0HEjvxWwIe9k9b7BrLbvFM2CFfZd0X
	QDrG7XTqYA7ITSphr5lZOoqvR4dQd0dj6w4lOzc07m5cvVrG7SebfWOlT4luCcIqPRONID1gqiP
	mG3jx7ZObHsECWKcVhLHmNdcvsb4RUYBm3NmqZ1dcKovghZ8FfZ9qA5oJRiq4uyxV0D8QeGvWbD
	KU66AK3qAVy3aHojTMXgKxfnfKcYBu8Kd7C6qXZ8POKjTKMw/Lv+bKaQHnTzeCcPGMF38G/lMqd
	OdXjQXhiZEBuAIzg8nxPt2S06zq0L21x+uzlyAOLVx/hsRmi5Y+12HlguVeJ11XozimKDa+j9jl
	Zcs4PNCR3ddkpQJYjiuS/bb2hzVzCIvL+4ehf+jqAdEfUm4Akcxrn0hBWzEgX4vE0OfiSLQ58mm
X-Received: by 2002:ac8:598e:0:b0:517:5e1e:f8b9 with SMTP id d75a77b69052e-5198e039256mr23476631cf.28.1781570062692;
        Mon, 15 Jun 2026 17:34:22 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f132178csm16794326d6.7.2026.06.15.17.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 17:34:21 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net 2/2] sctp: add INIT verification after cookie unpacking
Date: Mon, 15 Jun 2026 20:33:34 -0400
Message-ID: <13a54c38586e0e1c7d46dfc16c3f6e1a7685001b.1781570014.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1267-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 09EF168AF64

In SCTP handshake, the INIT chunk is initially processed by the server
and embedded into the cookie carried in INIT-ACK. The client then
returns this cookie via COOKIE-ECHO, where the server unpacks it and
reconstructs the original INIT chunk.

When cookie authentication is enabled, the cookie contents are protected
against tampering, so reusing the unpacked INIT without re-verification
is safe.

However, when cookie authentication is disabled, the reconstructed INIT
can no longer be trusted. In this case, the INIT must be explicitly
validated after unpacking to avoid processing potentially tampered data.

Add sctp_verify_init() checks after cookie unpacking in COOKIE-ECHO
processing paths (sctp_sf_do_5_1D_ce() and sctp_sf_do_5_2_4_dupcook())
when cookie_auth_enable is disabled. On failure, the association is
freed and an ABORT is generated via sctp_abort_on_init_err().

Also update sctp_verify_init() to validate parameter bounds against the
actual peer_init length rather than chunk->chunk_end, since peer_init
may not span the full chunk buffer in COOKIE-ECHO.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_make_chunk.c |  2 +-
 net/sctp/sm_statefuns.c  | 29 ++++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 41958b8e59fd..21b9eb1c02e9 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2298,7 +2298,7 @@ int sctp_verify_init(struct net *net, const struct sctp_endpoint *ep,
 	 * VIOLATION error.  We build the ERROR chunk here and let the normal
 	 * error handling code build and send the packet.
 	 */
-	if (param.v != (void *)chunk->chunk_end)
+	if (param.v != (void *)peer_init + ntohs(peer_init->chunk_hdr.length))
 		return sctp_process_inv_paramlength(asoc, param.p, chunk, errp);
 
 	/* The only missing mandatory param possible today is
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 544f308ee527..a11a18678279 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -647,10 +647,10 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 					 struct sctp_cmd_seq *commands)
 {
 	struct sctp_ulpevent *ev, *ai_ev = NULL, *auth_ev = NULL;
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
 	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
-	struct sctp_chunk *err_chk_p;
 	struct sctp_chunk *repl;
 	struct sock *sk;
 	int error = 0;
@@ -725,6 +725,17 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 		}
 	}
 
+	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
+	if (!sctp_sk(sk)->cookie_auth_enable &&
+	    !sctp_verify_init(net, ep, asoc, peer_init->chunk_hdr.type,
+			      peer_init, chunk, &err_chk_p)) {
+		sctp_association_free(new_asoc);
+		return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
+					      commands, err_chk_p);
+	}
+	if (err_chk_p)
+		sctp_chunk_free(err_chk_p);
+
 	if (security_sctp_assoc_request(new_asoc, chunk->head_skb ?: chunk->skb)) {
 		sctp_association_free(new_asoc);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
@@ -738,7 +749,6 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	/* This is a brand-new association, so these are not yet side
 	 * effects--it is safe to run them here.
 	 */
-	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
 	if (!sctp_process_init(new_asoc, chunk,
 			       &chunk->subh.cookie_hdr->c.peer_addr,
 			       peer_init, GFP_ATOMIC))
@@ -2128,10 +2138,11 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 					void *arg,
 					struct sctp_cmd_seq *commands)
 {
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
+	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
 	enum sctp_disposition retval;
-	struct sctp_chunk *err_chk_p;
 	int error = 0;
 	char action;
 
@@ -2200,6 +2211,18 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 	switch (action) {
 	case 'A': /* Association restart. */
 	case 'B': /* Collision case B. */
+		peer_init = (struct sctp_init_chunk *)
+				(chunk->subh.cookie_hdr + 1);
+		if (!sctp_sk(ep->base.sk)->cookie_auth_enable &&
+		    !sctp_verify_init(net, ep, asoc, peer_init->chunk_hdr.type,
+				      peer_init, chunk, &err_chk_p)) {
+			sctp_association_free(new_asoc);
+			return sctp_abort_on_init_err(net, ep, asoc, chunk, arg,
+						      commands, err_chk_p);
+		}
+		if (err_chk_p)
+			sctp_chunk_free(err_chk_p);
+		fallthrough;
 	case 'D': /* Collision case D. */
 		/* Update socket peer label if first association. */
 		if (security_sctp_assoc_request((struct sctp_association *)asoc,
-- 
2.47.1


