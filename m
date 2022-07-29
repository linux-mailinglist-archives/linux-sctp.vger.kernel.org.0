Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428D6584F32
	for <lists+linux-sctp@lfdr.de>; Fri, 29 Jul 2022 12:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbiG2Ksa (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 29 Jul 2022 06:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbiG2Ks0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 29 Jul 2022 06:48:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BC713EA4
        for <linux-sctp@vger.kernel.org>; Fri, 29 Jul 2022 03:48:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p10so6714740lfd.9
        for <linux-sctp@vger.kernel.org>; Fri, 29 Jul 2022 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=Xp3jiYKdfD+2KOmUSOr0cVdDmDB/vg9vLamjcTiNnoc=;
        b=B6GYMsHrbjLCgvlp/NAuQQSVdFKJohBc7NZq244AvhAAdABLpApG3S5rlkvzh9tIqC
         qWwH8UDaUQjA2p1BzmLLnDl7ZFW768ojH7tv+QsIY/SjJve9enaRJK8/UuXW89DCR/AY
         tpMTTL38XGcODyb6Ss71WM+Y+Jqg0uOelzkLwwqZLeAMIUmSj8aXpgHeid8lEfZmwA71
         8iqEsdQBvOTMjrY9zllIKgcK1xto4BTMgcTQu2GCds1we2/vXhlY0JStfMXx1qWgLn42
         BGJTRj87Htot5wXsdWQJjXBjOenJZivGkFCRs/YW8l69gnWJJsHWQ1DrUNPfE7iQ5QEB
         u1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Xp3jiYKdfD+2KOmUSOr0cVdDmDB/vg9vLamjcTiNnoc=;
        b=0QFD51iNeV30dWC7CEXa35PRvikVy1tqOhF+6tFR6yRzCSd9STT9p9A1s+b/BnpOZl
         /p/ETFPEwGrJ/Twzo8Ibgq+IlvJ6clVEyjm6+ow8N0FGAwxFiw4I6D4/58MtThyX9Jb8
         A9FX6bBwGlFZH7H34E0tReodE/cFNhQogIuKUBHgxwDh1OFK3V3bxVs6yYhyTe0S6Ejz
         6eP2yI/+SfkVGUlRLsCHbKOky7OD+sY6zj6hIiPnyXQR8+zOp7+EKpiPDnRQbWp07nj+
         zPM/33PcFETpmS5uAIq0syXsyyBiDIAS/re+KSuXwtT18Qd22cPwkJno+4ggTOwCp6Gq
         Ygyg==
X-Gm-Message-State: AJIora+rnmnv3dhdKeF0Tfs+xqq7wL4QDDvP2HVMLVMpAXuRDjfs9s+R
        GY4FjLTl/fZ56R1U2natztovpXjfTdjBlaMFnJs=
X-Google-Smtp-Source: AGRyM1tuWrSEr5Qrn6I7AaHjaNhLTvGBRbfiDoV97WbDSNBIDrWiwK73DftzYo5H2xIA0bDfvIM34Azp1bwyZeJSlgY=
X-Received: by 2002:a05:6512:3188:b0:48a:bfeb:8965 with SMTP id
 i8-20020a056512318800b0048abfeb8965mr1038783lfe.487.1659091703290; Fri, 29
 Jul 2022 03:48:23 -0700 (PDT)
MIME-Version: 1.0
Sender: hgghghhjhghg06@gmail.com
Received: by 2002:a05:651c:1583:0:0:0:0 with HTTP; Fri, 29 Jul 2022 03:48:22
 -0700 (PDT)
From:   "mrs.sophia.robin" <mrs.sophiar.robin424@gmail.com>
Date:   Fri, 29 Jul 2022 11:48:22 +0100
X-Google-Sender-Auth: IGC02IOky-qK6WeQEwEg1v7uEs8
Message-ID: <CALjxKU7WFRKc5_4_JZ8-WgJvcU52+abq0KZ+PF6z0tmKN_qXLw@mail.gmail.com>
Subject: Dear victim,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:132 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9542]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hgghghhjhghg06[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hgghghhjhghg06[at]gmail.com]
        *  1.7 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear victim,

   this Is National Crime Investigation Center USA.
In our Investigation from banks on International and National Funds
Transfer (INFT) protocols In The past 10 years from all banks
Worldwide. We have come across your contact details and record with
One of this Bank. in view of The carried Investigations, we have
Contacted you confidentially for vital Information toward your
transactions with This bank. It was clear That The bank have delayed
Your payment Thereby looking for a means to divert your fund to
Different Individual account not belonging to you.

How ever, all bank officials who mishandled your Transaction has been
Duly sacked and management dissolved and dismissed from bank work as a
Result of This attempt. Upon our Investigation conclusion, we found
Out that your Transaction was Legitimate and for This reason, a
Compensation Amount of $3,150,567.00 (Three million one hundred and
Fifty thousand, five hundred and sixty seven dollars) has been
Allocated to you for Immediate payment through our accredited bank,
Platinum Federal Credit Union USA. Kindly contact the compensation
paying officer with The below details.

Email: mrs.sophiar.robin424@gmail.com,

Yours Sincerely
mrs.sophiar.robin,
