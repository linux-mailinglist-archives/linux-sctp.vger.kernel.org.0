Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11916FDAAF
	for <lists+linux-sctp@lfdr.de>; Wed, 10 May 2023 11:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbjEJJYd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 10 May 2023 05:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbjEJJX7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 10 May 2023 05:23:59 -0400
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79E3AA5;
        Wed, 10 May 2023 02:23:45 -0700 (PDT)
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
        by mx0.infotecs.ru (Postfix) with ESMTP id 0A511113DE19;
        Wed, 10 May 2023 12:23:41 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 0A511113DE19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
        t=1683710622; bh=w4x/xmVNbv4I0guPaGI8ZGyOwgpS23MMbSf6Bjs7mFA=;
        h=From:To:CC:Subject:Date:From;
        b=ujNUL3fyv98mny2pW30/ksfLn+JcwssPN+u/sAMWAVZhWM078i8VvE7gAgEOF0Dhr
         2/W5AdUj1SVHfJ5fISz+Q4JCSMDsl+u4JLZYVZKIiyrQ2vRoopQzQksWF8j0zRgyLI
         PIvQfGF5bRKY8tbuFiHqSBKtDJNxfFGQm3B82404=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
        by mx0.infotecs-nt (Postfix) with ESMTP id 030E63032D49;
        Wed, 10 May 2023 12:23:41 +0300 (MSK)
From:   Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To:     Neil Horman <nhorman@tuxdriver.com>
CC:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Simon Horman <simon.horman@corigine.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next v4] sctp: fix a potential OOB access in
 sctp_sched_set_sched()
Thread-Topic: [PATCH net-next v4] sctp: fix a potential OOB access in
 sctp_sched_set_sched()
Thread-Index: AQHZgyEbpS0tA1Fa+Uyl1ufVP9SybQ==
Date:   Wed, 10 May 2023 09:23:40 +0000
Message-ID: <20230510092344.1390444-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.17.0.10]
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 177219 [May 10 2023]
X-KLMS-AntiSpam-Version: 5.9.59.0
X-KLMS-AntiSpam-Envelope-From: Ilia.Gavrilov@infotecs.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 510 510 bc345371020d3ce827abc4c710f5f0ecf15eaf2e, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;infotecs.ru:7.1.1;lore.kernel.org:7.1.1;127.0.0.199:7.1.2
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/05/10 08:03:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/05/10 03:39:00 #21251912
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: "Ilia.Gavrilov" <Ilia.Gavrilov@infotecs.ru>

The 'sched' index value must be checked before accessing an element
of the 'sctp_sched_ops' array. Otherwise, it can lead to OOB access.

Note that it's harmless since the 'sched' parameter is checked before
calling 'sctp_sched_set_sched'.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Ilia.Gavrilov <Ilia.Gavrilov@infotecs.ru>
---
V4:
 - revert to V2
 - repost according to
   https://lore.kernel.org/all/20230503184928.458eb0da@kernel.org/
V3:
 - Change description
 - Remove 'fixes'
V2:
 - Change the order of local variables=20
 - Specify the target tree in the subject
 net/sctp/stream_sched.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sctp/stream_sched.c b/net/sctp/stream_sched.c
index 330067002deb..4d076a9b8592 100644
--- a/net/sctp/stream_sched.c
+++ b/net/sctp/stream_sched.c
@@ -146,18 +146,19 @@ static void sctp_sched_free_sched(struct sctp_stream =
*stream)
 int sctp_sched_set_sched(struct sctp_association *asoc,
 			 enum sctp_sched_type sched)
 {
-	struct sctp_sched_ops *n =3D sctp_sched_ops[sched];
 	struct sctp_sched_ops *old =3D asoc->outqueue.sched;
 	struct sctp_datamsg *msg =3D NULL;
+	struct sctp_sched_ops *n;
 	struct sctp_chunk *ch;
 	int i, ret =3D 0;
=20
-	if (old =3D=3D n)
-		return ret;
-
 	if (sched > SCTP_SS_MAX)
 		return -EINVAL;
=20
+	n =3D sctp_sched_ops[sched];
+	if (old =3D=3D n)
+		return ret;
+
 	if (old)
 		sctp_sched_free_sched(&asoc->stream);
=20
--=20
2.30.2
