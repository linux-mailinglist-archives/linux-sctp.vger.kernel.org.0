Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC13784E9E
	for <lists+linux-sctp@lfdr.de>; Wed, 23 Aug 2023 04:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjHWCSN (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 22 Aug 2023 22:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjHWCSM (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 22 Aug 2023 22:18:12 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 19:18:10 PDT
Received: from symantec4.comsats.net.pk (symantec4.comsats.net.pk [203.124.41.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F16185
        for <linux-sctp@vger.kernel.org>; Tue, 22 Aug 2023 19:18:10 -0700 (PDT)
X-AuditID: cb7c291e-055ff70000002aeb-c6-64e553f3f1a7
Received: from iesco.comsatshosting.com (iesco.comsatshosting.com [210.56.28.11])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by symantec4.comsats.net.pk (Symantec Messaging Gateway) with SMTP id 97.72.10987.3F355E46; Wed, 23 Aug 2023 05:33:55 +0500 (PKT)
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=iesco.com.pk; s=default;
        h=received:content-type:mime-version:content-transfer-encoding
          :content-description:subject:to:from:date:reply-to;
        b=VRJSZzZvPoRUsdURvzldA6JRmu14jK9Kmhy2p88Xf8YubICbWy/xW/MrM8Sn5gkdf
          8Q48x+03pLu3oJamABdTRqQ1X/ZPntau6BOBjoXOGc3G2MDIo2HfkzsiTaxAmVxUa
          98b7LkbxHtYLLhNnXrTtbQbx2kpGg54mRY46Lk/Ac=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iesco.com.pk; s=default;
        h=reply-to:date:from:to:subject:content-description
          :content-transfer-encoding:mime-version:content-type;
        bh=GMzYzcyTxDsE6wX/XHG6MHqAdAiHrhqbmmLQ/TZ1QnQ=;
        b=RNK2GzzYzdFQKxiijIUb8QJ4vW/2P8flgrfGxaNEYz9uEV1cY9OrPNZ8DsiUiwMlz
          T4riV75kV9lxKy14uTMhDkedqTq7aypwh2qrUE12FiUuk7kLNbsdphcTCSxicxPxJ
          V9ok/wNFGgjNVWggkYPWFL8ePEBEczSA2jp15aK90=
Received: from [94.156.6.90] (UnknownHost [94.156.6.90]) by iesco.comsatshosting.com with SMTP;
   Wed, 23 Aug 2023 04:31:07 +0500
Message-ID: <97.72.10987.3F355E46@symantec4.comsats.net.pk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Re; Interest,
To:     linux-sctp@vger.kernel.org
From:   "Chen Yun" <pso.chairmanbod@iesco.com.pk>
Date:   Tue, 22 Aug 2023 16:31:21 -0700
Reply-To: chnyne@gmail.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsVyyUKGW/dz8NMUg3VfRS2eLnjN6sDo8XmT
        XABjFJdNSmpOZllqkb5dAlfGknUXWAp2M1e09S9iaWB8zNTFyMkhIWAicWtjJ3sXIxeHkMAe
        JolLTRvAHBaB1cwSCxd+ZINwHjJLfFyznR2kRUigmVHi0BFNEJtXwFri3omnYHFmAT2JG1On
        sEHEBSVOznzCAhHXlli28DVzFyMHkK0m8bWrBCQsLCAm8WnaMrBWEQE5id2/LjOC2GwC+hIr
        vjaD2SwCqhIzlk6CWislsfHKerYJjPyzkGybhWTbLCTbZiFsW8DIsopRorgyNxEYaskmesn5
        ucWJJcV6eaklegXZmxiBYXi6RlNuB+PSS4mHGAU4GJV4eH+ue5IixJpYBtR1iFGCg1lJhFf6
        +8MUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry2Qs+ShQTSE0tSs1NTC1KLYLJMHJxSDYwTXtl6
        HDg3f8arSv3bxiKxEcrJPNefmqueYL9y5tJZ72BZTzFTy9AHF06EqP4/Fp5csb911oqmnYc7
        b3Y8UXfQvnK6M7rWIPJZby7D6VrXbQcPz+649qoqaJJDdfLfd9LeRn2rDoTxrUqZUjgxbotk
        BvNNMcG3tuvONa4P842JtWnadcxoHY8SS3FGoqEWc1FxIgCrNt74PwIAAA==
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: iesco.com.pk]
        * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [203.124.41.30 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [94.156.6.90 listed in zen.spamhaus.org]
        *  0.1 RCVD_IN_SBL RBL: Received via a relay in Spamhaus SBL
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Re; Interest,

I am interested in discussing the Investment proposal as I explained
in my previous mail. May you let me know your interest and the
possibility of a cooperation aimed for mutual interest.

Looking forward to your mail for further discussion.

Regards

------
Chen Yun - Chairman of CREC
China Railway Engineering Corporation - CRECG
China Railway Plaza, No.69 Fuxing Road, Haidian District, Beijing, P.R.
China

