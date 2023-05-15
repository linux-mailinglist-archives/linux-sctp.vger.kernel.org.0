Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76ED703D22
	for <lists+linux-sctp@lfdr.de>; Mon, 15 May 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243499AbjEOTAQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 15 May 2023 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242979AbjEOTAP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 15 May 2023 15:00:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7151794B
        for <linux-sctp@vger.kernel.org>; Mon, 15 May 2023 12:00:14 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f509ec3196so42018685e9.1
        for <linux-sctp@vger.kernel.org>; Mon, 15 May 2023 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google; t=1684177212; x=1686769212;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4SdAWuFDBIP8isKGbBcjo1DKYyJN8ZY0LXZBRZMRQJ4=;
        b=dMo4dul2EfVDaQ+B4rHCHkGPo1S/mbz3Otf2jMKPd5nGaTu3bp3rwG03pebLjJ4Rna
         Omut6mVmjVEUM8b9d3+ifa6kMSTx5HJdJ3MSmtWlvbk5hjN6DlER7AsZBpVhEmskxPTa
         kPcMhmogUH/rA5+ous2Mflt5HcDfXh5B2VN3mB5HIfZN2az1HJlJuulqXmt84+q2yNQc
         neLnMRkw38IS4GMrZhYZ/IPZ+2sdj2ItMNbPTzPx3dOWwLC5eMh0N4iy7gjgWrIGuyDL
         lc+O1XSVxYvkdRj30fuAEjU76uhoyS3sM2CrgtyWbKPxL6FlFXwGVxgQb9ZNXCleHwm+
         cQHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684177212; x=1686769212;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4SdAWuFDBIP8isKGbBcjo1DKYyJN8ZY0LXZBRZMRQJ4=;
        b=TmejEV2jsCeDvWkAE1tAORHG1xMcuexot6sbQk9nBIDkOH02cdhHlpqXsBkz+Zu3Dh
         tDtRuuPGpZI4PiuhR2vdekH4HuU1jKO3koif33i7G67vxREPs0DtbHwz7UCq7boJJySr
         +kgyKQxDuEQumvYl3CkdIETQJiTm0sa6Crwp7YHcFXZ8UMEGh9HYBJTNV+8tK6YU9sc7
         yIEcfjYM5G7gLJmAX5TWnBEQFwX5uFguc4l4ChCcfGDYS+unK2ywZ9Zv5SlYf50Th8UZ
         HwNtkr07G9eaiHKtKPcNZx9580ZFUZulKU4LU3U8BxJyJOEeEu5C20vY2YplXVVVTRrA
         AQNw==
X-Gm-Message-State: AC+VfDx1zSfgxunquS5oxdMy0aJvJfzNhLWcE3oYOig6+AVGTKIFAc5/
        qkqUINsUJAnhDFpiOPUljS4hygyMB38bN9GIopwyryh/WadR0PNHJJQ=
X-Google-Smtp-Source: ACHHUZ6wjLG8LPYLArDZwDyo+zf5ehz3/rgtIg2CWZrpXoNL2KXCtJ5UQ8/HefDxAiIGo/BGtushM97IhyUx8ot/Pgk=
X-Received: by 2002:a05:600c:8507:b0:3f4:e432:7589 with SMTP id
 gw7-20020a05600c850700b003f4e4327589mr13838609wmb.10.1684177212271; Mon, 15
 May 2023 12:00:12 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Snaider <adam.snaider@bluerivertech.com>
Date:   Mon, 15 May 2023 12:00:00 -0700
Message-ID: <CALP-OgmKKFb4gMH0L6WYsxonBLDHbFHgpbc1=QY1N9HnFctWxQ@mail.gmail.com>
Subject: SCTP Authentication Current State and Examples
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi folks,

I would like to ask what the current state is for SCTP Authentication
in the Linux kernel (as described by rfc4895). I've been attempting to
use an SCTP authenticated socket in the 5.10 kernel but all my efforts
are fruitless so far. Given the lack of examples around, I'm not sure
if my setup is incorrect or if the linux implementation is incomplete.
If there are any references or examples I can look at I would really
appreciate it.

Thank you,
Adam
