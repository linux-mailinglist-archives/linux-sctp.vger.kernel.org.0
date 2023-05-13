Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6187F7015BE
	for <lists+linux-sctp@lfdr.de>; Sat, 13 May 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238121AbjEMJbu (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 13 May 2023 05:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjEMJbo (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 13 May 2023 05:31:44 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D957583FA
        for <linux-sctp@vger.kernel.org>; Sat, 13 May 2023 02:31:38 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ad9f2926adso64687701fa.1
        for <linux-sctp@vger.kernel.org>; Sat, 13 May 2023 02:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683970296; x=1686562296;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=SLLhHtlhLsOwzgCf+9ODvlw4dTLaH3cZrdu7lC+dHdIV66WRVMOK4eYsd4b4Gvvs9x
         o97LCm9QF+eqaS+XN6fwaz8zRAAde8OvfdND8NnDs9P4qgm7mZABgLqFkj2GDHkB5wfK
         PMUswbxDcX+ob6U51fHySFGdUpw8J4twVi2i8Ix4WgPf4x9JIzAslaiXECgE9tC7AErD
         xbFM9S0/xyRGsvVlE4F1Mg8tQY9imoiBCZ7DFdD2ddP0JXqdk6iZ8yzVl+WiZUBFWXoC
         pk0QTRyjyuhk/EnbLUpIVb+0H/viRhRw7nnIUaffllglnPMVK7QqsQ3j9vq3fKaYrETj
         89fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683970296; x=1686562296;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oDVdWICwavrWQ8UAVYhe8ynFXsBBW1vVQ7W08zgiq24=;
        b=IvkoTMl6vgmgZSZ9al2mtCTmh99MmBuVNjhhlk4i95aB2NNUPnIz0utZdTetU2ik+b
         rRwOGYN6bPevKrE5D5xFqAXWCr8PNndeORcj64t4v+cNgnzWZvLIekW7I0u7xv5ECM3g
         0tVe3TaPYpQImh9+00KVXZtB0tCu+6SI7xpkhJZP9ftAXAN+pEBjiVGv0gjjTfDTcXj6
         dQhc9SesFL0oP5awyzGzff/k/HypJ1llf6F7QyPHocyy+hyEF1o8CcO9zPRQZktzs1qn
         9aw2/06KC3rQoOflzt8CX2HAElp8AsUT/vMPrEpmI9FDi1u1vFneISygaSOLAq753DNO
         1fLA==
X-Gm-Message-State: AC+VfDyyvSkQQbtCzQz/v/1G50bH8ttkYMd+zaX7KzNWyx14lCP2epm3
        gFswBzQJpOThcQH9lZOZBFFLyNbFM+52aEuZC2A=
X-Google-Smtp-Source: ACHHUZ69yZnOfKT7w5SfUoQY/Cu6wzxYh4muPSQB6E+OFUFLbN2XZi1yBozAa0YVISxiMDtckCQ4QvDJ0SHLEBfq0P0=
X-Received: by 2002:a2e:350d:0:b0:2a8:c858:fb9 with SMTP id
 z13-20020a2e350d000000b002a8c8580fb9mr5241206ljz.29.1683970296351; Sat, 13
 May 2023 02:31:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:98cf:0:b0:2ac:a011:b92d with HTTP; Sat, 13 May 2023
 02:31:35 -0700 (PDT)
Reply-To: ninacoulibaly03@hotmail.com
From:   nina coulibaly <info.ninacoulibaly11@gmail.com>
Date:   Sat, 13 May 2023 02:31:35 -0700
Message-ID: <CAKjR=URVXeQOJMp8Rh+g1gg9HYS5Usrx0OJzpyoQzruWKyn90w@mail.gmail.com>
Subject: from nina coulibaly
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Dear,

I am interested to invest with you in your country with total trust
and i hope you will give me total support, sincerity and commitment.
Please get back to me as soon as possible so that i can give you my
proposed details of funding and others.

Best Regards.

Mrs Nina Coulibaly
