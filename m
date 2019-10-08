Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29977CF80E
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Oct 2019 13:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfJHLZf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Oct 2019 07:25:35 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:32807 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730051AbfJHLZf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 8 Oct 2019 07:25:35 -0400
Received: by mail-pf1-f181.google.com with SMTP id q10so10638451pfl.0;
        Tue, 08 Oct 2019 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=x9q3nPi8+YLsdfxqg4W+WXiCAIrozURlODs8ReffbJE=;
        b=oePMwl3rwpLNTnV3EB1UPbqB9q3oTclLrr3yffW98bgW5rZob92pMj980UPfka7DaA
         Ef0o2vImwGbG5ROrQ/XdI9QTsd47yBidthxazDIoOv7XAcELlZqbFCqqwmU8M8YxpEEL
         goR2xz9R+m2jaN+/szD+4+ATmrp8sAsFncoPDuZqJXb989kklD9wmVQw6Br8PBke7wMi
         Uvh8Pbktw1oe6lSMKVmlrf0oxoeA9niIIMC29yyCC9AB3S1rme+QpAc7ve+0hZpK94nj
         DcSVqa4V8L1BeKOdaml0LkWLtgWe+XRHgTH41/N/1cFvs1stNC3aabdR7lcNtttsjyUH
         Mzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=x9q3nPi8+YLsdfxqg4W+WXiCAIrozURlODs8ReffbJE=;
        b=GFWkuYIOdB3n3IFBs5znNoRIlzY8kQzmTHvP7Vnj+1Su+huRGJEMZ00SIRCLte6/IP
         PApM4o6xWeJUCZs21xZIz6/Jr4kWw08ELssDVAOnYBU+puEAC/bmKrpj0Uu+b0jmIdHl
         kyeRMgH9c51glINnr2A4ILe+llSCgVocNd8hnnsUjULD+JyTKWkfNEdi71gsAt8Sh8uo
         76KWq4KCEqw29pkU8flQU0URqN90vJJEMYQXYxKB9us90KiohD61LlCXjcuhsZyEBjcR
         M+YdnXPun0aimQa+m5GdMULOs0os4PQ8XLyqZn1Wt+fG4WsMo+nbSkjphBFzOpwxmee0
         jwrA==
X-Gm-Message-State: APjAAAUxAv2deNg5bNvzJqwQ/hi0SqrmobJ2BVRGQoJIUWg+MlXsjjuD
        9nnadlFWPqWbIOTzXkQxa6FC4hUI
X-Google-Smtp-Source: APXvYqwtlCCqf9WVHHvLzqCfDXA0+pkg6eYgn2yc9eikUTbRYlwBHhJfkCzB5V0q3H0D0Mj2E2AWgw==
X-Received: by 2002:a63:1d0:: with SMTP id 199mr36677640pgb.329.1570533932408;
        Tue, 08 Oct 2019 04:25:32 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q204sm20215445pfc.11.2019.10.08.04.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Oct 2019 04:25:31 -0700 (PDT)
From:   Xin Long <lucien.xin@gmail.com>
To:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, davem@davemloft.net
Subject: [PATCHv2 net-next 2/5] sctp: add pf_expose per netns and sock and asoc
Date:   Tue,  8 Oct 2019 19:25:04 +0800
Message-Id: <8fcf707443f7218d3fb131b827c679f423c5ecaf.1570533716.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <bca4cbf1bee8ad2379b2fe9536b3404fc0935579.1570533716.git.lucien.xin@gmail.com>
References: <cover.1570533716.git.lucien.xin@gmail.com>
 <bca4cbf1bee8ad2379b2fe9536b3404fc0935579.1570533716.git.lucien.xin@gmail.com>
In-Reply-To: <cover.1570533716.git.lucien.xin@gmail.com>
References: <cover.1570533716.git.lucien.xin@gmail.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

As said in rfc7829, section 3, point 12:

  The SCTP stack SHOULD expose the PF state of its destination
  addresses to the ULP as well as provide the means to notify the
  ULP of state transitions of its destination addresses from
  active to PF, and vice versa.  However, it is recommended that
  an SCTP stack implementing SCTP-PF also allows for the ULP to be
  kept ignorant of the PF state of its destinations and the
  associated state transitions, thus allowing for retention of the
  simpler state transition model of [RFC4960] in the ULP.

Not only does it allow to expose the PF state to ULP, but also
allow to ignore sctp-pf to ULP.

So this patch is to add pf_expose per netns, sock and asoc. And in
sctp_assoc_control_transport(), ulp_notify will be set to false if
asoc->expose is not set.

It also allows a user to change pf_expose per netns by sysctl, and
pf_expose per sock and asoc will be initialized with it.

Note that pf_expose also works for SCTP_GET_PEER_ADDR_INFO sockopt,
to not allow a user to query the state of a sctp-pf peer address
when pf_expose is not enabled, as said in section 7.3.

v1->v2:
  - Fix a build warning noticed by Nathan Chancellor.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 include/net/netns/sctp.h   |  7 +++++++
 include/net/sctp/structs.h |  2 ++
 include/uapi/linux/sctp.h  |  1 +
 net/sctp/associola.c       |  8 +++++++-
 net/sctp/protocol.c        |  3 +++
 net/sctp/socket.c          | 12 ++++++++++--
 net/sctp/sysctl.c          |  7 +++++++
 7 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/include/net/netns/sctp.h b/include/net/netns/sctp.h
