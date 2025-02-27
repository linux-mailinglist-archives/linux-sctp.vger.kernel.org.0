Return-Path: <linux-sctp+bounces-363-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C78A477E9
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216F13A9FDB
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 08:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FA7225403;
	Thu, 27 Feb 2025 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzGU+NXR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD5223711
	for <linux-sctp@vger.kernel.org>; Thu, 27 Feb 2025 08:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740645320; cv=none; b=q0AmISNNeuPdvMciJXr9+SGQMHzMigPJZ4coBM0aaNelQYALp18fj9VSy03MCg5SE3P4AZUewOJ8rUYQPbVvkjIh9QYY/XhvRlwajAFKlXbapvA2ODPyYRVvMYxdFep4PamnlJZdcgsYeJinOEqdGWdQ5CNFduGHgpoe8JgJP+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740645320; c=relaxed/simple;
	bh=xPMrcZXlyzkOROzTylH2sE2WQhKnhPRp81sgczS0BDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7hD4gMnS1uZgLaabScxQAAKHPpSH8+waUqfLUCzbminpzw76BVMGZrb1JwbGWtIawxoxjOsuLwojVbhisYBKuezRN2Zhj/AsRmwuOuxNB83dp5kapiOAPPoUdOzyQwUr/6CxYzQ26NKayCRnnT+a7mJLARUSVrQAirtIgXurUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzGU+NXR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-471fe5e0a80so6571531cf.1
        for <linux-sctp@vger.kernel.org>; Thu, 27 Feb 2025 00:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740645317; x=1741250117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbUNq4GyX64nqzEmvp+umfuZHI26ffw9v99H9Suo7JE=;
        b=HzGU+NXRvHEegbXS0+SMUpFYF+3KoeWCz2qMFDBPnmHFMNRm+hhRLHoeXdcxqXa8lE
         xQvE/sTAjt40g8NXGkK5j08LkTnB9e7FROCcEO1kl7nguY3MCGaSdRW9420Bf/W9skYm
         cJi6u4THLBigEv1O5NogZQ6+/iwhF3irdrRhhFGZ2T5jIMMOfVLvzrZXUIGsB/ue4GOm
         JJI29VQkIkiTX9kJCMUsw0do1IjEW5sFl+V7eMpVEzUTcABoSAXhRSySk4SYuWjve7x3
         VfmAlbKzfIWhDykk5xZO1QhSmXvjelQNK3gMIADwA7WNAEni2UCUPs63NbJrPEu+mcQF
         f7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740645317; x=1741250117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EbUNq4GyX64nqzEmvp+umfuZHI26ffw9v99H9Suo7JE=;
        b=o0YzFImgx44f5WVA5JNECfmF2iCZyZqjnVCsDiQmy3TuJ5T8TXnjVg5wGeo3/u2L8W
         seuaszVTm3aqCAop7KjqI2iKWppYPR1bEZb3lzvKtxw8Li9v9j6IdLd5MB/Wm6Ic+v8r
         kt1+fMpuycznWBKffayQShIMIMIbzK7nemn8lPS9cyFRM4FPlDriF15reyaCxs/+LpUh
         tvPz2ZY2CHQt5iSwhhXsGBzwM7lCoQs1MIYv8Fx1SB91EzlL+fXPv+4SyjxQeLL0bEkT
         PBsUu5JOgml321OehG7dLMZAwfqL59IttyOAfhN+AuXI8FCWtQcvMJ6igxMtvwOKi63f
         EZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy6eaThd35cxfLSQz3dwf6ZN8S3yWPbf860DJZMksNrLzaGyR0glDT3tOdAeTj/f5x6Dz9FGPlw+h8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/JeXIZMnhTwdRpe/nN6g38U8Csgve19T7NJb3HQGMNMmxSUWT
	K1GeAVOqTiP/SfKKZ2TkNjsTxJod0tykMYAzk4ZTfx3anAajZ9q5//Sl9EUN9ITTLBDz6p4b0qr
	hEn6ENtXLUJnU+Mqh6GqSUtuSuuPWQIrof//S
X-Gm-Gg: ASbGncttUvhfoBkVCu0CqvK6maIOEBM5kgqemIOuVGaKYjsx1gEZbsuc2hDyxY5VM5Z
	0CFhpLlmlYUV97vR4iVQUV+zNKomyTauvTT7xqLDvDWuScvrCzHnEw6oPcCEsnp0rS9EX/8sraL
	vZBVoZaM8=
X-Google-Smtp-Source: AGHT+IF7aj3xZqg1BXSkAfM9Yrb4ohI/2Ky9Ht430sL32q+fWf5c8humNsilGQHX1CYP+rTmJHV5RbiY8qCIFlua/4w=
X-Received: by 2002:ac8:598b:0:b0:472:95f:d25e with SMTP id
 d75a77b69052e-4722473cfb4mr342060211cf.19.1740645316870; Thu, 27 Feb 2025
 00:35:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740643844.git.tanggeliang@kylinos.cn> <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
In-Reply-To: <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 27 Feb 2025 09:35:05 +0100
X-Gm-Features: AQ5f1JryXKMVP6N9LHTCBYmNcUmx9qDszFAnKpx8VGAyOne3EBu3Vo70b-0zGuA
Message-ID: <CANn89i+ZLAPPKVCzAMrchJBvisiOsEZyVN-TqGUkEH8EFApbpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 4/4] net/tcp_ao: use sock_kmemdup for tcp_ao_key
To: Geliang Tang <geliang@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:24=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Instead of using sock_kmalloc() to allocate a tcp_ao_key "new_key" and
> then immediately duplicate the input "key" to it in tcp_ao_copy_key(),
> the newly added sock_kmemdup() helper can be used to simplify the code.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  net/ipv4/tcp_ao.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> index bbb8d5f0eae7..d21412d469cc 100644
> --- a/net/ipv4/tcp_ao.c
> +++ b/net/ipv4/tcp_ao.c
> @@ -246,12 +246,11 @@ static struct tcp_ao_key *tcp_ao_copy_key(struct so=
ck *sk,
>  {
>         struct tcp_ao_key *new_key;
>
> -       new_key =3D sock_kmalloc(sk, tcp_ao_sizeof_key(key),
> +       new_key =3D sock_kmemdup(sk, key, tcp_ao_sizeof_key(key),
>                                GFP_ATOMIC);
>         if (!new_key)
>                 return NULL;
>
> -       *new_key =3D *key;

Note that this only copies 'sizeof(struct tcp_ao_key)' bytes, which is
smaller than tcp_ao_sizeof_key(key)

