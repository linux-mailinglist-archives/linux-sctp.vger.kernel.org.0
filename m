Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98D93ABC3D
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Jun 2021 21:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhFQTDo (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Jun 2021 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhFQTDo (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Jun 2021 15:03:44 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A4C061574
        for <linux-sctp@vger.kernel.org>; Thu, 17 Jun 2021 12:01:35 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x6so2262896qvx.4
        for <linux-sctp@vger.kernel.org>; Thu, 17 Jun 2021 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FN3S2qxWfcHnR9EPE0Bd9E43mxFMyGCw30MmH29Ramw=;
        b=KjnVIxpcP8/ZuZgnu/yYpF+d/ZC9KoDDq6jf+eGaKJoa14wvH1mRjPg8iCxV0pwqY9
         Wyod9/COaEK6QK4nCQK5xmSATGBwveYtj8MoIHJgRGp7NkIrbAEojUXrVODyA3Xo3Apz
         ljsB5CsBpqqBdaJesA+WZrDSuhpXmxQYoX86X7oF4gigrT4+XHpjkEdkkDG2g+HcVfw0
         tzq4byNxzixzzTJLgRCY8BsS22q87Op32CkzNGbzDOZqCO9shQuvY+RaxsmZUoeKndiM
         hMJwQnwRKEqg2DfsS2/zPdC4s4isMpIfQajOfZy75zvd8+v+rGl3S4OGOD4Md9gw2GDp
         yFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=FN3S2qxWfcHnR9EPE0Bd9E43mxFMyGCw30MmH29Ramw=;
        b=HwNm61iNBWsIwvk+Uh9dUuwt4ObTOIkTq9U2LC1JcLRG958RTgmEXP7w32h7es5NaT
         qjT5OmUvdQ/NBnPmxKJn7hiy2C2MMzJBcumKEqgRKUm+xla3vKqajt4+6ibDonVkl9Au
         z7Hx0tNq2hVXxPuAf3kh4F3lNy9iq24+JwR8P3LZ2c9Z5fEdQy7ZdWqMO0ufU2fZNv79
         1UvhHGQB+WwL+TdEoxk8nfAFu0ra08HpwuNLperyyHFc6XF4skwTYLmufPEi4lySYjV3
         tHIWGCGeJsKa6+HnX2wLbZ1EVmVQ2jHKYPsSqnERC2AY1uMhwVV9/LZB/jT+TwdsVB7J
         dxgQ==
X-Gm-Message-State: AOAM531rbsQUR0qh8ukyvdjp1ZoJ1hXMCRVYJx0ST4F5UJgQN3tAN4RV
        xM6V0iBT6YS7DsiaDEh/hLSfG84Kwfixxj3O+vtofy4TweMqtw==
X-Google-Smtp-Source: ABdhPJy3SrHup/eSNdKUhNu95i11u4XNvSl4/vo0aumZ20kN9wSko1RqDkcmfCmYQunR4zvwQSv5inbuMPpmcReju24=
X-Received: by 2002:a05:6214:186b:: with SMTP id eh11mr1516259qvb.38.1623956494423;
 Thu, 17 Jun 2021 12:01:34 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?S=C3=A9rgio?= <surkamp@gmail.com>
Date:   Thu, 17 Jun 2021 16:01:23 -0300
Message-ID: <CAFsBEWmV+yvGQTuqm4FdFUAH5zHDPEXT+3cCUNgq1ZmZrau9Ag@mail.gmail.com>
Subject: draft-stewart-tsvwg-sctp-ipv4 enforcement
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

I am troubleshooting a deployment with SCTP and eventually found that
the client has configured the equipment using addresses within the
RFC2544 annex C.2.2 test network (198.18.0.0/15).

Although I think the deployment network may be changed to use another
address space in order to "solve" the issue, the restriction
enforcement on the SCTP kernel driver (implemented by function
sctp_v4_addr_valid -- net/sctp/protocol.c -- in expansion of
IS_IPV4_UNUSABLE_ADDRESS -- include/net/sctp/consntans.h) seems odd to
me, because the address is a valid unicast IPv4 address and should be
acceptable as per RFC4960 clause 8.4:

   The receiver of an OOTB packet MUST do the following:

   1)  If the OOTB packet is to or from a non-unicast address, a
       receiver SHOULD silently discard the packet.  Otherwise,

The source code states that this restriction came from
draft-stewart-tsvwg-sctp-ipv4, which is true, and the sysctl
net.sctp.addr_scope_policy is documented in ip-sysctl.txt as a switch
for the desired draft behavior, but changing the sysctl value has no
effect because IS_IPV4_UNUSABLE_ADDRESS macro expansion has no
verification of any sysctl configuration nor the sctp_v4_addr_valid.

The draft-stewart-tsvwg-sctp-ipv4 enforcement seems like a bug or I am
missing something?

Best Regards,
S=C3=A9rgio Surkamp
