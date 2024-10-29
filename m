Return-Path: <linux-sctp+bounces-273-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D99B4ECB
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 17:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C279289AE3
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 16:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35F8196455;
	Tue, 29 Oct 2024 16:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM3xyMVF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEFC19309C;
	Tue, 29 Oct 2024 16:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730217774; cv=none; b=ERLp308Ll11WNRX4t15JHtCp/A1Z9eSo2Ep5Vqex/t3a8K69CvKqF7T2OBineu9CjzsyR3fhCqXu6LSjYgQ8EDZqczcBFdMs1V9J5U4yMcmRL3ouSuSd85V8RD6EOnZTyOLoJfKQ0Rlo6vFMmm6/ndlMkQV+GuejK9YBYpUC96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730217774; c=relaxed/simple;
	bh=FtJx6Wo3p29eSAg1dW0tcFKWvNDY8B/086fCEFwO9Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ADZJUK5WJlaFkCZtXmM9F5eAZxACX2rz5IfcAV5nPozAeufx2715JbKcjY/x5u8tdh3IEZFYI4wJJ7baA9ZkjPytK6H4Nq/a/28JQ1QByedUKJgnHvEnCwsPU2TDUjZf7szqs0LKRnQik9UXi8kqcCx9Yuxddo02y2cFT8z6iAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM3xyMVF; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso23192025ab.3;
        Tue, 29 Oct 2024 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730217772; x=1730822572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cK2Y4uadfwipRkCs55AvdNK28aDW94wpHDMth7dhIo=;
        b=GM3xyMVF7bNQsCDQAbo/FpFwHSi8O+phwdgEumhVCEnIfwc0YvJ5YEMFCDmseoflic
         bdG5CSlqfuwuA9GAndJfOyLYSNJSYFe0peTqhMMiYxwFWhnRLHAm/Clia+zvgR1irlLD
         3Ee6Z5UGrUx4TF4hM8YN2Vqv6CqyXmKipMloBtHaT34bT6Q8533bX9x2FiolQMPPlI/S
         Rs/1B+wklC1JQ4X3m28PTZ6F2zYwa6Ko5DbcdM0cj1/drvmNVM5WLJ0Tubhfqq97PxEU
         zL96WlbAZp/R+DjluAL1mWiCZdAgqMUwhGrJ/42QYUno8z7LNPcn/Km3lXjbPvzY078U
         qVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730217772; x=1730822572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cK2Y4uadfwipRkCs55AvdNK28aDW94wpHDMth7dhIo=;
        b=Xvl5OCODHmWgodTTa/0HH79O3aREhpb+Mg4wnOdVWGH5ocdKmdOO7/M30n8a5Im0VH
         yVBr7OhKnWSRwQ+i68OT1eqMS95GEXXLt/UFmzAD4LqhKVVEsideoXMo/0YpKSRrKwwB
         2RrOLdhKiqwpWFOosY2/B5hdCAsgyEgixJB2mjOpMJLtlUsdWlpzDL9PjhYIQWHwL9Ir
         ke1Js5P8OeKmY3Yr0iiJf8TtewSVrT32aaHwNsA0/zCmNpB80TIc75wbJzDGLjnx/3p9
         ZepO3gzx/xZQezrghQuie7aqbgkB7U32KU22epSyQsBTtgAEPPRini62sItupuXJLDTo
         hNEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOX7VxO7tewvYhY3JGhKxUDCfdGjHvOFKy0Oj6sYSaz+yfShJ4PEa/+NZ1lL9zkBbPMhjxaMQPieq6@vger.kernel.org, AJvYcCWK89mHWY5KVnWyh9UhySWCB0+JzY/wn7y4kJHQI5ku+3Pr/RIsghzQdXxceWdSAaUR8sKMcg8d@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrXeZc3z3i5BVLkNfCqBvl34amZRjFiAH+4wt3Y4uDSFz6YBg
	5b/tMKQ9mrN0/v3sbLZrGwsE4dW0UJg82scEzYZWgk8nOUgtA9q1NgzDHT2IUV80RXYYlB+emW7
	9CN/TWCvgBPJWyUrqwt7NEZK4cRQ=
X-Google-Smtp-Source: AGHT+IE8+IDSVzYWZx3SeO1fGCa699XovvCjq1E5XqcC9jNNsMruqeiLZQcEtqql7nFkN5+UBKFz1L14iAzoDADYsB4=
X-Received: by 2002:a92:ca08:0:b0:3a4:e823:1ce3 with SMTP id
 e9e14a558f8ab-3a4ed2668c1mr99791115ab.3.1730217772063; Tue, 29 Oct 2024
 09:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028081012.3565885-1-gnaaman@drivenets.com>
In-Reply-To: <20241028081012.3565885-1-gnaaman@drivenets.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 29 Oct 2024 12:02:41 -0400
Message-ID: <CADvbK_eUK9QLzJ2HYtqQ1woAF=pcgTbvckeqCk1Es50HkxdZTg@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: Avoid enqueuing addr events redundantly
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 4:10=E2=80=AFAM Gilad Naaman <gnaaman@drivenets.com=
> wrote:
>
> Avoid modifying or enqueuing new events if it's possible to tell that no
> one will consume them.
>
> Since enqueueing requires searching the current queue for opposite
> events for the same address, adding addresses en-masse turns this
> inetaddr_event into a bottle-neck, as it will get slower and slower
> with each address added.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
>  net/sctp/protocol.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 39ca5403d4d7..2e548961b740 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -738,6 +738,20 @@ void sctp_addr_wq_mgmt(struct net *net, struct sctp_=
sockaddr_entry *addr, int cm
>          */
>
>         spin_lock_bh(&net->sctp.addr_wq_lock);
> +
> +       /* Avoid searching the queue or modifying it if there are no cons=
umers,
> +        * as it can lead to performance degradation if addresses are mod=
ified
> +        * en-masse.
> +        *
> +        * If the queue already contains some events, update it anyway to=
 avoid
> +        * ugly races between new sessions and new address events.
> +        */
> +       if (list_empty(&net->sctp.auto_asconf_splist) &&
> +           list_empty(&net->sctp.addr_waitq)) {
> +               spin_unlock_bh(&net->sctp.addr_wq_lock);
> +               return;

What if after this but before the addr is deleted from local_addr_list in
sctp_inetaddr_event(), a new SCTP association is created with these addrs
in local_addr_list, will it miss this asconf addr_del?

Thanks.

> +       }
> +
>         /* Offsets existing events in addr_wq */
>         addrw =3D sctp_addr_wq_lookup(net, addr);
>         if (addrw) {
> --
> 2.46.0
>

