Return-Path: <linux-sctp+bounces-742-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 288BBC5727D
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Nov 2025 12:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E42C4E4721
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Nov 2025 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E0733B96F;
	Thu, 13 Nov 2025 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DB9BRqDg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7003D338900;
	Thu, 13 Nov 2025 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033001; cv=none; b=J/4HaRyzYLm13oVGrd2Olhttxmy8PZFxO33zlRP1ok/8TDjqs6yhU2V6OVTGFAjAanZI35BOTMK/nBiXfVtgCjWXFDHslEhNsp3hfOVGgRDm4mmrcgB7gRtIbcXWAX+NOZUJ8sPIF00bNQ1NmktlyFlGPPwZ2pH2JkkCUkWvkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033001; c=relaxed/simple;
	bh=kPlPh//r2gTARcw728eg3pBZDeBIeXPyQNHrP8jSsMA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bYdIemRM/Sd0rjCouyz6F+eLoOdJOv46Kco40eh8st9fwoyECskOM8d1UtJLZMrXm72uvx1dUONM3cCq/dFDvXDSbwJZNLao5Ud9nJUamYwga0D5jCIjCTaQyvmtaKolLtkkf4JbsfKUZRcVQI2g8iexNjN0pr721xldoS+hNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DB9BRqDg; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=F3dSujDdh5WWIoQCAqCdwVBbckq0q+DWYe55BaO5CUE=;
	b=DB9BRqDgA1M37iHvXg01Jp/2DdLSLQI/Pru3d5OSoPi09PraYnjtdaGx26UydhCzY4ZctiOYf
	xiZme4uPFJ3/+EG2bQZDtF2xeAdYC4XGQrVcq/UXfeUsULoyCU1PM6EoE0BQ58+4owePfKHuUo5
	bnNGCx8VI+2LI1thKJYUWAI=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d6dBX12Htzcb0j;
	Thu, 13 Nov 2025 19:21:24 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 93951140202;
	Thu, 13 Nov 2025 19:23:15 +0800 (CST)
Received: from huawei.com (10.50.85.128) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 13 Nov
 2025 19:23:14 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <marcelo.leitner@gmail.com>, <lucien.xin@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ebiggers@kernel.org>
CC: <linux-sctp@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
Subject: [PATCH net-next] sctp: Remove unused declaration sctp_auth_init_hmacs()
Date: Thu, 13 Nov 2025 19:45:01 +0800
Message-ID: <20251113114501.32905-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit bf40785fa437 ("sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk
authentication") removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/net/sctp/auth.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
index 3d5879e08e78..6f2cd562b1de 100644
--- a/include/net/sctp/auth.h
+++ b/include/net/sctp/auth.h
@@ -72,7 +72,6 @@ struct sctp_shared_key *sctp_auth_get_shkey(
 int sctp_auth_asoc_copy_shkeys(const struct sctp_endpoint *ep,
 				struct sctp_association *asoc,
 				gfp_t gfp);
-int sctp_auth_init_hmacs(struct sctp_endpoint *ep, gfp_t gfp);
 const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id);
 const struct sctp_hmac *
 sctp_auth_asoc_get_hmac(const struct sctp_association *asoc);
-- 
2.34.1


