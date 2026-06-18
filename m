Return-Path: <linux-sctp+bounces-1273-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KPSeKr1sNGpfXwYAu9opvQ
	(envelope-from <linux-sctp+bounces-1273-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 19 Jun 2026 00:10:05 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F17026A2E6A
	for <lists+linux-sctp@lfdr.de>; Fri, 19 Jun 2026 00:10:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LOB43kn/";
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1273-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1273-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A99301ABB0
	for <lists+linux-sctp@lfdr.de>; Thu, 18 Jun 2026 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0909328641E;
	Thu, 18 Jun 2026 22:09:07 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0B221F20
	for <linux-sctp@vger.kernel.org>; Thu, 18 Jun 2026 22:09:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820546; cv=pass; b=AHWHkwr2tPpctD0hbMO2AIiTHP2BV0//2zGC5G5uMcW/4cUlZPYttErTPQNrlZ95GEkNmRWgHv9MDeHIz51etjk3fN0EqInjLobl2IFNaOpuT1t+32FYU7p+ov9ooD1iLVXYgkYq+l88p/Splnbg6iOdQUc6h0HKM8V58AKSSkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820546; c=relaxed/simple;
	bh=FP57ixB6vas9YSLhEpafEgUrTpTmh6IMV95sPY1Cm/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYC7HkTLhA3sNQVza/fRRhwAbj1P/ccuWIwFs11xwxXI+9Kde/GlsobQcue6rpIG6zqw4Ba/0N5YujaTwC3BvKXcMynUWctGoR5vbGHH5At2JMFuIRUluQQLE4GDOHtb6OcCp9V+C4KEdxLG9j/pgC56FWlz/HH7f+1lnQm7zpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOB43kn/; arc=pass smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-845397d1221so980971b3a.1
        for <linux-sctp@vger.kernel.org>; Thu, 18 Jun 2026 15:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781820545; cv=none;
        d=google.com; s=arc-20240605;
        b=OafiB6JJ8wXC6QrFBsVfouGWgsAgjFCCHXlCWfmZs5WYRHbWLVWfjudd79ew623XUn
         ijp+Ll9UJ8hZ1EE/+bboUv2xgUH9s/CY53naoEIrKkdrQOSUy0PYO2tvYGba3mjFSkEx
         8iriFnLDxL1/lhsPmx+F8oLxUZS4stBz4/gnWzlYE7k7zuAbbezpYFK+mwZHV53sGAOr
         9NnoxtC4sMhwGGx89H88jrS0Xe6g26hF9Vz2A729VaC+utuGeNlRkOzJNyE/9S0baPSd
         bDMYfQe4I80g/S9w6Zrc8O4NqqjHQnOBKK90yArekyxjqb8Z/a163MFaXsMA8HE/7DXa
         wn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAlFSiEpASE+H9CxsPg4DvwVnR9n4xFOZ5gXGl5r4bo=;
        fh=5xJdKxz+CKst/i6dt03QNWjhQCHx9ZUx9koYXBuYVF4=;
        b=G4RkzOrsIwX5dmYTT8YOSVsATT7QGp40RDdHDRmGq/mKMRvCB49DcB3EBwZ2TqLBmH
         VEAmPul1vsRRbZE3eh/42WyJjnCWVJjR+AwbEEXCjGSplJWfKLhoUS9WL420WyOihlJM
         yJno0LVD8D3b6N/Zo8AEKJ27Q01kbLEkWRIS+clCitlVn5i4ittBR+/Tjwt5MzFlmXPQ
         CkzQRwm3JjnuuUlPG8gXl7ZhJ63YbXHzAQsQTaz+nbofKHnpHLtqbeCw+jz/pJx0hJq1
         kgLwowWVi4yw9xVjB3U+uTW0d2XsrrRcEwL5Um34fEEm5VGYb94f6F3QoUb1tlZwBaig
         P03w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781820545; x=1782425345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAlFSiEpASE+H9CxsPg4DvwVnR9n4xFOZ5gXGl5r4bo=;
        b=LOB43kn/cSy1dW5r6NJK2VpvtT5A8nlJiboLJdOPm1Reb2ZyEtxR1aFu3CU/m4yK4e
         grNc1Ioe1Vq5FKksqJO7lLki7OhnD6lhb5aRgOz1Ot7gSS0vVX9OI8zCpdR29LIa+ykF
         tm2qHGddVhTXQ+HoQNRlyk9UxaZVlFdi4g91GNK9xF1Kc7NExSmhqvD87TtnaHtPFqqn
         BTV1EcNXYvRt8rTPCbv4vCYPYBauyJ4SS1zNw2Q8tPCuNRjXh2xbBsj+PJUByU3WD/W8
         LiOJZ+rKxcpWASLzZuIF4XSDf28McR3e7n9ESRorhvHeC/6DlghDq6JqUbFDUu073Io9
         LnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781820545; x=1782425345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAlFSiEpASE+H9CxsPg4DvwVnR9n4xFOZ5gXGl5r4bo=;
        b=YRj+PRtG2/h660RiFDFSKcDfxTXo+ZKPSoK6WTX+GjRulpfLvtESXcY2qPEiRBMsYk
         hez2PbobfrzsVliYD8z8Qjbc+djTzXkWwlhKcD7AlohCRBjaEhQk9QKGBr7bOK5frhKk
         HthB5ur0+6ktkbKPFDcQpWW3gySa50JyB0O4pXHem5eiHZFrcPmoU3Ps8UEhgmLMhlne
         +nBQEdmvde7QnpmXdIpj4lWWtYyhfxrBBzzQeOqe1/kgBMVJt5umPGdAsWsp/xvWQ6Zr
         +d5bvuQiM+RowRst3wPO1imCGmaYEKjphsmPFrlx1aqqMSA4C48If2fWKylxAaVuQWlF
         ohTA==
X-Forwarded-Encrypted: i=1; AFNElJ8RSB1MGHDfzm2sLjquO2XHzc0J/qalq9sRQjXw7E0km2vb2+kIiwo8oXK+VjrmG1Oqc2sDRjGwq6uq@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhKKtIfN/WmioShVRRk4W4Y57AxcJJfRGhFLEZNu3WmN3uPX4
	m3b1+tCh3VqQlZqOYTgHbyXx/M0jT5cRNhyRWCkXRDroABG3C2XMt5tDV7derWVjN7wf2IEAFGt
	pdnDeQxF8S83zmpr3mNtpcISM3trZeJ57clZg
X-Gm-Gg: AfdE7cmvuoEQCpHVE5OsnW+yCW/pvNtrVasy1oG/NwKgu38tOL+XP5DYpz3ahplNeUx
	ZvPGSxUPdEIsksI79wF5iLHV9ObpaIvsJBxKGgx36WBnMvT+VrN+jalABhcPPANGqu7d1kb+hk8
	BlAQ4FnNW3ZZgt87QP2V1f/CYkyBewXqLSF/SwZNIW5E55jmEtuhQsWf6HGFmbjw8sn/R2ye4CR
	7wC8hqoClv0TOITjG0ZB54Zjuz9iot4MgCv7FLYa3XWGYDCu2YK7oLz8Ooru+Otzu6ZJaBXXJ35
	VF40/K0x7otypN28nvoToc9V/Ex/00GqvHSsIsAT8KMSbyG+n4nbWwGxIqwD6rHeJz3bwWP6zLQ
	OeYS4zQ==
X-Received: by 2002:a05:6a00:3d04:b0:836:5c3c:2054 with SMTP id
 d2e1a72fcca58-845508a0f2emr758798b3a.37.1781820544920; Thu, 18 Jun 2026
 15:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13a54c38586e0e1c7d46dfc16c3f6e1a7685001b.1781570014.git.lucien.xin@gmail.com>
 <20260617104013.852168-1-horms@kernel.org>
In-Reply-To: <20260617104013.852168-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 18 Jun 2026 18:08:52 -0400
X-Gm-Features: AVVi8Cda4bpB7H8jsE-_f5NzyxbrGEuRzgXqeYsgC-Xoa1h8pNoShrYQk4Y8aBk
Message-ID: <CADvbK_c_+tm=sX_NH-JoppGaqrzt-jAb43NKs-2VXaohb9z1Vg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] sctp: add INIT verification after cookie unpacking
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1273-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F17026A2E6A

