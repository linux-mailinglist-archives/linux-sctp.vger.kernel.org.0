Return-Path: <linux-sctp+bounces-992-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JpgEpEKsGl4ewIAu9opvQ
	(envelope-from <linux-sctp+bounces-992-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:12:01 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCB424CBDE
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A47433070DCA
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6B148034D;
	Tue, 10 Mar 2026 11:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Bxnf5hCP"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243E1450904;
	Tue, 10 Mar 2026 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143743; cv=none; b=NaeubTccyDRepX75WDXqYdiri4Q5bC8HN3EYStr+RBqk+VQGfD1gfjn1Rhuw4qZFQED8q50Jarxauxi/ALtAjAHEols4ugYfd6Tw54+62jJD2M7EEzsS/T2COpzYYFsY60UsEUJ8ewTp2dEDKeT5QE8JdqiIluI6JFgws0xMbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143743; c=relaxed/simple;
	bh=1PXfnuytcDxCJ5WvjcpjD44YA1sDO5ZH9mYGPwGsGfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6sRYwxcajO+9gvzxYE1PXEaqFtZS/zumhD/+P3KtjeB8U8RYjc1mOhMX+IGt74kmotBIfJjh9yXL2IgxTRQboDtsducxbUJ7gi+efiQTPRerTGRyG6MErEEq/7sj8qfVc4B9GZz5bMYudLXujboAfLAeLlMgfYHQP0OwjmNPcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Bxnf5hCP; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143723; bh=1PXfnuytcDxCJ5WvjcpjD44YA1sDO5ZH9mYGPwGsGfw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bxnf5hCPr+H+CDDsd4jZqf0PlcVKEcYaL0Pz/10I5d/W/p+MffoFmo92xUBRx2cLX
	 A94VjB/2qVZrhl/RJ+4KmwX2udmVOjMvLzTe+ZiIm7Uwma/9ZeGBCSJpgojAnjeLTm
	 jJjx9CuSDNB6VELXF1K8H1AfxJ4tLJbUO0h/GaHQ=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-b734-7f0000032729-7f000001bffa-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:42 +0100
Subject: [PATCH 16/61] sched: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-16-bd63b656022d@avm.de>
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
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1398; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=1PXfnuytcDxCJ5WvjcpjD44YA1sDO5ZH9mYGPwGsGfw=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYMDPZu3smBGrrjEDAZgewRd/vSzrMtCJxCU
 Ab0/aCneJOJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGDAAKCRA0LQZT0ays
 2yYuCACBFSism0sJT51wNOH3mmVipRWFOp8Vg+RkYWteB8QGePJlSbJv9OJm09HMkW7tLjwUyWX
 VVHeC9B16w6ID+8gEcOTClH7t/fK4Dy8WecKHkh0F285AVZWcglgZ3SjIJUNbcIL4vnctyxVDTz
 UXRKVqYZS83Tz67A8a3xEjr7wme1UPPk+FME5Cb8slTwxHRkeibjPT1wP0LHzCbUOIo6nCgv8R7
 jLfvDCodAoO4aPJRzL3vfdPDFaqXegciQKVWThwHK6Iz+gXqJuudCNdAk8Oa0FFSpSor2eNbdWj
 hK6ZRlUo0db2BRvH/nraA1HapgaLEA9P2vfUY2mJwp9Lzm4g
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-73DC6A3D-D048E15E/0/0
X-purgate-type: clean
X-purgate-size: 1400
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 6FCB424CBDE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-992-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[67];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
To: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
To: Ingo Molnar <mingo@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
To: Juri Lelli <juri.lelli@redhat.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>
To: Ben Segall <bsegall@google.com>
To: Mel Gorman <mgorman@suse.de>
To: Valentin Schneider <vschneid@redhat.com>
Cc: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1594987d637b09e586ae788b7f2e6336332d605a..cfa869bd7de5406a5ca094992ab04c62b0e92fd0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3688,7 +3688,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	do {
 		rhashtable_walk_start(&rht_iter);
 
-		while ((dsq = rhashtable_walk_next(&rht_iter)) && !IS_ERR(dsq))
+		while (!IS_ERR_OR_NULL((dsq = rhashtable_walk_next(&rht_iter))))
 			destroy_dsq(sch, dsq->id);
 
 		rhashtable_walk_stop(&rht_iter);

-- 
2.43.0


