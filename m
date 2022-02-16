Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526994B8093
	for <lists+linux-sctp@lfdr.de>; Wed, 16 Feb 2022 07:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiBPGDq (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 16 Feb 2022 01:03:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiBPGDq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 16 Feb 2022 01:03:46 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D139813CA1F
        for <linux-sctp@vger.kernel.org>; Tue, 15 Feb 2022 22:03:34 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id f6so1281034pfj.11
        for <linux-sctp@vger.kernel.org>; Tue, 15 Feb 2022 22:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CmuNpHT3Ghu1p9u8qrzNES2PUlPivqE0AKA17621SPk=;
        b=iLHVrETnhGtopDR8UqvraeJNiDoKFDxKfNO6j7cmMRD+zWInSYs2IXKAUBerK/is4U
         ZGusAlsLUsuEllpM9aDO+rwpMwKtLa+IwXF6jQ8nO/k1h1wT0jxH9Fx+pdFk25LidkNi
         S4Sx8P5DqJ2swysTR9MhVM7PRz0yMU0mv9zkpZM5+QZK/rMDOLs/B7jBazwydj7GDQb8
         MMtnkySImmpSqbNdqL5kxse1cFnyLHLkldpX6xGNavLJ4HXGnq9NL8kE7di9iM3SyDxv
         ZUwB9cpz5JG4e/KjgU5MKTgVZFe0HVETcPMKLVrMARUSe7IdxckG5EUqNR/A/l2jnVAX
         beEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CmuNpHT3Ghu1p9u8qrzNES2PUlPivqE0AKA17621SPk=;
        b=jLO2O0ChFQ3/5dO1hpxL8cmDVGA1Wg4PEpAUQy0Qp6EdlhFXLwH/dfj4Ln9gd6LkDK
         DqupUuclPtT0agpqhcFEHT+d0k2I/VMX+OAp3DjNoNIdWSsp1YOa/0cRUKBIOiOGGcNm
         Lx82nncxeU6LpnZpCHYJFiBGxhOm78DWY1RzJHnkOBu5Yahl1CCbwXMEge33jedtM7Mv
         YKfnlA9pbBmdGSJOP1NsPQaZfiAgJeiQ3rnt5IdLnu5WnFuRePPEvoS/+mxsiAGbA3+n
         JSbh1q1lBpziOBB3Hhb0DCxXvKoWy1dtsaKbI6LBr1h4Ge+5OmjSxk3ZciaawL8n18p+
         gm1w==
X-Gm-Message-State: AOAM531dPfzXuT6VvIsiYDHWw9nKHAK0Ip/kjXyRlyJBkdD9fqTjLoMc
        ypA3BDCPQQq7vMP11If3lFFPD9W/6QpDDtzgdAY=
X-Google-Smtp-Source: ABdhPJyEuJijlrodT+udOmPKOeXDAbk8o0ZBbWPtlricnXHFoj5B9waxA1sm89C0LohRQC0fr0nC+mT8jSWQRh4WqfA=
X-Received: by 2002:a63:1350:0:b0:344:21b6:8a18 with SMTP id
 16-20020a631350000000b0034421b68a18mr1035623pgt.498.1644991414224; Tue, 15
 Feb 2022 22:03:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e81e:0:0:0:0 with HTTP; Tue, 15 Feb 2022 22:03:33
 -0800 (PST)
Reply-To: wilfried.vogele@gmail.com
From:   "wilfried.vogele" <vidal.charpentier@gmail.com>
Date:   Wed, 16 Feb 2022 07:03:33 +0100
Message-ID: <CAN7qQvQZY55p8X1htgEZXtqExtHnEvCNH_e3VVbA4Eir0pVH3g@mail.gmail.com>
Subject: Geldverleih an Privatpersonen und Gewerbetreibende in weniger als 72 Stunden
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:444 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5530]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [vidal.charpentier[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hallo,

Sind Sie in einer schwierigen Situation, f=C3=BCr die Sie einen Kredit
suchen? Ben=C3=B6tigen Sie eine Finanzierung zur Begleichung einer Schuld
oder zur Finanzierung einer Aktivit=C3=A4t? Ben=C3=B6tigen Sie einen
Konsumentenkredit, einen Immobilienkredit, einen Privatkredit, einen
Hypothekarkredit, einen Investitionskredit, einen Kreditr=C3=BCckkauf oder
anderes?

Ich bin ein privater Investor. Ich versorge Sie mit kurz-, mittel- und
langfristigen Krediten. Meine Finanzierungskonditionen sind sehr
einfach und der Zinssatz betr=C3=A4gt 3% pro Jahr.

F=C3=BCr alle Informationsanfragen stehe ich Ihnen gerne zur Verf=C3=BCgung=
.

Vielen Dank f=C3=BCr Ihre Kontaktaufnahme per Mail an:

wilfried.vogele@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fen.

Wilfried V=C3=B6gele
