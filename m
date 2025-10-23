Return-Path: <linux-sctp+bounces-668-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DC6C0058F
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 11:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 708CE4E5568
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 09:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842BE30ACEF;
	Thu, 23 Oct 2025 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkJU1aEY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44830AACD
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 09:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213148; cv=none; b=KVsWdJ2SpiBagV4/4i0fFEo2FkEZMjuFa/ZY8O+kmdPDiWvhhEM2MBgILpTxh9r3FkKVrVSnG3+kMRooeqRa/fTu9/+Tw34D0xIWOxp6Zd7TnrGHyaH27LnQOMECpXHKaEgj9hmzBf6SHiWCE1BNBTgDdqGqX8z11zvIN3Y3pbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213148; c=relaxed/simple;
	bh=YgxDyRN4ofYBe5Adc/skKfZKavkw9WdqKOsDqlZOpfg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RuT/wWTJCk8NCfFvr6yW1b4OVDkyVIAr6qnvyc6naa2i1uKVIUSRSoVM/cG1k06y9RNxV2qye/GMg1CVVNGg1K1S0IlroHvapMy4zkJ45WpQoBlLmJu6mFKVAsdvmiE4UIJLs9j28gLnUR5YBpfCfaY5iUSr6afwTGQkIWpmvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkJU1aEY; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33bba55200bso117084a91.1
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 02:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761213145; x=1761817945; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kycvQORLzyv+m6c4IfN7Tc5J35vHVuRL3jrZaefms2E=;
        b=UkJU1aEYYGi3k3k4ie54xn8nyzW6MItzaI89KDXtnt4pRbmYAHetVLlZ3u47v5U+Ak
         D7J3Xl3tyqptSLw9+dtlcK1lXTnukkftJjxwD28Bw7vi0mG8l4HWnjXaxDuOJkyzvkkq
         DXOt+zzMaQXZv0BLHFmplYrnsk7vjlaaM2KsBf7YxnxKrcqIy6cA5Fux73mfxzygr5Cc
         6YOaRB9hEYnKxRELrsBU+hm1JI82b5kxz9co7xwZGF4rR0zK0CdUzW4MHXK2h8GT+akc
         COSguI3WsVXm/KWzH++jLkctqRVGNAOkWMGm2sjw3wBVHNOWndQpvA+FqIXu4VcM2kaW
         PHnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761213145; x=1761817945;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kycvQORLzyv+m6c4IfN7Tc5J35vHVuRL3jrZaefms2E=;
        b=Yk6ypHQDCX5nRB2fpshvGnTkRv65yiqmz2kYkPAwqfYRrAdtsWVD6xYRIkvBJg3rNu
         omEEdqMC+iXudsU+ic3n8WBJC1QmlrBadDZp6j7hQYeEgeOXzPGaFxWecGU7pYPdSWIw
         yNmnRsANIzk3O4nErMCrP+Jk+iUWjVTJrGZEuAH+tloeQWkM9BkoQc0XaauEsKqLcySh
         9Y1JhRY4naHK/mnqraD/LgmGZ0xGKMSKb9p/pzzQnDBif/cpMep4L6Gc2cjLLXx6LDKJ
         VuI9iHIuzXaBBy7w64I1s/WVZN5yhJ0vxXHtH/ydTMq0tILEb+oIAYK0otpS4IuTGVI7
         bB9w==
X-Gm-Message-State: AOJu0YxjEqIi5eLiDk5NrQ+Ie5QWp8dVFzYPDC7yTveB+h8mR3ADRjNe
	OHswZZuKRBddvjFG9V6KPgGBwzz7xOE72Kt8o7apzYPHAJJeQRZSP8lN
