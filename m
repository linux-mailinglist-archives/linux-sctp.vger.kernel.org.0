Return-Path: <linux-sctp+bounces-728-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2755FC26BB6
	for <lists+linux-sctp@lfdr.de>; Fri, 31 Oct 2025 20:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84BD1189E2A1
	for <lists+linux-sctp@lfdr.de>; Fri, 31 Oct 2025 19:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2403286D63;
	Fri, 31 Oct 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kaf4vG02"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6DF2FB621
	for <linux-sctp@vger.kernel.org>; Fri, 31 Oct 2025 19:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938868; cv=none; b=MucWCqmWLIhaIJBbI4ECtwkzRv5uyihWFpUN2pjVZyYMu42p5Zs9YwObyWUvVM9kqRp3amrI/k3MRcAqoWPGNc2nFufpmACrd2cLPxRqjKUSaGOQAlaam8Xx05LpWeHDlhQvAehDu37qNBgh9pcGj3RiRyYJtvDu6zqIGmHomtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938868; c=relaxed/simple;
	bh=W5ERWeScacJrf/6VbJA5tzli6xAOwXLej82R5oNfZn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zyd8yKn09PGU/ZmRK2Fl8kuKPPARxNuYqc4IpXU/NuxosWzXUNXgZg56bZ/+KTuJUUIGzCkShz+XF6l30WRgqokwas75p7EWVtPfTsCQrZMaNcBje9BSM1jMLerh/lpCA+q4mxRGxwnFFcNFrHWC+DcfBurYL9/08KQHm3G9y3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kaf4vG02; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-27d3540a43fso27519745ad.3
        for <linux-sctp@vger.kernel.org>; Fri, 31 Oct 2025 12:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938866; x=1762543666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D//lpsjWyumK3n6VlbuWmPrat3C7InfHOVa4TBnUZU4=;
        b=Kaf4vG02AspVkEQufslGTPLsSeyG6UdwdnCitxJyr41M+eiYrExuNwTvB3W/qXOgxj
         PRdmpjfXsc/2AVmDjk3OFLXCKtZaZiGL1rEaT6msODg8PWt+3Kl3A8/SL6yaJF+5N3+L
         Fb//cQLJp+kr5GsSNqOO++EBbqMb+U2L0/RwOOV4nzgy/83OtgZmLGAuHBC35F63WoFg
         SJPVyTUUwsQSkrNSc8tVzbp7ZaN20KGupj04JWa0HNN6pnw8hOBlMHV4cPXp2FwPrHfo
         R4J1kzBhElE7ZD4mK/GFko+hjzCPfVMsHTtjjVDt5YpAt4yAPVeWylgmxSwsd/tGmx95
         UcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938866; x=1762543666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D//lpsjWyumK3n6VlbuWmPrat3C7InfHOVa4TBnUZU4=;
        b=kMw4KntBbJHuPC9ZzuBFmt/RgnNPjP97nqJyNS2SslTvLY2e1992xC4BYtCUsYtQEl
         Wn5lFDkUIkVbaQwNf+dhpR+B6MzD/CFSwzJaJYNfRPE/IVdg+3YHWXaNRZAF4PUpLdcG
         oUNXkmePcAeLWfD7e2VouYs7Y1DrGLi/GzQvbRcbjMLf+z+87MC6HYkoXzAiDvdKu1DI
         olqfNFGltvhJrRKU7eT68EkFWIvRm/0+DAjofOz9H+yI3lydiRXXCJ1WqdugIrD44crr
         8dvViiw7hWNHY7hllhmBU4zGe+CASzfnKD3RTkTdyQs7XhiI6592iHuLgumqjCwXn/Bu
         re2g==
X-Forwarded-Encrypted: i=1; AJvYcCWmVHg8jygg6o3kF3bsHVpi1rdKwdk7rU3OciWtV16EYST4B5IuMSbB1dz97TGX1hNpdFyym0qt9i6P@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+vzwF1y7glSrYYDvd5wJU00bYAW+pJ/W9dO5br5E4v8KKOOWi
	nyptqr28mWMrbahUmlaAAEf8uOGqYlQK7W/xUrq6oXUfo4iWjEPJlL80YoF7360tW7UfRJavO+S
	Uf8E4odEVaz0mCnUKgnqi624N+2s9FsX4tnCmmOpJ
X-Gm-Gg: ASbGnctz8OZA01O07YmDz9EiWNam2zS6yPiNiebX48jz2/Ahh3Z5DFbd3EvBfPxvmd6
	NCirsunCEWQBBPrU1Qvqz4ekuHgbHxd/CV+qPNvb11upUUS46IrxDsKfoq2iIfJV/r4IKE76I5+
	5PeRqV30IVkWTNZT43burI31eg1f+RlUH/h6PE67ehYDqdLGtKTn4EDsD38vANBZwe36H2VPPTp
	wXJxpJb+iB5E1b29V1FsiKEk0IGa5hSgPvqlCnXSHYUaVTgH2yCOzJSx814vxRlGyhocQL56fKx
	5v/kk9qhG/T0K4w7aG6aPKd6K/PzLB+sjRifbsg=
X-Google-Smtp-Source: AGHT+IFZUbXp28y0C0+8P0RtCvqI8+9sTeRUh7l5pcsHt3+fz1d92FONyqve969QB3J7LLHn7Chttx+BCV31QLbv+Q0=
X-Received: by 2002:a17:903:228a:b0:295:557e:7467 with SMTP id
 d9443c01a7336-295557e7b0emr2653585ad.17.1761938866351; Fri, 31 Oct 2025
 12:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com> <20251028161506.3294376-3-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-3-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Oct 2025 12:27:34 -0700
X-Gm-Features: AWmQ_bn2YZsASxudsjnaQ_5Bjyi-hSzM7nTrE0vhRKJJp2EZCZFWgvZ56FkYWlo
Message-ID: <CAAVpQUBaJMNCOZtzEcUUT80XmZsj+w8CZDe1C08FudjXJFPT6A@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] sctp: Prevent TOCTOU out-of-bounds write
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:15=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> For the following path not holding the sock lock,
>
>   sctp_diag_dump() -> sctp_for_each_endpoint() -> sctp_ep_dump()
>
> make sure not to exceed bounds in case the address list has grown
> between buffer allocation (time-of-check) and write (time-of-use).
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

