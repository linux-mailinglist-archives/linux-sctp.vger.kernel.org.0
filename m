Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3917A73EE44
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Jun 2023 00:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjFZWEn (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 26 Jun 2023 18:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFZWE2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 26 Jun 2023 18:04:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F3859CD;
        Mon, 26 Jun 2023 15:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24FFD60F77;
        Mon, 26 Jun 2023 21:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E215C433D9;
        Mon, 26 Jun 2023 21:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816246;
        bh=1fdzaqEMq6vZyaUUdwoyrVtVn9gfyoo10uV5nez1X1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCTIXBJTjbg3YHXTwdeWTZYc7pyyBpUngGtxLeHDyub1zAMBaK5BN9wgxlM81dHwp
         2gwsGZL+pbKIhIkk8VVZ+WZjUZnX2QXuCN2BLhISYLZILLMmhCETsfdwXA2U+uSL0k
         o/6ahsYR8zVrnkbFYt/TJjpnUZQvNVZNqQzgPBVGVpEoTWyzWZGrqIM7R2JZykY3wF
         g98wKEqU/3BkCcgp3W0BrWJrNdza8JZQyqpyOA0UQ6LRhgIVOUrD7mTiD/q/xFHEe/
         +ZZ+jmF5B7bG3mb1sohh3U5H/r0Evya1H6sO7yWdA/sSQ71aPfjvaCZnToUYF2OkRm
         iWr87vIy862mA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/15] sctp: handle invalid error codes without calling BUG()
Date:   Mon, 26 Jun 2023 17:50:24 -0400
Message-Id: <20230626215031.179159-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215031.179159-1-sashal@kernel.org>
References: <20230626215031.179159-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
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
2.39.2

