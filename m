Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860D61BA272
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Apr 2020 13:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgD0Lei (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 27 Apr 2020 07:34:38 -0400
Received: from mail-eopbgr20133.outbound.protection.outlook.com ([40.107.2.133]:16005
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbgD0Leh (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 27 Apr 2020 07:34:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu5vUoCRi2KSGE74mhS8/YIGV2bvBwyBOHNal3cooPXv88qF5JtCmfJ5+Fm44nL3PCNqzMmYPPd9NrQ2etyqyZ+q+eATuSx5kb/zBREZMyD3lZozWStWQokXri3MKswh+J25G3XN5Pe8p7bZXSB/VFE31Km5TZE7G1KBQI/uCPAtWo5IBhto9aX6wCxXFqZOuPK/87TOR2NB7+gR2xsvgyRJC44Ht+JxxdJ2OavYoTiAqCyXrekXWjqqpj3pb6tQfVVBDIKtBqxkSdq1x6+6u2gzm+ErF1BTZK6alnvpGR3rhMNhkVWZOBjtPO8VjUPvZmnAovkqxdz73kSwPZ/LBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIHLwOWM1qLFj9cG6g6uMoAsQ6RwIFOELckUgz3kYhg=;
 b=MlZnRwVMCsYLPKsg64qsONe2G0kVVduyqMUQsW0RRYhv4c7WDWHTd1rWEcELd1UBqZStiud8vNl29XRujpzl/OHt3oKY/aIi36cB9SiYcchWAVEAE+C5LwFWgF0Z2cuOXVzqejhbvIZ0Y40sPwIr51EZBpFQHuLgO/WoMzNaNn0MICHX2nrZKhQOSo0EO6+OIGSSwqUjzHBdq8eNdDoK7OrTwyMVogIckwFZDrS9cpeBcDP9RL0QaPoY4/I9gQPo3r0oXBIEeIhHP+BTBclYtOvoPXP3Tnvt5omGEu2XPXWIM7sREtONfchdK4dJU/sno16f0Vs3/MTrWK/bkR+KDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIHLwOWM1qLFj9cG6g6uMoAsQ6RwIFOELckUgz3kYhg=;
 b=gU/O2T8kO03x3EI/46rcSZRmHv/O47ogpM1XT19b6h+gsTnr/5KHGlM3j5amn0fLQ83khAJPQAQuxyyLvzNK42bhaKRkmBK55O9VsCjK1TjemOQrSpbxijiXpzwVilCaRQxUHjE9oY1k3noy1dl55j1qK9SDwRdxN2Gc5hMVofc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jere.leppanen@nokia.com; 
Received: from HE1PR0702MB3818.eurprd07.prod.outlook.com (2603:10a6:7:8c::18)
 by HE1PR0702MB3772.eurprd07.prod.outlook.com (2603:10a6:7:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.9; Mon, 27 Apr
 2020 11:34:32 +0000
Received: from HE1PR0702MB3818.eurprd07.prod.outlook.com
 ([fe80::f0bb:b1ae:bf22:4526]) by HE1PR0702MB3818.eurprd07.prod.outlook.com
 ([fe80::f0bb:b1ae:bf22:4526%6]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 11:34:32 +0000
Date:   Mon, 27 Apr 2020 14:34:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jere_Lepp=E4nen?= <jere.leppanen@nokia.com>
X-X-Sender: jeleppan@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net
To:     Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org
cc:     marcelo.leitner@gmail.com, Vlad Yasevich <vyasevich@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv4] sctp: Don't add the shutdown timer if its already been
 added
In-Reply-To: <1458592673-31247-1-git-send-email-nhorman@tuxdriver.com>
Message-ID: <alpine.LFD.2.21.2004231802580.564714@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net>
References: <20160318165140.GB2560@hmsreliant.think-freely.org> <1458592673-31247-1-git-send-email-nhorman@tuxdriver.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: AM4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::15) To HE1PR0702MB3818.eurprd07.prod.outlook.com
 (2603:10a6:7:8c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net (131.228.2.10) by AM4P190CA0005.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 11:34:31 +0000
X-X-Sender: jeleppan@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net
X-Originating-IP: [131.228.2.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4b643be3-f206-418c-c4d9-08d7ea9ef475
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3772:
X-Microsoft-Antispam-PRVS: <HE1PR0702MB37727BEA9F5538D5331F8B53ECAF0@HE1PR0702MB3772.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0702MB3818.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(45080400002)(26005)(9686003)(66476007)(54906003)(186003)(2906002)(66556008)(478600001)(316002)(16526019)(55016002)(66946007)(52116002)(6666004)(81156014)(8936002)(7696005)(6506007)(5660300002)(4326008)(86362001)(956004)(8676002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FR/FfaIHpVz1ZEiQi3aSmqhWXFd/W4vKWHcuv1HAxJwJow2jDzbthRoPcz9CF7OFSG0nXglv8WKMmSlLT1n1Qj6O4XvjKRL3TCSvUT6C9PAenphNbKAbrfSWmnzRYRGoIfeWz4vtFpUDbYiJlULx6yNw1UlwDbdlQ2j56b2szN0dvjNx7RfVfm6Azhx0TgKq8FVdXd0UjYWFfM9+mgmcP95GqeqJ7malc6/thb+cevag66f9rSz2Re+ZocWwZkicZCiL/H31kV7MF2MxXea+ONBW3J4xywOyJ1A7halB4+eCBgCb7vG6CPtt0OpAFkuU/ndAWqLqJCEp5lMwozo+lg60b9YqK7ekXGjde+ypGeLVc9mrmYDYkyq2xCMxSwpvtV6xiJeEAtyDxHN2mhfwRkrV0MUdDDyORDrfRg74fx6wG1o1cQCGxdmC3LuLkswz
X-MS-Exchange-AntiSpam-MessageData: h+sn47XsdRQfmfmSJfvEsTkpK0g3N7eY2j1Qyph/Th8FHmXuFHqExYX826opCk+mr0f+tAAC9dmE3v6XHMYU7Kr0ssU1RwddzbWJ13tB1U9bZWZs/WorISKXHHNH+u4/ujP0HdLdjJVAPk0XHEqp29VJYIpsmy3g8tgYg5DM7CJCaoDT2NrkpNvMx/TotfPBcqYANOE5qZQu0fjyKzjkKVXApVZpkt2JANSKDR5JpxSu5jI6rHvUn15Cv0GjVK/Ryw/Y+AM1jP4TDRNXgSz425zF99qRHPyI1Iq7S1lTfTZ2B/zRkzB3YtQaeJnhB3ux15fatBLnNongs9Uzg0pHKVGYtTUe3Hod0sb3iZhECJNwTEZ9RAXMXK9CvuNeA6aUhulrzyMBcmjze89PPkEWnkiXiXx7yFfbj+FHlozlm3f230z8BxQpAeDtFhkxzVOpTnr1BXKlb0I9sP1dIa+h44AawwQQGXSAM/shuqet4GrXrPy+2otCGX5SsIqMbO0OCKpPTxro0YbVxJC/iJ3sR3z2CA/ooK9dfbvJYx1S0nLP9YG48cs4gboyRAic1IYh6/OFIo0P32YWENc50GE2dfRzXj5oU8V70x/SmJ+I31VHidqWwq4iGn7yogQZqRxR1exkmsjVaYTo/ExjheFmAEcaQ1KbSmmba/2zQ/Ffh9YwZyWFs/ONWRquWInxTqCUIvzKu5GJ+a53a3lKASqtz++2Jw1jaK/E29X6YilRDpyXVb+GV3Zf+UJYsC7M/tkWLVyg009bXoSUwEeQy+oITJe7pBpuyyqHfN5Lqv9yNPk=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b643be3-f206-418c-c4d9-08d7ea9ef475
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 11:34:32.5974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdYWesLmPsmAGBC2QUctqfYDS5odARq5gUnsTmc+DPCxUdbEDRKUqydqH2+1l4/ZK0EchsIXW/LxuTD+uc4B1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3772
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, 21 Mar 2016, Neil Horman wrote:

> This BUG halt was recently reported:
> 
> PID: 2879   TASK: c16adaa0  CPU: 1   COMMAND: "sctpn"
>  #0 [f418dd28] crash_kexec at c04a7d8c
>  #1 [f418dd7c] oops_end at c0863e02
>  #2 [f418dd90] do_invalid_op at c040aaca
>  #3 [f418de28] error_code (via invalid_op) at c08631a5
>     EAX: f34baac0  EBX: 00000090  ECX: f418deb0  EDX: f5542950  EBP: 00000000
>     DS:  007b      ESI: f34ba800  ES:  007b      EDI: f418dea0  GS:  00e0
>     CS:  0060      EIP: c046fa5e  ERR: ffffffff  EFLAGS: 00010286
>  #4 [f418de5c] add_timer at c046fa5e
>  #5 [f418de68] sctp_do_sm at f8db8c77 [sctp]
>  #6 [f418df30] sctp_primitive_SHUTDOWN at f8dcc1b5 [sctp]
>  #7 [f418df48] inet_shutdown at c080baf9
>  #8 [f418df5c] sys_shutdown at c079eedf
>  #9 [f418df70] sys_socketcall at c079fe88
>     EAX: ffffffda  EBX: 0000000d  ECX: bfceea90  EDX: 0937af98
>     DS:  007b      ESI: 0000000c  ES:  007b      EDI: b7150ae4
>     SS:  007b      ESP: bfceea7c  EBP: bfceeaa8  GS:  0033
>     CS:  0073      EIP: b775c424  ERR: 00000066  EFLAGS: 00000282
> 
> It appears that the side effect that starts the shutdown timer was processed
> multiple times, which can happen as multiple paths can trigger it.  This of
> course leads to the BUG halt in add_timer getting called.
> 
> Fix seems pretty straightforward, just check before the timer is added if its
> already been started.  If it has mod the timer instead to min(current
> expiration, new expiration)
> 
> Its been tested but not confirmed to fix the problem, as the issue has only
> occured in production environments where test kernels are enjoined from being
> installed.  It appears to be a sane fix to me though.

Hi Neil,

This patch was acked by Marcelo four years ago, but was then apparently 
forgotten about and never applied. I have a comment to the patch itself, 
below, so would it possible for you to reroll another version?

Here's one way - not necessarily the only way - to hit this kernel BUG:

--- clip ---

# cat sctp_t2_double_start.c
#include <stdlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <netinet/sctp.h>
#include <arpa/inet.h>

int main()
{
	int listen_fd, server_fd, client_fd;

	struct sockaddr_in addr = {
		.sin_family = AF_INET,
		.sin_addr.s_addr = inet_addr("127.0.0.1"),
		.sin_port = htons(65000),
	};

	struct sockaddr_in caddr = addr;
	caddr.sin_port = htons(65001);

	listen_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
	bind(listen_fd, (struct sockaddr *)&addr, sizeof(addr));
	listen(listen_fd, 10);
	client_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
	bind(client_fd, (struct sockaddr *)&caddr, sizeof(caddr));
	connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
	struct linger lin = { .l_onoff = 1, .l_linger = 0, };
	setsockopt(client_fd, SOL_SOCKET, SO_LINGER, &lin, sizeof(lin));
	server_fd = accept(listen_fd, NULL, NULL);
	system("iptables -A INPUT -p sctp -j DROP");
	shutdown(server_fd, SHUT_WR);
	close(client_fd);
	system("iptables -D INPUT -p sctp -j DROP");
	client_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_SCTP);
	bind(client_fd, (struct sockaddr *)&caddr, sizeof(caddr));
	connect(client_fd, (struct sockaddr *)&addr, sizeof(addr));
	close(server_fd); // segfault and add_timer() kernel BUG

	return 0;
}
# gcc sctp_t2_double_start.c
# ./a.out 
[  105.117695] ------------[ cut here ]------------
[  105.120047] kernel BUG at kernel/time/timer.c:1135!
[  105.122536] invalid opcode: 0000 [#1] SMP PTI
[  105.124646] CPU: 8 PID: 1126 Comm: a.out Not tainted 5.5.15-200.fc31.x86_64 #1
[  105.128029] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  105.131380] RIP: 0010:add_timer+0x14a/0x200
[  105.132382] Code: 5b 5d 41 5c 41 5d 41 5e c3 25 00 00 08 00 41 89 c6 e9 47 ff ff ff 48 c7 c5 00 d1 01 00 65 48 03 2d 4b 2b ea 5b e9 4b ff ff ff <0f> 0b 0f 0b 49 89 ec eb 8a e8 18 3f fa ff 48 c7 c2 80 be 01 00 89
[  105.136724] RSP: 0018:ffff9c5440defba8 EFLAGS: 00010286
[  105.137972] RAX: 0000000000000000 RBX: ffff8fc5ab0c6000 RCX: 00000000fffd0462
[  105.139658] RDX: 00000000fffd101a RSI: 0000000000000012 RDI: ffff8fc5ab0c6370
[  105.141338] RBP: ffff8fc5ab0c6000 R08: ffff8fc5ab0c6018 R09: ffff8fc5a90a6204
[  105.143026] R10: ffff8fc5c8c06d80 R11: ffff8fc5c16e7410 R12: 0000000000000000
[  105.144725] R13: 0000000000000001 R14: ffff8fc5ab0c6370 R15: ffff9c5440defd50
[  105.146391] FS:  00007f7b87b02540(0000) GS:ffff8fc5cf400000(0000) knlGS:0000000000000000
[  105.148330] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  105.149686] CR2: 00007f7b87937ff8 CR3: 0000000bf1fb8005 CR4: 0000000000160ee0
[  105.151362] Call Trace:
[  105.152007]  sctp_do_sm+0xc10/0x1e20 [sctp]
[  105.153024]  ? pick_next_task_fair+0x19a/0x380
[  105.154086]  ? __schedule+0x669/0x740
[  105.154971]  ? __switch_to_asm+0x40/0x70
[  105.155914]  ? __switch_to_asm+0x34/0x70
[  105.156850]  ? __switch_to_asm+0x40/0x70
[  105.157787]  ? __switch_to_asm+0x34/0x70
[  105.158729]  ? __switch_to_asm+0x40/0x70
[  105.159667]  ? __switch_to_asm+0x34/0x70
[  105.160608]  ? __switch_to_asm+0x40/0x70
[  105.161545]  ? __switch_to_asm+0x34/0x70
[  105.162480]  ? __switch_to_asm+0x40/0x70
[  105.163412]  ? __switch_to_asm+0x34/0x70
[  105.164379]  ? __switch_to_asm+0x40/0x70
[  105.165326]  sctp_primitive_SHUTDOWN+0x2f/0x40 [sctp]
[  105.166537]  sctp_close+0x200/0x320 [sctp]
[  105.167528]  inet_release+0x34/0x60
[  105.168373]  __sock_release+0x3d/0xa0
[  105.169265]  sock_close+0x11/0x20
[  105.170072]  __fput+0xc1/0x250
[  105.170822]  task_work_run+0x8a/0xb0
[  105.171694]  exit_to_usermode_loop+0x102/0x130
[  105.172760]  do_syscall_64+0x1a6/0x1c0
[  105.173663]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  105.175557] RIP: 0033:0x7f7b87a2ac07
[  105.177069] Code: ff ff e8 fc e8 01 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 f3 41 f9 ff
[  105.182798] RSP: 002b:00007ffe10833458 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  105.185271] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7b87a2ac07
[  105.187653] RDX: 0000000000000000 RSI: 00007ffe10833420 RDI: 0000000000000005
[  105.190029] RBP: 00007ffe108334a0 R08: 0000000000000000 R09: 0000000000000000
[  105.192398] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000004010f0
[  105.194779] R13: 00007ffe10833580 R14: 0000000000000000 R15: 0000000000000000
[  105.197128] Modules linked in: iptable_filter sctp libcrc32c rfkill intel_rapl_msr intel_rapl_common sb_edac kvm_intel snd_pcsp bochs_drm kvm drm_vram_helper snd_pcm irqbypass drm_ttm_helper ttm snd_timer ppdev drm_kms_helper snd virg
[  105.210029] ---[ end trace 8399eda7e3a18429 ]---
[  105.211899] RIP: 0010:add_timer+0x14a/0x200
[  105.213611] Code: 5b 5d 41 5c 41 5d 41 5e c3 25 00 00 08 00 41 89 c6 e9 47 ff ff ff 48 c7 c5 00 d1 01 00 65 48 03 2d 4b 2b ea 5b e9 4b ff ff ff <0f> 0b 0f 0b 49 89 ec eb 8a e8 18 3f fa ff 48 c7 c2 80 be 01 00 89
[  105.220063] RSP: 0018:ffff9c5440defba8 EFLAGS: 00010286
[  105.222102] RAX: 0000000000000000 RBX: ffff8fc5ab0c6000 RCX: 00000000fffd0462
[  105.224566] RDX: 00000000fffd101a RSI: 0000000000000012 RDI: ffff8fc5ab0c6370
[  105.227022] RBP: ffff8fc5ab0c6000 R08: ffff8fc5ab0c6018 R09: ffff8fc5a90a6204
[  105.229452] R10: ffff8fc5c8c06d80 R11: ffff8fc5c16e7410 R12: 0000000000000000
[  105.231882] R13: 0000000000000001 R14: ffff8fc5ab0c6370 R15: ffff9c5440defd50
[  105.234299] FS:  00007f7b87b02540(0000) GS:ffff8fc5cf400000(0000) knlGS:0000000000000000
[  105.236935] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  105.239040] CR2: 00007f7b87937ff8 CR3: 0000000bf1fb8005 CR4: 0000000000160ee0
Segmentation fault

--- clip ---

The reason why this reproduces the BUG is because on the server side, the 
reconnect triggers an association restart, which moves the association to 
ESTABLISHED state, but leaves the T2 timer running. After that, close() 
triggers a new shutdown and an attempt to start the T2 timer again.

With your patch, the BUG is not reproduced.

Moving the association to ESTABLISHED state even though the socket is 
already closed is in itself a problem. I have a simple patch for that 
ready to be posted, but your patch should be handled first.

> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Vlad Yasevich <vyasevich@gmail.com>
> CC: "David S. Miller" <davem@davemloft.net>
> 
> Change notes:
> 
> v2) Removed WARN_ON, as its not useful
> 
> v3) Actually commit my changes
> 
> v4) Reduce code size by rolling expiration update into mod_timer line
> ---
>  net/sctp/sm_sideeffect.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> index b5327bb..192ec99 100644
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -1480,9 +1480,21 @@ static int sctp_cmd_interpreter(sctp_event_t event_type,
>  			timeout = asoc->timeouts[cmd->obj.to];
>  			BUG_ON(!timeout);
>  
> -			timer->expires = jiffies + timeout;
> -			sctp_association_hold(asoc);
> -			add_timer(timer);
> +			/*
> +			 * SCTP has a hard time with timer starts.  Because we process
> +			 * timer starts as side effects, it can be hard to tell if we
> +			 * have already started a timer or not, which leads to BUG
> +			 * halts when we call add_timer. So here, instead of just starting
> +			 * a timer, just determine the shorter of the two
> +			 * timeouts and mod the timer to that.
> +			 */
> +			if (timer_pending(timer)) {
> +				if (time_after(timer->expires, (jiffies + timeout)))
> +					mod_timer(timer, jiffies + timeout);
> +			} else {
> +				sctp_association_hold(asoc);
> +				mod_timer(timer, jiffies + timeout);
> +			}

Meanwhile, timer_reduce() has been added. Just call that instead?

>  			break;
>  
>  		case SCTP_CMD_TIMER_RESTART:
> -- 
> 2.5.5
> 
