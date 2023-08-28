Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE278AF74
	for <lists+linux-sctp@lfdr.de>; Mon, 28 Aug 2023 14:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjH1MDA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 28 Aug 2023 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjH1MCv (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 28 Aug 2023 08:02:51 -0400
Received: from mail.fink.org (mail.fink.org [79.134.252.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095F911A
        for <linux-sctp@vger.kernel.org>; Mon, 28 Aug 2023 05:02:46 -0700 (PDT)
X-Footer: Zmluay5vcmc=
Received: from smtpclient.apple ([79.134.238.70])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 10.0.1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        for linux-sctp@vger.kernel.org;
        Mon, 28 Aug 2023 14:02:44 +0200
From:   Andreas Fink <afink@list.fink.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: SCTP MTU issues
Message-Id: <27FDC8D4-B7DE-4A3D-B681-2070C9D53D8C@list.fink.org>
Date:   Mon, 28 Aug 2023 14:02:34 +0200
To:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
X-Mailer: Apple Mail (2.3731.700.6)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello all,

I have a specific issue related to SCTP and MTU size and I'm not sure how it should be solved correctly.

I have this setup

Host A <---> router <---ipsec-tunnel--->  router B <----> Host B

Host A is my Linux machine and  has a default MTU of 1500
the IPsec tunnel reduces the MTU to a lower value (1476 or something like that)
Router-B and Host B are devices we do not control

Our software sets the MTU in Host a to reflect the maximum transmission size in the following way


1. We set the maximum transmission unit to 1412 which is a safe max value (configurable)

    int _mtu = 1412;
    struct sctp_paddrparams params;
    socklen_t len = sizeof(params);

    memset((void *)&params,0x00, sizeof(struct sctp_paddrparams));
    if(getsockopt(_sock, IPPROTO_SCTP, SCTP_PEER_ADDR_PARAMS, &params, &len) == 0)
    {
params.spp_pathmtu = _mtu;
        if(setsockopt(_sock, IPPROTO_SCTP, SCTP_PEER_ADDR_PARAMS, &params, len) == 0)
        {
            /* success */
            if(getsockopt(_sock, IPPROTO_SCTP, SCTP_PEER_ADDR_PARAMS, &params, &len) == 0)
            {
               _mtu = params.spp_pathmtu;
            }
        }
    }


2. We enable Path Discovery

    struct sctp_paddrparams params;
    socklen_t len = sizeof(params);
    memset((void *)&params,0x00, sizeof(struct sctp_paddrparams));
    if(getsockopt(_sock, IPPROTO_SCTP, SCTP_PEER_ADDR_PARAMS, &params, &len) == 0)
    {
        params.spp_flags |= SPP_PMTUD_ENABLE;
        params.spp_flags &= ~SPP_PMTUD_DISABLE;
        if(setsockopt(_sock, IPPROTO_SCTP, SCTP_PEER_ADDR_PARAMS, &params, len) == 0)
        {
           /* success */
            _pathMtuDiscovery = 1;
        }
    }


The result is that we never seem to send any oversize packages outbound.
The problem is that the remote host doesn't get to know the MTU limitation and if big replies are being sent, the link gets killed after retries of the too big packets fail.

Is there something like tcp's mss which gets sent over to tell the other side that it should send something smaller?
What is the recommended way to avoid this issue?

The other side is a ZTE mobile switch and the partner has no way of controlling the MTU (or they have no clue).
So we can only control the Host A and Router A side.
