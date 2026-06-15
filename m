Return-Path: <linux-sctp+bounces-1263-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iSDEL0dUMGqKRgUAu9opvQ
	(envelope-from <linux-sctp+bounces-1263-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 21:36:39 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3761C689742
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 21:36:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eV4GHmBd;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1263-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1263-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2810730309F3
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E083A962E;
	Mon, 15 Jun 2026 19:36:35 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B60B3AE193
	for <linux-sctp@vger.kernel.org>; Mon, 15 Jun 2026 19:36:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552195; cv=none; b=GuHNtknffES0nvVk96x4eOKCHZ3AWUMpK6Vgbv+WpSY7t9LgkhteeBtAMIIkFNPnJxxIQylFiwlVFjWM/+9XU5oD3JWDzeIhaAgrFhpHJ4bgfqAiSSEtlLuudSgukly4fEQVgIeeCcft2ieTj4Kn1vP2SwXK2GPpnslWX378+jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552195; c=relaxed/simple;
	bh=zExE5mU1uth3L3YciOkNs3dfGu8JI81ISthn7zqwI9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=caV4zKlB+jA//4bp0EHqjgWpthORdqBVyfwbiI3QYOdzjFUTixWxlWOd50r+0KnZZHMDv425gi8kciO86t/0snlu8dDKlcyPwrwmrGIjr+MqppzkfUaVJUlgEtJqs5AhgPD77947CK7Usn/+gsXrzkBrYZ6u7yJXlEy08n8HoaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eV4GHmBd; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9185503e6a5so316850585a.0
        for <linux-sctp@vger.kernel.org>; Mon, 15 Jun 2026 12:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781552192; x=1782156992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEPYbPBc5PCqVyemts16X0tQWPQJiI9iZvYMcKt7ijQ=;
        b=eV4GHmBdnBkmy3GkfHhfP1aIT7CWIzpo9b6VDrMf9nsHtxRLvYgj3nYp1PrbBGv1ep
         +0jH7yZMcG5jvUe09ctBrmPb+joJif6z3Y//Ahd9fKFeYKvRkzEw8pVWp3q8aOTaxzHd
         GYw4FpHu5nFKsuTNl4WgHSn+7Ve0QTC7Y5RWNjkSc4oXhkbVb/5AvV95pnj4t/PUZe5J
         h2gh98lyzE4bc0mKyRWN+Q6Q02ip+WzkhiLWyPeq1EcWX3m+SYihRAnzXnfSd8YvraKO
         AJQ+ZfIu3HS0XQtNEmFLXmewisSr6CWUd87ut1CaGe82CwdGSg8L2n89PQ4VVtE1pTE4
         LfVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781552192; x=1782156992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PEPYbPBc5PCqVyemts16X0tQWPQJiI9iZvYMcKt7ijQ=;
        b=pRjXzTYmer832S1PWfzKzkCOEP3q602G3V0nOJ66/2PdizVr+cCokABadEAMM9otAF
         KaYgdM+Uxv2VhNXtr5qaXk5PQ1H1We5oHOOvwYAcziiBSu6jQiDkf2I2k+G47tdsRd/c
         Ymi7D+TUQUvl7ns3huTpuQ/CRv2iyUCAxrKuf3aL/jHlCcGHKIsIykCydEfsitaRRKeB
         y4L4XrBRBKm0YjVHTZ1aiXwQpc4f/AwrOX+QJJGtROW572/+qHV+9uryT24Z8R/b4mMk
         clXaxRlq7/HaDdUqO1aYCN8nAw2FOQmhvVFz+7Tz7CBwXpCYkmzvNchnlDlAQcYBeUNi
         fkFg==
X-Forwarded-Encrypted: i=1; AFNElJ9t/pUqFZTErVJloyj+4FOgZKZWPs50tXQvUC7tCBpSQeNViUrRDNB6QSRRj0/YcHtrtmxwjz4H8A4E@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4mSntm7V9krefGP2qcqBzin1XMTy1liev3ygFec7xh72vadVI
	hXPARL88ynkziavx6lKRdifdPqRWQovpabuc+Sq+PtRwFtKV21lh4LxT
X-Gm-Gg: Acq92OHDMdBX9xwk628e+3St+8QQYHpmokRy0LgIsdmwZ9bCFXoa+0C9hi7J4EV4lPq
	23Hltwc483TeR0leSy9I+f8OJnqw8vSfOOrrq+zzQrFhTYiDkt9iz9C6hQ4gbpPIq2JrUVFvDRv
	b/TaAxrQb6oS6ZvlTI/TBLvmJvF2KTecYdbRsY4QtdomWBilqvTa+trWGsdj3iINfHRJGln/cfb
	7ib9OadY+o4DcyKYpUyeKd+Or+wRQ98sVV2n1yNKF4uG5CcbczstjBRUvnJH/tFTbHur+epicmJ
	42XVpYpbcQO+MbEC7HVJ46prTACkruLkSZQXUqTHsKiJH4MblEU23UwXcKGeHqFt6V0zRZ62op0
	72NtnRWS+4L/J9ng9kxZKH/KV+jrMEV+/Sc8oKSt80xCRyUmPMH0yMkXHTY8kz/P0kRiT78NIaD
	nGSElza/3UGnftW+rO+qHBiYoiy9kLVzDEdlpQ7mR0DMgJGddLZETqkyjJ9MyP197RsCNHtimPN
	bX//LWonLeuriJdpUlS77exBYGSxXER2tJDstddVoo1ZgKvslIeOhjGigK8RQbaMiZbt0OEjHRt
X-Received: by 2002:a05:620a:2914:b0:8ee:b817:9a03 with SMTP id af79cd13be357-91c2d8654f5mr139642385a.9.1781552192358;
        Mon, 15 Jun 2026 12:36:32 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f06835sm1229534085a.14.2026.06.15.12.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 12:36:31 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Willy Tarreau <w@1wt.eu>,
	Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: [PATCH net v2] sctp: hold socket lock when dumping endpoints in sctp_diag
Date: Mon, 15 Jun 2026 15:36:30 -0400
Message-ID: <4c1b49ab87e0f7d552ebd8172b364b1994e913c9.1781552190.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,1wt.eu,trendmicro.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1263-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:w@1wt.eu,m:zdi-disclosures@trendmicro.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,trendmicro.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3761C689742

SCTP_DIAG endpoint dumping was traversing endpoint address lists without
holding lock_sock(), while those lists could change concurrently via
socket operations (e.g., bindx changes). This creates a race where
nla_reserve() counts addresses under RCU protection, but the subsequent
copy may see fewer entries, potentially leaking uninitialized memory to
userspace.

Fix this by:

- Taking a reference on each endpoint during hash traversal
- Moving socket operations (lock_sock()) outside read_lock_bh()
- Serializing address list access during dump
- Reworking sctp_for_each_endpoint() to support restart-based traversal
  with (net, pos) tracking

Also:

- Add WARN_ON_ONCE() for inconsistent address counts
- Fix idiag_states filtering for LISTEN vs association cases
- Skip dumping endpoints being freed (ep->base.dead)
- Move dump position tracking into iterator, removing cb->args[4] and
  its comment for sctp_ep_dump().,
- Update the comment for cb->args[4] and remove the comment for unused
  cb->args[5] for sctp_sock_dump().

Note: traversal is restart-based and may re-scan buckets multiple times,
but this is acceptable due to small bucket sizes and required to support
sleeping-safe callbacks.

This issue was reported by Nico Yip (@_cyeaa_) working with TrendAI Zero
Day Initiative.

Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2:
  - Improve the changelog to cover more changes.
  - Check ep->base.dead instead of sctp_sstate(sk, CLOSED) in
    sctp_ep_dump().
  - Add an inline comment for idiag_states check in sctp_ep_dump().
  - Update the inline comment for cb->args[4] for sctp_sock_dump().
  - Simplify the code a bit by holding ep instead of sk in
    sctp_for_each_endpoint().
---
 include/net/sctp/sctp.h |  3 +-
 net/sctp/diag.c         | 67 ++++++++++++++++++++---------------------
 net/sctp/socket.c       | 29 +++++++++++++-----
 3 files changed, 56 insertions(+), 43 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 58242b37b47a..cd82b05354a3 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -111,7 +111,8 @@ int sctp_transport_lookup_process(sctp_callback_t cb, struct net *net,
 				  const union sctp_addr *paddr, void *p, int dif);
 int sctp_transport_traverse_process(sctp_callback_t cb, sctp_callback_t cb_done,
 				    struct net *net, int *pos, void *p);
-int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *), void *p);
+int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
+			   struct net *net, int *pos, void *p);
 int sctp_get_sctp_info(struct sock *sk, struct sctp_association *asoc,
 		       struct sctp_info *info);
 
diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index d758f5c3e06e..c2a0de2adf6f 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -92,6 +92,7 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 		if (!--addrcnt)
 			break;
 	}
+	WARN_ON_ONCE(addrcnt);
 	rcu_read_unlock();
 
 	return 0;
@@ -373,42 +374,39 @@ static int sctp_ep_dump(struct sctp_endpoint *ep, void *p)
 	struct sk_buff *skb = commp->skb;
 	struct netlink_callback *cb = commp->cb;
 	const struct inet_diag_req_v2 *r = commp->r;
-	struct net *net = sock_net(skb->sk);
 	struct inet_sock *inet = inet_sk(sk);
 	int err = 0;
 
-	if (!net_eq(sock_net(sk), net))
+	lock_sock(sk);
+	if (ep->base.dead)
 		goto out;
 
-	if (cb->args[4] < cb->args[1])
-		goto next;
-
-	if (!(r->idiag_states & TCPF_LISTEN) && !list_empty(&ep->asocs))
-		goto next;
+	/* Skip eps with assocs if non-LISTEN states were requested, since
+	 * they'll be dumped by sctp_sock_dump() during assoc traversal.
+	 */
+	if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
+	    !list_empty(&ep->asocs))
+		goto out;
 
 	if (r->sdiag_family != AF_UNSPEC &&
 	    sk->sk_family != r->sdiag_family)
