Return-Path: <linux-sctp+bounces-569-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F37ACD387
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Jun 2025 03:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513D11756D4
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Jun 2025 01:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4357E264A76;
	Wed,  4 Jun 2025 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFPryiza"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A003202961;
	Wed,  4 Jun 2025 01:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998956; cv=none; b=Wc/+Z6J3T/Vf/NVpRyc5PXDw7w8RSp9HHe3XIBBRQ/FF0eJkTS/H3XecawWuxXnJQ39g8Gx0pol4cXwqOzqpSXq6LVTsvHRbJNTELT+OVmmoILNzfGoGB6VoxkxQ8BvCLqC//WpWzIdJj2gURQazkcbIpqX9H/2Dvbl2xuie6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998956; c=relaxed/simple;
	bh=qRF0GB9M0xbizYuJeyiMlpyA5tApnc9Nb4DCyv2HXJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ec+HuXOyytECEUlkrVD7wwcgOmwhMMtsoyULdY5T7VNb/9sFm4muevsw76olJDdmIJgoWQjHeVGGBShRr4mqiwx6xNc7N2MmOjSVYKCOTsiRs9J978qYZXqFMOmUgNXmg9qUWWqpxlUvwThvnSGEdqeIKRfZGmVT+sPpsi8fthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFPryiza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0050AC4CEEF;
	Wed,  4 Jun 2025 01:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998956;
	bh=qRF0GB9M0xbizYuJeyiMlpyA5tApnc9Nb4DCyv2HXJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFPryizaQgvCyh/4U6ORW83YLDuadLqxc3ZfsOVV97yDtOJIr7ixoWLdUFeU26xgx
	 xLiKXOFF4UXCWeSNRPlPX4wAhig04m89idHllSw/QfmTscQrJJLFxC29Gk2WGY8VOK
	 O8AeftsklYX5RnUWXWiArM1UxulV0+j0sOdPKR0hHx7O9eASlhV4md9jK/KfUoGxMP
	 s33TZwQ1aXJRCGvCet2yvTdbFcJAZ62cWNI2jqkuib0xSyZ5poXyE5HslKGLQUcFix
	 Qr2eSGP2RQEv+2vC8XfbPiuOj2OjSghFcsupBBJ1Ci4GYRq9qbPQ/6kTRtWHMGX2Z8
	 /OAW2WaTX+Dgg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Petr Malat <oss@malat.biz>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcelo.leitner@gmail.com,
	linux-sctp@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/62] sctp: Do not wake readers in __sctp_write_space()
Date: Tue,  3 Jun 2025 21:01:22 -0400
Message-Id: <20250604010213.3462-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010213.3462-1-sashal@kernel.org>
References: <20250604010213.3462-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.92
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Petr Malat <oss@malat.biz>

[ Upstream commit af295892a7abbf05a3c2ba7abc4d81bb448623d6 ]

Function __sctp_write_space() doesn't set poll key, which leads to
ep_poll_callback() waking up all waiters, not only these waiting
for the socket being writable. Set the key properly using
wake_up_interruptible_poll(), which is preferred over the sync
variant, as writers are not woken up before at least half of the
queue is available. Also, TCP does the same.

Signed-off-by: Petr Malat <oss@malat.biz>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20250516081727.1361451-1-oss@malat.biz
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and comparison with similar
historical commits, here is my assessment: **YES** This commit should be
backported to stable kernel trees. ## Detailed Analysis: ### 1. **Core
Issue Being Fixed** The commit addresses a specific bug in SCTP's
`__sctp_write_space()` function where `wake_up_interruptible()` is
called without setting a poll key. This causes `ep_poll_callback()` to
wake up **all** waiters on the socket, not just those waiting for
writability (EPOLLOUT events). This is inefficient and can cause
spurious wake-ups for readers waiting on the same socket. ### 2. **Code
Changes Analysis** The fix is minimal and surgical: ```c // Before:
wake_up_interruptible(&wq->wait); // After:
wake_up_interruptible_poll(&wq->wait, EPOLLOUT | EPOLLWRNORM |
EPOLLWRBAND); ``` ### 3. **Consistency with Existing Patterns** Looking
at `/home/sasha/linux/net/core/stream.c:41-42`, I can see that the fix
aligns with established patterns in the kernel networking stack: ```c
wake_up_interruptible_poll(&wq->wait, EPOLLOUT | EPOLLWRNORM |
EPOLLWRBAND); ``` This is exactly what TCP and other protocols use in
their write space callbacks, making SCTP consistent with the rest of the
networking subsystem. ### 4. **Comparison with Historical Similar
Commits** **Positive Indicators (matching YES backports):** - **Similar
Commit #1**: Also SCTP-related, fixes socket behavior issue affecting
users - **Similar Commit #4**: TCP polling fix with similar wake-up
improvements - **Similar Commit #5**: SCTP wake-up related fix that was
backported **Risk Assessment:** - The change is contained to a single
function (`__sctp_write_space`) - No architectural changes - Follows
existing kernel patterns exactly - Low regression risk - improves
efficiency without changing core behavior ### 5. **Impact and Benefits**
- **Performance improvement**: Eliminates spurious wake-ups for readers
when only write space becomes available - **Correctness**: Ensures only
appropriate waiters are woken (those waiting for EPOLLOUT) -
**Consistency**: Aligns SCTP behavior with TCP and other protocols ###
6. **Stable Tree Criteria Compliance** ✅ **Important bugfix**: Fixes
incorrect polling behavior affecting performance ✅ **Minimal risk**:
Single-line change following established patterns ✅ **Small and
contained**: Only affects one function in SCTP ✅ **No new features**:
Pure bugfix ✅ **No architectural changes**: Maintains existing
interfaces ### 7. **Clear Author Intent** The commit message explicitly
states this change makes SCTP behave "as TCP does," indicating this is a
correctness fix to align with established networking patterns rather
than a new feature. This commit exhibits all the characteristics of a
good stable backport candidate: it's a small, contained bugfix that
improves correctness and performance without introducing new
functionality or significant risk.

 net/sctp/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index b84c5e0a76f52..adc04e88f349f 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9094,7 +9094,8 @@ static void __sctp_write_space(struct sctp_association *asoc)
 		wq = rcu_dereference(sk->sk_wq);
 		if (wq) {
 			if (waitqueue_active(&wq->wait))
-				wake_up_interruptible(&wq->wait);
+				wake_up_interruptible_poll(&wq->wait, EPOLLOUT |
+						EPOLLWRNORM | EPOLLWRBAND);
 
 			/* Note that we try to include the Async I/O support
 			 * here by modeling from the current TCP/UDP code.
-- 
2.39.5


