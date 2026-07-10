Return-Path: <linux-sctp+bounces-1321-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nZl1FO82UWqJAwMAu9opvQ
	(envelope-from <linux-sctp+bounces-1321-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 20:16:15 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A475073D489
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 20:16:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Dk8ZRoeW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1321-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1321-lists+linux-sctp=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ABD3303EF57
	for <lists+linux-sctp@lfdr.de>; Fri, 10 Jul 2026 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70817346798;
	Fri, 10 Jul 2026 18:12:41 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DA379EEA
	for <linux-sctp@vger.kernel.org>; Fri, 10 Jul 2026 18:12:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783707161; cv=none; b=sqxJUA1Rh8PomonZET5SEppg+jNS9lExF3R2iaYwCG66aI3/JoEPGdxpIp5ogSIausOZy3A2FsQrheFS1zLVZwoZ8Yklc9SmPtfNIVsVpr9T1+lip0AeQr4Vc7Io5savo/Zd1QMomgB9ZRymG3+nYSqj7Nx3ZFjv/3f8j311Luc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783707161; c=relaxed/simple;
	bh=HmVx9/LS+hVjcUQ6NyKEX8ixmWtWS09UvwEdDjuSIww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfYNYErQtrfOq4JLjufNRhklOOYqnn8q8ZZ6Ft4fgcY6si5WTtoUzDqPOCRYzMVK6rJMflgENAphR2RWWCHqPIWey7USfmESqTOwNtM5obB/AYipcO4vKaKW01V5YlhbEunP9Ran7RHFCdYbCYEFU38z+cdjJJn5Bk/mOdMaUMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk8ZRoeW; arc=none smtp.client-ip=209.85.222.175
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e85499ffbso94205785a.0
        for <linux-sctp@vger.kernel.org>; Fri, 10 Jul 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783707157; x=1784311957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/bI02IT26f9J98q2x/cBgGT2CgXZdiDxxE3v83TDsdk=;
        b=Dk8ZRoeW6v3ERM2XnGhror4RHK6ia1PAHcdhn2ROc47GsS7rbrh459PKnbvgqkEpBL
         S9xQOAdGpRs0LECNlAR5b6gOzg6vbrbIIY5wHTJ2qWZjsAAIS6CL8AN0T23dgidINV+8
         fS0rpGzJSsoV6jJAuGHNQpppBtzQ/tW0No9WQls9bHnWIzDZm7mHx1dB10eAJLYgtjXM
         TTo9bNK+tww7yWYQ4+JHi+ynWzlstT59MuWR5F1nUeAvJ/uxtDkcaU9lCrWShfCkdLn3
         Gd52xGlXjsHynpMpe3mx3bX0yPIaGx6+Wmh7jIH4vyWTEQkgnRopPSAPZDeA0qbWNqh/
         Y7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783707157; x=1784311957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bI02IT26f9J98q2x/cBgGT2CgXZdiDxxE3v83TDsdk=;
        b=iz+4pZVP8i3UGocxog1mxlLZwQBkYeWFFrSvnNYBWHviAYyb2jj2j9q0pLxajSOawq
         EE17rVvPSypW8Co7+GxtQCNskESrSwWIrlj/src/IvXx5DG7eGZU95epy/iJNXchhxx+
         xop41IkXG68SAO3yebhAFI035gd32uSFo8TtvsHFfsl7704hJG199Qf+GhkIWZbNIE9y
         +7fdVO3znvUxcOqURmkajq2C2rCUC8Vg5t+oUpOmRDRVHD+fVg9fMeQU8/YkWx7inJH/
         y+W3yJpOReBtn2Ry9g5x4uyi5sxqiMiJvwjeN6uKtnP6DkdmBeTSX2EJLHx0+V9FEZ5K
         d/FA==
X-Forwarded-Encrypted: i=1; AHgh+RrExjQoTJeYJ1lMVkjMfjZPKjcPwA7CytK6SeLWSLHSJh/I2P3TSbpLs+6C/rfFGQKQFxutSDCM8TqU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4jz4QJb6hCYX1OnMqKIqUhxZVu+G0c4XEUwEjjOXxmFrQJNW
	i73iwifPnIm43nvNGhhlcOjP8f9ARbZtqKgXjPzk+VmZCzMl/CvhRmDG
X-Gm-Gg: AfdE7ckcPWCO50pa0enhMdIGHJMFlrVQ3o+2LP65HIJU9K3Es5nZhIWPW2oOEmTRmWw
	49M233U3HcE5L1I9K3tuNPPGBPbsjhrs2JCFDuXvIg2IAwsyCPxrpMnJN/X/jpkZ0khw90rnYDT
	i/gBvaO5ivMruPoGGZ4dyfMndnq6bh0QbKwDMWpcHN+vQdJQPpYixNLOfS5jmslkFKlo0FMMPhg
	jO/EXWIPCtZOah3D4Xg27ME7lrbWM7h6EdQKxCZNvPcVu/HbaNCQmqRhAJwHcyzdDo1a5lKW9Ro
	vkfhFwCkzDlbRjWTW/WdAE0c9PeYkvm+QvH+KXDM3oARviXeoOkhruycQUqQpWVyZfBRNsN1+Kh
	+bl6cy3TsBEOMBOMWCt0CdZYXVNbXSTrsqDk54+6CgquamJxZS7AOYM7EezXvRcBWFbt7EpTSwZ
	SZ7qIQs7kgnREXclg3pB1AU307m0KLX71/CyPRuUvOkOMk/UDV7hnF7XvQFGy1bm+Z02MqFYlIO
	M7a476rL4AbayM0aBkqMMjTJhwwqrKk8uyTgHpG9aAtK38ZprvByzg=
X-Received: by 2002:a05:620a:460c:b0:92e:e2a4:ae86 with SMTP id af79cd13be357-92ef2c6b27amr32773185a.80.1783707157195;
        Fri, 10 Jul 2026 11:12:37 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b38dsm270405185a.10.2026.07.10.11.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 11:12:36 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <dstsmallbird@foxmail.com>,
	Zihan Xi <xizh2024@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net] sctp: fix auth_hmacs array size in struct sctp_cookie
