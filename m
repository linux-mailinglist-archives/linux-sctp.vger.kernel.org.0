Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC094A82F4
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Feb 2022 12:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiBCLLC (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 3 Feb 2022 06:11:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42050 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiBCLLA (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 3 Feb 2022 06:11:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE18A1F443;
        Thu,  3 Feb 2022 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643886659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CfNXJJ/k3rW6x39C4BI6vvuxKwP1+8Jph9GSsSDDHgY=;
        b=NiUBYLYd4Cuy+5WTzmsRacTRRcfW0cI/qiP/mKtTFx6z/Y7yuzpwkO6aOpfc638NIrxBw4
        pKSzSqL8dWkzGU6AhN5YUDtwdqtl1hqsK7rMLQipbEIZgABqs3V3fbOMLMtAoyCiJuJVHW
        bkeoK1uVPgy/ZLUn56M7BKijo0biD2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643886659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CfNXJJ/k3rW6x39C4BI6vvuxKwP1+8Jph9GSsSDDHgY=;
        b=GeL+NDUzg8QKXoh6sSQzLvELlQE7pjN9tm9K2OM2eTtflDy9Ime6aCY5AoxQz4kV5Zl04H
        bfiN/+kUTTmyVJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C559A1348D;
        Thu,  3 Feb 2022 11:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YvYlMEO4+2HabQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Thu, 03 Feb 2022 11:10:59 +0000
Date:   Thu, 3 Feb 2022 12:12:57 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     Petr Vorel <pvorel@suse.cz>, linux-sctp@vger.kernel.org,
        ltp@lists.linux.it, Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Martin Doucha <martin.doucha@suse.com>
Subject: Re: [RFC] SCTP tests in LTP vs. on github.com/sctp
Message-ID: <Yfu4ucYOvXbOqXYt@yuki>
References: <YfpnVfrto4Elshy5@pevik>
 <Yfp49PCW9Res5gXG@t14s.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfp49PCW9Res5gXG@t14s.localdomain>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi!
> > SCTP tests lksctp-tools [1] are also in LTP [2].
> > IMHO it's not worth to have it on both places.
> 
> Agree. I wasn't aware of the copy in LTP, btw.
> 
> A question I have now is, is getting more exposure because it is in
> LTP? As in, does it get executed periodically by bots somewhere?

Generally I think that not many run the LTP network tests, but it seems
that the intel 0-day has at least a job definition for the LTP sctp
tests:

https://github.com/intel/lkp-tests/blob/3fece75132266f680047f4e1740b39c5b3faabbf/jobs/ltp-stress.yaml

Not sure how often of if they even run it though.

-- 
Cyril Hrubis
chrubis@suse.cz
