Return-Path: <linux-sctp+bounces-1241-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1RC8MJe7JGoy+wEAu9opvQ
	(envelope-from <linux-sctp+bounces-1241-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 07 Jun 2026 02:30:15 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6765364E9A8
	for <lists+linux-sctp@lfdr.de>; Sun, 07 Jun 2026 02:30:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=j6O7qCmx;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1241-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1241-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3185C3009F10
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2026 00:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EBA217F27;
	Sun,  7 Jun 2026 00:30:08 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B344071DF
	for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2026 00:30:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780792208; cv=pass; b=XPK0gleQbDi2l/dRo5K0V3rkq+caUHg542NxJhl+2qZYCplzpWh1bCGgP6aZcCx7zqd4EySNsYYiYrgv+OqQR4Uael4H87sV8qsAXJXl+QnLfzmA5fAK68KOa3plF8lT8LEy2Nu/2Etwx9VSeAe1v7fY99nSBIbn6GLbU0mbqv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780792208; c=relaxed/simple;
	bh=bvm8XR80mK0+tJ7bOaj+iLMt1hixXvlRE+ID0KlE5F8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcisJ0z2gqPLljP244j30WiJK4sNsWIFRP8O9QYXeCqUitRXYwQrNN3s5F7B+RV1n1geZK3IeD4D4QFqXqyRgdNJ5GWnc1dZx/P7rgx2Znl7s4RZNOiVbhu75yiTX7H4yR8qx7O3fA86xE2Wumn0ACUdfxWX2nuCTJGskD51VRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6O7qCmx; arc=pass smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8423f626a65so1304386b3a.2
        for <linux-sctp@vger.kernel.org>; Sat, 06 Jun 2026 17:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780792205; cv=none;
        d=google.com; s=arc-20240605;
        b=FKmazNnGRI825gcqH2MEYm+N3bWW7vsczmL1NlHeWWHaX0SEY7uv6CRE6X/FMTyp/W
         MtjYQt5UQiCYOY40ReEgJz5J0jkM95AOAVtC7AP1T37xdLLk+oKVou4lADV3YQlwO1NV
         0ghsAVPWtM/xGCK3VihAeNSpVlLQ+yZhz0h3KKkdrv9j0GHs9WO9rbbu/Mtag++4+OT2
         Z9QsLrXPpFF/ygN7Y7b3JYhzsx+UTvmSBp+DMtGCT92SRr29ar981NhkM4hpGltqYNCM
         04dV+ts/q9SNyki0vavQqS/Slwff2e+D44ngL3Sb1cmkZ5XkSMM+uLmBHB/AJUUemZaN
         W/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0CJN8f1kq0P5OFHhUxk52kB/BECDO+WDurskh2BXXEc=;
        fh=qQ+GMlofXc8rvLzdalqm6+7vpRWZyMm8GMYNc56bBiY=;
        b=THdUn+2UB5yCmIHbb8G36E4MzHq1doFzcCufF3tuGnD9eubjx/6Zf/Sth5PnKoUpAk
         +lJudN1Gl5skjzfMosfYRnB5Q73W3lcRJHWUB18jn50LQ1h6QOEox6mXPj35ZTAXnpKH
         n26wWDg6CRlU5xMPAGM2WMCBHIsCuRpVpMqbOda18lurbtKYhgTk5EMK2Lp0GLs62i1U
         I1YKe7VuUXapsBa+1U89ggSO3OF68ZTNNTzHxro09dJheDZFzIhCN9rv2OoswpKgnEeK
         2ydGRxW88MqM2h0hlqMYGiaJSnSzeVswzZFpKSp6f8CzsORjZzWwBe8kuzCev57wDzk7
         oopA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780792205; x=1781397005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CJN8f1kq0P5OFHhUxk52kB/BECDO+WDurskh2BXXEc=;
        b=j6O7qCmxHmH6zzs5K+Ps8rcC8Di7+YT41Qff8Lzhx8ErpXDz4Ug+EGVEWVqjmh2ZjL
         A6rO4CJi/O+5NKXtLs4gqaVpoSAKnj/+HFdL1ElI3JSq9DXYCtXzU3wNTgNN5yWyoknn
         aN5hsEgA/NK6t5aRjKtnKFKTah00YVsraSAI6c5AyqvBySoZSfGhi28r26X6H8uP9xaF
         YlcdifjqLhDQAAiul7I1qSR6bZfJG3i1o46v1v5OYk3XvViEdu6jukoXI50tImUoXbNs
         xrMYM+flEq1uINcgrPZAvHKIKOfZeUnqrdu8+PUE3QwqNjpBsr9anNHoogMNgQeRqpMY
         NVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780792205; x=1781397005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0CJN8f1kq0P5OFHhUxk52kB/BECDO+WDurskh2BXXEc=;
        b=C8tQHPlf2YLumi3qpRffFlj+LrfYgQ8vxOPKz5oFDtebijPAUiNvnNSjWPSe4lVwEn
         RipvKWyZ36A7qflzePRz61BkJWtCpD+FKpTzPO6T0vu77ybiXmIyiFq/qXzz9886/2JE
         9+FIvlHyN6mrbN14VN4/EYDqcjVVhN8afUbILISqUv0WYDB1W9r8OM3O0PCFcTHwAGNJ
         LKOSWGC8Y9ceNkVih8E70Khz2PNND6SXjvkHSiD1f838kfb2SPKhHiw/5bSgd7oTXaFe
         Uggr/fnVClK5Wvk3BJ+VAyePHWj4V4BuMoi+NLX2sw+ISDeGIccLSS6M/NkOrW5shhtU
         fRrA==
X-Gm-Message-State: AOJu0YyI/Zrq52xfO/OsdFXpkaQ3VuhI5IPSiRiwwTjpwtN3F65Q8MlM
	pTjUWkA0KDDd6u5FoNjjef2J/Nj3rWddWGceYtNRiVlIJQ2goEG0xJUDwaWLQs0IXM/dj0seqwl
	xSNvwjlic1pY3s4luo1Pphww97o6CHq0=
X-Gm-Gg: Acq92OFfzhDp5L7xPdYdLv6p+mgRLFBe9SuJwiBicCQ0cz72bRnXXDuNIp9pYvDao9B
	u31ro22VtAkcgOE0EI2Qs0C6lL4yTRZn7uaPLhYiWlM6vIx3u16r7/5AkVcdEWFP3LkEQHEEBUe
	8HDq7PuBEhed9AIEsusa+sM+YxH9j+/2Jypxjb9YsR1z+RFZntDLxPzxSrYdGg5qg4PSf4v85zP
	tulcXEYVjEOrMnJFqnAUPUJFy2qefSkXNfBhg4HGGbQzxy+c+VgVLOP7GFNageQbr5b5mqcj8R+
	03SRFdPjYTJpGsiyeUtw8AC3M+JU3D3F/4uIXs7oXY2QBffO8KhFlzrX+tgVpJewXuy1jpxdngj
	xd+ZEwPS/ZnIBBodQgQ==
X-Received: by 2002:a05:6a00:2441:b0:842:57e8:1bdc with SMTP id
 d2e1a72fcca58-842b0e718b4mr9040468b3a.18.1780792205031; Sat, 06 Jun 2026
 17:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d78954ecd94954653ee299400e98d74a03a6f7d3.1780603399.git.bronzed_45_vested@icloud.com>
In-Reply-To: <d78954ecd94954653ee299400e98d74a03a6f7d3.1780603399.git.bronzed_45_vested@icloud.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sat, 6 Jun 2026 20:29:53 -0400
X-Gm-Features: AVVi8Cff1SYXJTyct_UzvU-aEB56DUj-CEcggirsskGphb4yopP6wOJDomNiapg
Message-ID: <CADvbK_cw+w+NSS+=7wJwEd5Z2ziBesVgc4nz4PepPDy1hjNZew@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] sctp: stream: fully roll back denied
 add-stream state
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1241-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,icloud.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,icloud.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6765364E9A8

