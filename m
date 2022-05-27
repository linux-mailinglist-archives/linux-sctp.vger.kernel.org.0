Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ED7535E4C
	for <lists+linux-sctp@lfdr.de>; Fri, 27 May 2022 12:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345578AbiE0K3s (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 27 May 2022 06:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344759AbiE0K3i (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 27 May 2022 06:29:38 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4812AB0A
        for <linux-sctp@vger.kernel.org>; Fri, 27 May 2022 03:29:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id x137so7188252ybg.5
        for <linux-sctp@vger.kernel.org>; Fri, 27 May 2022 03:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gMRL2ChFV1c1fJH6+lzMvi+AnpLvf8Jv1voAqTadcaU=;
        b=bLw6XqnKFQFFInt3xWPSaEjYC97Ne58ABIfFtC/c8xNSspu1BM5aHxb4ibCZBeUOsO
         tsNEZj8wNKP8NCOpiF8WBMhb7SxwcgYxhekqZDwZdc7TPLw/9quzv6ec+VZfG9KqmAQF
         zhg67tWPjE5SgXj04bzLI+Cvm4FF30BXHuzjaXvsLlnx1w/1xcUboByYoww2n5WNMOQQ
         emGH3nGLqT5qmYFczcgK9fjY9qbYbSP35oQLMCp4HWrmb/IDYxMUjKyNcl9G64n3nv/x
         kI34rfb6IBigy04EeoswvSiZYL/q/bzS+T0quNBt62sa1+l8JDC9qXsHOlQCQWCX/zxX
         PfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=gMRL2ChFV1c1fJH6+lzMvi+AnpLvf8Jv1voAqTadcaU=;
        b=bU/aRbKi/j1ihZ1lXwrTApcVVqzQiDKVxm2gIvOCURGgtb7uFb6RAZ7HXXQjKRU7vX
         LnQVb/ttkPZEoNwpf0bjfoaKR3FoCeT6IC5ypIGVzeTzLg9Xhl0QQy/Xh9PY+pc0ujUM
         WuVqbsiDyEZwWve8eSTi9SjGnw8nCzRq5UykQ21CbsZkNrGi/srNCDfVp1woMAHfV2Pl
         sGAFiRhSlYHRau15XHy8pUucPRPoaRWUXlVi9Ae0EFZOD+XyaazZbNlzd1k+UpfVcn81
         GTAYT0c1Kuwe17crHJUnvIPdGVaVNWIp8Ynl6zlgWc36io9ZQBZpYids0BcV/Myjqgei
         lE5w==
X-Gm-Message-State: AOAM531OPSYSzqBFJd2T0PjnkCr4vQDlgUDuddWUppw9ws+GcbemiTus
        2Q5MWQl2iqCwbs7+fWBJK+T2ZLByobVpfUIF3Rs=
X-Google-Smtp-Source: ABdhPJyJE/2t7fe/ogDcp3L0AeSMlCiMYdLgJd1UgXaFx96hKGCFD7eF7c/OcuJXsBIHPqWKtjc4+mNYMj86jhh61Is=
X-Received: by 2002:a25:e7d0:0:b0:655:22c0:ea08 with SMTP id
 e199-20020a25e7d0000000b0065522c0ea08mr14301066ybh.374.1653647370714; Fri, 27
 May 2022 03:29:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6902:114d:0:0:0:0 with HTTP; Fri, 27 May 2022 03:29:29
 -0700 (PDT)
Reply-To: donaldcurtis3000@gmail.com
From:   Donald Curtis <91474711amele@gmail.com>
Date:   Fri, 27 May 2022 11:29:29 +0100
Message-ID: <CAC=gNW1ncEMeGc8aCf8F8gVGVPEVWiHipAwefzpfxfHr=n9rZw@mail.gmail.com>
Subject: Donald
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5044]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2e listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [91474711amele[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [donaldcurtis3000[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,
I called to know if you received my previous email, reply to me asap.
Donald

Hallo,
Ich habe angerufen, um zu wissen, ob Sie meine vorherige E-Mail
erhalten haben. Antworten Sie mir so schnell wie m=C3=B6glich.
Donald
