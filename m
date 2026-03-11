Return-Path: <linux-sctp+bounces-1084-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HEfJpgosWkBrgIAu9opvQ
	(envelope-from <linux-sctp+bounces-1084-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:32:24 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A015D25F600
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 09:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 681763003BFD
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 08:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5301C3F0C;
	Wed, 11 Mar 2026 08:27:22 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F811DF258
	for <linux-sctp@vger.kernel.org>; Wed, 11 Mar 2026 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217642; cv=none; b=F36CA0w2MGBSGuPB3K9LgP2kmXIrnQjUNzDmFcr5J0NvOJx5CAEUOQk1XHEM82hwxGwa+WJcCIctrNAYzxo+X/q2TXnCv0svwa3nHYdTT3cgo5UZzVmkupCrnFYqYEoAY0ny1/Sirc/q7b1OphYmU6g+qx+5DuX+S81XAqSbnqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217642; c=relaxed/simple;
	bh=62QCpDXQ19DuCkEVmsTIfiPIA4bbzZLKZDd0zU0n8k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTkKStsprA+jiYRO7xB4qT1DZis14dctF6OrzG0OF0lOp32nV/RDOhSVGp9TzntQDqlQCqigmGfE/aklV9HomSETDvfo27kh3Z3xzOS6BnT8op95UBPan2KuDqrIdMW/O/T13SMooadVcJF3nvmL1BtkbyOqWT548oyuYeEo0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cd75abd09dso529656785a.0
        for <linux-sctp@vger.kernel.org>; Wed, 11 Mar 2026 01:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773217640; x=1773822440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OPUxC4UVYYzFR5WbkDP1rfKgT9C5RxhWe2cP85gtoTg=;
        b=pkheygenseFxMylq0yGKX7i0qtLy4yq7Nrs6y5MumAlLqAo3vv9udwWcp8BnYLPUpK
         2mUt1jD803B3CLNI/1PB7z/Wo+rIpkAif9LVQBY/nDwGoEXDM8tCZewpx9qWW05MKLLR
         l2JISs4NNx5194xhzhtG+ZL7JtrM5QyI/yOiw4ZttQ2VmPuTJ2IiZGJneQTF6IKJaous
         wpur87oAGayfQ29RzRj6HdLf+ISfZFaWES1MXBee6xhiit0L3mF1JOWfO4ADkzCjnxN9
         4qaxL/sr8HKElioCmQqjmfOtx8ALS6NOYtQ1oRqym1XvNGJXy07ve7lcX2TioqS5Qq1x
         TyjA==
X-Forwarded-Encrypted: i=1; AJvYcCU+nWNpaBwr5WFHIc2L+633duoKBhlBKkrH44N7/Gb2zxEqkBUzkoBC6+pit3K43vUY+ducNgs49BSA@vger.kernel.org
X-Gm-Message-State: AOJu0YzQijUBAnO2SKvw+cbD3waOA9KK5c3Dkz76j81XoTsWaL5TtyUP
	YM1ApOw/yP3tqG3f0uQ0XMVxH0IRCZ3C1rZL46//1xesxm2kDm0NFbKYL1hQq4HH
X-Gm-Gg: ATEYQzxkEXmmEsc47SCTl22KFQLiSSYX9lkzLk2liOAIHJeGgbp32iiqiysk+hmriZ8
	ClFvqtCp5IoHTPiBMgj8MDhvuGOwMQoF0BhFGIX05sxmlFDkF0mqM14jnxn1ELl8nroFmRWBa+u
	+nBzR9J7IlfnGiqdvD2uscMkBpuwEFKMjIFbNF301DDzFgzn0LlLzecznLshRKD+f6C3lqb5WeQ
	Z1W9haJm1O/3lPL+Mk1zwPn0iC9Hc777l1RFF6ofiEkYZ9rU8+yF8OmANcz/meHPz6sDaCD4UL6
	liVjmDLPJTcnKPpwbro3c5LIg3GizYnhbythTcL0Q23VbGJeFU5ELqsHy3vtlPSs49yLoouoiy3
	UybGXD1PUxU8+CgRkOFFJueMbIu6VxxIsQrBiHNYEA/ajAbcvBihPLPeZR80oO/NbVwev0BS7ue
	jLpn5HSwosnMmWaG6515h3OYzIJkgOfKW31Uzwgej1DqdZtgDrijXXDmgnW3qZ
X-Received: by 2002:a05:620a:4493:b0:8cd:9a1d:4de with SMTP id af79cd13be357-8cda1a31930mr213801085a.50.1773217639822;
        Wed, 11 Mar 2026 01:27:19 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda216944fsm90995885a.50.2026.03.11.01.27.19
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 01:27:19 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a1347051aso151498346d6.2
        for <linux-sctp@vger.kernel.org>; Wed, 11 Mar 2026 01:27:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURsB0g5T+bcoKPTUDU59yKOMBgrcuyKJPmtWa283A51A6Z1NaSJV0QP6L7pl4w6IHo5gs1GSmsWRJ4@vger.kernel.org
X-Received: by 2002:a05:6102:290c:b0:5ff:d192:ff22 with SMTP id
 ada2fe7eead31-601deec1db1mr739173137.19.1773217280031; Wed, 11 Mar 2026
 01:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309022013.5199-1-fmancera@suse.de> <20260309022013.5199-2-fmancera@suse.de>
 <01a4936f-77cd-4c60-a1be-cabec872a2bb@kernel.org> <e54d887c-5a70-b8c9-aeef-433c5134dd14@kolla.no>
 <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
In-Reply-To: <5c4b6043-a484-479d-83bc-a86ecdb8f810@app.fastmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 09:21:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWec3Xwi1ma22D_eqs3OqRJXEt4=YmWvO2MgtBdSpNuqg@mail.gmail.com>
X-Gm-Features: AaiRm52Q0QeELW2kE8F3ZB9XQa9qhSRDKWOoNuroUdAnxhN87qOfxCDKsawyRAY
Message-ID: <CAMuHMdWec3Xwi1ma22D_eqs3OqRJXEt4=YmWvO2MgtBdSpNuqg@mail.gmail.com>
Subject: Re: [PATCH 01/10 net-next] ipv6: convert CONFIG_IPV6 to built-in only
 and clean up Kconfigs
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?Q?Kolbj=C3=B8rn_Barmen?= <linux-m68k@kolla.no>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Fernando Fernandez Mancera <fmancera@suse.de>, Netdev <netdev@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	"maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <GR-QLogic-Storage-Upstream@marvell.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
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
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Eric Biggers <ebiggers@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Luca Weiss <luca.weiss@fairphone.com>, 
	Sven Peter <sven@kernel.org>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kir Chou <note351@hotmail.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, 
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
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A015D25F600
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kolla.no,kernel.org,suse.de,vger.kernel.org,ziepe.ca,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,gondor.apana.org.au,hotmail.com,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-1084-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-sctp@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[69];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.801];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,arndb.de:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 at 20:58, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Mar 10, 2026, at 20:40, Kolbj=C3=B8rn Barmen wrote:
> > On Mon, 9 Mar 2026, Krzysztof Kozlowski wrote:
> >> On 09/03/2026 03:19, Fernando Fernandez Mancera wrote:
> >>
> >> It must stay module for me. Alternatively, drop it, but then some user=
s
> >> will be really affected.
> >
> > I agree. If anything I would prefer to see IPv4 be made optional (and
> > modular) as well, and not as something IPv6 depends on, it's (AFAIK)
> > impossible today to build an IPv6-only Linux kernel.
>
> My first feeling was that this is a bad idea as well. On the other hand

