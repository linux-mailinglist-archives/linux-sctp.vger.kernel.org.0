Return-Path: <linux-sctp+bounces-206-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF3D95B5C4
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB171F22128
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3747A1C9DF8;
	Thu, 22 Aug 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgsDS9MU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077421C9DF6;
	Thu, 22 Aug 2024 12:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331517; cv=none; b=b8OH2+2bEBkJECip0ZFlQeQaccZd19o/iBAI7EoMco3RloN8/Dtxe0g+TY/ElXMZFG4f6lLIc+MHtzl9Glv2yrCg/DtHcC0eP9k+p4ZbogGXvsCpUxAHuk/sAiX7I4vpOlNI+jkfW5+cmkhaYeuO2jatOB6db0J+ihUOy0Rn7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331517; c=relaxed/simple;
	bh=24AETjKMzbddM6Bj/d+KJAowW7w2tX1dFCwIySqVgC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tnPxBOVoCCaLCvJ2uDPcYDwIpKvz6m1E3rBmhXyZFjDvmTXd+QPRE6rvjjCIM5xkMoO4bRaEeGgUkwc0TKzF/DXb0V0mYvu5HI+/PKJuvq+RTIb7Oms7QJKCVWQksnocMsldWCmUO7vuxGimM+lAqDoRmoWC9Xa0Uc6W8rVmq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgsDS9MU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73295C4AF0E;
	Thu, 22 Aug 2024 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331516;
	bh=24AETjKMzbddM6Bj/d+KJAowW7w2tX1dFCwIySqVgC8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IgsDS9MUoGnZC8npO2YMZC2DDPg8NhndlLlIYSNQH37UtFM6IttOMIlNNHB3Vm6EZ
	 /ibB40vsl/ZKqVWhAq4DIGWLsIAHLvIbzbMy0jq8NZJQ7WIkQiuScheERMS8KEtHV6
	 7Ybk87fi7+lvECmy/4LNL5oa/fV9gNeAGIlkG0yj2FISDzPNSijaryGc/NkGEUjo+N
	 +CqpGXVDWkbrxvHlNyU5CHikYwSEcaere5hNIi31HBm1FzG9IXBO7pP8edgC4QrfZf
	 TqSNWntdNVLOMdN0GKzXcSFT6XodhYoDbVu7o15SL4UdfUbchtbwRL4Hfq56mzbwsb
	 w7CvhtE6RrqSg==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:33 +0100
Subject: [PATCH net-next 12/13] net: Correct spelling in headers
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-12-3a98971ce2d2@kernel.org>
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

Correct spelling in Networking headers.
As reported by codespell.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/linux/etherdevice.h    |  2 +-
 include/linux/netdevice.h      |  8 ++++----
 include/net/addrconf.h         |  2 +-
 include/net/busy_poll.h        |  2 +-
 include/net/caif/caif_layer.h  |  4 ++--
 include/net/caif/cfpkt.h       |  2 +-
 include/net/dropreason-core.h  |  6 +++---
 include/net/dst.h              |  2 +-
 include/net/dst_cache.h        |  2 +-
 include/net/erspan.h           |  4 ++--
 include/net/hwbm.h             |  4 ++--
 include/net/llc_pdu.h          |  2 +-
 include/net/netlink.h          | 16 ++++++++--------
 include/net/netns/sctp.h       |  4 ++--
 include/net/regulatory.h       |  2 +-
 include/net/sock.h             |  4 ++--
 include/net/udp.h              |  2 +-
 include/uapi/linux/in.h        |  2 +-
 include/uapi/linux/inet_diag.h |  2 +-
 19 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/include/linux/etherdevice.h b/include/linux/etherdevice.h
