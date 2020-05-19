Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8991DA1BA
	for <lists+linux-sctp@lfdr.de>; Tue, 19 May 2020 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgEST7y (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 May 2020 15:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgEST7x (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 19 May 2020 15:59:53 -0400
Received: from smtp.tuxdriver.com (tunnel92311-pt.tunnel.tserv13.ash1.ipv6.he.net [IPv6:2001:470:7:9c9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B2EC08C5C0
        for <linux-sctp@vger.kernel.org>; Tue, 19 May 2020 12:59:51 -0700 (PDT)
Received: from 2606-a000-111b-4634-0000-0000-0000-1bf2.inf6.spectrum.com ([2606:a000:111b:4634::1bf2] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1jb8Ob-0000Wy-9k; Tue, 19 May 2020 15:59:36 -0400
Date:   Tue, 19 May 2020 15:59:24 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     Jere =?iso-8859-1?Q?Lepp=E4nen?= <jere.leppanen@nokia.com>,
        linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv2] sctp: Don't add the shutdown timer if its already been
 added
Message-ID: <20200519195924.GA697897@hmswarspite.think-freely.org>
References: <20200428165848.1834838-1-nhorman@tuxdriver.com>
 <20200429113613.1959665-1-nhorman@tuxdriver.com>
 <20200430135904.GD2688@localhost.localdomain>
 <alpine.LFD.2.21.2005191146330.774972@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net>
 <20200519192410.GO2491@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519192410.GO2491@localhost.localdomain>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, May 19, 2020 at 04:24:10PM -0300, Marcelo Ricardo Leitner wrote:
> On Tue, May 19, 2020 at 11:51:23AM +0300, Jere Leppänen wrote:
> > On Thu, 30 Apr 2020, Marcelo Ricardo Leitner wrote:
> > 
> > > On Wed, Apr 29, 2020 at 07:36:13AM -0400, Neil Horman wrote:
> > > > This BUG halt was reported a while back, but the patch somehow got
> > > > missed:
> > > > 
> > > > PID: 2879   TASK: c16adaa0  CPU: 1   COMMAND: "sctpn"
> > > >  #0 [f418dd28] crash_kexec at c04a7d8c
> > > >  #1 [f418dd7c] oops_end at c0863e02
> > > >  #2 [f418dd90] do_invalid_op at c040aaca
> > > >  #3 [f418de28] error_code (via invalid_op) at c08631a5
> > > >     EAX: f34baac0  EBX: 00000090  ECX: f418deb0  EDX: f5542950  EBP: 00000000
> > > >     DS:  007b      ESI: f34ba800  ES:  007b      EDI: f418dea0  GS:  00e0
> > > >     CS:  0060      EIP: c046fa5e  ERR: ffffffff  EFLAGS: 00010286
> > > >  #4 [f418de5c] add_timer at c046fa5e
> > > >  #5 [f418de68] sctp_do_sm at f8db8c77 [sctp]
> > > >  #6 [f418df30] sctp_primitive_SHUTDOWN at f8dcc1b5 [sctp]
> > > >  #7 [f418df48] inet_shutdown at c080baf9
> > > >  #8 [f418df5c] sys_shutdown at c079eedf
> > > >  #9 [f418df70] sys_socketcall at c079fe88
> > > >     EAX: ffffffda  EBX: 0000000d  ECX: bfceea90  EDX: 0937af98
> > > >     DS:  007b      ESI: 0000000c  ES:  007b      EDI: b7150ae4
> > > >     SS:  007b      ESP: bfceea7c  EBP: bfceeaa8  GS:  0033
> > > >     CS:  0073      EIP: b775c424  ERR: 00000066  EFLAGS: 00000282
> > > > 
> > > > It appears that the side effect that starts the shutdown timer was processed
> > > > multiple times, which can happen as multiple paths can trigger it.  This of
> > > > course leads to the BUG halt in add_timer getting called.
> > > > 
> > > > Fix seems pretty straightforward, just check before the timer is added if its
> > > > already been started.  If it has mod the timer instead to min(current
> > > > expiration, new expiration)
> > > > 
> > > > Its been tested but not confirmed to fix the problem, as the issue has only
> > > > occured in production environments where test kernels are enjoined from being
> > > > installed.  It appears to be a sane fix to me though.  Also, recentely,
> > > > Jere found a reproducer posted on list to confirm that this resolves the
> > > > issues
> > > > 
> > > > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > > > CC: Vlad Yasevich <vyasevich@gmail.com>
> > > > CC: "David S. Miller" <davem@davemloft.net>
> > > > CC: Jere Leppänen <jere.leppanen@nokia.com>
> > > > CC: marcelo.leitner@gmail.com
> > > > 
> > > > ---
> > > > Change notes:
> > > > V2) Updated to use timer_reduce
> > > 
> > > Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> > 
> > Hey is this patch falling through the cracks again? No rush, I'm just 
> > wondering what's going on.
> 
> Whoops, sounds like Neil forgot to Cc netdev@..
> 
>   Marcelo
> 
Crap, my bad.  I'm stuck in a call at the moment, but I'll resend this tomorrow
morning.
Thanks for following up!
Neil

