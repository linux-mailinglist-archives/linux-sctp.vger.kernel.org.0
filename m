Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2474B87F8
	for <lists+linux-sctp@lfdr.de>; Wed, 16 Feb 2022 13:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiBPMqZ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 16 Feb 2022 07:46:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiBPMqZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 16 Feb 2022 07:46:25 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CD61F6BB9
        for <linux-sctp@vger.kernel.org>; Wed, 16 Feb 2022 04:46:13 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id ay7so2257971oib.8
        for <linux-sctp@vger.kernel.org>; Wed, 16 Feb 2022 04:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DNlgyVaU8TjCWNLA871jCHNl9EtR9BXdeye9SGukbxg=;
        b=hARA9aRgJun4pYSGSkWKwOkp9gaL5faGuWMwFTpkFrM/fl38FTX8UgX5FrRX8wVtqT
         Fb+N2G3Kovl3ergmvpVKaYw7wcOob9WKqittmv6IRrXfX2ifOOyWEqX+TKGO82ZUglay
         a3M3rzEGTCYeutboTRvuDtqi0WSQioBQzhp2xEEOXMStVHZiebhYpfYUI+nx3/qwaeUW
         jPSrEZHoQmVl5JagZeXbWOuolTq+/47CCZpaxZ8b8t4d+AKxOf/zsRk0Y0vPdM15XLph
         5JgjrMsZbmy8/aemg9KFoNQjx9U0BnSmoCQRB21GSc0gX4q3+g93tihTxHUDhXItBKIM
         U9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=DNlgyVaU8TjCWNLA871jCHNl9EtR9BXdeye9SGukbxg=;
        b=XOkTGwB/g/Twd7u7jaAgcEcXKgw6FBsbteJk1Fhd9HeWhEOnskZJnlv1oZMdPw/qTf
         lPAaIVxmTLC+qRmOryOWIFvtQRTcMOznPltuOtwUN+bXS1oW9731VS1x2fNWNqfKSmZG
         mHOp7Zsk5+vhH6uFTc/hFGoXTD+DWqtJh3cmro+J54szLEhtg0du5SgJs0drh1hr/NrN
         9HDcQ+YFAj385soJjWFFJjyhsUKw3XdZVyDz6SgIxdbpuo4yEjMIODFpvVU/HNqtmSwQ
         zpzM/X/SHVVuV9cjDP9zemjtqDBugnZS2RaSGofuHOMBKAxowP7n1lUjG6dujUe3KO4+
         gKpg==
X-Gm-Message-State: AOAM532RmUAj6qn6ByEX3LPzqY11JtO+WQ2No/NNkjcPY8or8VDW7Fbt
        QqoSUwtTpADhxH/BZxmJsrnU647+EsOjCa/tzEQ=
X-Google-Smtp-Source: ABdhPJxUzhATjE9WRhi3O6hd8sUISyEYIhVF7LLwrjKYgA4ELB5UhG6XggTcz+CyhaIPmluf7lp7XklkEJxZbb+ExbI=
X-Received: by 2002:a05:6808:186:b0:2cf:9af3:71c6 with SMTP id
 w6-20020a056808018600b002cf9af371c6mr520891oic.142.1645015572503; Wed, 16 Feb
 2022 04:46:12 -0800 (PST)
MIME-Version: 1.0
Sender: mrazaraibrahim2010@gmail.com
Received: by 2002:a4a:9621:0:0:0:0:0 with HTTP; Wed, 16 Feb 2022 04:46:12
 -0800 (PST)
From:   "Mr.Ibrahim" <ibrahimidewu4@gmail.com>
Date:   Wed, 16 Feb 2022 13:46:12 +0100
X-Google-Sender-Auth: dSu0YePOhMyiBo5pjcEMriizPmA
Message-ID: <CAFvumbT2V+K8nmrsXDDmA3KQLDODoMOcCjnx4tOrHSjkMnE_cw@mail.gmail.com>
Subject: GREETINGS
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrazaraibrahim2010[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrazaraibrahim2010[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22f listed in]
        [list.dnswl.org]
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.7 ADVANCE_FEE_2_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I have a business proposal in the tune of $19.3m USD for you to handle
with me. I have opportunity to transfer this abandon fund to your bank
account in your country which belongs to our client.

I am inviting you in this transaction where this money can be shared
between us at ratio of 50/50% and help the needy around us don=E2=80=99t be
afraid of anything I am with you I will instruct you what you will do
to maintain this fund.

Please kindly contact me with your information's if you are interested
in this tranasction for more details(ibrahimidewu4@gmail.com)

1. Your Full Name.....................
2. Your Address......................
3. Your Country of Origin.............
4. Your Age..........................
5. Your ID card copy and telephone number for easy communication...........=
....

Best regards,
Mr.Ibrahim Idewu.
