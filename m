Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2384A5E9902
	for <lists+linux-sctp@lfdr.de>; Mon, 26 Sep 2022 07:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbiIZFv5 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 26 Sep 2022 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233442AbiIZFvz (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 26 Sep 2022 01:51:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B9422BC3
        for <linux-sctp@vger.kernel.org>; Sun, 25 Sep 2022 22:51:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y8so7477281edc.10
        for <linux-sctp@vger.kernel.org>; Sun, 25 Sep 2022 22:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=bP6gxJU2ceOtoiTrEoGM4pjb2aTL/DZUG5W0nNV8SUs=;
        b=eq+/Wt52SO25ddq9qiPdhC6An5SKdhx4ldWp+qTX9buxoshEkersOuOGSxo6ZQSLbC
         Q7L2jMxrlBVckgfyXS8fjlc3mMie4Fsx+1H8n4/xTfAvex8yhgDFbrr2qiiqw5ZBHCij
         CyG/wskzANxV9FRThuV/hJCcyp5D48Xqq7/1KTh6Vb8HWNH+rPTr5fAyHZjmg/gJFFsJ
         wGgyFZR4Lm7nG0fBbQaj+xQ0NiRgAHFpXU6xbgrfpdiI1gFDW4jgjUe4C7ICumPIdMna
         WutfKBrXKnLwp8hD5+2OFlVlMdnT0ww96wR3QRDSelKyQcnbl940EGz71nkOVr9q7mSI
         aWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bP6gxJU2ceOtoiTrEoGM4pjb2aTL/DZUG5W0nNV8SUs=;
        b=msLn6YcV3wN5xPWB+/NggmuxHJ4o6r/X8nl5tO+HmflfnGQREfFeYb5eSNLRujG3uu
         ThQWJ676oyukmWcG/1h7/Am7fHe7ZyEUK3bPBI48EeqdhbZRdMFggwhb2v4rvMoeg1A0
         xThwbNjnTy3RB6LM5ph5ATehPH7MTTGE2lXmHROHxVenrf/u5DT8MrV6LFjEVL+jzomk
         9gfBSoxhuMqPQtXAGU57grwRWeArY4Zdc3bnKBpbX3qh4GN+gwo0CFh4HyXvVpSoFB8W
         Uni5SoD4Kd/7y9Ve7x/5b3Z/7ZunrXv2czonn2LBzd2GJk7CimtajKlzYrXlpLCOIAk3
         N14A==
X-Gm-Message-State: ACrzQf2URVCFtn5kYUM1YnndXbN4shVxMyb2rZMeNtdVVtUOA0qLlror
        JEFGvGdm88D3uVaHrTPlDylVfsf5eQBeKGilPxE=
X-Google-Smtp-Source: AMsMyM5zifNbDk/+TAuQWmdGIxKt0eDO0JgjBvc7UkPDluVOjkjusG33P12OGP/Nq4+BWgFDEFWrNJ2++RTMd1JFJik=
X-Received: by 2002:a05:6402:847:b0:453:944a:ba8e with SMTP id
 b7-20020a056402084700b00453944aba8emr20262556edz.326.1664171512649; Sun, 25
 Sep 2022 22:51:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a55:93d0:0:b0:1b7:a0ef:ac79 with HTTP; Sun, 25 Sep 2022
 22:51:51 -0700 (PDT)
Reply-To: petermalsam611@gmail.com
From:   Peter MALSAM <vidal.charpentier@gmail.com>
Date:   Mon, 26 Sep 2022 07:51:51 +0200
Message-ID: <CAN7qQvRLMqfKc3D1Y-qiuSoaSGOxV-ow0FjqKHae7pdstwKyUQ@mail.gmail.com>
Subject: Geldverleih an Privatpersonen und Gewerbetreibende in weniger als 72 Stunden
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
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

petermalsam611@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fen.

Peter MALSAM
