Return-Path: <linux-sctp+bounces-979-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMclAeOfrmm2GwIAu9opvQ
	(envelope-from <linux-sctp+bounces-979-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 09 Mar 2026 11:24:35 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6B236FC2
	for <lists+linux-sctp@lfdr.de>; Mon, 09 Mar 2026 11:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D8403042B7D
	for <lists+linux-sctp@lfdr.de>; Mon,  9 Mar 2026 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349F38F255;
	Mon,  9 Mar 2026 10:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyxrtNLr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADB256C84;
	Mon,  9 Mar 2026 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051865; cv=none; b=FjZALrB+tn2A8lnDjKor/8ZNb52frpoiCXDadez1G3/1c+nmSKOMUqymnv3IB+pSkop4FJXNXce/kzLFgQjnmPJXAiP10mWgXglkd4MtcS9lW2zuLNm2jkQ4b512MezJmKGahg67dNm8ix7+BmWyzMgv+paajjiDtnqm6Y05nNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051865; c=relaxed/simple;
	bh=BvtwtwcwSfVKcyfpQtaLtqIA+tgqr1RTHQjVXI2Vme4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nf44ujCLCXoRRlbycuyQjTGGyjXxU+ku6q8dhmwfcZoGBlEHVPYr0GYKRlJYwxa4rj8MZg3zoZEUKiUDD2PwQOwC6xMtHi1Mi9b8f3hiV2yk8U2GAYnRuOdOsZQB2s6WoEyO5XmlQn5cvaLy6rlBxaE8xtxtt+ezFwfFdF2zDz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyxrtNLr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2071CC4CEF7;
	Mon,  9 Mar 2026 10:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773051864;
	bh=BvtwtwcwSfVKcyfpQtaLtqIA+tgqr1RTHQjVXI2Vme4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VyxrtNLruvKU9Vq3Qy2KtTqc+zYLfcjs4YIvhrvgiJb5gtOY46oVjmEXXf7YinaVE
	 5khuGRS3qY3UVL3hy3wmqnxBqvI1CB9WN5omD4S1iOusTrEMAErj8IVjZpI2iwTydl
	 kp1MAotDxje3JrxOzGaxEaQpq2ccXBvx6bQYBMFVG4QmeEjqOMPkj/eShoCuRfouBI
	 VHIUcd0fANbygZgY+He3mnYpd8yx4sU8KIp4XiAdUHQzAwOv9Gh9kd8B65S5RAaXQY
	 fNJ2en5dg5ao95Rm8vU1c8tDOfIl9ck6y/pl+8clVoNNZR7PoKKxzwBPVU5Skak+rq
	 q5HmKfWfPwj6w==
Message-ID: <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
Date: Mon, 9 Mar 2026 11:24:06 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in only
 and clean up Kconfigs
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>,
 "maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER"
 <GR-QLogic-Storage-Upstream@marvell.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nilesh Javali <njavali@marvell.com>,
 Manish Rangankar <mrangankar@marvell.com>, Varun Prakash
 <varun@chelsio.com>, Alexander Aring <aahringo@redhat.com>,
 David Teigland <teigland@redhat.com>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Ahern <dsahern@kernel.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, David Howells <dhowells@redhat.com>,
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
 Kuan-Wei Chiu <visitorckw@gmail.com>, Vikas Gupta
 <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
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
References: <20260309022013.5199-1-fmancera@suse.de>
 <20260309022013.5199-2-fmancera@suse.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260309022013.5199-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 63A6B236FC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux-m68k.org,ziepe.ca,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,HansenPartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-979-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_GT_50(0.00)[68];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Action: no action

On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
> Configuring IPV6 as a module provides little or no benefit and requires
> time and resources to maintain. Therefore, drop the support for it.
> 
> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> dependencies across the tree that explicitly checked for IPV6=m. Adjust
> all the default configurations from CONFIG_IPV6=m to CONFIG_IPV6=y. In
> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> and MODULE_LICENSE().
> 
> This is also replacing module_init() by fs_initcall().
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  arch/arm64/configs/defconfig                | 2 +-
>  arch/m68k/configs/amiga_defconfig           | 2 +-
>  arch/m68k/configs/apollo_defconfig          | 2 +-
>  arch/m68k/configs/atari_defconfig           | 2 +-
>  arch/m68k/configs/bvme6000_defconfig        | 2 +-
>  arch/m68k/configs/hp300_defconfig           | 2 +-
>  arch/m68k/configs/mac_defconfig             | 2 +-
>  arch/m68k/configs/multi_defconfig           | 2 +-
>  arch/m68k/configs/mvme147_defconfig         | 2 +-
>  arch/m68k/configs/mvme16x_defconfig         | 2 +-
>  arch/m68k/configs/q40_defconfig             | 2 +-
>  arch/m68k/configs/sun3_defconfig            | 2 +-
>  arch/m68k/configs/sun3x_defconfig           | 2 +-
>  drivers/infiniband/Kconfig                  | 1 -
>  drivers/infiniband/hw/ocrdma/Kconfig        | 2 +-
>  drivers/infiniband/ulp/ipoib/Kconfig        | 2 +-
>  drivers/net/Kconfig                         | 9 ---------
>  drivers/net/ethernet/broadcom/Kconfig       | 2 +-
>  drivers/net/ethernet/chelsio/Kconfig        | 2 +-
>  drivers/net/ethernet/mellanox/mlxsw/Kconfig | 1 -
>  drivers/net/ethernet/netronome/Kconfig      | 1 -
>  drivers/scsi/bnx2fc/Kconfig                 | 1 -
>  drivers/scsi/bnx2i/Kconfig                  | 1 -
>  drivers/scsi/cxgbi/cxgb3i/Kconfig           | 2 +-
>  drivers/scsi/cxgbi/cxgb4i/Kconfig           | 2 +-
>  fs/dlm/Kconfig                              | 2 +-
>  fs/gfs2/Kconfig                             | 2 +-
>  net/bridge/Kconfig                          | 1 -
>  net/ipv4/Kconfig                            | 9 ++++-----
>  net/ipv6/Kconfig                            | 6 +-----
>  net/ipv6/af_inet6.c                         | 8 +-------
>  net/l2tp/Kconfig                            | 1 -
>  net/netfilter/Kconfig                       | 8 --------
>  net/rxrpc/Kconfig                           | 2 +-
>  net/sctp/Kconfig                            | 1 -
>  net/tipc/Kconfig                            | 1 -
>  36 files changed, 28 insertions(+), 65 deletions(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index b67d5b1fc45b..0651a771f5c1 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -140,7 +140,7 @@ CONFIG_IP_MULTICAST=y
>  CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
>  CONFIG_IP_PNP_BOOTP=y
> -CONFIG_IPV6=m
> +CONFIG_IPV6=y
>  CONFIG_NETFILTER=y
>  CONFIG_BRIDGE_NETFILTER=m
>  CONFIG_NF_CONNTRACK=m

No, I don't want IPV6. It is allowed as module if some users need, but
it's heavy bloat added to each person's build testing setup. Kernel
image is already huge and barely fits boot partitions when built with
KASAN and I do want a generic image with KASAN.

It must stay module for me. Alternatively, drop it, but then some users
will be really affected.

Best regards,
Krzysztof

