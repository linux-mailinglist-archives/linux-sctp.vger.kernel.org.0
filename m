Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D49D26EABA
	for <lists+linux-sctp@lfdr.de>; Fri, 18 Sep 2020 03:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIRB4e (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Sep 2020 21:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgIRB4e (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Sep 2020 21:56:34 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D332C061756
        for <linux-sctp@vger.kernel.org>; Thu, 17 Sep 2020 18:56:34 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id b14so2433126pls.12
        for <linux-sctp@vger.kernel.org>; Thu, 17 Sep 2020 18:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=plri2Uj3/0BhgvuieDQpUkOHYJKw7kGC3Aab3VEZGKQ=;
        b=MSO3o5W/igtbxRhTbaYu3Fy98SftdTC8wrSqBsfAbt7VGWh6gP/3AfRhpZwfx7VYMC
         oB9Hki72jyLdjDH4Ue4buFyBn8xGPdxV5+UPftCqgrmntqKuoM8RCVP7ABvVKCCmiz2z
         z51lOg3kVqAR4izTX+GIAnOCEJZGqOkuIFiiRyGvumhOQbIRszQCoRRauL8i5vOJufMn
         bglqHgZ0ES/+c7D2NvBqIBPsqFNPwu0v4BYWUt3NR5zzCxRvYv0mCoo7NrZiwXSFRLgT
         TkYOQ2xmBLLvl7PVZIllHsUWw92yT3nyvqEhAaqi/HdZuPhTJ+9YNhm2jErOi1BDsWza
         EQKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=plri2Uj3/0BhgvuieDQpUkOHYJKw7kGC3Aab3VEZGKQ=;
        b=gSJcNu5BoO8gNs/KW6/NSYQd55oPq9WTciRaG5G43qZ0cBFl9IfkFK1eZrIU8WybvY
         QUrrmjfOGwROlq1CtyJXvk5SBrcKnmsQHWN8G2+TUXRNiwUB9yXnBWY88eE/8Iwiboc2
         Xa9pLDxQOZiV1veftM6kFA3bGFctjd5+BK6nryitS0K8AqWqjYvTWkWnRG4AHV2uW5ue
         bJtZuQDhpyMNhzI4C+qIRKMMzyN5nwngdpUZoVGzVEOS05A+r64BYV+/tPAExAngem37
         Rrknbcc2LJFLg8UylOMPnAYeFa8FjNtuR373Id11p+Dn3so064yC2g4/u19FjgEHy2Wc
         2oVg==
X-Gm-Message-State: AOAM533c1al2JY15ZVj1U6hx1Iv2pdkj7yDRSxd/3bEiACYMvHhW74LW
        MO3VUY/ZdO9653aOSEzNSpy5pIvtmpFw6gjpt9PqOyMxadVFSUomGmaPMDnQOsx2m8haF/I2xgI
        7U+Sun31MKEjjhYfau4EOnHaWKiVX6ccWN5TWgK4GnvLNUd7h3fN7agnN/61zlJXti9ptOC02pD
        HTgg==
X-Google-Smtp-Source: ABdhPJyh7WutTEzL4pOGf9wf4jTaj43QlQJP1pYJ6OUulPVJn5lWVCzRNh6mMP8KyN4wkkLG2CwIgjLwUm8t888J
X-Received: from hptasinski.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1641])
 (user=hptasinski job=sendgmr) by 2002:a63:4656:: with SMTP id
 v22mr8672457pgk.116.1600394193300; Thu, 17 Sep 2020 18:56:33 -0700 (PDT)
Date:   Fri, 18 Sep 2020 01:56:10 +0000
Message-Id: <20200918015610.3596417-1-hptasinski@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH] net: sctp: Fix IPv6 ancestor_size calc in sctp_copy_descendant
From:   Henry Ptasinski <hptasinski@google.com>
To:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
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

Signed-off-by: Henry Ptasinski <hptasinski@google.com>
---
 net/sctp/socket.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 836615f71a7d..a6358c81f087 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9220,12 +9220,14 @@ void sctp_copy_sock(struct sock *newsk, struct sock *sk,
 static inline void sctp_copy_descendant(struct sock *sk_to,
 					const struct sock *sk_from)
 {
-	int ancestor_size = sizeof(struct inet_sock) +
-			    sizeof(struct sctp_sock) -
-			    offsetof(struct sctp_sock, pd_lobby);
+	size_t ancestor_size = sizeof(struct inet_sock);
 
 	if (sk_from->sk_family == PF_INET6)
-		ancestor_size += sizeof(struct ipv6_pinfo);
+		ancestor_size += sizeof(struct sctp6_sock);
+	else
+		ancestor_size += sizeof(struct sctp_sock);
+
+	ancestor_size -= offsetof(struct sctp_sock, pd_lobby);
 
 	__inet_sk_copy_descendant(sk_to, sk_from, ancestor_size);
 }
-- 
2.28.0.681.g6f77f65b4e-goog

