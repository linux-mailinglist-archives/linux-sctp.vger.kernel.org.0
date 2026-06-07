Return-Path: <linux-sctp+bounces-1242-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tflqNtz4JWoXQAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1242-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 08 Jun 2026 01:03:56 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD4651DDC
	for <lists+linux-sctp@lfdr.de>; Mon, 08 Jun 2026 01:03:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c9Gx+XcF;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1242-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1242-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF50E300795D
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2026 23:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11232B137;
	Sun,  7 Jun 2026 23:03:53 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2AF2BE02A
	for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2026 23:03:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780873433; cv=none; b=MFWcn65kwzcF69Nczr4cxWofzx4JJCKgIzicl0BKsUFgxgpa584ebQXdsa1OFGjgKlJP3lyNxx7CWoMGepQgPYpXZlDnm4+90ynDimZFkbSoF4S+O4iGpT2vLEpXDUsYhh/K32gCerhDlmZhzlWEs9rpLt0MZMj3hQpmMSb+THs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780873433; c=relaxed/simple;
	bh=m0wEFQkMtZz5SQCdbiHDqtirXnWw0Igz/FyAP/Tc19g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYIqgop8M/bmZ+MUdvxUrHZ9wuUX6BS0DYoXW8EpoqTUCEcBQtvir2nU7eOa7N5yyc2KSJxvfDVuK6UQInZeRgALcBgmk6jrTcRN93Neh1RqT+mMmDoaW+eMWKQVySKFjI1Us6BnRNsdeF/0nKMdcrCQvCv2IJml+FlIYNsBqZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9Gx+XcF; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccf0fa0aacso53779236d6.2
        for <linux-sctp@vger.kernel.org>; Sun, 07 Jun 2026 16:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780873430; x=1781478230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pbu6f2Dp8cbPNFNRei+jWtIPkS20L3y3tFhoh3dhkkw=;
        b=c9Gx+XcFuLCjEDc9ibdVPA3d587iNLPlt1OeuQmxZttxpUaST/2vDnk0Liowdj4tv/
         BsWtQJguOCcdTF22QymcmaBe2wRXr3jTAvdzt7veufQGn4HiAhdNvczmj/2waZRv7vhN
         XXtgTZr3VeADtNSh7Y3D9iRtljd4MU8ArYcKJRkLCD55bzNagxBQnQDtbEe/tXtSNd/z
         YwtdI05W7j/MY5goIjq7Ul/Or6HAxtlcje9dOVciP3WC9eF3fpGf12n6rj8Vj2hHy0id
         4XxYwmXJ2hBmaifKrC2+Cp8TB8iuDbe+uFL38adeByqy9aLB4SH3HvAenMCGx93V4YAl
         F5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780873430; x=1781478230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbu6f2Dp8cbPNFNRei+jWtIPkS20L3y3tFhoh3dhkkw=;
        b=tHJwd1e4E89ZgHhL5jrmq7FdZUpO8Vl6A0Phy0fpBVlKS6qEAU3siUDnQY0bea+4D9
         r2ZS8jVEca5tKIuJ+zDm76PRFC5LgJZFB4EgqBrsSXarjwt3KQtn+2ccha8Oi69bfwwq
         CL2KjZAsALmO4vGfd4E8/NDwDrSt1pFtD5WwkCvfk2+Uhd4xCzMrkHaNI6u1bzZ6knPt
         hn406ljXAuj/dnvFc0btVU03h4ChEHXZr4OoFFKN9atd1XYU1QtvqGEcjx5iUyQdykg3
         tGpaN1Bk4mdBCp8yd+SC3g5xSH5jRui2R/Wso1CiMK0/mXzkHVSfGWZJ+G3q7dQMsGeJ
         7HFg==
X-Forwarded-Encrypted: i=1; AFNElJ9USbyjGWJEbEv75B+gwcJ+75QIaAnO/p712lVV1pb8E+HS6tYLtuV6DJD0Zva9hI00EdJkrRAeqJEP@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6aawxceD271lgU+/8sjiobUZJM9zZ5t3gW2cvj+HdIwrqnG5h
	q16c2sH5jyqikkf5YZL6enumIeddn40is52iGq3mwiruvvYUX/Adaxmr
X-Gm-Gg: Acq92OHSaDIor2PH5i6LjBXCjtCB43AV5RrDiZbKKB3cK3R3eqMz+spdzBID7ae2sgA
	HzwCU/rdIv4aPCzqnzDQJ1CXOLVWszOU80qw5fA/6oAh+c90ZYNqwCr0g1RERcTtZeYwBfIfFZB
	kkl+foEsNLLd8OS8DKLVPZji92Ox4RIMwuGYPecN3iJVqTJU7cEaR8mCXzOiz1w5gZCyCJ+y6s3
	3bnkCv8GBKRWXVFO/w4F+egHgpE5L0h8r8aDZzeQEromw7v8nhKMkXH4GH7caMeYlfdXc2nAsXr
	6XZIlBIaxa3smg2hDKFu7PYQE0ZL4U+iev4ic6rXl8Cnh4M0oJHLkgeVrZHvjnnWWdsXXQzHe+p
	rqwF1Lv+rXZRe6ksvl6mqumQQbcg/nBqrsTv5ROW8gi9oel68xHcyTL0vMMaY8MvuIM0ovqR24F
	lkuIZuSQQLJj+AO7l6TQ4Yjry6K0Ay+rz/CHTL+8iH9KdnKnwwA+aQzoHosqYKhAXQ9sSm4cdjz
	EsEMgCcD358dxktGEbzKzVFymZIlsafOxeGp2lWr83LYeIvtDJm/ulXLRokttFAJIlgXUkDPU7u
