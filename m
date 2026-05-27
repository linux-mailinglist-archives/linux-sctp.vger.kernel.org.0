Return-Path: <linux-sctp+bounces-1218-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oME0IyppF2rcEAgAu9opvQ
	(envelope-from <linux-sctp+bounces-1218-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 23:59:06 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5135EA804
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 23:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF7C30448B9
	for <lists+linux-sctp@lfdr.de>; Wed, 27 May 2026 21:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBE3890F3;
	Wed, 27 May 2026 21:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNDBSWsV"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30346341AD6
	for <linux-sctp@vger.kernel.org>; Wed, 27 May 2026 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779919141; cv=pass; b=m92QiRN8ByGTyLjNnBPeCIrc8ErW4VcGSllD/i5exOU86OE9Gki1QbwQope1aCDK5C+U6UMkm75tY04BK09zUfaZ9513ccf4fKVPenmm4eq1jJGEYJkNjWmTcMSa1AMuT6R4zJxZcCeYIZFHkCF8hxbkzYQDTT2KWDJYJyY886A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779919141; c=relaxed/simple;
	bh=jC31wbituFYGZEW8Zzrrqo2ywlxmr0q5hdPoo2cZcHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aT4q+1RBSLUxax0tGXT/XclU70CdYPqT8xTABu/QmjtdHg9Ej8sZIXI+TcFJNKvj4LvslxesP4mbRDdtCljdr7dDwX7VLVgW04H1l6SLRo5OAoAGAiDvmv2vBqjmy1Q3SjtMIDnC14I60cS5YIqtN4k8j1RrLdZ0t54CuXAcslU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNDBSWsV; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36af4b7840aso2598849a91.3
        for <linux-sctp@vger.kernel.org>; Wed, 27 May 2026 14:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779919139; cv=none;
        d=google.com; s=arc-20240605;
        b=P5kDcKhj57ceYIeiEEdiALeEYlrmJwl21+0g6FgpDKU4R/iNOsQN2iYWOM7SaEtdTv
         91D2bAijH9WFxIhxvvy8vxbe31ayb8dMcG7j77mB67068JHChx/lRMZvgEDyGnOkMAS2
         xRSwA93T6nH6yjnZoQx+U/cWjSAFPUNlcTSiRcefGWyoQQA7xS3T5krJXE2BaXtuOmRs
         C512NSVoYJJFo7tNNI9nXMv9rbJnTaG/fUfvXaBfwmm9wwFWxwHmBj7CeOvDCx0iBwHG
         fIUyBYdGYEzpglt9MgGin9gzV3O78n3IbCPLiE4eOSD6GN+TajLKyFcL83KHjES8hNq5
         w3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rpo5vbgrRtRDRZwdk6vhAMK5bdc4lItXSamkQ1SeTh0=;
        fh=uWyes7byO7sC7WOkDawhM3RQlvHvXt6tmTu+xlmHXss=;
        b=e7vWgTYxiO6nnOs24LZArOD+ESEhjWCSXuvNvSPblT6G1Ymuok+3+ER9HO+KyCmdVn
         rWNaRCo9jal14HZE7hUx+KoeAeZXoJT/Au5+m4vj2engLi9wDZPJuNtgDd3YvGbDocSO
         Y6xg6oz4eYQ5nk4T937jD3/Xm2V6RtqX2DMdDPc10chyrECXlf6HVtQx/lwryX1Z2yI0
         eaaQb89fZlK4o65XoeKyF6/NVE8s2UQGjVHIMNcatdoWThYIx4Vfa2ji7ezE14JGwULU
         TG1QZhEfVeHvn2dbXDuKF4M62J+zKzQuH9nHMLJG8Xh6z2/h0SMDxUobq9lEOdLuSbUj
         Xe9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779919139; x=1780523939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rpo5vbgrRtRDRZwdk6vhAMK5bdc4lItXSamkQ1SeTh0=;
        b=sNDBSWsV8GzXAn3KeLEUgipEe64GCWCsUMNNHq6pF72T+0xosd2JNzswMogNBQ2Ygn
         kGNqU+WVNNJQrmhTvN+WTLnCq9hXoQ1Zd6ypwpOi3PKInJYSVFNYHJMC2LdTYyz4GPb7
         A+iz1T8oBj9IxaCpIqdrIwYWHRveADKQRLCr0TKrwBFyWAjfPifpnm1SlNVtMeEgZBxV
         JQrv6AI3JQmhpBWIlbQPKn8FO4b75g/zIRk0yvaXLezy6peHWpUuLoLbOBTYprb7TsKF
         QN7ocy6kAAlpALQ5UVAY0HCHYPhI8rYZs4aH/c2L70K8NakNm3C+IxC0LWMRa2IbH2By
         bSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779919139; x=1780523939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rpo5vbgrRtRDRZwdk6vhAMK5bdc4lItXSamkQ1SeTh0=;
        b=pdMw2gp0OxOeKzvM4jMc8gGbGDJ3C0oB11qA5nFw9dhJH92zBchQASCLvQSTsZlDq9
         OCaVyBRFYMOQlA+hzBDacii+i21upJ5GxMRoLaVTe1iDUOs9e3GgklbNBRpnXemgICVc
         4I9N5WiJ7nYA4lEEUv64/+6d5cvM4kSs7+gghH6Df1O0jmCTcR4eGiVMRm56eKCydcG0
         d9I+aC4dSEpR1no9a74vT+OT0JywhN9ndy88SLTBf/GowmUpV5ZVy8vJf46mCQ1FCBHi
         yTsUpMtbF8sCX7TfLiXepKcP5nrpIQWiSahXzjTqA9nKYgMIGJCkZgfPqcKAvvzD50tq
         wwDQ==
X-Gm-Message-State: AOJu0YyxTdUoAG7x1Oas2L5wEBhfRZYVV46ty6rEi4bfjLKte3x3vHK6
	dCIBcLz1k6FX6TCpPDVPVtXB5qGWLXvAn8HkcrLeYNqC9NirTCu4aeek42eUD5/p9Hb+DU/EIU6
	dYkBkFTsNYBUB9Q3+A5bYar1YOB6wK+8=
X-Gm-Gg: Acq92OEItacRRyEIlbSM9lwtU6stXlwwPlv5Ql2340gznx0dvgPThzXxqHGXdWYUbXf
	Kv56g/cZbrTvu1J+KjVn3E4vPdRWtgluEmbIQntBJyHhQ0oYyzA4NN95n58VguJFDZEgjDSbHVD
	fKiCLGZCLEp60DpvDsRyCjV/3/MmAxWXRwv9Lb4fqbTWDvBcgf1XPsOIhtnIJNp0Vht7oCvS61V
	TytwFIqJosffT2R6jLo5g4hzXvwj/iQmInVvOO8f86wiK2+J3/Rp40HGCtA3zpD2irt4pQNXGT7
	2arUJKNPaDbRUDZ+X9I91m4wzZcDgm2GguVKVqxrLKLYh+CVV3unqY9Shge8Ja9pp4mvqcoW6/k
	f74rl0u8XBzVWGuY19poW7XLAyNyHPnJLNKYH7j+GuWk63Jv3zg==
X-Received: by 2002:a05:6a20:734c:b0:3b3:1951:48b7 with SMTP id
 adf61e73a8af0-3b328fdb6f0mr25812094637.50.1779919139431; Wed, 27 May 2026
 14:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1779632544.git.xuyq21@lenovo.com> <4d56a975d40611822b2bd44f2f215e3534d76276.1779632544.git.xuyq21@lenovo.com>
In-Reply-To: <4d56a975d40611822b2bd44f2f215e3534d76276.1779632544.git.xuyq21@lenovo.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 27 May 2026 17:58:47 -0400
X-Gm-Features: AVHnY4Jdb7aP58sGcuX0n-QoBVJ_RUDZxn4MGj_N74DwHqdhDrKlIcv5hqVog2o
Message-ID: <CADvbK_dygG8qCDtG_LbsQ0=2PP4muNq2X7TNRqTiUMAoFjg5pA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sctp: clear current outbound stream on
 stream teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, zcliangcn@gmail.com, 
	bird@lzu.edu.cn, xuyq21@lenovo.com
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
	TAGGED_FROM(0.00)[bounces-1218-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,lzu.edu.cn,lenovo.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid,lenovo.com:email]
X-Rspamd-Queue-Id: 8F5135EA804
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 1:43=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Yuqi Xu <xuyq21@lenovo.com>
>
> out_curr caches the outbound stream selected for continuing a
> fragmented message. That pointer refers directly to an entry in the
> stream->out table.
>
> When the stream table is torn down, such as during stream updates for
> association restart handling, the old outbound stream entries are freed
> before a new table is installed. Clear out_curr as part of
> sctp_stream_free() so later dequeue paths never keep following a stale
> stream pointer after the teardown.
>
> This keeps the lifetime rule local to the stream teardown helper and
> covers every current caller that frees the outbound stream table.
>
> Fixes: 5bbbbe32a431 ("sctp: introduce stream scheduler foundations")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Yuqi Xu <xuyq21@lenovo.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/stream.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sctp/stream.c b/net/sctp/stream.c
> index c2247793c88b..207e0a77f9af 100644
> --- a/net/sctp/stream.c
> +++ b/net/sctp/stream.c
> @@ -186,6 +186,7 @@ void sctp_stream_free(struct sctp_stream *stream)
>         int i;
>
>         sched->unsched_all(stream);
> +       stream->out_curr =3D NULL;
>         for (i =3D 0; i < stream->outcnt; i++)
>                 sctp_stream_free_ext(stream, i);
>         genradix_free(&stream->out);

As commented on another patch, purging outqueue will also clear
stream->out_curr for the corner case via:

sctp_outq_teardown() -> sctp_sched_dequeue_done(last_chunk).

so there's no need to do it here.

Thanks.

