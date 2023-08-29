Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B988B78C614
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Aug 2023 15:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjH2Nfv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 29 Aug 2023 09:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjH2Ne5 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 29 Aug 2023 09:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EFBCD3;
        Tue, 29 Aug 2023 06:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 139B3657B3;
        Tue, 29 Aug 2023 13:34:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BC1C4339A;
        Tue, 29 Aug 2023 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316053;
        bh=HC0YW4pjTa8Wf0Ln9pyi5PcI4UwgFrx0mp5RSj49dyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEdPesiQf/hNE5WwlGWtHToW0y6QPhZwv37kHO7nz6sTDn3NUv65NXCmghK2zKZXW
         ldxYEO99C+JNb8B0o0JXGz99YIq+eMAA+U8iylsmd1ainGkVWCEbDtI2cc89gcs4I0
         dGpn2YXyWqLCpm5rQ9BpuO4+pRs3k2sd/MOwrkH+gH/tzWdruxTuLgvOVhsSpHEQEn
         JsFm43JyVL+ZdMwx/8nFjAY1B9qEZ5+OrqnKVKnhojzUKromUCukGigZAV/c7I/c6o
         E6PUFo5sgh4gsZaj6EMSUM00yLYleVDrGk64850O9040ujpM3Jsh41YoljOq8QK9LS
         a7cYn+0jgReiA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, vyasevich@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/5] sctp: handle invalid error codes without calling BUG()
Date:   Tue, 29 Aug 2023 09:34:04 -0400
Message-Id: <20230829133406.520756-3-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133406.520756-1-sashal@kernel.org>
References: <20230829133406.520756-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.292
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
2.40.1

