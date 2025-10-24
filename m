Return-Path: <linux-sctp+bounces-698-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DFDC06CE9
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711E61C21B86
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6642D31D39A;
	Fri, 24 Oct 2025 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSAy7VI6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE370258EDB
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317529; cv=none; b=F11gyVZP6X4Q7UFi2p1qVBumtmfg2nZHAhQfGHD4A7r78ADMp1PZRScl00PTLcZMfnnrZdU7LkBmkZW3GxTkPYQNs5HY3SEZaktOb4++AswVVIlmv8DiqJzePOrLB2HdZqQiqQwXM402vB15Z2sJmmky6PmQUZsOmNPwIw3Y7iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317529; c=relaxed/simple;
	bh=OcekF0uNEQgSI4aBvsnmMv6ZMJE2SZqDXxC9GMDna+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOlQMl2wngb/+hgVntUvOuT0DE9Kj6m08zjrhokEIREfLyA6kdTOpry+n4OxhZmBNieEtKsSduU/7VhVljZimupz7FRae6us6vHsCbQD3oQq9LSsKHAfnn9YXpcrF0qV6ZeV7wXUjcZjn7ynroiv76j5GmDMgFm9RNcbE/Te3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSAy7VI6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1743697a12.3
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317527; x=1761922327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcekF0uNEQgSI4aBvsnmMv6ZMJE2SZqDXxC9GMDna+I=;
        b=mSAy7VI6Fr40Azq5gvMR92yXNX+PwMygazuQG2CEp811dJCh+dTrPrkKUnC7ZlH8rq
         h7vWE8XgCdqYFc6Hy3NXKVhscRl9GZ4gGSydJyIyUDCUwFKz3U+sYyEm0G5kpWzgzdaD
         UrsohFYUafFkwqe6qABoRtOdgn9VIIGnnfyV2tVYcitFqdT+IG7facmejP0oRs5pWmXC
         BnUDwYEvvWvU2QzODcgSgDb5A+fyMUDk8gDB96i9xhNGkNEbzZwMIlSv9RbukKEDYXJ6
         lmqWIAO6IlDLN00cJ1MoQX/KrjiS5naWrlpzgSC77BV6ISvIsf/ajpFCvLNasqvU8hcU
         Bkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317527; x=1761922327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcekF0uNEQgSI4aBvsnmMv6ZMJE2SZqDXxC9GMDna+I=;
        b=ZfSuJcHyTqcLk3y6eVq0CUoSagkYev5wdx3WROh228/xYZ95wCHgDCLe+Ox3eZh7Yb
         PRDUgzZc5c4Q/9PdwgivvtjSAqFbmoyVyTN3676oJRoZqRrgsQ9TZSTkz3JTxFNB+AS6
         Q8UCbFZUJl7Og8Hkt/0ktWGxmzeS+bAcLyYbMnyEBE3h9sDAq9duYW1e1WtQapxObZcf
         mYUGla1hDxo1lK0PAeG53Q6Wm2+XXSyzoAoukn+KjllSI0B6m8gSW7bkmsuN4yGpC0um
         i4TmoP3+gJtnbrVxp5PGfeXzPSlizzKWC814I5kzHEfr0fiQuO+d39yBoD89X2k/D0tO
         nywA==
X-Forwarded-Encrypted: i=1; AJvYcCX/qgCqQTkwJXS+eFsawmdvm0XGi98pk4ya0gRtQH1GgS7wjLDOeJEs5IF5E7MJRn2pKnt88aBX5q4a@vger.kernel.org
X-Gm-Message-State: AOJu0YxVRPlcYWtg4hE047pVkLjgGrLsS3zmh625rSWfKgTAUeY8/2zE
	MkiDAkFf+6iiyswT1XwJOY2F5MtsEnRjW1MCSwR1OjUJq6vzP/HCgN+C5DCsscJo3z5P+WpSoTS
	Is1wO8m4U14QI1FcMv1wGhxhEGokaBag=
X-Gm-Gg: ASbGnctLqQPxwNlPK3Gkb+FJ0r9zcAlGEKZWtx/0+zZmirANQVm7Um2NfuYafO5gjwA
	ZGgpvp+UW/oE5AxR1JPqehqCJIKh03RUAmaSgk3EUVy3yPdRtZYHRS2GygDQilsIXVwM8W+3TKj
	LjbWXo1xclXW1P+lUEEuxFCAZ61vN/XtNqdvWoDKSXyGXQdnh/u49ef6+BqhK76IFeIRHodpkHR
	+E42lsOq6c25hSZrUDuxKbf3qpZzwYm40HS5x4s43xxTdHLkUt5RixMvVq8tW/OwBXYYXPm4A==
X-Google-Smtp-Source: AGHT+IFv5vkfuTE//Te5nmz1wt82UnKhpQMtl17iJPAGJ5j+ovA3i8x3RUgXcOqZOScksox0/R/ieVuy0Koq/DAPnL0=
X-Received: by 2002:a17:902:dac9:b0:28e:9427:68f7 with SMTP id
 d9443c01a7336-290c9c8a5c1mr373268475ad.6.1761317526939; Fri, 24 Oct 2025
 07:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-6-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-6-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 10:51:55 -0400
X-Gm-Features: AWmQ_blBoikGr7lZkMaIWvhnVCBxMBypRtxx5vMnfD3wT1Eoh6eGKx2FhNTNx60
Message-ID: <CADvbK_fnzXPNiLTQ9fV0P8ZYaw1au8iwMoijsmgHmcGbyS=0dg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 5/8] sctp: Use sk_clone() in sctp_accept().
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
> sctp_accept() calls sctp_v[46]_create_accept_sk() to allocate a new
> socket and calls sctp_sock_migrate() to copy fields from the parent
> socket to the new socket.
>
> sctp_v4_create_accept_sk() allocates sk by sk_alloc(), initialises
> it by sock_init_data(), and copy a bunch of fields from the parent
> socekt by sctp_copy_sock().
>
> sctp_sock_migrate() calls sctp_copy_descendant() to copy most fields
> in sctp_sock from the parent socket by memcpy().
>
> These can be simply replaced by sk_clone().
>
> Let's consolidate sctp_v[46]_create_accept_sk() to sctp_clone_sock()
> with sk_clone().
>
> We will reuse sctp_clone_sock() for sctp_do_peeloff() and then remove
> sctp_copy_descendant().
>
> Note that sock_reset_flag(newsk, SOCK_ZAPPED) is not copied to
> sctp_clone_sock() as sctp does not use SOCK_ZAPPED at all.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Nice patch for the dup sk copy code cleanup. Thanks.

Acked-by: Xin Long <lucien.xin@gmail.com>

