Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB941802AE
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Mar 2020 17:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgCJQBV (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 10 Mar 2020 12:01:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41844 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgCJQBV (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 10 Mar 2020 12:01:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so5596999plr.8
        for <linux-sctp@vger.kernel.org>; Tue, 10 Mar 2020 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5PprlbqoqI+8cqH5y1+LaXm/Lh1O+UbpqxwQEoE+kVQ=;
        b=QYDxC/nug0FPO0R2YDDHDpINh+3k13f/K2ZFHSvhTtDb+xxhNyCFtyrpCsUQy1dWvN
         GCiI4tkRZEnq/U0iMzpS8zQEPBFV0kTt0Cmo90IelMR3bgcbMzIow1xlr6OhlTUMgYEd
         ZfMxcAxoXjw/IMN7D8O9LQ2cZRfgF/iSJRu4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5PprlbqoqI+8cqH5y1+LaXm/Lh1O+UbpqxwQEoE+kVQ=;
        b=g4PTlZp3kbpDpCRtp2NyYwLOa2ly5OldNCtQ6JTDyrrOCSWRiaPXJ7+g5wRT3/rJl/
         WfdjVERJmSYS2ZIsTkoJIsxoBZkr3KMOlah7GOQYcYWAmWoZD8uybzZPEoUJULhFW1uv
         Rnncq5VMSg5DTC7Q57e228vjZghIR37KiSosYBvpjfC6MMj/m734vHfotHEFZ/OFlK5A
         LFkVx8wAbvA0+EH2MGTs9c78aGMvIkzAYODUoXV7H4Y3U0qRit2l5uEeRLuj2v3enitZ
         bOllJQe2gGOO0lIk7mAabXLTWzaewwB503DQoQBND42vYTK9Hh13Qa5BQevp/bGe5JkU
         gLGw==
X-Gm-Message-State: ANhLgQ1hJqSBfg2nisB4VWp9CQwTLa76wT5zopNlOAFMzuoF4zFIWqjj
        UeJ6rUXwTMXcrOb1z6aIGWECyg==
X-Google-Smtp-Source: ADFU+vtmM+D+yGWVPf1IZeuUEbx/otAbFEt5GhAZoqGWcLN6EsWZZ4nPx3ClLaNnJpKVk5Q1kJWBww==
X-Received: by 2002:a17:902:b903:: with SMTP id bf3mr21622900plb.144.1583856080398;
        Tue, 10 Mar 2020 09:01:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6sm7318987pfx.69.2020.03.10.09.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 09:01:19 -0700 (PDT)
Date:   Tue, 10 Mar 2020 09:01:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     syzbot <syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com>
Cc:     ardb@kernel.org, davem@davemloft.net, guohanjun@huawei.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com,
        mingo@kernel.org, netdev@vger.kernel.org, nhorman@tuxdriver.com,
        syzkaller-bugs@googlegroups.com, vyasevich@gmail.com,
        will@kernel.org
Subject: Re: WARNING: refcount bug in sctp_wfree
Message-ID: <202003100900.1E2E399@keescook>
References: <00000000000088452f05a07621d2@google.com>
 <000000000000cc985b05a07ce36f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000cc985b05a07ce36f@google.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Mar 10, 2020 at 02:39:01AM -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit fb041bb7c0a918b95c6889fc965cdc4a75b4c0ca
> Author: Will Deacon <will@kernel.org>
> Date:   Thu Nov 21 11:59:00 2019 +0000
> 
>     locking/refcount: Consolidate implementations of refcount_t

I suspect this is just bisecting to here because it made the refcount
checks more strict?

-Kees

> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117e9e91e00000
> start commit:   2c523b34 Linux 5.6-rc5
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=137e9e91e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=157e9e91e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a5295e161cd85b82
> dashboard link: https://syzkaller.appspot.com/bug?extid=cea71eec5d6de256d54d
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164b5181e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166dd70de00000
> 
> Reported-by: syzbot+cea71eec5d6de256d54d@syzkaller.appspotmail.com
> Fixes: fb041bb7c0a9 ("locking/refcount: Consolidate implementations of refcount_t")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

-- 
Kees Cook
