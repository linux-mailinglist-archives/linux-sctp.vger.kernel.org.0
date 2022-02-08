Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75654AE178
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Feb 2022 19:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385528AbiBHSud (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Feb 2022 13:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385518AbiBHSuc (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 8 Feb 2022 13:50:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222E3C0612C0
        for <linux-sctp@vger.kernel.org>; Tue,  8 Feb 2022 10:50:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C6AE7210F8;
        Tue,  8 Feb 2022 18:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644346229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ElMprPW5Cp7bYbLMDurp9MJhtcae8shwWsLRlc5Le4=;
        b=hqC1muMEEhBOT1mSZpmWzpMmSEaF0KUJAm2yffVoI60P/29B1kCpfjDWyeAppwzj6p2QtG
        U4h9NdBI90XjviJuf4+r6ZuCCEOC+VVY8knSTNmuJ87NtCtCfewqVHBssGgoOJwHHn+3lj
        hR+Wrk6bMMl8m/ZyHivNs/Q9BHgK0+M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644346229;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2ElMprPW5Cp7bYbLMDurp9MJhtcae8shwWsLRlc5Le4=;
        b=psxEUvw3Qx44/VSyV+Dbt/ToMTniU5PCDlcTdnjEVjr4oZDd65xGylEf6w/KHjPNyjemSn
        oiGuN1ZkhgvSmVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4926113D09;
        Tue,  8 Feb 2022 18:50:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vu6zD3W7AmIcCQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 18:50:29 +0000
Date:   Tue, 8 Feb 2022 19:50:27 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Veronika Kabatova <vkabatov@redhat.com>
Cc:     automated-testing@lists.yoctoproject.org, ltp@lists.linux.it,
        linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Philip Li <philip.li@intel.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        Erico Nunes <nunes.erico@gmail.com>
Subject: Re: [Automated-testing] SCTP testing
Message-ID: <YgK7cwcwgcio6XIY@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YfwVcwpZU/lusVlC@pevik>
 <CA+tGwnk9YO+0Df_BRqjOU4W5y-TgdJNE3PdnaB5RWWLRF0=8cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+tGwnk9YO+0Df_BRqjOU4W5y-TgdJNE3PdnaB5RWWLRF0=8cQ@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Veronika, all,

> On Thu, Feb 3, 2022 at 6:51 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > we've been just discussing, which repository should be hosting SCTP tests [1].

> > Do you use these SCTP tests? If yes, do you use it from LTP [2] or the official
> > SCTP kernel developers repository [3] ? If you use integrated to some testing
> > framework, would it be a problem if repository changes?

> > Also, do you use LTP network tests at all?


> Hi,

> we're currently not running these, but if I may offer a suggestion from my
> experience: It's easier for people to pick up testing when it's already a
> part of a test suite, rather than a separate test that they have to figure
> out a) even exists b) how to run it

> There are large test suites like LTP, kselftests and xfstests that most
> people are aware of, but then you get a lot of smaller tests or random
> scripts that, unless you're already familiar with the subsystem or get
> them linked directly, people won't find easily. And if a CI system wants
> to start running those tests, they most likely need to create a wrapper
> to handle test specifics, while the enablement via a larger test suite
> is way easier (as they can already handle it and all that's needed is
> to enable that specific test subset).

> Consolidating smaller tests into LTP or kselftests, where applicable,
> would make the testing process more streamlined and easier to follow
> for new folks too, as the expected testing could be unified across
> subsystems and there would be no surprises.

Thanks a lot for your input.

Agree, thus from this point it'd make more sense to keep it in LTP.
Given only 2 people responded and none of you actually run these tests.
That suggests little interest in SCTP testing.

@SCTP kernel maintainers: We LTP maintainers don't care which repo will be
chosen it's up to you to decide.

Kind regards,
Petr

> Veronika

> > Kind regards,
> > Petr

> > [1] https://lore.kernel.org/linux-sctp/YfpnVfrto4Elshy5@pevik/
> > [2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
> > [3] https://github.com/sctp/lksctp-tools