index bdc0f27..5234940c 100644
--- a/include/net/netns/sctp.h
+++ b/include/net/netns/sctp.h
@@ -97,6 +97,13 @@ struct netns_sctp {
 	int pf_enable;
 
 	/*
+	 * Disable Potentially-Failed state exposure, enabled by default
+	 * pf_expose	-  0  : disable pf state exposure
+	 *		- >0  : enable  pf state exposure
+	 */
+	int pf_expose;
+
+	/*
 	 * Policy for preforming sctp/socket accounting
 	 * 0   - do socket level accounting, all assocs share sk_sndbuf
 	 * 1   - do sctp accounting, each asoc may use sk_sndbuf bytes
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 503fbc3..c2d3317 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -215,6 +215,7 @@ struct sctp_sock {
 	__u32 adaptation_ind;
 	__u32 pd_point;
 	__u16	nodelay:1,
+		pf_expose:1,
 		reuse:1,
 		disable_fragments:1,
 		v4mapped:1,
@@ -2053,6 +2054,7 @@ struct sctp_association {
 
 	__u8 need_ecne:1,	/* Need to send an ECNE Chunk? */
 	     temp:1,		/* Is it a temporary association? */
+	     pf_expose:1,       /* Expose pf state? */
 	     force_delay:1;
 
 	__u8 strreset_enable;
diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
index 45a85d7..b6649d6 100644
--- a/include/uapi/linux/sctp.h
+++ b/include/uapi/linux/sctp.h
@@ -920,6 +920,7 @@ struct sctp_paddrinfo {
 enum sctp_spinfo_state {
 	SCTP_INACTIVE,
 	SCTP_PF,
+#define	SCTP_POTENTIALLY_FAILED		SCTP_PF
 	SCTP_ACTIVE,
 	SCTP_UNCONFIRMED,
 	SCTP_UNKNOWN = 0xffff  /* Value used for transport state unknown */
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 7278b7e..1c30fda 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -86,6 +86,7 @@ static struct sctp_association *sctp_association_init(
 	 */
 	asoc->max_retrans = sp->assocparams.sasoc_asocmaxrxt;
 	asoc->pf_retrans  = sp->pf_retrans;
+	asoc->pf_expose   = sp->pf_expose;
 
 	asoc->rto_initial = msecs_to_jiffies(sp->rtoinfo.srto_initial);
 	asoc->rto_max = msecs_to_jiffies(sp->rtoinfo.srto_max);
@@ -793,6 +794,8 @@ void sctp_assoc_control_transport(struct sctp_association *asoc,
 		 * to heartbeat success, report the SCTP_ADDR_CONFIRMED
 		 * state to the user, otherwise report SCTP_ADDR_AVAILABLE.
 		 */
+		if (transport->state == SCTP_PF && !asoc->pf_expose)
+			ulp_notify = false;
 		if (SCTP_UNCONFIRMED == transport->state &&
 		    SCTP_HEARTBEAT_SUCCESS == error)
 			spc_state = SCTP_ADDR_CONFIRMED;
@@ -817,7 +820,10 @@ void sctp_assoc_control_transport(struct sctp_association *asoc,
 
 	case SCTP_TRANSPORT_PF:
 		transport->state = SCTP_PF;
-		spc_state = SCTP_ADDR_POTENTIALLY_FAILED;
+		if (!asoc->pf_expose)
+			ulp_notify = false;
+		else
+			spc_state = SCTP_ADDR_POTENTIALLY_FAILED;
 		break;
 
 	default:
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 08d14d8..a303011 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1220,6 +1220,9 @@ static int __net_init sctp_defaults_init(struct net *net)
 	/* Enable pf state by default */
 	net->sctp.pf_enable = 1;
 
+	/* Enable pf state exposure by default */
+	net->sctp.pf_expose = 1;
+
 	/* Association.Max.Retrans  - 10 attempts
 	 * Path.Max.Retrans         - 5  attempts (per destination address)
 	 * Max.Init.Retransmits     - 8  attempts
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 939b8d2..8d27434 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -5041,6 +5041,7 @@ static int sctp_init_sock(struct sock *sk)
 	sp->hbinterval  = net->sctp.hb_interval;
 	sp->pathmaxrxt  = net->sctp.max_retrans_path;
 	sp->pf_retrans  = net->sctp.pf_retrans;
+	sp->pf_expose   = net->sctp.pf_expose;
 	sp->pathmtu     = 0; /* allow default discovery */
 	sp->sackdelay   = net->sctp.sack_timeout;
 	sp->sackfreq	= 2;
@@ -5521,8 +5522,15 @@ static int sctp_getsockopt_peer_addr_info(struct sock *sk, int len,
 
 	transport = sctp_addr_id2transport(sk, &pinfo.spinfo_address,
 					   pinfo.spinfo_assoc_id);
-	if (!transport)
-		return -EINVAL;
+	if (!transport) {
+		retval = -EINVAL;
+		goto out;
+	}
+
+	if (transport->state == SCTP_PF && !transport->asoc->pf_expose) {
+		retval = -EACCES;
+		goto out;
+	}
 
 	pinfo.spinfo_assoc_id = sctp_assoc2id(transport->asoc);
 	pinfo.spinfo_state = transport->state;
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 238cf17..eacc9a1 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -318,6 +318,13 @@ static struct ctl_table sctp_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "pf_expose",
+		.data		= &init_net.sctp.pf_expose,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 
 	{ /* sentinel */ }
 };
-- 
2.1.0

