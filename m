Return-Path: <linux-sctp+bounces-1276-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XTKRAKmtNmpHDAcAu9opvQ
	(envelope-from <linux-sctp+bounces-1276-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 17:11:37 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDEE6A90FC
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 17:11:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AVt2OHj0;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1276-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1276-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E484302882E
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9633E36A;
	Sat, 20 Jun 2026 15:11:00 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A4395266
	for <linux-sctp@vger.kernel.org>; Sat, 20 Jun 2026 15:10:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968260; cv=none; b=bkKTqAWrNV1GbXxUisDpJCls4znmnxwxFgA0Tv1Wer7YP5gYCcOenQA1nc/O52/X5EAGletVCGPjYVO6YowoPxnwUUvBJjPQ1Ur0vYA6x6PlOGsDgHeqCaPBq761N/7vnkG+r+NHmQHuveNuQFUkULnr+DPfajsB/Sp9dl0667c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968260; c=relaxed/simple;
	bh=ZLbPKmVKhX6MOQ3dIoRI7E4oZoryAPwi5qjuGUD5F3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8oC/O+TKoWAkpKJnQ2Qh0FunFV8YhQu4a/ZY6cRqfWN/2LRot48T0SFFQEiMopHEeqTK94HHjI+f69aJ7g5mfnWTYxm21J+7pUVrtt90WpvBLNbPBLDrn2hWLk6qxulZpLwB8+DNt1sfmf0iceOO9WT5OZf/8KiKgVBLLiHP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVt2OHj0; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8df9393e4d5so9038556d6.3
        for <linux-sctp@vger.kernel.org>; Sat, 20 Jun 2026 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781968258; x=1782573058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=byuE27fTQJHJEwPQRix+4FdNUy308GekTADTdRnmiRU=;
        b=AVt2OHj0MDiV18KDIukReAIhhTWxkLxuYAZfDIuSVi6DVVFdDqtKdRXgR8v+nRS5DR
         3mzR7wiiDRnW7NBjISKNoXntayc8MclXkYMAZywyEUP1kBNcXY5EzZbB0GTDPpD3a/Hc
         ZmUhalChkYy6C/KTplVPKWXeqwqsDfKr/yuB5AwwXoYQMWa8LpMEXxKHnabVOotSixc1
         cD8VSTYNvBydcrR8T7zRW7xH+wzST3nMq04ucA9P1rmpoZ5rlPKDTNchzbVpYgBD9kB7
         Rrcszi97PGhPcerNHHhMOiGPkfmgpuETpbp2BdfNcaVEUhLqNKPXgka5V1SKKkRt3IHK
         f2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781968258; x=1782573058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=byuE27fTQJHJEwPQRix+4FdNUy308GekTADTdRnmiRU=;
        b=bHmZVixv+ZeXLKOSf/OUmbkP+gaUkl2uUc9jz0es7pk9tTET3ln8c/X4J/reIj5PSa
         aYJIkla0VCgEpeJiVyb+n8Ej7pxRt+nSFxcP1F3vUngFDyd4zHKzrnFqH8mexrs1MCfP
         bZM9sryG4JbTqXfYeCknaKWfah9HASJg9UHnO+dP3Z/bgKy+ybwSFCQjVgzOLc5pkOhk
         m6Zv4Bl1Fg0uGzL2jytciv/ZmAm+VHpe5PLZzT/A+72u28b58ib/J6XMY65E+X7IjRqa
         jv5Yd1wLwvBVHss7Qh9WUB15AqcaIzT60D9S8RrkbKHLUJq9SjoKxgCPsv+Wr7wtKzgi
         m/YA==
X-Forwarded-Encrypted: i=1; AFNElJ9pIrVlHXfNOb+kH18p9YIpjQ1lvWeiCnBfCYcBiNb0CzpQqnb7De9KBqM9ymOwaxulcDPiCpaSIoB6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8xeMSgFFopbQtHmb87Yom3eg5afilMCMz6JaclenPK3Qs9p0s
	t2RXg+1t5vNqSrT/zxrzegdDDVYVrkrN8QDKhXc3fvsEVTL+1fyZ/Jnl1VyuwBui
X-Gm-Gg: AfdE7clmF+ZhNSXZHfldQRPtlPsWe7U3vMtkxQCg4lks5KyoWE05/Jpju9h34XlmOIs
	C9pQQOUxOJgbRxBauO//D1jdabFj3relTGht130+QBxHhuotOuf/Kb3DXddmTjyl9eutW0Be3fB
	WmEic8Mk4CEsrvjw6Ypz8++s4tmc83YV8ZOcMGJGiJ7Vwh7s0I9khrSmpleCDOF7slM/BQeAsdM
	YJUwwC+6XV6IA9HGHa5IHRkiMAlvTEQnGy3IaY8FeyqPYFKZ9tj9/kqhHf+ocKvFmU1NwPgMms8
	kH1mS6Q+D/xsp4h6f66iglNP5Atif8u6MsXp93wLvIiU/Hp2Q/J+awVqDPOALSAV7b+n/wLjJBt
	eZwmpjoMuHRlYOaXGWbsLndIHAmZEgG8X6RnhaYAXuPZ0EVGVDpWlgsPBLI3+uUpKRqY58LJ5Gk
	FnZxiPUqljR3wtifELE5l+z47skkxgT57OA5i4Aj/vby/g1SaelYc49o6gszg3A4s3QBRId3uzK
	rf9heljl2fjImdH9FUGBwjGnnnFh1RSDpmPPWSubDwxech3WEdLKrU=
X-Received: by 2002:a05:6214:2484:b0:8dc:9054:d63e with SMTP id 6a1803df08f44-8dea263ac19mr115588336d6.11.1781968258245;
        Sat, 20 Jun 2026 08:10:58 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde21csm34402146d6.26.2026.06.20.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:10:56 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net v2 2/2] sctp: add INIT verification after cookie unpacking
