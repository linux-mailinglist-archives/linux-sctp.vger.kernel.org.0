Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051843BD45F
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jul 2021 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhGFMIm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Jul 2021 08:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236979AbhGFLft (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 6 Jul 2021 07:35:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 44FEA61C90;
        Tue,  6 Jul 2021 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570697;
        bh=AszlLmrr/DkBA+BewiOFppzAnRfPe3LiNHUR+guaQQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=obrgKrsnC88rzWDKVRoqLG7ut16JQGuVZt579qw/Nd1a0MRhg6mU6ChxkP+X16DID
         D4CDtejz6kV7Yz6L1fcIdAn6HgX7FCFSCHEKDF1QbrY48QOaetS1wPc9ShD+ZO23DC
         s7PAwBoVKW+hrhxbrgz2lXT8mysDuVB2fzo3qmW64XI8YECg7pn0MRfiJ+oV5AEuZJ
         0YuMy+8gx/LgyhLOtfsNp6Y1uAp0etsgsgnRG0F54GJ+gutnU9lghYioqwj4AUdT84
         bAqhXz9carjuj/IrNCPa1bpOphk5L4G16yOAloBHIRzBzsg2nRIJI2Wo1xkMjzT9lu
         y1A0wo04nc6CA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 134/137] sctp: validate from_addr_param return
Date:   Tue,  6 Jul 2021 07:22:00 -0400
Message-Id: <20210706112203.2062605-134-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112203.2062605-1-sashal@kernel.org>
References: <20210706112203.2062605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit 0c5dc070ff3d6246d22ddd931f23a6266249e3db ]

Ilja reported that, simply putting it, nothing was validating that
from_addr_param functions were operating on initialized memory. That is,
the parameter itself was being validated by sctp_walk_params, but it
doesn't check for types and their specific sizes and it could be a 0-length
one, causing from_addr_param to potentially work over the next parameter or
even uninitialized memory.

The fix here is to, in all calls to from_addr_param, check if enough space
is there for the wanted IP address type.

Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/sctp/structs.h |  2 +-
 net/sctp/bind_addr.c       | 19 +++++++++++--------
 net/sctp/input.c           |  6 ++++--
 net/sctp/ipv6.c            |  7 ++++++-
 net/sctp/protocol.c        |  7 ++++++-
 net/sctp/sm_make_chunk.c   | 29 ++++++++++++++++-------------
 6 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 0bdff38eb4bb..51d698f2656f 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -458,7 +458,7 @@ struct sctp_af {
 					 int saddr);
 	void		(*from_sk)	(union sctp_addr *,
 					 struct sock *sk);
