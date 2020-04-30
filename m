Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527661BFB54
	for <lists+linux-sctp@lfdr.de>; Thu, 30 Apr 2020 15:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgD3N7L (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 30 Apr 2020 09:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgD3N7K (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 30 Apr 2020 09:59:10 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31139C035494
        for <linux-sctp@vger.kernel.org>; Thu, 30 Apr 2020 06:59:10 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b1so5015994qtt.1
        for <linux-sctp@vger.kernel.org>; Thu, 30 Apr 2020 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZUzabx+mAkXxTs/WsepXtmDTFcfQa8OjGrHGnh2duN8=;
        b=CPTr44R7gduHL8GMPToaGZDf2p0KdgBtipul6m5XxrqSTk8AvUDAS/hzAcs1no3HnN
         xJUiaNXYLPjpp6voUAJSY/Sz4XVAhA+IScu1dejrAucgLFX9lIHRNRO2WqL4Hq55hdH5
         PsVIccwW+dUZb/lK+Q/v5c8HhiqpcaVngsSVSVsg93D9aqa53k9lWSPd++uH75DuEZWt
         xVcXL2FbwGCXklJUxd1PF/VMVP+W5Ya5nQPBuKiFSA6DVVeC0eZXlaNttHZMJuWNHVUE
         nclDfhk1FYAlBKYt66lL+a+oBl/5NeiUR8geTlunVeAcysOFdiVboXjAGfr4ABSTCJgM
         zcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZUzabx+mAkXxTs/WsepXtmDTFcfQa8OjGrHGnh2duN8=;
        b=oRFsEr/dPcms+2wMZ1HWXTkcYUQnaQiYS5HVLYJz6uM7p4BZ7xjDPIF3Ea8j0ZxJkI
         wkvzPZUhJEaToErcv481u9gaQnqxNyOkZ6C7WxJTeNzBcVaoNIFmWo+0IGRVIdlULc+/
         2rDL3krRML6iUoffN3fCPKH34Hor2CxLHh1FBk1ziU1C9P4g6Xc7qqmRwH9Mf5GttBf9
         4RM+f5jnq+gRLiv6fsdBNaNZblyD3MzWA+0t5WxXkRvruj8vbWgsoAykRMS7gEOJKUEv
         g8e4SlihYU6ozpGInwU+5gz9FtE452FdMLwrLE//v6cg0oIWH3+deQ6VKBWURwojesBy
         HNRQ==
X-Gm-Message-State: AGi0PubZkRvMVfs6ElpwI0kRm0EzbNh9ukZKxQwZImgVPJ8VwGWCQNM0
        lSP81vXK3f2aLnBqKeYNDSo=
X-Google-Smtp-Source: APiQypJ7usVDs1as6lWNzbgkQ+XIPXuEYk6MXthFeOimwJ0QOpcb0dQRCRLhrViwgaUYkvR+seR63w==
X-Received: by 2002:ac8:358c:: with SMTP id k12mr3948709qtb.38.1588255148436;
        Thu, 30 Apr 2020 06:59:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f022:1531:d4ee:a562:95b8:a0e1])
        by smtp.gmail.com with ESMTPSA id t67sm76720qka.17.2020.04.30.06.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:59:07 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id BF737C4BC6; Thu, 30 Apr 2020 10:59:04 -0300 (-03)
Date:   Thu, 30 Apr 2020 10:59:04 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jere =?iso-8859-1?Q?Lepp=E4nen?= <jere.leppanen@nokia.com>
Subject: Re: [PATCHv2] sctp: Don't add the shutdown timer if its already been
 added
Message-ID: <20200430135904.GD2688@localhost.localdomain>
References: <20200428165848.1834838-1-nhorman@tuxdriver.com>
 <20200429113613.1959665-1-nhorman@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429113613.1959665-1-nhorman@tuxdriver.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Apr 29, 2020 at 07:36:13AM -0400, Neil Horman wrote:
> This BUG halt was reported a while back, but the patch somehow got
> missed:
> 
> PID: 2879   TASK: c16adaa0  CPU: 1   COMMAND: "sctpn"
>  #0 [f418dd28] crash_kexec at c04a7d8c
>  #1 [f418dd7c] oops_end at c0863e02
>  #2 [f418dd90] do_invalid_op at c040aaca
>  #3 [f418de28] error_code (via invalid_op) at c08631a5
>     EAX: f34baac0  EBX: 00000090  ECX: f418deb0  EDX: f5542950  EBP: 00000000
>     DS:  007b      ESI: f34ba800  ES:  007b      EDI: f418dea0  GS:  00e0
>     CS:  0060      EIP: c046fa5e  ERR: ffffffff  EFLAGS: 00010286
>  #4 [f418de5c] add_timer at c046fa5e
>  #5 [f418de68] sctp_do_sm at f8db8c77 [sctp]
>  #6 [f418df30] sctp_primitive_SHUTDOWN at f8dcc1b5 [sctp]
>  #7 [f418df48] inet_shutdown at c080baf9
>  #8 [f418df5c] sys_shutdown at c079eedf
>  #9 [f418df70] sys_socketcall at c079fe88
>     EAX: ffffffda  EBX: 0000000d  ECX: bfceea90  EDX: 0937af98
>     DS:  007b      ESI: 0000000c  ES:  007b      EDI: b7150ae4
>     SS:  007b      ESP: bfceea7c  EBP: bfceeaa8  GS:  0033
>     CS:  0073      EIP: b775c424  ERR: 00000066  EFLAGS: 00000282
> 
> It appears that the side effect that starts the shutdown timer was processed
> multiple times, which can happen as multiple paths can trigger it.  This of
> course leads to the BUG halt in add_timer getting called.
> 
> Fix seems pretty straightforward, just check before the timer is added if its
> already been started.  If it has mod the timer instead to min(current
> expiration, new expiration)
> 
> Its been tested but not confirmed to fix the problem, as the issue has only
> occured in production environments where test kernels are enjoined from being
> installed.  It appears to be a sane fix to me though.  Also, recentely,
> Jere found a reproducer posted on list to confirm that this resolves the
> issues
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Vlad Yasevich <vyasevich@gmail.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Jere Leppänen <jere.leppanen@nokia.com>
> CC: marcelo.leitner@gmail.com
> 
> ---
> Change notes:
> V2) Updated to use timer_reduce

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
