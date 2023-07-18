Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AAA75840C
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Jul 2023 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGRSC7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 18 Jul 2023 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjGRSC6 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 18 Jul 2023 14:02:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28728A1
        for <linux-sctp@vger.kernel.org>; Tue, 18 Jul 2023 11:02:58 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5700b15c12fso61433757b3.1
        for <linux-sctp@vger.kernel.org>; Tue, 18 Jul 2023 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689703377; x=1692295377;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7al5tUCjdA9CCQe4odwP1DfME2QXDR1IbbFzP4IEE4=;
        b=G4ejti3r3ofCzHIMvLK4BbEuxiZZW5JEXUvalESRKy0yR3/lGYlFZZHiD8N7m6dpOR
         Jecy9iPilmckgIKdNS19C1ovV0w/9TWyqrgf+jA1FH7igUzXSxAw9YT+nkdAA9DLAURW
         DSQK6wWAi80vSSUtnywWX5i6EEYQeEQsiLsSmDtvBw/9WEjjLBRO/rN61QU9iZnF39bu
         WgGAwxBPC1KlxV21mgZ/IZY+dCOPKjdw9uv2EcvHOU6sutRDIK0XwXBOE+PnF0BW6uBl
         makDCYyu8GoYebzQjr1n/5bljwxV4Rgoz0Bc0bwgVthzNWTm5bC8o+le8Xk8USI7FiCX
         i9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703377; x=1692295377;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7al5tUCjdA9CCQe4odwP1DfME2QXDR1IbbFzP4IEE4=;
        b=KawiclA3OtVfMIes9lzsYnl1r+xOVqfPVmjRMuRQfkBHpWRBgoAgNZOUXD+Z/Le4YK
         JyVgNyC8siKnRHIipwNIkB/8OAtaOOPTtqPdkV1dPlRgC4U/lJVv3ua5+eqkUTjaWYQM
         PaOoLd3miYApH05gaqGb9HDdZCVuAQ6GDAWDJSdQZF6o/zHWlLZuXObEu5DbE6QnFJIU
         L/KHn+flUxaiJkq2selkWD8zYA0zgqwtuZhubUSIixHSTxcXEQBrR5VociMEbFV7T+3o
         wZMRYlIHcrA2GAMhtXXasw0kPQx0VI5aCGtfcnVDMTKsERa6uymH/3bmps1TrE2zlddI
         v1UA==
X-Gm-Message-State: ABy/qLYWay8L4RrbmJB2HX57QHvuONFDjSzORQ6pqlc14QORs8QZyRpR
        FcYViNxyr+KEaOtLjzsidH5hoJKHtrLnYlKPiQ==
X-Google-Smtp-Source: APBJJlE6XGJcYvdPg1SsdkoFdK34HQMDp2w+bJ6K0wWZImXOBHYFVGIfv6NEPHXlLd6C1EhTCUE3OqUdQLsOwL0WWG8=
X-Received: by 2002:a81:520e:0:b0:576:d65d:2802 with SMTP id
 g14-20020a81520e000000b00576d65d2802mr15686312ywb.3.1689703377374; Tue, 18
 Jul 2023 11:02:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:f10a:b0:1a5:a18e:2e4a with HTTP; Tue, 18 Jul 2023
 11:02:57 -0700 (PDT)
Reply-To: fionahill.usa@outlook.com
From:   Fiona Hill <barr.makpojames.tg@gmail.com>
Date:   Tue, 18 Jul 2023 11:02:57 -0700
Message-ID: <CABXrGPc70OrXLHEyo04oxJRxwAZSTkc7CoJBKaHLJkBmyDXvvg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

-- 
Did you receive my messages?
