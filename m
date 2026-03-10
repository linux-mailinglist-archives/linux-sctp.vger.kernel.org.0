Return-Path: <linux-sctp+bounces-1071-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFbJE5iAsGmwjwIAu9opvQ
	(envelope-from <linux-sctp+bounces-1071-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 21:35:36 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C69B3257E81
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 21:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AF4630EAB65
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 20:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC5C36896E;
	Tue, 10 Mar 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="mQHVfkU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yxX/flEO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C1928D8D1;
	Tue, 10 Mar 2026 20:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174929; cv=none; b=gv6oqyGi3xDNzEbAOUJxEEmB3WxenXPbGM0kgxn7q57ZVfTwaVyVL7v/5UQoPOQ2euMQikbfRpff8sTZU+sSyPITXubFs1E3aC1DdVKYo+L/1/nhfd1qR3CHBe0ebc2wR92F7g9TB8aBQxQHbRnH13WM6vf7RW4m1SamVI3pRUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174929; c=relaxed/simple;
	bh=fWjPDtZYLRiHyP1hFQJoqbnIUZPfobJPRTRneeeUYZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUat5+HxSrPpIEqGqMSbY2kj5jQGVk/SXzieDGGI2EXM3hVMuaBHKHqw8ZrlOygGvMaJp+hOZi57A5+iEwAPPybmM858Etu0ZpMtZYp66lmx3dXAQFsSSpggLr+6AzjgRytOeGO9Dl+PJSHnsGA4Rww5w5qQi8ff3FmJQJiJEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=mQHVfkU2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yxX/flEO; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 91EB71301086;
	Tue, 10 Mar 2026 16:35:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Mar 2026 16:35:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1773174923; x=1773182123; bh=GUHcSBjnGwnEAePyZXqYRHBRjMu3EdRP
	nW5GkKUZ8Hg=; b=mQHVfkU2C/mSyWWIhYy4mdJQqdklBuH971WxffTsC+pYYWvP
	oco3aNmzcq2NSRmorvumHu5VzqcfQNU53evBJiLtJ3BVEsc7riELuOEjrbfzrMx5
	22mEXrMBl5wOHR2z95XruPLgwF0PZAj4PxuHXSslXwDxaLRBkLdFDCzmUVdD+SyN
	+qpNyLd65CR9ncYUXdUZqq86Xv+ak9F+uxyfJ2ctMHCfH4s5HSeBu0BCkx7fjIEo
	hJQImYXxcDfOwyJjt4mlCPjkpSlSb3fAcGX+F/knW+xQo+UVKxUbj6QuMfcB6hpD
	C2k+bt/vpRUNeCgTCPy/F9yZS6WUrkBiohFFIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773174923; x=
	1773182123; bh=GUHcSBjnGwnEAePyZXqYRHBRjMu3EdRPnW5GkKUZ8Hg=; b=y
	xX/flEOLE1Dgph3gOwfRlsHSCrNMPjT5DTVTocAYJvHeH9hJ/PQWRjdcDvXLO5X3
	Dhps6N7mNHnNCg6ZHsO/BNEyKIU4cCbmHqIYHxx73qI6H1DNEVoohrkcM2qognwg
	X6Qeae7ChlUatssaKSd98zzVHNtr2DborU4Ioo40Nrdx4Ftk88cffq6wOlFh5BxB
	oLd3jEL/TXt9CAEAEa+l/mRalbfk3DRFY4A4GlQCvWMDAH6+tPWp0ZKqCGUcHSdH
	TMwz+LrYFTB3sDUYHwHr1zWCWOxWcUcy5epu/OxqrYyPnDlf5PH54a5LzCxklFpt
	2OanoyOOaoQL9/DS/14Kg==
X-ME-Sender: <xms:h4CwaZ8QIsV7xI8gayVcjRp6WspDlx_s2IqtoPjstbWTxx96bkMlCA>
    <xme:h4CwaSZn5AfkuvaKxKamTZ2Oopj4qYZuryM4C9QhmyPfgDM0DZloLBomrHjREPYGn
    4s9kka7KrDoC6D03L6EZIMc-UU02Ao4BiHdKeiX2ujZdUXcnBvbRV4>
X-ME-Received: <xmr:h4CwaT0r5GdKgNmE2U0AcyvlWslGnr7dz473enqzKxWVsOmdO5d6xWJQgaNj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefurggsrhhi
    nhgrucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtf
    frrghtthgvrhhnpefgvdegieetffefvdfguddtleegiefhgeeuheetveevgeevjeduleef
    ffeiheelvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepjedtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrrhhnugesrghrnhgusgdruggvpdhrtg
    hpthhtoheplhhinhhugidqmheikehksehkohhllhgrrdhnohdprhgtphhtthhopehkrhii
    kheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhmrghntggvrhgrsehsuhhsvgdrug
    gvpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohepjhhg
    ghesiihivghpvgdrtggrpdhrtghpthhtoheplhgvohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h4CwaaWqtTrazTIBiJ7mj7KuMn3TAZ3eMyx_sc2qWjawSLgbCVbCcA>
    <xmx:h4CwaX1rZlL5LaUSU0CxuyVxElrkrEB6VpQbg4KERm6BzZwyKQg-sQ>
    <xmx:h4CwaQK3Mz6YPWIzCA8eAO7yNFSQA2ImELPQmOdQEcBHeBkd1JXYZw>
    <xmx:h4CwaawQxrSNYPNxR5geOEW7vpEIc-C1X8LxIBj5l5f_wfW3YhtKUg>
    <xmx:i4Cwaeb4Q29w_kzh9M9QqyuUPFh32eI9JlSeW34f912Df0nvtd9DtGTc>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 16:35:18 -0400 (EDT)
Date: Tue, 10 Mar 2026 21:35:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?B?S29sYmrDuHJu?= Barmen <linux-m68k@kolla.no>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,	Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>,	Simon Horman <horms@kernel.org>,
	Saurav Kashyap <skashyap@marvell.com>,	Javed Hasan <jhasan@marvell.com>,
	"maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER"
 <GR-QLogic-Storage-Upstream@marvell.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	Varun Prakash <varun@chelsio.com>,	Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,	Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>,	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Eric Biggers <ebiggers@kernel.org>,	Michal Simek <michal.simek@amd.com>,
	Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>,
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Gow <david@davidgow.net>,	Herbert Xu <herbert@gondor.apana.org.au>,
	Ryota Sakamoto <sakamo.ryota@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,	Kir Chou <note351@hotmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
	Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>,
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
	"open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
	"open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER"
 <linux-scsi@vger.kernel.org>,
	"open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>,
	"open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>,
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
	"open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
Message-ID: <abCAhAh5VnrnY0_i@krikkit>
References: <20260309022013.5199-1-fmancera@suse.de>
 <20260309022013.5199-2-fmancera@suse.de>
 <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
 <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
 <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
X-Rspamd-Queue-Id: C69B3257E81
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1071-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FREEMAIL_CC(0.00)[kolla.no,kernel.org,suse.de,vger.kernel.org,linux-m68k.org,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim,queasysnail.net:dkim]
X-Rspamd-Action: no action

2026-03-10, 20:58:15 +0100, Arnd Bergmann wrote:
> On Tue, Mar 10, 2026, at 20:40, Kolbjørn Barmen wrote:
> > On Mon, 9 Mar 2026, Krzysztof Kozlowski wrote:
> >> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
> >>
> >> It must stay module for me. Alternatively, drop it, but then some users
> >> will be really affected.
> >
> > I agree. If anything I would prefer to see IPv4 be made optional (and
> > modular) as well, and not as something IPv6 depends on, it's (AFAIK)
> > impossible today to build an IPv6-only Linux kernel. 
> 
[...]
> For optional IPv4 support, I would expect that it's possible
> to make it a loadable module, with a significant amount of
> work and little benefit. Loading an ipv6 module without also
> loading ipv4 sounds completely unrealistic though, given
> the way the code is structured today.

I played with building IPv6-only kernels some years ago. It was
possible (at least for the reduced config I was using as a start), but
yes, a fair amount of investigation and churn, to find all the IPv4
common code and turn it into "generic" common code.

IPv4 as a module would get us in the same mess with have with IPv6,
let's not do that.

But even IPV4=n, I abandonned the idea because of the work/churn vs
benefit ratio.

-- 
Sabrina

