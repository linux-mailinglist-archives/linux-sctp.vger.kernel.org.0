Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96EA368747
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Apr 2021 21:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236947AbhDVThG (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 22 Apr 2021 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236822AbhDVThG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 22 Apr 2021 15:37:06 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D94C06174A
        for <linux-sctp@vger.kernel.org>; Thu, 22 Apr 2021 12:36:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z25so12034954qtn.8
        for <linux-sctp@vger.kernel.org>; Thu, 22 Apr 2021 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5qXM+SaVBAUWEQBnJYzg2IBU+1Vdvsu7qpKzmF1HQY=;
        b=Q8+pv4Pfx0b/8kEfYR7+MC4WdwVk+N9ucWUlnNpxQUxgMmA3l6UqMlscGWDMH43t2B
         X0TcNV+xfuAJvWde+YSmIsrlsX4p0FKS12YM+EhFI2DFPh0CmOC3m6gQwtbk7okkrZLI
         hj2ehzoxwSLEMrdcrzYpyEqv/6oGFJ98/QmKmt8H2ow6znm6JA37ovWIeEVuX5t6Mb2I
         5gf2wTcxFQdTj34NGuU3c00/cZHktzblKA/g18CDbECgEEdC6CDJOy7vrQEhPutUtYL8
         GHSNNSI+naZ+pTjSAE03KfbxrpGKWG4nkvga6shjRmMXEMIv40ZwZMXLJ1VaG/Ru9jzv
         4HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J5qXM+SaVBAUWEQBnJYzg2IBU+1Vdvsu7qpKzmF1HQY=;
        b=jgi6c3IpLrOVNcTgTciiTce0MjBiKBkK5s8Hqn/hswYQaeNUuUJwAyikCZN7dxoK+v
         yuKGAfqkTAL4VLi/81mp+5wxeyFAT4TPPWaBV4NIpXm9Y5S2+/qHl7TZUyIrYe4iTAuc
         SsrR2bejROHL4p3R0bou2m6z9Ibb6eICDndsxE06oDDWB2alkVDt1OzE3RymNiAnfV1b
         4NTKX7Wpcy0O4I/u2oQZbnXuETLF2NbIRO1Fir7CdOMaWfYIeHtXosGI1KnepyD1YXiS
         MDPboah7jGlVPA59Igl6E7WgWJzxNRTehg5Dq0SHJm6OsjMaKgxvEIngxsol7a9823RT
         BfuQ==
X-Gm-Message-State: AOAM530NhoJgI2hIKuWwxBmH7wxXZ/ikj4Y8srXF9pLmctDFKB520F+i
        Xth+Hog64EkeM1LTgtNLgF30xRwoM6llsA==
X-Google-Smtp-Source: ABdhPJzlCMP8wafdDBwiORjYeR2+VSlHXmkPYlmZJB2W1q7IeZzCYfn6aj4l7SUAWT384YTmO4lgaA==
X-Received: by 2002:ac8:5c8b:: with SMTP id r11mr103423qta.140.1619120187809;
        Thu, 22 Apr 2021 12:36:27 -0700 (PDT)
Received: from horizon.localdomain ([177.220.172.96])
        by smtp.gmail.com with ESMTPSA id j9sm3110619qtl.12.2021.04.22.12.36.27
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 12:36:27 -0700 (PDT)
Received: by horizon.localdomain (Postfix, from userid 1000)
        id 5185EC3C56; Thu, 22 Apr 2021 16:36:25 -0300 (-03)
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     linux-sctp@vger.kernel.org
Subject: [PATCH lksctp-tools 0/2] sctp_send/v fixes
Date:   Thu, 22 Apr 2021 16:36:17 -0300
Message-Id: <cover.1619119690.git.marcelo.leitner@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

First one is more important. Identified by CovScan.
2nd patch is just a cosmetic change.

Marcelo Ricardo Leitner (2):
  sctp_send: fix ignored flags parameter
  sctp_sendv: avoid explicit memset for var initialization

 src/lib/sendmsg.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
2.30.2

