Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE0D78C5A6
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Aug 2023 15:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjH2Ndy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 29 Aug 2023 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236256AbjH2Ndj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 29 Aug 2023 09:33:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC1CCA;
        Tue, 29 Aug 2023 06:33:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FB6165795;
        Tue, 29 Aug 2023 13:33:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECCCC433C9;
        Tue, 29 Aug 2023 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316005;
        bh=m6FTBYog0Gmj5JacnOAKiMQ+PEuW1lN6b8HgEA82+QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AGoH63vvPUzWf+W9m0gJAnhJ7DmVvP8GDN65QEij2xbAwBTbJIxE7hwnJtT5otYuD
         nkStXEMbUwjfXzRtMMqSXhp9g2QUUELsQleKYDkmiT+u5JJAyCCKJf/sHIRFvPiwBv
         wXtFyGR/4FZVy+oPje/V6mV8JFjc1nteLwg4PcIp17fvsQRO2e7JMCrM1X/rLkM+Zh
         8a9QFrMGbFaEPjaycWthViz6m+vTgA7Y9T/fBk5PnZs5x/dxWvDXzyJTsE0kZYMFjl
         GCz+NG1ysAXzbd4xUktmBhzwht9XgnRF8cpwBn3BPRmdPERpBY6QCWYe+RyoGBH6l2
         4pfIND59Ls9Wg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, vyasevich@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/9] sctp: handle invalid error codes without calling BUG()
Date:   Tue, 29 Aug 2023 09:33:11 -0400
Message-Id: <20230829133316.520410-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133316.520410-1-sashal@kernel.org>
References: <20230829133316.520410-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.128
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit a0067dfcd9418fd3b0632bc59210d120d038a9c6 ]

The sctp_sf_eat_auth() function is supposed to return enum sctp_disposition
values but if the call to sctp_ulpevent_make_authkey() fails, it returns
-ENOMEM.

This results in calling BUG() inside the sctp_side_effects() function.
Calling BUG() is an over reaction and not helpful.  Call WARN_ON_ONCE()
instead.

This code predates git.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_sideeffect.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 463c4a58d2c36..970c6a486a9b0 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1251,7 +1251,10 @@ static int sctp_side_effects(enum sctp_event_type event_type,
 	default:
 		pr_err("impossible disposition %d in state %d, event_type %d, event_id %d\n",
 		       status, state, event_type, subtype.chunk);
-		BUG();
+		error = status;
+		if (error >= 0)
+			error = -EINVAL;
+		WARN_ON_ONCE(1);
 		break;
 	}
 
-- 
2.40.1

