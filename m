Return-Path: <linux-sctp+bounces-1017-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBSRIQYMsGmxewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1017-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:18:14 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228A24D1EC
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B504B303E153
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5A43B19D5;
	Tue, 10 Mar 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="CszXhVeu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98B47DFAF;
	Tue, 10 Mar 2026 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143757; cv=none; b=daDlZj9XxlpGX8u5f26Cgen4opAZY2mMdLwdsnG6FpJIRUwMxuw0GdEjHzj3VaSoaVwrJvNIMdBEm00kTMi6u+Cor+xKiywe6yAkZj1i0Idm19VbIExqBQGF7zf9OQ8RA+peHV4N9c61Kr4Z/QUXL1VsRkUm74cXM+WxciRYF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143757; c=relaxed/simple;
	bh=6EuXq65aclW87MvbjKpAiGhSvzG4CQReYSdgtvzfvbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7sEyfh/cIFanalI4nbEKNH3TXSfLwGV3sKj+Hg6wQlSgppNghf0e0j0RapavEFmAj1SUSxFRb/MwjCk41MHZfSWzhfn/O5K7faYlUkXxvHk7zKtwCXhfqmawfTEMIm4rESZzIVXXscIpPtlwhKhJAqV65YTyc5Nkx8f6wagoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=CszXhVeu; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143725; bh=6EuXq65aclW87MvbjKpAiGhSvzG4CQReYSdgtvzfvbQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CszXhVeuB80dBM7heOJ7Nx+XSyJvFegpI+yV6jBZ48DSexN1OeM6WlzN115+6wkJZ
	 eIxShGlw3YQU/KxKgPaMmZCdhfq/K3QAeOc7zxmganOhcTaf+z4IP3nvXGrkxn8OCE
	 sCjTlI8JJHaCye8ZFzf1bITMckeNh7CQk+9Wf7qE=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ad-b734-7f0000032729-7f000001c08a-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:25 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:25 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:49:03 +0100
