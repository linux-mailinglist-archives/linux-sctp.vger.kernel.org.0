Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C29355727
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Apr 2021 17:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345377AbhDFPBu (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Apr 2021 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345378AbhDFPBu (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 6 Apr 2021 11:01:50 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C79C06174A
        for <linux-sctp@vger.kernel.org>; Tue,  6 Apr 2021 08:01:40 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id u3so5129194qvj.8
        for <linux-sctp@vger.kernel.org>; Tue, 06 Apr 2021 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZMTpLi2/SiCTeBOzBOALnsPtMGQXTMmMiGGOCyCZWA=;
        b=As/4VntRTlXNm4jf3UALDME+T3Jez0cN1cTRsp8bYggxji8nj6oIYzXdVSVxTyFOV3
         ZbevrlFBPpHmpdmwT3KF0QP813/AwVF+vLvJEUAhVDTwG5nVe1bNplJD0Qt/D0pcdPdp
         SeBXSOzeMe3AbnmbPVjzWZ8pP/m1CzFbjFLUzb7W/5h6r4rk965u1Cwc7QhTT2DJr3w5
         nXb6Bo9ocYUrgKYDD9p081Ln+WNtzAhWrBxjR3vWtewV0nrCUwtKrZjDQJMEZE+SFNGZ
         QXkKSavgUVX0qU4qZlGTozFD+BFxlO4bQi3TLpATqcG/JEAxrN9dzUaJWImwbpW11SV1
         2y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZMTpLi2/SiCTeBOzBOALnsPtMGQXTMmMiGGOCyCZWA=;
        b=ldD65qdOjSLdp/UTD68riH7suM1mewSVv4qn0SDzHBJVC0ps0bnM71unKh9qvA4/LS
         z3b8EkoNnjdboU+DIWnbTjrOUr0yjN2Hrmhi5LovUsjNVQtXBL4Avfwvd/y+QYNwga8T
         MLc/YD/7OMpKPWHU1Ts8cJEDMF/YvTymOkFD5pcUosicv1dU+oLIjuQAomwNSgoAiMLF
         IsFXSiGLx1Qrs2tUioHReBCzE9kVi6Vp+2+tLHyjpp5aconFsEw9PXlWkwY7WJLPAfBQ
         FH3UgdFDQB2v/FZaMlo6TccShEZ6crqJ9DDQVtAq9A39mBCl/bVOtcOrpQhKk37WdGU/
         PryA==
X-Gm-Message-State: AOAM532JQ91JJrHGU7TeubVjly9lhjGwTEN7uO0nliU4CReKMVrmQR15
        fgGNwZWtZ+vD6Ekat1mDdMJuUEn7J57A4A==
X-Google-Smtp-Source: ABdhPJwngDoaTk1z7beUMVzQ297kildl6UL2eJzvBSTna9qXtdK0ZLnnSBJfSmPt8ulSJl89d9ontA==
X-Received: by 2002:a0c:908d:: with SMTP id p13mr29562564qvp.11.1617721298566;
        Tue, 06 Apr 2021 08:01:38 -0700 (PDT)
Received: from horizon.localdomain ([177.220.172.98])
        by smtp.gmail.com with ESMTPSA id b9sm13991058qtx.38.2021.04.06.08.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 08:01:38 -0700 (PDT)
Received: by horizon.localdomain (Postfix, from userid 1000)
        id 9DCA9C0D87; Tue,  6 Apr 2021 12:01:35 -0300 (-03)
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH lksctp-tools] func_tests: fix malloc size in test_1_to_1_connectx.c
Date:   Tue,  6 Apr 2021 12:01:23 -0300
Message-Id: <ce238aa27d414e3a6f857491d789dbfe2f1f912f.1617721194.git.marcelo.leitner@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Recent gcc started tracking this and now it's warning:
test_1_to_1_connectx.c: In function ‘main’:
test_1_to_1_connectx.c:133:17: warning: array subscript ‘struct sockaddr[0]’ is partly outside array bounds of ‘unsigned char[15]’ [-Warray-bounds]
  133 |         tmp_addr->sa_family = AF_INET;
      |                 ^~
test_1_to_1_connectx.c:132:40: note: referencing an object of size 15 allocated by ‘malloc’
  132 |         tmp_addr = (struct sockaddr *) malloc(sizeof(struct sockaddr) - 1);
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

It gets parsed by __connectx_addrsize using each family struct, but they
aligned to sockaddr size. So lets fix it here by allocating the right
size.

Signed-off-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
---
 src/func_tests/test_1_to_1_connectx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/func_tests/test_1_to_1_connectx.c b/src/func_tests/test_1_to_1_connectx.c
index 3cb18b3aad421720e8598e9a0bbab2de987d4467..9adab2352c09d0fb0087e4c4b43c6d7d7b60de0d 100644
--- a/src/func_tests/test_1_to_1_connectx.c
+++ b/src/func_tests/test_1_to_1_connectx.c
@@ -129,7 +129,7 @@ main(int argc, char *argv[])
 	tst_resm(TPASS, "sctp_connectx() with invalid socket - ENOTSOCK");
 
 	/*sctp_connectx () TEST3: Invalid address, EINVAL Expected error*/
-	tmp_addr = (struct sockaddr *) malloc(sizeof(struct sockaddr) - 1);
+	tmp_addr = (struct sockaddr *) malloc(sizeof(struct sockaddr));
 	tmp_addr->sa_family = AF_INET;
 	error = sctp_connectx(sk, tmp_addr, 1, NULL);
 	if (error != -1 || errno != EINVAL)
-- 
2.30.2

