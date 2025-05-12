Return-Path: <linux-sctp+bounces-507-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A108AB36FA
	for <lists+linux-sctp@lfdr.de>; Mon, 12 May 2025 14:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F2C189C892
	for <lists+linux-sctp@lfdr.de>; Mon, 12 May 2025 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FFB268FF6;
	Mon, 12 May 2025 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="R5GIhD9p"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC28265629
	for <linux-sctp@vger.kernel.org>; Mon, 12 May 2025 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053214; cv=none; b=emzKXD1VRksSb03Q3zeA9AYAflFTIDmMIlbq6lHVj3ctV96bpA7FcULHDzzU/+PTxqbWQAq1cy0JtN1MtjKHOCtX9k1+dIg5a1ukhAqHTzit2Y+NTcJTT/jqAU9livSiNSHmfqmRhg9RS6cHJ93jsU6qYWa6sf41T1YBqxzxNWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053214; c=relaxed/simple;
	bh=xmxoEugYyb1yGai8UT99bdmtsktA15ANKC9qQ4wlzFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L9rREjPsSGscV1FnIxRYg44cY323spt6+5kePuwHzBIM7PS5pmP6us755mB0t1JokHe37aKWOuKVjdS6AF4+0IYMsfrlqLiV5U3oGS1XtyXd2NLBwtMLF/H7xokI5n+snnKL+fi3C6T9JYPqbtuJhHnMXnusyfcxuU5ZVytzkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=R5GIhD9p; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad2414a412dso262874966b.0
        for <linux-sctp@vger.kernel.org>; Mon, 12 May 2025 05:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1747053209; x=1747658009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6/C9qiFnuvzVO9nZIyru/CfIRu+ytwnKBnjMZvevNw=;
        b=R5GIhD9plmrcCZvVIO8xcOiPJqNPYFemN3s02ENbOXXHukpbjHXoU+12w0eVgFj+nV
         LAQ8pwePejQQTqXHbEdv4yL/7UsndwcxC7RFAKkB6MD68HAeILF607xV7eU1ziIlqDUq
         9qCtPNcmQ1zUhbKTGGTJzdFwvdN3LN8pNxuKJsAnIy9CdipbhX9AJzGTNJ237iC0/CiM
         E/2fzqkUzL00zOOBDSi5zE76HNDIRac615nR9M/OpxldS04v8EIhM7Dux2qUyAglqs7q
         Gx90y7b3+ffaPQX7o4ekQIvOL41la/PvKvG5bVoBl4HB7MEctpr+YiesodJoQUmUo60p
         uApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747053209; x=1747658009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6/C9qiFnuvzVO9nZIyru/CfIRu+ytwnKBnjMZvevNw=;
        b=Gxqxe2iGOiOH9Npaxw16VeA6lhf2/OCVMFk/W8+CSsVhh98v+ZTBbHw8AlwFHCCM7B
         2yOmAEXZdY+RbnlSwKV0Cso/Wq2dlftONLFFdQoHrjngjafs8B45yOgGIZD/RdW63Zwm
         n3oUmxJDH6vcEudvP8S1CJRoiI4SgHVtqK1OWXMl6KI/I1q4pjJ1tzsF3Pc+VdQnuS66
         Yepi3Evovb0a2YT1QMI6ilWAQGfeiM4pSlHdfpn5uciOd9PILkgaYmuCEgA3WoWuucNe
         ekcRkbQMnTFSkatoKdhKxZAGocSB7F1SZuX2V7L7+GjGuZgBpu3Cuj9em6RqLFMF8T3X
         LIYg==
X-Gm-Message-State: AOJu0YyAc7QvK1DGQo34C6qlFuJrsG+FwpTLRXDuskYIRDUEq/WVFKHK
	/ObcdCV+BWyy2N6JNlOhPR/Fyhqe0fkgXBzjaCNs3lRpWvwxCCdCec4jqW8XxOghQFEnBH39jMg
	=
X-Gm-Gg: ASbGncs/uFZXpZAH0QGBuk2bbTTQLli7oOztrOL8ho8DkoKyo6BSUAPiVae0bbEDL6T
	k22E1nd/BeqN7HrwoBtuzNHj4LwKwXf68f1kBLmPE0n8E07vh7Ckjh7sEIGoh/s5cMbUWQODkwf
	tv4l3GgoiLJNzDznKf/5M6auPKxjo9W7WYTyCizYbXAG/qPTaFCNBWp7ExNV2c8eDt79AuTHfoN
	vzfnw8+yei1Mu7imjBnrlxBdOZDtscZOc/p6Fx+21D4He+r/d0mITGEhTAY7oeBBZz1Hb1rqqN6
	lvuD3btrMXdV6SOKSWWgrdsdMYB8hEFiT4EVEoZcfNkpqPePBq7ODw==
X-Google-Smtp-Source: AGHT+IEiviHwz9dvdHbHqjxSclHPnj+rx/UDex0XD7qlKXISZtwjZJEOCX0L8XBumr35gUOLT7RBmQ==
X-Received: by 2002:a17:907:a4ca:b0:ad2:e08:ea00 with SMTP id a640c23a62f3a-ad218ea4581mr1087955466b.9.1747053208591;
        Mon, 12 May 2025 05:33:28 -0700 (PDT)
Received: from ntb.emea.nsn-net.net ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad251f4c04fsm192369666b.171.2025.05.12.05.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:33:28 -0700 (PDT)
From: Petr Malat <oss@malat.biz>
To: linux-sctp@vger.kernel.org
Cc: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	Petr Malat <oss@malat.biz>
Subject: [PATCH] sctp: Do not wake readers in __sctp_write_space()
Date: Mon, 12 May 2025 14:32:24 +0200
Message-Id: <20250512123224.1231301-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function __sctp_write_space() doesn't set poll key, which leads to
ep_poll_callback() waking up all waiters, not only these waiting
for the socket being writable. Set the key properly using
wake_up_interruptible_poll(), which is preferred over the sync
variant, as writers are not woken up before at least half of the
queue is available. Also, TCP does the same.

Signed-off-by: Petr Malat <oss@malat.biz>
---
 net/sctp/socket.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 53725ee7ba06..b301d64d9d80 100644
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


