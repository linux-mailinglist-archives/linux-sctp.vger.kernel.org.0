Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A10974A8937
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Feb 2022 18:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352480AbiBCRFb (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 3 Feb 2022 12:05:31 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:45470 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiBCRFa (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 3 Feb 2022 12:05:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C2B9B21136;
        Thu,  3 Feb 2022 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643907929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmwCsdBv/AML/Mizfmf+cemZwHHLJYFn6YdmLGAWTTE=;
        b=PPloPfvX6k4T7MSuiYcEIWQZc4mcc4m4wQLtyNSgzDbh/xGGxOz0sQFagZmpF2nUT2FbTX
        f+/CHesHkW2yjAnN4ZXknJKKOtTee8wRYKmOHo6oIaljRRndX81cnakKFQo/ruGHb1NV/u
        qPSI/TNTzhma+FCWMyOYFJr7l9ytGfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643907929;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fmwCsdBv/AML/Mizfmf+cemZwHHLJYFn6YdmLGAWTTE=;
        b=qRLPtIVmMLrthqFEKmutnwWArPOj7k03Lv/o+e8WA9rJ8RYfHrP5CYkiSNU3fiZZzM8sKH
        BrTbM2a9Ob3EInBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 783E313A07;
        Thu,  3 Feb 2022 17:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6By8G1kL/GEJOAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 17:05:29 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Cyril Hrubis <chrubis@suse.cz>, linux-sctp@vger.kernel.org
Subject: [PATCH 2/2] sctputil.h: TCONF on EAFNOSUPPORT
Date:   Thu,  3 Feb 2022 18:05:22 +0100
Message-Id: <20220203170522.22051-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220203170522.22051-1-pvorel@suse.cz>
References: <20220203170522.22051-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

That's returned on systems without IPv6 support
(e.g. boot with ipv6.disable=1).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 utils/sctp/testlib/sctputil.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/utils/sctp/testlib/sctputil.h b/utils/sctp/testlib/sctputil.h
index 1e21760bec..c4bedb47cf 100644
--- a/utils/sctp/testlib/sctputil.h
+++ b/utils/sctp/testlib/sctputil.h
@@ -133,9 +133,14 @@ extern int TST_CNT;
 static inline int test_socket(int domain, int type, int protocol)
 {
 	int sk = socket(domain, type, protocol);
+	int res = TBROK;
 
-	if (sk == -1)
-		tst_brkm(TBROK, tst_exit, "socket: %s", strerror(errno));
+	if (sk == -1) {
+		if (errno == EAFNOSUPPORT)
+			res = TCONF;
+
+		tst_brkm(res, tst_exit, "socket: %s", strerror(errno));
+	}
 
 	return sk;
 }
-- 
2.35.1

