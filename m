Return-Path: <linux-sctp+bounces-1007-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJpKMl0KsGl4ewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1007-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:11:09 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E64A24CAA9
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BCF530793C7
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2374E3768;
	Tue, 10 Mar 2026 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="CWhZH8pY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A246AEDF;
	Tue, 10 Mar 2026 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143746; cv=none; b=MsKPGpCqHBbOGDuvLXlYbESa2gOcZZMuhIdWCqu1KOZ6UtX9KcubXD5NQNCkGoGBz8I9QSv0URqVq5j7qqCNfhLxj5KVHgVLOUnn7dlGQLhu5vfhYlZpU5+r51CER9ByNDRRoZRYH2PbbxRYhLZZbf9Cv1fhCcll/FCB9JDc564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143746; c=relaxed/simple;
	bh=TePjCBJ2mRHkUlSzKz9AEyXwCeNO/T4sJeJlLVRUEek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTVLhfh5QEizESkg7FRHSqVrgQ1fwSJfv2Dbv62TrbuLIzW0dOn9hLkEebloaX6a5D6y0eGl8Ggcadcxj9nMqmN+6L1JABNSiOlRC+FURj/VAk51EeFJA9egTE0VaOYliAes6uYAhhUH/L5ZJ2gtiAhYA/KQOBRu76GFutGFhy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=CWhZH8pY; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143724; bh=TePjCBJ2mRHkUlSzKz9AEyXwCeNO/T4sJeJlLVRUEek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CWhZH8pYoPHXJ9GodRv8bZf7CTCXPR5biEc/ESvLjFSG7M9EoK4FQxeOy1o2q/xFG
	 adtTUhZFnjWgEtd3EnUld9xRhtBPP2LCXHOMBXjK/IfTv5IvUPb5jOISEusb1eiq65
	 jalyJvpG8KfbWsOaQK+eTSDIbq4VvwVTL38wqr+Y=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ab-b734-7f0000032729-7f000001c008-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:23 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:23 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:44 +0100
Subject: [PATCH 18/61] sound: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-18-bd63b656022d@avm.de>
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
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=TePjCBJ2mRHkUlSzKz9AEyXwCeNO/T4sJeJlLVRUEek=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYTbY49pcWmI+zPeufRNN/9dH/gm0tUhIW5M
 sSE0KnGvN+JATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGEwAKCRA0LQZT0ays
 20TjCACXYevOdzzWZ8zg+QT0mj5XNSQgsj+29ztKUJ+NhTXTaWid39EhUMP397Ax0ta31zsGPRm
 0odiGii9nvcNMTK3z0LbXHwAyd2Q0fNqi4zFsqaNgSljw41n6QLzk50RIIvlMAtwUsismcvcfkc
 GlGmvCqi0YMh5Ps6ZKTVJuHiANRfJwasfti849ayN0tL2bNpZjcStJrsD6oocum/i0yO/DOehLD
 OGOf2TSq2UVG28aLw7N49gUvv1bUDwk6CT215ovMEtUyRG0UE7FpDGWKSdiW4/MWJSzpOO7eARa
 NIfS+Ckmg34HqAiCowU5EbKs98L8LUAVBFgmoB7oAUhpavOc
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143723-D7DE6A3D-A892B33C/0/0
X-purgate-type: clean
X-purgate-size: 2162
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 5E64A24CAA9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samsung.com,gmail.com,kernel.org,perex.cz,suse.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1007-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[60];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,avm.de:dkim,avm.de:email,avm.de:mid,suse.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,perex.cz:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Sylwester Nawrocki <s.nawrocki@samsung.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 sound/soc/samsung/i2s.c       | 4 ++--
 sound/soc/xtensa/xtfpga-i2s.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index e9964f0e010aee549cced75d8fe2023e8271d443..6e86f3a0a52dd3f8fc728d634594eb81f9945c57 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -559,7 +559,7 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id, unsigned int rfs,
 			clk_id = 1;
 
 		if (!any_active(i2s)) {
-			if (priv->op_clk && !IS_ERR(priv->op_clk)) {
+			if (!IS_ERR_OR_NULL(priv->op_clk)) {
 				if ((clk_id && !(mod & rsrc_mask)) ||
 					(!clk_id && (mod & rsrc_mask))) {
 					clk_disable_unprepare(priv->op_clk);
@@ -812,7 +812,7 @@ static int i2s_hw_params(struct snd_pcm_substream *substream,
 	i2s->frmclk = params_rate(params);
 
 	rclksrc = priv->clk_table[CLK_I2S_RCLK_SRC];
-	if (rclksrc && !IS_ERR(rclksrc))
+	if (!IS_ERR_OR_NULL(rclksrc))
 		priv->rclk_srcrate = clk_get_rate(rclksrc);
 
 	return 0;
diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 678ded059b959d475b6be3766867c8a78bdd4e54..698905257b690457a5d3d315e77d99d487d91f77 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -609,7 +609,7 @@ static void xtfpga_i2s_remove(struct platform_device *pdev)
 {
 	struct xtfpga_i2s *i2s = dev_get_drvdata(&pdev->dev);
 
-	if (i2s->regmap && !IS_ERR(i2s->regmap)) {
+	if (!IS_ERR_OR_NULL(i2s->regmap)) {
 		regmap_write(i2s->regmap, XTFPGA_I2S_CONFIG, 0);
 		regmap_write(i2s->regmap, XTFPGA_I2S_INT_MASK, 0);
 		regmap_write(i2s->regmap, XTFPGA_I2S_INT_STATUS,

-- 
2.43.0


