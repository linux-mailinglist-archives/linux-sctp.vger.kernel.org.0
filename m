Return-Path: <linux-sctp+bounces-1277-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7etwJm22Nmq3DgcAu9opvQ
	(envelope-from <linux-sctp+bounces-1277-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 17:49:01 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0071D6A9257
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 17:49:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Hl7m9OKL;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1277-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1277-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDEBE300459A
	for <lists+linux-sctp@lfdr.de>; Sat, 20 Jun 2026 15:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0668F396587;
	Sat, 20 Jun 2026 15:48:59 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B23955E1
	for <linux-sctp@vger.kernel.org>; Sat, 20 Jun 2026 15:48:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970538; cv=none; b=fepolG6w0ygJqSrVfpH/PMRn7SlmXBEp47c50O8CM4u4FbTWbFBBhhHvvT2mZh+xK7OA3x0OTcM+Bogr2o36oeKlQiMIN0Qi1SSe0pnqeFNwykJsJL5rjY6Y439NRNLLU/kp8KShFYQGqouCt2mPwXrVZNKB8PLkWaC/EIdgPw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970538; c=relaxed/simple;
	bh=y8CKsC4AcCnLZxu7FvlCaKBGb1tsp3+nM9n2z0emRA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hd+mnWDB1CjcTT2PeGhukq+vhUMvvrcRIZDObiN/4cYb5yVjipn/AGdzR9EWaVOiuj9ti1SbVYhcQEAxCK5ZGN3MFs/JiNaaT4lgLINN4tUE82vR4WL/7R0DkuZNYk4x1MC6XJ8vKkkO/gNKj9yYN+UiaoYuVbHi+OH+UPEeRYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl7m9OKL; arc=none smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92213351918so89010085a.0
        for <linux-sctp@vger.kernel.org>; Sat, 20 Jun 2026 08:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781970537; x=1782575337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCqX9SS0fcvxQj6cNLY7hXcBkW2X7Mm+a+jE+6aVrFs=;
        b=Hl7m9OKLPWIaBfSmlKEhnW6rkDmiQAn3sZ2VI3sgY9g/aLVBvAjoat3VyidxSAg4ve
         9ML3Jk5uId6lP13RsYS4a7ZHqI1mWfM63vUjd77Qg94jkULuVBACFKyPziw3iwaToDPy
         PdSzGmFUE+RAZ+LuyCzXly0H+p3zirCRZrAnNY13U7hhuTooaaVcTALiprUynePCgsTb
         2I/ZZ0CfT5jpf7Mfti1qqx3qyGsSpxrW1RWcPvhw9NXReO6OKJ9XFeU4i/lB3Wa3PKVh
         FNGf9IpLzUKridb4fN0nCRPxNjwLpHpNcvkyZ4zaPD8/K50g5luA5YGxwyaNlgoNA9Zg
         06Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970537; x=1782575337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCqX9SS0fcvxQj6cNLY7hXcBkW2X7Mm+a+jE+6aVrFs=;
        b=Y9Z35JEgxMQvWITD4sKxORHgJyrb4kVNlnnOBTCz2UQxyFNj28UhHJD+Yv612NjfMl
         8yyYgXiTb0Ed21KVp9W3dkAeY9cmeXZrrkw0NUpd4gpZUYQAdJgw/fwADzkSObmFM2GI
         VIO+ipGd9CRPoyxE5XN5z7t2JdHlKExcVd8N71s/fYJF4K7SzrFTI3tJVWXzq2zYSdMA
         ltvRe9nWuUek5R59uRep80hLvJgee22uNI1k/RiSeiJtEE1dGBqvVebXJGxk9cZZNwi9
         8h0G+6yt2m/jtcEtEZgIz5Mo92BvYSehepoqtVKyz1HLWJTs/3Rw+2+putnWaUxw0wlU
         BLbQ==
X-Forwarded-Encrypted: i=1; AFNElJ99VI07Q+yyySKD+M8PdlPUgTfDHZkz+fsfkYzO+PYVFoOZtVWT3hgxZ7cR0k21k3Xi+f4SUhMYbwzb@vger.kernel.org
X-Gm-Message-State: AOJu0YxObJePxqIvkqD66lYn8B10FUILs2zyC02Eu+RyGhZXzoBq7sh5
	vFuYZ7d7oHXsL/oMD+PRDxDTD05sBp+WV/ZoYetYD22F4jMCprjZUex8
X-Gm-Gg: AfdE7cmOqyfQKO2vV6ILB6FD8n8/0DNx90/LISH5Z6nJoT2KFJ/JSmyhJouRCr70R2t
	7uncgmOd++P2fWhtKBUOja3S/J998S+D1DpW47nT2BQUxuqTZPUSkcGS3Ea3meoals9OmKchKyk
	1I5x+GVUuZ+j0I1b8ZdWvHR5LBtxbtG9odPZ2f4COKlebpPk7CoX0f4lA/hRmQ1n0gBpamTH3FX
	efO8ftxYyN50M45IjR5yerPcJOTXFgSW21HFdTkplpMrh/pdDMk/67RRCj4q8/PdBKBGdMJQUdH
	03ZseWsC4hJU00sVcqWAqbeRmQho+cc5+dw0EARG3yMycFPHh91BRyVeBzU5Qzh/ZurAoz8WKIS
	BzlOe3fkOPFxmwBS1YwJQ6K9lDIwSvB/3uLQzQP5zocK4Y3VtFaFWAywBdvx2OerXmtyh96y7Kz
	XNbHgqVYRY2K1fZRoPNgdGGVfwfCd6B0L3GIUiixcOo+KRtX6y4Cy/vziJJnuIBeix6k2vTTIC+
	Qz5E7nhuJ63PT61Oe9YHtxp0WYz0i0KX3kLlju6a8M49boYvAr83oI=
X-Received: by 2002:a05:620a:278b:b0:915:94c7:5840 with SMTP id af79cd13be357-9208f1610f8mr1141369085a.1.1781970536718;
        Sat, 20 Jun 2026 08:48:56 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f015e50sm34809506d6.6.2026.06.20.08.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:48:55 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net] sctp: fix err_chunk memory leaks in INIT handling
