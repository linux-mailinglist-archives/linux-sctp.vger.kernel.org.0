Return-Path: <linux-sctp+bounces-510-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE98AB5E8F
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 23:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A98189BD81
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 21:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CAC2581;
	Tue, 13 May 2025 21:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMfjPjoL"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5380220EB
	for <linux-sctp@vger.kernel.org>; Tue, 13 May 2025 21:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172738; cv=none; b=Rlv8Iye826t/xyLE+IRaZCuA6Q53wOfPbIvKRTPc5koazGwR3+3A4DXo4NCMqu0P7cKi6h6dKW6LFxnbNReZBnOAn8dd3+k+7jMpJevwyl8+YZdwxIBf7YM5jzYreT6NHji32ReVoIhOXCV9RS/uP2fDEHzQCVFyjOcivvaIcHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172738; c=relaxed/simple;
	bh=iLG60YqVRPqMYfQLKGBSR2FARKjobDDegTedcobn/Zk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVQBlNfbuAaAXL8eyFeay/E3IfF9RVmSKTRGAmaBii7crj5yr5MeyQUaDYfkQwqlwWnRtEVLKmwrTIIn5ky2gsF/PchzcSW2QXlaGF6JTKoTrL6htlyiHrmSuCEp/Tpkm5eIiCKgA+thC+acy83JFcjNuFysOGBVFmh8hZhvPqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMfjPjoL; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3db6ddcef4eso5305235ab.2
        for <linux-sctp@vger.kernel.org>; Tue, 13 May 2025 14:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747172736; x=1747777536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GpSIkNaXiVpY2zNXrGEbzdNeuGUUR+fkU+G562WLTBY=;
        b=IMfjPjoL2/egrEigQQC68QtiJZYopKpjBTDNj6sIPTcM2KGIPOizLMhhCPebYORebd
         ly3B2crSDyaynFwhBnsWj3IKVOj2MQ0QYWk0tKW3GJ3MMaG/twYAej++brU4zVuGHsAC
         eUez9idtb5ryyXlki5t0xXboSb9XsOaiVMn8vyvkiI0nLyEnUAZ1v9mfCUpFjtcZqyE1
         HezaTA1LBj5h61UziB+66zg0Ys53oufmFqta6867kxYAyL3CdgWSoo54awRLNSpLXyHC
         y9Y/ai+EGdAq6aW7Scj4FOE9v1rARfqc1ZYt/laLeEni0l0phHVO+G7TVy0ohHZLpReh
         3qRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747172736; x=1747777536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpSIkNaXiVpY2zNXrGEbzdNeuGUUR+fkU+G562WLTBY=;
        b=fNsGDF0HjWIcr2q+0PhSb/EJpGKqRHyipuyB4TJ71jweiViuoHCEVjiCJKZtS4cszz
         VYW5C9TjGp6SlwyM4bC/68S2fFRm67akTdJfoRQnt1CONjQB5eh0tXB5EVn9OBgKgMqd
         8YttG8UX6636KyemBZRRjmsACrdYIf0upen93c8uecwPe8AaBdkD3KBeBMZrkj/HkTMd
         xoHhbwIPuyNcTIpr94ezij2u29hQPSAF81vBu4NlzzWBM+4n9f4wvNblVv5NTnZ9pqfD
         qbpUT9h/GqUL4YYUZ3s1h3uQ9ZhS80mo/pKB1vS8wirwuZuCbELtcV5RaeP06hPmOvYF
         hv9g==
X-Gm-Message-State: AOJu0YxxnoLBVysCJY4c25FYUa6Kv3rVEytkq9KIzismTd8jvo/qDxFK
	FptBLB8NF6ikLBpRJoe60Ix9tZTmap3pn0+iHz0gbRhaEwEVUFg9R/9CRzL3gk8J+DfdajR1/ZY
	q/R4j97ufX5T8ybRuJjrXoe2lWV4=
X-Gm-Gg: ASbGncun2Xb7qvfsx4enMnuSo/R7HS16kMdc2RrILd8xkHZpcLSNeRvM9xSS/xrcNsv
	doowqi3iXyCc2+t62OwACiGQ0iMiLovXR4Wqh4lUwByfbk13X+DuqkqxAhhkd2iCwhpeu8/e6jz
	On7irZEvNtF9Rrb2q4KMaopNY6505+TckxDWu+Wb79wSaPEm9B2HW568E7kyFU8v5uTQ==
X-Google-Smtp-Source: AGHT+IFr4Ged4xOZcfdIAr1WEebHuNz2WdiP9thdJgkrFCTWcUqlA/1CFmY+4Vh4T6OI1IoOYkIq1CxpMMuy7O1ylnc=
X-Received: by 2002:a05:6e02:1785:b0:3d3:d00c:3602 with SMTP id
 e9e14a558f8ab-3db6f7a4048mr13180495ab.10.1747172736434; Tue, 13 May 2025
 14:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512123224.1231301-1-oss@malat.biz>
In-Reply-To: <20250512123224.1231301-1-oss@malat.biz>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 13 May 2025 17:45:25 -0400
X-Gm-Features: AX0GCFvM1aEaPkE6Pxy6Ylp_JLu41SqUvmABjbAGrLqJ1Ib4RhgPrCAixOBRW6w
Message-ID: <CADvbK_ctiip5mu3zfAu5zmD6W9BuHmP+cL-WGvFQYtyT8u_HyQ@mail.gmail.com>
Subject: Re: [PATCH] sctp: Do not wake readers in __sctp_write_space()
To: Petr Malat <oss@malat.biz>
Cc: linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 8:33=E2=80=AFAM Petr Malat <oss@malat.biz> wrote:
>
> Function __sctp_write_space() doesn't set poll key, which leads to
> ep_poll_callback() waking up all waiters, not only these waiting
> for the socket being writable. Set the key properly using
> wake_up_interruptible_poll(), which is preferred over the sync
> variant, as writers are not woken up before at least half of the
> queue is available. Also, TCP does the same.
>
> Signed-off-by: Petr Malat <oss@malat.biz>
> ---
>  net/sctp/socket.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 53725ee7ba06..b301d64d9d80 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -9100,7 +9100,8 @@ static void __sctp_write_space(struct sctp_associat=
ion *asoc)
>                 wq =3D rcu_dereference(sk->sk_wq);
>                 if (wq) {
>                         if (waitqueue_active(&wq->wait))
> -                               wake_up_interruptible(&wq->wait);
> +                               wake_up_interruptible_poll(&wq->wait, EPO=
LLOUT |
> +                                               EPOLLWRNORM | EPOLLWRBAND=
);
>
>                         /* Note that we try to include the Async I/O supp=
ort
>                          * here by modeling from the current TCP/UDP code=
.
> --
> 2.39.5
>
Acked-by: Xin Long <lucien.xin@gmail.com>

