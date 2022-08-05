Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31AA58AD4F
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Aug 2022 17:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbiHEPqH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 5 Aug 2022 11:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238726AbiHEPpf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 5 Aug 2022 11:45:35 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F370E56
        for <linux-sctp@vger.kernel.org>; Fri,  5 Aug 2022 08:44:06 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a15so2282199qto.10
        for <linux-sctp@vger.kernel.org>; Fri, 05 Aug 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=LQ+gxjENaVia79r433KzJOJIIEVQETXTGQp0LXf1AFE=;
        b=pJCuygdozrbK0pAL82OU9kRmdZwDWsfvwmdc1PGp/0lg8fXt6qFTzTYbHlJJO0TCA0
         TiCMCPQtchFARZEZ0QWpDXmOmcReBgbPJyT3e6IlAyKbk62wxweNQ5cCq/Mi6pB418QZ
         OROzclOA0tE6a7WjTR7r0ZcWj3lDRAaLv070Jwv00jP/31FFwf2HnoAvvklaNhT5T9JR
         RCwk5lyxvcrx67AK1MY9IouRe0EW1s2xUn4FAzRM4HjccvC9O9Vd+zMiGf0/cHe+rgRW
         1McgmYAc4sTNhi/ZeFrK9MF/zdSrY/cbdCowV4cbKlu8Su6evJNmVOvsOwiR53+Jp7EA
         yO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=LQ+gxjENaVia79r433KzJOJIIEVQETXTGQp0LXf1AFE=;
        b=ib9O84ciu8yq/SBBY7LISQuGIRIdYOyu21XMcw3lQe5Aqh0NWVFGLxl+CrphuF9xnN
         5Fzbz9WjFXgNhw87mqj5epiEgZXRo7xd5gEMSO93l6dtOCftPj7qOaeNZ8rBQd8A/1pT
         xy2DY3Dl0DYyWOWpXb4MEhcS+3X/ghfIx/qkLlw4vitro4nf7T7iC5zOdLXgww1uURH+
         gd+0dSdtiRxxykcpa3axrQaz/xz+q9OEYNwN+PL8byh4CHWcsPDGqow3IFXO2BcIh61K
         zd5Ovi6TYYIONe8lIuHltCqRFkCnlXpc/JYMpC4m6Zu0dCVudCp79UG5DkTNaSdQfOhN
         fhOA==
X-Gm-Message-State: ACgBeo31HkDd4+3dJopo2/YTiDDUq+v+T0H4Pn1xUFl4pAss/KSPcx4b
        uPBcY0VzmwpsdQhNvgr8aJ21x3+oXBhoWA==
X-Google-Smtp-Source: AA6agR4EEC+OFjhr9lF5JEKUWrThceLtW1bXXBrUltIxlt5VSdNPQiDFAT2Lm0gWO0c/NIFA0EOvew==
X-Received: by 2002:ac8:5b87:0:b0:340:311e:a194 with SMTP id a7-20020ac85b87000000b00340311ea194mr6450259qta.461.1659714245801;
        Fri, 05 Aug 2022 08:44:05 -0700 (PDT)
Received: from cache-fedora.hsd1.nj.comcast.net ([2601:86:200:98b0::c166])
        by smtp.gmail.com with ESMTPSA id x9-20020ac81209000000b0031ef21aec36sm2809153qti.32.2022.08.05.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 08:44:05 -0700 (PDT)
From:   Yuxuan Luo <luoyuxuan.carl@gmail.com>
To:     linux-sctp@vger.kernel.org
Cc:     marcelo.leitner@gmail.com, lucien.xin@gmail.com, yuluo@redhat.com,
        Yuxuan Luo <luoyuxuan.carl@gmail.com>
Subject: [PATCH lksctp-tools 0/2] func_tests: Add test cases for interleaving and stream RE_CONFIG 
Date:   Fri,  5 Aug 2022 11:43:50 -0400
Message-Id: <20220805154351.27646-1-luoyuxuan.carl@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Add two test cases for verifying the support
for interleaving and re_config recently implemented in kernel.

Signed-off-by: Yuxuan Luo <luoyuxuan.carl@gmail.com>

Yuxuan Luo (2):
  Add a test case for interleaving
  Add a test cacse for RE_CONFIG

 configure.ac                     |   3 +
 src/func_tests/.gitignore        |   4 +
 src/func_tests/Makefile.am       |  20 +++
 src/func_tests/test_interleave.c | 254 +++++++++++++++++++++++++++++++
 src/func_tests/test_re_conf.c    | 251 ++++++++++++++++++++++++++++++
 5 files changed, 532 insertions(+)
 create mode 100644 src/func_tests/test_interleave.c
 create mode 100644 src/func_tests/test_re_conf.c

-- 
2.37.1

