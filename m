Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980D132CC46
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Mar 2021 07:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhCDF7y (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 4 Mar 2021 00:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhCDF7t (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 4 Mar 2021 00:59:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED7BC061756
        for <linux-sctp@vger.kernel.org>; Wed,  3 Mar 2021 21:59:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id i4-20020a17090a7184b02900bfb60fbc6bso4044513pjk.0
        for <linux-sctp@vger.kernel.org>; Wed, 03 Mar 2021 21:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id5BCIAdEAw9kvv1oTI4WoBnYjlfumhW6rcJtR1/p80=;
        b=MjFRX9uqMmt4hp4Ip00iBEz7h/4FW+ZL7kPbVl9KTaHpznt3G3DnBrCDdDUTHX82Sy
         rmltWhdUf6IpRf+p3jpbpGQFAnBIBVs3LptOeZwfEgQR1XHgF6OlEpV+hVLzYUOQdhsK
         W4rokGimrFs4ZXM6TcRfsCCYMRIn1OBdznKKw5wv9BBA+RpuPmxPB2YZUJerOgvOoRzY
         5Cy8urdxIx+KCAKlADIfWeJAS4rdYS4mVaqysTFIyKFrke+yzjBMz0Z0aVD1thmRQc2O
         Sm6QKIXnXTVGd1W4gKJGSC+J4Qd67uwmHIbOGSXFOLhLr/hhI5/E4yPq2R2aIJFm/WV3
         Mxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Id5BCIAdEAw9kvv1oTI4WoBnYjlfumhW6rcJtR1/p80=;
        b=hfNjtFkIxgnvo3Web59oJHQfXJnBP6vnl30A+Ir1JmEHAEad4+j6o64nvaPDhPM+mW
         QVo8rBGXovKCwM9S96v1oivd9iaTJUS2ktenel2f+g0hq1v/+GeAW7n9JdhgAPNFXzXn
         obOEXzlMmVNLwq7AXhHaF5OzC1ISIC1gBk35nZ7dDZfDSxzmEEA4M2VO2yElBCsWxghU
         fGBN9rx+D04sNJUen0uFO244gCH0H+BQDijS3Yn99nR4YLExNPUuj8hW1+Lxi0zQX7vY
         dn8YKDyD3QRMJLpmaX+f/LWacMDGFPs3m48mNMmznQ7vt1d+gUWeBfCL4Rvg0wTEqcTF
         9ibw==
X-Gm-Message-State: AOAM530gPSJS0UxUeGabS1akO0C+yOCSkfS3tXY4jawZzS0t4ck4Z6e+
        VvNovoyaW3408RTACg7o5aFq4A==
X-Google-Smtp-Source: ABdhPJx2lKVwf32ybpR0Wf6LWK0x0vIAD4OQg/cHZikJQ8X0t/iCmS1Rzsk2oiLi0N2Grsm5pjqsvA==
X-Received: by 2002:a17:902:ed8d:b029:e2:b3fb:ca95 with SMTP id e13-20020a170902ed8db02900e2b3fbca95mr2556977plj.17.1614837549280;
        Wed, 03 Mar 2021 21:59:09 -0800 (PST)
Received: from x1.hsd1.or.comcast.net ([2601:1c0:4701:ae70:a76a:a553:bfca:caa6])
        by smtp.gmail.com with ESMTPSA id g24sm17987313pfk.216.2021.03.03.21.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 21:59:08 -0800 (PST)
From:   Drew Fustini <drew@beagleboard.org>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <drew@beagleboard.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] net: sctp: trivial: fix typo in comment
Date:   Wed,  3 Mar 2021 21:55:49 -0800
Message-Id: <20210304055548.56829-1-drew@beagleboard.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Fix typo of 'overflow' for comment in sctp_tsnmap_check().

Reported-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Drew Fustini <drew@beagleboard.org>
---
 net/sctp/tsnmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/tsnmap.c b/net/sctp/tsnmap.c
index a9c6af5795d8..5ba456727f63 100644
--- a/net/sctp/tsnmap.c
+++ b/net/sctp/tsnmap.c
@@ -75,7 +75,7 @@ int sctp_tsnmap_check(const struct sctp_tsnmap *map, __u32 tsn)
 		return 1;
 
 	/* Verify that we can hold this TSN and that it will not
-	 * overlfow our map
+	 * overflow our map
 	 */
 	if (!TSN_lt(tsn, map->base_tsn + SCTP_TSN_MAP_SIZE))
 		return -1;
-- 
2.27.0

