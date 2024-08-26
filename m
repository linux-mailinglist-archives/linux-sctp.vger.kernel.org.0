Return-Path: <linux-sctp+bounces-218-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4788D95F50B
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8141C20D49
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40118FC85;
	Mon, 26 Aug 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS51vG/W"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF6017B51C;
	Mon, 26 Aug 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686142; cv=none; b=FAgic3eSUKD73RLtkfuG9Vh63ePRGpBtFx75yIRkXWzuWHmZe6UXawS3REGZ+x0fuCd7NwE5imXTS8qmdhwN0YwY7safvxldaiGOK0xMTt7PBYPpMNvU+UW2BTr7dmfhuTN2ti5zpzef4zdRZR95bG12V35h6/zZH7DuyxPaDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686142; c=relaxed/simple;
	bh=Db9M8pHcif2iZSyJS5LWO4EnKkBJ13mQE6dsAebprkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PB//IpoP4PWnLHhl0sFb51HnEixv5w8oRUVhpPiNC1548rwx/SbTVo+vMlOq3mDwgizlnGtWzCadwxxo098vv1iLDODoYPRGqcw5y+puhfRlC2hVtHnifv+8xJv9bzqWZNYWUpY4chR/e/LrG7inLNUBiJ9NWFDCd3+CBFbEy0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS51vG/W; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-824ee14f7bfso170050539f.1;
        Mon, 26 Aug 2024 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724686139; x=1725290939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHip6bX20yVmNEISfUGqBe8fWDCd+Plq/nxFo7CBhWA=;
        b=gS51vG/W/qchSJy4VJ2jW3KaeZyJyn4tPhXHLKMR3MNooY+mfzuEwAMME8XVpHqdHr
         kJXkL8c4TGHPrR1V0fc0a6GxbSLP9F6wLrhT32qtgXbjem9cW4tjKtRkZRyz/cAw7eVi
         Rr4/GGjsp8YKgWajtuaEq3A+k8vqU7e99qGJdqzUyY1NMXCYksy64nuHti6XdG/nJSAV
         ZAM+wTY8LylVEJKyKbNs/LftpHB7lCn4quLYWHM5SZ4yWdsud8Eo93GHWdzMTKO0Hbab
         FpOuNIYZNnZEzIT38/nnsQUSz1vqNW7S2NoEUYC7MdsUjHTCmE75ZXeZQI5Ql9nxcQNJ
         lxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724686139; x=1725290939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHip6bX20yVmNEISfUGqBe8fWDCd+Plq/nxFo7CBhWA=;
        b=MGTzGgpsctgF25TLwqBJI36lIgsBIAyTZQG2Ww1MNoNuQpOInvJHZr9WwmyFadcWE/
         9nVaZVx/eakVRRqDpLrgmLJlGa0HTayu/PfW/sX2BjruefnEi1lWJvPH0ZJsgCZNoeXv
         WQr5AuYgoA7fmAlmik6UCmwtbamMYFOm3G/6UBhtIkjyv4tbL4iSjwccLYj3UohvbSFE
         jFkBqBQaCyJvrMTzAAeWJSdt4ECoIzsaYzvNXK/vO4VAIazDneerciLNfJzH/aVGxQY9
         OQL8vFDNJYDVgW8SxREC4uUkfFGr418Qk03B6uOAJfHWZKmi/xlNiuNmG0bUhKZc0h1D
         Skug==
X-Forwarded-Encrypted: i=1; AJvYcCUiou9Zs8SOag285RQChkjg6e/X3/JBMavWXMdkluF2qvdf9Le6KkTBJ3NF5ojoU46AP5pNpYMiSaw70Q==@vger.kernel.org, AJvYcCUmRXdSHk5glKwcqGWzYxql/Uir3eNSIqSBic+VuPNxWjCgglKc3TZvkpBBcv5+SGaJ35z1n5p6uA==@vger.kernel.org, AJvYcCVKTNB8XuFt96BvzMT6Z3ntrwpqb7C1aMn86t4bwxhK2MwuC+9pVDwz01qHGEUPehI23G2HeMZ4xr6POER8kF4majX6NDpa@vger.kernel.org, AJvYcCVLUN9oNNnr5785T0NqQhvSIXsBqDfQ78dbzsRL4kRKjXktPxvdsspGmEn3W+LzTK+WhuLqEUNrfaoUpiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZmpjEXwUf26R8mIld+1cv6AapstnWZjBJ5xUhkjExDTBZ1/XU
	3msUnDW62FjYKNPdeJY/WBINT1M8mbOaEAQyEg/gJBx+9nCtVvEpIYNR5RgCXNCjNAG8WA+02vs
	21uuZU8pg9cOnI1y6BIo7eDKEQ6U=
X-Google-Smtp-Source: AGHT+IGwKg+o6Rqr71Zd/HjBAsN+oF21sPFhuAJJlbur0FwudipAWhG6CUWz9M6Jo9DnXhoVvqlu7T8AVHRhkwwNpfQ=
X-Received: by 2002:a05:6e02:1fc6:b0:375:ab6a:f701 with SMTP id
 e9e14a558f8ab-39e3c9757eamr126619065ab.5.1724686139465; Mon, 26 Aug 2024
 08:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826130711.141271-1-omosnace@redhat.com>
In-Reply-To: <20240826130711.141271-1-omosnace@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 26 Aug 2024 11:28:48 -0400
Message-ID: <CADvbK_enZcjb8KWZQZYScGLsnYHs6a-9ez2YAb2guta3Tnuk=w@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix association labeling in the duplicate
 COOKIE-ECHO case
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	Vlad Yasevich <vyasevich@gmail.com>, Neil Horman <nhorman@tuxdriver.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, linux-sctp@vger.kernel.org, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 9:07=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> sctp_sf_do_5_2_4_dupcook() currently calls security_sctp_assoc_request()
> on new_asoc, but as it turns out, this association is always discarded
> and the LSM labels never get into the final association (asoc).
>
> This can be reproduced by having two SCTP endpoints try to initiate an
> association with each other at approximately the same time and then peel
> off the association into a new socket, which exposes the unitialized
> labels and triggers SELinux denials.
>
> Fix it by calling security_sctp_assoc_request() on asoc instead of
> new_asoc. Xin Long also suggested limit calling the hook only to cases
> A, B, and D, since in cases C and E the COOKIE ECHO chunk is discarded
> and the association doesn't enter the ESTABLISHED state, so rectify that
> as well.
>
> One related caveat with SELinux and peer labeling: When an SCTP
> connection is set up simultaneously in this way, we will end up with an
> association that is initialized with security_sctp_assoc_request() on
> both sides, so the MLS component of the security context of the
> association will get swapped between the peers, instead of just one side
> setting it to the other's MLS component. However, at that point
> security_sctp_assoc_request() had already been called on both sides in
> sctp_sf_do_unexpected_init() (on a temporary association) and thus if
> the exchange didn't fail before due to MLS, it won't fail now either
> (most likely both endpoints have the same MLS range).
>
> Tested by:
>  - reproducer from https://src.fedoraproject.org/tests/selinux/pull-reque=
st/530
>  - selinux-testsuite (https://github.com/SELinuxProject/selinux-testsuite=
/)
>  - sctp-tests (https://github.com/sctp/sctp-tests) - no tests failed
>    that wouldn't fail also without the patch applied
>
> Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_=
sk_clone")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

