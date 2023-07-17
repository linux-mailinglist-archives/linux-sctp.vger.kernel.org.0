Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3513F75658B
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Jul 2023 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjGQNye (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 17 Jul 2023 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjGQNya (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 17 Jul 2023 09:54:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41CDF9
        for <linux-sctp@vger.kernel.org>; Mon, 17 Jul 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689602026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FaL2wcUnzSu1vhXihNYR8wHXoQel/dQpHY6Vim2NOYE=;
        b=Hl90kVHwC7Yk4YJoE2uu0Tr/HPpQGHjKjrKCdJs5gice2pOPBWXyl5Fc+AP8VEjuVjwXf/
        nI7aI5WSt1HDEJkxv7et0H9EbrcOEzVMUCflrPC1Is81eZZdiF3ycP1oOyYgWYp5Q2F0U8
        865mHi/p0u0Pci/kpkg5oqlR04DDb2o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-emQTzv5fMKePfGiYR6jviw-1; Mon, 17 Jul 2023 09:53:46 -0400
X-MC-Unique: emQTzv5fMKePfGiYR6jviw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-765986c0568so693108085a.1
        for <linux-sctp@vger.kernel.org>; Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689602025; x=1692194025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaL2wcUnzSu1vhXihNYR8wHXoQel/dQpHY6Vim2NOYE=;
        b=gvBOmS5yVryhY7hCNuX5NCRH61tEW04WOlgDKLbkCq9aWuZ9AM3M7K5xXiX5xw9QiT
         07RYRGk7pRRlMsgepGvn7UcPeLTtkOgYAflRrx9+v0tEUARTqA8p1HQ3s+e6ZLTMWcem
         JQ7gH8WHvVozX2IWJN5K/cwAMRo+GsMIyg/gSiSD+snYC7BVPqyCmOsXCrvWSGh4jYp6
         ia1egjq1BeQ5l1KXYlB8IkNGIE+8KcKuA1gwESxcsfSI/UA2p6GEMs72/m8QgiSmq0BD
         1YpCyKs/Khw9ll6EQ+iHHhgya+co+vzw0Ms5450E/ADetA+enp0xdOwHz3ThlBdqN/ov
         2lbQ==
X-Gm-Message-State: ABy/qLbBs9PnHGrSgynf3CnEUiWcDNrOEymROG1WJXFK796Icmu979Dv
        /3lYgjImvdB0WDpvALIOyhM0WsNL0xhM90SflHwYfvRjqbrWPk6eWypo0zRhF2yNo+jxJotSqUn
        xWc4sr99U+6OjdXSSdYp6yA==
X-Received: by 2002:a05:620a:1a90:b0:768:1e31:db83 with SMTP id bl16-20020a05620a1a9000b007681e31db83mr4067791qkb.17.1689602025550;
        Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGweCsSR9gCfZzTn6i1Ji1R15Px6FwQk49TxS1l0nFmF1AM1O1d+wX5CSPTKaBcC3vqMulNxg==
X-Received: by 2002:a05:620a:1a90:b0:768:1e31:db83 with SMTP id bl16-20020a05620a1a9000b007681e31db83mr4067777qkb.17.1689602025324;
        Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id pe20-20020a05620a851400b00767502e8601sm6134375qkn.35.2023.07.17.06.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:53:45 -0700 (PDT)
Date:   Mon, 17 Jul 2023 15:53:40 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     netdev@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org
Subject: [PATCH net-next 3/3] sctp: Set TOS and routing scope independently
 for fib lookups.
Message-ID: <8ecb4d62fea0ba72bc8a5525d097b36a6c6d0b32.1689600901.git.gnault@redhat.com>
References: <cover.1689600901.git.gnault@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cover.1689600901.git.gnault@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

There's no reason for setting the RTO_ONLINK flag in ->flowi4_tos as
RT_CONN_FLAGS() does. We can easily set ->flowi4_scope properly
instead. This makes the code more explicit and will allow to convert
->flowi4_tos to dscp_t in the future.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/sctp/protocol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 274d07bd774f..33c0895e101c 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -435,7 +435,8 @@ static void sctp_v4_get_dst(struct sctp_transport *t, union sctp_addr *saddr,
 	fl4->fl4_dport = daddr->v4.sin_port;
 	fl4->flowi4_proto = IPPROTO_SCTP;
 	if (asoc) {
-		fl4->flowi4_tos = RT_CONN_FLAGS_TOS(asoc->base.sk, tos);
+		fl4->flowi4_tos = RT_TOS(tos);
+		fl4->flowi4_scope = ip_sock_rt_scope(asoc->base.sk);
 		fl4->flowi4_oif = asoc->base.sk->sk_bound_dev_if;
 		fl4->fl4_sport = htons(asoc->base.bind_addr.port);
 	}
-- 
2.39.2

