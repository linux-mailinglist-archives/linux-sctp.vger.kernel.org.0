Return-Path: <linux-sctp+bounces-1158-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KrsFtSE0mliYgcAu9opvQ
	(envelope-from <linux-sctp+bounces-1158-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 05 Apr 2026 17:50:44 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A58F139EE8F
	for <lists+linux-sctp@lfdr.de>; Sun, 05 Apr 2026 17:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07E103017270
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Apr 2026 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92EA2FB084;
	Sun,  5 Apr 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzhnYc9c"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C0730B529
	for <linux-sctp@vger.kernel.org>; Sun,  5 Apr 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775404106; cv=none; b=uphvn8CJ4kLCGyIt48UPbbVrcTvjDblmMwVQTcqKnJmFjuAHm+9htFc3tLLvPlrJ+oRVfH7T4GLnL+iSZk+gmxZ7Y9OyeGUZG8l6P5Kbw7XV5PPlmrkf6SmKxC4ZLuswbpThAONqmXHoZtEZU+m6cNZUVG1KQRz3NY3DgH21/sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775404106; c=relaxed/simple;
	bh=MrlBMIl68Z2aMl2ScQ2BVndAayou0hU09d6+YgdqAzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfy/LdZtzRLTCy9umE+QfarzTmYucQFREIbkMh+nJYl3ElghEFd6PiAaPybrDCE0vLxLctawHUGvuVYP4eMQ3fLKk0iq5vlExfoN9R0eNOipaPzXjY2GkHe6q2LNTqJLLvU2rCmN4rTodwP5mDMe/0DQSJDi6F+vtdFVj0+IxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SzhnYc9c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso9827305e9.0
        for <linux-sctp@vger.kernel.org>; Sun, 05 Apr 2026 08:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775404100; x=1776008900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ejC9X9oL82T7UTRyPRfLQE9jbWqA07yGBE+sGIzbzg=;
        b=SzhnYc9c09ZUJxViq8NuyR1J7rbrygz0aqcsGwT7xHsRtqeEdMuAMciD4L0qEjBmhr
         65zFQtLOvov3XBgjrK5tbT23IB3PdDkzugL6mhtsBKr2xEO684tupfhprQBh8wcXUWPS
         5Z3G/SaLQXD8mmlPwBDKDbh6DfBUcxN/Nm2zA5f5DcwkCPo07WyJEOz+CqOQbVknq2dP
         pMmqnhNznctm+RdHSjGItJlsN1qEaI6ZslRBtPQvtUbFb6KE1JQpiNkbLF9OyO4CI7fK
         5akgoU5tGSj49n1jkwBjf0glBNYMnraz4P6u0TSB4AMJ2K0kC2llzR2VUnQpbntlB/rM
         ASpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775404100; x=1776008900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ejC9X9oL82T7UTRyPRfLQE9jbWqA07yGBE+sGIzbzg=;
        b=LU16ECDL4sqL2+vWnvLeUt/lG02SgTrRiqsy8AluvyLuAl0haPJgi+rwJwq3O2iJ/D
         lSLq0h6XkH1EN/4IKxArzPm9oNafz7KqzrbEoAZbAmqzosgim697xIgjjfOYu/9T0Dou
         nnoouFCF2FQn0RwrT3xVtLsZAAl3z3Ega6CDzc/Uilt5Kd1jf4wqsvtlTDPCPbw9aE1z
         8s6MFxob+Ao1RBwbvN8EA24mKbkZyR1L5N+x/mQzaihg3xrnelkDckURnU9rQXBkMtP1
         3LnFciecWeSJDoWHZKDDRiRGWplMrEgo/hg0LqJ9MtHQFQKO+8jgd2LKxo3yQAUryklt
         zTZA==
X-Forwarded-Encrypted: i=1; AJvYcCW0wRXCYmcpLfbqJ2MaalIUD7eBTEl/DXPXw6WqchwzCIPLY9HLamJwFyGx7sfaGb2AzBC84EQgYKQz@vger.kernel.org
X-Gm-Message-State: AOJu0YzNObstVftaD5xthMPWqMhhVsmE2EkvprXiJ8UmKNOigWC7PSQr
	Ki3ASZmkKT7Axi7LQWHcpJUmM4NnFOOh/D29EMCbMOwzQikDYBzejZp8
X-Gm-Gg: AeBDietHAsqMzHAt82CoskfzN06+9g3JYBrFe+oHBoGnhjDgwFQNeiq5oujEP8F9WgE
	GDudZttfyyMfh93OooNoLIYBe7nZqzkLs3EPfXhoKLBFkvCkTV7NRyzLq7YA1mAbD+blqmQByKc
	lz97kRgrBxYsxlECtFP7iOiYZ6gBBLrYoZJgCjluWfOm4dF7NMpuKQ9PlmJvFb7+JATG64JdNGm
	eAJdnEfYzxLP4NzbgDsOcRIa9GHGKreYRNDQ9x4p2K+9te30FbQAikZKfZ+0GesUdlGJEhdKLWJ
	PhqUDbdwUCV5zISp5Rqsai4wbyZ4M+NbriVhIUtfXQIJUXGCu+HNzNoWAwrgFX0N0X9/cO/NWyE
	aojjkc/ai5QDS8hfTKQyIQWTmPfxCPadbw1rOOgq5wwICnXc4SSZK6XUgNZm8VpzY/T5eEXZDAa
	EgGaRZMxoYWbfW/4bRRTX4OqBLi9j79i23jHEycuTsslL03gAw9oE0n4DAy8G2Et5mxnATXZUpb
	ccOohv1mmzU
X-Received: by 2002:a05:600c:1396:b0:487:338:b4f3 with SMTP id 5b1f17b1804b1-488997d1371mr147256185e9.17.1775404099759;
        Sun, 05 Apr 2026 08:48:19 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e93cf2dsm390530145e9.11.2026.04.05.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 08:48:19 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mptcp@lists.linux.dev,
	dev@openvswitch.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
Date: Sun,  5 Apr 2026 16:48:16 +0100
Message-ID: <20260405154816.4774-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,gmail.com,sipsolutions.net,redhat.com,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1158-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A58F139EE8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the typed random integer helpers instead of
get_random_bytes() when filling a single integer variable.
The helpers return the value directly, require no pointer
or size argument, and better express intent.

Skipped sites writing into __be16 fields (netdevsim) where
a direct assignment would trigger sparse endianness warnings.

Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/net/netdevsim/psample.c | 4 ++--
 net/ceph/auth_x.c               | 2 +-
 net/core/net_namespace.c        | 2 +-
 net/mac80211/mesh_plink.c       | 2 +-
 net/mptcp/subflow.c             | 4 ++--
 net/openvswitch/flow_table.c    | 2 +-
 net/sctp/sm_make_chunk.c        | 4 ++--
 net/tipc/node.c                 | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netdevsim/psample.c b/drivers/net/netdevsim/psample.c
index 47d24bc64ee4..717d157c3ae2 100644
--- a/drivers/net/netdevsim/psample.c
+++ b/drivers/net/netdevsim/psample.c
@@ -94,7 +94,7 @@ static void nsim_dev_psample_md_prepare(const struct nsim_dev_psample *psample,
 	if (psample->out_tc_occ_max) {
 		u64 out_tc_occ;
 
-		get_random_bytes(&out_tc_occ, sizeof(u64));
+		out_tc_occ = get_random_u64();
 		md->out_tc_occ = out_tc_occ & (psample->out_tc_occ_max - 1);
 		md->out_tc_occ_valid = 1;
 	}
@@ -102,7 +102,7 @@ static void nsim_dev_psample_md_prepare(const struct nsim_dev_psample *psample,
 	if (psample->latency_max) {
 		u64 latency;
 
-		get_random_bytes(&latency, sizeof(u64));
+		latency = get_random_u64();
 		md->latency = latency & (psample->latency_max - 1);
 		md->latency_valid = 1;
 	}
diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
index 692e0b868822..936b43ae4a95 100644
--- a/net/ceph/auth_x.c
+++ b/net/ceph/auth_x.c
@@ -571,7 +571,7 @@ static int ceph_x_build_request(struct ceph_auth_client *ac,
 			blob = enc_buf + SHA256_DIGEST_SIZE;
 		}
 
-		get_random_bytes(&auth->client_challenge, sizeof(u64));
+		auth->client_challenge = get_random_u64();
 		blob->client_challenge = auth->client_challenge;
 		blob->server_challenge = cpu_to_le64(xi->server_challenge);
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1057d16d5dd2..deb8b2ec5674 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -411,7 +411,7 @@ static __net_init int preinit_net(struct net *net, struct user_namespace *user_n
 	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt");
 
-	get_random_bytes(&net->hash_mix, sizeof(u32));
+	net->hash_mix = get_random_u32();
 	net->dev_base_seq = 1;
 	net->user_ns = user_ns;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 803106fc3134..7cbab90c8784 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -712,7 +712,7 @@ void mesh_plink_timer(struct timer_list *t)
 				"Mesh plink for %pM (retry, timeout): %d %d\n",
 				sta->sta.addr, sta->mesh->plink_retries,
 				sta->mesh->plink_timeout);
-			get_random_bytes(&rand, sizeof(u32));
+			rand = get_random_u32();
 			sta->mesh->plink_timeout = sta->mesh->plink_timeout +
 					     rand % sta->mesh->plink_timeout;
 			++sta->mesh->plink_retries;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5cfe19990f31..1a7736145dbc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -72,7 +72,7 @@ static void subflow_req_create_thmac(struct mptcp_subflow_request_sock *subflow_
 	struct mptcp_sock *msk = subflow_req->msk;
 	u8 hmac[SHA256_DIGEST_SIZE];
 
-	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
+	subflow_req->local_nonce = get_random_u32();
 
 	subflow_generate_hmac(READ_ONCE(msk->local_key),
 			      READ_ONCE(msk->remote_key),
@@ -1639,7 +1639,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_pm_local *local,
 	ssk = sf->sk;
 	subflow = mptcp_subflow_ctx(ssk);
 	do {
-		get_random_bytes(&subflow->local_nonce, sizeof(u32));
+		subflow->local_nonce = get_random_u32();
 	} while (!subflow->local_nonce);
 
 	/* if 'IPADDRANY', the ID will be set later, after the routing */
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 61c6a5f77c2e..67d5b8c0fe79 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -167,7 +167,7 @@ static struct table_instance *table_instance_alloc(int new_size)
 
 	ti->n_buckets = new_size;
 	ti->node_ver = 0;
-	get_random_bytes(&ti->hash_seed, sizeof(u32));
+	ti->hash_seed = get_random_u32();
 
 	return ti;
 }
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 2c0017d058d4..de86ac088289 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -2727,7 +2727,7 @@ __u32 sctp_generate_tag(const struct sctp_endpoint *ep)
 	__u32 x;
 
 	do {
-		get_random_bytes(&x, sizeof(__u32));
+		x = get_random_u32();
 	} while (x == 0);
 
 	return x;
@@ -2738,7 +2738,7 @@ __u32 sctp_generate_tsn(const struct sctp_endpoint *ep)
 {
 	__u32 retval;
 
-	get_random_bytes(&retval, sizeof(__u32));
+	retval = get_random_u32();
 	return retval;
 }
 
diff --git a/net/tipc/node.c b/net/tipc/node.c
index af442a5ef8f3..97aa970a0d83 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1275,7 +1275,7 @@ void tipc_node_check_dest(struct net *net, u32 addr,
 			goto exit;
 
 		if_name = strchr(b->name, ':') + 1;
-		get_random_bytes(&session, sizeof(u16));
+		session = get_random_u16();
 		if (!tipc_link_create(net, if_name, b->identity, b->tolerance,
 				      b->net_plane, b->mtu, b->priority,
 				      b->min_win, b->max_win, session,
-- 
2.53.0


