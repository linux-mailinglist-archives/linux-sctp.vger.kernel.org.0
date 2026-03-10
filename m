Return-Path: <linux-sctp+bounces-997-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFz+L3MTsGlRfQIAu9opvQ
	(envelope-from <linux-sctp+bounces-997-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:49:55 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E6424EE94
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D08B03083FB9
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149A4A3406;
	Tue, 10 Mar 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="YdBwgMkR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A338451052;
	Tue, 10 Mar 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143744; cv=none; b=UKwj/MvLqeyR4ugKfa7UgLfKqvsUgF8iMxbtjxVCosR1w+WScgDEhMSPksHqxlkwz1UadINPUPalY+OalmR9uSdfaZMo4D7606WYsUZeCkv1qySyQC4jNfePfu/mMelTNL9VJqZrsRKzgMwemDh46Ycn80m8SQfbfSxXkyHg53k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143744; c=relaxed/simple;
	bh=xZ7JyJZFZn3iuOZoe5h922zZ5R4/JN/dDbwKPDTDpVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fHdVv2GfwogBJm675qltNPaHPly+ngxnaPmE2/ewc3vRPXmPAUEDehdcpLtghGcua+kzkYiofMXMqG/GpeK9kocQFDra14GAGxOpQeJTdqo/Jx8fXhz0y9zRa0gTXBrSVJGIBepH9/kc6sxjlg6WC/dbjzSt1+96/3KypMbvfrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=YdBwgMkR; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143724; bh=xZ7JyJZFZn3iuOZoe5h922zZ5R4/JN/dDbwKPDTDpVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YdBwgMkRn/LM0wfzr0gxU35OF0gkF7VztXnDu/XGZ/A8qLfPtecbksfdqM+m0f1XU
	 cjDgnJjq0AQ7PalR/QYf9vqC3HEuQJbj1/WxSM5Eu/g9EuuBXbzKZ6Feb1raJ17QR/
	 gC22mLFV37QeOXSnSrcnpFSwOs0tFLUXA1JbgMHk=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-b734-7f0000032729-7f000001c03e-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:50 +0100
Subject: [PATCH 24/61] net/9p: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-24-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
To: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, 
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org, 
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, 
 Philipp Hahn <phahn-oss@avm.de>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=xZ7JyJZFZn3iuOZoe5h922zZ5R4/JN/dDbwKPDTDpVg=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYnEtzR553dJZWqu5r4IUgVMywPaNyCn2Kl0
 rArZNDCQ6GJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGJwAKCRA0LQZT0ays
 22Q3B/0WDcaxg22CSV3J2yK2YCh66cZH85KFq38ggbwHyd5a8WjqQnka33Kdtc08oHARsU9ozqE
 P4ub42oqVPDyOyAfaW0nuVYHNlcCbmh/bxnwLHvjz7DvZynqqfi+81IpwDPL+nf3OHCqA45W3el
 wXFHM9DZ2DjwYG4MfnrZOmjwML1Qt1LKYUAR5WbU3bIh/t6NofmRATpZci0AEY2ACgSBKNBZ+xC
 yT5B0+MsE+np/c9UPC/BM2BZX3AZEATfPCVPaM5j6SGQ910wEhLc3aOja8ish65RkJANbgaQX9X
 HjK5HDFDjBbvCnKAA71XMeOX3I4/FbTzAL7Ez+9Tosk9xWKL
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-EDDC2A3D-570DD134/0/0
X-purgate-type: clean
X-purgate-size: 2019
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 38E6424EE94
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-997-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[63];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,avm.de:dkim,avm.de:email,avm.de:mid,crudebyte.com:email,ionkov.net:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,codewreck.org:email,linux.dev:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Eric Van Hensbergen <ericvh@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>
To: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: v9fs@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 include/net/9p/client.h | 2 +-
 net/9p/trans_rdma.c     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 838a94218b593f3fb19e6827c472753380193461..4bde6bd716f323c819745e64c7aac0dea7beb72f 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -364,7 +364,7 @@ static inline struct p9_fid *p9_fid_get(struct p9_fid *fid)
 
 static inline int p9_fid_put(struct p9_fid *fid)
 {
-	if (!fid || IS_ERR(fid))
+	if (IS_ERR_OR_NULL(fid))
 		return 0;
 
 	if (tracepoint_enabled(9p_fid_ref))
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index aa5bd74d333f3b5e6fd1e4344d26bc0201ff7f7f..60461344b536bcb6e94112aace75a88b6a99ad86 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -252,16 +252,16 @@ static void rdma_destroy_trans(struct p9_trans_rdma *rdma)
 	if (!rdma)
 		return;
 
-	if (rdma->qp && !IS_ERR(rdma->qp))
+	if (!IS_ERR_OR_NULL(rdma->qp))
 		ib_destroy_qp(rdma->qp);
 
-	if (rdma->pd && !IS_ERR(rdma->pd))
+	if (!IS_ERR_OR_NULL(rdma->pd))
 		ib_dealloc_pd(rdma->pd);
 
-	if (rdma->cq && !IS_ERR(rdma->cq))
+	if (!IS_ERR_OR_NULL(rdma->cq))
 		ib_free_cq(rdma->cq);
 
-	if (rdma->cm_id && !IS_ERR(rdma->cm_id))
+	if (!IS_ERR_OR_NULL(rdma->cm_id))
 		rdma_destroy_id(rdma->cm_id);
 
 	kfree(rdma);

-- 
2.43.0


