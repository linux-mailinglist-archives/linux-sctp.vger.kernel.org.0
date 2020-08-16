Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C66245A06
	for <lists+linux-sctp@lfdr.de>; Mon, 17 Aug 2020 01:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHPXGd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 16 Aug 2020 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgHPXG2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 16 Aug 2020 19:06:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E860C061786;
        Sun, 16 Aug 2020 16:06:28 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id t7so12047277otp.0;
        Sun, 16 Aug 2020 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=YbB89hInxgGNf/U3d3iiUTm+UW9qgMc1qjxlWg8bWfI=;
        b=re4ibZngnuv4WwYw9HhWrwv6ALzurzoITfzmoEvAxnjQgz3GIzMEwZqcAEMStvNSPl
         wg8cby3O2wS+qb6ZA2uXqGByh7aHgmmduW2Hmr1CqDoxuTc4RuUPOuSAr/+Qa2ZyGkEe
         kcn6jvjUo6begiPLJfK/6O6K7lQQM3rjY43DJqP8Ba5O/LXUPKdfIvXa+FuPBcy/yvdC
         fOawh0bxi8SogBeYbkApqvxaouiq8V+9TrNUq0eyzJrTYtF04RVgRkqoz4C+5lgNaL9Z
         C/PjX3Gn1B9nK8B0MTdQKfRUcnEJKbY6SFC3m06yhkSRAiKQQwkUte07DMqWW5rM2D5B
         X6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=YbB89hInxgGNf/U3d3iiUTm+UW9qgMc1qjxlWg8bWfI=;
        b=JK2F8/TRerC7ytw75teyCvWhshcgdPYVoSkMpEB6CC2BkmvRf+/dN+j5DYxlh5fUeZ
         kr8whrXVlqOlaoNXA+4OAJE+B7EdfS+UBVdPVGm59csE14P7TyUaRRzvy9clNPhzRIxx
         FJz3KJIdkfcIer07RDiFjgbp9iEruvu2ZfwtNq34mC4T/siCl5Vdg1EWCpWlEB/BBVEp
         OcCQc57uqIIGZ0hIRqKaZnUscsk030vdpoG7L2xtD36IEwRcEwXxpzkIvCWEFILJipil
         90+YtoFRmJnSLdbLaHhX0gYfQQ8AGEjYfOmOWjhLilwHjsOqyZtf7PZ0iwCtG4Xfq76h
         eRUQ==
X-Gm-Message-State: AOAM5331EPfz3Q6YIPbMzg6bP9RGxG+9FI4U/vtr50x0p5+PhfVLpQEB
        x5sXEVYxaBeSa7y52GmdvIRT8NaBZQ==
X-Google-Smtp-Source: ABdhPJwShzK/Nep+Fov2VshXOBkVobUpYrteBRHfBNrfDbU2opTHS7AycXFjFbs9qEn3RQFGqSdQag==
X-Received: by 2002:a9d:7997:: with SMTP id h23mr9832826otm.28.1597619187282;
        Sun, 16 Aug 2020 16:06:27 -0700 (PDT)
Received: from serve.minyard.net ([47.184.146.204])
        by smtp.gmail.com with ESMTPSA id r197sm2810538oie.43.2020.08.16.16.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 16:06:26 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 66869180043;
        Sun, 16 Aug 2020 23:06:25 +0000 (UTC)
Date:   Sun, 16 Aug 2020 18:06:24 -0500
From:   Corey Minyard <minyard@acm.org>
To:     linux-sctp@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Oops on current Raspian when closing an SCTP connection
Message-ID: <20200816230624.GB2865@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I'm seeing the following when an SCTP connection terminates.  This is on
Raspian on a Raspberry Pi, version is Linux version 5.4.51-v7+.  That's
32-bit ARM.

I haven't looked into it yet, I thought I would report before trying to
chase anything down.  I'm not seeing it on 5.4 x86_64 systems.

