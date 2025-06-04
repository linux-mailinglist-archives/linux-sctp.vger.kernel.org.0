Return-Path: <linux-sctp+bounces-567-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 163DCACD242
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Jun 2025 03:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C314E1899D44
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Jun 2025 01:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AD620C016;
	Wed,  4 Jun 2025 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKPYQG7g"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784924B5AE;
	Wed,  4 Jun 2025 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748998574; cv=none; b=VJWJGZGDay6BkeZOCkJrlqjRvMROdl8w+AWeVbpKTSyfYyH0NKAmiOzPvqI1e7aaXD72zudyrtS6MkisFHjt5L9REJQjF3ROzK+VCesCiws55qE0VUNfWh3UjBceG5JDqwNNTX42Rlk/FOtLZH0Jn1n7xa/r8grM0RLvo5xf2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748998574; c=relaxed/simple;
	bh=XbjDtZGA81sTlSc5HaEVqzyX/b2ASvd7c8eC6cp+m2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XT86QqzGUIEBWLJyZIeFvZIImEM8/uPj94bd1FO4zuRoGy0wxjohVMuc844ow7bsHqNxJgDLdWZjEIMkWDM5HJXavboKCN2j3sKbSWBKyvOoJZCdf9TRjyHloE3/4ybXWf3VBTDincj+hMUxQjtwh9OefP0Dd0idOde2KgY9JPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKPYQG7g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF36C4CEEF;
	Wed,  4 Jun 2025 00:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748998574;
	bh=XbjDtZGA81sTlSc5HaEVqzyX/b2ASvd7c8eC6cp+m2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nKPYQG7gdLCiLO2vTuz0odoUnT2CVyXXEeg8qTuBsrulwwFWMKSejkeJgeT5cBo1z
	 e3T4wVB3wFgdHUVw7EFYCAXYWq9Zpp7rDS2TNGtRlq2rQibZ8bS2euo1KX24DT/fyQ
	 5/N6l4Wa1hIm2JN/ok0yUCV+Pu+3NKoBx97vN81xwHleVd52g8ASNISFDPj5N+y5BY
	 LC/uIhzulMwXqAcBZc1uMP24ESqLLJraw0X9DGOdqIKHFrl28o3isPxAAPGle41J4T
	 61dtGlPuAa00VcXGPdzj/mbn4/0O5yFKvk17Ut+pIwSCOBHCAzGW873ouXWzMqSz7e
	 S9l/4i4lxS9Mg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Petr Malat <oss@malat.biz>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	marcelo.leitner@gmail.com,
	linux-sctp@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 019/108] sctp: Do not wake readers in __sctp_write_space()
Date: Tue,  3 Jun 2025 20:54:02 -0400
Message-Id: <20250604005531.4178547-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604005531.4178547-1-sashal@kernel.org>
References: <20250604005531.4178547-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.9
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
index 53725ee7ba06d..b301d64d9d80f 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9100,7 +9100,8 @@ static void __sctp_write_space(struct sctp_association *asoc)
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


