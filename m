Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B77524E66
	for <lists+linux-sctp@lfdr.de>; Thu, 12 May 2022 15:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354353AbiELNiJ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 12 May 2022 09:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354485AbiELNiG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 12 May 2022 09:38:06 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB37843EF5
        for <linux-sctp@vger.kernel.org>; Thu, 12 May 2022 06:38:05 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-2f7d621d1caso56432517b3.11
        for <linux-sctp@vger.kernel.org>; Thu, 12 May 2022 06:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=8wlO2LAANUStJzA6ICgBjj2XiKm7ytGW9EjwyycZ8dc=;
        b=dMJH9W79w24dQCvvPiIYOf2QfRFvXXecT/S7NZWrSVGz5XnBq5WIhcb267h/tt0iIx
         ExNIT2BVxXyTIoZnatYzLBVB4/6qPHgf89EOBCsnCYMAuInj+hKTZ8VhKQjz0L5+zsTO
         oraiQo9sd9w3K4wbf0GDdQFSXBb+jS2Z58kyTN6k+5A/68WzjpPH2csNSBHKA59SR+PF
         JBa3hJjDRuhUKwUqwBr/ikH8aRo9XLZGZPomYoGFHkxgHOTX9WJ0n7W4iHg2awZ2GLlx
         C3XEZhn5EiXnMuMs0wO47Gyvxkasyav9p2XeS0EifOvdEd+u2vd9afhL6msI3AYmTfZg
         uT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=8wlO2LAANUStJzA6ICgBjj2XiKm7ytGW9EjwyycZ8dc=;
        b=u4N23S3cSQSq73ybGMcBGqWtdI4BFifOWSP0sU0dNqW/LULYfxs6zjka45+lVedM2l
         qexho1ziGMSIs0KAaV2IYiMXsnSQJpBC581/C4bNsBSn4RzFF00DhpOondsWYHMLGBul
         Zp5udhD01AoQr6N+dy+bIA0i9SjMQ8hCUzfez42lrF+3l6pMO95E8UMtKHiTiS3cz980
         W4y6qAXbk06YqZUQ3+BMDptdegMcYmbzku1px8m8rl5g5zIu31KzHV+PX8HotQXHUBqg
         1XcqZkRDDjJ55SZrcYgbZdMmTrVdYjj8iQz/C+BBDYYtUGIGQ1751jGWFOx0Zcv4FKEq
         FOPQ==
X-Gm-Message-State: AOAM530zZP9WR9bKelnTC1e9LtlpkejmlwaNjL04voQxo+Wuz+E80sxE
        IqlbI5i+d8PARbsKsNdyKTOY3IM/udp62MXF3g==
X-Google-Smtp-Source: ABdhPJxlSEi3uxDngc8TVMDG6XjU1dU644rYdGQ6poX4IyKDXmEQxiSiJu2D4u6u7B7z+YGZ5mhswhlWZE3eBS4hVXk=
X-Received: by 2002:a81:2541:0:b0:2f8:efd7:8962 with SMTP id
 l62-20020a812541000000b002f8efd78962mr60872ywl.404.1652362683716; Thu, 12 May
 2022 06:38:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:380b:0:0:0:0 with HTTP; Thu, 12 May 2022 06:38:02
 -0700 (PDT)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <happypalama@gmail.com>
Date:   Thu, 12 May 2022 14:38:02 +0100
Message-ID: <CAJoeney58L4O6ngQ73rSV6FZ=OnzWNEBzb+WAwZ6UkF7r==O2g@mail.gmail.com>
Subject: Rowland N.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4503]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [happypalama[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rolandnyemih200[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Rowland N.
