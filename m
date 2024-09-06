Return-Path: <linux-sctp+bounces-254-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4475A96F72D
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 16:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64471F2166C
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12841D1731;
	Fri,  6 Sep 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMmSrbEt"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489A61CB31D;
	Fri,  6 Sep 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633836; cv=none; b=Yo8e1LTY1BYE02xnRupVXka/AZK9iLklMkXgsvvSLF024T5xK/t6JDi99vpDbdqh1TsmOnSCg2LcF0ZLg2yADvY15zJADZfJBXj++9LqUW6+L8NiyN3VqlZ8B9aByjtFQUnyFt0MnYm+yt4smvrbXKq9yN5g3VorHiwMZ2j2HrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633836; c=relaxed/simple;
	bh=NhdQH1a5W6hapzmK4P0XA2IAR44oZC3J7Z1ztW+orLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuBXgNw2tbQFp/9oGNmvBWiACLCajQXxecFx5TzSVT+Q70D9RN52SQk0NilcXenC+/LdBj55vr2X61r+Oil8AoN3qWjIlPmEKv9O66HhLrDgEQqEuiJPgEQDsV8gYMGBT2YBkMEK5nSXm8YBI3Oz6yz0U7HB/Wn+NRIZfWgtins=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMmSrbEt; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a043869e42so8815615ab.0;
        Fri, 06 Sep 2024 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633834; x=1726238634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhdQH1a5W6hapzmK4P0XA2IAR44oZC3J7Z1ztW+orLg=;
        b=cMmSrbEt6siHY3Mss6nHeOA6YLKEIooXyI86EwV1VZpqgfrz5DA8JZgn3GO0X7+27P
         uF5Nk2oShb189dwaNC5hKhz6SKL0xxYu6eGm7kYXfxqEF4Tynb+aRbsscVIIWsHbrivb
         MdAsKZ3L2oNBbEx1oKcnxSwKL3yY3XUBcUJxYtTK6ZAOYgHmWSX6UMLTY5Id4j06qsCb
         KEGa1qsaX8jU2oYqFEFOwMAB2mUxzZVD9oYZaz98Ux9vtQH9QxKqovc7ihcNscqSRB7Y
         BwL1cZrMiZ+kRAUWMXoQatakd63LHNCzZbe8e3Im09gV78NBeXCVXiBbLr/nfG9b2pZJ
         p//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633834; x=1726238634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhdQH1a5W6hapzmK4P0XA2IAR44oZC3J7Z1ztW+orLg=;
        b=N/O2UKvZfKu25WIlsatSnG4K2Iiqu4hfewWNr8aN4mr5tepR2ENilpDgpj9icPQOkt
         i+DN7w1ooYp2HdVrImsN0QU9s3KNxwjkEZScvtIOs6QK5oCKTKbwmiU/PMW6ndgVRTGa
         t6LfqLamNW8l1d4j/IRa7u552RDbLtFuNs1WD+vWDfp9JAlPI/kzcMivsRlshEjd9oRv
         n4sAZngmAd4TC2utj+i1ybHotf6YqNNxgSmRFHHWV5ka0J0uZBKDRCrx1hrJUJ/AaZRi
         8T6VTrcCR67V4Q+JmuA0GF+/vlGHaXRMnOHPL4LaE0o2oEB8a8bg5a6TgEcbV9lkq2+S
         v7vw==
X-Forwarded-Encrypted: i=1; AJvYcCWFVq5gmPzW6BLwd8WZP9REfI5ffHAbsah8G+bxSa75XcCiJATgexy4bwfnJcD3NzSmaMM=@vger.kernel.org, AJvYcCX+ggIiTYFMZuIq+0kUJjKOSwXb+vb6qDU50jflBqT5A+AJPGbyEv3/rXjWlxz9TG25nCE2sOKcDl03iKoX1q4J@vger.kernel.org, AJvYcCXgwSeyPUOpvI2fhSnKPFyN4iJCLdUvuuGPXHN9bA5h9kE9wDw4XySsj17AZh/5n5Ir02A7m/JQKQBCRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhQqLjpWmvEfOTMyPiDdFqyX1NQg462HzKZblz8whRd7u5+/Zl
	veYQ4Kktgn4vUjly1dhXTHF49M9nylCLThM7kFhRume3TyTZLsxi6vjxTxlukLI/LCWf005eTT6
	W4WoJo0+D0DYixNamwaKI5eYgPgCh91gW
X-Google-Smtp-Source: AGHT+IHlLthbmKYIA0lXdf8bkLngRRLYn9z6GK5ZajQE9FHf65MIofrSVVfFZVVYi7C6mTQ8GGJ2XTekFieonTp2n2M=
X-Received: by 2002:a05:6e02:1b03:b0:39f:60b3:ca2e with SMTP id
 e9e14a558f8ab-3a04eb5f1f7mr24501095ab.2.1725633834252; Fri, 06 Sep 2024
 07:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905165140.3105140-1-idosch@nvidia.com> <20240905165140.3105140-13-idosch@nvidia.com>
In-Reply-To: <20240905165140.3105140-13-idosch@nvidia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 6 Sep 2024 10:43:42 -0400
Message-ID: <CADvbK_dn6vs05tbwd+uOL0raj_X6HFWAGqPqNxKNpaqSmw5yug@mail.gmail.com>
Subject: Re: [PATCH net-next 12/12] sctp: Unmask upper DSCP bits in sctp_v4_get_dst()
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, gnault@redhat.com, 
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org, 
	marcelo.leitner@gmail.com, bridge@lists.linux.dev, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 12:54=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.
>
> Note that the 'tos' variable holds the full DS field.
>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>

