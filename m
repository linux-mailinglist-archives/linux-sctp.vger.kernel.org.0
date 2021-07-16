Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09393CBAF7
	for <lists+linux-sctp@lfdr.de>; Fri, 16 Jul 2021 19:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhGPRQU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 16 Jul 2021 13:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPRQT (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 16 Jul 2021 13:16:19 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571CBC06175F
        for <linux-sctp@vger.kernel.org>; Fri, 16 Jul 2021 10:13:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g8-20020a1c9d080000b02901f13dd1672aso7438938wme.0
        for <linux-sctp@vger.kernel.org>; Fri, 16 Jul 2021 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kStPotY1Amof+XwsAMZ7KL4ii1Mao7SexnFHRx8W5Ps=;
        b=T4FSJgjcpZgAxvDlvCMbhpO2o9p6u6CGY6kOP5ClZCwBXwIYSf/LSFIzeO0wCiG6o2
         Mw6k3Ruft73um2CkFDsqKCYl2f5AaheG++Y7SQWDPOgfK7JXFBuQwDQlXky2XBvav3Uo
         KK/NOfsAKoicnw3FPvXcm3qSH9pxZsukaC7BShtZA28niQlMTumTmAXIHv7DIUSBS/8V
         a6ZlqVlK0hebBufwASkDVGZqAy/ypqNVANixPwFHgC5OnqDRa/3/SaxHy+QKdid0fCkE
         yLJckWySBPB6opOKmznYg94hxwQrOdeMvDViSX8ldfhu1hoZMk89jP6tnJWrHTftym0i
         AupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kStPotY1Amof+XwsAMZ7KL4ii1Mao7SexnFHRx8W5Ps=;
        b=D9NHdkPHsQg4eCxuRBTNQqj3wqO+p4NiZItfqQsdSqxIQ6TwhyAokGaxYJet8aedCt
         I7CnNH/dZzaHWT6E23P7rJffOPp4btmr5OZDF6oLGNEUAN+kcRXGFDQAWwS1yMM8Sjnu
         DnEcyoKxVXOEiVFVbpzdmKcjLnjy7oqyhPfU59YScKg8U/AhpuI/zN4nRymqHFjxNThM
         yyo+Dq2hLRUCNw5rcsNQ7dyx8hEykBdP+X3WoOO7cuRbr47zqglm+4Ddt66ff/0Gfdj9
         UZbVeKpuJohytgR+XHKl4RSgsdGUnkfjDDW79NKl33Kw1SrH7/JPscqQ/gEP+oZd3P4D
         Y92w==
X-Gm-Message-State: AOAM5335xIvnTy6hxOH68Q+FDrFOqLNzAND17B2vX9rwUDwuNjLiXeoi
        7Np5wogsV3B8CYVZUSOWPZo1pHRnBAHSF7f+Tc4=
X-Google-Smtp-Source: ABdhPJxK8s3O8wxazLtAHz0bC1KFDCVJANUxpZdG4O4dTSEuNjoMrH46dNi+rY1H+1ZBMBQyYGuQ5YEzhC/H59OD0xc=
X-Received: by 2002:a1c:988a:: with SMTP id a132mr17629602wme.175.1626455601866;
 Fri, 16 Jul 2021 10:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210716071600.53150-1-jacek.szafraniec@nokia.com> <20210716071600.53150-2-jacek.szafraniec@nokia.com>
In-Reply-To: <20210716071600.53150-2-jacek.szafraniec@nokia.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 16 Jul 2021 13:13:11 -0400
Message-ID: <CADvbK_erBY5MmDVJwBi6RSHV4g_ZtirKpN12QJrN1eNvntRuCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] sctp: do not update t->pathmtu when PMTUD is disabled
To:     Jacek Szafraniec <jacek.szafraniec@nokia.com>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Maciej Kwiecien <maciej.kwiecien@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jul 16, 2021 at 3:16 AM Jacek Szafraniec
<jacek.szafraniec@nokia.com> wrote:
>
> Transport pathmtu can not be updated, when PMTUD is disabled
> and pathmtu is condigured as fixed. Unconditional update t->pathmtu
> will result in overwriting parameter configured by user
> and lack of GSO usage.
Seems right, the update of dst's mtu from elsewhere shouldn't
affect SCTP either if SPP_PMTUD_DISABLE flag is set.

>
> Signed-off-by: Jacek Szafraniec <jacek.szafraniec@nokia.com>
> ---
>  include/net/sctp/sctp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index 2c6570e..0569956 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -612,7 +612,7 @@ static inline bool sctp_transport_pmtu_check(struct sctp_transport *t)
>  {
>         __u32 pmtu = sctp_dst_mtu(t->dst);
>
> -       if (t->pathmtu == pmtu)
> +       if (t->pathmtu == pmtu || t->param_flags & SPP_PMTUD_DISABLE)
>                 return true;
>
>         t->pathmtu = pmtu;
> --
> 2.10.2
>
Can you please try to fix it with this?

diff --git a/net/sctp/output.c b/net/sctp/output.c
index a6aa17d..9f53323 100644
--- a/net/sctp/output.c
+++ b/net/sctp/output.c
@@ -103,8 +103,8 @@ void sctp_packet_config(struct sctp_packet
*packet, __u32 vtag,
                sctp_transport_route(tp, NULL, sp);
                if (asoc->param_flags & SPP_PMTUD_ENABLE)
                        sctp_assoc_sync_pmtu(asoc);
-       } else if (!sctp_transport_pmtu_check(tp)) {
-               if (asoc->param_flags & SPP_PMTUD_ENABLE)
+       } else if (asoc->param_flags & SPP_PMTUD_ENABLE) {
+               if (!sctp_transport_pmtu_check(tp))
                        sctp_assoc_sync_pmtu(asoc);
        }

Thanks.
