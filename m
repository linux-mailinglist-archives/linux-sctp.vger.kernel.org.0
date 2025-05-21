Return-Path: <linux-sctp+bounces-552-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAB1ABF127
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123254E51D9
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F344C25C707;
	Wed, 21 May 2025 10:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zO5kmzAA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KO5Gk4LY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zO5kmzAA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KO5Gk4LY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E0225A626
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822458; cv=none; b=bW3VjhOqAkhcEfY7k96rKRbqjvu41xXuk7vetrs4lfqd7p1Bi6e9aLaX7lRgwkLf1CmkScg0kJmlncvtMlLD13VON4gruJ8W2d1YKS2o2L3XzOsRxZQmS/OKzvh3P9Mk1JCY7ibgvY9/oHEEOtCw90CnnYBozjfFVaarbmmByXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822458; c=relaxed/simple;
	bh=QSYzhxKHNiRVf7MWkU8qPPMNn3E4qW2hVkRu+GbDBLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sh/BZ29ukKduI+8IOLn6RaPLqR5AvvtC9SqC4TarTe5cDY+mJZ5eq3nKDgaamqo1HTcTyb/fYaF09SkTfM1QGXyrxRzUd0hEUmN9yedreUCauRg6CFmjh1MCZ15M3bglGRZc4HhTmbttGyM+jnD23Qm0h8hbQGPFDdlMbxT59AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zO5kmzAA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KO5Gk4LY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zO5kmzAA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KO5Gk4LY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D6BC337CA;
	Wed, 21 May 2025 10:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=zO5kmzAA4npNdFOn8h1xlOap/xBbEQ7usSNhVspHr6k3aQyGWUkFOpqpCUNJVuhsiWitq5
	16V0ixnjTN+zoQY8ldyGhFZi6nxZmqCG4Tw4V9OHlvdtsC+Hac2iaTzPm6SrHE9BhPTBfV
	jZq95B7+gl7FfkecEpGzLIa6RUdbgUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=KO5Gk4LYCOziRirBR3yFIo1o6QJMsBbOGS29WJMlwbwXAJvF4epiDX1bpk9agR9a85Cz4t
	DawXOTzObN20bHAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=zO5kmzAA4npNdFOn8h1xlOap/xBbEQ7usSNhVspHr6k3aQyGWUkFOpqpCUNJVuhsiWitq5
	16V0ixnjTN+zoQY8ldyGhFZi6nxZmqCG4Tw4V9OHlvdtsC+Hac2iaTzPm6SrHE9BhPTBfV
	jZq95B7+gl7FfkecEpGzLIa6RUdbgUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PrZkWoI3Zcmg+KJUSVPn4YmbY051hcyvk4GeLO925c=;
	b=KO5Gk4LYCOziRirBR3yFIo1o6QJMsBbOGS29WJMlwbwXAJvF4epiDX1bpk9agR9a85Cz4t
	DawXOTzObN20bHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B09F13AA0;
	Wed, 21 May 2025 10:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id igNZFXanLWh8TAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:14:14 +0000
Message-ID: <faacdc3b-260a-46b5-b244-ff1575d5e6ef@suse.de>
Date: Wed, 21 May 2025 12:14:06 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] sctp: use skb_crc32c() instead of
 __skb_checksum()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-6-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-6-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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
> Make sctp_compute_cksum() just use the new function skb_crc32c(),
> instead of calling __skb_checksum() with a skb_checksum_ops struct that
> does CRC32C.  This is faster and simpler.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/net/sctp/checksum.h | 29 +++--------------------------
>   net/netfilter/Kconfig       |  4 ++--
>   net/netfilter/ipvs/Kconfig  |  2 +-
>   net/openvswitch/Kconfig     |  2 +-
>   net/sched/Kconfig           |  2 +-
>   net/sctp/Kconfig            |  1 -
>   net/sctp/offload.c          |  1 -
>   7 files changed, 8 insertions(+), 33 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

