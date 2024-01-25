Return-Path: <linux-sctp+bounces-3-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC2483CF5A
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jan 2024 23:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9438290205
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jan 2024 22:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179AB13B790;
	Thu, 25 Jan 2024 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dEFfkSx1"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4613B787;
	Thu, 25 Jan 2024 22:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706221791; cv=none; b=dYQNTxR2/axnnpdfbNELM525hy4l8OOdmvUXXyK4OWdPKXC24djbSp/fFNCawdiTGSB5Bo2plTVNCxAhMQ457SVytMyWdmuatcYkXf1WCSy94jOpTXdH65YUrQAglsIP04LjHFK5DOAgW6ZSzfA+VdoDd1PZ7JTIU5zhS2WSWPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706221791; c=relaxed/simple;
	bh=teWxaZbkvWhb0PCw6q28RFREAnhb+f1N7VXEo2/etKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UbEqSe+dPSd83w4ESOlgBAevgJYLFUVI3vzR4pAaCFeEwrafkJpUeXVj2zT48y7hZ510xGSrXxBf47Xg/AjTTMAIWsqaIH70sdognumCiBm3dzzuVqzsl2YcEH8zqtFuT2FNqVYNITH81ELd3d7dw2HKUyKm7JUcb0I5fUWZbtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dEFfkSx1; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bbbc6bcc78so19895b6e.1;
        Thu, 25 Jan 2024 14:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706221788; x=1706826588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ouPYgv6jvx+UEBYd2b28+Blg8/f1MS+BmmcDzg8dExg=;
        b=dEFfkSx1lM12Ws+RFdttte2hsT36bVG58tYR62eE888DGz43Tpfp6+NVnMSefeB3ni
         DSgVEsj0eYg5XTb2yPcd/iqon4Cmsy1/zRsgE1IAMELxVD+n84XmiWPDHltpsW6WFcJP
         9+exS6pl3lPHV0dbbt73ls2jICrdi1lFlpUpqE/ZXQjFl+fROJ0HyAvDUuRkTU8Em2Aw
         nxDEYhwhnPptXzWRtZp23czP/FT+YaHZ/MHbKkTWDKP9Qw+LlpKTEfr7lJ8SZPntcsjh
         TA0Kv6SYaxuDLDg/VrKZ0J52Q62l7A8QBYHTzLaC+2ixYcTWgwd1IobpSY6cTKVvxYWn
         rpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706221788; x=1706826588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ouPYgv6jvx+UEBYd2b28+Blg8/f1MS+BmmcDzg8dExg=;
        b=CSy2rCapOGhHcVGaDQVwAC4/5AJP/+FOIimb6NsSfrwynL6YXijSthqBo9cOnLqwoM
         2YNopA675mIdxjs0zEjXBM3u73qA1apE0FsZ8doZwfW0fNahApr6jGaRzkV5CucBVBkI
         1PTAa+mwlKC7MjNVKz27kJQQq3Y9YmYP59WXe1zkv3O+C66miAxdi2JqNOTabKIA56MJ
         EJEl3BRpveTIf6yAoci3Eb6V7DKPXYjqxVQPAqfjttoNj8k8ujr7LCr7mi2N8f830fku
         A0BLzLHuHkM2gn0L0hRhQwpEu4KP5Gw6wt+/ERGm+V/C+uzR8/jB/xJ7DXEIduEm943m
         7keg==
X-Gm-Message-State: AOJu0Yy06Ng15C4KxLsmf1EXfkyfTz2ovLC3gCJVCzp5WIVPm4u2/sQd
	dFLmp8sINy4fX6uL3Umwe//fEipIdlXqsyQpH2MnvzXIwDIU8N7W43VvzrhQ
X-Google-Smtp-Source: AGHT+IG2/VOSv7+PKEiOE3BXtYPlBdE7raA2v7l8QZn0/Wb+nptsL1ZfejajXmKefyekueVTU6waZg==
X-Received: by 2002:a05:6808:2024:b0:3bd:d8d4:5706 with SMTP id q36-20020a056808202400b003bdd8d45706mr541354oiw.12.1706221788293;
        Thu, 25 Jan 2024 14:29:48 -0800 (PST)
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id b26-20020a05620a04fa00b007836720b96asm5448924qkh.24.2024.01.25.14.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 14:29:47 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH nf] netfilter: check SCTP_CID_SHUTDOWN_ACK for vtag setting in sctp_new
Date: Thu, 25 Jan 2024 17:29:46 -0500
Message-Id: <28d65b0749b8c1a8ae369eec6021248659ba810c.1706221786.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The annotation says in sctp_new(): "If it is a shutdown ack OOTB packet, we
expect a return shutdown complete, otherwise an ABORT Sec 8.4 (5) and (8)".
However, it does not check SCTP_CID_SHUTDOWN_ACK before setting vtag[REPLY]
in the conntrack entry(ct).

Because of that, if the ct in Router disappears for some reason in [1]
with the packet sequence like below:

   Client > Server: sctp (1) [INIT] [init tag: 3201533963]
   Server > Client: sctp (1) [INIT ACK] [init tag: 972498433]
   Client > Server: sctp (1) [COOKIE ECHO]
   Server > Client: sctp (1) [COOKIE ACK]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057809]
   Server > Client: sctp (1) [SACK] [cum ack 3075057809]
   Server > Client: sctp (1) [HB REQ]
   (the ct in Router disappears somehow)  <-------- [1]
   Client > Server: sctp (1) [HB ACK]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057810]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057810]
   Client > Server: sctp (1) [HB REQ]
   Client > Server: sctp (1) [DATA] (B)(E) [TSN: 3075057810]
   Client > Server: sctp (1) [HB REQ]
   Client > Server: sctp (1) [ABORT]

when processing HB ACK packet in Router it calls sctp_new() to initialize
the new ct with vtag[REPLY] set to HB_ACK packet's vtag.

Later when sending DATA from Client, all the SACKs from Server will get
dropped in Router, as the SACK packet's vtag does not match vtag[REPLY]
in the ct. The worst thing is the vtag in this ct will never get fixed
by the upcoming packets from Server.

This patch fixes it by checking SCTP_CID_SHUTDOWN_ACK before setting
vtag[REPLY] in the ct in sctp_new() as the annotation says. With this
fix, it will leave vtag[REPLY] in ct to 0 in the case above, and the
next HB REQ/ACK from Server is able to fix the vtag as its value is 0
in nf_conntrack_sctp_packet().

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/netfilter/nf_conntrack_proto_sctp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index c6bd533983c1..4cc97f971264 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -283,7 +283,7 @@ sctp_new(struct nf_conn *ct, const struct sk_buff *skb,
 			pr_debug("Setting vtag %x for secondary conntrack\n",
 				 sh->vtag);
 			ct->proto.sctp.vtag[IP_CT_DIR_ORIGINAL] = sh->vtag;
-		} else {
+		} else if (sch->type == SCTP_CID_SHUTDOWN_ACK) {
 		/* If it is a shutdown ack OOTB packet, we expect a return
 		   shutdown complete, otherwise an ABORT Sec 8.4 (5) and (8) */
 			pr_debug("Setting vtag %x for new conn OOTB\n",
-- 
2.39.1