Aug 16 17:59:00 access kernel: [510640.326415] Unable to handle kernel NULL pointer dereference at virtual address 00000008
Aug 16 17:59:00 access kernel: [510640.341624] pgd = c00fc16c
Aug 16 17:59:00 access kernel: [510640.347834] [00000008] *pgd=355ef835, *pte=00000000, *ppte=00000000
Aug 16 17:59:00 access kernel: [510640.357731] Internal error: Oops: 17 [#22] SMP ARM
Aug 16 17:59:01 access kernel: [510640.365931] Modules linked in: md5 sctp ftdi_sio cp210x usbserial raspberrypi_hwmon bcm2835_codec(C) v4l2_mem2mem bcm2835_isp(C) bcm2835_v4l2(C) bcm2835_mmal_vchiq(C) videobuf2_vmalloc videobuf2_dma_contig videobuf2_memops videobuf2_v4l2 snd_bcm2835(C) videobuf2_common i2c_bcm2835 snd_pcm snd_timer videodev snd mc vc_sm_cma(C) uio_pdrv_genirq uio fixed nf_nat_pptp nf_conntrack_pptp nf_nat nf_conntrack nf_defrag_ipv4 rtc_ds1307 regmap_i2c i2c_dev ip_tables x_tables ipv6 nf_defrag_ipv6
Aug 16 17:59:01 access kernel: [510640.425420] CPU: 1 PID: 4592 Comm: gtlsshd Tainted: G      D  C        5.4.51-v7+ #1327
Aug 16 17:59:01 access kernel: [510640.438008] Hardware name: BCM2835
Aug 16 17:59:01 access kernel: [510640.443823] PC is at sctp_ulpevent_free+0x38/0xa0 [sctp]
Aug 16 17:59:01 access kernel: [510640.451498] LR is at sctp_queue_purge_ulpevents+0x34/0x50 [sctp]
Aug 16 17:59:01 access kernel: [510640.459748] pc : [<7f1f3e08>]    lr : [<7f1f3ea4>]    psr: 20000013
Aug 16 17:59:01 access kernel: [510640.468311] sp : ad397dd0  ip : ad397df0  fp : ad397dec
Aug 16 17:59:01 access kernel: [510640.475811] r10: 00000008  r9 : b082c2c0  r8 : 80d04f48
Aug 16 17:59:01 access kernel: [510640.483282] r7 : 00000000  r6 : 00000000  r5 : b1ebc6a8  r4 : 00000000
Aug 16 17:59:01 access kernel: [510640.492079] r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : b1ebc6a8
Aug 16 17:59:01 access kernel: [510640.500815] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Aug 16 17:59:01 access kernel: [510640.510156] Control: 10c5387d  Table: 2028806a  DAC: 00000055
Aug 16 17:59:01 access kernel: [510640.518148] Process gtlsshd (pid: 4592, stack limit = 0x4ac0cb39)
Aug 16 17:59:01 access kernel: [510640.526489] Stack: (0xad397dd0 to 0xad398000)
Aug 16 17:59:01 access kernel: [510640.533055] 7dc0:                                     00000000 00000000 b1ec2a10 b1ea1300
Aug 16 17:59:01 access kernel: [510640.545471] 7de0: ad397e04 ad397df0 7f1f3ea4 7f1f3ddc b1ec2600 80d87e00 ad397e54 ad397e08
Aug 16 17:59:01 access kernel: [510640.557828] 7e00: 7f1fb208 7f1f3e7c ad397e94 00000000 802d4fec 8020b210 ad397e44 ad397e28
Aug 16 17:59:01 access kernel: [510640.570172] 7e20: aeacaf00 9ff167fd 8010bbbc b1ec2600 b082c240 7f21c380 b64b9550 94d54bb0
Aug 16 17:59:01 access kernel: [510640.582536] 7e40: b082c2c0 00000008 ad397e6c ad397e58 80826f9c 7f1fb1ac b1ec2600 b082c240
Aug 16 17:59:01 access kernel: [510640.595093] 7e60: ad397e84 ad397e70 7f00a23c 80826f5c b082c240 b082c340 ad397ea4 ad397e88
Aug 16 17:59:01 access kernel: [510640.607835] 7e80: 80751c38 7f00a20c 80751cac ad0006c0 000e0003 b082c2c0 ad397eb4 ad397ea8
Aug 16 17:59:01 access kernel: [510640.620747] 7ea0: 80751ccc 80751bf4 ad397ef4 ad397eb8 802e43f0 80751cb8 00000000 00000000
Aug 16 17:59:01 access kernel: [510640.633918] 7ec0: 8010cce8 ad0006c8 ad0006c0 00000000 b3c160b0 b3c15b80 b3c160d4 80dab2c0
Aug 16 17:59:01 access kernel: [510640.647206] 7ee0: ad0006c0 00000006 ad397f04 ad397ef8 802e459c 802e4358 ad397f2c ad397f08
Aug 16 17:59:01 access kernel: [510640.660620] 7f00: 801408e4 802e4590 ad396000 ad397fb0 80d04f48 80d04f4c 00000004 801011c4
Aug 16 17:59:01 access kernel: [510640.674165] 7f20: ad397fac ad397f30 8010cce8 80140838 ad397f4c ad397f40 802e4b1c 802e4a30
Aug 16 17:59:01 access kernel: [510640.687762] 7f40: ad397f6c ad397f50 802ddeb8 802e4b0c 00000052 00000000 b4335600 00000000
Aug 16 17:59:01 access kernel: [510640.701356] 7f60: ad397f94 ad397f70 80304e0c 802dde54 01614360 01614150 01615b18 9ff167fd
Aug 16 17:59:01 access kernel: [510640.714947] 7f80: 801011c4 01614360 01614150 01615b18 00000006 801011c4 ad396000 00000006
Aug 16 17:59:01 access kernel: [510640.728540] 7fa0: 00000000 ad397fb0 80101034 8010c884 00000000 00000000 000011f0 00000000
Aug 16 17:59:01 access kernel: [510640.742130] 7fc0: 01614360 01614150 01615b18 00000006 76ea3c04 00000001 00000000 00000009
Aug 16 17:59:01 access kernel: [510640.755714] 7fe0: 76ecd4a0 7ea20418 76e8d2f8 76b8c2f0 60000010 00000000 00000000 00000000
Aug 16 17:59:01 access kernel: [510640.769284] Backtrace:
Aug 16 17:59:01 access kernel: [510640.774544] [<7f1f3dd0>] (sctp_ulpevent_free [sctp]) from [<7f1f3ea4>] (sctp_queue_purge_ulpevents+0x34/0x50 [sctp])
Aug 16 17:59:01 access kernel: [510640.790327]  r6:b1ea1300 r5:b1ec2a10 r4:00000000 r3:00000000
Aug 16 17:59:01 access kernel: [510640.798799] [<7f1f3e70>] (sctp_queue_purge_ulpevents [sctp]) from [<7f1fb208>] (sctp_close+0x68/0x2a0 [sctp])
Aug 16 17:59:01 access kernel: [510640.813882]  r5:80d87e00 r4:b1ec2600
Aug 16 17:59:01 access kernel: [510640.820090] [<7f1fb1a0>] (sctp_close [sctp]) from [<80826f9c>] (inet_release+0x4c/0x80)
Aug 16 17:59:01 access kernel: [510640.833102]  r10:00000008 r9:b082c2c0 r8:94d54bb0 r7:b64b9550 r6:7f21c380 r5:b082c240
Aug 16 17:59:01 access kernel: [510640.845916]  r4:b1ec2600
Aug 16 17:59:01 access kernel: [510640.851117] [<80826f50>] (inet_release) from [<7f00a23c>] (inet6_release+0x3c/0x48 [ipv6])
Aug 16 17:59:01 access kernel: [510640.864202]  r5:b082c240 r4:b1ec2600
Aug 16 17:59:01 access kernel: [510640.870320] [<7f00a200>] (inet6_release [ipv6]) from [<80751c38>] (__sock_release+0x50/0xc4)
Aug 16 17:59:01 access kernel: [510640.883425]  r5:b082c340 r4:b082c240
Aug 16 17:59:01 access kernel: [510640.889316] [<80751be8>] (__sock_release) from [<80751ccc>] (sock_close+0x20/0x28)
Aug 16 17:59:01 access kernel: [510640.901384]  r6:b082c2c0 r5:000e0003 r4:ad0006c0 r3:80751cac
Aug 16 17:59:01 access kernel: [510640.909443] [<80751cac>] (sock_close) from [<802e43f0>] (__fput+0xa4/0x238)
Aug 16 17:59:01 access kernel: [510640.918821] [<802e434c>] (__fput) from [<802e459c>] (____fput+0x18/0x1c)
Aug 16 17:59:01 access kernel: [510640.927899]  r10:00000006 r9:ad0006c0 r8:80dab2c0 r7:b3c160d4 r6:b3c15b80 r5:b3c160b0
Aug 16 17:59:01 access kernel: [510640.940311]  r4:00000000
Aug 16 17:59:01 access kernel: [510640.945087] [<802e4584>] (____fput) from [<801408e4>] (task_work_run+0xb8/0xdc)
Aug 16 17:59:01 access kernel: [510640.956925] [<8014082c>] (task_work_run) from [<8010cce8>] (do_work_pending+0x470/0x4f4)
Aug 16 17:59:01 access kernel: [510640.969577]  r9:801011c4 r8:00000004 r7:80d04f4c r6:80d04f48 r5:ad397fb0 r4:ad396000
Aug 16 17:59:01 access kernel: [510640.981967] [<8010c878>] (do_work_pending) from [<80101034>] (slow_work_pending+0xc/0x20)
Aug 16 17:59:01 access kernel: [510640.994903] Exception stack(0xad397fb0 to 0xad397ff8)
Aug 16 17:59:01 access kernel: [510641.002430] 7fa0:                                     00000000 00000000 000011f0 00000000
Aug 16 17:59:01 access kernel: [510641.015375] 7fc0: 01614360 01614150 01615b18 00000006 76ea3c04 00000001 00000000 00000009
Aug 16 17:59:01 access kernel: [510641.028402] 7fe0: 76ecd4a0 7ea20418 76e8d2f8 76b8c2f0 60000010 00000000
Aug 16 17:59:01 access kernel: [510641.037533]  r10:00000006 r9:ad396000 r8:801011c4 r7:00000006 r6:01615b18 r5:01614150
Aug 16 17:59:01 access kernel: [510641.050214]  r4:01614360
Aug 16 17:59:01 access kernel: [510641.055157] Code: e590603c e3530000 0a000008 e5903084 (e5934008)

