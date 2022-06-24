Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064EE559CBA
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Jun 2022 17:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbiFXOtZ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 24 Jun 2022 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbiFXOr1 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 24 Jun 2022 10:47:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200B767E42
        for <linux-sctp@vger.kernel.org>; Fri, 24 Jun 2022 07:44:07 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s77-20020a257750000000b00668ea5e3d04so2362150ybc.16
        for <linux-sctp@vger.kernel.org>; Fri, 24 Jun 2022 07:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4626xia5d5LkF7af7H2/cvkuUYPcK6Kx8h2FacVJFEk=;
        b=th1qe6nCen6zmaCB190GBZfnRnMr8qckPf7xXdSq0EVD8gYjLt6WzhfTitRavGwMgd
         vXilcNgCDBJRRUwP86/NE2cFk2yt4LhrpvKbk+OSVaOhZ9QX7RoXNrnjse0RW8wrov0A
         e/AjVrKc+b2APqiS3MmTV8TXpGYJnfibLdZbRt8tPJAQ4VejcBVaHjm3xiHfRthqt3hO
         14SO9lJx7tqftr6orGS/SfyVF/xr5P71GTXTgmaE3fA6eyIJ4dLNQMv3/dfvge1guWtE
         73rzZBtWVKfBk7sNXfxQEVTU5QpWxtJpBQ75xhUnQaYU9jnnZSOcZn/PcgtTEVHgJAUL
         xvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4626xia5d5LkF7af7H2/cvkuUYPcK6Kx8h2FacVJFEk=;
        b=echCJl5p71q2i29x+WBIYNvcufUsjVeYJR8Wxav+EPpae7kk+44l6L7xuWLf1ApX90
         YoPpdq6Qwam+6AAzVMYsJW64TF1FxuTra5NezU5f3LwY5NQ3BnxDUnkgHcuTNWdVU0om
         W1ovH6/fyS/u125qaK9IYo+Ihz4L+3tCm/FAMD2BCrDim3/iU1XQIQv/g5mInRcE3cfI
         lYBL4oYCcEaM+pR/erZG4PNQsJ8gUh0TnuzUMYCRV2Qkwd6MuHUpf5QOHiufscynZyJi
         Uom8NQgX70UZtI7SJ3pZ25rZJ8b/F37xSn+sWACCOuwpGC9kwbMwPrcPHQ6zQmlYMMvJ
         tE1w==
X-Gm-Message-State: AJIora+SfBRQhJxuJlFXhuSiJMVOvzsGwVDw7+av14JNQkk3FH2NLkci
        M5RcISs66DWFndMCJVUHsraQW6OaAokPYA==
X-Google-Smtp-Source: AGRyM1u8PEp1pM9/KxJIfa3nFsPEcGkFKuipmMhOWQIlB56Ud7icllIM9M0fY7r3dfrgjjZsEQIIA/WAW9Z2GQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:5bc3:0:b0:669:b722:beb8 with SMTP id
 p186-20020a255bc3000000b00669b722beb8mr5658217ybb.447.1656081841097; Fri, 24
 Jun 2022 07:44:01 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:43:58 +0000
In-Reply-To: <20220624070656.GE79500@shbuild999.sh.intel.com>
Message-Id: <20220624144358.lqt2ffjdry6p5u4d@google.com>
Mime-Version: 1.0
References: <20220619150456.GB34471@xsang-OptiPlex-9020> <20220622172857.37db0d29@kernel.org>
 <CADvbK_csvmkKe46hT9792=+Qcjor2EvkkAnr--CJK3NGX-N9BQ@mail.gmail.com>
 <CADvbK_eQUmb942vC+bG+NRzM1ki1LiCydEDR1AezZ35Jvsdfnw@mail.gmail.com>
 <20220623185730.25b88096@kernel.org> <CANn89iLidqjiiV8vxr7KnUg0JvfoS9+TRGg=8ANZ8NBRjeQxsQ@mail.gmail.com>
 <CALvZod7kULCvHAuk53FE-XBOi4-BbLdY3HCg6jfCZTJDxYsZow@mail.gmail.com> <20220624070656.GE79500@shbuild999.sh.intel.com>
Subject: Re: [net] 4890b686f4: netperf.Throughput_Mbps -69.4% regression
From:   Shakeel Butt <shakeelb@google.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>,
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jun 24, 2022 at 03:06:56PM +0800, Feng Tang wrote:
> On Thu, Jun 23, 2022 at 11:34:15PM -0700, Shakeel Butt wrote:
[...]
> > 
> > Feng, can you please explain the memcg setup on these test machines
> > and if the tests are run in root or non-root memcg?
> 
> I don't know the exact setup, Philip/Oliver from 0Day can correct me.
> 
> I logged into a test box which runs netperf test, and it seems to be
> cgoup v1 and non-root memcg. The netperf tasks all sit in dir:
> '/sys/fs/cgroup/memory/system.slice/lkp-bootstrap.service'
> 

Thanks Feng. Can you check the value of memory.kmem.tcp.max_usage_in_bytes
in /sys/fs/cgroup/memory/system.slice/lkp-bootstrap.service after making
sure that the netperf test has already run?

If this is non-zero then network memory accounting is enabled and the
slowdown is expected.

> And the rootfs is a debian based rootfs
> 
> Thanks,
> Feng
> 
> 
> > thanks,
> > Shakeel
