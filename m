Return-Path: <linux-sctp+bounces-1311-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2RqlF5tnS2pwQwEAu9opvQ
	(envelope-from <linux-sctp+bounces-1311-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Jul 2026 10:30:19 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3570E1B2
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Jul 2026 10:30:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b="h/CL/4bK";
	dkim=pass header.d=linutronix.de header.s=2020e header.b=h1ZFsLjk;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1311-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1311-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BDF79311ABC3
	for <lists+linux-sctp@lfdr.de>; Mon,  6 Jul 2026 07:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46A33A9C1;
	Mon,  6 Jul 2026 07:38:38 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049E39C00A;
	Mon,  6 Jul 2026 07:38:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783323517; cv=none; b=tZn2AVE2i/yX/9+jcWSpjzSxdX4FH7Cd+Apoeg5AYANI33752VBKCBoiL1oBhTmmUDl0MLJxg/mbM+hTtBe+6WQuqxDLMqxYSItAzj9IIPeDaEFhACfz4e8Nb3uWx4LP2NdKae53gbjIsrgFK9BkM1C/zHWuc5U8kW06HMr6w1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783323517; c=relaxed/simple;
	bh=1gLGF9IsmyI26WbAe4SDrgBJ/qhGz/X/CmXiRDSskmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NeoBPO7ja1yASfNfWcto7cFjDIbjIQdD84/HGwiipj+prVwOI/ThUCcMqbQu7VYOGExAC6bq42rADOO8KKbAvkcHVlaQlrPbDVTxmC9eWi8mI5XRjKbCKMlEA6Ck7VucH/GtibPc9tMRGMCj5QZjhSKs8dTGuB+dTb86/5JcW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/CL/4bK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1ZFsLjk; arc=none smtp.client-ip=193.142.43.55
Date: Mon, 6 Jul 2026 09:38:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783323506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5IAtrkO9UAwExCb21TjOAlXys7k8G1RB0cyUpH/Rc3s=;
	b=h/CL/4bK1TMniKaY0N1hO0D+tWSPt3zgKzWlaOZZt2z4+EeExudtpvfuwHY9Aj7R86a+QY
	tLbP5N44Dwr6LxfKPlWiMJQLmaiCg6Uxf5IvzGkYAOBiL93qbStWzDoDkGU/Z1O/tXqHI3
	/U/g1yEAyn1uxxuEDaLFTL3LhAMHyCbTOFcabIz+nFK/pU5Yz1AZBA9UJTH7t+Xkbuooow
	da9QlOp8JKetgVMMfYcx918JvPsQ2eVTC5wtcT6r1RqwMt7o1nhGHUXtfYWEwRDnGuJa2C
	cdGzScu/Xv2TmcjsM7viZrx1U/59xgAIl0YxdLDDEcgAZKyRkH4vonSa6QpE2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783323506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5IAtrkO9UAwExCb21TjOAlXys7k8G1RB0cyUpH/Rc3s=;
	b=h1ZFsLjksjo/kokvSfqKiajg6p6botMYfcEOtTlBzaUOnDzwDSVGMcYEmfyQaBbPA9VXmq
	hXxJimuKnbN7mOBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-atm-general@lists.sourceforge.net, linux-can@vger.kernel.org,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Neal Cardwell <ncardwell@google.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Remi Denis-Courmont <courmisch@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH net-next] net: Convert %pK back to %p
Message-ID: <20260706073824.xixrLxoD@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1311-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-atm-general@lists.sourceforge.net,m:linux-can@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:herbert@gondor.apana.org.au,m:kuba@kernel.org,m:kuniyu@google.com,m:mkl@pengutronix.de,m:marcelo.leitner@gmail.com,m:ncardwell@google.com,m:socketcan@hartkopp.net,m:pabeni@redhat.com,m:courmisch@gmail.com,m:horms@kernel.org,m:steffen.klassert@secunet.com,m:willemdebruijn.kernel@gmail.com,m:lucien.xin@gmail.com,m:pmladek@suse.com,m:thomas.weissschuh@linutronix.de,m:kees@kernel.org,m:marceloleitner@gmail.com,m:willemdebruijnkernel@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,linux-sctp@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,gondor.apana.org.au,kernel.org,pengutronix.de,gmail.com,hartkopp.net,redhat.com,secunet.com,suse.com,linutronix.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:from_mime,linutronix.de:email,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2E3570E1B2

