Return-Path: <linux-sctp+bounces-556-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AABCEABF14C
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2414D7B4C88
	for <lists+linux-sctp@lfdr.de>; Wed, 21 May 2025 10:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB7125A659;
	Wed, 21 May 2025 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BPRI0ioi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I5wFhC9L";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BPRI0ioi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I5wFhC9L"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ECE238C36
	for <linux-sctp@vger.kernel.org>; Wed, 21 May 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822658; cv=none; b=TtfqfVGPMEWyqml21X8z7CWvm24vXQtxbR6LiGgqm/17CixKbF9tDfRMaStCT0Wmgxr0DMZFDCysrgiJbcFvZ5r/Yq5pKrK/IFzB/5dVxSdgxN2MmvnETmFznkhQqMq3iXwxjIf79fKP2FmnicsbnKvABRufXTVIwj/ASVTwsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822658; c=relaxed/simple;
	bh=HjayfiwY3T+/icSmrdHfK/8qh4ex2Q8JeaEL6bhFayo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LNNujgdcu53r+MsmjzAoP/ap4RcXkTTtqU971jMGny0hdWO/5Sr1LIHQ/DIz40ug6VnWj8Ddzuz7DAtZSqy0tGFhU2hjfqNf3C0OykOB5DbgVadE38kqyi/6PXH9SJK3injeFq5Yp4MugzSWAHmZ/mnax07mGlJC9y1aaebscI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BPRI0ioi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I5wFhC9L; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BPRI0ioi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I5wFhC9L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BED3922436;
	Wed, 21 May 2025 10:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=BPRI0ioiEdjk3AcbDRMMrlXUroHEzhI8OJ3d73iha6czXodvKCp3UR/9haCrHiSYx02pUD
	/644klZxV5wu+4+0rM5tQ+hjBCSC+3KnfbDjrDCysdmjxLrhymDsWFqy2DBzWeGiyK85Z8
	ACBq6oArABQEDpJpzpZ/7uYSPYSAp68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=I5wFhC9LXjmpHUiM0WD+/40yRVsi5v2LS6YlY8690tt6dMM/N/2rZ6VMB/CgZjRO+oout0
	c5nNOqxv7DPMejBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747822654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=BPRI0ioiEdjk3AcbDRMMrlXUroHEzhI8OJ3d73iha6czXodvKCp3UR/9haCrHiSYx02pUD
	/644klZxV5wu+4+0rM5tQ+hjBCSC+3KnfbDjrDCysdmjxLrhymDsWFqy2DBzWeGiyK85Z8
	ACBq6oArABQEDpJpzpZ/7uYSPYSAp68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747822654;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcxd8g5b5LVlH9ETZbXkzCfIBrcRd911KmW5mOi+rYQ=;
	b=I5wFhC9LXjmpHUiM0WD+/40yRVsi5v2LS6YlY8690tt6dMM/N/2rZ6VMB/CgZjRO+oout0
	c5nNOqxv7DPMejBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7206813AA0;
	Wed, 21 May 2025 10:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cinuFT6oLWh2TQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 21 May 2025 10:17:34 +0000
Message-ID: <f3731222-9666-4813-aac9-050f8b40844d@suse.de>
Date: Wed, 21 May 2025 12:17:25 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] nvme-tcp: use crc32c() and
 skb_copy_and_crc32c_datagram_iter()
To: Eric Biggers <ebiggers@kernel.org>, netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, linux-sctp@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20250519175012.36581-1-ebiggers@kernel.org>
 <20250519175012.36581-10-ebiggers@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250519175012.36581-10-ebiggers@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,iogearbox.net,gmail.com,grimberg.me,kernel.org,lst.de];
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
> Now that the crc32c() library function directly takes advantage of
> architecture-specific optimizations and there also now exists a function
> skb_copy_and_crc32c_datagram_iter(), it is unnecessary to go through the
> crypto_ahash API.  Just use those functions.  This is much simpler, and
> it also improves performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>   drivers/nvme/host/Kconfig |   4 +-
>   drivers/nvme/host/tcp.c   | 124 ++++++++++++--------------------------
>   2 files changed, 42 insertions(+), 86 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

