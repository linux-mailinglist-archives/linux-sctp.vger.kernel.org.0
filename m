Return-Path: <linux-sctp+bounces-1230-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZezeN0xbIGpe1wAAu9opvQ
	(envelope-from <linux-sctp+bounces-1230-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 03 Jun 2026 18:50:20 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC06D639EAA
	for <lists+linux-sctp@lfdr.de>; Wed, 03 Jun 2026 18:50:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LverCq/b";
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1230-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1230-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CEFB309ADC2
	for <lists+linux-sctp@lfdr.de>; Wed,  3 Jun 2026 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E543A9611;
	Wed,  3 Jun 2026 16:17:37 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536333DA7CD
	for <linux-sctp@vger.kernel.org>; Wed,  3 Jun 2026 16:17:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780503457; cv=pass; b=qzV/5UdVKHeXm0pdRyWLgkr5+UR0MCl6KloUL7t0ybIHyWKn5P0ge39m6xPQ81Q+QEAU52PV31scFXkyfAUiiET3RwPC6PyI+B52AvBOwWIfcXI9NEWXTDQuM4SVyAHHxkROUKNdqXuHAPjqkcG23gPmL1EyrFrKrxLZcCdRAfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780503457; c=relaxed/simple;
	bh=35yTCGZEFh5BBZx7RUwjJAduTUoa5mA8xziqKGSWw0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wl8E3RwjZGSUUltm3kWQUeukKok9qg3hvY69/Ncqc22EWZeSERtjwQrDrbps9SZsSKD6PBtZezVOyfpYa+HRZBKxZbkfdUh9Dv2PN2KzspEUrWPy6bpqGEFEd6n+Mh2imkMRS8Z7Su8iWtUCxVQnnkwFT34vzY/l6nCQ0lTP1Uo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LverCq/b; arc=pass smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c858014845aso403116a12.1
        for <linux-sctp@vger.kernel.org>; Wed, 03 Jun 2026 09:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780503455; cv=none;
        d=google.com; s=arc-20240605;
        b=EHS6EndTXn/8uNbFP2ZZlUshjJRaiMm0hNqSMmayNF9g+pgVOQRRv/2Gsu0qDpo8Oj
         72pKvDBloFUPOZkaiV1p5WKudR4X6ifsLzk2TBEogmFaIvVOqLke7LvUFFN78DhfaaUV
         55dfh/Q/lKytQxRsm1wzylKHKXXHF9BQ8/vzjLXk7Arrqt8e3o9bBj325gLke4QWlyQz
         zSSqtTTmgRfjmdOwSLauKvxumQB5/Oq/5/IhZDnbnlD5rBWdAUlMwgiK4+GSHaHDf0Xz
         ek6wsmSQhDxrDGJbfKqGsFK68hqnnn+zFfwtugAFbFzU23PhnwhsxSH1odHXzgPg0dpb
         E1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wf0teoBvvQIcbnBkQqQlc7GnVBu3/kxy8sYSpzsvuqs=;
        fh=qQ+GMlofXc8rvLzdalqm6+7vpRWZyMm8GMYNc56bBiY=;
        b=WuCibH7tC401Gly7cAnBrN0ok3YMMyI7cxcj0A/3uAJcxpcXARq8EHGXNgCXUfIMWZ
         4ZJ2OOoylwfg0j7f6BjIb8OVXC4BIFbjOdZTqZjyErUUWcxXCrqJGEyS1qTagh9Vbznr
         Qgsphqlxpf3nsZSz7zoBFKESnUy2F2aY+UQK2BH7kUBj/h9HVHLvWqDMmGhVKMGXWu6l
         mROp/AdStNTan7VrcK/08wN8oXoF/d7lDOs6IJWThyfkEc6ACK3WQg3AkiWyfo19WJ72
         8BvsQ9T0viFV5LQamrFtroj3voNAMJZKKh3Kj12AoKDRCH/aNfXeuUwkVnDfV3mdODxo
         x+QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780503455; x=1781108255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wf0teoBvvQIcbnBkQqQlc7GnVBu3/kxy8sYSpzsvuqs=;
        b=LverCq/ba/TiYxOIzRGykO3gBBKFUs0t2sCA8JHGH8xPBWvYZBy4holKGF1mVgP3nM
         hsWJE/fDDibA/JWEae9N9l2UB5rgZIQlDuj7eaTjUKCIsdbLQnuaGw/nVHtbYDNLR25j
         NnfF431tTOYtKKt7NTp3r6qMzVZWYFr4rPF9mScMehnIXyLrVfYCzviUcPgFZgaOLT1g
         qCmVpqLLAO996SlVgx99AZsmV0GRO8nphGjF0eLVaxEAST4BDy4Gq+g3JMvLn2z9S5Qk
         U/srV5CGS1re1tpOi9/0rdR06Ltu654i0CN8X10FfJoj44a3BOxnSC8dZDs7Iwz85ao5
         elDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780503455; x=1781108255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wf0teoBvvQIcbnBkQqQlc7GnVBu3/kxy8sYSpzsvuqs=;
        b=V7L5NS4QE2XjMmxAbpXWCul0TjXAEi98hUo+SumEtoN03cL4HROh89zRC+p2K4r12O
         ZEWFN/+NK5o+zEKpxNoClB/ab8uhUTarPI5kU5mJBCRK5pn6rneHfoz9xJ48Pt2Vmh1y
         6lwCV1i0w6Ut5D/TJIuvT4y3JMMZnPQ8yeWChGNHL1d7tFjSSHrYL6ehAwGHnLDhPWYE
         a+NOSxDECuahUEvwdNUpsMJZb3KnaZ0T/1KB/HpwyOKHY1qiDvuFFGHOsVef9EiB0Ytc
         elUO+5ZmwN0hxOVstktmCOsrxeUwg6WXtrkZMCNdvZIBE1ZkuvE1o5tfbGguYu59h1j9
         blGg==
X-Gm-Message-State: AOJu0YzWBXn4zL1grUmWy4Dx0XnXwmpqrgVWHMZBPrqMT3yRw2LMrfCL
	6fWSpMvuIJAIgjGAX3cWvUdzN6uwZCvB+l8RH3CxGc0lkh11kBjogy45GTXfhRjUqV4klHMxMP1
	xWT5i/yh16En/J0HWznbWe5iM3G/Tes4=
X-Gm-Gg: Acq92OGPXQbSZwJ1Q+8FOBzCVmc7An52XKFvmkz/5NvFJVuIp8cqFRJiY5CUwstHV8x
	SJdm1ay7FZielUVHj1+xRr0BUGsXG8pQsoSaI/HBzFfS7gg1l2xHb/KRKsJ8qUwF6Lhzw7FXbdq
	7Nk6pGCjFYA21Gr5rA0wZUttJGOG/tdYQ4q+5pUNaPoFEHpkpZNRFtav/MS/htKvbZyOYtVtbuc
	0B669e362POheP8tA7MZL2a04x4xRXLOl12ofeXZdoEpztlY4/e2ROtpKVEc+SJIQ45alHyHnWn
	eJQuKHE4ig+glL5hzRgeimouzvKCwKoZfq3SMCYMZP4ZI/o6kDeW43/C7v59OtdxmOAFz41gePC
	6ltU7nMe1EXycCfUhkpmul9FCgkxzNDa9cxeO6z9agoirN6UEoQ==
X-Received: by 2002:a05:6a21:150d:b0:3a2:edff:2975 with SMTP id
 adf61e73a8af0-3b4b202f8bemr43887637.25.1780503455283; Wed, 03 Jun 2026
 09:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780439824.git.bronzed_45_vested@icloud.com> <345886be48a66f70bad26ddcea6defb38d1d0f72.1780439824.git.bronzed_45_vested@icloud.com>
In-Reply-To: <345886be48a66f70bad26ddcea6defb38d1d0f72.1780439824.git.bronzed_45_vested@icloud.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 3 Jun 2026 12:17:23 -0400
X-Gm-Features: AVHnY4Lrb5hiDfvSo-lr3zrQ1yMaEYReNJTNcwgGKfGsajNvGcR_KgeT5FjHhYg
Message-ID: <CADvbK_fBqxVE+-ruaaYXsJY9L1TpchJrcLmhq-sBchAQTVZB_g@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: stream: fully roll back denied add-stream state
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1230-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,icloud.com];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,icloud.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC06D639EAA

