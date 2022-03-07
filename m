Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1079D4D0A6F
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Mar 2022 23:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiCGWEO (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 7 Mar 2022 17:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbiCGWEN (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 7 Mar 2022 17:04:13 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308527FF4
        for <linux-sctp@vger.kernel.org>; Mon,  7 Mar 2022 14:03:17 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so34999098eje.10
        for <linux-sctp@vger.kernel.org>; Mon, 07 Mar 2022 14:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQVpRuV+pxLj1wdxHD51yOZt+m0Gv31hBbuNDYIBvwQ=;
        b=ndNlokI8ElfcIjkDJGWJCkqjfFEZpZB51LWw0uehLSq6Ri1YGevOIr6t4lXa0956cO
         3P+hmrwge9DlpmTUCLVcqmOLPGtboOHGdcZu4ofg5xQi7eGG1N+S1CDBjYD7YqOSAP1Y
         Ho6zD+B7not5lq0aE6dmV/IDd+RmRMFGCCiP9sIy5+2qih25CmJFeHVyyaoL2D7PTRHB
         JYS9aGlH9MMG3FZERBGjkQI8SyRkFebgWJUBj6w/TY7/ATc8zGop9WNrnK7O4e8M471n
         kdqYhwwwdbefw9f1jAgJU0mUd2a4Ock9FTfOYoes+kmL90vXbzz5CydHK/LIrwK4itLC
         F7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQVpRuV+pxLj1wdxHD51yOZt+m0Gv31hBbuNDYIBvwQ=;
        b=kNKMopbHigMfZ/4aReJ0k0qnS419RvgXZOxilkxMFv6BBdpxirPSgaQt2nfpPgyNgR
         uKR7Y+LBIHht0XQIIr7oUbvMaj3NFXKjatVo9qsEbxTKheI9ytpD4zcAur0HIvtRXq/m
         Pb7Cad+D4Lj0DB0CygsDsSyg9yY4OcPDPW4t7Yex+HIYZYInZseUEjpzkfxu7JUTtps5
         IpiWlGsTrNNpM64ds58ft0bCOFNRFzAOdQX8HVN+VH6+7u3KKHNZl7KMs8FH2KCA3bcG
         izZ+V489UUZDF7C++EwKAd4srcLqQ47f5bDkIkPLqe5UPHjOZGFq4+zr6OvLCgXerS0G
         g8yg==
X-Gm-Message-State: AOAM530CYs9nkCoR8f7jtqpImwr0C2MMQmUadhGk4ZUlZhdbWoft37zs
        IYlxhvMY+iiZIBYSfiLMzLXLl9Jx0jul2/pY1lbeb5Jo
X-Google-Smtp-Source: ABdhPJxRtStKtqHQEXzZJ4JkFt04WS2p7SZ+nwdyN/g32IxLSnsw1YkE0KXrzdz6Xagh56oiHM0wQQ==
X-Received: by 2002:a17:907:6d97:b0:6d7:49e:275e with SMTP id sb23-20020a1709076d9700b006d7049e275emr10438193ejc.410.1646690595711;
        Mon, 07 Mar 2022 14:03:15 -0800 (PST)
Received: from ntb.petris.klfree.czf ([2a02:8070:d482:2400:3f75:1b29:d53e:cbdb])
        by smtp.googlemail.com with ESMTPSA id lj2-20020a170906f9c200b006da6f29bc01sm5140635ejb.158.2022.03.07.14.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:03:15 -0800 (PST)
From:   Petr Malat <oss@malat.biz>
To:     linux-sctp@vger.kernel.org
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Petr Malat <oss@malat.biz>
Subject: [PATCH v2] sctp: Initialize daddr on peeled off socket
Date:   Mon,  7 Mar 2022 23:02:21 +0100
Message-Id: <20220307220220.652293-1-oss@malat.biz>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220307133321.5d5386f1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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
socket instead of the peeled off socket, which makes getpeername()
return zeroes instead of the primary address. Initialize the new socket
instead.

Fixes: d570ee490fb1 ("[SCTP]: Correctly set daddr for IPv6 sockets during peeloff")
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

