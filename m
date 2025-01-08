Return-Path: <linux-sctp+bounces-311-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD20A06048
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD9E87A2CD5
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A651FFC6F;
	Wed,  8 Jan 2025 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUm8bROV"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDC1FFC68;
	Wed,  8 Jan 2025 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350533; cv=none; b=raqu1TYc0Wuq3c4YRG4DP4HfsDkMFVfr/1W5mgdbeMWYCex1deZFp1JpchDsrKPuBlwYfnDsY8Pixvu8/64PFo7fSvps+06R5Ja9JuzJrddREiOtHsCttSXqknyFZDR+IfZs8UBl/OeXhidIzsHHao6UUKip+vqMtA48MB3667M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350533; c=relaxed/simple;
	bh=ayV3wzrEF51iGpmrpDx//XVLQY2a3A5Dl5YwOxyjoc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XlBRqfnxsbQwGJtxc2vUOcCTQH3SfCWDZXbHmiumCNHU9tvhg6xTs6lMkTnkJiDs4REjUT2FseGlJjjS+K8PWG6u98gcMBp6TRkxyJkGgpSpIk69cYX9HCqUd/gI+P7VfnBmRJvHKOcc1lXH+OWd6eLY8fB8CiOejOpZJWxOKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUm8bROV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFEEC4CEE3;
	Wed,  8 Jan 2025 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350533;
	bh=ayV3wzrEF51iGpmrpDx//XVLQY2a3A5Dl5YwOxyjoc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UUm8bROVSesTFjcICdqH95oLdhDDpmuf3VnnM8PRJGauOz1ko2glctmoMKJk3h4rd
	 3bKFgY0fgwH8EY9ghOnJp2sRDn/dhr0dQmnpPqCu36QvBFEVvaVlGAstzUkw+EJN3N
	 /nCL0/ppURULhAkBwvp2PTm19nCri6ZriWta4Dzk6HoE0mE+ojdEYHFae2xrYhQovq
	 cD//tmHu2LVONpeYtMnhvAeIyTcD2oqvZEpr5v9f5/IvRbnPUf2ph16ow9PSvUcgUt
	 FLjs7bhji0OcD7a1RgBCnn+dzK7wz6pNjm0OIB8Mgu5UJJuRRrycytjY3UcaBqcoQ9
	 9+SC+joUEZlaA==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:33 +0100
Subject: [PATCH net 5/9] sctp: sysctl: rto_min/max: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-5-5df34b2083e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ayV3wzrEF51iGpmrpDx//XVLQY2a3A5Dl5YwOxyjoc4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsjKGaEE29cJY8jZk9VxvV177Cxn7ythD79l
 qQJXxOtVZ+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIwAKCRD2t4JPQmmg
 c0WIEACibXRVeRZTRpD7TX1zf5fLoc3vz2KC9nbsZmyUDM6hLKBkTg+CwzD/H9XDnTCpwFWAqM8
 d/nLyNtJrVUWGNb65WXelZg+a3kngwzQeXs6sOPyVG8RNaOJe2yzMp/2np5nReRtLqZrPeO5XVZ
 6akIfby1VCWGdlxLvOyelwNWHRHm3DYgbbUK7foncQiJktnXUYijsy4pEqrFQeOjsjpONoM9E4E
 ehfRwoTaYmkHjSI3w4CsMtSeIrID9Xo8A1vKvKnr+h2eRF8DBu2MP01jjfQM4CjsLc/f421u76e
 9JDndty81Br5Wh884T8GMQwfFcxVDCcS1Dh1EX/UoT1Bszbon2mQn2uyFzxhO4Q+wvU0UDcizv4
 l93nK6hz2SXthsD1wQQ/XpCyfnqWc0m6xylIPXhPimvhmIOzVSIMJWOO7XnZOa9tUjDwcshXHCE
 7KuAzYurIP5DTa7r47MaZxOtdo5+8/ueyDssb/oAQ7LBktATwEGPHnQ955Y03Sc8wHEo79V77pu
 yVbcOmCCOymfo+r/BenN0GBsMnbuGM01g9plN1mWDYJ7E61G9RTc/ot/paCEx0tPEWGQkUJd7J8
 UqJoLnmQg9ndoiyW9/QhimjCktjVad0tS6Vsyh0p1L/iBiy458OR/qddNsFvKoh0YXjiDgRRr6u
 6ByAZleuGoeW9hQ==
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
of this fix, to use '*data' everywhere 'net->sctp.rto_min/max' is used.

Fixes: 4f3fdf3bc59c ("sctp: add check rto_min and rto_max in sysctl")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 9848d19630a4f760238a3a2abd3ec823f012d34a..a5285815264dfa9d88d1d71244f309448e97a506 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -433,7 +433,7 @@ static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_min);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;
@@ -461,7 +461,7 @@ static int proc_sctp_do_rto_min(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_rto_max(const struct ctl_table *ctl, int write,
 				void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.rto_max);
 	unsigned int min = *(unsigned int *) ctl->extra1;
 	unsigned int max = *(unsigned int *) ctl->extra2;
 	struct ctl_table tbl;

-- 
2.47.1


