Return-Path: <linux-sctp+bounces-217-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E295F25D
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 15:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98291F22996
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Aug 2024 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974717ADF7;
	Mon, 26 Aug 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JsmZjIsD"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21DC14A617
	for <linux-sctp@vger.kernel.org>; Mon, 26 Aug 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724677639; cv=none; b=FZkGbX2s6PktuSp7NDgQXJYQD5Ua1/PuNzwAK3wQ+l0fbRxEsGw18j1h2jy81TKljTqY1aW7VW7gXVgoJF8945A8dAEG2r07r31fLSWNgtaXYLzeD9JvqdYBj51U+EzVNTmKeH2r9uj3sLjjuDloGsNO3dS3wGULPbwJOLjyTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724677639; c=relaxed/simple;
	bh=N758xsscg1j5iUzxcnYV2NuN/BVwUzZ7pjj4u4n0WCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f10kS6LsUnQgXkk1zhZccEVfPEITEw48G/z7FkAnfXVX60SRpdBFGGCCz68IB1jalcGDIrxx54d5KtgLObyxIT2NBKLiyO2L17qsQ0dhHtMKmotSDc4U17lwpvAFojRXqgTR4L7PVfeFzgBEDyz/ZoF/AOhtFtwYpyK2cqp9Trg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsmZjIsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724677636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QT8lf5mm9iWDhlz8PS5X1/LO79S+PPvsCnWmobjlCPU=;
	b=JsmZjIsD5ar0AwC+SAY9YifpPnJEqvT4zWAOp2bWF35pUHP+J2rflTODeH9UyVHacjvAKa
	iRRqp5zrPaoTBed66mYpA1oXza8aQ4lBKDkoABOJtZPD/D+B1kO+hohhEyAyWP3NSXpkkN
	839aWqTdHiIpC/9sQPimLCWsbN4zgy0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-eZMKU71INuOguo39p5Uh6A-1; Mon, 26 Aug 2024 09:07:15 -0400
X-MC-Unique: eZMKU71INuOguo39p5Uh6A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a868b6d6882so626983766b.1
        for <linux-sctp@vger.kernel.org>; Mon, 26 Aug 2024 06:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724677634; x=1725282434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QT8lf5mm9iWDhlz8PS5X1/LO79S+PPvsCnWmobjlCPU=;
        b=nniDODVsDp2EosizmillTeeelXxMN/DumZ6yO+s5vCxPLoeFpKBsFUtycEQ2PMp7ar
         N2FKOZi5wE0bvESDXYVBcc6OOF6WpnrDfV08tks1DVrcOtx8bNn1pf6YLxdxcTB1y5Uv
         nCw4JmWkNEQJT/A3D7c4bC17bCisDM9qqJ7p5ZXJJEQgn0/QmLUI6XotoNsAFk1xXm3v
         e/OK5TanxRbW9hkD26W5iKfAafhPq+qasju+bG7b++W1bRTu57ZsotcJTrRlLb+fT09N
         JjOWXHWZTYDCiJgv+R19lFqy3L9ht6g/h0Xy5A9bIwRAitMGHtgi66H/I7XmhrlhD5zK
         2sDA==
X-Forwarded-Encrypted: i=1; AJvYcCUUJrsRv8dzKLPpdRzfMGmEMdc13MsU5xSSgF26hJTTWHW8MRRUHD+LQRYcmehCMBwwbeCVwmt80gWx@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4iJTxRGnslDLETb8UIPiEEVZuFDSszdJm6erXzosR7dHAMplm
	/uZ0+hBPXOkroUJNZItQz5ZM4i7QClEqHaIfd5/VW0dHlX06/rGuVMdCdfXtm30sfcdhMQlVSnS
	Jp+q47XaPSSDqX2eJGsdy156HizBFzMg0PwdPwe6EtDznxdqYp1XpwB+NCDU=
