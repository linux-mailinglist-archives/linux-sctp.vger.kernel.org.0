Return-Path: <linux-sctp+bounces-1316-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W78TN4gSUGqXswIAu9opvQ
	(envelope-from <linux-sctp+bounces-1316-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 09 Jul 2026 23:28:40 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7903A735D00
	for <lists+linux-sctp@lfdr.de>; Thu, 09 Jul 2026 23:28:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JOB9dDaC;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1316-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1316-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E84DF3016B6F
	for <lists+linux-sctp@lfdr.de>; Thu,  9 Jul 2026 21:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0373BB680;
	Thu,  9 Jul 2026 21:28:38 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603F1D5160
	for <linux-sctp@vger.kernel.org>; Thu,  9 Jul 2026 21:28:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783632518; cv=none; b=JvBEL9qkWCzcSZBSBYopBHZfXLWddguOrTq5PZapoXPEeu4BCtMDCqFtyUkp489XS8Mfhnb+BcobHNO6Keck6nZF0GR18HFZtLCKpLByn8fo4k0Nu0xjxL/GiShfYmhEqwikEdKejtYBZ5i+Qn4NwSBgeIgQW5MHeZqkyu595HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783632518; c=relaxed/simple;
	bh=RfK4Rc+82FAtWUKvR0czhUym4lsT1kXkCb6HVu1HCxI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lhhyw70oWKqOOzGrOpKvQuNUK4hA3Fgy1NrWSos+gtmmbqAgOPYg4guftqAfLOspzcKzPyuo79buAzVs3nRNSDJKpe8m/26DJdXNNy+UU+/9kH1wkvL+I2Su5Vu6hNjlGitf4CuSqqVYIW3rQdO41fzFejllXvSlbMIf8rueUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOB9dDaC; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-922ff615c14so17716285a.3
        for <linux-sctp@vger.kernel.org>; Thu, 09 Jul 2026 14:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783632515; x=1784237315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGPBGDpmMCJG1jdmjxc2zGCbnDM99IZvLsk38bHA9OQ=;
        b=JOB9dDaCekjMUQcPq9Nzb26Xu6j+ZCsuJVfhuuSUF6Yc6UcmtQfw3gB9iXwFc+9DVE
         YkpwNlZy6B5BevvyGGyO8sCnE9C0yEVcBfpOAwegeAnOlUXW7e71EhE2vX8taReWdMWH
         dmDxe/XMQRNtme0hH7WU2/CVid7eI8r7gny7cWx2WGUVLlNx0P+lpS6tb4Mmy2TyOMJ/
         ghy8QvaxCq5xWAamj9H3jrkaSj86Ya2tV1vKe1z8c6XjXcArFv0CWv5e7OFiflhVWvgB
         8Zfbl4VefWCARFzkJQQPhTvcJJgMd01whC82f6NGK0zuH/28RTymvLHbtgsZu/xp60sd
         M/cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783632515; x=1784237315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGPBGDpmMCJG1jdmjxc2zGCbnDM99IZvLsk38bHA9OQ=;
        b=eB3m/UFdfmmbCq7xIXbqgcKl/s0FOo1nghLEIQQC+2W/QRFDDEjsc/iDJtr833tmTY
         eczKIMyNTdPX8eMpkABQdltmv5h4VeGOXUsxKx4t3Kju0fMOvukfiId16Yc0oaV440VX
         dK0wNFDzsAKWYxsC7JKOMc0JLWIyFbYZO32KlSk1E3WWpoJLqHKUUbTnvacewZEb8rP0
         V/+159KR3H8DTEYMVy7FsmL2QhAkBRwsPRqBwVysuFl4l7i5KJuy1c0yxz94xXMJ1oTM
         AXvctDygF0ODLLIP0rJNg29M080Jao8A6bc5EZjBErTp4Fgwpop7lyozOGgEZPCqmr/3
         T/Zw==
X-Forwarded-Encrypted: i=1; AHgh+RqCG/I/kzB0Mp5fDQ33axpA5woJKayeOA9cL9YOntue9Ds7t7ZltSRIzXOJYuE5kxQerdogv3y4X8yV@vger.kernel.org
X-Gm-Message-State: AOJu0YwFiEMzVwbxE3vUGz2bv3AncRbT7kdSeUyvbwa2YwZxxUD7xPoH
	0wbf5cU06U+x4X9srM+Vsqv+UP5MrMomypknR81aUN5lFNOsL9IHideB
X-Gm-Gg: AfdE7cnaIyvyE9pjDU9eUa1tD7ByZdJUVxCgJ+yk3TK7DfqUnmLiASkf2/5cVNBYoNj
	ll6NiPhofYU0vxHUnqvpnduW6hJTtlBUMIxL9+IjNcbdKrn0Cfzxnhcc+MtsdacFhW3fo4i2HsA
	+TNGj+uR0bHp9GA5yNRdNgU+XUeF6FKzEzCPYdxxoGA9I28C7S8YNg0SyjKoH1IkoOg3N6Kmp0k
	bSBK8YuaWfKpNzq+hh0rNcPfbcAmITEcOIzKBV6X/cWQ57hp4hP+UqKwZWhO3HX7yWYyWHVN3KJ
	TVVT2zZxpmeaoVsNyW+cZydp1vatf28qU4IOoX0r59/7JETgd0Sr0kJXYunERHWy8wbDPaW+op0
	kokIT7dqBsSCRx6wEO/neBiK6UhaowbViUf+CqcJwe2EO3o/7CezE04NnEEX+9b/YdjODHAuhQE
	bo8rJlqZV28InJseq3luOWBJ0/gWCF75oo6ruVqFZ4T9LF0bYCjlsrQnCQEHhfQtgDnXMoLCkfu
	ZKvoaCO2yr0PDld3NfVkqRDHVGXyd09eRip7V80bGgQ1+5+21A807UfaFzeIUeNmg==
X-Received: by 2002:ac8:5e51:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-51c8b3f9775mr89854991cf.35.1783632515371;
        Thu, 09 Jul 2026 14:28:35 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caae206b6sm3237861cf.14.2026.07.09.14.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 14:28:34 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net-next] sctp: replace cb->args[4] with a local variable in sctp_diag_dump()
