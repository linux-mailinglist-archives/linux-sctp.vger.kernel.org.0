Return-Path: <linux-sctp+bounces-1000-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBocBpUPsGkpfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1000-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:33:25 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3F224E012
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48D5D314A901
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87B54B8DE2;
	Tue, 10 Mar 2026 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="bIWX9HTo"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C483421F15;
	Tue, 10 Mar 2026 11:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143739; cv=none; b=Sza9niqVn4HVD//A4/PvejWjQYCNYJkTK4bkSsGnehfu9mA6VplMQq8OwkvkETq+LJ7PzJm1Y2/we3ENb6sLwi/H+ljcoMr23o7J0Ygcs6QL5qUBtQ0CyusQS5Qq1PK62ysk6rLj1odQZKSM+MXtcbml7KCP1hN/q5U5zXoswL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143739; c=relaxed/simple;
	bh=pg0bcAlKCqGzZYxxvjTHT3BjuiImw/JCztrCxw0OaYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tRPIPguhL/iCSUJczUcg/gDAF4CAAnOpGq7S4U8Hm8rG/Tox9JkOUUnseYTD2L9TgaE8u5TsgM8OAQ5EX/yUVH3Ehxln13Pq5waMJ2AHdvelz/0CsSswXVbIgsPtI+oRmGHF5vRVEhlgRbt9GZ+S/CFhbrNhdlsjyuYW5mSZkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=bIWX9HTo; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143723; bh=pg0bcAlKCqGzZYxxvjTHT3BjuiImw/JCztrCxw0OaYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bIWX9HTo18B4ZE3sIquR8sbft3qzxzntZILxo7B74pgnu0rbeOHxAC7dlzZUeUKhf
	 HyziuuxI8v1FJdI0XETgMVlTILYL71/sVzADfcPBmDn0JPtGKUshimXXHFg01f3FBK
	 jYVNQFVbnSBvARzQ5cTWzBurkew0k16ZhIWvNTOE=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006aa-2367-7f0000032729-7f0000019cb8-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:22 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:27 +0100
Subject: [PATCH 01/61] Coccinelle: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
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
Cc: Julia Lawall <Julia.Lawall@inria.fr>, 
 Nicolas Palix <nicolas.palix@imag.fr>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3942; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=pg0bcAlKCqGzZYxxvjTHT3BjuiImw/JCztrCxw0OaYk=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXSiE/1KQSdimAccvhjPksfwMRe29ZGV0WmQ
 dc68UTm4wOJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF0gAKCRA0LQZT0ays
 23P4B/sHBnCDcdVo4QHtyw/PgaWkSZpnGi/FADclDF/JNscwRsXCrFWzhKgn3xZ7GBKm9yEUANd
 kHYMMKsDVZ5Sq7xOrshFMfBSWpA+0BsCM8pKaxoj2QHBKIDA4UgN93hm4YvutplfF9/q6gdQOqR
 x0WpQkBc7InCLdKCwpXNhcL/HWVvBtzqT2nSOrbK1Rd5xcaVOko56aV82Fnst/bFUZLKttOBTCU
 bLU0LprdbSKp+PN7eyMO37tBs3H4QuuQgnRmZxd8L6mNXEFIpj0UqSFvKNrDWZBtTjurbiwItHZ
 +OYdOt4ryN9C08iNZEaNQULUxcRTzE4KumgPWWtIEShH9ICc
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-D8CB5E1F-6C1339D5/0/0
X-purgate-type: clean
X-purgate-size: 3944
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 7B3F224E012
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
	TAGGED_FROM(0.00)[bounces-1000-lists,linux-sctp=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imag.fr:email,avm.de:dkim,avm.de:email,avm.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,p:email,inria.fr:email]
X-Rspamd-Action: no action

Find and convert uses of IS_ERR() plus NULL check to IS_ERR_OR_NULL().

There are several cases where `!ptr && WARN_ON[_ONCE](IS_ERR(ptr))` is
used:
- arch/x86/kernel/callthunks.c:215 WARN_ON_ONCE
- drivers/clk/clk.c:4561 WARN_ON_ONCE
- drivers/interconnect/core.c:793 WARN_ON
- drivers/reset/core.c:718 WARN_ON
The change is not 100% semantical equivalent as the warning will now
also happen when the pointer is NULL.

To: Julia Lawall <Julia.Lawall@inria.fr>
To: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr
Cc: linux-kernel@vger.kernel.org

---
drivers/clocksource/mips-gic-timer.c:283 looks suspicious: ret != clk,
but Daniel Lezcano verified it as cottect.

