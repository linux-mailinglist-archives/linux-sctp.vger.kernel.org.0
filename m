Return-Path: <linux-sctp+bounces-772-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3B7D1A891
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Jan 2026 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5822301D0CA
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Jan 2026 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7833E34C;
	Tue, 13 Jan 2026 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxhl/Cgs"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com [209.85.222.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6E9288522
	for <linux-sctp@vger.kernel.org>; Tue, 13 Jan 2026 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324231; cv=none; b=lZUyYbxAZIMWUlhNo2UeCNbTlChrTLobvP4XEHicGxDmMnZI8rjzyvN1XTAvAlpT2/lgGRowdvzcIs2DWFbNJ/1tZG1adR1gJ04U6FdN8uGTxwqTQxEQ2sRRHDLz/CXLKyS8SPnU9RDyhXL4c+q1AVDnYtZns/z0T6658WK0yRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324231; c=relaxed/simple;
	bh=s9GLKMja2Fy99G8J8FP4C9B69+dV2cdS2sZsFGiO6ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wl8LqWeEBaahqoC/PzMP09sr+sobzqCTNrIPj2AOi79ZPBgmZJ9bhJWFRk6qRvIDw6uehZl6uwhlGfGMss+cxyIWKHmeJbugdd990XGf9hKNcy5NiSwbR0W5wXiXlzAMjB3CFqwFwxLE3iF0kC+XKl+LIJPdkY4Suhf5Z88eugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxhl/Cgs; arc=none smtp.client-ip=209.85.222.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f194.google.com with SMTP id af79cd13be357-8c0f13e4424so784852185a.1
        for <linux-sctp@vger.kernel.org>; Tue, 13 Jan 2026 09:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768324229; x=1768929029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PrXGZ1DMbIgC2clANmGoPNjpFNGYeb4SbcEZ9RK3BLQ=;
        b=mxhl/CgsJ3MXA53RDZmZ/nv4O51thVbeJy7l+czn3alNoe8pPSPSXzitZdEzIBeOYz
         UBXdGII7HP6VD1uqbZnQZUK8LEHx2RuYrzDvu5g+gQEMpeBDhqjBUiMFdFqUAF2FgX+W
         US1C+41cJOX3wAuFCfRLrd9XksFWPPDHC2akDhs6hPU+wOR6sNG4O4oGRge3acqp5u4p
         culBXDEaW9GP5tBKb8YCcsgVcYXdMVeeDStuo1c/+hs9tuxNoHwKtJrlJLq8TaYHriKe
         GlVKXL8clSZKHTC0iktoPPwoOsEaf8neF5Gs1y9hZMMRGlt1WKPQvi4nwgmVcHbVPVCu
         pCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768324229; x=1768929029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrXGZ1DMbIgC2clANmGoPNjpFNGYeb4SbcEZ9RK3BLQ=;
        b=Jz4bKP+M4Rq1z5g+otPSBFqZngxz1oLLktYpAGA/rdH5wNVYE91qqA402wNRXfo1Sv
         zrqHXkALIkGH3PGHGTWlypUjzlJ+bRHceAnxWR87kl8O0tHKSWhWTMWL/aFhjjaUqo4n
         GIxZj0yedfZtHc676LWUWyvWgRwYyUWJNcZrOvZEUsxsQv5CLqQKylSsMcMGmod7gImt
         HMqFriSY4fFdC1loCKOtSfTqzjPdsXw4bUcsdhRYdqFN9Q0GTH9MCYy4NVVZw75rGopf
         2A01FbO+ZX/HGO4+5cWgraWd88rbUx0xqWRp3oqsLv4MNEXmL0Z3YDnMAAKvTukDfEdA
         Goaw==
X-Forwarded-Encrypted: i=1; AJvYcCXEt4208xAe45fkRN9LOpr8GRsOR7rt33ohPLkjzWYoFziRvImvY70S7Vb7IcjfGQDiy2Pd3juXb11c@vger.kernel.org
X-Gm-Message-State: AOJu0YwmO7ofq5CukhP6DiWO+iw9LKi8MxwJ5yHEbV+hMDPUFq3bfj1q
	nhkyECnjmwhNBWvqFRrG597Ga1uG78KnUskKb8zO/fNCzqaoSchcTkrB
X-Gm-Gg: AY/fxX66bzJgYXTa8+ffJ50qSwThdlGK8RBJfmKyFhTi8q7TpNNGfFMIqFR6EHYEcv5
	mJgaAyqnV1AQoVM/i/YUtPVzyfwodC6gbWU8LlXa12UbKdk6GnbjsqupAgzuCBKhfOIctyaN7a4
	dyhc+oIzwdWmJyKwPHiBqLRdGjoXtDsmQW+Kb4VDj3PaU5Q/an0hUDB6d4Q0xujnxxWFi9kPuK9
	9J9U8FTutLOm0COCivbmm6GPraVfeLF/BJwX3e4MrdDBB63F5gbkJQL50ZpPTisqydOAvMTak98
	b2G6+vr3pW7Mi98ffVwBeIF7rcx9l4V112Mg0CzIbiyGiGS/vebDclXWod6OyfAx7wBuc5EeBIb
	TpoOtUBFf6Us1ELLi42pf9kZ0rYokx+ShABiYjfF7c5yIw/6meZxL/KxVHi17HblN98p7cUDgWM
	ao32aYOaX1lVUf8yMT6yyz9MVEUU294hVG7TxGBa+qntjgTM0j0W8=
