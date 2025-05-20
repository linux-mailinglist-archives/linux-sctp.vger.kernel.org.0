Return-Path: <linux-sctp+bounces-542-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75279ABD19B
	for <lists+linux-sctp@lfdr.de>; Tue, 20 May 2025 10:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E5188A4DE
	for <lists+linux-sctp@lfdr.de>; Tue, 20 May 2025 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1371E835B;
	Tue, 20 May 2025 08:15:53 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8817BD9;
	Tue, 20 May 2025 08:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747728953; cv=none; b=E9bRXe6PEw7uCijliOlRLxeDCIudyK04DLyWbMJ41cn7LiesKJ6CnTnbXhmUAhxQyL3BNAp90dxD6Zjjs7u9O/6ZhqLHl3sQAqwFgeiaA2hB6CB7pjpmpLj4XADuvxwqXvm5QUpkAqrXoY0SUm6CXbNPkGp7F4Mqi9ra3umeHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747728953; c=relaxed/simple;
	bh=NB8ORiYqiAIYhMj6I8xu6C4FPpBs3GPJsB/Dubsizto=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T22nw5BOxZ7j+cw1UfSwxJofscmRkwwNj/e5yYGqudSsWO9FMCDoHJ7tRS4svuLnp4GHCFmtR6NMIla8nMALicH0dqTLP9JC6HTdRW9l+/Jk/YSmcgqiGsxed7IMhgb5l6nVZxXRziK51GikntSDrBvRPygW4vp4jfyYHxPs5tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K4hXrr009585;
	Tue, 20 May 2025 01:15:34 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46pnr3jt9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 20 May 2025 01:15:33 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Tue, 20 May 2025 01:15:04 -0700
Received: from pek-lpg-core1.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Tue, 20 May 2025 01:14:52 -0700
From: <jianqi.ren.cn@windriver.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <jianqi.ren.cn@windriver.com>, <marcelo.leitner@gmail.com>,
        <lucien.xin@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux-sctp@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH 6.6.y] sctp: add mutual exclusion in proc_sctp_do_udp_port()
Date: Tue, 20 May 2025 16:15:07 +0800
Message-ID: <20250520081507.1955494-1-jianqi.ren.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDA2NyBTYWx0ZWRfX+n+iUgfkzg3Y wHrraqzYkGxynROp9QEXMs90NRx8mwVZwxqMtUhKzhGoqbCE8G4TrehTpgSK15ScttMwEUMJRLV hDWDaq+5SrMu910kw1SCbjCyc18nAebjrYqbHWDqk5UnYdBAUSnLqqzwdo1jokhkVW1unRKKwYl
 viyUKVy0+iMI2CFQC1Aib2fWBwGopH84B+zmmSR9g7jZ5tR2c0Bug4hGuREyAgLbcEqguBnrgym kfMCFNvwbtBDRB415p37e9MbuZXOLqn9CGJl3pyLA0vdkY1mRPvds02B6TcdJHnSxlFhovITBus rsyq/hSDQwMytpYzzOkjfpREHYejy/zypLT4j1eUJeaYwScVmMom6GXt/DQZ/goJYYULwHNueXa
 YKGXbTVCzq71BTQdXOIAGP8mf5zw1WUQtuLhG+zbSH2MxZ6g9s4eMBWUaGwK162cWa+UazTd
X-Authority-Analysis: v=2.4 cv=Z8XsHGRA c=1 sm=1 tr=0 ts=682c3a25 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8 a=hSkVLCK3AAAA:8 a=pGLkceISAAAA:8 a=t7CeM3EgAAAA:8
 a=ZVfp-KmhnKN58tcK2D4A:9 a=-FEs8UIgK8oA:10 a=FO4_E8m0qiDe52t0p3_H:22 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: h9M3NKwPA85_bGjtPcJgPdjDXhfF6A0N
X-Proofpoint-GUID: h9M3NKwPA85_bGjtPcJgPdjDXhfF6A0N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1011
 adultscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505070000
 definitions=main-2505200067

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 10206302af856791fbcc27a33ed3c3eb09b2793d ]

We must serialize calls to sctp_udp_sock_stop() and sctp_udp_sock_start()
or risk a crash as syzbot reported:

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 1 UID: 0 PID: 6551 Comm: syz.1.44 Not tainted 6.14.0-syzkaller-g7f2ff7b62617 #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
 RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3653
Call Trace:
 <TASK>
  udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:181
  sctp_udp_sock_stop+0x71/0x160 net/sctp/protocol.c:930
  proc_sctp_do_udp_port+0x264/0x450 net/sctp/sysctl.c:553
  proc_sys_call_handler+0x3d0/0x5b0 fs/proc/proc_sysctl.c:601
  iter_file_splice_write+0x91c/0x1150 fs/splice.c:738
  do_splice_from fs/splice.c:935 [inline]
  direct_splice_actor+0x18f/0x6c0 fs/splice.c:1158
  splice_direct_to_actor+0x342/0xa30 fs/splice.c:1102
  do_splice_direct_actor fs/splice.c:1201 [inline]
  do_splice_direct+0x174/0x240 fs/splice.c:1227
  do_sendfile+0xafd/0xe50 fs/read_write.c:1368
  __do_sys_sendfile64 fs/read_write.c:1429 [inline]
  __se_sys_sendfile64 fs/read_write.c:1415 [inline]
  __x64_sys_sendfile64+0x1d8/0x220 fs/read_write.c:1415
  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Reported-by: syzbot+fae49d997eb56fa7c74d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/67ea5c01.050a0220.1547ec.012b.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Link: https://patch.msgid.link/20250331091532.224982-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Minor conflict resolved due to code context change.]
Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Verified the build test
---
 net/sctp/sysctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index fd73be940f46..77a76634014a 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -529,6 +529,8 @@ static int proc_sctp_do_auth(struct ctl_table *ctl, int write,
 	return ret;
 }
 
+static DEFINE_MUTEX(sctp_sysctl_mutex);
+
 static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
@@ -553,6 +555,7 @@ static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 		if (new_value > max || new_value < min)
 			return -EINVAL;
 
+		mutex_lock(&sctp_sysctl_mutex);
 		net->sctp.udp_port = new_value;
 		sctp_udp_sock_stop(net);
 		if (new_value) {
@@ -565,6 +568,7 @@ static int proc_sctp_do_udp_port(struct ctl_table *ctl, int write,
 		lock_sock(sk);
 		sctp_sk(sk)->udp_port = htons(net->sctp.udp_port);
 		release_sock(sk);
+		mutex_unlock(&sctp_sysctl_mutex);
 	}
 
 	return ret;
-- 
2.34.1


