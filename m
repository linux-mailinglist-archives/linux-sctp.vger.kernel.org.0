Return-Path: <linux-sctp+bounces-1143-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPeMMUh7ummTWwIAu9opvQ
	(envelope-from <linux-sctp+bounces-1143-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 18 Mar 2026 11:15:36 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1932B9B9D
	for <lists+linux-sctp@lfdr.de>; Wed, 18 Mar 2026 11:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBFAA3004D03
	for <lists+linux-sctp@lfdr.de>; Wed, 18 Mar 2026 10:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4E3B7B8F;
	Wed, 18 Mar 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ofL7rmkW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZGgQxhz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rjiHoQUv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zNi9ATAz"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CA3A4F51
	for <linux-sctp@vger.kernel.org>; Wed, 18 Mar 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773828913; cv=none; b=UXTiXjt8i59Tui7Vfb4p5QGq+OqlIf7vnBLezW9iVmksgNjW7679aL26jQnXzGssNg1sBWcZYo38DU+8LTx2xa93paWmeY7ZRgJxIq6JMWA97kw6vd9XGQm2nN9tU/r6AcqufbZDEt/9nwMWnzscAlIzZsMWwqk/BLkqti5k+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773828913; c=relaxed/simple;
	bh=CXh/U1ihuHA6LZF6ZGQCMi5uhNUQAbZHBzU1hKUTMFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzF+hDPd95S1GRKjEGuCcsRZ4q3TXMnNYuZqq/ZVA1PxqlCDJTWWrjRy1ryjo+lYJ4CZ+3AQ2xJ+wv1qEqZCa58rjWxJcxATJwuTHrNaCtPEMG6nPuHtsPBfUmYqQ9Qd7qf8aowhSeuIFNlYcITtAMBP+76vO/9AMBZGJxdyqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ofL7rmkW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZGgQxhz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rjiHoQUv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zNi9ATAz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED89E5BEA0;
	Wed, 18 Mar 2026 10:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773828904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+1VVGhqZYl71Og99PfHZP+p6IZxOUEQZFy5WoUgigA=;
	b=ofL7rmkWroXmYKoz4Ua0Ng9aWiD23VYMTe+oAM94VuC8FjaGtrGH8ViaxPXybcdulB3IG0
	Xsp4tzk5UZeNSk+kixuZaB2NXxG1iLKsT9W3nQMFpoAavAvZplb4vmmJKw3Rq6+2OYDROI
	CbX/XzgpCgTNepSzOq6nchfE/RyhRiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773828904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+1VVGhqZYl71Og99PfHZP+p6IZxOUEQZFy5WoUgigA=;
	b=QZGgQxhzYbmuX4YwkGig4p/vc01oUeu5h6o2GOfOinFTSFD0gt2587VSUYAURtDn4Ie+ZJ
	Bff//Q+taN13UbCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773828902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+1VVGhqZYl71Og99PfHZP+p6IZxOUEQZFy5WoUgigA=;
	b=rjiHoQUvoZDMSQhHowT/BCbJaXhP2+WNQDABqYfzDG4LDZNOOzx3N731mCeeIA7m17yxC5
	rw8Tit8gy/oR01L+c92WCRRNMBkwR+pP8emkdrconjMJgw4x1m6DXT68AIJz16tw94eU3B
	Z1MSzhFu6xsdLG2a7e6eGgpCSbIw6/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773828902;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+1VVGhqZYl71Og99PfHZP+p6IZxOUEQZFy5WoUgigA=;
	b=zNi9ATAzAXLwGbQsQYK4mOsbjiq3CKVJuacz2Df4c48Ic+wRBZYYH5PMEcyvNO7nBLIAMv
	FxF9ZYyB6T7/EIBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EDEF4273B;
	Wed, 18 Mar 2026 10:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +1NDCCN7umlvWwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 18 Mar 2026 10:14:59 +0000
Message-ID: <cac7dbac-3c6e-498c-b640-478b0e6adceb@suse.de>
Date: Wed, 18 Mar 2026 11:14:51 +0100
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10 net-next v3] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 netdev@vger.kernel.org
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Selvin Xavier
 <selvin.xavier@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Saurav Kashyap <skashyap@marvell.com>,
 Javed Hasan <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
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
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ryota Sakamoto <sakamo.ryota@gmail.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Kir Chou <note351@hotmail.com>,
 David Gow <david@davidgow.net>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-rdma@vger.kernel.org, oss-drivers@corigine.com,
 linux-scsi@vger.kernel.org, gfs2@lists.linux.dev, bridge@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-afs@lists.infradead.org, linux-sctp@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net
References: <20260317140141.5723-1-fmancera@suse.de>
 <20260317140141.5723-2-fmancera@suse.de>
 <69dd007c-16d3-44c2-bc30-4e7f5a95addb@oss.qualcomm.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <69dd007c-16d3-44c2-bc30-4e7f5a95addb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,kernel.org,linux-m68k.org,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,HansenPartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,gondor.apana.org.au,hotmail.com,davidgow.net,blochl.de,vger.kernel.org,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-1143-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[69];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-m68k.org:url,suse.com:email,suse.de:dkim,suse.de:email,suse.de:mid]
X-Rspamd-Queue-Id: EF1932B9B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 7:51 AM, Krzysztof Kozlowski wrote:
> On 17/03/2026 15:00, Fernando Fernandez Mancera wrote:
>> Maintaining a modular IPv6 stack offers image size savings for specific
>> setups, this benefit is outweighed by the architectural burden it
>> imposes on the subsystems on implementation and maintenance. Therefore,
>> drop it.
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
>>
>> [1] http://www.linux-m68k.org/faq/ram.html
>>
>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> Tested-by: Ricardo B. Marlière <rbm@suse.com>
> 
> That's a Kconfig/defconfig only patch, so build system. You cannot test
> it in a meaning of testing code. Building code is not testing.
> 

I do not agree. This isn't a Kconfig/defconfig only patch. It is taking 
down some module logic like changing module_init() to device_initcall(). 
Indeed, on v1, this patch was introducing a regression as it was using 
fs_initcall().

>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> You removed important parts of Ack. It was not provided like that.
> 

Sorry about that. I will make sure to include the # arm64 on the next 
revision.

Thanks,
Fernando.

