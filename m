Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A005B363A
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Sep 2022 13:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIILUf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 9 Sep 2022 07:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiIILUa (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Sep 2022 07:20:30 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA415D132
        for <linux-sctp@vger.kernel.org>; Fri,  9 Sep 2022 04:20:23 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-346cd4c3d7aso14932797b3.8
        for <linux-sctp@vger.kernel.org>; Fri, 09 Sep 2022 04:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=ZAWXVu39zFnl04zGGdGpvYsH4qt+1ICRBchO3T7GYKs=;
        b=KFPpimkwDDKtEJX4z8jN6SW4ZtHgwTwgCztdDaJuWkqqpufQnAT7eVv4ZyCWZttlpZ
         PtAMZCMB82iudvTxrCBz3sjWfbbeN14slfdIcTBDXYeCKJHGWvDGDyoI1knu4bAvm8Yc
         uC+yD4yeUGSFLGAS1wO4klEehaKqC2KHVheeI/7yTvFCjo+Gu+e8q+kEnsCS8Iszcg6H
         j77+DPo9BtFs536cHjQ0TWmHhnryBaytOrzr2ei8VEsaIa1fACQuiCBpYWAZzY6uvYjS
         S9I9JNpTc2TCshEmUdbfqhmOEzDASyN+gwLuHrAXcEitB0eJHS8IWVJN4v5qx8cFZpS7
         4NeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZAWXVu39zFnl04zGGdGpvYsH4qt+1ICRBchO3T7GYKs=;
        b=QmMFGbhr+WWtrKFr71I47UkL7n11YgSdDVraTk01c4RDuDLaQmwUTy21p7ZVdacfAt
         85iCKJcKaZYTGGxHuiBMRVaNjiHlh6WM1zYsQJLyf6KMdS4dBZ7rhrohtrIHPqGpXEZu
         wmW+6CMqP4kaz6AN6Vpyc62LFBmxj8qjWk3vuAHGQwCAEb99BmyKfuEPMRDxVAuGf+Ot
         TFY0RZeOXdtRRwaCM9MriMcOvz70Aoy24wBVA0SL5XFXjJOff0trbiCXPhMoGuHP8s0V
         wt9gSYzCZ7j6VALW0o/CuBbIzpP1CsynWJbFDx7KktMLHIEwn6nxN22zMAc7OE4VFjTh
         lTdA==
X-Gm-Message-State: ACgBeo0Yh9IX7qcDkALnzPG2pxVDuN/GwOH1zqonRZ1jGxCXWEMH/KKB
        lJTfnr3AH20pCe08B9Qslx2LQplxmSyPHLdeUkI=
X-Google-Smtp-Source: AA6agR71D4kEEkOcqfJ8DL2tf23Ul1t9/sooH6mAzXFbnKdFxWskFcKPDYpJcQQSV80y8LEK1iSRY4GJh3UVeXdnCig=
X-Received: by 2002:a0d:efc4:0:b0:344:86fc:982a with SMTP id
 y187-20020a0defc4000000b0034486fc982amr11421384ywe.202.1662722422095; Fri, 09
 Sep 2022 04:20:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:38c7:0:0:0:0 with HTTP; Fri, 9 Sep 2022 04:20:21
 -0700 (PDT)
Reply-To: officialmanuelfranco606@gmail.com
From:   Mr Manuel Franco <mathiasmisali@gmail.com>
Date:   Fri, 9 Sep 2022 12:20:21 +0100
Message-ID: <CA+mvYJphy6nZA48nfzEROYFpYJcH6P=C8H0GTeUbhfEpwG0LKw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1132 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6861]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mathiasmisali[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [officialmanuelfranco606[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--=20
Hallo Sir/Madam Spende f=C3=BCr Sie

Ich hei=C3=9Fe Manuel Franco und bin der Gewinner der Jackpot-Lotterie im
Wert von 786 Millionen US-Dollar im Jahr 2019. Ich sende Ihnen diese
E-Mail bez=C3=BCglich der Spende in H=C3=B6he von 2.000.000,00 =E2=82=AC, d=
ie ich an
Ihren Namen und Ihre Daten geleistet habe. Bitte kontaktieren Sie mich
f=C3=BCr das weitere Verfahren.
