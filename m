Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D363E0028
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Aug 2021 13:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbhHDL3h (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Aug 2021 07:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbhHDL3h (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Aug 2021 07:29:37 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B05C0613D5
        for <linux-sctp@vger.kernel.org>; Wed,  4 Aug 2021 04:29:23 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id cg4so906795qvb.5
        for <linux-sctp@vger.kernel.org>; Wed, 04 Aug 2021 04:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7yMiLCAXJnA9iYcbJdbB0Yemhpi1pEtaZ2ZtXAiL7O8=;
        b=s63RUSVQ9FEV9mHbdBuNE9eqkGxRmYHwiGR3NtAyGqWUb4VCWLBHzuvupl9z5VQPR/
         a8hbHWTBsHgD4SAuYVC2OgxqtNTdG/ibDK+SRnUfouvCOMta3cdVX+O/anKPKhh91eJl
         Oy9XcZT+L1I9KgF/qLVG4zS496yfi8OqiUGiiXKZsbORciH+Z7lNPGQFWHKYv+IEY0pR
         XlUfJPw6wmi6B+pSl6J28WFPLLd/IWodmGBYM2KOHLxibaXUwF3AfzXBxgJRw7mhKI5x
         CqzrFmsy5bJUVeEkU6mFRZHXcOFsapVCqYDdtB5WwbMnnv5A1dxWUL2JEUkwaeBihz8d
         OpVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yMiLCAXJnA9iYcbJdbB0Yemhpi1pEtaZ2ZtXAiL7O8=;
        b=Qu2voIyw1lW1a1DWLh0GsG8TIjQ6RTDWRTOg2XiN21UyA6TZ9ik5pnH0XOnD9grNCY
         LZ5dXHI2PjJy8daV9HgiBfKIkuopqewEJquY3GoY6HUTvGfD4Q9tri3nvQn8a/M5OYP9
         EYRnnX3Re+mnBMfS1z4lZAgVq46hIyQyss/8waDvz7fRwQYQBeRnaHzHahYOPUpbf9cl
         Un2ZjGO7FiqxfJAgYSVduZ/87Msjzzsx01IOA3I/UkMDZx5H099HUue2e6g7v8gPqdbf
         EyRi8XEf04Lh+6IBt+33F+icmIc3aov/5e/lw+auVbIKGxVqYkNvgW+Ht9qIjJFf4Yeo
         ikyg==
X-Gm-Message-State: AOAM533qJQGKNN/dqMbHi5VyWpKZsH4HVeEIDnl0zIOSj+/KJpVzwM9c
        4yua/XheMcm27/EkEBYMTkRMp7h66Z+ZnA==
X-Google-Smtp-Source: ABdhPJxAm+0pZW1noyXVJSxFMW+RDVdCRyuEiQqVEM14oIQR3M/Ac3BU9pxXKGJ6lS8ViELnZMjhcg==
X-Received: by 2002:ad4:58cb:: with SMTP id dh11mr26418458qvb.29.1628076562587;
        Wed, 04 Aug 2021 04:29:22 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id bm7sm1100844qkb.79.2021.08.04.04.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 04:29:22 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools 4/4] sctp_darn: replace use of deprecated gethostbyname with getaddrinfo
Date:   Wed,  4 Aug 2021 07:29:16 -0400
Message-Id: <957cd3ddeb19fa8bced4abe9cb160804fe73767e.1628076531.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1628076531.git.lucien.xin@gmail.com>
References: <cover.1628076531.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This patch is to replace use of deprecated gethostbyname with
getaddrinfo in the file src/apps/sctp_darn.c.

Note that different from sctp_test, sctp_darn prefers v4 address
to v6 address when getting addrinfo from hostname. To keep the
compatibility, we don't change it.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 configure.ac         |   2 +-
 src/apps/sctp_darn.c | 246 +++++++++++++------------------------------
 2 files changed, 72 insertions(+), 176 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8345dab..28132bf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,7 +75,7 @@ AC_FUNC_REALLOC
 AC_FUNC_SELECT_ARGTYPES
 AC_FUNC_SETVBUF_REVERSED
 AC_FUNC_VPRINTF
-AC_CHECK_FUNCS([bzero getaddrinfo gethostbyname gettimeofday memmove memset select socket \
+AC_CHECK_FUNCS([bzero getaddrinfo gettimeofday memmove memset select socket \
 		strchr strerror strtol strtoul])
 
 # Support for stream reset even, added on v4.11, 35ea82d611da
diff --git a/src/apps/sctp_darn.c b/src/apps/sctp_darn.c
index bcfb822..133c1c6 100644
--- a/src/apps/sctp_darn.c
+++ b/src/apps/sctp_darn.c
@@ -126,7 +126,6 @@ int if_index = 0;
 sockaddr_storage_t remote_addr;
 sa_family_t ra_family;	/* What family is remote_addr? */
 int ra_len = 0;		/* How long is remote_addr? */
-void *ra_raw;		/* This is the addr part of remote_addr. */
 int new_connection = 1;
 
 enum inter_cmd_num {
@@ -491,49 +490,29 @@ int
 build_endpoint(char *argv0, int portnum)
 {
 	int retval;
-	struct hostent *hst;
+	struct addrinfo hints, *rp;
 	sockaddr_storage_t local_addr;
-	sa_family_t la_family;	/* What family is local_addr? */
-	int la_len;		/* How long is local_addr? */
-	void *la_raw;		/* This is the addr part of local_addr. */
 	int error;
 	struct sctp_event_subscribe subscribe;
 
 	/* Get the transport address for the local host name.  */
-	hst = gethostbyname(local_host);
-	if (hst == NULL) {
-		hst = gethostbyname2(local_host, AF_INET6);
-	}
-
-	if (hst == NULL || hst->h_length < 1) {
-		fprintf(stderr, "%s: bad hostname: %s\n", argv0, local_host);
-		exit(1);
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_family = AF_INET;
+	hints.ai_protocol = IPPROTO_SCTP;
+	if (getaddrinfo(local_host, NULL, &hints, &rp) != 0) {
+		hints.ai_family = AF_INET6;
+		if (getaddrinfo(local_host, NULL, &hints, &rp) != 0) {
+			fprintf(stderr, "%s: bad hostname: %s\n", argv0, local_host);
+			exit(1);
+		}
 	}
-
-	la_family = hst->h_addrtype;
-	switch (la_family) {
-	case AF_INET:
-		la_len = sizeof(local_addr.v4);
-		la_raw = &local_addr.v4.sin_addr;
-		local_addr.v4.sin_port = htons(portnum);
-		local_addr.v4.sin_family = AF_INET;
-		break;
-	case AF_INET6:
-		la_len = sizeof(local_addr.v6);
-		la_raw = &local_addr.v6.sin6_addr;
-		local_addr.v6.sin6_port = htons(portnum);
-		local_addr.v6.sin6_family = AF_INET6;
+	memcpy(&local_addr, rp->ai_addr, rp->ai_addrlen);
+	local_addr.v4.sin_port = htons(portnum); /* equal to v6.sin6_port */
+	if (rp->ai_family == AF_INET6)
 		local_addr.v6.sin6_scope_id = if_index;
-		break;
-	default:
-		fprintf(stderr, "Invalid address type.\n");
-		exit(1);
-		break;
-	}
-	memcpy(la_raw, hst->h_addr_list[0], hst->h_length);
 
 	/* Create the local endpoint.  */
-	retval = socket(la_family, socket_type, IPPROTO_SCTP);
+	retval = socket(rp->ai_family, socket_type, IPPROTO_SCTP);
 	if (retval < 0) {
 		fprintf(stderr, "%s: failed to create socket:  %s.\n",
 			argv0, strerror(errno));
@@ -553,7 +532,7 @@ build_endpoint(char *argv0, int portnum)
 	}
 
 	/* Bind this socket to the test port.  */
-	error = bind(retval, &local_addr.sa, la_len);
+	error = bind(retval, &local_addr.sa, rp->ai_addrlen);
 	if (error != 0) {
 		fprintf(stderr, "%s: can not bind to %s:%d: %s.\n",
 			argv0, local_host, portnum,
@@ -778,7 +757,7 @@ command_send(char *argv0, int *skp)
 	struct iovec iov;
 	int done = 0;
 	char message[REALLY_BIG];
-	struct hostent *hst;
+	struct addrinfo hints, *rp;
 	int c;
 	struct sockaddr *addrs;
 	int msglen;
@@ -787,38 +766,21 @@ command_send(char *argv0, int *skp)
 
 	/* Set up the destination.  */
 	if (remote_host != NULL) {
-		hst = gethostbyname(remote_host);
-		if (hst == NULL) {
-			hst = gethostbyname2(remote_host, AF_INET6);
-		}
-
-		if (hst == NULL || hst->h_length < 1) {
-			fprintf(stderr, "%s: bad hostname: %s\n",
-				argv0, remote_host);
-			exit(1);
+		memset(&hints, 0, sizeof(struct addrinfo));
+		hints.ai_family = AF_INET;
+		hints.ai_protocol = IPPROTO_SCTP;
+		if (getaddrinfo(remote_host, NULL, &hints, &rp) != 0) {
+			hints.ai_family = AF_INET6;
+			if (getaddrinfo(remote_host, NULL, &hints, &rp) != 0) {
+				fprintf(stderr, "%s: bad hostname: %s\n", argv0, remote_host);
+				exit(1);
+			}
 		}
-
-		ra_family = hst->h_addrtype;
-		switch (ra_family) {
-		case AF_INET:
-			ra_len = sizeof(remote_addr.v4);
-			ra_raw = &remote_addr.v4.sin_addr;
-			remote_addr.v4.sin_port = htons(remote_port);
-			remote_addr.v4.sin_family = AF_INET;
-			break;
-		case AF_INET6:
-			ra_len = sizeof(remote_addr.v6);
-			ra_raw = &remote_addr.v6.sin6_addr;
-			remote_addr.v6.sin6_port = htons(remote_port);
-			remote_addr.v6.sin6_family = AF_INET6;
+		memcpy(&remote_addr, rp->ai_addr, rp->ai_addrlen);
+		remote_addr.v4.sin_port = htons(remote_port); /* equal to v6.sin6_port */
+		if (rp->ai_family == AF_INET6)
 			remote_addr.v6.sin6_scope_id = if_index;
-			break;
-		default:
-			fprintf(stderr, "Invalid address type.\n");
-			exit(1);
-			break;
-		}
-		memcpy(ra_raw, hst->h_addr_list[0], hst->h_length);
+		ra_len = rp->ai_addrlen;
 	}
 
 	/* Initialize the global value for interactive mode functions.  */
@@ -1041,7 +1003,7 @@ command_poll(char *argv0)
 	fd_set *xbitsp = NULL;
 
 	struct msghdr outmsg;
-	struct hostent *hst;
+	struct addrinfo hints, *rp;
 	int msglen;
 	int temp_fd, temp_set;
 
@@ -1050,38 +1012,20 @@ command_poll(char *argv0)
 	/* If a remote host is specified, initialize the destination. */
 	if (remote_host) {
 		/* Set up the destination.  */
-		hst = gethostbyname(remote_host);
-		if (hst == NULL) {
-			hst = gethostbyname2(remote_host, AF_INET6);
-		}
-
-		if (hst == NULL || hst->h_length < 1) {
-			fprintf(stderr, "%s: bad hostname: %s\n",
-				argv0, remote_host);
-			exit(1);
+		memset(&hints, 0, sizeof(struct addrinfo));
+		hints.ai_family = AF_INET;
+		hints.ai_protocol = IPPROTO_SCTP;
+		if (getaddrinfo(remote_host, NULL, &hints, &rp) != 0) {
+			hints.ai_family = AF_INET6;
+			if (getaddrinfo(remote_host, NULL, &hints, &rp) != 0) {
+				fprintf(stderr, "%s: bad hostname: %s\n", argv0, remote_host);
+				exit(1);
+			}
 		}
-
-		ra_family = hst->h_addrtype;
-		switch (ra_family) {
-		case AF_INET:
-			ra_len = sizeof(remote_addr.v4);
-			ra_raw = &remote_addr.v4.sin_addr;
-			remote_addr.v4.sin_port = htons(remote_port);
-			remote_addr.v4.sin_family = AF_INET;
-			break;
-		case AF_INET6:
-			ra_len = sizeof(remote_addr.v6);
-			ra_raw = &remote_addr.v6.sin6_addr;
-			remote_addr.v6.sin6_port = htons(remote_port);
-			remote_addr.v6.sin6_family = AF_INET6;
+		memcpy(&remote_addr, rp->ai_addr, rp->ai_addrlen);
+		remote_addr.v4.sin_port = htons(remote_port); /* equal to v6.sin6_port */
+		if (rp->ai_family == AF_INET6)
 			remote_addr.v6.sin6_scope_id = if_index;
-			break;
-		default:
-			fprintf(stderr, "Invalid address type.\n");
-			exit(1);
-			break;
-		}
-		memcpy(ra_raw, hst->h_addr_list[0], hst->h_length);
 
 		/* Initialize the message struct we use to pass messages to
 	 	 * the remote socket.
@@ -1091,7 +1035,7 @@ command_poll(char *argv0)
 		outmsg.msg_control = NULL;
 		outmsg.msg_controllen = 0;
 		outmsg.msg_name = &remote_addr;
-		outmsg.msg_namelen = ra_len;
+		outmsg.msg_namelen = rp->ai_addrlen;
 		outmsg.msg_flags = 0;
 	}
 
@@ -1406,14 +1350,11 @@ struct sockaddr *
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
@@ -1421,28 +1362,17 @@ append_addr(const char *parm, struct sockaddr *addrs, int *ret_count)
 
 	if (!parm)
 		return NULL;
-	/* Get the entries for this host.  */
-	hst4 = gethostbyname(parm);
-	hst6 = gethostbyname2(parm, AF_INET6);
 
-	if ((NULL == hst4 || hst4->h_length < 1)
-	    && (NULL == hst6 || hst6->h_length < 1)) {
+	memset(&hints, 0, sizeof(struct addrinfo));
+	hints.ai_family = AF_UNSPEC;
+	hints.ai_protocol = IPPROTO_SCTP;
+	if (getaddrinfo(parm, NULL, &hints, &res) != 0) {
 		fprintf(stderr, "bad hostname: %s\n", parm);
 		goto finally;
 	}
 
-
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
@@ -1473,31 +1403,14 @@ append_addr(const char *parm, struct sockaddr *addrs, int *ret_count)
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
+		if (rp->ai_family == AF_INET6)
 			b6ap->sin6_scope_id = if_index;
-			bcopy(hst6->h_addr_list[j], &b6ap->sin6_addr,
-			      hst6->h_length);
-
-			aptr += sizeof(struct sockaddr_in6);
-		} /* for (loop through the new v6 addresses) */
+		aptr += rp->ai_addrlen;
 	}
 
  finally:
@@ -2123,7 +2036,7 @@ shutdown_func(char *argv0, int *skp, int shutdown_type)
 	struct cmsghdr *cmsg;
         int error=0, bytes_sent;
 	struct sctp_sndrcvinfo *sinfo;
-	struct hostent *hst;
+	struct addrinfo hints, *rp;
 	char *sd_type;
 	int sk = *skp;
 
@@ -2142,37 +2055,20 @@ shutdown_func(char *argv0, int *skp, int shutdown_type)
 	if (socket_type == SOCK_SEQPACKET) {
 		/* Set up the destination.  */
 		if (remote_host) {
-			hst = gethostbyname(remote_host);
-			if (hst == NULL) {
-				hst = gethostbyname2(remote_host, AF_INET6);
-			}
-
-			if (hst == NULL || hst->h_length < 1) {
-				fprintf(stderr, "%s: bad hostname: %s\n",
-					argv0, remote_host);
-				exit(1);
-			}
-
-			ra_family = hst->h_addrtype;
-			switch (ra_family) {
-			case AF_INET:
-				ra_len = sizeof(remote_addr.v4);
-				ra_raw = &remote_addr.v4.sin_addr;
-				remote_addr.v4.sin_port = htons(remote_port);
-				remote_addr.v4.sin_family = AF_INET;
-				break;
-			case AF_INET6:
-				ra_len = sizeof(remote_addr.v6);
-				ra_raw = &remote_addr.v6.sin6_addr;
-				remote_addr.v6.sin6_port = htons(remote_port);
-				remote_addr.v6.sin6_family = AF_INET6;
-				break;
-			default:
-				fprintf(stderr, "Invalid address type.\n");
-				exit(1);
-				break;
+			memset(&hints, 0, sizeof(struct addrinfo));
+			hints.ai_family = AF_INET;
+			hints.ai_protocol = IPPROTO_SCTP;
+			if (getaddrinfo(remote_host, NULL, &hints, &rp) != 0) {
+				hints.ai_family = AF_INET6;
+				if (getaddrinfo(remote_host, NULL, &hints, &rp) != 0) {
+					fprintf(stderr, "%s: bad hostname: %s\n",
+						argv0, remote_host);
+					exit(1);
+				}
 			}
-			memcpy(ra_raw, hst->h_addr_list[0], hst->h_length);
+			memcpy(&remote_addr, rp->ai_addr, rp->ai_addrlen);
+			remote_addr.v4.sin_port = htons(remote_port); /* equal to v6.sin6_port */
+			ra_len = rp->ai_addrlen;
 		}
 
 		/* Initialize the message struct we use to pass messages to
-- 
2.27.0

