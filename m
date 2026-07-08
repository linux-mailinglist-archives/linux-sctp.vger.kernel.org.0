Return-Path: <linux-sctp+bounces-1313-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZmrBjy/TmqcTQIAu9opvQ
	(envelope-from <linux-sctp+bounces-1313-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 08 Jul 2026 23:21:00 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08772A7B4
	for <lists+linux-sctp@lfdr.de>; Wed, 08 Jul 2026 23:20:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RRBVLDkl;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1313-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1313-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEC78303E813
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jul 2026 21:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA0D3E8C6A;
	Wed,  8 Jul 2026 21:20:16 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7AA3C3448
	for <linux-sctp@vger.kernel.org>; Wed,  8 Jul 2026 21:20:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545616; cv=pass; b=HBxHSqBFcO0/ZFavUbhJqV6y1WDPrd34kjWuRsQ5L3g4Fif6XfXuCd2tRLFkWfTW8d/ZwBakEtXVp/q1OP7lWU6ECIKPbq/HnMZxdvjIahHVV9NcepOk1KkkZI+9oRRounKfR7ycbSt0iMat371UzdrI0WBalLX9qzLh8heCwbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545616; c=relaxed/simple;
	bh=i23ourEsmh0Gz+WLPq6GnU7Yy/el6Z04qG/MBr41xFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiWj1CBj8x2cPVV3QMluE0K/2Tm9gNay+ucLDCk7rrIHfahtel9LzHr6iCZw7vkp8zMqPaxOAH/t6wphlhVgLsTPUoeHPxkA5b5YfuFT3zYQxL7kroMbUeWj1gHsv9SIuWCjISlUuLJjNClhwvd/BEPI4tu+kWtaX//cjTiJIbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRBVLDkl; arc=pass smtp.client-ip=209.85.210.179
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f236418so873440b3a.1
        for <linux-sctp@vger.kernel.org>; Wed, 08 Jul 2026 14:20:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783545615; cv=none;
        d=google.com; s=arc-20260327;
        b=Jv3rOpReOfwdjUbA4KngBm7e68Bn7LIU+/s2KDYrAuHnXLAxg1DO+OUEEBxTHtJ2gp
         E4PiarKWsg/zJrO8Igc3XRUGhyKof+RjrUpv8cULP7e0wfNHxl/6vzGv/xO67G6mAU23
         mWIWOSo1OjFzDCium4bcXbJMLYJcZylxwRPVxMlsYn6Ee5+baDwQsZWRefszGI2fJgj0
         GGrMWAwQUsJLm/iIDnVhmcTnKaXvNnUD4p5siwVAWL3uPybT5Wil+v4C8ykLQpyLZ5eG
         xtxrQYsMx4SYnmVMLveyKGf9dYKnif6WY0H9FLo5e40Q8mIpqgF0XKjgjBTMaIlq2FYg
         Sn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aS4Q5B4k2AOeF5jjhGh4kU/h0KJ8SNOkM5/Q3FHWSMU=;
        fh=srU2xVIQ925i7XyR1H7sSWvFX16JBsQJi53/RYv3juI=;
        b=hE0AnK8Sgp8Yocm0uCmjBhiWkzjNV0gCeUMv1DFh1OyceQLzlK11PF0I3Em4B2STpz
         +v3txgaocNzr0yFHn3vVNyr+vCq8n3oiad/sLlGTNTgK3mHZ7sMdLdxxqC15ancZIeDt
         qXA467xQJu5pE2myyz59FPBlRmgBvCabxas2np0m3cXnRxZL/JrI9ocVz7n/BfG6dwgF
         54LEkGZc1LSzsQMEEtDLLbx9c8ax1xsqqoZiugbRp2Vd6qXSh6DSzZHwDcKdyGnCvvz0
         mAMQEQmrBMUW50uw6l6tJk26Xs0AXHGRTgmR21VUJTSrTW4NlIReu+vokhJoc9OdtFo6
         rP5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783545615; x=1784150415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aS4Q5B4k2AOeF5jjhGh4kU/h0KJ8SNOkM5/Q3FHWSMU=;
        b=RRBVLDklhMwWjlUZHUZD8mvR1Ulgy6EhrBuOuqJ45UxOyFdM9dWzEX+ECE27P4fI3a
         O1L3CTz2zFahUobZZuDsia2OUGD1ixfoND0ponckTFe+lWaiBxMC6WQg/XFetMso3pZP
         YRBmVbNWzarLfTcxa85ytbjyPx9yMdPXkwhc9IE91/8acV3dV7HAiAcDyuZ8sYeSk1RT
         O6s2keNUwINZfgFe7tCRs1GbyMZ6KQD0IYPhX2lkPqWzLA2snxZF80Zm6dcRtOFdOJUo
         /HDvcwqIhZ0nNBu/wUtBf45ELui1xTI24KxaiEvuxNe4k9hSggmwRSDHkAINW244wWpw
         j0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783545615; x=1784150415;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aS4Q5B4k2AOeF5jjhGh4kU/h0KJ8SNOkM5/Q3FHWSMU=;
        b=Gir9FZ6LpwglcG7CSvLcsnE6uN8s2J/DRjnj4dKTDIQH3ow8hrd74MP/q0CynIw31b
         Ovjk3Y/RsQZtpduwIgklvIrwg812ZOSgLW4j8E/VcgALWYIHuuj4qZWjp6s0QagwTdFp
         qY4ZXbEAMf6FQQQMGuRvGP914peSWlnzx6WIR1tyiNx/NITtE9z3zijynEFjowor0HiB
         DoJaU/Zb9AzrTYRppoTkAQXmY+wrbnVqJGVYqU5fcYkBgm/m8aOPjuobfjhMb7BD6pBu
         UuBkqBtR2ajnAlOIx9unSmvYpikcT96tSuW67T2wf2+MzpbB4ibnR5JKRQ7E3hZ/TvT2
         MLfw==
X-Forwarded-Encrypted: i=1; AHgh+RojSHwLFxkx3AixJHx+ehA65ZRi51M7TetmCHxxVXXUN5vMPGKpgAn0egXmBUgkzbayXbrvtx+DTO1Q@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdWFaZUogyTlVtCdBVDMc08FH+vBuTrEVSHWvC0k845v/gRH3
	lsLAdFrziI1oSbtuSt1Hnx4UF+L1H1dLU2mYLOA/nfd1fcxps3JMHgh1imfU3DKT5LuwSAr8PBf
	PSxKC4WhA9F3z1QkYw25ZqglGIJBQACM=
X-Gm-Gg: AfdE7ckyW1tqPmrT6lOW6bzW4MBdglf74XRI6YrCxCzbrEhsov+ZR/bQcMzT6txsE+h
	oYLYkBGJfrhIjCSvQhK8y6NJ2uCa/ZyZ+7aIZ+J2t0SzAIePaZ54+4952Ftj0LrXw8KUbQ/WoeH
	S2l+tD6/iQNBi/W15U1GBamZKHSOWV/SkpOyvC8QewH7sPdoQ2woJ8vvYNbm10QIqbhGgEGgnZ3
	cjnIL+9PCf1ROM5mfzx1Bx+RwC3y4DPzWQ6NMrDwJ65k9ZqTIlDlmiVBEo3jzjzxw/gkfqlEWzW
	0AJrPTcHTBkCiL7Gsq2MB1QC/iH9VP0VuqJs5frD63wK2Bu1Gm+UKgFmrKF7dHSBnb+legTA
X-Received: by 2002:a05:6a00:8f0b:b0:845:dfef:75b8 with SMTP id
 d2e1a72fcca58-84842fe8cc2mr4141328b3a.15.1783545614779; Wed, 08 Jul 2026
 14:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707203215.2752-1-blbllhy@gmail.com>
In-Reply-To: <20260707203215.2752-1-blbllhy@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 8 Jul 2026 17:20:03 -0400
X-Gm-Features: AVVi8CcGemzqA0x8h-my5ThQQjmDgAX7MqMFTaMXliUpxW6XbifMPoB4xUZHmpM
Message-ID: <CADvbK_fTrjLmFK=ZwGjU=xnDRJ2W_3eewATJHw+kZt9caUsAbw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: validate stream count in sctp_process_strreset_inreq()
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:blbllhy@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1313-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,microsoft.com,linux.microsoft.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A08772A7B4

On Tue, Jul 7, 2026 at 4:32=E2=80=AFPM Cen Zhang (Microsoft) <blbllhy@gmail=
.com> wrote:
>
> When processing a RESET_IN_REQUEST from a peer,
> sctp_process_strreset_inreq() derives the stream count from the
> parameter length but does not check whether the resulting
> RESET_OUT_REQUEST response would exceed SCTP_MAX_CHUNK_LEN.
>
> The OUT request header (sctp_strreset_outreq, 16 bytes) is 8 bytes larger
> than the IN request header (sctp_strreset_inreq, 8 bytes). Generally, the
> IP payload is bounded to 65535 bytes, so the stream list cannot be
> large enough to trigger the overflow. However, on interfaces with MTU >
> 65535 (e.g., loopback with IPv6 jumbograms), a stream list that fits
> within the incoming IN parameter can cause a __u16 overflow in
> sctp_make_strreset_req() when computing the OUT response size, leading to
> an undersized skb allocation, raising a kernel BUG:
>
>   net/core/skbuff.c:207        skb_panic
>   net/core/skbuff.c:2625       skb_put
>   net/sctp/sm_make_chunk.c:1535 sctp_addto_chunk
>   net/sctp/sm_make_chunk.c:3695 sctp_make_strreset_req
>   net/sctp/stream.c:655        sctp_process_strreset_inreq
>
> The local setsockopt path (sctp_send_reset_streams) already performs leng=
th
> validation, but the network packet path does not. Fix by adding similar
> length check before calling sctp_make_strreset_req().
>
> Fixes: 7f9d68ac944e ("sctp: implement sender-side procedures for SSN Rese=
t
> Request Parameter")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
>  net/sctp/stream.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index 5c2fdedea..ea3805712 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -639,6 +639,10 @@ struct sctp_chunk *sctp_process_strreset_inreq(
>
>         nums =3D (ntohs(param.p->length) - sizeof(*inreq)) / sizeof(__u16=
);
>         str_p =3D inreq->list_of_streams;
> +       if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq)
> +                       > SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_=
chunk)) {
> +               goto out;
> +       }
>         for (i =3D 0; i < nums; i++) {
>                 if (ntohs(str_p[i]) >=3D stream->outcnt) {
>                         result =3D SCTP_STRRESET_ERR_WRONG_SSN;
> --
> 2.53.0
>
I think we should also prevent sending such an 'inreq', since it will
always be rejected by the peer. We can add improve the check in
'sctp_send_reset_streams()' like:

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index ea3805712b76..51a14d1f2391 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -308,7 +308,8 @@ int sctp_send_reset_streams(struct sctp_association *as=
oc,
                                        goto out;

                        param_len +=3D str_nums * sizeof(__u16) +
-                                    sizeof(struct sctp_strreset_inreq);
+                                    (out ? sizeof(struct sctp_strreset_inr=
eq)
+                                         : sizeof(struct
sctp_strreset_outreq));
                }

Nits: Please keep the '>' on the same line as the left-hand operand and
indent the continuation line using the usual kernel style. Also No braces
are needed for a single statement.

if (nums * sizeof(__u16) + sizeof(struct sctp_strreset_outreq) >
    SCTP_MAX_CHUNK_LEN - sizeof(struct sctp_reconf_chunk))
        goto out;

Thanks.

