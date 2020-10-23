Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A78297872
	for <lists+linux-sctp@lfdr.de>; Fri, 23 Oct 2020 22:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756413AbgJWUw3 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 23 Oct 2020 16:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55369 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756412AbgJWUw2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 23 Oct 2020 16:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603486347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BkkVwPtn1DQdSlrc077BWPrlkRKWINT920vgmPR1Boo=;
        b=C5oUi8q1OrV9+hE5/K/MW3iPdfVCB28SvoWWpH7XtIf5lZnY4sCDWFNtBTN+sffk6zre6Z
        IcVX8KOGKmPNnT2o7ec3sF8mr+WIdkTnz/KbbOracfzT+dkA+wStsPd+CdlYzTeEAXPeXM
        1Sn8JB/6s90dGFa4+1FEw0fiIdgMOpw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-FUIcEZqGNQONvMFFJezMcw-1; Fri, 23 Oct 2020 16:52:25 -0400
X-MC-Unique: FUIcEZqGNQONvMFFJezMcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DA931009E2D;
        Fri, 23 Oct 2020 20:52:24 +0000 (UTC)
Received: from new-host-6.station (unknown [10.40.192.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C954719C66;
        Fri, 23 Oct 2020 20:52:22 +0000 (UTC)
From:   Davide Caratti <dcaratti@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH net-next] net: use a dedicated tracepoint for kfree_skb_list()
Date:   Fri, 23 Oct 2020 22:52:14 +0200
Message-Id: <d4c179f46d00016ec418f6bf58ed01afedacd123.1603486318.git.dcaratti@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

kfree_skb_list() calls kfree_skb(), thus triggering as many dropwatch
events as the number of skbs in the list. This can disturb the analysis
of packet drops, e.g. with fragmented echo requests generated by ICMP
sockets, or with regular SCTP packets: when consume_skb() frees them,
the kernel's drop monitor may wrongly account for several packet drops:

 consume skb()
   skb_release_data()
     kfree_skb_list()
       kfree_skb() <-- false dropwatch event

don't call kfree_skb() when freeing a skb list, use a dedicated
tracepoint instead. By printing "cur" and "next", it also becomes
possible to reconstruct the skb list from its members.

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/trace/events/skb.h | 19 +++++++++++++++++++
 net/core/skbuff.c          |  6 +++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index 9e92f22eb086..b16e3544bbbe 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -51,6 +51,25 @@ TRACE_EVENT(consume_skb,
 	TP_printk("skbaddr=%p", __entry->skbaddr)
 );
 
+TRACE_EVENT(kfree_skb_list,
+
+	TP_PROTO(struct sk_buff *cur, struct sk_buff *next),
+
+	TP_ARGS(cur, next),
+
+	TP_STRUCT__entry(
+		__field(	void *,	cur_addr	)
+		__field(	void *,	next_addr	)
+	),
+
+	TP_fast_assign(
+		__entry->cur_addr = cur;
+		__entry->next_addr = next;
+	),
+
+	TP_printk("cur=%p next=%p", __entry->cur_addr, __entry->next_addr)
+);
+
 TRACE_EVENT(skb_copy_datagram_iovec,
 
 	TP_PROTO(const struct sk_buff *skb, int len),
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 1ba8f0163744..7ed6bfc5dfd0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -702,7 +702,11 @@ void kfree_skb_list(struct sk_buff *segs)
 	while (segs) {
 		struct sk_buff *next = segs->next;
 
-		kfree_skb(segs);
+		if (!skb_unref(segs))
+			continue;
+
+		trace_kfree_skb_list(segs, next);
+		__kfree_skb(segs);
 		segs = next;
 	}
 }
-- 
2.26.2

