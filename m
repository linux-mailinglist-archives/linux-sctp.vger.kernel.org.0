Return-Path: <linux-sctp+bounces-561-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18454AC43B1
	for <lists+linux-sctp@lfdr.de>; Mon, 26 May 2025 20:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3EE1898DDE
	for <lists+linux-sctp@lfdr.de>; Mon, 26 May 2025 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485E1F8722;
	Mon, 26 May 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDRURSTj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D221C5F06;
	Mon, 26 May 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748283958; cv=none; b=EvrJUaZG02MuYAt66ifoLvHQgdm3Gkeiug1ZvRIvEP/Jq1NRY3Q3/4DI4HkD2eKrZn9EuYxYnI68vSgoHPIbXMkwe53xlIYnoZCI08kQqBA3xoINPZV/58YFQoDOUrbcRHrHDqJTAgZr3sCJ/wjqDcEtkw1UK0QAZOWozb380tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748283958; c=relaxed/simple;
	bh=qVtk5mChgiojijgvw+Xacb75bcFr8uUkTPU8GL47QzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cciBpcIzktUZOsaWv6F0DDQigstAGqiJik82neMQMs5yam6mpvWzenneO54/TVaVTAQQmGm7fLCejuivN1Vj+6LCzzzmT1Gloqucl1I8I+WcZEpO00YiHx41Hsx50IgjWoyPnEEUKuzP+7Qrfo6ji9WrcNxJmjXq0hl/0cYrrpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDRURSTj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86135af1045so225475139f.1;
        Mon, 26 May 2025 11:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748283956; x=1748888756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbsso0SUfjZhlcJRFYfaPdijYfCfVggEkuSWqQh3kNw=;
        b=iDRURSTjiyZA3Au6m5P+stpE9psLelmahPs+8H87wP/Y8/tI+4eXqESgRtwRRbdwC/
         EOGW/uDpN4ABTXH5SHgwYXrbEL0Oqb757JVKcJMciMrbJaIRTKVMKvuk2zV6y61IpMCf
         be/z8EmLwFVknETDuLdwIOK2T/Nanh+H+UP68x3DnA5XRVPYwOD08SO2r3O25K+hrJKp
         tlQYu428tY3vvI/MqTBj4dDC8eUIwIwPxd78xp3gVsgPmFJ6971PaOeLBUPxyw6/YgSb
         2CU/810Z3AvePbM+YFMBdl+1a7L4XRQXMKcZWaHPFNTny0yUVhoCrjm0P6OdvCkPhrET
         LrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748283956; x=1748888756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbsso0SUfjZhlcJRFYfaPdijYfCfVggEkuSWqQh3kNw=;
        b=ulmJamcj5Bu9pBH2G5WYt2q8RAhbwg+0X5bZ7FExNLSAIqQ+GSbcka9UzdDkvmYTLB
         swU9hPXDyEB3xzY3KoHPJzANhx9v7QrDGxbX0bJVqIGzNifKmPE4HOaYRGypVBQik78V
         6cOkB/sC4jsgqtqcepzPc3owvaqhZyLL2ooCwmgz6F2/a6emQe+e//8KROnhPSxM4Imn
         PXJryOPYviuXbGJXB4CqUPdujHd2df99vjEr62efqAzbMw1PZ0jGOU+QMG4/+Lj2KUn0
         lY5ujTa42WPnMEbexicTEVpt7kM+fpE74ZHJ4Uf1WEpVrKt65pwmuLqWYGJ26zR9TLdQ
         HDTw==
X-Forwarded-Encrypted: i=1; AJvYcCX1gxKQ2+qnWX7ft3dV4IVIYB4pZyW4hRhQPsP0ruW0OKKz1w34Id21Yz1Mjjj9BMjScam3z5/MUVMt@vger.kernel.org, AJvYcCXIxXET3uV92zIkJRz8nGAbW9MmHUFJFnBrkI9y3sgy9vFWCMav0rKSdB/zqEiv0JnJ7hswuBNe@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjEFl3qZMu+jGzhsIuWFIYUJZ9F1BNnBZxo+1ojtXj4tn5LPb
	UNymAzY2UhRoWGPvajYMLriTa55oDh1vzPNRjC7eigsT6unxunfBiIaMuss2TLpNRVCgBpnijsG
	pPQnzxhCIYerAGNEVEodg1F3VlFQYdGAUEXjo
