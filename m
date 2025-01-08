Return-Path: <linux-sctp+bounces-309-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B61A06040
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB583A5A6B
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA421FF5EF;
	Wed,  8 Jan 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWyPt9lQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89065259497;
	Wed,  8 Jan 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350522; cv=none; b=IDaAghyGqIzcVt9m+z6NX240FTI+LqP9X25doXQqRaikWzCqsvzbYVzzbtviB2G9HLhMdOA/esbMgdUHUiJpPiNMkGV3/fZkcPw7mQ5o5FbeZPcGfn16chk0Q6UwEcwUiScEHWnN8/DzT06qJqhQ0kpbiiZVSLqtR3B13EHf7ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350522; c=relaxed/simple;
	bh=Xrd3zdWiR9VxG1TSMB2lMdIXir8zfBFIexCulLIIR54=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N76Nr+ljPaZdFCgYK3Qx8NwGTMwMKwi3kv5Xs5eMbHTx1B+QiaG16VVNs/IbhOEVISmtdXgR8agBl3jOqXhApI1rgZfBrJyFHxBfYNfaPclklR89Ahshb6jF8UXxLF//KDaBh/2IZCZL9g9X/eCBiH/pS7/omdOkigDWgkptuCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWyPt9lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2FEC4CEDF;
	Wed,  8 Jan 2025 15:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350522;
	bh=Xrd3zdWiR9VxG1TSMB2lMdIXir8zfBFIexCulLIIR54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lWyPt9lQBfKiiXQtLJvl+eNbiuQz3572B4KAsTxSrBOyIAgHC0GLUMYa4bbO9wMeS
	 6zJZJqycXC768jeDn19OHsTHgQB9Ba4SMQ84vaXjInK9LNvhtByF6RiAyNwA8h2FuL
	 UP9dwQQtWn0rzl6Rn+Y0aJNSnQMxMDsUMO2P5u3BX9nnOa3B87Z5CpG0NJ9+Bbmlv6
	 G81RbZ91PK/2H5gPIMJ5gmU1PNWw50GXDrh8jyhxaLuHf2TAkKHm04NvO4+K0AiYwR
	 NBtPs0aOpH/hEzQwrOvNKsKZvdwiXWFoRyNAn7xDdnrtEBDrm5y9U66H04wxkBk3Ly
	 kreVgN0d2/L7w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:31 +0100
Subject: [PATCH net 3/9] mptcp: sysctl: blackhole timeout: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-3-5df34b2083e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1567; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Xrd3zdWiR9VxG1TSMB2lMdIXir8zfBFIexCulLIIR54=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsjNDmbEGyWaVM7w9ArB+i15s5uX0WvUCClM
 RpwdkTsUamJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIwAKCRD2t4JPQmmg
 c5SJEADg1tojmkDUSYGZHbgXVr86QyBhtcFmSnE+UeD8Vr02jNuI3L8VFitr0C8EOSGjnvD35X+
 +TYA7s5XptukAXjDtN3wuskxp2zjhyhBy7UXxMiw8fqu8hufbnCgyI1iz+KPJf9WZ4xKiV+oCy0
 27D1OQTAY73w5U4n3DdOau9/IWZV8tvtK+nod/rpdGLAx69pq/hZNObfKRMtfVP8Ha6vZ4vVm5P
 dZfkWdPBVv0SlK1YlObEAhCRnGR9sIGatnKB17UJ4ZOxct0PjnNxCG/CdfymmrcI+U9LTjL5xBX
 EzoD5UjqX5Bq5KeXWtkmCs9Tt9SN51+K9KFjqe8rvHdS57JN/HP9ZCsVeA1KU0/8NWG2XwGcsFm
 0J+SUnABR47DbiEESAtZiaUKC/Ku/QYehT90bS+d7FfXXz5foglMeiXUxqCxUIBq9v6pPN5dgyQ
 Yn4V1YgDxp8ggZV3+0sADZ3mkKOG9cCmFtIIdpzhPUbWhqwjug0CiCTzBGUEYj6ZykNvNF3iL1l
 ErkpW+86vc8/P0zLLXr+d5842DDMFZZ7RpxQ/6MgVfYnu5i9ZtpOl0y1/4LygG1enDjQL3EPHSr
 lH60lH1gBV61PhRWa3fSowQD/7tu1qM1BJwHqdWXkVQFeZrtTkqk6iMeTp7qwLkJg9TDoOA10T1
 QJdsljuErW04AIQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in the previous commit, using the 'net' structure via
'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'pernet' structure can be obtained from the table->data using
container_of().

Fixes: 27069e7cb3d1 ("mptcp: disable active MPTCP in case of blackhole")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 81c30aa02196d69c55799e5963f6591e416c8831..b0dd008e2114bce65ee3906bbdc19a5a4316cefa 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -160,7 +160,9 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 					 int write, void *buffer, size_t *lenp,
 					 loff_t *ppos)
 {
-	struct mptcp_pernet *pernet = mptcp_get_pernet(current->nsproxy->net_ns);
+	struct mptcp_pernet *pernet = container_of(table->data,
+						   struct mptcp_pernet,
+						   blackhole_timeout);
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);

-- 
2.47.1


