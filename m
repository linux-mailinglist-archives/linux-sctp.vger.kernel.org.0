Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F01558F86
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Jun 2022 06:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiFXEOH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 24 Jun 2022 00:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiFXEOF (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 24 Jun 2022 00:14:05 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB8D4FC5E
        for <linux-sctp@vger.kernel.org>; Thu, 23 Jun 2022 21:14:03 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id h187so314667ybg.0
        for <linux-sctp@vger.kernel.org>; Thu, 23 Jun 2022 21:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qA3djIvmCXy0qDgHJwJPAvZJI/yB7Iv/v6zV71DlqI=;
        b=dbZ9+ZC5GXZBRWNne1PZdMvrN9BTVVpQyaGafXlsAtWJeAd9l8oyXDXIqFysIl9GVm
         N4H+lFbi6/LBOckdOGoUbN7WtfvcNbNBOeOFC7rh5NtINkkrczh+6eZUtMSYo2E3AY9Q
         KYGicWB9gM91hpq5XTmgvSFGXfHwUfmiFGF4JIDqGyLQZ9Ioy2r1nLhocjJhDW2tTunF
         +GaqHi5XbJRMj4kjJ73QHO1rFkP1twxXYdL2Vjmx+CyHxUvo5vkbtNGr14PQ0ANIM6bW
         nq7VV+wsKB9fTNwybydirk3rRQxeekz89JST0ITd5vaJmhm+joNueRsC/J/thMNGvbjz
         MofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qA3djIvmCXy0qDgHJwJPAvZJI/yB7Iv/v6zV71DlqI=;
        b=garmxL9I+rYFw1kXjsqvZxD6zu7BweHv0qEdMAIvM6va7wXzzTVCv2kR6b2znohfZG
         w9pYIBZVcHRYaA6/iVSMs4rsbq8T5ggrGE18GhPINEHq3T7MHJZ2Zb0TXYi1D86yiXV6
         mULXqGGQzKvoVCLofBYDy6vYAtWS9eBkdEv0hLI7BsjeE3DW5XF0WdLKd3KPbRsyDfvi
         jNHxnq/SWL4KctqFQxhP0DF1F7LYqmqpc/5qaF8Uxo20ThCy7O7KW09j4r3Dprb4pX1n
         lVyqurtNnmBJzZW5rIGoJgT7az5dHDwgBhJ6XA9slQBfr8JiEdSlS9LaTZmKl8IlC+AO
         +ZbQ==
X-Gm-Message-State: AJIora/yZEqKUyM+ykUs3lEEEEMhoH0e0rHwx8O9pgCHMBl+VABmS2mk
        w0+3jYsjLXJJ89XX/gY7q7B0TLHs9t6XfyjzGPNBzQ==
X-Google-Smtp-Source: AGRyM1u5NmicPX8kPXvz1kiPZ+hNXNfnIUMJsLYPxSR6t62siw34qIBUx64zMORNQHZNj8XRPh/W7Dh2yu7XetMiJhw=
X-Received: by 2002:a25:6c5:0:b0:669:a17a:2289 with SMTP id
 188-20020a2506c5000000b00669a17a2289mr9871960ybg.231.1656044042254; Thu, 23
 Jun 2022 21:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220619150456.GB34471@xsang-OptiPlex-9020> <20220622172857.37db0d29@kernel.org>
 <CADvbK_csvmkKe46hT9792=+Qcjor2EvkkAnr--CJK3NGX-N9BQ@mail.gmail.com>
 <CADvbK_eQUmb942vC+bG+NRzM1ki1LiCydEDR1AezZ35Jvsdfnw@mail.gmail.com> <20220623185730.25b88096@kernel.org>
In-Reply-To: <20220623185730.25b88096@kernel.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 24 Jun 2022 06:13:51 +0200
Message-ID: <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        network dev <netdev@vger.kernel.org>,
        linux-s390@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        lkp@lists.01.org, kbuild test robot <lkp@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Ying Xu <yinxu@redhat.com>
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

On Fri, Jun 24, 2022 at 3:57 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 23 Jun 2022 18:50:07 -0400 Xin Long wrote:
> > From the perf data, we can see __sk_mem_reduce_allocated() is the one
> > using CPU the most more than before, and mem_cgroup APIs are also
> > called in this function. It means the mem cgroup must be enabled in
> > the test env, which may explain why I couldn't reproduce it.
> >
> > The Commit 4890b686f4 ("net: keep sk->sk_forward_alloc as small as
> > possible") uses sk_mem_reclaim(checking reclaimable >= PAGE_SIZE) to
> > reclaim the memory, which is *more frequent* to call
> > __sk_mem_reduce_allocated() than before (checking reclaimable >=
> > SK_RECLAIM_THRESHOLD). It might be cheap when
> > mem_cgroup_sockets_enabled is false, but I'm not sure if it's still
> > cheap when mem_cgroup_sockets_enabled is true.
> >
> > I think SCTP netperf could trigger this, as the CPU is the bottleneck
> > for SCTP netperf testing, which is more sensitive to the extra
> > function calls than TCP.
> >
> > Can we re-run this testing without mem cgroup enabled?
>
> FWIW I defer to Eric, thanks a lot for double checking the report
> and digging in!

I did tests with TCP + memcg and noticed a very small additional cost
in memcg functions,
because of suboptimal layout:

Extract of an internal Google bug, update from June 9th:

--------------------------------
I have noticed a minor false sharing to fetch (struct
mem_cgroup)->css.parent, at offset 0xc0,
because it shares the cache line containing struct mem_cgroup.memory,
at offset 0xd0

Ideally, memcg->socket_pressure and memcg->parent should sit in a read
mostly cache line.
-----------------------

But nothing that could explain a "-69.4% regression"

memcg has a very similar strategy of per-cpu reserves, with
MEMCG_CHARGE_BATCH being 32 pages per cpu.

It is not clear why SCTP with 10K writes would overflow this reserve constantly.

Presumably memcg experts will have to rework structure alignments to
make sure they can cope better
with more charge/uncharge operations, because we are not going back to
gigantic per-socket reserves,
this simply does not scale.
