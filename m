Return-Path: <linux-sctp+bounces-1294-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3EypBk9dPWqh1wgAu9opvQ
	(envelope-from <linux-sctp+bounces-1294-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 18:54:39 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C096C7939
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 18:54:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=b20gVmlt;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1294-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1294-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE9413053D20
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C31E7C18;
	Thu, 25 Jun 2026 16:54:01 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2DB3EB119
	for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 16:54:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406441; cv=none; b=tYqtMkS9XVNuNyq3ZYDEpV4LT9aJeXB6nrUMm1dD5Lm0Jdyl4mcNaA0nSxkWvneyuJaaK7kqllLlqZrbc0cR2hNPX9E9baZaYk56pyPB9OScne3yuOzM6nAzxexQ9dYbsNNM4E10tcperWOA72tb8uw8EXo2y5v1jY1e5Dskle0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406441; c=relaxed/simple;
	bh=/eRuHFDI2ypTSzxFHx5ug3Zegsy8wNUUeDduP/sw8j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E36qnRqyU5fLKd1Uh/uhPAhBUNsCe5KHhiAy0GHHwj1mXvSQzGx0j0PGwdhEd0qDeKIUEyrodpyKIMaIWWxeQRbNnfxfLid60gwK0r5c+c/eA7iRDejU9nQtXLV8F+iEFZtGwH6UiFnti+RnTNb1I8HtxgTo3PqLhNjpr9yaUf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b20gVmlt; arc=none smtp.client-ip=209.85.167.45
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aea1776279so13231e87.2
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406438; x=1783011238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=feHQJVyeMqGKPt/6dnOwPMhuCCxYGuXcKgg+YszQic0=;
        b=b20gVmlt+vRsj7kmdKOo6cTYNW2uLyqzaiMcpMkS99XqRjEaovF7oF7otTRRqxy58+
         QIYhQfY880vgUCo7tBkuRNgzJcds7w38poDXHOfm0P+ckAWXKq4Em4uPBkB94dxDxBnl
         RWsG5iqqQHd2pV4rkShikKReLN2seROJHb2vOkuzjVzlbRwbHUtSXv0gjj25qm4aU4fx
         dR+LxkTz1xPLghCjtUUr7kh+enlhAF5wHlyk/3m06YwNy4xN4mfC0aNWLSEsZ4Il2zr0
         HGuqLJncDIhCO++KjJ9kekIUQzCBtSIdEoUV7Er/lqkkIDwRnZ7hROGEgP+TBasjqAd/
         AIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406438; x=1783011238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=feHQJVyeMqGKPt/6dnOwPMhuCCxYGuXcKgg+YszQic0=;
        b=pp4WZdkg2YrO8q8/8Kce9ZqKRQLPLn8Hc54ZKypmOKUaVL4wy2Cr3wq9w6wqiXv83x
         4BukkGG+LcFVtK+kmGZ7+txmQgBzmSkT/Hs8NTeJ4ndF7f4jeKdBsNJ/qoM1VJ8/Nh0B
         rFWzkSA0Q7HrMWUZM4NzExnzW/SvPz2QLAmb1FvVyVb+aDkC36Ziet7gIme0iobLoLXP
         my52OOud1w4UH3eaam6etomkIwGr6evpO9twI0l1U1LxLbTLRCfuPMeftXe9NrjDj5Kc
         gwDF+ytfjY3QPJjgJJ9Mxyzqi2p3v2pLTLVe/V9ndt0s8E9SehK0hCsvk2jCNKS7RNYx
         aWTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr8WeUyAif2R/MH7Pdljx78R0esSptaGjDazNQWmH2l5GbTS5DWNcICaX1rW8CRmUz+YKx8X79j4t+y@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3OMSs1KT3SSgAOfgD/9mhNYMCOzmDSVMO95tvyijNtlGGQQFn
	cD2q6Y2ZQeNrqKPC7TW8lCiz0yY8stuMz/yXfoivK6tNEAh8qi0LYDJ0
X-Gm-Gg: AfdE7cmUg7Fn5P83mKAKZ3hf2WT/5Y67Zfj9v00gs21EEu4Zckr8BOYVZl6QgPQQF8r
	eIQ9z61mXPDm67qIoOmce/oAF85M9rdrE0pUdzIqGpup+y7nPO5GmZvaqW+U1E7eQ1gKkkadWG3
	azV+zWtndvXGBTSM4rgA0a8T4yzbpfIS5RlCkYsdtroBqYYlf9mcjk/N0m55nRZtQZugUSl4jW8
	G2u2vRj8QODsx0AvLih2W3La8L3tRLweBwcp/Q8jPhJ1wXWSqayBaw7ciPHlEw9Ri6ugk1cNlzP
	04C686SGOt5wxz67ER1l5Df9Gfn5xBf3Ds/NfhskCBQSBy44kJWeiHQxIGirQ1WJ6FPNlt8aUip
	0PSobQDiJdJzI30MvsqLW1lBD4YhkFBi62ICu13LtgrPN8edbMiZkbQQKgeDWnGiKMNC6yjVxQ2
	u4Dz7XSpLR6pHx6LhCvPicvgX+JPkt
X-Received: by 2002:a05:6512:4052:b0:5ad:699f:9edd with SMTP id 2adb3069b0e04-5aea1f63d9amr1156950e87.26.1782406438099;
        Thu, 25 Jun 2026 09:53:58 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a543sm2828849e87.13.2026.06.25.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:53:56 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15/6.1/6.6 2/2] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Thu, 25 Jun 2026 19:53:33 +0300
