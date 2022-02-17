Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295914B9FEF
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Feb 2022 13:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiBQMSx (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Feb 2022 07:18:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiBQMSw (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Feb 2022 07:18:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCA32782BF
        for <linux-sctp@vger.kernel.org>; Thu, 17 Feb 2022 04:18:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 79C432198B;
        Thu, 17 Feb 2022 12:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645100316;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Axdt3EO2+0MqS0c3sL0sQw6bvpSjFXBb3syTZCsQbpo=;
        b=uM7Z4JrowsceTFgR4LJ8w6cGo0MW7oQh6wv5mXrm3PLgdcievuMN/xtsk1k81D6k3TMm8Q
        VH7YaRn03hNYZrjMeBomFapqeOt7YlfGRTiiowVFhrJQ7utF6j5i4gWCFdyd2ThaOzoGzW
        vwloyb9W/QTPHjQUQ7YxMe9RIRptoNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645100316;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Axdt3EO2+0MqS0c3sL0sQw6bvpSjFXBb3syTZCsQbpo=;
        b=Tg26PDacoXaWXUN/IH4a9hpC8qVlGmkaIyJ2eKgkmd+xw9ICX9KgEv78szxrQjdzhU2VvK
        RqrcnJ2GxmDvqtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16D8713BF1;
        Thu, 17 Feb 2022 12:18:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QaWhAxw9DmKOdgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 12:18:36 +0000
Date:   Thu, 17 Feb 2022 13:18:33 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
Message-ID: <Yg49GRX9Gpyle0pG@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220203170522.22051-1-pvorel@suse.cz>
 <20220203170522.22051-3-pvorel@suse.cz>
 <Yg4bt2V6rrircZ+x@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg4bt2V6rrircZ+x@yuki>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Cyril, all,

patchset merged (with suggested changes + few more TERRNO replaced).

Thanks!

Kind regards,
Petr

