Return-Path: <linux-sctp+bounces-306-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF8A0602F
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB4C7A29EB
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3578185B76;
	Wed,  8 Jan 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n82hfD1k"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67ED8259497;
	Wed,  8 Jan 2025 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350505; cv=none; b=PIVRoBb7s3iXPNbY1+E/Dc4c3saYdVLQ7XrwspTIxwRZ+GPiak76aysNNzbW0K8pqUfm801vx3w4NciWpsHJ4RkQsV9jjQYAF2yuX8dmXsH6vsVWWjTCtnMADGjt6jTfwlQYyPG6wr9N0lzZOp4UO6DX7TQb4r+073/r9OrG1n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350505; c=relaxed/simple;
	bh=ub7Pv69Wzx184pwG+PnlP1zLVQpPZk26HKdPbd+/poo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tZneJu3yn0LF3KMowTwJ3IJxCnxGzdPOSfdhKqV5Eat1grblOPMmuqeSZ7i2vGte3GFTjsM/Pz7meQNMO84ROqa78c42h63yBLXFy9W4/dWS5nuRaqSvH9IFTzbJ2VRSKOc/aRgiTYJR0522f08cveBP2RqnKs1MwsNbgDmWl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n82hfD1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B44C4CEE0;
	Wed,  8 Jan 2025 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350505;
	bh=ub7Pv69Wzx184pwG+PnlP1zLVQpPZk26HKdPbd+/poo=;
	h=From:Subject:Date:To:Cc:From;
	b=n82hfD1ko/ARf5EBbYNRhNgONRIlsrvYTuTDRtRl/AToYL0Kv1vRru/OdjBHQNx7k
	 YSZqkOQGn4YkE8gW7YGD4YsRODb8n9DhH58/cR+SUN24CE5Adk44waZVxdowg+ygW4
	 ANSPxox1DQZDZJfxsvxh0FlvbCdC0u2NFYKA6Lufw7lWolycFUNnkObaLfCG4qvE9B
	 tSekK6B0HNkfudqj0s9Lj8VLisrTr+iuL96CMDkEMAdRH2EblqgmlLrq7lqoFfkcnc
	 zG0TsOwffj0yXeHlv/UXvB9dCzErwd0JDFbXQeol1fqi+tedJlIbMhpK0fPT7r7pDw
	 eoW27EJv7uwyQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/9] net: sysctl: avoid using current->nsproxy
Date: Wed, 08 Jan 2025 16:34:28 +0100
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-0-5df34b2083e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASbfmcC/x3MQQqEMAxA0atI1gbayowyVxEXpcYxIFGSKop49
 ymzfIv/bzBSJoNPdYPSwcarFPi6gjRH+RLyWAzBhZfzrkOhjHZZygumXZUko9im63nhuw2Rgo9
 d20xQBpvSxOd/3kPpYHieH+MMVjBxAAAA
X-Change-ID: 20250108-net-sysctl-current-nsproxy-672ae21a873f
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
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2710; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ub7Pv69Wzx184pwG+PnlP1zLVQpPZk26HKdPbd+/poo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsiv0PQzgjS5i+apDYO3W7kw5of+oL8PulAp
 3VWanJVof+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIgAKCRD2t4JPQmmg
 cwtZEAC8lZ3J3v35LQZmG6EEU3E/LdaNGB/G2xRDIL9v/HPFzySs20kfSKwxWBEUDEH+4pOWfv8
 0Uh3nvFrVp6nUMRvzVADcH4BzvGsS5LqyrDBOS1Ut+rB7lKfbHGFf3aEd/PzrfZ+a67OQnpmXqR
 AYxCStjejy3u7n72awngmI6ueTbSYovY13EOe3I5P3KlPyeGLhAxea6w4TDF6YwdPmhITWk0SUF
 ygjAOq1xMSbUfGeXxRQBdnRBc3RSRTwcJ9nQWcM7sQef+Pei0RRi/tz1DSRCSXKn82OsDfryAVm
 uBgY8e+b2ciUoZ8xongH/cF7XOV/4TjpG329a5cdhlgj597mVjtTW52NfrP7PfzEICp3Vsh+K2S
 qgck+8ubL5TO0qU+7lTvK0v4OLgWsU61sEiH+rYmxmINiQO9i3+aqzwAwvUylDPTm71xz02SgK2
 Edo7zGixArSfpeZUfUh6WXDLoeihBpQHsRiTuFYGWs7zUl95Rf+6JD0jP2U/EGwcDuRxY6jg8FX
 7Q7rhl02qYC1yMI64hV/r9K7sqswDPsyp/6awgtO8/YpckmBzujRkX8SfFTrHmQe6BAvnNjsGGg
 Rpv0aRCuW8DPShFxoEq1X0UnCRXcQ9k1jD1xG/hfLBz92WZfJeMXlNZ6r+6jtOwo04k5Hwp2Oz4
 WsMkyGA8h0nhIGw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As pointed out by Al Viro and Eric Dumazet in [1], using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns as it is usually done. This could cause
  unexpected issues when other operations are done on the wrong netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' or 'pernet' structure can be obtained from the table->data
using container_of().

Note that table->data could also be used directly in more places, but
that would increase the size of this fix to replace all accesses via
'net'. Probably best to avoid that for fixes.

Patches 2-9 remove access of net via current->nsproxy in sysfs handlers
in MPTCP, SCTP and RDS. There are multiple patches doing almost the same
thing, but the reason is to ease the backports.

Patch 1 is not directly linked to this, but it is a small fix for MPTCP
available_schedulers sysctl knob to explicitly mark it as read-only.

Please note that this series does not address Al's comment [2]. In SCTP,
some sysctl knobs set other sysfs-exposed variables for the min/max: two
processes could then write two linked values at the same time, resulting
in new values being outside the new boundaries. It would be great if
SCTP developers can look at this problem.

Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Link: https://lore.kernel.org/netdev/20250105211158.GL1977892@ZenIV/ [2]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (9):
      mptcp: sysctl: avail sched: remove write access
      mptcp: sysctl: sched: avoid using current->nsproxy
      mptcp: sysctl: blackhole timeout: avoid using current->nsproxy
      sctp: sysctl: cookie_hmac_alg: avoid using current->nsproxy
      sctp: sysctl: rto_min/max: avoid using current->nsproxy
      sctp: sysctl: auth_enable: avoid using current->nsproxy
      sctp: sysctl: udp_port: avoid using current->nsproxy
      sctp: sysctl: plpmtud_probe_interval: avoid using current->nsproxy
      rds: sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy

 net/mptcp/ctrl.c  | 17 +++++++++--------
 net/rds/tcp.c     | 39 ++++++++++++++++++++++++++++++++-------
 net/sctp/sysctl.c | 14 ++++++++------
 3 files changed, 49 insertions(+), 21 deletions(-)
---
base-commit: db78475ba0d3c66d430f7ded2388cc041078a542
change-id: 20250108-net-sysctl-current-nsproxy-672ae21a873f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


