Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9E7E1747
	for <lists+linux-sctp@lfdr.de>; Sun,  5 Nov 2023 23:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjKEWBh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 5 Nov 2023 17:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjKEWBf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 5 Nov 2023 17:01:35 -0500
X-Greylist: delayed 5248 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Nov 2023 14:01:32 PST
Received: from SMTP-HCRC-200.brggroup.vn (unknown [42.112.212.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74ACF
        for <linux-sctp@vger.kernel.org>; Sun,  5 Nov 2023 14:01:32 -0800 (PST)
Received: from SMTP-HCRC-200.brggroup.vn (localhost [127.0.0.1])
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTP id 7F8D51983C;
        Mon,  6 Nov 2023 01:58:21 +0700 (+07)
Received: from zimbra.hcrc.vn (unknown [192.168.200.66])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by SMTP-HCRC-200.brggroup.vn (SMTP-CTTV) with ESMTPS id 77BED1999A;
        Mon,  6 Nov 2023 01:58:21 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id 14AAD1B8250B;
        Mon,  6 Nov 2023 01:58:23 +0700 (+07)
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZEQS66vmV3sG; Mon,  6 Nov 2023 01:58:22 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.hcrc.vn (Postfix) with ESMTP id D8B8F1B824EE;
        Mon,  6 Nov 2023 01:58:22 +0700 (+07)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.hcrc.vn D8B8F1B824EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hcrc.vn;
        s=64D43D38-C7D6-11ED-8EFE-0027945F1BFA; t=1699210702;
        bh=WOZURJ77pkiMUL2pPLC14ifVPRvyTQIBEQmxuN1ezAA=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=QJDD/5Hun+fEdzErLQmFyRbqMgLv7QpW/LGb7s00GpHVVIryDukJMwzPhsbhv9zxz
         erND7CAlYPKf5b2oUKwuu7+J5wMx2Je5HW0N2tJ4gZgnSGYNS2ociCBfytLCllOriy
         UywUjOzL3TUCH+BFw+je/gNgYWO2chdxTmJbwJygjIUOmjXorFgtXPgycmkpObN5l0
         cnFUJ+IOKePe15Br4VjQG+/9lCj0VFfVycQDreLc6HEWF0YH2CglUiT1UBkFBWbd/3
         VI9Oc7HvGbxY4fmGbAkQmpVu+HA78jgcs6G2VgE0gTS8UDjy1sqMxA+dEdH954IDiE
         yfGdXNGi29DUg==
X-Virus-Scanned: amavisd-new at hcrc.vn
Received: from zimbra.hcrc.vn ([127.0.0.1])
        by localhost (zimbra.hcrc.vn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7x5KTBDGlEv2; Mon,  6 Nov 2023 01:58:22 +0700 (+07)
Received: from [192.168.1.152] (unknown [51.179.100.52])
        by zimbra.hcrc.vn (Postfix) with ESMTPSA id 68C2F1B8252B;
        Mon,  6 Nov 2023 01:58:16 +0700 (+07)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?b?4oKsIDEwMC4wMDAuMDAwPw==?=
To:     Recipients <ch.31hamnghi@hcrc.vn>
From:   ch.31hamnghi@hcrc.vn
Date:   Sun, 05 Nov 2023 19:58:05 +0100
Reply-To: joliushk@gmail.com
Message-Id: <20231105185816.68C2F1B8252B@zimbra.hcrc.vn>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Goededag,
Ik ben mevrouw Joanna Liu en een medewerker van Citi Bank Hong Kong.
Kan ik =E2=82=AC 100.000.000 aan u overmaken? Kan ik je vertrouwen


Ik wacht op jullie reacties
Met vriendelijke groeten
mevrouw Joanna Liu

