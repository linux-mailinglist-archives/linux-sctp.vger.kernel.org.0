Return-Path: <linux-sctp+bounces-1039-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CzsJT4UsGnRfAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1039-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:53:18 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344424F183
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A403A337EE1E
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F653FAE0A;
	Tue, 10 Mar 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="cflriKS/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49C5423A6C;
	Tue, 10 Mar 2026 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143760; cv=none; b=Zd5DGMHMmczVV9z+KnJCGW8zwq0fmzrV7jkdlXNEMJyBu0eMezpcPTsuK4ZZ22p2l3XMatNB/i/5I5/HjOWGXIvp13sGCsGAybOBHpNynrZjlu1mdRGOpcgwk7H9qj4wxMxfX328PFuWrpNDu5ZGGBwJxB6kfSwxfeqz1YxHi/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143760; c=relaxed/simple;
	bh=Ch69HE8buqP46euP+YYFTxXSo2whzs/OaZa7KOXrnvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZouGKRW8zEH2kLucSXcIb0vB9ZEhTZqnNP8yauBiicItzUPAwbI6XF+NZ4ijaCjwWh/snSVSyVHCSi144yJuD/5YfXNin+9ry1XVCXdYEr3ZHdQuTI268/hy22WH7gYcF9QWlSLc+k3hF74KvI9jb0P9BHI5MX2IHxKUpOvsmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=cflriKS/; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143726; bh=Ch69HE8buqP46euP+YYFTxXSo2whzs/OaZa7KOXrnvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cflriKS/Uv58AGT33/uwNkwB7J2sdEXakW9Rj3yjFGXI+RI4a366cceElHliZyuuJ
	 mPSZ4TFmYIg3AF1ANgH8AJ4fIbLOCMfBhLuXzJMYqTbevJEc4r+piLw+nWaz0hy5uE
	 Y9GvHMtmRIkJRf4y+wtLqshG0kOCxTBOOJdztUGI=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ad-2367-7f0000032729-7f000001c97a-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:26 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:58 +0100
Subject: [PATCH 32/61] net/wireless: Prefer IS_ERR_OR_NULL over manual NULL
 check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-32-bd63b656022d@avm.de>
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
Cc: Johannes Berg <johannes@sipsolutions.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=Ch69HE8buqP46euP+YYFTxXSo2whzs/OaZa7KOXrnvQ=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZCB6VtswQFIkNrtK394BinlB0uxLllvDTnj
 z6f33li4q+JATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGQgAKCRA0LQZT0ays
 29wzCAChPFrcW+FfvZBVjABe7F29XZ5724a8XRQE85Iu6UGQCVTrGSBLyo8jXYsg5J3peaPVeKT
 KKhoEQfBVKbt6EAaScrTEpLi3KNOnd86Q8Wna7PddPHX6e15k2MlGUGDjd2Bw64F5NdG8ERAjc6
 DA0lCDlLGGjTu5XPxTGz5ABOwv4DjK6Yeb1iOXElewR1+d8c0JuR13TfzCtZK7b2pKqoZzkmtsk
 88UMWo9/5GiOCX9lUMyP/7qRCJPVDMHslX+kZfg6K27OVxqrHU+QQ1K66P5yscc52ULdw9obFw9
 w1Ny2/RuJ7C5Uaac1egGmoDY7u2Te8bNEht0/tO/Xq6O2NMq
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143726-964B0E1F-7D6D0A0A/0/0
X-purgate-type: clean
X-purgate-size: 919
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 0344424F183
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
	TAGGED_FROM(0.00)[bounces-1039-lists,linux-sctp=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,avm.de:dkim,avm.de:email,avm.de:mid]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 net/wireless/reg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1c5c38d18febd511285bc4aab93a60b4287dc054..222764a151ea25bec6179dbaffa87f34fdbf8da6 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1014,7 +1014,7 @@ static void regdb_fw_cb(const struct firmware *fw, void *context)
 	}
 
 	rtnl_lock();
-	if (regdb && !IS_ERR(regdb)) {
+	if (!IS_ERR_OR_NULL(regdb)) {
 		/* negative case - a bug
 		 * positive case - can happen due to race in case of multiple cb's in
 		 * queue, due to usage of asynchronous callback

-- 
2.43.0


