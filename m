Return-Path: <linux-sctp+bounces-310-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97CFA06046
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395023A8523
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158C81FECB0;
	Wed,  8 Jan 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTk92jOY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10BC1FECAE;
	Wed,  8 Jan 2025 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350528; cv=none; b=m3peyxKcPad6D/YFl59wFBve3+nq43VUKWHlTMEFFzvwtwNtyNYcY+LnEYZmH87QWl3u3ZQKWt03HoAMU/TmUQtogz6uhBbXXl8dS4X7qtj7UeI0IDQs7JXsdmEVfafSwzU//J6TiexS5WB0E00dmjtF7N0Akn4OQKhaQjUDXt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350528; c=relaxed/simple;
	bh=RzoX/Mfle45ycBTiE07FhU2G1d2ZCr++/wDZPC4Mtns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fozf2GV4OVEOWhpEBvjuUJ7I98gkuxlrxs1JK6Y7MQhRpdDa+vGmkVRkLP6JrGuV7RofrDzv+rTh0jLl6gs6rSyZUsri8QP5wBZ+4wOJSlqox+tsihcRZfrw4H0Xf3EjV5qs9j96nTDHoqfr1BJ9ncAJdBVr1kGJC+KwwXWIeyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTk92jOY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8029BC4CEE4;
	Wed,  8 Jan 2025 15:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350527;
	bh=RzoX/Mfle45ycBTiE07FhU2G1d2ZCr++/wDZPC4Mtns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dTk92jOYIjjH2J0dsNf99k8RJ2AzanZtaYpSHqdSGpweraXigfKEv+0upv1IT8A7z
	 KqJikdqcS2pHx7faYDewkPpCBwy5EmrdXszocdpK3WIHs49iYYThLf/06hLpPTkvc1
	 9HnUaohqRu962XNQNPByHTOBMhjSBhBTQdMsNWt3rMwFS7knScEYIIScoh0J9LnU9b
	 h1L3i8IA12uqNWKeWx9JFGER2Ojr7bcpKm1+hpX8sF9/10pT0hflfPUL23WUCKmEZi
	 E9b9eQEznxkTdQFG4dDTst+0DqLb0uxxMZxEHJzYUTMhKwjHb7bqrL5yBruKbN4AQg
	 SujQBQzFnl/FQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:32 +0100
Subject: [PATCH net 4/9] sctp: sysctl: cookie_hmac_alg: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-4-5df34b2083e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1732; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=RzoX/Mfle45ycBTiE07FhU2G1d2ZCr++/wDZPC4Mtns=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsjYAQXsZVHp54/bDIS4iqUYc/+zC1BDbk13
 KVDDIjqTMuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIwAKCRD2t4JPQmmg
 c8ghEACnStxbiJgevWI5Jgt6h5657fEy3C6jSyanXQXC8RxV8wHWDHoZzNFs4hw25GFas1qxJU7
 Vr8/95j23s+r4XRrBdReCL7+uWOWyOVvUTz7k5rym28GHc3qZ/Cg285HyQK2lJAlQUEZR27WH5f
 8rkM/6PTloThkqBdTb7Be0MQyRxTiq9CVKUUDDYzTu/gSstQ8T3iG18vfY7q2kVjNyo/9D0+Q/W
 Z23oDxIT3MQqqyLIplZaQxiLHfuo4zE8J8haW2+RFzeq05aAuXxjMw90TiYOBod8uqRaS/4kaET
 oRoK2QOIBoqoub5Pt7MWFigHWv+fUVLRD9aJ3ADbzlG4V9mnLi70GLMQpBLYMy/3GyVzrwnrt0A
 dPSaxFKbF3iF49NPMn1oDIS0e+SlRz6F4/FLxIuCFuuK4g4BJdY1dW+Zx4wg/FKQAmFiBhhONIK
 l+C4/ZxYCoVpAIUilJYOL52a4Eg5PdfRTgQWUuhMl51s3qw7IcrTKmuQr9J3kW5hGtcvajbQLpS
 y5IRblgIVwYnHH3gy/fvvr8J3KGrQKKrp/FTFQlNWk7CtOBDxzsGmddhsM1Wk9JHivL/xKhJGof
 ResKkg4zExSNS6IssvctlTutR/hxZ/TCnjDXjgI0w8yEMG/gwBXGCuBERrTXneS3KnT5vv1EvfQ
 novUbpb9ZiTk8cg==
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
of this fix, to use '*data' everywhere 'net->sctp.sctp_hmac_alg' is
used.

Fixes: 3c68198e7511 ("sctp: Make hmac algorithm selection for cookie generation dynamic")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index e5a5af343c4c98de1afb27359c104f5030583ac4..9848d19630a4f760238a3a2abd3ec823f012d34a 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -387,7 +387,8 @@ static struct ctl_table sctp_net_table[] = {
 static int proc_sctp_do_hmac_alg(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net,
+				       sctp.sctp_hmac_alg);
 	struct ctl_table tbl;
 	bool changed = false;
 	char *none = "none";

-- 
2.47.1


