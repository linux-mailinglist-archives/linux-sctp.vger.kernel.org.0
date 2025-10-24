Return-Path: <linux-sctp+bounces-699-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 816C2C06CEC
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 16:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68B8450802C
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59B324469B;
	Fri, 24 Oct 2025 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+tcbuFD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FB1221FC7
	for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761317588; cv=none; b=h5s7jlpejU2h8kz9qa+pw1COmO+eK7xg+ZhDPca+FH6NUe4Prn0U5kBrXX4nvlzUTltMPUiT2Z2OjpP5hic1Q3TkUktNao0130ILIwtRRPjJ7Y+qZ5G53m/ofQp0prpPHc8Th6j7rnmr1TIdoKwiwNGQx36lrK4SXIVEK897rjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761317588; c=relaxed/simple;
	bh=ZFJT/zFPdpxf7CnReiXfSJOOmCkZto6mtirRzazsPg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dBNGoy4pa8i+SevQlKB4Psv6uL0TRiE9nMxxHe8U3KqXQdDHBTUVobtYWtfA9Z+SDB00/jurTMRpEkv4He/FoLfhMX+6qvJk2D5d4qn6tBFwt2aHTFRsrVmm4cKQ59Y8u3dg/i5kmDYABYwh1MokpNl0AIJPoG3OeA1mzmi8UsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+tcbuFD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b67684e2904so1584098a12.2
        for <linux-sctp@vger.kernel.org>; Fri, 24 Oct 2025 07:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761317586; x=1761922386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFJT/zFPdpxf7CnReiXfSJOOmCkZto6mtirRzazsPg4=;
        b=S+tcbuFDSVBpFntYZyqL+S0oVpGmi5pKD0wy1imNmmOwJ3A3P1LZL87pY5PcMKcZ4t
         V6UNq/Yrcmqgns0quk4kmwX1O0AVkE5XoNFk+v0wdLzNGtaX62HKpc7Zz+LImfYaDG2A
         NUgPLuCAtacY6p6NuHhBKxJGlYN0g5HFzzeETbzxr06vFXXUy93MwbiqZfU5uMyeQYnJ
         L54zRq+8m58HjhJ0wwpGBeC7Xis4OdrNP1gZUS3FAJ3Gj2uWCL688204UV002CvCrhiq
         6UIhtzzjMv7PAzwKLOeOksyJ5+6CdCo2Tz35UoUPwKwhhYWP3kRLxaDW+TxhgwXr8WTI
         Euog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761317586; x=1761922386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFJT/zFPdpxf7CnReiXfSJOOmCkZto6mtirRzazsPg4=;
        b=jFJzhPdNhDDA9yOxvZ6YiHLFLWX8ngq+wwa3aqDTQYrdgt+1VV+5ATUKY9N5PSeLWU
         Vsm7C8zmv9u454uUkEqnQb3EQtHgy+bKQ4Q6hmnUouzbaCfWd7TaK6sc/pB+87JllAk2
         ReqKhFm5dCLgQ86z+8/9FkQ+ptSGPHf9DzTuwHmFGV0lZYGlgNZ6rqgzx2RLD7Y5g3M6
         pHGM0dnWanwua/Exjpk79LqNHz7XqYZN+YuBdfPK6D90o0DL1IDjjrf0pYmDokOfKFc+
         CE80YUqLn2cuN2qQMhnmqzYH1j2uOI4bkui3AfumpXKZxnZorJnDfngnwME6htM7JgcB
         q7Jw==
X-Forwarded-Encrypted: i=1; AJvYcCV0uh2L9Bv5hhKJM0qEBpOvtnzxmdMtKQXOkMKsyLf+xp5odlZ1i/9Yn/yL96MHrSzgi4taripH0zof@vger.kernel.org
X-Gm-Message-State: AOJu0YxMl9f7vxSMHirsTtN64dLsYWzjseAjLUR8EnOH32bbLBwfvDhI
	Y8cMYkqVufBz4WSJ/htnyEeuHrHTBHinkEuMLRRds5Umcjngr00zsuEv/1F6Dq74SkXBJK05p7R
	9556hsJDjZcmr3J7oEGLu2JL+TuGAxhg=
X-Gm-Gg: ASbGnctxhjwVR0JzlczLzntPANAd/dDUoen7smA0YQuhX52hlqdBue4SB6mmD7xXgHX
	xgCwZ8WRw23SYrfIS9KWBHGTt/deVu6iQs270pcoI64kYNqUABr5a8Lm6QqQyH85JqvVjmOHQoi
	AYhzEnUh6JijVYkbvEiHJEyXQsiGohYrJjVZrqDU94HZPNrbOuNzBhYaf2Wdk7ply3z4dQCCiYX
	85nUAiKjprf+Xk1MryvfG03QeDjiayDRIzIuuOMKg7ivDJmlL0FfHjoB1CjeGuYC+OAallCAQ==
X-Google-Smtp-Source: AGHT+IHJu8O2kjhyLPfikBasPetUHNar6epUzHrvKPxKuGCDo4EUGGFOt19Ons35bgDupeLU4i6u3rw6hlF9yTXLiAI=
X-Received: by 2002:a17:903:41c9:b0:290:aa7c:dfd3 with SMTP id
 d9443c01a7336-2948ba3c614mr35092075ad.45.1761317585236; Fri, 24 Oct 2025
 07:53:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com> <20251023231751.4168390-7-kuniyu@google.com>
In-Reply-To: <20251023231751.4168390-7-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 24 Oct 2025 10:52:52 -0400
X-Gm-Features: AWmQ_bnUt74r2DpBDPcwbfrgZgj1UTa6pX6nrtDykJYu7O3TQTJivrt-cF7MS1s
Message-ID: <CADvbK_eTxa5usoP_xh1mfrCVxrEyiLzgwPNeUe06uFmQyxmTDQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 6/8] sctp: Remove sctp_pf.create_accept_sk().
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
> sctp_v[46]_create_accept_sk() are no longer used.
>
> Let's remove sctp_pf.create_accept_sk().
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Xin Long <lucien.xin@gmail.com>

