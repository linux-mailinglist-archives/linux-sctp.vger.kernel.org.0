Return-Path: <linux-sctp+bounces-1110-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFFjLyDasmlMQQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1110-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 16:22:08 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C31274415
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 16:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEDD9307B664
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 15:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E8A30F543;
	Thu, 12 Mar 2026 15:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xRu6vREz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RojeaC+1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xRu6vREz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RojeaC+1"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D7B3BAD89
	for <linux-sctp@vger.kernel.org>; Thu, 12 Mar 2026 15:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773328341; cv=none; b=EiaEZwrrNocJsBdKPnJUYV1/vzGJwgCBHLwkTP0p7Q3PtWvmIZya+elMcskhT1koVdb7C66jQ9hIYp/8EjkYiUpL18wKc9ZSaDrKgB6Ssgxs4djXMjGgE0w4l6cgznijycUtprGpn8/LYSiiBCjLNt7AYf+Utv1NR3EwMzzt5Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773328341; c=relaxed/simple;
	bh=/OlB2wYXzxx2lhu8Gs9ALiFJ9KIIcAJs+OvO6vGrCEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+1ok76nE0tclkcy+VRIc7hEuGR2S8wx7ov3bxgSqHfX9sLn2zq5qvTYMNZ8qXMn56ZNmaEIfoJbhtk5SV8wBNhX7GGnp+omUmw5cX+3UaHETxXKgkp/2hyL61pVgdaZrK6+Ud0JHSyT2jprg+4U6La+TpqV4n9btPlG3EJ5Z/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xRu6vREz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RojeaC+1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xRu6vREz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RojeaC+1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 56B334D291;
	Thu, 12 Mar 2026 15:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773328337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMN3lOpSDeHzFKXg/7He8rMHmT0WmpOMpEjVHXqTdfM=;
	b=xRu6vREzGoHgGA2fUdRtHBjA2bI6+qRvJ+qzs72hVNkf5rofPyioB74jN3qYC0SeFB1juk
	+uMPAE6Ps4ODzS5/FRsPQ609BczthN1Q2WOoDjd3ZX+buc/kjfgEVhdsZXmDnOKnR96QbK
	21KoogoFiYYWcg5v4GiQO/x3chITNFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773328337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMN3lOpSDeHzFKXg/7He8rMHmT0WmpOMpEjVHXqTdfM=;
	b=RojeaC+1VkbWVze91xYdCKbNG6aIJzoN8TYBSjL2bj11VaV2q1HRH+YFNqtt2k6oiP5Uqo
	I+qIkjWcskTktIBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xRu6vREz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RojeaC+1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773328337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMN3lOpSDeHzFKXg/7He8rMHmT0WmpOMpEjVHXqTdfM=;
	b=xRu6vREzGoHgGA2fUdRtHBjA2bI6+qRvJ+qzs72hVNkf5rofPyioB74jN3qYC0SeFB1juk
	+uMPAE6Ps4ODzS5/FRsPQ609BczthN1Q2WOoDjd3ZX+buc/kjfgEVhdsZXmDnOKnR96QbK
	21KoogoFiYYWcg5v4GiQO/x3chITNFk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773328337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMN3lOpSDeHzFKXg/7He8rMHmT0WmpOMpEjVHXqTdfM=;
	b=RojeaC+1VkbWVze91xYdCKbNG6aIJzoN8TYBSjL2bj11VaV2q1HRH+YFNqtt2k6oiP5Uqo
	I+qIkjWcskTktIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDA7B40022;
	Thu, 12 Mar 2026 15:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VQkzL83XsmnAJAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 12 Mar 2026 15:12:13 +0000
Message-ID: <aebac89f-f3b9-4983-8139-353a3ff19c98@suse.de>
Date: Thu, 12 Mar 2026 16:12:09 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10 net-next v2] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, rbm@suse.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Selvin Xavier
 <selvin.xavier@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>,
 Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>,
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
 Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Sven Peter <sven@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Ryota Sakamoto
 <sakamo.ryota@gmail.com>, Kir Chou <note351@hotmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
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
References: <20260310153506.5181-1-fmancera@suse.de>
 <20260310153506.5181-2-fmancera@suse.de> <20260311200219.45796ec4@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260311200219.45796ec4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-m68k.org,ziepe.ca,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,HansenPartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,hotmail.com,gondor.apana.org.au,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1110-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[68];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 38C31274415
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 4:02 AM, Jakub Kicinski wrote:
> On Tue, 10 Mar 2026 16:34:24 +0100 Fernando Fernandez Mancera wrote:
>> Maintaining a modular IPv6 stack offers image size and memory savings
>> for specific setups, this benefit is outweighed by the architectural
>> burden it imposes on the subsystems on implementation and maintenance.
>> Therefore, drop it.
>>
>> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
>> dependencies across the tree that explicitly checked for IPV6=m. In
>> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
>> and MODULE_LICENSE().
>>
>> This is also replacing module_init() by device_initcall(). It is not
>> possible to use fs_initcall() as IPv4 does because that creates a race
>> condition on IPv6 addrconf.
>>
>> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
>> except for m68k as according to the bloat-o-meter the image is
>> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
>> this architecture by default. This is aligned with m68k RAM requirements
>> and recommendations [1].
> 
> AI has spotted:
> 
>> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
>> index 31d16cba9879..de088071dde4 100644
>> --- a/arch/m68k/configs/amiga_defconfig
>> +++ b/arch/m68k/configs/amiga_defconfig
>> @@ -64,7 +64,6 @@ CONFIG_NET_IPIP=m
>>   CONFIG_NET_IPGRE_DEMUX=m
>>   CONFIG_NET_IPGRE=m
>>   CONFIG_NET_IPVTI=m
>> -CONFIG_NET_FOU_IP_TUNNELS=y
>>   CONFIG_INET_AH=m
> 
> Is CONFIG_NET_FOU_IP_TUNNELS=y removed intentionally? This option
> provides FOU/GUE encapsulation for IP tunnels and has 'depends on
> NET_IPIP || NET_IPGRE || IPV6_SIT' as its Kconfig dependency. With IPv6
> disabled, IPV6_SIT becomes unavailable, but CONFIG_NET_IPIP=m and
> CONFIG_NET_IPGRE=m are both still present in the defconfig, so the
> dependency remains satisfiable.
> 
> Since CONFIG_NET_FOU_IP_TUNNELS has no 'default y', removing it from the
> defconfig means FOU/GUE encapsulation for IP tunnels will be silently
> disabled by default on m68k. The commit message describes only disabling
> IPv6 on m68k, not removing IPv4 FOU tunnel support.
> 

I noticed that when running

./scripts/config --disable CONFIG_IPV6

for the m68k, the script was adding CONFIG_LWTUNNEL=y and CONFIG_NET_FOU=y.

CONFIG_LWTUNNEL was selected by multiple IPV6 features. I do not think 
it makes sense to keep it for m68k given the information there is on 
http://www.linux-m68k.org/faq/platinfo.html.

CONFIG_NET_FOU was something IPV6_FOU required, probably it should be 
just dropped from the config instead of explicitly turn it off as it 
turns off FOU_IP_TUNNELS too. It will be selected by FOU_IP_TUNNELS too 
anyway.

I will update the config and also the commit message about CONFIG_LWTUNNEL.

FTR; I doubt anyone is running Foo over UDP in m68k but let's avoid 
doing extra undocumented changes.

Thanks,
Fernando.

> This affects four m68k defconfigs:
> - amiga_defconfig
> - apollo_defconfig
> - atari_defconfig
> - bvme6000_defconfig
> 


