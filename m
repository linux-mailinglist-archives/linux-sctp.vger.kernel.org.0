Return-Path: <linux-sctp+bounces-1225-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DtOBA4JG2pg+ggAu9opvQ
	(envelope-from <linux-sctp+bounces-1225-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 30 May 2026 17:58:06 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3460DD95
	for <lists+linux-sctp@lfdr.de>; Sat, 30 May 2026 17:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AC5330360B7
	for <lists+linux-sctp@lfdr.de>; Sat, 30 May 2026 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F41337699;
	Sat, 30 May 2026 15:57:36 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF60327C0D;
	Sat, 30 May 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156656; cv=none; b=bhdamjFe2Uzh0EoerWiGdqEMWYosxx5y5jqqln2Hxq3bSgTguJs+rsxUWUrJ3oXKDjb84AU6la+SotyQCUpIyOdKlsnB7ra7tvRnl3hIKwJPOE/1bNqZj+fMIspJKbmNJZYNmXmKr+CpXw/nVK0d4i9sH+AP6yMMEpF2+drXVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156656; c=relaxed/simple;
	bh=mnoFnQYhYA2he03EfVbg7R8e4M5dKnw2s3/hleZ2GOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJ5BjDgcwpZL2JZGrR22tDFHFzc5LCLuCLuMm4GL3ll38bLuXuQm3AKYVQLlkX9xEvOK8X0atQ7aMMcNQ6ZBTMtLXgIqH9Yt6pJY54b3oJTA4Xpl1ZDWoL03xU3fiCWqJWh6BQ0CuHxJMA2LxKhe/6QzrB8tYd1pe7I+o0O+NsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowADXcwvfCBtqe9QUAA--.42739S3;
	Sat, 30 May 2026 23:57:22 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	zzhan461@ucr.edu,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] sctp: diag: reject stale associations in dump_one path
Date: Sat, 30 May 2026 23:57:14 +0800
Message-ID: <fac6043fa20a2ff68e12958c431836f692c51268.1780113823.git.zzhan461@ucr.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1780113823.git.zzhan461@ucr.edu>
References: <cover.1780113823.git.zzhan461@ucr.edu>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowADXcwvfCBtqe9QUAA--.42739S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF1ruFWkXr4DWryrWr1fCrg_yoW8Kw1kpF
	ZxCrWqya4Utry7urnYkrWkZrW2kr4kK347Gryaqws8Z3WkGr1ftryIqw1qqry5ArWSkayY
	qF1qgFW5Jw15CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8V
	W8GwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEDCWoanc8GKQAAsH
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-1225-lists,linux-sctp=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,lzu.edu.cn,ucr.edu];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,linux-sctp@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.917];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ucr.edu:mid,ucr.edu:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6DD3460DD95
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Zhang <zzhan461@ucr.edu>

The SCTP exact sock_diag lookup can hold a transport reference, block on
lock_sock(sk), and then resume after sctp_association_free() has marked
the association dead and freed its bind address list.

When that happens, inet_assoc_attr_size() and
inet_diag_msg_sctpasoc_fill() can still dereference association state
that is no longer valid for reporting. In particular,
inet_diag_msg_sctpasoc_fill() may read an empty bind-address list as a
real sctp_sockaddr_entry and trigger an out-of-bounds read from
unrelated association memory.

Reject the association after taking the socket lock if it has been
reaped or detached from the endpoint, and report the lookup as stale.
This keeps the exact dump-one path from formatting torn association
state.

Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sctp/diag.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 2afb376299fe..d758f5c3e06e 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -266,15 +266,15 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 
 	lock_sock(sk);
 
-	rep = nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
-	if (!rep) {
-		release_sock(sk);
-		return -ENOMEM;
+	if (ep != assoc->ep || assoc->base.dead) {
+		err = -ESTALE;
+		goto out_unlock;
 	}
 
-	if (ep != assoc->ep) {
-		err = -EAGAIN;
-		goto out;
+	rep = nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
+	if (!rep) {
+		err = -ENOMEM;
+		goto out_unlock;
 	}
 
 	err = inet_sctp_diag_fill(sk, assoc, rep, req, sk_user_ns(NETLINK_CB(skb).sk),
@@ -289,8 +289,9 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 	return nlmsg_unicast(sock_net(skb->sk)->diag_nlsk, rep, NETLINK_CB(skb).portid);
 
 out:
-	release_sock(sk);
 	kfree_skb(rep);
+out_unlock:
+	release_sock(sk);
 	return err;
 }
 
-- 
2.47.3


