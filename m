Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E965648D5
	for <lists+linux-sctp@lfdr.de>; Sun,  3 Jul 2022 19:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGCR0i (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 3 Jul 2022 13:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGCR0h (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 3 Jul 2022 13:26:37 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F67200
        for <linux-sctp@vger.kernel.org>; Sun,  3 Jul 2022 10:26:36 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id q140so6927915pgq.6
        for <linux-sctp@vger.kernel.org>; Sun, 03 Jul 2022 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xCOwDQy21Ld30SQ4BcPGwbGpkaFInErbW2YUBTkEmhY=;
        b=ECxYszghauAevwUXi3SLjw8+qnYU5eHAxrAkxusNUaxNMvS4FZbNwGZpxI2fa3qzun
         8Zd9sLWAi2dNc2bduFIYyOUGiQK+S3RmdngBndC22FuqyexyVdasphmNl8wXBCw3RCFj
         NAzTUn+7GXrUfih8TbPGpDAMXuoBooi84BUdLaygGXZ9+BtrjXMzk/lxiWSDGL+Kkxf4
         7l/uEUjuVDD1bjO5L69WzHsSrOWeuvZAl9i0HYViR2VD/Q/t99GPpAne25hcDkndiEod
         wOQ+bQtM7N0dGA93GF3P+FpcYzoIyg6+hCT/0JFTSP0/Ij24gd9B3cTryn+w1cusi5A3
         mi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=xCOwDQy21Ld30SQ4BcPGwbGpkaFInErbW2YUBTkEmhY=;
        b=dDI2VG944/ziYn2gItXJ96iP/D+qRXYukYdlr12Tm5AgWEtjZwrqoe8olJil4yqKo1
         reCc200fVO07I1L/uXbM2f6t1c9DvltqNvXy0QCz2S2XAW3jQtmWwS7tro/wceCVmbFt
         kehuigFKhh9KQ+hM4kjqAy2jEKrjVW9fKVdEi4GaQD6Wlf60sGaQdtxFpKk9fTVJ1pSh
         ke6HllYMz7OATLXWtD5jVDYsgTfTUY7mXwhRfVxqp5K0X8xQJkaQCoS90EO3jjfgR63N
         JcB91nFrV81bDyNPhrjPoqs4lCZ7N8XvphBt7Q4tZUXWkzL0HcuWPodK8p8n9eHgLFTu
         iKtw==
X-Gm-Message-State: AJIora/ZeuAbYSq/cFINZ/Ax3/cXQz3Z1mhZ3wXVWXBwrkyH73rR1flu
        9KBQ7m07ng7rY5G+UwITNzqG/LGz0eYyJhRzAbI=
X-Google-Smtp-Source: AGRyM1tgX1bA31nl/wxM9i+YalSYeD3KzN1AIERc3ZPqTiTgiTq81VYfdg19IbwxFbZ4IB50Nxs8prwBs8ah3HXTXDc=
X-Received: by 2002:a63:9512:0:b0:40c:a165:a60e with SMTP id
 p18-20020a639512000000b0040ca165a60emr22111985pgd.398.1656869196009; Sun, 03
 Jul 2022 10:26:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:1790:0:0:0:0 with HTTP; Sun, 3 Jul 2022 10:26:35
 -0700 (PDT)
Reply-To: kbreitenbach17@gmail.com
From:   Kristina Breitenbach <dedadedvg2017@gmail.com>
Date:   Sun, 3 Jul 2022 10:26:35 -0700
Message-ID: <CAMnn89-xEeg1MPfp2DfY+WK3EnS97adYCHue-tyyPfBhYGQ0zw@mail.gmail.com>
Subject: Re, gute Nachrichten
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_TVD_FUZZY_SECTOR,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dedadedvg2017[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dedadedvg2017[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kbreitenbach17[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 T_TVD_FUZZY_SECTOR BODY: No description available.
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--=20
Hallo,

Wir sind eine registrierte Private Loan Investment Company, in der wir
t=C3=A4tig sind Europa, Amerika und Asien.


Wir suchen Beg=C3=BCnstigte, die Mittel f=C3=BCr die Erweiterung/Verlagerun=
g
ihres Unternehmens beschaffen

Gesch=C3=A4ftsinteressen im Ausland. Wir sind bereit, Projekte in Form von
zu finanzieren

Zinsg=C3=BCnstiger Kredit. Wir vergeben Kredite sowohl an Unternehmen als
auch an Privatpersonen zu g=C3=BCnstigen Konditionen Zinssatz von 2 % R.O.I
pro Jahr.


Wir vergeben gerne Kredite in folgenden Branchen: =C3=96l/Gas, Banken, Real
Immobilien, Aktienspekulation und Bergbau, Transportwesen,
Gesundheitssektor und Tabak,  Kommunikationsdienste, Landwirtschaft,
Forstwirtschaft und Fischerei, also jede Branche.

Die Konditionen sind sehr flexibel und interessant.

Bitte kontaktieren Sie uns f=C3=BCr weitere Details.
Email: kbreitenbach17@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fe
Kapitalfinanzierung One Limited
