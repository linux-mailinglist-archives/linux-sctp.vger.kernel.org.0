Return-Path: <linux-sctp+bounces-1070-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oTvcLvJ3sGnLjgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1070-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 20:58:42 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB3257453
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 20:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1B74302737D
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 19:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2DB3E1D1B;
	Tue, 10 Mar 2026 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Uew34qv7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2n/lZfXF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A23563F6;
	Tue, 10 Mar 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172719; cv=none; b=WhBHKmhK4gYFSDS5O9HKH72st0pfNAPiNZagyyHeJgcNue884sdsifLcHpi/3x4P1iyMS/ogcAJGnLNZ2j3kG27RG0Z3YYg1YzAQ1eP6H1WBg/BtzhDWDaiPsp05/IhLTNVe8BaGNRpLE83CdbvzVZM1pM46mDbOyuiyqxsS7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172719; c=relaxed/simple;
	bh=Je1rIPnGOjOPK0cgnGXu5ko559F90dtD+GO7ltgNRNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rq/ZQHmLSjjmQd+zzxU9oznQtOFIIrnzRi/fGj4yq5uTW8NJ+Cn/JES43gHhEIm9x11zhx49Ow9+5+d3RCX8fLMDlL+rrRvlwswluoI6kDBPMFkXfoCIFeN1USstvhAFA2Gfo3T1A3Q+0lFIoeLgOEnfFOpfOjRCQ71YhYY9YWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Uew34qv7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=2n/lZfXF; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A8FD414001D8;
	Tue, 10 Mar 2026 15:58:37 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 15:58:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773172717;
	 x=1773259117; bh=uJKac+q963i+BI7ifqs+uvHGeqpQW5n8cXoM0XhfjDE=; b=
	Uew34qv7pCBzkvZjZTEAYpO5UWhAAZdzSCNWTcTClAmjdLTvephCfQ4dxOz5YZn0
	/itpHBzOcLwGWlWpdtl5GgiK3xmn1WWZUapLt/Y2A/qSH0zxQpxFZ+xQxCmcjzY0
	7OWkB2BamWqHxPOFX2QuTgO3Dc4yfVA7erBQjC+qy8CFgEbx41zhaaaepKVNmYD+
	30dzlAGQybbtF3MBI9gtTT2L1jdgE/BuohqKWO3m3YYf87ATVRgcr6kUp+SHVTXI
	8PLWLjwFZbSi6yjygY44WM1d9ixhk8PtIA+jBxEd2ee3ZOEgZMynp945JvKsihKz
	OPUe8TI9ZbwDcxyykHBtJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773172717; x=
	1773259117; bh=uJKac+q963i+BI7ifqs+uvHGeqpQW5n8cXoM0XhfjDE=; b=2
	n/lZfXFfXJPo3ExlsRXlx2EdHgFZYFUHbs3rFuPv0NQcZNACMjfk0KjE8kWE9yHd
	HVU/DiLS5AOw1emAOd4rIQ3HwmePCrz+jXp2nrJN96GDVs2XfI06/nENPvr0jdEJ
	hVgWK0rinAurdKgRXFJX+w8oGfBjJJLbEy443uRCrUqt6MnbIObk6sDjo2f6S8A1
	tP/5wKydc5ZrVfj1yCFt05LWsRr0zM/5xfP5CbvvfeWwfeGBNAnnTLfmZbGqlra7
	CfMxEzCI/EjOgQ2KA42mDl9z6xvgg+/FmDoP19S5rRgwz8hb4KEco5H+OzF3ah4M
	xP0eYNCKwrCQvrX72kY5A==
