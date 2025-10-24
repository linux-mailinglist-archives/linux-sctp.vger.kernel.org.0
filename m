Return-Path: <linux-sctp+bounces-694-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F15C06914
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 15:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B625B1A04D75
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E50305050;
	Fri, 24 Oct 2025 13:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izdYmeLT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4B72E091C
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313661; cv=none; b=fKg986Ae3GMz1qSIKjPvRKEqxEYOHY1aNyNQWYy0QcVWrAqaPWtyzW6LoEuRezNbVnJdloG35zyo2awvoFks/puX51IP5MlvoPH3zqEiBnkoeGfIz0M5+CGGXMFub7scEsN2yn+vFJyEb59wIl0IKlRKzJWK5JTBwXYSBiYRGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313661; c=relaxed/simple;
	bh=B9/IzzC29ADjg838vSrP4QdcRAF1D/yHkv4aULU9fKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0UMXu2MYmh+LBg1pHd4aJ8/GiczDTWTh1LrIpfKRGk2GB93mB2MD6YAW39RiKKQSZedcfMM9tXx/pvI+uXxQ6gJpRmwKIgp196CVF5rDkfjJtPOWfiQVUVA/RGYoulAGsCpEzGjDifoTfLdR0rsBj6kRfKhLvN1N/IjvS2cF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izdYmeLT; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso2566627a91.0
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 06:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761313659; x=1761918459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx1vbl1Ez/pgI3WrRY2trbT57SZdevUOnhKO+gQlRmo=;
        b=izdYmeLTqkTRJYQ/XphS7Ewnr1Isma2QujP6doPce3vf+EcPXejm5lqALZMOdgVFS0
         ATPdDqNoXqm4Fezuh9Qoctn0OzvZL9NDk7FStJBZIma9TwfJb2YYPdlNaqPixgU5PT0g
         goUeLFe/4u7a0XeGitwSQ+mYjbZ16KymUXvRqdfkw2ahCEc1cjAKSJ/TWkVc7Zy5LS/e
         yOuZ+C7n+G1BF4WljhOg6JmVmIryx3OGIP/+6EtP8qkoC8ie3NY9XKvoMwUmhhWlNRXT
         dWbXvxjiLnD8KkR8J1J/DVghMj2O61x4tpZw/nrm+xFE7jCiYlEtRepgI6FSOzT/QZJq
         PkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761313659; x=1761918459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx1vbl1Ez/pgI3WrRY2trbT57SZdevUOnhKO+gQlRmo=;
        b=D2mQB+SBGsnmOgRju98SNru0Pj9EgnYFDMDHd7rJTJpRXK9Uoj3NOKrzPiyTWxwgNA
         iAfSly9upch/IooJJsyNL+1cCPGHJ4zomm3E5Kt2o2TFAmUuHVtzRR5+1wDi734/vheD
         d8z2R8d9ucHwGZ3SkjzMRZMCe3tM1+VzeIkk44jOzhkM7NhrYUrDHpA9C6ckOXWnFAZp
         +A8MB9G5EcQzcpcB7WdCsaCkSvJIfJ8omMuw5rRJp7h1VPETZYCAowPfOvZPSWhvyqFi
         XiAQ5nxzoAZ7jD2krSOwGtxYhg9Q0AB/5FZzNQd0bhN7PSIxhVLsjoOqts7G0gUfahVg
         16lg==
X-Forwarded-Encrypted: i=1; AJvYcCUY9J8n0cDoYcOfhoY7CTIY6Z3uhhu5eg7nyxADyr67YHio0i2NtBB4lDwsK1H4GaTNp5NbP986Jwc+@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdKZXf5xOEEyZAI6i4otgqlg83gXbtv5nIExzz3GmnUxMdXZq
	G+Rg0tx0cjybvR0I4SY7ibqB8ZpA8JB8InbzMMsJhh8B3XePnIV5YEaDPeW4lMx9Yjl16GPV7tp
	aEf0wbJ2jggBT1s5UNc+lc1IpyYJSrkY=
X-Gm-Gg: ASbGncuSrnZm9ZjrtLZOd9gNTKUnRiKTMr1Wux9EeWp89e0l/VRPzyb6YO+zOh2+A11
	VCzjUHQlLD7UEb5GJqpR12Teqfx+s9FYOgTQqbOAoKmXx8xPPnsMDnUjUDEWpqIOJkDp0m0S2GM
	SM9AXrkj7UInwJBUEdA9/oH0RoVs7S58D6G6/JcqUDluMeezzk8lB0cWSddWNivzlJ/lKjO6uEP
	xefYIrQ3+z+fIB1FYGJ3S4MFc2fS9cEyLTRYFbiFHKMjuIMyEQIHjppinFkU03v4OqfA8qM7Q==
X-Google-Smtp-Source: AGHT+IE7UbRuWkUv2m2tt/ayasWaU7KrRQBkfj8k1+EMhwatD5uEDT7aDID0I8p2sRDR22M3d28tUsCjOmpJf+1buho=
X-Received: by 2002:a17:90b:2ec7:b0:33b:6650:57c3 with SMTP id
 98e67ed59e1d1-33bcf8ec60dmr36743501a91.21.1761313659244; Fri, 24 Oct 2025
 06:47:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-2-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-2-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 09:47:27 -0400
X-Gm-Features: AWmQ_bky6eHmX1WP8yPNfQ2f2z1ZYNpNAmLJSqewTrn8LG41DWILwivDPpZrza0
Message-ID: <CADvbK_d92g+ZxyyB1QECp=ONxzsgJn-FD1HXz1NAzRGYMG-Kxw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 7:17=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> SCTP_DBG_OBJCNT_INC() is called only when sctp_init_sock()
> returns 0 after successfully allocating sctp_sk(sk)->ep.
>
> OTOH, SCTP_DBG_OBJCNT_DEC() is called in sctp_close().
>
> The code seems to expect that the socket is always exposed
> to userspace once SCTP_DBG_OBJCNT_INC() is incremented, but
> there is a path where the assumption is not true.
>
> In sctp_accept(), sctp_sock_migrate() could fail after
> sctp_init_sock().
>
> Then, sk_common_release() does not call inet_release() nor
> sctp_close().  Instead, it calls sk->sk_prot->destroy().
>
> Let's move SCTP_DBG_OBJCNT_DEC() from sctp_close() to
> sctp_destroy_sock().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

