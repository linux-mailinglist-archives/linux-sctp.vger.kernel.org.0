Return-Path: <linux-sctp+bounces-550-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1CABF116
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314093ABE34
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B70225A626;
	Wed, 21 May 2025 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cmi+n+YB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vrAuruo2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cmi+n+YB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vrAuruo2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D1253F3A
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822388; cv=none; b=l/29YTHLP5vbp8L0XpD3VK4gORH+F1bINH59/UsejPB/SLrsWrq143w2WpLAAjuzA7H+de1eFknf5WNTEcpzsC/MvY8y2vGa2nuCgLu8T1z1CFZMdbmOQ6mgALfMlwLMT+Lkz4Qz5az4Wtf3jCor6lCoQnBktc+/AGwyW/GRXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822388; c=relaxed/simple;
	bh=RByzAZMOLQNZEFtHbsKpgp1amQTVNJDbBgHinyMlwSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VCYHER1GftwPeADk3Re5Dz2HaLpE82K3pde3cqrdSPnkkVuFhUEsnH5V36VM1ioa9lvd1UEiH9lyvaOVxjvQsyFTDbM9JrygxojtgRuXbPw0EctuV9a/HC5cxGD3axLQpGkSNJa5IuNQP5k+wqJWCobQn6NWtIXOKSqnxHS5SJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cmi+n+YB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vrAuruo2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cmi+n+YB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vrAuruo2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2709F20922;
	Wed, 21 May 2025 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=Cmi+n+YBZA+ZZOwbg22YbtkbpAvJkjXoXQGRfTxHu6cMDhQ/X3gEGiRavHs4gQe7ZwxxmF
	K9Y2u5jD3UXRzNIXLDOpfHXO+IsXVd08vs8ywrRrxBWfsPokerRmW4LcU67NLbDLiyyJcQ
	tsNG/z5NZGZMyWssyz8GnZK5iTvKyYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=vrAuruo2cIf9bjUYr46d33GAeCYFFd+6NfNcwBLii7Ci+VFyxwAZaYa9vEnCzQu4Ka9Sog
	vWxtJFA3aLdqu2Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=Cmi+n+YBZA+ZZOwbg22YbtkbpAvJkjXoXQGRfTxHu6cMDhQ/X3gEGiRavHs4gQe7ZwxxmF
	K9Y2u5jD3UXRzNIXLDOpfHXO+IsXVd08vs8ywrRrxBWfsPokerRmW4LcU67NLbDLiyyJcQ
	tsNG/z5NZGZMyWssyz8GnZK5iTvKyYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLYsdgB3uf5e5BJCk5J+2wDtYUN+97pTdoUS/ZfGn7c=;
	b=vrAuruo2cIf9bjUYr46d33GAeCYFFd+6NfNcwBLii7Ci+VFyxwAZaYa9vEnCzQu4Ka9Sog
	vWxtJFA3aLdqu2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E835C13AA0;
	Wed, 21 May 2025 10:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fJLFNzCnLWguTAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:13:04 +0000
Message-ID: <c5807d92-3820-4d82-8937-06cd2ecd3d1d@suse.de>
Date: Wed, 21 May 2025 12:13:04 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] net: use skb_crc32c() in skb_crc32c_csum_help()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-4-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-4-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Instead of calling __skb_checksum() with a skb_checksum_ops struct that
> does CRC32C, just call the new function skb_crc32c().  This is faster
> and simpler.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   net/core/dev.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

