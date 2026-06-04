Return-Path: <linux-sctp+bounces-1236-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lth6OEb1IWq5QwEAu9opvQ
	(envelope-from <linux-sctp+bounces-1236-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 23:59:34 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FF3643B87
	for <lists+linux-sctp@lfdr.de>; Thu, 04 Jun 2026 23:59:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GDeAJUUr;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1236-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1236-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3053E301E5BC
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Jun 2026 21:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80230D3E6;
	Thu,  4 Jun 2026 21:56:58 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709D172617
	for <linux-sctp@vger.kernel.org>; Thu,  4 Jun 2026 21:56:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780610218; cv=pass; b=ufeurSd+plrDbKQ5WnfHwpRWOpT5ky2WBzN4p6uAfHkSpy4FkRvIDVL/AIcsBBC3zy6NBFRE8foFFpQ51iRMqMWxirs42QFpqdSwO0ZsflGxprKAaEijHlh8i2zgh5/A32EG9Hr0JM9Ou7frz9QpSgHRXcuI2OreWmW9K/tea5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780610218; c=relaxed/simple;
	bh=GIdR7oXqN0/LHonkwkN7zibl3m3ihCq0T2taL9KvOb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uSME5NGXpRlc9Fi3+iLW56gCcebW3eTdeY1vnGF+LrMl3uqQ6YmtJ7dPXbPdM/XMnmNIBLtuRltNT3XhyEOIQaDEulXT4wkS3Exn1fCwgataDmQIj8jU6gTXXIDSwhHvoQUwpOkXIDzGDS1tBtA7LDu8dxI9e/qkkGClN++SRjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDeAJUUr; arc=pass smtp.client-ip=209.85.210.182
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f1d8902so537670b3a.1
        for <linux-sctp@vger.kernel.org>; Thu, 04 Jun 2026 14:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780610216; cv=none;
        d=google.com; s=arc-20240605;
        b=U5EZw+xCNbLxaAYnfcQGGbBASU9jxniPwdqS0Ww4wQnkgjcYCUr3584968pFLWy9XE
         BHEaYyFFSU6Y8fQRoij/0QJTQG6jIiWF9RGEjCDvWGHnu+G/5lKBF2pIUiMcEI9WiDkU
         SXMYH+EOsvXgQWRZYJI55tdNcrHJTvZ0j5WtEv2kGu21g3CybiMdpOQYJKevy+m0dbib
         C/6VbeDEbBmsHYe9XRJPKAGKPPbKa7BhUeFAY5vD1c4nooOIifSiabLQFwlKAf4P0jth
         Ko4A7mb1kQSBxDgcP8iiTP69koUtEq3os8jLfdSBjVUH/mhxX4LfileVBfVl2GOOcRVj
         s1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B4P/E5eJRLHfKf3xAmuxsjbx58eaDCcmLeQej3n1fA0=;
        fh=SUqCkr8Nw9IMlVMziAUDYsLdHIGkyEx14ZCJnUFqtP8=;
        b=buc3ogvXdNq0icCD766uHNyqdtfKHdm8iTm1jHILW9SLWhVbFIbjdpuK4R2kDBAAPS
         rSJ1CpQpcd1t2Mchyzg/xV6e+s7i2CNwmhnjM6o6c7+C7L95PvkBEZ33IDAPJr2uhrHd
         DfUlUuJNbVpPUMBulq7FWhgEylF9y1ii372cvhiF72GORTG6bqcrwGUkmGCPvViQuwMY
         HstNp2K+6cGMfcgQSwUo6nrA/R/YOTmFPnhnaoueWnI4W/fMkS+Ipct1unBUjyuqyt4y
         l4SETc7XwqyzKKwrDlhnleztxVh9mS17ywafQiAJAA87b/yMvGN8Gvzoo3ukZuP10tVj
         AoxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780610216; x=1781215016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4P/E5eJRLHfKf3xAmuxsjbx58eaDCcmLeQej3n1fA0=;
        b=GDeAJUUr2FNIMnSIcQ9d5U4kqK5otWjjbAECP2YiTVpJ8i2oVLo+TBEff/J//y02mA
         KCy+2Uqie0pqFKLBts1+JUmDKgVSmDLxe91G3ELB+QWVfoJnjw8KKkG8GC9meb3UTLe4
         UDawuyFW1HcXtVh+Hy7AdL4orPo4V4IvXnPC9y1RsvRk66BpjCpyqWf1JONcLZ31vfjc
         epUm9zYKVlKCE8B9IsAgXRHETLC4azq2EgK9uwv7g2W7dmgiazen/txBJHjl7FNvf7JD
         r+eVWV+Tj6KcsDjyKMMCNrdhQMfKT3B/skmCgT0ueSu3m/Se8Vj5KghM4/AT3T5w7Dpj
         ug6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780610216; x=1781215016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4P/E5eJRLHfKf3xAmuxsjbx58eaDCcmLeQej3n1fA0=;
        b=huWdEuup6ZfNJCZw1/6RZXdumeewWXb05PsRgzEZGAzOwCtc47FkOqQvhN82kScsLD
         TOxvKEkgfq+azyOmnjr8I/eq1mIj8tieNjaLSFDCWQYYa15SMRrHKrw/J3aEPvLluwMB
         uIc2P8Ob5BItVFEvSzRnciz9T27mKxQw9VmuYImmIYdDZN2G8nqIlk449T8hGK/j5Mtf
         U2t4ZDjQNbS5veiE2I7b/KXMMDnUnIVoTPvdba7IR6hS00J5IW3l1ZHzu2A41TR4imlu
         SEaz0LrTdiq22wcdehv7W315JlWjkl5iJ3cIAqnTNvN7qx27YM/w2XqAMv0fGDAic8at
         v7LQ==
X-Forwarded-Encrypted: i=1; AFNElJ+m2JHiO9sRPDT7VEAjn8IlB2cZnjaqcLSaz7FoyaIGd5x4O+Vj0uO9cETyHOQ9xtF0lBFP4ejPPoH6@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7R+x7OBWeNiahD9AvUakos/nTOg/SEb33tEdhk+X+wM2dtTz
	avjY1o6RqgYe9a+rqiiT/Ke5E/wb/w78BEMOmv5yZn8q0e3oTZPm3RGmgHYxAgAwByNEFe8TmkN
	mzp5xkajrSr9zPz+AM1lE4fuXn8kXmh4=
X-Gm-Gg: Acq92OHFzboYoL08HRNzfpxr8E6lIK/twRx/r4D/UDu16nJI46Cp+7XKZl1PhWw5Z4S
	cdInu0cpm7KdyEtVIuTfo7uz/dss2MJPEFhiitOx4q17H0eoa9T+MCtTzdN2eyPstj+Srj3VK4H
	8bzDdpE3c5BUU1pR8y96OsVZjo4beSJbx4JXkBc4u/t1s16g9uJ6IIMGyjBsQHWtFcAMv5Zj89e
	lFVmxsBSEsS1tIFe+iXjpLz9kaMT1ml8Gw7f2OuuS9JBrWh/AIF4nW60bA34w6ZD4xV8Sx/KRd7
	XfIPg3EuJEQzHig3CxHtk4ohsWK94Hbvk826dpkREKcWV8rdIms8tayfpXpQkMxgHi+OMzP/wPz
	QRHZO3iMxNGwgjKwO
X-Received: by 2002:a05:6a00:982:b0:81e:ef16:b288 with SMTP id
 d2e1a72fcca58-842b0ea4a70mr489004b3a.22.1780610215549; Thu, 04 Jun 2026
 14:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb60825fa22d6f9e663c7d4dbb69f397b5d34d42.1780362366.git.lucien.xin@gmail.com>
 <20260604104712.3904260-3-horms@kernel.org>
In-Reply-To: <20260604104712.3904260-3-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 4 Jun 2026 17:56:43 -0400
X-Gm-Features: AVHnY4KeqM76a83Gitn5qA73uaqekrRS_cFoPicNj3QEsgW6dv5w_KCYuv_b4us
Message-ID: <CADvbK_fZ760o-A1JkFvzTphdsH9Qugj+BE+UCOba3v4GQJdtRQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate cached peer INIT chunk length in
 COOKIE_ECHO processing
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	marcelo.leitner@gmail.com, bgeffon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1236-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:bgeffon@google.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36FF3643B87

On Thu, Jun 4, 2026 at 6:48=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> From: 'Simon Horman' <horms@kernel.org>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev
> ---
> sctp: validate cached peer INIT chunk length in COOKIE_ECHO processing
>
> This commit adds a bounds check to ensure the cached peer INIT chunk
> length does not exceed the available data in the COOKIE_ECHO buffer
> during unpacking.
>
> Simon says:
>
> Hi Xin,
>
> Although the issues flagged below are flagged as pre-existing I am
> wondering if they directly impact the effectiveness of this patch.
> Could you take a look?
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index de86ac088289e..85264862fb6b6 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
>
> [ ... ]
>
> > @@ -1759,6 +1760,10 @@ struct sctp_association *sctp_unpack_cookie(
> >       cookie =3D chunk->subh.cookie_hdr;
> >       bear_cookie =3D &cookie->c;
> >
> > +     ch =3D (struct sctp_chunkhdr *)(bear_cookie + 1);
> > +     if (ntohs(ch->length) > len - fixed_size)
> > +             goto malformed;
> > +
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this check also
> need to ensure the length is at least the size of the INIT header?
>
> If ch->length is small, for example 4 bytes for just the chunk header,
> this check passes. However, sctp_process_init() appears to unconditionall=
y
> read the init_hdr fields:
>
> net/sctp/sm_make_chunk.c:sctp_process_init() {
>     ...
>     asoc->peer.i.init_tag =3D ntohl(peer_init->init_hdr.init_tag);
>     asoc->peer.i.a_rwnd =3D ntohl(peer_init->init_hdr.a_rwnd);
>     ...
> }
>
> Could an attacker send a COOKIE_ECHO chunk with an embedded INIT chunk
> truncated to 4 bytes and trigger an out-of-bounds read past the SKB paylo=
ad?
>
> [Severity: High]
> This is a pre-existing issue, but is cookie->raw_addr_list_len properly
> validated against the remaining payload length before use?
>
> If SCTP cookie authentication is disabled, an unvalidated
> raw_addr_list_len could lead to out-of-bounds reads when
> sctp_assoc_set_bind_addr_from_cookie() calls c()
> to parse the bind addresses:
>
> net/sctp/bind_addr.c:sctp_raw_to_bind_addrs() {
>     ...
>     while (addrs_len >=3D sizeof(struct sctp_paramhdr)) {
>         param =3D (struct sctp_paramhdr *)raw_addr_list;
>         len =3D ntohs(param->length);
>         addrs_len -=3D len;
>         raw_addr_list +=3D len;
>     }
>     ...
> }
>
> If the unvalidated addrs_len is artificially large, or if a supplied
> param->length is larger than addrs_len causing an integer underflow on
> addrs_len -=3D len, could this bypass the loop condition, read into unmap=
ped
> pages, and cause a panic?
>
Yes, these seem like real issues.

We likely need more cookie validation than just checking the chunk length
and raw_addr_list_len. This was probably missed because the cookie is
generated locally, but it can still be maliciously modified.

I will try to reproduce and get them fixed.

Thanks.