index 0ed47d00549b..30114c25ad12 100644
--- a/include/linux/etherdevice.h
+++ b/include/linux/etherdevice.h
@@ -645,7 +645,7 @@ static inline struct ethhdr *eth_skb_pull_mac(struct sk_buff *skb)
 }
 
 /**
- * eth_skb_pad - Pad buffer to mininum number of octets for Ethernet frame
+ * eth_skb_pad - Pad buffer to minimum number of octets for Ethernet frame
  * @skb: Buffer to pad
  *
  * An Ethernet frame should have a minimum size of 60 bytes.  This function
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 614ec5d3d75b..c7822380281b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1237,7 +1237,7 @@ struct netdev_net_notifier {
  * int (*ndo_fdb_del)(struct ndmsg *ndm, struct nlattr *tb[],
  *		      struct net_device *dev,
  *		      const unsigned char *addr, u16 vid)
- *	Deletes the FDB entry from dev coresponding to addr.
+ *	Deletes the FDB entry from dev corresponding to addr.
  * int (*ndo_fdb_del_bulk)(struct nlmsghdr *nlh, struct net_device *dev,
  *			   struct netlink_ext_ack *extack);
  * int (*ndo_fdb_dump)(struct sk_buff *skb, struct netlink_callback *cb,
@@ -3512,7 +3512,7 @@ static inline void netdev_tx_completed_queue(struct netdev_queue *dev_queue,
 	dql_completed(&dev_queue->dql, bytes);
 
 	/*
-	 * Without the memory barrier there is a small possiblity that
+	 * Without the memory barrier there is a small possibility that
 	 * netdev_tx_sent_queue will miss the update and cause the queue to
 	 * be stopped forever
 	 */
