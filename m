Return-Path: <linux-sctp+bounces-656-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82FBFE452
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 23:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E34941A06F57
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968FC296BB2;
	Wed, 22 Oct 2025 21:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3iGMxjQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE259277C9A
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167847; cv=none; b=DqxOJ/g3X4fLf4i69dRJLHJQDjF2KL0dz5xBqn4ogSRb+U2DRQ+xr3bFDhbVP90c51e74ZprbBOkW+LbkVA0Jq9IfhIJU75x+wbKFzJbldr8RYQ/rabdsBMH+1hze0CP52zaDRKR2xvQEfDGsmBKMl+EoXK18cQrjX8EqZsdfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167847; c=relaxed/simple;
	bh=7/cxEwMmZ++WTTO8EVxit+7JaDEKfmEUgCnplptK1hE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=YtW/04bXzp+X7wqbioPdupCVx28+WW2aP3GIiaH9fdlHDlpoK6iwWNjiW53woBeGcwtCJ8zW+twDJF93R7TU+EGwO9KTZB+RnQ/I6jSFsdQ8DV8IiU1ky7MimCZm7hhZhZXlXn5/yk4oPQVuTRTmJMErA8hOwEB4dTMN9cZrWp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3iGMxjQ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33d75897745so277174a91.0
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167844; x=1761772644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qW7guxq7h7ph5o/bQVxn1/WVYaA8UvxQBGzNlqrVyYk=;
        b=o3iGMxjQQ1GahR4TAtKoJEpCjmVwRC/NV4nKLs6Qpm4NVzzWCATwTaOYNKiUwzRICB
         IzrH7tqchzgzLtlKoQXlwJQVlO51Hp98juaQJsdbv+y6a52BixcKyHcpCE6LJJgAJuD6
         oPtgcInEobYJr+JbxkiVAhHTzLgSfpJZMio1XPf2tzvzNvkjwpZFGZBpB5JQHSzIbTWX
         rj7H2dAFBl2CDKkvER9TI8/BEUI1nWPvYwDHnoTDIAvo0LQBElmBT2sNbGBxuEvyq8t4
         PP1KPXLDjIFWmaN+ymKwCUtvTpOx5k64raegdRZSrmtrKGSZmlheHLs5uG2B8foIRqU1
         OW2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167844; x=1761772644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qW7guxq7h7ph5o/bQVxn1/WVYaA8UvxQBGzNlqrVyYk=;
        b=f+GHjnQfbKFlDcA7v9UziAb2YKTXCBV9E9Gzcl8sXJKJszFANCuSfBOpeTgu3CPoSF
         Xgjf3lR+FkTFXaNsEItQ60qJjivxCqS34Av8IIua+hBi7UlJuEM8a5+ArZ6T2qndvpln
         j6KMY9gufpPHlyJqxX8YjUALedBSV703TC8PwMcS3H/6vf6YlmXnJ8pM50Z191nwEbBQ
         uzxT115CLEbziJNxHl++5PEgbIqjDAIoSmljOm7tlXMCk3bmjZVsTYck7gx4Ffe7PEJv
         CyAsC/aJqPa/XncR6bhD0NuNFehusE5uPbEDHW+w581Zc1okgKLwCEtS1muQPMlpNHmw
         lpVw==
X-Forwarded-Encrypted: i=1; AJvYcCW7CVmVYHNZv4sFCIElKAMXmu3MsYqYo7/UZyI5533zWnpGKLr3r+WGG0UrRFDkp9fvuD06WuURWimu@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhseiVUg3Jrl/KEwZ+gSvPmn+qskbJfqWIBE8eR1VtlILeKoV
	zGEKokZTMlCesbSbCs5Hsg5C55Tdx/NUmzs1xT6B//3YzhbPc3tibqIYGkm3Vazjul8sADCSX5d
	mY7wEOw==
X-Google-Smtp-Source: AGHT+IEbLefywCGXkV0YtrKS7jEu8/+y1XTcDlnr43VAcpUpFm+cbgZAvq6aa6lgrqMnkp39rhehddofZEQ=
X-Received: from pjqc14.prod.google.com ([2002:a17:90a:a60e:b0:33b:51fe:1a77])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec7:b0:33b:6650:57c3
 with SMTP id 98e67ed59e1d1-33bcf8ec60dmr29138222a91.21.1761167844486; Wed, 22
 Oct 2025 14:17:24 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:00 +0000
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-1-kuniyu@google.com>
Subject: [PATCH v2 net-next 0/8] sctp: Avoid redundant initialisation in
 sctp_accept() and sctp_do_peeloff().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When sctp_accept() and sctp_do_peeloff() allocates a new socket,
