Return-Path: <linux-sctp+bounces-729-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D007C26BDF
	for <lists+linux-sctp@lfdr.de>; Fri, 31 Oct 2025 20:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D1F1A6094B
	for <lists+linux-sctp@lfdr.de>; Fri, 31 Oct 2025 19:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3269E28BAAC;
	Fri, 31 Oct 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m8hVTjqu"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B359348860
	for <linux-sctp@vger.kernel.org>; Fri, 31 Oct 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761938906; cv=none; b=osxe20+zQuhKakyEFTPMaMPO51m9rdfU6eYx7oHEnss0/AEMrP8vCd0QjEuKRM1czF8rq422YYznlIObcKG2UEEWB3mHZDiF5WA5NVZGr6ObM12pyjr3bSM2f/1Gu5xPNLWVaFy0+/+mMRmX3RdkGmy65xxX0nYA3gjriJiJJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761938906; c=relaxed/simple;
	bh=mUJznE05kUPl0IhO/e5znFzRpuOXnTth9Kcu9imUesY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iqY0bqxv1mEqyOLGsu6FbjKD+qvmY9HWcXbaF3RccKzDfps28eKdZ50TKA9Ej3D7QM11lEkAREn57NXaFchbtNHFmZSptrq9+bBkyfIUZmaBQJUT9P2vVOexwKw3fFP2sR7Urwp38swQIDPlFQnkiQt6dcyotIHFzmaVCGqDChs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m8hVTjqu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7a2738daea2so2683249b3a.0
        for <linux-sctp@vger.kernel.org>; Fri, 31 Oct 2025 12:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761938904; x=1762543704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDwjr1ZOLq8cLo3fTSn/h/+rtzM3FDrXyupCisosREA=;
        b=m8hVTjqudFney8nxFZYvBqMxQKej6AwYCS2apItgNKy/k2kVj9wcesr9yTwmpqGdA9
         P69WApwnDpcMgqsBjOu0PbAq46ewJZVHWJDNCeJovvs3G27dHe7c/bLwmcGQ/GY4kidH
         6LMFhz4ALpX2oKhPzimcDzeet5llptAyJskMEgA7guUigV5W7ltoCI0x4jiY0uBnM8+Q
         qMAQ+BAqy1Mg3N+v76c/LNDFD0CcKRb/8AOf6JtPdO6aWNVNLntc97P5SceH3WXhK6gO
         mbgbF2ndxALECRsLY9IWJolTZyvphF0xXx5GZ8qmcJH6/impAvfmdCqHN8WVu9wzyL/e
         LbXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761938904; x=1762543704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDwjr1ZOLq8cLo3fTSn/h/+rtzM3FDrXyupCisosREA=;
        b=CZSG65tqrUQ0/4uyMTZkcLIqJ5FZClla0T68VTXvtbSDC0EM+qzujITZVbjftMrRok
         CLi67cTAo7s7JB5mO01FX/Wb5UedmEnnrdG3eg+Mn83YolfMRG2w6sHqp6+zKq12IJCi
         rKy5+qDdGglyihrkAOynQBE7CdzFv9tmcZAVlS/ITCd/Mm4Z7KibJkhQerorl/o9vN+8
         eZ1HMqj5ruBUzdVVguVmGwAl1qrwORGRZS2wL+Q43HZiwnYnlZVgtFto2Rgxbp7cFqNn
         A0ec7Wh5Q8jr0uFGZnYVXK9Eqv+EYQpXId2NV2Lf0B7zqhR7XUEtrLh3b68TGgf0+mZj
         H2dQ==
X-Forwarded-Encrypted: i=1; AJvYcCWchyvndQy9RxBktykDZ6t7Y7VWZfUlKe9ai4TtlgPmsKxkljP3DgzrEqT5SywrWqZP+sehnNQ/JKIH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4evhNJzyU5goQ+4eIznoBiEXq6qwtjInyJzNIkNnwvFPJ9Wgi
	r3ZIFELPuLsqoQTRj9vch4pFn85LjgqcDX0T5nVowWOCNDaAGOlKhMvJZAUOrQEj0dS0QzQ9nG7
	5mywUAyqGGW8OXN60TOcdhwGMBvXogJ7yI7QyAMDv
