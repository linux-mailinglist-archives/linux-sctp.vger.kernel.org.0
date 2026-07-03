Return-Path: <linux-sctp+bounces-1304-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ySFBCH1jR2pIXgAAu9opvQ
	(envelope-from <linux-sctp+bounces-1304-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 03 Jul 2026 09:23:41 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB276FF81B
	for <lists+linux-sctp@lfdr.de>; Fri, 03 Jul 2026 09:23:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SqIdH38Q;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1304-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1304-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44BDA300CE64
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Jul 2026 07:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA68433E7D;
	Fri,  3 Jul 2026 07:19:59 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383AF33C192
	for <linux-sctp@vger.kernel.org>; Fri,  3 Jul 2026 07:19:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783063199; cv=none; b=aS2xAY1hj0PAiwTiWcPxSXNl8yazcUxUBHl+mXA5izxstcLilkR5U/d2QE0vh+pmYI77NYjDvA1K48VK4uBJe5lA/9DDYYveUtsRSSpLr4n3yzlnZnunCedFfascg2eFhupDFQA0cX/liT41ASnPAf6t5QYlXCr+P4iyONRJ7g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783063199; c=relaxed/simple;
	bh=zdQqo99vOdz/armowaz1cHmxzP3P70zODcOuuWtDsWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XcRzKeq8cnXlyBaCL5cGg5Pf9GJxXko89yZZmF+sKw+WXuVH0XMG1HJFENQMZsX1ZqcMsz+md2qXdxECfJShelY1KgraFVoPlK7YWJuPukzn0RiKOuAG3nvrBs0PJ3gPowuFiBZpquh67eU8hO7O84sp4hi6K7CoAh+FO4faxf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqIdH38Q; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso282034b3a.0
        for <linux-sctp@vger.kernel.org>; Fri, 03 Jul 2026 00:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783063197; x=1783667997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsDx3A88fXjWKNp+0/HLxbT8UZooEMPn92oG4tbcDQM=;
        b=SqIdH38QdHQt62NpT5qIbhJtm4qENTZ31zTcySfEZePRINTzw8RUeMpHNdHaAMWsoG
         WXqq++ixpX/89M0Zjq5MFpvt39cWMFx7/3QY2GqpCFnjVF4zvLQpNifbwCFEHamUmJul
         A5l7j0i4Z6tDwt4NyKzFA3ASetmC6bZCg6wa86xE1KrA488wdEOZCTHTj+91G+xUARtW
         L2vpsf7tF320iwJEm/rM/D4pSavACi7OszCE/q1mym0UJJOjEWWky3bR+bVgVAWOxhZd
         N6hXd+PYBZ60Wk5sOWfpCo7QPwsPXvDUYNk3BfmLyONRSf3YcWd0gWxJP2kzrrEVQOzq
         pM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783063197; x=1783667997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RsDx3A88fXjWKNp+0/HLxbT8UZooEMPn92oG4tbcDQM=;
        b=YTOMWzTxjStK+LJEflfOG/3WCsJ/SKBFmwL2wXCX3+qkTGH6oB+/Q+YUMR0pJFGiJI
         XiNIxW1a9OsjDiVvFolkZ7v8HoHz7YSEpT+45ULNfiVeakIpaKx2UJoY1xBOZChAixqK
         beSVSHKvmGPp4zsjj77NrxqBsu5tUExgKe4hubRrIAEKF3CuttI0e6gI3z3/R5FJvw2Z
         HxIcTpNHIQNAKffIJ5cJxcXA9ApqkkMBZ6tMLYt4iPUm29ouTchEAdja1jSVbTimww/u
         HLIgh2gqtvtGqPMOTMgwPO4YwMQuVIFkQHDslsLalpP2bJN8k8xKBV0W8ld7nPeZUhef
         9TbQ==
X-Gm-Message-State: AOJu0Yyutq3H2h7dkQHi5wfQJXX/Wfwa5xcWXktTKv+yUUNxutZQQgni
	Z63ms8C9kk3rRWm9Debleaau5kFIoQOquRLdp7KNC1sUS1fi5zVts5aBkJGXY9od
X-Gm-Gg: AfdE7cklJdQUIcnVwdcW9Q03xTFkdkEPcvgGbGM8InhTrV8OsqaZ4fqcGR5R/2Pv99x
	goyayka3pChdCEIrsXTQMsR8Kh5cO1M65Li/6MfefQ37OXo7SMq1r/gVI+kQm2dlQGfy7AckzN/
	VQoaTdiR+9dIJ3rz4xVo4xC7mhsEkBKPnO5nzsCYpq01a5v12x8yW21vw2Lfc6PXKgVDmFawhwM
	la90QXvwrw6k6u89AEldZuwFCGFRlwf/CSs6StdGd/rz37Tls2cztIomPP7zDZ508kvn2M7Amah
	YPeQl2l090iv1y9uhicjc933cnt+dh4KXAPomYkpQPAIoW/XEvkr8jzVFbs3shLUACFs1LxFk/v
	8sNh4aJLgEDtDPW0mgTqFNTHUrvfGqqU5PBUqjwyKPe0HcR9qZJv3qAu7Bg2lE+UclYumO6oBon
	MZ5fcq+3uWY63G4zAUH3UNiD4fq1oC
X-Received: by 2002:a05:6a00:1bc4:b0:82c:6aee:b21a with SMTP id d2e1a72fcca58-847c0888530mr9082293b3a.45.1783063197209;
        Fri, 03 Jul 2026 00:19:57 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9b409fsm2455742b3a.52.2026.07.03.00.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 00:19:56 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vladislav.yasevich@hp.com,
	yuantan098@gmail.com,
	dstsmallbird@foxmail.com,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH net 1/1] net: sctp: fix AUTH HMAC list overflow into auth_chunks
