Return-Path: <linux-sctp+bounces-523-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4C5AB9761
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 10:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA04503005
	for <lists+linux-sctp@lfdr.de>; Fri, 16 May 2025 08:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAD22B595;
	Fri, 16 May 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b="vRElF9P8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16EB22423B
	for <linux-sctp@vger.kernel.org>; Fri, 16 May 2025 08:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383494; cv=none; b=SeAkPk3+xC8xVwibYcxVKrHOxVwK5lj1QcGwO7+GdP6DdRzGnyxJuCkJKtAim0DWVJOwA8R8jq5Se/wxNqi7taqEbEvmvAPsyNB0qFjztxxocLALOQLl6cuVfOQYucE/v5u25wkso8oaX2TYyUOpJ9Jy63si4x744N0T8ydSVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383494; c=relaxed/simple;
	bh=GYoe7r92NOyNvWbUFh77gB0wAXLBnwFI82MXVO37j4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueXEx9ImPgMDPVfFFiKHhAEJ8wQS/1uROGkSx9aoL0lJDk1hiD46wWC1FSd+gHq56s98we7wzOmwJLO0HwIt0vnhEQfbtThTNrd88kuurkxCZ8N4odcu6Ti3NbAdCnKm9GCp6gCtbPJEe+S2giaUgwuDbVDgUmrD+XOAcr9GYDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz; spf=none smtp.mailfrom=malat.biz; dkim=pass (2048-bit key) header.d=malat-biz.20230601.gappssmtp.com header.i=@malat-biz.20230601.gappssmtp.com header.b=vRElF9P8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=malat.biz
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=malat.biz
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad1d1f57a01so294328966b.2
        for <linux-sctp@vger.kernel.org>; Fri, 16 May 2025 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20230601.gappssmtp.com; s=20230601; t=1747383489; x=1747988289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k59NPumrrDZdrADJzq5UX0o38elFaU9p3OwMlLm55t0=;
        b=vRElF9P8QeCoJhdIobhrIig05AXrlaiQh5oqhEwONphl9W9lsWeFEIVH4N4n1gwswP
         ue46LjYUfhqhf7MIYdMt1ThRVwGINLseLv125cisRXZhNofdWIX6FOj+0vm7f0vrijef
         vt8ATusxyBdOIEJWE6pOhKE4VGRuqfbsHYdfIIBm6sp02lgZa3v/avpt0OIvlAcBthbf
         cK3C1PHZdJ4jNaEDeVdai6maeR5dTB3vcqC8Fc7SZtOXMEI1IN8hFXyl/aqokyG2pNpe
         HS7tX9ZDEYHLhtgnj/7WBd3LiVs5lztKNsdGCqbk/cjUUv1M5WRqf1LEZKHxNrEl1tvR
         IDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747383489; x=1747988289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k59NPumrrDZdrADJzq5UX0o38elFaU9p3OwMlLm55t0=;
        b=LsabGC9BP0kvnS/XnCkq0sXddT1rbuhWUg/BhT8ib7V0CbngZUqwCmpS37Z/O0S8nh
         trcBSdcvNBcaqKCBt2eXxSf0npG8MWHM5T/e6bZ2PxnUza2dEf+0QJtGkfviZqSJz9BB
         so229edgal1IcOfCgfBtGCMju9DpetLqqFSINc/VrwFLuSbpGhVRAnjBXAnJgkNrIcw5
         4VrhHnGpJwpcdZgWbWUyamSgU6b3/sRcuGBvb5gOMBFE+0HDB0MaxGLk7C5/QQaTdile
         Tx9H/FEVnyd6hkuo1WIEfiKe8AP2s1MnMh0mArtKcAn22KybL7RdRjtL+mMy0Xn2PG/6
         1FfQ==
X-Gm-Message-State: AOJu0YyhSoBq2E8p0zQkQBkfyPdIdHBYioyfHevSlmOK5t5gurVaElep
	C1rq1xK/AMS+EiHqnlOrMrrQoporlGrNu0dlADzun26xt3viLQ2ly7HDPYoHfenHQL2nD32HHO8
	tj79l5A==
X-Gm-Gg: ASbGnctL5YHJJ1ub0YmTH22xmnJnXcDL+ofOc6RbQnSW7QI/r+GXGWXV0yAqOW710us
	Vx9IoqVrRnR9++0rm8yAo22SKg+FU4uhmfOarM5nXFTDExaxFQs0DGHewC4C90h4k0QGm3FhKi1
	0K1M7unlYx5Lexci1ZMMXp7+vy8O7j6dL/LpjtxUTRhdz+vb6G82fRUgEmb4B6T1TlrDMnqgkqU
	CKB+EX17BdTyMf9kavQVnjmITi5v2pOviA1e+OTP254UTtGBcGO/TsQbWiUNos6TpL5Y19D7lY5
	V5btviwpZuupIN/iXaEB8YWLZdAwvwZJeoGN0VwW2NVBEWIeLqeXTA==
X-Google-Smtp-Source: AGHT+IEK/s7twkDm0OR5XtH1NSOrfITFUmJvPDQ/dyTyOQXF/QXJqLIk3URyPRdo6S8TjXC3hbGodA==
X-Received: by 2002:a17:907:1b19:b0:aca:c38d:fef0 with SMTP id a640c23a62f3a-ad52d08120dmr249737966b.0.1747383488545;
        Fri, 16 May 2025 01:18:08 -0700 (PDT)
Received: from ntb.emea.nsn-net.net ([193.86.118.65])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ad52d2779fasm115052566b.79.2025.05.16.01.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 01:18:08 -0700 (PDT)
From: Petr Malat <oss@malat.biz>
To: linux-sctp@vger.kernel.org
Cc: netdev@vger.kernel.org,
	marcelo.leitner@gmail.com,
	Petr Malat <oss@malat.biz>,
	Xin Long <lucien.xin@gmail.com>
Subject: [PATCH] sctp: Do not wake readers in __sctp_write_space()
Date: Fri, 16 May 2025 10:17:28 +0200
Message-Id: <20250516081727.1361451-1-oss@malat.biz>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CADvbK_fuv7_Hoo3BGL2_b2r9yY7VT=x6K3a+yBuDd9LAN9bZ=A@mail.gmail.com>
References: <CADvbK_fuv7_Hoo3BGL2_b2r9yY7VT=x6K3a+yBuDd9LAN9bZ=A@mail.gmail.com>
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
Acked-by: Xin Long <lucien.xin@gmail.com>
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


