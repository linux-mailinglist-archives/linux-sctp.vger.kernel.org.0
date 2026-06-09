Return-Path: <linux-sctp+bounces-1247-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WfGaIJEnKGrU/AIAu9opvQ
	(envelope-from <linux-sctp+bounces-1247-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 09 Jun 2026 16:47:45 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F742661518
	for <lists+linux-sctp@lfdr.de>; Tue, 09 Jun 2026 16:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l30pssQc;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1247-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1247-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6B3F930C0AC0
	for <lists+linux-sctp@lfdr.de>; Tue,  9 Jun 2026 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2B6344DAD;
	Tue,  9 Jun 2026 14:39:43 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79453349CFF
	for <linux-sctp@vger.kernel.org>; Tue,  9 Jun 2026 14:39:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015983; cv=pass; b=Z49B8RJKW89K/4NyBN3RtTcho6xr3qpiX5M1+9F8KheLUnJC0noRgWOAqJQlHSfU2J/mv1gR7XRYmoWd/ZUwee+etQ25+GufI6vXLPu3Cc0F3WAk7l8tTm4B43W0rO6FRvBXcbUPLkOXwL8sZ3bMkjsWqFEl0pr8fqPW0jZ5ZvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015983; c=relaxed/simple;
	bh=PNSiV5Yf5IdVIuyS/ICdaQvkxmLwAXZci7kI9aJoLh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+7YhSrslfbZ/2ebS9RYKa2D6iMDoRdKaK5+vKYllFQ7fzEGMwebf5DVwoQwAyd2d3/nxqw9Ni++TarDesme93XQGdIxS+TxannFgL+ZnpONw/4ppQ1mQ1V00OC7dbDHui192qInfKGJgCt0Xr75aCix60KJPjpc+SbksKVpUJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l30pssQc; arc=pass smtp.client-ip=209.85.217.49
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-6c79d2bb687so4563136137.2
        for <linux-sctp@vger.kernel.org>; Tue, 09 Jun 2026 07:39:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781015981; cv=none;
        d=google.com; s=arc-20240605;
        b=ChX7BAYvMsC5m59VeBECa9JfqsRsBPPb0ztklQyRuNcLDT8SiCQe3FWaTGJOZVMziL
         NRSh2E22KTrULC3zamC78bydebFeJpgk4vvHu1aq1GRirUPzRefsu+mUr+QJevpO779C
         map25RpDaJoGVyTwijdTD0pnjcQYJYh2YvV5+2IvqKW+j89SDMuWKWQWGJB22XzTZNBt
         Td0mXr3EHWbeAZPxxTa/yGzUTEmYXfoE9RwK5WxwwdEbBzKbaE4iqVO6H+gmvZPheFOK
         ZbbH5UV5WDp6pHuNmALFpAMwIsmqFZO3WD7zQhWRYxpzj1r4HBg38PhEJ6pCM+ekBYtP
         hxJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1WND2J0G9sOe3jmN+FEjetbK0mHlmxsSnOX/VnUT/0c=;
        fh=iuu7BHluk0AeOE3GXTHyTZ+mfhJ/yTQ2bOzH+m2OEng=;
        b=FBZPISoOi/dAq75A//S7nDgaO0gnnA89PqLGG+LtcNHCYhiTR122Btk7Zfkto0EYkX
         bltU+DjTMyX3wQqWDsom/RI2zQJ3q1+o3bdzCR7tAsEli9/ZbDpR0qI4d3frjwpywqVR
         aDCLrSUMegkTxLULa9HjBee1rrrfzWBgcTXb7S6Am9juNmbxjg9yn3xjmENYU7xbMA8R
         e0dMGpXFomnM1uy2zFVUgfaG8usjGk9yrBIsF6mWmJpraok2NTlc5zapzq7RolvPPILH
         ppNZlLB9p/odurhdxEZAAZNrko61L/SEWfTj164oRyTjzM0ff/pTQ5uPzFTK1Q8WhxW9
         ebhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781015981; x=1781620781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WND2J0G9sOe3jmN+FEjetbK0mHlmxsSnOX/VnUT/0c=;
        b=l30pssQcqS7XZSOQRcOQDq6MApc7uLzJ218AZBZGiW2qYycyOPVHPCPgJt0LSWf8Te
         HWHeHn4NVxsnIru6aM3mH3gJl7f3MQgFP0UV36ijkomHNX3zXuzl25A+Q9cttM8HW7WI
         ICsGUFchxqcdmzqw5gLujFxIGoruYBV2afdVLnrRHEkMhwLCl30njxlbADFqLcGQn2I9
         wsA/9IIv1vVcIbYce71AOxkSSw5mt0Tv23RmFfCHKtt5gRD7FVQkMCoBY8lzCO+kiDfL
         3EC5bvZOEnryNckwEdeudaYKl7N9Ne6X7d2ijJn4ytLgjbnFu8g/tsIBKrh4RHppUb6K
         1kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015981; x=1781620781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1WND2J0G9sOe3jmN+FEjetbK0mHlmxsSnOX/VnUT/0c=;
        b=F1mUBHygis5uyevQOqTHlY482q/oRnRMIR5Z3M0O5FBYRSUuZ3dfWI2MEWMDlgss8w
         GZb6ZmhCPtkjJCn8tnio/HTUlkzYpEPWI99vCUlO5BHsyzoAzgLh8ZbG9uPWPfFHP6x+
         TG7Gil9jLDGxjsvXFoF9P5zyGzQpSAdvLjPKu6rakfFbHJaR2sqrEEePPRQ9g1eIZatD
         W7XFGwbg2COL6SnJHYs3YveKD6criUCFGHJYO+J6bHnbQdiiwAkVzZrW4LPm9I+MQ2TN
         HtGdpPD18/fVsfa56k345B9bP9979GLY6HKC/LYPT0SWzn9fRPQtIappcpGDIfMUj2FS
         oN6A==
X-Forwarded-Encrypted: i=1; AFNElJ9OKriCihneUMdUuPVribrkby7ThlH+IFRRpBGfSawFugrSAHKJkQOf3oC4r7XHQpHqZE3GSd5VBm0F@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMpj/hmAN0+SCBydveiobBFsjBSpFuJIY0AwgWLOtS2hfuDw7
	Yr6/YCK3tMaa/YQbdrqofaU5dNtWZSMsT93WhQWA9JbjyFSSelK/hheJ6DG4C0THvBMqQWX4iAd
	dCAtxr8vAU1qgQWYAe3rqKmNiz8vu4QM=
X-Gm-Gg: Acq92OEzFQlXAyQFVG4QyADImKDIJZ7eP42hVfrUPntsrNUnoXkKE+la255QJioZbGO
	+OTAiE2Nd8XQ8n6onRATqXS6wQWTIhKMvpi3lTM9N8Vo2VTDx3Q4ts2yrAt6Rmn2ti6BfVL4FDs
	Vt21JgWw9a1lra8Ha6skishN7CO8AGb9pN9Zn1ci7WevJ1M0Nbwowi1QEUCIfydMyG2W+/ZhB2r
	MdoNHjtn9rS4w2CNFGiaxkc5pyozE4aYAzF1heOhwblmcxdR1IGLqaPRqesykquydo/DQH/FQca
	tF7vjaSX7CwQDchBo5cB8+qVJgy0O5QyMliyhRSWqqunOqlYzVDCdth8UO1876CAmz99UAx8RlG
	xX3vvew5G7S+nyxVUhyqmztX4KjOUDi6bDpGYyaOdsMn5m3gsvYuRYI38wGK6LQ==
X-Received: by 2002:a05:6102:808f:b0:635:420c:9b00 with SMTP id
 ada2fe7eead31-6fef04ef441mr11500182137.10.1781015981191; Tue, 09 Jun 2026
 07:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75af23a89adf881a0895d511775e4770da367cbf.1780873427.git.lucien.xin@gmail.com>
In-Reply-To: <75af23a89adf881a0895d511775e4770da367cbf.1780873427.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 9 Jun 2026 10:39:28 -0400
X-Gm-Features: AVVi8CehU52B2gQ1iDxujzeKYWd2ENrBtjTy07eRVqtndCDKwwFeFWB1om7OI98
Message-ID: <CADvbK_dxRSLmSgOf798h4OqYZ+01TSUfZ82eCD9JUAROtT_-1A@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate embedded INIT chunk and address list
 lengths in cookie
To: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1247-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sashiko.dev:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3F742661518

On Sun, Jun 7, 2026 at 7:03=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> sctp_unpack_cookie() only checked that the embedded INIT chunk length
> did not exceed the remaining cookie payload, but did not ensure that the
> INIT chunk is large enough to contain a complete INIT header.
>
> A malformed COOKIE_ECHO can therefore carry a truncated INIT chunk whose
> length field is smaller than sizeof(struct sctp_init_chunk).  Later,
> sctp_process_init() accesses INIT parameters unconditionally, which may
> lead to out-of-bounds reads.
>
> In addition, raw_addr_list_len is not fully validated against the
> remaining cookie payload. When cookie authentication is disabled, an
> attacker can supply an oversized raw_addr_list_len and cause
> sctp_raw_to_bind_addrs() to read beyond the end of the cookie. The
> address parser also lacks sufficient bounds checks for parameter headers
> and lengths, allowing malformed address parameters to trigger
> out-of-bounds reads.
>
> Fix this by:
>
> - requiring the embedded INIT chunk length to be at least sizeof(struct
>   sctp_init_chunk);
> - validating that the INIT chunk and raw address list together fit
>   within the cookie payload;
> - verifying sufficient data exists for each address parameter header and
>   payload before parsing it.
>
> Note that sctp_verify_init() must be called after sctp_unpack_cookie()
> and before sctp_process_init() when cookie authentication is disabled.
> This will be addressed in a separate patch.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/bind_addr.c     | 11 ++++++++++-
>  net/sctp/sm_make_chunk.c |  9 +++++++--
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
> index 75e3e61d494e..31737f144c7f 100644
> --- a/net/sctp/bind_addr.c
> +++ b/net/sctp/bind_addr.c
> @@ -275,6 +275,16 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp=
, __u8 *raw_addr_list,
>                 param =3D (struct sctp_paramhdr *)raw_addr_list;
>                 rawaddr =3D (union sctp_addr_param *)raw_addr_list;
>
> +               if (addrs_len < sizeof(*param)) {
> +                       retval =3D -EINVAL;
> +                       goto out_err;
> +               }
> +               len =3D ntohs(param->length);
> +               if (addrs_len < len) {
> +                       retval =3D -EINVAL;
> +                       goto out_err;
> +               }
> +
>                 af =3D sctp_get_af_specific(param_type2af(param->type));
>                 if (unlikely(!af) ||
>                     !af->from_addr_param(&addr, rawaddr, htons(port), 0))=
 {
> @@ -291,7 +301,6 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp,=
 __u8 *raw_addr_list,
>                         goto out_err;
>
>  next:
> -               len =3D ntohs(param->length);
>                 addrs_len -=3D len;
>                 raw_addr_list +=3D len;
>         }
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 85264862fb6b..1741a9f33d8c 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -1731,8 +1731,8 @@ struct sctp_association *sctp_unpack_cookie(
>         struct sk_buff *skb =3D chunk->skb;
>         struct sctp_cookie *bear_cookie;
>         struct sctp_chunkhdr *ch;
> +       unsigned int len, chlen;
>         enum sctp_scope scope;
> -       unsigned int len;
>         ktime_t kt;
>
>         /* Header size is static data prior to the actual cookie, includi=
ng
> @@ -1761,7 +1761,12 @@ struct sctp_association *sctp_unpack_cookie(
>         bear_cookie =3D &cookie->c;
>
>         ch =3D (struct sctp_chunkhdr *)(bear_cookie + 1);
> -       if (ntohs(ch->length) > len - fixed_size)
> +       chlen =3D ntohs(ch->length);
> +       if (chlen < sizeof(struct sctp_init_chunk))
> +               goto malformed;
> +       if (chlen > len - fixed_size)
> +               goto malformed;
> +       if (bear_cookie->raw_addr_list_len > len - fixed_size - chlen)
>                 goto malformed;
>
>         /* Verify the cookie's MAC, if cookie authentication is enabled. =
*/
> --
> 2.47.1
>
Note in:
https://sashiko.dev/#/patchset/75af23a89adf881a0895d511775e4770da367cbf.178=
0873427.git.lucien.xin%40gmail.com

- Pre-existing issue 1: as mentioned in the commit message, it will be
  handled in a separate patch.

- Pre-existing issue 2: I don=E2=80=99t think it causes a problem. Also the=
 normal
  address parameter is already 4-byte aligned, so SCTP_PAD4(len) is not
  needed either.

