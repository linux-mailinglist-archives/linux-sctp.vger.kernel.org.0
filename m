Return-Path: <linux-sctp+bounces-1200-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFyVMdkV8WkcdAEAu9opvQ
	(envelope-from <linux-sctp+bounces-1200-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Apr 2026 22:17:29 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD7C48B9B2
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Apr 2026 22:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11D4A30293D2
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Apr 2026 20:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D1931327F;
	Tue, 28 Apr 2026 20:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlhTZCEL"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA422E7F20
	for <linux-sctp@vger.kernel.org>; Tue, 28 Apr 2026 20:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777407354; cv=pass; b=n53pZmu/pYAbd8Fhc3VgPG/GuD4oLYxwUwNgNDM9O4URtytDtia48aGPuEGbCZQC0BsnKgWQiwqlCHNpjo1bSdbuqgs5eGa09UTtTI/iEkux7opnfAXtsUDW6qmTpJ33WnzlrAsDdzwjy8VdYGuao6cNCg3TVDYbHxsu+jaajx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777407354; c=relaxed/simple;
	bh=jubsY6PGHnTXGhA5KKyDi/LWS9PbjTsPha5xbgCuu/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcjcT6rr2t5oltJf5MBanZGTM+8puySF1Nora7X8u/Jt6IlU2oMecEHGCajrIDWl16RJjGWVhlmyayMnLa9Snh90On0TdmWUHRiRtgBHypMzMkj+wz7iRIK7Yk8oeKqMtRm8Bz+XHiPuaHBNNYAfHB2i7GFIkSTiXeECFlvCvok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlhTZCEL; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824c9da9928so5771393b3a.3
        for <linux-sctp@vger.kernel.org>; Tue, 28 Apr 2026 13:15:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777407353; cv=none;
        d=google.com; s=arc-20240605;
        b=A2F1e3AzPm5MiBAxBjVFjXq03syw/g6xAFG0HAbLSioCrcRxSeuJqImhrBFCrLv8ey
         pLXBlvRlaUgHCkQsbUsIJjUx8tl3gcCOLkFe+ddv7l/8YbyRJ1mb1lu6lPHrc/tgbuXH
         mwStbhXWDLiAc7JBE1GvVQVn+/E5YxNmKIYFdlZGtp0ZcKw83EK2fVtCNRBmHKgqv71N
         b1MePs9+UBshczm0LpUUkUYAkuUSKJNbHOgi014gaGu28nvnmaFtPhQOA6JNHwFai8Na
         7EWOrQ+jgNqqYdw/pdO60UIa1AS0+kNkBSEmTKUw+w/Ypb8tujP54BvXhTaNjKjKo4QJ
         RiBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uQV+ZUo0kltumkkS/38YnBQvpZ5Ru0K+aNTeRpdyz74=;
        fh=rve/7b8FOZo/g5pZ8wi86/mlYLWp1iyVW9kttKHwP98=;
        b=i+IjFg+7SpJ8T8DyWMS8VTgQfaPKlTyyi6562pgzObYGY5RY18MpNUxYVU52UjJ+mn
         dWeZjMJbt5zZFH+0n3Ay6UFFZh8ixrEHfBU9801jEBvftBKKC0UYyDariKHnv117P3dC
         XqTTBUagLMw/5nRmQGTv50WlXyKpd8BHyrz/AiSTTcfUvLAq80nhgLBnHJhN0L+a626K
         c8shciZvzu5M4jjxB6ji/dZ3tzMf7koszT7am2hDYOjKZea+ScBWRj7xM+D3yGmRyQRW
         O7UhRV8MAqq2n3vxGI7zVrak1DrS06e6T2+fLhN/lEStdQyvIE1h+22Of3pNe7FI3Jey
         TVHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777407353; x=1778012153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQV+ZUo0kltumkkS/38YnBQvpZ5Ru0K+aNTeRpdyz74=;
        b=KlhTZCELSkeBlc2IBRjM/spYNSJcZEx+XzogZUf8EXFJF3JgePK7hmDvz5NuTFJiJv
         0BK3ai6GXs6Ba5FV/d4g1cdK/BL6ls/W71AfgslX1RqhbkmZGwqATBsS3wGqmGeH6nb/
         xNU61DVSE4tbJYhfIKjDVbPYfQHKGcxwSbWUEqeSX2GlYVe7n1TWGmwLyTSdTy2lzZnj
         VNdG2g0+RgBVVsWPCECBHC8P2dK1ajWkNZH/0ZwWaclyCSZEiTKU6Gl1JhiyMvC/Ti3k
         KiEHqJicHui4HFNs3+FoX2afrvltIR+2kaN7IlVkx5wnlKskFTKJ6aVIH+p0ujd5d0bl
         zUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777407353; x=1778012153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uQV+ZUo0kltumkkS/38YnBQvpZ5Ru0K+aNTeRpdyz74=;
        b=emZf3mHeMHVko4iKwBq6XkEI3nXQF/2+QbQo7FPsKj9hsyab0PO5o8flQjnxHC705I
         a8P7DUm/L4NBHlJF362PMCue6ohN06BXpbireCphyUIUES7LKvVMp5/dfbSGz9WismWn
         sCmWqODWPo6fHunIgU8854YMbho7K6mBgy9W8UZDXbd0PKoGogQjzNvHzReHONvQUdlw
         IccNmF4bSKlefLLPqQePSgFH+4iMv4gyxUtHfKXcR7NDX9BgiYbV9yUGJDcy5w8uOUEP
         X9ST+C/d/1Q9pf6FLPw7bLh9Oo5e0vZLatS4N3Mv4maJegt6tD8s4JFKAoYIfJh4YAdu
         hVbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+cL5/ZuVJXhTxgpvWZa/XKRLoTHUybRWmWXzIbFocJaZhNvlp3MAMo2V4ikFJgEjwQMQKV7pRrDht7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fu9sXKJuGUNMWLYsbrMLXubyM76UGO6aBbPfjWH9bvAwtybY
	aLZBzACXS3hlGYKKfeBMnp/DhbGj87MfVQh96eSQbum4iYJIDxHZOYmBibi4BxH74NX6gFwPgq1
	O/OGD2mXesmhn7klak/17MHGNV3c93f0=
X-Gm-Gg: AeBDievYibz1pC0FQl3PbSsZqgfqThj0JkTNCd2FtbNGyRjVJUYTM1Y6ClfZfOCQpjR
	UoTUhFXkE1ml9hQIAiB5W7Gnl9FPBj3Unv07Qkts64SuqsccCrgUD07N5Co3EKbHK5l7x+WSqRc
	PUmbK8BjF3J1F36FdHX5uZq+4w7Qrn/jVNKOY9TfcHFaDTGMzbPs5+2dgbJxWveiIfd5f4LuXhC
	0ofUAphHaELpl0mMOOmbsuF2+bH1WfNLZUMuNjmyElrh7OE1M5KfGNtYGIcyw2vfU5XhkB4ldlo
	wgLAXaJDoTRxqQYbnmeSdE/uomx9UEtvCWl1KZ6qvmRjvArKVlR7FtQcoFSAL1tFL/De66Vn9eS
	+UwuJ5vWvr5LBIp4Vyi2mQequWO1JszSsAjsvock6nUPqpfAqhQ==
X-Received: by 2002:a05:6a00:f9a:b0:82c:2155:5b6d with SMTP id
 d2e1a72fcca58-834ddabdb7dmr4872052b3a.12.1777407352913; Tue, 28 Apr 2026
 13:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777214801.git.lucien.xin@gmail.com> <20260428140642.GT900403@horms.kernel.org>
In-Reply-To: <20260428140642.GT900403@horms.kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 28 Apr 2026 16:15:40 -0400
X-Gm-Features: AVHnY4Kx985VXS0AEmk_DrhzVNCcnQW-CWSjNlk5dYUnFRn6jZWfAV-j5B80K0Q
Message-ID: <CADvbK_dNRkb8UeGi+x=HhH+tJZSpUTDyHdQLDxUQA1dinbaFNg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] sctp: fix a vtag verification failure caused
 by stale INITs
