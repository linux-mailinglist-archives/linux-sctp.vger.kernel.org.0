Return-Path: <linux-sctp+bounces-29-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2468855309
	for <lists+linux-sctp@lfdr.de>; Wed, 14 Feb 2024 20:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5FD281B87
	for <lists+linux-sctp@lfdr.de>; Wed, 14 Feb 2024 19:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D6D13B78D;
	Wed, 14 Feb 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEWwCpxS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6CB12D768;
	Wed, 14 Feb 2024 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938074; cv=none; b=dNZpkgzTcoCfBIM3fxaWeIq+Vn053E+8m1g2b9eT9p0p+PqWiuJCb6RUiGXAEquXJm5GK89RTnpHM84+l2ecKtFHR8Pc1cSDaQBRA4OSC4mPmkASxy/Q9xMIbp3izr1b9I0ABVbGi+YLhEYebjHBqzEfjJctfTbicuYBxbrwHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938074; c=relaxed/simple;
	bh=MaJZuXgtafOGc1X7dn5qpF3FNN6F4IyRYiNdXmKaABM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4F/LOc89xve3nF4KJ7zwqZrnppmt1FxYAGgU7CLOe6QD948guPinqL/vv31wu2XWLUJxjHVVUuARXRnSqjhAlreDUwzONGbdpIIMOiT3Q3FP0HOAmMnfvU2/g1G/8vSUhHerMO+xsktDV1KYCkfnT6N9B10mymoSe42Vf4CvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEWwCpxS; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-363d953a6c5so221655ab.1;
        Wed, 14 Feb 2024 11:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707938072; x=1708542872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XcRLFBmhxBNmC++s4eS7gG/u6Bkk3SvDAzwYVX1fDNg=;
        b=YEWwCpxSFI2jAhBG50HHH3UBEL8NkR69d1I3BuZwMB1ENRfDSsFcAFqUNfDGfD5Ebq
         OFLhRLk8KjcUn9ZG2QkTiR+GpRjYxp6T9lHdWWrxIBDCY65QUbxPqsEojbWZ3KuhppI7
         zbQMd+0dNZnnD79kt5EJUeiUqNCDiiR55aelyDsDOAuM+pAw3rIVbzZ187Y3YBMQ52rm
         GsnNiYwn70OOKEil4lUrIPLKh8FIkdpC29TXeLZFyK0DiFR5a/26O5VQOVUAJBtC3yXy
         uGM4UE5Z1yKQmfmVqUfwtlWjFU2II1jffxrp7wLcIotZ6DKewThIjTlZcj7SS4Ux1ZgD
         AYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707938072; x=1708542872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XcRLFBmhxBNmC++s4eS7gG/u6Bkk3SvDAzwYVX1fDNg=;
        b=iGo81cZ2vUzKoCAFLZYfZhBjbwuZIAr8tZse0HyuqvBRNNspNbz6y2euLWK2gBKv1y
         gQaMf9PFhHhZEDAJNyKZVuxawQDy5Vv7SGJB0KnLdjX9zIsjA5HOLRYIRbtjbKYYXClJ
         YMGkMjvfTohA/u6kvO1oqs9VmssK3joYo6w6GuSHuhnAth2c6Q0YkcPCagHhHIf97OBz
         PRioAzuQbOCUV5MfeBSv2rebZFEy+A9gbc9U5vSFr9s7fPJ2txwqWP7SrmyI0xVFrZul
         L2A4G54QVdx5rF/+4Vbw0AhiGrH5CPBI/mxWJfFXyIfFOL17l721P9rx4IZHQF+bp3yt
         bUJg==
X-Forwarded-Encrypted: i=1; AJvYcCV6L9ctkd4oJ1W2YK9xX+SQb+vn24W/7WDFcRyztnStCaG2y9rUGnC8SOoffgT5+bGiFu4THmF5sVPvYC07Bl7+M+GIUYMrmJODQbajV1gBoEKhfFA0uCGlzptTERK58XvMJw==
X-Gm-Message-State: AOJu0YxGxK6TybKl7GFKtIE2N149KpqPYy1lASBt1wZcAd2W4BEB/6bO
	VERch3oltTUNpSkmyPPX/P+ihKzrOsfxENQmv9W0GCNCYVY6qg7x6Oaz6Q9bfn0tLkqUg5mNxKW
	HuINBdXt5AHbunNe2o+lbqAa2b0I=
