Return-Path: <linux-sctp+bounces-1027-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFf2EXgSsGnRfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1027-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:45:44 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B18D24EB88
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D7B3315374B
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A73CEB85;
	Tue, 10 Mar 2026 11:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="arIjqC+e"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A74A2E2E;
	Tue, 10 Mar 2026 11:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143765; cv=none; b=GWxkI2dRg/Z5k+3n8S/ZoiZHeyhkQbbGtnfUFOdcCLJlZ+xHXg5Y5lkMpTOl4X25UR/cPWKI+WRc0S+sC1o0AbHnzGHkS9l/8nigKg3VXEzVXz6wtojDSLdqUVrOaLPIhe9fFpAwHGOanOU/jNCQXAAmhIg4KycHGJZOy3NEoKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143765; c=relaxed/simple;
	bh=Zdu+cVQUurUlnC57nYv7WmkJa7Su1n9ZL+7ubRQiCbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETGOgQO62S29Y5rBKCuC50OEKJV223TzORmtHmIdngsCo3qYS6+ji1+z2CWyUvYCvv5AAyv+VFgxxzRvminWt2AQCK9B4XBS7HQF/cWR8tkS+/gSdpm5X9UUSu/Z2LpBPy3z2N7xcPgxqRc0g4oOpVGf+KWO7TYSAKxMckR+tI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=arIjqC+e; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143729; bh=Zdu+cVQUurUlnC57nYv7WmkJa7Su1n9ZL+7ubRQiCbU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=arIjqC+eOW50ePPRI7IzTKWN2gbhB0tQ9WRbPXDZdH2y8Tl8MVJAS9gxKOCgGSNO1
	 MKRth9R9YTwOofMsTkyRe5Kz4PcjK/cLboke0inMKDssNbfSjXTkXB1/ZhuTMFSoly
	 YzXp7hvqApt2TDtbnjQwMPLewEHxBbUoVg9XuPpY=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006b1-2367-7f0000032729-7f000001ca3e-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:29 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:29 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:24 +0100
Subject: [PATCH 58/61] arch/x86: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-58-bd63b656022d@avm.de>
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
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1972; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=Zdu+cVQUurUlnC57nYv7WmkJa7Su1n9ZL+7ubRQiCbU=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAabkCM/59lsV79Q3PWR22p56JLuGabUpuR4i
 qxQub+ly/qJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGmwAKCRA0LQZT0ays
 2xXOB/9ZPHi30qdJIkWySghqlR16lgaAoi3kyqOX8y681/67uYGL/oYTixO52tnBrjVPqGtMJMl
 /Q1KhfevGkVNYzFAfMrFBpAZag+UIgbv/BCAd+mAYMHmfUSOVrYD15iCyuV/mzNjhjHEufwESj4
 I0XaRrF8IjuTyxoOaAktjvNz5kPAQuNzEBmaZ3v2GCRGsUPgyn1rW2fNRbOhVzN0Q0ZlAeRhTj/
 Qq0svuNBXvGJBVWHLKzaFNv3dtadS6o0vkr1vZsO43v1j0qtJ5bmVxhOhChUZ8M0SvSfZzOtGDb
 woeHnmnHVjGmRuu20BTVhdN6fCN/9hgCBGPx0vI7/S13IInk
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143729-8448CE1F-1FDA919B/0/0
X-purgate-type: clean
X-purgate-size: 1974
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 4B18D24EB88
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
	TAGGED_FROM(0.00)[bounces-1027-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[60];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zytor.com:email,avm.de:dkim,avm.de:email,avm.de:mid,intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,alien8.de:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of likely().

Semantich change: Previously the code only printed the warning on error,
but not when the pointer was NULL. Now the warning is printed in both
cases!

Change found with coccinelle.

To: Thomas Gleixner <tglx@kernel.org>
To: Ingo Molnar <mingo@redhat.com>
To: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@linux.intel.com>
To: x86@kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 arch/x86/kernel/callthunks.c | 2 +-
 arch/x86/kernel/irq.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index e37728f7032277a99ffb0e6bb7dfa318660e56a0..6dc45838d8e439e117815b85e2840bb3a6688ed8 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -212,7 +212,7 @@ static __init_or_module void patch_call(void *addr, const struct core_text *ct)
 		return;
 
 	dest = call_get_dest(addr);
-	if (!dest || WARN_ON_ONCE(IS_ERR(dest)))
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(dest)))
 		return;
 
 	if (!is_coretext(ct, dest))
diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index ec77be217eaf5f558fa73c2ff6cf1ab8953ee2f8..81963909066d72607f58d3e443a21a3b3e701a99 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -282,7 +282,7 @@ static __always_inline bool call_irq_handler(int vector, struct pt_regs *regs)
 {
 	struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
 
-	if (likely(!IS_ERR_OR_NULL(desc))) {
+	if (!IS_ERR_OR_NULL(desc)) {
 		handle_irq(desc, regs);
 		return true;
 	}

-- 
2.43.0


