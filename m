Return-Path: <linux-sctp+bounces-572-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6FACD46E
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Jun 2025 03:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C043A590A
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Jun 2025 01:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A45274FFB;
	Wed,  4 Jun 2025 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFYXCx8z"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EBD241690;
	Wed,  4 Jun 2025 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999191; cv=none; b=eTcjjEK/1ZljlB9vyjqopOtlXFKyAbdIiwBpBPZlTxNKh90T33556ZIF8+UFZ2ShbB7hoXCP0NILK+FlQ6FYEPf9eN/6/7ZzIOWo6HJ3lGm38PoO7XYQrJzH+QhgouF12UCnxNrx9JSBSkI8ea0GYxgRQz2SQbkd6mR4eqrYDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999191; c=relaxed/simple;
	bh=mfdZDm+KLvpt+x8T/c4eRi+y79rfOTetk0I/uHunKYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NAwoVKq2+8v9zv+1ubXAnLzSyu2zO+qzKC5rodOLEksu4ZctAewlh6PDVfE1jzuOOXEhtWrC1EKHxHOtXwU3qYyYaWJMowHZNKmk23TcLeFBLu6vRKbpAGSyk4fSPwlv1A8MUc0vj2fgXT9KnNYAxz2gZQIk923om5cpOoLrWD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFYXCx8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCE3C4CEED;
	Wed,  4 Jun 2025 01:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999191;
	bh=mfdZDm+KLvpt+x8T/c4eRi+y79rfOTetk0I/uHunKYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFYXCx8zdGh+cLbTnSf73NO2AkbnPhwS6JzDpaA1oYlDcJyp4TrTfTatw5QMQKTED
	 KmQ6aSEahwHmdj4y/W2d3KtVFXtQEGdApOAeo93gdbRH/5kNZsKYq+hhF124Gq47CR
	 KCk6FKOf6fwIwdujlDTOb2mL23ssS3Y75m/vtn1RCY+xzc1gabVn6vL36Ku4+tWvLM
	 SPk5iJ/AVUlLrPwBcWQt6ScURVU85E4HWCMiIs+eU3dESgDxaCzU92aYd5068lLpDh
	 C2gfD7roMnPFgvPJ7UxyGqK8y5F+0sCIaD5NibYgzarxxqlZPprpKgzUzNHcfoiHQT
	 AnwM3B/Gn4Imw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Petr Malat <oss@malat.biz>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcelo.leitner@gmail.com,
	linux-sctp@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/27] sctp: Do not wake readers in __sctp_write_space()
Date: Tue,  3 Jun 2025 21:05:59 -0400
Message-Id: <20250604010620.6819-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010620.6819-1-sashal@kernel.org>
References: <20250604010620.6819-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 3d6c9e35781e9..196196ebe81a9 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -8849,7 +8849,8 @@ static void __sctp_write_space(struct sctp_association *asoc)
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