X-Google-Smtp-Source: AGHT+IGqh4/UAR4oVXOwSRlhzxaXAft0b57DXpVe0H0Ph+lJu8HDpm9mVmoeISXiuN1DsF3WTZANQA==
X-Received: by 2002:a05:620a:2a01:b0:89e:f83c:ee0c with SMTP id af79cd13be357-8c389417b88mr3161605985a.74.1768324229084;
        Tue, 13 Jan 2026 09:10:29 -0800 (PST)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51d06fsm1723280985a.32.2026.01.13.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 09:10:28 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Zhen Chen <chenzhen126@huawei.com>
Subject: [PATCH net] sctp: move SCTP_CMD_ASSOC_SHKEY right after SCTP_CMD_PEER_INIT
Date: Tue, 13 Jan 2026 12:10:26 -0500
Message-ID: <44881224b375aa8853f5e19b4055a1a56d895813.1768324226.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A null-ptr-deref was reported in the SCTP transmit path when SCTP-AUTH key
initialization fails:

  ==================================================================
  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  CPU: 0 PID: 16 Comm: ksoftirqd/0 Tainted: G W 6.6.0 #2
  RIP: 0010:sctp_packet_bundle_auth net/sctp/output.c:264 [inline]
  RIP: 0010:sctp_packet_append_chunk+0xb36/0x1260 net/sctp/output.c:401
  Call Trace:

  sctp_packet_transmit_chunk+0x31/0x250 net/sctp/output.c:189
  sctp_outq_flush_data+0xa29/0x26d0 net/sctp/outqueue.c:1111
  sctp_outq_flush+0xc80/0x1240 net/sctp/outqueue.c:1217
  sctp_cmd_interpreter.isra.0+0x19a5/0x62c0 net/sctp/sm_sideeffect.c:1787
  sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
  sctp_do_sm+0x1a3/0x670 net/sctp/sm_sideeffect.c:1169
  sctp_assoc_bh_rcv+0x33e/0x640 net/sctp/associola.c:1052
  sctp_inq_push+0x1dd/0x280 net/sctp/inqueue.c:88
  sctp_rcv+0x11ae/0x3100 net/sctp/input.c:243
  sctp6_rcv+0x3d/0x60 net/sctp/ipv6.c:1127

The issue is triggered when sctp_auth_asoc_init_active_key() fails in
sctp_sf_do_5_1C_ack() while processing an INIT_ACK. In this case, the
command sequence is currently:

- SCTP_CMD_PEER_INIT
- SCTP_CMD_TIMER_STOP (T1_INIT)
- SCTP_CMD_TIMER_START (T1_COOKIE)
- SCTP_CMD_NEW_STATE (COOKIE_ECHOED)
- SCTP_CMD_ASSOC_SHKEY
- SCTP_CMD_GEN_COOKIE_ECHO

If SCTP_CMD_ASSOC_SHKEY fails, asoc->shkey remains NULL, while
asoc->peer.auth_capable and asoc->peer.peer_chunks have already been set by
SCTP_CMD_PEER_INIT. This allows a DATA chunk with auth = 1 and shkey = NULL
to be queued by sctp_datamsg_from_user().

Since command interpretation stops on failure, no COOKIE_ECHO should been
sent via SCTP_CMD_GEN_COOKIE_ECHO. However, the T1_COOKIE timer has already
been started, and it may enqueue a COOKIE_ECHO into the outqueue later. As
a result, the DATA chunk can be transmitted together with the COOKIE_ECHO
in sctp_outq_flush_data(), leading to the observed issue.

Similar to the other places where it calls sctp_auth_asoc_init_active_key()
right after sctp_process_init(), this patch moves the SCTP_CMD_ASSOC_SHKEY
immediately after SCTP_CMD_PEER_INIT, before stopping T1_INIT and starting
T1_COOKIE. This ensures that if shared key generation fails, authenticated
DATA cannot be sent. It also allows the T1_INIT timer to retransmit INIT,
giving the client another chance to process INIT_ACK and retry key setup.

Fixes: 730fc3d05cd4 ("[SCTP]: Implete SCTP-AUTH parameter processing")
Reported-by: Zhen Chen <chenzhen126@huawei.com>
Tested-by: Zhen Chen <chenzhen126@huawei.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 3755ba079d07..7b823d759141 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -603,6 +603,11 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	sctp_add_cmd_sf(commands, SCTP_CMD_PEER_INIT,
 			SCTP_PEER_INIT(initchunk));
 
+	/* SCTP-AUTH: generate the association shared keys so that
+	 * we can potentially sign the COOKIE-ECHO.
+	 */
+	sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
+
 	/* Reset init error count upon receipt of INIT-ACK.  */
 	sctp_add_cmd_sf(commands, SCTP_CMD_INIT_COUNTER_RESET, SCTP_NULL());
 
@@ -617,11 +622,6 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_STATE,
 			SCTP_STATE(SCTP_STATE_COOKIE_ECHOED));
 
-	/* SCTP-AUTH: generate the association shared keys so that
-	 * we can potentially sign the COOKIE-ECHO.
-	 */
-	sctp_add_cmd_sf(commands, SCTP_CMD_ASSOC_SHKEY, SCTP_NULL());
-
 	/* 5.1 C) "A" shall then send the State Cookie received in the
 	 * INIT ACK chunk in a COOKIE ECHO chunk, ...
 	 */
-- 
2.47.1


