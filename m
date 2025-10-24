Return-Path: <linux-sctp+bounces-697-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD1BC06A90
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 16:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F4D54E5601
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898C1DE2A5;
	Fri, 24 Oct 2025 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evZP0PKO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034DF2B2D7
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761315317; cv=none; b=iso5VE/SmIDgf30LHJoU+Qb8cz9qrjjHX7l/2xA7dWDCyGV6jujW46/cUTTaKMYCf0dl6dzw0l6bfLItGDhm86y9OcCm/KdaBJ0/FyVnloG51D3ocQDUM6KWMzQyrc1MaRlw/FnizUffniC6IDVPv1iPqAuz+2gwtZkJcHGv2mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761315317; c=relaxed/simple;
	bh=uvQ+jkhqGKk1WpblEFgGkHsvG8VKbSBMqxWVYLkcBAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhGciFdwPo5ZqOF/AypZ8JvKXBJddO4cFSWOFv3q5AKtVgW8A5PpM1GVLZJmYM5K3AQ4VtTUND8gl1ocTIPVZXFcKTyx8yTssosF42wUegXe2NZ3Ek0ot1Ns2o+EQKUEoCxlaNrBSbA8qkv5YNQCNTBCEcpIMdw71xVWL+Ke8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evZP0PKO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1419138a12.3
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 07:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761315315; x=1761920115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvQ+jkhqGKk1WpblEFgGkHsvG8VKbSBMqxWVYLkcBAs=;
        b=evZP0PKOhGzqRaVUQt7pa827Zu1vLR+hRo8SMJNNEfo2IdMfpNGXm2Rs7RwFWnQT6D
         T5z29NcXoVvQG1LGvxmpKpzoLMuwg7wQaCggmkx3e/nTN7v5RsTKcji99hwt2EDibw/T
         UuVb3HP+qR+lkcxh6Li/1T2XbGZniWqXNnCZgtcsqV6bYjStH0GLOszeV9yqWoStRxb4
         lduZNu+KeN2kXbphoIY+LmIzC6NhbPM1+DjVG42CVbtxDNu5ZnFxxnq+mIfVlWoigucm
         5/+H2d/2RPKi1qeitd9cf3GkOay+/Ww6AQWPHIrp2W/5z88d/1s1eu04aCkIYwcyK+vL
         dLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761315315; x=1761920115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvQ+jkhqGKk1WpblEFgGkHsvG8VKbSBMqxWVYLkcBAs=;
        b=Jjcnyqn1kG4AXlsadPgZ8xOrvy9sNM9x/gfwY5lAXKfEyEROZSh03inTecjsiSL/Ja
         MXMvqfoDDY5yUI79IJoKgRrVhys+PcclXib85BrCB7z25/lLe3JjJdgrgiQ+4pz/U/h4
         Iq/JxJgTv0p5nf2m/VMDmi40ijPqhfTLABuasUMbOiPEXa/ZfIU71nfm58JvbFZhvRn2
         D2fGPZoXWVn58zrrCOKGqVeICuvgRk+d5xtID2La9ByS6dQCY/SnP5t64SuUAITlz18k
         wlkjbkZxdn7eJ7TnD5fLJ55Q8fFzeXPggHjKdYy+UbP1tLnSONqvGKrfikvAuL28HJmD
         /cHA==
X-Forwarded-Encrypted: i=1; AJvYcCXyBxPvMYV2LpGwvlbXKHAlGi25iLoaxTPKExgrin4lvJCLOUoTObihaSbItKPlFh/yqaZphOawzaJC@vger.kernel.org
X-Gm-Message-State: AOJu0YwgssQ5XhI5KHWElo2t0A9Qo4evXYsAj0XzYmS4bg0yoQf/kAAc
	0+gEQaOxlcwrd3iNCygSZqPM8d1NczPV0G0BOOjt6kU1I4kLtd4yEomCy5NqdDlyITCRvG0x3N1
	RfqVEsRXxNSXX8T0pC6Z8nvOb8Kb07C4=
X-Gm-Gg: ASbGnctB75DiIojjSOey8GB5eRrHudJae3ly0ye/RJLL5WpLpPI8wXLlCSyEHsMuRyO
	HCfRPhcywNPhkVBm43qJIVzFzcmu9XMmpaMSe2aLXRYdPJA0U+lefMA8MStDTyLKRiOkG5Zof/L
	BT1opzd0E25zgQzRe8XxCJRzLPhvFeYfD2kiyVB8NjGOu9qSC2zxQQNLqORS7AfrmAggOdwXYcA
	qtoeW7Qx11zHDtbBYw1Ej6a/e1zO0vrA88yBReoJ5Xq/1DeUiFELmh2W9V5UHgz/qurHY87dQ==
X-Google-Smtp-Source: AGHT+IEA5W7eu0BLPVxoxUEV/CvApTWO74PEQfhYdsvQ+n8nBGSFVPwTgxTq/YcM5nUWFMdEJw1vfxFmiGfSUME+Myg=
X-Received: by 2002:a17:902:e944:b0:26e:e6ab:66fe with SMTP id
 d9443c01a7336-290c9c89033mr333543875ad.5.1761315315142; Fri, 24 Oct 2025
 07:15:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-5-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-5-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 10:15:01 -0400
X-Gm-Features: AWmQ_bmHnAeK2WlclRwGHjmwPGnZNFsUuJasTWT6C2yNaoAUurma4moeeIvQWtM
Message-ID: <CADvbK_c50x2-OzGhNRfrRK9u0so7fsf92MKoaYTWXAxJoTp=uQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 4/8] net: Add sk_clone().
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
> sctp_accept() will use sk_clone_lock(), but it will be called
> with the parent socket locked, and sctp_migrate() acquires the
> child lock later.
>
> Let's add no lock version of sk_clone_lock().
>
> Note that lockdep complains if we simply use bh_lock_sock_nested().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>

