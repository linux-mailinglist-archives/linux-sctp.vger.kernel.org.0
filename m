Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8404B9F57
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Feb 2022 12:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235162AbiBQLpk (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Feb 2022 06:45:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiBQLpk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Feb 2022 06:45:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B727D695
        for <linux-sctp@vger.kernel.org>; Thu, 17 Feb 2022 03:45:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0283C210DC;
        Thu, 17 Feb 2022 11:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645098325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loLYtvZYPROQc5ZQMZ4V5vjbczPWRMwCwDS0xewDOb0=;
        b=iKJ5wJ2+8i9Wv9xBSkMzLpQngwIymtW8BQeViqXqXuBdq7pZ7MoJ5F3aybMMi4Iqg+eWok
        Tn8VSQPhJ4+VClAhODJNoT72y3a49UOxtK8qxcjXT12rwpg27Z1LZFuJkya7n6LFble3b7
        jIH1t8jWMkwsg98xbOcj2w2G8brWUXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645098325;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loLYtvZYPROQc5ZQMZ4V5vjbczPWRMwCwDS0xewDOb0=;
        b=fg2+dgVZN4SwakyIJeRQbEWYdlM4g4G801/0LWtKx1y6PVXkcl00InXWvGuzwYGj1IuPdh
        eLurrq59nAPMljCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA6AE13BBF;
        Thu, 17 Feb 2022 11:45:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HMTzJ1Q1DmJlZQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 11:45:24 +0000
Date:   Thu, 17 Feb 2022 12:45:22 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     ltp@lists.linux.it,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>, linux-sctp@vger.kernel.org
Subject: Re: [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
Message-ID: <Yg41Uk3IxfBRX+i8@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220203170522.22051-1-pvorel@suse.cz>
 <20220203170522.22051-3-pvorel@suse.cz>
 <Yg4bt2V6rrircZ+x@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

> Hi!
> > diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
> > index 1e21760bec..c4bedb47cf 100644
> > --- a/utils/sctp/testlib/sctputil.h
> > +++ b/utils/sctp/testlib/sctputil.h
> > @@ -133,9 +133,14 @@ extern int TST_CNT;
> >  static inline int test_socket(int domain, int type, int protocol)
> >  {
> >  	int sk = socket(domain, type, protocol);
> > +	int res = TBROK;

> > -	if (sk == -1)
> > -		tst_brkm(TBROK, tst_exit, "socket: %s", strerror(errno));
> > +	if (sk == -1) {
> > +		if (errno == EAFNOSUPPORT)
> > +			res = TCONF;
> > +
> > +		tst_brkm(res, tst_exit, "socket: %s", strerror(errno));
> > +	}

> I would keep the messages separated here, i.e. do something as:

> 	if (errno == EAFNOSUPPORT)
> 		tst_brkm(TBROK | TERRNO, "socket(%i, %i, %i) not supported",
> 			 domain, type, protocol);

> 	tst_brkm(TBROK | TERRNO, "socket()");
+1


> Btw this code actually duplicates the safe_socket() function we do have
> already, so it may as well be easier to just replace the test_socket()
> with SAFE_SOCKET() in the tests...
I originally wanted to use safe_macros.h in sctputil.h to replace these
test_{bind,connect,listen,socket} with their SAFE_*() variants.

But it leads into dependency many redefinition problems due mixing
<netinet/in.h> and <linux/in.h>, e.g.:

/usr/include/netinet/in.h:68:5: error: redeclaration of enumerator ‘IPPROTO_GRE’
   68 |     IPPROTO_GRE = 47,      /* General Routing Encapsulation.  */
/usr/include/linux/in.h:55:3: note: previous definition of ‘IPPROTO_GRE’ with type ‘enum <anonymous>’
   55 |   IPPROTO_GRE = 47,             /* Cisco GRE tunnels (rfc 1701,1702)    */
      |   ^~~~~~~~~~~
in utils/sctp/func_tests/test_1_to_1_rtoinfo.c, which requires <linux/in.h> for
at least IPPROTO_SCTP which is not in <netinet/in.h>.

IPPROTO_SCTP is also in <linux/sctp.h>, but it also requires <netinet/sctp.h>
for sctp_recvmsg() and it creates another redefinition conflict due using
<netinet/sctp.h> with <linux/sctp.h> => dependency hell :).

FYI test_1_to_1_rtoinfo.c uses test_socket() and sctputil.h.

Sure this is solvable via either using lapi headers which would load only one of
them and with adding extra definitions or simple just adding the missing
definitions into sctputil.h.

But IMHO a cleaner solution is to rewrite test one by one (which would take
time), but we're waiting reply from SCTP maintainers where (and who) is going to
maintain these tests which deserve a massive cleanup...

Thus for now, I'll follow your other suggestions and merge so that we have IPv6
fixes in.

Kind regards,
Petr
