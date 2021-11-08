Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D2C4476FD
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Nov 2021 01:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbhKHAop (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 7 Nov 2021 19:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235286AbhKHAoo (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Nov 2021 19:44:44 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FE2C061714
        for <linux-sctp@vger.kernel.org>; Sun,  7 Nov 2021 16:42:00 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ee33so56010008edb.8
        for <linux-sctp@vger.kernel.org>; Sun, 07 Nov 2021 16:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FQsMoxxo6vvZxdeXnaDyOfDzDVU+kfuV0D4OVx6iMsQ=;
        b=rIo9esb5Ao1lsyabSBqkTtwbp0LJsI0+vaazzmFoSkQPhhgFGiDPfUueMVN3lTEB/V
         KuoZ0O6+t1P2lEDo+7OK4ss281AG/LY2+4lUn8fzvanqiBX1mWOw3/uMi7kTtvcSwTrq
         edvJXKqd0suYru5DauPbzoiB2KlRa+eV0Kiq74nfVXG8N/BWkJQxyaFbd1Bl4ai3Vmb4
         LSavr1buIg14eDaEVFBQ1h8SI0X1BFpJb69trGfxwlNXw/cI4Js+AeJrGGc5CmQ0CY51
         4bht7RXG1N1FUvM/cKfxH14RRZ9qf4qBgmb09PlqYdHPR3thEeUkxGTc9rmwL9xMyz3d
         Ak3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQsMoxxo6vvZxdeXnaDyOfDzDVU+kfuV0D4OVx6iMsQ=;
        b=mIZr8NykDlg3sBz3I2erc+IAwLrf84OR2e+p9LbnieyGZ31zHe4nHxUS3TBVoEoiiW
         1w5MNGiszmxVy7SWNeHiHWf7K/N9/t9cwD0PYmiQrm18QDAjSAFq83dNNrX5gc6V+q4Q
         3OwP4BDu54UQgziL58fTpUEn50aCTiqM5ArVoJO9e2xXY4DEu7zebU+bTzZY6N+SmYl9
         0cVg1q8mp+1y6FMnXTOmZEfmYOtwVASoDXtq1UxqmuNUp+bilTICBIxJqzi1xXBmy9si
         2L6FZx1AsfDv+dplAk+Kfit9z1dPCnsowyHaxMWPZWWnFt02SorVomrigsLD6fvtS+Rt
         tgRg==
X-Gm-Message-State: AOAM530/7ZxFpCqdkZw1fSD2dOa8Hf4epeJslNIFsCzdU+h6AHoaNH5o
        u6C2FwW+ESKajh4yD/yY54CMfYeSfkOVaTT92O/O
X-Google-Smtp-Source: ABdhPJxGGyTDiq3kTPKzYcm9DKRZvSWoRdN9WdXhDYlEK9VUjuZ5DvKyIzNqLKlStk7UxW/w7fh7l82VSj/GVbKF8VQ=
X-Received: by 2002:a17:907:868f:: with SMTP id qa15mr66694182ejc.187.1636332118501;
 Sun, 07 Nov 2021 16:41:58 -0800 (PST)
MIME-Version: 1.0
References: <20211104195949.135374-1-omosnace@redhat.com> <CAHC9VhQwpKWBF2S=vTutBVXeY9xSfTRuhK9nM9TariLVUSweMA@mail.gmail.com>
 <20211107.190959.1432110661171124830.davem@davemloft.net>
In-Reply-To: <20211107.190959.1432110661171124830.davem@davemloft.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 7 Nov 2021 19:41:47 -0500
Message-ID: <CAHC9VhTq-6rb3VbVQs4TS5DnzsguNiLB_iyq5ZFNMqqvO8a5gQ@mail.gmail.com>
Subject: Re: [PATCH net] selinux: fix SCTP client peeloff socket labeling
To:     David Miller <davem@davemloft.net>
Cc:     omosnace@redhat.com, netdev@vger.kernel.org, kuba@kernel.org,
        lucien.xin@gmail.com, richard_c_haines@btinternet.com,
        vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sun, Nov 7, 2021 at 2:10 PM David Miller <davem@davemloft.net> wrote:
> From: Paul Moore <paul@paul-moore.com>
> Date: Sun, 7 Nov 2021 09:12:57 -0500
> > When we change things as significantly as we are doing here, i.e.
> > shifting some of the labeling away from the endpoint to the
> > association, I much rather we do it as a chunk/patchset so that we can
> > review it in a consistent manner.  Some of that has gone out the door
> > here because of what I view as recklessness on the part of the netdev
> > folks, but that doesn't mean we need to abandon all order.  Let's get
> > all the fixes and repairs queued up in a single patchset so that we
> > can fully see what the end result of these changes are going to look
> > like.  Further, I think it would be good if at least one of the
> > patches has a very clear explanation in the commit description (not
> > the cover letter, I want to see this in the git log) of what happens
>
> Cover letters show up in the merge commit log message for the patch
> series so they show up in the git commit log.

That assumes the patch(set) is merged and not applied directly from
email, patchwork, etc.  I try not to make too many assumptions about
how patches end up in various trees as everyone/every-tree is a bit
different; including the details in a commit description has been the
safest route in my experience.  Regardless, the key is that info gets
into the git log in a way that is easily discoverable, the exact
mechanism is less important as far as I'm concerned.

> Paul, please stop being so difficult and let's fix this.

David, please look at the associated threads and see that we *are*
working on fixing this; no one likes broken code, we all want this
fixed.  As far as being difficult is concerned, I can assure that from
my perspective the individual who merged a patchset in less than 24
hours (during the initial days of the merge window) without an ACK
from the affected maintainers and then refused to revert the patches
when asked is the difficult party, but I guess we all have our
different opinions.

Best wishes and warmest regards.

-- 
paul moore
www.paul-moore.com
