Return-Path: <linux-sctp+bounces-200-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 234BD95B5A3
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DA11C234BC
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0771C9EC4;
	Thu, 22 Aug 2024 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGnrM9QY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4F91C9DF6;
	Thu, 22 Aug 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331488; cv=none; b=oq/hcOekZq/lHYSg4hic5HBj5c/+WZJYoqJ4SSlm+UNjS0rxSSHhhzQcUA1LuOXe4DXCMhqq25AR7JMt9b+2LojYnvqFBxLcWKYmmyuzNNu4B1WG9L9KiNLQv0mm4Qo2obLhHRu40e5ELZG2mysMBKK663rBNx110jOsjMsIqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331488; c=relaxed/simple;
	bh=994WLKmvIF8xySmU7VNKz8/rwajRzqjreyZvyk6dhmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYMvW4G3+0rzQdhutirG+FRxPb2yBbzlFlqEpg5xQ+7Cw6yyf6ANoDWcdwFL/2BisIgIXeJmS74TAmLDIkBygldN3bzZWUUd/PXyDelbRTjZ6UftLrgHSshXaVxkOrHaFUtsxny6t1J9R6ZvsrmyZZxkouHBKtCCFRnmghr3SlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGnrM9QY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7675DC32782;
	Thu, 22 Aug 2024 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331488;
	bh=994WLKmvIF8xySmU7VNKz8/rwajRzqjreyZvyk6dhmI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nGnrM9QY2bde9uSx08ThyByjUoYOAUeZZ+7zP2x08+66ZhLXGzg1wduKUxf3gtq5s
	 kZscS/jAlAhafMFaBU6FNb8y4hIJG249cgQXOgApECR3oNXifon2XcJuaEiTgsEJah
	 MDQq3dWLFYrrxc/ecmktUcKxc1Xlvt8EAdgUN60NQfgwd3phQ823vRBWKymkyEcusy
	 FIumvtI7PYTOj50NTb6AKcillut+IvVghz18LmFXetaQ7dQUZQCjMysZajXQEtFu0B
	 JY0WxXAJQ3IS0XTGfmi+M6vM1lI308EgRxqERx6Ls09ZIc6waU88OaK5UqGKT2f1C1
	 qu2L5To2rgs5A==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:27 +0100
Subject: [PATCH net-next 06/13] net: qualcomm: rmnet: Correct spelling in
 if_rmnet.h
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-6-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in if_rmnet.h
As reported by codespell.

Cc: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: Sean Tranchetti <quic_stranche@quicinc.com>
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/linux/if_rmnet.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_rmnet.h b/include/linux/if_rmnet.h
index 839d1e48b85e..c44bf6e80ecb 100644
--- a/include/linux/if_rmnet.h
+++ b/include/linux/if_rmnet.h
@@ -42,7 +42,7 @@ struct rmnet_map_ul_csum_header {
 
 /* csum_info field:
  *  OFFSET:	where (offset in bytes) to insert computed checksum
- *  UDP:	1 = UDP checksum (zero checkum means no checksum)
+ *  UDP:	1 = UDP checksum (zero checksum means no checksum)
  *  ENABLED:	1 = checksum computation requested
  */
 #define MAP_CSUM_UL_OFFSET_MASK		GENMASK(13, 0)

-- 
2.43.0


