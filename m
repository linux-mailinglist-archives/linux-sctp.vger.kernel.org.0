Return-Path: <linux-sctp+bounces-330-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F92FA2F86D
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 20:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D3C9168381
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 19:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE69288DB;
	Mon, 10 Feb 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJHuEC9e"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10BB25E468;
	Mon, 10 Feb 2025 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215137; cv=none; b=MZMpaKV5oH8SIgRB1kgdoAf1AIPH63TqXU0ncEi4T5f2mEyR4m8qDnew2tn+xT09HRYdxqkYY7g36XEqwgkudsN+tpPtXJ0OANs4Xd3oljFpGYWF4H2whdytNn9s7k686i6wDNNFUM9V+HwXkiRSrinug3wfJYYaVpRXtNQiHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215137; c=relaxed/simple;
	bh=bDstmLDKhx1lq3EGCKVzOywm8OB9mSXeBNsz3yRaorw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2tesK3HQ+EneNp3M5P2P12dB3buNhAsWbKudDHVzbClZ2hVP8FnpgH9G7xnhbzzqWGTbn8srnJ0xTdQNjBCQZqvyjqilYRqpYUiVhnl0mhYsgC0IpBXERBL+04kkd/pjNkTa0A5wc1m1dIBAyw1N7fl89P4bYJemcUlzRvhlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJHuEC9e; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8553108e7a1so80851939f.2;
        Mon, 10 Feb 2025 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739215134; x=1739819934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIoM7PkEdi55pwR80xPH/BH3+8eyi61fIwlGcG1P7h8=;
        b=TJHuEC9eHI891UCpwRavZxV0S+VxZ9EM+U1E7tRQtp47tkaBUfggpt/sJ1rjMd0RCS
         cYL5rtfRHug4C5ue/M5NOLgRGx0kjUNDDt67B8hnbuUkP1wCHnldxAHsPfAhFt8YAnnO
         +VHC6GWFUR0QYMXdVAgouO8InUnbdm5DAEJKD4jx4IW0NyZV46VPfS8BGp6YnSVyKfhe
         UZIJy7T+NqfUnRTkqS0CRwV0+jquH61Q6XBWMBjInTQbdelk7iCAgf8yRa1hD37ZcNeO
         LRTH+EvZKnwE+ohRmhtYGeKUNcYo4I41fR4W/uP2pBBqhujtCACgDcgvo7qChfwB+3H3
         62Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739215134; x=1739819934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIoM7PkEdi55pwR80xPH/BH3+8eyi61fIwlGcG1P7h8=;
        b=FQNFzYvvW1WBcW8T1Ij0qbjZGhWqqVUF0QIhQQ3LRlbXyg8w9PwLVPaT2Yv8I1GUl6
         YrPpefGYt4OulDU487Nh0Ho7TDjaJmk6W/VPuFIsakEVtnXXgtIt9LsphAugL+JsIYS0
         se1XC4CWlIuC4FuHbvgohKCNXcQx8hHZg2vM7+mdlugKUcTIzet8jOlcjYuWXCieDXnp
         c1CICDiiZH/w3DqHr2ZKvHcijgdT0igkBD7XNK0LMwNixbQMDRVH5vhSFYGNvQyq5G/6
         T1GyZd1p6U/uYQQPIQ1CnCctzVsh8KctWe9JOXfM9jDzoeKmdDgAYddqiOW9sEcNG/2o
         hzEw==
X-Forwarded-Encrypted: i=1; AJvYcCUpcLi3RR1+19251XjJrmIadEKfbL/Jl6mQJm7dlrhxfbNKAzzyKhoXODC4HGAQ9JlA38nvv2N1q1q9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xD7zsfb8f0t8dYIwqysvGzru54vmoBFJPKd6E8YZoQS3sxW+
	q5EqnZOCvXdGPsnojnvYasi/iaqtODQ5cjOqwkZIm7ci54zCgmANhiH+ZfOvHh/TE92M4cMSD5u
	mECw7GCSomy68HQrYxztgHyeIfVUZcQ/y
