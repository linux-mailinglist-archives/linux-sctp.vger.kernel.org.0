Return-Path: <linux-sctp+bounces-1184-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF8sKkNV4Gl5fAAAu9opvQ
	(envelope-from <linux-sctp+bounces-1184-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Apr 2026 05:19:31 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F41DB409E65
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Apr 2026 05:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2B95300E6A9
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Apr 2026 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF032773D3;
	Thu, 16 Apr 2026 03:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaPreFgq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0CE233723
	for <linux-sctp@vger.kernel.org>; Thu, 16 Apr 2026 03:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776309563; cv=none; b=rMCY8jHzBna9MyRb1n8sQMWrrPHlhtkePkdYLa08ypxLY6vdL69vOYsG65rkxWD5xtZoZOjN4Ok9QOMYG0SjEUBzv3vqTpn9DdUQFtEYApkMFxTE5jt2lMni+pE1Jp25T+G1zrlyvGL3zocXiXqWyQfy/YVWeor8nDApk3PaHhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776309563; c=relaxed/simple;
	bh=6gffQwVrZbWmmoZmS6ntD3kXVEXf3L650/1kWkyePIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYgGBY1J8sKtuS/q2u9wlL6mVzbqOWH+ztarmoGpRmpGHPy0oaNr2Y/4IlBdiWOKHpDunCccS1iTI2LZRguxp+6s8jm2QZ2t9zxxQ5T5k/2vmWj6LxX+JSYL5HmEfyUiSHh6YlBYkAUG2jbMmFhMVRm8BgKQ4Q/tyP0ewlQLfR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VaPreFgq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d560ede296so884537485a.0
        for <linux-sctp@vger.kernel.org>; Wed, 15 Apr 2026 20:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776309560; x=1776914360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GgBzs6EKzyDLWZ+aqE87/ScBh1gHb7gMVIBVANVXsG8=;
        b=VaPreFgqvH6YxdHi7lpfMyQ8zQHsFSai9T1koCoIkNPxbjCkYMK/NNaRkJYWC79mpk
         XcU29drJP427G9fYkn0q/U7P5v51t3MNzKYGskE2ShwIvZ464bXMlVzg3WbrD5s5qo4r
         iuuZQHh2EufS1CQIiGqyNnk+de0K5c6DIjsbcaBAuVRJ3Lq4IPM/hwcUuyQn8dNpC0zv
         eZfFRpzS4DWJX2PRsr13c6Gs5fOECcA9vmzjq5lvqMX8U0julgXQqm1NzJl1ph1ShERi
         BpbMxDgN30zBimN6LircLEgTNU98k+Lw58NB7poGNl/Dzna8dYplLnG3U24w0bJYiboR
         Lv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776309560; x=1776914360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GgBzs6EKzyDLWZ+aqE87/ScBh1gHb7gMVIBVANVXsG8=;
        b=XCP4Cgs8k3j6JpPAviuoEB3LZ2YZNnu4ioih4QuRf+9XShYckOE8ktQe6+Pi7EfkdH
         ybIKR8YI/RMQIWG/84EQcFC05Wnd7PyOnU8YMGt9LmrH3mK50YTwtT+GHRPF1tcIH3/x
         og1HCPdha9EZdTcHv6SaxuPVjt6T9iJUl24UwA77Q7CBwG/yfbvxk/dVdyOTYnXfnc0h
         Il1FMIBZ3KCTjpFQc1pEV1wo0s9yLNXIB/T5oID7qI0/KjfByXLPmq1RByKm8BKMp74U
         g+ZH0K0MhwqCtUO51cGGV3VvUdFNaafXYT4JZCaFcj0GAnt1LQ1I6HJ+0d6dzOC5PDPy
         Cq5A==
X-Gm-Message-State: AOJu0YwM9Y9cAA/xLm0CTtEisj8BJGoso2+GOIolzLsfmCHDA/I6rEK+
	OwZ2vjQcX4CsHv/bdck4gF8+VK16t0bs6Gf32ZrJ9HXg3DnjCm38iy76Y6nEODn/
X-Gm-Gg: AeBDiesO9Mlt5DbVgGFQP8V6HsLilxkbzNn0QA4wMqTJMW2gt/L6YiTyoHSUX3ndTMO
	mriBZyrzlWqIE7bgPEVx+WKOExsV3tJnNqlHM5n75DRzUmpXBDtAy5T98nxqNhw2/LFtfxUmPuF
	H2qC1Gv2YPUzcie7U6EEDGiMaise0ACYC1ev4gwGpj9XdRLTtmPtnu67tw+InAXqzVJRygp3ssd
	nK5nYoKKO7Pywbvmw+uOUaa/vslqhwW6Ww5SnddUjxFVTg00/ZSbFhjwISCAwKaRuzX/pte+kN3
	4TrFC4tX52FoAkgJ1FeEwOGU7mcFtetZ+Ju1kxeO8j0q+0yQ5pVj3PsGWToGUpKsJjq5Jox9eBV
	hdJfNmebpy+XkjInXGkZbIrs52YjqPTYPBmszYDOuJP6gEtxGmvXVrqu6jN4gxWSO5ZLNhgevto
	udwBVrL+2HCU2u4opRp3l0FOfF+avZZCJ4K8kF0ebFcaae3/EfZmNWChc5Pr76Z1f2H9/63avqQ
	HsogjST3VFAPFPzahxNaSjzu9bG1pfcYSzRagX+na5HeSSKvYHe/w==
X-Received: by 2002:a05:620a:29d1:b0:8dc:eca0:35bd with SMTP id af79cd13be357-8ddcd11942bmr3421071185a.5.1776309560487;
        Wed, 15 Apr 2026 20:19:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4eed6eef3sm297805585a.2.2026.04.15.20.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 20:19:19 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: linux-sctp@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] sctp: fix OOB write to userspace in sctp_getsockopt_peer_auth_chunks
