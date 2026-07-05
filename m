Return-Path: <linux-sctp+bounces-1309-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ue0LyKtSmq0FwEAu9opvQ
	(envelope-from <linux-sctp+bounces-1309-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 05 Jul 2026 21:14:42 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A570AEAE
	for <lists+linux-sctp@lfdr.de>; Sun, 05 Jul 2026 21:14:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gdTA8kJX;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1309-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1309-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBC1D301E6EF
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Jul 2026 19:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E63890EF;
	Sun,  5 Jul 2026 19:13:20 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF1C39F165
	for <linux-sctp@vger.kernel.org>; Sun,  5 Jul 2026 19:13:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783278800; cv=pass; b=FNUpGTYK6X9iE18HixLa2DtxvDRP1ee5DOha38SYBepTn3Cym498jtXBCE3/BptVTzNYGWk2aRat0+C0bur014hVXljHRZ5vq0P6aroYGYZs/ZeDtl4MEqe7ZHopoorSjrXdzE7bKCPlqnlo2XnOTaRXDA8Q+SrhXyUJDSbL5FE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783278800; c=relaxed/simple;
	bh=FSJgX2aJq38TJqvi01KAyCAWflKXEkyZJPxt103MZhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEFWGopwdydbYPoKpIcjxK9H0bYfKIkOF1+p6IIRTWlHWea3TmBeR9aTKHmegNvkIUMY+r5tfVk9HSnXpWrynXsVwkpCXS0sBjtXOMv5AFxmfpKnZKrymXDrbPJA80ltgWk5UOcBYCVJkmfIEtBsX+CYG0bKwCL3wiKC8PUIH8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdTA8kJX; arc=pass smtp.client-ip=209.85.210.171
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84794e800f4so1156754b3a.0
        for <linux-sctp@vger.kernel.org>; Sun, 05 Jul 2026 12:13:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783278798; cv=none;
        d=google.com; s=arc-20260327;
        b=arwEnjnQ8JzlzHzTQ47jC8TCnkTQ6EmVCH+PCHuNE6ipxuGJO6wKc340ZUHAX4XnZa
         seus2hd3g1FMNLxkAA7YJ/+5sh8gty6tIia/MAIvqS3kHj4EzgiLTgniovsqeymEZMa+
         aZqu4tmxg9pDqC2GcudMO3d62Ivg0Mw+gIZ/Wv7X0eUdK04vcv1q0ampycAqZH/jld76
         yxA0eRevYk4PGO2gpZCs1+lyfQOpAYEjc58dlZ3CI51QMRDARXtFYWxl8SWKCRYHetGP
         SYx5AsqGJqzq4ElhljCuUCKCti3rwohnx2EPgKnP6bCEe1ZA1rliDrRbhjXHUXZZSgV1
         W3FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQ9CpAFvWWrF141vt/3zJnBZKZaAv9ntmcauJ7Q288Y=;
        fh=oKEYR8MDaGM9WhT/8hCgkGIvDkGbSATlkTot117r7AA=;
        b=pzi3XkP20o9h1tYgV1LN3f0AgD//gieMVbX8QrvsbYo3PJE6qQ+RrvdoxiWGfWnQD4
         KJJuiQov0QY3+oE6spuNAxcWR+P1cbVggBCPq5UzJUoPQeMQv3jC1a202oDPDfoTMm2M
         Ugm3RjZUmdvQyIhx5zxMD4VYHZU6E3gIXEdtZnaMI3VWrDlhVoCOC6mmwzcoW14/eWrU
         m5taA2ymNyYi6/5nmR+UaoEPcGOYm/bfY9HZjH0N+qo+S5J5EmCM/HNCDsEbQECpjAKL
         6ZQOK5pRrZ6Be8u3NhldpPyBagYe3uDz5esfxWhcLz408cqDXuWBptJk2hpz7422z925
         PnVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783278798; x=1783883598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ9CpAFvWWrF141vt/3zJnBZKZaAv9ntmcauJ7Q288Y=;
        b=gdTA8kJXCXNQ2jbyoHuH9cqrAG+GHJJ1Mqi9bqfS1TvCXIK4xbQNvNv1Z+4KXW6rt1
         DAY4KsPM8Q84h3uCWEfbHmfjLE0n0dfpDp43sUxObfhxoOrBxdyNUVxxHL5jKTrNNj4S
         f9xdk7En4DnTDwV0WL+zv+bXuOCRHA+846n20AIT5imkN1Mmi9MqjK8xaL22guzBl3DY
         VlyLw6T14JVpaG7Rd9iGIKRxp1Fj03WKaFvGu2keICSglxRpotfsS14oyza3BvQ9nh6T
         8fDwL0IVb5HobfmCmO7uC2OZTiiuz1+t2sFn+3hwYcvPPMbf6OkhK+084s8RzaBPQnch
         rOHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783278798; x=1783883598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQ9CpAFvWWrF141vt/3zJnBZKZaAv9ntmcauJ7Q288Y=;
        b=CnTB+2fn3+9s/fRyGOkIFIZWX2Wk4UDz9EhpOLeBiMsXkcwIs8UWeZ9Sogmz35peV7
         kOFo8TGq3Gv0/9MTY6A3YcmXbTNlnxAOY4v8uwrQsGm8DY7wa2QXIRTLh81HzIBXFCJJ
         PClvPIhi1shw9q8IDQojiTma1gXpmhJlq4BNdKfYDBAj1zYaJiN7tXTtW9CDEHfmX8aQ
         M13W2+ZK3racH/1cX3a1dI5lqRC6ffcxZwK+izCILTNi66gnoUciUOFnTUK9l1bzQQ0n
         z6+zrBYV/DcIJatRA3HBGyvlvb30tg2WnoLzqNouwDtDDHVb/6vWYmxPFze1qjN3gK5O
         gamQ==
X-Forwarded-Encrypted: i=1; AHgh+RqjNDa+KzoONbrBCZ76dffW+9TOEOYKtgTnIwN5hPXD6Xfo66vI7WnM6KGVmrYwVCa0bieiLQ5dDGww@vger.kernel.org
X-Gm-Message-State: AOJu0YxiF+/GxaMFCSGxy2n5F8kxwTmS4sg2XG6Nb/D8FaC9mNIXvInB
	QqQAdTyV8PLldd3W/1HgXib1cDVnT6tqUJQV+7iLwnB+O6nHgKiwlGR7ZUGK8KOCEvFFCvl/NeC
	1qNLON1tK3iQfqzDEkM1oG6rO6wNIL+4=
X-Gm-Gg: AfdE7cnzxcCHQG/LxWn9ak6u/JC7MqJbk9ZoVqXrce4hMsMFZM0z0W4gokdAxIy7AF5
	YM5TqxzWTsQ+MR5Wjr68xyaGUiVWpbqJpcYxAaaF6jIIlVgGaIHmD71ipjl8pODdeW2F9roGjRp
	J3n0K36VvXKaz7df5EOPMbEXS3+fFc6H+j1aii6BxuP4tpJAyPR0LKzFFvtueekWRibO620uZYe
	IePOgVSGo5u3Zyflc6EObYPmNu+c1t+GKgahO/7Y9Tt68m1J7Ug0pvkB/ulmU2nZNlUjtHuYHcU
	KXv/dtq3SnpVD52DrBuooI9r1SW8f6/pbfSAnMD0NcW7YB8WOFrmGWQ5NRxNZIjLgGH06RGp5Cj
	3q2tvxXuR
X-Received: by 2002:a05:6a00:440c:b0:846:d484:945a with SMTP id
 d2e1a72fcca58-847f6f737c0mr6874374b3a.53.1783278796335; Sun, 05 Jul 2026
 12:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705003013.1134430-1-xmei5@asu.edu>
In-Reply-To: <20260705003013.1134430-1-xmei5@asu.edu>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 5 Jul 2026 15:13:04 -0400
X-Gm-Features: AVVi8Cfte7ya4M0inTOXBNlj7tfEYuc9tp7a8uuizOHEqaE06iX2_70pA9HTj90
Message-ID: <CADvbK_cWUT2ygfBSW6qjgx9_y=bvksqG87Lp8edQcFT+3p9fOA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate the body of a STALE_COOKIE error
 before reading it
To: Xiang Mei <xmei5@asu.edu>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1309-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 365A570AEAE

On Sat, Jul 4, 2026 at 8:31=E2=80=AFPM Xiang Mei <xmei5@asu.edu> wrote:
>
> sctp_sf_do_5_2_6_stale() reads the 32-bit Measure of Staleness that
> follows the error header:
>
>         stale =3D ntohl(*(__be32 *)((u8 *)err + sizeof(*err)));
>
> without checking that the STALE_COOKIE cause actually carries that
> 4-byte body. sctp_walk_errors() in the caller only requires
> err->length >=3D sizeof(struct sctp_errhdr), so a peer can send an 8-byte
> ERROR chunk whose sole STALE_COOKIE cause has length =3D=3D 4 and no body=
.
> It passes sctp_chunk_length_valid() (>=3D 8) and the error walk, yet the
> staleness read reaches past the validated cause.
>
> When that is the only chunk in the packet the cause ends exactly at
> skb_tail (sctp_inq_pop() discards only when chunk_end > skb_tail), so
> the read stays in-bounds of the skb head slab object but past the packet
> data. The value is folded into the COOKIE_PRESERVATIVE parameter of the
> retransmitted INIT and reflected to the peer, leaking adjacent kernel
> slab bytes.
>
> Discard the chunk when the staleness field falls outside the validated
> chunk data.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/sctp/sm_statefuns.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
> index d23d935e128e..e4b4b63162cf 100644
> --- a/net/sctp/sm_statefuns.c
> +++ b/net/sctp/sm_statefuns.c
> @@ -2592,6 +2592,9 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale=
(
>
>         err =3D (struct sctp_errhdr *)(chunk->skb->data);
>
> +       if ((u8 *)err + sizeof(*err) + sizeof(__be32) > chunk->chunk_end)
> +               return sctp_sf_pdiscard(net, ep, asoc, type, arg, command=
s);
> +
>         /* When calculating the time extension, an implementation
>          * SHOULD use the RTT information measured based on the
>          * previous COOKIE ECHO / ERROR exchange, and should add no
> --
> 2.43.0
>

I think this is a dup of
https://lore.kernel.org/netdev/20260704033545.2438373-2-bestswngs@gmail.com=
/.

Thanks.

