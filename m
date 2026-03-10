Return-Path: <linux-sctp+bounces-1040-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPE5DIUWsGknfgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1040-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:03:01 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 599DF24F644
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30D4230F41CA
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E746D3FB7D6;
	Tue, 10 Mar 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="SxQcNNRu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F1C49218D;
	Tue, 10 Mar 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143762; cv=none; b=OLj+5ImvfPnaAxdCfmIY7wKauiVneKYZsyUEFdC29V4RNg4a1kjJ5NjHhsLuydK6kfjszT3BCEd77EHWCKhMFWRlEV31xLQBuLPtwTWTRa9hPw5Fh36K9h5LJmUpO7/syvpJrbveTSSPFhJaA7kawp/A8b1xXS/xwynIIF21Hw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143762; c=relaxed/simple;
	bh=zh0NA9cMXwD2DkPFVL0EOnYz45KEbaJC9E9Miol506A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kheGrOpSjbU56uQgVkBu6eAu/w9qLfSHSBIVmoHJ9pssfUo5005DoWzag2Ks+Co++q7vpsoAnsnQDwDgLADmO6t6PYVLz0AkMDisqZYadkSJYJetyx6cg79w/o3gexJ9WEO5goQngH0axU/gG5vjL4yWXvtjny3gF0oBJUWCgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=SxQcNNRu; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143727; bh=zh0NA9cMXwD2DkPFVL0EOnYz45KEbaJC9E9Miol506A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SxQcNNRuEiFwL/5k7L3uNmiPeI5MF2imk5edf5+bENjDS759Fz4qD+/GE8T78XGoj
	 y3Anx7ULmIKK+LqK0b0jH70rnI3ftcXHXYxeZ0UjeUBfUOOob6Uk/Ag51Y5ZWXmM5b
	 3t6vwVKkMaMk0t3qb5EymyzCnKyZ6WtwRBwC159Q=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-2367-7f0000032729-7f000001c9bc-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:12 +0100
Subject: [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
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
Cc: Alex Williamson <alex@shazbot.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=940; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=zh0NA9cMXwD2DkPFVL0EOnYz45KEbaJC9E9Miol506A=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZyWhsmplRS68Hjc75s841x9LkbYtnoYEUHf
 5sKSdvRLCOJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGcgAKCRA0LQZT0ays
 26J5B/950clmJMa20JiDvd2Y9XUU4IMRZvZhOhN1i+pY6SIYFFSSWrstAJqpIpGOZ3R9V9O+AHS
 +c7Qni9AFhXI7buBYvtSAJWLJA8EJ41+9M8UOXpQoB5DcXO1c0CGt0ajsPjByLrSehp36R5PzH2
 wWu5vJHC6K9Bj9PLCfIhxzyGkz/hL0gcZbuCGZMCsvjzhhK3aqUIEmC2PQzNoj/okoSky7H2ok5
 Weutgt7pTJ9Q0oTr+n0PVtebcJ9O9+q3o9Yrs2sONA2GIXHGzM3vgOrYqV1Xoa6t/eWQHNiKxUs
 zghoWpQpcWwkFeKxopN3kqosmr1/sM4hUF11IDDx0e4ZVVPT
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-BACB9E1F-6BD158D9/0/0
X-purgate-type: clean
X-purgate-size: 942
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 599DF24F644
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1040-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,avm.de:dkim,avm.de:email,avm.de:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/vfio/vfio_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
 
 	/* Handle the VFIO_DEVICE_FEATURE_SET */
 	filp = device->mig_ops->migration_set_state(device, mig.device_state);
-	if (IS_ERR(filp) || !filp)
+	if (IS_ERR_OR_NULL(filp))
 		goto out_copy;
 
 	return vfio_ioct_mig_return_fd(filp, arg, &mig);

-- 
2.43.0


