Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F8F4B9C38
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Feb 2022 10:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiBQJku (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Feb 2022 04:40:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbiBQJkt (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Feb 2022 04:40:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EE929720E
        for <linux-sctp@vger.kernel.org>; Thu, 17 Feb 2022 01:40:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AA101F383;
        Thu, 17 Feb 2022 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645090834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=par63/FR9F0L/1vSXTdbL1MRNNPz8a9EIJtPr6UY9Uk=;
        b=ncyUkO91Rs67B0LBV5Gvx95/zepy8nugj+noLwhWZkF2mRz6yp9/LKeJgAs//KMP5NsElg
        mgnI/pYHvzj3dkCtBAQOjyu0E9tqBCCQ1r1W/dRO7KmEAj2ahfTAVFcD53DZZk7WrNqVhH
        sMMXC9/mtlu3kc/yXmJZT5eU8IwLnKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645090834;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=par63/FR9F0L/1vSXTdbL1MRNNPz8a9EIJtPr6UY9Uk=;
        b=8OSwOG8kcvVRVT6eIKDH9IGg5QqyMc3pjG6kJBYHsmYC5+fjMmnqbYEwOIKxgyF9gRmEfU
        QgDjW2QY7wx7iQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 066FD13BBF;
        Thu, 17 Feb 2022 09:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EWBGABIYDmKiKAAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 17 Feb 2022 09:40:34 +0000
Date:   Thu, 17 Feb 2022 10:42:41 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH 1/2] sctputil.h: Fix some formatting
Message-ID: <Yg4YkbUB3moje7Y8@yuki>
References: <20220203170522.22051-1-pvorel@suse.cz>
 <20220203170522.22051-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203170522.22051-2-pvorel@suse.cz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi!
>  static inline void *test_malloc(size_t size)
>  {
>  	void *buf = malloc(size);
> -        if (NULL == buf)
> -                tst_brkm(TBROK, tst_exit, "malloc failed");
> +
> +	if (NULL == buf)
> +		tst_brkm(TBROK, tst_exit, "malloc failed");

This one has still constant on the right and I would rather change this
to the more common if (!buf) variant as well.

Other than that it's pretty obviously fine:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

>  	return buf;
>  }
>  
> -- 
> 2.35.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
