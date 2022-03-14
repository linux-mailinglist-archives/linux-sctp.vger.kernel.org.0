Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151DC4D8BCD
	for <lists+linux-sctp@lfdr.de>; Mon, 14 Mar 2022 19:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243856AbiCNSdo (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 14 Mar 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiCNSdn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 14 Mar 2022 14:33:43 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31893E0CA
        for <linux-sctp@vger.kernel.org>; Mon, 14 Mar 2022 11:32:32 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e5827a76f4so3329627b3.6
        for <linux-sctp@vger.kernel.org>; Mon, 14 Mar 2022 11:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=TGpQcYtmcv5tS2Qcdar8vH5sAIQ+8bqw6hemf9UXnpQ=;
        b=Q3zuqumSZ88dnANM5KLTnDqivU/KZ4j7Ufc6a8am4HDJOQ5OvgQEF4+Kzwf+wlhLn7
         oIpY94/U0xMBniChs6QFgLcXUwM1tF3942o9CdqUD4RWWD9pfP+OF0dmZuUMyQuxR8ZG
         XJrWfaShQH/wBCNVV60aS+EeVp8GVRnVvaXQdntOrvQDurJzgEtX8WiGQJgYm8L6ss1y
         GHKkcIUvEk6evnsUVDS8DnG1yHpkp6tYFZBdTuta5X9TqeIPygOfax7AbgpShrcgub9z
         +JFMKn+4ZlgHrNDOnTmU1a/z7+oP1dAC+dzChNNCzIrt7kMwJavkhl6EemQE/4VJ3G4E
         YhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=TGpQcYtmcv5tS2Qcdar8vH5sAIQ+8bqw6hemf9UXnpQ=;
        b=5/SekqSgoS49YEleYiIj7B1AS7Ki2gkCqocu9mS1OsJlxp1IXwP/eeHfgKYkxprpqH
         t5BLDxnU0BsMx3w5YlBu8huP44p3wijHTxtDBJLyxouIX8PpgHCR75BUpkms2rIarwLe
         jIPA6D6QaayMIwytPmPHnIeZs6WcEOM2NJqzwmnd3VHR9BOmJJ5HxHcTiVIPXxKdZ4bv
         UG/a60TaCfYUKI3O5lMalGom63arY618WD4Jx+6zxwguph9TYNkzCFsqcWtUil9gDt8B
         OUtmRPuUxXQ4boDuh+6xcFPCVRywoYOVkdPLDlVRkHnfeGV2TVYM0VyOEwhDPAA3bVzR
         GgcA==
X-Gm-Message-State: AOAM533vbDadRaIH6ZJX3eOLrYFvCr759avIbnnfV5B9Hi2CuWhtN7Kl
        HhXGolgG4YKqQg5PTG7kkNhHVwwSn/Ja/D/1lBU=
X-Google-Smtp-Source: ABdhPJwqzXrhI+agc7dyU9SpW8+mq2f1+4FdBqKJHoiMZHQCt1SmJ0TuxxW2qXZj792L0fyIiGmWDt7FhMONKHtFe3A=
X-Received: by 2002:a81:9101:0:b0:2dc:1af:e2e4 with SMTP id
 i1-20020a819101000000b002dc01afe2e4mr19589180ywg.91.1647282749924; Mon, 14
 Mar 2022 11:32:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5354:b0:236:3e3d:3842 with HTTP; Mon, 14 Mar 2022
 11:32:29 -0700 (PDT)
Reply-To: gisabelanv@gmail.com
From:   Isabel Guerrero <rlori5284@gmail.com>
Date:   Mon, 14 Mar 2022 18:32:29 +0000
Message-ID: <CAJpYZBetmZUQwbhYmQWVvrSpHxwGTKj_PoLNgCLvjoPn49wx9Q@mail.gmail.com>
Subject: URGENT CONTACT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4799]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rlori5284[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rlori5284[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello, good day. I=E2=80=99ve not yet received your response to my previous=
 mail.
