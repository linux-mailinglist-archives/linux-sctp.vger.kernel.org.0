Return-Path: <linux-sctp+bounces-1023-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOQSEkgMsGl4ewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1023-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:19:20 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7524D33D
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5591D30D50D6
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CA83BB9F2;
	Tue, 10 Mar 2026 11:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="TM6eg5Is"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046848C40E;
	Tue, 10 Mar 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143761; cv=none; b=QMxrjAn+Zpi01K6B+kjiBtb48FAEh+xMBo6MmMyI7bk3zDoxSNlvOmQDd3XcHN5jpjFF7MZ+VzL+v7tXnN6GrogqZPepguB4602IemV21COHWqaEWCeBPDSqZxR1USI4QUoo1pBeiF1mUjaMABLeIp7OD6EjZA6l1eo996XfNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143761; c=relaxed/simple;
	bh=qcffqXWHqw29zikXSaMyeqsF5SNAPike03t0qIAEHZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VmPqRR3T8MyqC/eoNoMzCzzSSjlVdxK4TN1KdtNP5m6OSQ4i7FEJZDLqZGkCHxBJFwdHjouSTZRD9KHhkVEmPatlujGfoDYn8aV9MkNvDZZLA3XVMGRpIc4WKsF3YRIq4yN4oCG4q1MMCJEmV50MVS9ah/rbgNFwoaU17Z6gtG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=TM6eg5Is; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143728; bh=qcffqXWHqw29zikXSaMyeqsF5SNAPike03t0qIAEHZQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TM6eg5IsKDZmgxp7GUG67+/57rD9rEUbWduf95eT5FiKywsNOkOROxJd1HgADueu0
	 XiuppY49OLz9JAJVzWK6kmZAydSEKk8Yfb3LCk0edxsTMHOI+GxxxY6TToBD+hBFBa
	 LA63nSKl0Z508Ju4IKsVgpiypr/7gGuby3A+F088=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006b0-e21d-7f0000032729-7f000001bae0-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:28 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:28 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:18 +0100
Subject: [PATCH 52/61] gpib: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-52-bd63b656022d@avm.de>
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
Cc: Dave Penkler <dpenkler@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=qcffqXWHqw29zikXSaMyeqsF5SNAPike03t0qIAEHZQ=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAaHLW+SPsUXBzKjRGA9Sr6z74iUa0aNCqDAC
 Dpk7k/CQsGJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGhwAKCRA0LQZT0ays
 2xngB/9RQuwf5oN7K+t7LSQdZxyrxHOJcTw0116pWThU0XUv9UqQRCLX3DDjBAMUn8ivSrQQu3j
 eCXsK6Di/TiAzICtmQnhlrY1llqErJMK6D3gMknGUqPIUGtryg9JlZS983aqFsnI2NTWJkyhY62
 zoummbxiGOU/XB7LGr2KWmHwNok02P+rt7tXG3k25rPUmB1lXXK0IEKQHC6AYoy/xbYJ43MpYYP
 x2moPKs1et3YrKZ7IUmRwsJyLGDoTojj8VT1rAmn5p4RXjrw+bZItwBB2HSkOSM+PFx6Orfgajc
 95nvtBvD0Mtdm01bQJociZB8XX6BHHZ3h1K5cS12ZujFOnCS
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143728-84E19F2F-525884AA/0/0
X-purgate-type: clean
X-purgate-size: 945
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 30D7524D33D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1023-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Dave Penkler <dpenkler@gmail.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/gpib/common/iblib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpib/common/iblib.c b/drivers/gpib/common/iblib.c
index b672dd6aad25f2f4f36d2a0ed78a0625651ac8ba..18188228a90178ba0bf7c6c923924a99a8ace1bb 100644
--- a/drivers/gpib/common/iblib.c
+++ b/drivers/gpib/common/iblib.c
@@ -249,7 +249,7 @@ int iboffline(struct gpib_board *board)
 	if (!board->interface)
 		return -ENODEV;
 
-	if (board->autospoll_task && !IS_ERR(board->autospoll_task)) {
+	if (!IS_ERR_OR_NULL(board->autospoll_task)) {
 		retval = kthread_stop(board->autospoll_task);
 		if (retval)
 			dev_err(board->gpib_dev, "kthread_stop returned %i\n", retval);

-- 
2.43.0


