Return-Path: <linux-sctp+bounces-480-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9FEA7C009
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Apr 2025 16:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D703BB053
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Apr 2025 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4111F417E;
	Fri,  4 Apr 2025 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="sprcMgTO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3858E1F3BBD;
	Fri,  4 Apr 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778502; cv=none; b=W6ElwW8cIuD+IFJzUlt977YY01NNoKR56JfG/zyuxnsXZH++fEbv2FqoMtJk2GDr0MD3zwWhPV5CoqGs5HgqIFvP5Of5+8/wYMrC6b6JcgXvm1Gu5IyEkySti9eShv4JwRY4hUKh+iwwqfz5DeXLo0LukFuxEH1RzTTxlNiXgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778502; c=relaxed/simple;
	bh=SWQo3ccuwHGhaNZHO02pMNUDY4K7Rdvf7YnaHSIdGWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AK7V0PLdNJkgZzQ+sGTnj6sDNoN8EDc7RFS3+3BxEFtu3NVF5K2AIt1BfPUQ2/PTWa8/Z3sEM1y413cewhoObVDXVWJpPTG04+3lwF5qODAaOxWJHT14/zV3hynRmFla75Djtmw7eWaD+6E49FIH68T5ldjRHzOZH1R+h2j+ADU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=sprcMgTO; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sygz/bW1kxlcYgDdjSHghLu2MUlMWaBQ64Zi2rsXer4=; b=sprcMgTOFK0va0JEWaOTsmlK5z
	v04huu9OWlhJggHK68k1QaVzjL+X8/KfK9jfn5TZcd42xvdmusDPzcqPFQK7wS6ZLRLJ3rMsICmnQ
	C/sfB0xdorRtZq8FxOV2zB0Ndupoq1iRSXROyl3XFueHKVQVnSQcT9nyBj+utp2S1ID62vhygcdzq
	HeelUvIomNuoI1OszFjYW7bFUPc7svX12cTVCVlzygezv1vQvCNUYDMFmtRCWHxmilSB+kPD/R+Po
	fT/+KRHw3ZXJ/4ClHsO8eYBgqcZTgyrajI81UtLZ7Y0rYxcPeFw6U+w0zEs8rk4CfabKElCK4Ppf1
	qod9kRAg==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u0iRR-00BRNy-Qv; Fri, 04 Apr 2025 16:54:45 +0200
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Fri, 04 Apr 2025 16:53:21 +0200
Subject: [PATCH] sctp: detect and prevent references to a freed transport
 in sendmsg
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-v1-1-5ce4a0b78ef2@igalia.com>
X-B4-Tracking: v=1; b=H4sIAGDy72cC/z2O0QrCMBAEf6Xk2UBSq6K/InKczUaDJW3vUhFK/
 93gg4/DwuysRiEJai7NagTvpGnMFfyuMf2T8wM2hcqmde3Bda6zL1bOpAPf7aKwHAvERgFIwIF
 S3foy0biUmRQD+kJFOOs0SiH6a87wMe5Pzh19MPVsEsT0+YVcb9v2Ba2gzgCYAAAA
X-Change-ID: 20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-9e1ff370061d
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: revest@google.com, kernel-dev@igalia.com, linux-sctp@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
X-Mailer: b4 0.14.2

sctp_sendmsg() re-uses associations and transports when possible by
doing a lookup based on the socket endpoint and the message destination
address, and then sctp_sendmsg_to_asoc() sets the selected transport in
all the message chunks to be sent.

There's a possible race condition if another thread triggers the removal
of that selected transport, for instance, by explicitly unbinding an
address with setsockopt(SCTP_SOCKOPT_BINDX_REM), after the chunks have
been set up and before the message is sent. This can happen if the send
buffer is full, during the period when the sender thread temporarily
releases the socket lock in sctp_wait_for_sndbuf().

This causes the access to the transport data in
sctp_outq_select_transport(), when the association outqueue is flushed,
to result in a use-after-free read.

This change avoids this scenario by having sctp_transport_free() signal
the freeing of the transport, tagging it as "dead". In order to do this,
the patch restores the "dead" bit in struct sctp_transport, which was
removed in
commit 47faa1e4c50e ("sctp: remove the dead field of sctp_transport").

