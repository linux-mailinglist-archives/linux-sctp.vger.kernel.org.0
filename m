Return-Path: <linux-sctp+bounces-1293-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o7t0IC5dPWqV1wgAu9opvQ
	(envelope-from <linux-sctp+bounces-1293-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 18:54:06 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5DD6C7928
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 18:54:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dCPdbfGg;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1293-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1293-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42A8A3012CEB
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 16:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA663E9C08;
	Thu, 25 Jun 2026 16:53:58 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5430D414
	for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 16:53:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406438; cv=none; b=WM82tCcyggKJ4Zz8RXUbl2SYDGEuh77PoY3pSCoUmuSJDZFfAl/vGJyiPb+fPGz9gRUnky0mTdI6n7ZCa/4INVETwXBxMQq6XI0tjrW86WXtqPhfCVnKVABcvP7RTwMsp/1xLY/WBL7RGZdHyI+vYOMBuqcfshNgpJxgHwfnon8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406438; c=relaxed/simple;
	bh=5qVHps26hM+lLmNc8QeJKUzcQRmEU09xSvy67t8Jwwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5O3h2pXXHkwGL3c6zQ104LQMXF1noMXVuymhpQkVYj6KHzFq5Dek62WQ6EJlTqvGt4VC8Guq1AAPaMNOnHDAvsnvc5mnV5BuwBoGpuGZeuwGDXWPOz6rgWZsP4qwmDvmTrUDFspfwSo1WIX2CJamjJd3fmhSuQSyPsdVUXAwwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCPdbfGg; arc=none smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa2c25c632so20302e87.1
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406434; x=1783011234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tDUw2ua7IfiwLpN7RDrJJg19vrTPnELI9CPZKMaHeY=;
        b=dCPdbfGgGOLQwsUijOjAC8b7Veorb68bosqGxZ3uUfYWQqgchdoUdyLFqxZKi75F95
         gwEoSjqlmv2wOxlCnumxDd3lFLFS8rkQpvcWFRCdjM4QZBhMYUS+0ph6XOJZ7yPoUyU+
         KNY6DK0wz/X3pP+vzjGsGzXwMcm5K8VOpinfu2crjsBXaLACLozao/8GwzciB/M5YlP+
         DK5O0a2KJqoOiiqAnSb6Gk2r+EBDftiYTJ8f1cdO9q/eWAW5TnQZOI8tAcl5I2U9qbnt
         jp67eGH9FW6fkckaawhdSwFQjMcap98kryzwO+N8ByVrIt38mgaGVEKwq7TLJMEjXiBX
         jhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406434; x=1783011234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tDUw2ua7IfiwLpN7RDrJJg19vrTPnELI9CPZKMaHeY=;
        b=JqJUumSqQfWgbmhBjEh7X3bfCRHMZz98g+uXvpXoSjJkBbPQCVHRDfjyEdTooD80rf
         KtTAUdAlBpDp8wevwZrsV/lJA5v4qJpa5SGB8F+5J42vn/GLjZ5DYqOUXty4OoWrBgQj
         qRDtvBGy6nXucjWnRwcpLwmkysxV5nQ7TMzKRu40oqYJz1rrMgCzgvO/cnQVwBY1fOOu
         u3PcHt4Ozq4iv+nxaMnh12ORI5sqKTp4V8QU3tX9oPxXVQAnpu8xHBoocMFSapj3vCeF
         jhnNfzPa2fcodfOEOBDw/oPbNMWjEYtrn+cwym+/bdgDJM3LFcH3DxIbu6uuDue7UKqR
         oKjQ==
X-Forwarded-Encrypted: i=1; AHgh+RpRuG4BYA3IKDBZHpOn0GenlbZurraphlWlopcZa+5WWsgWRx1SlffZAR/XQsIqsab1l53tSnZ6X3X5@vger.kernel.org
X-Gm-Message-State: AOJu0YzlN7P/M7NlULEgICPAp5gqhxmE44FspwzZV9Jb5rZwwZMwruif
	ZAMHvxX9aD3RmmUtNeGMDh9kgec6nu83hsDlPiMDqK8Un+HctsCcToJx
X-Gm-Gg: AfdE7cl1qfuZrVQ669vF+Dx/WBHbbQ3mfYkMsHv1cKrVNayN7QLDbYiIZJLJygDt3c8
	M5etg3k1F/1HolV2EsFPw2EP2nOKZLEwcSEkWbCgY+2+PQxcApdfKqF9jB+Ugj9bV+0UPMI0tVC
	NQyDaLfC/2vYFrK0+92IZb0Wi+KCTly8uqs7+j1UPy5rKe/7NEzRMG8Wepy0t9YL+cN1WopH7xb
	+2F//6z9RWPhASuFeWmdv3pw1eT3ibtUIzRFMZacGkk8KemXoTz7aUzklsIjQPU93EwM5T0UR94
	a5vKLq4PlTH2vFkvW/0/3waAWv6ddf6zO+K/B606TqQaYermZoUtVgqyam5LxckKj8ZTHZGfLK1
	uZydzl1mWd1rncC8HBCCaRvsvCaxrpDFJGBeKV97WVYJWZ4xWOoQMRFBOpyYVt2R8tXWCIwZ9Ic
	YmeZEy5gctVaaZrLSnUoBm+Wl2irvG
X-Received: by 2002:a05:6512:2510:b0:5ae:a333:e982 with SMTP id 2adb3069b0e04-5aea333ea42mr853884e87.27.1782406434168;
        Thu, 25 Jun 2026 09:53:54 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6954a543sm2828849e87.13.2026.06.25.09.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:53:53 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH 5.15/6.1/6.6 1/2] net: ipv6: Make udp_tunnel6_xmit_skb() void
