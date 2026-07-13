Return-Path: <linux-sctp+bounces-1330-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IQe1KHfHVGqFSwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1330-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 13:09:43 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6042474A2AF
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 13:09:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=OoTPnIF6;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1330-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1330-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9EF303CE0A
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 11:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5D93839AE;
	Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33A37A839;
	Mon, 13 Jul 2026 11:07:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783940874; cv=none; b=OyI/YAUarbzGH0KlaQM4b/K4lyUPY6MwuvQqaDmOoAlHZHh+RGuKAh4XGUe6rTgjfP/KlkFhlTQMa0M/oYwjC2+MV+a0mQ1hENCghp+rY+NSloYVZ8hSBiyU1P6ns5uKluT908YKQ6sO6qj928/wGXctd8qUNLKoW4/+q0LcOxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783940874; c=relaxed/simple;
	bh=gFPfNAZb5Emut5tl59jtS1GCSawh67g0IOaptPFibj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GWYRxsUty+wLcsMpnbfHJJWMAUu8+8jg62cmjmBdts+oKht/WX+5IAVEMeG196UjLjXIRY+tevO3TN/vQ4coFP92r16LPo97nj67/Gium+xE7jGhMg7f70WlrjDV0JTq8UDb1EbWEUVw4AXbP2LIOxytiN3ejksN2GhuHynSN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoTPnIF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C59C1C2BCF5;
	Mon, 13 Jul 2026 11:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783940873;
	bh=gFPfNAZb5Emut5tl59jtS1GCSawh67g0IOaptPFibj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OoTPnIF6SRLmVMupyhjeUKZcJU6AwKweMwZvPnhmtHyFwjFGZN6LED68Pg9kUqDIh
	 QnIthYMOQS0FSZyN1buNkwC7IBnD/H8mjUCso0YSIVQgD3rz7hwLyyHbzgQHsM/7et
	 ZMhrwojxoZ1IP71Bxifb4A/pv98lRSCNrDNqk2b+hWFAtomwindDIrfc8DsdmItmku
	 9UWDy/4ZhoDm6QwHErqcuP1uhsqGZI4fOzzRpLoXobSgVpMST0T+HlbbsFjoxIVHg/
	 J3TRolG2lzwG4pisXO7RHNB6bmwRtJM2ALur1waxVeb26jVXjtOo06m7mJb102PZH8
	 SjIX+F9U8UW0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BBCC44507;
	Mon, 13 Jul 2026 11:07:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 13 Jul 2026 13:07:42 +0200
