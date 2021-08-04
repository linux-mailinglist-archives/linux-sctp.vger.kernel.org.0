Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0068A3E0024
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Aug 2021 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhHDL3c (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Aug 2021 07:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhHDL3c (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Aug 2021 07:29:32 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32CEC0613D5
        for <linux-sctp@vger.kernel.org>; Wed,  4 Aug 2021 04:29:18 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w197so1029626qkb.1
        for <linux-sctp@vger.kernel.org>; Wed, 04 Aug 2021 04:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98UCNDXMKoi7q0sV9XhqQ+3F+5iNMNsRGdkS2sxD1QY=;
        b=LknwwWXMUYPv0nb3qpQsdyDDuDYYWbRo6TUav774uEEud3LGkR2UODadobG+pw3XEG
         FGw1Zm74QO68pklbdcLCy58JCtER/ZSf36hAp3gXikNS2YGysWnrGS2atgJ+Zk3H7dLy
         O20Zr5z9C747LaA3COcYcZ5TIeHXC+OSfgUEhtkgJFeR6AfnBkL8WoUX9CfVrUngL172
         mRmspyIty/OuY+vbTAlJ6dQR1rWeH2W1crjrqwVlZJPb9IX18CGiPBULgfJTruNJz4wz
         KuNXlDPzn2zfbDint/DFV19v8fG0cGjUK4G15Vrx3GBH/WwvrtMdiBTfMCVOY0oHM7/e
         qTqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98UCNDXMKoi7q0sV9XhqQ+3F+5iNMNsRGdkS2sxD1QY=;
        b=HbnWi7G6Gee+Rg9UfwuxlxQ5BwIwGkIQgRyviiNhH6Z8hpCMI5ypmmaAMwBcmOG/W/
         zXv8yvsLEt4y+BdOFDoVzfJPubWAu6qVV0dzAb42dWu5QROnnSEYcrW+HxSuhfkMghiW
         DJ909fYfZ0cnO8kSDr/kl6lvLHq5Lc3/+BmSTN8+IpMo9HnnaqYcyztSjN8qXdkZE8+D
         hul4zaTTxaI7TdYZzSONO+200/IDC/ybl6aMMBLyIPjlhiHo4E9nYbHc9wfp2gVna1bm
         OHuBfA92351++WOEhuwQ9M7C423/jTLk+fwR1w/RkhXZOaXprVqjC45udlQtU5qRyjwS
         WKxg==
X-Gm-Message-State: AOAM532hHYwTyyhyd06He8ZwnnF10ALutLJWbQDm75m4R5pKGOmcR5op
        6Rp3XGuf24NUE27Tq6WDyqw1OMn43lZEcQ==
X-Google-Smtp-Source: ABdhPJy1O7elNvqRZpSyiMCqEhFKg5/n9UZ2d7DUQZMxy8+TgywU28gxLCOoBll79gBD6Uq3Ms6akQ==
X-Received: by 2002:ae9:f312:: with SMTP id p18mr25909742qkg.5.1628076557744;
        Wed, 04 Aug 2021 04:29:17 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p187sm1117720qkd.101.2021.08.04.04.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:29:17 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools 0/4] lksctp-tools: replace use of deprecated gethostbyname with getaddrinfo
Date:   Wed,  4 Aug 2021 07:29:12 -0400
Message-Id: <cover.1628076531.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This patchset is simply to replace use of deprecated gethostbyname
with getaddrinfo in myftp, sctp_xconnect, sctp_test and sctp_darn.

Xin Long (4):
  myftp: replace use of deprecated gethostbyname with getaddrinfo
  sctp_xconnect: replace use of deprecated gethostbyname with
    getaddrinfo
  sctp_test: replace use of deprecated gethostbyname with getaddrinfo
  sctp_darn: replace use of deprecated gethostbyname with getaddrinfo

 configure.ac             |   2 +-
 src/apps/myftp.c         |  40 +++----
 src/apps/sctp_darn.c     | 246 +++++++++++----------------------------
 src/apps/sctp_test.c     |  63 +++-------
 src/apps/sctp_xconnect.c |  72 +++++-------
 5 files changed, 137 insertions(+), 286 deletions(-)

-- 
2.27.0

