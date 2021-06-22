Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BE3B0C7F
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jun 2021 20:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbhFVSLH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 22 Jun 2021 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhFVSK6 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 22 Jun 2021 14:10:58 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA81C09B05B;
        Tue, 22 Jun 2021 11:05:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g4so40614563qkl.1;
        Tue, 22 Jun 2021 11:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=pbedhP3cBQJxA58L6oWJJvgZEBxcBLhAcD7mieq40a0=;
        b=hhDy+9NpuTxlrsyKEiRtc6Ij91PlbBrtF16AcbwQa9lRGKqUDQ4So+r0qQbOZa/5mS
         664A7Lj+DmWf4xXSeg2l6NFhu1hNXZXPPNE0ezTTgjAR7NYcuG2egBuEfjZYNg2Bnwvj
         rbulxnoFB3T9Daj1trH1exRF8U/gEkcFrBbQLRtx31l8zwPfWTsT/ufJ810AG0C2x++5
         HaFifm+VSIfamO8RF1ek/6pJLps/5bGKTxKC3NbMEhlZ7wvuw/RMeIJXRRmgTdlRv0xa
         /uCdY7QYrdQFbtcyzFNuNPM/Qoal3xK5/W4AMdDj7GpxruGX4v88vb2WW+qWRevr/kf0
         39bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pbedhP3cBQJxA58L6oWJJvgZEBxcBLhAcD7mieq40a0=;
        b=i00FZ1MONC2Cs0FZKK+4oMCFERHDlLAl1HtHiE+Vukr2Jhf3f72IKKzjqTWzzDOfyf
         q1SzfzFxctBVHI/ZcZNaVD6n51OjUEXtZVVbJrtBXKKbuVepZywdhPQkndLcTdZm46B3
         ybPXmEP3R833IBVVD0EJqbisfTeernzoNk77D+5ZEEZC4644C0Gp4ClEMOzc8YyomAmO
         enSTmOHyJ91kSgut+q3zf+kdqEhgJx0g6CN/oY3U47b6oybVQCXm+oaWV/uuDRr7Pchh
         aizIbF9ZeLY1rfpcFnNerdRCayYPNwOrKUdrGCjJ7bQWJOidoxuop/OmJ4VGG+ymMRrM
         YrIw==
X-Gm-Message-State: AOAM530BDyQeII09M43bPAGFLKgjTU7WYb6ao0bS/pQCiIVyMmFdNFHj
        VJdrmM1yoJnLdSozITEn4NnhOeiLS+TnOA==
X-Google-Smtp-Source: ABdhPJyaZjHkiWTQJ6t96I/+fP6fHw6PkX5N7w2WFHk9CXcFa8t0PYyHBQ5o9ltSNWtO6XtAuNF1SA==
X-Received: by 2002:a37:9306:: with SMTP id v6mr5821945qkd.476.1624385107894;
        Tue, 22 Jun 2021 11:05:07 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id h9sm13319232qkj.66.2021.06.22.11.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 11:05:07 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>, davem@davemloft.net,
        kuba@kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Subject: [PATCHv2 net-next 06/14] sctp: do the basic send and recv for PLPMTUD probe
Date:   Tue, 22 Jun 2021 14:04:52 -0400
Message-Id: <0f3a79f220cebb0821efe769fc23df4613423b28.1624384990.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1624384990.git.lucien.xin@gmail.com>
References: <cover.1624384990.git.lucien.xin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This patch does exactly what rfc8899#section-6.2.1.2 says:

   The SCTP sender needs to be able to determine the total size of a
   probe packet.  The HEARTBEAT chunk could carry a Heartbeat
   Information parameter that includes, besides the information
   suggested in [RFC4960], the probe size to help an implementation
   associate a HEARTBEAT ACK with the size of probe that was sent.  The
   sender could also use other methods, such as sending a nonce and
   verifying the information returned also contains the corresponding
   nonce.  The length of the PAD chunk is computed by reducing the
   probing size by the size of the SCTP common header and the HEARTBEAT
   chunk.

Note that HB ACK chunk will carry back whatever HB chunk carried, including
the probe_size we put it in; We also check hbinfo->probe_size in the HB ACK
against link->pl.probe_size to validate this HB ACK chunk.

v1->v2:
  - Remove the unused 'sp' and add static for sctp_packet_bundle_pad().

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 include/net/sctp/sm.h      |  3 ++-
 include/net/sctp/structs.h |  2 ++
 net/sctp/output.c          | 30 +++++++++++++++++++++++++++++-
 net/sctp/outqueue.c        | 13 +++++++++++--
 net/sctp/sm_make_chunk.c   |  5 ++++-
 net/sctp/sm_statefuns.c    | 20 ++++++++++++++++++--
 6 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/include/net/sctp/sm.h b/include/net/sctp/sm.h
