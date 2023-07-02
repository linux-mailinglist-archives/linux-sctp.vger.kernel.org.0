Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5166744E8C
	for <lists+linux-sctp@lfdr.de>; Sun,  2 Jul 2023 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjGBQI5 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 2 Jul 2023 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGBQI4 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 2 Jul 2023 12:08:56 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C523EE60
        for <linux-sctp@vger.kernel.org>; Sun,  2 Jul 2023 09:08:55 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id 006d021491bc7-565f3881cbeso1168480eaf.2
        for <linux-sctp@vger.kernel.org>; Sun, 02 Jul 2023 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688314135; x=1690906135;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=woT4Y6rZ5eMwziVdNp3BBHa5AlN1UvrqAgZ4Kd65IuI=;
        b=PLMS+MwkNr7aVyYxEMZrfM8DZ9aZA7mLLuBay6APh31BqkaJjsapGINhnZB1qHG31d
         OmfGLIces2TQElzoK88u62gW0+Ug659T5t5xLfnrt0NRTdYyjQY3zoidC42gAAszGHg4
         F9WTB3xNOO2vTEHyo0fOEuhrKbkcFW7qMpgZXQMNnlEubudb7UcnQbZUu+WlqV1hjWOf
         jcKGBqGvdQDOU7dGnVX5UwJ0ZV3LawfYxI/NQg99H767xVWMqU5RN+Izo/AzRdT8ZOd7
         VvlNzQxblpTZ1C3DmIQ+LaFzv8eojdVFW6pWTbwZAXKU8uYVSGyH/W0RwUb6iE7trY96
         oQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688314135; x=1690906135;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woT4Y6rZ5eMwziVdNp3BBHa5AlN1UvrqAgZ4Kd65IuI=;
        b=Wywri1hG3h05IGEGBNrmk1B3rStAijEvsBM6YlOx+YwrsBg3kpyG67zlNtcdC+0wv6
         71c9yCQgpyvFM4DF9TE8qkkufNNIGJ5zBE3EkYseIm45HCiwRD2osPwd5qAoo4g29PYp
         PxMfLT+IGpnydyOS9zWM21B9vnSeGWofTHzNy0B8jZ9Zrwqyc8sBMHyHDMR4I1bDXtnz
         UG17r96Y5Ya3nUdk3ZDdbKgOpwWhkgzGrbgQXEs64+9FlUPxDRJXaYSOviRCa/6RdouB
         awQ3YObDTkHGQwfZR2XDio3Z2+JyJ5D+9Mnw72oARrkGce041BM+Gh7gW+cEBBDhReEw
         eNiA==
X-Gm-Message-State: AC+VfDz+k9eYPC5oKu2FAvhvxDyzGTGc4JaFTkbxde8fw/IWqAn39vgT
        /yqUn83wCd1sU6gGuClpNrSI6Jm0f/MBd8bPYHU=
X-Google-Smtp-Source: ACHHUZ65K3UxtkqG7Oaic/kmMkrHgZYGqmqJpkCZJhUYqepfoT9AjwbMQRXR0MEINLtN13Z/mEr3CC16w+vCKhNKfAY=
X-Received: by 2002:a4a:2c82:0:b0:565:83d1:e3cc with SMTP id
 o124-20020a4a2c82000000b0056583d1e3ccmr6946633ooo.2.1688314134518; Sun, 02
 Jul 2023 09:08:54 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrr.patriciajuliawilliam@gmail.com
Sender: johnsontadams1@gmail.com
Received: by 2002:a05:6358:e48e:b0:134:c251:6e70 with HTTP; Sun, 2 Jul 2023
 09:08:54 -0700 (PDT)
From:   "mrs. patricia julia william" <mrr.patriciajuliawilliam@gmail.com>
Date:   Sun, 2 Jul 2023 09:08:54 -0700
X-Google-Sender-Auth: 3O0cvdpVZwvFtPi4BaxTy8vFU9s
Message-ID: <CANBATOcjaHdXxOR-QfxdNDkHpRd=E8riiGmVrGX=7gNJmBa2+w@mail.gmail.com>
Subject: Good day Dearest,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Good day Dearest,

Mrs.Patricia Julia William, from one of the cancer hospitals here in
America suffering from a long time breast cancer of breast and i want
to donate my money to help the orphans, widows and handicap people
through you because there is no more time left for me on this earth.

Yours sincerely,
Mrs.Patricia Julia William.
