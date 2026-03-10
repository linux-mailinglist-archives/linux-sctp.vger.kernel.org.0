Return-Path: <linux-sctp+bounces-1044-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBJ/ISEUsGl1fQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1044-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:52:49 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 727ED24F118
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E427B30B9598
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914E63FEB0F;
	Tue, 10 Mar 2026 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="FuoIkm8y"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F804963C7;
	Tue, 10 Mar 2026 11:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143764; cv=none; b=dey/Mit7bJDXKRELLmdqWbfpWegtTk3wUD/J5VoUfKwT9nE5peRq2oHU+3bbQVC7C0Gwh244Sak9YthkquQLfF2xWUH66+qwgDu5mrL7A/UguuF+6fW4gBvhVMl8YtAuUhju8Szle+V+w3A6p4snel9KSO71/cnTD/MZdrJQFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143764; c=relaxed/simple;
	bh=D3MT7fsInTbF+Q1IcBY1KlhxZOhv8n1GbgMEryPc1iY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uUKyMzWtTR5c+1yEW79uSIKa2jU6wZLyYCkqSECornVFNrxs5voAQXv1s9RUHQj9ted0HVpefWrSnW1Z7b/TfzugypYW1pLPJEaoNdF8yj1NcGQuPKPwbRXpXC3YStZQ1tq7wtfRyXNB3jdx9R69l4im6oe9Sujfg2/A+ulhRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=FuoIkm8y; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143729; bh=D3MT7fsInTbF+Q1IcBY1KlhxZOhv8n1GbgMEryPc1iY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FuoIkm8y1r9jmy9XkB/nIcxLjk6bi+LjK6sb5O5ohjTjMY18sKNe5fNP8s8fr+eSE
	 cVA8MM9YDRtdE2+c+3jQLNZHyd4epnj5ZDnSjfPWRMAs2R10VO12Ss6TLbgdzang/C
	 IuQfXi2yHqFGvraOYFSaQFSWS/mBIxmUmEAiJKQg=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006b0-2367-7f0000032729-7f000001ca2a-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:29 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:28 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:22 +0100
Subject: [PATCH 56/61] clk: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-56-bd63b656022d@avm.de>
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
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=D3MT7fsInTbF+Q1IcBY1KlhxZOhv8n1GbgMEryPc1iY=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAaUcbSjlqDNveOR0T7quZaIRE99Gs4Y40VBm
 M+JmB4D/wiJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGlAAKCRA0LQZT0ays
 29iMCACZFg0QUOFeRuYtY3bNuohm/w3gB25wtydzkEpw1y51B0CHIEYO2D+JTSeLzAXWxzoBnW9
 HXPmPssLJbvCLWKHMMkr0gAWPlZj2r2H5W9oWdTzVn7prfkWfj3QlC8PF6krEUlEdaF6S2eKHnY
 z1zuimMLbUrpcxQrqC7ES4i2d/Rp5LYwIEnS9CU2G4AgF3dSj7KUVqb2Lo1UirL++DC+eGcQfPA
 Ura0HOmvOdmbreSMPuxW3hgubjzqbYDJe+u22CiDbkdU8O1mLNiEw60lO04uucHvbyqPHMrNt0s
 Po0xv5cdM7Uk0fq2L3KaKWcmaytoRStiJNfwvalXm+okYQVa
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143729-974B6E1F-DBF721A0/0/0
X-purgate-type: clean
X-purgate-size: 1923
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 727ED24F118
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1044-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,baylibre.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Semantich change: Previously the code only printed the warning on error,
but not when the pointer was NULL. Now the warning is printed in both
cases!

Change found with coccinelle.

To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/clk/clk.c               | 4 ++--
 drivers/clocksource/timer-pxa.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 47093cda9df32223c1120c3710261296027c4cd3..35146e3869a7dd93741d10b7223d4488a9216ed1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4558,7 +4558,7 @@ void clk_unregister(struct clk *clk)
 	unsigned long flags;
 	const struct clk_ops *ops;
 
-	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
 		return;
 
 	clk_debug_unregister(clk->core);
@@ -4744,7 +4744,7 @@ void __clk_put(struct clk *clk)
 {
 	struct module *owner;
 
-	if (!clk || WARN_ON_ONCE(IS_ERR(clk)))
+	if (WARN_ON_ONCE(IS_ERR_OR_NULL(clk)))
 		return;
 
 	clk_prepare_lock();
diff --git a/drivers/clocksource/timer-pxa.c b/drivers/clocksource/timer-pxa.c
index 7ad0e5adb2ffac4125c34710fc67f4b45f30331d..f65fb0b7fc318b766227e5e7a4c0fb08ba11c8f9 100644
--- a/drivers/clocksource/timer-pxa.c
+++ b/drivers/clocksource/timer-pxa.c
@@ -218,7 +218,7 @@ void __init pxa_timer_nodt_init(int irq, void __iomem *base)
 
 	timer_base = base;
 	clk = clk_get(NULL, "OSTIMER0");
-	if (clk && !IS_ERR(clk)) {
+	if (!IS_ERR_OR_NULL(clk)) {
 		clk_prepare_enable(clk);
 		pxa_timer_common_init(irq, clk_get_rate(clk));
 	} else {

-- 
2.43.0


