Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDF64F42CD
	for <lists+linux-sctp@lfdr.de>; Tue,  5 Apr 2022 23:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345141AbiDENeh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 5 Apr 2022 09:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380518AbiDELmj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 5 Apr 2022 07:42:39 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1310CF2B
        for <linux-sctp@vger.kernel.org>; Tue,  5 Apr 2022 04:07:07 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id p143so6271023vkf.5
        for <linux-sctp@vger.kernel.org>; Tue, 05 Apr 2022 04:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Aq+6tU4I5tgzLqq7I6vrOIzeCDZgGUhZ499qJxkroak=;
        b=LUKYp0mlh7reLBl7oR8L/G51Vvo43lBB2oHP0aKtp9U7SsTabNMnptHDnweM+uQp1x
         Cn7UpK08m1LggGKcKTV69WiW5tiePT07Z9149egOkAtOlDZ1Vk1M/jxu+ozY9AzNMcjN
         nbIEj8M47p9fYTwEiXP5DiXnQhUA0gQhaf4vdGcLaEQZ77ioWEq+j6rf/HAOwkX6fjDW
         3NEN6F3zGYvKlkMt8qijefbvWwlsY5qfaJOnUff3Dm4N3WoOI8Zb1fgOurHMUKeK4rlO
         dK1pHyCvhvZ211Hp3lUYpUocwu4+hMODQMglvj39lp4I3t0ZCyzdHZO2EsCcy4wRpE29
         uhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Aq+6tU4I5tgzLqq7I6vrOIzeCDZgGUhZ499qJxkroak=;
        b=WUFKVaP81aIqYZWDsqoddrdkijMMNRdQL9KmWvD8FpMkuZVZnI0VnXhdcdR9f7Ojlk
         n1k4HOIhT6LiXt+GJHHsvzMQuG8PxbbjCBOwHB8c7+k4cmsar4UO+qnM3hbw35ZQC4iP
         DsZRzQxVvHJ5RB46Z/z/j3OVuxzXgQ5/4ChWrTWH1Tqucg7eYhFVPr2EnUcOqjts3adD
         qWGKLrogIyrWEkklqkQ+t5GefY2pavIOqcRbXznubj8WlY6+KMGqZGDBSNoejwddto/Z
         1/eGW4YjHmlAcN8ewfaeDqvMLdoMOyAu04GyoqZKdeQbWLqSRYMyBiZi+uchSOQ1YqfB
         pTLQ==
X-Gm-Message-State: AOAM530/M97bxe7EtOQZHq4sK8C6YMn17b+pSAa1NHx2ta4jDG9EMVQQ
        AqdDuanGEhI7gD7xF9gIc8KVe+XTltH1mp6kMew=
X-Google-Smtp-Source: ABdhPJyBwQS36on9bPUQM+/40RYo/nHGzeuGTlBZrRITFXguQsukspNlRu476f43wJOaghNXi/bYjCeBGdPSBaWAhCQ=
X-Received: by 2002:a05:6122:793:b0:343:8c9a:37ea with SMTP id
 k19-20020a056122079300b003438c9a37eamr1088721vkr.4.1649156826035; Tue, 05 Apr
 2022 04:07:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:64a:0:b0:2a6:8fd2:f80b with HTTP; Tue, 5 Apr 2022
 04:07:05 -0700 (PDT)
Reply-To: mrs.acostafahad@gmail.com
From:   "MRS.ACOSTAFAHAD" <bmamadoualioucafe78@gmail.com>
Date:   Tue, 5 Apr 2022 04:07:05 -0700
Message-ID: <CAJSRbJre4yN=8yw4oCDUwbZhTvBq7qnByfFJiWd7rHihKZdnkg@mail.gmail.com>
Subject: Hello my friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello Dear!!

Please get back to me soon, i have some information for you.

best regard,

Miss Acosta Fahad.
