Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C9247E990
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Dec 2021 23:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhLWWtQ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 23 Dec 2021 17:49:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34730 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbhLWWtQ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 23 Dec 2021 17:49:16 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78D2D210E0;
        Thu, 23 Dec 2021 22:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1640299755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wbmGWyeEVNIS/ME+UQ/afuNXoUDG8JZI1rGewRKA1SA=;
        b=dU4vcy/VpP6s+hkvgzpyz7emfay2mHajPcszmovkldX1yI8DWhlt80WYYN775fC0+KpFfb
        HaTO2rqCoXd6etNhD7xWsaL7THHtjSGa8d0Mo+LmhdPpOHOl3THTVg2d8I2yU3FlnITGrk
        gzZ+Z8AqwQxI2qT++QlM2FFnVmfLGIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1640299755;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=wbmGWyeEVNIS/ME+UQ/afuNXoUDG8JZI1rGewRKA1SA=;
        b=mcMC+W3BaSecXpY6+F2MstvJNSxiJWf6X9q7xGelCP5kP3AsF6I8tFoNOfnsV0ek31SgTG
        ZMnajzAHGg9HiECw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E16113E6D;
        Thu, 23 Dec 2021 22:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +o2CDev8xGF2HgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 23 Dec 2021 22:49:15 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-sctp@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 1/1] sctp: Add optional SHA256 hmac cookie generation
Date:   Thu, 23 Dec 2021 23:49:11 +0100
Message-Id: <20211223224911.9542-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

WARNING: While I tested this with LTP SCTP and IPsec over SCTP tests,
it'd be good to review carefully.

Also this may not be that useful given that CRYPTO_SHA256 will be most
likely enabled due being selected by ENCRYPTED_KEYS [=y] && KEYS [=y]
or BT [=m] && NET [=y] && !S390 && (RFKILL [=m] || !RFKILL [=m]).

Kind regards,
Petr

 net/sctp/Kconfig    | 13 +++++++++++++
 net/sctp/protocol.c |  2 ++
 net/sctp/sysctl.c   |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 5da599ff84a9..0f508d0b1864 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -68,6 +68,12 @@ config SCTP_DEFAULT_COOKIE_HMAC_SHA1
 	  Enable optional SHA1 hmac based SCTP cookie generation
 	select SCTP_COOKIE_HMAC_SHA1
 
+config SCTP_DEFAULT_COOKIE_HMAC_SHA256
+	bool "Enable optional SHA256 hmac cookie generation"
+	help
+	  Enable optional SHA256 hmac based SCTP cookie generation
+	select SCTP_COOKIE_HMAC_SHA256
+
 config SCTP_DEFAULT_COOKIE_HMAC_NONE
 	bool "Use no hmac alg in SCTP cookie generation"
 	help
@@ -89,6 +95,13 @@ config SCTP_COOKIE_HMAC_SHA1
 	select CRYPTO_HMAC if SCTP_COOKIE_HMAC_SHA1
 	select CRYPTO_SHA1 if SCTP_COOKIE_HMAC_SHA1
 
+config SCTP_COOKIE_HMAC_SHA256
+	bool "Enable optional SHA256 hmac cookie generation"
+	help
+	  Enable optional SHA256 hmac based SCTP cookie generation
+	select CRYPTO_HMAC if SCTP_COOKIE_HMAC_SHA256
+	select CRYPTO_SHA256 if SCTP_COOKIE_HMAC_SHA256
+
 config INET_SCTP_DIAG
 	depends on INET_DIAG
 	def_tristate INET_DIAG
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 35928fefae33..3a0b76e26878 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1317,6 +1317,8 @@ static int __net_init sctp_defaults_init(struct net *net)
 	net->sctp.sctp_hmac_alg			= "md5";
 #elif defined (CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1)
 	net->sctp.sctp_hmac_alg			= "sha1";
+#elif defined (CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA256)
+	net->sctp.sctp_hmac_alg			= "sha256";
 #else
 	net->sctp.sctp_hmac_alg			= NULL;
 #endif
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index b46a416787ec..05bfc66effeb 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -400,6 +400,12 @@ static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
 			net->sctp.sctp_hmac_alg = "sha1";
 			changed = true;
 		}
+#endif
+#ifdef CONFIG_CRYPTO_SHA256
+		if (!strncmp(tmp, "sha256", 6)) {
+			net->sctp.sctp_hmac_alg = "sha256";
+			changed = true;
+		}
 #endif
 		if (!strncmp(tmp, "none", 4)) {
 			net->sctp.sctp_hmac_alg = NULL;
-- 
2.34.1

