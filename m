Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1727095E
	for <lists+linux-sctp@lfdr.de>; Sat, 19 Sep 2020 02:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgISAMP (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 18 Sep 2020 20:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgISAMP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 18 Sep 2020 20:12:15 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB2C0613CE
        for <linux-sctp@vger.kernel.org>; Fri, 18 Sep 2020 17:12:15 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id y10so4285904pll.6
        for <linux-sctp@vger.kernel.org>; Fri, 18 Sep 2020 17:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=huQVogRrTJ8IjZrwun9QBbaOUshPSajlFOXa3DSBDGU=;
        b=sAknZHsldl7EP0HUVpdNbtNGpNeQ/jiY3HQfsPitwNccFi6YkkF/4c6xyDt4bU8Wp6
         LO/BdYGeZxKmTZaXcfP9g4srqrUWN/qWwNXYMr6flm6xoKEKoMk3zIxc6s7sR+bSQHqE
         rLPRTEaXEEOufCZIOvvTx7zvysOmoDvb59qxrBH2H2+tdsVjC/ixP04QVes0EJc01SwR
         KlY9wBJ3ceSyiy3t8Jlf236R6bQ0aETte/N1Q9SplbYirPMh1lsc0ohdsrPvNQLxgKMx
         bTca0SV6xq30jcFoNl00CnhHfRRI2tij41tCGWYuj47kTkgzvJloWiEu9/aHM2HG5jNR
         4PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=huQVogRrTJ8IjZrwun9QBbaOUshPSajlFOXa3DSBDGU=;
        b=QCB4JC9CnjDwmbtBe+IKYbEhrNz3j7PNjy0aJQD4uuuE+0hFZRwhCD96pxh9qtFR/a
         IBcHns8m5ENAOF1H7quIiocG9kSPQP9H5w/ybCTAFjySXv/Ip0H37Sr8d8VzhH7bnSnj
         zj+2HCF8bFcImHZtc2Fp2svrJn5YELoKGcHiEBiAbXEMKdRP4vpTDO1+r3KiuhXaieYi
         r3UPwEiL5utJk2e//pAGTdLIGPAGLWUnpipxIAomzd+GbZSdth1YQkYJrnjO1jtFoO6V
         3FHb/xq09Vjt/3VeO4nxwYdI/r7KxGVNxRJKxxMZiFWZzTi9Zq7RVAbk/BhHyfwbrD0g
         /83Q==
X-Gm-Message-State: AOAM530v64vIU+e21K6btVhb5I8bwK3oUubbW3G2GJK5jhdxe2d9mDA3
        tiILiggmPvwDIQt/zC49Y5/enFIuXg6jDJco
X-Google-Smtp-Source: ABdhPJw/Vdg/CFrhaWEGWa9vKGnznTJN+AQgKUgoILuh2WXMfK/8BDW80gy0jMuYHAXPRXihxBdvoPzje1xO+Iyp
Sender: "hptasinski via sendgmr" <hptasinski@hptasinski.c.googlers.com>
X-Received: from hptasinski.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1641])
 (user=hptasinski job=sendgmr) by 2002:a62:1dc1:0:b029:13e:d13d:a051 with SMTP
 id d184-20020a621dc10000b029013ed13da051mr33221931pfd.23.1600474335063; Fri,
 18 Sep 2020 17:12:15 -0700 (PDT)
Date:   Sat, 19 Sep 2020 00:12:11 +0000
In-Reply-To: <20200918132957.GB82043@localhost.localdomain>
Message-Id: <20200919001211.355148-1-hptasinski@google.com>
Mime-Version: 1.0
References: <20200918132957.GB82043@localhost.localdomain>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v2] net: sctp: Fix IPv6 ancestor_size calc in sctp_copy_descendant
From:   Henry Ptasinski <hptasinski@google.com>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Henry Ptasinski <hptasinski@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

When calculating ancestor_size with IPv6 enabled, simply using
sizeof(struct ipv6_pinfo) doesn't account for extra bytes needed for
alignment in the struct sctp6_sock. On x86, there aren't any extra
bytes, but on ARM the ipv6_pinfo structure is aligned on an 8-byte
boundary so there were 4 pad bytes that were omitted from the
ancestor_size calculation.  This would lead to corruption of the
pd_lobby pointers, causing an oops when trying to free the sctp
structure on socket close.

Fixes: 636d25d557d1 ("sctp: not copy sctp_sock pd_lobby in sctp_copy_descendant")
Signed-off-by: Henry Ptasinski <hptasinski@google.com>
---
 include/net/sctp/structs.h | 8 +++++---
 net/sctp/socket.c          | 9 +++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index b33f1aefad09..0bdff38eb4bb 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -226,12 +226,14 @@ struct sctp_sock {
 		data_ready_signalled:1;
 
 	atomic_t pd_mode;
+
+	/* Fields after this point will be skipped on copies, like on accept
+	 * and peeloff operations
+	 */
+
 	/* Receive to here while partial delivery is in effect. */
 	struct sk_buff_head pd_lobby;
 
-	/* These must be the last fields, as they will skipped on copies,
-	 * like on accept and peeloff operations
-	 */
 	struct list_head auto_asconf_list;
 	int do_auto_asconf;
 };
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 836615f71a7d..53d0a4161df3 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9220,13 +9220,10 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 static inline void sctp_copy_descendant(struct sock *sk_to,
 					const struct sock *sk_from)
 {
-	int ancestor_size = sizeof(struct inet_sock) +
-			    sizeof(struct sctp_sock) -
-			    offsetof(struct sctp_sock, pd_lobby);
-
-	if (sk_from->sk_family == PF_INET6)
-		ancestor_size += sizeof(struct ipv6_pinfo);
+	size_t ancestor_size = sizeof(struct inet_sock);
 
+	ancestor_size += sk_from->sk_prot->obj_size;
+	ancestor_size -= offsetof(struct sctp_sock, pd_lobby);
 	__inet_sk_copy_descendant(sk_to, sk_from, ancestor_size);
 }
 
-- 
2.28.0.681.g6f77f65b4e-goog

