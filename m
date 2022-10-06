Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D455F622F
	for <lists+linux-sctp@lfdr.de>; Thu,  6 Oct 2022 09:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJFH61 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 6 Oct 2022 03:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiJFH61 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 6 Oct 2022 03:58:27 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99AD213E2C
        for <linux-sctp@vger.kernel.org>; Thu,  6 Oct 2022 00:58:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e20so1348799ybh.2
        for <linux-sctp@vger.kernel.org>; Thu, 06 Oct 2022 00:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=GcZaMLmrW6Bw6eGQLVZ9g1I+KUwzh2OBeMDdqnUGAOg=;
        b=B6uYvn6b9uFfLFbd9WdEFYlPPfDVpVPsE28q4KmPMpI9ML2UwR0OqbTiX6kSFM/Nn6
         Euyv+RNhHqrdT7HUmuRIzokyBjSmsK3XqWyY8MurC42jmQQxrqcgGWpGyfc4NA24CQhK
         O0PVB9zK6SFAmGyP0rgbK01OIyRJTdZXwSeZ0uWSZwQfzf6CBL2BE0TUJ7PhSF918dmH
         wvCG4iPQmnuOxGe0e6nZQahAiD31Rv0mEvoxI1/lypt2bVc9ZgI0+WE8aITxQrp2dj8Q
         9jG8hWVNuHU266cJkD3Yw4qU31Rfe+ZgSasaA0CRtaAOCDxDqqExFEyuFfLz32nDH5mU
         XaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=GcZaMLmrW6Bw6eGQLVZ9g1I+KUwzh2OBeMDdqnUGAOg=;
        b=ORsz5gErX+GYykQ6Zkz2XpIaQ6X/FE6IKrwqwx5iRN9K8P4a7KZjODdY3WGDxHslwj
         K4nBM+H4ZiYVcrj+5FUrLpJMbEOqElob9KxhApWKq9R3UcGn3cV0BSL6WUX80P7pWjLl
         vxSfJJoZg55UzugFUseMyIq1S+xddflRgoDPVoooK+yJ/Zy3x06Gthzqk/9CGZEQK/Az
         OE5tFQC3wvW+4o7HxD6u/uAGZlyGgLfmZGCmg84RMduieyL626uscf10YO1FVpYMOWna
         PZsCPAmGfhLj16zzO4QEfgo5FTYubisfjznDwadQgmSM8iOLZELtTfdB9pNQII8DLcOH
         /PtA==
X-Gm-Message-State: ACrzQf0tSjEsrbA9jT/UJ83uckw8KODPptz+QOdTYptRDbcQp2lcuccw
        4F036iYKvWqIGH3UfeqzkawcGrXnLoIOxatM4VaQqyjTwzc=
X-Google-Smtp-Source: AMsMyM5rHQIdY72Qhr47vaBwul3x6m66s6JoR+W1AkUggb5lfju8M3Iu3j0IyVEi1R4uVjeStayR+7/wM+/da6kM7xM=
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr3461012ybb.604.1665043105763; Thu, 06
 Oct 2022 00:58:25 -0700 (PDT)
MIME-Version: 1.0
From:   "Denis M." <xeronm@gmail.com>
Date:   Thu, 6 Oct 2022 10:58:14 +0300
Message-ID: <CAO4aA2BjT2hUk_U=xxidxz4=dwsd5uwuK-oTW5epFgeCrA3pog@mail.gmail.com>
Subject: Subject: SCTP: Stateless multi-homing support with adjustment of the
 Verification Tag
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

Could you consider some improvements in linux SCTP implementation.

Motivation: Implementation of the stateless balancing of the SCTP
multi-homing inbound connections through L4 LB (for instance IPVS
subsystem) based on Verification Tag.

Idea:
1. We need a deterministic algorithm to find a proper backend host. We
may encode the host index into SCTP Verification Tag. I know that RFC
recommends generating Verification Tag randomly, but this could
drastically simplify implementation of the L4 LB.
2. On the L4 LB side we restore the host index from Verification Tag
and route the packet to a certain host from the backend pool.

Implementation:

1. add new sysctl parameter <sysctl.c>:

> {
> .procname = "vtag_hindex",
> .data = &init_net.sctp_vtag_hindex,
> .maxlen = sizeof(unsigned int),
> .mode = 0644,
> .proc_handler = proc_dointvec_minmax,
> .extra1 = SYSCTL_ZERO,
> .extra2 = &vtag_hindex_max,
> },


2. use this parameter in sctp_generate_tag function <sm_make_chunk.c>

> /* Select a new verification tag.  */
> __u32 sctp_generate_tag(const struct sctp_endpoint *ep)
> {
> /* I believe that this random number generator complies with RFC1750.
> * A tag of 0 is reserved for special cases (e.g. INIT).
> */
> __u32 x;
> unsigned char* cx = (unsigned char*)&x;
> unsigned char hindex;
>
> do {
> get_random_bytes(&x, sizeof(__u32));
> } while (x == 0);
>
> hindex = ep->base.net->sctp_vtag_hindex;
> if (hindex) {
> cx[0] =  cx[1] ^ cx[2] ^ cx[3] ^ hindex;
> pr_info("sctp_generate_tag(): adjust vtag=%u:%u\n", x, hindex);
> }
>
> return x;
> }



Regards,
Denis Muratov
