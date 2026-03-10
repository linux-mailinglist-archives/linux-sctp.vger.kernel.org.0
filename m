Return-Path: <linux-sctp+bounces-1018-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DhCBaUQsGmNfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1018-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:37:57 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3D924E371
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E84D30FBBB2
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3E13A16BA;
	Tue, 10 Mar 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="vC8qGYtm"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31673480DFA;
	Tue, 10 Mar 2026 11:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143758; cv=none; b=L/sDSVTy7Uw++Lfp1vPvFR4Gq6Hp+lujrOClYGEvm3upgPKYYwwzci8ITdTMxVDX10XWUCmJEr6fOKe2Ks9q9OW5xU4z8+mI12smb5N24m/ILzwcrUw/8yyUVABDv4KyS0ZRVakKauy/Mu3/IHEWkA/pcCKQ35OiobbVRrmHK0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143758; c=relaxed/simple;
	bh=Axff4FnAHPNmyZXZ2vgEuavJkfKhCKJPqZGqnoou9Q8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbCeYXmq2uf4MzSzntQmrtKOzK9TuynPCThdoLBBsbtLXYh1XXsxIT4PIp3l5/UFWZj/osf4FOGEy+bR5yLLUncrDkyx4vsaGSH/x/pc66/j06YBd5u8uN6MJ0rSLFBsG3SG8LISy3fExKq1jeyvmXghmd8j5QUQHmbf71U1vK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=vC8qGYtm; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143726; bh=Axff4FnAHPNmyZXZ2vgEuavJkfKhCKJPqZGqnoou9Q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vC8qGYtmoTTFtKG57rlNoXWnybB42U6r7mF3yDjZNK169i+LPPc6FbsKjJViJXz0P
	 z0SkvHe3S8CzlbyDQgjnVKCfReu3jwjo1Tnr6q9iIPykZjcNCRLdwFjqB3/YTiencA
	 upketXPZTZxW0W7lPSDpgLsiq82FnKI8pFh7qlSE=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ae-2367-7f0000032729-7f000001c97e-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:26 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:26 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:59 +0100
Subject: [PATCH 33/61] mm: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-33-bd63b656022d@avm.de>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3181; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=Axff4FnAHPNmyZXZ2vgEuavJkfKhCKJPqZGqnoou9Q8=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZGGzCaztqu0lpdWvBpBbRCmO+WdPRS9iZCq
 y8ebihz4r+JATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGRgAKCRA0LQZT0ays
 21/8B/wPP7xI3S+6VTDXKISgyNvBqi0UZCbrYypvYfajV0SZbWCEuGKdkXjsEnnFt9YRKxoHeyi
 XmpmbA47CMrp+VNl6him9YVO8BEPZHU4T3m6BB2+Ps31+3rQDfYs7d+nPEStYiJ7CseLk0vc9Xu
 aMyI8bSdyPpcRveFxPuH/uy4iV8zrSXLAoi0Ddm83MyR2aRNl2iCZfPRsvcbR2T8dPBVJjhKzKb
 5v+Zz66IZ/QArfKSmSkUD+nw+Micr3w6XFCa9e1WMrdcQ/Zh9MZx0TWZwcRgOAgfEwQG/fxgX8/
 bLP83oq+8G1pw01czFBtKoe7eUKh6J8z9KOOUPoqLrMipRXq
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143726-05CBBE1F-4CFCA352/0/0
X-purgate-type: clean
X-purgate-size: 3183
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 2F3D924E371
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
	TAGGED_FROM(0.00)[bounces-1018-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[56];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,linux-foundation.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,kvack.org:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle and adapted by hand.

To: Catalin Marinas <catalin.marinas@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 mm/kmemleak.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index d79acf5c51006c3ed42fd88a2246ca148e401999..91136be23a84d825698e98b4f2d0e666429dd593 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1092,7 +1092,7 @@ void __ref kmemleak_alloc(const void *ptr, size_t size, int min_count,
 {
 	pr_debug("%s(0x%px, %zu, %d)\n", __func__, ptr, size, min_count);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && !IS_ERR_OR_NULL(ptr))
 		create_object((unsigned long)ptr, size, min_count, gfp);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc);
@@ -1152,7 +1152,7 @@ void __ref kmemleak_free(const void *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_free_enabled && !IS_ERR_OR_NULL(ptr))
 		delete_object_full((unsigned long)ptr, 0);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free);
@@ -1170,7 +1170,7 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && !IS_ERR_OR_NULL(ptr))
 		delete_object_part((unsigned long)ptr, size, 0);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_part);
@@ -1238,7 +1238,7 @@ void __ref kmemleak_not_leak(const void *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && !IS_ERR_OR_NULL(ptr))
 		make_gray_object((unsigned long)ptr);
 }
 EXPORT_SYMBOL(kmemleak_not_leak);
@@ -1255,7 +1255,7 @@ void __ref kmemleak_transient_leak(const void *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && !IS_ERR_OR_NULL(ptr))
 		reset_checksum((unsigned long)ptr);
 }
 EXPORT_SYMBOL(kmemleak_transient_leak);
@@ -1287,7 +1287,7 @@ void __ref kmemleak_ignore(const void *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && !IS_ERR_OR_NULL(ptr))
 		make_black_object((unsigned long)ptr, 0);
 }
 EXPORT_SYMBOL(kmemleak_ignore);
@@ -1307,7 +1307,7 @@ void __ref kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && size && !IS_ERR(ptr))
+	if (kmemleak_enabled && size && !IS_ERR_OR_NULL(ptr))
 		add_scan_area((unsigned long)ptr, size, gfp);
 }
 EXPORT_SYMBOL(kmemleak_scan_area);
@@ -1325,7 +1325,7 @@ void __ref kmemleak_no_scan(const void *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+	if (kmemleak_enabled && !IS_ERR_OR_NULL(ptr))
 		object_no_scan((unsigned long)ptr);
 }
 EXPORT_SYMBOL(kmemleak_no_scan);

-- 
2.43.0