Date: Fri,  3 Jul 2026 15:19:32 +0800
Message-ID: <e62943a59f5e1c7a68beddc1dbebe50a9a036c16.1782798905.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782798905.git.xizh2024@lzu.edu.cn>
References: <cover.1782798905.git.xizh2024@lzu.edu.cn>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:vladislav.yasevich@hp.com,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:xizh2024@lzu.edu.cn,m:enjou1224z@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,hp.com,foxmail.com,lzu.edu.cn];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1304-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[enjou1224z@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enjou1224z@gmail.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,foxmail.com:email,lzu.edu.cn:mid,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5EB276FF81B

From: Zihan Xi <xizh2024@lzu.edu.cn>

sctp_auth_ep_set_hmacs() may advertise a 12-byte HMAC-ALGO parameter when
four identifiers are configured, but the association only stores ten bytes
in c.auth_hmacs. sctp_association_init() copies the advertised length and
overwrites the adjacent auth_chunks field, so sctp_auth_asoc_verify_hmac_id()
accepts forged HMAC identifiers and sctp_auth_get_hmac() indexes past
sctp_hmac_list.

Clamp the stored parameter length to the association buffer, copy only that
many bytes when initializing an association, and reject out-of-range HMAC
identifiers in sctp_auth_get_hmac().

Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reviewed-by: Ren Wei <enjou1224z@gmail.com>
---
 net/sctp/associola.c    | 10 +++++++---
 net/sctp/auth.c         | 10 ++++++++--
 net/sctp/sm_statefuns.c |  2 ++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 62d3cc1558..760457def6 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -260,9 +260,13 @@ static struct sctp_association *sctp_association_init(
 	asoc->strreset_enable = ep->strreset_enable;
 
 	/* Save the hmacs and chunks list into this association */
-	if (ep->auth_hmacs_list)
-		memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list,
-			ntohs(ep->auth_hmacs_list->param_hdr.length));
+	if (ep->auth_hmacs_list) {
+		size_t hmac_len = min_t(size_t,
+				ntohs(ep->auth_hmacs_list->param_hdr.length),
+				sizeof(asoc->c.auth_hmacs));
+
+		memcpy(asoc->c.auth_hmacs, ep->auth_hmacs_list, hmac_len);
+	}
 	if (ep->auth_chunk_list)
 		memcpy(asoc->c.auth_chunks, ep->auth_chunk_list,
 			ntohs(ep->auth_chunk_list->param_hdr.length));
diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index be9782760f..4d14bd6185 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -447,6 +447,8 @@ struct sctp_shared_key *sctp_auth_get_shkey(
 
 const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id)
 {
+	if (hmac_id >= SCTP_AUTH_NUM_HMACS)
+		return NULL;
 	return &sctp_hmac_list[hmac_id];
 }
 
@@ -510,6 +512,9 @@ int sctp_auth_asoc_verify_hmac_id(const struct sctp_association *asoc,
 	hmacs = (struct sctp_hmac_algo_param *)asoc->c.auth_hmacs;
 	n_elt = (ntohs(hmacs->param_hdr.length) -
 		 sizeof(struct sctp_paramhdr)) >> 1;
+	n_elt = min_t(__u16, n_elt,
+		      (sizeof(asoc->c.auth_hmacs) -
+		       sizeof(struct sctp_paramhdr)) / sizeof(__u16));
 
 	return __sctp_auth_find_hmacid(hmacs->hmac_ids, n_elt, hmac_id);
 }
@@ -708,8 +713,9 @@ int sctp_auth_ep_set_hmacs(struct sctp_endpoint *ep,
 		ep->auth_hmacs_list->hmac_ids[i] =
 				htons(hmacs->shmac_idents[i]);
 	ep->auth_hmacs_list->param_hdr.length =
-			htons(sizeof(struct sctp_paramhdr) +
-			hmacs->shmac_num_idents * sizeof(__u16));
+			htons(min_t(__u16, sizeof(struct sctp_paramhdr) +
+				      hmacs->shmac_num_idents * sizeof(__u16),
+			      SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2));
 	return 0;
 }
 
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index d23d935e12..21cda509a0 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -4431,6 +4431,8 @@ static enum sctp_ierror sctp_sf_authenticate(
 	sig_len = ntohs(chunk->chunk_hdr->length) -
 		  sizeof(struct sctp_auth_chunk);
 	hmac = sctp_auth_get_hmac(ntohs(auth_hdr->hmac_id));
+	if (!hmac)
+		return SCTP_IERROR_AUTH_BAD_HMAC;
 	if (sig_len != hmac->hmac_len)
 		return SCTP_IERROR_PROTO_VIOLATION;
 
-- 
2.43.0

