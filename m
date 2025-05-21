Return-Path: <linux-sctp+bounces-553-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8F0ABF12C
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDE11BA8362
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D170A25B69A;
	Wed, 21 May 2025 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QLRiqsff";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Tcs6OFN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UcOSS4V/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wvag8WbD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F8F25A64D
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822492; cv=none; b=udl6Qwsg2Pt0F9hltHwaykRNHhtrZWd5LVl603B3vdUWtkJaXHVc8beJ/Ne1/KTH6Rz1vwodfrRofVTcL9/wlirzj/k8mMQPNfAzOgb2ae0y/R5MQy7GDBCB+p++YaO+MYpdWo9sWMiDtGUuBQfVd2O5Pw+SltzDVVJWxXR+jV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822492; c=relaxed/simple;
	bh=q1hjdgEO6DoBqSlAA5Wybk0eimeQHVfJXZnujDsW5tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APScqSoMfwukF+bNwehgMxHuAY/PrgG+TIqcra6Q7tusA/g8lqZrKdiGmlk+0G37vY2Q0ibSRbYgsRXHWk+GZ9+bEtkW3wPw490xon/tbWFBWt40GUn0BhRPht13GtdI6rSqSBD0gDhl7co5nqbOaBEARjCVjF86zg4wb5akTCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QLRiqsff; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Tcs6OFN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UcOSS4V/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wvag8WbD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E15102091C;
	Wed, 21 May 2025 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=QLRiqsff1PXVC4ebs47iVDAj9bjOQIt1c0CnHRTEMseXBG+fkje2ZRSMjdqD+YSs5jOsCl
	o4jQrtV7w8jgoqwXj40WdbJ44PHdjOWpQcW1sKLDBqkTTL0nubcMWysCziZcQGpZED8fcK
	FTcNoCJUocsQIO58pNf84ixZcjfcRd8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=7Tcs6OFNkrhdUZr5DXGs+h4wuBJXJS/duVQn3F403sruvpVYIiH3maFj8l7hdvg1LHXH9e
	azFddiKUWVlLDLDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=UcOSS4V/CIYcsAFikTmh8Lnd+u2+Rz4F5QpXvq2Q/uUzZ2MAXdoUhzLrTkf1i0JlacDit7
	4pe8TJf6gRdKS2K5WtGX3NkA7DGbR2t8hPH7/56y3SSsAIt0ZTZ0iZEUv6kqNc79FbVhFA
	9UPOvmBE7ojbVx8BF3/AWxVhyErPcCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L36lwljlqMD0aYeNn5rHtteD0CmLa5fppTcwExjJASI=;
	b=Wvag8WbDuD/UYUAsBDOpPwvRjKhLe1BQsFtT5zquE0FcLHyrLIQGXR5CxcNfPOInIyeGkG
	cb+Th4UTTIjwvVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8BCD13AA0;
	Wed, 21 May 2025 10:14:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kKxWLJenLWiqTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:14:47 +0000
Message-ID: <c46209ce-3e28-4a18-83c2-3ff6d442cf8d@suse.de>
Date: Wed, 21 May 2025 12:14:47 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] net: fold __skb_checksum() into skb_checksum()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-7-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-7-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the only remaining caller of __skb_checksum() is
> skb_checksum(), fold __skb_checksum() into skb_checksum().  This makes
> struct skb_checksum_ops unnecessary, so remove that too and simply do
> the "regular" net checksum.  It also makes the wrapper functions
> csum_partial_ext() and csum_block_add_ext() unnecessary, so remove those
> too and just use the underlying functions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/linux/skbuff.h |  9 -------
>   include/net/checksum.h | 12 ---------
>   net/core/skbuff.c      | 59 +++++-------------------------------------
>   3 files changed, 7 insertions(+), 73 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

