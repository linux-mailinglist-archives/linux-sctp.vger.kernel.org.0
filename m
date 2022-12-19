Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95146510BB
	for <lists+linux-sctp@lfdr.de>; Mon, 19 Dec 2022 17:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiLSQuQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 19 Dec 2022 11:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiLSQuF (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 19 Dec 2022 11:50:05 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F012D37
        for <linux-sctp@vger.kernel.org>; Mon, 19 Dec 2022 08:49:56 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id x11so9742384ljh.7
        for <linux-sctp@vger.kernel.org>; Mon, 19 Dec 2022 08:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2FkPSQhkPmlUq1MiBIrc+wGX4ejTebMXeFCRl3j6q9c=;
        b=FJKx0XcBFb+1Kxx5RC/twnpX3Vc27Zl8GB9UQoR6qv1uxO2UiVc2ZA7DfAHo+p1CxH
         mchtLILoAZ7vNTh9oR1jOwAIzGV8OQF+S0HNbJuq7U+IEJPmiicF0K0E6EWmSUjYGA3O
         iT2IhkWIzOcjf5I6KJIMyI14HgP4RjBmNqNkK8r5lc/xjVPYTvG0vXFzWd7zy524qfUX
         uFK+DkTzARcILJDGt5t7RNFxQNh+B4YBnvCfYT2e4Zecele7EcNLdbiOpIPYEeNd94R7
         9jpKu0DF6h4MvtmeLqwG+veOsu7y47eoSgpb4VR0uz5NycnhfE6DA2R4uiNXKoXV8z6C
         CQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FkPSQhkPmlUq1MiBIrc+wGX4ejTebMXeFCRl3j6q9c=;
        b=MkTQ0AJXsKohyO+X3HXN6O8LuWCxt39pdFVsQg6gOoBM00Nuj6HKClQAJSqkR23AJF
         D7QarsOkHrh4UsZfhaNxRNnsKIsmiN5pIgp3PUFCZs6IojUWDhpevbHl3zun993Dn9ww
         gOgia6+6IyHPAsxUIZrL01MVhivcbwB+j1dcSvwF/HIWJoYPh2o+xKHlaW+St8fZyNST
         PTaVwRGSww2NpY135wK7N2rIaW5QTBi3U8jpq7yxYdg1rK0D4Mptb3ydQTDacRlIhBiG
         zaYczSM7RAHbIkNzVi4FhSaZgJTA99WQGZZTupaBVxx1xkStKbmpboR0OgsRG8zdII2T
         c0Ig==
X-Gm-Message-State: AFqh2kpZyj0CWjPQWxxjeR3nI6O9qXLcxd3uingIZyvOok7YLPTXhUOG
        qnjZ9jYkXJHX9seDb3AERuBrvxhLmqQB/FVwDtM=
X-Google-Smtp-Source: AMrXdXsxXzBMKjRV9+sGyklb4On2B+RschSRvc0FIDFqxTnvS3Hy661youWapvEOZVvYi0dXOTYvXFbc4ih3yCwKfQY=
X-Received: by 2002:a2e:7318:0:b0:27f:1537:2ba9 with SMTP id
 o24-20020a2e7318000000b0027f15372ba9mr656957ljc.260.1671468594385; Mon, 19
 Dec 2022 08:49:54 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:44:b0:22e:c13a:89a3 with HTTP; Mon, 19 Dec 2022
 08:49:53 -0800 (PST)
Reply-To: canyeu298@gmail.com
From:   Can yeu <towen8936@gmail.com>
Date:   Mon, 19 Dec 2022 17:49:53 +0100
Message-ID: <CAEgccdtMnMzE24fAHe164jrdhtTweACY+=DJhCAqkw2b=Ag0cQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

LS0gDQrYtdiv2YrZgiDYudiy2YrYstiMDQoNCtmE2K/ZiiDYsdiz2KfZhNipINmF2YfZhdipINij
2LHZitivINmF2YbYp9mC2LTYqtmH2Kcg2YXYudmDLg0KDQrYqtmC2KjZhNmI2Kcg2K7Yp9mE2LUg
2KfZhNiq2K3ZitipDQoNCtin2YTYs9mK2K/YqSBDYW4gWWV1DQo=
