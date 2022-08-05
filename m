Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62E4858AE81
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Aug 2022 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238484AbiHEQwl (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 5 Aug 2022 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241307AbiHEQwZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 5 Aug 2022 12:52:25 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8417E2A24A
        for <linux-sctp@vger.kernel.org>; Fri,  5 Aug 2022 09:52:09 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-328303afa6eso29402747b3.10
        for <linux-sctp@vger.kernel.org>; Fri, 05 Aug 2022 09:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=GX2VsLe6zlHZJQaHxp6ZA63Q6+Lku6F2sAX8QsLIKqTE8h7oMk0SU4TUzgZG+2H42N
         Y3M8QZdfZ//CLy+DcNT6/+0oT9ZKAF8CNmXJgXH0kNrgIxHXEQjkOBKiRee7arN0Mm78
         rT3uHj+GbzXwZ41Q6/RemZmgX3XW2/OZDwJr4TansR3NRlk/tMjZEVj18+zu+8xyx05H
         vuSnJzTiEWKcabR+DOkd2oD5C3F2ooX6jgF0WPY9oaWjbL/Cg2Iych/77dHIWmbUnG8G
         t0Imft6QKm/NQPv2rRXV4zbSg3sz2qgD5iynshhZZ20p1ps6UE3BnMB+E4nYdVfidNvm
         Vhpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=npxCWy2DywcBQq9OCNxxK3fUiVjXtjApy10t54oASAI=;
        b=pVIJBKcxFVP57SzT2NCB9hRw1j7stYwe1X8ERqrnMQP68kABBcYzP0AGpKrY7cWJ3x
         uVbVzC+ottB2cqZZLeLj3aQ5mghLD/oGkxNuDTo64jM2+/KsTf/0fymuOOOkZ9pWyOwt
         5awHt/wXB9I3Yn06mM4zB5dfmpRKM3gMcPQJYAxOwTpOeRGm9kE1+uk9Hndlj5P0Xcs8
         o6oIh6OvYDS7+V3oK2dtMgD4qliS2Be5EqIQp0R/SL++FXZT124YWXAvD1k8cOUa3v0i
         i26PBAAYOQo8YyYIq4zXV89s80jIG3hbpNABcBnPdQrqtYSEkYXp2TwKwPwD5Lom/ano
         bHkw==
X-Gm-Message-State: ACgBeo3sHVwXDskFLq4ox8bciUAr8iAYUMOY+xjz7eA/iqRslf+Tn1Ac
        xuhSpzdq3I5avxFQV1sbLuXJMEe4/Gtdv6taNZs=
X-Google-Smtp-Source: AA6agR5ECIuy+HZtHmx/LEBzJcu4mAgIjHfuaxJ5+4AZG4EImRPAdIMnAgMaGH+q7RLzvh6UJEKZ/028k/Nrdcnc1rM=
X-Received: by 2002:a81:a004:0:b0:323:fd73:8a25 with SMTP id
 x4-20020a81a004000000b00323fd738a25mr6596490ywg.399.1659718328709; Fri, 05
 Aug 2022 09:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:130a:b0:cd:907e:bca with HTTP; Fri, 5 Aug 2022
 09:52:08 -0700 (PDT)
Reply-To: abraaahammorrison1980@gmail.com
From:   Abraham Morrison <drjameswilliams1926@gmail.com>
Date:   Fri, 5 Aug 2022 09:52:08 -0700
Message-ID: <CA++so7nEjsrGoMDX8OTkxOB5qvEtj0YbEnm-Wvne_qTzE6Fs7w@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drjameswilliams1926[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drjameswilliams1926[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abraaahammorrison1980[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Aufmerksamkeit bitte,

Ich bin Mr. Abraham Morrison, wie geht es Ihnen, ich hoffe, Sie sind
wohlauf und gesund? Hiermit m=C3=B6chte ich Sie dar=C3=BCber informieren, d=
ass
ich die Transaktion mit Hilfe eines neuen Partners aus Indien
erfolgreich abgeschlossen habe und nun der Fonds nach Indien auf das
Bankkonto des neuen Partners =C3=BCberwiesen wurde.

Inzwischen habe ich mich entschieden, Sie mit der Summe von 500.000,00
=E2=82=AC (nur f=C3=BCnfhunderttausend Euro) f=C3=BCr Ihre bisherigen Bem=
=C3=BChungen zu
entsch=C3=A4digen, obwohl Sie mich auf der ganzen Linie entt=C3=A4uscht hab=
en.
Aber trotzdem freue ich mich sehr =C3=BCber den reibungslosen und
erfolgreichen Abschluss der Transaktion und habe mich daher
entschieden, Sie mit der Summe von 500.000,00 =E2=82=AC zu entsch=C3=A4dige=
n, damit
Sie die Freude mit mir teilen.

Ich rate Ihnen, sich an meine Sekret=C3=A4rin zu wenden, um eine
Bankomatkarte =C3=BCber 500.000,00 =E2=82=AC zu erhalten, die ich f=C3=BCr =
Sie
aufbewahrt habe. Kontaktieren Sie sie jetzt ohne Verz=C3=B6gerung.

Name: Linda Kofi
E-Mail: koffilinda785@gmail.com


Bitte best=C3=A4tigen Sie ihr die folgenden Informationen:

Ihr vollst=C3=A4ndiger Name:........
Deine Adresse:..........
Dein Land:..........
Ihr Alter: .........
Ihr Beruf:..........
Ihre Handynummer: ...........
Ihr Reisepass oder F=C3=BChrerschein:.........

Beachten Sie, dass, wenn Sie ihr die oben genannten Informationen
nicht vollst=C3=A4ndig gesendet haben, sie die Bankomatkarte nicht an Sie
herausgeben wird, da sie sicher sein muss, dass Sie es sind. Bitten
Sie sie, Ihnen den Gesamtbetrag (=E2=82=AC 500.000,00) der Bankomatkarte zu
schicken, die ich f=C3=BCr Sie aufbewahrt habe.

Mit freundlichen Gr=C3=BC=C3=9Fen,

Herr Abraham Morrison
