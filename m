Return-Path: <linux-sctp+bounces-555-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6905ABF137
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693154E54E9
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CECD25A2C7;
	Wed, 21 May 2025 10:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DuyGOlx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xt+H1xQ5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DuyGOlx2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xt+H1xQ5"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF231A9B4C
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822572; cv=none; b=CxE8NLGLfPXa8GTt+b4lJ1HTVmJQi/vWp4xqElYn4/Vgne/2pdLNzvJglaHaXqCVEuPNM4Z0uQ2Uz863QwsL7x01QTGdmb1Yj91Pt+wdAV/TY2Q0dPwdC4NUv2k2XiSx3sOTzXsWccFJsM2t4fLi9WuXk4fu9mW6Pd89rj8OlUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822572; c=relaxed/simple;
	bh=3b8x3qpRfc/t8SlTRxfHyG4tgUvZSAQijQP6CnDfyLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk4qqy7VGCdM4F0J8hQ9GS47TqQm0jk11nrPjsNuqPYlwFJlnWXjzTDY8qACLraVuP4WmFSx+ZEZoRZPdp2MI2M63aPUuYncQHKTR1vFJu491HTqUwO071x5CEZ7dy+O3M9pp3RwHhtlJj+sY1tIiBwUCVClTLz8N0tviMg5Xbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DuyGOlx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xt+H1xQ5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DuyGOlx2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xt+H1xQ5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90DE72091C;
	Wed, 21 May 2025 10:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wcWmyR1AiMJaEQNt1hassbelqkqhpDNye6S7Ijp6c0=;
	b=DuyGOlx2c07z/3wBv1JQ4Km5lBN+/y1kHUkGS+UABocULt0LXt5bmwpe4+TNFWbY8nvMIS
	e1QAbyf9A/bkTnNQjEkaf0TzRNWCyAUVQNF3lUT47j3iZHEqsniheykQ1KjDlS+sPrUsqS
	akGnG877yzSc8XAcfrGYGyZjfdPDIdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wcWmyR1AiMJaEQNt1hassbelqkqhpDNye6S7Ijp6c0=;
	b=Xt+H1xQ5fZydl8MuyHAtU9Y1WCTXF64cMf8rOFlmXP/ZwUa5avTJTbK16/cyucctyDfnj0
	pzvesSnHvplgO4Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DuyGOlx2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xt+H1xQ5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wcWmyR1AiMJaEQNt1hassbelqkqhpDNye6S7Ijp6c0=;
	b=DuyGOlx2c07z/3wBv1JQ4Km5lBN+/y1kHUkGS+UABocULt0LXt5bmwpe4+TNFWbY8nvMIS
	e1QAbyf9A/bkTnNQjEkaf0TzRNWCyAUVQNF3lUT47j3iZHEqsniheykQ1KjDlS+sPrUsqS
	akGnG877yzSc8XAcfrGYGyZjfdPDIdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wcWmyR1AiMJaEQNt1hassbelqkqhpDNye6S7Ijp6c0=;
	b=Xt+H1xQ5fZydl8MuyHAtU9Y1WCTXF64cMf8rOFlmXP/ZwUa5avTJTbK16/cyucctyDfnj0
	pzvesSnHvplgO4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 67D2513AA0;
	Wed, 21 May 2025 10:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xqurGOinLWghTQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:16:08 +0000
Message-ID: <85bdd00e-832f-47de-9822-6c8ae090701d@suse.de>
Date: Wed, 21 May 2025 12:16:08 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] net: add skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-9-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-9-ebiggers@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 90DE72091C
X-Spam-Level: 
X-Spam-Flag: NO

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since skb_copy_and_hash_datagram_iter() is used only with CRC32C, the
> crypto_ahash abstraction provides no value.  Add
> skb_copy_and_crc32c_datagram_iter() which just calls crc32c() directly.
> 
> This is faster and simpler.  It also doesn't have the weird dependency
> issue where skb_copy_and_hash_datagram_iter() depends on
> CONFIG_CRYPTO_HASH=y without that being expressed explicitly in the
> kconfig (presumably because it was too heavyweight for NET to select).
> The new function is conditional on the hidden boolean symbol NET_CRC32C,
> which selects CRC32.  So it gets compiled only when something that
> actually needs CRC32C packet checksums is enabled, it has no implicit
> dependency, and it doesn't depend on the heavyweight crypto layer.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/linux/skbuff.h |  2 ++
>   net/core/datagram.c    | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 35 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

