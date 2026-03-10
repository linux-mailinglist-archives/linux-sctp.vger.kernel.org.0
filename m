Return-Path: <linux-sctp+bounces-1026-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CiKI/EMsGl4ewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1026-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:22:09 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D2624D67E
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 955E631A058B
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249BE3C7E1F;
	Tue, 10 Mar 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="Pw5J/ZKa"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED27C495511;
	Tue, 10 Mar 2026 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143765; cv=none; b=OOwNQwMb3AhpRbTg950A1Zj3QQ+Rbz/rchgAyX9ghdIetGphOtNgpFePi9eLgDL5f5gI6KO5f0+fOnj9cPmWaIHyv9MnSjLkgykJZ6esintQKW2+QX2o7RyGqc3VTYqb9QTYRwRJ0FyuS1psMEnnWycg5SvvDR13tLB3yPQy838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143765; c=relaxed/simple;
	bh=P8RHvB1pDU6Ba6KZR0cIN2NAbDWAknWQIRz8JMX8gns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ff1VZlQ6OTfWDGkqcvU36LILgf03tdsFZvltywUhEjFbpgVZfcg6gJafOG/qvjO8cvrFAqglS0moHbC2fLuss4uksh/kNffBSQaY9eOyTh0dm3Np7J7wM4hi537QO4l+yRpAokflIpB/lEo8FeFkdpS+ZmKmsk+ODzbUaAUomVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=Pw5J/ZKa; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143728; bh=P8RHvB1pDU6Ba6KZR0cIN2NAbDWAknWQIRz8JMX8gns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pw5J/ZKa7qdOD/KHliFHGAPgoeYPtxmoMsaCQF/FKai+LG5vkmyJowXsEzkD3cPot
	 34kvrGSUxg1JnjFKHY6NsLgrOVug3M9Be4rVveawRMrk6MR1C1BR6jP8hIlA4X3hU4
	 jr1s0kl9i2R1ifgZ0ZoS8j1AZYiWtKMhO7fCyfSs=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-e21d-7f0000032729-7f000001bab8-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:28 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:14 +0100
Subject: [PATCH 48/61] mtd: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-48-bd63b656022d@avm.de>
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
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1817; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=P8RHvB1pDU6Ba6KZR0cIN2NAbDWAknWQIRz8JMX8gns=;
 b=kA0DAAoBNC0GU9GsrNsByyZiAGmwBnnIluZqwXeZ26oYYynjfBoy02QQTmlYcSsBV5M99kkBR
 okBMwQAAQoAHRYhBDls8G2tYNRwNAKmmDQtBlPRrKzbBQJpsAZ5AAoJEDQtBlPRrKzbhhQIALOH
 7GGUb7lDbOgP/8xq1PNX4SyEuog4C5Kqug0EL27yDZ5DTcHtYtEWvTOVFh3DoBIg9oWZIhltbqf
 zQqvypi0p020OQBz5OD/FKYzR1JLtT/NpVkDjTnrh0FIsLPISsJn9k8DorrTpQE5Fk5zPEGhmlk
 HlvpEuSvvQD0MQibzxJjUYSjgq+Ll386Twc/QQfm3hFYZT/c4I4Yb80f4z0CM2WhT7S3udW5nGM
 BjGFdYImnQ9uAgWz45BEBVAwZb3P7349MoFLUJ9ZHvqc+4UOIWn+5d35lrOEZcvkJpfol2G0RFZ
 WFsYepS2AbdMtsza99K9TLlncKCIQLIaXnPIWJM=
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143728-90660F2F-3D7E05AD/0/0
X-purgate-type: clean
X-purgate-size: 1819
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: D4D2624D67E
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
	TAGGED_FROM(0.00)[bounces-1026-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[57];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,bootlin.com:email,nod.at:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Weinberger <richard@nod.at>
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/mtd/nand/raw/gpio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpio.c b/drivers/mtd/nand/raw/gpio.c
index 69e5e43532a448aa6273f3df79f53145784ccc05..86a8b62fb9e8510d36f925b8b468ec17c77e26d8 100644
--- a/drivers/mtd/nand/raw/gpio.c
+++ b/drivers/mtd/nand/raw/gpio.c
@@ -276,9 +276,9 @@ static void gpio_nand_remove(struct platform_device *pdev)
 	nand_cleanup(chip);
 
 	/* Enable write protection and disable the chip */
-	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
+	if (!IS_ERR_OR_NULL(gpiomtd->nwp))
 		gpiod_set_value(gpiomtd->nwp, 0);
-	if (gpiomtd->nce && !IS_ERR(gpiomtd->nce))
+	if (!IS_ERR_OR_NULL(gpiomtd->nce))
 		gpiod_set_value(gpiomtd->nce, 0);
 }
 
@@ -358,7 +358,7 @@ static int gpio_nand_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, gpiomtd);
 
 	/* Disable write protection, if wired up */
-	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
+	if (!IS_ERR_OR_NULL(gpiomtd->nwp))
 		gpiod_direction_output(gpiomtd->nwp, 1);
 
 	/*
@@ -381,10 +381,10 @@ static int gpio_nand_probe(struct platform_device *pdev)
 		return 0;
 
 err_wp:
-	if (gpiomtd->nwp && !IS_ERR(gpiomtd->nwp))
+	if (!IS_ERR_OR_NULL(gpiomtd->nwp))
 		gpiod_set_value(gpiomtd->nwp, 0);
 out_ce:
-	if (gpiomtd->nce && !IS_ERR(gpiomtd->nce))
+	if (!IS_ERR_OR_NULL(gpiomtd->nce))
 		gpiod_set_value(gpiomtd->nce, 0);
 
 	return ret;

-- 
2.43.0