There are some cases where the checks are part of a larger expression:
- mm/kmemleak.c:1095
- mm/kmemleak.c:1155
- mm/kmemleak.c:1173
- mm/kmemleak.c:1290
- mm/kmemleak.c:1328
- mm/kmemleak.c:1241
- mm/kmemleak.c:1310
- mm/kmemleak.c:1258
- net/netlink/af_netlink.c:2670
Thanks to Julia Lawall for the help to also handle them.

Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 scripts/coccinelle/api/is_err_or_null.cocci | 125 ++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/scripts/coccinelle/api/is_err_or_null.cocci b/scripts/coccinelle/api/is_err_or_null.cocci
new file mode 100644
index 0000000000000000000000000000000000000000..7a430eadccd9f9f28b1711d67dd87a817a45bd52
--- /dev/null
+++ b/scripts/coccinelle/api/is_err_or_null.cocci
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Use IF_ERR_OR_NULL() instead of IS_ERR() plus a check for (not) NULL
+///
+// Copyright: (C) 2026 Philipp Hahn, FRITZ! Technology GmbH.
+// Confidence: High
+// Options: --no-includes --include-headers
+// Keywords: IS_ERR, IS_ERR_OR_NULL
+
+virtual patch
+virtual report
+virtual org
+
+@p1 depends on patch@
+expression E;
+@@
+(
+-	E != NULL && !IS_ERR(E)
++	!IS_ERR_OR_NULL(E)
+|
+-	E == NULL || IS_ERR(E)
++	IS_ERR_OR_NULL(E)
+|
+-	!IS_ERR(E) && E != NULL
++	!IS_ERR_OR_NULL(E)
+|
+-	IS_ERR(E) || E == NULL
++	IS_ERR_OR_NULL(E)
+)
+
+@p2 depends on patch@
+expression E;
+@@
+(
+-	E == NULL || WARN_ON(IS_ERR(E))
++	WARN_ON(IS_ERR_OR_NULL(E))
+|
+-	E == NULL || WARN_ON_ONCE(IS_ERR(E))
++	WARN_ON_ONCE(IS_ERR_OR_NULL(E))
+)
+
+@p3 depends on patch@
+expression E,e1;
+@@
+(
+-	e1 && E != NULL && !IS_ERR(E)
++	e1 && !IS_ERR_OR_NULL(E)
+|
+-	e1 || E == NULL || IS_ERR(E)
++	e1 || IS_ERR_OR_NULL(E)
+|
+-	e1 && !IS_ERR(E) && E != NULL
++	e1 && !IS_ERR_OR_NULL(E)
+|
+-	e1 || IS_ERR(E) || E == NULL
++	e1 || IS_ERR_OR_NULL(E)
+)
+
+@r1 depends on report || org@
+expression E;
+position p;
+@@
+(
+ 	E != NULL && ... && !IS_ERR@p(E)
+|
+ 	E == NULL || ... || IS_ERR@p(E)
+|
+ 	!IS_ERR@p(E) && ... && E != NULL
+|
+ 	IS_ERR@p(E) || ... || E == NULL
+)
+
+@script:python depends on report@
+p << r1.p;
+@@
+coccilib.report.print_report(p[0], "opportunity for IS_ERR_OR_NULL()")
+
+@script:python depends on org@
+p << r1.p;
+@@
+coccilib.org.print_todo(p[0], "opportunity for IS_ERR_OR_NULL()")
+
+@p4 depends on patch@
+identifier I;
+expression E;
+@@
+(
+-	(I = E) != NULL && !IS_ERR(I)
++	!IS_ERR_OR_NULL((I = E))
+|
+-	(I = E) == NULL || IS_ERR(I)
++	IS_ERR_OR_NULL((I = E))
+)
+
+@r2 depends on report || org@
+identifier I;
+expression E;
+position p;
+@@
+(
+*	(I = E) != NULL && ... && !IS_ERR@p(I)
+|
+*	(I = E) == NULL || ... || IS_ERR@p(I)
+)
+
+@script:python depends on report@
+p << r2.p;
+@@
+coccilib.report.print_report(p[0], "opportunity for IS_ERR_OR_NULL()")
+
+@script:python depends on org@
+p << r2.p;
+@@
+coccilib.org.print_todo(p[0], "opportunity for IS_ERR_OR_NULL()")
+
+@p5 depends on patch disable unlikely @
+expression E;
+@@
+-\( likely \| unlikely \)(
+(
+ IS_ERR_OR_NULL(E)
+|
+ !IS_ERR_OR_NULL(E)
+)
+-)

-- 
2.43.0


