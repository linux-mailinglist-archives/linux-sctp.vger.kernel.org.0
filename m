Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6459053450E
	for <lists+linux-sctp@lfdr.de>; Wed, 25 May 2022 22:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235710AbiEYUhm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 25 May 2022 16:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiEYUhl (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 25 May 2022 16:37:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4577F5E743
        for <linux-sctp@vger.kernel.org>; Wed, 25 May 2022 13:37:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i40so28484292eda.7
        for <linux-sctp@vger.kernel.org>; Wed, 25 May 2022 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=hyNbqM90wkCUu7nISEHTZriYtwbp6gsYULvUSN0U6RSLTK12J/HLAN93ueROmFG+VR
         U6KkIq9o9WrN58EZfYztg+Jf0SsTiqnUNKJvXM6wx9vvDhQWN5yQ6xjJAQ+P/QuCYWiU
         nyH/B7+BKSBtUGF+++0WSN0vfAPRPBH+iKhy0euiS77pZnTXThBzCynPwzdYrR6Pc7Ul
         B0GK6KVJXLpxZw6fTwWM6yeMFqhAj3F59poyS1XHAY2+ihbXTj6Sl79TpUokhFL0JV7J
         RbRBtb0YUlBCggRPBnP0Uq5PoGMGO18aEV+QalUQ+Q84hvymcHA9J2gLvAmMBXNOJGcj
         2loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=PGnreY48ZsyhcvckqZtaGEnrqWC5OMMZcjbIWyLWZ3beIg8z9KVmnFSH0k4NHo+rha
         +lCwPzWp30CAxaSLMnyncU7g+KL0Lte/T/+ghgSNAofSi9geOAc8zgQRzoQlBTJja1yF
         RKr2pHb/esiti/yCTvRTwN8coE0FIOYxoIJ8ovBuvaYbAbkFmbl6mXd4MtU9vTfBkQBy
         aP1af5z12R7jPvOG1FeuTqzHODTJTwZuS/znqI4yENPSbfUCZx6o7+SKjZM/LL3QWFbj
         VNDIWnrZLzAhc3ISxbzinGYRTAaXy0AZA766wNRYIEFWIi3kxGUd2x6OO4GywssRqLT9
         YB/w==
X-Gm-Message-State: AOAM533oB2tOLvgSfMUCQ5ZEMIg98WVZaJP5M0JoIVlvip8nqMhy1dcx
        RDaf5URqEQMmWj8zY7xitLh/er9YZ0j7eRzyzl0=
X-Google-Smtp-Source: ABdhPJzTcDFNPwadm/IDYMF0r0xZvuUNst7xNM0UZu6R21PxX31hEfyqy7LWoz68WcyapHY5p818yj90jWZvSKXZaos=
X-Received: by 2002:aa7:c595:0:b0:42a:b571:2726 with SMTP id
 g21-20020aa7c595000000b0042ab5712726mr36983029edq.48.1653511058699; Wed, 25
 May 2022 13:37:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a26b:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:37:38
 -0700 (PDT)
From:   Luisa Donstin <luisadonstin@gmail.com>
Date:   Wed, 25 May 2022 22:37:38 +0200
Message-ID: <CA+QBM2r-tfUB_7P4VpzicsuVpz0Yta5js39M89VwqNv6fq6CPw@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Luisa Donstin

luisadonstin@gmail.com









----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Luisa Donstin

luisadonstin@gmail.com
