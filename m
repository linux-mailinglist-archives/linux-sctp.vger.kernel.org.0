Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B6323B2BF
	for <lists+linux-sctp@lfdr.de>; Tue,  4 Aug 2020 04:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgHDC3E (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 3 Aug 2020 22:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHDC3E (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 3 Aug 2020 22:29:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36685C06174A
        for <linux-sctp@vger.kernel.org>; Mon,  3 Aug 2020 19:29:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id q16so18957669ybk.6
        for <linux-sctp@vger.kernel.org>; Mon, 03 Aug 2020 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iwt/1nxcUwFhi57dQLj6DSL9I/pGIvL5ed/nmcTtpZk=;
        b=rWKTAPISxuGxDow7CmIiuWIEtSuyyWLWmo23vQMPsHA+5Yd8WWEKSUZtxhW1u3RDY3
         TAiJu23CS7Y69+XVLkQftq3N2u1V9ZdwaQulmzIRdAp7PDpV2+YYBDy2KK9CHpOpzxh2
         PZwi9nbV/R2VlKt658JDBtpPA05f5QMz9/ZRGJjMRAfcvJnYWQp1Bc7kmhoniKx2c5CG
         LNpQFIZnfdtboIVVLFSKMa20gqW7wuHbS9YXiDZqivFr4JmRiWY79aNqgH3N10JMJ3sg
         YK+aADEBpPrgxakrZrSf83fG+0JlCvZd1zqTKF4UI96wApBIQv5e2yFyH7G5pXr85njh
         agMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iwt/1nxcUwFhi57dQLj6DSL9I/pGIvL5ed/nmcTtpZk=;
        b=DyNXl004nOjhHtggou5owkjyOenkNwHuFUGHbh0dxl/x6DOxPaCA1idawbSv8xXzJe
         EFMW0FyEOrNJR+ID5ECh2XHK6rt9fFHUaHymwbfnuI05yumB1SyRXvVKLCQlm5ta6/7I
         vfYR/J+UsnxooAkGKhv2uEspIgxdC6JlbiTFcwT7tiozBxwyuf1BYHAsbyITMKGv18Ak
         RhDUqjULyGa8541yT/eKDrrnq+a+c/FuMZqVGfOFUoe4zbH8MhKBJI+ziILLEIxmDCII
         i75SApUeMFuQTV5uxvJ3TAIEoV2G6HWsySuzZXLgJtubQmEhqSVAFEJzu3QbtEtHTwLl
         0KiQ==
X-Gm-Message-State: AOAM531CVr5A2WdbOy0YmzjdoTl3jsEQrKWXO5EpPLZUzVmRxwy/622d
        dxeKvIS0pb6yHhWD9fPmyGIJRHSKz272yfmJvZ69djos
X-Google-Smtp-Source: ABdhPJx6WYj4yBxEyGxe5UadRAVhql0+TTdlaRuvdFb7Rb8OFK8qIgOhSfdyXk8yBtBq86lhBaoEOUZ7vmKjk+VuLJA=
X-Received: by 2002:a25:6b04:: with SMTP id g4mr12899485ybc.387.1596508143469;
 Mon, 03 Aug 2020 19:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAMyZL9pE+343HvMHuci=+2aKS4HrtuL2GJ2oVwxw7PfL7=doKQ@mail.gmail.com>
 <20200803174232.GE3399@localhost.localdomain>
In-Reply-To: <20200803174232.GE3399@localhost.localdomain>
From:   sonia bhattacharya <soniaruby1@gmail.com>
Date:   Tue, 4 Aug 2020 07:58:51 +0530
Message-ID: <CAMyZL9o14WtFT5+MfS4qWOpzSHLiX21vSLn0795Z-_mi4hGLyQ@mail.gmail.com>
Subject: Re: Regarding kernel SCTP module compliance to 4960
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Marcelo,

We are using Ubuntu 18.04 with the following kernel version.
esi14-vm-23u:~$ uname -r
5.0.0-23-generic

Just to confirm, the modinfo sctp shows the following:
esi14-vm-23u:~$ modinfo sctp
filename:       /lib/modules/5.0.0-23-generic/kernel/net/sctp/sctp.ko
license:        GPL
description:    Support for the SCTP protocol (RFC2960)
author:         Linux Kernel SCTP developers <linux-sctp@vger.kernel.org>
alias:          net-pf-10-proto-132
alias:          net-pf-2-proto-132
srcversion:     5CD1A15EE663D4E98EAC641
depends:        libcrc32c
retpoline:      Y
intree:         Y
name:           sctp
vermagic:       5.0.0-23-generic SMP mod_unload
signat:         PKCS#7
signer:
sig_key:
sig_hashalgo:   md4
parm:           no_checksums:Disable checksums computing and verification (bool)

Kindly confirm that this is compliant to 4960 already. If that is the
case, then it would be great if atleast the description in modinfo
shows 4960.


Regards,
Sonia


On Mon, Aug 3, 2020 at 11:12 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Mon, Aug 03, 2020 at 03:53:35PM +0530, sonia bhattacharya wrote:
> > Hi Team,
> >
> >
> >
> > Is there a plan to upgrade the linux SCTP kernel module to be
> > compliant to RFC 4960?
> >
> > Right now, it is compliant to RFC 2960.
> >
> >
> > description:    Support for the SCTP protocol (RFC2960)
>
> Hi Sonia,
>
> There are several references to old RFCs throughout the code, just
> because they weren't updated to the newer versions. But in regards to
> your question, Linux SCTP kernel code is compliant to RFC4960 already.
> If you notice anything particular missing, it's a bug. :-)
>
> Thanks,
> Marcelo