-		goto next;
+		goto out;
 
 	if (r->id.idiag_sport != inet->inet_sport &&
 	    r->id.idiag_sport)
-		goto next;
+		goto out;
 
 	if (r->id.idiag_dport != inet->inet_dport &&
 	    r->id.idiag_dport)
-		goto next;
-
-	if (inet_sctp_diag_fill(sk, NULL, skb, r,
-				sk_user_ns(NETLINK_CB(cb->skb).sk),
-				NETLINK_CB(cb->skb).portid,
-				cb->nlh->nlmsg_seq, NLM_F_MULTI,
-				cb->nlh, commp->net_admin) < 0) {
-		err = 2;
 		goto out;
-	}
-next:
-	cb->args[4]++;
+
+	err = inet_sctp_diag_fill(sk, NULL, skb, r,
+				  sk_user_ns(NETLINK_CB(cb->skb).sk),
+				  NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
+				  cb->nlh, commp->net_admin);
 out:
+	release_sock(sk);
 	return err;
 }
 
@@ -479,41 +477,40 @@ static void sctp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 		.r = r,
 		.net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN),
 	};
-	int pos = cb->args[2];
+	int pos;
 
 	/* eps hashtable dumps
 	 * args:
 	 * 0 : if it will traversal listen sock
 	 * 1 : to record the sock pos of this time's traversal
-	 * 4 : to work as a temporary variable to traversal list
 	 */
 	if (cb->args[0] == 0) {
-		if (!(idiag_states & TCPF_LISTEN))
-			goto skip;
-		if (sctp_for_each_endpoint(sctp_ep_dump, &commp))
-			goto done;
-skip:
+		if (idiag_states & TCPF_LISTEN) {
+			pos = cb->args[1];
+			if (sctp_for_each_endpoint(sctp_ep_dump, net, &pos,
+						   &commp)) {
+				cb->args[1] = pos;
+				return;
+			}
+		}
 		cb->args[0] = 1;
 		cb->args[1] = 0;
-		cb->args[4] = 0;
 	}
 
+	if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
+		return;
+
 	/* asocs by transport hashtable dump
 	 * args:
 	 * 1 : to record the assoc pos of this time's traversal
 	 * 2 : to record the transport pos of this time's traversal
 	 * 3 : to mark if we have dumped the ep info of the current asoc
-	 * 4 : to work as a temporary variable to traversal list
-	 * 5 : to save the sk we get from travelsing the tsp list.
+	 * 4 : to track position within ep->asocs list in sctp_sock_dump()
 	 */
-	if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
-		goto done;
-
+	pos = cb->args[2];
 	sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
 					net, &pos, &commp);
 	cb->args[2] = pos;
-
-done:
 	cb->args[1] = cb->args[4];
 	cb->args[4] = 0;
 }
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 66e12fb0c646..c8481461f7d8 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5369,24 +5369,39 @@ struct sctp_transport *sctp_transport_get_idx(struct net *net,
 }
 
 int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
-			   void *p) {
-	int err = 0;
-	int hash = 0;
-	struct sctp_endpoint *ep;
+			   struct net *net, int *pos, void *p) {
+	int err, hash = 0, idx = 0, start;
 	struct sctp_hashbucket *head;
+	struct sctp_endpoint *ep;
 
 	for (head = sctp_ep_hashtable; hash < sctp_ep_hashsize;
 	     hash++, head++) {
+		start = idx;
+again:
 		read_lock_bh(&head->lock);
 		sctp_for_each_hentry(ep, &head->chain) {
-			err = cb(ep, p);
-			if (err)
+			if (sock_net(ep->base.sk) != net)
+				continue;
+			if (idx++ >= *pos) {
+				sctp_endpoint_hold(ep);
 				break;
+			}
 		}
 		read_unlock_bh(&head->lock);
+
+		if (ep) {
+			err = cb(ep, p);
+			sctp_endpoint_put(ep);
+			if (err)
+				return err;
+			(*pos)++;
+
+			idx = start;
+			goto again;
+		}
 	}
 
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(sctp_for_each_endpoint);
 
-- 
2.47.1