X-ME-Sender: <xms:7HewaW2EW4aIbBKTS7UK-psUE0Nw5jE1F-RBDtPxUx8dDxUD2BRztA>
    <xme:7HewaT4k_ONcW6iKQNQx5FQE2xPGs-qrJRlGTln3pRXSgCQnpnr1UT9Jpqr5RBRdv
    l-QRHtUMmbAW7OgzWJUPHNcHwzNv0UjRGb04YkaL6p-5QVyvZ56q5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepteefudehvedutdeugfeuveffleduheehfeehffeujeduledvheeivdffleffjedt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsghjohhrnhdrrg
    hnuggvrhhsshhonhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepughm
    ihhtrhihrdgsrghrhihshhhkohhvsehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtph
    htthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehoshhsrdhquhgrlhgtohhm
    mhdrtghomhdprhgtphhtthhopegrrghhrhhinhhgohesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtoheprghgrhhuvghnsggrsehrvgguhhgrthdrtghomhdprhgtphhtthhopeguhhho
    figvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhmrghlohihsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepthgvihhglhgrnhgusehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:7HewaTOpEFcn6hqIyIiBheJRfEB7Vkj-PbGHEO4wX95Gn0zmQ7kxtA>
    <xmx:7HewaeWQLgkTVfjnhbbWXXKW7aT3rAFHhhzTGXJZjc15yTdIu3YaVg>
    <xmx:7HewaTZ912bZtZOvaA6q8xjcPqfUUQK1VTgTF43fwte6r90C4LHobw>
    <xmx:7HewaTuF2EPmaYnp6X8GjsyTbIsZW_eJ1rEE4KSO8hmNdoO9qJXdvw>
    <xmx:7XewaUIK6AIVkZv1GGe9EhDA9LBrlF3Jl8_SlSwh-5-51rX6_GPeSCTv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C056E700069; Tue, 10 Mar 2026 15:58:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aes-ty0OVaaR
Date: Tue, 10 Mar 2026 20:58:15 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>,
 "Krzysztof Kozlowski" <krzk@kernel.org>
Cc: "Fernando Fernandez Mancera" <fmancera@suse.de>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Selvin Xavier" <selvin.xavier@broadcom.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Ido Schimmel" <idosch@nvidia.com>,
 "Petr Machata" <petrm@nvidia.com>, "Simon Horman" <horms@kernel.org>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>,
 "maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER"
 <GR-QLogic-Storage-Upstream@marvell.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Aring" <aahringo@redhat.com>,
 "David Teigland" <teigland@redhat.com>,
 "Andreas Gruenbacher" <agruenba@redhat.com>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "David Ahern" <dsahern@kernel.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>, "Jon Maloy" <jmaloy@redhat.com>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
 "Bjorn Andersson" <bjorn.andersson@oss.qualcomm.com>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Michal Simek" <michal.simek@amd.com>,
 "Luca Weiss" <luca.weiss@fairphone.com>, "Sven Peter" <sven@kernel.org>,
 "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "David Gow" <david@davidgow.net>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Ryota Sakamoto" <sakamo.ryota@gmail.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Kir Chou" <note351@hotmail.com>, "Kuan-Wei Chiu" <visitorckw@gmail.com>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
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
Message-Id: <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
In-Reply-To: <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
References: <20260309022013.5199-1-fmancera@suse.de>
 <20260309022013.5199-2-fmancera@suse.de>
 <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
 <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in only and
 clean up Kconfigs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 28CB3257453
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1070-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,linux-m68k.org,ziepe.ca,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[69];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	NEURAL_HAM(-0.00)[-0.820];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026, at 20:40, Kolbj=C3=B8rn Barmen wrote:
> On Mon, 9 Mar 2026, Krzysztof Kozlowski wrote:
>> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
>>
>> It must stay module for me. Alternatively, drop it, but then some use=
rs
>> will be really affected.
>
> I agree. If anything I would prefer to see IPv4 be made optional (and
> modular) as well, and not as something IPv6 depends on, it's (AFAIK)
> impossible today to build an IPv6-only Linux kernel.=20

My first feeling was that this is a bad idea as well. On the other hand
I found that the default changed from =3Dm to -y over 10 years ago, all
recent distros listed in https://github.com/nyrahul/linux-kernel-configs
use that default (the only two exceptions are board specific builds
of Debian and Ubuntu for linux-5.x).

The list does not include openwrt though, and I know that in
previous releases, there was an optional kmod-ipv6 package
that could be left out of an install without rebuilding
the kernel. Configurations under 128MB are only partially
supported there these days, so maybe it's no longer important
for openwrt either, but it would be good to get a confirmation
from someone doing the packaging.

For optional IPv4 support, I would expect that it's possible
to make it a loadable module, with a significant amount of
work and little benefit. Loading an ipv6 module without also
loading ipv4 sounds completely unrealistic though, given
the way the code is structured today.

    Arnd

