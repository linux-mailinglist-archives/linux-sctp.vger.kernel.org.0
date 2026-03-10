Return-Path: <linux-sctp+bounces-1013-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELbdLhYWsGknfgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1013-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:01:10 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DC424F4D4
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D82E033CFEA5
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE63AA51D;
	Tue, 10 Mar 2026 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="HvCb/8oi"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037847B431;
	Tue, 10 Mar 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143756; cv=none; b=lNLk98etxSieoc4SvRPNOdUOor5DW9otg5a3OeP/WO4WmiJloSvMpIc65ULVVst7I9dhIRWpO8ysQSBSLqtf93eIsiokuw8v3Dylr/1O58TgGbtzJMXXtavEIm2DrjXQ9owKLBZ9+JBuD/oaXPvpIP6Av0ZU7YHd/kKfSrW0kKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143756; c=relaxed/simple;
	bh=Z5CcgUmxb8TIHuxVENT8+Rdbeolb2IW3uV9KbiLoZl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gD1BrmD+qRTHvkHSnhEifOU+JtQr5Jp8+wSyYWJk0ChwL4WwNFlf8Q/lxZKwj8nXPAMyY4Ckc90bqAidTTiOA4qCcbpqZ+HR6WkJoRy2730/7OZSo7u4bQHj4dOtqXYXuwEztXRrGmIeW/D/iYonm61JcXYzWXxiwVT+rx60tVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=HvCb/8oi; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143724; bh=Z5CcgUmxb8TIHuxVENT8+Rdbeolb2IW3uV9KbiLoZl0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HvCb/8oi+QjPTMN2Yg58hVQgISqDho2KSemsYUZ+vy5VD2bnZIm5jRkx5UuokMrry
	 Cd/bADEMvLj4WpFiDDooSYtHMuljYAEx/RujmrWNzucIvLCjqd0TnsL6u3xLqdwjKn
	 SoUF7kcbAi1lGgdxzJJB8ERoQMMzj0TR7iF4FK9M=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-b734-7f0000032729-7f000001bfb4-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:34 +0100
Subject: [PATCH 08/61] fuse: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-8-bd63b656022d@avm.de>
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
Cc: Miklos Szeredi <miklos@szeredi.hu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=Z5CcgUmxb8TIHuxVENT8+Rdbeolb2IW3uV9KbiLoZl0=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXxKvlvqCH0DwJSbq+UNs0LTyfOD3vzlRqtT
 2TRtqiRMXSJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF8QAKCRA0LQZT0ays
 2xgMCACJUN2JSxzamJUFQvwc92wfvAAIT82LlFBC4CNAPLjUwClhfMFmMBmKAZA8HDz81VrcG/p
 fo2P5eS+rFs83E9iVI/bW+OpSphb7hd9/Pa3DNpSkaQcLQUMHw39s5ltgUYmcwhQdUpEa+pWYW+
 gg+34EAVtKnYkmIuH1aWQKSSPRHXFEEIj8Mu1YI3EnTGvDB+NleQt1zN6UaIksTNUf5+3I2W33b
 Z+hxOEmA2AEpaox3bemtlkSQbWv4qtVtcFYcWHKzhKpkUH0i5WAZ0lUSrDgtHsTI7KM+223fQQ9
 V7CmYp8rYAFlP8Yb8uQbtjIbd9Kw5z3oAZRh0mglz23o1NU6
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-035C7A3D-B44CD0B6/0/0
X-purgate-type: clean
X-purgate-size: 892
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 36DC424F4D4
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
	TAGGED_FROM(0.00)[bounces-1013-lists,linux-sctp=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 7ac6b232ef12323e3afb97b98301f623bce917a4..7b39c013027bd9c4ba6f080bfc9b3ec22bc2dd4a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1599,7 +1599,7 @@ int fuse_reverse_inval_entry(struct fuse_conn *fc, u64 parent_nodeid,
 		goto put_parent;
 	while (!entry) {
 		struct dentry *child = try_lookup_noperm(name, dir);
-		if (!child || IS_ERR(child))
+		if (IS_ERR_OR_NULL(child))
 			goto put_parent;
 		entry = start_removing_dentry(dir, child);
 		dput(child);

-- 
2.43.0


