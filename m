Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0A211DAE
	for <lists+linux-sctp@lfdr.de>; Thu,  2 Jul 2020 10:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgGBIBh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 2 Jul 2020 04:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgGBIBh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 2 Jul 2020 04:01:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6BC08C5C1
        for <linux-sctp@vger.kernel.org>; Thu,  2 Jul 2020 01:01:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so27010753wrv.9
        for <linux-sctp@vger.kernel.org>; Thu, 02 Jul 2020 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q17ui7OnYYzv5W5hWWK4E0UVVUgnNiP2VX3PtAHf3vE=;
        b=JfR7U9iS1yQAF8iuo6uHO+OwknDI/EoIoIVVPiBlcBvYQtMUpQJ2e8FuwFFgHJygFV
         jLVJgwjnTPMi/6HSBiaPvlIUO9ICa+1oHiINQzgz+qLXnWYuCyiMl03p6vuV8D5pC5g2
         yBWSYu6ZbMKq2BrKby4kwsZ9ZQjTRTyg866bN8eCftK5rz8j5nS+yTFdKt1l5427oVv7
         CMM/5ExoPM22LF1hhmfDlu6WfMEogN7+M9JcPKMG6lm5CirSDMnOCJqbHfQySMEp351W
         5iHJ75XjWkAFF0t2p9XCLqQmGUt3RQRC+mqIuCtMp9fPmorlJH1QXS8RxG+aF58DmgO1
         9g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q17ui7OnYYzv5W5hWWK4E0UVVUgnNiP2VX3PtAHf3vE=;
        b=qsLRuKL/vq2ESYEMJz/3wQQ9F0535cS3AKFWF9t1cbd0uH/7M966kAPas1ituiRSQa
         MXEr9rwKL0EtLugWyM2DzhNZJUFWIs1f/vy7prsNbh5/nioa7R0ULro1PSJBLe0KpO33
         gXQgWJ9LfoW7LoGA9ekCOhVnUGdBziCNolPzbaQr3vfnkdCeqJJNcEpf2CNs7LzsI2DA
         VL9JUzwlH8xDVQIWepImgbI/XA0rgWiyJpgZpexYFwXGIvpYnGA3P8CF64RR3CRbAVYm
         1KssuDpm+X+jgvF5TzZqzny/qDBLdTOhZ4hjiE7QgH4OgBur3mTbcfV7Dv1c/MaaxZ1j
         wOyA==
X-Gm-Message-State: AOAM533Ao2aKiYcf33/9Rkco6WA+oQF+Y+/UhARCXSIldiHWI5RkCG6F
        qPBV/tIhKYrua4Wc4BX1zJI22trWdQs=
X-Google-Smtp-Source: ABdhPJxAQpjzV/Qe+O4hWr6ADTs51SV6i/wttfaMuaTOxyId3YIR4g9KrHPwKFWTqxHErttdT08YZw==
X-Received: by 2002:a5d:55cf:: with SMTP id i15mr32992070wrw.204.1593676895373;
        Thu, 02 Jul 2020 01:01:35 -0700 (PDT)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id u20sm9383191wmc.44.2020.07.02.01.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 01:01:34 -0700 (PDT)
From:   Petr Malat <oss@malat.biz>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, trivial@kernel.org,
        linux-sctp@vger.kernel.org
Cc:     Petr Malat <oss@malat.biz>
Subject: [PATCH] sctp: Wake up all processes after closing the connection
Date:   Thu,  2 Jul 2020 10:01:26 +0200
Message-Id: <20200702080126.8951-1-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

All waiters need to be woken up after a state change to ESTABLISHED,
CLOSED or SHUTDOWN_RECEIVED, as that's the time when they all should
react - for example all threads blocked in send() must return an
error when the connection is closed, not only one of them.

This solves the problem of threads sleeping indefinitely in
sctp_sendmsg_to_asoc() when the connection was closed while multiple
threads were waiting for SNDBUF.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 net/sctp/sm_sideeffect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 9f36fe911d08..ae08b1805b45 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -892,11 +892,11 @@ static void sctp_cmd_new_state(struct sctp_cmd_seq *cmds,
 	if (sctp_state(asoc, ESTABLISHED) ||
 	    sctp_state(asoc, CLOSED) ||
 	    sctp_state(asoc, SHUTDOWN_RECEIVED)) {
-		/* Wake up any processes waiting in the asoc's wait queue in
+		/* Wake up all processes waiting in the asoc's wait queue in
 		 * sctp_wait_for_connect() or sctp_wait_for_sndbuf().
 		 */
 		if (waitqueue_active(&asoc->wait))
-			wake_up_interruptible(&asoc->wait);
+			wake_up_interruptible_all(&asoc->wait);
 
 		/* Wake up any processes waiting in the sk's sleep queue of
 		 * a TCP-style or UDP-style peeled-off socket in
-- 
2.20.1