Date: Wed, 15 Apr 2026 23:19:03 -0400
Message-ID: <20260416031903.1447072-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-1184-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.5.7.0.0.1.0.0.e.5.1.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-sctp@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F41DB409E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sctp_getsockopt_peer_auth_chunks() checks that the caller's optval
buffer is large enough for the peer AUTH chunk list with

    if (len < num_chunks)
            return -EINVAL;

but then writes num_chunks bytes to p->gauth_chunks, which lives
at offset offsetof(struct sctp_authchunks, gauth_chunks) == 8
inside optval.  The check is missing the sizeof(struct
sctp_authchunks) = 8-byte header.  When the caller supplies
len == num_chunks (for any num_chunks > 0) the test passes but
copy_to_user() writes sizeof(struct sctp_authchunks) = 8 bytes
past the declared buffer.

The sibling function sctp_getsockopt_local_auth_chunks() at the
next line already has the correct check:

    if (len < sizeof(struct sctp_authchunks) + num_chunks)
            return -EINVAL;

Align the peer variant with its sibling.

Reproducer confirms on v7.0-13-generic: an unprivileged userspace
caller that opens a loopback SCTP association with AUTH enabled,
queries num_chunks with a short optval, then issues the real
getsockopt with len == num_chunks and sentinel bytes painted past
the buffer observes those sentinel bytes overwritten with the
peer's AUTH chunk type.  The bytes written are under the peer's
control but land in the caller's own userspace; this is not a
kernel memory corruption, but it is a kernel-side contract
violation that can silently corrupt adjacent userspace data.

Fixes: 65b07e5d0d09 ("[SCTP]: API updates to suport SCTP-AUTH extensions.")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/sctp/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 05fb00c9c335..f5d442753dc9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7033,7 +7033,7 @@ static int sctp_getsockopt_peer_auth_chunks(struct sock *sk, int len,
 
 	/* See if the user provided enough room for all the data */
 	num_chunks = ntohs(ch->param_hdr.length) - sizeof(struct sctp_paramhdr);
-	if (len < num_chunks)
+	if (len < sizeof(struct sctp_authchunks) + num_chunks)
 		return -EINVAL;
 
 	if (copy_to_user(to, ch->chunks, num_chunks))
-- 
2.53.0