On Wed, Jun 3, 2026 at 6:19=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> When ADD_OUT_STREAMS is denied, SCTP only shrinks the queued chunks and
> then lowers outcnt. That leaves removed stream metadata behind, so a
> later re-add can reuse a stale ext and hit a null-pointer dereference in
> the scheduler get path.
>
> Fix the rollback by tearing down the removed stream state the same way
> other stream resizes do. Unschedule the current scheduler state, clear
> out_curr if it still points at a removed stream, drop the removed stream
> ext state with sctp_stream_outq_migrate(), and then reschedule the
> remaining streams.
>
> This keeps scheduler-private RR/FC/PRIO lists consistent while fully
> rolling back denied outgoing stream additions.
>
> Fixes: 637784ade221 ("sctp: introduce priority based stream scheduler")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/stream.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..5c07c6148228 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -1037,6 +1037,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                 *evp =3D sctp_ulpevent_make_assoc_reset_event(asoc, flags=
,
>                         stsn, rtsn, GFP_ATOMIC);
>         } else if (req->type =3D=3D SCTP_PARAM_RESET_ADD_OUT_STREAMS) {
> +               const struct sctp_sched_ops *sched;
>                 struct sctp_strreset_addstrm *addstrm;
Thanks for the patch.

Please move 'sched' below 'addstrm' to follow the reverse Christmas tree
declaration style.

>                 __u16 number;
>
> @@ -1048,7 +1049,16 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                         for (i =3D number; i < stream->outcnt; i++)
>                                 SCTP_SO(stream, i)->state =3D SCTP_STREAM=
_OPEN;
>                 } else {
> -                       sctp_stream_shrink_out(stream, number);
> +                       sched =3D sctp_sched_ops_from_stream(stream);
> +                       sched->unsched_all(stream);
> +                       if (stream->out_curr)
> +                               for (i =3D number; i < stream->outcnt; i+=
+)
> +                                       if (stream->out_curr =3D=3D SCTP_=
SO(stream, i)) {
> +                                               stream->out_curr =3D NULL=
;
> +                                               break;
> +                                       }
I don=E2=80=99t think we need to update stream->out_curr here since it shou=
ld never
end up pointing to a closed stream.

out_curr is only set in sctp_sched_dequeue_done(), and the stream_state =3D=
=3D
SCTP_STREAM_CLOSED check in sctp_outq_flush_data() already prevents it from
being assigned to a closed stream.

If the concern is the assignment in the sctp_chunk_abandoned() path, you
could just move the stream_state =3D=3D SCTP_STREAM_CLOSED check above that=
 to
make the intent clearer in sctp_outq_flush_data().

Thanks.

> +                       sctp_stream_outq_migrate(stream, NULL, number);
> +                       sched->sched_all(stream);
>                         stream->outcnt =3D number;
>                 }
>
> --
> 2.43.7
>

