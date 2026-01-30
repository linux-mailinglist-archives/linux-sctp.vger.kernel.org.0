Return-Path: <linux-sctp+bounces-774-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC4lIoRZfGkYMAIAu9opvQ
	(envelope-from <linux-sctp+bounces-774-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 30 Jan 2026 08:11:00 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E1B7CAC
	for <lists+linux-sctp@lfdr.de>; Fri, 30 Jan 2026 08:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC6C83013B47
	for <lists+linux-sctp@lfdr.de>; Fri, 30 Jan 2026 07:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A242FB0B9;
	Fri, 30 Jan 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="YSYYQWsT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A946A21883E;
	Fri, 30 Jan 2026 07:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769757056; cv=none; b=RWEYikg/8HLTLH35WapGZHhxbD5FwP7CDKZyEPxbtkoq2MMPIiN8Iu7cLfctOTya4A8pYjNLwkMk7IvxqD3/h/xhwYXYNWlqThYBldKO2aw8q1NXQGAhwFduHD3c8sFmK2n52BPesutzrVJsLMjEDiYl6rwFa7ACGlZgX+mDQyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769757056; c=relaxed/simple;
	bh=KyGofQA+yPanct2ad1s/4EMe4J4e3sxY1/iZhzeXLDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dY9yJGgDo0o+nfJ0Ep96MdoEhegMlv+cM1wQItr14gp226XUBJmFsQ0DAmavdegWNTRUi9klueGXjNT28F635Q5FyJnlHPSarMxjXiWUPJjkHM8qKmtZlBV0E1kFKyedG94Qy6xZAHEK3JIe9kUUyVzuuRLOpqKJtxCZjiPp+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=YSYYQWsT; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=YSYYQWsTrYbAoBDC46vtwuLGbtuuVniXpbR6fiTZCtjrq+fGx2gcc21OSKet3JUHn3hi812bEzFHB
	 OPH57CG8w4wvEIXe2MR35pxLZIo49HD6ocTrXxnzGsF3ZFl6khv27HqtOys1Zlo5sjokQM7OfrMWzB
	 zgK6DNvkun82xGmE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f37697c5978bec-04c4d;
	Fri, 30 Jan 2026 15:10:54 +0800 (CST)
X-RM-TRANSID:2f37697c5978bec-04c4d
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	lucien.xin@gmail.com
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	vyasevich@gmail.com,
	nhorman@tuxdriver.com,
	marcelo.leitner@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 6.1.y] sctp: linearize cloned gso packets in sctp_rcv
Date: Fri, 30 Jan 2026 15:10:38 +0800
Message-Id: <20260130071038.3931297-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-774-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,tuxdriver.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[139.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 208E1B7CAC
X-Rspamd-Action: no action

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit fd60d8a086191fe33c2d719732d2482052fa6805 ]

A cloned head skb still shares these frag skbs in fraglist with the
original head skb. It's not safe to access these frag skbs.

syzbot reported two use-of-uninitialized-memory bugs caused by this:

  BUG: KMSAN: uninit-value in sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
   sctp_inq_pop+0x15b7/0x1920 net/sctp/inqueue.c:211
   sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:998
   sctp_inq_push+0x2ef/0x380 net/sctp/inqueue.c:88
   sctp_backlog_rcv+0x397/0xdb0 net/sctp/input.c:331
   sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1122
   __release_sock+0x1da/0x330 net/core/sock.c:3106
   release_sock+0x6b/0x250 net/core/sock.c:3660
   sctp_wait_for_connect+0x487/0x820 net/sctp/socket.c:9360
   sctp_sendmsg_to_asoc+0x1ec1/0x1f00 net/sctp/socket.c:1885
   sctp_sendmsg+0x32b9/0x4a80 net/sctp/socket.c:2031
   inet_sendmsg+0x25a/0x280 net/ipv4/af_inet.c:851
   sock_sendmsg_nosec net/socket.c:718 [inline]

and

  BUG: KMSAN: uninit-value in sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
   sctp_assoc_bh_rcv+0x34e/0xbc0 net/sctp/associola.c:987
   sctp_inq_push+0x2a3/0x350 net/sctp/inqueue.c:88
   sctp_backlog_rcv+0x3c7/0xda0 net/sctp/input.c:331
   sk_backlog_rcv+0x142/0x420 include/net/sock.h:1148
   __release_sock+0x1d3/0x330 net/core/sock.c:3213
   release_sock+0x6b/0x270 net/core/sock.c:3767
   sctp_wait_for_connect+0x458/0x820 net/sctp/socket.c:9367
   sctp_sendmsg_to_asoc+0x223a/0x2260 net/sctp/socket.c:1886
   sctp_sendmsg+0x3910/0x49f0 net/sctp/socket.c:2032
   inet_sendmsg+0x269/0x2a0 net/ipv4/af_inet.c:851
   sock_sendmsg_nosec net/socket.c:712 [inline]

This patch fixes it by linearizing cloned gso packets in sctp_rcv().

Fixes: 90017accff61 ("sctp: Add GSO support")
Reported-by: syzbot+773e51afe420baaf0e2b@syzkaller.appspotmail.com
Reported-by: syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/dd7dc337b99876d4132d0961f776913719f7d225.1754595611.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Li hongliang <1468888505@139.com>
---
This patch is lost/missing, as it has already been added
into stable branches less than and greater than 6.1. Previous patch in
https://lore.kernel.org/stable/20251022075549.195012-1-kovalev@altlinux.org/ is still not added.
So I resent it again.
---
---
 net/sctp/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 4ee9374dcfb9..182898cb754a 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -114,7 +114,7 @@ int sctp_rcv(struct sk_buff *skb)
 	 * it's better to just linearize it otherwise crc computing
 	 * takes longer.
 	 */
-	if ((!is_gso && skb_linearize(skb)) ||
+	if (((!is_gso || skb_cloned(skb)) && skb_linearize(skb)) ||
 	    !pskb_may_pull(skb, sizeof(struct sctphdr)))
 		goto discard_it;
 
-- 
2.34.1



