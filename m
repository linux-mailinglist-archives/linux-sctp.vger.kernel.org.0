Return-Path: <linux-sctp+bounces-1060-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COmhHKMvsGkShAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1060-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 15:50:11 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6D252779
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 15:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CB56326ED50
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646D139DBE3;
	Tue, 10 Mar 2026 14:14:15 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF472391E63;
	Tue, 10 Mar 2026 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773152055; cv=none; b=k7HLW1eu0CVhEw1JOHUvmzxhZg9w+0HcdgG4jPigu3gUdoQF3fQJYlT7RLFSF2aTeAq7RWaKORcQEcAlEPYIUwBT8BNfE6tyspF6JO7txXJwQsUFpyTZO3IUicm2hJG08M5u3aYpgoF4jc9eKBWX1hGeXqwZPGGdqheS4/QSpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773152055; c=relaxed/simple;
	bh=SMamLYuK7QpP5Qy11gfel2SYdZy/ey1WEVc9Se5MWz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nAGcBReV5CYWz9pLAKq9eCNFHF6PdQxOeJjbrZQZUfHBULwX5aVkcgIuRI1rxu+PBtefANSOk4AFOKw+/KscrNk3GeCxWASrklK4jmTd1wfTzkQ4QHxfwlmxugKQpOqG7gVNggk0k501/HqZwzAwZU4BRrsVZy3mu0TLEX8TAuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 0CEFF1C171;
	Tue, 10 Mar 2026 14:08:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 847E92D;
	Tue, 10 Mar 2026 14:07:40 +0000 (UTC)
Date: Tue, 10 Mar 2026 10:07:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL
 check
Message-ID: <20260310100750.303af303@gandalf.local.home>
In-Reply-To: <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7qtdkkf3por5hcs9du9pir5nqq8uht35
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Z3Tx1sMlUDFHS8YYPfSOpiqPw8cg/LfU=
X-HE-Tag: 1773151660-993833
X-HE-Meta: U2FsdGVkX1+JWrMXdInzvBx9l2WUqahyoYUezPLaF3HICGuHpiLcos2NJHmqwFPLfM8ZBXZ6/fmTg/vlHLcqcaFGukyEZOsOE3kBaCKhhIkGksjLucUHfFRW8KX39dTkHeOQhZTWX/A0f9Y+1fWRMEQzHGhaJF2wpPshgb4yUxNCAKdeI6QYyukTSlQGbTY7Uxizi79ndrJuznFkrJ0f1Gh3JC2I5gazyCY5QhqLMJ9a9ShPFpKdZ7NDaPeyx31oXfa0p+bWWHR1R5JbGDYWhbllAgJDuEbxQsOff6UlFUV0L3hTo0f3pFVAKw4ZSe/3wUeKTGah6IcaIcnei7ziR9eK5k/ow6hfmOBOZGq2CLBxHUplOJMJzaQEF/IeU48U6bUZ8WiPpl/JDxwK03ucqBa/7oG+YB+etWyAxh+TKdi7NbCLCb6PbeExJ2cO76n2AdjJCB03SaDGNN90kGsLmA==
X-Rspamd-Queue-Id: 18B6D252779
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[goodmis.org : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1060-lists,linux-sctp=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rostedt@goodmis.org,linux-sctp@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_GT_50(0.00)[56];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.787];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goodmis.org:email,avm.de:email,gandalf.local.home:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,efficios.com:email]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 12:48:41 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.

Why?

> 
> Change generated with coccinelle.
> 
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Masami Hiramatsu <mhiramat@kernel.org>
> To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  kernel/trace/fprobe.c                | 2 +-
>  kernel/trace/kprobe_event_gen_test.c | 2 +-
>  kernel/trace/trace_events_hist.c     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index dcadf1d23b8a31f571392d0c49cbd22df1716b4f..a94ce810d83b90f55d1178a9bd29c78fd068df4c 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -607,7 +607,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
>  	do {
>  		rhashtable_walk_start(&iter);
>  
> -		while ((node = rhashtable_walk_next(&iter)) && !IS_ERR(node))
> +		while (!IS_ERR_OR_NULL((node = rhashtable_walk_next(&iter))))

Ug, No!

That looks so much worse than the original.

-- Steve

>  			fprobe_remove_node_in_module(mod, node, &alist);
>  
>  		rhashtable_walk_stop(&iter);
> diff --git a/kernel/trace/kprobe_event_gen_test.c b/kernel/trace/kprobe_event_gen_test.c
> index 5a4b722b50451bfdee42769a6d3be39c055690d1..a1735ca273f0b756aa1fcfcdab30ddad9bc51c5f 100644
> --- a/kernel/trace/kprobe_event_gen_test.c
> +++ b/kernel/trace/kprobe_event_gen_test.c
> @@ -75,7 +75,7 @@ static struct trace_event_file *gen_kretprobe_test;
>  
>  static bool trace_event_file_is_valid(struct trace_event_file *input)
>  {
> -	return input && !IS_ERR(input);
> +	return !IS_ERR_OR_NULL(input);
>  }
>  
>  /*
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 73ea180cad555898693e92ee397a1c9493c7c167..59df215e1dfd9349eca1c0823ed709ec7285f766 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3973,7 +3973,7 @@ trace_action_create_field_var(struct hist_trigger_data *hist_data,
>  	 */
>  	field_var = create_target_field_var(hist_data, system, event, var);
>  
> -	if (field_var && !IS_ERR(field_var)) {
> +	if (!IS_ERR_OR_NULL(field_var)) {
>  		save_field_var(hist_data, field_var);
>  		hist_field = field_var->var;
>  	} else {
> 


