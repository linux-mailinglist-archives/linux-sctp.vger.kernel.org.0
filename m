Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4A3B346B
	for <lists+linux-sctp@lfdr.de>; Thu, 24 Jun 2021 19:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbhFXRL5 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 24 Jun 2021 13:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbhFXRLy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 24 Jun 2021 13:11:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04E7C0617A8
        for <linux-sctp@vger.kernel.org>; Thu, 24 Jun 2021 10:09:31 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id i189so9173531ioa.8
        for <linux-sctp@vger.kernel.org>; Thu, 24 Jun 2021 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=qmK03PZYFoObdU6aFzFVrYvNat/PzNjdD0bxSLnOuRmtFtVb7YhYj6XFhW78d6NMyy
         53AIfaHozUMK00x3wPD/FeYFNyI7+1tCEP1u8HLX+Y0sqIbAhRHjE+wZWo47GufjMbRV
         EWppFx88GQjjA8bXZZGKLhdziW4UJTghE8nyCAmWnx/A24Y7TCHVBRqlWhD0A+mwOVd7
         QfRPdXOtLZhAFScrsO1FNKP9zj39AxZmxK6PbUBon4CB7WXNJJOh4AO118fjqPKlJo8y
         NvvEco2qFFNC50CLbcrZIXDS9UQLHI0meQoZW6pwuJB9rt+5/dbcZaJeUzhq2ybcD+R8
         NWyA==
X-Gm-Message-State: AOAM5324IZ3vGPjVpKMInbb5IFuCplK3eltbtQ1E80fYeM6Sdp2g6ArT
        LGWLKuSr3oB3v3sN6zIITcsbtsNb396DHCwZSrddp7lGcAF40A==
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
