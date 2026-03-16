Return-Path: <linux-sctp+bounces-1136-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK+PEAeAuGltfAEAu9opvQ
	(envelope-from <linux-sctp+bounces-1136-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 16 Mar 2026 23:11:19 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 974762A14A5
	for <lists+linux-sctp@lfdr.de>; Mon, 16 Mar 2026 23:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4A3304BDB2
	for <lists+linux-sctp@lfdr.de>; Mon, 16 Mar 2026 22:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596C6372678;
	Mon, 16 Mar 2026 22:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="eyO5nsRG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="guCypQjf"
X-Original-To: linux-sctp@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B41364E85;
	Mon, 16 Mar 2026 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699061; cv=none; b=X2HD+TcaXbBKqJwG3FOGvtGJ46b+9I3gceqYyzbiFh6CNe9xr5K5tYkgxy7/FPoH9bW5ibjyU1GRsjl45lwRwaFkYUlkIK460MM/W7tnIzi7BdP62SHY3AFNuzkzLwFRLz8crKfu/KWSHUHvsA941n8ETVzAIJYgBbCgkdzV/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699061; c=relaxed/simple;
	bh=bR3l1XBxxG0Br6WPViaTYx4jBj801ByLeboUNggNeu4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A38yHLwEglJnAk0B2QCy7stC9vMmro0enVPstLHcOoOWf+ISPC3fMoHAiOFXJpgQ+JEGYQrlTu0OIZqL9gIfg9EuELK7OlOHQThyqCuvdDItVMWZTKlH5lCT2EoHtG4zqNZ3haS7IZ2EcyWbx12HIJK/xKpWlKg0tgYFk4eMcz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=eyO5nsRG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=guCypQjf; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 96E81138028E;
	Mon, 16 Mar 2026 18:10:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 16 Mar 2026 18:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773699056;
	 x=1773706256; bh=pZj8f0JboyjKt94J8KB7OLIiCOoml43GOZ4w8rDpLPA=; b=
	eyO5nsRGgscBaSPTlSrjx8D8qsmxFZTD+YBT90C8JLtkSU+JG9otBsGP68/aDjfq
	Ip8/CY7pDqj8uLfl6tk9PaoCLmHFx9BmC+OLDsgQIKz5wruWwvglBIFTzX8Bgo1G
	D7tyDhfcq/yYvbxAZYbPlVlov+W1BUQwVVZx34myYfSzzczy+o0TvO2AJR+dEy1d
	h9Fy4zA0IHy3AyAu2lJw7cTPeRVsoH7Q9DZJUhPGVmEq8IZ5byXvr46eUf3RwYLV
	Pd21rN+O2sxo21UD0KoApMpHYwnhY5vI1CKlHqs6nb1Q0ON5mjBcz18/WvPyI4M2
	g7ed/wORmv3aHNEvlM9NEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773699056; x=
	1773706256; bh=pZj8f0JboyjKt94J8KB7OLIiCOoml43GOZ4w8rDpLPA=; b=g
	uCypQjfxr+Zi7JxdTC/p3wGQ4VV0q/Wv3rf4QuOSSvRwPZ4hwWoKXSQwRlJppx/A
	eTD/kX8ytMBkqeeAHXi8QojGoDJPwhemKEl1A5BQyy+VTfQ0kjCklEhRU0D9TNU6
	QzoouUhJdY7Fi24kVLMS4vkfF5Xif+sxcGuZ+ZH9bmNOAZhg/6jHFnuxjrIUYo4Y
	sJAjmQ/c58h+MsTVokuL8c2t4xBbVGwnTgXIvKplEwnaY81NNzKXbPGa+zPU58N/
	vwQ/zZfUYT5zYdyXfBWrfC5sZSkqzhpuD1WACxXIM/TD7Jh2N1ZXy8qS+O1DtSBY
	h24uS6YuZ9c79L+rKNYRA==
X-ME-Sender: <xms:73-4aYdtUUIQC679P0YPl8k6UZ10Tz8-qTD319yDZEtXusdBhZuXRA>
    <xme:73-4aTUav9FvduIIOmc0jldmINr5W_MhUsWQFGzP1fBm1dpf8ggOxSMvCMHniLmCu
    LbRPk360ujIo39hLA6fsP95YlnCLki5WcrUsiuRyEwh6NcxWlxF>
X-ME-Received: <xmr:73-4aSY56rJyFtQwMFw-H9dfM29zbbMWxWkWrpi3kYaZ1kbqDyXdf5bHU5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleelheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfgjfhfogggtgfesthejre
    dtredtvdenucfhrhhomheptehlvgigucghihhllhhirghmshhonhcuoegrlhgvgiesshhh
    rgiisghothdrohhrgheqnecuggftrfgrthhtvghrnhepvdekfeejkedvudfhudfhteekud
    fgudeiteetvdeukedvheetvdekgfdugeevueeunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheprghlvgigsehshhgriigsohhtrdhorhhgpdhnsg
    gprhgtphhtthhopeehhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhrghh
    nhdqohhsshesrghvmhdruggvpdhrtghpthhtoheprghmugdqghhfgieslhhishhtshdrfh
    hrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopegrphhprghrmhhorheslhhishht
    shdruhgsuhhnthhurdgtohhmpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtvghphhdquggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegtohgttghisehinhhrihgrrdhfrhdprhgtphhtthhopegumh
    dquggvvhgvlheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegurhhiqdgu
    vghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtohepgh
    hfshdvsehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:73-4aQltNdDVIdEqvCmz7Mlt0qW50NA4CHgJQUMNlacMN4MGiVKHfA>
    <xmx:73-4acHdFw15OLpR73_B1AdIXJMG-pYssiD_C0T2dj2N-8ux7fVHFg>
    <xmx:73-4aU6P6J2BtdvPwSPzfrUNjz9-qYacHOOWBucSAMlha23fXDTcIg>
    <xmx:73-4aaO5YEqAXlnOLRO88GZx1RbxPW8QtXAeqZQNaqmxlgOL7PgFkQ>
    <xmx:8H-4abIvs_QYur641c9BpnDuFQ6ssCC-7-o-rPLEHWyRxStBDxJEr6SL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 18:10:52 -0400 (EDT)
Date: Mon, 16 Mar 2026 16:10:50 -0600
From: Alex Williamson <alex@shazbot.org>
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
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
 alex@shazbot.org
Subject: Re: [PATCH 46/61] vfio: Prefer IS_ERR_OR_NULL over manual NULL
 check
Message-ID: <20260316161050.01c82973@shazbot.org>
In-Reply-To: <20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
	<20260310-b4-is_err_or_null-v1-46-bd63b656022d@avm.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1136-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[55];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 974762A14A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 12:49:12 +0100
Philipp Hahn <phahn-oss@avm.de> wrote:

> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
> 
> Change generated with coccinelle.
> 
> To: Alex Williamson <alex@shazbot.org>
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 742477546b15d4dbaf9ebcfb2e67627db71521e0..d71922dfde5885967398deddec3e9e04b05adfec 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -923,7 +923,7 @@ vfio_ioctl_device_feature_mig_device_state(struct vfio_device *device,
>  
>  	/* Handle the VFIO_DEVICE_FEATURE_SET */
>  	filp = device->mig_ops->migration_set_state(device, mig.device_state);
> -	if (IS_ERR(filp) || !filp)
> +	if (IS_ERR_OR_NULL(filp))
>  		goto out_copy;
>  
>  	return vfio_ioct_mig_return_fd(filp, arg, &mig);
> 

As others have expressed in general, this doesn't seem to be cleaner
and tends to mask that we consider IS_ERR() and NULL as separate cases
in the goto.  This code looks like it could use some refactoring, and
likely that refactoring should handle the IS_ERR() and NULL cases
separately, but conflating them here is not an improvement.  Thanks,

Alex

