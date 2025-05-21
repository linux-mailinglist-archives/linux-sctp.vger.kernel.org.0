Return-Path: <linux-sctp+bounces-549-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6772BABF10F
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AAA74E4B5F
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C39325A64D;
	Wed, 21 May 2025 10:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ki5JcNjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b05e8/3H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ki5JcNjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b05e8/3H"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C5B25A626
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822325; cv=none; b=sLH84ZxzIvrrA/OsxZb+sxOtbRDplf/6X+WlakAqKPP+So9RNGiADPaQ/dwrVj4fxnO97Y4oPmjyOveNYXCobC8alvb72nUVQoch9QsdD6ef+kAkOD5Pymb+8kKg+K87Sloec20zl2iYV3WnH9shMvXMX6H3N0DnYmAzitotphQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822325; c=relaxed/simple;
	bh=GptCyVy0FbNxysu9UCMw34L7HgW1wGzabHVnDOLUIMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPqb8XvbtPn0dFGS+ayPwUTM4mQp5FlR3FaDM/PNgWS25rZGpdxOOPAxX18DMJ1oaHLo7MQNifs+MR33oG3LlvZIBP6ixFSqbwZUvlUCXZSc672bNoFisvo8ikmeOTjACPIY2I6nW0iai8dsYGizLcNMM7irkYXKWGbQ4oigrxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ki5JcNjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b05e8/3H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ki5JcNjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b05e8/3H; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 200AF20919;
	Wed, 21 May 2025 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ9g9jSX1fohEBDn5gmLEUU9DPbZojP3+i2DcalaxVg=;
	b=Ki5JcNjf8lw7z/M3fEoSaM5Coi454jvrhsYdKiS52udHh5EEstopNT2KMhWMBrn7vHxBN0
	OQczQQADwVSiBS7zmX0mEv5fh6AM/yYlBb6hRY/4HwozeXJFlVMwxjQaW1QoepT6cEn8pH
	2WRr/bvYzP2U802olUrwvEe4wINY1yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ9g9jSX1fohEBDn5gmLEUU9DPbZojP3+i2DcalaxVg=;
	b=b05e8/3HUhE9vX2prCH4KKs3mAduKDuQqpJTL16+h7eaZYBepTCRFYSe+h15KhzInYc9RB
	/ncFm7NpsFBVi8Bw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ki5JcNjf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="b05e8/3H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ9g9jSX1fohEBDn5gmLEUU9DPbZojP3+i2DcalaxVg=;
	b=Ki5JcNjf8lw7z/M3fEoSaM5Coi454jvrhsYdKiS52udHh5EEstopNT2KMhWMBrn7vHxBN0
	OQczQQADwVSiBS7zmX0mEv5fh6AM/yYlBb6hRY/4HwozeXJFlVMwxjQaW1QoepT6cEn8pH
	2WRr/bvYzP2U802olUrwvEe4wINY1yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aJ9g9jSX1fohEBDn5gmLEUU9DPbZojP3+i2DcalaxVg=;
	b=b05e8/3HUhE9vX2prCH4KKs3mAduKDuQqpJTL16+h7eaZYBepTCRFYSe+h15KhzInYc9RB
	/ncFm7NpsFBVi8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E016F13AA0;
	Wed, 21 May 2025 10:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NUZQNfCmLWjPSwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:12:00 +0000
Message-ID: <56c630a7-a88b-4c75-b572-939f8597214e@suse.de>
Date: Wed, 21 May 2025 12:12:00 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] net: add skb_crc32c()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-3-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-3-ebiggers@kernel.org>
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
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
X-Rspamd-Queue-Id: 200AF20919
X-Spam-Level: 
X-Spam-Flag: NO

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add skb_crc32c(), which calculates the CRC32C of a sk_buff.  It will
> replace __skb_checksum(), which unnecessarily supports arbitrary
> checksums.  Compared to __skb_checksum(), skb_crc32c():
> 
>     - Uses the correct type for CRC32C values (u32, not __wsum).
> 
>     - Does not require the caller to provide a skb_checksum_ops struct.
> 
>     - Is faster because it does not use indirect calls and does not use
>       the very slow crc32c_combine().
> 
> According to commit 2817a336d4d5 ("net: skb_checksum: allow custom
> update/combine for walking skb") which added __skb_checksum(), the
> original motivation for the abstraction layer was to avoid code
> duplication for CRC32C and other checksums in the future.  However:
> 
>     - No additional checksums showed up after CRC32C.  __skb_checksum()
>       is only used with the "regular" net checksum and CRC32C.
> 
>     - Indirect calls are expensive.  Commit 2544af0344ba ("net: avoid
>       indirect calls in L4 checksum calculation") worked around this
>       using the INDIRECT_CALL_1 macro. But that only avoided the indirect
>       call for the net checksum, and at the cost of an extra branch.
> 
>     - The checksums use different types (__wsum and u32), causing casts
>       to be needed.
> 
>     - It made the checksums of fragments be combined (rather than
>       chained) for both checksums, despite this being highly
>       counterproductive for CRC32C due to how slow crc32c_combine() is.
>       This can clearly be seen in commit 4c2f24549644 ("sctp: linearize
>       early if it's not GSO") which tried to work around this performance
>       bug.  With a dedicated function for each checksum, we can instead
>       just use the proper strategy for each checksum.
> 
> As shown by the following tables, the new function skb_crc32c() is
> faster than __skb_checksum(), with the improvement varying greatly from
> 5% to 2500% depending on the case.  The largest improvements come from
> fragmented packets, mainly due to eliminating the inefficient
> crc32c_combine().  But linear packets are improved too, especially
> shorter ones, mainly due to eliminating indirect calls.  These
> benchmarks were done on AMD Zen 5.  On that CPU, Linux uses IBRS instead
> of retpoline; an even greater improvement might be seen with retpoline:
> 
>      Linear sk_buffs
> 
>          Length in bytes    __skb_checksum cycles    skb_crc32c cycles
>          ===============    =====================    =================
>                       64                       43                   18
>                      256                       94                   77
>                     1420                      204                  161
>                    16384                     1735                 1642
> 
>      Nonlinear sk_buffs (even split between head and one fragment)
> 
>          Length in bytes    __skb_checksum cycles    skb_crc32c cycles
>          ===============    =====================    =================
>                       64                      579                   22
>                      256                      829                   77
>                     1420                     1506                  194
>                    16384                     4365                 1682
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/linux/skbuff.h |  1 +
>   net/core/skbuff.c      | 73 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 74 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

