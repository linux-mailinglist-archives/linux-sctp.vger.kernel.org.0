Return-Path: <linux-sctp+bounces-682-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB500C03D0B
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB881A066B8
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB942C0277;
	Thu, 23 Oct 2025 23:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zp5CZEx6"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83129BDBF
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761261478; cv=none; b=hi1VJE9spcmqBW7gGYUvSoC4GjdN/IbDD5BlZYkBdTzNGGwLX2zNmKQDw7cldkKHWq2jD86FjMIQLNWLxFD8o6KZ9JYky9msrDQ+QNZaV/VA3bflDlFX1yVcQ2S/YcwAfEmqxR8LUDF45o/EBrVS1Y1/U69SyNdCkZDPyUfgfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761261478; c=relaxed/simple;
	bh=+v/LCHwnmax0eWR9imzbAfL9uJ2oz+OG3A7IHP3okBc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fIEW/hkejeUumfPoJ4bSE/zVjaThglWlnsHkbKkwUjAe+oO8hhlvjv4z/oJUgTYluLo8J7xa1/Dmzz0hGSqwTU0Rxf3cMM5C56tBln/ot/PMgkuNUCw0ghuJzYcwZ9kDbYecVUWL2Enh/XU6zWfSPJBvBkJ7+nfV1CbdfS0Gvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zp5CZEx6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b60992e3b27so1000731a12.3
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761261477; x=1761866277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f6cvceI1OVZxBwykq1fiTVykcannd1Sw3sac5q5Srpc=;
        b=zp5CZEx6WjV78neIee7hWwlSi6kPN3WXrVvIfeFwssjX6tVyA/0T7K9LyppWXxYWKN
         /I3abe3K2rPN6aXuyq1VCHP6A/BClwZt+OcU6nAEobhKQvkuXeeCa2BY5NG+te9WyPXu
         d0yWbL5i+X0zKPRONR2PtTrbuJRu8EyUvJidFpH7TCr0GtsL+jGBd16qV/BeLSeiwywA
         8VLUcqsYF+76QHenkYsPaa436PFWFOCYse3QxYb1cOYsDVALgNZ3hfEjh5SUWjJzlYLd
         shFPkPQWIHKFvOJyU9u9reglbGiiN9J+4mSmqNwUJdpGmM0+jNumZ75u6KOnNLJyzGEa
         kCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761261477; x=1761866277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f6cvceI1OVZxBwykq1fiTVykcannd1Sw3sac5q5Srpc=;
        b=W8XMjz8H/+tVCBVGEc06Jxw8jsqpDyiYhQHFa+keaHSbqYoXTET1cQawSq20J98Fqq
         HkqF6LBlDcrSyWwLUwCarU3ar+GN5c9g3eCi2CnqGoiQ37b/KoLmIppDKaATJVYsV7d2
         GCHEclwA4sgfiKya9h2Vns1BQICG/GIbpiJ5W0JjLCC6aKZYotOAQQftiZns6/Qw3OYo
         s2qHebd8C0fTmzF22jeQqrPH7vz3d3ocTTjlOlFOLfO2RMDZk74wLCy0UJqpexoh1PUd
         eEY6DD+yQ0uQkL/CE/+DcFjRm+ptziXwD2pfBu56nV80gVVaBRcqWAq54kUb/rLhzFgg
         Df4g==
X-Forwarded-Encrypted: i=1; AJvYcCVoqsnqzqqiXGIjOuHL6A/ri97F0hP6x5k3GaS3QMb/e7Aij+EPGenjy/aliLm+N8bhLMXEuTorViZO@vger.kernel.org
X-Gm-Message-State: AOJu0YxNaQeYg3nzqXASqikFCTmjAXwfycdtkFi4WD2pawOBoBGImV6A
	DgYFzcDwIQnSmIiBT6fI+MYmdHMKtcOo7Ln+TWmtt352yIAHRO6uzfRpj1WLT1eBMnS47OEQroe
	eEjZrqA==
X-Google-Smtp-Source: AGHT+IEocUzvZgLWhL0Jw3pucLYnu4fhj1Dp4OpquK2AegpvRGrjPjp2USLTU8uIpypDL8g5Hhsst0mxwJU=
X-Received: from pjcc8.prod.google.com ([2002:a17:90b:5748:b0:32d:a0b1:2b14])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e212:b0:334:a681:38a3
 with SMTP id adf61e73a8af0-334a8542a1dmr32512648637.13.1761261476812; Thu, 23
 Oct 2025 16:17:56 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:16:51 +0000
In-Reply-To: <20251023231751.4168390-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023231751.4168390-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023231751.4168390-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 2/8] sctp: Don't copy sk_sndbuf and sk_rcvbuf in sctp_sock_migrate().
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
index d190e75e4645..735b1222af95 100644
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
2.51.1.851.g4ebd6896fd-goog


