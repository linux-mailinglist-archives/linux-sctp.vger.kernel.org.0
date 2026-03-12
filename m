Return-Path: <linux-sctp+bounces-1125-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EISHG1PmsmktQwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1125-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 17:14:11 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B257275584
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3464A304FF55
	for <lists+linux-sctp@lfdr.de>; Thu, 12 Mar 2026 16:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759ED3F23A5;
	Thu, 12 Mar 2026 16:12:51 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B93F7AA2
	for <linux-sctp@vger.kernel.org>; Thu, 12 Mar 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331971; cv=none; b=XBbB8El/Yyk6gOXXHSJ2diTtXTYSZurqIX/HJ4p5Mw12HNazFxg7ww7Dq+czdrfnzi5fLZOaKHwxDg3S3iwahJPZKrplp8/l5a6FPYK08kDru30PoYQjBNBKgYG1objx1rwbIUdhZ+I+qpIvc+Cv9+rug9EZlw8EvU2YFd/SYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331971; c=relaxed/simple;
	bh=J0G6eyWjCZe2EavnpoZMaa3QDnbvlnCWthcPft0y1xg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XbUTK/NbmLE6ra7nSSrK5Faed3f00BGADIJHEMx0KkX4edGhZYGX5p1t+bRvu/mT1UVBhrW/oKsAvRoLRR+sDZiljbmIGvwbkpZJbX4RVyC9M6uTg6VBt+GBEhEZ9KwWGCoGebVpL/lbubYMfw96022Ca2efQc8wIRWOSiL1BJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40427db1300so762337fac.0
        for <linux-sctp@vger.kernel.org>; Thu, 12 Mar 2026 09:12:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773331969; x=1773936769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8DuBIlRqwUybKw9BKko7+xZruw6jP0mIyTYZl7vHWM=;
        b=bVTKXI1M1RMPcy1kySqOQ1Etp7ZiTSIvNOnH46d1cnUhtTL6tu8nTZccZsYH1ePOt0
         Hf5rEYl2tb4DcvbtTBsCCkPfFJ3IVt91a/LEJUFScPR+emib5XJqY0ajRavh07WfhOxu
         GXvuKsv/AV44ImT9LDOuRgXlgxYo/c9gok2oyr/5Fhad72z/fGeNtC3l40LEjRqPWn1y
         BUDIRyFM4A64oBinE/o28XgqwO7b12clEJGp03mbE2iynwZkOr/x1kvFiIsmxKmFCEDo
         8c5vwu2O+FvUJ+RxXakzRCEn+qgbXzCxcoc/QY5d4DJtO15VAKWuMfZhOIiYGCRQhiOK
         DDUw==
X-Forwarded-Encrypted: i=1; AJvYcCXwg9yIL148MWqcK1QgSWVQylr8tVHCFLVe2Pttai+UeEw4K40bIMMaglRUXiACOsReiZBWr83SRXNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0a6n2k4yltuBgKp2plvgb1XCdzowCzoK6HeVxRtzBEfTZ+nVB
	VUsOPHqIHv0AZAWIXIsGmikXZaSdnpGaUFa5LG/gk7GHZ/asiprGy59Wr2yzV4IJRf0=
X-Gm-Gg: ATEYQzx3rKX7M82QStVqGsgnkj1HrS4l9RL6IyVdAHfjyudPMICeTUg0+sqtbDN5bEX
	6T2VLz02/EEpEiQirAQmkl7k8RnYj+x8ptqJWA5Y1KxpjVj+Jos1xtBXbjT0LpCaSCNTi5VY1IC
	eJG6XQA9BY+boudDPZzdmckfwOAJ9YLatRNS/KFKMAFCyBVeUuSDYvgqMPCJK0QhXlYl74Gh60J
	1M00FZKpAbwdlLhB7YQ+WUh7gUqikA7cGKLQlhukmiSAlUGCEPylp9S8N/t+5gxbWNRz0x/QIYN
	qnMIXx1Xj7QErbpHIVbUweirQwqbkfRjVSLcUq1v2Km+6/YrHcg8VwED805ygzfHqd4QcMtihZ3
	C1OeaoU+E1LySAK3QrBvc8l1jzMF7fp7z8G/SPatCCQlR8qL9RBjmowQDS/vW+6wq1q/oHEkzvx
	7kw9uZDkIpLecynWWX95qtm7xOW4zmC8/8vfhTGG612ckHmPRTfGR1litxQPqLoqDS6QmjRQY=
X-Received: by 2002:a05:6870:a109:b0:417:3be0:4e4e with SMTP id 586e51a60fabf-4177c8d3750mr3818516fac.16.1773331968737;
        Thu, 12 Mar 2026 09:12:48 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1f9f86sm5498746fac.2.2026.03.12.09.12.48
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 09:12:48 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-67bb5e4cf5aso777818eaf.2
        for <linux-sctp@vger.kernel.org>; Thu, 12 Mar 2026 09:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXmTAG++PiOu+tyzAI0dD2RLlr5NF3d9aW+Zz7bGYKtxJpcvQiKDi182HXw0SV+4GtW/UPPL7qjXVmx@vger.kernel.org
