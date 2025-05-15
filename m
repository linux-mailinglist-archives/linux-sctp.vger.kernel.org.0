Return-Path: <linux-sctp+bounces-513-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF69FAB7F22
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 09:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155313B7593
	for <lists+linux-sctp@lfdr.de>; Thu, 15 May 2025 07:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BC51F0E50;
	Thu, 15 May 2025 07:46:39 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2AE4B1E51
	for <linux-sctp@vger.kernel.org>; Thu, 15 May 2025 07:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295199; cv=none; b=mlCiROBdE4BL+uwb+Ga3lPnqob3mYF9XhKrbi7WWB/fW92JYbLouygtSoupPDpp57G5F968mwvFjF5pa1vhWLtcbIXYUp+TFh1u4gyg2bp8og+5RsCnKzwGrZgNpExzOE4HwkKCrnoPlrnZuKxcp4bHlSO9GICRrjJSnNy2KvBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295199; c=relaxed/simple;
	bh=GcPWC9DTX9rlILvVyRFyZgGWozsdOzRauear8FzHQzY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u4kDgDIl0+AcvLEw0wb14LH+WN1JWsdm8nZDKsI0yJEpnAlv157jhAJxya2YNW2KNk4XVTkRImFTmosK92HL5IP37hvucc3t0jaic4RNVkYk61MiPqXT1IwetdN0PzOsEg40PEhi3+DT576PHG7pHtPXLzi8SnPTVc/9YJ4tWfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-85b418faf73so125084039f.1
        for <linux-sctp@vger.kernel.org>; Thu, 15 May 2025 00:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747295197; x=1747899997;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S86UjQFMGu5iYwtVlwx0AEIGx4zFd27s3P2snhatw/0=;
        b=ePSVLkwhYgDHXCYSoAahgrE0q9Nj+Z+q/7VRn2m1D/kWYncn38oB3kOWG+LBhWymxv
         43EKuqjbGAWWBj2fHYVqfAbfuwN4cG8RQQ+zoxyb7GM+W+clF18O4ccZfIMGz80seZvc
         JbTnvoJvOnDPV2dhVlT1gRw47ooLAY9JTk4JA9pkxRWeR5psOfcOdNW/aT/dL6RR51fY
         88oTTWGI5S9vyt02UvYGNKHINwyChcnQB3o65RKWVRHV8LBVFbYpZfORk4ab5KgQRs34
         a9Q9jt10fCPY2PJLSo+a76m35kDxDoCdkZJVX9EKfkHI0hA0stxTpHf/mWKw/Harg4JP
         lpeA==
X-Forwarded-Encrypted: i=1; AJvYcCWhQI49zoMXmrQgH5TxaMVue1wTbpMSixx1X+LXQoEyxG5C10jpSag2VCY25x0ZisqGVTbAPJ2uB/hj@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8jdK7zH4aXPY//Y099QUcQFfF2hHpYt7sXmnalJ3+h9V48o4o
	8BfJWxP0h8nLrpLASaweKpxLgPDsuAdrpZnAdNgvtNjD4CePEM5sbKkppDibMPxws5aCLlqCCfb
	z44Ri9chBRXdbMuvbTtYG7cS+XUQeJ8jWGQPnjUX3G2SnLMrrjg8fEKQ=
X-Google-Smtp-Source: AGHT+IFoNQrhWrXpNLY7oh5rJ2tJ3Nb5XXwI5DRU6GxO6PTblFimDaCE8hr8eSKPRhk6PwZQLqVfgGYEsjiTdbz8CYNpTJjk9hQY
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:dc03:0:b0:86a:93c:f5fb with SMTP id
 ca18e2360f4ac-86a093cf6admr582105939f.1.1747295196799; Thu, 15 May 2025
 00:46:36 -0700 (PDT)
Date: Thu, 15 May 2025 00:46:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68259bdc.a00a0220.a2f23.0198.GAE@google.com>
Subject: [syzbot] Monthly sctp report (May 2025)
From: syzbot <syzbot+listc23b11af384e20c3b1fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, marcelo.leitner@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello sctp maintainers/developers,

This is a 31-day syzbot report for the sctp subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/sctp

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 70 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3934    Yes   KMSAN: uninit-value in sctp_inq_pop (2)
                  https://syzkaller.appspot.com/bug?extid=70a42f45e76bede082be
<2> 83      No    KMSAN: uninit-value in sctp_assoc_bh_rcv
                  https://syzkaller.appspot.com/bug?extid=773e51afe420baaf0e2b
<3> 3       Yes   INFO: rcu detected stall in inet6_rtm_newaddr (3)
                  https://syzkaller.appspot.com/bug?extid=3e17d9c9a137bb913b61

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

