Return-Path: <linux-sctp+bounces-702-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B00C071FB
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 18:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66477508795
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612561DDA24;
	Fri, 24 Oct 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPtnvCtC"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603332E750
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321724; cv=none; b=tbs8YG0dijhVWcGUITIOr833kbTYTzELwSJp0dznsiy3itfJr6Y18mpkBfAcyvkbtzlDcyUR1zYLgXPZSsLHYmqAXfXTwZexAymU9LpUf7JfzvMSkL+eNhVkqByCS3lrFhTkToTmekXdEQLoa8+FjRV6c4vqMwuyJpefK4lPjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321724; c=relaxed/simple;
	bh=2TJy/wmtIjdj1zVG1S49iY/z0Gogb2d6befSBR9re64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ud1SFwGNbVdvDSggZbUT7VgCTpi6EC3bJI4vY9V1yMpEY8NTWNiI6bHeD7er75m+WJq1Udu+IQ0n15HPHOujHDTAgL60SMbA0zKe8xfBqX0SAE7EnK0pXdPUpVk7bLn32rrBq60l5JW/0hQheSrxFMSkWhrFHuvt6nGxd7iKHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPtnvCtC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7833765433cso2908300b3a.0
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761321722; x=1761926522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xM7tTJSQFOu7U5Iu9Yae5Rihy66ZaCsrXLLaOr+Jyo=;
        b=IPtnvCtCO5oLLs3RUTFkZ4ZxpTFDSpRgABfAdo05RDophRSYOURe7OB9fwSyxaO9Du
         9JOjwZq0U5J1egQ1NZrRSMA7xqnFmC6paBdyZRVsffLCQV2qAVUTsvuXPyPtlFxOfAXc
         5rP+gpi0lXs/yV9OCTaH88DF1hsJoLH2u5UUDRAZ+1Km8ck8cVkqJULlHq4ctJGVG5g5
         NKs26tNlQ8jG3pG1TsC+Dqe/n3J9zwAmqt7cLEHFpa4mxfeNaohYGSl5LGiUl/6nFIAD
         Uinnck9kACvAiwZFkdX4HaOs6wXSQCi0N/RNTHibqtKLv8NtufS4aikLaAMva8w4Re1r
         rckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761321722; x=1761926522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xM7tTJSQFOu7U5Iu9Yae5Rihy66ZaCsrXLLaOr+Jyo=;
        b=Gu3+dWeIAuydDqeRD6Z407vuwvO8k+LrOPXiTTtHdnnXJ+AjtYBg9T9Ra+PmdAG5SL
         IWOMv/6neMgh6A1CpC4QiQqxYMP9wnHHxmsU56K/hoMP16LYhgy0/5KvixOcUzDYpjiM
         ABAJMP6s9w5xxcMoWYGv6s9TdcvL6xZFb7V9obTqrJVeeRRnscpkiPmr1LgEyNU7a6mr
         WTg/ySa7zlb0c3Wq4C7UIEmkqrVcsQClnmcrois67WA2Lv/qdFLb5HyDO3NqYdPwdO9U
         VOdXiTxfOrFxdltmQaxjbtjErRB9ZCs2FNDXy5RNGZvdHg/sGFJGXwGVO1c/x4kWURrK
         eW9w==
X-Forwarded-Encrypted: i=1; AJvYcCV3EgzpBqwc7BvSbfdP6RcGSI4a1nPsTNbeSxDcuPiF1h9224pUpRchx5J3cGwOyI1y6rxB6KiEcpWX@vger.kernel.org
X-Gm-Message-State: AOJu0YyKd7Apw4gWegNxke51tEqoy7DrUnYbBrjep0fAf4u/5D/xdiXd
	QSPWQZJJ0GYA5dfk+wf5N+8tlOJ7AxXZnyMLaydU4c5n2ZRA3B8gssr3HKpY2C8IYuClNd1eXVy
	iq759IN98xgoDxJAJUhAMONUUSU8X8bo=
X-Gm-Gg: ASbGncsQvu2BjAhvgcmIm3BLYRwJ4lrDvtktdtnAFFE1i1ReYBXVG2eXBH6IgnYfj0V
	HHZ4FirWOBoL6MM24/xHsKH1LZtBgPksrK9zb4xUuCyHm7jYWLB7xAbqO/KIigce+loAstcghGY
	kqliYDdALnsX+ksQfs1C1pRyKLtCFpCr9Qhg+LYTxWbvnHaFQFP6KJFZG8IbGVs86ft6D1+GM6O
	sdBWJYePqKTjHLx/Br+SmU//mgSKKIwm0wkT4jvbQTLNFqOniED0FfIbJTb3eA=
X-Google-Smtp-Source: AGHT+IFgXNFHDVjsDkfldQ4dCyopGzSqbd+Nl88iTbL65LARzCjGL2DP3Gqq4IE+2wRysqTKhZNrOG4LoGmFkhGa1NA=
X-Received: by 2002:a17:903:3bc4:b0:26d:353c:75d4 with SMTP id
 d9443c01a7336-290c99a9669mr358112785ad.0.1761321720729; Fri, 24 Oct 2025
 09:02:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com>
In-Reply-To: <20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 12:01:48 -0400
X-Gm-Features: AWmQ_bmIoJnrXxWCLQDEdYLWJrHbOfgktULY9VYiQX5d1f0lIXNqyEMWXFPiHDI
Message-ID: <CADvbK_dgLr5dUVqc=hxjj3n8wn8azkAp=K2Jr-pcuzUBk+et1Q@mail.gmail.com>
Subject: Re: [PATCH v2] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:44=E2=80=AFAM Ranganath V N <vnranganath.20@gmail=
.com> wrote:
>
> Fix an issue detected by syzbot:
>
> KMSAN reported an uninitialized-value access in sctp_inq_pop
> BUG: KMSAN: uninit-value in sctp_inq_pop
>
> The issue is actually caused by skb trimming via sk_filter() in sctp_rcv(=
).
> In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed t=
he
> original check:
>
>         if (skb->len < sizeof(struct sctphdr) + sizeof(struct sctp_chunkh=
dr) +
>                        skb_transport_offset(skb))
> To handle this safely, a new check should be performed after sk_filter().
>
> Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
> Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=3Dd101e12bccd4095460e7
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks for the follow up.

