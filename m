Return-Path: <linux-sctp+bounces-700-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9640C06FA3
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 17:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73A04050E7
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5521F31E101;
	Fri, 24 Oct 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0KIq5/H"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BA2DEA7B
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 15:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319585; cv=none; b=ozMKEBAoXRVnvOOdV3dKWw1c73MsLluhyMzJRM0EBFejlU6XkRBCpoo8ustNQmWBMfJWVGm08MO04+QKu3LEQT1cUrrKn6AoeiYus/CpYOmDTZ/bjShwe4tIVEdlXAlBDKu0ziJVR0/ovWyuHHqMEYJX+qwN1jFp9MbifI1FF3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319585; c=relaxed/simple;
	bh=h/b/7B8erCyrj3JILyJdzAZuB7zL6Tarc/A8a8l+KZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JAvGfAW5dpBTutRKDVx1jV0oQqnT/tWrBMoRLRdqyCDwBnqpWjN5TWsunSijQhYP+1VrzxKT9P1+tJ3KxBi8VXFLe/QfqfuIjnFCd/zJBMKczXHupLMonfgTWqYEA8Ej7rhaa9Y1ofp59hbjoEBpcIU20pWe/pcfm2aH/gnKyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0KIq5/H; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5a631b9c82so1474177a12.1
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319583; x=1761924383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/b/7B8erCyrj3JILyJdzAZuB7zL6Tarc/A8a8l+KZU=;
        b=g0KIq5/HZZf3ko/3+l2iddwU0TggiQp08dyB7an8s/wTYN7KiVTRI9A2dpf/E1JMMk
         VTj4gGg6R7yT43GIQM7yI6ZDElG0esYFNVO/h7uS4GVFIR3lFrVyigu53FVnmuMeWOmE
         7mR6OsnlC4vumadBl0SUfluN2NZChXhRc73DQopaGbchDoPNEsfM8BQRabowY9qFO/zp
         v7sXQKMphHDhbUje1KldF96MmuOMniJdhflZJ5RTBxR7cbiwXe8nb+2KzynixOOUhYcA
         2ml2cFSGwlTY5LTPQb+36oOkS+53/7P80IoeoRIdMP3yqPjXeSb0u7mVyr+lUJ7wnN1x
         LLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319583; x=1761924383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h/b/7B8erCyrj3JILyJdzAZuB7zL6Tarc/A8a8l+KZU=;
        b=BPzUpRuimDFoYIALwzofZHCsCBxiS/DtCQG9Be7C1/2CgmxLjZupk2DtDo3MZx7xam
         po2LJGNFNESN1AqWLFmk4yF+OXUYmlX0f9pmBK4tjjyXpRi/eqE8qwjesZocbIDmYSsr
         geWYg80gUu/vTI952PAQB1gmUV3ZyI5XP7cPxRwwaIfjWNLUWW/QG5XeAEdqtPG2MOVZ
         +/O+OTaXeWyGOGIrl80OIB1euRoHXLqJuJ3wNrJsora9mmpk/REqF+g5rtY6f7DCK8yy
         E+9hnnU8fCip1ttuAHkit90hn/S3D/TsHnUy47Ws/Txvw+k3oXkaENSNkggySxK0sTQ+
         /OdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWz3ValeGOylRZV7ngT7L6iLAvrUz8Mp9t7HIUexvFeU66Ywcv16kWfWlcb/5VDubIz7ZGKvejPZZF@vger.kernel.org
X-Gm-Message-State: AOJu0YxnyHKfUjKpfZJAa7RGdf8cQy6cidE43tzdp3uZqvRHYtrIpe+K
	ZFE6HohL3CrcN9eQ/DuNdUvx4uibTLSzK30JXbKebl/7KBwyjTRO8KoZW5cvUrEgAXQwKNlXh2U
	tCj4XPUvr/bd+6Yjr7P7FLPZR33YBHS8=
X-Gm-Gg: ASbGnctuQgFOP3fraUeU5A8Xpw8T+03bs0u9dNZK3UCAV+ivs6oRlArkAMarN5WO9JL
	xmD5kfZh7TfzemPBIGJkyTShBcNoIKxY/vyyI6/+nLhPXgqr2Dku2AvfzXXZ9S43C1iv6YU+pXy
	tTWg8fBj3Kf6D8Z1Met+avZR/xQlKo+MsyzGFA6hQbfvdavvUdXZd+rLZEe9HnH0ROxl0bKGSwK
	Ye602RDyf3r6G1cc7J/dnBA/SnmeSyCyqfedSTKHScmMCQUc8P/+1dLSV1SM2k=
X-Google-Smtp-Source: AGHT+IEOKdDxMb9HRkXEYTo6SU095pGaTWP1Is+4rDD/byL+J1nKnOMtorV+TskGEVX3KZgpNdKNwa4mrFcTz3mie8Q=
X-Received: by 2002:a17:902:f68c:b0:27b:defc:802d with SMTP id
 d9443c01a7336-2946e0ebeffmr84709465ad.28.1761319582838; Fri, 24 Oct 2025
 08:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-8-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-8-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 11:26:09 -0400
X-Gm-Features: AWmQ_bnzIhVV3MsPnWM2jSZ2tqW9zy4mQ0zFymu--KHSuU72fnUF-ZQu5fEvqAs
Message-ID: <CADvbK_cBbHfXyKe9=_+BH0VB-c73hRsNG0Jiitvh+48Y3_ydUA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:18=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> sctp_do_peeloff() calls sock_create() to allocate and initialise
> struct sock, inet_sock, and sctp_sock, but later sctp_copy_sock()
> and sctp_sock_migrate() overwrite most fields.
>
> What sctp_do_peeloff() does is more like accept().
>
> Let's use sock_create_lite() and sctp_clone_sock().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

