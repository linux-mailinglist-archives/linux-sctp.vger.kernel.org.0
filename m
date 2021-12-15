Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656494752F2
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Dec 2021 07:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhLOGYf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 15 Dec 2021 01:24:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:51446 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhLOGYf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 15 Dec 2021 01:24:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0D65212BC;
        Wed, 15 Dec 2021 06:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639549473;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+UsgwAj/Es2kpywdgbIRaddQM/4YOShamve6J8QLgo=;
        b=MfSc+rPJUaSaYwl2OL75O+BrLjXhcekyW6hFlFlJ1yr9/13cYG0r8xWC1qcCcYV860w/+y
        fthnDgXLlWpvBvfeokaWOR+y6frRROxqSyUDQcVpXQ6YVaCy5t32sOgUFMR9wrInn+r4rU
        wu0sXd9sDxSH6cKjRtlkujgge+/ADp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639549473;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s+UsgwAj/Es2kpywdgbIRaddQM/4YOShamve6J8QLgo=;
        b=3hbDzRUZcLwEsBscRrmXrVZuT41kcSafMRWFfikMkkKvSbFXNrH8FeCDwQzzLK6inDbRpE
        YCAQ32vROoTIZQDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 808E813A6B;
        Wed, 15 Dec 2021 06:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1kO4HSGKuWFXCAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 06:24:33 +0000
Date:   Wed, 15 Dec 2021 07:24:31 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Support sha256 as default (SCTP_DEFAULT_COOKIE_HMAC_SHA256)
Message-ID: <YbmKH89Ybwo+jQGt@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <YbcreMQry03v5VmW@pevik>
 <YbgPEqEAB2uqgSaB@t14s.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbgPEqEAB2uqgSaB@t14s.localdomain>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Marcelo,

> Hi,

> On Mon, Dec 13, 2021 at 12:16:08PM +0100, Petr Vorel wrote:
> > Hi all,

> > what is the reason there is no support for sha256 as default
> > (SCTP_DEFAULT_COOKIE_HMAC_SHA256)? sha256 is mentioned in RFC 4895 (2007).

> I'm not aware of any particular reason. Perhaps it just wasn't
> implemented. We're open to patches, btw. ;-)

Thanks for info, I'll have a look into it.

Kind regards,
Petr

>   Marcelo
