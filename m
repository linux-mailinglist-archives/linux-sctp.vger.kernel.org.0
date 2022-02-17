Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E5A4B9C87
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Feb 2022 10:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238863AbiBQJyR (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Feb 2022 04:54:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiBQJyQ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Feb 2022 04:54:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33834B3E43
        for <linux-sctp@vger.kernel.org>; Thu, 17 Feb 2022 01:54:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E54C31F37D;
        Thu, 17 Feb 2022 09:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645091640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ce3XAXOnsVh6eXPTSQDZt9DWrZieHLQsSF+P0ypZmuI=;
        b=LjglO9OwOKMKX96EUT03q9vLnHRubtpGuurALC3+eWzIH9uQeow3wKbGTtXoR1HUf9kEJR
        d2SyXARXyaEPXRZRzhDfqSUBjzZ6ArZpyz0He3ZUws4eEbLSS5FqjI6s8mfEIUXGd9ij9x
        eMSxQfGznxbZN/tdhFH+FFf66CCqDxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645091640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ce3XAXOnsVh6eXPTSQDZt9DWrZieHLQsSF+P0ypZmuI=;
        b=hRTpKhk1NKDpSx8DHIYEXEfnkYn+dapKujvKqWGfw+lML3i03N7ij3NnLwoDTiOxK0M5Xl
        kNEsFSddjOqEErAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 816A013BBF;
        Thu, 17 Feb 2022 09:54:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YWmLHjgbDmI/LwAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 17 Feb 2022 09:54:00 +0000
Date:   Thu, 17 Feb 2022 10:56:07 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
Message-ID: <Yg4bt2V6rrircZ+x@yuki>
References: <20220203170522.22051-1-pvorel@suse.cz>
 <20220203170522.22051-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203170522.22051-3-pvorel@suse.cz>
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
> diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
> index 1e21760bec..c4bedb47cf 100644
> --- a/utils/sctp/testlib/sctputil.h
> +++ b/utils/sctp/testlib/sctputil.h
> @@ -133,9 +133,14 @@ extern int TST_CNT;
>  static inline int test_socket(int domain, int type, int protocol)
>  {
>  	int sk = socket(domain, type, protocol);
> +	int res = TBROK;
>  
> -	if (sk == -1)
> -		tst_brkm(TBROK, tst_exit, "socket: %s", strerror(errno));
> +	if (sk == -1) {
> +		if (errno == EAFNOSUPPORT)
> +			res = TCONF;
> +
> +		tst_brkm(res, tst_exit, "socket: %s", strerror(errno));
> +	}

I would keep the messages separated here, i.e. do something as:

	if (errno == EAFNOSUPPORT)
		tst_brkm(TBROK | TERRNO, "socket(%i, %i, %i) not supported",
			 domain, type, protocol);

	tst_brkm(TBROK | TERRNO, "socket()");


Btw this code actually duplicates the safe_socket() function we do have
already, so it may as well be easier to just replace the test_socket()
with SAFE_SOCKET() in the tests...

-- 
Cyril Hrubis
chrubis@suse.cz
