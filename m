Return-Path: <linux-sctp+bounces-266-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E9299331A
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Oct 2024 18:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 430991C23172
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Oct 2024 16:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3501DACA0;
	Mon,  7 Oct 2024 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiHE9oJ2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBE61D9A59;
	Mon,  7 Oct 2024 16:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318316; cv=none; b=tQpXGl46mpEb/o4wnvGm8duUKn235uuBp5YGyRT7NaHcsSGhu7ccRIs9oLryCFt4eIap8k7cp5NizyeH5hGsaeRA7wy+xCYmQxrnUvlQRRUn62fYEiUI41ptjgbpDjujr0uRpBRU1nHV4SEPd8jsqQqZS64EZWeO2t9EgmE8VFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318316; c=relaxed/simple;
	bh=5egQxFe/qBK3BoTXYTaQ6cBjx9+c4TK2O/BMmuHQ4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=He0fbYpLEKpqFLS6xtv/rR7vug0PqltAn5kG8XoBSxTqZTwFKYJMlkkfmLshjQ2uDP7QXFESMJ6GB0FloDKuW66NJgnGxUA0d22Q8yz8wL5Vrp8PwoGfmED1XIt1fwKZ9JKHkTKXo44gmwcXfa4+9JnBX4ymUrkCO6ZFwBjveMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiHE9oJ2; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-45cac3368f0so26811711cf.0;
        Mon, 07 Oct 2024 09:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728318313; x=1728923113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPIAb1EILedJgPiiQHoqwhll0+w67fSDIT9lxG+NwAo=;
        b=OiHE9oJ24sHn7UPvj7e5DPcr5RtX88DyZuqKSeqm5kf7AGQYKAZb2+E4ER9LN8FKW+
         +WyjY5qYxHjr0oVa0x6hz5Vh8Z65qXTju4deo3kaqFlGsESDjmHMRSxvH2yJpTlLcz2H
         NZ1ccOMbaoWdpr5Hs/PQxxO2Ha43MVltHbZyACmfNu17S7SrFyxzeoHj3rEVzai7Lo9m
         F3dtacs8BuFDHJ8cRFjkqam952N6r8V5niVfuGIytb5vm3Od0Je0op4q966WvYLeMjUJ
         rPdBPJ4TDDMwhQK7YU4+9n+pgSGa88bnj5iHFc9J2Ua6SeG2VJ7OwqCy8Q/Y0hQS1OtX
         po7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728318313; x=1728923113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPIAb1EILedJgPiiQHoqwhll0+w67fSDIT9lxG+NwAo=;
        b=aWAu+M6od4dBX4ufzmta3PYNOCYjLGp3WAuhCyiUdKMadQb9L39v+Z4FtCMoXaHOpK
         3V6o3puVyZ0jpiOAfeqypogEpF79C3yVvnVhpplcLRu96YtUvxlRXi/WfO3Tc7RhmIh8
         Ca8MRGD8GzAm0CbTVPFJIRMz86K/ayis+2rlb9cwjrEUKStI4XZA3edShAXm6kjdO71S
         CESWwCnWbEL/omP5c5nZNmTwaFk/3Mfp7ezUf5DrqXcF9SHXaQWKYGhQRlOUVntPkUid
         THdIF6prAeGQRxIahLZ9o+EXaFZ7FnQMk4Q1v02uZ2aSPE7QF4nTEg1Z0M1DHK4z8taU
         RAcg==
X-Forwarded-Encrypted: i=1; AJvYcCUp92jTPbkQqn+V/sqrzYOu8JVvJZ+lFjxFfGhrePHBALw5UbZGH4ddd5YLfieZgk7iOCR+G9mowJbr@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVBB/ODMbweCFqXBGoWr96cy5gvU7C0fHrarWo5gvi+ig6srm
	LdbK/t8xa04gm+67BOhG3k4ntPw/QiFTAZxs5sLJCEbfTvUQEbxOmS+7Cg==
X-Google-Smtp-Source: AGHT+IHpSV3SDRgPvnWlLxOoOzPtRo8yPtuDih9V79MSEnOP6P7GgJuJ5ffZDMcdip9WWq9Ur7ixog==
X-Received: by 2002:a05:622a:188b:b0:458:532c:1e6f with SMTP id d75a77b69052e-45d9bb13bf9mr199387671cf.55.1728318312914;
        Mon, 07 Oct 2024 09:25:12 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da75ed295sm27691421cf.68.2024.10.07.09.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 09:25:12 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: ensure sk_state is set to CLOSED if hashing fails in sctp_listen_start
Date: Mon,  7 Oct 2024 12:25:11 -0400
Message-ID: <43b03d2daa303fee1995f6b16f5003a1fc0599bf.1728318311.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hashing fails in sctp_listen_start(), the socket remains in the
LISTENING state, even though it was not added to the hash table.
This can lead to a scenario where a socket appears to be listening
without actually being accessible.

This patch ensures that if the hashing operation fails, the sk_state
is set back to CLOSED before returning an error.

Note that there is no need to undo the autobind operation if hashing
fails, as the bind port can still be used for next listen() call on
the same socket.

Fixes: 76c6d988aeb3 ("sctp: add sock_reuseport for the sock in __sctp_hash_endpoint")
Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 078bcb3858c7..36ee34f483d7 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8531,6 +8531,7 @@ static int sctp_listen_start(struct sock *sk, int backlog)
 	struct sctp_endpoint *ep = sp->ep;
 	struct crypto_shash *tfm = NULL;
 	char alg[32];
+	int err;
 
 	/* Allocate HMAC for generating cookie. */
 	if (!sp->hmac && sp->sctp_hmac_alg) {
@@ -8558,18 +8559,25 @@ static int sctp_listen_start(struct sock *sk, int backlog)
 	inet_sk_set_state(sk, SCTP_SS_LISTENING);
 	if (!ep->base.bind_addr.port) {
 		if (sctp_autobind(sk)) {
-			inet_sk_set_state(sk, SCTP_SS_CLOSED);
-			return -EAGAIN;
+			err = -EAGAIN;
+			goto err;
 		}
 	} else {
 		if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
-			inet_sk_set_state(sk, SCTP_SS_CLOSED);
-			return -EADDRINUSE;
+			err = -EADDRINUSE;
+			goto err;
 		}
 	}
 
 	WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
-	return sctp_hash_endpoint(ep);
+	err = sctp_hash_endpoint(ep);
+	if (err)
+		goto err;
+
+	return 0;
+err:
+	inet_sk_set_state(sk, SCTP_SS_CLOSED);
+	return err;
 }
 
 /*
-- 
2.43.0


