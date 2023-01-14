Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52866A96D
	for <lists+linux-sctp@lfdr.de>; Sat, 14 Jan 2023 06:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjANFib (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 14 Jan 2023 00:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjANFi3 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 14 Jan 2023 00:38:29 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BE635BC
        for <linux-sctp@vger.kernel.org>; Fri, 13 Jan 2023 21:38:28 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jl4so25436913plb.8
        for <linux-sctp@vger.kernel.org>; Fri, 13 Jan 2023 21:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GRwYDgUcv2i6TegYdoTaWLoHNouqpJz9zOauXiFO9iE=;
        b=gMMx1mDxFwTNH3KLLV+qMt3vo8g9Y5Kfa2xoetMbyhQVi/ErPH4ASetFyrcKm/I0C+
         zBAt0dEF/vmuE3VWtEDEYzX2XtJVLlGdKBlsL2GgS/+aApc3wSd/N6F82fwToS0B4X5i
         aM0KbFovmzzFtijessJH9Hz/RSZZ6fXJKZLlLlo3WxYkg2JymKdRnGbmLWj7XmRRaMVd
         4DtBKKiqkGJ7XnEbkIXH1Lp1YDS7k2Du6X4zSoSbQkoTr6xbyxZVRvTfzAn3sT9OydgJ
         dQkW9AXmbxi19ob1E1F5cUhnk7DSfIjid1qbTGkbPAhFWLomHLWjKq19FBDRlN/j15nd
         lnnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GRwYDgUcv2i6TegYdoTaWLoHNouqpJz9zOauXiFO9iE=;
        b=HmO7UFwPbsebnN+w5EPiz2HU2RyYYbijFg2XV98o4tWFEEklkizucfv/JEunLr9KzA
         DHZJOII9uQXinOH55RdnzYpiUHULJysnRBuZCkfJu6XtNfTF87/lSp68ZBReIbhIjFz0
         z08ClMvyLemyifx+v16kyCxaVlkWdSDmVbDKMawp36tTX4yP8aNgqr3MIO4Smv816A25
         DEYfrKmA4ld/IcqFiYIvNPjaoRpVdU6hqh1NAMZR5oPQnde3IBIth+WLUVWWuc5cO3/P
         nKzmXiGuY+hBWJvIPjVqmRvG+yWaPw+VNbmp7YZvz+W3dGiJZSG3duzCZfZXM7m3swBe
         7BGg==
X-Gm-Message-State: AFqh2kq4usK/T3L3qt36Dfti8v95RE31P/xuJpSdiXCgD6d2bIX9So9O
        66U/727Eb+NaR+la56v7nIlD9Knzvjj2Yi7tmpg=
X-Google-Smtp-Source: AMrXdXsFQ+F4SDtWA1qum12LN/dLPSAWoS1FZIDm+jNysKMqibjCVA5vbCnuIXVvwGc/AT0xcbCmhYS3cZ5fN4sZYHU=
X-Received: by 2002:a17:902:e548:b0:194:5166:fd75 with SMTP id
 n8-20020a170902e54800b001945166fd75mr130635plf.30.1673674708508; Fri, 13 Jan
 2023 21:38:28 -0800 (PST)
MIME-Version: 1.0
Sender: ann.ivan1983@gmail.com
Received: by 2002:a05:6a10:16a9:b0:3b7:c63d:e98 with HTTP; Fri, 13 Jan 2023
 21:38:28 -0800 (PST)
From:   Charles W Jackson Jr <charleswjacksonjr002@gmail.com>
Date:   Sat, 14 Jan 2023 06:38:28 +0100
X-Google-Sender-Auth: evQALb7kEPNgDXk9ZSzTY0pPJvs
Message-ID: <CAC1=0FmtYuu6BAvtzQdyR0JWmUnr7vDY2BhzfsPbfbPukrFF_w@mail.gmail.com>
Subject: Spende von Charles W Jackson Jr
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--=20
IHR E-MAIL-KONTO WURDE F=C3=9CR EINE WOHLT=C3=84TIGKEITSSPENDE VON $3.500.0=
00,00
AUSGEW=C3=84HLT. BITTE KONTAKTIEREN SIE UNS F=C3=9CR WEITERE INFORMATIONEN
