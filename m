Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFAC4D3871
	for <lists+linux-sctp@lfdr.de>; Wed,  9 Mar 2022 19:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiCISIU (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 9 Mar 2022 13:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbiCISIT (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 9 Mar 2022 13:08:19 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC44C4578F
        for <linux-sctp@vger.kernel.org>; Wed,  9 Mar 2022 10:07:19 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o22so2561909qta.8
        for <linux-sctp@vger.kernel.org>; Wed, 09 Mar 2022 10:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WhWPQBc6+aeHTdCKV+dLwNIRJs+SxTcePufZKGXzmHw=;
        b=a0HjMgGSam0mHnGfecFJ0fQComNe1+bNXJ+XbdEgleaJPzbYYAih0zEVY1rUrX8RY+
         iv8pgnOCuTDV7+HyZ0uKPFGbE6b1Wt+Q6tp/NCrtXIn6au6SgSwF1XfDdd3/AymYQO2q
         ZH6ZVDqGRQ+zOCWGYAGxp/pZeApCHu4nol2w9zaoUfEGaeZNt3XktmbzUDhpZPVms6AQ
         +RXi1xHL9lioifwGZOmr3rEPxid+P8aNzlqLF4JfGduFjatWZcsMP/DJAckzzZANG1m4
         kaxBwRpf7u0BWp20VDL3a5FQKA7eH4CF9xEAvY1FQ7/9reqzn5RfGN7fQRYkU55EgIKI
         ONSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WhWPQBc6+aeHTdCKV+dLwNIRJs+SxTcePufZKGXzmHw=;
        b=wUAoghCd4wCnoW7l7alW3j6nno+9ZFz1oJ+wiqed+ChypjpF/PRe9HXqkkxDpdbCPt
         vDUFpEOM70RRdOZAK+cCPPaHFsKnt1cqmcdYFiOE5USboZuylK30f4sjNiVFr81H54/I
         U2J5ag78VqoStHgCVTQRI1oByNaAFEvNC5wmL9Ai4Mq6q4c+k+ZfBbaPgwlrsLz75TAm
         Q9qlsCFySV77I4BsIiL16weE/Yf4Im3DpxBZ+kun3k2Zb/F7yqbr7n0Ttzh3Lo9CY4Bd
         cNdvnv/DmFMKEik2Wr0FOgMfYP+fnbBHM5y0I8b5nWXbPMFqjU95wlBQjBRxbnhEf2Tf
         0LNw==
X-Gm-Message-State: AOAM532BZ7YL4FDxsznwiGAiINnqRigOPSFrsk9drXVHLF3EcrOkEJpE
        iOnC2rf/s77JpYMW8eVsPYuf5iMWfpCs9Z5Cix4=
X-Google-Smtp-Source: ABdhPJybLI1WHTSTmglzehJfdf8i+nQOIW3sbvxIOkTTpwvpy0KMa6HB+TG+mOhydYVqZr4llDtmTjZcqa5r38ayolc=
X-Received: by 2002:ac8:5f87:0:b0:2df:f50f:f4c8 with SMTP id
 j7-20020ac85f87000000b002dff50ff4c8mr806329qta.46.1646849239049; Wed, 09 Mar
 2022 10:07:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:5f4f:0:0:0:0:0 with HTTP; Wed, 9 Mar 2022 10:07:18 -0800 (PST)
Reply-To: blessingbrown.017@gmail.com
From:   Blessing Brown <msouley115@gmail.com>
Date:   Wed, 9 Mar 2022 18:07:18 +0000
Message-ID: <CAPXpgPXz_TgcvH27Bv2MwzkznyWZ=jBYKO6QTtFs4AYpO9GBng@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I'm Mrs Blessing Brown. please i wish to communicate with you.
