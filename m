Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564B97748BD
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Aug 2023 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjHHTiM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Aug 2023 15:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236485AbjHHThw (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 8 Aug 2023 15:37:52 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41258911
        for <linux-sctp@vger.kernel.org>; Tue,  8 Aug 2023 12:07:20 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-790970a8706so274627839f.2
        for <linux-sctp@vger.kernel.org>; Tue, 08 Aug 2023 12:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691521640; x=1692126440;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yC9NAqo1aOvykbiz9gLngNWHgdwdNTwWiPOzCE3he0k=;
        b=kIwHZEfDNhqnMoJz9MXlmcRlH5spT9aYIsELAzlNE70yLuK7B3sbACey45XWVepXmF
         idLw4o+SWnMHemCos1LgID6u/H29O1hHIJ8GNvquyJnQmtS097DWPbfnoNaW7Rxzasd3
         sP/BVCPFS1QOZF6AsD20yRzZdXA0fWe49RSEGaR+B6cAEhRDuHk4Dvtl8GK1Gt4QNbr5
         s3NDh7dB/7QjzwiX5xqC4bth0I7bw2qgQKCmNyAzrjIP0clr2U7njzKxmMpaSycljYX8
         KSMBn1b39Z81IFNXLe1ZVMDSBuzzmVfOD4D4cvTz8AJ4PqrIxzcMob7GI7EJ/NiuKqcz
         y+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691521640; x=1692126440;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yC9NAqo1aOvykbiz9gLngNWHgdwdNTwWiPOzCE3he0k=;
        b=FRlZ/oEFHwWJIOyeJYZBFuGdKWnAPOxNxjIXg1LtXwznUdCcGmLLssfh4BU65IV+dy
         0GWnzCMo6P6owOvrhx0ZojAqo33czFbH2hGsgAo7QlQ97907D8wx0bXaJw0XEwk8HjOc
         VEY71gzVOV+84ZXQrSY2vYIfbt1h2ZlHGfFpyFaxdvCYxfKY90ptLylSuLvnMAlO/ZpE
         BJpp/c19KS6Tlo3tQ2VJaHjcozqo8YE4LdxbVB0qh9f6LixFowk53eGAXmuf5vScJuHg
         gPAN7geHgePS9zKwsVLbf5L/a5sdTRylDFbb/rXIWH3bwL5viZibTii/W1stbu+QJUDs
         zc/w==
X-Gm-Message-State: AOJu0YwrI7O8ZWfMgpKl5uelOiSvM+xYrZ92vgtwzyLHicvew5J3MB8n
        F513Wj2VZFDYQNzze6TMEQ8=
X-Google-Smtp-Source: AGHT+IE3dIHvCmsskhjEaBPch6q4Q4ZLDgm4onMedwSUxHPtOlOefE2jyj8/xIzMdUT7XQncPEdkxg==
X-Received: by 2002:a5e:c90e:0:b0:783:6272:afbb with SMTP id z14-20020a5ec90e000000b007836272afbbmr625321iol.9.1691521640044;
        Tue, 08 Aug 2023 12:07:20 -0700 (PDT)
Received: from smtpclient.apple ([195.252.220.43])
        by smtp.gmail.com with ESMTPSA id y19-20020a5ec813000000b0077a1b6f73b9sm3765312iol.41.2023.08.08.12.07.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Aug 2023 12:07:19 -0700 (PDT)
From:   Sishuai Gong <sishuai.system@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Racy addr->valid in sctp_inet6addr_event() and sctp_copy_laddrs()
Message-Id: <72339335-4072-429C-9494-ACCDC5572F54@gmail.com>
Date:   Tue, 8 Aug 2023 15:07:08 -0400
Cc:     linux-sctp@vger.kernel.org
To:     marcelo.leitner@gmail.com, lucien.xin@gmail.com
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

We observed a data race over addr->valid between sctp_inet6addr_event() and 
sctp_copy_laddrs(). Under the following execution order, sctp_copy_laddrs()
might copy the addr that is no longer valid.

sctp_copy_laddrs()              sctp_inet6addr_event()
if (!addr->valid)
        continue;
                                		addr->valid = 0;
memcpy(&temp, &addr->a, sizeof(temp));

Thanks
