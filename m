Return-Path: <linux-sctp+bounces-207-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D995B5C8
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA901281E67
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50191CB335;
	Thu, 22 Aug 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVZIRYC1"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CDF1C9EAC;
	Thu, 22 Aug 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331521; cv=none; b=C0PqwQcdSTYP3JD8yADiQbSaFXllv70FpJy8vETdkNixaSocrHVE/pPfRUBhYBJn0sQaze4hvjUAB7sduCjO2eOIABwdYJev1koeBUhTVGbUC82WVRdGAgCRRn7+1YzdkuLP76YIIuAPK85m2w9fkWa0dA0XpILSNIoB0GdhM5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331521; c=relaxed/simple;
	bh=qqHphxwn2qWHWhPAByHe6TETHqJld8jq2S4guezpHtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JzJy2EhlTeYUuRaIovwzkcTnNd4YsVUfcNDXSqy+Kswkir2Jz5xuNf8gXUI9HK7m5IAqs1ClOftP+AQhEg5lVKWYsYjuDLhBh7iccRgseo3Uj1EfZJB2ky2L02GNbPH0gBtn7gvpap0qiXa78Xwy5aMDS6PuqikIcQ7NguUHmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVZIRYC1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C705C4AF10;
	Thu, 22 Aug 2024 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331521;
	bh=qqHphxwn2qWHWhPAByHe6TETHqJld8jq2S4guezpHtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IVZIRYC1SXikCt6YX9RXFUr40kg1Ow9GbNopwC+COZy44oJhREgi+E0gE8ESH07w+
	 FVlKU27sXkg//XfKvMWWHdLG1nfSpjP4BCg5GvqZviH8oR2tJoSuG6yihG8j+uQTKn
	 v6R8HIHZuehlqxUhyzc/rKNWTYjpQC7ZisZ/skfbmERmsSJvvtLqnLDPC1hN6bTTly
	 QSrvV5owdJxsS3FYP57WO+VXLmY6of94Tu4ulUWgyf9I7CK/65odm63P44lwrS1nJy
	 W/SGzOSFB5QM+pOApcPdnQ/MH5izgqQbVmC3AOZCA7XCUBY4rE3vgbPpfL+CZgcXCD
	 aXt+63HXdWxIw==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:34 +0100
Subject: [PATCH net-next 13/13] net: Correct spelling in net/core
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-13-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in net/core.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 net/core/dev.c            |  6 +++---
 net/core/dev_addr_lists.c |  6 +++---
 net/core/fib_rules.c      |  2 +-
 net/core/gro.c            |  2 +-
 net/core/netpoll.c        |  2 +-
 net/core/pktgen.c         | 10 +++++-----
 net/core/skbuff.c         |  4 ++--
 net/core/sock.c           |  6 +++---
 net/core/utils.c          |  2 +-
 9 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index e7260889d4cb..2a7381e5cf88 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3705,7 +3705,7 @@ struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *d
 		next = skb->next;
 		skb_mark_not_on_list(skb);
 
-		/* in case skb wont be segmented, point to itself */
+		/* in case skb won't be segmented, point to itself */
 		skb->prev = skb;
 
 		skb = validate_xmit_skb(skb, dev, again);
@@ -11407,7 +11407,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
  *	@head: list of devices
  *
  *  Note: As most callers use a stack allocated list_head,
