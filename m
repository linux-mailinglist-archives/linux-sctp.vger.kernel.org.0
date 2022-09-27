Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F4D5ECF36
	for <lists+linux-sctp@lfdr.de>; Tue, 27 Sep 2022 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiI0VVl (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 27 Sep 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbiI0VVj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 27 Sep 2022 17:21:39 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E04E1E1CDA
        for <linux-sctp@vger.kernel.org>; Tue, 27 Sep 2022 14:21:38 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-131886d366cso3325270fac.10
        for <linux-sctp@vger.kernel.org>; Tue, 27 Sep 2022 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=xW+awmz6XO4pz52+OuSTd3ef48/L7G6DRShkfOc4ZEs=;
        b=pptRCF6IPM8nCCgKhb//QO0kO63nfIM8H4uPxgZPuuzmLbzOfehzo0MRE5TcNjVG8R
         4uRDpqjOTBD0LyQtlRbBzmMBc6WkZbhjAW4/N82ErQneuWEr1ba4hZ2hiNj/jum4QIoY
         iwgk1JzUg75306ArynupqBIwfTCCmVWIPhS56+f1xb42ujHTb9CWqdj9DZ+nDXAKliD9
         LVS1oJ/eDV+7N4HgKrkpS7y4ttVURSgNJvE18A31XXJHzebIo3ui5KulYQ0LppNpQXQZ
         Jxa5XfOcuFtPfYbr/y9kspn+uVi41HSCgz5DBD2tjnGOL21WDri7VePFT3kIervLvP3O
         T/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=xW+awmz6XO4pz52+OuSTd3ef48/L7G6DRShkfOc4ZEs=;
        b=5bLXTNJGzEpWvTNi/t7Dq2KTyqlDbKd7Hc8cb/sYpNc9E+Uilm1/kshQlAhJJubXMA
         hJm2VyaQPz6LM6XLJs6PE1PFfDBfBqc/0GxcdMh75B071RCe1sXf3E3aBWe7ns7Z6ezS
         eG6U6f+za1TWhHSPLzXbhPTqFrfJ38U2VAjRC81IjOhCwmOd6A1mKzvO1PAaXDYqfPzo
         Vat8PSBKxkijQ5PXqrQZ+xznkSaAawoYzvnrcg0WELPJu9TLs9OsjzwNVb+Uh6za016T
         yEZDIHX2rS9MRlSDE7i17ZTAOxUuiyrRFjJBK+tW+jF1LzO23W6S2sWF6qdyBZr2OLaS
         nFWg==
X-Gm-Message-State: ACrzQf13nvhptd6Tq2IkEnQ2VbK2BmSK1iJjt11bqp1jpFjiQpanDrdU
        BMtwHv1LKHXrcPmeYa1NLvW8kPjmZDUXlYbZ5Nw=
X-Google-Smtp-Source: AMsMyM5J/3bWWkvUUnHeG6da5EvO1ZoKkPO3g97mpv7Co8pcDWjjlCmO/pZoRZt3KO4FmNxZg+cqk3wOBxOHloZYrjg=
X-Received: by 2002:a05:6870:523:b0:131:2d50:e09c with SMTP id
 j35-20020a056870052300b001312d50e09cmr3520247oao.129.1664313697847; Tue, 27
 Sep 2022 14:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR08MB724105AD73E9AFB3F12A0679E7419@PH0PR08MB7241.namprd08.prod.outlook.com>
 <20220927203051.35nneqjltzpysa5m@t14s.localdomain>
In-Reply-To: <20220927203051.35nneqjltzpysa5m@t14s.localdomain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 27 Sep 2022 17:20:56 -0400
Message-ID: <CADvbK_fvVr1++gV3FAURSgTfxZH_JO2kHcm=n_zH0bxU8NG3Xg@mail.gmail.com>
Subject: Re: lksctp-tools licensing
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     Istvan Gyurjan <istvan.gyurjan@flex.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
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

On Tue, Sep 27, 2022 at 4:30 PM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> Hello Istvan,
>
> On Wed, Sep 07, 2022 at 10:32:38AM +0000, Istvan Gyurjan wrote:
> > Dear lksctp-tools Maintainer team,
> >
> > We are planning to develop an application where lksctp-tools would be used together with other OSS components that uses Apache License 2.0 and The OpenSSL License. Those are in conflict with the GPL-2.0-only
> > license of lksctp-tools.
>
> That's unfortunate.
>
> > Do you have any plan to update the license to GPL-2.0-or-later?
>
> No, but we can evaluate that. It's fine by me.
> Xin, thoughts?
I'm okay with that. But relicensing seems not an easy thing,
especially when there is code from other people, not sure if we can't
contact all the contributors.

>
>   Marcelo
>
> >
> > Best Regards, Istvan Gyurjan
> >
> > Legal Disclaimer :
> > The information contained in this message may be privileged and confidential.
> > It is intended to be read only by the individual or entity to whom it is addressed
> > or by their designee. If the reader of this message is not the intended recipient,
> > you are on notice that any distribution of this message, in any form,
> > is strictly prohibited. If you have received this message in error,
> > please immediately notify the sender and delete or destroy any copy of this message!
> >
