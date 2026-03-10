Return-Path: <linux-sctp+bounces-1012-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKBQBXkLsGl4ewIAu9opvQ
	(envelope-from <linux-sctp+bounces-1012-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:15:53 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF724CFAC
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 13:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EBDD30943A5
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 12:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D9A3A7582;
	Tue, 10 Mar 2026 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="AHWaJPiB"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1BF47A0BA;
	Tue, 10 Mar 2026 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143754; cv=none; b=ROFUQKVgTznUN9F46983KfRWUAcF7pQ8uLVPaVdG07aUBZe40MmSYmjeoV9/uXkvCdIr/Vl8H8H0HAan9a4PukKUCQhvytfi9CVVwsf41yFA5Q6nWTiMzu35xE9jgoMQ7NTwLbUHB+U3741oghtVi+/I0aPEk9ZrJ5XsLMntqxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143754; c=relaxed/simple;
	bh=lEmCou71DQIv3rJiH+2ZIvzOcBQ45/hCLHA8fjFTjEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2j8NEUrmYNhLSK9yskvF6yyQjJ56tD8mvH3B6owD9OZsFD8kqErkFtN8tTn9LmSCPjPgCbd6AJwiqfdk2C0h34vtNTJZnItKr5M2B8KPyyiHjvDTc2Uczz7i8pk6wxVvT0iewmTEDnUvCxYR+Le3P88TmunWuhB5vdBqwiFouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=AHWaJPiB; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1773143725; bh=lEmCou71DQIv3rJiH+2ZIvzOcBQ45/hCLHA8fjFTjEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AHWaJPiBsL+GwFoetOExpKLG9cmnqvpt8xMBxHRmuFnKfjqJNAZAD1Wuu27hEzCjp
	 yo/8LH57/iizP+bjiVmoMZwTMOiCMC/XLDqy5SSCcm+OQZZ/0iP8EPctZ2sQqxK7Ab
	 XT9/JQSyTpsDOlLEGnKt3l1avwq96+RDdo3lipF8=
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.55.2)
	(envelope-from <phahn-oss@avm.de>)
	id 69b006ac-2367-7f0000032729-7f0000019d40-1
	for <multiple-recipients>; Tue, 10 Mar 2026 12:55:24 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 10 Mar 2026 12:55:24 +0100 (CET)
From: Philipp Hahn <phahn-oss@avm.de>
Date: Tue, 10 Mar 2026 12:48:41 +0100
Subject: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
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
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2257; i=phahn-oss@avm.de;
 h=from:subject:message-id; bh=lEmCou71DQIv3rJiH+2ZIvzOcBQ45/hCLHA8fjFTjEM=;
 b=owEBbQGS/pANAwAKATQtBlPRrKzbAcsmYgBpsAYJfb+qOowLIkUmfJbwapQWgbBrCmoY2MGV1
 kQO676TIO+JATMEAAEKAB0WIQQ5bPBtrWDUcDQCppg0LQZT0ays2wUCabAGCQAKCRA0LQZT0ays
 264GB/0ePCsoEZ4dvusK/+59DK+nFUG4TMYrwfcQ9Aw8geb+nDTbFBXmGXKhwNE0FGNMoZ9u6w0
 6Z8ff6aHriAkc9Kt7Cgo70KOX6BjUy2bKgpnqJ9UCEmLABUocGsnikIoRM/S+kmqBXC+hSxD7sM
 X70l7rxeP1jyVHxWJrxfa6E/R35lI3vjpmjnsYcBxz/fgBeGY30s+ys1gafR9RwiFHF5/fl9jcb
 Y3J+3Pom6JCnaZYPGyS2UG84plp5l+rENGjhP2UWug9tGkZ5pwYbuR79z7QaUT6EEnR3YbR314t
 8SpG12KL4Vc7ZU5W2GsSc9E64021CyFWbNdSoNZGwreTwyp2
X-Developer-Key: i=phahn-oss@avm.de; a=openpgp;
 fpr=58AF7C2E007CDBE62C59E078F50EFDCF8AD04B1A
X-purgate-ID: 149429::1773143724-764F0E1F-76E75FCD/0/0
X-purgate-type: clean
X-purgate-size: 2259
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Queue-Id: DAFF724CFAC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[avm.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[avm.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[avm.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1012-lists,linux-sctp=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phahn-oss@avm.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[57];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,efficios.com:email,avm.de:dkim,avm.de:email,avm.de:mid,goodmis.org:email]
X-Rspamd-Action: no action

Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
check.

Change generated with coccinelle.

To: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
---
 kernel/trace/fprobe.c                | 2 +-
 kernel/trace/kprobe_event_gen_test.c | 2 +-
 kernel/trace/trace_events_hist.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index dcadf1d23b8a31f571392d0c49cbd22df1716b4f..a94ce810d83b90f55d1178a9bd29c78fd068df4c 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -607,7 +607,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	do {
 		rhashtable_walk_start(&iter);
 
-		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
+		while (!IS_ERR_OR_NULL((node = rhashtable_walk_next(&iter))))
 			fprobe_remove_node_in_module(mod, node, &alist);
 
 		rhashtable_walk_stop(&iter);
diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
index 5a4b722b50451bfdee42769a6d3be39c055690d1..a1735ca273f0b756aa1fcfcdab30ddad9bc51c5f 100644
--- a/kernel/trace/kprobe_event_gen_test.c
+++ b/kernel/trace/kprobe_event_gen_test.c
@@ -75,7 +75,7 @@ static struct trace_event_file *gen_kretprobe_test;
 
 static bool trace_event_file_is_valid(struct trace_event_file *input)
 {
-	return input && !IS_ERR(input);
+	return !IS_ERR_OR_NULL(input);
 }
 
 /*
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad555898693e92ee397a1c9493c7c167..59df215e1dfd9349eca1c0823ed709ec7285f766 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3973,7 +3973,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
 	 */
 	field_var = create_target_field_var(hist_data, system, event, var);
 
-	if (field_var && !IS_ERR(field_var)) {
+	if (!IS_ERR_OR_NULL(field_var)) {
 		save_field_var(hist_data, field_var);
 		hist_field = field_var->var;
 	} else {

-- 
2.43.0