@@ -4580,7 +4580,7 @@ void dev_uc_flush(struct net_device *dev);
 void dev_uc_init(struct net_device *dev);
 
 /**
- *  __dev_uc_sync - Synchonize device's unicast list
+ *  __dev_uc_sync - Synchronize device's unicast list
  *  @dev:  device to sync
  *  @sync: function to call if address should be added
  *  @unsync: function to call if address should be removed
@@ -4624,7 +4624,7 @@ void dev_mc_flush(struct net_device *dev);
 void dev_mc_init(struct net_device *dev);
 
 /**
- *  __dev_mc_sync - Synchonize device's multicast list
+ *  __dev_mc_sync - Synchronize device's multicast list
  *  @dev:  device to sync
  *  @sync: function to call if address should be added
  *  @unsync: function to call if address should be removed
diff --git a/include/net/addrconf.h b/include/net/addrconf.h
index c8ed31828db3..363dd63babe7 100644
--- a/include/net/addrconf.h
+++ b/include/net/addrconf.h
@@ -333,7 +333,7 @@ static inline struct inet6_dev *__in6_dev_get(const struct net_device *dev)
 /**
  * __in6_dev_stats_get - get inet6_dev pointer for stats
  * @dev: network device
- * @skb: skb for original incoming interface if neeeded
+ * @skb: skb for original incoming interface if needed
  *
  * Caller must hold rcu_read_lock or RTNL, because this function
  * does not take a reference on the inet6_dev.
diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index 9b09acac538e..5e3b5703e4ab 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -131,7 +131,7 @@ static inline void skb_mark_napi_id(struct sk_buff *skb,
 #endif
 }
 
-/* used in the protocol hanlder to propagate the napi_id to the socket */
+/* used in the protocol handler to propagate the napi_id to the socket */
 static inline void sk_mark_napi_id(struct sock *sk, const struct sk_buff *skb)
 {
 #ifdef CONFIG_NET_RX_BUSY_POLL
diff --git a/include/net/caif/caif_layer.h b/include/net/caif/caif_layer.h
index 0f45d875905f..053e7c6a6a66 100644
--- a/include/net/caif/caif_layer.h
+++ b/include/net/caif/caif_layer.h
@@ -20,7 +20,7 @@ struct caif_payload_info;
  * @assert: expression to evaluate.
  *
  * This function will print a error message and a do WARN_ON if the
- * assertion failes. Normally this will do a stack up at the current location.
+ * assertion fails. Normally this will do a stack up at the current location.
  */
 #define caif_assert(assert)					\
 do {								\
@@ -116,7 +116,7 @@ enum caif_direction {
  * @dn:		Pointer down to the layer below.
  * @node:	List node used when layer participate in a list.
  * @receive:	Packet receive function.
- * @transmit:	Packet transmit funciton.
+ * @transmit:	Packet transmit function.
  * @ctrlcmd:	Used for control signalling upwards in the stack.
  * @modemcmd:	Used for control signaling downwards in the stack.
  * @id:		The identity of this layer
diff --git a/include/net/caif/cfpkt.h b/include/net/caif/cfpkt.h
index 44d914a50369..acf664227d96 100644
--- a/include/net/caif/cfpkt.h
+++ b/include/net/caif/cfpkt.h
@@ -18,7 +18,7 @@ struct cfpkt *cfpkt_create(u16 len);
 
 /*
  * Destroy a CAIF Packet.
- * pkt Packet to be destoyed.
+ * pkt Packet to be destroyed.
  */
 void cfpkt_destroy(struct cfpkt *pkt);
 
diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 9707ab54fdd5..4748680e8c88 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -155,8 +155,8 @@ enum skb_drop_reason {
 	/** @SKB_DROP_REASON_SOCKET_RCVBUFF: socket receive buff is full */
 	SKB_DROP_REASON_SOCKET_RCVBUFF,
 	/**
-	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limition, such as udp packet
-	 * drop out of udp_memory_allocated.
+	 * @SKB_DROP_REASON_PROTO_MEM: proto memory limitation, such as
+	 * udp packet drop out of udp_memory_allocated.
 	 */
 	SKB_DROP_REASON_PROTO_MEM,
 	/**
@@ -217,7 +217,7 @@ enum skb_drop_reason {
 	 */
 	SKB_DROP_REASON_TCP_ZEROWINDOW,
 	/**
-	 * @SKB_DROP_REASON_TCP_OLD_DATA: the TCP data reveived is already
+	 * @SKB_DROP_REASON_TCP_OLD_DATA: the TCP data received is already
 	 * received before (spurious retrans may happened), see
 	 * LINUX_MIB_DELAYEDACKLOST
 	 */
diff --git a/include/net/dst.h b/include/net/dst.h
index 0aa331bd2fdb..0f303cc60252 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -341,7 +341,7 @@ static inline void __skb_tunnel_rx(struct sk_buff *skb, struct net_device *dev,
 	skb->dev = dev;
 
 	/*
-	 * Clear hash so that we can recalulate the hash for the
+	 * Clear hash so that we can recalculate the hash for the
 	 * encapsulated packet, unless we have already determine the hash
 	 * over the L4 4-tuple.
 	 */
diff --git a/include/net/dst_cache.h b/include/net/dst_cache.h
index b4a55d2d5e71..1961699598e2 100644
--- a/include/net/dst_cache.h
+++ b/include/net/dst_cache.h
@@ -102,7 +102,7 @@ int dst_cache_init(struct dst_cache *dst_cache, gfp_t gfp);
  *	@dst_cache: the cache
  *
  *	No synchronization is enforced: it must be called only when the cache
- *	is unsed.
+ *	is unused.
  */
 void dst_cache_destroy(struct dst_cache *dst_cache);
 
diff --git a/include/net/erspan.h b/include/net/erspan.h
index 6cb4cbd6a48f..c6209e7b6c96 100644
--- a/include/net/erspan.h
+++ b/include/net/erspan.h
@@ -89,7 +89,7 @@ enum erspan_encap_type {
 	ERSPAN_ENCAP_NOVLAN = 0x0,	/* originally without VLAN tag */
 	ERSPAN_ENCAP_ISL = 0x1,		/* originally ISL encapsulated */
 	ERSPAN_ENCAP_8021Q = 0x2,	/* originally 802.1Q encapsulated */
-	ERSPAN_ENCAP_INFRAME = 0x3,	/* VLAN tag perserved in frame */
+	ERSPAN_ENCAP_INFRAME = 0x3,	/* VLAN tag preserved in frame */
 };
 
 #define ERSPAN_V1_MDSIZE	4
@@ -192,7 +192,7 @@ static inline void erspan_build_header(struct sk_buff *skb,
 	enc_type = ERSPAN_ENCAP_NOVLAN;
 
 	/* If mirrored packet has vlan tag, extract tci and
-	 *  perserve vlan header in the mirrored frame.
+	 * preserve vlan header in the mirrored frame.
 	 */
 	if (eth->h_proto == htons(ETH_P_8021Q)) {
 		qp = (struct qtag_prefix *)(skb->data + 2 * ETH_ALEN);
diff --git a/include/net/hwbm.h b/include/net/hwbm.h
index aa495decec35..bdbe91c609ff 100644
--- a/include/net/hwbm.h
+++ b/include/net/hwbm.h
@@ -11,9 +11,9 @@ struct hwbm_pool {
 	int frag_size;
 	/* Number of buffers currently used by this pool */
 	int buf_num;
-	/* constructor called during alocation */
+	/* constructor called during allocation */
 	int (*construct)(struct hwbm_pool *bm_pool, void *buf);
-	/* protect acces to the buffer counter*/
+	/* protect access to the buffer counter*/
 	struct mutex buf_lock;
 	/* private data */
 	void *priv;
diff --git a/include/net/llc_pdu.h b/include/net/llc_pdu.h
index 1d55ba7c45be..86681f29bda7 100644
--- a/include/net/llc_pdu.h
+++ b/include/net/llc_pdu.h
@@ -254,7 +254,7 @@ static inline void llc_pdu_header_init(struct sk_buff *skb, u8 type,
 }
 
 /**
- *	llc_pdu_decode_sa - extracs source address (MAC) of input frame
+ *	llc_pdu_decode_sa - extracts, source address (MAC) of input frame
  *	@skb: input skb that source address must be extracted from it.
  *	@sa: pointer to source address (6 byte array).
  *
diff --git a/include/net/netlink.h b/include/net/netlink.h
index e78ce008e07c..db6af207287c 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -827,7 +827,7 @@ nlmsg_parse_deprecated_strict(const struct nlmsghdr *nlh, int hdrlen,
 /**
  * nlmsg_find_attr - find a specific attribute in a netlink message
  * @nlh: netlink message header
- * @hdrlen: length of familiy specific header
+ * @hdrlen: length of family specific header
  * @attrtype: type of attribute to look for
  *
  * Returns the first attribute which matches the specified type.
@@ -849,7 +849,7 @@ static inline struct nlattr *nlmsg_find_attr(const struct nlmsghdr *nlh,
  *
  * Validates all attributes in the specified attribute stream against the
  * specified policy. Validation is done in liberal mode.
- * See documenation of struct nla_policy for more details.
+ * See documentation of struct nla_policy for more details.
  *
  * Returns 0 on success or a negative error code.
  */
@@ -872,7 +872,7 @@ static inline int nla_validate_deprecated(const struct nlattr *head, int len,
  *
  * Validates all attributes in the specified attribute stream against the
  * specified policy. Validation is done in strict mode.
- * See documenation of struct nla_policy for more details.
+ * See documentation of struct nla_policy for more details.
  *
  * Returns 0 on success or a negative error code.
  */
@@ -887,7 +887,7 @@ static inline int nla_validate(const struct nlattr *head, int len, int maxtype,
 /**
  * nlmsg_validate_deprecated - validate a netlink message including attributes
  * @nlh: netlinket message header
- * @hdrlen: length of familiy specific header
+ * @hdrlen: length of family specific header
  * @maxtype: maximum attribute type to be expected
  * @policy: validation policy
  * @extack: extended ACK report struct
@@ -933,7 +933,7 @@ static inline u32 nlmsg_seq(const struct nlmsghdr *nlh)
  * nlmsg_for_each_attr - iterate over a stream of attributes
  * @pos: loop counter, set to current attribute
  * @nlh: netlink message header
- * @hdrlen: length of familiy specific header
+ * @hdrlen: length of family specific header
  * @rem: initialized to len, holds bytes currently remaining in stream
  */
 #define nlmsg_for_each_attr(pos, nlh, hdrlen, rem) \
@@ -1034,7 +1034,7 @@ static inline struct sk_buff *nlmsg_new_large(size_t payload)
  * @skb: socket buffer the message is stored in
  * @nlh: netlink message header
  *
- * Corrects the netlink message header to include the appeneded
+ * Corrects the netlink message header to include the appended
  * attributes. Only necessary if attributes have been added to
  * the message.
  */
@@ -1954,7 +1954,7 @@ static inline struct nlattr *nla_nest_start(struct sk_buff *skb, int attrtype)
  * @start: container attribute
  *
  * Corrects the container attribute header to include the all
- * appeneded attributes.
+ * appended attributes.
  *
  * Returns the total data length of the skb.
  */
@@ -1987,7 +1987,7 @@ static inline void nla_nest_cancel(struct sk_buff *skb, struct nlattr *start)
  *
  * Validates all attributes in the nested attribute stream against the
  * specified policy. Attributes with a type exceeding maxtype will be
- * ignored. See documenation of struct nla_policy for more details.
+ * ignored. See documentation of struct nla_policy for more details.
  *
  * Returns 0 on success or a negative error code.
  */
diff --git a/include/net/netns/sctp.h b/include/net/netns/sctp.h
index 7eff3d981b89..d25cd7a9c5ff 100644
--- a/include/net/netns/sctp.h
+++ b/include/net/netns/sctp.h
@@ -125,14 +125,14 @@ struct netns_sctp {
 	int pf_expose;
 
 	/*
-	 * Policy for preforming sctp/socket accounting
+	 * Policy for performing sctp/socket accounting
 	 * 0   - do socket level accounting, all assocs share sk_sndbuf
 	 * 1   - do sctp accounting, each asoc may use sk_sndbuf bytes
 	 */
 	int sndbuf_policy;
 
 	/*
-	 * Policy for preforming sctp/socket accounting
+	 * Policy for performing sctp/socket accounting
 	 * 0   - do socket level accounting, all assocs share sk_rcvbuf
 	 * 1   - do sctp accounting, each asoc may use sk_rcvbuf bytes
 	 */
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index a103f4c8cf75..6633627f6e76 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -121,7 +121,7 @@ struct regulatory_request {
  * @REGULATORY_DISABLE_BEACON_HINTS: enable this if your driver needs to
  *	ensure that passive scan flags and beaconing flags may not be lifted by
  *	cfg80211 due to regulatory beacon hints. For more information on beacon
- *	hints read the documenation for regulatory_hint_found_beacon()
+ *	hints read the documentation for regulatory_hint_found_beacon()
  * @REGULATORY_COUNTRY_IE_FOLLOW_POWER:  for devices that have a preference
  *	that even though they may have programmed their own custom power
  *	setting prior to wiphy registration, they want to ensure their channel
diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..f51d61fab059 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1624,7 +1624,7 @@ bool __lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
  * lock_sock_fast - fast version of lock_sock
  * @sk: socket
  *
- * This version should be used for very small section, where process wont block
+ * This version should be used for very small section, where process won't block
  * return false if fast path is taken:
  *
  *   sk_lock.slock locked, owned = 0, BH disabled
@@ -2546,7 +2546,7 @@ struct sock_skb_cb {
 
 /* Store sock_skb_cb at the end of skb->cb[] so protocol families
  * using skb->cb[] would keep using it directly and utilize its
- * alignement guarantee.
+ * alignment guarantee.
  */
 #define SOCK_SKB_CB_OFFSET ((sizeof_field(struct sk_buff, cb) - \
 			    sizeof(struct sock_skb_cb)))
diff --git a/include/net/udp.h b/include/net/udp.h
index 5ca53b1cec67..61222545ab1c 100644
--- a/include/net/udp.h
+++ b/include/net/udp.h
@@ -232,7 +232,7 @@ static inline __be16 udp_flow_src_port(struct net *net, struct sk_buff *skb,
 	}
 
 	/* Since this is being sent on the wire obfuscate hash a bit
-	 * to minimize possbility that any useful information to an
+	 * to minimize possibility that any useful information to an
 	 * attacker is leaked. Only upper 16 bits are relevant in the
 	 * computation for 16 bit port value.
 	 */
diff --git a/include/uapi/linux/in.h b/include/uapi/linux/in.h
index d358add1611c..5d32d53508d9 100644
--- a/include/uapi/linux/in.h
+++ b/include/uapi/linux/in.h
@@ -141,7 +141,7 @@ struct in_addr {
  */
 #define IP_PMTUDISC_INTERFACE		4
 /* weaker version of IP_PMTUDISC_INTERFACE, which allows packets to get
- * fragmented if they exeed the interface mtu
+ * fragmented if they exceed the interface mtu
  */
 #define IP_PMTUDISC_OMIT		5
 
diff --git a/include/uapi/linux/inet_diag.h b/include/uapi/linux/inet_diag.h
index 50655de04c9b..86bb2e8b17c9 100644
--- a/include/uapi/linux/inet_diag.h
+++ b/include/uapi/linux/inet_diag.h
@@ -143,7 +143,7 @@ enum {
 	INET_DIAG_SHUTDOWN,
 
 	/*
-	 * Next extenstions cannot be requested in struct inet_diag_req_v2:
+	 * Next extensions cannot be requested in struct inet_diag_req_v2:
 	 * its field idiag_ext has only 8 bits.
 	 */
 

-- 
2.43.0


