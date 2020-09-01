Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247C4258AE4
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Sep 2020 11:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgIAJA3 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 1 Sep 2020 05:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAJA2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 1 Sep 2020 05:00:28 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B6C061244
        for <linux-sctp@vger.kernel.org>; Tue,  1 Sep 2020 02:00:28 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so359233wmh.4
        for <linux-sctp@vger.kernel.org>; Tue, 01 Sep 2020 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQkx8fUG8mwQIi4m4nThh8XuyNKND7WiqTo03rOQoiQ=;
        b=BBVyXvKb4FwZE0yDkzb1CNGgDTLXNI0L0YbqvLpF52oDfaQ1wl43gi5hTteW/c68Qj
         hjZ7BGXFUBmckvySUJgp9jeXeoL4a4lVeet80NCa9hexAp6Q4yI87Ja2Pyo6LBzti22s
         nZ6bOSspj9bE5TdQyk5rfZO6bUGXU+F2kGGI8LD4XzdB6fWk7/RBSx+PMVeSTlJtm4qR
         DbNCMlsc039Pw7VzCNAo9zN6+qDE+osvM4jc/45kt7a03uWb0LS1V02eIfZbVlKbtmcg
         hACdnskItzA1danuDub71PLyu13desZ/qxlV7fETdlqVJPYr29H0eg46YbWTx4CX0TaB
         76VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XQkx8fUG8mwQIi4m4nThh8XuyNKND7WiqTo03rOQoiQ=;
        b=MZgLZP+DRYAzdsayvtX92UpPs5BfvGq/Sgvo3mxQwSsGsJfzWIzZDUIuNusAAqK7dm
         un/hIHInnEV2+/NDnsP1TOpSfEdFGetey84gCTVn7pCTW97t2FTostKPJmkSDmgtHGk1
         zSokCNPiwzpxmjUiHSm647niIMyV7DMP3iLO7NAIWm5bZi6GvZAZ3oF7vOy/elHRgLBV
         4dZb6pwCHWBL7hiJhDOxH61mYmiqm5tCNql4TbGB8pPNFsGmvsZaZsXf8egz6FdlxFwK
         vjEXMhnz4FrzXn6TzTOTCwExLWFfuOY4JH55iq5eCBvOmYS/HLUILawDSYGo2/XNUay0
         ZzVg==
X-Gm-Message-State: AOAM533HbDyhsrTxSe9/hijgQCAR/01YzFy+cfRFDgbx5/1JdIeeBy4p
        y7H9s7tO+Pg5/QLb3XQb5yVMcLiXTKVMBjoW
X-Google-Smtp-Source: ABdhPJw4peF/jYTpY5uLnJmb/rtRjhz/58Rri+AFrPOhLSCvueuDLf3qpNHK5YGfRt6/IbcNk+0EyQ==
X-Received: by 2002:a1c:a90a:: with SMTP id s10mr760397wme.11.1598950826537;
        Tue, 01 Sep 2020 02:00:26 -0700 (PDT)
Received: from ntb.petris.klfree.cz (snat2.klfree.cz. [81.201.48.25])
        by smtp.googlemail.com with ESMTPSA id j7sm1337591wrs.11.2020.09.01.02.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 02:00:25 -0700 (PDT)
From:   Petr Malat <oss@malat.biz>
To:     linux-sctp@vger.kernel.org
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, davem@davemloft.net, kuba@kernel.org,
        Petr Malat <oss@malat.biz>
Subject: [PATCH] sctp: Honour SCTP_PARTIAL_DELIVERY_POINT even under memory pressure
Date:   Tue,  1 Sep 2020 11:00:07 +0200
Message-Id: <20200901090007.31061-1-oss@malat.biz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Command SCTP_CMD_PART_DELIVER issued under memory pressure calls
sctp_ulpq_partial_delivery(), which tries to fetch and partially deliver
the first message it finds without checking if the message is longer than
SCTP_PARTIAL_DELIVERY_POINT. According to the RFC 6458 paragraph 8.1.21.
such a behavior is invalid. Fix it by returning the first message only if
its part currently available is longer than SCTP_PARTIAL_DELIVERY_POINT.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 net/sctp/ulpqueue.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/sctp/ulpqueue.c b/net/sctp/ulpqueue.c
index 1c6c640607c5..cada0b7f1548 100644
--- a/net/sctp/ulpqueue.c
+++ b/net/sctp/ulpqueue.c
@@ -610,6 +610,7 @@ static struct sctp_ulpevent *sctp_ulpq_retrieve_first(struct sctp_ulpq *ulpq)
 	struct sctp_ulpevent *cevent;
 	__u32 ctsn, next_tsn;
 	struct sctp_ulpevent *retval;
+	size_t pd_point, pd_len = 0;
 
 	/* The chunks are held in the reasm queue sorted by TSN.
 	 * Walk through the queue sequentially and look for a sequence of
@@ -633,8 +634,9 @@ static struct sctp_ulpevent *sctp_ulpq_retrieve_first(struct sctp_ulpq *ulpq)
 				first_frag = pos;
 				next_tsn = ctsn + 1;
 				last_frag = pos;
+				pd_len = pos->len;
 			} else
-				goto done;
+				goto check;
 			break;
 
 		case SCTP_DATA_MIDDLE_FRAG:
@@ -643,15 +645,19 @@ static struct sctp_ulpevent *sctp_ulpq_retrieve_first(struct sctp_ulpq *ulpq)
 			if (ctsn == next_tsn) {
 				next_tsn++;
 				last_frag = pos;
+				pd_len += pos->len;
 			} else
-				goto done;
+				goto check;
 			break;
 
 		case SCTP_DATA_LAST_FRAG:
 			if (!first_frag)
 				return NULL;
-			else
+			if (ctsn == next_tsn) {
+				last_frag = pos;
 				goto done;
+			} else
+				goto check;
 			break;
 
 		default:
@@ -659,6 +665,11 @@ static struct sctp_ulpevent *sctp_ulpq_retrieve_first(struct sctp_ulpq *ulpq)
 		}
 	}
 
+check:
+	pd_point = sctp_sk(ulpq->asoc->base.sk)->pd_point;
+	if (pd_point && pd_point > pd_len)
+		return NULL;
+
 	/* We have the reassembled event. There is no need to look
 	 * further.
 	 */
-- 
2.20.1

