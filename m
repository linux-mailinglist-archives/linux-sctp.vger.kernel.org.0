Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9931B4D080B
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Mar 2022 20:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbiCGUAf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 7 Mar 2022 15:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiCGUAe (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 7 Mar 2022 15:00:34 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA676A026
        for <linux-sctp@vger.kernel.org>; Mon,  7 Mar 2022 11:59:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bi12so21296109ejb.3
        for <linux-sctp@vger.kernel.org>; Mon, 07 Mar 2022 11:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7heHLDszBS548TlGCq/TmQ4cqmwmdx1VZ/2V7ZjXNY=;
        b=vUVXwub0FDv3yy/CM2XPUvUeZbqoT+oOMUvxHQLhnZaMXCmD5Wb1rV9LyKxs7ANaFj
         3G5cF3zmh8O9mHN4wI4mBOsLquoDwHeMc/LWMi8fOsYkBD2mVy/kovUHUv6eTo8rQeW/
         piXKY2I13OBmdlGofA/Wqs64Hkr9zbydQPNUrhQ/4WbagdkyQRUUtbO5YGYbARvlMVc0
         AJ6a58hLwyiOeaNa609MP0sGT01E8rdZbfsHZT730HRx+bHyKpck6IStGeiwvkkSnnIH
         7RW18EGcAMVur/EeuZpPFqsIR4fg9roHXHChFPxq94rtjc15AQXroFAkGARqd1tqFIN6
         Eimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T7heHLDszBS548TlGCq/TmQ4cqmwmdx1VZ/2V7ZjXNY=;
        b=0k5YDi8n0Zxe26YBUbQvxSSen9BvuNT3bB8L+TsUHEfKil9BwfbCluwVm1SqBBCAk/
         wTfdn899ZK+fa7w2I6SKQMcb3xXHAyDM5EvbON1IZQqMk0VLWGfeGpWt1ALJqw1iWv6O
         YD6e3g++tO+uZzxhYzEItcXRH/2Izpe4ENEOmm9vwSuotA+7D3MX+VNY3u3mml6nwdRU
         nWl+pxjmIP2r/utSFdWZUggpZsL7gSOUjkud6Elt9ewJZ9ZsYJDj3XRloMYEshLUGhAC
         Dd+ycTkUTiN5pxSuBljqZ80VJ0saW0fmfRpO4rhKze2pIOoqyMGe95JmF3aBNIKUxwj1
         ZDVA==
X-Gm-Message-State: AOAM531a/A6tx7Ci4l/JOI3voREsPp7pE6f82BnxR0Z/U4OBikG4l21Q
        b8yYsdy4B53YNAJIi30U1lCarnGCLULXm0PLSKdqfA==
X-Google-Smtp-Source: ABdhPJwLihVUpNrKiia1Z9+0mOzDibdjFI6iYVBJhejsu/ZW2KYTis+atz5fhWggd3GG4krHVCjBrQ==
X-Received: by 2002:a17:906:edbd:b0:6b6:bd54:235c with SMTP id sa29-20020a170906edbd00b006b6bd54235cmr10466461ejb.363.1646683177674;
        Mon, 07 Mar 2022 11:59:37 -0800 (PST)
Received: from ntb.petris.klfree.czf ([2a02:8070:d482:2400:3f75:1b29:d53e:cbdb])
        by smtp.googlemail.com with ESMTPSA id si13-20020a170906cecd00b006cded0c5ee2sm5123100ejb.61.2022.03.07.11.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 11:59:37 -0800 (PST)
From:   Petr Malat <oss@malat.biz>
To:     linux-sctp@vger.kernel.org
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Petr Malat <oss@malat.biz>
Subject: [PATCH] sctp: Initialize daddr on peeled off socket
Date:   Mon,  7 Mar 2022 20:59:29 +0100
Message-Id: <20220307195929.621359-1-oss@malat.biz>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Function sctp_do_peeloff() wrongly initializes daddr of the original
socket instead of the peeled off one, which makes getpeername() return
zeroes instead of the primary address. Initialize the new socket
instead.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 3e1a9600be5e..7b0427658056 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5636,7 +5636,7 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sockp)
 	 * Set the daddr and initialize id to something more random and also
 	 * copy over any ip options.
 	 */
-	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sk);
+	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sock->sk);
 	sp->pf->copy_ip_options(sk, sock->sk);
 
 	/* Populate the fields of the newsk from the oldsk and migrate the
-- 
2.30.2

