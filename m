Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2583D5736BE
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Jul 2022 14:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiGMM6p (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 13 Jul 2022 08:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiGMM6o (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 13 Jul 2022 08:58:44 -0400
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [IPv6:2a01:e0c:1:1599::12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1CE15FF4
        for <linux-sctp@vger.kernel.org>; Wed, 13 Jul 2022 05:58:43 -0700 (PDT)
Received: from zimbra101-e18.priv.proxad.net (unknown [172.20.243.47])
        by smtp3-g21.free.fr (Postfix) with ESMTP id C803113F84C;
        Wed, 13 Jul 2022 14:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1657717120;
        bh=8Zk9bEIGsBQpNGubAmJWkYLSb5ZZlevbEJc7d20CdAw=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=lbzkT1koOimM7Qb3cKLryb235TG17fAZHP04FZAdEBQT4NLiyOzUIJm1hl2pEyTd3
         iX/QkfMAwFVp/eJQ4oo6jAx5qMiGaZ6AtGULQsXevV1TnhQmVd5Bkq2kAVaGL74op3
         AI0Hk+FU6SR+5AEyxWZDiE8I5eKfemSMcjoVTvS9wXT6HuoOxid7dXzOemF4CDOUaZ
         7hR+odkB8lCGWyXaubVNOQ03O60tUZf6ql0UNcL0eJOPBvLMq4ga9mMonOfVyve+w6
         3u4HX2vdtjA+fzMuw1U1E98l7C9qLS5F0a2D9SA+klYbzFG0VxhpLcrlxQ1+awrslw
         DYUHQPzmQ8Z3g==
Date:   Wed, 13 Jul 2022 14:58:40 +0200 (CEST)
From:   o.evistel@free.fr
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     linux-sctp <linux-sctp@vger.kernel.org>
Message-ID: <1937458162.418765580.1657717120765.JavaMail.zimbra@free.fr>
In-Reply-To: <YsbiDrG1PQ2Gng5T@t14s.localdomain>
References: <6f6f11b5c30bce3d6e77d719ef75112dee75250d.profile@marceloleitner.u.sourceforge.net> <YsbiDrG1PQ2Gng5T@t14s.localdomain>
Subject: Linux SCTP performance question
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [78.197.34.136]
X-Mailer: Zimbra 8.8.7_GA_1002 (ZimbraWebClient - FF101 (Linux)/8.8.7_GA_1002)
Thread-Topic: Linux SCTP performance question
Thread-Index: 2DGxpN6xV4C4bUClvJnyXq7vayuHvw==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        GB_FREEMAIL_DISPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear Marcelo

I am using linux-sctp as transport for SIGTRAN M3UA on RHEL 8.4 and I am using sctp_sendmsg() and sctp_recvmsg() to send/receive.
I would like to know if the use of sctp_sendv() and sctp_recvv() enhances performances ?

Regards
Omar AIT AMRANE
