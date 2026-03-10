Return-Path: <linux-sctp+bounces-1045-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKZnJpUdsGlBgAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1045-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:33:09 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE4250629
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B8783230972
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BAB3FF89C;
	Tue, 10 Mar 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="SoumYKRr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9B4A13B0;
	Tue, 10 Mar 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143764; cv=none; b=pgz7cKJmEnitHFVUFfueG5oMRFM6jlZKI5+Cewvkv6UNeriItPgv79oNe0XIOJaoH3ou13aOYmXF41a3iLT8dVIPK8LYeTUeVsERehcE9QFzJoz84j28TtCxB7Ze9SvBAxX4/AbsJhGEFbKEE9q9FxMd1BZnxjN3BnsSnNh708s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143764; c=relaxed/simple;
	bh=BZdZKAXpTi8WGNXN2fiMzetM/noYEEE0kBAl+EzvNzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m3fVLUR1Y1Vwiq4hym9NRRVwKHbJuEhHSQm9zRZ/3xWyEHom8TLqMYc5IqQU02YJ48I2zz7bndMFgOwMJQMjBYRkIrQkHlCYjuO/obPX2S1hhz7RJ3m2PsFTpHcNsk501cMHgwnwExkICRKo2K3IEqhZJBlgAiZjWE+aVXhSOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=SoumYKRr; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143730; bh=BZdZKAXpTi8WGNXN2fiMzetM/noYEEE0kBAl+EzvNzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SoumYKRreG/py1h5mHUmmcf5MNhTA0IWVyuhwVtBQDsB3zjLeFZGYUpB8dmBQK885
	 8zp8zOhWINTswvz/8Dpb4sCQeiaM8MeFzyXeYCejwMtQ6v6ZBfw76CXpeNeZINOkH+
	 x4yAkEpkA6PhpBthZhWBkiZQBi3374fgQonGrnmw=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006b1-2367-7f0000032729-7f000001ca68-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:29 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:29 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:27 +0100
Subject: [PATCH 61/61] file: Drop unlikely() around IS_ERR_OR_NULL()
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-61-bd63b656022d@avm.de>
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
Cc: Christian Brauner <brauner@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=BZdZKAXpTi8WGNXN2fiMzetM/noYEEE0kBAl+EzvNzY=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAamjmr2YH1D6NIv4bWMOoOgSjqlNw1AkTnEk
 z4zblGz3BCJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGpgAKCRA0LQZT0ays
 24dkB/9I2IH2WVtNuAbc4pN8k/UWfzfn7IBk5SYldKbG4a3vAt2BCQOMLY6KBgHTT+SL+30NFE0
 eqhT72U09tRMvyWUaeodCCSJABvxL6Unq+gQWaX6/P1+X8+kVa/Fa0v8GHtiYqiopntbOsAjZBr
 sS0Bbptn0GuVsdoMNke4vQD0A9rA3xW5nWOgDpK1U8FjC9uaXfz1Bfzn2XQq/Me0fZtcNCJpNlZ
 qjNOLRSw3BZGb7IPqnUrcjHIuuNd6dYbs6wYHOgbyiibTqQrj6tp6SnoDxHnYU93V6GBh2lMfHt
 9qSEynUbZNIYOnoqI2ah9KWLVKFkMsTrddsdp5JisL6z2WZS
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143729-96CB1E1F-80912B69/0/0
X-purgate-type: clean
X-purgate-size: 1022
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 9EFE4250629
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1045-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[56];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

IS_ERR_OR_NULL() already uses likely(!ptr) internally. checkpatch does
not like nesting it:
> WARNING: nested (un)?likely() calls, IS_ERR_OR_NULL already uses
> unlikely() internally
Remove the explicit use of unlikely().

Change generated with coccinelle.

To: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 include/linux/file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index 27484b444d3155685cdbb89f546f26ef66e3e1b4..007b9b9d365a052c1c056e12571eaf4f8ef5a45c 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -163,7 +163,7 @@ static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
 {
 	if (unlikely(fdf->__fd >= 0))
 		put_unused_fd(fdf->__fd);
-	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
+	if (!IS_ERR_OR_NULL(fdf->__file))
 		fput(fdf->__file);
 }
 

-- 
2.43.0


