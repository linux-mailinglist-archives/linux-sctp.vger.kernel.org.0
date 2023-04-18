Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EBD6E58F0
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Apr 2023 07:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDRF7l (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 18 Apr 2023 01:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjDRF7g (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 18 Apr 2023 01:59:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BFA5B97
        for <linux-sctp@vger.kernel.org>; Mon, 17 Apr 2023 22:59:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q23so60759143ejz.3
        for <linux-sctp@vger.kernel.org>; Mon, 17 Apr 2023 22:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681797571; x=1684389571;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=h2u+IvYIbnFxxtQG/ZtOJXOGODtmHZE6DE2kphmV5deUhBtI5SSl5ZpPS81I4DoyvM
         cL/QsMoq/nZ79QoTUVBpjigDCpbkhNV4ihdOYSWAZCOke9dA/QR1VB/koOlQ9LVEDYMX
         XtbtlwSc8k7WA+c3R6xpugIUkMv4IcvxiBX5jugHOkE6bIQRd6XIP4bPoYTYUOtLJ8cY
         jqOSy7VahCSY+50nHqKMLAvtMY0jgSKZG9RLZ0VM4rlX3dlYAIwPmpAZEs5sdE1jKPzt
         sUSa+Yt3rvdogEL685HX9OzzgKvbxUuLxSFiR0ubii95w3DTWRmDDneYGKBqJn2l6obd
         7Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681797571; x=1684389571;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=DJMGpsyzjAAOttQUmuUI70AvmA1Yb2G327ZQl6Ys5phqFEou79pWraI8SMEqM2DNlM
         mKJkpM6onugquT29iWVnzox7Vyh8CYD6BKRRkc0WuyTM3gQNE7CkUEygp1llPP6Pnfhe
         Rm9CLQ15Xr9lCr9+mLDULFwNV2XenrerbNIMzmtMLKOPTskK2+M91V2cU++xV14oaL3d
         O7j/JvM9n7XcVYnXuvrNkyg1GirYH5c/p7wqx8NpuSRhFjJdWXzkMI02CjRBW6Xj9TGE
         jCCRVs5BZ/4exIhpvybU6oVU+RP3DCf/5YxnoZsogMq5XUv4fL/5Mh1bLHPlZLUiqcQJ
         3kWg==
X-Gm-Message-State: AAQBX9emn888C02okW47hLRnBC8V0rF/sV220W5AM/bLVoWP4dEwNqny
        FqRVya5GBukwvMVZEmXCoXLNFjtgsLBNtsctzhMxHkkvTo3LHjke
X-Google-Smtp-Source: AKy350YRsUSKQ0+i58Lzun7WtY7IrRwSkm+DWIi2JdfS71rVYYWUT2OQ/a/Q5PRWIBazn3AQLm2dWBYGVxBajLvvRoE=
X-Received: by 2002:a05:6512:96b:b0:4e8:4b7a:6b73 with SMTP id
 v11-20020a056512096b00b004e84b7a6b73mr2935594lft.4.1681797550844; Mon, 17 Apr
 2023 22:59:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:2681:0:b0:1b6:840f:9075 with HTTP; Mon, 17 Apr 2023
 22:59:10 -0700 (PDT)
Reply-To: mariamkouame.info@myself.com
From:   Mariam Kouame <mariamkouame1992@gmail.com>
Date:   Mon, 17 Apr 2023 22:59:10 -0700
Message-ID: <CADUz=agNY633M0qMXMnAP3Ms7-3rKuWtAZGCOQZKeYpCdBxT_w@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
