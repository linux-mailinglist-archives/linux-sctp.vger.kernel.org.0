Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A838662794A
	for <lists+linux-sctp@lfdr.de>; Mon, 14 Nov 2022 10:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiKNJpQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 14 Nov 2022 04:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbiKNJpP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 14 Nov 2022 04:45:15 -0500
X-Greylist: delayed 460 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 01:45:14 PST
Received: from relay.mgdcloud.pe (relay.mgdcloud.pe [201.234.116.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79834165A2
        for <linux-sctp@vger.kernel.org>; Mon, 14 Nov 2022 01:45:14 -0800 (PST)
Received: from relay.mgdcloud.pe (localhost.localdomain [127.0.0.1])
        by relay.mgdcloud.pe (Proxmox) with ESMTP id 5AA4C22939B;
        Mon, 14 Nov 2022 04:35:55 -0500 (-05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cgracephoto.com;
         h=cc:content-description:content-transfer-encoding:content-type
        :content-type:date:from:from:message-id:mime-version:reply-to
        :reply-to:subject:subject:to:to; s=Relay; bh=POmmLhbs6/14Mhmcbsw
        HpX0H+MIlo+W0e6cG8XDkBG8=; b=HbUoQV2uuN+u43t0wsLHt7/bAgPuNy9wrCZ
        2/P/nMwZyLgjGI+QhqJ4h++XGm5WSLExiY5s7I1yLL//Kgr1iGNBceas0eQNE/Xh
        8fny+7RcJosZygUHDmdhK1TEKV2Dsmyo2+11Jlbvq51jnddyiTZJiYye0SHKPw/D
        +1ZR8td5GAeMA/MOyHPxdBz+fj6amxLHzT2ZVuzRlcIFV04OCsXtaFtzzTvW3zb+
        uAq/hNuARsNjIuA0yn21L+AMO3cfb4JnKtpoZ/9QN41sSEtquhNKScdwXNI00ZMy
        dNCd+UTQ/GoAX8s7WEpOYCLjvZrX4xY8tg1giaj55DXAgzzr0nw==
Received: from portal.mgd.pe (portal.mgd.pe [107.1.2.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by relay.mgdcloud.pe (Proxmox) with ESMTPS id 40EDA229391;
        Mon, 14 Nov 2022 04:35:55 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by portal.mgd.pe (Postfix) with ESMTP id 2193920187D83;
        Mon, 14 Nov 2022 04:35:55 -0500 (-05)
Received: from portal.mgd.pe ([127.0.0.1])
        by localhost (portal.mgd.pe [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id AcyNiQMddMQr; Mon, 14 Nov 2022 04:35:54 -0500 (-05)
Received: from localhost (localhost [127.0.0.1])
        by portal.mgd.pe (Postfix) with ESMTP id CC0C420187D82;
        Mon, 14 Nov 2022 04:35:54 -0500 (-05)
X-Virus-Scanned: amavisd-new at mgd.pe
Received: from portal.mgd.pe ([127.0.0.1])
        by localhost (portal.mgd.pe [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FUvu20TLSIKJ; Mon, 14 Nov 2022 04:35:54 -0500 (-05)
Received: from [103.125.190.179] (unknown [103.125.190.179])
        by portal.mgd.pe (Postfix) with ESMTPSA id 2D7E720187D85;
        Mon, 14 Nov 2022 04:35:47 -0500 (-05)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Strategic plan
To:     Recipients <cindy@cgracephoto.com>
From:   "Mr.IgorS. Lvovich" <cindy@cgracephoto.com>
Date:   Mon, 14 Nov 2022 01:35:46 -0800
Reply-To: richad.tang@yahoo.com.hk
Message-Id: <20221114093548.2D7E720187D85@portal.mgd.pe>
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,HK_NAME_MR_MRS,RCVD_IN_SBL,
        SPF_FAIL,SPF_HELO_PASS,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello
I will like to use the liberty of this medium to inform you as a consultant=
,that my principal is interested in investing his bond/funds as a silent bu=
siness partner in your company.Taking into proper
consideration the Return on Investment(ROI) based on a ten (10) year strate=
gic plan.
I shall give you details when you reply.

Regards,

