Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73AB36A26D
	for <lists+linux-sctp@lfdr.de>; Sat, 24 Apr 2021 19:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhDXRrh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 24 Apr 2021 13:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhDXRrg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 24 Apr 2021 13:47:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD31C061574
        for <linux-sctp@vger.kernel.org>; Sat, 24 Apr 2021 10:46:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s7so51488925wru.6
        for <linux-sctp@vger.kernel.org>; Sat, 24 Apr 2021 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3SIwL84c+aY7vkRMva+0Nw2r/K5cRkGFCKdCu9D5ac=;
        b=f44XIYuxAPFsScEFGnoWBOINFNnrVH51aQe119t3feo7MDEi/sMfco61ZhaScxAF7e
         8T8aoWLsl3OAvOMw1+EzZQQRw2Akq6rVG7ypRTAJM2FEjeGt64PM1IabJrDuCDefJ0vr
         3awrWrxujXvUskjR8PS8xSykaK1jJ1fO8tRvawEccj7pk9Xh/3dQn8NWrnBIpK4u9JXo
         V9+9pdLzSD+tH89qbJDn0Vsv19ev5usGZbyxNHiU+o/Kc6pbwGbDRnn805HtRjmnOxx/
         Djo5uOKrBUEbpbDLEWr5lUmBBTs6Pg26u30mC/xPDwCiu5paXbCDYN7PxaHg8V1rROX0
         pW0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3SIwL84c+aY7vkRMva+0Nw2r/K5cRkGFCKdCu9D5ac=;
        b=ibxDyr/NaCV2bTbkiOPkI6LTpcvaPsV7MfEGzi1XLQ//3VG2xqCF9Uq4cD8Ce8uaZC
         K3f7To+654og2UwNupYkZWyJUUXWjKYC+8+EMsfP0R9uGu0hKSsTCVz8czPhKiMlp7AJ
         F8ZVZMdpJDQBWzQSq1Vf04+WYgJQTlcSi0IEm6c10oS3rBmfERj9sCxoK+YwDibpe1y9
         yuXYrxVq37rXyZanZm0f+9N74one0/A1PkKZr6eEpuj43/OhDDdx9v4VxF9DKkjGZYiY
         li71Itp1yqgCdofgeKUNx7a/QDr3jtmLWeYKnJ/r4RXxKhNYpPyBeTaV0iTI6qxBDkhm
         g/Tw==
X-Gm-Message-State: AOAM531mKRbmtMAvslIz0ss01pMbwVO/txmiNYczum1VOANdSPDz4OF1
        nS4VxUcTKd0IhBlb/r+3wcuHrVjh1Iahis/8nmQ=
X-Google-Smtp-Source: ABdhPJyLlYpQ+gY7lCmGTouGVPDHagU2GgPlhzNv74HM2E8Xy061DG13voa8taWR53ouK4K0xlkaqHGXuzmogdsoz0E=
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr11887989wrt.120.1619286416861;
 Sat, 24 Apr 2021 10:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619119690.git.marcelo.leitner@gmail.com>
In-Reply-To: <cover.1619119690.git.marcelo.leitner@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Sat, 24 Apr 2021 13:46:45 -0400
Message-ID: <CADvbK_cBOz-wvRQweSn6oX4GZsouwPQdrbcGz_KDXWFc+dfncg@mail.gmail.com>
Subject: Re: [PATCH lksctp-tools 0/2] sctp_send/v fixes
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Apr 22, 2021 at 3:36 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> First one is more important. Identified by CovScan.
> 2nd patch is just a cosmetic change.
>
> Marcelo Ricardo Leitner (2):
>   sctp_send: fix ignored flags parameter
>   sctp_sendv: avoid explicit memset for var initialization
>
>  src/lib/sendmsg.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> --
> 2.30.2
>
Series Reviewed-by: Xin Long <lucien.xin@gmail.com>
