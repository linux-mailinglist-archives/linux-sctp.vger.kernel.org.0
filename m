Return-Path: <linux-sctp+bounces-1032-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4NiuAYsUsGnRfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1032-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:54:35 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E81224F24E
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EA2531F5FFF
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831843DCD90;
	Tue, 10 Mar 2026 11:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="YXGm2fdd"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A74C041D;
	Tue, 10 Mar 2026 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143766; cv=none; b=eNYgd1oWW7By0IZ69pfu5JB3MgYckysWTTL8yKiRzq4Y/11hNOmuN8HdnVEEtzeNLZWic7rRUZLrd1QX4z4T992MlO89GmJ2PqmEbQ7z2DQwRhNhXL/edznFZcin+HZWqQP67OIAWqCF8iiK9JZbtxf0PQCdxCP3YRODWyfCRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143766; c=relaxed/simple;
	bh=r2ZNUyu6wG+N08MfsdquggU1Q5xHuPu+4B/VYVv0t9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmahpJWAUWYLPWIrUetH/k6Cs5+UJW8qAGgvUDkSY47ZHTUxfpygVGAjbJHOMtDM6AXDknm21vYgu0S7/bX3ossrgEZoUck+Qk/WZc/I7DDr/qxU1nvN0creh8W++MmIAIf8l5AaVisarBsMdWhtgzmDLElZWmdbtH7KvjCtIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=YXGm2fdd; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143727; bh=r2ZNUyu6wG+N08MfsdquggU1Q5xHuPu+4B/VYVv0t9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YXGm2fddB0bD05XRQUo0zroBzSiXv55w6mXtnC3/rbyTRBzDlz9PWwan2loANEchz
	 3nUHhdwioF2zPrdtj5GGDiz2/RlpAekCz2aZgV1toF9qbrEYEb5oV3jU7h9yUVsShF
	 X4koU5bE7tqGGpl7IdLmkPqUNFFBIWSBlmjRRwMc=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-b734-7f0000032729-7f0000019c66-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:20 +0100
Subject: [PATCH 54/61] aoe: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-54-bd63b656022d@avm.de>
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
Cc: Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>
X-Developer-Signature: v=1; a=openpgp-sha256; l=955; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=r2ZNUyu6wG+N08MfsdquggU1Q5xHuPu+4B/VYVv0t9Q=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAaNWcUAch/xMnI0wAbOgPf41K9NsP36Msk7P
 Nki6xRL5YKJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGjQAKCRA0LQZT0ays
 2xbWCACfzS98X1Mp5R5EwpIK0pTgqrssQIB840NNUj3GRa/d9D29Lch2JFjR2Yy+ldzvSmEDJYr
 +FATwB8i4z+nArVkmYPgbG8vodjj8pep1H5lik7YhU3G9ClazVWr99T039Q+W8sEprULXLQ0dbA
 4Kpe3/L1QfxY1N+GchfqAHMv0rRJq1RvirATmISGmxTg7n0SEymJW83Bn4X8R0ZnvK6kohy5NEW
 2Ii5RKfTmBA8YgN2bfh5HrwrKAUrDiQU4qD40KTADcaRVC7Oxd160l9rFHE0+fB+GiDoct83TcC
 /85+2RTmaR+Iva1VQ69ftJxFcgDmZC/vMk3mknKyTuNPcNM+
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-DADD8A3D-0ED39ACF/0/0
X-purgate-type: clean
X-purgate-size: 957
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 6E81224F24E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1032-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[56];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,kernel.dk:email,avm.de:dkim,avm.de:email,avm.de:mid,coraid.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Justin Sanders <justin@coraid.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/block/aoe/aoecmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index a4744a30a8af4ff05113f3234021eec728265b4f..b31e539a66433a0a5d6e81117a32d12735ffc1bc 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1268,7 +1268,7 @@ aoe_ktstart(struct ktstate *k)
 
 	init_completion(&k->rendez);
 	task = kthread_run(kthread, k, "%s", k->name);
-	if (task == NULL || IS_ERR(task))
+	if (IS_ERR_OR_NULL(task))
 		return -ENOMEM;
 	k->task = task;
 	wait_for_completion(&k->rendez); /* allow kthread to start */

-- 
2.43.0