X-Received: by 2002:a05:6102:512b:b0:5ff:22f5:e37e with SMTP id
 ada2fe7eead31-601deb4d089mr2630417137.10.1773331557630; Thu, 12 Mar 2026
 09:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310153506.5181-1-fmancera@suse.de> <20260310153506.5181-2-fmancera@suse.de>
 <20260311200219.45796ec4@kernel.org> <aebac89f-f3b9-4983-8139-353a3ff19c98@suse.de>
In-Reply-To: <aebac89f-f3b9-4983-8139-353a3ff19c98@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2026 17:05:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWK0P+EEQXOQ8FMb7DYt-95dAmmbOjMhxCKHnvHRntojA@mail.gmail.com>
X-Gm-Features: AaiRm51vTFby3MbWyu4EKyWe_lBoIWwNWM0L5hUj3OB8Sdn3mba4moA7Rj12Mh4
Message-ID: <CAMuHMdWK0P+EEQXOQ8FMb7DYt-95dAmmbOjMhxCKHnvHRntojA@mail.gmail.com>
Subject: Re: [PATCH 01/10 net-next v2] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, rbm@suse.com, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Selvin Xavier <selvin.xavier@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Saurav Kashyap <skashyap@marvell.com>, 
	Javed Hasan <jhasan@marvell.com>, 
	"maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <GR-QLogic-Storage-Upstream@marvell.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Kir Chou <note351@hotmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, 
	Heiner Kallweit <hkallweit1@gmail.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, 
	"open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>, 
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>, 
	"open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <linux-scsi@vger.kernel.org>, 
	"open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>, "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,suse.com,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,hotmail.com,gondor.apana.org.au,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1125-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_GT_50(0.00)[68];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0B257275584
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

On Thu, 12 Mar 2026 at 16:12, Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
> On 3/12/26 4:02 AM, Jakub Kicinski wrote:
> > On Tue, 10 Mar 2026 16:34:24 +0100 Fernando Fernandez Mancera wrote:
> >> Maintaining a modular IPv6 stack offers image size and memory savings
> >> for specific setups, this benefit is outweighed by the architectural
> >> burden it imposes on the subsystems on implementation and maintenance.
> >> Therefore, drop it.
> >>
> >> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> >> dependencies across the tree that explicitly checked for IPV6=m. In
> >> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> >> and MODULE_LICENSE().
> >>
> >> This is also replacing module_init() by device_initcall(). It is not
> >> possible to use fs_initcall() as IPv4 does because that creates a race
> >> condition on IPv6 addrconf.
> >>
> >> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
> >> except for m68k as according to the bloat-o-meter the image is
> >> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
> >> this architecture by default. This is aligned with m68k RAM requirements
> >> and recommendations [1].
> >
> > AI has spotted:
> >
> >> diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
> >> index 31d16cba9879..de088071dde4 100644
> >> --- a/arch/m68k/configs/amiga_defconfig
> >> +++ b/arch/m68k/configs/amiga_defconfig
> >> @@ -64,7 +64,6 @@ CONFIG_NET_IPIP=m
> >>   CONFIG_NET_IPGRE_DEMUX=m
> >>   CONFIG_NET_IPGRE=m
> >>   CONFIG_NET_IPVTI=m
> >> -CONFIG_NET_FOU_IP_TUNNELS=y
> >>   CONFIG_INET_AH=m
> >
> > Is CONFIG_NET_FOU_IP_TUNNELS=y removed intentionally? This option
> > provides FOU/GUE encapsulation for IP tunnels and has 'depends on
> > NET_IPIP || NET_IPGRE || IPV6_SIT' as its Kconfig dependency. With IPv6
> > disabled, IPV6_SIT becomes unavailable, but CONFIG_NET_IPIP=m and
> > CONFIG_NET_IPGRE=m are both still present in the defconfig, so the
> > dependency remains satisfiable.
> >
> > Since CONFIG_NET_FOU_IP_TUNNELS has no 'default y', removing it from the
> > defconfig means FOU/GUE encapsulation for IP tunnels will be silently
> > disabled by default on m68k. The commit message describes only disabling
> > IPv6 on m68k, not removing IPv4 FOU tunnel support.
> >
>
> I noticed that when running
>
> ./scripts/config --disable CONFIG_IPV6
>
> for the m68k, the script was adding CONFIG_LWTUNNEL=y and CONFIG_NET_FOU=y.
>
> CONFIG_LWTUNNEL was selected by multiple IPV6 features. I do not think
> it makes sense to keep it for m68k given the information there is on
> http://www.linux-m68k.org/faq/platinfo.html.

Dunno about lwtunnel...

> CONFIG_NET_FOU was something IPV6_FOU required, probably it should be
> just dropped from the config instead of explicitly turn it off as it
> turns off FOU_IP_TUNNELS too. It will be selected by FOU_IP_TUNNELS too
> anyway.

... but CONFIG_NET_FOU seems to be just a gatekeeping symbol
for the tristate symbol IPV6_FOU, so FOU is still a module., which is good.



Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