X-Gm-Gg: ASbGnctbpMSAfcES/3xorQg0Iv3AEc26+rGfxxtCkfDsL6vpaNi7tohMcgXnYR2NPGk
	wbpQZ9HdqfPnb6iFdc325IWgAD3DDFbX8v8GPokfJJuhr4pkn+uUSrCi7g3goNzsOD9zZsB6Ctw
	W4Nq7isBe5X5o9LgpIRuHoI5EBPr1i3OciImRg3qtqA/6OxF/8Ii5ZU5WMZ8qkJgtaHHZvuf+AQ
	p58VFRfiX9V8m+NQvKxT2lxPqpDDAmdWbRz7JCAgE9wlO91e9uxq4vVlqLKlmNEaYPTz5+X/TGD
	SDPX8rD3jmbNjXPQZw==
X-Google-Smtp-Source: AGHT+IFigqOtFBCYUqwCmY3qziL8qVWGu/nRTorElbmyiYpFccuK+2gunWWZPScjAXWItngFYakwtYJJBQr3HV87VJ8=
X-Received: by 2002:a17:903:187:b0:295:1277:7926 with SMTP id
 d9443c01a7336-2951a4976f9mr68144065ad.23.1761938903604; Fri, 31 Oct 2025
 12:28:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com> <20251028161506.3294376-2-stefan.wiehler@nokia.com>
In-Reply-To: <20251028161506.3294376-2-stefan.wiehler@nokia.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 31 Oct 2025 12:28:10 -0700
X-Gm-Features: AWmQ_blgcBeSUdxPtx55HtoAsZERyYHkYCJ5aCAKAIqjn5k5KTf1zjWOPzbN5ao
Message-ID: <CAAVpQUBk7CnezW6bOK-5GF3-kQwJZBwz0hLS4TTEiPYTkov+HQ@mail.gmail.com>
Subject: Re: [PATCH net v3 1/3] sctp: Hold RCU read lock while iterating over
 address list
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 9:15=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> With CONFIG_PROVE_RCU_LIST=3Dy and by executing
>
>   $ netcat -l --sctp &
>   $ netcat --sctp localhost &
>   $ ss --sctp
>
> one can trigger the following Lockdep-RCU splat(s):
>
>   WARNING: suspicious RCU usage
>   6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
>   -----------------------------
>   net/sctp/diag.c:76 RCU-list traversed in non-reader section!!
>
>   other info that might help us debug this:
>
>   rcu_scheduler_active =3D 2, debug_locks =3D 1
>   2 locks held by ss/215:
>    #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netli=
nk_dump_start+0x84/0x2b0
>    #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_dum=
p+0x38/0x200
>
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f864458e=
9a6 #5 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-=
0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5d/0x90
>    lockdep_rcu_suspicious.cold+0x4e/0xa3
>    inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
>    sctp_sock_dump+0x131/0x200
>    sctp_transport_traverse_process+0x170/0x1b0
>    ? __pfx_sctp_sock_filter+0x10/0x10
>    ? __pfx_sctp_sock_dump+0x10/0x10
>    sctp_diag_dump+0x103/0x140
>    __inet_diag_dump+0x70/0xb0
>    netlink_dump+0x148/0x490
>    __netlink_dump_start+0x1f3/0x2b0
>    inet_diag_handler_cmd+0xcd/0x100
>    ? __pfx_inet_diag_dump_start+0x10/0x10
>    ? __pfx_inet_diag_dump+0x10/0x10
>    ? __pfx_inet_diag_dump_done+0x10/0x10
>    sock_diag_rcv_msg+0x18e/0x320
>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x4d/0x100
>    netlink_unicast+0x1d7/0x2b0
>    netlink_sendmsg+0x203/0x450
>    ____sys_sendmsg+0x30c/0x340
>    ___sys_sendmsg+0x94/0xf0
>    __sys_sendmsg+0x83/0xf0
>    do_syscall_64+0xbb/0x390
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    ...
>    </TASK>
>
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

