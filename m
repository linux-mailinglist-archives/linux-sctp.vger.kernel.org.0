Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6BC6A9DC7
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Mar 2023 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCCRfp (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 3 Mar 2023 12:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjCCRfo (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 3 Mar 2023 12:35:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B05647410
        for <linux-sctp@vger.kernel.org>; Fri,  3 Mar 2023 09:35:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so13187203edb.12
        for <linux-sctp@vger.kernel.org>; Fri, 03 Mar 2023 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677864936;
        h=content-transfer-encoding:to:subject:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LaOTBtKMwRZiDcFQS8k/nw3O839PhUwgA/MLGTdCM4Q=;
        b=XsfLZGPBCkZpbYLKTLp47Ulc5DHq3dO2+KOjEaGpnh1cbY2L3L9VeLjQb95An2jKuZ
         1u1d9y/5cNxTfmS8GoKP9mi+wYRBoI8joth7quuNTWxmt2RowWqDdNZt29uX92WZSGou
         Mfs1OqnL+jqqQwtra3ay3e0wFmgaqIboQ1TDxl7VVFfC45NQ2LxDCjw4DZhtvPzxoNrJ
         4Ptc6rKFBylMom3BtQ95swbtBDAJ57GYpxcP7GQ3E6v9U65VoJOKcxcwno7YFcLhhhUS
         xwixqk1zaVqoQ2TvlET08DrToc8giehEDeZ3+LfQmfWkMhTgVqw/4bSzfIANWAMq4S6y
         v+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677864936;
        h=content-transfer-encoding:to:subject:content-language:reply-to
         :user-agent:mime-version:date:message-id:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaOTBtKMwRZiDcFQS8k/nw3O839PhUwgA/MLGTdCM4Q=;
        b=bB5Ib7Kz95mQiRAnEyjqpCTHqZrT5OKb/4P2549YQvTKfslHpjU11oMpiK98Wdlwwf
         rDuIW3ue3Gnjo3bJQYOt8Bp4Fl5m8+dUo5xAPEvRVPgyo5vI53mvDx5JvA+3BB1xdcRj
         vXJs0INRM0UXRpHvLsQA+ZgqvU9bqS44rxoHUtfRZHhI+k5Ji4NF4cvs/0ST6QfndLcj
         fsToe05gBlNW7IfTea4m8OsGrWOEzz33X1G7UPMbuBApb1H073cI4yLPzA7/bFDy4aLS
         /hytGqHmsiNoiQumN8W+IATvJpukDr5mMkcRObi4WFyOlP0H6OWjsjYA6bquoqjKIsvD
         6J1A==
X-Gm-Message-State: AO0yUKVSxjEwCZiYfTtzxvcz+2+WlY5hSQGKz+mKlYbPFtZysXb4fS0g
        ifKhupEfZDEg7UwET5MnTh0=
X-Google-Smtp-Source: AK7set/+7M61D00/SfNuPaWXXYqGOI2wGD5ag24h3Dpw8hEc2ePrkURnc3UE8KclhOatiWJwL2OCSA==
X-Received: by 2002:a17:907:97ce:b0:8f3:9ee9:f1bc with SMTP id js14-20020a17090797ce00b008f39ee9f1bcmr2498557ejc.13.1677864935978;
        Fri, 03 Mar 2023 09:35:35 -0800 (PST)
Received: from [14.2.2.97] ([196.171.80.178])
        by smtp.gmail.com with ESMTPSA id pv16-20020a170907209000b009079442dd11sm1159376ejb.154.2023.03.03.09.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 09:35:35 -0800 (PST)
From:   Soufiane Soufianess <lanbanipascal@gmail.com>
X-Google-Original-From: Soufiane Soufianess <lanbani.pascal@googlemail.com>
Message-ID: <fccf8e06-0f7d-f2ed-81c6-4b3423c022ba@googlemail.com>
Date:   Fri, 3 Mar 2023 17:35:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: emailoffice151@gmail.com
Content-Language: en-US
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4873]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [emailoffice151[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lanbanipascal[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear Friend,

With due humility; I sent you an email and there was no response, please
confirm to me that you did get this mail for more clarification.

Kind regards,
Yours in service.

