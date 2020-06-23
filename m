Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5847E2056BC
	for <lists+linux-sctp@lfdr.de>; Tue, 23 Jun 2020 18:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732236AbgFWQEY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 23 Jun 2020 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732224AbgFWQEY (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 23 Jun 2020 12:04:24 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC2AC061573;
        Tue, 23 Jun 2020 09:04:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e5so17100774ote.11;
        Tue, 23 Jun 2020 09:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zaKtthY1nsaDasEOa6ucSdKyxIbtyGjeZUxtrpdMIv4=;
        b=mMOEp1t9Nb/dq0osQpb8sxQmI9ZdqSvDHMOXatiXLujBaHx92mcFI9IrCFNk4f5qcL
         xLEZn7m5xgEmb056pZLC6qlL2FItluG1LYc2bGg555/2LvmkJy2cmyz9okqluIJKmbyE
         pVmDM8aDKDUGMghxrcCtyW/ALFG1q7C8UpA8R0Y96sAlfzPBFEReEwEXipHTEglfAXhk
         zrFch7dfEO474YRUSrL73MFMDVvWZ0YD0F2VjbEZOywdPuSofBsqVLZxIl0eSoh4bQuB
         Xhh8CGz4jYi8qLj+fjuA837ZtC5nYMQQ7iwYxUzqKzKR3P8LyFqZMBAN6Dm5cIUXlnvl
         18Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=zaKtthY1nsaDasEOa6ucSdKyxIbtyGjeZUxtrpdMIv4=;
        b=dD2BMvjYLnvdczXVZBB/a854epKdKQKG0mAcd7nOTxWEKePCc7RHtOSIZjB33RbCVZ
         7wsmg93fhAHtD5pyuW45kr4Zvf4L7LkUFmhWRTfF46gYQRuSFwZMOgcn4LwPn/bY2mYf
         msuuS5M8cVE1G08bszwSiv/rtIVMY2AdseW4SictHm0Zyx6CjSFiOgVMsws2dcaXLdN5
         POOlbHsPC2RddziAlUjd4lQWt5xZmWMXDaAMhvH/4gjBZQwr/p8ZXq0vom8JnDG23fPA
         IZDWIM48LyOWizOCzuW1qn5VAIMQ56PctVvEaitNvV/9Uca3kgXAwqcLDVxIPHScPEnv
         ln0w==
X-Gm-Message-State: AOAM5312VdSpkJ1LN8DB7C1XZRy/ZxcWg5QUSnEKiOIDKH6PpZ0y62pG
        BmTST8FVYoPcftHrlMOQcg==
X-Google-Smtp-Source: ABdhPJwoC/Juun94t/+Y/w2TtWleh4zh2/D9umvQNUrCyHkT/ekhAUm2lkr7YduTB23ZxHkwuRRLPQ==
X-Received: by 2002:a9d:754e:: with SMTP id b14mr3506738otl.112.1592928263536;
        Tue, 23 Jun 2020 09:04:23 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id l2sm710153oti.67.2020.06.23.09.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:04:22 -0700 (PDT)
Received: from t560.minyard.net (unknown [IPv6:2001:470:b8f6:1b:6d79:306:b4b0:35c1])
        by serve.minyard.net (Postfix) with ESMTPA id D03C618003A;
        Tue, 23 Jun 2020 16:04:21 +0000 (UTC)
From:   minyard@acm.org
To:     Xin Long <lucien.xin@gmail.com>,
        Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>
Subject: [PATCH] sctp: Don't advertise IPv4 addresses if ipv6only is set on the socket
Date:   Tue, 23 Jun 2020 11:04:17 -0500
Message-Id: <20200623160417.12418-1-minyard@acm.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
References: <c1121947c9a94703b4ab6dc434a7c3f8@AcuMS.aculab.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Corey Minyard <cminyard@mvista.com>

If a socket was set ipv6only, it would still send IPv4 addresses in the
init and init ack packets.  So don't add IPv4 addresses to ipv6only
sockets.

Based on a patch by Xin Long <lucien.xin@gmail.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
I have tested this and it seem to fix the issue.  However, I'm wondering
if it might be better to fix it where the addresses are put into the
association as opposed to where they are put into the message.

 include/net/sctp/structs.h | 3 ++-
 net/sctp/bind_addr.c       | 7 ++++++-
 net/sctp/sm_make_chunk.c   | 5 +++--
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index fb42c90348d3..1e839bf4eaa7 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -1190,7 +1190,8 @@ union sctp_addr *sctp_find_unmatch_addr(struct sctp_bind_addr	*bp,
 					const union sctp_addr	*addrs,
 					int			addrcnt,
 					struct sctp_sock	*opt);
-union sctp_params sctp_bind_addrs_to_raw(const struct sctp_bind_addr *bp,
+union sctp_params sctp_bind_addrs_to_raw(const struct sctp_association *asoc,
+					 const struct sctp_bind_addr *bp,
 					 int *addrs_len,
 					 gfp_t gfp);
 int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp, __u8 *raw, int len,
diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
index 53bc61537f44..3f5b448f2127 100644
--- a/net/sctp/bind_addr.c
+++ b/net/sctp/bind_addr.c
@@ -202,7 +202,8 @@ int sctp_del_bind_addr(struct sctp_bind_addr *bp, union sctp_addr *del_addr)
  *
  * The second argument is the return value for the length.
  */
-union sctp_params sctp_bind_addrs_to_raw(const struct sctp_bind_addr *bp,
+union sctp_params sctp_bind_addrs_to_raw(const struct sctp_association *asoc,
+					 const struct sctp_bind_addr *bp,
 					 int *addrs_len,
 					 gfp_t gfp)
 {
@@ -214,6 +215,7 @@ union sctp_params sctp_bind_addrs_to_raw(const struct sctp_bind_addr *bp,
 	struct sctp_sockaddr_entry *addr;
 	struct list_head *pos;
 	struct sctp_af *af;
+	struct sock *sk = asoc->base.sk;
 
 	addrparms_len = 0;
 	len = 0;
@@ -238,6 +240,9 @@ union sctp_params sctp_bind_addrs_to_raw(const struct sctp_bind_addr *bp,
 	addrparms = retval;
 
 	list_for_each_entry(addr, &bp->address_list, list) {
+		if ((PF_INET6 == sk->sk_family) && inet_v6_ipv6only(sk) &&
+		    (AF_INET == addr->a.sa.sa_family))
+			continue;
 		af = sctp_get_af_specific(addr->a.v4.sin_family);
 		len = af->to_addr_param(&addr->a, &rawaddr);
 		memcpy(addrparms.v, &rawaddr, len);
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 47910470e532..6e1a6af40779 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -230,7 +230,7 @@ struct sctp_chunk *sctp_make_init(const struct sctp_association *asoc,
 	 */
 
 	/* Convert the provided bind address list to raw format. */
-	addrs = sctp_bind_addrs_to_raw(bp, &addrs_len, gfp);
+	addrs = sctp_bind_addrs_to_raw(asoc, bp, &addrs_len, gfp);
 
 	init.init_tag		   = htonl(asoc->c.my_vtag);
 	init.a_rwnd		   = htonl(asoc->rwnd);
@@ -397,7 +397,8 @@ struct sctp_chunk *sctp_make_init_ack(const struct sctp_association *asoc,
 	int addrs_len;
 
 	/* Note: there may be no addresses to embed. */
-	addrs = sctp_bind_addrs_to_raw(&asoc->base.bind_addr, &addrs_len, gfp);
+	addrs = sctp_bind_addrs_to_raw(asoc, &asoc->base.bind_addr,
+				       &addrs_len, gfp);
 
 	initack.init_tag	        = htonl(asoc->c.my_vtag);
 	initack.a_rwnd			= htonl(asoc->rwnd);
-- 
2.17.1