Subject: [PATCH RFC net-next v3 1/3] net: enforce net sysctl registration
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-jag-net_const_qualify-v3-1-7289fe9eaea6@kernel.org>
References: <20260713-jag-net_const_qualify-v3-0-7289fe9eaea6@kernel.org>
In-Reply-To: <20260713-jag-net_const_qualify-v3-0-7289fe9eaea6@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Phil Sutter <phil@nwl.cc>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
 Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, 
 Mahanta Jambigi <mjambigi@linux.ibm.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org, 
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3574;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=gFPfNAZb5Emut5tl59jtS1GCSawh67g0IOaptPFibj4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpUxwZskgenDOU98txc57mfzp9zCAPadshX1
 w9t16Ag3hXFGYkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqVMcGAAoJELqXzVK3
 lkFPFuML/RuQe3IepvdaZwOqXPTFSxjiaQ9bHG5EjMlqTZJymTxUXke4CX6cffYqR8LOCXv/zqI
 Xz6yMTCeEaKdC/KbKlarrXHYnX0dUo/F3SqzxbWAoouVQN77rnoI7iQbY+TDK0GEy2zZONsm95u
 Vf+EfOQeGZuxwgpbCYUR8IBhhpqcVfuF0vI8vaxi7bhmmK30aRoBtLG+WYyHIgf/N7CXmGwRFxC
 yDHVArNMtiBNObUr0CVTFLxn8/BXuAIVrsNttsPGQm6aDvm3AQd87+wUS2otzOefZp82bJUl73e
 IzkI9JlAq/XN9dgNUEPdpolmegObR57+ikTaZzNrILLpVchdIIKBR4cZfPkGGVcjwBnrXrvM9Zy
 kksDs+AIzzP/SDuNq8GseNIMT37Jo/NFsSdfK+eblk8DVjuKx+gEwV7GHjkzZkGe6PEWWgIhT8f
 uCYW4EEdIC4+bpgG8ygVgbaTDyA1+W81V10LuKN5vBvLR6iuqzESCQGH1rg5ryeHGO+tKQvK3f8
 Ig=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1330-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,netfilter.org,strlen.de,nwl.cc,gmail.com,secunet.com,gondor.apana.org.au,linux.alibaba.com,linux.ibm.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:kuniyu@google.com,m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-sctp@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:virtualization@lists.linux.dev,m:joel.granados@kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[joel.granados@kernel.org,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joel.granados@kernel.org,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6042474A2AF

Replace the warning and file permission change with an error when an
"unsafe" net sysctl registration is detected.

One of the barriers preventing the const qualification of the ctl_tables
in the net directory is the permission (->mode) change in
ensure_safe_net_sysctl. This prep commit removes that barrier and
ensures that the received ctl_table pointer to the net ctl_table
register function is const.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/net/net_namespace.h |  4 ++--
 net/sysctl_net.c            | 24 ++++++++++++------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 80de5e98a66d6c9273aa7c5b9d489b22cef8559a..dca0ec809483bec604f4ca3d99dfea32834af8fa 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -522,12 +522,12 @@ struct ctl_table;
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
 struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
-					     struct ctl_table *table, size_t table_size);
+					     const struct ctl_table *table, size_t table_size);
 void unregister_net_sysctl_table(struct ctl_table_header *header);
 #else
 static inline int net_sysctl_init(void) { return 0; }
 static inline struct ctl_table_header *register_net_sysctl_sz(struct net *net,
-	const char *path, struct ctl_table *table, size_t table_size)
+	const char *path, const struct ctl_table *table, size_t table_size)
 {
 	return NULL;
 }
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 19e8048241bacb18de853d3b904d0f97fd2fe78a..4714887113d90a191c300c9c49a6317d5609efeb 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -114,16 +114,16 @@ __init int net_sysctl_init(void)
 	goto out;
 }
 
-/* Verify that sysctls for non-init netns are safe by either:
+/* Return error when sysctls for non-init netns are unsafe by verifying:
  * 1) being read-only, or
  * 2) having a data pointer which points outside of the global kernel/module
  *    data segment, and rather into the heap where a per-net object was
  *    allocated.
  */
-static void ensure_safe_net_sysctl(struct net *net, const char *path,
-				   struct ctl_table *table, size_t table_size)
+static int ensure_safe_net_sysctl(struct net *net, const char *path,
+				  const struct ctl_table *table, size_t table_size)
 {
-	struct ctl_table *ent;
+	const struct ctl_table *ent;
 
 	pr_debug("Registering net sysctl (net %p): %s\n", net, path);
 	ent = table;
@@ -149,24 +149,24 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 		else
 			continue;
 
-		/* If it is writable and points to kernel/module global
-		 * data, then it's probably a netns leak.
-		 */
+		/* Warn on netns leak. */
 		WARN(1, "sysctl %s/%s: data points to %s global data: %ps\n",
-		     path, ent->procname, where, ent->data);
+			path, ent->procname, where, ent->data);
 
-		/* Make it "safe" by dropping writable perms */
-		ent->mode &= ~0222;
+		return -EACCES;
 	}
+
+	return 0;
 }
 
 struct ctl_table_header *register_net_sysctl_sz(struct net *net,
 						const char *path,
-						struct ctl_table *table,
+						const struct ctl_table *table,
 						size_t table_size)
 {
 	if (!net_eq(net, &init_net))
-		ensure_safe_net_sysctl(net, path, table, table_size);
+		if (ensure_safe_net_sysctl(net, path, table, table_size))
+			return NULL;
 
 	return __register_sysctl_table(&net->sysctls, path, table, table_size);
 }

-- 
2.50.1



