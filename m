Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3CB4933C9
	for <lists+linux-sctp@lfdr.de>; Wed, 19 Jan 2022 04:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbiASDv7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 18 Jan 2022 22:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiASDv6 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 18 Jan 2022 22:51:58 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7DC061574
        for <linux-sctp@vger.kernel.org>; Tue, 18 Jan 2022 19:51:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id d10-20020a17090a498a00b001b33bc40d01so2210818pjh.1
        for <linux-sctp@vger.kernel.org>; Tue, 18 Jan 2022 19:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=CmuNpHT3Ghu1p9u8qrzNES2PUlPivqE0AKA17621SPk=;
        b=PJGGTZWzRImW5LI9rw1pg5Ta/6NDdGVBwlTAc01jVzryCnMgPTjoRLIrs63SAinmgt
         siOrlfszWehMWBEjzN6TA7W/WzG4B6H/IUNJUsaebp0LuWz4xRCmINIBsJVFWoLsf81u
         PJPlD8K8uZAORiJm2CYd2rnqwcdoxvqzbTb4YeRsBJQ3R+sF0vvyRjFcN5Z/ghAeEN7v
         EggGjrncV7t36tkIm1yqP71r/QTsu7zaDGJNkwL3kD7GsRkAtBoMaq5Bt9vDCDlMJmZb
         p+mZmDzQ/R4vIv3JyMhQdeRb9x8PTOuA4ZaK7jwezFyYFNY2oxxqnwYQf5FGRtZ3ydxo
         sQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CmuNpHT3Ghu1p9u8qrzNES2PUlPivqE0AKA17621SPk=;
        b=Qk3sjR6CtRVEzZQj7sD5Aq1C00DOWe9QKKPgX0KkISWo5sUwd4ouO2nPrVKxncqHTg
         3MoeneVYZLKlJqKwN2TUJqmfqz80enMreVFOQCYOXXoQ1B+jLYW4wjsJ0Mh2dY/DO8ar
         yYEIjWuDchcDparPOWKRd/MrTnOeSEOHRCvBUuZdFCvKRSwUguJUNaZaf9R2Kc8lT2K6
         fmjpmqXZl2fY65aT2PfDmcEGgOZIfyY+TXIc9kPjzaT4tbujekgIu9stTwN9vRHtVPQy
         W1lj73fxoPGXJGuaswLnquaJSKcIJ7N+vc48KJ92yR/GGMkGQu4A8fLVbI12dWNMyAMO
         fSjw==
X-Gm-Message-State: AOAM53353XalJ6Z/z5e8MuRAfj6OdxL9B+zywtn28NaD3nXFmU59fqpO
        SjcEJhhWB9CJo3PSI6Vo5jslhkL9yd8iBh8zXqo=
X-Google-Smtp-Source: ABdhPJy4OVkLPfxr7BqfBLXfy8aNPU0DuSiHKMnRx9my8J3pKAzVTW5D1F1njuEBZ5sB1pDlg5LJKiIYKZSDampIprg=
X-Received: by 2002:a17:902:e546:b0:14a:6fcc:607e with SMTP id
 n6-20020a170902e54600b0014a6fcc607emr30778068plf.38.1642564317664; Tue, 18
 Jan 2022 19:51:57 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:e816:0:0:0:0 with HTTP; Tue, 18 Jan 2022 19:51:57
 -0800 (PST)
Reply-To: wilfried.vogele@gmail.com
From:   "wilfried.vogele" <vidal.charpentier@gmail.com>
Date:   Wed, 19 Jan 2022 04:51:57 +0100
Message-ID: <CAN7qQvRGK9H1WZSwsR8aM5U5+wFmkYJsKpv4s+hbNcCXr=y_-w@mail.gmail.com>
Subject: Geldverleih an Privatpersonen und Gewerbetreibende in weniger als 72 Stunden
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
