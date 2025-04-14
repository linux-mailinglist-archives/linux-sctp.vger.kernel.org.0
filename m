Return-Path: <linux-sctp+bounces-487-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFF0A87D52
	for <lists+linux-sctp@lfdr.de>; Mon, 14 Apr 2025 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA07188AF62
	for <lists+linux-sctp@lfdr.de>; Mon, 14 Apr 2025 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4177825E471;
	Mon, 14 Apr 2025 10:17:26 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7B1EB5F1
	for <linux-sctp@vger.kernel.org>; Mon, 14 Apr 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744625846; cv=none; b=KQ2U7MALMPedCYzGpYAC7HHl3bv05THAsc/vrHim6lrIcyIWLHqyUUFxnGpUznidpcDkZcAOu2qTPtKKmYygGWN1hkKyQBKJsbOebr1tXhkz3yFhN3RSwQ2C6bBgZUnKuPkcdeqNpq+ID7GrfQbUnv0BQ6djf3iDqbXJMO4HAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744625846; c=relaxed/simple;
	bh=2c7M1E1lRjaBDF0DTAAPrSRSxY+BYWh8WNPLmGeCIVw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Yi+1qo7lGVv5267whJOnu8rtqWUkSG4zt5om7xa516NWIWFhX7sbtXywNGhDbXPeXWSxA5dnkF+nK/Qm0HZt4XCYRKnF5dxyRiN4WS9XsUiVZnv+nZlvDf3Q2/o0EADeDkPm7U9R6gx9dOgTVuofGbTymfY3mI1pB1j8eleawpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-85b3f480d86so375055239f.3
        for <linux-sctp@vger.kernel.org>; Mon, 14 Apr 2025 03:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744625844; x=1745230644;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtlMRSkBTs7/GQxA1jZuBkOtfqExXnDhTxodFQXsVWE=;
        b=kiz06eTr0LNZkVsNyRLUIFjJMUOmJZmmW6ddUl18uOP+9vylJ7mC4qkYXMQjO5f+Ao
         4ln8Rmad7r8+Ygb5KAy+KeYFBgU5rTDstUj4/lHTlIbXKbwSODxuD5EhF3HGhSLU0h3O
         9sXfkINGA8dFlvQaUnCiNJAD8aw80b86wKa12tJzSjsnNWDTy30gF4Edf8QWtToGM43f
         TODD2Lg0QrJaKAE1Jnc4JjizVJbne3tyTsMzwIpRPKojh+SmNqWP/dUOpGz6V7BvNIze
         QvxAglO0LZI7PDsfKBX1dgVpCrw5LSQ9WzgZlZnXwth45D4/ba6SNWlsrTgF7g1Y4wuo
         LJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVALwRGEPoi/yXABSvteFbzO3XwfBsBZ8gM+qtGvmcG5Yo7EdgsYKSDR7j0noh4HyT/JjK/qnN1vPJP@vger.kernel.org
X-Gm-Message-State: AOJu0YwzhXNLCf/8vKx7pHDKMPwhFLn8HtwX3YyVhETSOqPE2tZZARDJ
	q14UrOuZZ2VoUvZk6OPMzFy16J4jf/9S3SskxomNNlZc2Q51BUXva0uSOlWqGZI486gy1guEYUV
	pXoWo0zt0xkJc0jVmgByquQHlJkYOxm3NHECJPCVQ7rF8UKda1Sq5hGk=
X-Google-Smtp-Source: AGHT+IEsWK/XLzkCHRNQgrHF5KhLezLNJO4VLrlEScGVacAR/kgdUOYuphvjLeyiCMwRREts1QtXMXzftrH3GbUhtWKQod+vnsQX
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2190:b0:3d3:dece:3dab with SMTP id
 e9e14a558f8ab-3d7ec1dd57cmr100206425ab.1.1744625843764; Mon, 14 Apr 2025
 03:17:23 -0700 (PDT)
Date: Mon, 14 Apr 2025 03:17:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fce0b3.050a0220.3483fc.0024.GAE@google.com>
Subject: [syzbot] Monthly sctp report (Apr 2025)
From: syzbot <syzbot+list56b130d2c18ef7a5ca58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 2 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 70 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3863    Yes   KMSAN: uninit-value in sctp_inq_pop (2)
                  https://syzkaller.appspot.com/bug?extid=70a42f45e76bede082be
<2> 29      No    KMSAN: uninit-value in sctp_assoc_bh_rcv
                  https://syzkaller.appspot.com/bug?extid=773e51afe420baaf0e2b
<3> 1       No    WARNING: refcount bug in sctp_generate_timeout_event
                  https://syzkaller.appspot.com/bug?extid=c7dd9f1bd1d2ad0e5637

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

