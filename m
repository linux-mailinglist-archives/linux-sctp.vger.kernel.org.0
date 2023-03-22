Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1136C4950
	for <lists+linux-sctp@lfdr.de>; Wed, 22 Mar 2023 12:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCVLg5 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 22 Mar 2023 07:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjCVLg4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 22 Mar 2023 07:36:56 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284F5B5C9
        for <linux-sctp@vger.kernel.org>; Wed, 22 Mar 2023 04:36:55 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b18so1537902ybp.1
        for <linux-sctp@vger.kernel.org>; Wed, 22 Mar 2023 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679485014;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gbidrJiHHLN/fpdH07ytzpgHwZxdMuUaCJTJ/XZPD6Y=;
        b=dJz5SCp86Lu3x3oS3e999TjAe8tSl86mbB2CDf1+6epffTz696RSBFS5upbJakoRrL
         WZszhUI3APsoVlx3PSSzeF8yjdJ7IT3kG0NVabWnOMv00rO1ejsmu5T+gBGZ2DIbqV+k
         EzflJY1CBVPb10u+2+8qDTAGYbq7vh2p99Qos/WbjoPbMoTtfdYwP5dEOFPJZU4CDXL9
         6kHHr+FOJ2JDcWS7DljiBlLGbLHisabpZAOnoIP15+P2hr8iyqUmYZyKOSnXdP3GNHYg
         80SNAe9D3XpoK5vBYnwYueEsHfB61XkZDu1zusHTFQjuJ3B3H8SlKFo3j1YDLHCSEUXm
         IncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485014;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbidrJiHHLN/fpdH07ytzpgHwZxdMuUaCJTJ/XZPD6Y=;
        b=QNTdnCfWL5AvywB43ftv5eO99ok8BGluQEL9ovoXawgEwMaUDrizihdLJMbAp65o+V
         NDLKHkE/0TPUwyCNlzGTyYJIyuvBg8Z9oSWhq4dkZitBp8bj6tE5vmUp22fMhgPghPbC
         eD8jcrezdNj5tmYct0hhWBwfN/hCLKgIglOEquHQIyAUOeGq0Jno8r3eEad0pwL+GD2K
         q54rHW2esYViwp5gN9Xflt+DSdQMCfchEeDCaoCWAEollAu7Js8H+rEHxzGlNNtuGbXY
         AwTXO5llwFq+Xnn1RMkCpNtop7KYLBK2ib20teRBjntT8IdCZOHQ59uWUZ10Lvg7F/rO
         rcyA==
X-Gm-Message-State: AAQBX9dWsKxiC071FHFatCuohjmDBmkpw7yKeAXDZcLxNs1LnrkzDkXC
        b7ERHegPPCdUxdmYTUweHL5Ndf0aujhFUpCqN70=
X-Google-Smtp-Source: AKy350ZITtjvd2sxmh/U6cvxn68xKV9tVhdQDDQb2gf5zVHDrtCQ+LeOV96qi6pzDPbWVP2a7zGtQFgkEGf/uepSdN0=
X-Received: by 2002:a25:9a85:0:b0:a67:c976:c910 with SMTP id
 s5-20020a259a85000000b00a67c976c910mr2971258ybo.7.1679485014517; Wed, 22 Mar
 2023 04:36:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:c10e:b0:340:4df0:6213 with HTTP; Wed, 22 Mar 2023
 04:36:54 -0700 (PDT)
Reply-To: rea73536@gmail.com
From:   amanda wiliams <oliveruhuru123@gmail.com>
Date:   Wed, 22 Mar 2023 11:36:54 +0000
Message-ID: <CAGL_FLcpWq1khh+xTxyOJWtnH6U9wESKe+2VXHbBZfFR5c30VQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dobr=C3=BD den, dostala jsem pokyn, abych v=C3=A1s kontaktovala zesnul=C3=
=A1 Susan
Carterov=C3=A1, kter=C3=A1 zem=C5=99ela na rakovinu. P=C5=99ed jej=C3=ADm z=
=C3=A1nikem mi poradila,
abych v=C3=A1m poslal n=C4=9Bjakou kompenzaci, pokud kone=C4=8Dn=C4=9B obdr=
=C5=BE=C3=ADm pen=C3=ADze od
jej=C3=AD banky. Dal=C5=A1=C3=AD podrobnosti v=C3=A1m poskytnu na z=C3=A1kl=
ad=C4=9B va=C5=A1=C3=AD odpov=C4=9Bdi.
Za=C5=A1lete mi sv=C3=A9 cel=C3=A9 jm=C3=A9no, adresu, v=C4=9Bk a telefonn=
=C3=AD =C4=8D=C3=ADslo pro doru=C4=8Den=C3=AD
va=C5=A1=C3=AD kompenzace.williams rea73536@gmail.com
