Return-Path: <linux-sctp+bounces-1196-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CfgCOAl7mn0qwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1196-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:49:04 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E1A46A6CB
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 959543002319
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E206833D4F0;
	Sun, 26 Apr 2026 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8Pb2hy+"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854354A07
	for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 14:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214939; cv=none; b=NpbEZ/6wgEtas6x+97jcKt1AchwGuwKqKn1lU8j9+vWbJ1GTRFcpC1XZwhJGz3OZcwXTL1LVUpGYjCkJdZXkteDyLIHelk+xk2o06r71WRptknljerx8/zrQYVzx13E250QyTGKaXQRbeuqi2Ty5i6fGEVuQRDIxqq2Jzb8nnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214939; c=relaxed/simple;
	bh=0/ZauZOQB/NP1QcAH+PDITEaXUC773OeN19DfxcW1yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RVmQAlhrEt7gPzqAOukC0gdSZ3grTKUoqgeZFcGLcXB2zS9s98lfREQxYR77FUi8JPFa/nloJgXyoN/+LWt6+47HHafkyVqlMPtzpY4hOHOZWnp5RKSNXS/fCA/Sx7QCXcz8ue+I999evZVPAugDSL3RlIdPaewyZf7nMWktvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8Pb2hy+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b038a00370so80466606d6.1
        for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214937; x=1777819737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EMSX8d1QgLZUoJnKt34AnkG63ZeJBVmP3ekDSJT4BDs=;
        b=j8Pb2hy+d7PpZUfwcrhGzURJ3yc5i1yFgqmIuBIPKXfnfuyojj+p3psQHT7x2/N4dL
         FIL+orvjFmJA1KfPcPmVIkCHgn9oayoX3ZoCMwHHucFNJKcw1MP5H4c/khHVwb148c2R
         ww7ElTN7ZK1VTAoPz91nnXWZIKUjrsEyhEaVe5k/GIK6rEAXT/2rFYDkY7VvwK0y1yKx
         JvtmIpXZ107zb7jKjdMKdGZdL3wmlmFb3YN2tts5mogsR3EnaLPWHhnkWerfXCABJjJ8
         iVzt/kuvHy7TINI0C+i7UmYk6WIE5EKk8hu2AUCJE97/16kzdat2tOAoDxx9noU9tISp
         R8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214937; x=1777819737;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMSX8d1QgLZUoJnKt34AnkG63ZeJBVmP3ekDSJT4BDs=;
        b=bFOV2MwvdyMT9dsgPM51NsAscG+9/+yZi/dhqd4Jqp+SJGP4Yfs4g7JfJi1Q4UyX/O
         lwVDhW6loXO1ufMjvPAgpifrUmtfR8oF50fZ+PVc767PhCuApH1ETbT3wogiQwwABHhb
         gYml8+Myk+EvxwdJSS3PgV9Y7U17EQksPRcEJZ3xfhamH1pXD5Zdngmx4i/WpRx9Snpw
         /QqON3OQev5DjenGUtdTuX/fK/VdABNWT4MmSK2YRBv9ccvqmgBIJTRx9JrVS+a0ksdN
         LJvq3OSz73qWQPm7jVrMrm30NgHlOiKHOayKyaAkRCh5Vv6Pky8qJtmmQA00hfZTR6/i
         Wx4A==
X-Forwarded-Encrypted: i=1; AFNElJ/aIW3jtE6IXOS2TTCwaxaOo5aMT9rHG+U0eBQaYADc8Ur97KW1er3yl7gXqzj0YnqDxWTlXRvFXx1F@vger.kernel.org
X-Gm-Message-State: AOJu0YyYASWIuy8q3+KKMgykt7y7vJyrRueUTsQXoak0s+KqRrwnqvtT
	AnXV35G5ujXNc3cXclJzIlVdgiuDeZGTnQClWPg02es20UhkFofBmCJ9
X-Gm-Gg: AeBDieuAypWTLq+KaIP0GBAGfS27cXJ7VY3Zw9K+xRZ29R6BfQrKDguHUShn2mfh8D/
	zWN3MHCkLqQuhplzWC2JEGgeHchplF5nkL+ABVNokl9tbIWxNY7FYheL+SS1/FNqjkzOXKGL3al
	QiGMOuqA83dWg/kFTDRjNJJB5DZXYI4hYzpkpx0HIq2nUd6d4LdpLvuKVZWvPB1BkGtmYKamefH
	rOoVGS4gnTDJKT3OXZ/wf2Vsb8WgRijscKvqnK66LIebs+9Fg6fxHAq0Nr6xU7VmcGvn3JXqOvN
	CczWKwBGconW2AxgPEZ5hzZ4NyNCUmzvLIn8qb/R7ka17nsouYYHiE4/px/oowsv+rUM8tWcqWr
	mOe52/R6sQsQqYjwE3T2NBZ9i4QPHuLtit2Nva4rR6lOsFZm2Xa2hMIiP6xN53EZlpnNQ8t2vjs
	RRIL0Q9KbhlkLaAJyPYuZwKVK78E725X1hNr4lUnq8PRJRswlkmeKUEj6l5GNd2MnGHkhk0Nwqz
	TK0hkCD0GtU4T+hltoqBbC2hU3nWHWV9hCdMXF9IM5qVTRZT4BGvGubxKxTh4bKpyRvlRci/oE=
X-Received: by 2002:a05:6214:d0e:b0:8ac:aa89:6bbc with SMTP id 6a1803df08f44-8b0446f0cb3mr459818986d6.16.1777214937472;
        Sun, 26 Apr 2026 07:48:57 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm232579146d6.48.2026.04.26.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:48:56 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Yi Chen <yiche.cy@gmail.com>
Subject: [PATCH net v2 0/2] sctp: fix a vtag verification failure caused by stale INITs
Date: Sun, 26 Apr 2026 10:46:39 -0400
Message-ID: <cover.1777214801.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B4E1A46A6CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,netfilter.org,strlen.de,nwl.cc,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1196-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Similar to Scenario B in commit 8e56b063c865 ( netfilter: handle the
connecting collision properly in nf_conntrack_proto_sctp"):

Scenario B: INIT_ACK is delayed until the peer completes its own handshake

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
    192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *

There is another case:

Scenario F: INIT is delayed until the peer completes its own handshake

  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
  (OVS upcall)
    192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
    192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
    192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
    192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
  192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
  (delayed)
  192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *

In this case, the delayed INIT (e.g. due to OVS upcall) is recorded by
conntrack, which prevents vtag verification from dropping the unexpected
INIT-ACK in nf_conntrack_sctp_packet():

  vtag = ct->proto.sctp.vtag[!dir];
  if (!ct->proto.sctp.init[!dir] && vtag && vtag != ih->init_tag)
          goto out_unlock;

This happens because ct->proto.sctp.init[!dir] is set by the delayed INIT,
even though it is stale.

Fix this in two parts:

- In netfilter: Do not record INITs whose init_tag matches the peer vtag,
  as they carry no new handshake state in the 1st patch.

- In SCTP: Prevent endpoints from responding to such INITs with INIT-ACK,
  ensuring correctness even when middleboxes lack the netfilter fix in
  the 2nd patch.

A follow-up selftest for this scenario will be posted in a separate patch
by Yi Chen.

Xin Long (2):
  netfilter: skip recording stale or retransmitted INIT
  sctp: discard stale INIT after handshake completion

 net/netfilter/nf_conntrack_proto_sctp.c | 10 +++++++---
 net/sctp/sm_statefuns.c                 |  6 ++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.47.1


