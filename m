Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FDD445ADD
	for <lists+linux-sctp@lfdr.de>; Thu,  4 Nov 2021 20:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhKDUCf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 4 Nov 2021 16:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27463 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232063AbhKDUCd (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 4 Nov 2021 16:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636055994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5ysUK4zlUy4qbvF8xulmXFjW7M2EeOHCxuh+1FxUYgQ=;
        b=BzxrijMXlaWqNy15Lz81KEwYr09zUMJC7FWAvEQ/tSMKknwhxXxl7Kjs53z2FYrQV3BN4t
        PSZatCO2FEtjfMx1gL36jiXFc+LOoC4B0BIu5DqOBWx7tafqaHuuivD2aD6BM0F7CMCf9E
        qvkWjg0erlbT1fJ7G5fsFO2twiipAm4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-VMdgZ223Pq2gbuIShJcw1Q-1; Thu, 04 Nov 2021 15:59:50 -0400
X-MC-Unique: VMdgZ223Pq2gbuIShJcw1Q-1
Received: by mail-ed1-f70.google.com with SMTP id s12-20020a50dacc000000b003dbf7a78e88so6808008edj.2
        for <linux-sctp@vger.kernel.org>; Thu, 04 Nov 2021 12:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ysUK4zlUy4qbvF8xulmXFjW7M2EeOHCxuh+1FxUYgQ=;
        b=WqT5+jDHj/QLeS+qd02/BOMOGq0Ff21LbXfzskKsC3KEPjJNMBg/ogDMlcJ4no2gYV
         PFCY6ZjNqYozdFTlqeUF7MDmcqPvNedR2gthxqCNinp2SuzbhxZKNqgl3ZiLGMSYda5p
         OtZT2GVbysPdK07Xzq6J8ASnfbcRslAAJY8/IZkEy//2MdaVtuR9ltceVoLrRyBQiqwj
         6juqdS5nGTfeOsGp4rsjD0KVenszzfQezlhVsZVpiIJQzFvyoCpWgkROELEI6Q37PMru
         xqZdU5OiQs1TsDTZJwA4+B4Sf9Bf1rw977Tl9rmib4NXjJ2NrgVtXNZjqSTvn7QZE5BV
         2IxA==
X-Gm-Message-State: AOAM532Qh2MO80g4lgVChb3nHJ9zdfrlONAmFRmwbmwadc/s7x+hMfUX
        HZICqT9W7cUB89xieqfP7jD/9gvFOamK6cnxHlkaQKh6tEaeDiuGF2dCVo/rSsd2w6xbtGXxAU+
        DoJljCMtT3GcMWGK4WIB9bg==
X-Received: by 2002:a17:906:c9cb:: with SMTP id hk11mr64150289ejb.204.1636055989309;
        Thu, 04 Nov 2021 12:59:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBAGFvqsv+54+E13aafHdXqWywSbJFTfv5rjyniwJl/0Di8RDpeDpuIohiIg3dLqbwbBM56g==
X-Received: by 2002:a17:906:c9cb:: with SMTP id hk11mr64150267ejb.204.1636055989131;
        Thu, 04 Nov 2021 12:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:d067:83f0:d612:b70f])
        by smtp.gmail.com with ESMTPSA id p3sm3096445ejy.94.2021.11.04.12.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 12:59:48 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     Xin Long <lucien.xin@gmail.com>, Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] selinux: fix SCTP client peeloff socket labeling
Date:   Thu,  4 Nov 2021 20:59:49 +0100
Message-Id: <20211104195949.135374-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

The commit referenced in the "Fixes" tag mistakenly attempted to
preserve the label of the peeloff socket that had been set in
selinux_socket_post_create() in the case of a client socket. However,
the peeloff socket should in fact just inherit the label from the parent
socket. In practice these labels are usually the same, but they may
differ when setsockcreatecon(3) or socket type transition rules are
involved.

The fact that selinux_socket_[post_]create() are called on the peeloff
socket is actually not what should be happening (it is a side effect of
sctp_do_peeloff() using socket_create() to create the socket, which
calls the aforementioned LSM hooks). A patch to fix this is being worked
on.

In the meanwhile, at least fix sctp_assoc_established() to set
asoc->secid to the socket's sid and selinux_sctp_sk_clone() to
unconditionally get the peeloff socket's sid from asoc->secid, which
will ensure that the peeloff socket gets the right label in case of both
client and server SCTP socket. The label set by
selinux_socket_post_create() will be simply overwritten in both cases,
as was the case before the commit this patch is fixing.

Passed both the selinux-testsuite (with client peeloff tests added) and
the SCTP functional test suite from lksctp-tools.

Fixes: e7310c94024c ("security: implement sctp_assoc_established hook in selinux")
Based-on-patch-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

As agreed with Xin Long, I'm posting this fix up instead of him. I am
now fairly convinced that this is the right way to deal with the
immediate problem of client peeloff socket labeling. I'll work on
addressing the side problem regarding selinux_socket_post_create()
being called on the peeloff sockets separately.

Please don't merge this patch without an ack from Paul, as it seems
we haven't reached an overall consensus yet.

 security/selinux/hooks.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5e5215fe2e83..5d9da4662449 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5502,8 +5502,7 @@ static void selinux_sctp_sk_clone(struct sctp_association *asoc, struct sock *sk
 	if (!selinux_policycap_extsockclass())
 		return selinux_sk_clone_security(sk, newsk);
 
-	if (asoc->secid != SECSID_WILD)
-		newsksec->sid = asoc->secid;
+	newsksec->sid = asoc->secid;
 	newsksec->peer_sid = asoc->peer_secid;
 	newsksec->sclass = sksec->sclass;
 	selinux_netlbl_sctp_sk_clone(sk, newsk);
@@ -5566,7 +5565,7 @@ static void selinux_sctp_assoc_established(struct sctp_association *asoc,
 
 	selinux_inet_conn_established(asoc->base.sk, skb);
 	asoc->peer_secid = sksec->peer_sid;
-	asoc->secid = SECSID_WILD;
+	asoc->secid = sksec->sid;
 }
 
 static int selinux_secmark_relabel_packet(u32 sid)
-- 
2.31.1