Date: Fri, 10 Jul 2026 14:12:35 -0400
Message-ID: <634a0de0d5de29532915e6d47c92a0cbc206e03f.1783707155.git.lucien.xin@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1321-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:yuantan098@gmail.com,m:dstsmallbird@foxmail.com,m:xizh2024@lzu.edu.cn,m:enjou1224z@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,foxmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lzu.edu.cn:email,foxmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A475073D489

The auth_hmacs array in struct sctp_cookie is supposed to store a complete
SCTP_AUTH_HMAC_ALGO parameter, which consists of a struct sctp_paramhdr
followed by N HMAC identifiers.

However, the array size was calculated using an extra 2 bytes instead of
sizeof(struct sctp_paramhdr), which is 4 bytes. When four HMAC identifiers
are configured, the HMAC-ALGO parameter stored in the endpoint is larger
than the auth_hmacs buffer in the cookie.

As a result, sctp_association_init() copies beyond the end of auth_hmacs
when initializing the association, corrupting the adjacent auth_chunks
field. This can lead to an invalid HMAC identifier being accepted and later
cause an out-of-bounds read in sctp_auth_get_hmac().

Fix the array size calculation by including the full SCTP parameter header
size.

Fixes: 1f485649f529 ("[SCTP]: Implement SCTP-AUTH internals")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <dstsmallbird@foxmail.com>
Reported-by: Zihan Xi <xizh2024@lzu.edu.cn>
Reported-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/sctp/structs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index affee44bd38e..cccc662561aa 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -312,7 +312,8 @@ struct sctp_cookie {
 
 	__u8 auth_random[sizeof(struct sctp_paramhdr) +
 			 SCTP_AUTH_RANDOM_LENGTH];
-	__u8 auth_hmacs[SCTP_AUTH_NUM_HMACS * sizeof(__u16) + 2];
+	__u8 auth_hmacs[sizeof(struct sctp_paramhdr) +
+			SCTP_AUTH_NUM_HMACS * sizeof(__u16)];
 	__u8 auth_chunks[sizeof(struct sctp_paramhdr) + SCTP_AUTH_MAX_CHUNKS];
 
 	/* This is a shim for my peer's INIT packet, followed by
-- 
2.47.1