Exactly my feeling. That's why I stayed quiet for a while, and gave
it some thought...

> I found that the default changed from =3Dm to -y over 10 years ago, all
> recent distros listed in https://github.com/nyrahul/linux-kernel-configs
> use that default (the only two exceptions are board specific builds
> of Debian and Ubuntu for linux-5.x).

Thanks, that is something I was wondering too.

Obviously the world is moving the IPv6 (but having IPv6=3Dm doesn't
preclude that!).  From the other side, there is a trend to have as much
as possible in modules instead of built-in.  A larger base kernel not
only has impact on memory usage (and loading modules has, too), but
also on e.g. boot partitions.  Various platform-specific limitations
may be at play (boot loader size limits, boot partition size limits,
base kernel must fit in the first memory block on systems with many
small discontiguous memory blocks, ...).

But apparently even the Android gki_defconfig (which is not on the
page mentioned above?) has IPv6 built-in.

Back to the numbers:
  - base kernel: atari_defconfig (CONFIG_IPv6=3Dm)
  - with this series, CONFIG_IPv6=3Dn: -22 KiB
  - with this series, CONFIG_IPv6=3Dy: +246 KiB
Note that I ignored any defconfig changes in these series.
The size impact is almost the same for v1 and v2, but only v2 boots.

Each new kernel release increases kernel size by ca. 30-40 KiB on
average.  So a one-time increase of 246 KiB is not unsurmountable,
and slightly less than the increase between v6.14 and v6.19...

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

