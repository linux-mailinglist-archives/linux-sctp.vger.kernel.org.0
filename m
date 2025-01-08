Return-Path: <linux-sctp+bounces-314-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FDFA06051
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6195D1888F2C
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E9820102C;
	Wed,  8 Jan 2025 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft2rBaGm"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4F8192D66;
	Wed,  8 Jan 2025 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350550; cv=none; b=pQ9vEWHiSvFrJ8yPyQhBeeHOAaDQp1AxOUGZ2c8tdfEF/30nAbsIzNjE70Qz9MPyM00pjN1u7cfHaFGsNSgRy16+0sxdlh5xYrMiPTX42nwGzEoFwF4hxYzBXVj7gfzOVWs78e7YkisncNtxVPUrhV8B++ebCT5xaZXCN9sH+Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350550; c=relaxed/simple;
	bh=mlZQdwHebIpNYItwXgOB6fIb3H+q/rwlaNvaWmrUCp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nc6KIi3ni20Y2h895semvhjOrQffVyuR9H8H7uOswVVTgRxnSnI2RR899K1imfZKb0JjBWfZpVP7Q0smzWJNg5/eYjTgHsEY2DvxT5ihQI+YDh02ttt74/8M0P9JctQXHoT0nfJgDGuK/X4f4VPDq7uXZ+fF6nhJShtgJAPPwJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft2rBaGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA87C4CEDD;
	Wed,  8 Jan 2025 15:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350549;
	bh=mlZQdwHebIpNYItwXgOB6fIb3H+q/rwlaNvaWmrUCp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ft2rBaGmWGwjHOuawnbWCzVbrc6HEv5s7wTbPshkn5ymzI2TjOP5c3WjPAKJXGVuS
	 dWkTY3EqsoYhgI1RqmJYmxuu61Q893gkYflc8UonbetimwUWZcO7cUMUmNja9aLSPb
	 2b16I7amCi9x0vZu8Sc4dlcAGl6Cf02RyLFFCj2MBJuHEzUshQKTh6vGZio60Qo/PE
	 6IygesGE5K487f7RFS++E9bQITiygQ0B0k4SaSMUXgxIt/dmU4zs89vKsYzhVcgj3l
	 ppZxAZqlmGo53O3Gl8bPdNSUebG5UH0LxbHUOuV/pW701IeHr0tKQmsOYOfwnHAQ+O
	 vOZCAJf662FQw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:36 +0100
Subject: [PATCH net 8/9] sctp: sysctl: plpmtud_probe_interval: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-8-5df34b2083e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=mlZQdwHebIpNYItwXgOB6fIb3H+q/rwlaNvaWmrUCp0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsjJ4HDkogKorT9L2En4dE4/eoq5wRMAUMX8
 XcyRyZziQuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIwAKCRD2t4JPQmmg
 c5MxD/0UlJL1Vxt2/RFbALPdO8hQ83HfKXTCikWNSpxu/Q8B7RYAC8Vp28XV4/dqXH9t/wxsgjo
 54qWRgFINZ/v3CX5weT0TNhoUe3VyVB5Tam9GtX80/5PViZs7+l/UMYN5hzrGliITiup2ScRPW4
 QOqTRAujq1/E4rIsw8w2wfSkHo+xpVNgs1qWIXIVB6+7fN0v7jMGsoj4XZHkvT/AWyIiOW/e9VY
 gwQDgEC0V4S3wBjJodyol5J58HWPbc3RWfOfwy8ILVJsW++47g5Mxm1LUrjpjXjXfn9BYpDu92/
 KfS2HDiSJbjlMJS6gPIKdcqmNzMFwYrRbk7Ws0um8HE9nyD4AaWEij7e1tyJAfEfsStzQCT5TDh
 QagYdQSa5nwM3gyYua3dYmyQ+FeXTUPMqYhz1aSdQLrziyqszXmgsfhvzlxzIT0WnF3r3AKzmTk
 YE26nMUouupRs+Hm7IZjBEga/3GYB131QMqi+n7CuJF6yzviBWqTC7FT/C92jZq7eXX2wqwZvkJ
 M2bVWAlqOGXdLuOGK9nninX97e5wBU0eCBuYADm04VbOfVdGUzTgVh1dCCjX+ZqiX2otFVaPFAn
 r4IqW/2cRNUR5CKbRXtSp2Nz2T6KHWhHJkiofFUgocGsE8B5ten9kPgG3qJvvzFDuWlsYBppxKT
 spVRKA7ZQVqdDMg==
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

Note that table->data could also be used directly, as this is the only
member needed from the 'net' structure, but that would increase the size
of this fix, to use '*data' everywhere 'net->sctp.probe_interval' is
used.

Fixes: d1e462a7a5f3 ("sctp: add probe_interval in sysctl and sock/asoc/transport")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 18fa4f44e8ec8c86f8415b1251ef8a2979c7f823..8e1e97be4df79f3245e2bbbeb0a75841abc67f58 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -569,7 +569,8 @@ static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_probe_interval(const struct ctl_table *ctl, int write,
 				       void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.probe_interval);
 	struct ctl_table tbl;
 	int ret, new_value;
 

-- 
2.47.1


