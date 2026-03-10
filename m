Return-Path: <linux-sctp+bounces-1020-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHwXJEEPsGkpfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1020-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:32:01 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0624DEA0
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B362A322AD82
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DEF3B47F3;
	Tue, 10 Mar 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="M5sopbNY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB93481A9C;
	Tue, 10 Mar 2026 11:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143759; cv=none; b=XYGi4/q8B56AB4RaSXahiHp9KjTJgIb0ZyyypZMKYWKm5upAA6z3yE/RkBORYQK1iEi4TcNQ1avqF/Yuyb+BIzPoGGD2HFGjSkOM6MrgqH9XiPPY5Z0ZkY35mTsCWGh/Yh7wQED48g9OJo1olNn/DC7NJuVwDEOS3HSQI+MlvbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143759; c=relaxed/simple;
	bh=5jNhYM960jMlYUrL3T2we+u9wPA7QX8xb/YhMa8cGzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h7xQAP5bfZQARJpHVVMFGFU4tfwVERq8wUTFFOF8nBhTK41dv+CaQ36DuUci7kPm3+l3yMPCjn6eoCKZPJPl32orLtEjfc6blpjs4pTgvtC2hm3RP9b69UOz+7mOoj9xPrXnUP7THGJubNTTepOHrUjQL5iJdCcR7d+IunhF40c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=M5sopbNY; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143727; bh=5jNhYM960jMlYUrL3T2we+u9wPA7QX8xb/YhMa8cGzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M5sopbNY66qmWa+2q+MLa+uKDQnYhARDVpHPBaPhnBAWxbQH6mILrzFzXoehD/OnN
	 XfkL39v7DGJAyVHbunl2dtyoz4/s+HQp68/tCQVMA+YzssNFiXbaAEz8Yvn1XdtigU
	 NmV3lEhKYunB5kPsVmat/OQepTdLQIWCI8jH5Ufw=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-e21d-7f0000032729-7f000001ba7e-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:10 +0100
Subject: [PATCH 44/61] target: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-44-bd63b656022d@avm.de>
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
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=5jNhYM960jMlYUrL3T2we+u9wPA7QX8xb/YhMa8cGzI=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZrwlPF0cTtka85RKXa/jq01klA6219EkbVF
 sAxzvkaF5OJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGawAKCRA0LQZT0ays
 26c3B/97YbFOVY+7aU+X20/OGHSJFO2zRY48bbypRSoZTJJvUVhT9k9LgthUke6q7t50KfcaKxO
 +ji7TT6hO8Cm4OsGah0c5lQCV8UQAJc4iRbI/bt93UQwIqQrpJeR9mDiRtZ63zuk53hAKMaouvF
 y6MARoN+FEiA3sHGmWk/DuFGtzf6I3rn5UIuUm1ckeIx7XgHZwxEQLChAjM+0RUA9PFCwYu/qm6
 9IpeMJ2V/nIZwaOJH7XMvW452VksCcG4pysYBM4gaKPDiw/aj9RS8erUS771tOWY6ZGy4Wx4+7y
 JX63QRv+rPmmYyTOxZi58eVjXbcoNvE3qP8qFHWJHKPRXuOf
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-8B66AF2F-B220D537/0/0
X-purgate-type: clean
X-purgate-size: 1613
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 13A0624DEA0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1020-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,oracle.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: target-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/target/target_core_fabric_configfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index 331689b30f8540c8e78de3eae32c1f8cd4906213..20d57d766ada6ba24cbd2d44d0107cdff9483a68 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -479,7 +479,7 @@ static struct config_group *target_fabric_make_np(
 	}
 
 	se_tpg_np = tf->tf_ops->fabric_make_np(se_tpg, group, name);
-	if (!se_tpg_np || IS_ERR(se_tpg_np))
+	if (IS_ERR_OR_NULL(se_tpg_np))
 		return ERR_PTR(-EINVAL);
 
 	se_tpg_np->tpg_np_parent = se_tpg;
@@ -937,7 +937,7 @@ static struct config_group *target_fabric_make_tpg(
 	}
 
 	se_tpg = tf->tf_ops->fabric_make_tpg(wwn, name);
-	if (!se_tpg || IS_ERR(se_tpg))
+	if (IS_ERR_OR_NULL(se_tpg))
 		return ERR_PTR(-EINVAL);
 
 	config_group_init_type_name(&se_tpg->tpg_group, name,
@@ -1112,7 +1112,7 @@ static struct config_group *target_fabric_make_wwn(
 	}
 
 	wwn = tf->tf_ops->fabric_make_wwn(tf, group, name);
-	if (!wwn || IS_ERR(wwn))
+	if (IS_ERR_OR_NULL(wwn))
 		return ERR_PTR(-EINVAL);
 
 	wwn->cmd_compl_affinity = SE_COMPL_AFFINITY_CPUID;

-- 
2.43.0


