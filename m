Return-Path: <linux-sctp+bounces-462-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632D3A78C40
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81CA63A5D0A
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Apr 2025 10:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE43B236458;
	Wed,  2 Apr 2025 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="aBV/LWR4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD1E20DD4B;
	Wed,  2 Apr 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743589576; cv=none; b=tlpPw3uSuPRiye/dveX0Sg402/VHH3qq8/zCY245pPA5mRn/DSqOL8zIBXnSuRoQJDysCNI4S7ccq2KHLYe7nWAScipX7PsVCj+IYeQfCElENYoWcJU04TWMqrmM8WhlEHtIwQwUxbX/mLiH6f0Zn0ISEd2ied7D9k3XeRqF7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743589576; c=relaxed/simple;
	bh=ueU0tsoJmshJuhCgiZV9VtCiPEtKC2S2/SWb4YyF92k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hv+h3jl0zNznxK4q0I/GW2hS2+qr7ggxCTWY7CBDU20ugXD7XPkiBuFocWT2XOUUtuDBU49BxpyxJHIXXUngLrEtqsaw7CDDArU09IF1tuGYNoJo9IsAmAR/OURkGuPX1nzprCJ2yIYu/J2x6ddl3Xoi4/1XYfs5ruldmJCOxpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=aBV/LWR4; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fHhV9SK89xJ+0Cav0WJVvWFjhjuNOwJ4gquSCfYAFuc=; b=aBV/LWR4i3lUECdfXUpg01khHZ
	vylR0RFhk8X/NMLdsTu6p77MbZyxaUGfDwW74FNMjASH2wqFmW+ZvEWJeHVmiNl4xpbaUQaLAOwel
	AZgxGo3xF+e/VP7kVrCq0AWPJTf1r+bwkIz2Z8OmZ0b+0rW36yenGMmdcT1ljhGbLclL3cV+t6k5t
	CDwsRe52rl/sN3NDyeCFCNfG/U0m5rFbWyUM4Hj+FqtnJOT1X36oBy8l265DEC0I8O9O5/CMmwgs4
	aYrtLLa6PUuHZg09PQ1wjG41aA7Ex+eyq/KrPOge8kMnJBQEkVE+FJgeofzJyVpXUV7oSE8mnORV1
	AooyfFBA==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tzvII-00AK3u-Q2; Wed, 02 Apr 2025 12:26:02 +0200
From: =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Date: Wed, 02 Apr 2025 12:25:36 +0200
Subject: [PATCH] sctp: check transport existence before processing a send
 primitive
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
X-B4-Tracking: v=1; b=H4sIAJ8Q7WcC/x3NQQrCMBBA0auUWRuItSp6FZEwSSYaLEmcmYpQe
 neDy8df/BWEOJPAdViB6ZMl19Kx3w0QnlgeZHLshtGORzvZ0bxQsDiZ0ZtFyGBSYpOYyDFhdLm
 3oM3VRd9OaKagThmLtMpqplO4hIP1wZ8j9EVjSvn739/u2/YDGUIqV44AAAA=
X-Change-ID: 20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-46c9c30bcb7d
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kernel-dev@igalia.com, linux-sctp@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
X-Mailer: b4 0.14.2

sctp_sendmsg() re-uses associations and transports when possible by
doing a lookup based on the socket endpoint and the message destination
address, and then sctp_sendmsg_to_asoc() sets the selected transport in
all the message chunks to be sent.

There's a possible race condition if another thread triggers the removal
of that selected transport, for instance, by explicitly unbinding an
address with setsockopt(SCTP_SOCKOPT_BINDX_REM), after the chunks have
been set up and before the message is sent. This causes the access to
the transport data in sctp_outq_select_transport(), when the association
outqueue is flushed, to do a use-after-free read.

This patch addresses this scenario by checking if the transport still
exists right after the chunks to be sent are set up to use it and before
proceeding to sending them. If the transport was freed since it was
found, the send is aborted. The reason to add the check here is that
once the transport is assigned to the chunks, deleting that transport
is safe, since it will also set chunk->transport to NULL in the affected
chunks. This scenario is correctly handled already, see Fixes below.

The bug was found by a private syzbot instance (see the error report [1]
and the C reproducer that triggers it [2]).

Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport.txt [1]
Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-after-free_Read_in_sctp_outq_select_transport__repro.c [2]
Cc: stable@vger.kernel.org
Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer")
Signed-off-by: Ricardo Cañuelo Navarro <rcn@igalia.com>
---
 net/sctp/socket.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 36ee34f483d703ffcfe5ca9e6cc554fba24c75ef..9c5ff44fa73cae6a6a04790800cc33dfa08a8da9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1787,17 +1787,24 @@ static int sctp_sendmsg_check_sflags(struct sctp_association *asoc,
 	return 1;
 }
 
+static union sctp_addr *sctp_sendmsg_get_daddr(struct sock *sk,
+					       const struct msghdr *msg,
+					       struct sctp_cmsgs *cmsgs);
+
 static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 				struct msghdr *msg, size_t msg_len,
 				struct sctp_transport *transport,
 				struct sctp_sndrcvinfo *sinfo)
 {
+	struct sctp_transport *aux_transport = NULL;
 	struct sock *sk = asoc->base.sk;
+	struct sctp_endpoint *ep = sctp_sk(sk)->ep;
 	struct sctp_sock *sp = sctp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct sctp_datamsg *datamsg;
 	bool wait_connect = false;
 	struct sctp_chunk *chunk;
+	union sctp_addr *daddr;
 	long timeo;
 	int err;
 
@@ -1869,6 +1876,15 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 		sctp_set_owner_w(chunk);
 		chunk->transport = transport;
 	}
+	/* Fail if transport was deleted after lookup in sctp_sendmsg() */
+	daddr = sctp_sendmsg_get_daddr(sk, msg, NULL);
+	if (daddr) {
+		sctp_endpoint_lookup_assoc(ep, daddr, &aux_transport);
+		if (!aux_transport || aux_transport != transport) {
+			sctp_datamsg_free(datamsg);
+			goto err;
+		}
+	}
 
 	err = sctp_primitive_SEND(net, asoc, datamsg);
 	if (err) {

---
base-commit: 38fec10eb60d687e30c8c6b5420d86e8149f7557
change-id: 20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-46c9c30bcb7d


