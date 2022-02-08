Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA70E4AD7EC
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Feb 2022 12:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiBHLv7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Feb 2022 06:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiBHLvz (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 8 Feb 2022 06:51:55 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8145C07D68B
        for <linux-sctp@vger.kernel.org>; Tue,  8 Feb 2022 03:51:54 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id r144so20706684iod.9
        for <linux-sctp@vger.kernel.org>; Tue, 08 Feb 2022 03:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=EhMSDVSYztoG7AfHV4Vb3k3J5zgh/OHu1B7Q1T4DdnBYiZms20saGm7S3u1WG0KBDM
         XVab0A5yk1WZD35+gINnMvuaRGrFVHnYqo7T9Xfm6Tiw5xfnx1QhGC5B4/Vs9meO1YcY
         fsPn+MbWfK3Zqt+8JBFax8dgmuB2I7u1EHt76ndWmkcqACII7sHSiNU5QD+2Yb+uY70L
         /d3uQ/ehDCKLH57c9Ro7Gj0ltXg7W5c6DDG3/gBmVRLPTuEkiRjFl3OUAmQqVxuM79Yz
         V741U+9umIWbPqI1QKo4NPN2HthqJOdGfUqw+i4ICyOAKhEdllH5c1agejSw36dVUe4l
         1Fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=C9P/DHqU/t/wFuAxuBylqOGpD0qQ6r700RJKrW8VDWZhTGH4PzpeG79qIMZHkrSb84
         sNQnjH3bJX9tAmqVg/D/z8beS5wFSiBqsSKSTaJ5HzfVX5KX8H/Xo7XqgRd0ABLZ/zGm
         T+puvZutHAVbdrc9nqx5bsQXEcAiq/BhM/baxIm2wY5oVeMLRuLj/zaa/NQX72sosdi8
         963tuxUyJcqXKTtXvJQEvYn1XzjlBuulU643V4r363ecPvcMul01nbr1UkoWxglD2/yY
         e955ZQGQ/qDMrRBbdu1DzFzkT8vUxZOSNT5Cfv/KgHMHZ3hwHe3TDWz+UeFoFmkVhYAe
         7UqQ==
X-Gm-Message-State: AOAM532ZctUl+ndFE5DWsY6B90nZmmmBMCy/U8yS6FFbJsVuf0Rwj/vL
        Zj5ECrLPNsuFfUoxtsJ7U54TLZaZPQn3pwUn9Ro=
X-Google-Smtp-Source: ABdhPJy/lc7MtyU4VTqEPnHapchd9Kz0CmUIFbatepV5JUpa1O3wgGxcenOTjF5DAmH5IvUMOlo9fIcXkjWaCTYVskI=
X-Received: by 2002:a5e:d610:: with SMTP id w16mr1784456iom.87.1644321113923;
 Tue, 08 Feb 2022 03:51:53 -0800 (PST)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: aliwat885@gmail.com
Received: by 2002:a05:6638:1ef:0:0:0:0 with HTTP; Tue, 8 Feb 2022 03:51:52
 -0800 (PST)
From:   Zahiri Keen <zahirikeen2@gmail.com>
Date:   Tue, 8 Feb 2022 11:51:52 +0000
X-Google-Sender-Auth: oiVTYPMk83A7Q2ch105CJaOXceI
Message-ID: <CAA2insJQOZkq0LMo0QAwsxXRkLG5KKz1--z299vV1vyrazm33w@mail.gmail.com>
Subject: Greetings to you.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4879]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aliwat885[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zahirikeen2[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
