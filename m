Return-Path: <linux-sctp+bounces-651-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F20BF8FAE
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 23:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E173819A85B6
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95802C0F93;
	Tue, 21 Oct 2025 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0tzlSc3"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330062BEFFA
	for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 21:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083077; cv=none; b=J/onzIr0nMh2lWdQYT3mub+gQ43VQrcbjed3tDbOUJAsMh8jKoDiMNczFZH8/HrZGA4DN+FPF7zRAmh/E+hMEC4yHMMZGnTJqtO5O2aEJ7Mn7EjXTOkD+anA7ae7AIcvo4mNq8QpBpGc1ppjYQUSttiE61BbxEiCzm3p6aa0S7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083077; c=relaxed/simple;
	bh=PvbXyO2Xv0F0aCNDTW+vC6aSFlCz/tMyrexgi8JKhnc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lZ9qRzYX/e/ckHSAG12PFVkt+kQWHpGpkDmojhTUzAOEsNxi//nqB6v8rq/2vZQf6ZXZMAA9SYfAavma03LaL1zHtLF1/+z3e6/NWrN0E9aIlJwiytsA5Ux3tprEzSCuBB/pXZgVsmYA+Qhor34MfiS4V+JAbBOeoeU+qcPVMZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0tzlSc3; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-290bd7c835dso57757545ad.3
        for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 14:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083075; x=1761687875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3oFuTBHP3Oh6ENHZ1GWGRzc+PlcwIDyCkAHy61cDqaw=;
        b=J0tzlSc3AOJOZ03J3nGQkHq6rNsOoR2vpU/WW9yBX16cR618oOtu/t8+/e5qnluyf4
         OTJJB2eN/RcjFYZf4ZSco4pJd+lf0Hvv+GmQcuysruPr7waph/a6fPOIFjbl4glSf8Sw
         mQROGZwzaud0TSvZvWTSbqx12OoCQVqWhamPKnQ6hGCaQRBDdSOQ461UrYfRexcKFM8q
         QVhOFNtqiH0/rbhwbO9LB1iVlgSNvSSkRTtFe8h/y6A2M8KTmVWitbCzPm5cMOVKKo7W
         iKlIhukMTDqdKBIogb3s1IfQp9mTluX7NvYB2iyAJ+qcHls17Pt/6bdiQzTEPCRPNdcX
         NgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083075; x=1761687875;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3oFuTBHP3Oh6ENHZ1GWGRzc+PlcwIDyCkAHy61cDqaw=;
        b=HlUq/HNykyB0GMUMm988tLcH8Ja5LRSjasT4A6F9AEn4KWfz+vHHegI4u3xFpul6oa
         epUUN+ssV3oH1Hf5ucvJSB/KafCUO5lglo12WC63F6+rARnbM5VI45TZmmDnzzEV8cSv
         lMgmYUp+CUkKVfe1OkggwDcfBfuuCI17QqVOYImeQHpFpZmbI8/w5JsjXkblvbB9OWXc
         /L1Z8mkx3vMpHbNYuYkMxVm1SpXZMwCj6BMFVPesCDUQITpAv4BLSWUIWVh/cLYFWJz5
         xw/SJDFIy6xlwLOlw7++X+jhvViYXkIkpfaxVGdm+dou5dVdYrWo0j8sFL/2Fvz/nnGh
         uAnA==
X-Forwarded-Encrypted: i=1; AJvYcCVkDhxMCya2wwVGfvCOIaR5jcnC8FU30x7oULogfL05TCSq9sSY7sEXJX5DpRDuDBJ2euIAzI21OR9I@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXv/GfgUqA2XSeP7Sh+hLOp8ZW1pKAwIkwjrSAd/0RGRh6AN1
	4x41v2y96ArhCPFPr7oQ4Q1kyt7LtCzxSB0uF7kS8VvJbDioJbPCYrEQKqXVLVq9O8HcK8ZTlwJ
	pEwz5/w==
X-Google-Smtp-Source: AGHT+IHwE840E4NtIlo0dAcsArtYLw0wL8cRT0LUI1vGPg9kogJjyt1taM8SFEpl4mXYL5EM/w7O5CRZl/Q=
X-Received: from plrt13.prod.google.com ([2002:a17:902:b20d:b0:27e:dc53:d244])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:46c8:b0:24b:1589:5054
 with SMTP id d9443c01a7336-290c9cc3da9mr206216405ad.23.1761083075505; Tue, 21
 Oct 2025 14:44:35 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:24 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-8-kuniyu@google.com>
Subject: [PATCH v1 net-next 7/8] sctp: Use sctp_clone_sock() in sctp_do_peeloff().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_do_peeloff() calls sock_create() to allocate and initialise
struct sock, inet_sock, and sctp_sock, but later sctp_copy_sock()
and sctp_sock_migrate() overwrite most fields.

What sctp_do_peeloff() does is more like accept().

Let's use sock_create_lite() and sctp_clone_sock().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/socket.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 826f17747f176..60d3e340dfeda 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5671,11 +5671,11 @@ static int sctp_getsockopt_autoclose(struct sock *sk, int len, char __user *optv
 
 /* Helper routine to branch off an association to a new socket.  */
 static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
-		struct socket **sockp)
+			   struct socket **sockp)
 {
 	struct sctp_association *asoc = sctp_id2assoc(sk, id);
-	struct sctp_sock *sp = sctp_sk(sk);
 	struct socket *sock;
+	struct sock *newsk;
 	int err = 0;
 
 	/* Do not peel off from one netns to another one. */
@@ -5691,30 +5691,24 @@ static int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,
 	if (!sctp_style(sk, UDP))
 		return -EINVAL;
 
-	/* Create a new socket.  */
-	err = sock_create(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
-	if (err < 0)
+	err = sock_create_lite(sk->sk_family, SOCK_SEQPACKET, IPPROTO_SCTP, &sock);
+	if (err)
 		return err;
 
-	sctp_copy_sock(sock->sk, sk, asoc);
-
-	/* Make peeled-off sockets more like 1-1 accepted sockets.
-	 * Set the daddr and initialize id to something more random and also
-	 * copy over any ip options.
-	 */
-	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sock->sk);
-	sp->pf->copy_ip_options(sk, sock->sk);
-
-	/* Populate the fields of the newsk from the oldsk and migrate the
-	 * asoc to the newsk.
-	 */
-	err = sctp_sock_migrate(sk, sock->sk, asoc,
-				SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
-	if (err) {
+	newsk = sctp_clone_sock(sk, asoc, SCTP_SOCKET_UDP_HIGH_BANDWIDTH);
+	if (IS_ERR(newsk)) {
 		sock_release(sock);
-		sock = NULL;
+		*sockp = NULL;
+		return PTR_ERR(newsk);
 	}
 
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	__inet_accept(sk->sk_socket, sock, newsk);
+	release_sock(newsk);
+
+	sock->ops = sk->sk_socket->ops;
+	__module_get(sock->ops->owner);
+
 	*sockp = sock;
 
 	return err;
-- 
2.51.0.915.g61a8936c21-goog


