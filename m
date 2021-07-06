Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D213BD353
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jul 2021 13:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhGFLvE (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Jul 2021 07:51:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237284AbhGFLgE (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 6 Jul 2021 07:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BA3161EEA;
        Tue,  6 Jul 2021 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570795;
        bh=CFfpxMYRtSFEtrkuK4v7XIcMIQZy/kBrY4eH87LdzPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBqut+ZhLCiM7flRa7O5b3NUmdkuJfEWccD3qDeoURfqLCJ0tGmpVcihrOrLZ+IRY
         I+zu8pWJP6OSIvEm/mgNEZLJAsjLYJ3E6oOY7FJXmie+QXvtiJk79URMhbeN0TROI5
         yHjKu5SqUAxufPbEzyVZvjb8jRmmzOvOz/MlY2LW0sRAlsve1MYpI1JgfJnuhIZUex
         Rb3yaeUaIQwxvNZMv3LRTq6lHrY/Tc8wlrlCorm8prbynzYh/axqnf0gXfPXirJoKk
         RY4dcdI8ucLaM4EMDrHGquPorDcsDuIR76E0/SC7AMtu+OLABGj2QcdSN/+ol1sV8Z
         1oxw4VnHsEuRQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 72/74] sctp: add size validation when walking chunks
Date:   Tue,  6 Jul 2021 07:25:00 -0400
Message-Id: <20210706112502.2064236-72-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112502.2064236-1-sashal@kernel.org>
References: <20210706112502.2064236-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

[ Upstream commit 50619dbf8db77e98d821d615af4f634d08e22698 ]

The first chunk in a packet is ensured to be present at the beginning of
sctp_rcv(), as a packet needs to have at least 1 chunk. But the second
one, may not be completely available and ch->length can be over
uninitialized memory.

Fix here is by only trying to walk on the next chunk if there is enough to
hold at least the header, and then proceed with the ch->length validation
that is already there.

Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index a84523284777..ab84ebf1af4a 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -1247,7 +1247,7 @@ static struct sctp_association *__sctp_rcv_walk_lookup(struct net *net,
 
 		ch = (struct sctp_chunkhdr *)ch_end;
 		chunk_num++;
-	} while (ch_end < skb_tail_pointer(skb));
+	} while (ch_end + sizeof(*ch) < skb_tail_pointer(skb));
 
 	return asoc;
 }
-- 
2.30.2

