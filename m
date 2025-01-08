Return-Path: <linux-sctp+bounces-308-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248FA06038
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 16:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE1BD18888C4
	for <lists+linux-sctp@lfdr.de>; Wed,  8 Jan 2025 15:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107C1FE454;
	Wed,  8 Jan 2025 15:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH6+06AS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED850259497;
	Wed,  8 Jan 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736350518; cv=none; b=DvR+BAT8vwMvq+HZEgzU8pUCipn2hSmBjiNGgMKBGqFPtgCXlzkLXn+7VY9kqNWTuwnIOigfIPvBag8lNPMeT1m4gE2PwxokOC+LIe3GB+gA468NctkO1+ZxNmrtSHQUHI7JIKSu0Nwt8JfU2dXgaI4VNWTTDulaShccyo8QEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736350518; c=relaxed/simple;
	bh=WwnRjI/8/iw1OFb2VHnT5gO6pqS+HzJirrR+KnF87m4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDpH+Te1IHFOQ8SW43U69h3yL4XemLZVv32RkU4k4bNZNzP/3fNllvQNu7zxozkJVK0dXoqFrBk6TrwRpOsGqu/CoUerkBlu5paJNVVL4ejohk2q0V75Ouc8OJ6EucNmiECM6VBGAn25ZFoiq+m49NyEJxaryc/RoJpcSmrNcEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH6+06AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06512C4CEE0;
	Wed,  8 Jan 2025 15:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736350516;
	bh=WwnRjI/8/iw1OFb2VHnT5gO6pqS+HzJirrR+KnF87m4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jH6+06AS0OGJFkxIo8C0AdmMl9hGCe2WjR8aokttVZT5ABdZEiAOhbhNi9Hvf2Oc9
	 Vhj8Za+zyU07taeXAiu0jPdu5VpJM3Sbri35NOrH20+9MANEyDeWu0XtAno7bc/P8t
	 anWJq0Fj/6g98CETEtTG8u45xzcQmQeTjOIjTO/6d3ii3yYQ1Kp7SOaSLh8MQiuxBA
	 RqVk2hEsBFkqpYX74Ja6VFLyn1ajv3AElJDWTkvmKi268ThJfwFyVQ9hd/VjUE0xSh
	 4K456QddI92JuajuRvamPPquo9ydAHQuDAr/+kjddYvZQ3lReaqE788ex9iDnGDFwJ
	 rwEFgDqw5a5qw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 16:34:30 +0100
Subject: [PATCH net 2/9] mptcp: sysctl: sched: avoid using current->nsproxy
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-net-sysctl-current-nsproxy-v1-2-5df34b2083e8@kernel.org>
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
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org, 
 syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8026; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=WwnRjI/8/iw1OFb2VHnT5gO6pqS+HzJirrR+KnF87m4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfpsixzVlWSJc7W3+DiXQbOeuPWYmxtlalL9cY
 aNraDupi/+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ36bIgAKCRD2t4JPQmmg
 c2pPEADK0/j23gnw3Xa9ZPzBVlwodZLcGIupRhenNXzpJQsdQAhzuL4qQD1YuUX4GACboGodjaW
 I82T3P8LTpeQKwyYdbXvGolIGlKNqz1ySAfsFKifdHOoOByplEz6SLqXmoElJl7NxfATfRIwVFa
 UNwercmhNgZo4a528gdBpvoTgAlq1ZYSzint4cOXunSxN3UXJ/jMt8/8y8yb+JDRNG0cOnZOu3q
 LnKhXUpEbZzaZwaFJK2bbQHCrYvvs3KMhc06cb2liGxT6z7J4sardbawtk0PrJb8T01p3CQ6gLI
 To+FNv7WF1n16OWRzXXrjOpB6vfkPsy25XsQAbJ0HAx4Zt4S6EPOXg0BIBzfBgTJnfPv1hzXlAk
 pJh5EU2rarWokt+YbpHSUV/dVxAo47YhYkSqzPx8dIio6pu/seY/S0mlvuFS55RN8E2fNE+0U2x
 OBjDWDDr/k6CUUpTm4hz6KSYerRR6dXLPSlzDDVnWV8ykvE0brnseXZN3voQNt+hBCVnRJsEZOT
 phmOTByFA8kvL0+1huKfzAi50NBWYjUG6dybPNuyoMv//sie/uLbvOec8sI42G8OBgmgkXbO+Il
 kjQCJChAX6VChbM7qPr/zMYyoD7OksF8lW9HFhfE+HkOxI4Txvak9x1R4tUPdi8+Z4E8b1QaKFE
 m/ZwZhf0D1Ay8UQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Using the 'net' structure via 'current' is not recommended for different
