Return-Path: <linux-sctp+bounces-327-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87BA2EDA5
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 190AE1626DD
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 13:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B46225778;
	Mon, 10 Feb 2025 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1Zq1wCg"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADA225392;
	Mon, 10 Feb 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739193910; cv=none; b=gH2Ugvhc5/Sj7b4DzRdWaPdI274BAbzr3xsgp12wfmaIL5GQnh1fKszGcofJrUKMUlL3AsqtH+hMrgSxUcewcPrcEYTKiKovAiA3ZA5AMdt/5S4pQdRJJMZ3Q+4sdrxfVN/Gm0a2EEN+VrqtI2te0IoDdj5uJzurfQeekL37EhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739193910; c=relaxed/simple;
	bh=ArJXZrKbhHH4iskvI4WEuO34/M4LRlH1tN5VejTwQTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=POwNwkZX3H+bK3WSZZcoxSG58FV+BmZE1DMX11GB2rVqhGwJAhtVx0OZcA4WV9Dq1ajBpHBQIhoea8Q0v8nXiSt6JyBaa0AKB9zCtLFOXDUgW1MkQnHx2/57IPSgab3YOLnqlnrZ0doTNOc4cHH1swlmTXAZ41pKDSarsVKmbRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1Zq1wCg; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f7f03d856so25907285ad.1;
        Mon, 10 Feb 2025 05:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739193908; x=1739798708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o8R9Qq9zywQhBZPOypSKlrlY+huMMJJFdgWMKi4bYZE=;
        b=c1Zq1wCg2EXTke51OKXs7sLT+BCu1eDkLq5tOheHDRAU+20OJfyzbPz7Br+bqTQgkr
         nRhPdJZzsp0hHOftJmZdkhARngCg01u5BF8xjqNKnN/koVYhkaZaElZxGY4U8/MFQS2E
         PCEg4EqEQdz4zu0CDj9gALkzVdI8KbzFJvZz9lqvACaGhy9tj5/RNTTh6E4axB3smtJm
         X7ypCCoTRfgGXwc5xLJucgYrzH4h/QbjElCYlbno2H8NDKk8BFu0gCbWih8VXuBdedfq
         fkfm9WdWu0Z+VIBxCpHf0worLeJvqTwjhwLSH/6Of2ECPHOfEucVqicKnT/7gFxT5e6C
         PcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739193908; x=1739798708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o8R9Qq9zywQhBZPOypSKlrlY+huMMJJFdgWMKi4bYZE=;
        b=nhPihe0pOo5+KhVg6Yg3mtmhtdwrpn5+U/RP50KprScm/BQycSXrGOTj75uR1gcHmi
         wDL/s0AfXYkAN4I1KwjZXNlx6fbXIuk12DoRpeibgqc0kKWCPjkc9WY1V+AcbeuQ6eg3
         KcxcYDckHUp2/0VzVJE98FmN/EGWZ1e22A6EMneWGsKI8HqBHDnJtSY8SP1e0cTKGmG5
         XgohJTLxYN4Fmpvpy0jUL1IabUVoVHlk5XrzVypCRa5qoePefiCPF6iIawzAwRUMTSIs
         gI12boysszznY337oMZYy787X5sZ0C4IyVJd+jh0dSRfwcrRwS9lbLJd5//4P9S+Okd7
         PJrQ==
X-Gm-Message-State: AOJu0Yw+Z5GjvJ6uTkFohSIj3t2Rj2x67C4wglOp6X2wo0Yj8YolL4wv
	P8H26ZiYwGvvKTuTfRP+r+HZ+J55B1fsxUPyGvNe1+yqNhKM+5ty
X-Gm-Gg: ASbGncuDr7MBiHrEibjJLydz3U6Kg/lEzLxX11XJxHUn9wDCWtq+4eqCWB+lgvWUto4
	IH8wyYepBYWylPugFNtRXtIAVXowrtk9rCbm640VMIlkUdj455g1Sjc4hgkiVPTyO+EqaNJ90lh
	2RWf66iw5DC+hwHiGERWjOxX0NQm47JBpUD6HrRU39iWJgHWkVXTf9FzhVEn/sFhAJwkHQNy4NG
	TODz7CoSellkaPYGfkkJpT40ySbUAxGHqVxD8iDXRrSN2OP9X1xoFnnExCCHZxvTdbZ71ssgpDV
	lGQ1/KF1hm1ANrnlr6CR0RCsfXd6tA==
X-Google-Smtp-Source: AGHT+IEd+6OlWcTlZozqGwiovVIIEK92WaU0LfFrQcY2JnIuKqNRiYwOaDujmfbpkh8jHLhSveFyOQ==
X-Received: by 2002:a17:902:d2cb:b0:21f:60cd:e8b with SMTP id d9443c01a7336-21f60cd2b67mr185960985ad.14.1739193907935;
        Mon, 10 Feb 2025 05:25:07 -0800 (PST)
Received: from t14s.localdomain ([177.37.172.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c6d5sm78545925ad.186.2025.02.10.05.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:25:07 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id F3CABE6F528; Mon, 10 Feb 2025 10:25:04 -0300 (-03)
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-sctp@vger.kernel.org,
	thorsten.blum@linux.dev,
	lucien.xin@gmail.com
Subject: [PATCH net] MAINTAINERS: Add sctp headers to the general netdev entry
Date: Mon, 10 Feb 2025 10:24:55 -0300
Message-ID: <b3c2dc3a102eb89bd155abca2503ebd015f50ee0.1739193671.git.marcelo.leitner@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All SCTP patches are picked up by netdev maintainers. Two headers were
missing to be listed there.

Reported-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 873aa2cce4d7fd5fd31613edbf3d99faaf7810bd..34ff998079d4c4843336936e47bd74c0e919012b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16509,6 +16509,7 @@ F:	include/linux/netdev*
 F:	include/linux/netlink.h
 F:	include/linux/netpoll.h
 F:	include/linux/rtnetlink.h
+F:	include/linux/sctp.h
 F:	include/linux/seq_file_net.h
 F:	include/linux/skbuff*
 F:	include/net/
@@ -16525,6 +16526,7 @@ F:	include/uapi/linux/netdev*
 F:	include/uapi/linux/netlink.h
 F:	include/uapi/linux/netlink_diag.h
 F:	include/uapi/linux/rtnetlink.h
+F:	include/uapi/linux/sctp.h
 F:	lib/net_utils.c
 F:	lib/random32.c
 F:	net/
-- 
2.48.1


