Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E022B4D3CA8
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Mar 2022 23:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiCIWLJ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 9 Mar 2022 17:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiCIWLJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 9 Mar 2022 17:11:09 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A99120E80
        for <linux-sctp@vger.kernel.org>; Wed,  9 Mar 2022 14:10:09 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2db569555d6so38542687b3.12
        for <linux-sctp@vger.kernel.org>; Wed, 09 Mar 2022 14:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=nb2USvAcIusQq1fJA3vfnzjsAE9hpY49brDSG4ExG/fGaduPIUCdi3fKsb8H9MOvo1
         xf8WEKSw0OU7oys3CdtbJNpmN6D9y7BXRY7015RYGjiGxlVqhB9mDZh/ZLLXQt5qt8q7
         ZzxqMxSjUKaURocik8k2nZ1xGP1FqDVgGfZC897q0V5+GxkXRzab+x93KVV2xHmHAYOA
         SvMN+FCScF47LTG89tZXd9IzdEgQL5QHOtPF+xR8CWfLkbjKr5fFL9C7MpGbfBapgAjJ
         CHYD188kAnGW4PKJPIQZ8K0tKk/IRm7YBh3cCRSKr0/C3Oovj+PLXazkY20Sw+yck7R7
         6nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=4SL1/qbkTptdsuZGoXAM80S4DBJva1Vt53CdfbCl4nw=;
        b=hcbKZjK7NKThf9rD3iLPHu4Mb9syBvI7iGYcO2dv8CkpycvIIwKogkck0aKJAwzDz5
         KJ2e1VLZRLyrwRklCIEQx9kkjDljSGnsYMbG+LpgEYdkGZlsjWUvFV150+flLj+91LBC
         60uyqVuFKk0StuEtle2D+dbhcsTWtEDxn62o0V5VQTdqYa/5C7pwje+EazPSgscO7TW3
         SXjpReJdmvteK4svsljYIjW7S8CN7ZL0IDWL7aAatS/LthEQXJ26reuZ6IlHZ1xaf+my
         UQX6lZAFDfgHFih/VzfdOAqLFT7oPZWHehrPMsSaCPou1bxPGo1et0pFHfI30hAtgd4b
         3ezw==
X-Gm-Message-State: AOAM5326SUQW3NtvP0pTgtDPE9dy1BST9HX+04e2v1ar7YpsVl8GM/pc
        9iZIPxZOepBKc0waRXzGwJ4gwANg/ek01eeb9oE=
X-Google-Smtp-Source: ABdhPJwLEKb32kabIJmnaoDOUgwXfzmAZdQFcPCOid6gzEsbMQ12ZDmBKJVhRpApQ0dFGFaQcFsbBQMsvT0nvHZgfhM=
X-Received: by 2002:a81:1784:0:b0:2d6:b6cc:8f75 with SMTP id
 126-20020a811784000000b002d6b6cc8f75mr1766153ywx.46.1646863808959; Wed, 09
 Mar 2022 14:10:08 -0800 (PST)
MIME-Version: 1.0
Sender: nonyeric777@gmail.com
Received: by 2002:a05:7010:17a3:b0:210:b67d:202e with HTTP; Wed, 9 Mar 2022
 14:10:08 -0800 (PST)
From:   "Mrs. Latifa Rassim Mohamad" <rassimlatifa400@gmail.com>
Date:   Wed, 9 Mar 2022 14:10:08 -0800
X-Google-Sender-Auth: A-ylJH6d8QesrTinhC3C-jwmAXw
Message-ID: <CAEx8jzr7_KJ=Xox+w2-DOG0L0eeKy1+Y6+HM2gxOcqFpu6i-VQ@mail.gmail.com>
Subject: Hello my beloved.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Greetings dears,

Hello my dear Good evening from here this evening, how are you doing
today? My name is Mrs.  Latifa Rassim Mohamad from Saudi Arabia, I
have something very important and serious i will like to discuss with
you privately, so i hope this is your private email?

Mrs. Latifa Rassim Mohamad.