Date: Thu, 25 Jun 2026 19:53:32 +0300
Message-ID: <20260625165335.162311-2-alexevgmart@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1293-lists,linux-sctp=lfdr.de];
	FORGED_SENDER(0.00)[alexevgmart@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,windriver.com,vger.kernel.org,lists.sourceforge.net,nvidia.com,blackwall.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:alexevgmart@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:dsahern@kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:jmaloy@redhat.com,m:ying.xue@windriver.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:petrm@nvidia.com,m:idosch@nvidia.com,m:razor@blackwall.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,blackwall.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB5DD6C7928

From: Petr Machata <petrm@nvidia.com>

commit 6a7d88ca15f73c5c570c372238f71d63da1fda55 upstream.

The function always returns zero, thus the return value does not carry any
signal. Just make it void.

Most callers already ignore the return value. However:

- Refold arguments of the call from sctp_v6_xmit() so that they fit into
  the 80-column limit.

- tipc_udp_xmit() initializes err from the return value, but that should
  already be always zero at that point. So there's no practical change, but
  elision of the assignment prompts a couple more tweaks to clean up the
  function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://patch.msgid.link/7facacf9d8ca3ca9391a4aee88160913671b868d.1750113335.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 include/net/udp_tunnel.h  |  2 +-
 net/ipv6/ip6_udp_tunnel.c |  3 +--
 net/sctp/ipv6.c           |  7 ++++---
 net/tipc/udp_media.c      | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 6818a59a1ebc..dc796ddd231d 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -152,7 +152,7 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			 struct sk_buff *skb,
 			 struct net_device *dev, struct in6_addr *saddr,
 			 struct in6_addr *daddr,
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 7aef559e60ec..886c42de0566 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,7 +74,7 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 			 struct sk_buff *skb,
 			 struct net_device *dev, struct in6_addr *saddr,
 			 struct in6_addr *daddr,
@@ -108,7 +108,6 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->saddr	  = *saddr;
 
 	ip6tunnel_xmit(sk, skb, dev);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 0673857cb3d8..12469cf1a49d 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -263,9 +263,10 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
-	return udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr,
-				    &fl6->daddr, tclass, ip6_dst_hoplimit(dst),
-				    label, sctp_sk(sk)->udp_port, t->encap_port, false);
+	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
+			     tclass, ip6_dst_hoplimit(dst), label,
+			     sctp_sk(sk)->udp_port, t->encap_port, false);
+	return 0;
 }
 
 /* Returns the dst cache entry for the given source and destination ip
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index e993bd6ed7c2..26aca3df2978 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -172,7 +172,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			 struct udp_media_addr *dst, struct dst_cache *cache)
 {
 	struct dst_entry *ndst;
-	int ttl, err = 0;
+	int ttl, err;
 
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
@@ -217,13 +217,13 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 			dst_cache_set_ip6(cache, ndst, &fl6.saddr);
 		}
 		ttl = ip6_dst_hoplimit(ndst);
-		err = udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
-					   &src->ipv6, &dst->ipv6, 0, ttl, 0,
-					   src->port, dst->port, false);
+		udp_tunnel6_xmit_skb(ndst, ub->ubsock->sk, skb, NULL,
+				     &src->ipv6, &dst->ipv6, 0, ttl, 0,
+				     src->port, dst->port, false);
 #endif
 	}
 	local_bh_enable();
-	return err;
+	return 0;
 
 tx_error:
 	local_bh_enable();
-- 
2.43.0


