Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A05C6FE0A9
	for <lists+linux-sctp@lfdr.de>; Wed, 10 May 2023 16:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbjEJOnb (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 10 May 2023 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbjEJOna (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 10 May 2023 10:43:30 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33509BC
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 07:43:28 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20ACB3F232
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 14:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683729805;
        bh=VsRr4UycG64Ad7Wwitdyuus/KJ2GRNbGK68qU7i6U64=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=u6c3Bipv+fkr+z/cQj+1sVFQAt43+F1JQc4xPZf+2jzqntjXC09X55Nh0ybd0rud5
         XIGNEyL+sqqwseHVHt+ARV/vg4VyQpRLkUNgR+E6FyOx4lGrPjXdVX5M3J7nprYCAQ
         GXr/6AgcHmmU0+VNzyNLP8rENoB6YfhU50l5O85JAN+qy5CHrL3rmfRnDP+KWH8RTS
         rkxMI+u8qdqOon0xk2yXdS06KZp4nCir8dqSr9jetNbrEFGTc1lOPnJcJnerzcpxQF
         1+Fb01mm/rHdEI1K9ML7hyVzzu05fWQniHFU2jDd8ymjRAPHK7ts00WZosoqkZ38di
         Q5lIYL1GIAdAQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso709716066b.3
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 07:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683729804; x=1686321804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsRr4UycG64Ad7Wwitdyuus/KJ2GRNbGK68qU7i6U64=;
        b=FGaEWZPak6tUIbEcqwB78Ua6b/o5gQE6aPLIoO3syzoYirhbsa7Uz6SmfD/OOPQfLV
         z9kcRLp8p34ETFV6KfCuVGtkx7Z88NNcJFWVyEwz+YMW54h0DtDUkeiiyipYD9wx0DuZ
         YtZT6cmJGz/whGXVjMPNJLHtfi5nOQbU4S931RtgpjW4h2vAkU6mDFpiJGRrRYcAm1PZ
         IvqaE2PAEtONX4tCajyH4xpelM26jj7/gqA358GwzQiNrGqJ+ka6YONamTihOWt3f7Sd
         F0d8eBzAu2YO5Q6J99YrkYwwIqCiAtXbp43jF9WprOAVEaqVgTFpX82vIrslp+qIZPVE
         hPkw==
X-Gm-Message-State: AC+VfDwiiGg26djeqiJEFz4wriD5qtN05Dsabp5Iv+hOI2h7D1XxnUjN
        JpKt5Ekv9taN841+eQ073WYbMHDBwFiSvtBoFoRXJJ+0m9/bPpkJmNbr4uA5xCYo3avcP/Eqoxj
        MlZ50CP+wkoT1kMO5wg11ey4u3t6WZEyG1EIU3lY=
X-Received: by 2002:a17:907:94cf:b0:8b8:c06e:52d8 with SMTP id dn15-20020a17090794cf00b008b8c06e52d8mr18552872ejc.36.1683729804688;
        Wed, 10 May 2023 07:43:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4p3WcCR9YYlvqH5FEUdsaxVk8iHhVqAwORD/x5tdhZuSVIvkPty0YtMpelRGfmwuLtWDzKFw==
X-Received: by 2002:a17:907:94cf:b0:8b8:c06e:52d8 with SMTP id dn15-20020a17090794cf00b008b8c06e52d8mr18552853ejc.36.1683729804415;
        Wed, 10 May 2023 07:43:24 -0700 (PDT)
Received: from amikhalitsyn.. (ip5f5bf3d5.dynamic.kabel-deutschland.de. [95.91.243.213])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b009659ecdf29fsm2753044ejc.1.2023.05.10.07.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 07:43:23 -0700 (PDT)
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
Subject: [PATCH net-next v2] sctp: add bpf_bypass_getsockopt proto callback
Date:   Wed, 10 May 2023 16:42:58 +0200
Message-Id: <20230510144258.1343471-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Add bpf_bypass_getsockopt proto callback and filter out
SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
from running eBPF hook on them.

These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
hook returns an error after success of the original handler
sctp_getsockopt(...), userspace will receive an error from getsockopt
syscall and will be not aware that fd was successfully installed into fdtable.

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
 net/sctp/socket.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index cda8c2874691..fed6057beb60 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8281,6 +8281,29 @@ static int sctp_getsockopt(struct sock *sk, int level, int optname,
 	return retval;
 }
 
+static bool sctp_bpf_bypass_getsockopt(int level, int optname)
+{
+	/*
+	 * These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
+	 * hook returns an error after success of the original handler
+	 * sctp_getsockopt(...), userspace will receive an error from getsockopt
+	 * syscall and will be not aware that fd was successfully installed into fdtable.
+	 *
+	 * Let's prevent bpf cgroup hook from running on them.
+	 */
+	if (level == SOL_SCTP) {
+		switch (optname) {
+		case SCTP_SOCKOPT_PEELOFF:
+		case SCTP_SOCKOPT_PEELOFF_FLAGS:
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
@@ -9650,6 +9673,7 @@ struct proto sctp_prot = {
 	.shutdown    =	sctp_shutdown,
 	.setsockopt  =	sctp_setsockopt,
 	.getsockopt  =	sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg     =	sctp_sendmsg,
 	.recvmsg     =	sctp_recvmsg,
 	.bind        =	sctp_bind,
@@ -9705,6 +9729,7 @@ struct proto sctpv6_prot = {
 	.shutdown	= sctp_shutdown,
 	.setsockopt	= sctp_setsockopt,
 	.getsockopt	= sctp_getsockopt,
+	.bpf_bypass_getsockopt	= sctp_bpf_bypass_getsockopt,
 	.sendmsg	= sctp_sendmsg,
 	.recvmsg	= sctp_recvmsg,
 	.bind		= sctp_bind,
-- 
2.34.1

