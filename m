Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AABC7764FF
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Aug 2023 18:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjHIQ1Y (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 9 Aug 2023 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjHIQ1X (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 9 Aug 2023 12:27:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB8910F3
        for <linux-sctp@vger.kernel.org>; Wed,  9 Aug 2023 09:27:22 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-cfcebc33d04so7044873276.2
        for <linux-sctp@vger.kernel.org>; Wed, 09 Aug 2023 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691598442; x=1692203242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kTVvzoAaoN693V+JbHtjsIjjx0XhgMzWetRQHqKPGn4=;
        b=ZDgzYyK5PLSsPxZK2W/Gma/cjMwfuwCXMExbUxSf1D/uhXFLQDyjLYNqgRH54zDmYn
         4EH4Onp1YOHm7NiHuKr6N6yv3BNQXQWmr80DcoeLU4H29e/A9cvKZTfTYn9r1sChV7Zk
         eisKWJc3DWCcjNgeMhh/aLqY/Csu0wvxvTtfG/uVvEVauVYlddRSknKqu+CC3Wse2DpO
         qxTRidw6E2xRsUH6mw+jrxau8XZ91OmgV+qIHDGHrM5BIUPzXd0yuzosdeaeFaLipDCy
         nTg39CirNspH03gG6CMjQgTaE3FqC/RzlbWZX9eqhci7aQsQ6lGjMl9Xc7qMwiPZLYrJ
         XvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691598442; x=1692203242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kTVvzoAaoN693V+JbHtjsIjjx0XhgMzWetRQHqKPGn4=;
        b=Ni5+UlJYytUSjmhJ6g9pYH7ijeCHKKZJaupuAeJff3J8CuY+I3vEYuql8+BQzr4xWR
         WCZTY1dIAidvPWIGO0QOZRcQ6j5+q/Oai6Y18C8JRRf06NXPLgnFhFvQkKsnPSwPQugi
         1meFPoNZ+ivnkGNOgV2zcBZxVRfPlfh6Bx4+MN1Ctn2+r+8jdFEFFwq7QoeXxXgVgQ1U
         JlzFXvPVYkBxE7WRe/SVbtk6Q+vGiRCAU1Us7sy4yifzTcT9ylD3x/8L/1D/UpjlPYGz
         irX5LJ+GsOIxmdP+IMnyd+wWYCY2kmfunmRogF7rCODVoC+ybAALwlnV6wiKp54FilAY
         a95Q==
X-Gm-Message-State: AOJu0Yym/51Fm7XS6fjz7ZnM19x2TAmP3YDNiA4mCWsL1H54/GOpKwgt
        tQi1aqj/MMScCuhEddx3RlY4DCd4GjkVdh5fWEcVG0AKx4A=
X-Google-Smtp-Source: AGHT+IEJDuoGq6JDAAyi8JwpgHa0XHXS/RKUIdF72ecyPvyCFwVjpKNKiHxGHGMMVMyWHZxhDuUp3vfprX/YrTtvlys=
X-Received: by 2002:a25:ef51:0:b0:d48:3868:2d43 with SMTP id
 w17-20020a25ef51000000b00d4838682d43mr3025662ybm.13.1691598441892; Wed, 09
 Aug 2023 09:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <72339335-4072-429C-9494-ACCDC5572F54@gmail.com>
In-Reply-To: <72339335-4072-429C-9494-ACCDC5572F54@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 9 Aug 2023 12:26:50 -0400
Message-ID: <CADvbK_edcx5A3ij_LbehqwoyNEft-NB+4bgbYbsOh_yJ-hqgRQ@mail.gmail.com>
Subject: Re: Racy addr->valid in sctp_inet6addr_event() and sctp_copy_laddrs()
To:     Sishuai Gong <sishuai.system@gmail.com>
Cc:     marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Aug 8, 2023 at 3:07=E2=80=AFPM Sishuai Gong <sishuai.system@gmail.c=
om> wrote:
>
> Hello,
>
> We observed a data race over addr->valid between sctp_inet6addr_event() a=
nd
> sctp_copy_laddrs(). Under the following execution order, sctp_copy_laddrs=
()
> might copy the addr that is no longer valid.
>
> sctp_copy_laddrs()              sctp_inet6addr_event()
> if (!addr->valid)
>         continue;
>                                                 addr->valid =3D 0;
> memcpy(&temp, &addr->a, sizeof(temp));
>
Yes, there's no lock protecting valid's read and write. But it doesn't
seem to matter.

Even if we put a lock there, after calling sctp_copy_laddrs() or
sctp_copy_local_addr_list() this addr can still be deleted in
NETDEV_DOWN event, which could happen anytime.

Checking addr->valid can only ensure the addr is available at that moment,
which doesn't look really helpful IMHO, considering an address can be
deleted, or the same address as the one already deleted can be added
anytime.

addr->valid and addr>rcu were introduced to fix an use-after-free. But it
seems to me that addr->rcu is enough for this purpose, we can actually
deleted addr->valid.
