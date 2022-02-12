Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E454B36E2
	for <lists+linux-sctp@lfdr.de>; Sat, 12 Feb 2022 18:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbiBLR7e (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sat, 12 Feb 2022 12:59:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiBLR7d (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sat, 12 Feb 2022 12:59:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9D7A2FFEA
        for <linux-sctp@vger.kernel.org>; Sat, 12 Feb 2022 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644688768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=WvDQx/YlpbeiDDYelHT2SHMuzpCfQD74ETqwLNGiv58=;
        b=YPpi8iIfVDSfV8K0ShoW3xK1N8I4PAHNEnH4SLfOpkitIt+u7NcBkj3SJZLchol7T6knsF
        jAsaW8jWg7tTF2XQpdS6d5pSFtJbMEUyiMBLYADJ+jFfbdY9NDmoSR/RsFhNpJDXRzCQ3G
        4pgV/p2rz/2QtwiYJZgvRZE32b8wsLA=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-387-RbkDCdBVPOy2iaguq8856Q-1; Sat, 12 Feb 2022 12:59:26 -0500
X-MC-Unique: RbkDCdBVPOy2iaguq8856Q-1
Received: by mail-ed1-f69.google.com with SMTP id z21-20020a05640235d500b0041092b29ad6so1205058edc.19
        for <linux-sctp@vger.kernel.org>; Sat, 12 Feb 2022 09:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WvDQx/YlpbeiDDYelHT2SHMuzpCfQD74ETqwLNGiv58=;
        b=hh3FgstMgAKUMlElpCJs0k7o0DtwpQRQGeSvcGjitqssacoJwdkxwFVTW0C5ZbODVT
         xqiHTYu9/dEI5A8K1QPYfiHWBPI93R3oMxLlUz+O6wE4WuuBA/fLHU39FfrKt0nd941+
         pl0t6WNrheHtCv6JWOU7St9nUAOQTpyCyYAlniK4huewtrUsJJxtkz206BbsvetJraDq
         kH2kTRrS+6uV4dAZ5wFWIL04i0HOeDLLd2ooOl0vq5xSgf2VTd4PtYZa0/b+Xl/zUq5Q
         poxgTvWfpoP4bGgmpKA+9ChpfUW6yiOhbsEKloGdj9SdU1gtsuMcP2duMcBwRkofkmHL
         R4mQ==
X-Gm-Message-State: AOAM533a40Z93nyvlxgMca75tu+gzSzmJanJ0ZQUcidp25ftHt0z+PqA
        VSPuoxQ6gBW75u0Nb7V58XHEoxJnt5awRut5eHG4VMHeQO4gltIN7WQBSW7v/OpAlkA4RDZT5BY
        YuK9st3lk+0BvfTW7RC9KNw==
X-Received: by 2002:a17:907:a088:: with SMTP id hu8mr5494125ejc.281.1644688764820;
        Sat, 12 Feb 2022 09:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpCLnkWipDo+gFAaDaKcNOlElyuo5FfhyBrRsys1CHR6MQDWnLUVKo21UiNITagZ4ZP8k9xg==
X-Received: by 2002:a17:907:a088:: with SMTP id hu8mr5494102ejc.281.1644688764546;
        Sat, 12 Feb 2022 09:59:24 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id d10sm437409ejo.207.2022.02.12.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 09:59:23 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Xin Long <lucien.xin@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/2] security: fixups for the security hooks in sctp
Date:   Sat, 12 Feb 2022 18:59:20 +0100
Message-Id: <20220212175922.665442-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This is a third round of patches to fix the SCTP-SELinux interaction
w.r.t. client-side peeloff. The patches are a modified version of Xin
Long's patches posted previously, of which only a part was merged (the
rest was merged for a while, but was later reverted):
https://lore.kernel.org/selinux/cover.1635854268.git.lucien.xin@gmail.com/T/

In gist, these patches replace the call to
security_inet_conn_established() in SCTP with a new hook
security_sctp_assoc_established() and implement the new hook in SELinux
so that the client-side association labels are set correctly (which
matters in case the association eventually gets peeled off into a
separate socket).

Note that other LSMs than SELinux don't implement the SCTP hooks nor
inet_conn_established, so they shouldn't be affected by any of these
changes.

These patches were tested by selinux-testsuite [1] with an additional
patch [2] and by lksctp-tools func_tests [3].

Changes since v2:
- patches 1 and 2 dropped as they are already in mainline (not reverted)
- in patch 3, the return value of security_sctp_assoc_established() is
  changed to int, the call is moved earlier in the function, and if the
  hook returns an error value, the packet will now be discarded,
  aborting the association
- patch 4 has been changed a lot - please see the patch description for
  details on how the hook is now implemented and why

[1] https://github.com/SELinuxProject/selinux-testsuite/
[2] https://patchwork.kernel.org/project/selinux/patch/20211021144543.740762-1-omosnace@redhat.com/
[3] https://github.com/sctp/lksctp-tools/tree/master/src/func_tests

Ondrej Mosnacek (2):
  security: add sctp_assoc_established hook
  security: implement sctp_assoc_established hook in selinux

 Documentation/security/SCTP.rst | 22 ++++----
 include/linux/lsm_hook_defs.h   |  2 +
 include/linux/lsm_hooks.h       |  5 ++
 include/linux/security.h        |  8 +++
 net/sctp/sm_statefuns.c         |  8 +--
 security/security.c             |  7 +++
 security/selinux/hooks.c        | 90 ++++++++++++++++++++++++---------
 7 files changed, 103 insertions(+), 39 deletions(-)

-- 
2.34.1