X-Received: by 2002:a05:6214:2349:b0:8ac:b258:71d1 with SMTP id 6a1803df08f44-8cee5f9f71amr206612146d6.3.1780873430098;
        Sun, 07 Jun 2026 16:03:50 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd2629cesm143921966d6.41.2026.06.07.16.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 16:03:49 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: validate embedded INIT chunk and address list lengths in cookie
Date: Sun,  7 Jun 2026 19:03:47 -0400
Message-ID: <75af23a89adf881a0895d511775e4770da367cbf.1780873427.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1242-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75CD4651DDC

sctp_unpack_cookie() only checked that the embedded INIT chunk length
did not exceed the remaining cookie payload, but did not ensure that the
INIT chunk is large enough to contain a complete INIT header.

A malformed COOKIE_ECHO can therefore carry a truncated INIT chunk whose
length field is smaller than sizeof(struct sctp_init_chunk).  Later,
sctp_process_init() accesses INIT parameters unconditionally, which may
lead to out-of-bounds reads.

In addition, raw_addr_list_len is not fully validated against the
remaining cookie payload. When cookie authentication is disabled, an
attacker can supply an oversized raw_addr_list_len and cause
sctp_raw_to_bind_addrs() to read beyond the end of the cookie. The
address parser also lacks sufficient bounds checks for parameter headers
and lengths, allowing malformed address parameters to trigger
out-of-bounds reads.

Fix this by:

- requiring the embedded INIT chunk length to be at least sizeof(struct
  sctp_init_chunk);
- validating that the INIT chunk and raw address list together fit
  within the cookie payload;
- verifying sufficient data exists for each address parameter header and
  payload before parsing it.

Note that sctp_verify_init() must be called after sctp_unpack_cookie()
and before sctp_process_init() when cookie authentication is disabled.
This will be addressed in a separate patch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/bind_addr.c     | 11 ++++++++++-
 net/sctp/sm_make_chunk.c |  9 +++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/sctp/bind_addr.c b/net/sctp/bind_addr.c
index 75e3e61d494e..31737f144c7f 100644
--- a/net/sctp/bind_addr.c
+++ b/net/sctp/bind_addr.c
@@ -275,6 +275,16 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp, __u8 *raw_addr_list,
 		param = (struct sctp_paramhdr *)raw_addr_list;
 		rawaddr = (union sctp_addr_param *)raw_addr_list;
 
+		if (addrs_len < sizeof(*param)) {
+			retval = -EINVAL;
+			goto out_err;
+		}
+		len = ntohs(param->length);
+		if (addrs_len < len) {
+			retval = -EINVAL;
+			goto out_err;
+		}
+
 		af = sctp_get_af_specific(param_type2af(param->type));
 		if (unlikely(!af) ||
 		    !af->from_addr_param(&addr, rawaddr, htons(port), 0)) {
@@ -291,7 +301,6 @@ int sctp_raw_to_bind_addrs(struct sctp_bind_addr *bp, __u8 *raw_addr_list,
 			goto out_err;
 
 next:
-		len = ntohs(param->length);
 		addrs_len -= len;
 		raw_addr_list += len;
 	}
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 85264862fb6b..1741a9f33d8c 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1731,8 +1731,8 @@ struct sctp_association *sctp_unpack_cookie(
 	struct sk_buff *skb = chunk->skb;
 	struct sctp_cookie *bear_cookie;
 	struct sctp_chunkhdr *ch;
+	unsigned int len, chlen;
 	enum sctp_scope scope;
-	unsigned int len;
 	ktime_t kt;
 
 	/* Header size is static data prior to the actual cookie, including
@@ -1761,7 +1761,12 @@ struct sctp_association *sctp_unpack_cookie(
 	bear_cookie = &cookie->c;
 
 	ch = (struct sctp_chunkhdr *)(bear_cookie + 1);
-	if (ntohs(ch->length) > len - fixed_size)
+	chlen = ntohs(ch->length);
+	if (chlen < sizeof(struct sctp_init_chunk))
+		goto malformed;
+	if (chlen > len - fixed_size)
+		goto malformed;
+	if (bear_cookie->raw_addr_list_len > len - fixed_size - chlen)
 		goto malformed;
 
 	/* Verify the cookie's MAC, if cookie authentication is enabled. */
-- 
2.47.1


