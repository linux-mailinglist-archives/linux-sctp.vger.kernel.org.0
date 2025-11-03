Return-Path: <linux-sctp+bounces-733-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB49BC2DE0C
	for <lists+linux-sctp@lfdr.de>; Mon, 03 Nov 2025 20:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F8914F6250
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Nov 2025 19:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D7742048;
	Mon,  3 Nov 2025 19:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqvN1Jp8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D74502A
	for <linux-sctp@vger.kernel.org>; Mon,  3 Nov 2025 19:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762197543; cv=none; b=JdkSOPnWuVP03yFUiQGcA13+J3u19YWPSZF9YYzuN/ixl84cYO8jWTaZvylFKNjPaLOha1IUUOD382cw+ZVVcCF7OubyQFjYWKtdWvY++GlyRpONmvx7dg4f+zdStjXQIFZANFRMgnpd+PjKHIYMsX9Z/G4nv8IHZrdJ1M7bP/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762197543; c=relaxed/simple;
	bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJV1FYk1QB5KE3DnMww585NrDVlYM3UQb/fKsTtBAii4TanGDDmVFzqu/uSFFpwOYD+4iLJTanZon9ey9UiO9TcUjE9jW4h5yJy37474wcMJopmy3FBwKWzAsavm+wyPaw0Z71wua6tT1CttP5DXPwQGjYHWmeg4DK/9pi/FbAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqvN1Jp8; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62e7221351so4585589a12.1
        for <linux-sctp@vger.kernel.org>; Mon, 03 Nov 2025 11:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762197541; x=1762802341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
        b=nqvN1Jp8S0D87zX1aiFPPz5J6yMMN6G3n97knd3SuRXhtI/NTH0NmhSQHJ7LztSZZn
         P2LnmryfdZ4Ap5h2ouZDudjIBJhIEOe7Ac7akOVh4wkucKjMowZVeS9wVLpb1wNOBuJj
         3pIbu39p6KYyTIeuWt6bHtTHZprEaeipSUDAVR1d0PKTlccqlqyn2v0sLT6HrOMAtYm1
         IMQX1E/7uuttmG2nnySdFphb1cusZXibepX/KiPq1wf+9nXa+ORZ6Q5zYlelV8aCTWco
         KKlH9ovHRtDHkBqljxCPlZgQGZK7WswkYO8zGL8lJ8SmXPFNo3xTORDXObLMBmOdsbXx
         fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762197541; x=1762802341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiPAPKa/5E7lZ3VkDFPFN/ouI2YUhm4970Gu5hWK3LI=;
        b=sq9DXyh+DAzTFOdbXyLNvZio/URHUGLEmX1YCjatkI6VG1ePOiBMPto4kMeN2CXPWQ
         AXSA0m6lMq1fJo3XdIlgokxqT8Dl+d338iSpehtvdHzSLtLALl97f78hzMzOB30pZ6S7
         Srp5rehBrE4pLLNpJUOz0x8d6EpBevGVfxRH+RzOu+WnTJ5SqRMAwPGPYtYktaBNlaDM
         FW0u87+6pe5mBprpYChLWqvCTvmk6ELznnywYbfO2R28QV212R309lFuotUmE6g8JllV
         jfp2OofJd011xobygulCpgr62Zb4OBcUTwOf8QMao8t70rV+EVRSsZ8q39CLoAOoT7mD
         KyoA==
X-Forwarded-Encrypted: i=1; AJvYcCXJsD1G2JcDj2L7b/BZycr8aEIKjY5QSzXHp77LrRxaNd7ol0T4A6JsWh/PKcarMNhSUOIFWrv8U3Pp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywle45+wIO9P7QyWtloO6z/LHFts5HQKTRmEp26WJADSRBFsRKv
	0l3RMkubVPBOD+0FR82GhUKJbzXhRVA5je0TS8oazAeVl/bzTWa2iWFCYflsLkdf7voiHcUfPNx
	9kLQ4QiNk5qqLzqd9U8nsUFdysznG2gg=
X-Gm-Gg: ASbGncvIva2TD8izooZlf4JnWqLGXuTYG1RXwIy6s53IJymCqkJuaoOM1kGV6r53Bv1
	mUpoGFb9sAYwCXo53vD1Pqg/P5tsAogJJHPuLd3GoIWDyxpMn4fVAW1SffmikMHaYYjHbn19Iu6
	ps7+FC+idGmmiqWwLkbD2eYtyeS2K5OCMqZd3rScnqcOHQsonFHU2t86imAp+4II02pDh0TORSU
	UM1q39KtPlbu3rkite9qE9fAjvKHNTqBR+HS3i2OcD9CzfBVfb4n+U218cF
X-Google-Smtp-Source: AGHT+IF0BSYD4ggbwG3GKDSXC0JY95fMZFQFVb8K4FHOBBwvNGu2REmpMK4jfQUnBSt+Oq262i2Kl3UblwRepxobDSg=
X-Received: by 2002:a17:902:ea0e:b0:295:c1:95f7 with SMTP id
 d9443c01a7336-2951a5271bbmr188667085ad.61.1762197540672; Mon, 03 Nov 2025
 11:19:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
In-Reply-To: <20251103023619.1025622-1-hehuiwen@kylinos.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 3 Nov 2025 14:18:48 -0500
X-Gm-Features: AWmQ_bmwicNW82tRVRkXxPbIo5gT61jNLe8lZ8bOYZiBYnm3rw60BaynqJTOX-U
Message-ID: <CADvbK_cp=heq2sg0J2hEa3p4soBFmjdqvY2otSLtCkF0aF2FKQ@mail.gmail.com>
Subject: Re: [PATCH v2] sctp: make sctp_transport_init() void
To: Huiwen He <hehuiwen@kylinos.cn>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 2, 2025 at 9:38=E2=80=AFPM Huiwen He <hehuiwen@kylinos.cn> wrot=
e:
>
> sctp_transport_init() is static and never returns NULL. It is only
> called by sctp_transport_new(), so change it to void and remove the
> redundant return value check.
>
> Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
> ---
> Changes in v2:
> - Remove the 'fail' label and its path as suggested by Xin Long.
> - Link to v1: https://lore.kernel.org/all/20251101163656.585550-1-hehuiwe=
n@kylinos.cn
>
Acked-by: Xin Long <lucien.xin@gmail.com>

