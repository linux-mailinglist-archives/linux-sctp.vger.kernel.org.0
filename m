Return-Path: <linux-sctp+bounces-1187-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIM1Livq4GmmnQAAu9opvQ
	(envelope-from <linux-sctp+bounces-1187-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Apr 2026 15:54:51 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3495E40F417
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Apr 2026 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05B483203319
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Apr 2026 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6788E3A9D8C;
	Thu, 16 Apr 2026 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzcjVm97"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342041F5825
	for <linux-sctp@vger.kernel.org>; Thu, 16 Apr 2026 13:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347225; cv=pass; b=Nofwtiwb0UlGPla+s77C8oLy/8+6fJB99D0xShbJwoJwvtQT/aYeRhLy/V7+qSy8oAt0bmtCIYEwIVCQmdfoUp9Ers3xPEKTW8VCwMO1CbwBbbRRjpeeSc0wyRIE1Dw5aoJfwQwQEC5VX+HbLu/MZ6qV1wQ84wmoBQFFQoxQYXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347225; c=relaxed/simple;
	bh=uwqwZWO4cytEM0TWMFqBfKh8P6MuYsz1R5OR8hxVdb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YPmQIw0emua4RLu8nKfNtoG5+XKwp4IWDcenYrsz/hCqVHPBnyRm1M+hAeuGpbQ3dEnwtnRaNDGRb1I8Ot2KrAqXrpLXrvceC0EQVC39arjVUZEE4u8Ew3hW1LD6w0R335+7q6rKgsY41zDXpBwb9MX1gZixzbDeOG/MsupfQs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzcjVm97; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f344e880bso3024396b3a.3
        for <linux-sctp@vger.kernel.org>; Thu, 16 Apr 2026 06:47:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776347223; cv=none;
        d=google.com; s=arc-20240605;
        b=Kb28EwDjX2x7Qgaw0iU3SURezZDqAHt2evjLSN2ZqaHAkstP2wVXc9fZLBD5h8oOiZ
         iLx3oZz2tq++kfuRKzlDusnX5nYOBEXUPzZUgRrLGVwgDsXs9WiWniuRBzmupVaIP7VU
         93IQEtS90683W/jCsMAvhjnP5Mkc5uuctIMLUnmFAbHxiga1Nw5XS+usEzUCNgiGHgVB
         GGnY9PkFvziIuMk9ZseBCZp/AuaOf+GQGUZyWpAaYVspImFE5oG0KOtW5OOfhWvvoNfx
         pJwfwKwlG+is3tYQJ+hUoILrt1O39TwQSL3rPebgz7vIRxOxayFGYjNzoI59ptGzMSNQ
         dfPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        fh=VmrBviC8dCWFzTnRtquyfyncJgdjKwrqDTSydzAmdYw=;
        b=kRfROuyluYga3RbYx6UlXMZjWEF+JamF49zqx2E6lcF2kDHy5r0CQm0uNkD91pQLUS
         V2NBHXNQK+Tw445zROTjv/4J8+QIgoyvY/7mC9T/UeGfpjrAT1K/bpQVBQr+1rcbpcng
         /Z8J1BC+2X/l2A9qfe/tqguZL+5cI5mEP1eF8v285AcS+9hNC3swzdBDtzrpPuh+lX7s
         aNwrskRlRV14bfqupU3gJI7hZ6Jtpm9QCQQysxD6vAVuFfWLXhkQp8eUJNsL1iagQJ9C
         6RISES74hLriSaIgvIu2D/F2TXBO3cY/Pm1dpZR4OBTbONVp8dast6nZkDmkunnxSpa0
         6rZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776347223; x=1776952023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        b=FzcjVm970lX5qxpetuut7rZiMR7msZ+WXtf722TG66J108ewgaOmFkbma8556ma62C
         2Ti1HAj0GqJ1oDXOCflTosqvz4lFvqkkOZjDmzXoV9832LeC8YZl49DR0gq77QvAU93S
         BrMlwFOCg31yz68c0xq05Thi/c11EXbDnuP8ybn2YIIoC25C3ewzIk6aMO3qemC/UKji
         PY/D7IbwEA7kI3zS6Vfq8m/YIzZK4ZL+7NRj9/OFyfbMAROlMLQP+/Y1VtSXm6XgYfib
         abCd8tpP7qMHvJ1GtcsAAsY/4qS7svLNV2LAucN3bET4jZQbAxySS189PzjjdnKh+VfU
         b3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347223; x=1776952023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1/nG5+BUyLH/mzVhpWnbCa416r4NmEzelUBla6sJzwI=;
        b=NED73xGnjEeCnrUtlRszQTcPKhNjN3fvo9KyeB3kw5dtpTrJZdHpY1KIC2alxgn+xb
         kC179QUkMoMralizf3QLb6LFGRMj4Oaa/xmD6alJYZP8+Xq/8BgiKY4IK8N4PlOW5axE
         eKB8xklob0LeghLZqOlHmd9UGtlJD3fzIdtOmRIKbiq79MKcGxFapXkjYeJRZf5W1Pe+
         dCOvVumtZEV8VYj8T3n0GfYuH1ijcZ3Q8jHPcpUWg4VINZTp9ZuH+CaRuJvu9zxiW7WH
         dbfFCKgqSVuHsYB2uiEBxEJp9LUzNLqj6nVWaqqySCJ0ptW74QhuYtZ0nKAulq5xsSej
         QAIQ==
X-Gm-Message-State: AOJu0YwNNxszYOqTDqbEHAl55Hfsn3/kgPts5h2UeIJiWXz4hqexAA+Y
	pj4YiqpJKjLJAkZucLy6axtTt0IvcC42KAKtgw7WqRVXwT8RQO353rEQMw9XtGlSlCRXtlQtojB
	2Frx/rXAUxzY+vTEM2U3FbuVbDvsCUxY=
X-Gm-Gg: AeBDiesPUUpFbAL/PaQh65WBXpuota+CGHspc16iDLoRELXfqxFzFKMFODUEtFxXnl1
	IRhThADn2yNrG//1K99cs3Utj+ziManSQppJcK795OHWigSNtX1hxUrdvc2gukXLM4bwRJFphj9
	R2lXKlp2ob2xxh2pGMZSfwQuNr14kE6xPhjit7QjIAGf2bImQCqeH6snmI/WSrpR7aTb/91Hech
	SDYdhebmsx6kbZbjFckMozy5Cfm051R7XI7lOX+59GbN3qnHfIhGkYSpF0Kwz2rq6ZP4ECaxFny
	11JYR97VbCbrrfPfbMovkQ80++qFJQKQydMBPSMzf4/GtP/PxVrsw16qi1Z7dZlCmIusmWg5kPA
	/jyUzkxum9E4lwdBJyDQVW/7zcL1qKXCE2+48suhNutjpLsQgw1U=
X-Received: by 2002:a05:6a00:2392:b0:82f:250b:9f16 with SMTP id
 d2e1a72fcca58-82f250ba2a1mr20854005b3a.28.1776347223559; Thu, 16 Apr 2026
 06:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416031903.1447072-1-michael.bommarito@gmail.com>
In-Reply-To: <20260416031903.1447072-1-michael.bommarito@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 16 Apr 2026 09:46:51 -0400
X-Gm-Features: AQROBzBXABVaL19OQLFi-BeVpvoNvRQFkcBHonub7TDUeEKdTffXEx0BwEBOtCs
Message-ID: <CADvbK_d_T++kjJ1U3g8RZRM8AUTHsrqD47Y3EuB3wZQTxeZ6Fg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1187-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3495E40F417
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 11:19=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
> buffer is large enough for the peer AUTH chunk list with
>
>     if (len < num_chunks)
>             return -EINVAL;
>
> but then writes num_chunks bytes to p->gauth_chunks, which lives
> at offset offsetof(struct sctp_authchunks, gauth_chunks) =3D=3D 8
> inside optval.  The check is missing the sizeof(struct
> sctp_authchunks) =3D 8-byte header.  When the caller supplies
> len =3D=3D num_chunks (for any num_chunks > 0) the test passes but
> copy_to_user() writes sizeof(struct sctp_authchunks) =3D 8 bytes
> past the declared buffer.
>
> The sibling function sctp_getsockopt_local_auth_chunks() at the
> next line already has the correct check:
>
>     if (len < sizeof(struct sctp_authchunks) + num_chunks)
>             return -EINVAL;
>
> Align the peer variant with its sibling.
>
> Reproducer confirms on v7.0-13-generic: an unprivileged userspace
> caller that opens a loopback SCTP association with AUTH enabled,
> queries num_chunks with a short optval, then issues the real
> getsockopt with len =3D=3D num_chunks and sentinel bytes painted past
> the buffer observes those sentinel bytes overwritten with the
> peer's AUTH chunk type.  The bytes written are under the peer's
> control but land in the caller's own userspace; this is not a
> kernel memory corruption, but it is a kernel-side contract
> violation that can silently corrupt adjacent userspace data.
>
> Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.=
")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  net/sctp/socket.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 05fb00c9c335..f5d442753dc9 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -7033,7 +7033,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct =
sock *sk, int len,
>
>         /* See if the user provided enough room for all the data */
>         num_chunks =3D ntohs(ch->param_hdr.length) - sizeof(struct sctp_p=
aramhdr);
> -       if (len < num_chunks)
> +       if (len < sizeof(struct sctp_authchunks) + num_chunks)
>                 return -EINVAL;
>
>         if (copy_to_user(to, ch->chunks, num_chunks))
> --
> 2.53.0
>

Acked-by: Xin Long <lucien.xin@gmail.com>

