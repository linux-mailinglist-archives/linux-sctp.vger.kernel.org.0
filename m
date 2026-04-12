Return-Path: <linux-sctp+bounces-1174-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aH4ZD0nh22ngIAkAu9opvQ
	(envelope-from <linux-sctp+bounces-1174-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 20:15:37 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 464983E55C0
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 20:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B6433002B42
	for <lists+linux-sctp@lfdr.de>; Sun, 12 Apr 2026 18:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84BC271450;
	Sun, 12 Apr 2026 18:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk7sm6X4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6340DFD8
	for <linux-sctp@vger.kernel.org>; Sun, 12 Apr 2026 18:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776017730; cv=none; b=Vvtv/zZNwBmmITCs4eLPUz5m9GNl4qYA307bOUtt+OZza4sMc528TCdRQRx+HyLAKIFwUb7Sr7ku/LBS+D1lX+yYOvmjVXJHYaQ/v7Z1UCNKqxw9WVxzZWgAONQr0YDVA4B0xShq/TcBLRLJgKZbnx9Fe7hLqgMqQOYNNpFC/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776017730; c=relaxed/simple;
	bh=Byj/sqX+2JSsT8hmzhfEaSvDM99QoUAiN1oxmcwdnig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeTqhl5gUCfWpwcFnrXnS/boMvtTOQD7hjl34iw+4UeCU40n9AWlMHf35WzYuXN8dprsY3iH7soitEOShzrDxZrm6wdf6tosHZIdVDAzEfVppf4ggmu5vDAIrDQp8H0kcBglUX4lK2FibR59Y6ojTDN2OnvDoKfS6RXSGZ3CF70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jk7sm6X4; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cfd122d78fso513637585a.3
        for <linux-sctp@vger.kernel.org>; Sun, 12 Apr 2026 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776017728; x=1776622528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQyGEfo3+mfnnv1YXniq0e4ov23sKEA7WrqzMWQ1rgs=;
        b=jk7sm6X40OBOazy6RU6XLXFhC2LGNlMqOGb5LbMVnIQF1nyXXA0v4zix092zPAwM28
         3WWHA3infe5ZzdZBlOSZVHLB7jy4cptd8ypMr+cfNuwZn5q5ecNuceb0IFl+OnpyFRYS
         xcuYaMz2EuboD2ZD+C3pxO6Dr2SWC2L/p7nhi+NIcJGUBRed32EhSjW4n/dmrr5vogUd
         k/ix0Oh5TP41Amp2UqPee3WWz+RAfT8fOjD07NGDMxbSXV1gw5m7DaLQVKheO0yOEy3c
         G121U+GFuC+IjsobgIo5mxlz40du9unjLn6Sov0yOOI9hnZDzIZ5ZVkZatAdHTKxlSyo
         g2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776017728; x=1776622528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQyGEfo3+mfnnv1YXniq0e4ov23sKEA7WrqzMWQ1rgs=;
        b=CnVy27OqGx83iGtZ37xoHPaLFkSmaRAQNpOnfNrBGFmEec6doMSmyC3HWXSOb81lLU
         dD2qfzWrLpo9LviziqCdTtX6AGAklcnx46W3A7FFExwqQCcSgNIQQi9pU93GfS0nulPA
         7W3kBN8sZOxjiF3HyRuw7NBbVXJOkzTOX8HZuAlGs7JmKQ1+L4rIYSHPRgmpQZbzhx/E
         3sAq+OIgk+In72kpOa0/iKGcjyWvjec8zVN+jaox/ix0B7ZcSGVju5GQYAZGrmAmciJA
         NbqT71SnRyUN/LpbNvDN1nlXiHEXS9MhBe3/sD9ImR3VkHOAmg6UicSbB0Q8SdnL4/Gj
         sM5A==
X-Forwarded-Encrypted: i=1; AJvYcCXxuwE0dmzBF8g76BbbpXsfNeo8Ov57W3AWCXi1i6kgCWX5pAeVtPGY6ZPjZK8slcIFvmkFgwCZx616@vger.kernel.org
X-Gm-Message-State: AOJu0YzyENXWq0vuLTk03pedpslJ/0FXmYzG4xYe+ZVKB6rLByK/SZiN
	bIShyc/Szv6andNS1ZgToxzRk7YNw/jgzeLO7RFYbEH9sliaCtMe1yK0
X-Gm-Gg: AeBDieuGKbsxAYZ+Rn6xI9LLcAERvcJj4h6Ho3cP6SCAhpZr9eA5aPcN0v46ZlZ9/Gl
	52eDtgS8oxOUDyLvEwSCmE2uUSBCqCBWMUTHRBBHvoF6sygmjye0otaAFXpcb9fd1KliCQgqvvB
	a28WRvs4/o8LqiNwspZGkkAhX7So6b2X+EmWdfdiqTuH57RNwdABMfX9n9fFyAMwN2KeSsP6yXy
	7EKs4SZiYdHoNhci3l1iYW0aIeI4OyKLrVlirTdxI4nGaIYcS/IgRz5YSg1Hl+vUEpEnBl2736g
	PEEGfMjCfgsOTYP4lIOfPXPvF8lErip2JbsBN3m20AAhWsRnZ0Tli47OU3D35uyTOxLbGZDnrTh
	4Xei9SJY97bvQmdTVtxcirMyL+fU4Z6zGNq59ymaVlWiiag33T9INR4pO+8xZu2cocpXTz0TBST
	9SL9v070nWioCR2mJTzPRpgfzb7e0YNSEAE18vudXAUyiB3VpIuZpitY7uuGoueeXzfeCJEs5ji
	uwfp5OkPYnOIaOXB1ro2V7fQW4zaMaKyjGGBqszUGzhhzdT5yNtylXse+OnTAw/
X-Received: by 2002:a05:620a:4625:b0:8d0:a4b:e427 with SMTP id af79cd13be357-8ddcfcab061mr1587842785a.57.1776017728508;
        Sun, 12 Apr 2026 11:15:28 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8de94216e90sm530888685a.1.2026.04.12.11.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 11:15:27 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH net] sctp: disable BH before calling udp_tunnel_xmit_skb()
Date: Sun, 12 Apr 2026 14:15:27 -0400
Message-ID: <c874a8548221dcd56ff03c65ba75a74e6cf99119.1776017727.git.lucien.xin@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1174-lists,linux-sctp=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-sctp];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 464983E55C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fixes: 6f1a9140ecda ("add xmit recursion limit to tunnel xmit functions")
Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/ipv6.c     | 2 ++
 net/sctp/protocol.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 53a5c027f8e3..cd15b695607e 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -261,9 +261,11 @@ static int sctp_v6_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
 	label = ip6_make_flowlabel(sock_net(sk), skb, fl6->flowlabel, true, fl6);
 
+	local_bh_disable();
 	udp_tunnel6_xmit_skb(dst, sk, skb, NULL, &fl6->saddr, &fl6->daddr,
 			     tclass, ip6_dst_hoplimit(dst), label,
 			     sctp_sk(sk)->udp_port, t->encap_port, false, 0);
+	local_bh_enable();
 	return 0;
 }
 
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 828a59b8e7bf..5800e7ee7ea0 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1070,10 +1070,12 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
+	local_bh_disable();
 	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false,
 			    0);
+	local_bh_enable();
 	return 0;
 }
 
-- 
2.47.1


