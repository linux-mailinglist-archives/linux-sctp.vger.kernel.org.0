Return-Path: <linux-sctp+bounces-1340-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0metGXjXVWrHuAAAu9opvQ
	(envelope-from <linux-sctp+bounces-1340-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 08:30:16 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E895D7517CA
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 08:30:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pm6mbu65;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1340-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1340-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 149C93034B01
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Jul 2026 06:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853663DB325;
	Tue, 14 Jul 2026 06:29:18 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EAD3E2AD7
	for <linux-sctp@vger.kernel.org>; Tue, 14 Jul 2026 06:29:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784010558; cv=none; b=b8wzrj+TjmCIDiYeItC+NHfZ8mA8vR1hFohsvqKhiKgsmlWxfvdNgk5JtuAdT0tWiKpb0QBK+lWS6o0P7bdVknUkeKGhGNuknXWI47iaW8sBGTpvbdhD4p3VMWKz8jdLS8Fpobe2G41HhXMhVH66Ej0/VDpoJjoyVeFltIt2g4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784010558; c=relaxed/simple;
	bh=kmLU4rGPR67ilucNMrOPzthVZ5+TQTJoDMgB86gwQ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kzkyt+/FXLmSwHd3FNZnFM/DfKukPTQJ8iF2+0CeN9v0oJRF+GkEpHtbhlSeACHniqLBVv/dIJXQnJeT9YUDEKtM0zLYoDySEkE9pyALJDlSNo9jpXNCS6XLV3pqNBNWcBTR7v7qgGucJ+wFslAsCPNl0PQWyXSmhjp11OaDWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pm6mbu65; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4369C1F00A3A;
	Tue, 14 Jul 2026 06:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784010556;
	bh=09EO8r5LgFzD7KhN+xcQkRjxHZVY9HMB5UxLRzRJDVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=pm6mbu65d9hn/SJF0B3JE5ZRA5BzLba5Pq5LxZ9YM2aVApPSA6meNw2P9x026KFI/
	 kAcP0HIBohHxFA/VjwaNrzCtz0sFD2HqvAYY8eBq4t/JoHCd+b44MtAFQEZpc5RTIY
	 9RIJzXxAAGhtR5RehDucafG5hd5uOCi0NxVmm+7E=
Date: Tue, 14 Jul 2026 08:29:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: omeux <omeux327@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, security@kernel.org,
	linux-sctp@vger.kernel.org
Subject: Re: Subject: [SECURITY] sctp: diag: uninit kernel stack leak via
 INET_DIAG_LOCALS/PEERS
Message-ID: <2026071410-concerned-tremble-4cc4@gregkh>
References: <CAG245UPnx9BOWdG7EMh6jQrHeShjRZYaPM_ah_sMPeN82U+gpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG245UPnx9BOWdG7EMh6jQrHeShjRZYaPM_ah_sMPeN82U+gpA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:omeux327@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:security@kernel.org,m:linux-sctp@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1340-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linuxfoundation.org:from_mime,linuxfoundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E895D7517CA

On Tue, Jul 14, 2026 at 02:19:00PM +0800, omeux wrote:
> 5. Suggested fix
> ---------------------------------------------------------------
>    - Suspected location: net/sctp/diag.c inet_diag_msg_sctpladdrs_fill()
>      and inet_diag_msg_sctpaddrs_fill(); the uninit source is in
>      net/sctp/protocol.c sctp_v4_from_skb()/sctp_v4_from_addr_param().
>    - Proposed and tested fix: zero the full sockaddr_storage slot first,
>      then copy only the actually-initialized length of the address
>      (sizeof(struct sockaddr_in) for AF_INET, sizeof(union sctp_addr)
>      otherwise) so the uninitialized tail never reaches userspace.
> 
>        Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
>        Cc: stable@vger.kernel.org
>        Signed-off-by: Your Name <you@example.com>

Please turn this into a patch that can be applied, and properly use your
name and the Assisted-by: tag showing that you used an LLM for this
thing, so that it can be considered as a real patch.

Also, when cc:ing a public mailing list, no need to get
security@kernel.org involved.

thanks,

greg k-h

