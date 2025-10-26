Return-Path: <linux-sctp+bounces-705-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC9FC0AD9A
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Oct 2025 17:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 77ED9342DA0
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Oct 2025 16:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BFA21770C;
	Sun, 26 Oct 2025 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7wGD6kr"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19221C163
	for <linux-sctp@vger.kernel.org>; Sun, 26 Oct 2025 16:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761496405; cv=none; b=onfoWbSnatrXrFWkpgdTOgtiia77+rRVj4L7bNr5y94rEtV0OQuKZ/B7oKW1Id2axv/ZUitE71aIYiqowM9eHPO4zp+Kz6z/e3aXwmoyl/i4Kb/pPGVOznVybOOwWwOb3NezFFOrCg6DmI6KJERsgZvG50ATH9goXOEBehvhzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761496405; c=relaxed/simple;
	bh=dkfgSRg3n/ubnVVhdVKVipSAGyUHeSxeTZAvC8QYEGI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jm9GjwxkvLze//h5yfNdzK6dL9FROFUQprIZ65vT5z3jcnMul0QIhWg7IQOwO2cRdVlHTIiuIcchVi1s8ll1WzVyFLJBSIEOcJgKlNQh7FkoYc+LDI8ORy8ZbLxp8+UuPE5kvjgtQrNeyVSZ6tODlVBHArFBUl2VgCIUpg97Q74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7wGD6kr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-28d18e933a9so5153095ad.3
        for <linux-sctp@vger.kernel.org>; Sun, 26 Oct 2025 09:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761496403; x=1762101203; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sbMEHOWO5Ae/gMtvFENkyfzcNJXX7WO2rOgBfdcmdE=;
        b=D7wGD6kr5KaXWkuZ1RT7Yb+wB9X17LgfcJy/ebeZVv1InmTLBgRbvPtP7fIv6w9bS4
         rulFeG3MhawTMlx75E6Z7TgtQRZ8KnDyd9yr9/sk07WGkZwOVe4iXlly3OS2W8/StTUe
         d7NjHX3Hsjx+PO1Y10TQ992gqU6mQSiGaVRj+4RCxU1jd8kVlVHfJ9ri827MFp2lcDXR
         /74URtbdqrRNAyBSbhCOiqOyvipc2XPvEH137PH/1fKJAl9+yLMwpemXgDC9hVTKBwmi
         XQnBg84PnQGwQWQBHC57q6kCQFZ1nSQvNYb7Q3JIvAQ9zfsL5tMyOQUDI+9eek3CWD25
         MMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761496403; x=1762101203;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sbMEHOWO5Ae/gMtvFENkyfzcNJXX7WO2rOgBfdcmdE=;
        b=jFAyGo9NPkDvdUIkKh8fesJQR/DyZ+jojMzzTizshtNTac1Vy9jHecOHM0c0AFuFYB
         rhOwIe0oKPfuAbeYaMfrKdr6815H0IJ2AXdnRB4fcPlmeScqZNfFrRvC6sqpSHsA7DRf
         tMllaODlW6ir1i1IxYnBjKGH+mnAVCy4KxSF781XzAZCy5Sbf4tWEzJi1KBFAyqMRxjR
         T1Zlyi2SVtGcTE1CUAFvkWr0gBn4w9d+ljDjMzUrsK02c5NNG84Q/eD3fk8DpFKnMCK+
         BMB/nih2qocJoNEy4aH8WDCWJswek/5N+kW82kVsJ1k0vNlvSDgbK+rvTn/AmdizmKMW
         fkcg==
X-Gm-Message-State: AOJu0YyEDJ93mVgPD+Ei5IuBnOCiZFm9Mpn9MvYRfW0gt/avpui3qf91
	DxGrS2CzUxMWZY6zsmln0CuvYRdnjE6o1zDRGlvJ/cIQGmc/PEcgw5VY
X-Gm-Gg: ASbGncutbMw3RIAlsaFoC+5pZ3jSysbhShYQCeAFlPKIIPNDfjOiL0QNqs8IZoyAK0z
	WJ0bEOEvtHPd3B34F3egWI3A3isYKTNFSGdm1wENqlyQeNoBVjG/Zf4+jjNCXNndEsSijk5XRQ5
	o6c1KnF6ZPuqEUI3UWEB33rlLE9lLkhcRf7mjFuxCVtDKkwbRQXhxIIFQB/13QX6NlEIFvjK2lI
	DbXoXOaJFCuDqtYgwmqFrQamXATUMiSVjy7SvHmskCu/SbHYnzsESBjPu5E0T4Xw8JDjzp692NX
	jrPodKLjNcpe098VnEJLk2om0XXerFFcuVtZPltTulxkuU2MIn+nBfQULNpYkJ2QYtLAD8LRLl8
	9hoKgC7Bf0xCLXFMQSpi9DXYkSvwWCmdzfOHuWyBv1zV7xh6GQDVhN0/wqW8gNUk3Kpgs9/Q7Dc
	4SPIAFa1Nt4BkWFacrDjLqLDu+qEgoBK+CqiQ+nu8RYY0DEAA2U17Q
