Return-Path: <linux-sctp+bounces-173-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4C9038E5
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Jun 2024 12:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72397286A5D
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Jun 2024 10:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448CA13665D;
	Tue, 11 Jun 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSEB6+5W"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3457407C
	for <linux-sctp@vger.kernel.org>; Tue, 11 Jun 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718101984; cv=none; b=EIutEU2iUnKFFnZjdHXsXB1H3WMaIMViW0boO2/Beyw9OD0e1D0d7kycrTWlEBfSq1iPVw2dygKlQiY0J0oRKI/ZCusx3cqkkXfgK9dxy7gRUdDdzUCbJowDkMtbIRzGi+3FGyogwSowNWs4kTe7fYmcY7SS4Ou28STf+k10QjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718101984; c=relaxed/simple;
	bh=b7iN8pvBAkCEKcNL+QNfJcQRwx1hNlmRrhDxczp/fUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OYc6PN6iekAZERZ064TQWAA1OE3iXllKGXLJPRdwf9OGkS1szp4vsVS/NrhIAokZudkKt9eCJrko3c5bPgEMgQdkLXiiZhrvd8qA8fKUe9176fWWSGimgEiGOxNILyBsjAALpKhMqWRCDYTP1ij1MUmQ017WhQqidTSbZq21OQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSEB6+5W; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6265d48ec3so87583466b.0
        for <linux-sctp@vger.kernel.org>; Tue, 11 Jun 2024 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718101980; x=1718706780; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b7iN8pvBAkCEKcNL+QNfJcQRwx1hNlmRrhDxczp/fUY=;
        b=CSEB6+5WyAAw62nMAhHzMeBWZhSc/rcviDxiQpglMNcj2ugiuP9CZARUcwuOIcI6Pc
         XfQOFMQ9MG0fiaSGKvFpP7fvpsaK1oRd4NmlYG2QjZMovJsMBaOk0xVks1vKoVapS/63
         wjuWcvZRfzmdnndu/7ofhMI0MaPFsn2Ax33zFUb/KBwfDK00w6UK2rGLpV+r0++kNmPq
         XGCmimOvfLqaibiRVCEgFZfsh1njO3N+1nr9xwOVtU7CoTMZMXkLRYGD5CwzGTcZEM/y
         1tyINTPGjjika3dPIN+tBhB9O7zOLUMbh+cErsdMwFGcw96l64n0JFMIJpJz3/XQ1bzM
         xn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718101980; x=1718706780;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b7iN8pvBAkCEKcNL+QNfJcQRwx1hNlmRrhDxczp/fUY=;
        b=eNA99DSsYmxkaruPsRDCi34c1eAELBTnDdS3kFse/yNBkwAyCxk9QSonxSkBspXDDG
         pggmgdJq2DCk/Lu2BRg7rsnv8zgqcewvhqlPFOQ6TTFUyOyXtfz7FWONon3D71sEaSC0
         TFQda+p8KGTKmAw3F+TBUP8xR+K1Kg0NkK92fYmw85sfLcSLTwCuWiHXCl6Nhdb+A6Og
         y2HVHUSxqAJjK6LfUdEKCmelvEWGiyraLES7RXAgpeldXO0MIkmQmFO2GefNFvvquWl2
         Bq/OPgTNWPlDbDskhRwbKOqKexYnQ/mF/RAkitXd69UM8rXEbFGv117KN0AYHQeuFU9G
         OwEw==
X-Gm-Message-State: AOJu0YwjuoUqcaw39CwtMysD62FNjMkxCL1L/TOpIcTxuEpAN5mNV5rP
	jxSQmAfN9pl+Iy9mmUJc1Bvg7ZIaj757HkESDBGqGFy0hFTJmYwjpPZSb3INc776z8zYAZfgj1E
	ankabpRbv/68eskW6AIwqTd2PvjajiaWx
X-Google-Smtp-Source: AGHT+IFQBmzAxN5C7pY2xxgEmX4WljSQ+wuBzxb18IiA256dG0oTZJFUuGKB56flrdYPBEB2IkspEDS+RSPT/ld0r8w=
X-Received: by 2002:a17:906:ae85:b0:a6e:f7ee:b1f5 with SMTP id
 a640c23a62f3a-a6ef7eeb3d0mr570574866b.52.1718101980295; Tue, 11 Jun 2024
 03:33:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHqUhqxNvxEQRuHs57QmVZwBw2tsH1qgOoxPqJMb0wNW6PxNAg@mail.gmail.com>
In-Reply-To: <CAHqUhqxNvxEQRuHs57QmVZwBw2tsH1qgOoxPqJMb0wNW6PxNAg@mail.gmail.com>
From: Igor Spiridonov <igor.sp.ser@gmail.com>
Date: Tue, 11 Jun 2024 13:32:49 +0300
Message-ID: <CAHqUhqwqfP1JA3wQfDWvPf95yDWa_9Xy0HvMnWnM=PuxceGopA@mail.gmail.com>
Subject: Re: sctp_recvmsg returns duplicate messages.
To: linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

There is a post with the same problem and there is no solution yet.
https://stackoverflow.com/questions/78158391/duplicated-packets-received-in-unix-network-programming-about-sctp
Maybe is it a new bug?

On Wed, 5 Jun 2024 at 08:02, Igor Spiridonov <igor.sp.ser@gmail.com> wrote:
>
> Hi,
> I have a sctp client and an echo server that use one to many mode.
> The client sends some amount of messages with different stream ids.
> After that it reads them back from the server with sctp_recvmsg.
> The server reads one message at a time and sends it back with the same
> stream id.
> When I test this on a local host then everything works perfectly - all
> messages are sent, read and the assoc id is the same every time.
>
> If I have the client and the server on different hosts then there are
> the following problems.
> sctp_recvmsg sometimes returns the same message twice - these messages
> have the same assoc id, stream i, ssn. Looks like it can happen only
> with the first received message. MSG_EOR is true every time.
> Tcpdump doesn't show any duplicates.
> The second problem is that assoc id changes very often if i send
> messages with just a couple seconds delay. I think the same hosts
> should have the same assoc id more or less.
> Both hosts have linux kernel 6.5.0-35.
>
> Igor.