Date: Sat, 20 Jun 2026 11:48:54 -0400
Message-ID: <0656704f1b0158287c98aec09ba36c83e4a537ab.1781970534.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1277-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0071D6A9257

When sctp_verify_init() encounters unrecognized parameters, it allocates an
err_chunk to report them. However, this chunk is leaked in several code
paths:

1. In sctp_sf_do_5_1B_init(), if security_sctp_assoc_request() fails after
   sctp_verify_init() has populated err_chunk, the function returns
   immediately without freeing it.

2. In sctp_sf_do_unexpected_init(), the same leak occurs on the
   security_sctp_assoc_request() failure path.

3. In sctp_sf_do_unexpected_init(), on the success path after copying
   unrecognized parameters to the INIT-ACK, the function returns without
   freeing err_chunk, unlike sctp_sf_do_5_1B_init() which properly frees
   it.

Fix all three leaks by adding sctp_chunk_free(err_chunk) calls before
returning in the error paths and on the success path in
sctp_sf_do_unexpected_init().

Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_statefuns.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 6967e889d1bd..2f484c678093 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -400,6 +400,8 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 	/* Update socket peer label if first association. */
 	if (security_sctp_assoc_request(new_asoc, chunk->skb)) {
 		sctp_association_free(new_asoc);
+		if (err_chunk)
+			sctp_chunk_free(err_chunk);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 	}
 
@@ -1542,6 +1544,8 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	/* Update socket peer label if first association. */
 	if (security_sctp_assoc_request(new_asoc, chunk->skb)) {
 		sctp_association_free(new_asoc);
+		if (err_chunk)
+			sctp_chunk_free(err_chunk);
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
 	}
 
@@ -1607,6 +1611,7 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 		 * parameter type.
 		 */
 		sctp_addto_chunk(repl, len, unk_param);
+		sctp_chunk_free(err_chunk);
 	}
 
 	sctp_add_cmd_sf(commands, SCTP_CMD_NEW_ASOC, SCTP_ASOC(new_asoc));
-- 
2.47.1


