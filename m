Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313F54B9C4D
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Feb 2022 10:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiBQJnu (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Feb 2022 04:43:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiBQJnt (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Feb 2022 04:43:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AB01704F
        for <linux-sctp@vger.kernel.org>; Thu, 17 Feb 2022 01:43:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8FBC521108;
        Thu, 17 Feb 2022 09:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645091014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LMLInmOQBOfRxxxSqN1OsDaJao7PcodBVEmK0/ffCpc=;
        b=UtRq7p6eGsKNjVL2qw8z5oFvbnBfVW6V5bbaiZ9tBmgJLPEuVT08J8wB+QVxV4A708BWGn
        4foE/Kb6fFCq/DOKdqhQDjOVPhSM7jRlhk7q7Hem+W0uoP/HJqyAM/HEgTU+Ywa1mAGEXL
        IUeiaBsRyMz06521nky+3FXpBkUWdYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645091014;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LMLInmOQBOfRxxxSqN1OsDaJao7PcodBVEmK0/ffCpc=;
        b=J+nbUw7fD53EIrpLtsyvtM0lw5B9yl4QJ/kA4cFY/k/mbZ/ipQX9gcs/9ucQGeG1sc/Omo
        nHrVU1YQ3s4PTDCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75F8D13BBF;
        Thu, 17 Feb 2022 09:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hJfWG8YYDmIHKgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 17 Feb 2022 09:43:34 +0000
Date:   Thu, 17 Feb 2022 10:45:41 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH 1/2] sctputil.h: Fix some formatting
Message-ID: <Yg4ZRSy3nmzB31D6@yuki>
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
> +	if (sk == -1)
> +		tst_brkm(TBROK, tst_exit, "socket: %s", strerror(errno));
> +
>  	return sk;
>  }

Also one more thing, we can just do TBROK | TERRNO instead of the
strerror() as well.

-- 
Cyril Hrubis
chrubis@suse.cz
