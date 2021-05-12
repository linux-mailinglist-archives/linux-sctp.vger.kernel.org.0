Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F1C37CFC3
	for <lists+linux-sctp@lfdr.de>; Wed, 12 May 2021 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbhELRRz (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 12 May 2021 13:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbhELQde (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 12 May 2021 12:33:34 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EE3C061242
        for <linux-sctp@vger.kernel.org>; Wed, 12 May 2021 09:08:35 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso3102634wmc.1
        for <linux-sctp@vger.kernel.org>; Wed, 12 May 2021 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Zb8Z1MMBHH1GDzI2/MHx2aqkliA2vrBibF8r3xnq9g=;
        b=BrMRUT9BVbfzYXCL1R7JqOinDFhET5B7ApIwSPFdK+RSgvFN207oJO657OLx9d+Lqn
         VoBwDqufEiRXlbccBpOrzWJhIOZqe1hUaI0wV7EzNxmQouaC9JNtLV+Gdljz2tTP724M
         OseGPkUYILzGYN7RUu3DVOoRfVHkMfMcrAuZpBVYO5EJqa7iiCnwMMABdmHf9ACu3M+g
         RR/1deO5mygmGXztBDjUWppXF0LlXsgAM/d2362XhC8dkmkbWp30eIHuFe6TmOviIEdq
         oCmmXb4tHFwJ8biDzwVWnKTkMdfVJtlVG6paHRiVcjwpWkPAnwGnV3q8wZdffWWptKQO
         4q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Zb8Z1MMBHH1GDzI2/MHx2aqkliA2vrBibF8r3xnq9g=;
        b=UsxLEI8JTEj+kVdeiYgI+zqlaP/TsPjPY0KW+S4xwGKPcj5lTloowsYXjMaT/IH3Zo
         yfFIpc09SzsavUEt2Gi/NYo0UkyGqQ5kmORBQbkWpxy8pcVaITc9tHe5UTiec8hhgJ7j
         b9NJ7InthhOh8extr0IJUU3O5VUy99h8MbmW15DY2OydaLTvn7en/DavYITYN7wKuPby
         Dc/Pb9bteQAWQnp012Iwx5ISVrzJGxnUw95etKkhsyp/K1Y+ztx/IaEpnLxaxZSCJcWJ
         27R/MnoKFolOKvRu0U+8M7Hiz6yuHNqd+wJDjZxQO/CUH6RqlidqFwjIBPQlT7Hf0XCz
         aHxw==
X-Gm-Message-State: AOAM531E8NRtJ4pieUpSb4+Mqh/gtlYBQnw8zYXNDUeFtda7Hh9TA1RF
        4v9+ZP0ZmgRohIy+R2GfBvFvD1t2kiucJ9jUQnE=
X-Google-Smtp-Source: ABdhPJxeObGwLzbLW/Oy5cCZs5DMshSShTb5zkcweuGf0pmQNbPT7PIV8KgHiunAiUI1vgO6IuXqi2XSLaxosXqm0YE=
X-Received: by 2002:a7b:ca42:: with SMTP id m2mr39933166wml.67.1620835714140;
 Wed, 12 May 2021 09:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <86d2a00b-7fba-a539-b1bf-5bacf0443542@nokia.com>
In-Reply-To: <86d2a00b-7fba-a539-b1bf-5bacf0443542@nokia.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 12 May 2021 12:08:22 -0400
Message-ID: <CADvbK_dtTAxy=kYhbxHc6b1AKVc+vQm=h1tnWHbCizihFSm30w@mail.gmail.com>
Subject: Re: Race of sctp_assoc_control_transport() against
 sctp_assoc_rm_peer() ?
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Petr Malat <oss@malat.biz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This should be fixed by:

commit 35b4f24415c854cd718ccdf38dbea6297f010aae
Author: Xin Long <lucien.xin@gmail.com>
Date:   Sat May 1 04:02:58 2021 +0800

    sctp: do asoc update earlier in sctp_sf_do_dupcook_a

On Tue, Dec 8, 2020 at 4:12 PM Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:
>
> Hello!
>
> I'm trying to understand the crash we experience with Linux v4.19
> (sorry for the ancient codebase, but actually the affected code is largely
> unchanged up to now).
>
> This is hard but reproducible:
>
> general protection fault: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O      4.19.155-g...
> ...
> RIP: 0010:sctp_assoc_control_transport+0x1db/0x290 [sctp]
> Code: 01 00 00 00 00 00 00 bd 01 00 00 00 31 c0 48 89 e7 b9 10 00 00 00 f3 48 ab 48 8b 86 a8 00 00 00 48 89 e7 48 81 c6 88 00 00 00 <48> 63 90 bc 00 00 00 e8 29 61 2b e1 31 d2 41 b9 20 00 48 00 41 89
> RSP: 0018:ffff88846fc43ba8 EFLAGS: 00010286
> RAX: 7070682e72656d69 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffff8882984b3888 RDI: ffff88846fc43ba8
> RBP: 0000000000000001 R08: 0000000000022e80 R09: ffff88846fc43cd8
> R10: ffffffffa0562cf0 R11: 0000000000000007 R12: 0000000000000000
> R13: ffff88846fc43cd8 R14: ffff8881bd588000 R15: ffff88846fc43e18
> FS:  0000000000000000(0000) GS:ffff88846fc40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000024b3160 CR3: 000000000320a006 CR4: 00000000003607e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  sctp_do_8_2_transport_strike.isra.10+0xd3/0x1a0 [sctp]
>  ? sctp_oname+0x20/0x20 [sctp]
>  sctp_do_sm+0x15fb/0x1d00 [sctp]
>  ? try_to_wake_up+0x226/0x4b0
>  ? __update_load_avg_se+0x219/0x2c0
>  ? enqueue_entity+0xc4/0x850
>  ? enqueue_entity+0x17f/0x850
>  ? enqueue_task_fair+0xe5/0x950
>  ? __update_load_avg_cfs_rq+0x1e2/0x280
>  ? resched_curr+0x20/0xd0
>  ? check_preempt_curr+0x4e/0x90
>  ? ttwu_do_wakeup.isra.21+0x19/0x170
>  sctp_generate_timeout_event+0xa8/0xf0 [sctp]
>  ? sctp_generate_t4_rto_event+0x20/0x20 [sctp]
>  ? sctp_generate_t4_rto_event+0x20/0x20 [sctp]
>  call_timer_fn+0x32/0x170
>  expire_timers+0x9d/0x110
>  run_timer_softirq+0x8a/0x160
>  ? __hrtimer_run_queues+0x156/0x2e0
>  __do_softirq+0xaf/0x33e
>  irq_exit+0xbf/0xe0
>  smp_apic_timer_interrupt+0x7d/0x170
>  apic_timer_interrupt+0xf/0x20
>  </IRQ>
>
> The exploding code in sctp_assoc_control_transport() is:
>
>         /* Generate and send a SCTP_PEER_ADDR_CHANGE notification
>          * to the user.
>          */
>         if (ulp_notify) {
>                 memset(&addr, 0, sizeof(struct sockaddr_storage));
>                 memcpy(&addr, &transport->ipaddr,
>                        transport->af_specific->sockaddr_len);
>
> where "transport" pointer seems to be freed and re-used, so the dereference
> to obtain "af_specific" leads to the dump above. This memset/memcpy pair
> has been factored out into sctp_ulpevent_notify_peer_addr_change(), but
> this most probably doesn't solve the problem.
>
> According to the stack above, the race seems to be between this code:
>
> enum sctp_disposition sctp_sf_t4_timer_expire(
>                                         struct net *net,
>                                         const struct sctp_endpoint *ep,
>                                         const struct sctp_association *asoc,
>                                         const union sctp_subtype type,
>                                         void *arg,
>                                         struct sctp_cmd_seq *commands)
> {
>         struct sctp_chunk *chunk = asoc->addip_last_asconf;
>         struct sctp_transport *transport = chunk->transport;
>
>         SCTP_INC_STATS(net, SCTP_MIB_T4_RTO_EXPIREDS);
>
>         /* ADDIP 4.1 B1) Increment the error counters and perform path failure
>          * detection on the appropriate destination address as defined in
>          * RFC2960 [5] section 8.1 and 8.2.
>          */
>         if (transport)
>                 sctp_add_cmd_sf(commands, SCTP_CMD_STRIKE,
>                                 SCTP_TRANSPORT(transport));
>
>
> and
>
> void sctp_assoc_rm_peer(struct sctp_association *asoc,
>                         struct sctp_transport *peer)
> {
> ...
>         /* If we remove the transport an ASCONF was last sent to, set it to
>          * NULL.
>          */
>         if (asoc->addip_last_asconf &&
>             asoc->addip_last_asconf->transport == peer)
>                 asoc->addip_last_asconf->transport = NULL;
>
> ...
>         asoc->peer.transport_count--;
>
>         sctp_transport_free(peer);
> }
>
> So instead of doing sctp_transport_hold() on the addip_last_asconf->transport,
> the code relies on the NULL assignment to be propagated.
>
> As I do not see any memory barrier or lock here, I have several questions:
>
> - Is it possible that sctp_assoc_control_transport() runs in a timer handler
>   in parallel to sctp_assoc_rm_peer() running on a different core?
>   In this case there would be no guarantee, that NULL assignment will reach
>   another core.
>
> - What was the designed guarantee, that sctp_assoc_control_transport() will see
>   the change to asoc->addip_last_asconf->transport = NULL ?
>
> - What about all the similar NULL assignments in sctp_assoc_rm_peer()?
>
> --
> Best regards,
> Alexander Sverdlin.
