Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E41477A27
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Dec 2021 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbhLPRNh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 16 Dec 2021 12:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbhLPRNd (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Dec 2021 12:13:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F32EC061401
        for <linux-sctp@vger.kernel.org>; Thu, 16 Dec 2021 09:13:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso5657399wme.1
        for <linux-sctp@vger.kernel.org>; Thu, 16 Dec 2021 09:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OMjRsNGHZ2I2ihwsYkZ5ZKcHaWtZzDIKJ4TLgD8hE9U=;
        b=Dfm60GMi3mu5YKNhQckxceX+apMWSCbYXmdws8hjmeJ8qUUws5F1vYtuAGTNbX1m9E
         eHHp4I/6dHxFYsJKi+Sou/aAxTCMkqnAJcny+VLO9OMQSSlSqnn/kKX3ND9gBYIsCmFB
         gWxskOoSgY++PUDvKkaPrI9Uy8MPfNPFuhr8ikuIR8Um+NezmvQtvPGfOD+7Jji+2XO6
         Ed+fWbkm7a9D8rc3TE5OiD1h8o9pki3kIWmRIWj5Wn1qmQ59uTAG3ycCLZsp2WmEHJCq
         AnRsXIpwC0HrQL/GPNmyZQb3ws/nuhEG5TLPxgEXEoYypOOUoha5miRlkRPYjhRrr668
         gDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OMjRsNGHZ2I2ihwsYkZ5ZKcHaWtZzDIKJ4TLgD8hE9U=;
        b=AlV0LRD48K4QXD2H4XLV6BXJ+Mlz2EsFLc/06UQkGOInXN+2C2aeNUmCkT2vdj6X6v
         g9cs7nSaHcN57FD27JI8EvEq+euTQk6WF7kYyi5QWQJT1vwy/ttWykl/U9KizM02oHQs
         TK5GzhMWzx61I++Z2kCviDG5mwAVie/QMHbEUfdHLJiSNgnNppfWckdnU9niXDMVsrry
         FU08z2hzh7mkoRe36zV61kfCM+CLI6XjW568twUqabdPy2MDDEQrWl0HBCbBZQei0RLr
         Rr2WGtMSUbiMNxNS+D88nfes0l7xzW9Lvo/ac4/F2zVs4kxLXSWZ3rSTZLZV0807Gy3h
         zWTg==
X-Gm-Message-State: AOAM53389DMLYh2yeSS4lNaA/CwknaHIxm170i9v55XssGc8T8TLo/Rn
        mMaStUpGTK4Pm4E6FpPz9c9KDw==
X-Google-Smtp-Source: ABdhPJyxcRuoYfy781SO2sacN5s1W1mYRSYnrQQkbdwrTCVCNwzb/LHSqskPVNDiQprPQeewyhF57g==
X-Received: by 2002:a1c:35c2:: with SMTP id c185mr6013201wma.29.1639674811864;
        Thu, 16 Dec 2021 09:13:31 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id z15sm5058513wrr.65.2021.12.16.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:13:31 -0800 (PST)
Date:   Thu, 16 Dec 2021 17:13:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        lksctp developers <linux-sctp@vger.kernel.org>,
        "H.P. Yarroll" <piggy@acm.org>,
        Karl Knutson <karl@athena.chicago.il.us>,
        Jon Grimm <jgrimm@us.ibm.com>,
        Xingang Guo <xingang.guo@intel.com>,
        Hui Huang <hui.huang@nokia.com>,
        Sridhar Samudrala <sri@us.ibm.com>,
        Daisy Chang <daisyc@us.ibm.com>,
        Ryan Layer <rmlayer@us.ibm.com>,
        Kevin Gao <kevin.gao@intel.com>,
        network dev <netdev@vger.kernel.org>
Subject: Re: [RESEND 2/2] sctp: hold cached endpoints to prevent possible UAF
Message-ID: <Ybtzr5ZmD/IKjycz@google.com>
References: <20211214215732.1507504-1-lee.jones@linaro.org>
 <20211214215732.1507504-2-lee.jones@linaro.org>
 <20211215174818.65f3af5e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CADvbK_emZsHVsBvNFk9B5kCZjmAQkMBAx1MtwusDJ-+vt0ukPA@mail.gmail.com>
 <Ybtrs56tSBbmyt5c@google.com>
 <CADvbK_cBBDkGt8XLJo6N5TX2YQATS+udVWm8_=8f96=0B9tnTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_cBBDkGt8XLJo6N5TX2YQATS+udVWm8_=8f96=0B9tnTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, 16 Dec 2021, Xin Long wrote:

> On Thu, Dec 16, 2021 at 11:39 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 16 Dec 2021, Xin Long wrote:
> >
> > > On Wed, Dec 15, 2021 at 8:48 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Tue, 14 Dec 2021 21:57:32 +0000 Lee Jones wrote:
> > > > > The cause of the resultant dump_stack() reported below is a
> > > > > dereference of a freed pointer to 'struct sctp_endpoint' in
> > > > > sctp_sock_dump().
> > > > >
> > > > > This race condition occurs when a transport is cached into its
> > > > > associated hash table followed by an endpoint/sock migration to a new
> > > > > association in sctp_assoc_migrate() prior to their subsequent use in
> > > > > sctp_diag_dump() which uses sctp_for_each_transport() to walk the hash
> > > > > table calling into sctp_sock_dump() where the dereference occurs.
> >
> > > in sctp_sock_dump():
> > >         struct sock *sk = ep->base.sk;
> > >         ... <--[1]
> > >         lock_sock(sk);
> > >
> > > Do you mean in [1], the sk is peeled off and gets freed elsewhere?
> >
> > 'ep' and 'sk' are both switched out for new ones in sctp_sock_migrate().
> >
> > > if that's true, it's still late to do sock_hold(sk) in your this patch.
> >
> > No, that's not right.
> >
> > The schedule happens *inside* the lock_sock() call.
> Sorry, I don't follow this.
> We can't expect when the schedule happens, why do you think this
> can never be scheduled before the lock_sock() call?

True, but I've had this running for hours and it hasn't reproduced.

Without this patch, I can reproduce this in around 2 seconds.

The C-repro for this is pretty intense!

If you want to be *sure* that a schedule will never happen, we can
take a reference directly with:

     ep = sctp_endpoint_hold(tsp->asoc->ep);
     sk = sock_hold(ep->base.sk);

Which was my original plan before I soak tested this submitted patch
for hours without any sign of reproducing the issue.

> If the sock is peeled off or is being freed, we shouldn't dump this sock,
> and it's better to skip it.

I guess we can do that too.

Are you suggesting sctp_sock_migrate() as the call site?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
