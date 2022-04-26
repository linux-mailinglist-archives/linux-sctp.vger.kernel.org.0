Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B178350FAA2
	for <lists+linux-sctp@lfdr.de>; Tue, 26 Apr 2022 12:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbiDZKfO (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 26 Apr 2022 06:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349187AbiDZKfG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 26 Apr 2022 06:35:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3C1759DE
        for <linux-sctp@vger.kernel.org>; Tue, 26 Apr 2022 03:14:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m23so10462944ljc.0
        for <linux-sctp@vger.kernel.org>; Tue, 26 Apr 2022 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=iVRRXkOXoqY/EYM3m5fQzAZyEF7D95hbXONnhjKaAXxyHqk4G4fXAq3RAly4Tl5Xvt
         zghEdgBbJJHVNTQ18UsOXbgfPlg2RIrwK6zw140XzIU+FIowWyRh7mUGE7j/0SsmIuSM
         nv1UeaaRhYAnc9hfcHVkFW2P15rg23CFuuvYCUuTSUKpN3SH1NMWt57HV9GZgBtRaAVp
         1s2RfWMpniBXNBVJpvzSHhhMNZhcBI/boGcAzNqZTBqFRpCGd6jEd/lTk1YSbcxaWGrA
         zGaxB8yMnhidtfhCs8U5ilQWUDdVfcq8d3umqDw0D2kXQI69fsl4y5h3Qy+hKLbxUpt9
         3ZSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=aPTFbZr4LhKGppGQDkO7tNLWiZLizgW3cwR+POXjY4E=;
        b=MwJ12AkprYGsWCE6DqyScS1Sn47VbryOt/WkbXMa7442YU2+Wkh8IMrxygeY+9hzBj
         g7Q2rvf/FVAclDb5/WFisMWoJm3/RooP5BV5w8VyXYUbRucuFmEe3Vs9tlB3ozVj8bZo
         ko4gOu+qzZ3hfd77HUiD+ztTfKnFgpWCnVFAmgxFo9K06pHCJQlV0oD8KPMi5yY4rXsp
         woTe4GvNY1tbhVkNhg9Did/1/KVx2BfBgcXVFerHLPXvEV5wwThCW5ELEtG8QVtK71KV
         r71QcZnvd3HxTIJfWBPhPCjX8OS8+oeQm/0MnwzuUGct58jGptokxRv5dgC/b0MRBdMP
         WT5Q==
X-Gm-Message-State: AOAM532t+1ade9xYzeXVykttg+HX3qOVjBlm6W8NvXSh66CCNJCQPEf4
        ALaMzBFsOeuE5n4ZUhbO8QLqDztF76FRZmG7/Uw=
X-Google-Smtp-Source: ABdhPJyyX3E8H/gtK3/ybZX/llKQqtQOatCc0MWUfGSOAu9ZAWANOmalb+vlaI4Y5dOkkPhGN5uHnqXR0jdW6+sdIPA=
X-Received: by 2002:a05:651c:2129:b0:24f:1a26:df1b with SMTP id
 a41-20020a05651c212900b0024f1a26df1bmr1832764ljq.223.1650968070258; Tue, 26
 Apr 2022 03:14:30 -0700 (PDT)
MIME-Version: 1.0
Reply-To: dr.tracymedicinemed1@gmail.com
Sender: ra00028671@gmail.com
Received: by 2002:aa6:c784:0:b0:1be:7e7e:6b3e with HTTP; Tue, 26 Apr 2022
 03:14:29 -0700 (PDT)
From:   Dr Tracy William <ra6277708@gmail.com>
Date:   Tue, 26 Apr 2022 18:14:29 +0800
X-Google-Sender-Auth: di3btg4IKu5pT2yenoASHIFxA9A
Message-ID: <CAEWKTYdMjoJ5NvavTGVxGF5hdrfpt50exuNQdZA4n8Cqjr5Tog@mail.gmail.com>
Subject: From Dr Tracy from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4967]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ra6277708[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dr.tracymedicinemed1[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ra00028671[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello Dear,

how are you today,I hope you are doing great.

It is my great pleasure to contact you,I want to make a new and
special friend,I hope you don't mind. My name is Tracy William from
the United States, Am an English and French nationalities. I will give
you pictures and more details about my self as soon as i hear from
you Kisses.

Pls resply to my personal email(dr.tracymedicinemed1@gmail.com)

Thanks.
Tracy,
