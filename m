Return-Path: <linux-sctp+bounces-1288-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lSWMFPHlPGoxuAgAu9opvQ
	(envelope-from <linux-sctp+bounces-1288-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 10:25:21 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 711326C3C10
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 10:25:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lxfWE3wX;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1288-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1288-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DD6E300603F
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 08:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73871714AA;
	Thu, 25 Jun 2026 08:25:15 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AAF2253EB
	for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 08:25:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782375915; cv=none; b=DK987jlosSHcsU8B/5mnmKNr4R1L1u0bgqiOtZP+vUnyQ/fT/dtH4hL9EFLS1yAu/nKwlLQNHG9kwUG0CWPDrjl+lss6DYPxWBBTGr9G8TCvI8hXMsQrPdbz+BZ6MZB7GnkpNEbnc4xM+0/6HHSpCnKJfbTuGrwgRV5eo0HOnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782375915; c=relaxed/simple;
	bh=FttxWcQB/hNn+4s9v0hsj+DpOXG7C6zn1XazAFM7dH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D26eCnLmRqwMEktKt6mwtMjUci5E65mr+yc/HlTy+Ru/BMzgcJpw2u95qioxvdbguqcbI8IXghmIzoJCTTQjv9h/RxGXFAYzActFkKGejg3IfBC4jujl6t/VubDbPtBQjqzJHKqdJ4cvcchF4JuLv4cBZpu3Yde6OMNg2YJWss0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxfWE3wX; arc=none smtp.client-ip=209.85.167.47
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ae9fabd40fso816295e87.2
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 01:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782375912; x=1782980712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNsZSX3/QBjqrDIvX4drEF9Odl8RtjkKP8nQ70A9iWI=;
        b=lxfWE3wXOPqeE/e51favXN6jlbuBkWkaWVrfdA1/4TTbjaGumbP2VPamidjALhrg5e
         caq/MgRnP7+INT4a4QVtS6zy8yF7n4qNB7yR4mpgATEMF2/pfN0bSPwhAF9V+cP8y9Ki
         aN1AcuTMN3mfUY3u6c2nY7gTQ3CSFziVJlaRrXoariu8wIIzyurG7Ny+qQ1TNOuhVt2z
         zmjq53KrcqIR7uqPBiKiLNRxxSG09MLt8JNpcxOecYErnmsSwFtMMlcWZ6dquyraQ5UI
         bqdrEGsl0985UBaYUSIg3DtoRbIdd7Zj7Qe4BtBjzKtO+9AD1X3vyCK+EiykwvwZ6bM7
         2Zlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782375912; x=1782980712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YNsZSX3/QBjqrDIvX4drEF9Odl8RtjkKP8nQ70A9iWI=;
        b=T75SJvs/WQ7kXokK2phH1RnlMvFQIwI8qC04aQFRtcwGPnm1dAw6dqJAoy+mkNS20v
         6hkZVQCGORfSaQ4xTaRzlSGMtryz6WmITJid86EtQEQDjaJPI9F4A6U6dcLSSvmdXRf2
         tJXmkV6vEQi727BWrcT2v2dPMEv7JUf8BnCdikL9+mFwkqZ2SEDznFrYwZI89bhhxsor
         fxD98NLeegNxSLgw9RcvJJoC3rHu/pfqdOC4TZikEUnqtT3SvXdkB2vKgbvLJQHdOzcU
         kYH8xQTPXedmPW0aEFDDOrkpaMDtMvj0USbY91aVtDM9OHdUfFwIOlAyxHI0mlNJuniu
         KrSg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2JJW6lQGydIm2gIop6MaMWwUEpMwKzmF+uwIRn5ud06v7hwde86tpue251XU2V69av8LYuGRVmpQr@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwZ7UcMUiuS0kG8SLDv67/tlMe4H6qDngOIZURe9Xs2S4syzO
	/NB/GKQBSD7lkFJKsPvHXwaBkJT9hHPWRnLquhk/U0ROFG+hi9Kp4tuy
X-Gm-Gg: AfdE7cnFCgzvgnJ0s/I2Hg10B6KwKNZzEkC61W16fi1txXN7pizyw5FtYYFLlC8Cu23
	ToXx8SU8cXOru+lnGXNsJfygxn3rkcv9VbPwgg7Wc9BzVref6aiWJ4J72pnWk61FEOvlG3fXPHQ
	nCSfcvmijJGhCJiX8WF5wRmv7M03b0XfbOTnZU3+72f0NzT4Gss1I4BJtlI8qxaN1U7ej/u2wvc
	B7P8P/n81+DzmLQE5LG6dzF1BXOlulg59ov8w21VzSbbbUrLHWh3+SNoDDncYdm+nayrY0XJjaS
	FYTM3/ybBV8eMbBIy1hcqCC+CNVtwEcI5tTlW7h49HVc/NJX731M2RDWJH5Jzngg2Ch1+o7xA58
	jc2QtPHir9/FzreuhMTtqwDIj87uUzWE7sB/K3yTQKdmWZQAK4vISUy7eTyhnOwSz5I5H+R5asc
	uq15NcI9kBXrEgJlumpJAvD4RPc8kR
X-Received: by 2002:a05:6512:b8b:b0:5aa:6df7:4eac with SMTP id 2adb3069b0e04-5aea1f2d8famr531570e87.20.1782375912271;
        Thu, 25 Jun 2026 01:25:12 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39ad31a81adsm566391fa.28.2026.06.25.01.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 01:25:11 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
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
Subject: [PATCH 6.12 1/2] net: ipv6: Make udp_tunnel6_xmit_skb() void
Date: Thu, 25 Jun 2026 11:24:41 +0300
Message-ID: <20260625082442.96390-2-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625082442.96390-1-alexevgmart@gmail.com>
References: <20260625082442.96390-1-alexevgmart@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-1288-lists,linux-sctp=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,blackwall.org:email,vger.kernel.org:from_smtp,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 711326C3C10

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
 include/net/udp_tunnel.h  | 14 +++++++-------
 net/ipv6/ip6_udp_tunnel.c | 15 +++++++--------
 net/sctp/ipv6.c           |  7 ++++---
 net/tipc/udp_media.c      | 10 +++++-----
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
index 6e2c5c77031f..8ed36ec520d7 100644
--- a/include/net/udp_tunnel.h
+++ b/include/net/udp_tunnel.h
@@ -152,13 +152,13 @@ void udp_tunnel_xmit_skb(struct rtable *rt, struct sock *sk, struct sk_buff *skb
 			 __be16 df, __be16 src_port, __be16 dst_port,
 			 bool xnet, bool nocheck);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck);
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck);
 
 void udp_tunnel_sock_release(struct socket *sock);
 
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 2acf1bb93fc0..f22eff2ba77c 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -74,13 +74,13 @@ int udp_sock_create6(struct net *net, struct udp_port_cfg *cfg,
 }
 EXPORT_SYMBOL_GPL(udp_sock_create6);
 
-int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
-			 struct sk_buff *skb,
-			 struct net_device *dev,
-			 const struct in6_addr *saddr,
-			 const struct in6_addr *daddr,
-			 __u8 prio, __u8 ttl, __be32 label,
-			 __be16 src_port, __be16 dst_port, bool nocheck)
+void udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
+			  struct sk_buff *skb,
+			  struct net_device *dev,
+			  const struct in6_addr *saddr,
+			  const struct in6_addr *daddr,
+			  __u8 prio, __u8 ttl, __be32 label,
+			  __be16 src_port, __be16 dst_port, bool nocheck)
 {
 	struct udphdr *uh;
 	struct ipv6hdr *ip6h;
@@ -109,7 +109,6 @@ int udp_tunnel6_xmit_skb(struct dst_entry *dst, struct sock *sk,
 	ip6h->saddr	  = *saddr;
 
 	ip6tunnel_xmit(sk, skb, dev);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(udp_tunnel6_xmit_skb);
 
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 9f835e674c59..b4c321bad033 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,10 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
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
index 258d6aa4f21a..1b8d6bbf8a8e 100644
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


