Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 916F312642F
	for <lists+linux-sctp@lfdr.de>; Thu, 19 Dec 2019 15:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLSOCr (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 19 Dec 2019 09:02:47 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:37721 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfLSOCp (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 19 Dec 2019 09:02:45 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so4960803iln.4
        for <linux-sctp@vger.kernel.org>; Thu, 19 Dec 2019 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UW2WNzCKVC/Q6BcgA6pHzxjIqG8G7Lfqaw17jtNqaCs=;
        b=GgCIM/qWM2be3MNK2igzkBxxtdkwTYlah7yGxK19tPzTPMjTLCt+N/azSnqT8ePhIl
         ho53qzAlXiWCrTQu6/39i0RSFpkbAFoZVVB7teM81WAzd0osbj2bOonmnlhztG8Srd/S
         x/L5PzFLs5WyWh+mhZ0S19JazD8mo5Wz7+MHGOVV6npGHxWqEvYp/4KRMwvsfYXzcef8
         CEpnPxEoxMknefAELUThiIEvyS2Zjo8Z0KQHCjjoDt7z14B9gIrxOb+y3qI5z2qvg5d2
         8hGWBQqPG/LgzOztWZv5bd0j40+XPuQaoydwyzNKrC0IKT+LH+Sz3Ik4iSPE4O0uTeSZ
         psOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW2WNzCKVC/Q6BcgA6pHzxjIqG8G7Lfqaw17jtNqaCs=;
        b=oKUfXAceOmFjpb30/VGfhMt8Livot0R1+LQxfg0On710GhN/grvyWcSWu2HGFX9cEc
         bQwbpPFa5q/G9bMuYCDKVzV1Xx5rmGF5CBgbMHginMsz2VIcRT+z8W5aNNPwPss/R1Ke
         iW6obYMyWq1RGHbIcAmm6Sxpz5iIbXNgL71L/6P66s213AXJpyQGfYqDCXL+6wO1TVcK
         E3IDr+AOK/8Sc3/2C3zAeGFmAVHhibL2RvHQ05WA62+ERO+rFT641OMYf6kKG4RcXaAk
         oiHHxTk6chU8B281zJNIIF2Dc7vOHbDU5hkRiB33xcjNBaPgxh7Jkn49zoNbnEmytdtR
         rBCQ==
X-Gm-Message-State: APjAAAWOPcGQ+k5B5blS0bWveDwD5LZKoEvpK50zz9uI9m/HbqSZod3s
        Siqd3zL1UOBz4hGX5Ode33EtFiSlyhPhvlvKpP1YZQ==
X-Google-Smtp-Source: APXvYqyrla0Db74O+Uz2gFwVhw5eg2ZuE9sHJpBI7irla0B1Jw7er2Ms6F2iPOM5Ggv+Wrxik/dvdhbHyQW0pGxcnTo=
X-Received: by 2002:a92:6e09:: with SMTP id j9mr7317565ilc.178.1576764164462;
 Thu, 19 Dec 2019 06:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20191127001313.183170-1-zenczykowski@gmail.com>
 <20191213114934.GB5449@hmswarspite.think-freely.org> <CAKD1Yr1m-bqpeZxMRVs84WvvjRE3zp8kJVx57OXf342r2gzVyw@mail.gmail.com>
 <20191219131700.GA1159@hmswarspite.think-freely.org>
In-Reply-To: <20191219131700.GA1159@hmswarspite.think-freely.org>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Thu, 19 Dec 2019 23:02:32 +0900
Message-ID: <CAKD1Yr2wyWbwCGP=BNqAfsGu9cjgjD12-ePjs648Or-FjqHyBw@mail.gmail.com>
Subject: Re: [PATCH] net: introduce ip_local_unbindable_ports sysctl
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux NetDev <netdev@vger.kernel.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux SCTP <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Dec 19, 2019 at 10:17 PM Neil Horman <nhorman@tuxdriver.com> wrote:
> > As I understand it, those utilities keep the ports reserved by binding
> > to them so that no other process can. This doesn't work for Android
> > because there are conformance tests that probe the device from the
> > network and check that there are no open ports.
> >
> But you can address that with some augmentation to portreserve (i.e. just have
> it add an iptables rule to drop frames on that port, or respond with a port
> unreachable icmp message)

There are also tests that run on device by inspecting
/proc/net/{tcp,udp} to check that there are no open sockets. We'd have
to change them as well.

But sure. It's not impossible to do this in userspace. We wouldn't use
portreserve itself because the work to package it and make it work on
Android (which has no /etc/services file), would likely be greater
than just adding the code to an existing Android daemon (and because
the reaction of the portreserve maintainers might be similar to yours:
"you don't need to add code to portreserve for this, just use a script
that shells out to iptables").

But in any case, the result would be more complicated to use and
maintain, and it would likely also be less realistic, such that a
sophisticated conformance test might still find that the port was
actually bound. Other users of the kernel wouldn't get to use this
sysctl, and the userspace code can't be easily reused in other
open-source projects, so the community gets nothing useful. That
doesn't seem great.

Or, we could take this patch and maintain it in the Android kernel
tree. Android kernels get a tiny bit further from mainline. Other uses
of the kernel wouldn't get to use this sysctl, and again the community
gets nothing useful. That doesn't seem great either.
