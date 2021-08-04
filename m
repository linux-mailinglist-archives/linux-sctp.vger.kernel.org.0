Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6283E0027
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Aug 2021 13:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237128AbhHDL3g (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Aug 2021 07:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhHDL3f (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Aug 2021 07:29:35 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D15C061798
        for <linux-sctp@vger.kernel.org>; Wed,  4 Aug 2021 04:29:22 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c5so1109236qtp.13
        for <linux-sctp@vger.kernel.org>; Wed, 04 Aug 2021 04:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eZbxqp4thrjx6OxSnVNBA8LfSQAfKFEhgC8QjM2fSMY=;
        b=PDs/gyHoJw4gbah3K71UWSB8WYALUl2Jz5rKhYxCmuQn8V4xOqocUeiTyRVqfTd11m
         butAbvMbt9I7bpc3YG1Vdgws48StdKZorBPh6Db2FLf036wXN5SUBuwJ+WFMba6W8aUN
         CLawtDmBR2M5i+w/ThAeh+Szdve7jc1F+JDubbSsUSR0m+HGsdbGDvbfKIzhyKjTSiMI
         ZYH6CPZERbW2vbCwww162cR02tKMrksn3aah9QJLQEnMziQtOvc3E8JnLCgKxyoxnDaC
         m2wLI7Q8X4oDoRA80XAUidoK+IJsTCTnEPJ69Z0oub96hK9M2Ec2+yFEOL6e4C6C6Fly
         OsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZbxqp4thrjx6OxSnVNBA8LfSQAfKFEhgC8QjM2fSMY=;
        b=qv10KZzc+IpXiXHbtb19Ix4OyvfLC8hI1PZ41f+OT3hG9c04OZ1sjJcmVRmWQBrDju
         PvdkMvdijMWGSs2bn2yQemIcwzRnmRzTKqDnaqzicL+sFhxKqZ4di9HlxvgBnjAk9HVA
         3ahH8c83mj0n9JXJd5AMrC6YREwpUS8JjGwnSzxGdJHXPKE+EwuNvaQUoLW3DzuDbli5
         BAewis21WUh3GRNviJ+X3hxeDBvOJTpE7apdYe8Po2WC3d+PdiQikPOriDAi/1dLjsjw
         3rQNgNZHqKINGxJzVetuqz6qf4lBk6qpDKT8zvssHrtna93ZHYH6NGBrOGiVEaGIFwxb
         uO4g==
X-Gm-Message-State: AOAM533bOuPSmKR72JCYqVAhEGckNDwHM2y+pBftwGOyB80pV1b/zI1q
        p5fJ+mz5wy8R6JIYIGRRtTO++Lr0xV33tw==
X-Google-Smtp-Source: ABdhPJw5OLwrHlQFdQMekTXzCD2NZja6SRNTweLEbCDkeV50okd+RehAzkkCi31RdGobeOYITJZhbw==
X-Received: by 2002:ac8:7452:: with SMTP id h18mr22767970qtr.206.1628076561350;
        Wed, 04 Aug 2021 04:29:21 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l29sm806734qtn.8.2021.08.04.04.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:29:20 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools 3/4] sctp_test: replace use of deprecated gethostbyname with getaddrinfo
Date:   Wed,  4 Aug 2021 07:29:15 -0400
Message-Id: <30cb9c19a9c1e511fde7880046126aa81a659ff8.1628076531.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1628076531.git.lucien.xin@gmail.com>
References: <cover.1628076531.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This patch is to replace use of deprecated gethostbyname with
getaddrinfo in the file src/apps/sctp_test.c.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 src/apps/sctp_test.c | 63 +++++++++++---------------------------------
 1 file changed, 16 insertions(+), 47 deletions(-)

diff --git a/src/apps/sctp_test.c b/src/apps/sctp_test.c
index cd7654b..e382804 100644
--- a/src/apps/sctp_test.c
+++ b/src/apps/sctp_test.c
@@ -487,14 +487,11 @@ struct sockaddr *
 append_addr(const char *parm, struct sockaddr *addrs, int *ret_count)
 {
 	struct sockaddr *new_addrs = NULL;
+	struct addrinfo hints, *res, *rp;
 	void *aptr;
 	struct sockaddr *sa_addr;
 	struct sockaddr_in *b4ap;
 	struct sockaddr_in6 *b6ap;
-	struct hostent *hst4 = NULL;
-	struct hostent *hst6 = NULL;
-	int i4 = 0;
-	int i6 = 0;
 	int j;
 	int orig_count = *ret_count;
 	int count = orig_count;
@@ -514,27 +511,16 @@ append_addr(const char *parm, struct sockaddr *addrs, int *ret_count)
 		}
 	}
 
