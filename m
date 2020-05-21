Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C336F1DD523
	for <lists+linux-sctp@lfdr.de>; Thu, 21 May 2020 19:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgEURtl (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 21 May 2020 13:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730488AbgEURtk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 21 May 2020 13:49:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEADC061A0E;
        Thu, 21 May 2020 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=u1TTf4SfRsqesfP4zvSoxDB03ZVzHC/neNfkO7s8Czo=; b=NhzZqwh5ylYqKwBzTxjQOWOOSz
        KJVQkirWeuOl+nta/3DCimNSjzo/5OAQpF2GrZpUsrvy31l1CS8j2cqxZfAaT4O3odzA9TkbMjUQo
        V5mhn18R7aHWuyIOSC0LViehFvro65Jl+tbF3pwzbZagINa90Cn4WJBTI3uupRVaMyFml4ll029Ow
        ArHJWGeOpiWR4OaQs0SPL/vHXO9x+fnTT+zrDMyppOGpY2gma6697n4/luLSIe/SZaplmgii5qBF+
        0n0INs8pOEJfJ2tCQvj6pIjWWrnBdynbHbTzx8Ir0Xp0C5dQvwO8Zfo9PVc0I7mNonVn9O0rB1q8i
        bU97FMlA==;
Received: from [2001:4bb8:18c:5da7:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbpK3-0003TJ-Nw; Thu, 21 May 2020 17:49:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 48/49] sctp: pass a kernel pointer to sctp_setsockopt_ecn_supported
Date:   Thu, 21 May 2020 19:47:23 +0200
Message-Id: <20200521174724.2635475-49-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521174724.2635475-1-hch@lst.de>
References: <20200521174724.2635475-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Use the kernel pointer that sctp_setsockopt has available instead of
directly handling the user pointer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/sctp/socket.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 755bb23ffa3c9..f9f4776b0bbfd 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4356,27 +4356,21 @@ static int sctp_setsockopt_auth_supported(struct sock *sk,
 }
 
 static int sctp_setsockopt_ecn_supported(struct sock *sk,
-					 char __user *optval,
+					 struct sctp_assoc_value *params,
 					 unsigned int optlen)
 {
-	struct sctp_assoc_value params;
 	struct sctp_association *asoc;
 	int retval = -EINVAL;
 
-	if (optlen != sizeof(params))
-		goto out;
-
-	if (copy_from_user(&params, optval, optlen)) {
-		retval = -EFAULT;
+	if (optlen != sizeof(*params))
 		goto out;
-	}
 
-	asoc = sctp_id2assoc(sk, params.assoc_id);
-	if (!asoc && params.assoc_id != SCTP_FUTURE_ASSOC &&
+	asoc = sctp_id2assoc(sk, params->assoc_id);
+	if (!asoc && params->assoc_id != SCTP_FUTURE_ASSOC &&
 	    sctp_style(sk, UDP))
 		goto out;
 
-	sctp_sk(sk)->ep->ecn_enable = !!params.assoc_value;
+	sctp_sk(sk)->ep->ecn_enable = !!params->assoc_value;
 	retval = 0;
 
 out:
@@ -4631,7 +4625,7 @@ static int sctp_setsockopt(struct sock *sk, int level, int optname,
 		retval = sctp_setsockopt_auth_supported(sk, kopt, optlen);
 		break;
 	case SCTP_ECN_SUPPORTED:
-		retval = sctp_setsockopt_ecn_supported(sk, optval, optlen);
+		retval = sctp_setsockopt_ecn_supported(sk, kopt, optlen);
 		break;
 	case SCTP_EXPOSE_POTENTIALLY_FAILED_STATE:
 		retval = sctp_setsockopt_pf_expose(sk, optval, optlen);
-- 
2.26.2