Message-ID: <20260625165335.162311-3-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625165335.162311-1-alexevgmart@gmail.com>
References: <20260625165335.162311-1-alexevgmart@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-1294-lists,linux-sctp=lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:bestswngs@gmail.com,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexevgmart@gmail.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94C096C7939

From: Xin Long <lucien.xin@gmail.com>

commit 2cd7e6971fc2787408ceef17906ea152791448cf upstream.

udp_tunnel_xmit_skb() / udp_tunnel6_xmit_skb() are expected to run with
BH disabled.  After commit 6f1a9140ecda ("add xmit recursion limit to
tunnel xmit functions"), on the path:

  udp(6)_tunnel_xmit_skb() -> ip(6)tunnel_xmit()

dev_xmit_recursion_inc()/dec() must stay balanced on the same CPU.

Without local_bh_disable(), the context may move between CPUs, which can
break the inc/dec pairing. This may lead to incorrect recursion level
detection and cause packets to be dropped in ip(6)_tunnel_xmit() or
__dev_queue_xmit().

Fix it by disabling BH around both IPv4 and IPv6 SCTP UDP xmit paths.

In my testing, after enabling the SCTP over UDP:

  # ip net exec ha sysctl -w net.sctp.udp_port=9899
  # ip net exec ha sysctl -w net.sctp.encap_port=9899
  # ip net exec hb sysctl -w net.sctp.udp_port=9899
  # ip net exec hb sysctl -w net.sctp.encap_port=9899

  # ip net exec ha iperf3 -s

- without this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  37.2 MBytes  31.2 Mbits/sec  sender
  [  5]   0.00-10.00  sec  37.1 MBytes  31.1 Mbits/sec  receiver

- with this patch:

  # ip net exec hb iperf3 -c 192.168.0.1 --sctp
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  sender
  [  5]   0.00-10.00  sec  3.14 GBytes  2.69 Gbits/sec  receiver

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Link: https://patch.msgid.link/c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 net/sctp/ipv6.c     | 2 ++
 net/sctp/protocol.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 12469cf1a49d..99686b87b99a 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -263,9 +263,11 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	local_bh_disable();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 2185f44198de..0f7e241178f5 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1085,9 +1085,11 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+	local_bh_disable();
 	udp_tunnel_xmit_skb((struct rtable *)dst, sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.43.0