Date: Thu,  9 Jul 2026 17:28:33 -0400
Message-ID: <e0076ec046fbd8a70d4f3facfb701473d08c3ebb.1783632513.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1316-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7903A735D00

cb->args[4] is currently used as a temporary counter to track the assoc
index while traversing ep->asocs in sctp_sock_dump(). However, this
state is only needed locally within a single dump iteration and does not
need to be preserved across callbacks.

Replace cb->args[4] with a local idx variable in sctp_sock_dump(), and
update cb->args[1] directly when the dump is interrupted due to skb
space exhaustion.

This simplifies the dump state handling and removes the dependency on an
extra cb->args[] slot, making the traversal logic easier to follow.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/diag.c | 45 ++++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index c2a0de2adf6f..a9bb31303613 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -299,18 +299,21 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 static int sctp_sock_dump(struct sctp_endpoint *ep, struct sctp_transport *tsp, void *p)
 {
 	struct sctp_comm_param *commp = p;
-	struct sock *sk = ep->base.sk;
+	struct sock *sk = ep->base.sk, *nsk;
 	struct sk_buff *skb = commp->skb;
 	struct netlink_callback *cb = commp->cb;
 	const struct inet_diag_req_v2 *r = commp->r;
+	u32 portid = NETLINK_CB(cb->skb).portid;
 	struct sctp_association *assoc;
-	int err = 0;
+	int err = 0, idx = 0;
+
+	nsk = NETLINK_CB(cb->skb).sk;
 
 	lock_sock(sk);
 	if (ep != tsp->asoc->ep)
 		goto release;
 	list_for_each_entry(assoc, &ep->asocs, asocs) {
-		if (cb->args[4] < cb->args[1])
+		if (idx < cb->args[1])
 			goto next;
 
 		if (r->id.idiag_sport != htons(assoc->base.bind_addr.port) &&
@@ -320,32 +323,31 @@ static int sctp_sock_dump(struct sctp_endpoint *ep, struct sctp_transport *tsp,
 		    r->id.idiag_dport)
 			goto next;
 
-		if (!cb->args[3] &&
-		    inet_sctp_diag_fill(sk, NULL, skb, r,
-					sk_user_ns(NETLINK_CB(cb->skb).sk),
-					NETLINK_CB(cb->skb).portid,
-					cb->nlh->nlmsg_seq,
-					NLM_F_MULTI, cb->nlh,
-					commp->net_admin) < 0) {
-			err = 1;
-			goto release;
+		if (!cb->args[3]) {
+			err = inet_sctp_diag_fill(sk, NULL, skb, r,
+						  sk_user_ns(nsk), portid,
+						  cb->nlh->nlmsg_seq,
+						  NLM_F_MULTI, cb->nlh,
+						  commp->net_admin);
+			if (err < 0) {
+				cb->args[1] = idx;
+				goto release;
+			}
 		}
 		cb->args[3] = 1;
 
-		if (inet_sctp_diag_fill(sk, assoc, skb, r,
-					sk_user_ns(NETLINK_CB(cb->skb).sk),
-					NETLINK_CB(cb->skb).portid,
-					cb->nlh->nlmsg_seq, 0, cb->nlh,
-					commp->net_admin) < 0) {
-			err = 1;
+		err = inet_sctp_diag_fill(sk, assoc, skb, r, sk_user_ns(nsk),
+					  portid, cb->nlh->nlmsg_seq, 0,
+					  cb->nlh, commp->net_admin);
+		if (err < 0) {
+			cb->args[1] = idx;
 			goto release;
 		}
 next:
-		cb->args[4]++;
+		idx++;
 	}
 	cb->args[1] = 0;
 	cb->args[3] = 0;
-	cb->args[4] = 0;
 release:
 	release_sock(sk);
 	return err;
@@ -505,14 +507,11 @@ static void sctp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
 	 * 1 : to record the assoc pos of this time's traversal
 	 * 2 : to record the transport pos of this time's traversal
 	 * 3 : to mark if we have dumped the ep info of the current asoc
-	 * 4 : to track position within ep->asocs list in sctp_sock_dump()
 	 */
 	pos = cb->args[2];
 	sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
 					net, &pos, &commp);
 	cb->args[2] = pos;
-	cb->args[1] = cb->args[4];
-	cb->args[4] = 0;
 }
 
 static const struct inet_diag_handler sctp_diag_handler = {
-- 
2.47.1


