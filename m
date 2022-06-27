Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CCA55C913
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Jun 2022 14:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbiF0RFc (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 27 Jun 2022 13:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbiF0RFb (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 27 Jun 2022 13:05:31 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4817E25
        for <linux-sctp@vger.kernel.org>; Mon, 27 Jun 2022 10:05:29 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g4so6273879ybg.9
        for <linux-sctp@vger.kernel.org>; Mon, 27 Jun 2022 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llT1Zq6sh+MENUn7ZyFpz597NkMTivkH2nO9uzDfXJc=;
        b=hSVoyAPeZyTQ6QXLkInesPxCelw6q0JD7Hv9wsjbBHfFEdOnkZ2yvmx7AxA0Eh7LxL
         5Br6FVTxPc7BCLirBQW+hf6peNUEzFOJvMNCPTWbaY6WN9blx5shC/VN1xq1zWQk2JZ1
         sS/2tZbkP1G2ZnHwZpk9zwBdhJ9ydoT9I0699o4AHA7THbqNqWgs5cnENYiYAtskraqf
         2kuwhXGgUbZwhBqFcRROjY03fkDh2BbMWkIszSqN8qA6NqD5lLk+ogy+J7EmL2CUFVJn
         nJe4Drn1fXkyqf+a9IdT7HZr+7cy2fG3pgzM+tc/VZUqb+6vNOgyaO4phFEdxPZxjP+9
         brQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llT1Zq6sh+MENUn7ZyFpz597NkMTivkH2nO9uzDfXJc=;
        b=HXxcVr2aLHK9H9J6zgN0d5f7Zad5j0Lk0yQBBo4FlP2w+mCuLmU9uME3FuY7/gjHFg
         F48Vm75CZV6qRG6DG60kb/E436N9eHeBME3va74ffyFE11OOiG4ZNj6Mg34Acg6ySNzG
         S9zq7KU7YSz69fh/e50jRdh64dnk6uNsJi9ZKA/K5mGSBto5e71zb6f/d+LX/2qFPn6Q
         /ELZvCqq+LT6p8obL8mN9iKDDUU8CZOOcc9esYCUSMNkJ6wHh/eMo5zGipFNc9478PqH
         NRGWE19K9ITwvcTZjWtg4duWxgmbxA7kqFkOFBFYlXkUPIa54J5uFvaf0cWW+DVzfYcF
         G2dA==
X-Gm-Message-State: AJIora/VwVEPcm1X6fs81ZPUGPYVBY50iZxJXHEG/r/R6An+olo2XSQK
        6AwBV/79vSjNmKUROrHXpoOL99grgdQUCVEGrNlqHg==
X-Google-Smtp-Source: AGRyM1v+tQ4QFlzlRJhm1Rkgi+oPwKgFtB3zGgIAUGtDZNUytR6VX29Z8irDx5YhFCtKUwVtXFd5otJlwfAxhslH2Mk=
X-Received: by 2002:a25:d957:0:b0:66c:9476:708f with SMTP id
 q84-20020a25d957000000b0066c9476708fmr11488633ybg.427.1656349528655; Mon, 27
 Jun 2022 10:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220623185730.25b88096@kernel.org> <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
 <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com>
 <20220624070656.GE79500@shbuild999.sh.intel.com> <20220624144358.lqt2ffjdry6p5u4d@google.com>
 <20220625023642.GA40868@shbuild999.sh.intel.com> <20220627023812.GA29314@shbuild999.sh.intel.com>
 <CANn89i+6NPujMyiQxriZRt6vhv6hNrAntXxi1uOhJ0SSqnJ47w@mail.gmail.com>
 <20220627123415.GA32052@shbuild999.sh.intel.com> <CANn89iJAoYCebNbXpNMXRoDUkFMhg9QagetVU9NZUq+GnLMgqQ@mail.gmail.com>
 <20220627144822.GA20878@shbuild999.sh.intel.com> <CANn89iLSWm-c4XE79rUsxzOp3VwXVDhOEPTQnWgeQ48UwM=u7Q@mail.gmail.com>
 <CALvZod60OHC4iQnyBd16evCHXa_8ucpHiRnm9iNErQeUOycGZw@mail.gmail.com>
In-Reply-To: <CALvZod60OHC4iQnyBd16evCHXa_8ucpHiRnm9iNErQeUOycGZw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 27 Jun 2022 19:05:17 +0200
Message-ID: <CANn89iLnOBGk+P33MRAkNwVLQC+s1M36m+cg1d4pJ970ecdxcg@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Feng Tang <feng.tang@intel.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>,
        linux-s390@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>, Ying Xu <yinxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jun 27, 2022 at 6:48 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Jun 27, 2022 at 9:26 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> [...]
> > >
> >
> > I simply did the following and got much better results.
> >
> > But I am not sure if updates to ->usage are really needed that often...
>
> I suspect we need to improve the per-cpu memcg stock usage here. Were
> the updates mostly from uncharge path or charge path or that's
> irrelevant?

I wonder if the cache is always used...

stock = this_cpu_ptr(&memcg_stock);
if (memcg == stock->cached && stock->nr_pages >= nr_pages) {

Apparently the per-cpu cache is only used for one memcg at a time ?

Not sure how this would scale to hosts with dozens of memcgs.

Maybe we could add some metrics to have an idea of the cache hit/miss ratio :/


>
> I think doing full drain (i.e. drain_stock()) within __refill_stock()
> when the local cache is larger than MEMCG_CHARGE_BATCH is not best.
> Rather we should always keep at least MEMCG_CHARGE_BATCH for such
> scenarios.
>
> >
> >
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
> > index 679591301994d316062f92b275efa2459a8349c9..e267be4ba849760117d9fd041e22c2a44658ab36
> > 100644
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -3,12 +3,15 @@
> >  #define _LINUX_PAGE_COUNTER_H
> >
> >  #include <linux/atomic.h>
> > +#include <linux/cache.h>
> >  #include <linux/kernel.h>
> >  #include <asm/page.h>
> >
> >  struct page_counter {
> > -       atomic_long_t usage;
> > -       unsigned long min;
> > +       /* contended cache line. */
> > +       atomic_long_t usage ____cacheline_aligned_in_smp;
> > +
> > +       unsigned long min ____cacheline_aligned_in_smp;
>
> Do we need to align 'min' too?

Probably if there is a hierarchy ...

propagate_protected_usage() seems to have potential high cost.


>
> >         unsigned long low;
> >         unsigned long high;
> >         unsigned long max;
> > @@ -27,12 +30,6 @@ struct page_counter {
> >         unsigned long watermark;
> >         unsigned long failcnt;
> >
> > -       /*
> > -        * 'parent' is placed here to be far from 'usage' to reduce
> > -        * cache false sharing, as 'usage' is written mostly while
> > -        * parent is frequently read for cgroup's hierarchical
> > -        * counting nature.
> > -        */
> >         struct page_counter *parent;
> >  };
> >
> >
> >
