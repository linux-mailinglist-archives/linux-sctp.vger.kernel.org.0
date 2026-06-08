Return-Path: <linux-sctp+bounces-1246-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CVitCn3uJmopngIAu9opvQ
	(envelope-from <linux-sctp+bounces-1246-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 08 Jun 2026 18:31:57 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 925FF658BBD
	for <lists+linux-sctp@lfdr.de>; Mon, 08 Jun 2026 18:31:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ibL9kTmg;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1246-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1246-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40CCD3051594
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Jun 2026 16:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E5348C56;
	Mon,  8 Jun 2026 16:22:39 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62A33A9E1
	for <linux-sctp@vger.kernel.org>; Mon,  8 Jun 2026 16:22:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935759; cv=none; b=aqnumiPHVtl3Ik7fEUhlBvCg9X2e8capt6OAvWHSUKtYfHaA1W12+f9hxFKr13QcLg/ZZ/wdWSZz8lrijpb0afQ5S9GwLBDJ6PCeTcKLSIleAgsOrO6ipoeMhmZOqHCqrB4TDcT4AtYdu1YKzSvzspLwUqFdWlUZz1ZyTHAXVb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935759; c=relaxed/simple;
	bh=jFcy7qGszDpviUxuZY4SN2f2XLYRG009KZCZxWTYTDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyA/IPp1DmtznzDPK0IoA1+HYSM1e6OEwmJcvBoiGsICpgr+CKg5SzciDc6WIppwDLL9eodFl72NNIa9Ofxsarmd01FCDgwPQqblpvz8mLP7d3K4selTCTIioUgt61QuBV75gmM/DThKzMO3mxaDmH3hpzBCoYaiQoWQZ+gxHM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibL9kTmg; arc=none smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91574384cc2so521065085a.2
        for <linux-sctp@vger.kernel.org>; Mon, 08 Jun 2026 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780935756; x=1781540556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yvinHr1mQvwvNvWAosxx0fmHzORHH/aQDJK7llc8tJM=;
        b=ibL9kTmgsM0+NW/9htvvrjqgoaRAMO1LNxr3WhP/f7qzJ6OoEC59FiD02bgPfULDB6
         TNIsI8MVk60PTFrhuGZBx0w26TybCtsElCioHSJWrU06S16pTJUNareffudBXZlTiD1L
         FVOCb+iuJzvKBBjeT2Mxv3FvQzvoEk+yV/KKEd2M2TuvyyW2js0VQkQ24L3HTz9og1mm
         ciksH9e5koDO51zwnc9Rfi6uXWsQpfcjpTqwU/HlqqpmINV4o5nf3OfJnpjwLaLTzRai
         Ttlmeiy4A7AeudNmltsfuDJMN1+NlvwewvyBSKcDHdsG/d16mVYn2YwfLkwrEgBqQ6wm
         TvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935756; x=1781540556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvinHr1mQvwvNvWAosxx0fmHzORHH/aQDJK7llc8tJM=;
        b=mLrFi6alohmtZYvEpFS8GjwRJFOfHZoM6nH5KQm67o9CQvW/R2YM4mIP7HbxR+3GWM
         5lZq6Qo3roSQVcyIYinobAaEWlj0J2goAcLG5tRc+a8k/JdnpMQIp+tXXr8cKopkwyxw
         sm/rujXI/x3lg2cLQpz5GNPkl5Q2shqedafasKaxN0ACYT56CROR7eF5jm+0vFBm/9aJ
         dAV2uIzAIfk6jqakwJ5s4ttfBFyI8wrSlDXxEThbCmKb/gmlvq8GpJAoXM4vzMTl+42W
         iGz97xdsJcEx/NYAv+YTH+AFPgD+RV9yT2/+6GPKelQhL1xvm5klbr4uvYe2FEHaZI8B
         sGmw==
X-Forwarded-Encrypted: i=1; AFNElJ+KaPlsiy9UfVjcM/OgIB3mSaDW57NQdc3hD4j/JBKzhCeQRlpYLi47NV8mDsTlUs1oPOo6bdqEweXJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMAx4ubMHG18h0F4WEpjbRiRea9jXyxmiQp7F2WbtBBh53VP8
	zI7E3C8SxQV9qk2EL/Y2cr7iWhRQUwpHRA7Oa9tq47XZZEEpFQghKxc9
X-Gm-Gg: Acq92OHGqwxtq+mo9HUJyhSumuZnI+R1IGcMqFya+8HFF+MOY363YxJThD8b0T90y+G
	EpMMNJif9ztx9x+ltvA8h0ZeNRdr6zLIY6ZQ6kAAP8sq9vAYp6ObkHgvKcKVMUpNdoj0gwxL/5S
	MT8K9hyZSUIxVLEJFfNgmXC1JQJf4oYXpUgYrnt4a5rAGHIxoR9qgM7MUO0FMwxeQR0mmCOzHz3
	vzUOdp+OnRFfv9eCkA5xFh4DMcja5/CP5Q1myYHwcWSMF/z8Ny//kgfdB64QEelFp3Z5EpV8m/N
	P/2tYTu6f/IVG6XygujL6dO2PctJa5X1LB/oQvHAO9UVp142ivPPYSWgF5ZSImwT2VheWvSL6yY
	YdmZTHCIykp4n2VVF/PLV6DwfhjZzYV4qA2jQU9oCRDvNfQVdqsN+f1BhgSaxdTC4RoNcV8zcuX
	8mSEoG+Z1/uYh9m1mL0N9a9cLTYQ79b8kPXnLYS19ghZhT7w4SUo259fUKxVtyEQ==
X-Received: by 2002:a05:620a:bcb:b0:915:6a2b:626c with SMTP id af79cd13be357-915a9dd11d3mr2539559785a.51.1780935756139;
        Mon, 08 Jun 2026 09:22:36 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9159cd62a84sm1382524185a.5.2026.06.08.09.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 09:22:35 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH net v1] sctp: Unwind address notifier registration on failure