This is a revert of commit 71338aa7d050c ("net: convert %p usage to
%pK") which is from 2011. Back then the default behaviour for %p was to
print the pointer. The %pK modifier was introduced to be able to control
the behaviour of specific pointer output without changing the behaviour
of %p for everyone. It was dedicated to avoid leaking pointers via
/proc.
There was also the idea to remove the check from formatting the string
and move to the open callback (of the /proc file) with some helpers but
this did not happen.

Things changed over time. The default behaviour for %p is now to print a
hash pointer which does not leak the address but allows to
correlate if two pointers are equal. The pointer to hash value mapping
is not stable across reboots so one can not precompute the values and
have a lookup table. There is also the `hash_pointers' boot argument
which allows to disable it and print real pointers if needed. The
default behaviour of %pK (kptr_restrict==0) is already %p (hashed
pointer).

The %pK modifier brings hardly and value over %p. Removing it allows to
remove the policy checks from pointer formatting.

Switch back to the %p modifier.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

My long term goal is remove the restricted_pointer() handling from
vsprintf. I don't see any benefit in having it and case kptr_restrict==1
caused problems in terms of locking. Instead of attempting to get the
debug/ warn infrastructure right I am for removing it.

 net/atm/proc.c           | 2 +-
 net/can/bcm.c            | 6 +++---
 net/can/proc.c           | 4 ++--
 net/ipv4/ping.c          | 2 +-
 net/ipv4/raw.c           | 2 +-
 net/ipv4/tcp_ipv4.c      | 6 +++---
 net/ipv4/udp.c           | 2 +-
 net/ipv6/datagram.c      | 2 +-
 net/ipv6/tcp_ipv6.c      | 6 +++---
 net/key/af_key.c         | 2 +-
 net/netlink/af_netlink.c | 2 +-
 net/packet/af_packet.c   | 2 +-
 net/phonet/socket.c      | 2 +-
 net/sctp/proc.c          | 4 ++--
 net/unix/af_unix.c       | 2 +-
 15 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/net/atm/proc.c b/net/atm/proc.c
index 8f20b49b9c02a..2c39364edf929 100644
--- a/net/atm/proc.c
+++ b/net/atm/proc.c
@@ -159,7 +159,7 @@ static void vcc_info(struct seq_file *seq, struct atm_vcc *vcc)
 {
 	struct sock *sk = sk_atm(vcc);
 
-	seq_printf(seq, "%pK ", vcc);
+	seq_printf(seq, "%p ", vcc);
 	if (!vcc->dev)
 		seq_printf(seq, "Unassigned    ");
 	else
diff --git a/net/can/bcm.c b/net/can/bcm.c
index a4bef2c48a559..ce3650932d5cd 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -213,9 +213,9 @@ static int bcm_proc_show(struct seq_file *m, void *v)
 	struct bcm_sock *bo = bcm_sk(sk);
 	struct bcm_op *op;
 
-	seq_printf(m, ">>> socket %pK", sk->sk_socket);
-	seq_printf(m, " / sk %pK", sk);
-	seq_printf(m, " / bo %pK", bo);
+	seq_printf(m, ">>> socket %p", sk->sk_socket);
+	seq_printf(m, " / sk %p", sk);
+	seq_printf(m, " / bo %p", bo);
 	seq_printf(m, " / dropped %lu", bo->dropped_usr_msgs);
 	seq_printf(m, " / bound %s", bcm_proc_getifname(net, ifname, bo->ifindex));
 	seq_printf(m, " <<<\n");
diff --git a/net/can/proc.c b/net/can/proc.c
index de4d05ae34597..1f2611b0ccfc1 100644
--- a/net/can/proc.c
+++ b/net/can/proc.c
@@ -192,8 +192,8 @@ static void can_print_rcvlist(struct seq_file *m, struct hlist_head *rx_list,
 
 	hlist_for_each_entry_rcu(r, rx_list, list) {
 		char *fmt = (r->can_id & CAN_EFF_FLAG)?
-			"   %-5s  %08x  %08x  %pK  %pK  %8ld  %s\n" :
-			"   %-5s     %03x    %08x  %pK  %pK  %8ld  %s\n";
+			"   %-5s  %08x  %08x  %p  %p  %8ld  %s\n" :
+			"   %-5s     %03x    %08x  %p  %p  %8ld  %s\n";
 
 		seq_printf(m, fmt, DNAME(dev), r->can_id, r->mask,
 			   r->func, r->data, atomic_long_read(&r->matches),
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index d36f1e273fde4..d66811d825eba 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -1095,7 +1095,7 @@ static void ping_v4_format_sock(struct sock *sp, struct seq_file *f,
 	__u16 srcp = ntohs(inet->inet_sport);
 
 	seq_printf(f, "%5d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u",
+		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %p %u",
 		bucket, src, srcp, dest, destp, sp->sk_state,
 		sk_wmem_alloc_get(sp),
 		sk_rmem_alloc_get(sp),
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 2aebaf8297e04..c7ef95f8eb2c6 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -1045,7 +1045,7 @@ static void raw_sock_seq_show(struct seq_file *seq, struct sock *sp, int i)
 	      srcp  = inet->inet_num;
 
 	seq_printf(seq, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u\n",
+		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %p %u\n",
 		i, src, srcp, dest, destp, sp->sk_state,
 		sk_wmem_alloc_get(sp),
 		sk_rmem_alloc_get(sp),
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 209ef7522508f..aa31af06e5e3b 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2743,7 +2743,7 @@ static void get_openreq4(const struct request_sock *req,
 	long delta = req->rsk_timer.expires - jiffies;
 
 	seq_printf(f, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %u %d %pK",
+		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %u %d %p",
 		i,
 		ireq->ir_loc_addr,
 		ireq->ir_num,
@@ -2806,7 +2806,7 @@ static void get_tcp4_sock(struct sock *sk, struct seq_file *f, int i)
 				      READ_ONCE(tp->copied_seq), 0);
 
 	seq_printf(f, "%4d: %08X:%04X %08X:%04X %02X %08X:%08X %02X:%08lX "
-			"%08X %5u %8d %llu %d %pK %lu %lu %u %u %d",
+			"%08X %5u %8d %llu %d %p %lu %lu %u %u %d",
 		i, src, srcp, dest, destp, state,
 		READ_ONCE(tp->write_seq) - tp->snd_una,
 		rx_queue,
@@ -2839,7 +2839,7 @@ static void get_timewait4_sock(const struct inet_timewait_sock *tw,
 	srcp  = ntohs(tw->tw_sport);
 
 	seq_printf(f, "%4d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK",
+		" %02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %p",
 		i, src, srcp, dest, destp, READ_ONCE(tw->tw_substate), 0, 0,
 		3, jiffies_delta_to_clock_t(delta), 0, 0, 0, 0,
 		refcount_read(&tw->tw_refcnt), tw);
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 59248a59358ca..db3c90f9a56de 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -3280,7 +3280,7 @@ static void udp4_format_sock(struct sock *sp, struct seq_file *f,
 	__u16 srcp	  = ntohs(inet->inet_sport);
 
 	seq_printf(f, "%5d: %08X:%04X %08X:%04X"
-		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u",
+		" %02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %p %u",
 		bucket, src, srcp, dest, destp, sp->sk_state,
 		sk_wmem_alloc_get(sp),
 		udp_rqueue_get(sp),
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 38d7b48452817..7cfacc06a331c 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -1102,7 +1102,7 @@ void __ip6_dgram_sock_seq_show(struct seq_file *seq, struct sock *sp,
 	src   = &sp->sk_v6_rcv_saddr;
 	seq_printf(seq,
 		   "%5d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %u\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %p %u\n",
 		   bucket,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3], srcp,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index ebe161d72fbd0..e370b47171ce8 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2099,7 +2099,7 @@ static void get_openreq6(struct seq_file *seq,
 
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %d %d %pK\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %d %d %p\n",
 		   i,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3],
@@ -2167,7 +2167,7 @@ static void get_tcp6_sock(struct seq_file *seq, struct sock *sp, int i)
 
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %pK %lu %lu %u %u %d\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5u %8d %llu %d %p %lu %lu %u %u %d\n",
 		   i,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3], srcp,
@@ -2207,7 +2207,7 @@ static void get_timewait6_sock(struct seq_file *seq,
 
 	seq_printf(seq,
 		   "%4d: %08X%08X%08X%08X:%04X %08X%08X%08X%08X:%04X "
-		   "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %pK\n",
+		   "%02X %08X:%08X %02X:%08lX %08X %5d %8d %d %d %p\n",
 		   i,
 		   src->s6_addr32[0], src->s6_addr32[1],
 		   src->s6_addr32[2], src->s6_addr32[3], srcp,
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 1d8965d7f4f3c..4df706789280f 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3805,7 +3805,7 @@ static int pfkey_seq_show(struct seq_file *f, void *v)
 	if (v == SEQ_START_TOKEN)
 		seq_printf(f ,"sk       RefCnt Rmem   Wmem   User   Inode\n");
 	else
-		seq_printf(f, "%pK %-6d %-6u %-6u %-6u %-6llu\n",
+		seq_printf(f, "%p %-6d %-6u %-6u %-6u %-6llu\n",
 			       s,
 			       refcount_read(&s->sk_refcnt),
 			       sk_rmem_alloc_get(s),
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 5202fe0b08671..48a1996f897b9 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2706,7 +2706,7 @@ static int netlink_native_seq_show(struct seq_file *seq, void *v)
 		struct sock *s = v;
 		struct netlink_sock *nlk = nlk_sk(s);
 
-		seq_printf(seq, "%pK %-3d %-10u %08x %-8d %-8d %-5d %-8d %-8u %-8llu\n",
+		seq_printf(seq, "%p %-3d %-10u %08x %-8d %-8d %-5d %-8d %-8u %-8llu\n",
 			   s,
 			   s->sk_protocol,
 			   nlk->portid,
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 8e6f3a734ba0b..fd22ff5677ebc 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -4726,7 +4726,7 @@ static int packet_seq_show(struct seq_file *seq, void *v)
 		const struct packet_sock *po = pkt_sk(s);
 
 		seq_printf(seq,
-			   "%pK %-6d %-4d %04x   %-5d %1d %-6u %-6u %-6llu\n",
+			   "%p %-6d %-4d %04x   %-5d %1d %-6u %-6u %-6llu\n",
 			   s,
 			   refcount_read(&s->sk_refcnt),
 			   s->sk_type,
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index 631a99cdbd006..eefdb788be592 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -586,7 +586,7 @@ static int pn_sock_seq_show(struct seq_file *seq, void *v)
 		struct pn_sock *pn = pn_sk(sk);
 
 		seq_printf(seq, "%2d %04X:%04X:%02X %02X %08X:%08X %5d %llu "
-			"%d %pK %u",
+			"%d %p %u",
 			sk->sk_protocol, pn->sobject, pn->dobject,
 			pn->resource, sk->sk_state,
 			sk_wmem_alloc_get(sk), sk_rmem_alloc_get(sk),
diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index 43433d7e2acd7..cd99d634fa6d6 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -174,7 +174,7 @@ static int sctp_eps_seq_show(struct seq_file *seq, void *v)
 		sk = ep->base.sk;
 		if (!net_eq(sock_net(sk), seq_file_net(seq)))
 			continue;
-		seq_printf(seq, "%8pK %8pK %-3d %-3d %-4d %-5d %5u %5llu ", ep, sk,
+		seq_printf(seq, "%8p %8p %-3d %-3d %-4d %-5d %5u %5llu ", ep, sk,
 			   sctp_sk(sk)->type, sk->sk_state, hash,
 			   ep->base.bind_addr.port,
 			   from_kuid_munged(seq_user_ns(seq), sk_uid(sk)),
@@ -260,7 +260,7 @@ static int sctp_assocs_seq_show(struct seq_file *seq, void *v)
 	sk = epb->sk;
 
 	seq_printf(seq,
-		   "%8pK %8pK %-3d %-3d %-2d %-4d "
+		   "%8p %8p %-3d %-3d %-2d %-4d "
 		   "%4d %8d %8d %7u %5llu %-5d %5d ",
 		   assoc, sk, sctp_sk(sk)->type, sk->sk_state,
 		   assoc->state, 0,
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a1..6a8174977c87a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3554,7 +3554,7 @@ static int unix_seq_show(struct seq_file *seq, void *v)
 		struct unix_sock *u = unix_sk(s);
 		unix_state_lock(s);
 
-		seq_printf(seq, "%pK: %08X %08X %08X %04X %02X %5llu",
+		seq_printf(seq, "%p: %08X %08X %08X %04X %02X %5llu",
 			s,
 			refcount_read(&s->sk_refcnt),
 			0,
-- 
2.53.0


