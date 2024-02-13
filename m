Return-Path: <linux-sctp+bounces-27-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F87853477
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Feb 2024 16:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE24B28336E
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Feb 2024 15:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB3A5B672;
	Tue, 13 Feb 2024 15:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7f7Zect"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F3C55C39;
	Tue, 13 Feb 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837726; cv=none; b=MhMhXUjaChisPgga9n17lQ1U24ibZzqFGGTWLmTSOhZTpm3jbhmVXMLupJW/1S6XrCm09NsmXXqmvOO66NkvloXcLL/6XvPcF7f2bMtiZKKRQYCcWcpeNJZ589p/9Iwm3BTrmFOUfSaFFO9fvWFHalGZcYlzTLCVhq8deDTAepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837726; c=relaxed/simple;
	bh=jWsNDx5Xjeco7N2CGZwG8xmgdAQag1baQkmVbQTSwmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMeSV1Td9N6wS5kGZLKoRSfvpyW1eXDOtc1zn0cAoGdw7lPi2MzDXPjuGYPz0znt5SWMS1oZO1oh9sUHjer7w4UobDG23cMngIlAGanADYd8w4jphSn3w7yYvVJ9SL1f21I77DeE/e4OQ+EeGPN45nR+COH9uowm0It03yL5cxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7f7Zect; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36426a010fdso411485ab.0;
        Tue, 13 Feb 2024 07:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707837724; x=1708442524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWsNDx5Xjeco7N2CGZwG8xmgdAQag1baQkmVbQTSwmo=;
        b=E7f7Zect+96EE4w1rdcIOPBrgs3/kHFgKWoh6ldPkCkjV1jtUDRiktzKOlJuLQ79pD
         JtezDx/pxVV63P+bLNTI2UDWI8YFd5yiF7EA4H7NDgEHFpO2E6xBuEYz2nh08jcRnCHo
         zuej4MOyxueP7htZOATC2PMI40Z2kB9HxZoWrEWI/R+uXWMLcPDIG0ePmjhuFz0HvWYN
         o+DbfmRCuu9fOZjbN7abnLkEAHeakBvgaOKbWK5l3wc+tSuDWL5VDGdZlr8QtnNwDwLb
         ZTZYyhuFQAJ1hRDbqoguWmlIvwQ4bd70IN97RBMEcy+N31XWPaLz782yZMPUP85yozPL
         njDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837724; x=1708442524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWsNDx5Xjeco7N2CGZwG8xmgdAQag1baQkmVbQTSwmo=;
        b=NJbvIJTJaFAh8Kaq0XmF3jBxIKzJnmMMngH9SMijzmQ9nC94CMkjEmVld019BYURRt
         mpEaCCuYZmomrChRXGwY0ALoDN470ZjIe8GV0RfUryi6GcNItQ3dDNrrHI5XTGa0eflk
         mxV/TzUE+48v97IdGRqolguxyNJIboSJSXkHuQQ161TNmBpXJCxH/Q5h4ToW54a1vHwg
         NoGgFyhQ3gWFwgyL5DN3bSVQqAXsbqPirj61wQJu7c2u6YVyT5DIgshzh6U2AMZFWwf2
         wuh6/9eZKxPqWYLbXT6FfISKs94kt9URNGuZ+x6EeCDsJocxIG+wNU9lMpv//VYVkpD8
         RZzw==
X-Forwarded-Encrypted: i=1; AJvYcCW9EvK6pGD3uXDTbZIzNiSTYDyGaAzkDGfmcGT9D/RdV6xVFNzlykzSQFqxp1o5rSQuEWVsb7w8ZudiTSgs1dAshcRtZoI6fotzAHnYn7GECm3JOWnRa1Kf6XP/pxQLt3ldvQ==
X-Gm-Message-State: AOJu0YwWQF1rkNCNka1E9S5qzls2swqgOQFIJOguyMUzFthoswSJCfmU
	EtBRqL7u56Cf0A5SSYJgBj3R95c2mabMevvsU54gZDEEs/2HWBQab9LOSe4TN1KmZcv5tf2O8JF
	Jriwm3206PnTBWyhPkYgGCbuRrSQCC0bBwcs=
X-Google-Smtp-Source: AGHT+IGfFYMoaD/H4WarN8ae84BKmXqWUj/hA0cv1+bMCPqaFkIeSNUZMFRdeXffP++iYizjVJ3KgZGFc33/cq0JHf0=
X-Received: by 2002:a92:b745:0:b0:363:d9eb:c2de with SMTP id
 c5-20020a92b745000000b00363d9ebc2demr11421103ilm.6.1707837724212; Tue, 13 Feb
 2024 07:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209134703.63a9167b@kernel.org> <20240212082202.17927-1-dmantipov@yandex.ru>
 <20240212162515.2d7031db@kernel.org>
In-Reply-To: <20240212162515.2d7031db@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 13 Feb 2024 10:21:53 -0500
Message-ID: <CADvbK_cjg7kd7uFWxPBpwMAxwsuCki791zQ7D01y+vk0R5wTSQ@mail.gmail.com>
Subject: Re: [PATCH] [v2] net: sctp: fix skb leak in sctp_inq_free()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dmitry Antipov <dmantipov@yandex.ru>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, lvc-project@linuxtesting.org, 
	syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 7:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 12 Feb 2024 11:22:02 +0300 Dmitry Antipov wrote:
> > In case of GSO, 'chunk->skb' pointer may point to an entry from
> > fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
> > random fraglist entry (and so undefined behavior and/or memory
> > leak), introduce 'sctp_chunk_release()' helper to ensure that
> > 'chunk->skb' is set to 'chunk->head_skb' (i.e. fraglist head)
> > before calling 'sctp_chunk_free()', and use the aforementioned
> > helper in 'sctp_inq_pop()' as well.
>
> Please repost this as a separate thread, per:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resen=
ding-after-review
and instead of sctp_chunk_release(), please use a better name like
"sctp_inq_chunk_free()" when you repost.

Thanks.

> Xin Long is probably out for New Year celebrations, anyway.
> --
> pw-bot: cr

