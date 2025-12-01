Return-Path: <linux-sctp+bounces-753-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EDCC99569
	for <lists+linux-sctp@lfdr.de>; Mon, 01 Dec 2025 23:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B4534E2E56
	for <lists+linux-sctp@lfdr.de>; Mon,  1 Dec 2025 22:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21EF287253;
	Mon,  1 Dec 2025 22:09:04 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27243286415
	for <linux-sctp@vger.kernel.org>; Mon,  1 Dec 2025 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626944; cv=none; b=jWXejNhZHoxJJ9Ek7l5GeHRCzVXgUvwF3lEIG0YhGnIwdGSaaOCRcgjj8yADIsiiuC0m9cDdOBN1sHzGYsTBio8EitxrDJm8d1SHrUkcYLZry8QMXvW5ou3wr5jfo5OCubN+kAymoWo67pn/nw+6N8eVydahdE+EKuIqHUV3a+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626944; c=relaxed/simple;
	bh=Uw9kUV9EdAkxOYByN1jtz7gLbs5Uy6OVyl/gd7NOE5s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0ecVGbZeVqbCpc0go+BZVUnxgwYXWyQRn734bu5q+kr5JiBM0axjSDNCbbX/3VFa+928BJR5epokvf9fvmC3cDsBagikqjm4rPpkrC48cvGPxAIrjHMHaKB+lNuhlBZprXqE4Y5+tmdV+AKQfOw/3RwWg2f4tY5TjfitjTDsvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4501f50b40cso3540841b6e.1
        for <linux-sctp@vger.kernel.org>; Mon, 01 Dec 2025 14:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764626942; x=1765231742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vkKw1aMFMsjt7cPjue/zTtcAVsiSrnVVB8Q6f0BvOw=;
        b=kLEck6UJ34TO5cvEEMO2Shey+G36EVdW/X4t+vsTYv3Ddxf4e5mTPKjt7HsHRZcCsC
         q5reOOCEVf3asXVnni9sjlf6T+BlMt4zvtXbMc7hgWe2SxHjnbu7yd1ZTj01vTB9VMS0
         4png3PuLq4UEUjgh7UIZ9lfEwGe5zNlDEcDheJrNLkVfupOisUrMVNBTOLvIeL7rEpd4
         Ida/rbYgPr1cOF7v8gLen0k1irRf0A/tmlEl4Pa1P6zIBPgoGwNg7DETUE+HvmMpRfPI
         DdCv7SsF1iaZ/aIFkrE/SN85UFqds3ljPoFDkkMx5PcOkA2EpA+i/Qy7SSphF5Lso4z2
         wHXw==
X-Forwarded-Encrypted: i=1; AJvYcCVBMxpNa/K1Qg5WVbac1+Cvrq7qlLJsuXrI6/VUEXtUtgjlquAx9AWc2/Xw978YQRC7AcAAC8sdV8ox@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/2X+GB6FW7mMi/Vs1nXadZUgqjEcZseYnO5ITqzsQvVq0jwk
	Vu0C+22IIbPj5nfDMsFDq1SKISEICE405YL+i8vk1NK8tqYbtSMwNHwOMQXFL+5GZ9Zaqc4Q2wC
	2Tpa4JjwqJg7jAztdOhkSZ8ryzhFAON9AkTbQqNv9TrvgN9y7WNc7X0v1Fos=
X-Google-Smtp-Source: AGHT+IFCVn9SmBjyBhDsZVB9FNp97B50jkWsVXck4orrLX/hYWor8khmXtZ+VRasjlQ64ebDCoYjuVDiltI/XEWnqYdManqfsXti
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:210c:b0:450:a9d0:b799 with SMTP id
 5614622812f47-45115a10e29mr18815486b6e.17.1764626942248; Mon, 01 Dec 2025
 14:09:02 -0800 (PST)
Date: Mon, 01 Dec 2025 14:09:02 -0800
In-Reply-To: <692d66d3.a70a0220.2ea503.00b2.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <692e11fe.a70a0220.d98e3.018e.GAE@google.com>
Subject: Re: [syzbot] [fs?] kernel BUG in sctp_getsockopt_peeloff_common
From: syzbot <syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com>
To: brauner@kernel.org, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, jack@suse.cz, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, marcelo.leitner@gmail.com, 
	mjguzik@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 457528eb27c3a3053181939ca65998477cc39c49
Author: Christian Brauner <brauner@kernel.org>
Date:   Sun Nov 23 16:33:47 2025 +0000

    net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1136a512580000
start commit:   7d31f578f323 Add linux-next specific files for 20251128
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1336a512580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1536a512580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6336d8e94a7c517d
dashboard link: https://syzkaller.appspot.com/bug?extid=984a5c208d87765b2ee7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2322c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a3c512580000

Reported-by: syzbot+984a5c208d87765b2ee7@syzkaller.appspotmail.com
Fixes: 457528eb27c3 ("net/sctp: convert sctp_getsockopt_peeloff_common() to FD_PREPARE()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

