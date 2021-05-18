Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B2F387DDC
	for <lists+linux-sctp@lfdr.de>; Tue, 18 May 2021 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350903AbhERQpS (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 18 May 2021 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350897AbhERQpR (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 18 May 2021 12:45:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE288C06175F
        for <linux-sctp@vger.kernel.org>; Tue, 18 May 2021 09:43:57 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so1845835wmq.0
        for <linux-sctp@vger.kernel.org>; Tue, 18 May 2021 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dIaiC40+daKRdCy2ptJvgkC1A5nug9Ngz8WU/6RpNW4=;
        b=b0yP+nWYOqqWsmVOV0rwxsnIOjHjjOjxWBVb6ydoQ7V7fU8zJ+HG2Luwq2JxLWPuGu
         kLymrrmYAl30akHQQrnY79FvsqfqsMUka4DK4nrm3lndBTBXHv9YdWVsXjQ0PGFsIfSv
         SsAC2oYXbNH5N4I782n/ym/ZVmhxAFzNVc76XX52n1Jl9x8RmXjyYK8MVkY63TXwsdl9
         uEHImqtkE5Cazjf5V0o1n9ZJ/VqbZT/atYUGHTlBOKJpTKY4ZdBlgYYdrJKSuc6t7p/7
         INYEcfRV1qLKDkKklBY/hCZO8NP9FC8qqqsbp4PurS3rrr4vC9yUedF4iNI3cNl6mqNG
         1/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dIaiC40+daKRdCy2ptJvgkC1A5nug9Ngz8WU/6RpNW4=;
        b=nfI8FgWRtb/AVbjgdKCKcywwheW0eWpNuUimHxb46yXl/IsgM32w7E1HMScxjQrvoy
         22QUnzSmMkrwzBJ8y8PhoVvVmpXRFQn1MOdSFeuk0FfgSSAEfj5Niab+dHVyVccyh7fi
         Hc+esB7hQxq7rax9ah+/RF1QEA8ANx2ZNmueutnsGyBeW7wFK7rDRdaWdj/RCpgjrtj9
         AA9WX8vT05bx623idcScXNJcN+N4c4O0+2+VESozClPY3IjKfkFfkuTGghgYwwkDpuxg
         Sz2s8URmx99Jp0S6SR7MlbGyx1E1jJr01G/FYCMZAITCkXttrVMCHzADWvJ0iQ7kMfNy
         wg4w==
X-Gm-Message-State: AOAM532LUAl5ForPk/cg6J3khuVRQT+EDVbZWGLMfInMnBwBXOJCXUZe
        UJKfcJSsQYLdcs4Y3NVETLvOXg7hPStulIBTif3klSVH4ONVlC5H
X-Google-Smtp-Source: ABdhPJxP65HyyNkVMhbJH/sTKfV1J9s7/S0mCcA7XyPBJCWinqokKrK8WhlfKKRbCQXSCVLzWQq89ULSWcY06l1KoO0=
X-Received: by 2002:a1c:7402:: with SMTP id p2mr5842476wmc.88.1621356236684;
 Tue, 18 May 2021 09:43:56 -0700 (PDT)
MIME-Version: 1.0
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 18 May 2021 12:43:45 -0400
Message-ID: <CADvbK_dqs84c7Yr_eUuENe9Y9HQXwG3AXh-0EcKFD3mjPwfpQQ@mail.gmail.com>
Subject: add SPP_PLPMTUD_ENABLE/DISABLE flag for spp_flags
To:     Michael Tuexen <tuexen@freebsd.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi, Michael,

We're implementing RFC8899 (PLPMTUD) on Linux SCTP recently,
and to make this be controlled by setsockopt with
SCTP_PEER_ADDR_PARAMS, as in

  https://datatracker.ietf.org/doc/html/rfc6458#section-8.1.12:

we need another two flags to add for spp_flags:

  SPP_PLPMTUD_ENABLE
  SPP_PLPMTUD_DISABLE

Do you think it makes sense? if yes, does the RFC6458 need to update?
if not, do you have a better suggestion for it?

Thanks.
