Return-Path: <linux-sctp+bounces-701-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59508C06F63
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 17:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2EBD3353567
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 15:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D92DEA7B;
	Fri, 24 Oct 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIqDjPxl"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AE326D4F
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761319670; cv=none; b=bMCGJi5/9brdSGM8JWersRm8W8V9tijaDJMXgDDP4Pf60UbUvf377X7UDdT/AaoqOKULoFkUeTltRrvya5HFrCYV8yvKgIFnImRoIhe3Rka8XhWPEUcSzml6oFHAT0+sYyKq0fUqobUheHKiaauaMe5P32u4r62ZAZ9TjPdkbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761319670; c=relaxed/simple;
	bh=mZUwLoRhzQZCFpDyDkkPff1q32CTDK5uaQBs2fNy31U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgp+hQ3YXPfGjjavDu5YwP4Cs6THUT1vKs43/YnEFsotFbjuQsESee/UnqciesHw+dMKh3S06caJ5h0FhZu6agBS53t4q/afL6fFTP+7w2uz7vwoCxxrC5p8aPBDFyaebTuF59k23EKOIptLqv+Vihr2S1Rw+SG//UI/wvfcSIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIqDjPxl; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5db2dc4e42dso2124263137.1
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 08:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761319668; x=1761924468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZUwLoRhzQZCFpDyDkkPff1q32CTDK5uaQBs2fNy31U=;
        b=nIqDjPxlztsCVIzTHKFW7I1d+Lu1FIuTO9PwrAOlL1FEn3kBilNjzNBf09utzFHPJl
         BczbPz+YhczmefI52dYWmOASq+yB8bXjPPtWJIrhqtXJOc02iyVEwxLQOtWKPobsBPYG
         ClbOj6shMp8wcY9nf4yHp5h2agUsxU0Remq2PI0yzYq0mBZujVybdIExJAm7h9GfzAjk
         I85XHPYue8U2AJ9hlBISZwSi8WH8XJuedfDBjpLzllisXcFnkHD35uGQC3OtrPAfnfsl
         J/72yiZaUt6bLLvMPFkn/RpM6ZxLBgOD7iMiPIAAPXBSWhB5fv4sxCvw7A79TnDLgFb9
         DdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761319668; x=1761924468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZUwLoRhzQZCFpDyDkkPff1q32CTDK5uaQBs2fNy31U=;
        b=Mg6sv6lxUQNmh5Fjl0G4aFts0AsNiD1mMHfLyDEqgZBmWqFfd6vq9WrvXdivjSDWFv
         Hb+/9CZr5KIiCHi14DsUNEDicN0Gd8ERutGECrxwsVMOiYQVABw9Ip1jAs+1LjclzNbJ
         QedM2GT+VtStzO7XyVqniIfNiAKEd7FyBxHgfoVQj7ruIgb7HyFoK+ACwdvs61NoRo4W
         WIZydFXDQrM6evinOCDPeBiRxVzTt97Q11IFx3bJZnfO4hjuGvGmrvQXUDR3FdKM5emi
         oNhbmd9MnUkMKOd8MB241rCkqmLXJXxaw3s7WBvwmuasxkY6tx3gYhz5CotTBEW4allJ
         OBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpLDQEwm3BM7X9WxnlffSrRwYcRP30MSIs5PT8G8nBbGa1X2rhGdAb5ZZRpoGWbs8Qeo105TnBLQq+@vger.kernel.org
X-Gm-Message-State: AOJu0YxS3WfLcjnEqNjOjcq8kREDGs3hj0tE6nMr3x4nX+M6kb2RZXnJ
	/yAbApztQjoOm/vs2dU/UpxFhnhgVKHeYQW0DecSW/nEy4HYyZRDDsATy5N/E42MhZwBFeARpUs
	ba4UHews8owCsR6QDCowlSwiErMFwPk8=
X-Gm-Gg: ASbGnctr/jsa9kIcJJ/GivjYTRD2TzNAe8/celbLeMkzBdaNQmtb6vZnBxFIXB4n7eV
	XjxLrWNefZeaLzEjS/LLj6Jv8uSYYLY60pZzr4qdWzp8FfYvSv0cmjS7EXAfEK6qfPG3tKEnq4j
	pzMGorgAdGte8r5VFxWwT65X/fA1771dGWY//G5iKjwuQHb+sReJ+IhqL8EcMPxog3pBg6JhJAt
	zQShTvDLQi9nPjedXLIYXKj71CndOO2ZOD3NFVoIaRbAg0v7FoTn6Lw+bOFBYXPPVL0t0/Mng==
X-Google-Smtp-Source: AGHT+IHO6jbdwKewZ+aopol3D/t0siB5pKFXflfKqanP1Lzne19T0FSC237EONrcwcBGE1+D2XZVqHChOX/PZGHrpDM=
X-Received: by 2002:a05:6102:4412:b0:5d5:f6ae:3914 with SMTP id
 ada2fe7eead31-5db3e1edb23mr1087557137.22.1761319667779; Fri, 24 Oct 2025
 08:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-9-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-9-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 11:27:35 -0400
X-Gm-Features: AWmQ_bna7aWrX9MYc169qOTlnpqj03VGgvqTIlz7J2pxgV8dC1npZp8UKxvl4Dc
Message-ID: <CADvbK_c_xQL2RpOog7sA9QK7uRL=3gWEUtvCaxYaCoKHyT1XJg@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 8/8] sctp: Remove sctp_copy_sock() and sctp_copy_descendant().
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
> Now, sctp_accept() and sctp_do_peeloff() use sk_clone(), and
> we no longer need sctp_copy_sock() and sctp_copy_descendant().
>
> Let's remove them.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

