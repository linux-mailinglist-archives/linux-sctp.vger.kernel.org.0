Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3A4A8938
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Feb 2022 18:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352481AbiBCRFa (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 3 Feb 2022 12:05:30 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56508 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBCRF3 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 3 Feb 2022 12:05:29 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB1D11F3AF;
        Thu,  3 Feb 2022 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643907928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=d7gVBUhdV9vSi1hHDARmL1+gAtLmoGKp5TL9ff04ul8=;
        b=Ph0m1m/dOfaZVkt8oDE4i9bOiaqVkgohqIldS9xOvy5nJuh92eAFA4a9uz8nKrHAht7slX
        xRmaBP3QZRRlEQcCDHqxAwxY5bwv6iJ8xEcOqjo1TE3PEbQRhIHjEvABhk5b+twL07ObcK
        Y1HB6NpeZeKFMjKer5iEBaxo3IZEdMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643907928;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=d7gVBUhdV9vSi1hHDARmL1+gAtLmoGKp5TL9ff04ul8=;
        b=SKONZNtAUUl16djZYzFtp8/9AR10qXevV+HaMNQALlRJdcdAQA2eu1IRZVZTO7MP4T2TFR
        IiN+Qrp1hK/gYwBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 98CE013A07;
        Thu,  3 Feb 2022 17:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xN7yIlgL/GEJOAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 17:05:28 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Cyril Hrubis <chrubis@suse.cz>, linux-sctp@vger.kernel.org
Subject: [PATCH 0/2] Fix SCTP tests on systems with disabled IPv6
Date:   Thu,  3 Feb 2022 18:05:20 +0100
Message-Id: <20220203170522.22051-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

this is needed for systems which boot with ipv6.disable=1.
Although we have some discussion what should be the primary repository [1],
I'd like to get this fixed in LTP sooner than later.

I could not stop myself to fix little bit of broken formatting (first
commit), but I can drop it, if that's easier for backporting to the
other repository.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-sctp/Yfu4ucYOvXbOqXYt@yuki/T/#md06d317a4200592ed5c3a47ff30884a224c503c9

Petr Vorel (2):
  sctputil.h: Fix some formatting
  sctputil.h: TCONF on EAFNOSUPPORT

 utils/sctp/testlib/sctputil.h | 105 ++++++++++++++++++++++++----------
 1 file changed, 74 insertions(+), 31 deletions(-)

-- 
2.35.1

