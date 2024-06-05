Return-Path: <linux-sctp+bounces-169-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDA08FC2DF
	for <lists+linux-sctp@lfdr.de>; Wed,  5 Jun 2024 07:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D26628526B
	for <lists+linux-sctp@lfdr.de>; Wed,  5 Jun 2024 05:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6235761FCC;
	Wed,  5 Jun 2024 05:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGnYuhlx"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF7F139D1A
	for <linux-sctp@vger.kernel.org>; Wed,  5 Jun 2024 05:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717563787; cv=none; b=L3BvISrsx3g2rYCR3VcaGx2u+IMOeOppQxLRaHblqRAtAO7xEJ/nc/jUHXUgLgUeYoX0Jt2GcpWIQdRiJk4839Qyoq2JZZR1FJan/AKxb1APlKePttmGRsiWa2xXyavLubeqROlkFXhUxzPqwoImj3ZgDh9BqOz8TMTN6dtEe+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717563787; c=relaxed/simple;
	bh=PUGUmIGpnOH3NVb2L6MdhOLJh3gKxu6+Vnpemvv6vks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TZDRXSCQwHUdKF3s0tAyCJoxDOl3D4lU5Tro/dF5Jqq/pT8VaFvHua+BPyGseCpMx0civqoLS9sZCotOPXz81pRc88Rp6RS4VR+y77J5L3liLC1sTIVdbquRmQt9qhZu0+l2cXawI4UeuqpkSroXdBBRfDj0FFk/l5O7E32JmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VGnYuhlx; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-80aae72df40so1413594241.0
        for <linux-sctp@vger.kernel.org>; Tue, 04 Jun 2024 22:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717563784; x=1718168584; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PUGUmIGpnOH3NVb2L6MdhOLJh3gKxu6+Vnpemvv6vks=;
        b=VGnYuhlxnM94bsQDYRlBRrcimntQza6XS0/DjzKIhTkSBTeiBpubYUpqpMMRwLJLQh
         eIj47H7iDYdZ7GbnsMixaoQk9++ssdRloYNmuGx0PGXfAAlQ9/HcGtyPz+SwzCTJPGYD
         ic5ANrjQwFbTEJ8ITTaRSzGWWvbkZzoiJjzhe48jjFsQ9e4VRP6VFKXgwNMKAYDGnVmz
         tKyrw/fquNC9EgpyYID35CYJCC4yYVeCGMCzopMRXpSTeTcYq0O8b+1EhE1c6lzfunQ3
         zkQnGl1ZrQAVDAx5oEw74hkE6P1bZ5n5TE9LYkjJRnsmZo4bFAY4GcnTQnt8NhL84zBf
         /rcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717563784; x=1718168584;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUGUmIGpnOH3NVb2L6MdhOLJh3gKxu6+Vnpemvv6vks=;
        b=W9Y+rHtiHv1p1vwKo6r3M88mKG6UrunlXi0RxgFEKrw49ZI53wIsi7cRwTqBbADNKk
         /2PunZqpN8N0BU1WYz3SWGF7yjDp56AwN7g8Y+A1qjqrvJINMKSfRh+X2a+Y2qKu/DvM
         QXQDWY2isMyTkLljIAU7TE8yrFktTiH0KHJBQqDGED2rV1TFI48cVAzg0BuzwxdV9c4s
         NK+O5zniZ9ifhp3nTOUuYar2DTNuavyxM58rXre0apZZ/OuKhJ3/UOllk9+oLid5q14k
         cQ67izDF1Dypt+77WGHMRYTE9M/0koZ9V0oFm+hqKKCcYVfbnmEm4fTMjaAdSiqmgmRl
         qbIA==
X-Gm-Message-State: AOJu0YwQvfTSyJbuirprSXx61cnQ2fmdoS0TgvwBUoIcnWBB4ctzjuo9
	qAGbGspO4s1g9iMMpJFhMmbCLPCQG2rXgaWVvY1zt8m5leVEheO2172t2MTCOg0/xIP4f/mD+7O
	B0E6cjVGvEFY2HEypo/Di7EAVRD8JnQIQ
X-Google-Smtp-Source: AGHT+IEFP8z2wCKxiY67MnJ1xpZwWPrZn/DiWwR4HrPY5/9Lbb+S62iwcye2qotT6f0aCl6XQNxA0FDx8n/g50j5Xj8=
X-Received: by 2002:a67:f70a:0:b0:48a:3355:bd32 with SMTP id
 ada2fe7eead31-48c048bd266mr1585323137.16.1717563784613; Tue, 04 Jun 2024
 22:03:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Igor Spiridonov <igor.sp.ser@gmail.com>
Date: Wed, 5 Jun 2024 08:02:54 +0300
Message-ID: <CAHqUhqxNvxEQRuHs57QmVZwBw2tsH1qgOoxPqJMb0wNW6PxNAg@mail.gmail.com>
Subject: sctp_recvmsg returns duplicate messages.
To: linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,
I have a sctp client and an echo server that use one to many mode.
The client sends some amount of messages with different stream ids.
After that it reads them back from the server with sctp_recvmsg.
The server reads one message at a time and sends it back with the same
stream id.
When I test this on a local host then everything works perfectly - all
messages are sent, read and the assoc id is the same every time.

If I have the client and the server on different hosts then there are
the following problems.
sctp_recvmsg sometimes returns the same message twice - these messages
have the same assoc id, stream i, ssn. Looks like it can happen only
with the first received message. MSG_EOR is true every time.
Tcpdump doesn't show any duplicates.
The second problem is that assoc id changes very often if i send
messages with just a couple seconds delay. I think the same hosts
should have the same assoc id more or less.
Both hosts have linux kernel 6.5.0-35.

Igor.

