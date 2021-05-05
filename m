Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E796D3746B1
	for <lists+linux-sctp@lfdr.de>; Wed,  5 May 2021 19:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhEERWj (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 5 May 2021 13:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237818AbhEERB2 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 5 May 2021 13:01:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C16B619FE;
        Wed,  5 May 2021 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620232836;
        bh=/xgOOXNVSViHM4jZNsqwPFHxziF+YLoGg2WFBHF9iCI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEYtl/djkx3qXJpdOXfdcEI1Oi3nj6ghxgEDPIbCd8UAKueEXReuiIpvg7nwbF2a/
         DG/TH+9ceSV38oIML1PjSjK00VmnCg75NeWf4DlmsOotRvGmsLv3BanRcygzHHkMNw
         iPEJC0QLnRDtuA2J35grRnsJ9EAIVYiKZOPM8+NRcuteD5Il+d8gBmc24VN/LbuDjO
         Azy2XbRqNI9be+tMu72gm6iWSzaxcFj6xTZP54tdyjHH5Zu9bYFFNxLph1lbAkTlTC
         UOJHUKwzhlTegVXHK5fKv9uTYmFZMg+ONO08F7Z7lASEJ1WylAT05lT+/OsngsiLMF
         AeR2tZ+8LOFGQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 22/32] sctp: Fix out-of-bounds warning in sctp_process_asconf_param()
Date:   Wed,  5 May 2021 12:39:54 -0400
Message-Id: <20210505164004.3463707-22-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505164004.3463707-1-sashal@kernel.org>
References: <20210505164004.3463707-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit e5272ad4aab347dde5610c0aedb786219e3ff793 ]

Fix the following out-of-bounds warning:

net/sctp/sm_make_chunk.c:3150:4: warning: 'memcpy' offset [17, 28] from the object at 'addr' is out of the bounds of referenced subobject 'v4' with type 'struct sockaddr_in' at offset 0 [-Warray-bounds]

This helps with the ongoing efforts to globally enable -Warray-bounds
and get us closer to being able to tighten the FORTIFY_SOURCE routines
on memcpy().

Link: https://github.com/KSPP/linux/issues/109
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_make_chunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index ce6053be60bc..dc51e14f568e 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -3148,7 +3148,7 @@ static __be16 sctp_process_asconf_param(struct sctp_association *asoc,
 		 * primary.
 		 */
 		if (af->is_any(&addr))
-			memcpy(&addr.v4, sctp_source(asconf), sizeof(addr));
+			memcpy(&addr, sctp_source(asconf), sizeof(addr));
 
 		if (security_sctp_bind_connect(asoc->ep->base.sk,
 					       SCTP_PARAM_SET_PRIMARY,
-- 
2.30.2

