Return-Path: <linux-sctp+bounces-680-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AC1C03CF6
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F0F3B45B3
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9AD2797AC;
	Thu, 23 Oct 2025 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svjhxatP"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563528373
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261476; cv=none; b=MNLgu3wyYWXvr24v0HKWD+ug68ge6BeDbk/lsevlaagwgm7bAwi/HugIsVCsJl1e/e6B+l+IsP1ND5OH9YZBhT8RlhwGkZ3+ccH27FwAlkBWmeP3O4CJcxwY8bX1o01cSsof/0qIX1VsfUVIK9WQCGjlKUlPTkPFUWtuZfn+Ubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261476; c=relaxed/simple;
	bh=H0UoUk7mrY8ApiouzoHqaM4xBIKytdZGjgYKOZ+Cmts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=twFKium4CL4eeTaqtEHHNR++KCZHKUBCBtHgYSynJ2IoEXUx6FlATt1JgKRung9tt51d7cRC5UAP6/aGONRPyYUpc2SCIR9qktYZ1Mfn6kbGQzf8aho1kzjhF2RrlpasTie5SVOqzQFpaoKwLBOY6nIqtPkco/MSzton0QrVYD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svjhxatP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-294880e7ca4so8801055ad.0
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261474; x=1761866274; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nPr+IHmc+5KcsOV/+l/1yTGitm3LXEpb7d4tT1QpRkA=;
        b=svjhxatPoPWwFRT8uM95hxXuAPKG5b21GzvyaGWsYOyS/OVGkJczc63gqLFhU6U0mj
         CRcyuz96akHfvoJVpCbe1g3wtuLxFQKYNxMahq0JIadp+hCoj9KO4cmVLgBlKiF7jteB
         PmhnLaJfMDxvEtu6mHZ48MiqqQjjzRiBrR3gg8sKOIJsbOvFFmxbyNpbCnBy0vLBxrDr
         LvVspnTmviPXVDL28D5HkeCnOuRR2HEJzSI43++fPjUaLE/eND8SBR48a5vqXIjSCYui
         bvtfgNhjpHDxAQLJHY/qcUK/cZxvSGzJHosnpQ4cgo64djebmirvcVGkcUd4a3WW4+Bw
         BPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261474; x=1761866274;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nPr+IHmc+5KcsOV/+l/1yTGitm3LXEpb7d4tT1QpRkA=;
        b=uzX51X8O7KZgmZR72QfRy/UwJ6dorP7YIlB8fE2SYXTSouE60FVqw+qeYZ2QVZEhbn
         /TU7pnaYyj6ecdcPL6icUyWyWT/c4ZzHf4ColLDBMaBvxR/8EGSlDIyfSjan/mGs7M4e
         Y73kU4d3izpZNnExPmoVcqDQ8AKCeto4EmOopIStk3kP/MzKAVqWW6eC8uyA5mlh6RQ2
         Tf9Ih4QN4nQAU1aOMUJNEX73NNcLHMpNnfCUESfiJPZsdOvX6VRT9ZssK5vFmQQskq2E
         V5ARlkkRT940FykJXdbCvx3OX88itg7c9rwix/7Q5HWCHUfO3zQhR80k0dJQ7SfDQBt7
         bqkw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7tQxqJHWkdPeJby1iPtAxyTtTSqeqP7sb6zzEbyfLKFyYsEo72XCtASBi3p8+dBgcB6TrwQ8WjZe@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NX11c8so/HhjnIxaE5rBE7f0KHuVNsVsjw0OYEFSRARwGksx
	ZgFJbTMgVXzInlX55KDRZxdrD4t3l9fWkzOuisvmVfkORdmoNzdksZxLatqlOWIMueETNKt4OcU
	RMGHurw==
X-Google-Smtp-Source: AGHT+IG5XgXdlnpqv2kQWZbN6dVjt0I/XcKJmdB0oc9j3In5M2rF8NmhfNVw1XUDgSvQzOaOuO2CryQn+so=
X-Received: from plon3.prod.google.com ([2002:a17:903:1a83:b0:293:e4f:e3bc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d60d:b0:28a:2e51:9272
 with SMTP id d9443c01a7336-2948ba56877mr1597175ad.48.1761261473737; Thu, 23
 Oct 2025 16:17:53 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:49 +0000
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-1-kuniyu@google.com>
Subject: [PATCH v3 net-next 0/8] sctp: Avoid redundant initialisation in
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
  v3:
    * Patch 4: Check if (lock) for bh_unlock_sock(). (Xin Long)

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
 net/core/sock.c            |  24 +++--
 net/ipv4/af_inet.c         |   5 +-
 net/sctp/ipv6.c            |  51 ---------
 net/sctp/protocol.c        |  33 ------
 net/sctp/socket.c          | 209 +++++++++++++++++--------------------
 9 files changed, 118 insertions(+), 225 deletions(-)

-- 
2.51.1.851.g4ebd6896fd-goog