somehow sk_alloc() is used, and the new socket goes through full
initialisation, but most of the fields are overwritten later.

  1)
  sctp_accept()
  |- sctp_v[46]_create_accept_sk()
  |  |- sk_alloc()
  |  |- sock_init_data()
  |  |- sctp_copy_sock()
  |  `- newsk->sk_prot->init() / sctp_init_sock()
  |
  `- sctp_sock_migrate()
     `- sctp_copy_descendant(newsk, oldsk)

  sock_init_data() initialises struct sock, but many fields are
  overwritten by sctp_copy_sock(), which inherits fields of struct
  sock and inet_sock from the parent socket.

  sctp_init_sock() fully initialises struct sctp_sock, but later
  sctp_copy_descendant() inherits most fields from the parent's
  struct sctp_sock by memcpy().

  2)
  sctp_do_peeloff()
  |- sock_create()
  |  |
  |  ...
  |      |- sk_alloc()
  |      |- sock_init_data()
  |  ...
  |    `- newsk->sk_prot->init() / sctp_init_sock()
  |
  |- sctp_copy_sock()
  `- sctp_sock_migrate()
     `- sctp_copy_descendant(newsk, oldsk)

  sock_create() creates a brand new socket, but sctp_copy_sock()
  and sctp_sock_migrate() overwrite most of the fields.

So, sk_alloc(), sock_init_data(), sctp_copy_sock(), and
sctp_copy_descendant() can be replaced with a single function
like sk_clone_lock().

This series does the conversion and removes TODO comment added
by commit 4a997d49d92ad ("tcp: Save lock_sock() for memcg in
inet_csk_accept().").

Tested accept() and SCTP_SOCKOPT_PEELOFF and both work properly.

  socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP) = 3
  bind(3, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  listen(3, -1)                           = 0
  getsockname(3, {sa_family=AF_INET, sin_port=htons(49460), sin_addr=inet_addr("127.0.0.1")}, [16]) = 0
  socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP) = 4
  connect(4, {sa_family=AF_INET, sin_port=htons(49460), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  accept(3, NULL, NULL)                   = 5
  ...
  socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP) = 3
  bind(3, {sa_family=AF_INET, sin_port=htons(0), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  listen(3, -1)                           = 0
  getsockname(3, {sa_family=AF_INET, sin_port=htons(48240), sin_addr=inet_addr("127.0.0.1")}, [16]) = 0
  socket(AF_INET, SOCK_SEQPACKET, IPPROTO_SCTP) = 4
  connect(4, {sa_family=AF_INET, sin_port=htons(48240), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  getsockopt(3, SOL_SCTP, SCTP_SOCKOPT_PEELOFF, "*\0\0\0\5\0\0\0", [8]) = 5


Changes:
  v2:
    * Patch 7: Export __inet_accept()

  v1: https://lore.kernel.org/netdev/20251021214422.1941691-1-kuniyu@google.com/


Kuniyuki Iwashima (8):
  sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
  sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
  sctp: Don't call sk->sk_prot->init() in sctp_v[46]_create_accept_sk().
  net: Add sk_clone().
  sctp: Use sk_clone() in sctp_accept().
  sctp: Remove sctp_pf.create_accept_sk().
  sctp: Use sctp_clone_sock() in sctp_do_peeloff().
  sctp: Remove sctp_copy_sock() and sctp_copy_descendant().

 include/net/inet_sock.h    |   8 --
 include/net/sctp/sctp.h    |   3 +-
 include/net/sctp/structs.h |   3 -
 include/net/sock.h         |   7 +-
 net/core/sock.c            |  21 ++--
 net/ipv4/af_inet.c         |   5 +-
 net/sctp/ipv6.c            |  51 ---------
 net/sctp/protocol.c        |  33 ------
 net/sctp/socket.c          | 209 +++++++++++++++++--------------------
 9 files changed, 116 insertions(+), 224 deletions(-)

-- 
2.51.1.814.gb8fa24458f-goog