On Wed, Jun 17, 2026 at 6:40=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> Now I have enough verified information to produce the report.
>
> commit 9d74027bfd0cb22a103cca034883f0fcb4e2535a
> Author: Xin Long <lucien.xin@gmail.com>
>
> sctp: add INIT verification after cookie unpacking
>
> This commit adds sctp_verify_init() checks after cookie unpacking in
> the COOKIE-ECHO processing paths when cookie_auth_enable is disabled.
> It also changes the bounds comparison inside sctp_verify_init() from
> chunk->chunk_end to peer_init + ntohs(peer_init->chunk_hdr.length).
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index 41958b8e59fd..21b9eb1c02e9 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
> > @@ -2298,7 +2298,7 @@ int sctp_verify_init(struct net *net, const struc=
t sctp_endpoint *ep,
> >        * VIOLATION error.  We build the ERROR chunk here and let the no=
rmal
> >        * error handling code build and send the packet.
> >        */
> > -     if (param.v !=3D (void *)chunk->chunk_end)
> > +     if (param.v !=3D (void *)peer_init + ntohs(peer_init->chunk_hdr.l=
ength))
> >               return sctp_process_inv_paramlength(asoc, param.p, chunk,=
 errp);
>
> [High]
> Can this new comparison reject INIT chunks whose final parameter has a
> length that is not a multiple of 4?
>
> sctp_walk_params() advances pos.v by SCTP_PAD4(ntohs(pos.p->length)) on
> every iteration:
>
>   include/net/sctp/sctp.h:
>   #define _sctp_walk_params(pos, chunk, end)\
>   for (pos.v =3D (u8 *)(chunk + 1);\
>        ...
>        pos.v +=3D SCTP_PAD4(ntohs(pos.p->length)))
>
> so when the final parameter has an unpadded length L that is not 4-byte
> aligned, pos.v ends at peer_init + offset_of_last_param + SCTP_PAD4(L),
> which exceeds peer_init + ntohs(peer_init->chunk_hdr.length) by 1..3.
>
> The previous comparison used chunk->chunk_end, which inqueue.c computes
> with the padding included:
>
>   net/sctp/inqueue.c:
>   chunk->chunk_end =3D ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
>
> so the old check accepted unaligned-length final parameters; the new
> check returns 0 from sctp_verify_init(), and the callers then invoke
> sctp_abort_on_init_err() and emit an ABORT.
>
> Note that this change is in sctp_verify_init() itself, so it affects
> every caller, not just the new COOKIE-ECHO sites: sctp_sf_do_5_1B_init,
> sctp_sf_do_5_1C_ack, sctp_sf_do_unexpected_init, sctp_sf_do_5_1D_ce
> and sctp_sf_do_5_2_4_dupcook all reach this comparison.
>
> Realistic triggers include:
>
>   - Locally-generated INITs constructed by sctp_make_init() when both
>     auth_enable and asconf_enable are set: with the default chunk IDs
>     ASCONF + ASCONF_ACK the AUTH-CHUNKS parameter has length 6 and is
>     typically the last parameter, leaving chunk_hdr.length unaligned.
>
>   - Peer INITs containing any final parameter with non-4-aligned
>     length, e.g. SCTP_PARAM_SUPPORTED_ADDRESS_TYPES with 1 or 3 types
>     last, AUTH-CHUNKS with N=3D1,2,3 entries last, or any unknown TLV.
>
> Even in the COOKIE-ECHO context the new bound seems too strict, since
> sctp_pack_cookie() copies the INIT verbatim with memcpy(cookie + 1,
> init_chunk->chunk_hdr, ntohs(...->length)) followed immediately by
> raw_addrs, so unpacked cookies recovered from peers that sent an INIT
> with an unaligned-length final parameter would also be spuriously
> rejected.
>
> Would comparing against peer_init + SCTP_PAD4(ntohs(peer_init->
> chunk_hdr.length)) preserve the long-standing semantics of chunk_end
> while still validating the cookie-derived peer_init bounds?
>
There's no problem here, as INIT or INIT_ACK chunk's length is always
a multiple of 4, unless it's an abnormal one. We don't need SCTP_PAD4()
for this check.

Thanks.

