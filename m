Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0693AD08D
	for <lists+linux-sctp@lfdr.de>; Fri, 18 Jun 2021 18:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbhFRQh7 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 18 Jun 2021 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbhFRQhy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 18 Jun 2021 12:37:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A95C061760
        for <linux-sctp@vger.kernel.org>; Fri, 18 Jun 2021 09:35:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n7so11436769wri.3
        for <linux-sctp@vger.kernel.org>; Fri, 18 Jun 2021 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wqMP4plX1bGuqE8YQalMhz18D/Sbnnhs+Z3ceryHhqY=;
        b=U6FHtLoKu5pfwJZ18OoNHRNmSntrWI1M/YbOQFcJW0BNqKmU8ow9JZqFA8xfptmAmz
         q0hpWv4YpPaPT2UiGRB6nr5nkHPN+3Xfs4oxek/B0hnvS0XxDYUCpDLiBmiHWv2SY8I+
         UBDfWazVWsBd5MY42gE2lDsZLCdvvu/WhIUxULS5CgcwiTxMZfh9XvYW6cgDek2XqlOj
         Z4k6XlNx8nCLOs39qj2kdqRPTYYGRRE1ydC/AX/qcDg6y4ze5hDm8NAP75UC6tuYruQI
         jOlrIfO9OElxRjHqBgIbOyxoxmdjbm9w20XoRc5mz0WM8odMirPhKBNAnggRM4pskEpo
         GB1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wqMP4plX1bGuqE8YQalMhz18D/Sbnnhs+Z3ceryHhqY=;
        b=p3pNs8RREaFSQOzIJPPcEDMr0vtnvoqEay/myRxHCbyMVZbW4az0PV5nXAit7ZgslB
         9UzoJ18uyXGvigF8kt8mlpcoZffgA7fuYsRlZNbOAYFr/ntbuu5/6IY5MRTrXA49QvPl
         nFjG1HxIbkhHkZeR8GZztIm1MG0LVvYB2OxDEJD1QRnTFtGkPQuUA6329u24eZwcEzPb
         l+jCoZIe2pVdnG7QkbwJfOgVpPrycF9Qh97/Eo24osn/WXRsjkiJC6uTRMu13eJtV2Ca
         +XCztqT9m4bYd/RQeT66ciJgSlCCQiTqPfv+mDW8y/kDnsq9Z7dEgEgJdrM+Ak6TZViU
         zJ6w==
X-Gm-Message-State: AOAM531AQZ8vPJngU6ksvHAWfRrwhITRFmzVRtFIs2lcHf/VeIrP23l3
        CvT9NFrSrYuQRsel77rbPt1f68sInhI6SrHRexE=
X-Google-Smtp-Source: ABdhPJwo4PVQvl7wntgLqM9Ii2v/rBxAA9JUyJ4uhzzU8g/tHWO1aRsFbNSO7O44VeqWpBKl4QbA1+AIkg/4WYf7km8=
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr13474998wry.395.1624034142225;
 Fri, 18 Jun 2021 09:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFsBEWmV+yvGQTuqm4FdFUAH5zHDPEXT+3cCUNgq1ZmZrau9Ag@mail.gmail.com>
In-Reply-To: <CAFsBEWmV+yvGQTuqm4FdFUAH5zHDPEXT+3cCUNgq1ZmZrau9Ag@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 18 Jun 2021 12:35:31 -0400
Message-ID: <CADvbK_d8=rfzObEYEG35jVdm-yDzc4gN+v4EvRRCnrh8j36h9g@mail.gmail.com>
Subject: Re: draft-stewart-tsvwg-sctp-ipv4 enforcement
To:     =?UTF-8?Q?S=C3=A9rgio?= <surkamp@gmail.com>,
        Michael Tuexen <tuexen@freebsd.org>
Cc:     "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Jun 17, 2021 at 4:40 PM S=C3=A9rgio <surkamp@gmail.com> wrote:
>
> Hello,
>
> I am troubleshooting a deployment with SCTP and eventually found that
> the client has configured the equipment using addresses within the
> RFC2544 annex C.2.2 test network (198.18.0.0/15).
>
> Although I think the deployment network may be changed to use another
> address space in order to "solve" the issue, the restriction
> enforcement on the SCTP kernel driver (implemented by function
> sctp_v4_addr_valid -- net/sctp/protocol.c -- in expansion of
> IS_IPV4_UNUSABLE_ADDRESS -- include/net/sctp/consntans.h) seems odd to
> me, because the address is a valid unicast IPv4 address and should be
> acceptable as per RFC4960 clause 8.4:
>
>    The receiver of an OOTB packet MUST do the following:
>
>    1)  If the OOTB packet is to or from a non-unicast address, a
>        receiver SHOULD silently discard the packet.  Otherwise,
>
> The source code states that this restriction came from
> draft-stewart-tsvwg-sctp-ipv4, which is true, and the sysctl
> net.sctp.addr_scope_policy is documented in ip-sysctl.txt as a switch
> for the desired draft behavior, but changing the sysctl value has no
> effect because IS_IPV4_UNUSABLE_ADDRESS macro expansion has no
> verification of any sysctl configuration nor the sctp_v4_addr_valid.
>
> The draft-stewart-tsvwg-sctp-ipv4 enforcement seems like a bug or I am
> missing something?
>
There must be a reason for not using 198.18.0.0/24 in SCTP, as in

  https://datatracker.ietf.org/doc/html/draft-stewart-tsvwg-sctp-ipv4-00#se=
ction-3.1

   [1]  IANA, I., "Special-Use IPv4 Addresses", draft-iana-special-ipv4-
        03 (work in progress), April 2002.

https://datatracker.ietf.org/doc/html/draft-iana-special-ipv4-03
