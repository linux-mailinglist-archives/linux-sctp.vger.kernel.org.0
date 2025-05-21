Return-Path: <linux-sctp+bounces-554-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABDAABF131
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A584E545A
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F662192E3;
	Wed, 21 May 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V1sI/aGv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wEruPZB/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z720WXok";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WU1UFD43"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5591A9B4C
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822534; cv=none; b=FX7x7xcHZtbgosJAvXhHXFxlrcOGfFTaVgpF11VJjLXvX5ZdTJ2t//WvEEcTpizAuQqgdMBa1GDP2XSx5RK4nyYvEEmSYz9S8jc6YCBPZCi4X3kYC/PSJddnEsYxL8DL+JOOaljbWq0+DH77CArcvwuiB0Df/g6t5/3E/zM/xQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822534; c=relaxed/simple;
	bh=7VWBwnJB42oFEs0jILgSLBIhI5XSf9/Ya23n6GOLo1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lxo7xZ2hBnv2MH++lSvvMkCyqPmSfX4ovdjRoQk59pnLwgmycVL59PtBMCUZPz2N/LzDIBU7iD2GCjLgSYHx5JQFCMoVznRWEErLNhFiLwzfQXB23JmXd+eTFry53cwyjICcIbKTTO9VfbZye+SdcGuH1FU/O4SmK9atfhjXLgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V1sI/aGv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEruPZB/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z720WXok; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WU1UFD43; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA5FE22683;
	Wed, 21 May 2025 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJTkULtf9UqfX8az0n+gCs96zFx7/STVs41naO7OIe8=;
	b=V1sI/aGvUPo1HIn80ZMKIClyVJWkbobLfqFrf3t2OrovFInqhbOXr0eFXRLdrDRXLtYFo2
	o/9kYxVnQeMLDs0K6pWx7P1ezSEgXONcKza474lUIlMlZEFF8AHtEiXXWvAHnRRR7VKWMi
	/t7VulTTVd63v58NtsYkOIBJ1gJAiLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822531;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJTkULtf9UqfX8az0n+gCs96zFx7/STVs41naO7OIe8=;
	b=wEruPZB//g7CAbiGQLXfynku7QZFqSY01/z7EcYnQLurJcDLuCdz26Jm/+ZmXQ3EFYCFDx
	ZDs0XwLcTzMrIKAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=z720WXok;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WU1UFD43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJTkULtf9UqfX8az0n+gCs96zFx7/STVs41naO7OIe8=;
	b=z720WXoksmPtG5xasEzDG6XoMWvL+9vWPY6YRO8lmEsVRR1jQDt1emL7gEIDlnkyRDLmBk
	56+ncXmvM4HSPqK1/EUx1SYLZG8BLeBv3OxDU6VoRqXH6Bao5FULlyS45kEoDSl+8ifg7k
	QaHZk3IVWilOGOGribLci6YdWqRenM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJTkULtf9UqfX8az0n+gCs96zFx7/STVs41naO7OIe8=;
	b=WU1UFD43mBvCvS0s5WseoFTadVOW+Ztjd7WJx8LpNS7HOpHN3epGIiO5ZW9R6EJJImDyes
	hCRu9l1taKh0qMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A42F513AA0;
	Wed, 21 May 2025 10:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZGCnJsKnLWjqTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:15:30 +0000
Message-ID: <95c26a3d-edeb-4def-9068-b05e90157ef1@suse.de>
Date: Wed, 21 May 2025 12:15:22 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] lib/crc32: remove unused support for CRC32C
 combination
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-8-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-8-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: DA5FE22683
X-Spam-Level: 
X-Spam-Flag: NO

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> crc32c_combine() and crc32c_shift() are no longer used (except by the
> KUnit test that tests them), and their current implementation is very
> slow.  Remove them.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/linux/crc32.h | 23 -----------------------
>   lib/crc32.c           |  6 ------
>   lib/tests/crc_kunit.c |  6 ------
>   3 files changed, 35 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

