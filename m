Return-Path: <linux-sctp+bounces-557-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B67ABF14F
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA784E453A
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EB425B661;
	Wed, 21 May 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kiYmIz4j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cTvx893E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kiYmIz4j";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cTvx893E"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235342472B4
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822677; cv=none; b=GQm10Z6WuYYYDkhJoPHG3aCMfnjMhQumGmUNy4D4TQ2oNXwBTk8MxSNqzhEFhHwJ8Jtn+4NwWZoH5mt7ujlsfqO5szzS0I9/2597RaqmojyGYYJtB58SdM1D8lYAQ+kB3IdHxN1NBDBK6K9+IF55UaUDcOZ7D7WKai0NF6n/UFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822677; c=relaxed/simple;
	bh=QcsTdbjN4xGn7DZjRxTqSlCgHU7YI8pF19UDJz1DSzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O4HY/WruC4NUj10vb9Zk+6iyG5kbGvnACQzp3nvQPi6xNeNbGnckM/PAUoEmSiKZ0bVmY0h1D3qNgMeVdGAXJEPhfTJ2LrzWkEQxiZnRqqdgUwqMT2E5p705II0NujwAWDhf+5DLryL5g4MbLEd15/g3d5aLo1j1bJCLgFH+VYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kiYmIz4j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cTvx893E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kiYmIz4j; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cTvx893E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77D08229A6;
	Wed, 21 May 2025 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB9ufzomD7OPRNP5XuFnaHueioW0xDGgM7Luo4DEPYU=;
	b=kiYmIz4jpZRRYrQtHewbBidduyuyrgBKAtmvOuCsYB//AeZIK0TMzPEDHnDYXjkBIgB5+W
	5tGHw/8CFTrI04n+ofoND9Un1OZjxA7BkSN2s7n5B7FR8C3YmgKmWDSCjiq394Zng4kudl
	z2WPleE6n4/lVp4tsoLqm3s9Wj6aQ3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB9ufzomD7OPRNP5XuFnaHueioW0xDGgM7Luo4DEPYU=;
	b=cTvx893Eu/KxepfdcOwkNxo9+SsW6UP290z1Gkpg5wPUEg8qtVYo+OzqtbMpP5KmXabk7P
	SVQ6uVyhveEz63Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB9ufzomD7OPRNP5XuFnaHueioW0xDGgM7Luo4DEPYU=;
	b=kiYmIz4jpZRRYrQtHewbBidduyuyrgBKAtmvOuCsYB//AeZIK0TMzPEDHnDYXjkBIgB5+W
	5tGHw/8CFTrI04n+ofoND9Un1OZjxA7BkSN2s7n5B7FR8C3YmgKmWDSCjiq394Zng4kudl
	z2WPleE6n4/lVp4tsoLqm3s9Wj6aQ3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB9ufzomD7OPRNP5XuFnaHueioW0xDGgM7Luo4DEPYU=;
	b=cTvx893Eu/KxepfdcOwkNxo9+SsW6UP290z1Gkpg5wPUEg8qtVYo+OzqtbMpP5KmXabk7P
	SVQ6uVyhveEz63Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E49E13AA0;
	Wed, 21 May 2025 10:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GPJJClKoLWibTQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:17:54 +0000
Message-ID: <0f9de3d1-89f4-4629-a858-5d9ab7c781b2@suse.de>
Date: Wed, 21 May 2025 12:17:53 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] net: remove skb_copy_and_hash_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-11-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-11-ebiggers@kernel.org>
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
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]

On 5/19/25 19:50, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that skb_copy_and_hash_datagram_iter() is no longer used, remove it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   include/linux/skbuff.h |  4 ----
>   net/core/datagram.c    | 37 -------------------------------------
>   2 files changed, 41 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

