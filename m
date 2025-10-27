Return-Path: <linux-sctp+bounces-710-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8EC0CA2D
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE424401AA7
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 09:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A47A2F25FA;
	Mon, 27 Oct 2025 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L6Wo+c1U"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954B2E92DA
	for <linux-sctp@vger.kernel.org>; Mon, 27 Oct 2025 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556693; cv=none; b=MYoc7qvVvEr0HE+E95kHAEY9OCYK7DjPzj24h70ttIuYV2IzTMSzFcQcserHWmg8PihnBC2d/1cerVmDdqia6vziCkZpU/2p/dpDnTGdEUEEgP0GbdCNYbLZZEAfv/N1QO5NLkEb9jvu1nc+7jb+TXMgF4w5UZS0/wcVLd01iJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556693; c=relaxed/simple;
	bh=fPskHNpEnASinQ2bx7vkp4RFIOTfzZ4Tr1rU4FC5YBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEwjJEQkGpKa1SuP36OaoXB1x0Q5VtjNyFTIGdi1yWfCrx/JFQ+pOC0RiFfbn/CeIr6DvfIMI+khXOJpRCvGkFLegD/nOc9w5HPPHe5LX/FqY54Jzcmf+QhAjA/LjMsQK/xBjB8X/pnjVvK4iIiN0yVMrYjaVOxf4Xk99z8b5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L6Wo+c1U; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ecf03363c9so9668231cf.1
        for <linux-sctp@vger.kernel.org>; Mon, 27 Oct 2025 02:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761556689; x=1762161489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjuXaDF4nyYws2bQ+7X3zoKeqLCyOBsQRJF/6yWZXpk=;
        b=L6Wo+c1UGYfbusRJKURqQ7YfENnRCvFkLp/MFu+ehh8E2a8uym9+d8rGA+jEpgdBBf
         7RKXqCEBMoUvp0Zegr7yZK0aHf2wTqcc8Fh1kciWnN46aH4nnN7RmTJQ9/d3MKtRV6dn
         lq1ZPCh3qJ674HAmXT9plsZ+GnPo7C1G9EZq/gteJOs7Fex+6/b1wACviXmT0YDR9qoV
         PsrDJswL4U/4UgQypHbBxPZ1sgQh48V1PYFpW2/lwmNQpDwY4xuiUR9yLSMPJkD3NQv0
         tryZwm8gOqbSxhb2z3EuI0axV3gdeDT1VJSIPOWlVvbuH8AKL6LG2PlVPoeFOM20yphn
         nP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556689; x=1762161489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjuXaDF4nyYws2bQ+7X3zoKeqLCyOBsQRJF/6yWZXpk=;
        b=Izj7BKvccIflyQat5EKa8+SA1FL5Z4TJ5DESi8unkYffIHuXnGHqXfOu56giMtvIyL
         GUvHy9hfoA0biG7EHGgvR6mqlWHiSV1Xa7ciLMZBjuuSapZJZgg/iQBCOAxdR0d9DSRr
         ECaA+nAKHQsWcukg1Yy1B75pnQQ2k596/gYJZ/r7+T72TMU87QnrmvcIvktivmOahfrO
         ZPEz7gF+O1KsLUOCrVYCT1rsWsOKuWpopYfWMVph5+LuAmRvWrqXjU2qfXhANTj3Ang+
         1ibGxNLpZ4qCW7I8I+dPR1oeYKmEAxTtlTNYOEbHurUU9vwzmhWcZ2ratkn7mbyDK8hV
         N2Cg==
X-Forwarded-Encrypted: i=1; AJvYcCV5nqZlBlVKoIUu/2sztiO8YizxSSaBQCaWPL86k9grT9wfP2O4VqlRZcSOjsQ2ZZSNZgKEU3pzEcWo@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc7bjXiPO+6RYmJYqyNXlSwF9Sl8ZYay8BclbyxOynPcxYutle
	M1LMb++E7uBKVBzEUMhDFtQq/LOEbD5O6Z80JkWew3RlMCIb0VsCg0/3zlrZspAOqnBHs7EY0hR
	uxw4y5wxe1TAXKbIOLbq4DvDTd2PDT8mRFmG7JKkR
X-Gm-Gg: ASbGnctjr08A/OQCS9o8rWHCEeHJcBheskblJHYTPNsTvSWkYFlk/nQiUPBYsRoh4rQ
	rKrtDD7rLIjnW6IOfHM8GHLcGV1xOz+l6xIE4SIogzn3OSN1hC7vXRSe8Ao2mxdOY53tzV6PjH2
	9ZZk/LDKYXVFnMatIyMiYg2i8z/00/Ix0Ff4C7rMgB1w5F88kyp8fCql2Q12EeNdklmh5jOG/q9
	HM1VFEfHZ0kaygtY4F39ZAezisuanS2XWNoVxCrmMn0X9HVjm7HDXX2ek+MASb4hlJn18Q=
X-Google-Smtp-Source: AGHT+IGn9kiXC6v55wZ2Z6kE1uL4cTaogteQRe65Qan4CvgMr20ojg1DZQnSbG0o49HMvVhY7LnDKeEAhavDJCrNcCY=
X-Received: by 2002:ac8:5a43:0:b0:4ec:f1e5:1b21 with SMTP id
 d75a77b69052e-4ecf1e51cc1mr36707271cf.59.1761556688706; Mon, 27 Oct 2025
 02:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027085007.2259265-1-stefan.wiehler@nokia.com>
In-Reply-To: <20251027085007.2259265-1-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Oct 2025 02:17:57 -0700
X-Gm-Features: AWmQ_bnwJIlS1v6l9rdALIdpQrpckWaD6-kZUS-gDcLcLrRu9vSgbv1vyX_nN2c
Message-ID: <CANn89iKbLadNizRB28AoNw8McQXgqtknbH3zdhErDku-m5rjqQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: Hold sock lock while iterating over address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We need a changelog.

On Mon, Oct 27, 2025 at 1:50=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
>  net/sctp/diag.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..7f7e2773e047 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -223,14 +223,15 @@ struct sctp_comm_param {
>         bool net_admin;
>  };
>
> -static size_t inet_assoc_attr_size(struct sctp_association *asoc)
> +static size_t inet_assoc_attr_size(struct sock *sk,
> +                                  struct sctp_association *asoc)
>  {
>         int addrlen =3D sizeof(struct sockaddr_storage);
>         int addrcnt =3D 0;
>         struct sctp_sockaddr_entry *laddr;
>
>         list_for_each_entry_rcu(laddr, &asoc->base.bind_addr.address_list=
,
> -                               list)
> +                               list, lockdep_sock_is_held(sk))
>                 addrcnt++;
>
>         return    nla_total_size(sizeof(struct sctp_info))
> @@ -256,11 +257,12 @@ static int sctp_sock_dump_one(struct sctp_endpoint =
*ep, struct sctp_transport *t
>         if (err)
>                 return err;
>
> -       rep =3D nlmsg_new(inet_assoc_attr_size(assoc), GFP_KERNEL);
> +       lock_sock(sk);
> +
> +       rep =3D nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
>         if (!rep)
>                 return -ENOMEM;

If -ENOMEM is returned, the lock needs to be released ?

Please do not rush patches like this.