-	void		(*from_addr_param) (union sctp_addr *,
+	bool		(*from_addr_param) (union sctp_addr *,
 					    union sctp_addr_param *,
 					    __be16 port, int iif);
 	int		(*to_addr_param) (const union sctp_addr *,
diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
index 53e5ed79f63f..59e653b528b1 100644
--- a/net/sctp/bind_addr.c
+++ b/net/sctp/bind_addr.c
@@ -270,22 +270,19 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp, __u8 *raw_addr_list,
 		rawaddr = (union sctp_addr_param *)raw_addr_list;
 
 		af = sctp_get_af_specific(param_type2af(param->type));
-		if (unlikely(!af)) {
+		if (unlikely(!af) ||
+		    !af->from_addr_param(&addr, rawaddr, htons(port), 0)) {
 			retval = -EINVAL;
-			sctp_bind_addr_clean(bp);
-			break;
+			goto out_err;
 		}
 
-		af->from_addr_param(&addr, rawaddr, htons(port), 0);
 		if (sctp_bind_addr_state(bp, &addr) != -1)
 			goto next;
 		retval = sctp_add_bind_addr(bp, &addr, sizeof(addr),
 					    SCTP_ADDR_SRC, gfp);
-		if (retval) {
+		if (retval)
 			/* Can't finish building the list, clean up. */
-			sctp_bind_addr_clean(bp);
-			break;
-		}
+			goto out_err;
 
 next:
 		len = ntohs(param->length);
@@ -294,6 +291,12 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp, __u8 *raw_addr_list,
 	}
 
 	return retval;
+
+out_err:
+	if (retval)
+		sctp_bind_addr_clean(bp);
+
+	return retval;
 }
 
 /********************************************************************
diff --git a/net/sctp/input.c b/net/sctp/input.c
index d508f6f3dd08..8924e2e142c8 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1131,7 +1131,8 @@ static struct sctp_association *__sctp_rcv_init_lookup(struct net *net,
 		if (!af)
 			continue;
 
-		af->from_addr_param(paddr, params.addr, sh->source, 0);
+		if (!af->from_addr_param(paddr, params.addr, sh->source, 0))
+			continue;
 
 		asoc = __sctp_lookup_association(net, laddr, paddr, transportp);
 		if (asoc)
@@ -1174,7 +1175,8 @@ static struct sctp_association *__sctp_rcv_asconf_lookup(
 	if (unlikely(!af))
 		return NULL;
 
-	af->from_addr_param(&paddr, param, peer_port, 0);
+	if (af->from_addr_param(&paddr, param, peer_port, 0))
+		return NULL;
 
 	return __sctp_lookup_association(net, laddr, &paddr, transportp);
 }
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index c8074f435d3e..d594b949ae82 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -530,15 +530,20 @@ static void sctp_v6_to_sk_daddr(union sctp_addr *addr, struct sock *sk)
 }
 
 /* Initialize a sctp_addr from an address parameter. */
-static void sctp_v6_from_addr_param(union sctp_addr *addr,
+static bool sctp_v6_from_addr_param(union sctp_addr *addr,
 				    union sctp_addr_param *param,
 				    __be16 port, int iif)
 {
+	if (ntohs(param->v6.param_hdr.length) < sizeof(struct sctp_ipv6addr_param))
+		return false;
+
 	addr->v6.sin6_family = AF_INET6;
 	addr->v6.sin6_port = port;
 	addr->v6.sin6_flowinfo = 0; /* BUG */
 	addr->v6.sin6_addr = param->v6.addr;
 	addr->v6.sin6_scope_id = iif;
+
+	return true;
 }
 
 /* Initialize an address parameter from a sctp_addr and return the length
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 25833238fe93..47fb87ce489f 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -253,14 +253,19 @@ static void sctp_v4_to_sk_daddr(union sctp_addr *addr, struct sock *sk)
 }
 
 /* Initialize a sctp_addr from an address parameter. */
-static void sctp_v4_from_addr_param(union sctp_addr *addr,
+static bool sctp_v4_from_addr_param(union sctp_addr *addr,
 				    union sctp_addr_param *param,
 				    __be16 port, int iif)
 {
+	if (ntohs(param->v4.param_hdr.length) < sizeof(struct sctp_ipv4addr_param))
+		return false;
+
 	addr->v4.sin_family = AF_INET;
 	addr->v4.sin_port = port;
 	addr->v4.sin_addr.s_addr = param->v4.addr.s_addr;
 	memset(addr->v4.sin_zero, 0, sizeof(addr->v4.sin_zero));
+
+	return true;
 }
 
 /* Initialize an address parameter from a sctp_addr and return the length
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index b9d6babe2870..7411fa442821 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2329,11 +2329,13 @@ int sctp_process_init(struct sctp_association *asoc, struct sctp_chunk *chunk,
 
 	/* Process the initialization parameters.  */
 	sctp_walk_params(param, peer_init, init_hdr.params) {
-		if (!src_match && (param.p->type == SCTP_PARAM_IPV4_ADDRESS ||
-		    param.p->type == SCTP_PARAM_IPV6_ADDRESS)) {
+		if (!src_match &&
+		    (param.p->type == SCTP_PARAM_IPV4_ADDRESS ||
+		     param.p->type == SCTP_PARAM_IPV6_ADDRESS)) {
 			af = sctp_get_af_specific(param_type2af(param.p->type));
-			af->from_addr_param(&addr, param.addr,
-					    chunk->sctp_hdr->source, 0);
+			if (!af->from_addr_param(&addr, param.addr,
+						 chunk->sctp_hdr->source, 0))
+				continue;
 			if (sctp_cmp_addr_exact(sctp_source(chunk), &addr))
 				src_match = 1;
 		}
@@ -2514,7 +2516,8 @@ static int sctp_process_param(struct sctp_association *asoc,
 			break;
 do_addr_param:
 		af = sctp_get_af_specific(param_type2af(param.p->type));
-		af->from_addr_param(&addr, param.addr, htons(asoc->peer.port), 0);
+		if (!af->from_addr_param(&addr, param.addr, htons(asoc->peer.port), 0))
+			break;
 		scope = sctp_scope(peer_addr);
 		if (sctp_in_scope(net, &addr, scope))
 			if (!sctp_assoc_add_peer(asoc, &addr, gfp, SCTP_UNCONFIRMED))
@@ -2615,15 +2618,13 @@ static int sctp_process_param(struct sctp_association *asoc,
 		addr_param = param.v + sizeof(struct sctp_addip_param);
 
 		af = sctp_get_af_specific(param_type2af(addr_param->p.type));
-		if (af == NULL)
+		if (!af)
 			break;
 
-		af->from_addr_param(&addr, addr_param,
-				    htons(asoc->peer.port), 0);
+		if (!af->from_addr_param(&addr, addr_param,
+					 htons(asoc->peer.port), 0))
+			break;
 
-		/* if the address is invalid, we can't process it.
-		 * XXX: see spec for what to do.
-		 */
 		if (!af->addr_valid(&addr, NULL, NULL))
 			break;
 
@@ -3037,7 +3038,8 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 	if (unlikely(!af))
 		return SCTP_ERROR_DNS_FAILED;
 
-	af->from_addr_param(&addr, addr_param, htons(asoc->peer.port), 0);
+	if (!af->from_addr_param(&addr, addr_param, htons(asoc->peer.port), 0))
+		return SCTP_ERROR_DNS_FAILED;
 
 	/* ADDIP 4.2.1  This parameter MUST NOT contain a broadcast
 	 * or multicast address.
@@ -3314,7 +3316,8 @@ static void sctp_asconf_param_success(struct sctp_association *asoc,
 
 	/* We have checked the packet before, so we do not check again.	*/
 	af = sctp_get_af_specific(param_type2af(addr_param->p.type));
-	af->from_addr_param(&addr, addr_param, htons(bp->port), 0);
+	if (!af->from_addr_param(&addr, addr_param, htons(bp->port), 0))
+		return;
 
 	switch (asconf_param->param_hdr.type) {
 	case SCTP_PARAM_ADD_IP:
-- 
2.30.2

