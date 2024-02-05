Return-Path: <linux-sctp+bounces-11-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9CA84AA84
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Feb 2024 00:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D1431C259BB
	for <lists+linux-sctp@lfdr.de>; Mon,  5 Feb 2024 23:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66D84879C;
	Mon,  5 Feb 2024 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jmTHwb8z"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49948793;
	Mon,  5 Feb 2024 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707175778; cv=none; b=H8EARhrOFO7pgZhXOU+14WeYHty+rnarMz9r0Nv8DdAOMXF8KyPBSOiKODrSKpt9gnOazJbBb3kH2mDJEKALSZIEm+MEHC9oFCaGhf2+Fqvs8VTnTUnpnKVSE8OiNDrIo04d+cRd4aSy3U4JQczBE+RdyPhNwlTz9KTWcdDBGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707175778; c=relaxed/simple;
	bh=MO701j1VdsFOkjix8vAIy0189lSwdgX2Svz78UZNjxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBDNgHLvvwgTUmr8J+KB8+SOwjafgz88QDUQY+0Av1ukpk8n6e5f7ydJRSbSfi9Sse4MbysA+BqBH+Ifl5C690SZuHLOobU9e1F7w2CSBdq46H22eAuBtb2dHvsp2jDqtskIIhdhU+7zmM1l8Vq6NpDqs5KKZfcS6aeYvQLgq8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jmTHwb8z; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-363ac28b375so12327115ab.3;
        Mon, 05 Feb 2024 15:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707175776; x=1707780576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5h4C9UteCg9eOgceej/mmHcmrSvR8/JhU2mjiTOOjkw=;
        b=jmTHwb8zTqMhF7KkkOqWuzpkLFz9uSfBeryIbAJmOpl7vlHppjPjwsyk9i2iIy4tdh
         gyio7hsIlrpFr8rLwqtmDAQ8LmUHgaLYSIz0XfSEQxNGg2G0q7K9u3vdZY+e8voNUD24
         GEnylYmqr71CUAnzaEQh+oclt236g4i9l8nBZNS4e+GB2HuaLs7nRRV9fwQYWDpeSZpv
         Q3RiC3oToVV7OSx1XS+1OASXC34o1W1dot0cylO3bE7IoPxzcb0xWocO6VE4TH2hyWPW
         tq8EWeof1WoIIVNOAlv2W781hUrjD3Wg5JsRAxQwNLiyt8HeSibjjfS7HhaYYTqDuI71
         SZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707175776; x=1707780576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5h4C9UteCg9eOgceej/mmHcmrSvR8/JhU2mjiTOOjkw=;
        b=akdvnGX5fiivLzxTNCA59tCnKUHBR+GKfPCuQG6Yu9/kywBrEsKzNaEGotKjebvUya
         fa7KVJTILo6lCZe6SEuWAlK28Jw8FXdmSAk6faIBjHmfUylCTHyTI1JE4nIbBLlPYlTd
         H94FxG+kUXnGqa2t/bsTYHKlvTgjoP0+DnWGbaWo3hChNy7xEMmvi+yhZbqazKkS1Goi
         w0PXKLmQG9cJC8Reqivpm0bANKcCqWO7iHSyTMF4cxrh0KnlsE0nldUJcdVOdTlrmVo+
         K2bAUS1vyrBLc1I+AYwMGL7qXGgUD7ygb08ACC/I/YKuOl9AVaeAy6kx0qpl4gM0Wk+u
         +FNQ==
X-Gm-Message-State: AOJu0YxT60jHfHZKsBicUtvunxLMcm+7be1kLiGTrWl3qk9GWDD2aVph
	GxFpvE46hIpRywTjlLEuoLlo8aZz9bt+mGMaXEmXtIHijxEyIlPlpt0KFGWyXmitEJtOAtAyCzX
	WlZOZeZy+NXuXG7jWWq7Qy+gMgsk=
X-Google-Smtp-Source: AGHT+IGvR49UjNlOF4JJ6CzLSEGaTke8MRvIkg9sW3ZU9vCABHjacR/m/lVcbn8ZDbA2sjpHewO8IMkcanNIcrKbcvo=
X-Received: by 2002:a05:6e02:1d15:b0:363:b695:5d5a with SMTP id
 i21-20020a056e021d1500b00363b6955d5amr1578168ila.18.1707175775632; Mon, 05
 Feb 2024 15:29:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205170117.250866-1-dmantipov@yandex.ru>
In-Reply-To: <20240205170117.250866-1-dmantipov@yandex.ru>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 5 Feb 2024 18:29:24 -0500
Message-ID: <CADvbK_fn+gH=p-OhVXzZtGd+nK6QUKu+F4QLBpcx0c3Pig1oLg@mail.gmail.com>
Subject: Re: [PATCH] net: sctp: fix memory leak in sctp_chunk_destroy()
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 12:02=E2=80=AFPM Dmitry Antipov <dmantipov@yandex.ru=
> wrote:
>
> In case of GSO, per-chunk 'skb' pointer may point to an entry from
> fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
> random fraglist entry (and so undefined behavior and/or memory
> leak), consume 'head_skb' (i.e. beginning of a fraglist) instead.
Right, chunk->skb is supposed to be set to chunk->head_skb
before calling sctp_chunk_free () in sctp_inq_pop():

                        if (chunk->head_skb)
                                chunk->skb =3D chunk->head_skb;
                        sctp_chunk_free(chunk);
                        chunk =3D queue->in_progress =3D NULL;

However, somehow the loop in sctp_assoc_bh_rcv() breaks without
dequeuing all skbs, and I guess it's because of "asoc->base.dead".

In this case, sctp_inq_free() should take care of its release,
so can you try to fix it there? like:

diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 7182c5a450fb..dda5e1ad9cac 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -52,8 +52,11 @@ void sctp_inq_free(struct sctp_inq *queue)
        /* If there is a packet which is currently being worked on,
         * free it as well.
         */
-       if (queue->in_progress) {
-               sctp_chunk_free(queue->in_progress);
+       chunk =3D queue->in_progress;
+       if (chunk) {
+               if (chunk->head_skb)
+                       chunk->skb =3D chunk->head_skb;
+               sctp_chunk_free(chunk);
                queue->in_progress =3D NULL;
        }
 }

this would avoid doing chunk->head_skb check for all chunks destroying.

Thanks.
>
> Reported-by: syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?id=3D0d8351bbe54fd04a492c2daab0=
164138db008042
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/sctp/sm_make_chunk.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index f80208edd6a5..30fe34743009 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -1500,7 +1500,10 @@ static void sctp_chunk_destroy(struct sctp_chunk *=
chunk)
>         BUG_ON(!list_empty(&chunk->list));
>         list_del_init(&chunk->transmitted_list);
>
> -       consume_skb(chunk->skb);
> +       /* In case of GSO, 'skb' may be a pointer to fraglist entry.
> +        * Consume the read head if so.
> +        */
> +       consume_skb(chunk->head_skb ? chunk->head_skb : chunk->skb);
>         consume_skb(chunk->auth_chunk);
>
>         SCTP_DBG_OBJCNT_DEC(chunk);
> --
> 2.43.0
>