To: Simon Horman <horms@kernel.org>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Yi Chen <yiche.cy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4DD7C48B9B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1200-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 10:06=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Sun, Apr 26, 2026 at 10:46:39AM -0400, Xin Long wrote:
> > Similar to Scenario B in commit 8e56b063c865 ( netfilter: handle the
> > connecting collision properly in nf_conntrack_proto_sctp"):
> >
> > Scenario B: INIT_ACK is delayed until the peer completes its own handsh=
ake
> >
> >   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
> >     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 392221640=
8]
> >     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
> >   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]=
 *
> >
> > There is another case:
> >
> > Scenario F: INIT is delayed until the peer completes its own handshake
> >
> >   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
> >   (OVS upcall)
> >     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 392221640=
8]
> >     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
> >     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
> >   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
> >   (delayed)
> >   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]=
 *
> >
> > In this case, the delayed INIT (e.g. due to OVS upcall) is recorded by
> > conntrack, which prevents vtag verification from dropping the unexpecte=
d
> > INIT-ACK in nf_conntrack_sctp_packet():
> >
> >   vtag =3D ct->proto.sctp.vtag[!dir];
> >   if (!ct->proto.sctp.init[!dir] && vtag && vtag !=3D ih->init_tag)
> >           goto out_unlock;
> >
> > This happens because ct->proto.sctp.init[!dir] is set by the delayed IN=
IT,
> > even though it is stale.
> >
> > Fix this in two parts:
> >
> > - In netfilter: Do not record INITs whose init_tag matches the peer vta=
g,
> >   as they carry no new handshake state in the 1st patch.
> >
> > - In SCTP: Prevent endpoints from responding to such INITs with INIT-AC=
K,
> >   ensuring correctness even when middleboxes lack the netfilter fix in
> >   the 2nd patch.
> >
> > A follow-up selftest for this scenario will be posted in a separate pat=
ch
> > by Yi Chen.
>
> Hi Xin,
>
> FTR: There is an AI generated review of this patchset available on
> sashiko.dev. I have looked over this and I do not believe the feedback
> there should block progress of this patchset.
Right, the feedback is false in practice::

- "No response" is not a clean signal
  (could be loss, firewall, rate limiting, etc.).
- Even guessing this init_tag does not let attackers hijack the association
  (they still lack the correct verification tag and state).

Thanks.