On Fri, Jun 5, 2026 at 1:54=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Wyatt Feng <bronzed_45_vested@icloud.com>
>
> When ADD_OUT_STREAMS is denied, SCTP only shrinks the queued chunks and
> then lowers outcnt. That leaves removed stream metadata behind, so a
> later re-add can reuse a stale ext and hit a null-pointer dereference in
> the scheduler get path.
>
> Fix the rollback by tearing down the removed stream state the same way
> other stream resizes do. Unschedule the current scheduler state, drop
> the removed stream ext state with sctp_stream_outq_migrate(), and then
> reschedule the remaining streams.
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
> Changes in v2:
>   - Moved the `sched` declaration below `addstrm` and dropped the
>     `out_curr` handling. The rollback fix now only unschedules the
>         current scheduler state, migrates/drops the removed stream ext
>         state, and reschedules the remaining streams.
>   - v1 Link: https://lore.kernel.org/all/345886be48a66f70bad26ddcea6defb3=
8d1d0f72.1780439824.git.bronzed_45_vested@icloud.com/
>
>
>  net/sctp/stream.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..5c2fdedea088 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -1038,6 +1038,7 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                         stsn, rtsn, GFP_ATOMIC);
>         } else if (req->type =3D=3D SCTP_PARAM_RESET_ADD_OUT_STREAMS) {
>                 struct sctp_strreset_addstrm *addstrm;
> +               const struct sctp_sched_ops *sched;
>                 __u16 number;
>
>                 addstrm =3D (struct sctp_strreset_addstrm *)req;
> @@ -1048,7 +1049,10 @@ struct sctp_chunk *sctp_process_strreset_resp(
>                         for (i =3D number; i < stream->outcnt; i++)
>                                 SCTP_SO(stream, i)->state =3D SCTP_STREAM=
_OPEN;
>                 } else {
> -                       sctp_stream_shrink_out(stream, number);
> +                       sched =3D sctp_sched_ops_from_stream(stream);
> +                       sched->unsched_all(stream);
> +                       sctp_stream_outq_migrate(stream, NULL, number);
> +                       sched->sched_all(stream);
>                         stream->outcnt =3D number;
>                 }
>
> --
> 2.43.7
>
Acked-by: Xin Long <lucien.xin@gmail.com>

