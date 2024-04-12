Return-Path: <linux-sctp+bounces-66-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174998A3160
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Apr 2024 16:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BB8AB21951
	for <lists+linux-sctp@lfdr.de>; Fri, 12 Apr 2024 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513F61474B3;
	Fri, 12 Apr 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8zr0nsJ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E821448E3;
	Fri, 12 Apr 2024 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933327; cv=none; b=cKsyRmBVRe8lyM2nKvMGv/dTiOtEsgq1tHTgMaYZbBXbudcXnZ7qEGLnOFfjI4W5cJB9egU81CxdNvU8wHqx2bdtPtwz6zviSKyaVb0lPYx2d9Hrf0yBpX7m++Dlyjnw4th5cbyMfIOAmlrkJ78a57cJ/M+pe+EfCB/jKzq1aUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933327; c=relaxed/simple;
	bh=jrbuO52ZBSIAk7BVgz4HVemMnghQxGKVn3QHhdB/BIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btWnWs2I2zsiC25bK2WdHsvMh+PpK96mE44xUb5tOt7atujD7Oi7A5EPHnCX/Vn3WXz6JpMDaQNS+D4vTKIOzJVUVJ9I8i8rKUiF6sHkJWXcFKeS9Y2nZl4sDivz8LTcwfiC7ootGWQND0845wXYq7CmTUi7Sd8xA2nKLCkSvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8zr0nsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C74EC4AF0F;
	Fri, 12 Apr 2024 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712933326;
	bh=jrbuO52ZBSIAk7BVgz4HVemMnghQxGKVn3QHhdB/BIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=f8zr0nsJxy5LvDnNDmnQ+P4VqSlqhvFf2lvS7fWg6H+fGg4QVkERQTANdOfCMaqi8
	 MiPOi3hy9LTpjTE9DIaO3/L96bQxmwlzj02kDdJDTXppFsklPGHPZbgqM1ojrPeGFt
	 MYkjra6/naj7ziq8hauy/GaDUg9Gc6ceSIxeoYbgFIs4ICK92Kx/L6DtFUk1UJIXFr
	 U01FGDXMOLcIuSQ7cjgnMKHDvFVH6y/tag3UH8PGIZJgxVSTzdDpinGASl2cf9ENdE
	 XE7RZg0m3o/lDcE6BBPwCf5riMIfpSVtlu3A8Uo0WE3ffYrVh0wyp+7lbTYzY9iS5z
	 fufK1yBQIoznQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46119C04FF8;
	Fri, 12 Apr 2024 14:48:46 +0000 (UTC)
From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 12 Apr 2024 16:48:31 +0200
Subject: [PATCH v3 3/4] appletalk: Remove the now superfluous sentinel
 elements from ctl_table array
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-jag-sysctl_remset_net-v3-3-11187d13c211@samsung.com>
References: <20240412-jag-sysctl_remset_net-v3-0-11187d13c211@samsung.com>
In-Reply-To: <20240412-jag-sysctl_remset_net-v3-0-11187d13c211@samsung.com>
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
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGYZScsPYrpPiMEhQtTWZeyDzwGKKkqrNx1Y5
 blH40PV/tbg0okBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJmGUnLAAoJELqXzVK3
 lkFPYU0L+wdiNX0+Oq9km4WCDWgZjYmZPl2GKaZZ/YhkEiKhU0DCpHyVq+kR+z84jZe1Qun6y3X
 1BLWRgjdk8yz8v1hNZPrfIKBEANTRfx6/bb9H1DXKnmGYvj0JTpCSkRQnLEOhwNXcL7LoYWozWH
 zISe3iPA0j7a5t2s7UJBp2zfDLzZuui9ldhlvQpXIYF4o/jvJMV+IcMvziaASUq/SGlGoxjv6/A
 iIfVcVM7URaA4472C8F5y8TAheOaNI6kQqEonolMTsZnr/safBo9YWvKuHAx3iitOgvDKLKAkaI
 FrIFG4n7l2p81s2oUoDZr4Q2Mx5ubOrh/bxJWK9TzkxtsPiHw3OqoviwjQ72k0HWkPw4DqIIc4k
 P7IQFbSkwQxS1Csj2vtNJDqcIwxOBA7OS78s91U3QG1+4i51wohjEl86pul3m+aWCcJaML6bonM
 ZmImGHv4gHL19ZjdepmJPNbiIQnFNIK+zGd1VKwRaXFAbZOxa4zqhiYsNqE5LjrPPUr+BNzb6w7
 BY=
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



