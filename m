Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A506A427709
	for <lists+linux-sctp@lfdr.de>; Sat,  9 Oct 2021 05:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbhJIEBa (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 9 Oct 2021 00:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhJIEB2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 9 Oct 2021 00:01:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADD0C061570
        for <linux-sctp@vger.kernel.org>; Fri,  8 Oct 2021 20:59:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so9205217pjb.4
        for <linux-sctp@vger.kernel.org>; Fri, 08 Oct 2021 20:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OB8oKqFD0hsxaxmsoGbmPn6aPO7+uZ/DUqZDxe4V+aE=;
        b=GoMmjRI5wgcT0BLRYX7r/QJW/a3wyU7z7l/9JxpDPaZQK0yeYKyWHcv64wKNxSvUhX
         cA9bmH2b9cxvqEoZJ/JHOvPe8SUPE/shDIQsFerjM0F1/G4HoLjHroB2kUvyoEkgngs/
         XNZFmNvSY7WIAayZDXnXaBsjD8evqatoonQ7eIml9KRsY4UxRp8o5pDUmoZxSH3jesRZ
         ejh/6oUPNPck0WQEY0XJvJs9Nzr7JcZzBU7R/o6nzemTq28YahlpOy4EfYYKFHk2Abxm
         zmX6jrsA5qVj3BBEw8k94aKh5XwuYGEC7EGdAUeCVHaUexmwMZt7RWrAOe9B6ncWhqOB
         ggQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=OB8oKqFD0hsxaxmsoGbmPn6aPO7+uZ/DUqZDxe4V+aE=;
        b=sdfxszDWSn3iATyxpAuWKQ1C+oMAjNwSm4eat5DxctKTu7+f5s/KP4FFr+i5pCdxzU
         9Kt4LWNqSqwGlCBVN+lL1Gbb1tC54HhhKEB1II3t6x/sRy60TlS9cwWFBzWxbFOyCEaA
         JpkGXxQg4I/QH16iylURSDUOYp4EqEgNWmbvmDgVkO68X0vHacLR5cSBUGmt/zZJa7hJ
         a4erSMeDruJwlP9iQnErZNK3mcuZY459ufzgppxBfmXC3tUrFVXm895b1zM2cP1z4l0F
         gSgh69cJnPM33/edmmlkTkuwkrKvu9qqBrfxbEFrTQ/v1zSt/ugqMkx7oXf3O+urblox
         A58A==
X-Gm-Message-State: AOAM5326ZGoccaATdcGtAOS2DQOjhTYreNW4JBBY+nB9lhaBXH/MH54/
        zc1W4wJTSP1RmD4kU0rbPsclAh85Zbh+VVn95aI=
X-Google-Smtp-Source: ABdhPJzzC01h0lQRob+B7vx6oM0erix2iA4WebKZ6VT12upHsDjShNKftlxi8J0L6502TtX5DRGFTjLsgikkyeD+OQA=
X-Received: by 2002:a17:90a:1d0:: with SMTP id 16mr15874057pjd.60.1633751971726;
 Fri, 08 Oct 2021 20:59:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:2d05:0:0:0:0 with HTTP; Fri, 8 Oct 2021 20:59:31
 -0700 (PDT)
From:   ibrahim sani <ibrahimsanigml340@gmail.com>
Date:   Sat, 9 Oct 2021 11:59:31 +0800
Message-ID: <CACgL27Ot67JL5RJ7eKL4hLCBDrYUm+Eq6U=g0-42MvWwH+AdYw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hallo, lieber Beg=C3=BCnstigter,

Sie haben diese E-Mail von der Robert Bailey Foundation erhalten. Ich
bin ein pensionierter Regierungsangestellter aus Harlem und ein
Powerball-Lotterie-Jackpot-Gewinner von 343,8 Millionen Dollar. Ich
bin der gr=C3=B6=C3=9Fte Jackpot-Gewinner in der Geschichte der New York Lo=
ttery
in Amerika. Ich habe diesen Wettbewerb am 27. Oktober 2018 gewonnen
und m=C3=B6chte Ihnen mitteilen, dass Google in Kooperation mit Microsoft
Ihre =E2=80=9EE-Mail-Adresse=E2=80=9C f=C3=BCr meine Anfrage hat. Bitte bes=
uchen Sie die
folgende Website f=C3=BCr weitere Informationen, damit Sie diesen 3 Mio.
EUR Ausgaben nicht skeptisch gegen=C3=BCberstehen.

https://nypost.com/2018/11/14/meet-the-winner-of-the-biggest-lottery-jackpo=
t-in-new-york-history/Sie
Weitere Best=C3=A4tigungen kann ich auch auf meinem Youtube suchen:
https://www.youtube.com/watch?v=3DH5vT18Ysavc
Ich stelle Ihnen 3 Millionen Euro (3.000.000 =E2=82=AC) zur Verf=C3=BCgung,=
 um
Ihrer Gemeinde zu helfen.
E-Mail: robertbaileys_spende@aol.com .

Ich spende diese 3 Millionen Euro (3.000.000 =E2=82=AC) an Sie, um auch
Wohlt=C3=A4tigkeitsorganisationen und armen Menschen in Ihrer Gemeinde zu
helfen, damit wir die Welt zu einem besseren Ort f=C3=BCr alle machen
k=C3=B6nnen. Wenden Sie sich an die unten stehende E-Mail-Adresse, um
weitere Informationen zu erhalten, damit Sie diese Spende von der
=C3=BCberweisenden Bank erhalten k=C3=B6nnen.
E-Mail: robertbaileys_spende@aol.com

Gr=C3=BC=C3=9Fe,
Robert Bailey
* * * * * * * * * * * * * * * * * * * * *
Powerball-Jackpot-Gewinner
E-Mail: robertbaileys_spende@aol.com
