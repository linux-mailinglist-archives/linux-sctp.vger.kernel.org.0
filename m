Return-Path: <linux-sctp+bounces-646-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C4BF8F8A
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 23:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D6924E4D36
	for <lists+linux-sctp@lfdr.de>; Tue, 21 Oct 2025 21:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5E829B8FE;
	Tue, 21 Oct 2025 21:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8y+nqG9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08D29A31C
	for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083069; cv=none; b=nEuSWBicamCEvFY8FOPkrYLQXZkBNFO2E1gE66UhiIaQJk8v4W8cJfsJbmJ+eSGYFT5vAvohe14ieeT9kb7QCPFhxqb+V3mCnlzE3AadzD4KeY/ZRZnKKzM6aU7nim+3mjhzU4919fexBCkOp6G6Gd0Tq8nfSfmA0csfi2EhDKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083069; c=relaxed/simple;
	bh=zwEQnRS63FsArBMQrWWg/87nk/3B7BWgQrw4k9fZbFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e7mRiRy/rZVnem6rp8Ycct6+upb4+evz+PIFJAwjAQDPKkGLDcwxm+q7tZfQQqqZDCwqBPXwF5PRamxCUr0cQt7JGltkQJ3sn++n/Odxap53YoXkREkYjzz05oh2xiMCC7cnuR1d2DAiFiNHJjoN+9gDbcHUROFtzuOiRlb1pOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8y+nqG9; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33be4db19cfso9674881a91.0
        for <linux-sctp@vger.kernel.org>; Tue, 21 Oct 2025 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761083068; x=1761687868; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7R4PquQC7iOdzeoa8eBBcR02cBjGYIkrkyYUw/rwe4=;
        b=u8y+nqG9ZbnD/i5vLNgVxj9LKg1r33VfBbOCUbbla4VB4GzvuhJHNYRgV4v0u0wkj2
         eDDTMEZX9xSFiOSwG+6E5jeAFzGqDsN1fxmhQQ5jYfp42H0YRVycJPQz+8cJXF7dxdpk
         +GiRbpktmIVAmTwmequnnl3cycFvTc2XZNIZ/cdb+JTSnW0pBCSg9ysl3/pmfxPFZ0ts
         yq/iIAvHBmgI5SPjLqSuacZ1cTISGE8mM51YFUY8CnRUoIrW+9duToYfqbtrG+r9ed7+
         QMD74Va+9ORGsIDv/QhTfGipmCdpNHKPOfcpJrh7W2qOe9tbXd7pWkZlMVCe4HZAbxpI
         YGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761083068; x=1761687868;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7R4PquQC7iOdzeoa8eBBcR02cBjGYIkrkyYUw/rwe4=;
        b=Vfc+ASlRIFKuH0lBHoiSTeMYqsZOcHwojM5FDJPifzDq2YxTfrpzHi/ZRe0OzxF+AR
         nTkKdRgZ2BLGZlizUVECXoeif430mNcouEc7rMzInFdzjaHOI/fRkdXaaxemT9oZTVz8
         syfjRYneGEI+9n0JLQfhjWlpSjallZB+ZkzLrbP1qLkFT0kGhmjevI1l3tfL99aaQsPb
         8wQE5h4ne1KTU970QcFTnUZ5nWtVKKZ0g+L0B4a0vaQWTkQodatyMrE9LlSmQMw+aqMf
         FDwaXpK/Kf6cIeU23XXWR3ZdpeHAyi9jFOAEBFO1rG88EzdE3VmNmi7yV2WwH/Cto25Q
         mmkw==
X-Forwarded-Encrypted: i=1; AJvYcCUASHa22buVs7nqODrnIK6Rpejv7M6WoqXpPibBzZGA8X7DEAVRn3a/QC4zF7pUD4lWJJbOaYU6qJNf@vger.kernel.org
X-Gm-Message-State: AOJu0YxfVhb+msBIPMxr3PLQ3WmknV5Y3K2Pd5QDjPldDdSXVCnCkyZQ
	7nvb0q+orFShi4vNnnv8t8MEvUyF00etW997DjSENPjSOgkx3jLmEasRUUihyuZKGiu1MGBH4PY
	T/nSEhw==
X-Google-Smtp-Source: AGHT+IHRzrm9kPn7DRSEesn0PnJE+57wnLGP216oUrBk7UwaXgT0WJJ46l4Kn+gY6fwyv+OqmsYDQ/2SIIM=
X-Received: from pjbgp6.prod.google.com ([2002:a17:90a:df06:b0:33b:c226:ff96])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3ec4:b0:33b:cfab:2f2a
 with SMTP id 98e67ed59e1d1-33bcfab2f31mr30471810a91.33.1761083067794; Tue, 21
 Oct 2025 14:44:27 -0700 (PDT)
Date: Tue, 21 Oct 2025 21:43:19 +0000
In-Reply-To: <20251021214422.1941691-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021214422.1941691-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
Message-ID: <20251021214422.1941691-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/8] sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sctp_sock_migrate() is called from 2 places.

1) sctp_accept() calls sp->pf->create_accept_sk() before
   sctp_sock_migrate(), and sp->pf->create_accept_sk() calls
   sctp_copy_sock().

2) sctp_do_peeloff() also calls sctp_copy_sock() before
   sctp_sock_migrate().

sctp_copy_sock() copies sk_sndbuf and sk_rcvbuf from the
parent socket.

Let's not copy the two fields in sctp_sock_migrate().

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/sctp/socket.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d190e75e46454..735b1222af955 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9523,12 +9523,9 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	struct sctp_bind_hashbucket *head;
 	int err;
 
-	/* Migrate socket buffer sizes and all the socket level options to the
-	 * new socket.
+	/* Migrate all the socket level options to the new socket.
+	 * Brute force copy old sctp opt.
 	 */
-	newsk->sk_sndbuf = oldsk->sk_sndbuf;
-	newsk->sk_rcvbuf = oldsk->sk_rcvbuf;
-	/* Brute force copy old sctp opt. */
 	sctp_copy_descendant(newsk, oldsk);
 
 	/* Restore the ep value that was overwritten with the above structure
-- 
2.51.0.915.g61a8936c21-goog


