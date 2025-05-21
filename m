Return-Path: <linux-sctp+bounces-551-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 731BAABF122
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79BBF1BA824C
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BD225C6FC;
	Wed, 21 May 2025 10:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E52q4LhC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xwl2jjOW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E52q4LhC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xwl2jjOW"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A6F25A626
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822422; cv=none; b=piUfOjwLOP4XImdgk9mp5869OAEimaLhAjNlfKAaalRGKmMKMtKQXNygvn1Gq8QJ4VqHEvuCpwqNQq+cvD9/6UYpHWPuOXB7uNG4lBWv3YK2lio7C0JEn0TlPOqtXuB6lHVbL1C4Az9R3e2ujzOJ6vnbgAsk2Do+v28aqj7cJQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822422; c=relaxed/simple;
	bh=zfFN4ECNlCYKkIquH4Y5nOyeNL665gFfqu1kr6cvrG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcBjgxjnPt3SngoykzRG6NyxYGDjEx6E/IQD+anUII/I2w4uBGdOQ158YHG7Ir9V81uTU5KthB9V4+MW7lDM3dT/ZUZ/2FDZqPvl5HnFwCEyvuzMRBpOPvOERuXhEeUws/BQRTpCGzSy87mzcb9dPOPr17kie4/xJZD0RHGcGpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E52q4LhC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xwl2jjOW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E52q4LhC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xwl2jjOW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A95862091D;
	Wed, 21 May 2025 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UloAwARssezWLmeNvNMbUHgYHdiImBQLlIU1qh9y2l0=;
	b=E52q4LhCDvgX8Nyly4cDRD7gcKaHQ1Gd+kTpDc+gltp9G6q6pGW3K5WrswaE5rJZg3h5H3
	bmf4dvfcazhUu9YiOItaHhizJc1HVtpsb5TX/Yj7f43YeN2ztpxsiGB9VeRMt167/oIuyF
	kCXgFKNTfaTbjgxLPvLIvGIn4iJA0po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UloAwARssezWLmeNvNMbUHgYHdiImBQLlIU1qh9y2l0=;
	b=xwl2jjOW3azlDQVpg6Ut2TMCvQb7uzQJq2rCRWlKn8o44VzdmnIW6T5djguz/FAACgYC/6
	teeHIa2XvtaxPjCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E52q4LhC;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xwl2jjOW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UloAwARssezWLmeNvNMbUHgYHdiImBQLlIU1qh9y2l0=;
	b=E52q4LhCDvgX8Nyly4cDRD7gcKaHQ1Gd+kTpDc+gltp9G6q6pGW3K5WrswaE5rJZg3h5H3
	bmf4dvfcazhUu9YiOItaHhizJc1HVtpsb5TX/Yj7f43YeN2ztpxsiGB9VeRMt167/oIuyF
	kCXgFKNTfaTbjgxLPvLIvGIn4iJA0po=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UloAwARssezWLmeNvNMbUHgYHdiImBQLlIU1qh9y2l0=;
	b=xwl2jjOW3azlDQVpg6Ut2TMCvQb7uzQJq2rCRWlKn8o44VzdmnIW6T5djguz/FAACgYC/6
	teeHIa2XvtaxPjCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 769C513AA0;
	Wed, 21 May 2025 10:13:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FwSFF1GnLWhWTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:13:37 +0000
Message-ID: <361bad5d-b6bc-4d11-b454-16885256f248@suse.de>
Date: Wed, 21 May 2025 12:13:33 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>,
 Bernard Metzler <bmt@zurich.ibm.com>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-5-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-5-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A95862091D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org,zurich.ibm.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Instead of calling __skb_checksum() with a skb_checksum_ops struct that
> does CRC32C, just call the new function skb_crc32c().  This is faster
> and simpler.
> 
> Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   drivers/infiniband/sw/siw/Kconfig |  1 +
>   drivers/infiniband/sw/siw/siw.h   | 22 +---------------------
>   2 files changed, 2 insertions(+), 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

