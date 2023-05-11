Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166886FF2C5
	for <lists+linux-sctp@lfdr.de>; Thu, 11 May 2023 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238175AbjEKN2W (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 11 May 2023 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238177AbjEKN2E (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 11 May 2023 09:28:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD7110E65
        for <linux-sctp@vger.kernel.org>; Thu, 11 May 2023 06:26:36 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7DE113F486
        for <linux-sctp@vger.kernel.org>; Thu, 11 May 2023 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683811532;
        bh=ch7davOyHO5vzgs3WrwY5EQ2yT5MouTazclXi2xArF8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Eixv/6n6xkKXnRmjrsKMk28yxsKZvlJnrCsXE65Nwz7ifLofLuR8w0iSVGiK7Vt6/
         A2rVW5rkFG5kH7dlarJZz9pdkHYtoXtYQZRifezwYRhWwGyWd1xrOTq3M+IQIaoSLs
         ZpSKK0WqO3TjiEiSr+bwKwAsMMr7zktVZRu6FZ+YXv+ddUtfKmf8jSxa8JGEKFLNUz
         tPUWObtLN+r5bQEf51EW3YOxQ2JSux8NgT/cE8JH3hxDGg3lusbsDXFkaJHIMnbUuz
         esCs2yiqhoRbEmitF8Uw25nZQlVDZ2uR9xd+fzMbm/UYbs4KnG8hBUKGrN6zxZ+wVQ
         djkHZJI6lLVrw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50a094d5876so9689196a12.3
        for <linux-sctp@vger.kernel.org>; Thu, 11 May 2023 06:25:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683811531; x=1686403531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ch7davOyHO5vzgs3WrwY5EQ2yT5MouTazclXi2xArF8=;
        b=Dk763bu05Fvnyby4Qrk1eRKMd3WO1v+mPznoLGOArNm8l4biyFNs+c6GHLXcIGnrVg
         Ji1Czbq8hDcBYRX/Jq79PnQ/07ZbttTGuh4+oz+7Ay0Xz1qkrBtCYdLW3Zljar/AXaaP
         NwVP+jfFOrzL9qVp97JPtROm3S+4vapvpSDGEvtAL2a3PO/Ex5aIFHtldV+IzxuGPkXM
         Npfr/ci58cpDk0xl2njktdwzOgQyuqsnzSiXPnTryE9OZjoH3RMv4RYwNQ2ykmNXyF/o
         mbs1vGGcNxLH6uIJkCDDN2cT6ec3hYmph1mSXu56mTXxzmqJEpQ0aL1f1WKF0zB/Pxrb
         w/Sw==
X-Gm-Message-State: AC+VfDxFaKBtNSCBiXPaL4sDOKOHnjgMcKY3MEHa5KrxZYLLplARYDL/
        IM0gbcUpQdTDVuyhYaFz7YdSj8ISD6mNs3aRKPwUiP331+q6vtRJbKYxcpuMF+t+ZED4ltqmKU5
        rTua33xKzyk/zYhE0UV3kEjS1MhzHZ/loa0izREc=
X-Received: by 2002:a17:907:3d9f:b0:959:5454:1db7 with SMTP id he31-20020a1709073d9f00b0095954541db7mr21156771ejc.3.1683811531207;
        Thu, 11 May 2023 06:25:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xYBBCiS0F3m++AIGabvifZQOL5/jshhNMHmOdRosjw/dT+tJALMD25HPpXkwEl9AGcsMRMw==
X-Received: by 2002:a17:907:3d9f:b0:959:5454:1db7 with SMTP id he31-20020a1709073d9f00b0095954541db7mr21156743ejc.3.1683811530743;
        Thu, 11 May 2023 06:25:30 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bf3d5.dynamic.kabel-deutschland.de. [95.91.243.213])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906939300b0094e7d196aa4sm3936099ejx.160.2023.05.11.06.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 06:25:30 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     nhorman@tuxdriver.com
Cc:     davem@davemloft.net,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH net-next v3] sctp: add bpf_bypass_getsockopt proto callback
Date:   Thu, 11 May 2023 15:25:06 +0200
Message-Id: <20230511132506.379102-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Implement ->bpf_bypass_getsockopt proto callback and filter out
SCTP_SOCKOPT_PEELOFF, SCTP_SOCKOPT_PEELOFF_FLAGS and SCTP_SOCKOPT_CONNECTX3
socket options from running eBPF hook on them.

SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS options do fd_install(),
and if BPF_CGROUP_RUN_PROG_GETSOCKOPT hook returns an error after success of
the original handler sctp_getsockopt(...), userspace will receive an error
from getsockopt syscall and will be not aware that fd was successfully
installed into a fdtable.

As pointed by Marcelo Ricardo Leitner it seems reasonable to skip
bpf getsockopt hook for SCTP_SOCKOPT_CONNECTX3 sockopt too.
Because internaly, it triggers connect() and if error is masked
then userspace will be confused.

This patch was born as a result of discussion around a new SCM_PIDFD interface:
https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/

Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: linux-sctp@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Suggested-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v3: fix commit description and remove comments
v2: filter out SCTP_SOCKOPT_CONNECTX3
---
 net/sctp/socket.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index cda8c2874691..a68e1d541b12 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8281,6 +8281,22 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
 	return retval;
 }
 
+static bool sctp_bpf_bypass_getsockopt(int level, int optname)
+{
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		case SCTP_SOCKOPT_PEELOFF:
+		case SCTP_SOCKOPT_PEELOFF_FLAGS:
+		case SCTP_SOCKOPT_CONNECTX3:
+			return true;
+		default:
+			return false;
+		}
+	}
+
+	return false;
+}
+
 static int sctp_hash(struct sock *sk)
 {
 	/* STUB */
@@ -9650,6 +9666,7 @@ struct proto sctp_prot = {
 	.shutdown    =	sctp_shutdown,
 	.setsockopt  =	sctp_setsockopt,
 	.getsockopt  =	sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg     =	sctp_sendmsg,
 	.recvmsg     =	sctp_recvmsg,
 	.bind        =	sctp_bind,
@@ -9705,6 +9722,7 @@ struct proto sctpv6_prot = {
 	.shutdown	= sctp_shutdown,
 	.setsockopt	= sctp_setsockopt,
 	.getsockopt	= sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg	= sctp_sendmsg,
 	.recvmsg	= sctp_recvmsg,
 	.bind		= sctp_bind,
-- 
2.34.1

