Return-Path: <linux-sctp+bounces-312-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B24DA06052
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A874E3A88DF
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1BC1FECCE;
	Wed,  8 Jan 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKoie9YQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427561FECD0;
	Wed,  8 Jan 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350539; cv=none; b=dr6O7UT9CMGErFAAjyL9Bc54wSlHajyTeC36RGVMMTeraEhmr+woQLmoxMrxDvLmQAYY2iDwUZZakOV3xabVTPPo7cfR+Qsrq0bqFJ/th08A2w9PjEN1rouf62DYG/B/Ko31mhxP1thCE/JLaefH2Xgy5HvMnns7UgwcVQK7Djc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350539; c=relaxed/simple;
	bh=GtD13rz6CUq4cx2jxPDigJz1ycwU6vRnNISdtqEgmsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9xrwsPEBL+gCy8uDujTrdx+h9w3Gsyd1z6Fr0wKyQlUqgCzUI7Dj6g7vi24WvpTSZQNwK2tco4Cw+vnT5s0JQKtYlNd/VZowRux5o+nuL1TMUOFDtNIyX76gkoEPwWA58XbTILtXmDT1ff5Dd+3QUM8Sq4N7p2GU3T0crMstYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKoie9YQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3395C4CED3;
	Wed,  8 Jan 2025 15:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350538;
	bh=GtD13rz6CUq4cx2jxPDigJz1ycwU6vRnNISdtqEgmsk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cKoie9YQGfESjtvNWpnYGBrKoIBtcln+htnzvlgnSc/y4stD80RdGpZZonZNsOy6i
	 Sl3Ma5yOLkB0xgxIr6qsCElkmvJFZjTVYLEz5soK9fl/lwjXe/G1KaGqSC+9TNK7w8
	 xHcU33q/crWQAnDxD3qEPmjOFJdtY5k8N4bOZWhKtbEkQmPM995/GS3gTwsVYgSz5h
	 tyrSd39pCM8plyHN6tabi6JhUl02NdhlZMOLr3B9wOD/sd+DALI73MIkLO3doT8p/x
	 dY3Ghzra76JILAEuTXwb2mylLKIAhaP6pNR/oW8sSzqbLt1yhZOdYWxUWSuA2uf7mo
	 safongD8y7EmQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:34 +0100
Subject: [PATCH net 6/9] sctp: sysctl: auth_enable: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-6-5df34b2083e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=GtD13rz6CUq4cx2jxPDigJz1ycwU6vRnNISdtqEgmsk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsjb7qb1AcTm3VoJxHCWqJ24AOe8+8WyLgkf
 UMdW7nFiy2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIwAKCRD2t4JPQmmg
 c1h8D/0Q/ESUg8goIbYyWiYTOKiDMMAKoIny5mVEwBGkzXzB/rd4jpLvV9ls8nk42pXOBSBnu/P
 L2bq7QEDA4uI1C7nkdZMHgcRyHAhcNBz0L+rzAjpFkqGqrnFWDPTXBdgC/rlTh4Ue2JXfhMDwCU
 /wC6fGxjqIMh3EUCow7WyIwQGD5pboo4YzIlhJpr9B24IfBKVVAwdttZnl44tCEGbCn0ydbdamF
 d1ZEPSveXA5klTqYfIK8DwGKbNdxcfZBZ7nIukr6GxY4iVghQAD88Gv0ZNqoKeXvNa+VIjiWJNb
 ZFMjZ68tmsK9pN7E5qgdovWywRFeKruhzRHb2jFoA2Oh0kw0Ra0B20Zx0gxY/6H8SEOkP1q4vbh
 UOvFsGecDlWR+uIPG2gZfMwRY8ouRMtVV1NbMbOC4SshSKbxnBuZ759oLXHhod246VwVo882V0r
 Mp1gWQBFJwIDdQglORaBtNGmmTNeO07nGrSxoacbi8BXU4dqDolZtVWOv0La+xz0ANvZy1LmIwS
 wDcgv5kyIJQyGiMeZv1QfbDpfnJ8IgTgMlOVqTLlUvnV1AA9bPi4Ei6/W74OB4yZo+CU2wjq4xr
 2aQdFkwRu8GryNoS+HQLTEW2sdp2/r+aUX6A6qhnfVeotKZp9+yRaUjSBi/5BhJXpo4Q+kLboNV
 UFhuuiYfMqhzJWw==
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

Fixes: b14878ccb7fa ("net: sctp: cache auth_enable per endpoint")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index a5285815264dfa9d88d1d71244f309448e97a506..9d29611621feaf0d2e8d7c923601ab374515563b 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -499,7 +499,7 @@ static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
 	struct ctl_table tbl;
 	int new_value, ret;
 

-- 
2.47.1


