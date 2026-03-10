Return-Path: <linux-sctp+bounces-1072-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFLMNtKLsGkukgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1072-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 22:23:30 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF17258361
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 22:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBC44302256D
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2026 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8B43E92A2;
	Tue, 10 Mar 2026 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="XehxLy1d"
X-Original-To: linux-sctp@vger.kernel.org
Received: from dilbert.mork.no (dilbert.mork.no [65.108.154.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679D3CEB9E;
	Tue, 10 Mar 2026 21:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.108.154.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773177768; cv=none; b=ZQj6jzHO4uOrUEIsub1O7OpDJ2HKg4gBfzqEtKgst9B4vT6vak2gevxUKnEYP27yqnIDHIk+/lzhzx+U/90LC/BYAJ9jX7gpcKGUh7GndNLVceSqarCh2Cgw29jyXOiItq5xmHUj34KJq8dMao5vG8PnQqUH2ByOzZiQzpzOxqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773177768; c=relaxed/simple;
	bh=uW/SHTU/bmzAxq69+5aquBUZCuf5Yy0XrivWZ/q8OEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vey6PaXBsbT/g2lLrKORr4n7judRAbM17OZ3+NZHdDWM4uMXPSUrWSNooKksAmQTzn6XH21aYacyXWUts43s9HvdqNsdk1CydtF8ARxO6EaA8jzO0JAAk6uDAkIBbVwjqCRDF9jh1fO08A9IzF+LQZppN1toISxCPeffCe3+ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no; spf=pass smtp.mailfrom=miraculix.mork.no; dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b=XehxLy1d; arc=none smtp.client-ip=65.108.154.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mork.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=miraculix.mork.no
Authentication-Results: dilbert.mork.no;
	dkim=pass (1024-bit key; secure) header.d=mork.no header.i=@mork.no header.a=rsa-sha256 header.s=b header.b=XehxLy1d;
	dkim-atps=neutral
Received: from canardo.dyn.mork.no ([IPv6:2a01:799:10e2:d900:0:0:0:1])
	(authenticated bits=0)
	by dilbert.mork.no (8.18.1/8.18.1) with ESMTPSA id 62ALICW34119410
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 21:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
	t=1773177492; bh=uW/SHTU/bmzAxq69+5aquBUZCuf5Yy0XrivWZ/q8OEs=;
	h=From:To:Cc:Subject:References:Date:Message-ID:From;
	b=XehxLy1dP2hexPsyxBZBiYDt/ZKIsdMfw6dXSR0tS4w+wHD4C7MuVJdRWjblVJ4vN
	 f1m6MVEq3Cv94mvAZbpeaPr7+ir8ONDcWdEb+OsChqmet/YhuA31w47Bmp/rKkxQ9s
	 rMW/hB/Ky4PFf0e5UjQoOJEZFR0hLcpBMaWErYd0=
Received: from miraculix.mork.no ([IPv6:2a01:799:10e2:d90a:6f50:7559:681d:630c])
	(authenticated bits=0)
	by canardo.dyn.mork.no (8.18.1/8.18.1) with ESMTPSA id 62ALIBSw285875
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 22:18:12 +0100
Received: (nullmailer pid 737464 invoked by uid 1000);
	Tue, 10 Mar 2026 21:18:10 -0000
From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?utf-8?Q?Kolbj=C3=B8rn?= Barmen <linux-m68k@kolla.no>,
        Krzysztof
 Kozlowski <krzk@kernel.org>,
        Fernando Fernandez Mancera <fmancera@suse.de>,
        Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Geert
 Uytterhoeven <geert@linux-m68k.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>,
        Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        "maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <GR-QLogic-Storage-Upstream@marvell.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Manish Rangankar <mrangankar@marvell.com>,
        Varun Prakash <varun@chelsio.com>,
        Alexander Aring <aahringo@redhat.com>,
        David
 Teigland <teigland@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Jon
 Maloy <jmaloy@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Luca
 Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>,
        "Lad,
 Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Gow <david@davidgow.net>,
        Herbert
 Xu <herbert@gondor.apana.org.au>,
        Ryota Sakamoto <sakamo.ryota@gmail.com>,
        Kuniyuki Iwashima <kuniyu@google.com>, Kir
 Chou <note351@hotmail.com>,
        Kuan-Wei Chiu <visitorckw@gmail.com>,
        Vikas Gupta <vikas.gupta@broadcom.com>,
        Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
        Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>,
        Markus =?utf-8?Q?Bl=C3=B6chl?= <markus@blochl.de>,
        "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>,
        "open
 list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>,
        "open
 list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
        "open
 list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <linux-scsi@vger.kernel.org>,
        "open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>,
        "open
 list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
        "open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
        "open list:NETFILTER" <coreteam@netfilter.org>,
        "open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
        "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
In-Reply-To: <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com> (Arnd
	Bergmann's message of "Tue, 10 Mar 2026 20:58:15 +0100")
Organization: m
References: <20260309022013.5199-1-fmancera@suse.de>
	<20260309022013.5199-2-fmancera@suse.de>
	<01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org>
	<e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
	<5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
Date: Tue, 10 Mar 2026 22:18:10 +0100
Message-ID: <87bjgvpenh.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 1.4.3 at canardo.mork.no
X-Virus-Status: Clean
X-Rspamd-Queue-Id: 5DF17258361
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mork.no,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mork.no:s=b];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kolla.no,kernel.org,suse.de,vger.kernel.org,linux-m68k.org,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1072-lists,linux-sctp=lfdr.de];
	DKIM_TRACE(0.00)[mork.no:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@mork.no,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[70];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,arndb.de:email,mork.no:dkim]
X-Rspamd-Action: no action

"Arnd Bergmann" <arnd@arndb.de> writes:

> The list does not include openwrt though, and I know that in
> previous releases, there was an optional kmod-ipv6 package
> that could be left out of an install without rebuilding
> the kernel.

The kmod-ipv6 package was dropped in 2016:
https://github.com/openwrt/openwrt/commit/33beafa8d88e51907acba6fdece5a35f5=
09934df

And IPv6 was unconditionally enabled in OpenWrt in 2022:
https://github.com/openwrt/openwrt/commit/832e7b817221d288df76b763ca12c5853=
65db5d8


Bj=C3=B8rn

