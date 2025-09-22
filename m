Return-Path: <linux-sctp+bounces-623-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDCFB923BA
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Sep 2025 18:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FF57A9905
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Sep 2025 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4FD31076D;
	Mon, 22 Sep 2025 16:32:19 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from MSK-MAILEDGE.securitycode.ru (msk-mailedge.securitycode.ru [195.133.217.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECDA2D7812;
	Mon, 22 Sep 2025 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.217.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558739; cv=none; b=hOYdDXDDPd6sthtNjKSQGCQEz1k6B6uFDkh/bsG+y5TSiyLxpIZkT4yYKgDoeMw0TlnUk7/XYG7pqg8ThfYuQRiAjN/Bts5lwumHU3tbo3b5r5asHyLAbfa3sUBWEIwN06DbxAqFIVzONSYrrhTMfmYLX6c9JQsetmscmVLHkZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558739; c=relaxed/simple;
	bh=ORmP/+uQJ0WMn3vpa0kZzPdHh0E9G08pmkp5QvsIfl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=noyUqlLYYjCwFesSxY9rnFREYZNa74TOfOqbG29E0N9/EAkRVtWbUTrniGjvgWW9DHFCuYQSuoPrxqOax6x5jU25bLoqbQKpbbrhrNe7fhnc7J/it+6JYDggM7f0BWP/zpCpE7YIoosWL//Kf+DRSj3viQfbxK4lv0/A15yrxeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru; spf=pass smtp.mailfrom=securitycode.ru; arc=none smtp.client-ip=195.133.217.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=securitycode.ru
From: Alexey Simakov <a.simakov@securitycode.ru>
To: <marcelo.leitner@gmail.com>
CC: Alexey Simakov <a.simakov@securitycode.ru>, <lucien.xin@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux-sctp@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] sctp: fix null deref in sctp_sf_do_5_1D_ce()
Date: Mon, 22 Sep 2025 19:15:55 +0300
Message-ID: <20250922161557.2716-2-a.simakov@securitycode.ru>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SPB-EX1.Securitycode.ru (172.16.24.91) To
 MSK-EX2.Securitycode.ru (172.17.8.92)

The check of new_asoc->peer.adaptation_ind can fail,
leaving ai_ev uninitialized. In that case, the code
can jump to the nomem_authdev label and later call
sctp_ulpevent_free() with a null ai_ev pointer.
Leading to a potential null dereference.

Add check of ai_ev pointer before call of
sctp_ulpevent_free function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_E=
VENT")
Signed-off-by: Alexey Simakov <a.simakov@securitycode.ru>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index a0524ba8d787..93cac73472c7 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -885,7 +885,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *ne=
t,
        return SCTP_DISPOSITION_CONSUME;

 nomem_authev:
-       sctp_ulpevent_free(ai_ev);
+       if (ai_ev)
+               sctp_ulpevent_free(ai_ev);
 nomem_aiev:
        sctp_ulpevent_free(ev);
 nomem_ev:
--
2.34.1

=D0=97=D0=B0=D1=8F=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BE =D0=BA=D0=BE=
=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8

=D0=94=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D0=B5 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=BE =D0=B8 =
=D0=BB=D1=8E=D0=B1=D1=8B=D0=B5 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=
=D0=BD=D0=B8=D1=8F =D0=BA =D0=BD=D0=B5=D0=BC=D1=83 =D1=8F=D0=B2=D0=BB=D1=8F=
=D1=8E=D1=82=D1=81=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=
=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=BC=D0=B8 =D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D1=8B =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =
=D0=B4=D0=BB=D1=8F =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=B0. =D0=95=
=D1=81=D0=BB=D0=B8 =D0=92=D1=8B =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=
=D1=82=D0=B5=D1=81=D1=8C =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=BE=
=D0=BC =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=B8=D1=81=D1=8C=
=D0=BC=D0=B0, =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0,=
 =D1=83=D0=B2=D0=B5=D0=B4=D0=BE=D0=BC=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5=D0=BC=
=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE =D0=BE=D1=82=D0=BF=D1=80=D0=B0=
=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=80=D0=B0=D1=81=D0=BA=
=D1=80=D1=8B=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=
=D0=B6=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BB=
=D0=B8=D1=86=D0=B0=D0=BC, =D0=BD=D0=B5 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=BA=D0=B0=D0=BA=
=D0=B8=D1=85-=D0=BB=D0=B8=D0=B1=D0=BE =D1=86=D0=B5=D0=BB=D1=8F=D1=85, =D0=
=BD=D0=B5 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8 =D0=BD=D0=B5 =
=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D1=83=D0=B9=D1=82=D0=B5 =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BB=D1=8E=D0=B1=D1=8B=D0=BC =
=D1=81=D0=BF=D0=BE=D1=81=D0=BE=D0=B1=D0=BE=D0=BC.

