Return-Path: <linux-sctp+bounces-1073-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H/8GOSYsGkukgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1073-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 23:19:16 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D864258D7B
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 23:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2BFD43053CE1
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 22:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED67A391E58;
	Tue, 10 Mar 2026 22:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RBIWZwwe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+noIFjW"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968A346E50;
	Tue, 10 Mar 2026 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773181146; cv=none; b=q1aJXFscpzmHzy/e3N7fpCN4Lyt9mQ1KgtkN4eFW80cPwD11Do+I53+i/ZpicHM6Gqy0Y/Qu//UK/YqJ5WAOwArOhDCRwvxJPm5QULNzFJCTNmaL2vl6DvPtHldogrevwY5KfjdigvGSFU42dY9egd7grTKaXOqY2+x1Ilj4sMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773181146; c=relaxed/simple;
	bh=iJDAvNQWfTXa/d54rND70rOy1C42f+AfmZ9GTZCuIqQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JO6QY0WQWPDsMel5lrPEO34YhYUm2SD1yuhdpghYpl+brK2i4kH9Xh/ThMY61bCftzs+oUuxGy+hqEKhBczv8x64vWm0xnhYa765kn1diDEo+c3ItSlZNBI5Za/dN+oEVijkkl9zE8yeFzBPTkF3Km5hfWyJtrCkbRlGVXjgQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RBIWZwwe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+noIFjW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13189140021A;
	Tue, 10 Mar 2026 18:19:04 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 18:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773181144;
	 x=1773267544; bh=FRlgnoZcWgoJlJFqsFQjQT0OGLiik2V/K6MtiEBUEM4=; b=
	RBIWZwwelBtW10J+dVYS5KxWLYY+Z5KYr67R+cWTV7oxZTv749/mXXRIVeTn+H7r
	GxOX8R1vpM/4BWx9WXCn52aKQQf7Q+QqOKu/4RF/ZuN5lLTD5Dxx8jXeTxTNcULJ
	3BEdBvl3GXqURyW3odtt3p8xWgE3oC/oREzqZEoAiVNOWgwpCJ7crrRUyBEhAVZI
	vlHGARaFW1BJ7ddZSAm2xvDLFDvqHpuAAdz162Az2xtFyMkbXhTnQetXvA0XsbIl
	Qg9mbenNjEbbMeKEwbX/P9bC5uV6xjLOmWYDgCQ+AQXOmkUkf20R8cdFbeQY7UHi
	Bb4JfK+EU6ISGvpHgENqdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773181144; x=
	1773267544; bh=FRlgnoZcWgoJlJFqsFQjQT0OGLiik2V/K6MtiEBUEM4=; b=Q
	+noIFjWXCUrp3h0mxD7ppfVOe1UO+Vk7K4a1Yt/GNMGtSs8DP//5YAWcrCudmb41
	P7NoEAuiAb8DUoQ4IRkMSwdpQ7ToF/oD9QaaiqGkpPIEv5xx5ZdfuJw/NMB+XUCs
	pm7bgWLAVR7hF4/p/3rFkwhdq9YUcI6nFjnbynII3Yhc7YsBmluxVnPYCalEYQ9X
	fuIkt382YG4TL7A8i8IOOVGPgmyXabQG0wsJSxVXwid7nU+m4Rk4051k7VIRiexz
	S/CXCKMv9bfSsmjr6OANzMJulZ5Fr4ZYuFKf/5EYs1OIgQJRRnQ7rxaT+eyOjvqR
	QU/tn0ahtRPn9ImmbhiwQ==
X-ME-Sender: <xms:15iwafNpRAgTuD_NUtH5iWgTrmT8y0tX5mBrGDiYjk59bTEv8kacXQ>
    <xme:15iwaUxC5D12tx0Ymltu00MT7vho8q9aEZWYTPxyHeiLt4fWBscd_upno1egcnsud
    tmQbBgIEJQpP5DfnjuSVUYnxaHfET5TBqOjZjB8fKVR18oRO_RWZo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedvvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepteefudehvedutdeugfeuveffleduheehfeehffeujeduledvheeivdffleffjedt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhtihhnrd
    hpvghtvghrshgvnhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsghjohhrnhdrrghn
    uggvrhhsshhonhesohhsshdrqhhurghltghomhhmrdgtohhmpdhrtghpthhtohepughmih
    htrhihrdgsrghrhihshhhkohhvsehoshhsrdhquhgrlhgtohhmmhdrtghomhdprhgtphht
    thhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehoshhsrdhquhgrlhgtohhmmh
    drtghomhdprhgtphhtthhopegrrghhrhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghp
    thhtoheprghgrhhuvghnsggrsehrvgguhhgrthdrtghomhdprhgtphhtthhopeguhhhofi
    gvlhhlshesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhhmrghlohihsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:15iwaf-Kf6MeOapsmweEsqPwg3eFKiZQxijFSW0urK8Q7sozvfC3Sg>
    <xmx:15iwacIPsJSGfO64l6EvH6QccwUWirQM-76oJVl80W02oxD_gTV-gA>
    <xmx:15iwaSdFtRRhbAQ1DIeWCBhheGcHHYjmZ3FtJNyxsTaFVZZnTDqTQA>
    <xmx:15iwaZbSe1UzVDHdUMe9n0Fnk2qwzCF_kNeCwUkf06zCOVeodNyh_w>
    <xmx:2JiwaTKBIBeG4hh0HFeirOoWkHEfY8wvJ9daeDikHitZKM9-1D4LqoaB>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 173C2700065; Tue, 10 Mar 2026 18:19:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aes-ty0OVaaR
Date: Tue, 10 Mar 2026 23:18:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Cc: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Fernando Fernandez Mancera" <fmancera@suse.de>,
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
Message-Id: <ebebb003-f7d7-4659-8248-9d36e9c2c26b@app.fastmail.com>
In-Reply-To: <87bjgvpenh.fsf@miraculix.mork.no>
References: <20260309022013.5199-1-fmancera@suse.de>
 <20260309022013.5199-2-fmancera@suse.de>
 <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
 <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
 <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
 <87bjgvpenh.fsf@miraculix.mork.no>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in only and
 clean up Kconfigs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D864258D7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1073-lists,linux-sctp=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kolla.no,kernel.org,suse.de,vger.kernel.org,linux-m68k.org,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[70];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	NEURAL_HAM(-0.00)[-0.819];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026, at 22:18, Bj=C3=B8rn Mork wrote:
> "Arnd Bergmann" <arnd@arndb.de> writes:
>
>> The list does not include openwrt though, and I know that in
>> previous releases, there was an optional kmod-ipv6 package
>> that could be left out of an install without rebuilding
>> the kernel.
>
> The kmod-ipv6 package was dropped in 2016:
> https://github.com/openwrt/openwrt/commit/33beafa8d88e51907acba6fdece5=
a35f509934df
>
> And IPv6 was unconditionally enabled in OpenWrt in 2022:
> https://github.com/openwrt/openwrt/commit/832e7b817221d288df76b763ca12=
c585365db5d8

Thanks for checking!

Not sure what the commit log for the second one is trying to say, as
there generally was no build failure in mainline for a long time

But if nobody has bothered to revert the patch, it doesn't seem
to have caused any problems.

    Arnd

