Return-Path: <linux-sctp+bounces-1034-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDcGNkIYsGknfgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1034-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:10:26 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ACC24FA3E
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 931E53253B1D
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6F33F7E76;
	Tue, 10 Mar 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="XrOjEMLx"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258E47D940;
	Tue, 10 Mar 2026 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143755; cv=none; b=kEEXiE74TX0WzkNIL8gzGLbCrNWL7qRoKVqwdKi3kdVI31ET30kH/JKL135H+BtiVrdLT9u1ZKQ6CN2ZhGBtkjBzg4j8f1K3pfmMERxO1f/V214qPY8hZ6ayCYbm03LFwEUgMvnte1nkm/W30yPj4dnQJYvFRXQYRS2YxGwYbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143755; c=relaxed/simple;
	bh=pn4l4Bneda6cRvLB6hSFUDCMaCdQu5yrimDpnU+4XNM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hAOVade4FmyWubPIcwU8xMFRQx9r7xpmY1JrFMoHkWINF5O4KgVZEBSpJqs/sFGM/6TCUVyTaB1qKkBgOgDoBqzrBuAQeby23+kebYO5dYTlzdETOW5z7GYnn6KV3id5LAmKA8E4v/W/C6RNy1H/eBKxuZ+qRuYfiuz7rb9sXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=XrOjEMLx; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143725; bh=pn4l4Bneda6cRvLB6hSFUDCMaCdQu5yrimDpnU+4XNM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XrOjEMLxKN0Q5AmyrWHNIKWYwAXYvxSGofpRw1fSzyTCz7O3kSu9wZMVhCigrODma
	 xaDgiBmBXDbNfcoI5fcc6yYimuO3Cnj4vKRdoox62XvE8LKZz+/gN4z3zTXbmuJ2J8
	 09unIVObBESNuzHAoxHz8OyIcq6YqGzcxhMd6Jyc=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-2367-7f0000032729-7f0000019d5a-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:46 +0100
Subject: [PATCH 20/61] apparmor: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-20-bd63b656022d@avm.de>
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
Cc: John Johansen <john.johansen@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=pn4l4Bneda6cRvLB6hSFUDCMaCdQu5yrimDpnU+4XNM=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYZg+c1WuLJkNtjs3nyvfVhnVwRMFZkjRyjg
 9Bta5ElUMSJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGGQAKCRA0LQZT0ays
 21AMCAC7XRT2CFV3uyPK4StoEGsXQYqMR1ynn7bit9TqTcf+0Wgtn6TYvMctAHR6A5S0MhH7yf7
 gILWOKn6+HLqPdr3lmY3ZuYwuYUr4OHhvBA9aCnbDXWOuH1dD12oVxx3wu0+3drbZUUw1a5lJWN
 hsJfyDm3gNagxfOpgqCfQqiJ9xVVghJWjS+o0/hto7AZgqOBw9ObaanKLghJUEDwwTwpQEVda2+
 0LDNyTd4iej+Ak8COmDse1KGC2gcs+EiSzfYOC0pte2fBmGM11VRcAnsxd2vAsBFmvs/mJ8XFJS
 YSqDB3vEx2vFoOZdvhWx2ECAhXN2w/fnobSlleabiSgRaViM
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-914AAE1F-0BAD1D24/0/0
X-purgate-type: clean
X-purgate-size: 1036
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: D5ACC24FA3E
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
	TAGGED_FROM(0.00)[bounces-1034-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hallyn.com:email,paul-moore.com:email,ubuntu.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,canonical.com:email,namei.org:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: John Johansen <john.johansen@canonical.com>
To: Paul Moore <paul@paul-moore.com>
To: James Morris <jmorris@namei.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: apparmor@lists.ubuntu.com
Cc: linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 security/apparmor/apparmorfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 2f84bd23edb69e7e69cb097e554091df0132816d..5145b0c9c699514697291967c5a7b1e96b8753d1 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -352,7 +352,7 @@ static void aafs_remove(struct dentry *dentry)
 {
 	struct inode *dir;
 
-	if (!dentry || IS_ERR(dentry))
+	if (IS_ERR_OR_NULL(dentry))
 		return;
 
 	/* ->d_parent is stable as rename is not supported */

-- 
2.43.0