X-Gm-Gg: ASbGncuu5QGy4hSmUbUSzzkIiGDKIw6zhSvPzDRUCWOIG6VeyZ3/rCvzk4i44g7bZtn
	9KJoPbuo9F1ZJEcp9ciq2Z16Vl4iDyMWYHzJRNHKTC56+9fFX6g5EsN5mSGt0RUra2jfVYJk1
X-Google-Smtp-Source: AGHT+IF6AaYG3SfWJMl6xBqTGy/M5tj4Ezo8ajNsv5Z5hCSXQBRg5W29K+deTSAtKKI4BY8dMhtesf5f/kzFFE9pL5Y=
X-Received: by 2002:a05:6e02:1c0e:b0:3d0:28d3:e4ba with SMTP id
 e9e14a558f8ab-3d13dfa700amr145946335ab.18.1739215134545; Mon, 10 Feb 2025
 11:18:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
 <CADvbK_dtrrU1w6DNyy_OxizNwx_Nv=mjs5xESR+mB8U6=LKXdA@mail.gmail.com> <Z6o49-Iv5kCdPwL8@t14s.localdomain>
In-Reply-To: <Z6o49-Iv5kCdPwL8@t14s.localdomain>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 10 Feb 2025 14:18:43 -0500
X-Gm-Features: AWEUYZnbpOpFwelRZ0oEsl1ssbeF4VvTl2W6Our8dLKwVD_aq1rz3KIUv_TNvIY
Message-ID: <CADvbK_dFoJ056xR2BW5eZeg_b7ZfHhM9_6iuGM8MbsUJSipm+A@mail.gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: Add sctp headers to the general netdev entry
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	thorsten.blum@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 12:35=E2=80=AFPM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Mon, Feb 10, 2025 at 11:44:10AM -0500, Xin Long wrote:
> > On Mon, Feb 10, 2025 at 8:25=E2=80=AFAM Marcelo Ricardo Leitner
> > <marcelo.leitner@gmail.com> wrote:
> > >
> > > All SCTP patches are picked up by netdev maintainers. Two headers wer=
e
> > > missing to be listed there.
> > >
> > > Reported-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > > ---
> > >  MAINTAINERS | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 873aa2cce4d7fd5fd31613edbf3d99faaf7810bd..34ff998079d4c48433369=
36e47bd74c0e919012b 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -16509,6 +16509,7 @@ F:      include/linux/netdev*
> > >  F:     include/linux/netlink.h
> > >  F:     include/linux/netpoll.h
> > >  F:     include/linux/rtnetlink.h
> > > +F:     include/linux/sctp.h
> > >  F:     include/linux/seq_file_net.h
> > >  F:     include/linux/skbuff*
> > >  F:     include/net/
> > > @@ -16525,6 +16526,7 @@ F:      include/uapi/linux/netdev*
> > >  F:     include/uapi/linux/netlink.h
> > >  F:     include/uapi/linux/netlink_diag.h
> > >  F:     include/uapi/linux/rtnetlink.h
> > > +F:     include/uapi/linux/sctp.h
> > >  F:     lib/net_utils.c
> > >  F:     lib/random32.c
> > >  F:     net/
> >
> > Checking some other subcomponents like: MPTCP, TIPC, OPENVSWITCH,
> > HANDSHAKE UPCALL ...
> >
> > It seems that we should append:
> >
> >   L:      netdev@vger.kernel.org
> >
> > after:
> >
> >   L:      linux-sctp@vger.kernel.org
> >
> > in the section:
> >
> >   SCTP PROTOCOL
>
> You mean, "also" append, right? And not "instead". Because currently
> the NET one includes all other files and it doesn't exclude stuff like
> net/{mptcp,sctp}.
I'm thinking it should be "instead".

Yes, all files under include/net/ are included in the NET, but those files
(belong to subcomponents/modules) under include/linux/, include/linux/uapi/
or even include/trace/ are included in their own sections and not in the
NET, such as:

include/uapi/linux/mptcp*.h
include/trace/events/mptcp.h
include/uapi/linux/tipc*.h
include/uapi/linux/openvswitch.h
include/trace/events/handshake.h

Thanks.