Date: Sat, 20 Jun 2026 11:09:22 -0400
Message-ID: <c34fee6105f9051a52f8e774fe4c35f0e6ba0afc.1781968162.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1276-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BDEE6A90FC

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
v2:
  - Because of sctp_abort_on_init_err() param change in patch 1/2,
    pass cid and not chunk.
  - Use SCTP_PAD4() around ntohs(peer_init->chunk_hdr.length) when
    checking param.v in sctp_verify_init() to make Sashiko happy.
---
 net/sctp/sm_make_chunk.c |  3 ++-
 net/sctp/sm_statefuns.c  | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 41958b8e59fd..d5ee81934d93 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2298,7 +2298,8 @@ int sctp_verify_init(struct net *net, const struct sctp_endpoint *ep,
 	 * VIOLATION error.  We build the ERROR chunk here and let the normal
 	 * error handling code build and send the packet.
 	 */
-	if (param.v != (void *)chunk->chunk_end)
+	if (param.v != (void *)peer_init +
+		       SCTP_PAD4(ntohs(peer_init->chunk_hdr.length)))
 		return sctp_process_inv_paramlength(asoc, param.p, chunk, errp);
 
 	/* The only missing mandatory param possible today is
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 8c636f045e45..6967e889d1bd 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -650,11 +650,12 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 					 struct sctp_cmd_seq *commands)
 {
 	struct sctp_ulpevent *ev, *ai_ev = NULL, *auth_ev = NULL;
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
 	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
-	struct sctp_chunk *err_chk_p;
 	struct sctp_chunk *repl;
+	enum sctp_cid cid;
 	struct sock *sk;
 	int error = 0;
 
@@ -728,6 +729,18 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 		}
 	}
 
+	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
+	cid = peer_init->chunk_hdr.type;
+	if (!sctp_sk(sk)->cookie_auth_enable &&
+	    !sctp_verify_init(net, ep, asoc, cid, peer_init, chunk,
+			      &err_chk_p)) {
+		sctp_association_free(new_asoc);
+		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
+					      err_chk_p);
+	}
+	if (err_chk_p)
+		sctp_chunk_free(err_chk_p);
+
 	if (security_sctp_assoc_request(new_asoc, chunk->head_skb ?: chunk->skb)) {
 		sctp_association_free(new_asoc);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
@@ -741,7 +754,6 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	/* This is a brand-new association, so these are not yet side
 	 * effects--it is safe to run them here.
 	 */
-	peer_init = (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);
 	if (!sctp_process_init(new_asoc, chunk,
 			       &chunk->subh.cookie_hdr->c.peer_addr,
 			       peer_init, GFP_ATOMIC))
@@ -2133,10 +2145,12 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 					void *arg,
 					struct sctp_cmd_seq *commands)
 {
+	struct sctp_chunk *err_chk_p = NULL;
 	struct sctp_association *new_asoc;
+	struct sctp_init_chunk *peer_init;
 	struct sctp_chunk *chunk = arg;
 	enum sctp_disposition retval;
-	struct sctp_chunk *err_chk_p;
+	enum sctp_cid cid;
 	int error = 0;
 	char action;
 
@@ -2205,6 +2219,19 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 	switch (action) {
 	case 'A': /* Association restart. */
 	case 'B': /* Collision case B. */
+		peer_init = (struct sctp_init_chunk *)
+				(chunk->subh.cookie_hdr + 1);
+		cid = peer_init->chunk_hdr.type;
+		if (!sctp_sk(ep->base.sk)->cookie_auth_enable &&
+		    !sctp_verify_init(net, ep, asoc, cid, peer_init, chunk,
+				      &err_chk_p)) {
+			sctp_association_free(new_asoc);
+			return sctp_abort_on_init_err(net, ep, asoc, cid, arg,
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


