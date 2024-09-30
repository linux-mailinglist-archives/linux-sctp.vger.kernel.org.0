Return-Path: <linux-sctp+bounces-261-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D0C98AEB0
	for <lists+linux-sctp@lfdr.de>; Mon, 30 Sep 2024 22:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4EAF1F23E46
	for <lists+linux-sctp@lfdr.de>; Mon, 30 Sep 2024 20:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C190519E965;
	Mon, 30 Sep 2024 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU4lIq0q"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588491925A2;
	Mon, 30 Sep 2024 20:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727729396; cv=none; b=ToK3odpTJjuYviKF/TnMBbe82uNzwntmze3ANCMq9QJOjXqg9J5N35sfFfUvqvfzKy5eoa8sp3PuIuuEA2onYq+dWCle9PGDqoEn2JVwzbwq3dmn4mnRv9+SY+4bfC2Nc7Q6rWTienrQ0t53O1e6E+17OkL1pMt8aMTNu2iujys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727729396; c=relaxed/simple;
	bh=rFTPHK5eli7T04ahe1X129NVHyn2mdU+a1b/ry+xQ98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvpgsXISZoLkK7JwhF88bGCs9tpPivagM5YHgpDzAg+RhuuNxZ2Rj+eG8Wv4lU/PwotDzVzIzGscPRI7sP48VLHtNqSN48Y7YD/KspQnvZMEQKJTMTEtQC4Q6LJONLrS6Hc0fY0SJUaDFHBMaU2n7VWYZ9q6aeewRbFqgecUIN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU4lIq0q; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db233cef22so3990615a12.0;
        Mon, 30 Sep 2024 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727729394; x=1728334194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wKzPaZZROtd3eMqdj82XE/tWk5OI6WSi2v0PvqZKDg=;
        b=NU4lIq0qDBlJn6lfLnsmele8qC2EHpnClVZAAdbkFzzkF1hUnW/OsGAl9xfM8P+BlF
         sjwBPxiWB7fXVDZemmtAYOR8QysqyGEqrwkMHRliUkkt/1R5Ua+DwuLiht8BRxRP2yjF
         cGnY5mzhHbPdWeZ4D+yZyHVylCXAOXpSrzgxbac+7dHvqROUjZUOb7xIWCNzZr8mzCXJ
         zuYRHqXuxzkeV5Tn4p/Lhlejd2cmx8ogSp5SKWRuYNC8Lj9YoNydZDW6MpBhHNKibheR
         9S0VYe1aa5J6eQw1IAB9HSCkmiipMDSV6XjMGW/Jhz7J7/hIK5W90LIkbW6cr29oH2If
         8VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727729394; x=1728334194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wKzPaZZROtd3eMqdj82XE/tWk5OI6WSi2v0PvqZKDg=;
        b=CYTHA2NpzTEfA62nWdE43nbljatJX17ymDozJgOFHcNfTyg3B6b6R/VWaunVZRp850
         agRzE40qH+ouF57Us69x41cTQ+ZUV2lVRd60gcp+g94sDoLRLaiuU4Y5RT/Q2xaiit43
         X+3YREVdcdt4DN6H2YsfpU73cr2j7w1gNfquHIT4yklYx8WPcNWFkFnRjMqDSOM3WCxE
         CVeAbFEswJGq7GsN1ubs8v6e9Qxg2hmG4sq+cdkqOZcZ84a+mhIZMiaD2cxILBjetNHJ
         lnScnHyzYf42gfE//4LTaajQpgFLjm3V3tM31htEd1jzDDK53+hqXBWbbX7y16psM9Dp
         ZZng==
X-Forwarded-Encrypted: i=1; AJvYcCVSZSOIHxFTLPH6pF2hwzSt9g7FsxtdE4lgSqpdTw6J3qZ5Tl+h7eQBL5ZFp5/YcysEBr/ssMWOrJ90@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0Dn+bHvxcxTPETBiTBXqPq87hNw/krzboU86LiOrD2nIkmAX
	yiZ5WrRvl6amQLircTYiSKjJfRi0UOfNqSKtGnpNwveSymuuObTe+doGSA==
X-Google-Smtp-Source: AGHT+IF3Udt39AQiFQMVvaR/LN1TxUvQvHsFDkk2HvgWD98N7MZSD+6f8/UmfpqDpHNMfkC39PFHEA==
X-Received: by 2002:a05:6a21:390:b0:1d3:292a:2f7c with SMTP id adf61e73a8af0-1d4fa7ab370mr20195179637.49.1727729394353;
        Mon, 30 Sep 2024 13:49:54 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652b5b3sm6667756b3a.161.2024.09.30.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:49:54 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
Date: Mon, 30 Sep 2024 16:49:51 -0400
Message-ID: <a93e655b3c153dc8945d7a812e6d8ab0d52b7aa0.1727729391.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In sctp_listen_start() invoked by sctp_inet_listen(), it should set the
sk_state back to CLOSED if sctp_autobind() fails due to whatever reason.

Otherwise, next time when calling sctp_inet_listen(), if sctp_sk(sk)->reuse
is already set via setsockopt(SCTP_REUSE_PORT), sctp_sk(sk)->bind_hash will
be dereferenced as sk_state is LISTENING, which causes a crash as bind_hash
is NULL.

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
  Call Trace:
   <TASK>
   __sys_listen_socket net/socket.c:1883 [inline]
   __sys_listen+0x1b7/0x230 net/socket.c:1894
   __do_sys_listen net/socket.c:1902 [inline]

Fixes: 5e8f3f703ae4 ("sctp: simplify sctp listening code")
Reported-by: syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 32f76f1298da..078bcb3858c7 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8557,8 +8557,10 @@ static int sctp_listen_start(struct sock *sk, int backlog)
 	 */
 	inet_sk_set_state(sk, SCTP_SS_LISTENING);
 	if (!ep->base.bind_addr.port) {
-		if (sctp_autobind(sk))
+		if (sctp_autobind(sk)) {
+			inet_sk_set_state(sk, SCTP_SS_CLOSED);
 			return -EAGAIN;
+		}
 	} else {
 		if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
 			inet_sk_set_state(sk, SCTP_SS_CLOSED);
-- 
2.43.0


