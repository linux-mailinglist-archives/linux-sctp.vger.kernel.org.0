Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E29A011A81
	for <lists+linux-sctp@lfdr.de>; Thu,  2 May 2019 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEBNtE (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 2 May 2019 09:49:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40667 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBNtD (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 2 May 2019 09:49:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id w20so1443049qka.7
        for <linux-sctp@vger.kernel.org>; Thu, 02 May 2019 06:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAWez0+/o/WsyOky0oUwAy3M7l8gOJugqdDRmc+yfRg=;
        b=IJmpPdkasi1Z+ZQthhtdDHyGemguv3KnSAalIwlioPG6MLYfh8VKf9d9Y/sBnrdoAz
         CHBq9L/WenFYBHMBLS5sZqJXJtygUOJsnlnVTjXHpciYkhYo3hQMAn+Aeaxj9v49W2v9
         rc6UfxpAYlkVZDvaAFnTF4ry2HMp1K9oCkMQ469qDablsfhw1rzi5H2d3f56NAAJ9nA7
         2XPhb5iTHvWxeADSvtmT84OdcNlU3k48ECSYf9jB/636GwcKOTxr+M2m6rJfFaZz5ZVC
         1aEVJ8C3b6v6WTiBys3m63JbWRb58DJ9vSW7XhbDziLkgbx1Qsh5RDR7H/RMhigl+8Dm
         oLAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GAWez0+/o/WsyOky0oUwAy3M7l8gOJugqdDRmc+yfRg=;
        b=T/mf6bG+KC9hRVeN5yJj29BSLA28rJuTvusWXD1YQO0lcgRV0APmUmtiCOyof60HhA
         tUHXPe6cANrP28xMh8wUDnzgzWXbKLwNLJ34jmI1eBJ6pzP0WYAAMUUfadoOeSD+ITk1
         ikLhsedfJTgW/jSx2XeXApTJEWl9nxfHblV8SACMGjajOlY3Q3OCcu8O64AEQ3+cms1T
         KM4MnLH/WRZjm/W94hh3zwCeMcDzdgju5LRUZbOXb0BLBNsieFGfTwR6GQbabHeCP0lM
         JPIUN+le7ONzveq+nrvqC7/CmvCRywf8QNtWJH1fEOLD9zD+s/Cwup/ae7x3WB6LVoFv
         i+Yw==
X-Gm-Message-State: APjAAAVyFG44kZ9bEEJszydMh4joa9LkfMISM+Kxx42Cd0k+cKpkPw4D
        JXATzi9pOMuWG0aA0yTQhTQ=
X-Google-Smtp-Source: APXvYqwKZSftesGn4i3otO9QDCPx2OlKJ71KunSpL40eD8jtRQmtNDpE8fLUNBI53YTGBPXPdtI09g==
X-Received: by 2002:a05:620a:129c:: with SMTP id w28mr2834935qki.232.1556804942924;
        Thu, 02 May 2019 06:49:02 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:68ab:38f4:1276:793c:951a])
        by smtp.gmail.com with ESMTPSA id p12sm7440208qta.57.2019.05.02.06.49.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 06:49:02 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id E8F49180CF7; Thu,  2 May 2019 10:48:59 -0300 (-03)
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Marcelo Ricado Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools] travis: add tests for building using a build dir
Date:   Thu,  2 May 2019 10:48:58 -0300
Message-Id: <b2ef8b66e46e4dffe7c47b76a30d9e0631f4203f.1556804896.git.marcelo.leitner@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

In the light of Issue #30.

Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 .travis/linux-build.sh | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/.travis/linux-build.sh b/.travis/linux-build.sh
index c96bd11958816f0625b8ba95df6ec96b2b4124fe..97ce3cd9d003a04b0405151367eb40ce1e50b727 100755
--- a/.travis/linux-build.sh
+++ b/.travis/linux-build.sh
@@ -57,6 +57,8 @@ function download_prep_kernel()
 
 function build_lksctp()
 {
+	local use_builddir="$1"
+
 	make distclean || :
 	./bootstrap
 
@@ -65,12 +67,23 @@ function build_lksctp()
 		CFLAGS="$CFLAGS -I$KERNEL_HEADERS"
 	fi
 	export CFLAGS
-	./configure
+
+	if [ "$use_builddir" == 1 ]; then
+		mkdir build
+		pushd build
+		../configure
+	else
+		./configure
+	fi
 
 	make -j $nproc
 
 	#make -j $nproc distcheck
 
+	if [ "$use_builddir" == 1 ]; then
+		popd
+		rm -rf build
+	fi
 }
 
 trap cleanup EXIT
@@ -80,9 +93,11 @@ if [ -z "$KERNEL" ]; then
 	for ver in $VERS; do
 		git_prep_kernel "$ver"
 		build_lksctp
+		build_lksctp 1
 	done
 else
 	download_kernel "$KERNEL"
 	download_prep_kernel "$KERNEL"
 	build_lksctp
+	build_lksctp 1
 fi
-- 
2.20.1

