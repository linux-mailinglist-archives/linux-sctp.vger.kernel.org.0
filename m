Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C635DC69
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Apr 2021 12:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241910AbhDMKVA (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 13 Apr 2021 06:21:00 -0400
Received: from mx0b-00169c01.pphosted.com ([67.231.156.123]:39038 "EHLO
        mx0b-00169c01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241611AbhDMKU7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 13 Apr 2021 06:20:59 -0400
X-Greylist: delayed 2907 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Apr 2021 06:20:59 EDT
Received: from pps.filterd (m0048188.ppops.net [127.0.0.1])
        by mx0b-00169c01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13D9OpWv016509
        for <linux-sctp@vger.kernel.org>; Tue, 13 Apr 2021 02:32:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paloaltonetworks.com; h=from : to :
 cc : subject : date : message-id : mime-version :
 content-transfer-encoding; s=PPS12012017;
 bh=k1uzUWieStLbjBrWN9sf01s97HUk5RnWp9G0mNUWDHk=;
 b=O+c06ThmP4xopO1TyhPUSPmLk4wfeMNAuu3XGXtWncQjuymSAranFS0b+N1hxIIQO5Hi
 DJkhajGjJURAl5tAfaxjth0bzW6NXaqrIHWi8iDnZ9dvyRI1TW5TPyO/hxBtJB8nZMdc
 0J4IHytCFJ3MBDN2WQ87HisY+ltCmY9UHMvU5qLYz5jha24oe22U2FAKGOLUml27kMYW
 nmQK1X5/eQa3rJEG6uGY5OFjNxfNfcdvFLh/neLBBWfMd+cAoQUnumBB1r0sZs0iH0hN
 Xu4si1fV3C3/i+F591WZSljffO9UtdAifsOVRzpBbimzf6mWxONBttYx9UNr8zNWGGtl gQ== 
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        by mx0b-00169c01.pphosted.com with ESMTP id 37vgx6er1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-sctp@vger.kernel.org>; Tue, 13 Apr 2021 02:32:11 -0700
Received: by mail-wr1-f72.google.com with SMTP id z6so529350wrh.11
        for <linux-sctp@vger.kernel.org>; Tue, 13 Apr 2021 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paloaltonetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1uzUWieStLbjBrWN9sf01s97HUk5RnWp9G0mNUWDHk=;
        b=ruMfn12kgeIWbVMfy+Y5iBoujea6HuyyXpIzzYnoCpZZcMIOF21puwQDIulvgiBovT
         YAl4HKHPLb0MZ0BgwARZIyiHxmUs2+NOPJgs/5A4kvP0PihQbj4lYifVv82YFMMNo9x5
         NfFbqE5ga0UfFINmZAmL4kXkFr3laz2o1XFqhzxc0xrk4I3DqcNdg0euGIoqFxlsbDum
         Ap84l3GzT0hSZ91w9GLG4kb5qJkvDpybO4pUllt0da3IeIreu0jP5bCdFZvI8ETOSoUE
         T/KRv0B2iIs1l6bZM0/D36ifsVvJ0cNOafvBoeMbpn6YXV2WUcqagtFJi8RZzYzbuIif
         Gi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k1uzUWieStLbjBrWN9sf01s97HUk5RnWp9G0mNUWDHk=;
        b=EqPHPk/n3/X814wmUQCm2NfxPFEfEImbFyD7jeYC+lVtOiklqymBQ50EBh6jVYojlb
         D84tY++6w1Jw2g8r5SWegxU1j8Vpd1HHzJBRhI4OTpp13YQnPZ+uBoGxyC6M9GE+dqvc
         ajOnWfuscQY4uyoaSkeTG7nUu3+suQYKQFrH+MYPsM9dbaqw+Uz6xbuPh2UQ7G5lzuc/
         ICHimWYhCOPRdyvdAvqYbwoA/sfoZjexkTy+ZVG27SeU6i46Xrslze9mPw1WZwO45Z9h
         zU8V/0o9jg1wAaWkGHZ9Hs1R8avkmQNXjSaaCmYUmqGI622nAwGWSCmPsVlwr83EWVEO
         bV7w==
X-Gm-Message-State: AOAM533P7B0TcL2eShyuyPrZxkYnRzo1JIGKOxbC8zgI3ipgItiUYupa
        4c0XG8+x5Mk9SAkT3LhywDOGdSQkxx8G+PtpRi7CizFD0cB6npIy41D2PN9QCkV182TR1zXbKRt
        VMLwLAVjeDPiEodgYzShr4w==
X-Received: by 2002:a5d:66cf:: with SMTP id k15mr744315wrw.404.1618306329668;
        Tue, 13 Apr 2021 02:32:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8xgLKlcrbSmuAMJZs9DVRk7zd5FD5tma7sW5EktfSB+kqjqea8DyHuNtAaT3WnpOn/ceoNw==
X-Received: by 2002:a5d:66cf:: with SMTP id k15mr744299wrw.404.1618306329438;
        Tue, 13 Apr 2021 02:32:09 -0700 (PDT)
Received: from localhost.localdomain (bzq-79-181-151-86.red.bezeqint.net. [79.181.151.86])
        by smtp.gmail.com with ESMTPSA id v4sm22075373wrf.36.2021.04.13.02.32.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Apr 2021 02:32:07 -0700 (PDT)
From:   Or Cohen <orcohen@paloaltonetworks.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, davem@davemloft.net, kuba@kernel.org,
        linux-sctp@vger.kernel.org, lucien.xin@gmail.com
Cc:     nmarkus@paloaltonetworks.com,
        Or Cohen <orcohen@paloaltonetworks.com>
Subject: [PATCH] net/sctp: fix race condition in sctp_destroy_sock
Date:   Tue, 13 Apr 2021 12:31:53 +0300
Message-Id: <20210413093153.27281-1-orcohen@paloaltonetworks.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C-zEX14bKMqJQ7zFNU08jVJBTyL1dKFq
X-Proofpoint-GUID: C-zEX14bKMqJQ7zFNU08jVJBTyL1dKFq
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-13_04:2021-04-13,2021-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam score=0 mlxlogscore=374
 priorityscore=1501 clxscore=1011 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130065
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

If sctp_destroy_sock is called without sock_net(sk)->sctp.addr_wq_lock
held and sp->do_auto_asconf is true, then an element is removed
from the auto_asconf_splist without any proper locking.

This can happen in the following functions:
1. In sctp_accept, if sctp_sock_migrate fails.
2. In inet_create or inet6_create, if there is a bpf program
   attached to BPF_CGROUP_INET_SOCK_CREATE which denies
   creation of the sctp socket.

The bug is fixed by acquiring addr_wq_lock in sctp_destroy_sock
instead of sctp_close.

Reported-by: Or Cohen <orcohen@paloaltonetworks.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Fixes: 610236587600 ("bpf: Add new cgroup attach type to enable sock modifications")
Signed-off-by: Or Cohen <orcohen@paloaltonetworks.com>
---
 net/sctp/socket.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index a710917c5ac7..9af232d4fb6b 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1520,11 +1520,9 @@ static void sctp_close(struct sock *sk, long timeout)
 
 	/* Supposedly, no process has access to the socket, but
 	 * the net layers still may.
-	 * Also, sctp_destroy_sock() needs to be called with addr_wq_lock
-	 * held and that should be grabbed before socket lock.
 	 */
-	spin_lock_bh(&net->sctp.addr_wq_lock);
-	bh_lock_sock_nested(sk);
+	local_bh_disable();
+	bh_lock_sock(sk);
 
 	/* Hold the sock, since sk_common_release() will put sock_put()
 	 * and we have just a little more cleanup.
@@ -1533,7 +1531,7 @@ static void sctp_close(struct sock *sk, long timeout)
 	sk_common_release(sk);
 
 	bh_unlock_sock(sk);
-	spin_unlock_bh(&net->sctp.addr_wq_lock);
+	local_bh_enable();
 
 	sock_put(sk);
 
@@ -5030,7 +5028,9 @@ static void sctp_destroy_sock(struct sock *sk)
 
 	if (sp->do_auto_asconf) {
 		sp->do_auto_asconf = 0;
+		spin_lock_bh(&sock_net(sk)->sctp.addr_wq_lock);
 		list_del(&sp->auto_asconf_list);
+		spin_unlock_bh(&sock_net(sk)->sctp.addr_wq_lock);
 	}
 	sctp_endpoint_free(sp->ep);
 	local_bh_disable();
-- 
2.7.4

