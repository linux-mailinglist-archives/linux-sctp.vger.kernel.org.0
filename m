Return-Path: <linux-sctp+bounces-695-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A934C0696A
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 15:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AA30950564F
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8D131A80B;
	Fri, 24 Oct 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqz7D3Mh"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236213195FE
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314171; cv=none; b=rJSNZMHG/RND3H0Gg+rhF5A0wrWsNsbIEiHF0xWKMpnsPOZ/wZYjAxQ1PiwRGnjQJwhozNEzPxFmvP2FCdTnhOoytvbqX8NfJwNY6QhVG4D3dm7YyR7SzIv085GBPAI0/7iqYVKubQ1cVjVrENhLqcbb9WlGo9SLoYdDjOKPL58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314171; c=relaxed/simple;
	bh=ff/DRF40bPQ0ZOkhkE1U8SbP6PSmE0d8pJrKGabISdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t23hrLoO7pFwqowTi/FaVvvCDyTymuAmNshR3pJg0yp9lbc4rhhKNZzGQ40OHd6OOQvc3IpUNv9WaLwX1FMdefL8RuYKl2JHpcEzaMCjQseTigvq6c87wzC1COmZpp1cQqiFMmUZIMSTfK8gL5k72cDCxR3OLKZRAhXH0eLHwKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gqz7D3Mh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso1557095a12.0
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 06:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761314169; x=1761918969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ECDvdIBbgPjfBzu0WR5UMZQdnbEC4fTao32NLRSQs8=;
        b=Gqz7D3Mh9JR2DOamw+9adVY69uRP+CCKCvyPh3varLTM3B6GFV2O/O7Yr3hSGgmiqa
         SQ/To/qqzQ+50PFSOO3M7Tt2f2lc+NMRGviMK2goFR+9WjPulocbgykmxTGdBaJliD68
         fL1xTeQaXgnn8epvrDzgsD6POjFVx7IT7CA6EeQ/4gGtpcEo7qpK6mSL3QOdykOke3A4
         gtLUXusgoNnEIfxubt9y+OJ5sTe4KxAJyr78B0eEcwABjKBZz8vZqXQvkVXGmVCPenS+
         B4LnKL4UwHxZVgWyr9/+l0Y35dOoORmooyqXGAzFOen4O7IXtcXwzjnn2pRyFCpvnQcw
         s6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761314169; x=1761918969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ECDvdIBbgPjfBzu0WR5UMZQdnbEC4fTao32NLRSQs8=;
        b=QgcEu0Zfjsrmib4a5B4DHGYx+OnUPh7871QgcojLdQFH1Cs7MulgvCHe1koXJvt2D8
         Uh5W2jlCYjcBtn12D1G7F7GUB6cc6pBJsIRcLQN6JnPoLTNbHfdjRfEwD8r3gsCLMu7a
         h3ECsE2Dwd7Xj5LL4/7CIrvZmI72e/WseZJcFjhoaJB82MVdvXJ3GVjWA239qvtKiNxT
         riapggtXmvVEY/b6ZSbkfwQqk7w/MfVPS5sW3WeDAB3nHKiR1bzMoceGy2Fi96EAH8oW
         oIAk78I3mgLskUpZkjCrafLV0MGeYCMVDPmB9KL80YJgRhLL8OpN6BjSessH5xAiAawN
         L2UA==
X-Forwarded-Encrypted: i=1; AJvYcCV1KpDtE1sp2SamuRVUuGhxtsrIGVqrV9+/YVv3Oll9hlKJe0BmXrB6BDq34mPd4yrGBauEabi2ZSdM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Ve5mZBuDXmeBeMFR3ruYSMz/z+QqiqM0qxXPDJKHqMgrBe3y
	NNXLvQUiP0Ye9wtsyuHNVVk7GMSAI7MlOsejTBuG4V7qOTnOAZbKKd6VamX3GYqdAo1IMQa+coX
	1YJXannyQFVuhwFacKe35d5h8HSQfkgA=
X-Gm-Gg: ASbGnctVtWCcpVTr0Nfqe0lQ2J796XfGhWjK30tRv8WuxGKJ4LLLtoW+vl8SSh9BLe6
	GmaIkGzKHCztmvldBPyPsKkIjC2tQNnk2xhiNCuRjsihhoeLNXi0Fb3HpjtyLnuRJEmoblwf78K
	r+OIsLSLEcTEyvQH8hJJgwHuHT8OXPj6KKtDZzGCO3twMohTEEorbdPXFXI2rRu4kS007DNUI7R
	3J+ucg64MXNzj8W+1bKezoyKilquun4U6q63HlMHu6p6ua91OH3DSRkeFp9Bcc=
X-Google-Smtp-Source: AGHT+IFUweA0FrNrhak9yFCS0iUPJ7kUrOYCjCdpYrDuihK8hXnTOP0JEsYsYmBDMl7Q+wZKtOAGXdprbWIPS18TACQ=
X-Received: by 2002:a17:903:234e:b0:290:a3b9:d4c3 with SMTP id
 d9443c01a7336-2948ba5d932mr28420075ad.56.1761314169363; Fri, 24 Oct 2025
 06:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-3-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-3-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 09:55:55 -0400
X-Gm-Features: AWmQ_blIGrBy3zirHzHyn1AAGAhjWECgDtZHAfJu_PfzbWO6ze6xstFwEJynfS8
Message-ID: <CADvbK_dJGFQG9jx5KioFn3-z01w3xO=MeWxwsQ1fUHdkNN6NGw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/8] sctp: Don't copy sk_sndbuf and sk_rcvbuf
 in sctp_sock_migrate().
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
> sctp_sock_migrate() is called from 2 places.
>
> 1) sctp_accept() calls sp->pf->create_accept_sk() before
>    sctp_sock_migrate(), and sp->pf->create_accept_sk() calls
>    sctp_copy_sock().
>
> 2) sctp_do_peeloff() also calls sctp_copy_sock() before
>    sctp_sock_migrate().
>
> sctp_copy_sock() copies sk_sndbuf and sk_rcvbuf from the
> parent socket.
>
> Let's not copy the two fields in sctp_sock_migrate().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

