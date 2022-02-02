Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DE94A6FFA
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Feb 2022 12:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbiBBL3t (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Feb 2022 06:29:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43146 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239784AbiBBL3s (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Feb 2022 06:29:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC82B1F383;
        Wed,  2 Feb 2022 11:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643801387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/qtQ1vfj3bhRrhP00y3o4XKNTi0PrABt7KP98DImyg=;
        b=of6+gUharJIOlMWgWg/AKSKwn81skymn9sKb+hgIXhVf6KNxpWa5SXa81X4cxR77sSoBXu
        EvDWtX4fLkiaVqftFwKMg/bnyUjMVAzSb5ajSbXiOoIOhuqKZEalh+ydYXncQdrlfbt/IQ
        Ncm45zndQpjD2giW9lyZjE75uMd+0z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643801387;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/qtQ1vfj3bhRrhP00y3o4XKNTi0PrABt7KP98DImyg=;
        b=GXaxI4xxZu8Vqnw0CbwTn7ow6RcrwKyFZ6s2Wx9dfs5zoa4KTHiW1c5iN1U/nkbNgdXE0k
        JOofnJm92bXicnCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B8FF13DFF;
        Wed,  2 Feb 2022 11:29:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BfwGFypr+mFgBwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 11:29:46 +0000
Date:   Wed, 2 Feb 2022 12:29:33 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-sctp@vger.kernel.org, ltp@lists.linux.it,
        Cyril Hrubis <chrubis@suse.cz>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Martin Doucha <martin.doucha@suse.com>
Subject: Re: [RFC] SCTP tests in LTP vs. on github.com/sctp
Message-ID: <YfprHQcxAnsb1RI/@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YfpnVfrto4Elshy5@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfpnVfrto4Elshy5@pevik>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

FYI we've been thinking about back in 2013.
https://lore.kernel.org/ltp/20130805121135.GB8739@rei/

I'd personally prefer sctp folks maintain them and we removed them from LTP.

Kind regards,
Petr
