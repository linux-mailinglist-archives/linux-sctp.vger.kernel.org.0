Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935813DBA2A
	for <lists+linux-sctp@lfdr.de>; Fri, 30 Jul 2021 16:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbhG3OPS (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 30 Jul 2021 10:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhG3OPS (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 30 Jul 2021 10:15:18 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733EAC06175F
        for <linux-sctp@vger.kernel.org>; Fri, 30 Jul 2021 07:15:13 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id v3so4040111uau.3
        for <linux-sctp@vger.kernel.org>; Fri, 30 Jul 2021 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=X0EmIHh5ul6NJKk/pBY4/z8/+MXiI9ym64pW06z1cs4doAKhb3+PgocUnPSP2ugnfG
         2ALkNlhbtZxf/oEpXHNbDjArVfjo66RPMhswryw60ITuW/UOOXRzrRUfbncU1dVYuOpI
         sj58X9PRFM5dpCfhNakvZ5jNn8NSfe2i/ASjTUwtPEQ4uX4KSLLCI7g4w9sX0WlTD7qt
         0Ak/rLtoPebgPlHapPf7kB8VIPzkp8uIVihnvewDoETffw31WOdTIEbQwH9OMz9ZSxi6
         ZgwllRYAOeZaKlGs+H2uYJYe/LyG8XM62/bn+yXGXk60OXDInV9caGTL/eVST5BAcu6H
         yCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=SnkW2ATTV/3JNadW5EEl+AwOBp1Ct8C74QEwo0lwyqeQW9uIvS7U8VUSN5MuJgZXf7
         RwiDrKiurDAeKWtYrrZBr0Pgd6099/JwwloXphVjmzg0RMJAuDzyHZ5z+z9kcKXaZLMx
         bcKxDJls8QHRR6u6i8/zymEdz2Y3ErDQkIzSwPozec4huxDN1BRPmbxKH5iuKpVgnkuJ
         DTYyJB1yJUmUHfCz7SuX/+mBmaqBLheCIuaCbDuLELSqWNbJwfF2x2nAQf8FQs3qgERA
         DhlkcusrOu9AGS6qGswrHs8cHoqnZKEjmqqvh0Yb8XT6QXai2V29Lxi+CU4kAOXRJHBo
         WKtw==
X-Gm-Message-State: AOAM533EO1iGi6pNumpvtJGdQOd1U1XVatprc7DvyxXAUeKj1RRWSpdA
        8IcWNBMcE/XSKxyuqYe/C9Mnfsn1I0q+XePd/4s=
X-Google-Smtp-Source: ABdhPJxuzwLqiqko9lgwN2hRVM2a/Ct5kMQJGJtIGPG16oUCn+vPI6z4Pv5ggt892P0JsCpbnMX+AaG6ltyXCqVIqF4=
X-Received: by 2002:a9f:2427:: with SMTP id 36mr2084918uaq.35.1627654512600;
 Fri, 30 Jul 2021 07:15:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:ee8d:0:0:0:0:0 with HTTP; Fri, 30 Jul 2021 07:15:12
 -0700 (PDT)
Reply-To: fms90883366@gmail.com
From:   Frank Martins <frankmartin21968@gmail.com>
Date:   Fri, 30 Jul 2021 07:15:12 -0700
Message-ID: <CAKPs0R1UYP4-rtKdWQc_R371StvqrBQovqfsQnYn6tGGzHUxUA@mail.gmail.com>
Subject: =?UTF-8?Q?Lieber_Freund=2C_Ich_muss_etwas_=C3=BCber_Ihren_Familienna?=
        =?UTF-8?Q?chlassfonds_im_Wert_von_8=2C5_Millionen_US=2DDollar_erfahren=2E_Bi?=
        =?UTF-8?Q?tte_best=C3=A4tigen_Sie_mir_diesen_Brief_erneut=2C_um_weitere_Info?=
        =?UTF-8?Q?rmationen_zu_erhalten_Ich_werde_darauf_warten=2C_von_Ihnen_zu_?=
        =?UTF-8?Q?h=C3=B6ren=2E_Mit_freundlichen_Gr=C3=BC=C3=9Fen=2C_Herr_Frank_Martin=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org


