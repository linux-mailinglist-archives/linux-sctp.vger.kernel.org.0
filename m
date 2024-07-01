Return-Path: <linux-sctp+bounces-174-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EF91E6E7
	for <lists+linux-sctp@lfdr.de>; Mon,  1 Jul 2024 19:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF9D1F2545B
	for <lists+linux-sctp@lfdr.de>; Mon,  1 Jul 2024 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7016F8F5;
	Mon,  1 Jul 2024 17:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEJm57+i"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE316EB75;
	Mon,  1 Jul 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856133; cv=none; b=jiC8byxv2i7cm9Eb21H0qzm8R1aseu8WBzWYEkjHwJmh21si/qE+8fwoC26or5vpUETl7oJy569/FnyynXOdMMV0dBWfLqseECpXIbzFT7YWzpWelI38FkmFz+IpGp+baTX9K35iyZLg6sQoInmzvrYV6CzLHmgLkeNhqQHtLSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856133; c=relaxed/simple;
	bh=z9HQAgTA9hSsKMNWRCoiiNJCmVX/1Hg7GXRdkfFEmno=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=askltR5kwRuSTfxSsUN8kj/dwLFQi8yihLbtAQ63r1P3zpBF7xoG+dlJAjINhsDVHTJn3hNK2yHOU0mvrGecE1dhwV5VZJWrHG97XxAR1phzp8ueMMBYAb2BdLD1vtryehZpnQc9mJapTp4SE5/XMkxnNgD9q6zDx7UIAcXTork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEJm57+i; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b2c95b6c5aso14976026d6.2;
        Mon, 01 Jul 2024 10:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719856130; x=1720460930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hJtkxojM0mCUIGf1og2Qw2ek37F+Q427CZ4vFrsP08=;
        b=hEJm57+i8RP9afW3MNNHN3R3iSc3TIaDSKl1tAahzP0x/EChQnYqJidXuODtj0TVG6
         7mW9n9V/Ahj05xhid/KNt+HwtE0LEKiRDhbf0/g0N59RagN/jijID+v6DPhI74lT3CA8
         KNVWynePr9Nb8BB7PTKjc21ohD3zm/2dGErk4Tfnfr2N/thLkVoiEyvUjnnu5tO7nBo/
         9UMRwNypAZ6Wbdg9E3i3OmH//+hOezUPy2Vgq1HOMCATaWawVN1Bntujd1pPL8EnKrl2
         Go6B7mxe1cC9PDdbUXU12CbtWfVUfOQxxAs1UQiGjnkV9QfPkcHp2SfrKtdSGCdlqpXQ
         UEkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719856130; x=1720460930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9hJtkxojM0mCUIGf1og2Qw2ek37F+Q427CZ4vFrsP08=;
        b=sbP1Nx3TWCwIlGyxEVqOPQtOP/E9rbSx3QXqGR8vq6a5M88rErUYk02YpPg2Fruzn6
         26M6f69hcXqgSZ2cROVDKWiG+5c150zzVsz0dfTQD4NnQABE12ojzMAvAAppiOkET+Cx
         asKnlfTN5GxxH73P6g5FfTupFcrLIbmHJWDKuVUJ3ykNrerK05Cq0FZ9q8wm/yYWslaD
         OrK1yoJ7DxkbNnrNGeXxvaUCg8T2otsyEfpEQRty8QJ5KEFLK5ShuC1VCYWYxaBCHQGz
         brmusbKizplVn6UrbENpcaEe8tdgxyN83gI4Y9EDrWhdO2b8chSCIMQxEfrXde5ZRSBF
         BqsA==
X-Forwarded-Encrypted: i=1; AJvYcCUfguq7nPDLFxzeMitL9lxPy3CSUeA0kAax0cgrjmrxpl69VLmiHDgvko2daRVNPMZN0NRPo7mbgtJamFEeXNkOqKvmOHkDdxk8QQ==
X-Gm-Message-State: AOJu0Yy2NIGT4fYEkJidUHy60ikCJP4TklEspg/s8D/vmZBEiNcM22yd
	6DESJ6z4yLM8qCuM6vqEUceK07z766Q7ydCD3mYwhEwpR0Z0HDV6GbtJ/g==
X-Google-Smtp-Source: AGHT+IEC6+QCqYJDT7LsCt1IfeZUejYgGyjAh8OE+ImZNeSqBLANk1GQlgGHE80ftUduaHOB5ThfGA==
X-Received: by 2002:a05:6214:ac5:b0:6b0:737f:534a with SMTP id 6a1803df08f44-6b5b70c2eb2mr112887336d6.27.1719856130520;
        Mon, 01 Jul 2024 10:48:50 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e5631bcsm35168986d6.32.2024.07.01.10.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 10:48:50 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	David Laight <david.laight@aculab.com>
Subject: [PATCH net-next] sctp: cancel a blocking accept when shutdown a listen socket
Date: Mon,  1 Jul 2024 13:48:49 -0400
Message-ID: <ee35ac9d519708ea0ba16f8288e42f215a0dbbcf.1719856129.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As David Laight noticed,

"In a multithreaded program it is reasonable to have a thread blocked in
 accept(). With TCP a subsequent shutdown(listen_fd, SHUT_RDWR) causes
 the accept to fail. But nothing happens for SCTP."

sctp_disconnect() is eventually called when shutdown a listen socket,
but nothing is done in this function. This patch sets RCV_SHUTDOWN
flag in sk->sk_shutdown there, and adds the check (sk->sk_shutdown &
RCV_SHUTDOWN) to break and return in sctp_accept().

Note that shutdown() is only supported on TCP-style SCTP socket.

Reported-by: David Laight <David.Laight@aculab.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c67679a41044..da299455cd10 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4834,10 +4834,14 @@ int sctp_inet_connect(struct socket *sock, struct sockaddr *uaddr,
 	return sctp_connect(sock->sk, uaddr, addr_len, flags);
 }
 
-/* FIXME: Write comments. */
+/* Only called when shutdown a listening SCTP socket. */
 static int sctp_disconnect(struct sock *sk, int flags)
 {
-	return -EOPNOTSUPP; /* STUB */
+	if (!sctp_style(sk, TCP))
+		return -EOPNOTSUPP;
+
+	sk->sk_shutdown |= RCV_SHUTDOWN;
+	return 0;
 }
 
 /* 4.1.4 accept() - TCP Style Syntax
@@ -4866,7 +4870,8 @@ static struct sock *sctp_accept(struct sock *sk, int flags, int *err, bool kern)
 		goto out;
 	}
 
-	if (!sctp_sstate(sk, LISTENING)) {
+	if (!sctp_sstate(sk, LISTENING) ||
+	    (sk->sk_shutdown & RCV_SHUTDOWN)) {
 		error = -EINVAL;
 		goto out;
 	}
@@ -9392,7 +9397,8 @@ static int sctp_wait_for_accept(struct sock *sk, long timeo)
 		}
 
 		err = -EINVAL;
-		if (!sctp_sstate(sk, LISTENING))
+		if (!sctp_sstate(sk, LISTENING) ||
+		    (sk->sk_shutdown & RCV_SHUTDOWN))
 			break;
 
 		err = 0;
-- 
2.43.0


