Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8272F572
	for <lists+linux-sctp@lfdr.de>; Wed, 14 Jun 2023 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbjFNHFy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 14 Jun 2023 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbjFNHF2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 14 Jun 2023 03:05:28 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C31FD7
        for <linux-sctp@vger.kernel.org>; Wed, 14 Jun 2023 00:05:03 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77b210292c5so82701939f.1
        for <linux-sctp@vger.kernel.org>; Wed, 14 Jun 2023 00:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rmuti.ac.th; s=dkim; t=1686726303; x=1689318303;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up2eIalEPJnVHBT4m9NMNp4RM0R+bEuvowOLz20NAF4=;
        b=XYd2YWgWZ8ksNFKxXsW8IcKuwgBsXdc/DMPQVNtLo6rk7wiEMwjjtasqk5aw+MGjiH
         3QflKAeI9Pt1A88FA8OpQX6Dxy4lEBiwF7gVzKAtEWuqhrFGWERXv1eE8Rm3pLmjZX1t
         jcxu72thFG/SSoo3gDlpAJ9z5LTQMP3TpvE10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686726303; x=1689318303;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up2eIalEPJnVHBT4m9NMNp4RM0R+bEuvowOLz20NAF4=;
        b=LhTQvLxeXkEsJIgF4vO3XBlSwEaAPnUZbTKtqLZ7OCjAeZ3UPBtd1LCbji0zNWlbFL
         q3Nptt9bHx9ghjONMge1bGIdOUU4bvsu7iddZ/782yE+j76X1WOrp4F7MuD8FsBe5RRl
         qCtVo47zFpx0twiJuusJDJjnvnp1GwS/Q6zWU+JDaunExPbQXCf7Woiq8yP7fmHGTQeK
         22FzRtwHKN6e2Qg17fULVCynBu02Yq3TNowUl2MqDfFkyQfFfmrPTdyGfn2WREbYrkJp
         gEj7dCzOhaqT41Oc3kgVnhMXEdcKGxGy3FDMINYf21N7qfd3lVcUMHjwvcEhvkb/4MXJ
         qbrQ==
X-Gm-Message-State: AC+VfDzjkBGsUJt3FLQvqwzDEZsF8Upo/Of9Eu1tgqP+ShaTyYQy1c5M
        zhw6Dl1tarivoMvJQ6bDhxSOF6S1/0gy4iWh986cuw==
X-Google-Smtp-Source: ACHHUZ4VXsxJrvfuzcpGRICRgZvKFCweIR3Ry7nKbDcWXqqjN6pdKdHXHdLbxtl8jJ6D05965u+3FM3GNdW9CzwITX0=
X-Received: by 2002:a5e:dc45:0:b0:778:65fb:5e25 with SMTP id
 s5-20020a5edc45000000b0077865fb5e25mr12044059iop.4.1686726302936; Wed, 14 Jun
 2023 00:05:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:1504:b0:420:bd39:e2b0 with HTTP; Wed, 14 Jun 2023
 00:05:02 -0700 (PDT)
Reply-To: konnia4loveth@gmail.com
From:   "Mrs.Loveth Konnia" <khanisabodee.pa@rmuti.ac.th>
Date:   Wed, 14 Jun 2023 07:05:02 +0000
Message-ID: <CAF4ig4GAACRwKgGBDZ8hvqWTeT4QAD84uaBYM2yewBm3MTO6rA@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        HK_NAME_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URIBL_DBL_SPAM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: rmuti.ac.th]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  2.5 URIBL_DBL_SPAM Contains a spam URL listed in the Spamhaus DBL
        *      blocklist
        *      [URIs: rmuti.ac.th]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 HK_NAME_MR_MRS No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Zweimal habe ich Ihnen eine E-Mail geschickt, auf die Sie nicht
geantwortet haben. Finden Sie jetzt Zeit, mir zu antworten?
...............................................
On two occasions, I have sent an email to you which you have not
responded to.Can you find time to respond to me now?
