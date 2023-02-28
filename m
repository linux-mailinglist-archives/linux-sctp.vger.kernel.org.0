Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28A6A58CA
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Feb 2023 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjB1MEK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 28 Feb 2023 07:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjB1MEJ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 28 Feb 2023 07:04:09 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE442DE40
        for <linux-sctp@vger.kernel.org>; Tue, 28 Feb 2023 04:04:08 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z42so9892285ljq.13
        for <linux-sctp@vger.kernel.org>; Tue, 28 Feb 2023 04:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+k+YR0XLbOjpIw1D1tAsgxD/7d/+7mH6f4z4UDbPL70=;
        b=l1pSq/hW0xWvLb39rz+PZBaKPcHq59igktLpR8pRDznOov3tEtFz0948f69517jHUD
         pXU8K0tc/fk42Q21T/8SkPy2yQZLSIapaLE2IQR0TVKh9j7hq93+5+JRLMfSUaIXZzj7
         aGV5QDE950yLDh7fE4+9JhNl9bPUoHM19wZVllofofaF+12k7kjm+2CMtC6bbRFVF7hY
         eShl5mKeqX20iF3tXnN6cqRCs4qiqkbHXNejXuaBdH63GjLFcguKE3ZntYZk3+WKJ5WP
         VZeZUSxAoNYR0p4KLXnsiUsY6p0vZu1Udjg+FDUOVp0Upi3DYkzhCjOhZmpv3X03EnZd
         /xXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+k+YR0XLbOjpIw1D1tAsgxD/7d/+7mH6f4z4UDbPL70=;
        b=R4QvCqgwyZBGiIO/8e4JeF7/kpOgtnHq/IWXMnB8gZ2Q35IAUdOSO3/gBcpbS9lCdy
         xkCcT0cCycCNTtm12xeLXlGt7u4KaVouvwcs6ZUdVs9OGIHK9wqgT4beQvp5F2zsO6TG
         7L74iwbrc0ZCH3qUKgEIuoehbP8r386ZXEOPwIG3YQ7qJNbosNSMlJD9BRX1Hc+CND8D
         PQ/RhucF14F0najq/wlbuI1Sf2KQqMIR1cGumqrtq9JwvhvFk+ofJBKLJI/F23PhW+Mf
         SRKT4Y8xAupUjE7W5KdUdFqL5KxFSO7OPNxsPNXO63ADdPcxnCvJtAMnhxrP7NIu/B2A
         aMRg==
X-Gm-Message-State: AO0yUKUfUcMHbWs6r92Y8bXlsR9fybXiIEfyPDrqFOlz/zHW5pKh3AOh
        Qr0JDO1eW/cElMLIybvC8hiPNuTGnk3FBIu/fNk=
X-Google-Smtp-Source: AK7set+4nrPk+VoT71SvDrJKrSkLx5S+Jt3ygbhyLe1vWM9mfhuTOcXYxkSjrdiPH9GPmgEdcQvdqA/Q3RIRu0Vn5JY=
X-Received: by 2002:a05:651c:1249:b0:295:a446:cd05 with SMTP id
 h9-20020a05651c124900b00295a446cd05mr722423ljh.6.1677585846450; Tue, 28 Feb
 2023 04:04:06 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a2e:b4a5:0:0:0:0:0 with HTTP; Tue, 28 Feb 2023 04:04:05
 -0800 (PST)
From:   Francis Kwame <franciskwame575@gmail.com>
Date:   Tue, 28 Feb 2023 12:04:05 +0000
Message-ID: <CANiRMRP9xsUR5ugVvN-mx98TgVjyvU3W-BQyYVp3-kRV4ibumA@mail.gmail.com>
Subject: Att;
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Good day,

Kindly confirm if this e-mail address is still valid so that I will
give you important information about your late relative's inher!tance.

Yours faithfully,

-- 
Francis Kwame. Esq
Principal Attorney of
Dominion Associates
Chambers Barristers & Solicitors
Public Notary , BTD/SORT-CD-00247901
