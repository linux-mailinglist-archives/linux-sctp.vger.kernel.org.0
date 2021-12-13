Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8962E472B01
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Dec 2021 12:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhLMLQM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 13 Dec 2021 06:16:12 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58728 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhLMLQL (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 13 Dec 2021 06:16:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB8C91F3BA;
        Mon, 13 Dec 2021 11:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639394170;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YVG87+toS4WkYUR8w7Un3Xqo5fupEpTpk1WOrMpwIv0=;
        b=I8eHm5ARHNuhVu2jczljV4AQmRz77XTGGPl5MFci4WE/DMepw5taMVCXs7fZ/PpvE7uesL
        5D57rUKoqaimuOM0F76r8goyoBFogEV848Ji2fOTQjo1D/u4u+ZagOTCy6Snh9TUjddPbh
        +oX0jvkbBmDPpKneqheDfVMJL8LsL+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639394170;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YVG87+toS4WkYUR8w7Un3Xqo5fupEpTpk1WOrMpwIv0=;
        b=0N5yt+LnvYfYSzQbvV2tQ/sVNkNpvQJBredlxssTyEUFdyRi1OZzTgP7GhWunUDhUiK4Hh
        +wAu9tYw4FQDvqDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7680113AFF;
        Mon, 13 Dec 2021 11:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l6ZtG3ort2EBVAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 13 Dec 2021 11:16:10 +0000
Date:   Mon, 13 Dec 2021 12:16:08 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-sctp@vger.kernel.org
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Support sha256 as default (SCTP_DEFAULT_COOKIE_HMAC_SHA256)
Message-ID: <YbcreMQry03v5VmW@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi all,

what is the reason there is no support for sha256 as default
(SCTP_DEFAULT_COOKIE_HMAC_SHA256)? sha256 is mentioned in RFC 4895 (2007).

Thanks for info.

Kind regards,
Petr
