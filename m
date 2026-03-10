Return-Path: <linux-sctp+bounces-1016-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AXCOsEKsGlregIAu9opvQ
	(envelope-from <linux-sctp+bounces-1016-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:12:49 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2B224CCB5
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A50730A2C90
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EB93B0AD5;
	Tue, 10 Mar 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="helEnKZU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2247247DD49;
	Tue, 10 Mar 2026 11:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143756; cv=none; b=AF8a008rQHiuzknJGtnyMWpmxJOaMJv/ai5UJfJq0PYfKVwuO2mLimKeZbI5kLmO1qeX+mBmltTqu/ao0PL96E2XlZVMdvt/+gjcwcTn1UhZE/l9gse+UQGZz8OPCElDDfeAFy+c4R6SPgEJt6n3N6r7wG2fWBbJlp9MijDaiPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143756; c=relaxed/simple;
	bh=xBKhBreRFiEpPz9/49OtWlCzYkq81mZihzEqekyK7xA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hONHER+x6S0PjjQWaUesWeqndINfLZ1aHhFUdmCcAztsazISGhgVBl6dowy3MPmUmA5M5xtMfvg3GH2yt0FnuVxk84+Hz71Um9KKZq7puQZ+0j6nBXUwau+f5ilEex9rDFIJQYpMrhEqsmPJVLxWem2WACN4+8qmOuy0uTZHEEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=helEnKZU; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143725; bh=xBKhBreRFiEpPz9/49OtWlCzYkq81mZihzEqekyK7xA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=helEnKZUDYmuyC7r9itC+dVARlXrRlYpZWzDAaAXEYc5wN1FHoKQsdSjCaomchjhv
	 +41zqDKlH044FWtyvi2VX9TAdQF1rs14U237EegHWJogLxynx4m+2shwi9NDMEzjxe
	 k3vCUFrBTw+1/DCUt/wn8qmUGFq+b5Q0TC9ytTvc=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-b734-7f0000032729-7f000001c024-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:48 +0100
Subject: [PATCH 22/61] md: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-22-bd63b656022d@avm.de>
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
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Benjamin Marzinski <bmarzins@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=xBKhBreRFiEpPz9/49OtWlCzYkq81mZihzEqekyK7xA=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYgLcFKxegL/bQqhgTo4RNQJgrnmxL3YCzsA
 NwbsOtNPYeJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGIAAKCRA0LQZT0ays
 21bACACtmD+JNOZZE2WtYGgZs+OKFUvGXg8BvTcg2nAeuTAfDV15mPSXGDJtr1bOhVuDnL/Nw9l
 YuHe1nCI3Kb5gMl9oJ6QTc/nxqpUehwIiPaszmCzsqUT9Av4+JV9tbiRExsTnWgWp8/ohC7O/t7
 0F2HI97L08/EOhP6er3J/caSpZnOpbWXT+xXd1cfFQmhFO8426W+HbSPnqaYqXoPZvzXs04m+U7
 Y+HhZZm9gUaVM39bOf2O7FpXKP5lXlaxHXla0Syc5xOdqOCZGHEwLXH/1MeFU5JbVnp/DFE01i8
 2gpgUDB/Kr+8ov9qYVC2ZPrR+l2cjmrUojAxw0U8eiSwxKRA
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-71DC2A3D-384367F1/0/0
X-purgate-type: clean
X-purgate-size: 1997
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 7A2B224CCB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1016-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[58];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[avm.de:dkim,avm.de:email,avm.de:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Alasdair Kergon <agk@redhat.com>
To: Mike Snitzer <snitzer@kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
To: Benjamin Marzinski <bmarzins@redhat.com>
Cc: dm-devel@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/md/dm-cache-metadata.c | 2 +-
 drivers/md/dm-crypt.c          | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index 57158c02d096ed38759d563bf27e7f1b3fe58ccc..32f7d25b83a181a30a78c663d48f7882cb97f7b5 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1819,7 +1819,7 @@ int dm_cache_metadata_abort(struct dm_cache_metadata *cmd)
 	WRITE_UNLOCK(cmd);
 	dm_block_manager_destroy(old_bm);
 out:
-	if (new_bm && !IS_ERR(new_bm))
+	if (!IS_ERR_OR_NULL(new_bm))
 		dm_block_manager_destroy(new_bm);
 
 	return r;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 54823341c9fda46b2d8e13428cbd51f3edf642d5..05eae3d3c7df6baebd0b7a4219f7b6938f6e7f87 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2295,7 +2295,7 @@ static void crypt_free_tfms_aead(struct crypt_config *cc)
 	if (!cc->cipher_tfm.tfms_aead)
 		return;
 
-	if (cc->cipher_tfm.tfms_aead[0] && !IS_ERR(cc->cipher_tfm.tfms_aead[0])) {
+	if (!IS_ERR_OR_NULL(cc->cipher_tfm.tfms_aead[0])) {
 		crypto_free_aead(cc->cipher_tfm.tfms_aead[0]);
 		cc->cipher_tfm.tfms_aead[0] = NULL;
 	}
@@ -2312,7 +2312,7 @@ static void crypt_free_tfms_skcipher(struct crypt_config *cc)
 		return;
 
 	for (i = 0; i < cc->tfms_count; i++)
-		if (cc->cipher_tfm.tfms[i] && !IS_ERR(cc->cipher_tfm.tfms[i])) {
+		if (!IS_ERR_OR_NULL(cc->cipher_tfm.tfms[i])) {
 			crypto_free_skcipher(cc->cipher_tfm.tfms[i]);
 			cc->cipher_tfm.tfms[i] = NULL;
 		}

-- 
2.43.0


