Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EB14D254E
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Mar 2022 02:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiCIBEd (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Mar 2022 20:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiCIBE0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 8 Mar 2022 20:04:26 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D0812D90C
        for <linux-sctp@vger.kernel.org>; Tue,  8 Mar 2022 16:41:28 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id w17-20020a056830111100b005b22c584b93so584173otq.11
        for <linux-sctp@vger.kernel.org>; Tue, 08 Mar 2022 16:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=+xCzDXKpurcBEhZ8+xr/1+qLsXYFBobYcsOzCn7TcBU=;
        b=XSbt210YK3OwB8wIDmu53kgtJP38rHmAD5FaiHiVGlepJsJd696/T5xmG8hyg4Ae77
         ZxNPfeeUrpNZShX9iA5wyFQk3u0qT1KaMBWquXgS0JED+6QHx4xODu9SSs51gkcrHhUJ
         bhumKSlZqgQ+n0RwIaCWY5RHW5ly+DtsZSrpvyLNxMqe+rhUinBV36XXI7zju3lRwanW
         qf/c++go6R/1B5TFxDbgQ2M+HNDmMEGei+7sykXvzOYdcd3TZXCT7r1i9m7wa5CzENY8
         84jCUQQnLVizI/4tp8CKRcS/7DtBpeVxvlAF88TNX29g41+PbTrXXwJ1BW43LRDgCJye
         HhYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=+xCzDXKpurcBEhZ8+xr/1+qLsXYFBobYcsOzCn7TcBU=;
        b=dLU9CvWec66quxSPCEzabYNsY3Sp8m5LH8Y+OHG4TjYC4I64/K36gFpLaRO8Bi3Rsu
         t4L6T7HLq7RH4aVdR7Exrd8RbgXBWo5Gv+YS7qmAmU7OEZDgCbYVV6z49ar6PaNr4MVo
         LL3UsrYmxRgXOnG6/LMsWpRg5XIfeiGHpyGgRF5LR/CE1WTqtjqoJccsiaJeDyW4/IPE
         19vltaxeqR+MTurLEgyH3+MQ6t4vdL2naQqqK17Je2kORcZjjGoKGsQ13j4wUH1o4cN8
         iC+b5wZ2PH2XbZHZt2O9zihe2iNtEp1iTDO0HS5Dzdf3plBetiWbxu6Vh7TN0f3KsNJu
         4R5g==
X-Gm-Message-State: AOAM531+9CuezY1p/SIhB/e8g/oZFRBAlYkaJOkbcOa0/nf7befvvtRS
        r7QlSqTPiit8e7sFvfNfecxAfXLwrmGVrf/Zji361MTblNlWiMWTJD+iPg==
X-Google-Smtp-Source: ABdhPJxQZfT5tk0JOwIvXXJjqTRxyPD2A8KYJwP0skjHYpTFU9Z2xKXN15qcHetWIZ+EM5IgpYI827WnYjRmM1AecZA=
X-Received: by 2002:a05:6902:3cc:b0:628:73aa:9c7f with SMTP id
 g12-20020a05690203cc00b0062873aa9c7fmr14662951ybs.632.1646782712030; Tue, 08
 Mar 2022 15:38:32 -0800 (PST)
MIME-Version: 1.0
Sender: ojinemechibuzor1@gmail.com
Received: by 2002:a05:7110:29c:b0:16f:abb9:57cb with HTTP; Tue, 8 Mar 2022
 15:38:31 -0800 (PST)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Tue, 8 Mar 2022 23:38:31 +0000
X-Google-Sender-Auth: QdEAS4Rygau5LxW4n9N0kaGX4-Q
Message-ID: <CAAxBeg3RLCfg0hY+QYmx6L4mWADEyMQZak7LPw_BvHcLQrfNCg@mail.gmail.com>
Subject: My name is Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Dear,

My name is Lisa  Williams, I am from the United States of America, Its
my pleasure to contact you for new and special friendship, I will be
glad to see your reply for us to know each other better.

Yours
Lisa
