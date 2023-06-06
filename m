Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACB4723EEA
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jun 2023 12:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233011AbjFFKIh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Jun 2023 06:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjFFKIg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 6 Jun 2023 06:08:36 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3992E1B8
        for <linux-sctp@vger.kernel.org>; Tue,  6 Jun 2023 03:08:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6ef9a928fso49300725e9.3
        for <linux-sctp@vger.kernel.org>; Tue, 06 Jun 2023 03:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686046113; x=1688638113;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1KOoXg0khb7ub9aS1y7PhG31PfQuNeSSJdf34wiyC3w=;
        b=JqUVQ85WSi85kqMLiuybRJT0zT89pRtMOwo3kfSJIt2LFPujbOAdhCo/lJQQA5sxCu
         cV+YS4w6KGdDNqfHAjjaeGuV5ryaqvgQz0iGfmVgT1L0ABgsDI2QsjjYAwK2x48W35HT
         5MYiWIkjI5X75iLrHZOqZVfX/APpP3KvlDNNyJecnzRQKJdCQOV8ypDPvODjDZtX0Rre
         cOS8yzUwLNOrPfLvEfGXtwhaecLmlotcZ7vFJszC4UVQSdTjdXEEknvp14+P0ZLU1co/
         mkIE7ePFPJE4lodB0LKQ6C4DyJLbXPHvUbVgK/A9iUliJvAt+jqe/GyS1BF66Eqv8Me0
         CbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686046113; x=1688638113;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1KOoXg0khb7ub9aS1y7PhG31PfQuNeSSJdf34wiyC3w=;
        b=fvKvF8FVFuPMdxmOmAXnzeuaeOo9WcueSG343TFBe0ShOvfJdZica0fqNm1EbSgBsV
         lwcFn65NR/A+My/DgROJnfvGSaZ6u7u6E4gQFhD7XRZ9OUZDZev+C33NTR3SwPYdBlpQ
         Y6XyQjWj5CEVXAA00NXP4d/i1WRCIDVUH4pwdDGZdquArZX6uUZHruVTfdbvqYeRlVdA
         yacbTsUBg0AsxNwkYpt0TC3HvWlcD3QocFZvZyu2x1n9IK9euNYOWk4KPvXZYliG+RkO
         6S8VTJWnRLavebldhRTauHevZzTpfY2h//63TxWW9GgCdUspOVRhpGeJ9vzAW480juOl
         eu+g==
X-Gm-Message-State: AC+VfDzJI+f/Rd4Jz8TuHghCqcXLnXFRgW0LAssVFzjvXGsjtFya08bU
        /gZZgXpS0qmJpzJFZIQmWsw1yV6HThGUCeJaFP4=
X-Google-Smtp-Source: ACHHUZ6mfhT6U7FAkZb+xd1P/k9+7YdZ6LodIrkJBEkJVn2BjMNUVSWWmZYZWAaW1rwIvLJdY7GOnbgtIItulGAk9lk=
X-Received: by 2002:a1c:4b0b:0:b0:3f6:c8c:7048 with SMTP id
 y11-20020a1c4b0b000000b003f60c8c7048mr1446431wma.20.1686046112730; Tue, 06
 Jun 2023 03:08:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4d87:0:b0:30a:df6b:5e53 with HTTP; Tue, 6 Jun 2023
 03:08:31 -0700 (PDT)
Reply-To: 07445678an@gmail.com
From:   "Miss.Ann Daniel" <kouakouedoukouedoukou@gmail.com>
Date:   Tue, 6 Jun 2023 10:08:31 +0000
Message-ID: <CAMp67Qz75_3W4cdg56gUdLUXug4v=-yLQ4HuRX-Wc8js2HbUTg@mail.gmail.com>
Subject: Ich brauche deine Assistentin
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kouakouedoukouedoukou[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Ich brauche deine Assistentin

Ich bin Miss Ann Daniel, die Tochter des verstorbenen Herrn Gilbert
Daniel? Ich habe keine Eltern,

Ich brauche Ihren Assistenten, um mein Erbe und meinen Umzug in Ihr
Land auf Ihr Bankkonto zu =C3=BCberweisen.Ich habe von meinem Vater geerbt
(4,8 Millionen US-Dollar), die er bei einer der gr=C3=B6=C3=9Ften Banken hi=
er in
Abidjan hinterlegt hat.Wenn Sie bereit sind, mit mir
zusammenzuarbeiten und mir zu helfen,Bitte erwidern Sie Ihr Interesse
an mir, damit ich Ihnen die notwendigen Informationen und
Vorgehensweisen zukommen lassen kann, Ich werde dir 20% des Geldes
geben, um mir zu helfen

M=C3=B6ge Gott Sie f=C3=BCr Ihre sofortige Aufmerksamkeit Segnen.Kontaktier=
en
Sie mich f=C3=BCr weitere Details und Erkl=C3=A4rungen, damit wir Ihre best=
en
Gr=C3=BC=C3=9Fe an Sie und Ihre Familie weitergeben k=C3=B6nnen.

Sch=C3=B6ne Gr=C3=BC=C3=9Fe
Fr=C3=A4ulein Ann