Date: Mon,  8 Jun 2026 12:22:30 -0400
Message-ID: <20260608162230.46644-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dbgh9129@gmail.com,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1246-lists,linux-sctp=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 925FF658BBD

sctp_v4_add_protocol() and sctp_v6_add_protocol() register their
address notifiers before registering the SCTP protocol handlers. If
protocol registration fails, the functions return without unregistering
the notifiers.

Unregister the notifiers on the protocol registration failure paths.
Also propagate notifier registration failures instead of ignoring them.

Fixes: 827bf12236fb ("[SCTP]: Re-order SCTP initializations to avoid race with sctp_rcv()")
Fixes: 270637abff0c ("[SCTP]: Fix a race between module load and protosw access")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 net/sctp/ipv6.c     | 10 ++++++++--
 net/sctp/protocol.c | 10 ++++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index cd15b695607e..ef26878f1282 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -1176,11 +1176,17 @@ void sctp_v6_protosw_exit(void)
 /* Register with inet6 layer. */
 int sctp_v6_add_protocol(void)
 {
+	int ret;
+
 	/* Register notifier for inet6 address additions/deletions. */
-	register_inet6addr_notifier(&sctp_inet6addr_notifier);
+	ret = register_inet6addr_notifier(&sctp_inet6addr_notifier);
+	if (ret)
+		return ret;
 
-	if (inet6_add_protocol(&sctpv6_protocol, IPPROTO_SCTP) < 0)
+	if (inet6_add_protocol(&sctpv6_protocol, IPPROTO_SCTP) < 0) {
+		unregister_inet6addr_notifier(&sctp_inet6addr_notifier);
 		return -EAGAIN;
+	}
 
 	return 0;
 }
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 5800e7ee7ea0..6153340f1b45 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1263,12 +1263,18 @@ static void sctp_v4_protosw_exit(void)
 
 static int sctp_v4_add_protocol(void)
 {
+	int ret;
+
 	/* Register notifier for inet address additions/deletions. */
-	register_inetaddr_notifier(&sctp_inetaddr_notifier);
+	ret = register_inetaddr_notifier(&sctp_inetaddr_notifier);
+	if (ret)
+		return ret;
 
 	/* Register SCTP with inet layer.  */
-	if (inet_add_protocol(&sctp_protocol, IPPROTO_SCTP) < 0)
+	if (inet_add_protocol(&sctp_protocol, IPPROTO_SCTP) < 0) {
+		unregister_inetaddr_notifier(&sctp_inetaddr_notifier);
 		return -EAGAIN;
+	}
 
 	return 0;
 }
-- 
2.43.0


