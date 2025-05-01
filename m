Return-Path: <linux-sctp+bounces-488-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D541AA67B8
	for <lists+linux-sctp@lfdr.de>; Fri,  2 May 2025 02:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BC84C6478
	for <lists+linux-sctp@lfdr.de>; Fri,  2 May 2025 00:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844846FB9;
	Fri,  2 May 2025 00:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="b/GkN4LF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D2801;
	Fri,  2 May 2025 00:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145058; cv=none; b=a5uvLcGzZidQsoZnVQiHInYGSNeaGpAfxU1kTLEU+JLPmR8k1tdkLYroU/Gq9rq5dCF/H+WzvXhuKPG/kl4j+/1EyIX2V6N7ajb2ltlfDt6ZNaVT+rIlQthV/8zacI9Nv8k551c/S5kOgDv0CAw2YUi9WuvEa/jTDvBoX0mOwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145058; c=relaxed/simple;
	bh=5i8bFsSgpcufvSYsYIHQhogwNQunbUypD6CAxiA3sVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ga2hYc7BbD2X3DtZuNwyfyPHUuhWuZzWW2rpxgPRLng5tQG1ag3YAP5YhXK2oaNYuaOOU1Bd5cup5xqkNMyeUv8Aq7mLmjf3+s9d987S8a99V01dqHgFQeeheSlM8ydeQ6KHjvMFjif9hHIHOIRI6iobD7OnmP4L9A2Gdb3IgWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=b/GkN4LF; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=95JfMuuwwwlYjV2zqmhexIQdacuaBYC+NdT7w2fT52Q=; b=b/GkN4LFfJPns1b8
	gYuHMMcWTgo60iqVAS5m2gmE2RnqYwrpJBKjyScBAcECfIqtEfsme8QZ1xw1W6Xk3Xc1P6eqwkRUK
	g/+5XUkFwjBpH2CWGNru7C3GC5BBzmmpR2Azw1xyMkL71qQWxxlYbXZr12qvqKKNC9QQZvOmxIBEE
	p5ZcyIudvFvipfIi4w2FzoJihyW2OynGwKHlAEVs6vFvw7hI5X6Scii1UXjWtoZo4j6NNAnoBoJL+
	sTh3NtGdt4jG/6s113Uq9kFaOP1xftnU2v/b5qkPb9kX7jxoYeFx3TdWVuiBEcwFyGwKMTUCVWlxb
	M2modQL7Z8V5CG81ug==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1uAdTs-000xxT-1s;
	Thu, 01 May 2025 23:38:16 +0000
From: linux@treblig.org
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] sctp: Remove unused sctp_assoc_del_peer and sctp_chunk_iif
Date: Fri,  2 May 2025 00:38:15 +0100
Message-ID: <20250501233815.99832-1-linux@treblig.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

sctp_assoc_del_peer() last use was removed in 2015 by
commit 73e6742027f5 ("sctp: Do not try to search for the transport twice")
which now uses rm_peer instead of del_peer.

sctp_chunk_iif() last use was removed in 2016 by
commit 1f45f78f8e51 ("sctp: allow GSO frags to access the chunk too")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/net/sctp/sm.h      |  1 -
 include/net/sctp/structs.h |  2 --
 net/sctp/associola.c       | 18 ------------------
 net/sctp/sm_make_chunk.c   |  8 --------
 4 files changed, 29 deletions(-)

diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
index 64c42bd56bb2..3bfd261a53cc 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -161,7 +161,6 @@ const struct sctp_sm_table_entry *sctp_sm_lookup_event(
 					enum sctp_event_type event_type,
 					enum sctp_state state,
 					union sctp_subtype event_subtype);
-int sctp_chunk_iif(const struct sctp_chunk *);
 struct sctp_association *sctp_make_temp_asoc(const struct sctp_endpoint *,
 					     struct sctp_chunk *,
 					     gfp_t gfp);
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index dcd288fa1bb6..1ad7ce71d0a7 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -2152,8 +2152,6 @@ struct sctp_transport *sctp_assoc_add_peer(struct sctp_association *,
 				     const union sctp_addr *address,
 				     const gfp_t gfp,
 				     const int peer_state);
-void sctp_assoc_del_peer(struct sctp_association *asoc,
-			 const union sctp_addr *addr);
 void sctp_assoc_rm_peer(struct sctp_association *asoc,
 			 struct sctp_transport *peer);
 void sctp_assoc_control_transport(struct sctp_association *asoc,
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 760152e751c7..5793d71852b8 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -736,24 +736,6 @@ struct sctp_transport *sctp_assoc_add_peer(struct sctp_association *asoc,
 	return peer;
 }
 
-/* Delete a transport address from an association.  */
-void sctp_assoc_del_peer(struct sctp_association *asoc,
-			 const union sctp_addr *addr)
-{
-	struct list_head	*pos;
-	struct list_head	*temp;
-	struct sctp_transport	*transport;
-
-	list_for_each_safe(pos, temp, &asoc->peer.transport_addr_list) {
-		transport = list_entry(pos, struct sctp_transport, transports);
-		if (sctp_cmp_addr_exact(addr, &transport->ipaddr)) {
-			/* Do book keeping for removing the peer and free it. */
-			sctp_assoc_rm_peer(asoc, transport);
-			break;
-		}
-	}
-}
-
 /* Lookup a transport by address. */
 struct sctp_transport *sctp_assoc_lookup_paddr(
 					const struct sctp_association *asoc,
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index f80208edd6a5..3ead591c72fd 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -115,14 +115,6 @@ static void sctp_control_set_owner_w(struct sctp_chunk *chunk)
 	skb->destructor = sctp_control_release_owner;
 }
 
-/* What was the inbound interface for this chunk? */
-int sctp_chunk_iif(const struct sctp_chunk *chunk)
-{
-	struct sk_buff *skb = chunk->skb;
-
-	return SCTP_INPUT_CB(skb)->af->skb_iif(skb);
-}
-
 /* RFC 2960 3.3.2 Initiation (INIT) (1)
  *
  * Note 2: The ECN capable field is reserved for future use of
-- 
2.49.0


