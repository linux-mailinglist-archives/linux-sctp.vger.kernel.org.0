Return-Path: <linux-sctp+bounces-489-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B292AA7469
	for <lists+linux-sctp@lfdr.de>; Fri,  2 May 2025 16:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FB804605A1
	for <lists+linux-sctp@lfdr.de>; Fri,  2 May 2025 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315CF2566F9;
	Fri,  2 May 2025 14:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="haydd9qO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B59715A848;
	Fri,  2 May 2025 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746194610; cv=none; b=GE9w25spzNfNLPyvvBAvVbiTn0ugZUAySBlP2t0ORrOzbMYQxYsA0jyEc0FI2QWau6rllugklS2QgPGKCnU/EzDnjDDDOD2K2KUEi+BX+6gPCejjQ9fABU9zOC+m7iLB1yAhd8JObaNHlAdGdS1vME87cA5MnMe/iOGLFX/MD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746194610; c=relaxed/simple;
	bh=J+7geM7OZeKeiKu7DrbSaOOB1gEHpjlKe0G+M+0X+9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpvafBNesNCbIpZcufoVtn2s7DUXZMAS7gZwgfyFC/k/K5bzvledjhggHqeowPLhVntqjDRYSkV+EHwL8JC5ZnoKjNgoSst71+fUmNK8BDBtBCmK67CK/Mrh4gp5jeYonoMO9XZsv775j5my0DPlUD1JTKaFfBlfuR9xAMfPtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=haydd9qO; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86142446f3fso56569039f.2;
        Fri, 02 May 2025 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746194607; x=1746799407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J+7geM7OZeKeiKu7DrbSaOOB1gEHpjlKe0G+M+0X+9s=;
        b=haydd9qOjcy+TCAGJ07cUB9hO1pRfwYkFAohAuyfoidir7QPVcBdXphPMVILACpzhp
         TfiKyst2EVRTxDX8KN0cGvso86vDHgk6TLg8G5XSQotxtWf/46tBe5YRXi/inbqW919P
         HBEhWcHUKgqPmtRzOhSDZNdKid1CdPJdnm/1y7pb85hyb791yukBf2mJmwpoGOvzWHuQ
         TS2EV6Au7twA0DRQmpPzKTVeOfCyLNHiVsbbm2cK1QxV+RIfFZXznDtw1P8akl1QlgXW
         di/s/jE5g3crfAtTURwuOjZanNeoarxNtbcnN4jLTqbiZQvq+lLx+ENUaJU8pInAch43
         N8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746194607; x=1746799407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+7geM7OZeKeiKu7DrbSaOOB1gEHpjlKe0G+M+0X+9s=;
        b=kDXsvetfsRk77gzTpR78feg3cpAt1xIYjpO+nexwaMnRQFsanGQdOs+k1Q9FJARsdR
         hZIvuiTcGVA4T6Q57xR3Q548I85XlB+GvyKJ/t/f/a2GogXI+0yxaCK4JhqpxV+DBq91
         eAYE+EMwZ21g0r6YnQme8A3uMDob3hK6/kljrks5dazdBRxQh9qmlOj8TDK/FyCh6Uol
         JfH9TKuaIeKuVOjvsoS7HIbNJetzdySrJi2LoxXyB3oKuyYY9IR8QDEsw3HArAR1B+Su
         RNtJN8bacGm1Gf7q2X6KanFDE9piM+UI3LIDNycsl+cjFlvndjAuZ+9r+ebsSkLIypqi
         HU/w==
X-Forwarded-Encrypted: i=1; AJvYcCU+tmWb7JkngdTjB5SYvXBLE2wWr8EVJjCpssBCr+7UemKgvrVXwnUqwpVF/XpoMNWA6Dn9mApazCGUPg==@vger.kernel.org, AJvYcCVDdrHAr5Veae2U/wuRQWniV/IfZpSPJHQeYFHrWapVnVpHGr4sN0F5K9HqW5WIdhfORYU/pACZ@vger.kernel.org, AJvYcCX1ej01WwTBz9ZQj+UHdTQtOCU/4n+8uAcZCixmXVYdOBXUw5bthdXc2PJCmrsPYg6NihpyH6qD0evSRhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfMv9Yp3orcdzWZi27Q3lMC6/U9GImpWH7z+/LAu9vRbmeVO0r
	mSr1SF43eVfRmqeUO4rC3K6Ii80Te6T9LUM8KoRKpk2l/OvvJVXz6LCJl6q3DobeLaYVx7Au2n5
	4BcW/pN6LUVsaffYZNBsecxvWxto=
X-Gm-Gg: ASbGncsoYVQ2AAVipULXdMrYg1JJir0JV/iD98WYppfdNWpl/acT2GaO2WnM2n7kNSn
	YmOwwlPi7ybI703fsxcKu2MKM8zr/2Ap3cJMNY/VLPMzZkC4tCW7t6pn9DBRSBoxA3TDCdbZKTb
	6nWqL9mHUoUYBo9x0v2Hr9qDVS
X-Google-Smtp-Source: AGHT+IFVMPHJnDUUhpcX6XdaH3vpAJdu4LZJ3R/lCZPqoGS/As/H35451bCbpG2KagVgYq59AX3bEM91sCVs9m/uN8c=
X-Received: by 2002:a05:6e02:1a85:b0:3d5:81aa:4d0a with SMTP id
 e9e14a558f8ab-3d97c1705e6mr27499175ab.6.1746194607586; Fri, 02 May 2025
 07:03:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501233815.99832-1-linux@treblig.org>
In-Reply-To: <20250501233815.99832-1-linux@treblig.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 2 May 2025 10:03:16 -0400
X-Gm-Features: ATxdqUEFoCwjFw_FYE4QvhoWvdBIQ-fsPbqAykyXkm7nY1SDSa33tNg5JiOzku4
Message-ID: <CADvbK_cJpug6TfH8=2uEM1Mwr9hhL5vJ5merYEjuDyA-Y1fRPQ@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: Remove unused sctp_assoc_del_peer and sctp_chunk_iif
To: linux@treblig.org
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 1, 2025 at 7:38=E2=80=AFPM <linux@treblig.org> wrote:
>
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> sctp_assoc_del_peer() last use was removed in 2015 by
> commit 73e6742027f5 ("sctp: Do not try to search for the transport twice"=
)
> which now uses rm_peer instead of del_peer.
>
> sctp_chunk_iif() last use was removed in 2016 by
> commit 1f45f78f8e51 ("sctp: allow GSO frags to access the chunk too")
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Acked-by: Xin Long <lucien.xin@gmail.com>

