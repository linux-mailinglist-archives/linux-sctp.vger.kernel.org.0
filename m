Return-Path: <linux-sctp+bounces-7-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A160B844E85
	for <lists+linux-sctp@lfdr.de>; Thu,  1 Feb 2024 02:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564151F2C8B5
	for <lists+linux-sctp@lfdr.de>; Thu,  1 Feb 2024 01:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4032107;
	Thu,  1 Feb 2024 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgD7kbsa"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E383BB20;
	Thu,  1 Feb 2024 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749968; cv=none; b=p4UzOYPFV2AUksDn2l2lXtR9JKOHOxzHVKmpfkceeuqPMXvANCcflSy8fd4SpK9rsTKvJRfiwiuh2ps1+eg6y7ev+8M7K0fiPC1w8fi2xDHAGUDZlAeh4+M+I9rl/XQRtce9tiKobPBmslHaVjN38QxNdo6Gfnbolxf6SOphDeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749968; c=relaxed/simple;
	bh=K7m8gtHLg+fdcwXXrK8dXPdrMnYZvsrGEiWz2SbekN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oZMGtD8DjdzDCtIssrpx0bVLCDRnH0ahXc15SOcmGeZtHFTBnUKP3MpC94SX2F8URaC+Q33vzgykQEOg5Rl2pu/dIAeqdznS0npS2tzpIXNkREIYuRTHHgn5clQD5gC5t1UHQMqPPMcJft4o5kIdXRrVe3xBny6NNQUEwb2vhh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgD7kbsa; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3639124ef52so1596245ab.3;
        Wed, 31 Jan 2024 17:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706749965; x=1707354765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7m8gtHLg+fdcwXXrK8dXPdrMnYZvsrGEiWz2SbekN0=;
        b=hgD7kbsa0q4GHDEcWAZc3DpVyDBQvBTgrbIAiiu3wLM5SkUF+jk/G+AdqGVe1qX/6u
         Ws98wj4ttcuxlhBjPAiiglNv+INZ2eejVtpqvOrQGO+BnyWRvYR1Rh5vAHGwmQqjOOCa
         g3kWSY4ixMqbqfG6rG3FsZAYDAaA5EegmMH2FdqT5ki78FwuWKBxp9e1Z+AWES6S5U+4
         LK2k/Qyi5aLMoLgQycNDUR9A8swik1q7jHn8WgFNHe7tq04lxk0Ush8bhMCcyi+Ts45Q
         lcMQyInWea4XwMHO9bU/uJYejsfbMQLev5EkXqqdeuNhqmPe6ySLtU7DW83ag7XA7G7q
         qqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706749965; x=1707354765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7m8gtHLg+fdcwXXrK8dXPdrMnYZvsrGEiWz2SbekN0=;
        b=D1ADboZFXelb0Tbeiz+hRTNcgWW6K+HX2sp2Er1NYqZV2m28I3/98MXn3tmRT7Bhr+
         zsk1B6UKW2uY71bX3EXciRiYDF43QmZ3sV85RCuyJGzOsTd09Yj8RJr/w6bf/s4Dq3u/
         u8Zi1kmpLReHZ0PbFNJ0b4ClN1wwWkTaMw/a5Ogut5rXafgXNESdz9oeFZm8iB40apf8
         exg5kTiHBXo21ehT+G8/mUPw8WrT4QvTYzKswrabaMnlCY9giiKLhqsarkmAWGuuDuK5
         iTzA+toM0CXg++EJIzBMuRQ59n6dZs78QRSqgd4u9rli83ryY5dQ9PMrakh1sviY1ky3
         YkiA==
X-Gm-Message-State: AOJu0Yw7SSOLQkAzHB6XY5dW4KZJJByRbO8ZUQ+lKVmasxf6j2OhwsjS
	B3nSXOsUM3EO2vIxAWeHJNJ2Qk+eDbxoPMzSL4qfiJjqSIzlrAKvKPGKq/kPNXJbE63/VPkAtS9
	WQ/yVEZc6zWqp4Sp2tZN9dYQSqvw=
X-Google-Smtp-Source: AGHT+IEh0+jQ75LnEjqODofvT0NWp1gE8wEHS1esNqSY/7DD+N4jBt8M2Eb3cH395TwbO60rTYWKynysoJh3mylrNDw=
X-Received: by 2002:a92:d307:0:b0:363:920c:9bd7 with SMTP id
 x7-20020a92d307000000b00363920c9bd7mr3313192ila.9.1706749965596; Wed, 31 Jan
 2024 17:12:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131084549.142595-1-chentao@kylinos.cn>
In-Reply-To: <20240131084549.142595-1-chentao@kylinos.cn>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 31 Jan 2024 20:12:34 -0500
Message-ID: <CADvbK_ewbc2dnFLArRdj9APhMVUiBJg9GwvjxJ+2wdiK6Pp-tw@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: Simplify the allocation of slab caches
To: Kunwu Chan <chentao@kylinos.cn>
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:46=E2=80=AFAM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> introduces a new macro.
> Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> to simplify the creation of SLAB caches.
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Acked-by: Xin Long <lucien.xin@gmail.com>

