Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB173ED6F
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Jun 2023 23:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjFZVxP (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 26 Jun 2023 17:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjFZVw1 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 26 Jun 2023 17:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78A230F4;
        Mon, 26 Jun 2023 14:51:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C5D60FA4;
        Mon, 26 Jun 2023 21:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1154C43215;
        Mon, 26 Jun 2023 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816261;
        bh=1fdzaqEMq6vZyaUUdwoyrVtVn9gfyoo10uV5nez1X1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MXZTWg7ObH0CEYcEU9m4spOhruodvSVeIRfptmAfJCwyo88C2Lz68NjiMLONec7A1
         R3bssg004C09+9mNkZSjDuKtBSECMy2gkJbOD/prldkz766AD3UqkQOCoZ1tW9Xk0c
         HIm2gKFAd6YDhVYhBYYkKfrAIIgewxQUVY5WsabLfa9kgRVnZiH9Bb3g3Rb2kPb1Ae
         ncTIpjwNaTR+xFkVcR3JgKrHKGrEYNPKilvFM9GTxhFbR+HfWLIRuA6nWmEDVMws0w
         t5ILjtjcTup0iftNBjN5GEesn71X8S/QSHnFcxC5jvM3MOBKCl6ZzS256RpsYaMNhB
         xh2icc041A5Gg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 4/9] sctp: handle invalid error codes without calling BUG()
Date:   Mon, 26 Jun 2023 17:50:52 -0400
Message-Id: <20230626215057.179363-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626215057.179363-1-sashal@kernel.org>
References: <20230626215057.179363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.118
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

