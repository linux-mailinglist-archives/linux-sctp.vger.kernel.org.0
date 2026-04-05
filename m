Return-Path: <linux-sctp+bounces-1159-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Y8uAAoP10mmLcgcAu9opvQ
	(envelope-from <linux-sctp+bounces-1159-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Apr 2026 01:51:31 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9D3A0485
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Apr 2026 01:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 077AC300131D
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Apr 2026 23:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC82342146;
	Sun,  5 Apr 2026 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uAR1P3fO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506A34A02;
	Sun,  5 Apr 2026 23:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775433087; cv=none; b=FZu5tw7zaaG44pqQ5rv4Sovbe4HXJJ/0lGV1fPnuPy9Iz3RuJONve/L7n5etT6bnjipAgolSY2Ux6jCu9zqT8kF+zRVnn+/myYsqXb+uUg3saUZ/uOil+o4ZUEJtF6l6jUanhIHri/FK+5MA/bsw1c3KQPZrDfnml+G2KOIaJ2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775433087; c=relaxed/simple;
	bh=VWw2iQyuexyaX5wJJkHA2h2NGNab19K4tdMZJXCzdvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu5izNpiS//FTJhVSMU86Mrc7atjH6iMUnkD2n1t9zLFOkkmYWcH/ikNhbkvTcsxdqRn4+O6WELwG0pGXViVEhuvMXuUjoKhFKNF9/sAPgSjqkO7BEzhzGSzfLa7kGbaTyZKY5kTFcmn3rwC5DcVE2RtV9NSEQZS/XXIqs7QGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uAR1P3fO; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GcsBfi5F620a2VKaJJ4d3Xj9iYCBM9JdnynJybp0Ml8=; b=uAR1P3fOkiXbjktHEAQYC6zv3P
	DcFFeUxQzvftzwTeBXke83cFHAZX7zKr09XszNolooc/TfS7Uigea0AFBX2DKAYWPCSw3BfMzxfA6
	o4ATmG125tktTkSaHOtOl4NmLjThQp/ltc7YDDwgEFqWQXGeaTMjH5artg7lnOr2oIXQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w9XFN-00EvmP-0K; Mon, 06 Apr 2026 01:51:17 +0200
Date: Mon, 6 Apr 2026 01:51:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Ilya Dryomov <idryomov@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	netdev@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-wireless@vger.kernel.org, mptcp@lists.linux.dev,
	dev@openvswitch.org, linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where
 appropriate
Message-ID: <414634f5-3f9a-4d54-9c4d-0e87f63e8894@lunn.ch>
References: <20260405154816.4774-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260405154816.4774-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1159-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:email,lunn.ch:mid]
X-Rspamd-Queue-Id: 9BD9D3A0485
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 05, 2026 at 04:48:16PM +0100, David Carlier wrote:
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
> 
> Skipped sites writing into __be16 fields (netdevsim) where
> a direct assignment would trigger sparse endianness warnings.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

