Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302A07529D8
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Jul 2023 19:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbjGMR2d (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 13 Jul 2023 13:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjGMR2W (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 13 Jul 2023 13:28:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7932D50
        for <linux-sctp@vger.kernel.org>; Thu, 13 Jul 2023 10:28:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7659db6339eso43005085a.1
        for <linux-sctp@vger.kernel.org>; Thu, 13 Jul 2023 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689269283; x=1691861283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8HL7CUl8Nl4Ioty23RUOK+NanZNksrYlNe7u93OccY=;
        b=IgmWTLtWvzxwXmXKucGTWvHEQBwX4I+ktgmiKb5RlTIuEAiLZLITR0bjYejAFKSH3I
         ZAot26yTteCpMKtiRr65TyvjIDaOxA5L+5hQvVlBFMyuJ4l+Pi3Uvcu0H4luOKn/aAV1
         gWZuHm84uvEENnxo0XK6Fnz+Pd/curjNjIggs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689269283; x=1691861283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8HL7CUl8Nl4Ioty23RUOK+NanZNksrYlNe7u93OccY=;
        b=RatMjVc60Z/6lATjmjY13yzVk/wSj8J74Vn/luSiu+ftRtTIhKquqr+rrXY9dDusZY
         stYNzAPBftnrBCrRodNozKAltIcCg9IPpQof8j7ava3PU549whJ6d8zKwUp673UttBxW
         7kzpcMw0LLYqHopTzM5LE8ewXms9fn2+GEXp5iKm2XWNMOhXCGlRUm/SrmtktJ2dBlvE
         0IOcnLl065hcJvKBLtdXVc9/QdU//sHfziRK+If1w3mmHXB/hk3E6CRwmyPiyrDg0qLV
         OLWo+6e+6e6TJ2nAAa8ev0RO8+RhxzLbCtx9l9busDA+Fdci8HzWEHd1jcXI3o8Uns7m
         W/WQ==
X-Gm-Message-State: ABy/qLa40M3MVdvcUnWNKWADooMsVnP/b2XIo3NKrMBXoCFNgHJEtFtE
        qZgawIuGf4gA/xxpvjor7FTFdkSn0e6NcaIqvUwMQQ==
X-Google-Smtp-Source: APBJJlGCb+ocFoI0/71J3QpD/JyGRpP6aexUWwJuxeqih+WcGwDRhK6UP2v/FHPvUWAdtd5K/UOJbA==
X-Received: by 2002:a05:620a:4455:b0:765:5ba6:a5c0 with SMTP id w21-20020a05620a445500b007655ba6a5c0mr429843qkp.14.1689269283055;
        Thu, 13 Jul 2023 10:28:03 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e10-20020a05620a12ca00b007592f2016f4sm3040949qkl.110.2023.07.13.10.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:28:02 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:28:00 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>
Cc:     kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Melnychenko <andrew@daynix.com>,
        Jason Wang <jasowang@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Subject: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
Message-ID: <ZLA0ILTAZsIzxR6c@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
packets.") checks DODGY bit for UDP, but for packets that can be fed
directly to the device after gso_segs reset, it actually falls through
to fragmentation:

https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28KzYDg+A@mail.gmail.com/

This change restores the expected behavior of GSO_UDP_L4 packets.

Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packets.")
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Signed-off-by: Yan Zhai <yan@cloudflare.com>

---
v2: dropped modifications to tcp/sctp on DODGY bit removal after
validating gso_segs. Also moved the UDP header check into
__udp_gso_segment (per Willem's suggestion).

---
 net/ipv4/udp_offload.c | 16 +++++++++++-----
 net/ipv6/udp_offload.c |  3 +--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 75aa4de5b731..f402946da344 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -274,13 +274,20 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	__sum16 check;
 	__be16 newlen;
 
-	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
-		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
-
 	mss = skb_shinfo(gso_skb)->gso_size;
 	if (gso_skb->len <= sizeof(*uh) + mss)
 		return ERR_PTR(-EINVAL);
 
+	if (skb_gso_ok(gso_skb, features | NETIF_F_GSO_ROBUST)) {
+		/* Packet is from an untrusted source, reset gso_segs. */
+		skb_shinfo(gso_skb)->gso_segs = DIV_ROUND_UP(gso_skb->len - sizeof(*uh),
+							     mss);
+		return NULL;
+	}
+
+	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST)
+		return __udp_gso_segment_list(gso_skb, features, is_ipv6);
+
 	skb_pull(gso_skb, sizeof(*uh));
 
 	/* clear destructor to avoid skb_segment assigning it to tail */
@@ -388,8 +395,7 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 		goto out;
 
-	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-	    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 		return __udp_gso_segment(skb, features, false);
 
 	mss = skb_shinfo(skb)->gso_size;
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index ad3b8726873e..09fa7a42cb93 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -43,8 +43,7 @@ static struct sk_buff *udp6_ufo_fragment(struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct udphdr)))
 			goto out;
 
-		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4 &&
-		    !skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST))
+		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4)
 			return __udp_gso_segment(skb, features, true);
 
 		mss = skb_shinfo(skb)->gso_size;
-- 
2.30.2

