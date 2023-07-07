Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E874B8B2
	for <lists+linux-sctp@lfdr.de>; Fri,  7 Jul 2023 23:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjGGVhS (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 7 Jul 2023 17:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGGVhR (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 7 Jul 2023 17:37:17 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7E81FC7
        for <linux-sctp@vger.kernel.org>; Fri,  7 Jul 2023 14:37:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b6a6f224a1so38583481fa.1
        for <linux-sctp@vger.kernel.org>; Fri, 07 Jul 2023 14:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688765835; x=1691357835;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVQi/8xXURrbilsiX3mxefWVIRl9F2NNfRgsuZtvioc=;
        b=YYvC93G3b8d4Ho1kV4Rh3T77nRwVPgKGUHUs2zqIruiv9af11a8m0PRe7mt9i7Zj7g
         h0wz4UlMS63Y6wwYkw//4x5k1I25ly2NCY4MX173zdB8/reWEXsgXL5Ip4E5RZHRIhkn
         uIMgqkW1Y4fdTlQ9rcReICTeMkq3Lrjnad6Hueudk4r1Z98mBP6l4mOvYF/stGKNonyj
         jUIBLllKJbqoa8hD8+SjpyVff+vsf4gDABUbw5q1slqzP4K6XNxr69eo68DWysV8nvjJ
         Zp+bw3NGW+jj5s8HHUlnh2JBj+mZOLbRZ4YlqcIj/dq5dfqC/eyavtrbd42kFM+P9KqJ
         IBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688765835; x=1691357835;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVQi/8xXURrbilsiX3mxefWVIRl9F2NNfRgsuZtvioc=;
        b=LReDjSaveYPZuYCzOz6wJgGUes81WPCeizrZYBQ/uP74r6x+ry6eM7mGJkM2NO3OJa
         +cEkB+7BYUy+4A5m3UewvFvvQokthQVA9CUUvfJPsaqmSQ12aRcCg142vLZUlXDT9DoT
         Q6TJFTg/3WCVk50Nj3gFErR6d/y6E7UugRGyClj1mJZCy9AsMquei7I/5mhU9mQS6YFn
         gmpePiXg+PJx10dJL/z0xApDlltBNyCzeM60H8OviV2DkFYhLB4s1CO5J6MzU4LaCXju
         tZi4v7xjqzkzBvQ69rUsbn2capFPCzkKN4lkis8zzawBf/3YuNwo+VGrhN27IuH/kRNw
         KxJg==
X-Gm-Message-State: ABy/qLatx0ChC5DgRmY0rpwFXuNF/RTZ4YlwQQo1Z0s7BOxfYtIo0Rio
        s9XySIqbe+HbEcbzcVwbxM8cFb2qLCRtjIyYoac=
X-Google-Smtp-Source: APBJJlEETEcBawQyKf5zVd6EKXL5zSu8q9Z1gOgnd4DliicOJuKBRD/uc2BByXZ12B5pd4m58eEZVRwMo5UY9RhfYpI=
X-Received: by 2002:a2e:3c0a:0:b0:2b6:d77b:92b8 with SMTP id
 j10-20020a2e3c0a000000b002b6d77b92b8mr4492769lja.16.1688765834980; Fri, 07
 Jul 2023 14:37:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:152:b0:2b6:e33a:fd4b with HTTP; Fri, 7 Jul 2023
 14:37:14 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   Sgt Kayla Manthey <ramatoutoumey1@gmail.com>
Date:   Fri, 7 Jul 2023 21:37:14 +0000
Message-ID: <CAFFFc6QjgwhmjqRjKHpjvQLArzEK+DzVkUp-b4-Ubds0N7qwGA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

-- 
Greetings,
Please did you receive my previous letter? Write me back
