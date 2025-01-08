Return-Path: <linux-sctp+bounces-313-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB608A0604D
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFB11888C06
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB9F200BBD;
	Wed,  8 Jan 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hjQKbcpj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2323192D66;
	Wed,  8 Jan 2025 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350544; cv=none; b=F/DjITWp5s/GPAWnzsnrHmhzL/20B5/1OOGKtXRpd9cHJgUwBVnq/jGHG0n2UQCTeVO5TOsltiUDEF8lo7Q9scyQ/iTK9xqx7DbflS/JJG717AGnJYjC69Jk82Ek9L3Ixym+nhxSz3xFLs/vo3CzbIXv/FuMlUHN+q8y1kEZ/u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350544; c=relaxed/simple;
	bh=yu42qnw1nNAsokR/WO64E0Ffx8R6+FXxDkFWZffqNA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TJDr5wxubLWoph38b9S1ZD7nhauzq/9RAVZ1FIOd8FBhWX9B504k2rHboHe4ovANUnBHmIbjoXiHcOBcvSTwXlpmGUG3j1UGTmq2Q30dj51+Xl3a+LEe7LPZVT5lt60OSCdWvHKedmDSQ8/AwbGX9Sp8pHDbFamTI1VneuOSo4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hjQKbcpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3634DC4CEE3;
	Wed,  8 Jan 2025 15:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350544;
	bh=yu42qnw1nNAsokR/WO64E0Ffx8R6+FXxDkFWZffqNA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hjQKbcpjwC12EhLPftrMJQyB2ZRcxVmnP73gHYwli7DGvFiLKFF4ztm3Qfa7RBeoE
	 f4fR7oGeqvmmPo8wRcpQonWNmC9sLCrUvs3zrBSf9hzm+FnO/WRvApT+qLSsaj51Dy
	 LsngVqqhfOCU4twJF8BRn/PnlskZBjWDJFY50Ku061lBMSupMaSLDzAV2TRatf+h4/
	 1IpwyTMUNyqpmNGTqD//0vYJut2PkOr/FS1HjL+M57VbUNDJt1bL3CraqXghTAFcKE
	 82/1DLTnyE1h5ggFIPqR1CU0wthw35yoyjq/lGcaS0LIEu4MjTJ7SaRVFKctiToDNv
	 dIOaC7ISrM8Lg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:35 +0100
Subject: [PATCH net 7/9] sctp: sysctl: udp_port: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-7-5df34b2083e8@kernel.org>
References: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org>
In-Reply-To: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Vlad Yasevich <vyasevich@gmail.com>, 
 Neil Horman <nhorman@tuxdriver.com>, wangweidong <wangweidong1@huawei.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Vlad Yasevich <vyasevic@redhat.com>, 
 Allison Henderson <allison.henderson@oracle.com>, 
 Sowmini Varadhan <sowmini.varadhan@oracle.com>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: Joel Granados <joel.granados@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1708; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=yu42qnw1nNAsokR/WO64E0Ffx8R6+FXxDkFWZffqNA0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsjteJFxAGcvm3BfPK4WDy8tgZSdrpA0YYGu
 dt2TbToOKKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIwAKCRD2t4JPQmmg
 c5oUD/4yBuIMw9JQg42vpGQrv/esWRLzvypsiMX91nZrH1Hlm7Tj/d39nXjqe25DRSGQL/Wx0re
 5se7ItBbXQ3W0yKK9ER4EyE0Zrgec1W1ZcCsN5kA9hCCvuo0LHhxwJQBa+S0WT9+GBNUovMtqqt
 0JIqQ4IB6raPkgYJcwK2YEeDjDtDTWHPZdY+PNqFkv92FT/bF+6TDjBlritqSGa06a90JJ8Re0x
 fh/LwhnHNUpOxj6JsI+tO6V+KwVuBt/w/Z8fXzkRKdC04Cj/8PyPGH36/KDtefXpLWWJXsWL1t9
 yOuCcmCLTZ0ScNFfTiFrgKpqDBi/taP33tGTPGo1s9jXQ0FFx7h2KnBcbbNX0XZe7JZ0C1sLDhF
 egL0i7yhRlTW06MljLYBMXUuTjophlwjkK1HS7vKjyhMED9saU8tQpJiBwM9hdh85ncHrew5RSN
 ZnRj+m0dgDypwn82vh42d94sAZANfodeHvorNZ3CtQPiXS6fRbOXSam3IvzdabKbwc/qz+GC2+N
 xieMr0md0RosdGw4gT97jee+YeD8gYWaDHO7fd47DAglZVpl7O2cf98HgxPa4132I+DgK4Kr62Q
 YAntsAT45wb+sjXwVMsQsifnO0XWvaqY+OLPEIiIN8Q2BOs7WxOCFBYvkYD7KtzLE2V8u+1Etf+
 tWWBA3uUnsbnJFw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, but that would
increase the size of this fix, while 'sctp.ctl_sock' still needs to be
retrieved from 'net' structure.

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 9d29611621feaf0d2e8d7c923601ab374515563b..18fa4f44e8ec8c86f8415b1251ef8a2979c7f823 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -528,7 +528,7 @@ static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.udp_port);
 	unsigned int min = *(unsigned int *)ctl->extra1;
 	unsigned int max = *(unsigned int *)ctl->extra2;
 	struct ctl_table tbl;

-- 
2.47.1


