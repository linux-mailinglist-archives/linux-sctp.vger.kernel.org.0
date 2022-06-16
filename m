Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E256954DEF9
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Jun 2022 12:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376562AbiFPKZr (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 16 Jun 2022 06:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiFPKZn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Jun 2022 06:25:43 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EC75AA76
        for <linux-sctp@vger.kernel.org>; Thu, 16 Jun 2022 03:25:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i29so1535788lfp.3
        for <linux-sctp@vger.kernel.org>; Thu, 16 Jun 2022 03:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=ABukwHqeSM98uGcshbCxcb5wQWHGiHfFagypt7/loMb9v2FDjwcTgJrhBtRxVWf1v2
         BXStPbBsgYSqnUGGl7zGBKM5CMLd7osq6XxwDfWGiMcFn4Pi67uCFUXjvoArP/U14XOy
         mQeS4UYPV1T6X+0EnR/uBN8wVFg+Gtbvf3f6qSheDv1gjHNHTXbbedH61hcExrUHexoJ
         rx1Jgk5bVM9b9AL2u7FDe7guhHcyiN+kbqYLFek60/qjs7XvLdFeOWURUBV0kwO8CI+7
         Cgd19SBjyhxlRHqwqo9b9KDCVX/Ur+QyoWeFC2a2uxKLH7+bPAsMu0Sd6y37iHP37kUl
         Kx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=lLG88JCPgF7Yhflf4FNi4GQedsSNMbwmPtgneUr9Mu0=;
        b=LAlO+v19sztpOEzs9MwotMcZJ80cFgXgYoPBZrxw1pRiwipMqk9Z+oHFoheZLHmvxu
         t/vMT4dd4wIj7Tt0YbuaUsjV0URvOU1q0MDPcU4P61OP76tzqtH7XeKABQVJgt0moBfM
         OFkEGX3DTlj7vX7yro5P8s+lxx6fM9d+zCObtJbW/XwsnJ8h8uZfZOhtJrrecAWnrMFM
         OPe3eWBIY8GT5D7bAq5Qiiu5pXoVwHmbCgG2XiqwvJtFWLT3k18ykNVx5DKdA5JQyvLP
         PY2XYzlU3/ARr4mQUNYv9P4wGCw0H7BUv0nsWfTt59MoSNEmIwyv9WDRrsiXEHHIm5qA
         yB7w==
X-Gm-Message-State: AJIora/WsF6ok4UByBsjWHusoOEGcpHBRhEOUiCk13+1BX6j7ruO2sMI
        GoGa0YGRXBg2qbmsfVspQ4TbpW9t8xAMs3ZatXM=
X-Google-Smtp-Source: AGRyM1v58shGjEx7x4KAdFNHXuS9Ixy8KMeEpc8k/MiglXee1uXZfo7fZhbkGUuLzTt8pK6QeU3FZUcLi8QQvzcrZAY=
X-Received: by 2002:a19:ca0c:0:b0:479:46c:2917 with SMTP id
 a12-20020a19ca0c000000b00479046c2917mr2283112lfg.160.1655375140632; Thu, 16
 Jun 2022 03:25:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:28c2:b0:1f3:cf5:e20d with HTTP; Thu, 16 Jun 2022
 03:25:39 -0700 (PDT)
Reply-To: clmloans9@gmail.com
From:   MR ANTHONY EDWARD <bashirusman02021@gmail.com>
Date:   Thu, 16 Jun 2022 11:25:39 +0100
Message-ID: <CAGOBX5aJbCGJvAx_fa099PFZmXDUdUgW9p6nY_cgZy+0W2JLtg@mail.gmail.com>
Subject: DARLEHENSANGEBOT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--=20
Ben=C3=B6tigen Sie ein Gesch=C3=A4ftsdarlehen oder ein Darlehen jeglicher A=
rt?
Wenn ja, kontaktieren Sie uns

*Vollst=C3=A4ndiger Name:
* Ben=C3=B6tigte Menge:
*Leihdauer:
*Mobiltelefon:
*Land:
