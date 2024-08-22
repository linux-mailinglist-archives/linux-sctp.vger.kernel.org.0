Return-Path: <linux-sctp+bounces-204-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8776195B5BB
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 14:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7359B240B9
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Aug 2024 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB37E1C9EC2;
	Thu, 22 Aug 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sWXn8p7I"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAB41C9DED;
	Thu, 22 Aug 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331507; cv=none; b=vAO9MSzrFhGgtOy9U7Zp05GxhDLZxH2UuBQhYvPX+q6EFXTnybR/AmIcdVZkNQIa82XgoO+3ofGyDsuVZ9W3Kadc09EzYyUksdWu1rNPhZDfD+di2LbW6lSxnSypxYzLYrvck9LANFSp2c/rPpdf+lIPmhBCnRkFZt+f/Wr1Vf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331507; c=relaxed/simple;
	bh=kZ/PsmLBGx4oLQb2HsOSwDrGbJh1eBk6BO9es46bP8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qIdQwGh26pdLnDkYxBJynMM6OAZD4w4fPh5ulIYa6+2CbaKvy2rtKQEiNYiLuYqweK+s9QFbD1OMAGBkcb0nF2S8GODuWdk7+CzF/TuJPxaBJepin4uWv+17ev+i+tCAR6+Avf6l/vk3NreSquz0QTKhPfUmsehnvMWSdx/YfMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sWXn8p7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188B9C4AF0C;
	Thu, 22 Aug 2024 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724331507;
	bh=kZ/PsmLBGx4oLQb2HsOSwDrGbJh1eBk6BO9es46bP8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sWXn8p7I6D62t20NpFeuvQ+MWdGjCKNIxWUYfQWuEfKQ7bPauBgRNNmdsyYQSimyf
	 VSjmMyPig/FE1Et/uw1cCOZ6YUBYv1181/4bfzr38xQaSV5+m1sNFrg/qXKC49KJsg
	 8tANB7V4+yeSYY64xwhK86jk0YD3tvJV2EQD4w3tJIJUiap1CDMqZw+rkyBXu/iNjy
	 69jR8Obok49edwEy7RHoIcjTaOniGeWElrAHi/qoVN4+9f6FgM4Tn48hTjgCIYFv5f
	 ykqPcXWzhYdHCC4PPkFM6Yzefw5J8ue3JwwjipNo3Lov+ZYUNte10aSJMSBjlK+hHj
	 eg+wvNSdUWC7w==
From: Simon Horman <horms@kernel.org>
Date: Thu, 22 Aug 2024 13:57:31 +0100
Subject: [PATCH net-next 10/13] sctp: Correct spelling in headers
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240822-net-spell-v1-10-3a98971ce2d2@kernel.org>
References: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
In-Reply-To: <20240822-net-spell-v1-0-3a98971ce2d2@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandra Winter <wintera@linux.ibm.com>, 
 Thorsten Winkler <twinkler@linux.ibm.com>, David Ahern <dsahern@kernel.org>, 
 Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
 Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>, 
 Sean Tranchetti <quic_stranche@quicinc.com>, 
 Paul Moore <paul@paul-moore.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-x25@vger.kernel.org
X-Mailer: b4 0.14.0

Correct spelling in sctp.h and structs.h.
As reported by codespell.

Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
Cc: linux-sctp@vger.kernel.org
Signed-off-by: Simon Horman <horms@kernel.org>
---
 include/net/sctp/sctp.h    |  2 +-
 include/net/sctp/structs.h | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index a2310fa995f6..84e6b9fd5610 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -28,7 +28,7 @@
 #define __net_sctp_h__
 
 /* Header Strategy.
- *    Start getting some control over the header file depencies:
+ *    Start getting some control over the header file dependencies:
  *       includes
  *       constants
  *       structs
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index f24a1bbcb3ef..31248cfdfb23 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -521,7 +521,7 @@ struct sctp_datamsg {
 	refcount_t refcnt;
 	/* When is this message no longer interesting to the peer? */
 	unsigned long expires_at;
-	/* Did the messenge fail to send? */
+	/* Did the message fail to send? */
 	int send_error;
 	u8 send_failed:1,
 	   can_delay:1,	/* should this message be Nagle delayed */
@@ -792,7 +792,7 @@ struct sctp_transport {
 		 */
 		hb_sent:1,
 
-		/* Is the Path MTU update pending on this tranport */
+		/* Is the Path MTU update pending on this transport */
 		pmtu_pending:1,
 
 		dst_pending_confirm:1,	/* need to confirm neighbour */
@@ -1223,7 +1223,7 @@ enum sctp_endpoint_type {
 };
 
 /*
- * A common base class to bridge the implmentation view of a
+ * A common base class to bridge the implementation view of a
  * socket (usually listening) endpoint versus an association's
  * local endpoint.
  * This common structure is useful for several purposes:
@@ -1353,7 +1353,7 @@ struct sctp_endpoint {
 	struct rcu_head rcu;
 };
 
-/* Recover the outter endpoint structure. */
+/* Recover the outer endpoint structure. */
 static inline struct sctp_endpoint *sctp_ep(struct sctp_ep_common *base)
 {
 	struct sctp_endpoint *ep;
@@ -1906,7 +1906,7 @@ struct sctp_association {
 	__u32 rwnd_over;
 
 	/* Keeps treack of rwnd pressure.  This happens when we have
-	 * a window, but not recevie buffer (i.e small packets).  This one
+	 * a window, but not receive buffer (i.e small packets).  This one
 	 * is releases slowly (1 PMTU at a time ).
 	 */
 	__u32 rwnd_press;
@@ -1994,7 +1994,7 @@ struct sctp_association {
 
 	/* ADDIP Section 5.2 Upon reception of an ASCONF Chunk.
 	 *
-	 * This is needed to implement itmes E1 - E4 of the updated
+	 * This is needed to implement items E1 - E4 of the updated
 	 * spec.  Here is the justification:
 	 *
 	 * Since the peer may bundle multiple ASCONF chunks toward us,
@@ -2005,7 +2005,7 @@ struct sctp_association {
 
 	/* These ASCONF chunks are waiting to be sent.
 	 *
-	 * These chunaks can't be pushed to outqueue until receiving
+	 * These chunks can't be pushed to outqueue until receiving
 	 * ASCONF_ACK for the previous ASCONF indicated by
 	 * addip_last_asconf, so as to guarantee that only one ASCONF
 	 * is in flight at any time.
@@ -2059,13 +2059,13 @@ struct sctp_association {
 	struct sctp_transport *new_transport;
 
 	/* SCTP AUTH: list of the endpoint shared keys.  These
-	 * keys are provided out of band by the user applicaton
+	 * keys are provided out of band by the user application
 	 * and can't change during the lifetime of the association
 	 */
 	struct list_head endpoint_shared_keys;
 
 	/* SCTP AUTH:
-	 * The current generated assocaition shared key (secret)
+	 * The current generated association shared key (secret)
 	 */
 	struct sctp_auth_bytes *asoc_shared_key;
 	struct sctp_shared_key *shkey;
@@ -2121,7 +2121,7 @@ enum {
 	SCTP_ASSOC_EYECATCHER = 0xa550c123,
 };
 
-/* Recover the outter association structure. */
+/* Recover the outer association structure. */
 static inline struct sctp_association *sctp_assoc(struct sctp_ep_common *base)
 {
 	struct sctp_association *asoc;

-- 
2.43.0