reasons.

First, if the goal is to use it to read or write per-netns data, this is
inconsistent with how the "generic" sysctl entries are doing: directly
by only using pointers set to the table entry, e.g. table->data. Linked
to that, the per-netns data should always be obtained from the table
linked to the netns it had been created for, which may not coincide with
the reader's or writer's netns.

Another reason is that access to current->nsproxy->netns can oops if
attempted when current->nsproxy had been dropped when the current task
is exiting. This is what syzbot found, when using acct(2):

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
  CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
  Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
  RSP: 0018:ffffc900034774e8 EFLAGS: 00010206

  RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
  RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
  RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
  R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
  R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
  FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
   __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
   __kernel_write+0xf6/0x140 fs/read_write.c:632
   do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
   acct_pin_kill+0x2d/0x100 kernel/acct.c:192
   pin_kill+0x194/0x7c0 fs/fs_pin.c:44
   mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
   cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
   task_work_run+0x14e/0x250 kernel/task_work.c:239
   exit_task_work include/linux/task_work.h:43 [inline]
   do_exit+0xad8/0x2d70 kernel/exit.c:938
   do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
   get_signal+0x2576/0x2610 kernel/signal.c:3017
   arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
   exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
   syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
   do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fee3cb87a6a
  Code: Unable to access opcode bytes at 0x7fee3cb87a40.
  RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
  RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
  RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
  RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
  R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
  R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
  Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
  RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
  RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
  RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
  RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
  R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
  R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
  FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  ----------------
  Code disassembly (best guess), 1 bytes skipped:
     0:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
     5:	0f 85 fe 02 00 00    	jne    0x309
     b:	4d 8b a4 24 08 09 00 	mov    0x908(%r12),%r12
    12:	00
    13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
    1a:	fc ff df
    1d:	49 8d 7c 24 28       	lea    0x28(%r12),%rdi
    22:	48 89 fa             	mov    %rdi,%rdx
    25:	48 c1 ea 03          	shr    $0x3,%rdx
  * 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
    2d:	0f 85 cc 02 00 00    	jne    0x2ff
    33:	4d 8b 7c 24 28       	mov    0x28(%r12),%r15
    38:	48                   	rex.W
    39:	8d                   	.byte 0x8d
    3a:	84 24 c8             	test   %ah,(%rax,%rcx,8)

Here with 'net.mptcp.scheduler', the 'net' structure is not really
needed, because the table->data already has a pointer to the current
scheduler, the only thing needed from the per-netns data.
Simply use 'data', instead of getting (most of the time) the same thing,
but from a longer and indirect way.

Fixes: 6963c508fd7a ("mptcp: only allow set existing scheduler for net.mptcp.scheduler")
Cc: stable@vger.kernel.org
Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d9b57fab2a13e64b6c8585e821ed5212f59f8651..81c30aa02196d69c55799e5963f6591e416c8831 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -102,16 +102,15 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 }
 
 #ifdef CONFIG_SYSCTL
-static int mptcp_set_scheduler(const struct net *net, const char *name)
+static int mptcp_set_scheduler(char *scheduler, const char *name)
 {
-	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
 	struct mptcp_sched_ops *sched;
 	int ret = 0;
 
 	rcu_read_lock();
 	sched = mptcp_sched_find(name);
 	if (sched)
-		strscpy(pernet->scheduler, name, MPTCP_SCHED_NAME_MAX);
+		strscpy(scheduler, name, MPTCP_SCHED_NAME_MAX);
 	else
 		ret = -ENOENT;
 	rcu_read_unlock();
@@ -122,7 +121,7 @@ static int mptcp_set_scheduler(const struct net *net, const char *name)
 static int proc_scheduler(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	const struct net *net = current->nsproxy->net_ns;
+	char (*scheduler)[MPTCP_SCHED_NAME_MAX] = ctl->data;
 	char val[MPTCP_SCHED_NAME_MAX];
 	struct ctl_table tbl = {
 		.data = val,
@@ -130,11 +129,11 @@ static int proc_scheduler(const struct ctl_table *ctl, int write,
 	};
 	int ret;
 
-	strscpy(val, mptcp_get_scheduler(net), MPTCP_SCHED_NAME_MAX);
+	strscpy(val, *scheduler, MPTCP_SCHED_NAME_MAX);
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0)
-		ret = mptcp_set_scheduler(net, val);
+		ret = mptcp_set_scheduler(*scheduler, val);
 
 	return ret;
 }

-- 
2.47.1