X-Gm-Gg: ASbGncsw0xu0xgkKkt2nxZ/DEzPCZw4iLdTOTUDf4jEslaqhn3nVGd3uAqSNyxLm2u/
	NZ1veqOnRigRxnZrpyxmgP90QYeuuvQCUQvdXohKzlV9MNCK5Df/VsbgWyCwDJFjPMIwsPPWPuP
	OlkiKbNjKXCLGpNzwE3VsN5iLj4vBmSRb5QE1UpUxECVXZzZjsVRTyg+bv23CDsaN12esNhR8TJ
	DbNWE26RoEm9Kh+jwZFaJ9ZyRS2KRTuQS7pd7DNqp0i0nIE8/8LF/MW2Ka8LRwVza0GLj0ztPfN
	rx1/md7p+Sv+CyH7RjFWA9W+bWjzSnOldYO6bifOQTEBzWPZHEPDjhlZ90Krc968nEs26iL9kLs
	DY/kgDV5WnNV1wM0/rxWBGeHN6VIyJ/8WuByjoHUg0XnANPRIO3nQvQAoE9RDdmCVxLoJ9MNJWT
	7Gj/dfXOUl0F0qc4/7Z9s9bBery2aBc7SiFr4NFCJfsA==
X-Google-Smtp-Source: AGHT+IEtqGW4IiwBCRAkhLR4GgJO5Ha3iipzwFeyZXwIB20yXWTxUWvqYd9qkwRwxN+A8Z4KoCOQ8A==
X-Received: by 2002:a17:90b:4f8d:b0:32b:9416:3125 with SMTP id 98e67ed59e1d1-33dfabf9ec3mr6477574a91.7.1761213145330;
        Thu, 23 Oct 2025 02:52:25 -0700 (PDT)
Received: from [127.0.1.1] ([2401:4900:c919:de72:c3d6:19e5:82a7:de6e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33faff37afesm1832177a91.1.2025.10.23.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:52:24 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Thu, 23 Oct 2025 15:22:17 +0530
Subject: [PATCH] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com>
X-B4-Tracking: v=1; b=H4sIAND6+WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNj3ezc4sS8+LTMCl1zixRTI/MkS0szgyQloPqColSgMNis6NjaWgB
 e8LkUWwAAAA==
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761213140; l=1717;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=YgxDyRN4ofYBe5Adc/skKfZKavkw9WdqKOsDqlZOpfg=;
 b=N+rGD+nOzg05+/WRyPSDnt/qkxsarHxN2Fxy+Jq7bpfYDwKG3zvwRzAwCjrv0D7KU6nhMwFMC
 d0XDaYHELDiAysN3t522buK9pj9ALp94ylS8sj95gk06940Z2BRmkLy
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix an issue detected by syzbot:

KMSAN reported an uninitialized-value access in sctp_inq_pop
while parsing an SCTP chunk header received frma a locally transmitted packet.

BUG: KMSAN: uninit-value in sctp_inq_pop

skb allocated in sctp_packet_transmit() contain uninitialized bytes.
sctp transmit path writes only the necessary header and chunk data,
the receive path read from uinitialized parts of the skb, triggering KMSAN.

Fix this by explicitly zeroing the skb payload area after allocation
and reservation, ensuring all future reads from this region are fully
initialized.

Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Fixes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
KMSAN reported an uninitialized-value access in sctp_inq_pop
while parsing an SCTP chunk header received frma a locally transmitted packet.
---
 net/sctp/output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sctp/output.c b/net/sctp/output.c
index 23e96305cad7..e76413741faf 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -602,6 +602,8 @@ int sctp_packet_transmit(struct sctp_packet *packet, gfp_t gfp)
 	skb_reserve(head, packet->overhead + MAX_HEADER);
 	skb_set_owner_w(head, sk);
 
+	memset(head->data, 0, skb_tailroom(head));
+
 	/* set sctp header */
 	sh = skb_push(head, sizeof(struct sctphdr));
 	skb_reset_transport_header(head);

---
base-commit: 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
change-id: 20251023-kmsan_fix-78d527b9960b

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