X-Gm-Gg: ASbGncv6g5OowabybQ8JC9K48WTNGkS8au8csK9DQ1sKQ+gHsFTYBD9qtqkvIibwdFJ
	hn+veeM4T7CtulSaMZ/68ANA6YPNxQMGOAnQ1WhxBdasB3hzOmfrmi21z6q+Wp6e/DDllhF3Y3s
	QocUSaU7xRBaosVk42bpl3Mh4/7afWZPyfF5I=
X-Google-Smtp-Source: AGHT+IFieohgpCQZAZgsmFtt/mvdYmvDMniQ31fjQpsebOqSzthcWwv8hqRk3MuHLNVOuc0+pUAiZVvBwTgfAt6sKuw=
X-Received: by 2002:a05:6e02:743:b0:3dc:8a5f:7cd1 with SMTP id
 e9e14a558f8ab-3dc9b6a9fbemr103026125ab.3.1748283955921; Mon, 26 May 2025
 11:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526054745.2329201-1-hch@lst.de>
In-Reply-To: <20250526054745.2329201-1-hch@lst.de>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 26 May 2025 14:25:45 -0400
X-Gm-Features: AX0GCFvbGISRIw2IR9cm-ACqlhaFohJczvUp8YSbofsszI6L5XteWpTcRS96XT8
Message-ID: <CADvbK_d-dhZB-j9=PtCtsnvdmx980n7m8hEDrPnv+h6g7ijF-w@mail.gmail.com>
Subject: Re: [PATCH] sctp: mark sctp_do_peeloff static
To: Christoph Hellwig <hch@lst.de>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 1:47=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> sctp_do_peeloff is only used inside of net/sctp/socket.c,
> so mark it static.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/net/sctp/sctp.h | 2 --
>  net/sctp/socket.c       | 4 ++--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index d8da764cf6de..e96d1bd087f6 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -364,8 +364,6 @@ sctp_assoc_to_state(const struct sctp_association *as=
oc)
>  /* Look up the association by its id.  */
>  struct sctp_association *sctp_id2assoc(struct sock *sk, sctp_assoc_t id)=
;
>
> -int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **so=
ckp);
> -
>  /* A macro to walk a list of skbs.  */
>  #define sctp_skb_for_each(pos, head, tmp) \
>         skb_queue_walk_safe(head, pos, tmp)
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 53725ee7ba06..da048e386476 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -5627,7 +5627,8 @@ static int sctp_getsockopt_autoclose(struct sock *s=
k, int len, char __user *optv
>  }
>
>  /* Helper routine to branch off an association to a new socket.  */
> -int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **so=
ckp)
> +static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
> +               struct socket **sockp)
>  {
>         struct sctp_association *asoc =3D sctp_id2assoc(sk, id);
>         struct sctp_sock *sp =3D sctp_sk(sk);
> @@ -5675,7 +5676,6 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc_t i=
d, struct socket **sockp)
>
>         return err;
>  }
> -EXPORT_SYMBOL(sctp_do_peeloff);
>
I believe sctp_do_peeloff() was exported specifically to allow usage
outside of the core SCTP code. See:

commit 0343c5543b1d3ffa08e6716d82afb62648b80eba
Author: Benjamin Poirier <benjamin.poirier@gmail.com>
Date:   Thu Mar 8 05:55:58 2012 +0000

    sctp: Export sctp_do_peeloff

While there=E2=80=99s no known in-tree usage beyond SCTP itself, we can=E2=
=80=99t be
sure whether this function has been used by out-of-tree kernel modules.

