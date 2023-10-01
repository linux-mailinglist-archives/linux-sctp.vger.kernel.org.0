Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE167B483A
	for <lists+linux-sctp@lfdr.de>; Sun,  1 Oct 2023 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjJAO6v (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 1 Oct 2023 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjJAO6u (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 1 Oct 2023 10:58:50 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C8D8;
        Sun,  1 Oct 2023 07:58:48 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77574c5979fso394416685a.3;
        Sun, 01 Oct 2023 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696172327; x=1696777127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WrI6RpIrqVuIa48OQB1Vt0FW7P6Aq30k8ni6NH75sUo=;
        b=T/UIT4XqhHncUQIfe2Mq92yIrkE8J96ervWfX7cUyMYVixrww5q4SDaE24A73UWh6j
         NeSq8wD4C0+3+N7LHLiQlRH+qhIxcw7IyomnJCA8u/N4c6uy1urnfqbirVb55GsP1A8R
         T5517O4rBwf8iNRQ/Sk5C7REVICKw4EOSADHdLhLkiaXNaSrQZTF9Rz7QSDt4LGcoM+k
         nHrWDW91a6InO6947cs4yNntoR8gZqW6wvx7D890QBCRm0D8h++4A6GUfHwXOVcsbpq0
         KoAgLgZuNo1frASvfE4CGmj9kTPajp9Ok6XZixzqlCYe1mBkcRB8KLb2LOuS4rkcgeO7
         VmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696172327; x=1696777127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WrI6RpIrqVuIa48OQB1Vt0FW7P6Aq30k8ni6NH75sUo=;
        b=PJo2G7dRrDcYokjNCHaCArgq+Z7dcAtWJLb85/zKrf6PmfiNLAswEF+2aYK1mqR9Eo
         SNBqYpFLugN2CzlGbm3apJPoCRs6MQQx8VSXMzsa7QECgUDutdrB7HRFtottGT99JlPG
         hEtJcSL+wRmx6pfI6HpwWloj6/l/tCqbtL/FZae7JBjeiM/dBiLINq3kogkwIH5hz1tT
         r44sZtYRzI4zlFcSKxwwQdPA94XcwvfFFrz3XG4oIJlRvO5tEf4EJDFJ+J4q3VCozZiL
         lt3fue3vSpuwfvrFi7zQYisceWm3BOe9IUi8qy9WzrGxrMGtnCan3mKkJ+2btWFrSAnu
         YhNg==
X-Gm-Message-State: AOJu0YwKMjSkOTJdW31U40L8Rwe+N1Ixhdrz2FsV9X2dUDVNIsVogKZg
        8Y5TQVwuJvFcLsMbyb2KDEMANY0o9YE=
X-Google-Smtp-Source: AGHT+IF+rf63I+D2dTM2buA26z3TgY/WyvsptCCY3AGvNupSB7fj0LDf6oz5FrfrhH4ycck1lmRvAg==
X-Received: by 2002:a05:620a:21c1:b0:774:ba1:ef44 with SMTP id h1-20020a05620a21c100b007740ba1ef44mr9076230qka.70.1696172327124;
        Sun, 01 Oct 2023 07:58:47 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d24-20020a05620a159800b0076ef0fb5050sm1890674qkk.31.2023.10.01.07.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 07:58:46 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: update transport state when processing a dupcook packet
Date:   Sun,  1 Oct 2023 10:58:45 -0400
Message-Id: <fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

During the 4-way handshake, the transport's state is set to ACTIVE in
sctp_process_init() when processing INIT_ACK chunk on client or
COOKIE_ECHO chunk on server.

In the collision scenario below:

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
    192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]

when processing COOKIE_ECHO on 192.168.1.2, as it's in COOKIE_WAIT state,
sctp_sf_do_dupcook_b() is called by sctp_sf_do_5_2_4_dupcook() where it
creates a new association and sets its transport to ACTIVE then updates
to the old association in sctp_assoc_update().

However, in sctp_assoc_update(), it will skip the transport update if it
finds a transport with the same ipaddr already existing in the old asoc,
and this causes the old asoc's transport state not to move to ACTIVE
after the handshake.

This means if DATA retransmission happens at this moment, it won't be able
to enter PF state because of the check 'transport->state == SCTP_ACTIVE'
in sctp_do_8_2_transport_strike().

This patch fixes it by updating the transport in sctp_assoc_update() with
sctp_assoc_add_peer() where it updates the transport state if there is
already a transport with the same ipaddr exists in the old asoc.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/associola.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 796529167e8d..c45c192b7878 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1159,8 +1159,7 @@ int sctp_assoc_update(struct sctp_association *asoc,
 		/* Add any peer addresses from the new association. */
 		list_for_each_entry(trans, &new->peer.transport_addr_list,
 				    transports)
-			if (!sctp_assoc_lookup_paddr(asoc, &trans->ipaddr) &&
-			    !sctp_assoc_add_peer(asoc, &trans->ipaddr,
+			if (!sctp_assoc_add_peer(asoc, &trans->ipaddr,
 						 GFP_ATOMIC, trans->state))
 				return -ENOMEM;
 
-- 
2.39.1

