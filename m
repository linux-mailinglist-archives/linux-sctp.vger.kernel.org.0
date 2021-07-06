Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832CB3BD460
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jul 2021 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbhGFMIm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Jul 2021 08:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236978AbhGFLft (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 6 Jul 2021 07:35:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9554761C9D;
        Tue,  6 Jul 2021 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625570698;
        bh=tMnwuOqsKetrJOZHCxfof29wQdNfyrd0hr/fLSioJSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RmrQg/YCG3nY/ElkgqFgzySCVW8/Ya1Y31XOyXMnpBrtMrus+NaFUjxf2K48U6cTj
         s2+z37kOP7A7+1pJ9Kl1kNZWL4JRNXd9HhiaAHFBiAYIO8zUwGp8XJkb/7GHBHMkSk
         +XichBMPH2WlGo2WWM9u/fk/wFX1u6YmdcXaSmO5rUvi18CPZl9Fknqy9KrnA4Dxka
         2Dt60UQq6Nwt5uBVy0Kw8gQOHd2wSde/2Uh8DxoZeMTpbn3EuDqmfUQp/r30RubntI
         OGSG/zgdzn90tflnP/tCu7OY1AJfvG73fasGglxsoKf6C24xB4QkVy5uSePvydXtWN
         baUP5mZHmXTCg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 135/137] sctp: add size validation when walking chunks
Date:   Tue,  6 Jul 2021 07:22:01 -0400
Message-Id: <20210706112203.2062605-135-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706112203.2062605-1-sashal@kernel.org>
References: <20210706112203.2062605-1-sashal@kernel.org>
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
index 8924e2e142c8..f72bff93745c 100644
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