X-Google-Smtp-Source: AGHT+IHcEjmlNyC3BUiCH/cJeBxJokcXHzVfjj+6EljnXykqRRfg4XwTOuv1Q9en28L2oqmxU7E7rg==
X-Received: by 2002:a17:902:d589:b0:290:7634:6d7e with SMTP id d9443c01a7336-292d40198f8mr135057545ad.11.1761496402921;
        Sun, 26 Oct 2025 09:33:22 -0700 (PDT)
Received: from [127.0.1.1] ([2406:7400:10c:a59a:a7b7:a351:9b3b:d26d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b71268bde68sm4837369a12.1.2025.10.26.09.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 09:33:22 -0700 (PDT)
From: Ranganath V N <vnranganath.20@gmail.com>
Date: Sun, 26 Oct 2025 22:03:12 +0530
Subject: [PATCH v3] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-kmsan_fix-v3-1-2634a409fa5f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEdN/mgC/22Myw6CMBQFf4XctTV9iG1Z+R/GGPoAbrRgWtNoC
 P9uYcXC5ZycmRmSj+gTNNUM0WdMOI0FxKECO7Rj7wm6wsAprxnlgjxCasd7hx8ilau5NFqfqYH
 yf0Vf5q11vRUeML2n+N3Sma3rv0pmhBFHlWXKGaWkvPShxefRTgHWSuZ787Q3+WpaoYXtjKaS7
 c1lWX7X3VYF3AAAAA==
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com, 
 Ranganath V N <vnranganath.20@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761496398; l=1958;
 i=vnranganath.20@gmail.com; s=20250816; h=from:subject:message-id;
 bh=dkfgSRg3n/ubnVVhdVKVipSAGyUHeSxeTZAvC8QYEGI=;
 b=cXfC2grfwFoLTzuKTmqRsq4RmFBhH81YwCEK+w6/9OREBTgr7kj10VBf6eGGDduYtb9w//Hn/
 uGQe23ZPQprDUJ2/t63/UnLKYIyUrrrQIs7T0xElPUnR1QpQ8ABqBaS
X-Developer-Key: i=vnranganath.20@gmail.com; a=ed25519;
 pk=7mxHFYWOcIJ5Ls8etzgLkcB0M8/hxmOh8pH6Mce5Z1A=

Fix an issue detected by syzbot:

KMSAN reported an uninitialized-value access in sctp_inq_pop
BUG: KMSAN: uninit-value in sctp_inq_pop

The issue is actually caused by skb trimming via sk_filter() in sctp_rcv().
In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed the
original check:

        if (skb->len < sizeof(struct sctphdr) + sizeof(struct sctp_chunkhdr) +
                       skb_transport_offset(skb))
To handle this safely, a new check should be performed after sk_filter().

Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
---
KMSAN reported an uninitialized-value access in sctp_inq_pop
---
Changes in v3:
- fixes the patch format like fixes and closes tags.
- Link to v2: https://lore.kernel.org/r/20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com

Changes in v2:
- changes in commit message as per the code changes.
- fixed as per the suggestion.
- Link to v1: https://lore.kernel.org/r/20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com
---
 net/sctp/input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/input.c b/net/sctp/input.c
index 7e99894778d4..e119e460ccde 100644
--- a/net/sctp/input.c
+++ b/net/sctp/input.c
@@ -190,7 +190,7 @@ int sctp_rcv(struct sk_buff *skb)
 		goto discard_release;
 	nf_reset_ct(skb);
 
-	if (sk_filter(sk, skb))
+	if (sk_filter(sk, skb) || skb->len < sizeof(struct sctp_chunkhdr))
 		goto discard_release;
 
 	/* Create an SCTP packet structure. */

---
base-commit: 43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c
change-id: 20251023-kmsan_fix-78d527b9960b

Best regards,
-- 
Ranganath V N <vnranganath.20@gmail.com>