-	/* Get the entries for this host.  */
-	hst4 = gethostbyname(ipaddr);
-	hst6 = gethostbyname2(ipaddr, AF_INET6);
-
-	if ((NULL == hst4 || hst4->h_length < 1)
-	    && (NULL == hst6 || hst6->h_length < 1)) {
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_family = AF_UNSPEC;
+	hints.ai_protocol = IPPROTO_SCTP;
+	if (getaddrinfo(ipaddr, NULL, &hints, &res) != 0) {
 		fprintf(stderr, "bad hostname: %s\n", ipaddr);
 		goto finally;
 	}
 
-	/* Figure out the number of addresses.  */
-	if (NULL != hst4) {
-		for (i4 = 0; NULL != hst4->h_addr_list[i4]; ++i4) {
-			count++;
-		}
-	}
-	if (NULL != hst6) {
-		for (i6 = 0; NULL != hst6->h_addr_list[i6]; ++i6) {
-			count++;
-		}
-	}
+	for (rp = res; rp != NULL; rp = rp->ai_next)
+		count++;
 
 	/* Expand memory for the new addresses.  Assume all the addresses
 	 * are v6 addresses.
@@ -565,34 +551,17 @@ append_addr(const char *parm, struct sockaddr *addrs, int *ret_count)
 	}
 
 	/* Put the new addresses away.  */
-	if (NULL != hst4) {
-		for (j = 0; j < i4; ++j) {
-			b4ap = (struct sockaddr_in *)aptr;
-			memset(b4ap, 0x00, sizeof(*b4ap));
-			b4ap->sin_family = AF_INET;
-			b4ap->sin_port = htons(local_port);
-			bcopy(hst4->h_addr_list[j], &b4ap->sin_addr,
-			      hst4->h_length);
-
-			aptr += sizeof(struct sockaddr_in);
-		} /* for (loop through the new v4 addresses) */
-	}
-
-	if (NULL != hst6) {
-		for (j = 0; j < i6; ++j) {
-			b6ap = (struct sockaddr_in6 *)aptr;
-			memset(b6ap, 0x00, sizeof(*b6ap));
-			b6ap->sin6_family = AF_INET6;
-			b6ap->sin6_port =  htons(local_port);
+	for (rp = res; rp != NULL; rp = rp->ai_next) {
+		b4ap = (struct sockaddr_in *)aptr;
+		b6ap = (struct sockaddr_in6 *)aptr;
+		bcopy(rp->ai_addr, aptr, rp->ai_addrlen);
+		b4ap->sin_port = htons(local_port); /* equal to b6ap.v6.sin6_port */
+		if (rp->ai_family == AF_INET6) {
 			b6ap->sin6_scope_id = if_index;
-			bcopy(hst6->h_addr_list[j], &b6ap->sin6_addr,
-			      hst6->h_length);
-			if (!ifindex) {
+			if (!ifindex)
 				b6ap->sin6_scope_id = ifindex;
-			}
-
-			aptr += sizeof(struct sockaddr_in6);
-		} /* for (loop through the new v6 addresses) */
+		}
+		aptr += rp->ai_addrlen;
 	}
 
  finally:
-- 
2.27.0