Then, in the scenario where the sender thread has released the socket
lock in sctp_wait_for_sndbuf(), the bit is checked again after
re-acquiring the socket lock to detect the deletion. This is done while
holding a reference to the transport to prevent it from being freed in
the process.

If the transport was deleted while the socket lock was relinquished,
sctp_sendmsg_to_asoc() will return -EAGAIN to let userspace retry the
send.

The bug was found by a private syzbot instance (see the error report [1]
and the C reproducer that triggers it [2]).

Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport.txt [1]
Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport__repro.c [2]
Cc: stable@vger.kernel.org
Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
---
This patch supersedes this one I sent a few days ago, which proposed a
different solution:
https://lore.kernel.org/all/20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com

As Xin Long pointed out in the discussion on that patch, that solution
would have a significant performance impact, so this alternative was
proposed instead. Although the purpose is the same, the patch
implementation is completely different, hence the new patch instead of a
v2.

Cheers,
Ricardo
---
 include/net/sctp/structs.h |  3 ++-
 net/sctp/socket.c          | 22 ++++++++++++++--------
 net/sctp/transport.c       |  2 ++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 31248cfdfb235f1e6008c4a6b64a1103d2f355ef..dcd288fa1bb6fbbb33bb639a790d8edcbba7c389 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -775,6 +775,7 @@ struct sctp_transport {
 
 	/* Reference counting. */
 	refcount_t refcnt;
+	__u32	dead:1,
 		/* RTO-Pending : A flag used to track if one of the DATA
 		 *		chunks sent to this address is currently being
 		 *		used to compute a RTT. If this flag is 0,
@@ -784,7 +785,7 @@ struct sctp_transport {
 		 *		calculation completes (i.e. the DATA chunk
 		 *		is SACK'd) clear this flag.
 		 */
-	__u32	rto_pending:1,
+		rto_pending:1,
 
 		/*
 		 * hb_sent : a flag that signals that we have a pending
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 36ee34f483d703ffcfe5ca9e6cc554fba24c75ef..53725ee7ba06d780e220c3a184b4f611a7cb5e51 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -72,8 +72,9 @@
 /* Forward declarations for internal helper functions. */
 static bool sctp_writeable(const struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len);
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len);
 static int sctp_wait_for_packet(struct sock *sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
 static int sctp_wait_for_accept(struct sock *sk, long timeo);
@@ -1828,7 +1829,7 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 
 	if (sctp_wspace(asoc) <= 0 || !sk_wmem_schedule(sk, msg_len)) {
 		timeo = sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
-		err = sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
+		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
 		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
@@ -9214,8 +9215,9 @@ void sctp_sock_rfree(struct sk_buff *skb)
 
 
 /* Helper function to wait for space in the sndbuf.  */
-static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
-				size_t msg_len)
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc,
+				struct sctp_transport *transport,
+				long *timeo_p, size_t msg_len)
 {
 	struct sock *sk = asoc->base.sk;
 	long current_timeo = *timeo_p;
@@ -9225,7 +9227,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
 
-	/* Increment the association's refcnt.  */
+	/* Increment the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_hold(transport);
 	sctp_association_hold(asoc);
 
 	/* Wait on the association specific sndbuf space. */
@@ -9234,7 +9238,7 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 					  TASK_INTERRUPTIBLE);
 		if (asoc->base.dead)
 			goto do_dead;
-		if (!*timeo_p)
+		if ((!*timeo_p) || (transport && transport->dead))
 			goto do_nonblock;
 		if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
 			goto do_error;
@@ -9259,7 +9263,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 out:
 	finish_wait(&asoc->wait, &wait);
 
-	/* Release the association's refcnt.  */
+	/* Release the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_put(transport);
 	sctp_association_put(asoc);
 
 	return err;
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index 2abe45af98e7c6efd5baffb88a8687e595cf3f24..31eca29b6cfbfb146c389cc643126ce87620fccd 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -117,6 +117,8 @@ struct sctp_transport *sctp_transport_new(struct net *net,
  */
 void sctp_transport_free(struct sctp_transport *transport)
 {
+	transport->dead = 1;
+
 	/* Try to delete the heartbeat timer.  */
 	if (del_timer(&transport->hb_timer))
 		sctp_transport_put(transport);

---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-9e1ff370061d


