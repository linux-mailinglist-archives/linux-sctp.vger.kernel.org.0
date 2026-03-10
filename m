Return-Path: <linux-sctp+bounces-1006-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFsYCIYMsGl4ewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1006-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:20:22 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEBA24D483
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30D3932634BE
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D14F7988;
	Tue, 10 Mar 2026 11:56:06 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F046AEC2;
	Tue, 10 Mar 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143747; cv=none; b=uvf7c+8ZTaGEslqVXsuPaytsaBjNuDUtddyzjsegLuaLsJZGfWFmi+c/IVjyJkHZYjfYBnA47SQ/mOLgqGkORB/tcPB0okJnbufNBHrkksTrWeBQQ01jiJB3ttND/pXCgQueZLK4HR25XxuN1f7pc37doo3y8NJce8yyV5LBAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143747; c=relaxed/simple;
	bh=w6c4PA3VGZ44yyLt8mghr+WTJ9TxkFa/GQpFHp0jaRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=heHUHAMWnTgWR/+hP3/qGij7yTTg58MUJoEMNGyRPSAOsRWql+RnI/LWRXUW56oqEeYfFwf8a5aaL27+ikLUkRJPC9GurEAz01ARC72wdtBZ69EYk+QNGcy7Te0b1yq7ciZUs/leOTTp56Y2aF6YILL9nkYi0SNXQTVGJNi8H7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ad-e21d-7f0000032729-7f000001da0c-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:56 +0100
Subject: [PATCH 30/61] net/sunrpc: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-30-bd63b656022d@avm.de>
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
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=w6c4PA3VGZ44yyLt8mghr+WTJ9TxkFa/GQpFHp0jaRg=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAY7O6x5f/jrEOlM2kM2YjYC7Xq22wW3Mikry
 9AY9ISieLCJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGOwAKCRA0LQZT0ays
 24W7CACaVIegavbFPh1+6gPSjqv5T1Ou5hQU0OcaZ20nx5fdOimad+jK3UuGfZrC9Vgv0QMm0ym
 3OSuSluEWbuIv6zcFp3UbdEj9aI7TM7en4Ha7pCkmDfNfPts09fhhi9VrPo390VGOMeNWeVMtD/
 CQde1U2q7DKI3QtGXyjY9I//uCPpAfeRw/e0X1QSKZ9eOdV+c4uWgQhNCPrPJZrHvycJx2lFn3Q
 ZNRGEplISNXY/bb/iuclRgqFYvGWnoUgBYQkpTrGJqDvFREwT8LcHN3+0nwKoz0xIqQbO7gBWgt
 +Dgbc3vk23keeP8aHFv6AZ7K16GCQyMm+zwDBr92eUq+pHvN
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-94E79F2F-D29BF16C/0/0
X-purgate-type: clean
X-purgate-size: 2553
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 8BEBA24D483
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[avm.de : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1006-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[67];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,davemloft.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>
To: Olga Kornievskaia <okorniev@redhat.com>
To: Dai Ngo <Dai.Ngo@oracle.com>
To: Tom Talpey <tom@talpey.com>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9b623849723ed0eb74b827881c6f32d3434c891b..b4d03e59a8202f20360cff1e2e79b1e325396517 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -578,7 +578,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
  errout:
 	/* Take a reference in case the DTO handler runs */
 	svc_xprt_get(&newxprt->sc_xprt);
-	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
+	if (!IS_ERR_OR_NULL(newxprt->sc_qp))
 		ib_destroy_qp(newxprt->sc_qp);
 	rdma_destroy_id(newxprt->sc_cm_id);
 	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
@@ -608,7 +608,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	might_sleep();
 
 	/* This blocks until the Completion Queues are empty */
-	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
+	if (!IS_ERR_OR_NULL(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
 	flush_workqueue(svcrdma_wq);
 
@@ -619,16 +619,16 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	svc_rdma_recv_ctxts_destroy(rdma);
 
 	/* Destroy the QP if present (not a listener) */
-	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
+	if (!IS_ERR_OR_NULL(rdma->sc_qp))
 		ib_destroy_qp(rdma->sc_qp);
 
-	if (rdma->sc_sq_cq && !IS_ERR(rdma->sc_sq_cq))
+	if (!IS_ERR_OR_NULL(rdma->sc_sq_cq))
 		ib_free_cq(rdma->sc_sq_cq);
 
-	if (rdma->sc_rq_cq && !IS_ERR(rdma->sc_rq_cq))
+	if (!IS_ERR_OR_NULL(rdma->sc_rq_cq))
 		ib_free_cq(rdma->sc_rq_cq);
 
-	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
+	if (!IS_ERR_OR_NULL(rdma->sc_pd))
 		ib_dealloc_pd(rdma->sc_pd);
 
 	/* Destroy the CM ID */

-- 
2.43.0


