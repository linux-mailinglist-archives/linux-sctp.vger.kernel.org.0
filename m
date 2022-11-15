Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BA962A1C7
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Nov 2022 20:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiKOTXj (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Nov 2022 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKOTXg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Nov 2022 14:23:36 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 11:23:32 PST
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681F8C7C
        for <linux-sctp@vger.kernel.org>; Tue, 15 Nov 2022 11:23:31 -0800 (PST)
X-KPN-MessageId: d30a3c6e-651a-11ed-823a-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id d30a3c6e-651a-11ed-823a-005056abad63;
        Tue, 15 Nov 2022 20:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kpnmail.nl; s=kpnmail01;
        h=content-type:mime-version:message-id:subject:to:from:date;
        bh=GWAyNUFElKzCQd+YKsyyzpQITTAkk0s4kDulJCqw1/o=;
        b=d7ZAiTMFlR/oOIMuB4ZNhAXssoMJVyS/6Ily1IeS5SdazSGGVONOw7RF+qTkPtfwLXxgoyyxkbcP4
         AYxQ7UknGLbjFtC/zjtlsOy/0MpKaedFSLl+DfHkPiBcdFwtNGDUkjFmxNxn9utDKW+I84wnAzzTVg
         1Hy1itX81aEcahSI=
X-KPN-MID: 33|rZQxI7EflygsWZFNijyZr0NKh74HqHoxCWBNu6jEfqmLDxO9gEHaydGNsHlaemQ
 sVbdF8sf3EIm1azgdbi7AsK/z0bjyp+IttxcDaRdzw7w=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|8Xeid29BDjK8/1CXWFgBn+gij68Rt5/QQkunymViP+ebyNf6U54UbTJuuVrEEYf
 A3bPEdQ4kOzkPgBCKCAK4OA==
X-Originating-IP: 82.170.67.232
Received: from keetweej.vanheusden.com (82-170-67-232.fixed.kpn.net [82.170.67.232])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id d3351214-651a-11ed-b8b1-005056ab7447;
        Tue, 15 Nov 2022 20:22:20 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by keetweej.vanheusden.com (Postfix) with ESMTP id 8102F161327
        for <linux-sctp@vger.kernel.org>; Tue, 15 Nov 2022 20:22:20 +0100 (CET)
Received: from keetweej.vanheusden.com ([127.0.0.1])
        by localhost (mauer.intranet.vanheusden.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id whne8p-x9mMF for <linux-sctp@vger.kernel.org>;
        Tue, 15 Nov 2022 20:22:17 +0100 (CET)
Received: from belle.intranet.vanheusden.com (belle.intranet.vanheusden.com [192.168.64.100])
        by keetweej.vanheusden.com (Postfix) with ESMTP id CEE40160DC6
        for <linux-sctp@vger.kernel.org>; Tue, 15 Nov 2022 20:22:17 +0100 (CET)
Received: by belle.intranet.vanheusden.com (Postfix, from userid 1000)
        id 955CA1602C2; Tue, 15 Nov 2022 20:22:17 +0100 (CET)
Date:   Tue, 15 Nov 2022 20:22:17 +0100
From:   folkert <folkert@vanheusden.com>
To:     linux-sctp@vger.kernel.org
Subject: testing of the sctp stack
Message-ID: <20221115192217.GE1688985@belle.intranet.vanheusden.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Reply-By: za 12 nov 2022 19:54:34 CET
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

How do you test the sctp stack?
I mean not via de socket-interface, but the other end; via the network.

I'm asking this as I'm developing my own IP-stack including SCTP (for
fun, open source, nothing big or special).


regards
