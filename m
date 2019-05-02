Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ED311A80
	for <lists+linux-sctp@lfdr.de>; Thu,  2 May 2019 15:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbfEBNs4 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 2 May 2019 09:48:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43315 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBNs4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 2 May 2019 09:48:56 -0400
Received: by mail-qk1-f193.google.com with SMTP id p19so1436653qkm.10
        for <linux-sctp@vger.kernel.org>; Thu, 02 May 2019 06:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kevjdMQKUmiSaSoSxO56Pe6/NEjsgKMfed3HBdPfVRE=;
        b=YVuwt7dJf999L2UIOaY/r5zpYvcyDwmDHWmRpr1nE2XLlpdFAzvaZOdXsX+4oUsjD6
         1sqOueSR4aIM7pJaNS441z+AU+wn+UVO2rbpXbszcq0B8BH0R2rI8bD261pLC/EghOSn
         8qoUgCGPQQAgke6pdMHWNL+EoGQeEXBLQXkmreAlHp5r/6GBn1sfPvnTEKJEEmGxhJSo
         xvYibXtdD1Keeof5ZLl2tDiX/Dp9ZifTUs8LOvaqNmsQUEAb5pr8mE+ZbNrCHkJNKehO
         6xfPDgkZu8p8cLp1tMTKz0+SrbbZjunz0dml5VSbXO9u9+wqIOyvdNqyh4CKda9qzz9g
         G+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kevjdMQKUmiSaSoSxO56Pe6/NEjsgKMfed3HBdPfVRE=;
        b=Vcdx+nCNJ9BXfJL+RC9tz6aELw9nfoek+/wtqDRQH6IMUMzat2IpQ3nL/nc1ecBAcX
         OWKUhWGV/yxP0CNhLDkUWjSwsdwoV//AFIHnqjuKcJdrKksCK69a6EBFQW+z89S1nE40
         tualRslR4Vhd2shFPt8t6mgxfufwLWTIyHr2om9dr3+01iy27WTqfrUSnPRwhEoIdjN7
         65ENvjkcLqggKKRSr4izBFRRDwYwuarSkIGAEMPGIobc893ICV7aOQb9alJKfIC5cOhJ
         l+J4y+pHDt4FlCs2J+g8tJFp5ghYwg69ptsngXmse+AigJTj0IGAc5CG0LkLabd9A1Ix
         z1CA==
X-Gm-Message-State: APjAAAUePahRrW3ndUAHuExMVtgabzxmBovMM+HMcx0MX93j80Ekd6EA
        ssk1nMDEg7grpGKKeAucKqY=
X-Google-Smtp-Source: APXvYqx5f46Mz919hmj3QzHF87DbmgkcXRWsvKAbC332Rnax+8McqGdq1qFinCTc/xRoYEfmIrE6Cw==
X-Received: by 2002:a37:4ad4:: with SMTP id x203mr2855071qka.21.1556804935209;
        Thu, 02 May 2019 06:48:55 -0700 (PDT)
Received: from localhost.localdomain ([168.181.49.3])
        by smtp.gmail.com with ESMTPSA id p12sm7439935qta.57.2019.05.02.06.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 06:48:54 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C61D2180CF7; Thu,  2 May 2019 10:48:51 -0300 (-03)
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Marcelo Ricado Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools] travis: disable kernel retpoline
Date:   Thu,  2 May 2019 10:48:48 -0300
Message-Id: <6861d1450cb76484769a468b9e1f1c798a61e682.1556804893.git.marcelo.leitner@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Because Travis compilers doesn't support it and that breaks the build
as is.

Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 .travis/linux-build.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.travis/linux-build.sh b/.travis/linux-build.sh
index 746f17252992f8f80a49fd9004bc9600cc97081e..c96bd11958816f0625b8ba95df6ec96b2b4124fe 100755
--- a/.travis/linux-build.sh
+++ b/.travis/linux-build.sh
@@ -30,6 +30,8 @@ function __prep_kernel()
 {
 	make mrproper
 	make allmodconfig
+	sed -i 's/CONFIG_RETPOLINE=/# CONFIG_RETPOLINE is not set/' .config
+	make oldconfig
 	make -j $nproc modules_prepare
 	make -j $nproc headers_install
 	KERNEL_HEADERS=$(pwd)/usr/include
-- 
2.20.1

