Return-Path: <linux-sctp+bounces-1104-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNpKLMMssmmlJQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1104-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 04:02:27 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 744A426C89C
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 04:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14F3A302DE16
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 03:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D74382F37;
	Thu, 12 Mar 2026 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8NXL71/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE8638DD3;
	Thu, 12 Mar 2026 03:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284543; cv=none; b=S0JFj6zc4zCnFLvfoaayVNtCTvJ+HkbE3TYY+9tYKdChL5kmzc4ca5GcOMjQFcRQMdCBI5RhGPAriaumDHf8ECWoUbPCmJnjw/nFRozQn26FhJIw6QY+XzbNPdwjD3rjTTXJldv1hqa+4p4BgbtFyHzUkCTwgnWP4LSjzebGKVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284543; c=relaxed/simple;
	bh=KEYQl8+VvPcfn6uzVu6YIy+HYhzQOXqkZpAojxKhODA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FKAOaizCHgHx3LVQRTYq21oCj4Vap6RVTeh/TAXoQdI4CxonNvlW6FU8GAJPciGBP2stdkyjuA7qLo/yRU2LMpGHB02WQt+McNWcsQT0XCUvMYXcSLt0e6hh7/uvjWZqciazv6/CGg3i9rlPuwfCzr5zhqsqCbowbiqqKB9x8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8NXL71/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A04AC4CEF7;
	Thu, 12 Mar 2026 03:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773284543;
	bh=KEYQl8+VvPcfn6uzVu6YIy+HYhzQOXqkZpAojxKhODA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F8NXL71/vLl3Dq1WAm4Auc0XA4QvHGBmkfPAKKMT6NZVVgMTlNICYyjzHbGeJNcRz
	 F/Wyghg4yMGVLqcfE4spE2II5KVJdUmo2MxvcpQg3RiL0kv50pky3Us/SgWGfNm4C8
	 OBewmMfEcqIpb9At+m7LjiAqOwNVG4C2TNES2w0nh0uyTac7Ly/93mEtPAEk62p2+b
	 RhVSYeBhuL4hLRLBGq/r/1rBww6KvG71fHi3nYyB1s5dHCLtjRQkQCLldoR1mkjmFr
	 aShv34CDa+y+Ih95SrOoeCJ6uds494cxNGUfz/pgC7e4lbkLCq/zI770KaUawqGkb+
	 srwBq+9pcpfUw==
Date: Wed, 11 Mar 2026 20:02:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, rbm@suse.com, Geert Uytterhoeven
 <geert@linux-m68k.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>, Selvin Xavier <selvin.xavier@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ido
 Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Simon Horman
 <horms@kernel.org>, Saurav Kashyap <skashyap@marvell.com>, Javed Hasan
 <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com
 (maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER), "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, Manish
 Rangankar <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>,
 Alexander Aring <aahringo@redhat.com>, David Teigland
 <teigland@redhat.com>, Andreas Gruenbacher <agruenba@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>, Pablo
 Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil
 Sutter <phil@nwl.cc>, David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Jon Maloy
 <jmaloy@redhat.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, Bjorn Andersson
 <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, Eric
 Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, Luca
 Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>, Lad
 Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
 <kuninori.morimoto.gx@renesas.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, Kuan-Wei Chiu
 <visitorckw@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, Kir Chou
 <note351@hotmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, Markus =?UTF-8?B?QmzDtmNobA==?=
 <markus@blochl.de>, Heiner Kallweit <hkallweit1@gmail.com>,
 linux-kernel@vger.kernel.org (open list), linux-m68k@lists.linux-m68k.org
 (open list:M68K ARCHITECTURE), linux-rdma@vger.kernel.org (open
 list:INFINIBAND SUBSYSTEM), oss-drivers@corigine.com (open list:NETRONOME
 ETHERNET DRIVERS), linux-scsi@vger.kernel.org (open list:BROADCOM BNX2FC 10
 GIGABIT FCOE DRIVER), gfs2@lists.linux.dev (open list:DISTRIBUTED LOCK
 MANAGER (DLM)), bridge@lists.linux.dev (open list:ETHERNET BRIDGE),
 netfilter-devel@vger.kernel.org (open list:NETFILTER),
 coreteam@netfilter.org (open list:NETFILTER), linux-afs@lists.infradead.org
 (open list:RXRPC SOCKETS (AF_RXRPC)), linux-sctp@vger.kernel.org (open
 list:SCTP PROTOCOL), tipc-discussion@lists.sourceforge.net (open list:TIPC
 NETWORK LAYER)
Subject: Re: [PATCH 01/10 net-next v2] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
Message-ID: <20260311200219.45796ec4@kernel.org>
In-Reply-To: <20260310153506.5181-2-fmancera@suse.de>
References: <20260310153506.5181-1-fmancera@suse.de>
	<20260310153506.5181-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-m68k.org,ziepe.ca,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,HansenPartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,hotmail.com,gondor.apana.org.au,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-1104-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[62];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 744A426C89C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 10 Mar 2026 16:34:24 +0100 Fernando Fernandez Mancera wrote:
> Maintaining a modular IPv6 stack offers image size and memory savings
> for specific setups, this benefit is outweighed by the architectural
> burden it imposes on the subsystems on implementation and maintenance.
> Therefore, drop it.
> 
> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> dependencies across the tree that explicitly checked for IPV6=m. In
> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> and MODULE_LICENSE().
> 
> This is also replacing module_init() by device_initcall(). It is not
> possible to use fs_initcall() as IPv4 does because that creates a race
> condition on IPv6 addrconf.
> 
> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
> except for m68k as according to the bloat-o-meter the image is
> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
> this architecture by default. This is aligned with m68k RAM requirements
> and recommendations [1].

AI has spotted:

> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> index 31d16cba9879..de088071dde4 100644
> --- a/arch/m68k/configs/amiga_defconfig
> +++ b/arch/m68k/configs/amiga_defconfig
> @@ -64,7 +64,6 @@ CONFIG_NET_IPIP=m
>  CONFIG_NET_IPGRE_DEMUX=m
>  CONFIG_NET_IPGRE=m
>  CONFIG_NET_IPVTI=m
> -CONFIG_NET_FOU_IP_TUNNELS=y
>  CONFIG_INET_AH=m

Is CONFIG_NET_FOU_IP_TUNNELS=y removed intentionally? This option
provides FOU/GUE encapsulation for IP tunnels and has 'depends on
NET_IPIP || NET_IPGRE || IPV6_SIT' as its Kconfig dependency. With IPv6
disabled, IPV6_SIT becomes unavailable, but CONFIG_NET_IPIP=m and
CONFIG_NET_IPGRE=m are both still present in the defconfig, so the
dependency remains satisfiable.

Since CONFIG_NET_FOU_IP_TUNNELS has no 'default y', removing it from the
defconfig means FOU/GUE encapsulation for IP tunnels will be silently
disabled by default on m68k. The commit message describes only disabling
IPv6 on m68k, not removing IPv4 FOU tunnel support.

This affects four m68k defconfigs:
- amiga_defconfig
- apollo_defconfig
- atari_defconfig
- bvme6000_defconfig

