Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C36CF26F134
	for <lists+linux-sctp@lfdr.de>; Fri, 18 Sep 2020 04:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgIRCJB (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Sep 2020 22:09:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgIRCJA (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 17 Sep 2020 22:09:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58E562389E;
        Fri, 18 Sep 2020 02:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394939;
        bh=1S77m4row9Ck+TBXx2z25Pwb64xZDCNkJSlX5PfCtF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b54frm6rigxi28dU+rKEl+uD59iPOg/gn8qVMEsNymRG/dy8EefTne35Gr8C3dw4U
         MjYrvjY/TL+ldGdFeRSu0JTNcn6d6hYPT9+Isxtb8nBKI0UVc80F0HvhtOCNOYfRez
         QM7r9mzpLS9/THgnjNoSKKHRYMoxWBvAE1E1D+Nk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kevin Kou <qdkevin.kou@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 048/206] sctp: move trace_sctp_probe_path into sctp_outq_sack
Date:   Thu, 17 Sep 2020 22:05:24 -0400
Message-Id: <20200918020802.2065198-48-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Kevin Kou <qdkevin.kou@gmail.com>

[ Upstream commit f643ee295c1c63bc117fb052d4da681354d6f732 ]

The original patch bringed in the "SCTP ACK tracking trace event"
feature was committed at Dec.20, 2017, it replaced jprobe usage
with trace events, and bringed in two trace events, one is
TRACE_EVENT(sctp_probe), another one is TRACE_EVENT(sctp_probe_path).
The original patch intended to trigger the trace_sctp_probe_path in
TRACE_EVENT(sctp_probe) as below code,

+TRACE_EVENT(sctp_probe,
+
+	TP_PROTO(const struct sctp_endpoint *ep,
+		 const struct sctp_association *asoc,
+		 struct sctp_chunk *chunk),
+
+	TP_ARGS(ep, asoc, chunk),
+
+	TP_STRUCT__entry(
+		__field(__u64, asoc)
+		__field(__u32, mark)
+		__field(__u16, bind_port)
+		__field(__u16, peer_port)
+		__field(__u32, pathmtu)
+		__field(__u32, rwnd)
+		__field(__u16, unack_data)
+	),
+
+	TP_fast_assign(
+		struct sk_buff *skb = chunk->skb;
+
+		__entry->asoc = (unsigned long)asoc;
+		__entry->mark = skb->mark;
+		__entry->bind_port = ep->base.bind_addr.port;
+		__entry->peer_port = asoc->peer.port;
+		__entry->pathmtu = asoc->pathmtu;
+		__entry->rwnd = asoc->peer.rwnd;
+		__entry->unack_data = asoc->unack_data;
+
+		if (trace_sctp_probe_path_enabled()) {
+			struct sctp_transport *sp;
+
+			list_for_each_entry(sp, &asoc->peer.transport_addr_list,
+					    transports) {
+				trace_sctp_probe_path(sp, asoc);
+			}
+		}
+	),

But I found it did not work when I did testing, and trace_sctp_probe_path
had no output, I finally found that there is trace buffer lock
operation(trace_event_buffer_reserve) in include/trace/trace_events.h:

static notrace void							\
trace_event_raw_event_##call(void *__data, proto)			\
{									\
	struct trace_event_file *trace_file = __data;			\
	struct trace_event_data_offsets_##call __maybe_unused __data_offsets;\
	struct trace_event_buffer fbuffer;				\
	struct trace_event_raw_##call *entry;				\
	int __data_size;						\
									\
	if (trace_trigger_soft_disabled(trace_file))			\
		return;							\
									\
	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
									\
	entry = trace_event_buffer_reserve(&fbuffer, trace_file,	\
				 sizeof(*entry) + __data_size);		\
									\
	if (!entry)							\
		return;							\
									\
	tstruct								\
									\
	{ assign; }							\
									\
	trace_event_buffer_commit(&fbuffer);				\
}

The reason caused no output of trace_sctp_probe_path is that
trace_sctp_probe_path written in TP_fast_assign part of
TRACE_EVENT(sctp_probe), and it will be placed( { assign; } ) after the
trace_event_buffer_reserve() when compiler expands Macro,

        entry = trace_event_buffer_reserve(&fbuffer, trace_file,        \
                                 sizeof(*entry) + __data_size);         \
                                                                        \
        if (!entry)                                                     \
                return;                                                 \
                                                                        \
        tstruct                                                         \
                                                                        \
        { assign; }                                                     \

so trace_sctp_probe_path finally can not acquire trace_event_buffer
and return no output, that is to say the nest of tracepoint entry function
is not allowed. The function call flow is:

trace_sctp_probe()
-> trace_event_raw_event_sctp_probe()
 -> lock buffer
 -> trace_sctp_probe_path()
   -> trace_event_raw_event_sctp_probe_path()  --nested
   -> buffer has been locked and return no output.

This patch is to remove trace_sctp_probe_path from the TP_fast_assign
part of TRACE_EVENT(sctp_probe) to avoid the nest of entry function,
and trigger sctp_probe_path_trace in sctp_outq_sack.

After this patch, you can enable both events individually,
  # cd /sys/kernel/debug/tracing
  # echo 1 > events/sctp/sctp_probe/enable
  # echo 1 > events/sctp/sctp_probe_path/enable

Or, you can enable all the events under sctp.

  # echo 1 > events/sctp/enable

Signed-off-by: Kevin Kou <qdkevin.kou@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/sctp.h | 9 ---------
 net/sctp/outqueue.c         | 6 ++++++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/sctp.h b/include/trace/events/sctp.h
index 7475c7be165aa..d4aac34365955 100644
--- a/include/trace/events/sctp.h
+++ b/include/trace/events/sctp.h
@@ -75,15 +75,6 @@ TRACE_EVENT(sctp_probe,
 		__entry->pathmtu = asoc->pathmtu;
 		__entry->rwnd = asoc->peer.rwnd;
 		__entry->unack_data = asoc->unack_data;
-
-		if (trace_sctp_probe_path_enabled()) {
-			struct sctp_transport *sp;
-
-			list_for_each_entry(sp, &asoc->peer.transport_addr_list,
-					    transports) {
-				trace_sctp_probe_path(sp, asoc);
-			}
-		}
 	),
 
 	TP_printk("asoc=%#llx mark=%#x bind_port=%d peer_port=%d pathmtu=%d "
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index 7bb8e5603298d..d6e83a37a1adf 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -51,6 +51,7 @@
 #include <net/sctp/sctp.h>
 #include <net/sctp/sm.h>
 #include <net/sctp/stream_sched.h>
+#include <trace/events/sctp.h>
 
 /* Declare internal functions here.  */
 static int sctp_acked(struct sctp_sackhdr *sack, __u32 tsn);
@@ -1257,6 +1258,11 @@ int sctp_outq_sack(struct sctp_outq *q, struct sctp_chunk *chunk)
 	/* Grab the association's destination address list. */
 	transport_list = &asoc->peer.transport_addr_list;
 
+	/* SCTP path tracepoint for congestion control debugging. */
+	list_for_each_entry(transport, transport_list, transports) {
+		trace_sctp_probe_path(transport, asoc);
+	}
+
 	sack_ctsn = ntohl(sack->cum_tsn_ack);
 	gap_ack_blocks = ntohs(sack->num_gap_ack_blocks);
 	asoc->stats.gapcnt += gap_ack_blocks;
-- 
2.25.1

