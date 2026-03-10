Return-Path: <linux-sctp+bounces-1003-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHPSMjMMsGmxewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1003-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:18:59 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248624D2E9
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78A7431B59E6
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBD34D90A1;
	Tue, 10 Mar 2026 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="ZioiLNZ6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01DD4657F3;
	Tue, 10 Mar 2026 11:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143749; cv=none; b=Ji7rN6OuGls7wCepF3QkMANhnMDUzvtmdfDigoFrw6H/zkiQpzTyv4f4vJTExNem5jILxgtHtA2HAHcQyo/QpB4AVWotK036Ag7W8zseNtFQluMLSPnz0BNzvjk6bN6La0RyGNeifBHJWQlnufVLpWuyl+t9uXcsX3FAm7IRdhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143749; c=relaxed/simple;
	bh=KX6X+DDiGt9UXTjcCHLPV6DtScldl/2cIRjPuvT9tTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7jps1l2eCVhPG1KU0jWmuky8a+VgTm1xgA7KXEhRKzyVZBAEU378A6xQp0aOF2K7Wtuu2oTlm1dFxoehmHsawBmYiv2cTI/1Hd/1/RQlvOuFTVbj3N6KLRwzroqEJpIsnpyRDLbJ5EE3oFiGVjzOnuzEA3nstdU6MbcQ28EIEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=ZioiLNZ6; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143723; bh=KX6X+DDiGt9UXTjcCHLPV6DtScldl/2cIRjPuvT9tTY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZioiLNZ6EfhKGMrW73+pjGIuwzOuvOKiSTcZ7wPJiCwebXNzeEOuXWZ+A1nFHvhW4
	 kJcOoKZ0VhxgqpRswcks1O+/9tUDVhOk4k88nkZD85ItDoYcz2HVcAjttfrO5CwuLe
	 NFoc05VLkE1QM4ORDb0Hi3i8FcBzsZqAPnJdPzxQ=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-2367-7f0000032729-7f0000019d06-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:32 +0100
Subject: [PATCH 06/61] 9p: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-6-bd63b656022d@avm.de>
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
Cc: Eric Van Hensbergen <ericvh@kernel.org>, 
 Latchesar Ionkov <lucho@ionkov.net>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 Christian Schoenebeck <linux_oss@crudebyte.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=KX6X+DDiGt9UXTjcCHLPV6DtScldl/2cIRjPuvT9tTY=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAXqJp0CDUjw9jEvsvX+a/KbvAdXeFk7KScmA
 k1gbpU+8P+JATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAF6gAKCRA0LQZT0ays
 29mrCACj+Vud6UtbAeAOyyVoHbFLvMA1jaglqqRGws0fgYsgwpzXFXvy2i2CmaAOIcTuq4UVTOl
 2Cp9O2MO0VDKHA4864zJOud8em6WQkYpTs1edDKjyZ8gpLnrkl+uUALuLIZHLcn32/PFl6USje2
 0rlhbB9Ue5RZDoT7EFzcp3mX899jCdSGzalbeWr5SPDgRQW0S9l7PbTpDgAvlvTr4+JT6Q76sJ+
 Xum3jXXZ29Rm368akWgnu/SoCzltjqdTHnSYloTAliMoi8hFFj6gbktEQSHRbMEzLVXTgNcHq2l
 4mfiDZbzmkqs8S8e3yaP+Mk/R/tjrHLygop2cIGzqTfhnlfW
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-77CF7E1F-303E842C/0/0
X-purgate-type: clean
X-purgate-size: 934
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 5248624D2E9
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
	TAGGED_FROM(0.00)[bounces-1003-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,codewreck.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid,ionkov.net:email,crudebyte.com:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Eric Van Hensbergen <ericvh@kernel.org>
To: Latchesar Ionkov <lucho@ionkov.net>
To: Dominique Martinet <asmadeus@codewreck.org>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: v9fs@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 fs/9p/fid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 0d6138bee2a3d1ab565ab2d210c0a3f3bf97e4e3..3bb7ef4380e972a2d9ab67eb4aab6cc5bfe2eea7 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -27,7 +27,7 @@ static inline struct p9_fid *v9fs_fid_clone(struct dentry *dentry)
 	struct p9_fid *fid, *nfid;
 
 	fid = v9fs_fid_lookup(dentry);
-	if (!fid || IS_ERR(fid))
+	if (IS_ERR_OR_NULL(fid))
 		return fid;
 
 	nfid = clone_fid(fid);

-- 
2.43.0


