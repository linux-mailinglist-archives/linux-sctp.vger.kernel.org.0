Return-Path: <linux-sctp+bounces-1037-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEjRLCUUsGnRfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1037-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:52:53 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED1E24F129
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 727C734ABA00
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75E477983;
	Tue, 10 Mar 2026 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="BoFkjZya"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.94])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B148AE0B;
	Tue, 10 Mar 2026 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143759; cv=none; b=RDbe5EuKvGtyn9Fm+bZmuasuUF0NQxO0iA8tIQqcb+5pmq8jnIBulLBBPYVcPdiF/U85e/F7HC/f9/7SiuZe5EPWTqMhYdy7uurHFZSWk3teWHMJSS2k28GiIs1notqaSt4KsdFevlfaLzcUAz2l2vwZqmB0yJsZtjn3R1gFY2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143759; c=relaxed/simple;
	bh=a1YtuPUr/A4Jokjiqoyr22dEN0gVE+OOIk5/iCzuB9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RFSNlU4iUNW5e9gpbaSFikE5xqMfrSkHmKFQoaE7bUJEZY6ZxcimtzpVvV3UJHw7wIbbKAveuLk2JUeU49mTOA9yBM0NH2hGPHxT2VZrz9ecAsL0n2ogTdpVU9i4cfA54vPgux2Y6e/3yHjC5m/vaSiQwi/eywh2Lvhbl4gmuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=BoFkjZya; arc=none smtp.client-ip=212.42.244.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143728; bh=a1YtuPUr/A4Jokjiqoyr22dEN0gVE+OOIk5/iCzuB9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BoFkjZyaKFG4I+0my0U16P/ZlsfjMrTgDD1a+wOsKM3wW6Hyckunq05e6+k99D3Gi
	 4kV+7om5pC/Efx3ZEKmiJFTqpv4USFiYyuVuVp1V1iQJ18dYlrQIte47hFcyWAgg5r
	 KM84isD0nokr7A5umpY1I9BsMYrFHMDwFBwVekfs=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-e21d-7f0000032729-7f000001baa4-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:13 +0100
Subject: [PATCH 47/61] nfc: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-47-bd63b656022d@avm.de>
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
Cc: Mark Greer <mgreer@animalcreek.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1019; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=a1YtuPUr/A4Jokjiqoyr22dEN0gVE+OOIk5/iCzuB9k=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZ1Y/UGouoeQcc9WQ8MxrI8d8MHBXHMF2nKS
 xW2sTsLmvSJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGdQAKCRA0LQZT0ays
 20jSB/99EGQGPGXfwgc9aoZkEd87WlbZAw/E49hsk8skwCBZpOQIbZBOjpLkfsW3KBFKwpYL6hr
 zj+vjAPS0Kbx/wu/htgTOseyb8dlXJs2DJCBqPrRUWk2pbJhfh9SL0jieoNOSPl5SCoElM11Tk7
 rVQVkuo82qw4WSlg3liLUmo4Aasw+ALrReSJUM+VyOL2Xm/NrCTSIkyRe46UeXgqxXym8K01Jiw
 UcwLAnfIONTcOH9YPD1gA7uZh9C/pYgWe8DkJu23THTdXZuc/7KopxZDLw5gOH2D1JgCmfeTZcx
 ZHAC2ZLeQRVUrAJ1qKHgI4k8WSRe11aWcTzhA96+gLBGdLHb
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-8161EF2F-9C4586C8/0/0
X-purgate-type: clean
X-purgate-size: 1021
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 1ED1E24F129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1037-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,animalcreek.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Mark Greer <mgreer@animalcreek.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/nfc/trf7970a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index d17c701c7888b3be0b46cf95c4b77182313c97c0..f62fc2b80b05bd7a82269334d7f50e6394bfe80f 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -651,7 +651,7 @@ static void trf7970a_send_upstream(struct trf7970a *trf)
 	dev_kfree_skb_any(trf->tx_skb);
 	trf->tx_skb = NULL;
 
-	if (trf->rx_skb && !IS_ERR(trf->rx_skb) && !trf->aborting)
+	if (!IS_ERR_OR_NULL(trf->rx_skb) && !trf->aborting)
 		print_hex_dump_debug("trf7970a rx data: ", DUMP_PREFIX_NONE,
 				     16, 1, trf->rx_skb->data, trf->rx_skb->len,
 				     false);

-- 
2.43.0


