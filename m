Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2EB622333
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Nov 2022 05:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKIEqN (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Nov 2022 23:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKIEqM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 8 Nov 2022 23:46:12 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B46647B
        for <linux-sctp@vger.kernel.org>; Tue,  8 Nov 2022 20:46:11 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so486619wmb.0
        for <linux-sctp@vger.kernel.org>; Tue, 08 Nov 2022 20:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pNCH53mecLYGasEWHq0PMVI0sGrG9B8snD4A/whETAE=;
        b=BKZ81MWCgpcaQvOZ7MCWyflBluFs9RoSm7pJsEO3segB+kKJVE7lMZ72/onicfiubW
         dp5rj2XiA9lc/4DkJHMQHSipAFgBX/N0JC0kbfgGckZmlYkrFafH682uM1q6+dBQAH4c
         KGdpqfgyzYWeNs4sURDOK+seJLbVa1oImb7r9mUQSHQbDMXu6hB/JfGhZmy6WsiRoDIm
         A9t3+Gg5lJ/pW6+n/iT0mKUyVbKDNXEUyDDiYs1XPiQl/ynwhyOC3n7Wus83YLK66lcX
         1pQiYYk56AzO62751Gdm632t0PsYZWt8z7wz8YLUQjlHx82k2fR/VG/+zAqYrx82+fSk
         6T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNCH53mecLYGasEWHq0PMVI0sGrG9B8snD4A/whETAE=;
        b=kGTh9UN6IZIf74pfiX/xtwpyGRCR7aY3fuTwdoVAKeMnOXc27M3XQv36ARsiERyHEz
         iPNvMEL9LrkET2CotW+QjRHTqVDOi3pKa+Bz9QdPu+lSiYQQ8NYUyTb3qS0d+kCjZ+ci
         D+UW9Gk6wm/QOQZeg3majiNX+hJo0s4TKD97RUV9B8hcaaS7qpxB6fHq9iSp+rTxm7m7
         VS/c90WXjyDhcfvN3IUuRi3Q2hSSghWSeNq/nEYD8WKhbZx3hOOznTJR5HvuLcaysHDO
         yjUCnC6UNlqAOcW8uJPoUxSPgo6+qbfgPTJiIRLSuvpQ6j/ybIjUWqcA+cZ/WZfViX19
         F9lg==
X-Gm-Message-State: ACrzQf2rrllvmas+N1q3dOuuEh7uT1DIWYYFnc2kE0tx/Ir5cdfJjBLP
        8viKpUWqeT/Gop3SI5apuneO8hu/4JcotQBDlHc=
X-Google-Smtp-Source: AMsMyM6ba2/dJ9iRZbT76qRwRcRJE/3sjBKFmIjTIBppsKujnYRcDsZf16j+AvBk1sZy0AlmcMvLgUH6Y2Ut6jFBVGg=
X-Received: by 2002:a05:600c:42c9:b0:3cf:69d4:72d9 with SMTP id
 j9-20020a05600c42c900b003cf69d472d9mr36455964wme.93.1667969169590; Tue, 08
 Nov 2022 20:46:09 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:ed47:0:0:0:0:0 with HTTP; Tue, 8 Nov 2022 20:46:08 -0800 (PST)
Reply-To: petermalsam611@gmail.com
From:   Peter MALSAM <philippefontaine14@gmail.com>
Date:   Wed, 9 Nov 2022 05:46:08 +0100
Message-ID: <CAL-e08Tc9149y-jRJBMyHKmLuBzQqzhGg7ZTgQ4-EtZxR9L20A@mail.gmail.com>
Subject: Geldverleih an Privatpersonen und Gewerbetreibende in weniger als 72 Stunden
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [petermalsam611[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [philippefontaine14[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [philippefontaine14[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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

petermalsam611@gmail.com

Mit freundlichen Gr=C3=BC=C3=9Fen.

Peter MALSAM


KREDIT PARTENAIRES
