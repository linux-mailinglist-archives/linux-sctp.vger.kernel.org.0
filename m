Return-Path: <linux-sctp+bounces-307-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1839A06032
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C3E1670A5
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF661FCF4F;
	Wed,  8 Jan 2025 15:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shEHDZtY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05713259497;
	Wed,  8 Jan 2025 15:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350511; cv=none; b=E+dd2KcTtNXauaJ2ODTuozWJ3gcyeilpUL9kU7md1Ko3Oxd4Jjwv+lQVhIxHeZ6Fvi9bR3lCiMOTI1DLLBcTlVBYuS86BZaExieUazHPnAale/yqurpydB9/iQfZbOBCt0ddXRjbGUwkXACVegWChvpXDfc2LPhJS3ics4PqvGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350511; c=relaxed/simple;
	bh=hIueIUZaxmfqgKEY/FmottlVw/0rUVh36j7Ej9VoLM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XnepIbOtdVfEmX+5AxQGSkfTYLRT6tnKNkE8NYyzv3P4n02UHsKUUbYN1O3VKM6mXqAnVQ/lTobbXswrCy7SfIA2h6lKK6HANE9f1LTQSSomRfOgXil37j4xpumJfC3+CSZFDjbDUPuPeXv6Y+dwBtVzlV3b1uccCqxeiXAF+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shEHDZtY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C50C4CEE3;
	Wed,  8 Jan 2025 15:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350510;
	bh=hIueIUZaxmfqgKEY/FmottlVw/0rUVh36j7Ej9VoLM8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=shEHDZtYNWfyW4JudNaIOaUbvPSgS6JTAc/wW3s8PseALXtnJ4SoxcJm2pd7InOar
	 iKUKM4Fn738sH6Hn3tlNeugOYdof9mAfAPYuud/qLVpItMi0S4eSYfG1Uc1cZuof/6
	 OLbCKu++rXqWZoikJ/I+rAcQ4/3cHAbFo21kWrrXPItPZT8g8XakrSrX47qay5IiFF
	 5B/eS7Pjp8xEtr1qs6XjRCDjMHsTLPILPFXV0h0WphmEDJ4SP2QQGvfyKmjPHMBcqw
	 0Z5VJI3yo7kP/zffyxI474iDcLa4p2BhI53yB7pajhJg+/DCCLHhPt2Encz7hiZp36
	 UvrHO7Majpsxw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:29 +0100
Subject: [PATCH net 1/9] mptcp: sysctl: avail sched: remove write access
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-1-5df34b2083e8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=hIueIUZaxmfqgKEY/FmottlVw/0rUVh36j7Ej9VoLM8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsiX4/l17Z7l01UKCkmrIDO8CxYVFp7jJn5c
 2F45JJHuP2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIgAKCRD2t4JPQmmg
 c0l1EAC8OTeXe1Zwwsh4/vjLo0Bxad6vISYLRAo11hH08jUlq/PXUXCXPJgIIEal9zJyeeUfQJR
 2vuN0sX5wX1EF99+VlCe8suASxn2fV+ffaUMSsFTNe+dxTZA/GIHqjhCpQIzRuOrvndw2Pk2zNN
 XdhuRfmbdsRxrJ2XgzNS5maV/UFbrfmdwedbF6lGTX6S9qnDKfi88gYWJle0+TpMVMcLwRxRFW7
 3mvNyjY5+5hr7BXZgFHJl3BTHhOamqtYvQEwddnqeamRl931htkEwhRmwp806+qcKV41nzmcKjY
 0Z1chFTuNombDRNBhxVUri7yXSM/88i6HUQAZZH+Bi81CEEwctgRktiPobgMh4hnG8nZNHIvZmm
 adUuTN8N+fd8SgN6MGKJmHnnqO7/T/JmGj4d+BAJvHtm3xYjHTwZMEdHIilTTTs2dozTMlX5WqU
 vvhmkSiev1khcdTnMKUNtZ17Iz40opR6yzG6qIGR5deJSWVxGQkn7KECOBrkbATcsOcLnN9+P43
 SxcjWRcEquRXzmqNI1gvruXWeFGuDEgmECC7rUtkJMRJxAzIQ2QpgmFAuQV3jcbLbFq5Vmm4vYK
 x2aCfqWajQdSAxpbwcrAeECrTCJ87dWnMSCKMMy3mvRDZq7Q5YfC8obnyuomKVGUG/5g8AHA/9W
 drK5uks9iDK7AFg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'net.mptcp.available_schedulers' sysctl knob is there to list available
schedulers, not to modify this list.

There are then no reasons to give write access to it.

Nothing would have been written anyway, but no errors would have been
returned, which is unexpected.

Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
Cc: stable@vger.kernel.org
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 38d8121331d4a981d4a60ebd8f6cd9482fc2b50c..d9b57fab2a13e64b6c8585e821ed5212f59f8651 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -228,7 +228,7 @@ static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "available_schedulers",
 		.maxlen	= MPTCP_SCHED_BUF_MAX,
-		.mode = 0644,
+		.mode = 0444,
 		.proc_handler = proc_available_schedulers,
 	},
 	{

-- 
2.47.1