X-Received: by 2002:a17:907:72c9:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86a309adf6mr1221354666b.25.1724677634295;
        Mon, 26 Aug 2024 06:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfMUDlt8DybpTH0kwcX/XKT6qaULsyhgHI3OUZQq9tkVmm8pYBDmjG4y5t+KIz9vx7HsCF9Q==
X-Received: by 2002:a17:907:72c9:b0:a7a:c7f3:580d with SMTP id a640c23a62f3a-a86a309adf6mr1221350166b.25.1724677633744;
        Mon, 26 Aug 2024 06:07:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220d16sm664298866b.22.2024.08.26.06.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:07:13 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	linux-sctp@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sctp: fix association labeling in the duplicate COOKIE-ECHO case
Date: Mon, 26 Aug 2024 15:07:11 +0200
Message-ID: <20240826130711.141271-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

sctp_sf_do_5_2_4_dupcook() currently calls security_sctp_assoc_request()
on new_asoc, but as it turns out, this association is always discarded
and the LSM labels never get into the final association (asoc).

This can be reproduced by having two SCTP endpoints try to initiate an
association with each other at approximately the same time and then peel
off the association into a new socket, which exposes the unitialized
labels and triggers SELinux denials.

Fix it by calling security_sctp_assoc_request() on asoc instead of
new_asoc. Xin Long also suggested limit calling the hook only to cases
A, B, and D, since in cases C and E the COOKIE ECHO chunk is discarded
and the association doesn't enter the ESTABLISHED state, so rectify that
as well.

One related caveat with SELinux and peer labeling: When an SCTP
connection is set up simultaneously in this way, we will end up with an
association that is initialized with security_sctp_assoc_request() on
both sides, so the MLS component of the security context of the
association will get swapped between the peers, instead of just one side
setting it to the other's MLS component. However, at that point
security_sctp_assoc_request() had already been called on both sides in
sctp_sf_do_unexpected_init() (on a temporary association) and thus if
the exchange didn't fail before due to MLS, it won't fail now either
(most likely both endpoints have the same MLS range).

Tested by:
 - reproducer from https://src.fedoraproject.org/tests/selinux/pull-request/530
 - selinux-testsuite (https://github.com/SELinuxProject/selinux-testsuite/)
 - sctp-tests (https://github.com/sctp/sctp-tests) - no tests failed
   that wouldn't fail also without the patch applied

Fixes: c081d53f97a1 ("security: pass asoc to sctp_assoc_request and sctp_sk_clone")
Suggested-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 net/sctp/sm_statefuns.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 5adf0c0a6c1a..7d315a18612b 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2260,12 +2260,6 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 		}
 	}
 
-	/* Update socket peer label if first association. */
-	if (security_sctp_assoc_request(new_asoc, chunk->head_skb ?: chunk->skb)) {
-		sctp_association_free(new_asoc);
-		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-	}
-
 	/* Set temp so that it won't be added into hashtable */
 	new_asoc->temp = 1;
 
@@ -2274,6 +2268,22 @@ enum sctp_disposition sctp_sf_do_5_2_4_dupcook(
 	 */
 	action = sctp_tietags_compare(new_asoc, asoc);
 
+	/* In cases C and E the association doesn't enter the ESTABLISHED
+	 * state, so there is no need to call security_sctp_assoc_request().
+	 */
+	switch (action) {
+	case 'A': /* Association restart. */
+	case 'B': /* Collision case B. */
+	case 'D': /* Collision case D. */
+		/* Update socket peer label if first association. */
+		if (security_sctp_assoc_request((struct sctp_association *)asoc,
+						chunk->head_skb ?: chunk->skb)) {
+			sctp_association_free(new_asoc);
+			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
+		}
+		break;
+	}
+
 	switch (action) {
 	case 'A': /* Association restart. */
 		retval = sctp_sf_do_dupcook_a(net, ep, asoc, chunk, commands,
-- 
2.46.0


