Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B641066A21D
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Jan 2023 19:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjAMSeA (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 13 Jan 2023 13:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjAMSdY (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 13 Jan 2023 13:33:24 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBBA544F5
        for <linux-sctp@vger.kernel.org>; Fri, 13 Jan 2023 10:29:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id bj3so20015232pjb.0
        for <linux-sctp@vger.kernel.org>; Fri, 13 Jan 2023 10:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLPmlGGL/gTvueqKEBdKiHKfa75D3rcCxU1z3taEYt8=;
        b=NDAiyKuG9x9Rpu55msQAWvQ26zTCbL4jAmLuWVZRkY7nS0/ozF0sXuOpTB+UppTnPB
         Hp2FZA9gno9zKMM7qTT0alaAomnI3uo9qG63DPjND9w71jOYSvQoXslXrF/u8B/YQ3MD
         x4q1Cnl6DpjUbFkjc0oennWNUTkx5GVeZzPKXT2aow/LqJ/I5iAXqwPXMj9oK88yDJbu
         UGGukmLGHZh73+poRrriuVXksj6bsLMk/8+9Q8YVo3Zfn8OyNTmrf1DiD5Vsk+yuAZyg
         sW1R6eRzZZsBYgOi9B2EaANQPhXYU22rM7/A4eAUM/RCOob2g07+rYUq5VpBwmDtSC9o
         bqAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLPmlGGL/gTvueqKEBdKiHKfa75D3rcCxU1z3taEYt8=;
        b=jtk32+I3rgL4T6ZqU/phg3AbtbrdjXnMHYKFzH1+KrycPI9j74COsxZFCAOs8V79gE
         bwPnl8TywENJD661rcPiFaxFyGdYMLv5zbW2Z7/yKjv1k5fJ2/JB2junXIoPJLwPwurO
         4kZc13gBfDbj/OJ4Szv3Dl4sw1ganJJ2egEC0u0ad9GvBIenA8z4aP4godbg4zmdBuOn
         9bA4N6ErpMH3a+DukB3IkXfXkrKFeTKIz32K0gXEHiCMFAHpSXhUdSBS6cr/NSecXfFf
         o1sqD9FaHGdQpyfaCUoTr8U2uzS1loMBA9jwDLllrCxXqqGEa770zgMS8JTroVtsgBH9
         1NTQ==
X-Gm-Message-State: AFqh2kohPaqOU7DF0fFoYWOlrZ/UtURqI9pZMc+KDBKRHeClqZXtexOU
        QDMkMwwJpAUvZlIDqtltYQ98AyCb3Ajk9oBn8Sk=
X-Google-Smtp-Source: AMrXdXscni9pg1SbV+Ef1aeLSWUvhTUHZV3v68CZTLhOuC7hHfCYb0iYjIp6I9IpKBRa/nFAl2WFEggZX4mGAN5DxGo=
X-Received: by 2002:a17:903:1203:b0:192:7a00:c790 with SMTP id
 l3-20020a170903120300b001927a00c790mr56133plh.12.1673634553236; Fri, 13 Jan
 2023 10:29:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:ce87:b0:3b7:8130:eb66 with HTTP; Fri, 13 Jan 2023
 10:29:12 -0800 (PST)
Reply-To: richardwilson19091@gmail.com
From:   Richard Wilson <katejoy198@gmail.com>
Date:   Fri, 13 Jan 2023 18:29:12 +0000
Message-ID: <CAAoq0c6cE2RfL899AYG73p9PdYJmCVAzBrpLCip43KBxx96jiw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1029 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 REPTO_419_FRAUD_GM Reply-To is known advance fee fraud
        *      collector mailbox
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [katejoy198[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [richardwilson19091[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [katejoy198[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear,
I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's

Barr. Richard Wilson
