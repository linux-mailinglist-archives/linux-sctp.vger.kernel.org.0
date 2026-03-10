Return-Path: <linux-sctp+bounces-1069-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AbfCIJ2sGnJjQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1069-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 20:52:34 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7A125732A
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 20:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4FD0304DF38
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 19:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1882935A38D;
	Tue, 10 Mar 2026 19:52:17 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from melduny.fyrkat.no (melduny.fyrkat.no [217.144.76.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157633542CF;
	Tue, 10 Mar 2026 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.144.76.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773172337; cv=none; b=Ws8oXW8+FNpP06ngNgolfrMgeCrltogN5WBgdEfTxgRZjUcKhhxPgvIzJ+OFf3GYlG5LLVELld8ZD876phJSN9T92/8Mvb27nneON+owb4ylb7TVF/JuD+Ch1krkZCSmMs351VA28QmC5JEfadJo40z3zjxXWwkiWTY/MaVtJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773172337; c=relaxed/simple;
	bh=ZC/kikINZ4TAvirVIFkqBizjiOt39ErEkuGXZ1Z0W+Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=spsv9j9FnU7JyeT9JkMuLJ5vAVexowszWi1mv5wnm4d1Wf9jIYq0HStyT8DGEoIvlPu4X8jJVdBqNDn8ka0pQoctIlLl68/VYiVM8B0meHe600Js4BcrLOas6s3x+PS7Hjez6hblBX1zrFMIV1FoyyPsYqA7ZrPZqU57Jyx4c8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no; spf=pass smtp.mailfrom=kolla.no; arc=none smtp.client-ip=217.144.76.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kolla.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kolla.no
Received: by melduny.fyrkat.no (Postfix) with ESMTPSA id 51FE78D0F;
	Tue, 10 Mar 2026 19:40:41 +0000 (UTC)
Date: Tue, 10 Mar 2026 20:40:36 +0100 (CET)
From: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>
To: Krzysztof Kozlowski <krzk@kernel.org>
cc: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
    Selvin Xavier <selvin.xavier@broadcom.com>, 
    Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
    Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>, 
    Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
    "maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <GR-QLogic-Storage-Upstream@marvell.com>, 
    "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Nilesh Javali <njavali@marvell.com>, 
    Manish Rangankar <mrangankar@marvell.com>, 
    Varun Prakash <varun@chelsio.com>, Alexander Aring <aahringo@redhat.com>, 
    David Teigland <teigland@redhat.com>, 
    Andreas Gruenbacher <agruenba@redhat.com>, 
    Nikolay Aleksandrov <razor@blackwall.org>, 
    David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
    Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
    David Howells <dhowells@redhat.com>, 
    Marc Dionne <marc.dionne@auristor.com>, 
    Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
    Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
    Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
    Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
    Arnd Bergmann <arnd@arndb.de>, 
    Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
    Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
    Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>, 
    Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
    Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
    Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, 
    Herbert Xu <herbert@gondor.apana.org.au>, 
    Ryota Sakamoto <sakamo.ryota@gmail.com>, 
    Kuniyuki Iwashima <kuniyu@google.com>, Kir Chou <note351@hotmail.com>, 
    Kuan-Wei Chiu <visitorckw@gmail.com>, 
    Vikas Gupta <vikas.gupta@broadcom.com>, 
    Bhargava Marreddy <bhargava.marreddy@broadcom.com>, 
    Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, 
    =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, 
    "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, 
    "open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>, 
    "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>, 
    "open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <linux-scsi@vger.kernel.org>, 
    "open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>, 
    "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>, 
    "open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
    "open list:NETFILTER" <coreteam@netfilter.org>, 
    "open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>, 
    "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
    "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
In-Reply-To: <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
Message-ID: <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
References: <20260309022013.5199-1-fmancera@suse.de> <20260309022013.5199-2-fmancera@suse.de> <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Queue-Id: BD7A125732A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.04 / 15.00];
	DMARC_POLICY_REJECT(2.00)[kolla.no : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,vger.kernel.org,linux-m68k.org,ziepe.ca,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,HansenPartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-1069-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux-m68k@kolla.no,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[69];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.803];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email,kolla.no:mid]
X-Rspamd-Action: no action

On Mon, 9 Mar 2026, Krzysztof Kozlowski wrote:

> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
> > Configuring IPV6 as a module provides little or no benefit and requires
> > time and resources to maintain. Therefore, drop the support for it.
> > 
> > Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> > dependencies across the tree that explicitly checked for IPV6=m. Adjust
> > all the default configurations from CONFIG_IPV6=m to CONFIG_IPV6=y. In
> > addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> > and MODULE_LICENSE().
> > 
> > This is also replacing module_init() by fs_initcall().
> > 
> > Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> > ---
-->8--
> No, I don't want IPV6. It is allowed as module if some users need, but
> it's heavy bloat added to each person's build testing setup. Kernel
> image is already huge and barely fits boot partitions when built with
> KASAN and I do want a generic image with KASAN.
> 
> It must stay module for me. Alternatively, drop it, but then some users
> will be really affected.

I agree. If anything I would prefer to see IPv4 be made optional (and
modular) as well, and not as something IPv6 depends on, it's (AFAIK)
impossible today to build an IPv6-only Linux kernel. 

-- kolla

