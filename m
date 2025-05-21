Return-Path: <linux-sctp+bounces-548-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FF7ABF100
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A77C4E4ADE
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FC325A626;
	Wed, 21 May 2025 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JlBM26su";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kjgxIqum";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JlBM26su";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kjgxIqum"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF7E25A354
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822185; cv=none; b=oCfVkj8MrES9zXjQ9lDPlmbbrN8tEmI4fO8Cgq2w6ms2wrdSZcyMtv4RCOx6GpJkRQxVELdEEO68wQiROBLSse149YngKY290q4lIUp9m2QEJSb3D3wQyN+x6SF3neQrOy4kj1IwI3kdg87RUx78jW6Dr//mRtoTfvcXq1jTiTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822185; c=relaxed/simple;
	bh=gZZW7tC/cpV4nKL1Hx4riTsfSqR9HnF1ZneuFND9oco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cedqYEVRvGQ0cyN2KgFuq3Fto7zP+n5Q8EE5IruZIYO6e17I81Y90DEn77XbwdYTIcJolFOGqT2k8h04fjj5b/5wEJnjGTQKL33LXbD45xN0vmbd0tZ0jzRewEhW3rsXGZLTlQZsIPx4lgUGOVLHa9Xuw3jnFvHaMbiHbP/r8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JlBM26su; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kjgxIqum; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JlBM26su; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kjgxIqum; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 865802090F;
	Wed, 21 May 2025 10:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=JlBM26suErECduo/NiesDgfnWAETytXGdEvIVlC34VVSfaasE9XErF9hZySxdjhmeZMho8
	w+sNbicoJ/pi3vVy46H+sXvz4T1FjE3f5YOyU921SqqBe8fFMX3s1FikWXjNKfWvRDYTQX
	9qFJ3Q/YffthB8SI7bPujl8CAVm5Djk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=kjgxIqumnz+LccUy5yZYNn5hO2wYwCeOQAk2mwbZWehT03u8MaLgCASxuhhZwzumzc6Hj0
	hBDzGeYTmmfxVJCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=JlBM26suErECduo/NiesDgfnWAETytXGdEvIVlC34VVSfaasE9XErF9hZySxdjhmeZMho8
	w+sNbicoJ/pi3vVy46H+sXvz4T1FjE3f5YOyU921SqqBe8fFMX3s1FikWXjNKfWvRDYTQX
	9qFJ3Q/YffthB8SI7bPujl8CAVm5Djk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ae4dGNDLprnJrk+XcRux67LTnsmy+MgMY5bukERjtzk=;
	b=kjgxIqumnz+LccUy5yZYNn5hO2wYwCeOQAk2mwbZWehT03u8MaLgCASxuhhZwzumzc6Hj0
	hBDzGeYTmmfxVJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5388413888;
	Wed, 21 May 2025 10:09:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HY1XE2WmLWgoSwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:09:41 +0000
Message-ID: <2f9aef5f-91c5-4501-ae83-0efcf2a79f2f@suse.de>
Date: Wed, 21 May 2025 12:09:40 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] net: introduce CONFIG_NET_CRC32C
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-2-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-2-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a hidden kconfig symbol NET_CRC32C that will group together the
> functions that calculate CRC32C checksums of packets, so that these
> don't have to be built into NET-enabled kernels that don't need them.
> 
> Make skb_crc32c_csum_help() (which is called only when IP_SCTP is
> enabled) conditional on this symbol, and make IP_SCTP select it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   net/Kconfig      | 4 ++++
>   net/core/dev.c   | 2 ++
>   net/sctp/Kconfig | 1 +
>   3 files changed, 7 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

