Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4886F7B4848
	for <lists+linux-sctp@lfdr.de>; Sun,  1 Oct 2023 17:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjJAPE1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 1 Oct 2023 11:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbjJAPE0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 1 Oct 2023 11:04:26 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D71DA;
        Sun,  1 Oct 2023 08:04:23 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4197310af61so21112031cf.3;
        Sun, 01 Oct 2023 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696172662; x=1696777462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SX+t+M7+v49lWi6HHo3wnx6X5ASvWTDpAtnD2Miku4s=;
        b=ER3xEIa0cwhi+5qIqYpwujaYUZtHVQUAc/7amoIAuHEdbqU9woc/L3z1i3079u27/D
         BJV/bn8kEj9lwxXZRmRTsaVmBR/HdPpBsIA42BEKSMrhNcd3NYIDfka2AxiZNLd4TznE
         ZC4NLgdtfh/GDs9kXldOAqpPewGy2EUYUC8jZW8xRMqdNvvxe3id5f3DaYsiuqFp/AUn
         gsQ/OsBJaB8rKMM5g+kfQwvZJe3l2PuPvnhZU+PcdSA3vFJESby3wyHAhXmv1vQgTtor
         /ejO0F/B2ikA2dWLOxJJ75hpZtmWG7wKm2VYb5t4FVvTJ19LfSjuKihsgpYCeYiocy2p
         3hnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696172662; x=1696777462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SX+t+M7+v49lWi6HHo3wnx6X5ASvWTDpAtnD2Miku4s=;
        b=ImlU6mdFiU3r44PK5pUoQUVUrFVOHNLTpDijPdp8iCM72A5L8V89Nh2a/cpa7ZLGuA
         OhrSqcnqYV5gsu7mtpYY9zI1V2FdtdsNpI/bncxbQT3ncEafHOCHNLMUdSxkOhBEgamf
         yTkp6tjJt0/IqnQKKKeRYOlFgfn9DNyW4CQdDPdoheAUwAfYdqVljDQRUm/brYtmC9oj
         2J6qccSm0zkEsz75n1LUu8y6IoAZCjxTytHcnaSVARFOTKUzs2IUQZJqnA2Bd3/vKQOr
         U4D7aLwz55LzSpqzACuXfndOPHuGAft95hsSxyNhZ1URp7x52npiUd++HSFGkVFVnD1d
         bN8w==
X-Gm-Message-State: AOJu0Yz2CinylXtDnAAc4xJYq+hgzqeqhx4f66w/kfV5+rGliXnjlWk0
        wQ5kbokKk9euhxczSsItX+sIqAMZfPLjLQ==
X-Google-Smtp-Source: AGHT+IE2k5uRvNwn3dERsGEQ8ATuEQehvaH0fn2M0/qQxKFKFIzGBo4UhFMiVTMZ9G6QKwln9Hz0eg==
X-Received: by 2002:a05:622a:1704:b0:412:1e51:8fef with SMTP id h4-20020a05622a170400b004121e518fefmr12187264qtk.30.1696172661941;
        Sun, 01 Oct 2023 08:04:21 -0700 (PDT)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w19-20020ac86b13000000b00417f330026bsm7477825qts.49.2023.10.01.08.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 08:04:21 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xufeng Zhang <xufeng.zhang@windriver.com>
Subject: [PATCH net] sctp: update hb timer immediately after users change hb_interval
Date:   Sun,  1 Oct 2023 11:04:20 -0400
Message-Id: <75465785f8ee5df2fb3acdca9b8fafdc18984098.1696172660.git.lucien.xin@gmail.com>
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

Currently, when hb_interval is changed by users, it won't take effect
until the next expiry of hb timer. As the default value is 30s, users
have to wait up to 30s to wait its hb_interval update to work.

This becomes pretty bad in containers where a much smaller value is
usually set on hb_interval. This patch improves it by resetting the
hb timer immediately once the value of hb_interval is updated by users.

Note that we don't address the already existing 'problem' when sending
a heartbeat 'on demand' if one hb has just been sent(from the timer)
mentioned in:

  https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg590224.html

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index ab943e8fb1db..7f89e43154c0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -2450,6 +2450,7 @@ static int sctp_apply_peer_addr_params(struct sctp_paddrparams *params,
 			if (trans) {
 				trans->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
+				sctp_transport_reset_hb_timer(trans);
 			} else if (asoc) {
 				asoc->hbinterval =
 				    msecs_to_jiffies(params->spp_hbinterval);
-- 
2.39.1

