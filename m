Return-Path: <linux-sctp+bounces-1029-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOYzKN4QsGlxfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1029-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:38:54 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA224E3F3
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00D3F31FEC38
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24B53D1712;
	Tue, 10 Mar 2026 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="i31l4ZLC"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1A44B8DF0;
	Tue, 10 Mar 2026 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143765; cv=none; b=ItSZVO0EoGQdQvEn8GgZ0VrWw+NCYhiZ8vraFk6MxBUOyrcEWvJP73pMCUedYEPHiwI+pheDkQsy3yGIxRdYw5sB8Z647NGLWoC13rO0XnDrsqS+mqUKsxC8N/qMz61lDUpJ7X1LrWUv53SvOmarwITEFZv7uy08lZifMSSIuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143765; c=relaxed/simple;
	bh=gXi6ivSyh7ZdNYhxQJgA68gjpGeiYyVoxWZ9PHNV1mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqEyQU/s2PxpeV+JYPdVOQGTnMQAkcXlo2gHsvSj9v2rT8XcFcQlBLrsEwAXwsA9NIt3dLSpft4QN3OJKNFt41tRgyy10W3MHRKEYrM8NrhQa+ffw4cnbxl+FqiklH/FmgjNLNOEHO59fCpLoiI5VmvyI+x00n/PXe3fNqhG87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=i31l4ZLC; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143727; bh=gXi6ivSyh7ZdNYhxQJgA68gjpGeiYyVoxWZ9PHNV1mk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i31l4ZLCMLhpXpaK7/Y2yOfuiAhnSJr8fMnqxjs25j5opOPrdqJNTkpsIEDFkqgSp
	 sZnvLSPj8tGgU4HRU29DH4iPyKhf4v+uoWFgpTspJJOsv7N1zoPc8cizNZidyZ8Q0X
	 jUywybPonMt30TuRnw66+h5bxhBLfRmMmaXnPfrQ=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006af-b734-7f0000032729-7f0000019c20-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:27 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:27 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:17 +0100
Subject: [PATCH 51/61] leds: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-51-bd63b656022d@avm.de>
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
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=gXi6ivSyh7ZdNYhxQJgA68gjpGeiYyVoxWZ9PHNV1mk=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAaDRzpibZr08PkdSw8N3Wy2DsiAYuwbT7jaR
 Q+T5qeGz2qJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGgwAKCRA0LQZT0ays
 2y8ACACMKWU5TdDg1OYJ2RnR6HQxJ+2JBIhOyDk8x3FmHidd0wyjcAKA49FqYhtFEhdjGJpgNO3
 wlcNr4zJ0vDoKzMmVWNj4Kco49QymIlKxd4ko1v9jLom22gL6FIw+i0pd7JG7Dw9K0M9qv/g65X
 psKPmTQlkBRnjyq+gEp1UF+Z+aW8svU4fmV048TA2bEb7zgfrp0dmnA9hbj2JEYjWrt/pHjBWtC
 27oF1sxBbFSjPkNzuaBpb0y9RWyLO/07lImA1AItNHZGlvNpydtzvqp/I3qxgt9sXKt1PHRt8iZ
 u4zVb/lltaBI2wPScPn/3+nmKc5y9QbdtT1oK6vzRsjkH2h6
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143727-CD5F3A3D-F6F9F436/0/0
X-purgate-type: clean
X-purgate-size: 925
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 10AA224E3F3
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
	TAGGED_FROM(0.00)[bounces-1029-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[56];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Lee Jones <lee@kernel.org>
To: Pavel Machek <pavel@kernel.org>
Cc: linux-leds@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/leds/trigger/ledtrig-tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-tty.c b/drivers/leds/trigger/ledtrig-tty.c
index 8eb6286b33ac3cdcbb72ed9ad5ad7105e15d20b6..3725571144d910b225ca9605771fc0f0c8355efd 100644
--- a/drivers/leds/trigger/ledtrig-tty.c
+++ b/drivers/leds/trigger/ledtrig-tty.c
@@ -220,7 +220,7 @@ static void ledtrig_tty_work(struct work_struct *work)
 			goto out;
 
 		tty = tty_kopen_shared(devno);
-		if (IS_ERR(tty) || !tty)
+		if (IS_ERR_OR_NULL(tty))
 			/* What to do? retry or abort */
 			goto out;
 

-- 
2.43.0


