Return-Path: <linux-sctp+bounces-95-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1599A8B20FE
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 14:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A031F25198
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Apr 2024 12:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D87B12C49D;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iebj8Wwz"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286FF12BE8C;
	Thu, 25 Apr 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714046620; cv=none; b=qj18crh8BELH29BsNFAlJWQLB8oxsdp4+sL1A0TI5tNhEh6u2HD1K5WPWxSbzcvbfnMrKMumm5quPdq0wQM06qUjG5cjihRjrx9koMeIHyfkCUzz2+a371sBF4BKJk33zfHxjPCp8WmXJnLhE2AFIIKbnymt3qBPxtrjElroOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714046620; c=relaxed/simple;
	bh=OaWenH2ecs+TvT40FvZfeCOsMkIprLb3i+uRB7TGjxw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FV93sLpUYMis5hOMH2TIbBgxV7zATDkg9LnxkDyIPVLORwD2aSaQw+w/S4B1MeCPidbLz9j/TRl4AvDeXrvaI0aS7w53kjF0z+w6oWCtoV9UPIu8W1mxSBvboHfyDZgYBqDmZ0UD705ofz0jZ4me7NC9eziULip+nsfxEune4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iebj8Wwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C99DDC4AF0D;
	Thu, 25 Apr 2024 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714046619;
	bh=OaWenH2ecs+TvT40FvZfeCOsMkIprLb3i+uRB7TGjxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iebj8WwzVL+A712aOjHvZVb2LDpFpEXkLkDox4BuouovfrBfBVUMjnHmA74kMziQS
	 4cHR1usXK+N+fXrqjsv4xvQc6YxHwsWkHC87xg9fKYFf/RuNH9PwidOHG0S1lKx7ym
	 iDFthYA3S5oiN3sbuleUqmqzTIPLPvtclvT1Dc+5KWOaEfBLsg8affCkYJQ31su65D
	 nKmidiXn1JyIriN6kbCvm20TFBJkZisMTtHGFKi7zwlGb5okklYWqlRwGjxGoP9cz6
	 /5yuraskJdE0xbQFscPVQnZlV7treb/SA3ZSnhb+dhxQNMD8/Ff7wjhA0+DFm9bYNc
	 /2yrmqf9aE7Gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE61C4345F;
	Thu, 25 Apr 2024 12:03:39 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 25 Apr 2024 14:03:01 +0200
Subject: [PATCH v4 3/8] net: rds: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240425-jag-sysctl_remset_net-v4-3-9e82f985777d@samsung.com>
References: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
In-Reply-To: <20240425-jag-sysctl_remset_net-v4-0-9e82f985777d@samsung.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, David Ahern <dsahern@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, 
 Remi Denis-Courmont <courmisch@gmail.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Jon Maloy <jmaloy@redhat.com>, 
 Ying Xue <ying.xue@windriver.com>, Martin Schiller <ms@dev.tdt.de>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Florian Westphal <fw@strlen.de>, 
 Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>, 
 Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <keescook@chromium.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dccp@vger.kernel.org, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-afs@lists.infradead.org, 
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, bridge@lists.linux.dev, lvs-devel@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=openpgp-sha256; l=1604;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Yhw5Yxzxk2wGoyQtTfioNjf4XA/aQJR8HoqakSkFmW8=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYqRpZ+ciA/HHVt65phSNWtFyMUOJjaO+muN
 giwMjY3le8uKokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmKkaWAAoJELqXzVK3
 lkFPOOIL/RVvW0sG7aSSd5w2F2A7rKvXffRk6l2MMFhUVSA6mTgxTTtWKiAhcdH+Tph9HS0xjmb
 RA5qTObl2piNudwds595bpBh95SUaFWXs+JaFvoz7rGQmLq0dR/7urynVoO1BqoA31AE4h1YT0M
 hAAfyOIbTk/udmGJ7p8l3AbnOgb78NrsEVEm0R8IB1HKkCgMar3/u9R3umnS5eogtXQ0Zw7ZqLO
 KwVsn3LDTckfU3Sum2vYvUNHfnYapZWvtLUWtLq72l1XHaeZTAQertUKq+EI25OEPZHUzoS0Afj
 Xym9aOv/GqdERSwT9o4YBfc3fKFNTDCUrypJ3Zkd8LHJEhpzf517Sgwk9yp+EslSoGB+z0nlREK
 QHhojWNrCN6900i+pIoWMcQ8vil4s35QVwP6KT9Utum5DqUrYFW1SnEaTb7uWZfODcUmXZ/LJ1N
 qEN10dnIE9hBxDnuqmPt93EnnCIbvnv2EUkwHt1cQrZv7AdS0yVsdYnDYBtntWfYGqzCT90iZh3
 wo=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

* Remove sentinel element from ctl_table structs.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/rds/ib_sysctl.c | 1 -
 net/rds/sysctl.c    | 1 -
 net/rds/tcp.c       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
index e4e41b3afce7..2af678e71e3c 100644
--- a/net/rds/ib_sysctl.c
+++ b/net/rds/ib_sysctl.c
@@ -103,7 +103,6 @@ static struct ctl_table rds_ib_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
-	{ }
 };
 
 void rds_ib_sysctl_exit(void)
diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
index e381bbcd9cc1..025f518a4349 100644
--- a/net/rds/sysctl.c
+++ b/net/rds/sysctl.c
@@ -89,7 +89,6 @@ static struct ctl_table rds_sysctl_rds_table[] = {
 		.mode           = 0644,
 		.proc_handler   = proc_dointvec,
 	},
-	{ }
 };
 
 void rds_sysctl_exit(void)
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 2dba7505b414..d8111ac83bb6 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -86,7 +86,6 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
 		.proc_handler   = rds_tcp_skbuf_handler,
 		.extra1		= &rds_tcp_min_rcvbuf,
 	},
-	{ }
 };
 
 u32 rds_tcp_write_seq(struct rds_tcp_connection *tc)

-- 
2.43.0



