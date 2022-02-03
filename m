Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9C4A8A9C
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Feb 2022 18:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239986AbiBCRsj (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 3 Feb 2022 12:48:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:48842 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiBCRsi (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 3 Feb 2022 12:48:38 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E68CB21123;
        Thu,  3 Feb 2022 17:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643910517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4evBO+POjQzamNc4DHb8Bx/EMzfDWMdsaLbNmOWVCa0=;
        b=sS5h+fqayr9QJBnAV9sYn/AtXlxnjyEy2lVAShVgNmoPDPeLECJa9QcDjd2aKnsW7hGX1O
        8VokbGeSjNX8FeitrahWGjzplq6rB8emKl9pMpxD+5OfBVsdDbDn5N+vBjH9pqkUt5+n+X
        FJ6inRnHaALIP9dxoCndYZ/GwaDU3SY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643910517;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type;
        bh=4evBO+POjQzamNc4DHb8Bx/EMzfDWMdsaLbNmOWVCa0=;
        b=DJHNapkDoLtoeSVafMudNSqU3g8JEDtx4aacYoHeQgNDswhxFxqi0gN9xI5ugY2b3EoBP8
        bVP3Syxe73c4AiBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0568513671;
        Thu,  3 Feb 2022 17:48:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nSj0OnQV/GEbTAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 17:48:36 +0000
Date:   Thu, 3 Feb 2022 18:48:35 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     automated-testing@lists.yoctoproject.org
Cc:     ltp@lists.linux.it, linux-sctp@vger.kernel.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Philip Li <philip.li@intel.com>, Tim Bird <tim.bird@sony.com>,
        Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>,
        Jan Stancek <jstancek@redhat.com>,
        Baruch Siach <baruch@tkos.co.il>,
        Erico Nunes <nunes.erico@gmail.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>
Subject: SCTP testing
Message-ID: <YfwVcwpZU/lusVlC@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi all,

we've been just discussing, which repository should be hosting SCTP tests [1].

Do you use these SCTP tests? If yes, do you use it from LTP [2] or the official
SCTP kernel developers repository [3] ? If you use integrated to some testing
framework, would it be a problem if repository changes?

Also, do you use LTP network tests at all?

Kind regards,
Petr

[1] https://lore.kernel.org/linux-sctp/YfpnVfrto4Elshy5@pevik/
[2] https://github.com/linux-test-project/ltp/tree/master/utils/sctp
[3] https://github.com/sctp/lksctp-tools
