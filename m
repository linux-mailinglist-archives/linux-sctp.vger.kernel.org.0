Return-Path: <linux-sctp+bounces-681-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8D5C03CFD
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4D9A4E2C6B
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC2D298CA2;
	Thu, 23 Oct 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w+YMU/nD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F372472AE
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261477; cv=none; b=bTb+strV1LMDs+pbtfHiiKR6XlhGLzmusZL04+A7TfDmoCIommDOmdP7UeS5khxpSFQRhW+Ce6bCzIUKYstC2kg0zc+0YNqx43SbZS8hoRHitWNwltifuw/5EnjVI/38NliwFqhyakV1lPDdYPaD5pa/uh6pFDCwufDnzWlwv3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261477; c=relaxed/simple;
	bh=eepb6CFfGDQC09Sy/24Rtzwj1pIvAFykxiZYQRBaCpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EIfS0VSS78cOOOv9hygdKe+ZfkntxUYfun9kfKkD9Y6e81h/MEmC1DyfRcXC9qZgENwfJrDG2N88isfBppmJAWr40UrEqxGX1uZ2TVQnr4YZGh9e+Tq4zA/VXpCKhzDKqw7fvKo4Cn7g8aOJ0Z1Jh2OnaVXrBw+WMIoPl3EgdJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w+YMU/nD; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b6cd4d3a441so1134131a12.0
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261475; x=1761866275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LXl5yVRKLn6z/9KiE3OHahGyzawPLwWd2qFS+XcPUHo=;
        b=w+YMU/nDt2QYec4WswuvwhQ6Cuy8xTsnNvcHsz5qknyHEW/vp9pxV8xfhizP28+67f
         U8M9A4htRAKdBNT2QI4EkdDhFBPk9BbGzboJnPbnBNRL6O1DoNKBKAzfNx81/WNDCG7x
         6x0F4jXdRBjCz9FARjOBlw+QEaSqw9G9gIcpWJsyzQuCjcJJL1npC3JWZExlGdrvDLsm
         0UogG2pPKachFWzSHIJRKAnB0X69FOElneCbwHNG0dfWVHfE5ANaGypSA7+VozL7Cffo
         BC8/WA8WThYJZSJ3QCWkpbaw2kS1aJ2W4lAORtPJyMmBQpDxFTxuCwzWu/mdIyhGqreh
         7yBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261475; x=1761866275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LXl5yVRKLn6z/9KiE3OHahGyzawPLwWd2qFS+XcPUHo=;
        b=I8C0IKESnzYOWjVWr2qVBl3N6gP3upRVXCc23zdbm99fRkm650R34qrU/G2KYXCrXf
         IYWsgCI9GqS7eMqERfTwMfUqoZ78x2GC/Z6kmvu53ti5/0qRtj3pCThaSFrH+NiWeLI/
         mDWXPkTAIpwB8sXV2EJDhbtRDJE89roYfFxKse/s41LoTd4XcXYTukUMc2++iRHvhSQ6
         kP1ZB542OegcdenLOvCK4l+e4u2HhSgWem9kwMyNGNyItBzaEdDna2jhOMYjw3pP9vDC
         vmzMcgwxtsv2zgxT1GMNTs+Cy/xXHPHVtdDuJTSPgW/rngchzYmWpwJ5z4EfSKvdWsWI
         8n4w==
X-Forwarded-Encrypted: i=1; AJvYcCWEjuIbTnLO31CxFIH4ibYX9K2Qas2lhoG4RaDnb7/cmmSxyabU2YsJt674lS/Whhn5byWA9tQAgz6z@vger.kernel.org
X-Gm-Message-State: AOJu0YwY2mlyrerRMrv18I3HfCg7m6+Wv61pFeS8w4t7rLJNKczOWXba
	vwvcj/Dh//40y7Zx6aJx1e7KW5Gf2K+igId6FAXrARYTct21/Cp3QHfoFL/0N2aN4muBMVSuqXQ
	qrgojHA==
X-Google-Smtp-Source: AGHT+IFG1MdEPQO7YAbbzAkIP0iM7lCxAwhvxAYF8d3H7vOOyZetkNz59Pnl/AE/wSQ5gCRBbooZ5OlRJpg=
X-Received: from pjbpb12.prod.google.com ([2002:a17:90b:3c0c:b0:33b:ba24:b207])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:6a08:b0:33b:20b9:d249
 with SMTP id adf61e73a8af0-33dafdf9809mr854413637.0.1761261475247; Thu, 23
 Oct 2025 16:17:55 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:50 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-2-kuniyu@google.com>
Subject: [PATCH v3 net-next 1/8] sctp: Defer SCTP_DBG_OBJCNT_DEC() to sctp_destroy_sock().
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
2.51.1.851.g4ebd6896fd-goog


