Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696131DA0F7
	for <lists+linux-sctp@lfdr.de>; Tue, 19 May 2020 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgESTYQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 May 2020 15:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTYP (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 19 May 2020 15:24:15 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F6C08C5C0
        for <linux-sctp@vger.kernel.org>; Tue, 19 May 2020 12:24:15 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id z9so159989qvi.12
        for <linux-sctp@vger.kernel.org>; Tue, 19 May 2020 12:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hbKivt4Mp7GiiKi+qCzxvsK+PSwwqQ7C6le1FJgmiDM=;
        b=NWld+JAEk7sIuYQUSoIW1IIsV4G2uGaZQ/uQBzUczTDMmPReV6Ok5QMKHPjRlYMz+A
         CnsPyXl5NrhAWSFc+2GnAjge1eAuFDxhcSHKMURYmox7aGHX/R1e9VtQvMo5E1JeDhje
         MgZ2IcUlTIPRuPjC4M3HAU0njnR61lHHrqp4T49Jf4wxZZp24aAegYgIdGyZw1hsg3oq
         hPX7dnAqX2vYqQUIhjCrciCRZl8szGH18n0ZZqhL61qsWBeNHnb2YNBzNs7S/+ahAkAu
         7F1MBv8zvfNvgqxft/omJP7gjQALISpgYaUs/cG3ZAysNMNvffSieyM8WjwmktMJ2l8A
         061A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hbKivt4Mp7GiiKi+qCzxvsK+PSwwqQ7C6le1FJgmiDM=;
        b=JbGEqmSRF0du2feYtfAIAWBPBVUcXLBq0E3lGfQHBqcH3wuaz87jhsBWFs46UmMiDf
         VfnQxhVDR+mRaRgQYpxXJsCqwCkl961aJ7g2xE5CoYQCa80HPt2PkY78jX4VyUzEuyGz
         Bq84gj84p0cCLJ5sVYl67CNv7MZdIXw2WaSmU6cmAjVFVacdlVy0U4Kcyxw9wlNHk2h4
         sFDjUXkjKBiewLjrFAKko1iA/+wgrfsy8VLl7qELQTMdCY5GIKboGKLN2xuXDlFh3NAK
         +MhWu4oDf4QH1HU1arVt0ikL0gogQbNTnd5E5g5HgQXxGtL9lWEC7V7BBo5Q8kSg91i9
         ZdIg==
X-Gm-Message-State: AOAM5310jhZFzBvp1HsMWYiI7+6HMgiKM5GCD9qaVZLXu8M0Q+jLFPES
        KwXv5tS6t0EcPtfPxclIWkE=
X-Google-Smtp-Source: ABdhPJylH5PTz/bH3pXRnxdvmlnvaPC0w026LXgGNjq1xwhkqoefGKmk3pMGr9TRZgn9JP2bsOb4HQ==
X-Received: by 2002:a0c:c3cf:: with SMTP id p15mr1307974qvi.10.1589916254834;
        Tue, 19 May 2020 12:24:14 -0700 (PDT)
Received: from localhost.localdomain ([168.181.48.225])
        by smtp.gmail.com with ESMTPSA id p137sm372727qke.60.2020.05.19.12.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 12:24:13 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id A2EA7C08DA; Tue, 19 May 2020 16:24:10 -0300 (-03)
Date:   Tue, 19 May 2020 16:24:10 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Jere =?iso-8859-1?Q?Lepp=E4nen?= <jere.leppanen@nokia.com>
Cc:     Neil Horman <nhorman@tuxdriver.com>, linux-sctp@vger.kernel.org,
        Vlad Yasevich <vyasevich@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCHv2] sctp: Don't add the shutdown timer if its already been
 added
Message-ID: <20200519192410.GO2491@localhost.localdomain>
References: <20200428165848.1834838-1-nhorman@tuxdriver.com>
 <20200429113613.1959665-1-nhorman@tuxdriver.com>
 <20200430135904.GD2688@localhost.localdomain>
 <alpine.LFD.2.21.2005191146330.774972@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LFD.2.21.2005191146330.774972@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, May 19, 2020 at 11:51:23AM +0300, Jere Leppänen wrote:
> On Thu, 30 Apr 2020, Marcelo Ricardo Leitner wrote:
> 
> > On Wed, Apr 29, 2020 at 07:36:13AM -0400, Neil Horman wrote:
> > > This BUG halt was reported a while back, but the patch somehow got
> > > missed:
> > > 
> > > PID: 2879   TASK: c16adaa0  CPU: 1   COMMAND: "sctpn"
> > >  #0 [f418dd28] crash_kexec at c04a7d8c
> > >  #1 [f418dd7c] oops_end at c0863e02
> > >  #2 [f418dd90] do_invalid_op at c040aaca
> > >  #3 [f418de28] error_code (via invalid_op) at c08631a5
> > >     EAX: f34baac0  EBX: 00000090  ECX: f418deb0  EDX: f5542950  EBP: 00000000
> > >     DS:  007b      ESI: f34ba800  ES:  007b      EDI: f418dea0  GS:  00e0
> > >     CS:  0060      EIP: c046fa5e  ERR: ffffffff  EFLAGS: 00010286
> > >  #4 [f418de5c] add_timer at c046fa5e
> > >  #5 [f418de68] sctp_do_sm at f8db8c77 [sctp]
> > >  #6 [f418df30] sctp_primitive_SHUTDOWN at f8dcc1b5 [sctp]
> > >  #7 [f418df48] inet_shutdown at c080baf9
> > >  #8 [f418df5c] sys_shutdown at c079eedf
> > >  #9 [f418df70] sys_socketcall at c079fe88
> > >     EAX: ffffffda  EBX: 0000000d  ECX: bfceea90  EDX: 0937af98
> > >     DS:  007b      ESI: 0000000c  ES:  007b      EDI: b7150ae4
> > >     SS:  007b      ESP: bfceea7c  EBP: bfceeaa8  GS:  0033
> > >     CS:  0073      EIP: b775c424  ERR: 00000066  EFLAGS: 00000282
> > > 
> > > It appears that the side effect that starts the shutdown timer was processed
> > > multiple times, which can happen as multiple paths can trigger it.  This of
> > > course leads to the BUG halt in add_timer getting called.
> > > 
> > > Fix seems pretty straightforward, just check before the timer is added if its
> > > already been started.  If it has mod the timer instead to min(current
> > > expiration, new expiration)
> > > 
> > > Its been tested but not confirmed to fix the problem, as the issue has only
> > > occured in production environments where test kernels are enjoined from being
> > > installed.  It appears to be a sane fix to me though.  Also, recentely,
> > > Jere found a reproducer posted on list to confirm that this resolves the
> > > issues
> > > 
> > > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > > CC: Vlad Yasevich <vyasevich@gmail.com>
> > > CC: "David S. Miller" <davem@davemloft.net>
> > > CC: Jere Leppänen <jere.leppanen@nokia.com>
> > > CC: marcelo.leitner@gmail.com
> > > 
> > > ---
> > > Change notes:
> > > V2) Updated to use timer_reduce
> > 
> > Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> 
> Hey is this patch falling through the cracks again? No rush, I'm just 
> wondering what's going on.

Whoops, sounds like Neil forgot to Cc netdev@..

  Marcelo