index 45542e2bac93..2eb6d7c2c931 100644
--- a/include/net/sctp/sm.h
+++ b/include/net/sctp/sm.h
@@ -226,7 +226,8 @@ struct sctp_chunk *sctp_make_new_encap_port(
 					const struct sctp_association *asoc,
 					const struct sctp_chunk *chunk);
 struct sctp_chunk *sctp_make_heartbeat(const struct sctp_association *asoc,
-				       const struct sctp_transport *transport);
+				       const struct sctp_transport *transport,
+				       __u32 probe_size);
 struct sctp_chunk *sctp_make_heartbeat_ack(const struct sctp_association *asoc,
 					   const struct sctp_chunk *chunk,
 					   const void *payload,
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index a3772f8ee7f6..f7b056f5af37 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -386,6 +386,7 @@ struct sctp_sender_hb_info {
 	union sctp_addr daddr;
 	unsigned long sent_at;
 	__u64 hb_nonce;
+	__u32 probe_size;
 };
 
 int sctp_stream_init(struct sctp_stream *stream, __u16 outcnt, __u16 incnt,
@@ -657,6 +658,7 @@ struct sctp_chunk {
 		data_accepted:1,	/* At least 1 chunk accepted */
 		auth:1,			/* IN: was auth'ed | OUT: needs auth */
 		has_asconf:1,		/* IN: have seen an asconf before */
+		pmtu_probe:1,		/* Used by PLPMTUD, can be set in s HB chunk */
 		tsn_missing_report:2,	/* Data chunk missing counter. */
 		fast_retransmit:2;	/* Is this chunk fast retransmitted? */
 };
diff --git a/net/sctp/output.c b/net/sctp/output.c
index a6aa17df09ef..ceefb0616d9d 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -211,6 +211,30 @@ enum sctp_xmit sctp_packet_transmit_chunk(struct sctp_packet *packet,
 	return retval;
 }
 
+/* Try to bundle a pad chunk into a packet with a heartbeat chunk for PLPMTUTD probe */
+static enum sctp_xmit sctp_packet_bundle_pad(struct sctp_packet *pkt, struct sctp_chunk *chunk)
+{
+	struct sctp_transport *t = pkt->transport;
+	struct sctp_chunk *pad;
+	int overhead = 0;
+
+	if (!chunk->pmtu_probe)
+		return SCTP_XMIT_OK;
+
+	/* calculate the Padding Data size for the pad chunk */
+	overhead += sizeof(struct sctphdr) + sizeof(struct sctp_chunkhdr);
+	overhead += sizeof(struct sctp_sender_hb_info) + sizeof(struct sctp_pad_chunk);
+	pad = sctp_make_pad(t->asoc, t->pl.probe_size - overhead);
+	if (!pad)
+		return SCTP_XMIT_DELAY;
+
+	list_add_tail(&pad->list, &pkt->chunk_list);
+	pkt->size += SCTP_PAD4(ntohs(pad->chunk_hdr->length));
+	chunk->transport = t;
+
+	return SCTP_XMIT_OK;
+}
+
 /* Try to bundle an auth chunk into the packet. */
 static enum sctp_xmit sctp_packet_bundle_auth(struct sctp_packet *pkt,
 					      struct sctp_chunk *chunk)
@@ -382,6 +406,10 @@ enum sctp_xmit sctp_packet_append_chunk(struct sctp_packet *packet,
 		goto finish;
 
 	retval = __sctp_packet_append_chunk(packet, chunk);
+	if (retval != SCTP_XMIT_OK)
+		goto finish;
+
+	retval = sctp_packet_bundle_pad(packet, chunk);
 
 finish:
 	return retval;
@@ -553,7 +581,7 @@ int sctp_packet_transmit(struct sctp_packet *packet, gfp_t gfp)
 	sk = chunk->skb->sk;
 
 	/* check gso */
-	if (packet->size > tp->pathmtu && !packet->ipfragok) {
+	if (packet->size > tp->pathmtu && !packet->ipfragok && !chunk->pmtu_probe) {
 		if (!sk_can_gso(sk)) {
 			pr_err_once("Trying to GSO but underlying device doesn't support it.");
 			goto out;
diff --git a/net/sctp/outqueue.c b/net/sctp/outqueue.c
index 5cb1aa5f067b..ff47091c385e 100644
--- a/net/sctp/outqueue.c
+++ b/net/sctp/outqueue.c
@@ -769,7 +769,11 @@ static int sctp_packet_singleton(struct sctp_transport *transport,
 
 	sctp_packet_init(&singleton, transport, sport, dport);
 	sctp_packet_config(&singleton, vtag, 0);
-	sctp_packet_append_chunk(&singleton, chunk);
+	if (sctp_packet_append_chunk(&singleton, chunk) != SCTP_XMIT_OK) {
+		list_del_init(&chunk->list);
+		sctp_chunk_free(chunk);
+		return -ENOMEM;
+	}
 	return sctp_packet_transmit(&singleton, gfp);
 }
 
@@ -929,8 +933,13 @@ static void sctp_outq_flush_ctrl(struct sctp_flush_ctx *ctx)
 			one_packet = 1;
 			fallthrough;
 
-		case SCTP_CID_SACK:
 		case SCTP_CID_HEARTBEAT:
+			if (chunk->pmtu_probe) {
+				sctp_packet_singleton(ctx->transport, chunk, ctx->gfp);
+				break;
+			}
+			fallthrough;
+		case SCTP_CID_SACK:
 		case SCTP_CID_SHUTDOWN:
 		case SCTP_CID_ECN_ECNE:
 		case SCTP_CID_ASCONF:
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index e5d470cd7c40..b0eaa93a9cc6 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1160,7 +1160,8 @@ struct sctp_chunk *sctp_make_new_encap_port(const struct sctp_association *asoc,
 
 /* Make a HEARTBEAT chunk.  */
 struct sctp_chunk *sctp_make_heartbeat(const struct sctp_association *asoc,
-				       const struct sctp_transport *transport)
+				       const struct sctp_transport *transport,
+				       __u32 probe_size)
 {
 	struct sctp_sender_hb_info hbinfo;
 	struct sctp_chunk *retval;
@@ -1176,6 +1177,7 @@ struct sctp_chunk *sctp_make_heartbeat(const struct sctp_association *asoc,
 	hbinfo.daddr = transport->ipaddr;
 	hbinfo.sent_at = jiffies;
 	hbinfo.hb_nonce = transport->hb_nonce;
+	hbinfo.probe_size = probe_size;
 
 	/* Cast away the 'const', as this is just telling the chunk
 	 * what transport it belongs to.
@@ -1183,6 +1185,7 @@ struct sctp_chunk *sctp_make_heartbeat(const struct sctp_association *asoc,
 	retval->transport = (struct sctp_transport *) transport;
 	retval->subh.hbs_hdr = sctp_addto_chunk(retval, sizeof(hbinfo),
 						&hbinfo);
+	retval->pmtu_probe = !!probe_size;
 
 nodata:
 	return retval;
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 3b99eda50618..8edb9186112a 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -1004,7 +1004,7 @@ static enum sctp_disposition sctp_sf_heartbeat(
 	struct sctp_chunk *reply;
 
 	/* Send a heartbeat to our peer.  */
-	reply = sctp_make_heartbeat(asoc, transport);
+	reply = sctp_make_heartbeat(asoc, transport, 0);
 	if (!reply)
 		return SCTP_DISPOSITION_NOMEM;
 
@@ -1104,8 +1104,15 @@ enum sctp_disposition sctp_sf_send_probe(struct net *net,
 					 struct sctp_cmd_seq *commands)
 {
 	struct sctp_transport *transport = (struct sctp_transport *)arg;
+	struct sctp_chunk *reply;
+
+	if (!sctp_transport_pl_enabled(transport))
+		return SCTP_DISPOSITION_CONSUME;
 
-	/* The actual handling will be performed here in a later patch. */
+	reply = sctp_make_heartbeat(asoc, transport, transport->pl.probe_size);
+	if (!reply)
+		return SCTP_DISPOSITION_NOMEM;
+	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(reply));
 	sctp_add_cmd_sf(commands, SCTP_CMD_PROBE_TIMER_UPDATE,
 			SCTP_TRANSPORT(transport));
 
@@ -1260,6 +1267,15 @@ enum sctp_disposition sctp_sf_backbeat_8_3(struct net *net,
 	if (hbinfo->hb_nonce != link->hb_nonce)
 		return SCTP_DISPOSITION_DISCARD;
 
+	if (hbinfo->probe_size) {
+		if (hbinfo->probe_size != link->pl.probe_size ||
+		    !sctp_transport_pl_enabled(link))
+			return SCTP_DISPOSITION_DISCARD;
+
+		/* The actual handling will be performed here in a later patch. */
+		return SCTP_DISPOSITION_CONSUME;
+	}
+
 	max_interval = link->hbinterval + link->rto;
 
 	/* Check if the timestamp looks valid.  */
-- 
2.27.0

