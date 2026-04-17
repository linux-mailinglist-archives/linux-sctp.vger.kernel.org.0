Return-Path: <linux-sctp+bounces-1188-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHdLL9+h4mmv8QAAu9opvQ
	(envelope-from <linux-sctp+bounces-1188-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 17 Apr 2026 23:10:55 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D441E9D4
	for <lists+linux-sctp@lfdr.de>; Fri, 17 Apr 2026 23:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E163038A4A
	for <lists+linux-sctp@lfdr.de>; Fri, 17 Apr 2026 21:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903D53290D2;
	Fri, 17 Apr 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMyqQ1xy"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1712264C7
	for <linux-sctp@vger.kernel.org>; Fri, 17 Apr 2026 21:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460184; cv=none; b=HWGk7Vsr2ihxzpFc+0HbesSoedeKo++ROuo10fBMXtCNeOXObbBbFb81GPrqhVhm99Il6CFtjlpBL5+l41ayRvRHhV4403h8JcDzEYnxpUPh6iSA6wijV74kvoxwy8sigkPkz1RSmzJoEuv3iL5DkwyqdKOdlEXi1nwxcQBCG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460184; c=relaxed/simple;
	bh=Ojb9tsYidH7+XlNxOvXN5yHkq9jgOnNphzNBOPjr5SI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkuwl0Bly7lT8VrP//lrAStR6A9fFRJ9jc21TkmkYhwHzgQSKrMwd6UJ6+zZGbEBA24UL3seZxg/+afmlTFhEMDEyPlxauudhPJZWmghWRhap19ntIK0l7INu85G/iPgICAvaYUaKOS9EUKqlNSdGVBfiAFBWjFOWOHtWdRxqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMyqQ1xy; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so9405566d6.1
        for <linux-sctp@vger.kernel.org>; Fri, 17 Apr 2026 14:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776460182; x=1777064982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G/ceKS4zZANLPnvM8/t1TovHGT4+al4Wc8t9XoY5Y70=;
        b=lMyqQ1xyBiiBwVz/jLChmAAAu746gjNC7YXUltblMKgdUMfNedQz0PMc3am6cmykLH
         xFeHmQR8ZUTn8jyiM3GxnHe80mVgVRx9fasP9GQBgZPhINmWv+Jh13MRxS1Nah3+/fpi
         XSysG5/vs7VOqLg/zWfGUsrWnu5X3YZlJHzzr3CyumkRP2oBh7EwDFPqmchasOBMNbrE
         7p1ULqgdKSsePj8Ts+EbEi2emC3a9Puqvr2tjp2qOU62h84qpyeTb/XB8sjpk/Xqkm9q
         11U9sSN1SXPO/uby8vOKYEeFqjpAWhdfNcV5otzP2oh16hCbK8elLCS4f/prHz8LILrR
         jXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776460182; x=1777064982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/ceKS4zZANLPnvM8/t1TovHGT4+al4Wc8t9XoY5Y70=;
        b=fp9BSP6/EDEq+uGQlI3un9diFYZAUR+7muIjuPPtANseY4sXaqmP5y+9DjKn5y2NOA
         rHuQKiN8GAsfeLrQ5dC92lzZa6LPNZ9yKMkyiO31r4TWfimBy2cwfPklQ10Evdtp6ud/
         YyD2+GgacGpC+miGn68yZ+7VmeE1L6554O6Wwx3gmipDL2DLzk2txMcdqRFv44ERszx4
         jJ5Z8KgXWu+hJsO0AkT21v/mLQgeAnREdSoNzx6vubCioZ4Xt4qfwi0tUTjSsos7rapG
         f0xhmEQkj6vnNCFsqqaz7Sl9r0K/NC2KIHOe6x9rZi+WuUtLkorjzd4bNVdtRdCKjxsT
         pAeg==
X-Forwarded-Encrypted: i=1; AFNElJ93oa8zr0fWgEDNmF/er0umBbx0TJvOQGN8Dmq1euP3aMC3/CEYRR8DdTwliR0TuDRUoBjCSlQEV/TY@vger.kernel.org
X-Gm-Message-State: AOJu0YwnGyi6zOY7pL69/Iu2/f1fJugUZVhHIK748rBkuqw+VBWOIojL
	NH/tbUEzIwuInKU2BBi+UDY1u2mZhbbSzWBWyhp2Z0619AQwMioWWx/4
X-Gm-Gg: AeBDieu54VAAg20ljcDyORAuw+Xgb7w9dIxlZbjzWj3nEqLXG/OFxuwRWXWHsR/t+K/
	WPArMFi+isc3Lfv7n/Op1VRr9LL5s3/yYbg6LVhrHEztnznk03WNk0LF8h5zqf7stlU95Tevm+j
	oT9c/ODlxVNBCCq5Tu6EcNAOmO99oSruKt2AcZFsXW3LDd1F/6ijOxwPHwij4foMJLon20B8s7k
	0fOn6lb3rZUeTA3qZzMhHeWIPFLcx/I8npegpp8DNPjl/JFZDt10rcRZ7LFUs6cQh/j9E1VID1y
	a/q6L+NaGVB+UKL1LiV5EJVdb/ymNb0Q1MQonTs7bpdSV6ZsG1T2tcv659C9xXKYBLx+8bHFmIS
	e5RZu5U9zCEYaaabbiDX0rCBdKN+8aRyGkKMVlLBYYgAcsNaFJPNKSdvcSY+lY6FW45qU1KNONZ
	mn2tlC1eKhe2GpIp8SWi8jKP+HJVua8oriwNGtqeeTuxMdNlMHcX31zoY23xJ4hxOhyuFWAV/RS
	4N+Tgm4ToNfhajXGW0ZgEF0Rm1OhRd1mGlIm2mv76W/PMK9jmMItrKYOsqfO9GUWyZV7Rf/zvVd
	P22y/gS8vm4=
X-Received: by 2002:ad4:576b:0:b0:8ac:b0d8:65f3 with SMTP id 6a1803df08f44-8b0287779f3mr62616686d6.21.1776460182211;
        Fri, 17 Apr 2026 14:09:42 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac4260bsm19087246d6.4.2026.04.17.14.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:09:41 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net] sctp: fix sockets_allocated imbalance after sk_clone()
Date: Fri, 17 Apr 2026 17:09:40 -0400
Message-ID: <af8d66f928dec3e9fcbee8d4a85b7d5a6b86f515.1776460180.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-1188-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-sctp];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 266D441E9D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sk_clone() increments sockets_allocated and sets the socket refcount to 2.
SCTP performs additional accounting in sctp_clone_sock(), so the clone-time
increment must be undone to avoid double counting.

Note we cannot simply remove the SCTP-side increment, because the SCTP
destroy path in sctp_destroy_sock() only decrements sockets_allocated when
sp->ep is set, which may not be true for all failure paths in
sctp_clone_sock().

Fixes: 16942cf4d3e3 ("sctp: Use sk_clone() in sctp_accept().")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index d2665bbd41a2..d0e7048230c0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -4855,8 +4855,9 @@ static struct sock *sctp_clone_sock(struct sock *sk,
 	if (!newsk)
 		return ERR_PTR(err);
 
-	/* sk_clone() sets refcnt to 2 */
+	/* sk_clone() sets refcnt to 2 and increments sockets_allocated */
 	sock_put(newsk);
+	sk_sockets_allocated_dec(newsk);
 
 	newinet = inet_sk(newsk);
 	newsp = sctp_sk(newsk);
-- 
2.47.1


