Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D49773EDAD
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Jun 2023 23:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjFZVys (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 26 Jun 2023 17:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbjFZVyJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 26 Jun 2023 17:54:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2462948;
        Mon, 26 Jun 2023 14:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF77B60FAF;
        Mon, 26 Jun 2023 21:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10445C433C0;
        Mon, 26 Jun 2023 21:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816286;
        bh=qE8u4L6kjeC4fnOGBNKjaTNjhOeZev3M+njjDO+plAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=efe+pAqfDrLs+WvXVlsuCnZNkGAP+X2sLR+MQ9kRgs/HmTGWyytGm2zebHt2R3OUt
         8txE2U0XNkVlPPFea6AUJexTJyb5wfVYUWQo0MaLQtgvJRAzE1y1ZRYM710OXEqm+i
         pvieWz3vBa/3Hr82j95x409ikOfA1J/rLadS1yQE0c7C5qoRz5jVGcH2+8reKXZQmC
         suxSbKOxnvmC4PgAfu6gq8n2LkYh4bxnPKI47UrsDczRpDvPCLj5/BtwuudKDP25P0
         HBwLQg4DQhrbVcCWJDxgYzEy6znEDzthm10c4hAZyjJHEnMwYpi+NwBBzbahtDGfGP
         EEzxxnC9/N+wA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/5] sctp: handle invalid error codes without calling BUG()
Date:   Mon, 26 Jun 2023 17:51:22 -0400
Message-Id: <20230626215124.179666-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215124.179666-1-sashal@kernel.org>
References: <20230626215124.179666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.287
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 82d96441e64d6..c4a2d647e6cc7 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1255,7 +1255,10 @@ static int sctp_side_effects(enum sctp_event event_type,
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
2.39.2

