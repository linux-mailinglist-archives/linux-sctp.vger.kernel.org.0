Return-Path: <linux-sctp+bounces-1310-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdayEOXaSmraIgEAu9opvQ
	(envelope-from <linux-sctp+bounces-1310-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Jul 2026 00:29:57 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C7470BA5D
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Jul 2026 00:29:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=ASQSsxUH;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1310-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1310-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D6EF3007892
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Jul 2026 22:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA8372EDD;
	Sun,  5 Jul 2026 22:29:53 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1652FE56E
	for <linux-sctp@vger.kernel.org>; Sun,  5 Jul 2026 22:29:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290593; cv=pass; b=Ih38pgV1f0wFva5jtCOZgz/idMxRqlAhhyb9NTUAOXqVHI9mIpaYoueZUDNjEPFgHsLj8NbLFqYmSXdAequVmLV2y9ha9wEU7TMD16E1FSvGK2HVFNKl5U8GLD8fxKleIinM3QPRNolMT2+4+kJTGbDzUPjviHCok8mJ/GC9lfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290593; c=relaxed/simple;
	bh=82GO7hu8F510MGdXPvAoDzFO8wfMHHHBy7DdIo/Opy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpsyKwqWT4swHQWoNzY/XhE1M1rclR2a/A7yLkVq3QOF/+KmQeqtmeQ3Ao5as/Szrave9D27tj7AKMA9S7XycHl2k/JpaYs5WOGs4U30iNCbobf/9856br5B5vhekaxkdJd77ZpwJ5IyHmbFvRYwbpKZEaJxD4RCWeuUOY14mAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ASQSsxUH; arc=pass smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8478cc93299so2555040b3a.2
        for <linux-sctp@vger.kernel.org>; Sun, 05 Jul 2026 15:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783290591; cv=none;
        d=google.com; s=arc-20260327;
        b=eDWkIiChOOWfk4PILzmL4QUwrxmxffNPygkj4lLImPG3eGg0KjGBHDhHY3xYjL5zeU
         UgiQWYYbGDrSJWDlhWoHp0h371evDK5CxloI2nmQe2vgyCgjzrsbR22+2S/cyflTSBiG
         DK5lFOhN0DhFadhB4n5ApopbseM6G5xEpAoRIttAK+FD8B9MuZCgJzE54Wea2CxsiW6S
         OZf/UP30dIAKaust2E1bJ+UoN1tG/LjpTHQULDnRrfHOG+vsMvdzi83sh8k21fA582ou
         y1zmy4zre8X5i9UaoTOwR1xwKf7JFw1Qil6VzA9M6+WfCLuRUydP+aH7nSxIinPwbG0j
         kHvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UA8iUQiEy+NI5b2MnDL6j/liL6MwMgPKJZvHOO3c8b8=;
        fh=yMR7Ey/FddyCS/ry3yE0arCZs2WZQ1zZoHz/RI3kqJQ=;
        b=bY5xhIpiUOCgJ93bz/5g75cjN9fKTTaEmzEvWt1sV8mZBrB2IO31qd7+ot5zZkU8kb
         PKaGiz9Td/q2rhpboLSAOw9o6hepaPkm36Dl/j33Pt2we5FjXF6JZ3RAlvaAXTbXlKiE
         HGB0C+K6Oz2dCAb4UDGxsxkvu++28JN5+na5Hlcj4tUfO3uarw6LX6wAAi44Fm4RoC5D
         P7hXVImuxOlfXhWXLgkyHAbjvZ5taCPkGltdUU2u32xOrF8Rw71W8wn0hJSufeQhyHmW
         iFXv7m/Ry4XrA4DAsNPpX2B+ZrW0pCL8g+qRVh6g17hbrJ/wRD0DVrAXyJEAwUl/2x8e
         NHgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783290591; x=1783895391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA8iUQiEy+NI5b2MnDL6j/liL6MwMgPKJZvHOO3c8b8=;
        b=ASQSsxUH6SMnL9CFK99v3bJ93zZdpRXu88KSb93o6ce/cbCT+vSFGgck3j3SiPCXg/
         IcxHQE2Hj4wB+0skXuwkv/eQJ9smzbKhsL2LY75TRKzoxUqEmz+fVI3fI61HbgoQBBXK
         KU8K0n2AUtvLgxcVx/MziiBOJ2jPYD/a+sl3pV6X/xjjh5BOrrLXjDunPbVWA1pqCVJm
         HGygxrfANEmM5gXXFNZR0gwm86TBukDr0zedOrt2G09E6KAbNQHCLi2D58sxrwnlrDN8
         KWSk44vC/A81EH8mFJGUp3E6gs8lDuu0kDd6xHlgcJl/lbZM0p/W7s/3Z05KKOv5eTzU
         Lgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783290591; x=1783895391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UA8iUQiEy+NI5b2MnDL6j/liL6MwMgPKJZvHOO3c8b8=;
        b=Xcv77pAAxslugdNZYEwh9LtfFjvSGJ+ifgiQeRbgFmEdiyD29bqAGu+CFJSdFV/wf7
         j7atTN8G8hNSMmwskQ8NDCsrrGacSpYwDaSyhRwxaMOItuu5vaHCzhcaz1wPYeFvTxmy
         HedENFA0cwlEFL4CsDVtHOAjksHC1tS9E4I8naQ1Bz/ZBN0OjQYA1KGSxEz4IP0lPDVB
         HmkBFvyg/mTmZrg7uQQIhPWBIqEnptF014QmxtSj+/ZhYwzg1KrpIkC8NRu3WqEkVh/Q
         +U53PsBFJGqA/l5YeGpcpvzAHDAqIZl8B/mDdWKUkncG7+6d7IWMi9+zK8xvRf3iTSIA
         mdWw==
X-Forwarded-Encrypted: i=1; AHgh+RqTM3xckr0yABBaXDHIgGrk98f+vN1pPoLsUzwkw2CIKqsYW5j163iy8tURnAUz4SLBrDHcQBEEbFbp@vger.kernel.org
X-Gm-Message-State: AOJu0YyUobzZxsMMD+wYX9tUcVH+TgXbHESVG5P3U17vDUDhYrItA5DZ
	3XUt/bm9dm6ymaDrcUJHUlus/FEzpLVU0h09K8+07Zp1m9s/QUXFt4+/egE68xuV7qb4HzOknA+
	Q4FvKk3+6VRGoUZT8TDuE7vJEsi4hsXUGnPMZ9WRo
X-Gm-Gg: AfdE7ck6xG3ev5zR/72C5slcZj/YclGVULtSWAl6fWjEWHJGo9KfwMwicZtDiLSD2IQ
	AiDN3/iCBEpTQ3+jWq9fP46g0AfUmIao3IG5RZmHf5w/pYCoMdl+gRebAP2BoR6j8prVC9oNAQ0
	ccC4hgNCePTV01rzreh3ycrKAL/12WtogG8zCV4Aycv0WOSXe6fQ8hjVDjxO3+2QvqCksDxuU5Q
	HGZXDqnHRQOubBjEWFAYvazLjgOLBdL81fUXW7pTOFfozIUCgctiW1TEfbInZhdzXfuHULKEmKq
	kCwmIciZlJe3B6dlCBr7xPxbTA==
X-Received: by 2002:a05:6a00:9a7:b0:847:973b:3cfa with SMTP id
 d2e1a72fcca58-847f6da5baamr6872701b3a.15.1783290591595; Sun, 05 Jul 2026
 15:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705003013.1134430-1-xmei5@asu.edu> <CADvbK_cWUT2ygfBSW6qjgx9_y=bvksqG87Lp8edQcFT+3p9fOA@mail.gmail.com>
In-Reply-To: <CADvbK_cWUT2ygfBSW6qjgx9_y=bvksqG87Lp8edQcFT+3p9fOA@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 5 Jul 2026 15:29:40 -0700
X-Gm-Features: AVVi8Cc5H56GXXzsX9a9BdNE0H538_9lKNQJmhfjK2mq9-dPouAlLRRy1ehet_8
Message-ID: <CAPpSM+SaxP+HOA1aRBdHCTFFN-2q8oPhmN59J-VPV2F5NwJyAA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate the body of a STALE_COOKIE error
 before reading it
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1310-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:from_mime,asu.edu:email,asu.edu:dkim,mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2C7470BA5D

Thanks for the reminder. I didn't notice that Weiming has patched it.
Sorry about that.

Xiang

On Sun, Jul 5, 2026 at 12:13=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Sat, Jul 4, 2026 at 8:31=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
> >
> > sctp_sf_do_5_2_6_stale() reads the 32-bit Measure of Staleness that
> > follows the error header:
> >
> >         stale =3D ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
> >
> > without checking that the STALE_COOKIE cause actually carries that
> > 4-byte body. sctp_walk_errors() in the caller only requires
> > err->length >=3D sizeof(struct sctp_errhdr), so a peer can send an 8-by=
te
> > ERROR chunk whose sole STALE_COOKIE cause has length =3D=3D 4 and no bo=
dy.
> > It passes sctp_chunk_length_valid() (>=3D 8) and the error walk, yet th=
e
> > staleness read reaches past the validated cause.
> >
> > When that is the only chunk in the packet the cause ends exactly at
> > skb_tail (sctp_inq_pop() discards only when chunk_end > skb_tail), so
> > the read stays in-bounds of the skb head slab object but past the packe=
t
> > data. The value is folded into the COOKIE_PRESERVATIVE parameter of the
> > retransmitted INIT and reflected to the peer, leaking adjacent kernel
> > slab bytes.
> >
> > Discard the chunk when the staleness field falls outside the validated
> > chunk data.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >  net/sctp/sm_statefuns.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> > index d23d935e128e..e4b4b63162cf 100644
> > --- a/net/sctp/sm_statefuns.c
> > +++ b/net/sctp/sm_statefuns.c
> > @@ -2592,6 +2592,9 @@ static enum sctp_disposition sctp_sf_do_5_2_6_sta=
le(
> >
> >         err =3D (struct sctp_errhdr *)(chunk->skb->data);
> >
> > +       if ((u8 *)err + sizeof(*err) + sizeof(__be32) > chunk->chunk_en=
d)
> > +               return sctp_sf_pdiscard(net, ep, asoc, type, arg, comma=
nds);
> > +
> >         /* When calculating the time extension, an implementation
> >          * SHOULD use the RTT information measured based on the
> >          * previous COOKIE ECHO / ERROR exchange, and should add no
> > --
> > 2.43.0
> >
>
> I think this is a dup of
> https://lore.kernel.org/netdev/20260704033545.2438373-2-bestswngs@gmail.c=
om/.
>
> Thanks.

