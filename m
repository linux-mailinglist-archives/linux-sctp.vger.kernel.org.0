Return-Path: <linux-sctp+bounces-747-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BBFC7F3DE
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Nov 2025 08:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146753A63B9
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Nov 2025 07:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471D1A295;
	Mon, 24 Nov 2025 07:46:28 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9CC21D58B
	for <linux-sctp@vger.kernel.org>; Mon, 24 Nov 2025 07:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970388; cv=none; b=XG9ThabWbtv3efGCN9ltTMX4KaUGXQwwoXKKuiQ8XAifqeuzB8P5bQgzviC+j5I6JHI7gEKsW/39EHxHDCtkrf+nRzK3wlPx259mdT0awdiBCDazU3GptpjhYzGxU8nHh/rzLHatGPWkrl+x6BBCV1kK3dw8rgAkd/CGOtxp9B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970388; c=relaxed/simple;
	bh=P1Qnt7dE/JNs8Xq8k8Ilp+gjpzoNArTSyZC0RoLgO8U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QIQS7UkF4gw3NGZS8uEgcAaTGrNzcuSjnKhNHBqjSN//7OKFJJvLdYDlAm1sqqLnOEDscJmo6NQsadYiYhNu36/gXW5NiNHw/7OiGKJQoaK1W/TjWvAqH9p2Peh/NmupocGltrgM4o8Z7PSieLe9Q4NeIERyjNIjJYHWB+r0m/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-937e5f9ea74so385159339f.1
        for <linux-sctp@vger.kernel.org>; Sun, 23 Nov 2025 23:46:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970385; x=1764575185;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Em/20aVI2j5vJXiyoo0oMdRjjZFMPYlo6bZRrdj/+vY=;
        b=l+3W/W/JPTUBHuMVSg40wk57fYRxcaIQw+CN6zB/ZVRQw3U+HhL1QCQtqfXfvzx4C4
         0GB6oGoe3JmWU7yhkXTNr1DFQU13JKiizWrebu8+bZlEF1BqkS72g8NTt6OZ0b4XRvFX
         QTuWVFWWAsIKWZKI8NBX6SeAax/8Zy7id6jKAdj0EoIdfqSobMq1XgbHYCjFddjtIEth
         GW6RxQIH1cb6R7sWuFhKo4z4Vuo5Tj0/wTAOujh96qwpgVALYnBzqGKebB6x39GUFH3o
         YmBHpzPsBfzB/I7pEgMVXVhQLi5ML0+3a6KUp9jW4OY6X3c+OrPPBdJ/PnZmyg6kwVpM
         Wb8w==
X-Forwarded-Encrypted: i=1; AJvYcCWb0f17z7hTmyXkQm+OvT9o4DRsfUee1Wl2TGlvXl8VqR8xk6zxTY2996AnO540C95BsT5SUXHjAX3r@vger.kernel.org
X-Gm-Message-State: AOJu0YwNx32R7WAS8C6YLnZBrUIJIRwBDLzmP/Sxh5X+STC/7ReQ0gB0
	a6OOrBZCJmO9pkkgvbI05/NHmtkZ3Fcb70KlbSEu8BBHbWK90KiN4UmV1auHfxe5AKgnYqvO7Xh
	qSk7/0jx+z5JjIpvyVhxn3jaDlaCI7VGCBW30p3IWsZfeWBnmU4DmMEfa/U8=
X-Google-Smtp-Source: AGHT+IGrX0xdmXVKtphDI18dGVhIgTFkImohtzxBkwFVEo3zJxc7BfZWaWPsukHllCA6q8TpIHKU2JHC4JQ9jiNZmxelNsejQhmA
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:42d:878b:6e40 with SMTP id
 e9e14a558f8ab-435b986a6a0mr59376545ab.13.1763970385329; Sun, 23 Nov 2025
 23:46:25 -0800 (PST)
Date: Sun, 23 Nov 2025 23:46:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69240d51.a70a0220.d98e3.007f.GAE@google.com>
Subject: [syzbot] Monthly sctp report (Nov 2025)
From: syzbot <syzbot+listc1352ec1fd6125277eba@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 1 new issues were detected and 2 were fixed.
In total, 6 issues are still open and 77 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 115     Yes   INFO: rcu detected stall in NF_HOOK (2)
                  https://syzkaller.appspot.com/bug?extid=34c2df040c6cfa15fdfe
<2> 36      Yes   INFO: rcu detected stall in sock_close (5)
                  https://syzkaller.appspot.com/bug?extid=9a29e1dba699b6f46a03
<3> 1       No    WARNING: refcount bug in sctp_transport_put (5)
                  https://syzkaller.appspot.com/bug?extid=e94b93511bda261f4c43

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