Subject: [PATCH 37/61] drm: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260310-b4-is_err_or_null-v1-37-bd63b656022d@avm.de>
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
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Zhenyu Wang <zhenyuw.linux@gmail.com>, Zhi Wang <zhi.wang.linux@gmail.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4819; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=6EuXq65aclW87MvbjKpAiGhSvzG4CQReYSdgtvzfvbQ=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAZT+7AKzVVh94OZwGC1ojred94HRoubB3Jj7
 iZaELcQHomJATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGUwAKCRA0LQZT0ays
 26wAB/9TBiS4XQT7vnGKfXiPWlqEeJl/SwNfE8gRd+LVLd2GPoXI77JKlqZA5KJHsuEaYytwRHj
 0co7/mL9JXJHOUE/UPYXt3qFrwRsleM7nnJK7ysqo/nuMkL1zXCK+fpnqQpoBiKUkPJFjSSQWWs
 A0qg0NaHPa2ThCoMkZDNEnWBS7X/+ME4OgDoWVp7r1X953fdXqxWSX8/++3IUoA8zLfZZvBTN8Z
 lQp574N8BAAfdqG0oi1OBRhOByM9d1hpEYg4qXmJvNDZzHG8su81gcwwO+KaBKEy6Skfpo/fDOj
 n85UVFKj8iDz3Ls4+zhkzod+J74YBwXEvBpocAWj1P06D/Zf
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143725-CBDFEB7D-3DC3B596/0/0
X-purgate-type: clean
X-purgate-size: 4821
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: 1228A24D1EC
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
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,ursulin.net,amd.com,rock-chips.com,sntech.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[avm.de:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1017-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[76];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Andrzej Hajda <andrzej.hajda@intel.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Robert Foss <rfoss@kernel.org>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To: Jonas Karlman <jonas@kwiboo.se>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Zhi Wang <zhi.wang.linux@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Tvrtko Ursulin <tursulin@ursulin.net>
To: Alex Deucher <alexander.deucher@amd.com>
To: "Christian König" <christian.koenig@amd.com>
To: Sandy Huang <hjc@rock-chips.com>
To: "Heiko Stübner" <heiko@sntech.de>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c       | 2 +-
 drivers/gpu/drm/drm_sysfs.c                     | 2 +-
 drivers/gpu/drm/i915/gvt/scheduler.c            | 4 ++--
 drivers/gpu/drm/radeon/radeon_test.c            | 2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ee88c0e793b0416d20105a43448cb4037402e64b..64fa2bc8d28197147ee22b4f74134cc27dd9b32d 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3608,7 +3608,7 @@ void dw_hdmi_remove(struct dw_hdmi *hdmi)
 {
 	drm_bridge_remove(&hdmi->bridge);
 
-	if (hdmi->audio && !IS_ERR(hdmi->audio))
+	if (!IS_ERR_OR_NULL(hdmi->audio))
 		platform_device_unregister(hdmi->audio);
 	if (!IS_ERR(hdmi->cec))
 		platform_device_unregister(hdmi->cec);
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a872843339743d21e4877225855da921e..6748acb4163e8f5658c9201a0412b38862c7baab 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -600,7 +600,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
  */
 int drm_class_device_register(struct device *dev)
 {
-	if (!drm_class || IS_ERR(drm_class))
+	if (IS_ERR_OR_NULL(drm_class))
 		return -ENOENT;
 
 	dev->class = drm_class;
diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/gvt/scheduler.c
index 15fdd514ca836e84f4de95e3207ab45bb9243426..933ec5ffa1f1ebafd687996f167b982490702211 100644
--- a/drivers/gpu/drm/i915/gvt/scheduler.c
+++ b/drivers/gpu/drm/i915/gvt/scheduler.c
@@ -675,10 +675,10 @@ static void release_shadow_batch_buffer(struct intel_vgpu_workload *workload)
 	list_for_each_entry_safe(bb, pos, &workload->shadow_bb, list) {
 		if (bb->obj) {
 			i915_gem_object_lock(bb->obj, NULL);
-			if (bb->va && !IS_ERR(bb->va))
+			if (!IS_ERR_OR_NULL(bb->va))
 				i915_gem_object_unpin_map(bb->obj);
 
-			if (bb->vma && !IS_ERR(bb->vma))
+			if (!IS_ERR_OR_NULL(bb->vma))
 				i915_vma_unpin(bb->vma);
 
 			i915_gem_object_unlock(bb->obj);
diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
index 0b459f7df23bae3eef7e36f4b5f35638fb6f4985..573284c4af60f12d7edec889260fc8a2e2b70420 100644
--- a/drivers/gpu/drm/radeon/radeon_test.c
+++ b/drivers/gpu/drm/radeon/radeon_test.c
@@ -234,7 +234,7 @@ static void radeon_do_test_moves(struct radeon_device *rdev, int flag)
 			radeon_bo_unreserve(gtt_obj[i]);
 			radeon_bo_unref(&gtt_obj[i]);
 		}
-		if (fence && !IS_ERR(fence))
+		if (!IS_ERR_OR_NULL(fence))
 			radeon_fence_unref(&fence);
 		break;
 	}
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 3547d91b25d317c6cad690da7d97a7e5436c0236..8a267de85da9c76c2e29b2ababf1218e400282c2 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1095,7 +1095,7 @@ static int dw_mipi_dsi_rockchip_host_detach(void *priv_data,
 	struct device *second;
 
 	second = dw_mipi_dsi_rockchip_find_second(dsi);
-	if (second && !IS_ERR(second))
+	if (!IS_ERR_OR_NULL(second))
 		component_del(second, &dw_mipi_dsi_rockchip_ops);
 
 	component_del(dsi->dev, &dw_mipi_dsi_rockchip_ops);

-- 
2.43.0


