Return-Path: <linux-sctp+bounces-657-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8FEBFE455
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 23:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA111A06FDB
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Oct 2025 21:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3084A2F83D8;
	Wed, 22 Oct 2025 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/3A7BCc"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A915F279918
	for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 21:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167848; cv=none; b=HWSyS4xeioe0KEAvsJ7k9ivNShN7Q2yM3d+wywEiGb7J7lJxjmWRapDFggxfI4zl0dIEWvk2WdM09fqV8iWzVYUDYtv6gAtc5Z2w1FfhLlSMgWUS7KKTB9S5su480QhBKAohoUOWPsUKUXGu9gqiobXfxAFTyctNR20W2tOf6m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167848; c=relaxed/simple;
	bh=ahGep6W32+gNV6oNtpOuYveNFz+hFzSORjjfmF+eRZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ca33g3sent2MyAH42YutF4oapGEKhrvZr1S5NEU4hqM7hb9aExfubDE89jT3jzIKB9n1Gtt6sqOE7S1lueDiPXDToBjnd1SLWYlpxjlCGuDpcR4dzfCYxxMjCG67Ik+v64dWlu9CNK4tUG0uy10DHs8TRwyZA226EFcYh1ZdDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/3A7BCc; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-33dadf7c5beso90390a91.0
        for <linux-sctp@vger.kernel.org>; Wed, 22 Oct 2025 14:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761167846; x=1761772646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zC1K3IqyVSO0xtPymYXFv2IA0fNslGgFU0Blzcbsmno=;
        b=N/3A7BCcvIgMLf1iQ+tYgZJC91KJWkAgj1GoqBrrpUfBN2E8NzX0cHBnGJvnnFN7Co
         IQDzDdZbjnkgssV0cO2BZeGP4Fccs/nQLWE+SL4i/oJqS0XEjubnXH4e4nIoghi1UYp5
         2wXjCIFvzb6IKo6k9PAgvCPDUE5JvLt5FAB5j8go0A0g6a3A8GgSbUFQQAT75C71r/Ab
         M1ZC8SuYwp9GZP6NRA6/D8RNnVs59DjMGsf1iYU0+9prrxyn7Q2EcpOnvctQjFPM+Vj6
         ww0vnMBuZUCfJ4WPdte1YbG3eTMYYXtCZT9grCluYzExuBbmbwlHDU0VIX/riTeGJiKL
         jHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761167846; x=1761772646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC1K3IqyVSO0xtPymYXFv2IA0fNslGgFU0Blzcbsmno=;
        b=gtq2yx8vzDsHTv4NH7Zmz6n1tHFxqZ3bC2v2VQcCg/wIcGLbvXCo2v/SmE3yV4NsIH
         Owb3vUHiSHcodpuKdEndjmnCtRhNJ6u3pvd79Q8LGziq+LOyWlaWlkVtzj97Hvuy+Kii
         wMes2Qp/S/t8qLvhjPEqmsUAjRvcYjmpi0d2d08Wq0sUnThuIyglEeOR6qnIsmGyPwPd
         +W4n+D4iT+A4qhjRPWWlOUp9G5aXsnoUmW3El6HjK/f5KkhjPyJZJOtBpQcVCM9L/bKd
         gPEiD5takifNeXheSZ7pUn3aIXyyB3KDBBmb0j2xQYwqxFUqPakFUZkY6WIRefdzzOU0
         1y1A==
X-Forwarded-Encrypted: i=1; AJvYcCXhwIngsxyCe9MxwWXmDwji6BdGlJ9QXzGPYHEWRmThIDob4SlQgMxLfoCRbWjPPDVONWsHGUvVhvlV@vger.kernel.org
X-Gm-Message-State: AOJu0YwX9mJvWm+4htRTDmncSxKL00WifgpZCeWmV3adSGv8yq30FWst
	bGfhCvfowtf48c1GgTvRNltHX3DU+ROsBXhI4XOKAdDQ3YcnxBFeDf8s5QBmN8JwnrFv5nQtqe/
	CwHkZCg==
X-Google-Smtp-Source: AGHT+IFWEulJ5rWTn8gl2RfPZa6sZRrfZaT0vTzM1+EoEHyNwJau+tizb6zu7WA33NEsXmZNF6/glxvztEI=
X-Received: from pjyd13.prod.google.com ([2002:a17:90a:dfcd:b0:33b:cfaf:ce3e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b4a:b0:33b:aaf9:e980
 with SMTP id 98e67ed59e1d1-33bcf939e86mr30875872a91.35.1761167845941; Wed, 22
 Oct 2025 14:17:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 21:17:01 +0000
In-Reply-To: <20251022211722.2819414-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251022211722.2819414-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.814.gb8fa24458f-goog
Message-ID: <20251022211722.2819414-2-kuniyu@google.com>
Subject: [PATCH v2 net-next 1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SCTP_DBG_OBJCNT_INC() is called only when sctp_init_sock()
returns 0 after successfully allocating sctp_sk(sk)->ep.

OTOH, SCTP_DBG_OBJCNT_DEC() is called in sctp_close().

The code seems to expect that the socket is always exposed
to userspace once SCTP_DBG_OBJCNT_INC() is incremented, but
there is a path where the assumption is not true.

In sctp_accept(), sctp_sock_migrate() could fail after
sctp_init_sock().

Then, sk_common_release() does not call inet_release() nor
sctp_close().  Instead, it calls sk->sk_prot->destroy().

Let's move SCTP_DBG_OBJCNT_DEC() from sctp_close() to
sctp_destroy_sock().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/socket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ed8293a34240..d190e75e4645 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1553,8 +1553,6 @@ static void sctp_close(struct sock *sk, long timeout)
 	spin_unlock_bh(&net->sctp.addr_wq_lock);
 
 	sock_put(sk);
-
-	SCTP_DBG_OBJCNT_DEC(sock);
 }
 
 /* Handle EPIPE error. */
@@ -5109,9 +5107,12 @@ static void sctp_destroy_sock(struct sock *sk)
 		sp->do_auto_asconf = 0;
 		list_del(&sp->auto_asconf_list);
 	}
+
 	sctp_endpoint_free(sp->ep);
+
 	sk_sockets_allocated_dec(sk);
 	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	SCTP_DBG_OBJCNT_DEC(sock);
 }
 
 static void sctp_destruct_sock(struct sock *sk)
-- 
2.51.1.814.gb8fa24458f-goog


