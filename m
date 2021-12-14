Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69938474D6B
	for <lists+linux-sctp@lfdr.de>; Tue, 14 Dec 2021 22:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhLNV5o (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 14 Dec 2021 16:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhLNV5o (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 14 Dec 2021 16:57:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9384C06173E
        for <linux-sctp@vger.kernel.org>; Tue, 14 Dec 2021 13:57:43 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k37-20020a05600c1ca500b00330cb84834fso17239164wms.2
        for <linux-sctp@vger.kernel.org>; Tue, 14 Dec 2021 13:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QyzlaEvGftgMM8DTXQodMrr/OBpAbRBg3r+WHz53PU=;
        b=UkIn6MuatFncBY4nnc6Ob1g/v+sstRf43AWf8CSJ9LarrthuyEpzEUO9/JfVDYN1hQ
         R0NjN60m8xrB6vUnHIHW2ur6FmzgVsTeqScRQs+xvVhUq8jG5GezLfIJzJqvEESh/FWZ
         HSUc+5FDjTOLhG/+ntOmTM6/Q/NL4+JzWUOhzQq2ukFCZguoLcfXs66B3poauVd8tNgz
         QbiGUfq3LMonzwZnHhOphoP/sBwQT1+hEMdrFm/lfbh8IZfOKEJKZB7e+MB1S6Kf6qj8
         l2EjqlyyM9t1e7je/VjzpRBKKszneyrdOzNzeqAqeCgnIzPtY3e8WUSWdHfl4w0T+mbl
         KK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2QyzlaEvGftgMM8DTXQodMrr/OBpAbRBg3r+WHz53PU=;
        b=g4KTuAC/Rd6I16h2eYVNuyKDRNlv0J1Mqo/B2ah7D1noGPYPInu/xA+yze9PmnUXMX
         bkcfDmX+iCNA9LBx7/yeL2WRBb3FUop4lylWwnXCLxKWNWbanB0D1r5eS6YjkdBqMpgV
         VkZlNVenZfqWs/FE6u9R1PGdZm+eS5uE5f6ZQlfn3+8HRMAvf0f59LhzcGrYOgIR/Oj4
         SEUXnfPP8yaUhXcYkM1Ye2xzewMW/S6LqgJHAC2tTWFBfPUypuxgT/FieXhn+WlM6+dV
         zJIS5EK28k1Q6pmUGaFR0vDoRyzLNZFcdyyIh++0nq5vDeVOXmg6+0bMqFudB2RhWIfU
         shmw==
X-Gm-Message-State: AOAM533BP8SpV6FvgmuvWDvE2kccIh1JYlykhEC/+wwEmgvx+Gu1NiQz
        /BiDpeycyffdSd2mIJ8Zn89sOA==
X-Google-Smtp-Source: ABdhPJx2yH+Z25DQk22J6l9wWexwTfXulU5Erm2Nt5fUwPzVzm5FrUE1F7Fv1r3tHCrukQP1gYIK1g==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr1862972wmq.8.1639519062161;
        Tue, 14 Dec 2021 13:57:42 -0800 (PST)
Received: from localhost.localdomain ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id d15sm145504wri.50.2021.12.14.13.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 13:57:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        lksctp developers <linux-sctp@vger.kernel.org>,
        "H.P. Yarroll" <piggy@acm.org>,
        Karl Knutson <karl@athena.chicago.il.us>,
        Jon Grimm <jgrimm@us.ibm.com>,
        Xingang Guo <xingang.guo@intel.com>,
        Hui Huang <hui.huang@nokia.com>,
        Sridhar Samudrala <sri@us.ibm.com>,
        Daisy Chang <daisyc@us.ibm.com>,
        Ryan Layer <rmlayer@us.ibm.com>,
        Kevin Gao <kevin.gao@intel.com>, netdev@vger.kernel.org
Subject: [RESEND 1/2] sctp: export sctp_endpoint_{hold,put}() for use by seperate modules
Date:   Tue, 14 Dec 2021 21:57:31 +0000
Message-Id: <20211214215732.1507504-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

net/sctp/diag.c for instance is built into its own separate module
(sctp_diag.ko) and requires the use of sctp_endpoint_{hold,put}() in
order to prevent a recently found use-after-free issue.

Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: Neil Horman <nhorman@tuxdriver.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: lksctp developers <linux-sctp@vger.kernel.org>
Cc: "H.P. Yarroll" <piggy@acm.org>
Cc: Karl Knutson <karl@athena.chicago.il.us>
Cc: Jon Grimm <jgrimm@us.ibm.com>
Cc: Xingang Guo <xingang.guo@intel.com>
Cc: Hui Huang <hui.huang@nokia.com>
Cc: Sridhar Samudrala <sri@us.ibm.com>
Cc: Daisy Chang <daisyc@us.ibm.com>
Cc: Ryan Layer <rmlayer@us.ibm.com>
Cc: Kevin Gao <kevin.gao@intel.com>
Cc: linux-sctp@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 net/sctp/endpointola.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/endpointola.c b/net/sctp/endpointola.c
index 48c9c2c7602f7..7c36056f3a1b4 100644
--- a/net/sctp/endpointola.c
+++ b/net/sctp/endpointola.c
@@ -226,6 +226,7 @@ void sctp_endpoint_hold(struct sctp_endpoint *ep)
 {
 	refcount_inc(&ep->base.refcnt);
 }
+EXPORT_SYMBOL_GPL(sctp_endpoint_hold);
 
 /* Release a reference to an endpoint and clean up if there are
  * no more references.
@@ -235,6 +236,7 @@ void sctp_endpoint_put(struct sctp_endpoint *ep)
 	if (refcount_dec_and_test(&ep->base.refcnt))
 		sctp_endpoint_destroy(ep);
 }
+EXPORT_SYMBOL_GPL(sctp_endpoint_put);
 
 /* Is this the endpoint we are looking for?  */
 struct sctp_endpoint *sctp_endpoint_is_match(struct sctp_endpoint *ep,
-- 
2.34.1.173.g76aa8bc2d0-goog