- *  we force a list_del() to make sure stack wont be corrupted later.
+ *  we force a list_del() to make sure stack won't be corrupted later.
  */
 void unregister_netdevice_many(struct list_head *head)
 {
@@ -11465,7 +11465,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	if (dev->features & NETIF_F_NETNS_LOCAL)
 		goto out;
 
-	/* Ensure the device has been registrered */
+	/* Ensure the device has been registered */
 	if (dev->reg_state != NETREG_REGISTERED)
 		goto out;
 
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index baa63dee2829..166e404f7c03 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -262,7 +262,7 @@ static int __hw_addr_sync_multiple(struct netdev_hw_addr_list *to_list,
 }
 
 /* This function only works where there is a strict 1-1 relationship
- * between source and destionation of they synch. If you ever need to
+ * between source and destination of they synch. If you ever need to
  * sync addresses to more then 1 destination, you need to use
  * __hw_addr_sync_multiple().
  */
@@ -299,8 +299,8 @@ void __hw_addr_unsync(struct netdev_hw_addr_list *to_list,
 EXPORT_SYMBOL(__hw_addr_unsync);
 
 /**
- *  __hw_addr_sync_dev - Synchonize device's multicast list
- *  @list: address list to syncronize
+ *  __hw_addr_sync_dev - Synchronize device's multicast list
+ *  @list: address list to synchronize
  *  @dev:  device to sync
  *  @sync: function to call if address should be added
  *  @unsync: function to call if address should be removed
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 6ebffbc63236..644c49079bb1 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -72,7 +72,7 @@ int fib_default_rule_add(struct fib_rules_ops *ops,
 	r->suppress_prefixlen = -1;
 	r->suppress_ifgroup = -1;
 
-	/* The lock is not required here, the list in unreacheable
+	/* The lock is not required here, the list in unreachable
 	 * at the moment this function is called */
 	list_add_tail(&r->list, &ops->rules_list);
 	return 0;
diff --git a/net/core/gro.c b/net/core/gro.c
index b3b43de1a650..3abad1b567dd 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -374,7 +374,7 @@ static void gro_list_prepare(const struct list_head *head,
 				       skb_mac_header(skb),
 				       maclen);
 
-		/* in most common scenarions 'slow_gro' is 0
+		/* in most common scenarios 'slow_gro' is 0
 		 * otherwise we are already on some slower paths
 		 * either skip all the infrequent tests altogether or
 		 * avoid trying too hard to skip each of them individually
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index a58ea724790c..8debf27f383b 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -162,7 +162,7 @@ static void poll_one_napi(struct napi_struct *napi)
 	if (test_and_set_bit(NAPI_STATE_NPSVC, &napi->state))
 		return;
 
-	/* We explicilty pass the polling call a budget of 0 to
+	/* We explicitly pass the polling call a budget of 0 to
 	 * indicate that we are clearing the Tx path only.
 	 */
 	work = napi->poll(napi, 0);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index ea55a758a475..4baf02db1f6a 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -69,7 +69,7 @@
  *
  * By design there should only be *one* "controlling" process. In practice
  * multiple write accesses gives unpredictable result. Understood by "write"
- * to /proc gives result code thats should be read be the "writer".
+ * to /proc gives result code that should be read be the "writer".
  * For practical use this should be no problem.
  *
  * Note when adding devices to a specific CPU there good idea to also assign
@@ -2371,11 +2371,11 @@ static void get_ipsec_sa(struct pktgen_dev *pkt_dev, int flow)
 
 		if (pkt_dev->spi) {
 			/* We need as quick as possible to find the right SA
-			 * Searching with minimum criteria to archieve this.
+			 * Searching with minimum criteria to achieve, this.
 			 */
 			x = xfrm_state_lookup_byspi(pn->net, htonl(pkt_dev->spi), AF_INET);
 		} else {
-			/* slow path: we dont already have xfrm_state */
+			/* slow path: we don't already have xfrm_state */
 			x = xfrm_stateonly_find(pn->net, DUMMY_MARK, 0,
 						(xfrm_address_t *)&pkt_dev->cur_daddr,
 						(xfrm_address_t *)&pkt_dev->cur_saddr,
@@ -3838,8 +3838,8 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
 	pkt_dev->ipsmode = XFRM_MODE_TRANSPORT;
 	pkt_dev->ipsproto = IPPROTO_ESP;
 
-	/* xfrm tunnel mode needs additional dst to extract outter
-	 * ip header protocol/ttl/id field, here creat a phony one.
+	/* xfrm tunnel mode needs additional dst to extract outer
+	 * ip header protocol/ttl/id field, here create a phony one.
 	 * instead of looking for a valid rt, which definitely hurting
 	 * performance under such circumstance.
 	 */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1748673e1fe0..6022c7359385 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5163,7 +5163,7 @@ EXPORT_SYMBOL_GPL(skb_to_sgvec);
  * 3. sg_unmark_end
  * 4. skb_to_sgvec(payload2)
  *
- * When mapping mutilple payload conditionally, skb_to_sgvec_nomark
+ * When mapping multiple payload conditionally, skb_to_sgvec_nomark
  * is more preferable.
  */
 int skb_to_sgvec_nomark(struct sk_buff *skb, struct scatterlist *sg,
@@ -6021,7 +6021,7 @@ EXPORT_SYMBOL(skb_try_coalesce);
  * @skb: buffer to clean
  * @xnet: packet is crossing netns
  *
- * skb_scrub_packet can be used after encapsulating or decapsulting a packet
+ * skb_scrub_packet can be used after encapsulating or decapsulating a packet
  * into/from a tunnel. Some information have to be cleared during these
  * operations.
  * skb_scrub_packet can also be used to clean a skb before injecting it in
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..468b1239606c 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2048,7 +2048,7 @@ static inline void sock_lock_init(struct sock *sk)
 
 /*
  * Copy all fields from osk to nsk but nsk->sk_refcnt must not change yet,
- * even temporarly, because of RCU lookups. sk_node should also be left as is.
+ * even temporarily, because of RCU lookups. sk_node should also be left as is.
  * We must not copy fields between sk_dontcopy_begin and sk_dontcopy_end
  */
 static void sock_copy(struct sock *nsk, const struct sock *osk)
@@ -2538,7 +2538,7 @@ void skb_set_owner_w(struct sk_buff *skb, struct sock *sk)
 	skb_set_hash_from_sk(skb, sk);
 	/*
 	 * We used to take a refcount on sk, but following operation
-	 * is enough to guarantee sk_free() wont free this sock until
+	 * is enough to guarantee sk_free() won't free this sock until
 	 * all in-flight packets are completed
 	 */
 	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
@@ -3697,7 +3697,7 @@ EXPORT_SYMBOL(sock_recv_errqueue);
  *
  *	FIX: POSIX 1003.1g is very ambiguous here. It states that
  *	asynchronous errors should be reported by getsockopt. We assume
- *	this means if you specify SO_ERROR (otherwise whats the point of it).
+ *	this means if you specify SO_ERROR (otherwise what is the point of it).
  */
 int sock_common_getsockopt(struct socket *sock, int level, int optname,
 			   char __user *optval, int __user *optlen)
diff --git a/net/core/utils.c b/net/core/utils.c
index c994e95172ac..27f4cffaae05 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *	Generic address resultion entity
+ *	Generic address resolution entity
  *
  *	Authors:
  *	net_random Alan Cox

-- 
2.43.0


