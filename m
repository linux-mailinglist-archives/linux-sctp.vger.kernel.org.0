Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380F64A719A
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Feb 2022 14:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245191AbiBBNcr (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Feb 2022 08:32:47 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55026 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiBBNcq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Feb 2022 08:32:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E2931F397;
        Wed,  2 Feb 2022 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643808765;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYRZXTw5ERxIr7WmFR1GB2AYKILtzHJgKVwneyr+2VM=;
        b=3O02rUuCt5b6h+St8ygMC8PeJP0Z8wpwo+ATwBzCovoYfuux1pDuUl8D3Pw9d0H3O52Q/U
        K8G9jGVGDpMs/OjqadbG3AzzSjoja5+wZCaZq6aWG+hKb0i2gpYM/DAMXn7G2itxqDlSZD
        KLRmGreGDMspAeJJRljQjmY2oHF6vw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643808765;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYRZXTw5ERxIr7WmFR1GB2AYKILtzHJgKVwneyr+2VM=;
        b=reon22FooJWutkzNPRsDVrUuAcBnLc0d+PizNRM5woJq18ij7zQBq+zjwU/7cOnK7bbo+F
        mK8ioBCs2gNF4BCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5F0813E48;
        Wed,  2 Feb 2022 13:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sBshNvyH+mETSwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 13:32:44 +0000
Date:   Wed, 2 Feb 2022 14:32:43 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, ltp@lists.linux.it,
        Cyril Hrubis <chrubis@suse.cz>,
        Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Martin Doucha <martin.doucha@suse.com>
Subject: Re: [RFC] SCTP tests in LTP vs. on github.com/sctp
Message-ID: <YfqH+7Bsr9LrnJn1@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YfpnVfrto4Elshy5@pevik>
 <Yfp49PCW9Res5gXG@t14s.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfp49PCW9Res5gXG@t14s.localdomain>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Marcelo,

> Hi Petr,

> On Wed, Feb 02, 2022 at 12:13:25PM +0100, Petr Vorel wrote:
> > Hi all,

> > SCTP tests lksctp-tools [1] are also in LTP [2].
> > IMHO it's not worth to have it on both places.

> Agree. I wasn't aware of the copy in LTP, btw.

> A question I have now is, is getting more exposure because it is in
> LTP? As in, does it get executed periodically by bots somewhere?

Maybe yes, hard to tell. Not sure even how many people even run SCTP tests
included by LTP. We could ask at automated-testing [8] (embedded people + hopefully
folks from KernelCI [9]) or send the update there. We'd also put a link in
to remaining location in git commit message if agree to remove it from LTP.

> > lksctp-tools looks like to be the official ones [3] so maybe drop it from LTP?

> > Version in LTP was updated to 1.0.15 some time ago (upstream has 1.0.19, containing various fixes [4],
> > maybe worth to be backported to lksctp-tools? Frankly speaking even being older
> > version the LTP code looks to me better. One test was even rewritten to LTP new
> > C API [5] in order to apply more improvements [6].

> > BTW I'd really recommend lksctp-tools project to take new LTP C API [7] and
> > rewrite tests into it. But are these tests still relevant? (is it worth of
> > work?)

> These are nice tips, thanks. We certainly can have a take on them.
Yw.

Kind regards,
Petr

> Best regards,
> Marcelo


> > Kind regards,
> > Petr

> > [1] https://github.com/sctp/lksctp-tools
> > [2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
> > [3] https://github.com/sctp
> > [4] https://github.com/linux-test-project/ltp/commits/master/utils/sctp
> > [5] https://github.com/linux-test-project/ltp/commit/fcd43b3dd7a8e8fab2b03ec9fa659f21ff5cecb2
> > [6] https://github.com/linux-test-project/ltp/commit/fcd43b3dd7a8e8fab2b03ec9fa659f21ff5cecb2
> > [7] https://github.com/linux-test-project/ltp/wiki/C-Test-API
[8] https://lists.yoctoproject.org/g/automated-testing/
[9] https://foundation.kernelci.org/
