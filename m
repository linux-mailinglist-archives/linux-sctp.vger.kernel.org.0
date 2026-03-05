Return-Path: <linux-sctp+bounces-971-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIPYETNxqWnH7AAAu9opvQ
	(envelope-from <linux-sctp+bounces-971-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 05 Mar 2026 13:04:03 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DDACC2112BF
	for <lists+linux-sctp@lfdr.de>; Thu, 05 Mar 2026 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A2FE3005A90
	for <lists+linux-sctp@lfdr.de>; Thu,  5 Mar 2026 12:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748C39A802;
	Thu,  5 Mar 2026 11:59:36 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB88239A7E7
	for <linux-sctp@vger.kernel.org>; Thu,  5 Mar 2026 11:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711976; cv=none; b=q9drboX7yPs7DsOJmEBTVefA5YNOrPwWeA9Fjx0Bt1F4hVY4u8rolM8vWWFa+IFxlXrDromQMafx4FRmZ2W2shDziMz1BebT1sTTaLJVaZgquQSLicHsL9DVS5m//AdEiyA3vCaxWA9q3TBn06GVVqEJ8TRgmThjS2BqV6wvQok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711976; c=relaxed/simple;
	bh=d6iya0+CX0sihdTCb79lp3XbLdlDgDeY0yMYMLKcAXs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EIgu4HyaXqrQY5gcEdXfZVv9ApxWQ1xD1b/75rJysX2b1lbKuAh0m1HQATYt87JTQRE9katR7gOigZYqLWBGk5yv12aaLhLnO7SrjE4IPFdqoWoHyIDboLKskOs7ITZv343cYN4kOxPAGyViB/S3dDY7JJYQglyAcls8W7sAaC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-679c6ef1538so130352589eaf.3
        for <linux-sctp@vger.kernel.org>; Thu, 05 Mar 2026 03:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711974; x=1773316774;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nFvq2+V2x7J3mK6MTpBslU2KIn31x6q2F4F5zppXBQ=;
        b=ft1mtKcqOTGvsx3xyjZQqeqoivVjxLU8VPNLBp43wWTpHOfOACVve7eMusI8ydmu5/
         1f2nSPkXX7klfI/ZBRlspUucMHn0Vxgr5JjR5a7i19zSOC65+ULTO4gpl1ZoYO9DYXhB
         Q+yKbrfNnD/QMF1jSSzI2Mf6VTeZ1MscMyqOJjQMZtdvf9jDvD3/5nxMz+lBaigdIqFR
         mqCkzylNjHpXl2cAUW9rz3zlxefX8tpctTDWnMLi7p0MZfVNVzAFX0yfzrXgneGnjKuf
         MgxPYjm06HrRto40yLd5lf8Q1UkbpBktS621UWZCYYYnA8SNFaelPZh7MUVd0g8/yh0s
         8x5A==
X-Forwarded-Encrypted: i=1; AJvYcCWBmzFrrDKcCCfxX+dmc/CjBCndW5Cz75qeCNUCpXHzV/Ey/IsKiVNveQOL9F4TNIktKqVAj3K7sb2v@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WtILe8lBEWofyO+rUFcezpiOZmvHNWPS3fKDJ5ImFxD87eMX
	aYCn2U8HFg9B4/1yPQdR63miEjP/wm16Y8JmT2wiHlsuDPQwa/FYJXI6Go6vAeTpZ5ipz8l5suF
	V1ogHoU2QyW/UEy2Y4wrpoivQO5t+DL4V+aFtR9dIOk5W6MaHs4YjMDRFjBs=
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c8c:b0:67a:9918:5610 with SMTP id
 006d021491bc7-67af72279c6mr3486778eaf.0.1772711973857; Thu, 05 Mar 2026
 03:59:33 -0800 (PST)
Date: Thu, 05 Mar 2026 03:59:33 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a97025.a70a0220.2f119.0006.GAE@google.com>
Subject: [syzbot] [sctp?] KCSAN: data-race in sctp_do_sm / sctp_wait_for_connect
 (4)
From: syzbot <syzbot+5a18a1130eb54693214f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DDACC2112BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=70c3ed59b49365c3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,vger.kernel.org,gmail.com,redhat.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-971-lists,linux-sctp=lfdr.de,5a18a1130eb54693214f];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,googlegroups.com:email];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.929];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[11];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    23b0f90ba871 Merge tag 'sysctl-7.00-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13427ee6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=70c3ed59b49365c3
dashboard link: https://syzkaller.appspot.com/bug?extid=5a18a1130eb54693214f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ae3bcc875a04/disk-23b0f90b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a4dbd53da8f/vmlinux-23b0f90b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c3824777f5c/bzImage-23b0f90b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a18a1130eb54693214f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in sctp_do_sm / sctp_wait_for_connect

write to 0xffff88815e3ad228 of 4 bytes by task 15371 on cpu 1:
 sctp_cmd_new_state net/sctp/sm_sideeffect.c:878 [inline]
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1342 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1204 [inline]
 sctp_do_sm+0xa19/0x3330 net/sctp/sm_sideeffect.c:1175
 sctp_primitive_SHUTDOWN+0x74/0x90 net/sctp/primitive.c:89
 sctp_close+0x272/0x570 net/sctp/socket.c:1529
 inet_release+0xcd/0xf0 net/ipv4/af_inet.c:437
 __sock_release net/socket.c:662 [inline]
 sock_close+0x6b/0x150 net/socket.c:1455
 __fput+0x29b/0x650 fs/file_table.c:469
 ____fput+0x1c/0x30 fs/file_table.c:497
 task_work_run+0x130/0x1a0 kernel/task_work.c:233
 get_signal+0xe0e/0xf60 kernel/signal.c:2807
 arch_do_signal_or_restart+0x96/0x450 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x6a/0x6f0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x249/0x370 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88815e3ad228 of 4 bytes by task 15375 on cpu 0:
 sctp_wait_for_connect+0x173/0x390 net/sctp/socket.c:9381
 sctp_sendmsg_to_asoc+0xf34/0xf50 net/sctp/socket.c:1884
 sctp_sendmsg+0x13b9/0x1d60 net/sctp/socket.c:2030
 inet_sendmsg+0xc5/0xd0 net/ipv4/af_inet.c:859
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 __sys_sendto+0x3f4/0x4d0 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0x76/0x90 net/socket.c:2209
 x64_sys_call+0x2d35/0x3020 arch/x86/include/generated/asm/syscalls_64.h:45
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x370 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00000001 -> 0x00000000

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 15375 Comm: syz.4.3516 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

