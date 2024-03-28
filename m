Return-Path: <linux-sctp+bounces-55-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BA890377
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 16:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E361C2CB57
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FF6131193;
	Thu, 28 Mar 2024 15:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQA/vlzv"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3864212FF96;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640440; cv=none; b=TwAwdNW5436Pq/1iQ0Q6ZZOQyQjIiMNUh3uA2vtGo+x5DL86urN/wWGq2vBktjpj6J8VdFd3gc3MAxUzWS7CU1/PDhNo/zVdccrGXez5Z18xgxezdp5XUme9fBb14QdEt18vw2B3pQgPITF8SBaIK8dRq62kmziPAtZMWLfamsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640440; c=relaxed/simple;
	bh=jrbuO52ZBSIAk7BVgz4HVemMnghQxGKVn3QHhdB/BIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MALNPo4PuCth3xTf9GRPAXEfFOq2ECKzB0Nl6uV/dBxkawviN6aaWu30RNPDm4aCddDnrLS45RTBj4y8y6ausIelQlodsSd3gkKdZ1kbRCTuzP0oJTsEHnN/PhL4rPsyaq65dqoDyiR+QFoIaxHmkS4w28mnJDt0QB78b6+cqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQA/vlzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD024C433A6;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711640439;
	bh=jrbuO52ZBSIAk7BVgz4HVemMnghQxGKVn3QHhdB/BIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oQA/vlzvxQ9BWKY2rjejUTd71kOPqqX9g2MOXCwu9kbLB0L9vmtfyKXGPEHh15sQ8
	 DXQyfwCHD6bwawq+VERXYAFvy998J5WYQOxkIoRcHQqe0mYPZod/ctPR519YUbG4L5
	 JyBt+Fc3JNBipLzeQzK26XMH7ViMMK4yuRUdRtZ8uuXHB/hy8l/tq/gMWYiA+qknae
	 t0hkjgFBdh5HTj+RSAvMfNNvDXn1IDrQLP4cmJShEczDYmTrauTNpD+u17YQf4vBm6
	 6SWc+MV662z5ePOpsEAPf7VcqEsu6OQFk6n1wHF+HPRCPvfrJw0d2wpHhh7PP188s6
	 3jjPCakHdxZlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25ACCD1288;
	Thu, 28 Mar 2024 15:40:39 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:40:04 +0100
Subject: [PATCH v2 3/4] appletalk: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-jag-sysctl_remset_net-v2-3-52c9fad9a1af@samsung.com>
References: <20240328-jag-sysctl_remset_net-v2-0-52c9fad9a1af@samsung.com>
In-Reply-To: <20240328-jag-sysctl_remset_net-v2-0-52c9fad9a1af@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=954;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=XDIcCkZ78Jc0dTs1FMG4vIEa4qRq4WIrQqvTanRSSyI=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYFj3SuqfQsiaSf+fFZpsP0jHhd/mrZlzlVz
 23Vit0koICrdIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmBY90AAoJELqXzVK3
 lkFPXqAMAIxC+7QFDIIRdXgRwfA0cSaHn3wdRaAIg6vrDr4LyqJ9qLZwZdRyZvDu0UwAgyX1s19
 td8wZ6GE9yEgj1abGgEjcXm0hOY8lDe9UAsCCwWkG7VTPahH15cgga6yXM6XphN9BudLFQ+7RSY
 4ioezGlJDBoIJoXyGphVjy/F6YX4753RAJkEZOOTvpAiZ5d7lURowJWeyxlb9JwPLCCBTEN9Phb
 Z0s9dAxUP34JmG1VzzzhaBiUPibm+Q+LWbS0JW8AomRsZ3r86TL5WPFCRLzYmpH2w87rleAcEpv
 MlslpsG5ToZFD5KVglKvcwrNT/NYXZsHz1LQxbTky1tk1ZqnB1DLdY5t7/ijveSREO7/lgas242
 iNNqjT5iCg24C/5TF9Tr/16nk0TQOqJgJNkjASEq0lyjO2JbKsYDULL8XoHbZfFdbsI5tujHD4/
 M++BX6CHdHzh4X+T/bWc8RCv25S3NiNdH0LrwdvrJTpEgQ1mXwIevDeWq69QO1+xJny+IC0jBZ9
 iU=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with
 auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: j.granados@samsung.com

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which will
reduce the overall build time size of the kernel and run time memory
bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from atalk_table ctl_table array.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/appletalk/sysctl_net_atalk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/appletalk/sysctl_net_atalk.c b/net/appletalk/sysctl_net_atalk.c
index d945b7c0176d..7aebfe903242 100644
--- a/net/appletalk/sysctl_net_atalk.c
+++ b/net/appletalk/sysctl_net_atalk.c
@@ -40,7 +40,6 @@ static struct ctl_table atalk_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_jiffies,
 	},
-	{ },
 };
 
 static struct ctl_table_header *atalk_table_header;

-- 
2.43.0



