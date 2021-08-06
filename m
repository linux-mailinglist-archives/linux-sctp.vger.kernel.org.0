Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53A23E243B
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Aug 2021 09:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbhHFHkQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 6 Aug 2021 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbhHFHkQ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 6 Aug 2021 03:40:16 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C748C061799
        for <linux-sctp@vger.kernel.org>; Fri,  6 Aug 2021 00:40:01 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so11663612pjz.0
        for <linux-sctp@vger.kernel.org>; Fri, 06 Aug 2021 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=Aauu7gYvMaBruI9Zt1CgTlkxSZ8evQwPBhKOMH6jf8s=;
        b=kNA2VpQTTGGCUu/HPBUvQfOVLHAMiXfiOXPl6EZ5AumSRd0zGEFBtCMSNkZGkXe6DQ
         +IV+zm7ebbW/GUqhgYSJbM++KsnKHQKt8KfyF8h0PNc7wXEPCF8rSHgeM2eZR8FPADco
         UJ+w7oM9VDeOC+x47ORv3R6R/co3HPU6H1MLKBSZInuVH7wV1cRLixN1NZKnLDhgQqTx
         u7g/Q/sEIqytgUEOQfts8jQewy4adj2be16wTm6c3y3kuePHQpk0aDYRnexMlVf08jvc
         Nxl15n6/3o4KJUoVZ2EvJYf81LXZ7fnJzPFqHLHYQY2sX6u5rhm/n8F5Y5iA0Y/JtJXc
         KJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=Aauu7gYvMaBruI9Zt1CgTlkxSZ8evQwPBhKOMH6jf8s=;
        b=WHEZh35la8chqVSBd3zJU4m1nJ7kCN3kMZh1dI853C1BZ/9D6BLgTXdSyFSQ0tFrt6
         J6CKQ5H1dV+F4uNk4e2BkIlaovzHTer9kjPheoYSat66o+1edR/Ft1cR3TEs6iYiryX9
         qLiyLphLneyD1mzMMWhu/ym0oU3pRksrYFi5uP3BzOtZxkxOXFp8DoWdKoXuGiEDvJf3
         BnuWqrKeUO8t9Y5SV2TeeMLWsA42CvCCgTOskxg3bVDer7m+ICTwPAwU83/22hmG84p/
         /FpEVJ7Z4MwfXQvRDeaP14wrTX4hrH+Vw0ubQQ0RwDZSmROQIbqzpshNfWB1mdpE2ia8
         MVCA==
X-Gm-Message-State: AOAM533z1lRVZW5TY9ANemh+7BpN5M/XnpVvx4coXcB1Ef9eYJ21YkH6
        DmcOxTR8bjV4kUlHhwx4etxs0ww2r+sr3FM5Lm0=
X-Google-Smtp-Source: ABdhPJzo3Xwi1Nwlji2gW0hAAVsNlObmeCnS/qqr61gOvhTmlZsp/pLe+qUpc8/IYuIYN7xDeY7n0U2ZjacmrLYt7pw=
X-Received: by 2002:a17:90b:4ad1:: with SMTP id mh17mr8975871pjb.164.1628235600637;
 Fri, 06 Aug 2021 00:40:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: godwinppter@gmail.com
Sender: dr.nikitarehan@gmail.com
Received: by 2002:a05:6a10:fe08:0:0:0:0 with HTTP; Fri, 6 Aug 2021 00:40:00
 -0700 (PDT)
From:   Godwin Pete <godwinnpeter@gmail.com>
Date:   Fri, 6 Aug 2021 09:40:00 +0200
X-Google-Sender-Auth: qgugmeCSZRd2pjDyFiwGNadTyUM
Message-ID: <CALd83H1qWW6jYbcFrALSMbPTLdBwfGXGuU1XCp04+20hH8bi1Q@mail.gmail.com>
Subject: Reply Urgently
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

My good friend,

I just want to know if you, can help me to transfer the amount of
($6Million). After the transfer we have to share it, 50% for me, and
50% for you. Please let me know if you can help me for more
information in regards with the transfer. I hope you can work with me
honestly?


Thanks.

Godwin Peter,