X-Google-Smtp-Source: AGHT+IGaAdxT+p5eZyD405tcBTNrXvLLs2Hyo8g4KHuwGDbP+xjemkv9sIqAAL5yG/9jj/y9123Q1qOg0kvRLglpPQM=
X-Received: by 2002:a92:c841:0:b0:363:d9eb:c2de with SMTP id
 b1-20020a92c841000000b00363d9ebc2demr3924981ilq.6.1707938072122; Wed, 14 Feb
 2024 11:14:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214082224.10168-1-dmantipov@yandex.ru>
In-Reply-To: <20240214082224.10168-1-dmantipov@yandex.ru>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 14 Feb 2024 14:14:21 -0500
Message-ID: <CADvbK_fhGKBXyjSqo8shKVKi11SPoVQ2z1+Vde0ranhpsoy0zQ@mail.gmail.com>
Subject: Re: [PATCH] [v3] net: sctp: fix skb leak in sctp_inq_free()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jakub Kicinski <kuba@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	lvc-project@linuxtesting.org, 
	syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 3:23=E2=80=AFAM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> In case of GSO, 'chunk->skb' pointer may point to an entry from
> fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
> random fraglist entry (and so undefined behavior and/or memory
> leak), introduce 'sctp_inq_chunk_free()' helper to ensure that
> 'chunk->skb' is set to 'chunk->head_skb' (i.e. fraglist head)
> before calling 'sctp_chunk_free()', and use the aforementioned
> helper in 'sctp_inq_pop()' as well.
>
> Reported-by: syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=3D0d8351bbe54fd04a492c2daab0=
164138db008042
> Fixes: 90017accff61 ("sctp: Add GSO support")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Xin Long <lucien.xin@gmail.com>
> ---
> v3: https://lore.kernel.org/netdev/CADvbK_cjg7kd7uFWxPBpwMAxwsuCki791zQ7D=
01y+vk0R5wTSQ@mail.gmail.com
>     - rename helper to 'sctp_inq_chunk_free()' (Xin Long)
> v2: https://lore.kernel.org/netdev/20240209134703.63a9167b@kernel.org
>     - factor the fix out to helper function (Jakub Kicinski)
> ---
>  net/sctp/inqueue.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> index 7182c5a450fb..5c1652181805 100644
> --- a/net/sctp/inqueue.c
> +++ b/net/sctp/inqueue.c
> @@ -38,6 +38,14 @@ void sctp_inq_init(struct sctp_inq *queue)
>         INIT_WORK(&queue->immediate, NULL);
>  }
>
> +/* Properly release the chunk which is being worked on. */
> +static inline void sctp_inq_chunk_free(struct sctp_chunk *chunk)
> +{
> +       if (chunk->head_skb)
> +               chunk->skb =3D chunk->head_skb;
> +       sctp_chunk_free(chunk);
> +}
> +
>  /* Release the memory associated with an SCTP inqueue.  */
>  void sctp_inq_free(struct sctp_inq *queue)
>  {
> @@ -53,7 +61,7 @@ void sctp_inq_free(struct sctp_inq *queue)
>          * free it as well.
>          */
>         if (queue->in_progress) {
> -               sctp_chunk_free(queue->in_progress);
> +               sctp_inq_chunk_free(queue->in_progress);
>                 queue->in_progress =3D NULL;
>         }
>  }
> @@ -130,9 +138,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queu=
e)
>                                 goto new_skb;
>                         }
>
> -                       if (chunk->head_skb)
> -                               chunk->skb =3D chunk->head_skb;
> -                       sctp_chunk_free(chunk);
> +                       sctp_inq_chunk_free(chunk);
>                         chunk =3D queue->in_progress =3D NULL;
>                 } else {
>                         /* Nothing to do. Next chunk in the packet, pleas=
e. */
> --
> 2.43.0
>

