Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE53911DB1B
	for <lists+linux-sctp@lfdr.de>; Fri, 13 Dec 2019 01:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731358AbfLMAZz (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 12 Dec 2019 19:25:55 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46141 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731330AbfLMAZy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 12 Dec 2019 19:25:54 -0500
Received: by mail-io1-f66.google.com with SMTP id t26so551981ioi.13
        for <linux-sctp@vger.kernel.org>; Thu, 12 Dec 2019 16:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zvYy2WCR9QMih3XiDnl+CR4jwAqudFX5LXJtq32Rx7I=;
        b=MsYVZdbG+RCmTxrz/vGccnxf3cb33OCJMcoxSfC4knIfUdbMXDNTc+dQ6ChQeThBn8
         5EI6Nu1BwKxTn0OgXCUVtCRFkPE+j6bkFLfmMcZQzPdsPB7V5oQfI7+ir+k7WW5IvqXA
         UG96iEM3WAbfHtvjtAGNzfz6Sq+PSPGS8ALvuzaB6hYWmWMEVONFlpFH6K7pIkr3d1o+
         5QuoEYIQS3LzRBMtyRjIAw0ovDPuexZjo+TlvYj5ZgLBCTaT932sPEclPiIvzkD7ZMNH
         lj1T+eoOAMx0KVh7OS0Lcav2SeANmIfSMFWNAfm4HquzSOqIB4s+wrTMXXDRLz6qQeWe
         nEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zvYy2WCR9QMih3XiDnl+CR4jwAqudFX5LXJtq32Rx7I=;
        b=oUi0t3Pk6h3OVW0yzsvf7Jizg4uiNBoRANZyUAQStf7qJ2fijJfbIJIi9YvfZG5AeC
         Pkeq5dSlw0nuRuAzlVIAIDwDxiJu+zR1yUlxGecnIsfGWXs6zT8FPq7UYAp51tjrfmw4
         FHLqCgiTZ/ifDK8iSFw7E8hcCVuTf6b2wLiZWud3KHqadrCAQGke8kSlr8GGTUwUTZx3
         hYx+y2mU7Y7TYe+gpymuKTV9q5iqd7iIKqqLCChcp1NGuXz07MBntx+Or3+RKlCfJph4
         tEA7aoOz8IEfFOGfgzMlW4pP0fEHe/ydWclSRIA/di9YJTLq0+XgQ58r/EhgvBmq7CMM
         OE8Q==
X-Gm-Message-State: APjAAAWD50msBFZ0TuwPCpZH19zVi8vQOHymrDodqISLkZ0zDUELsrLY
        t1BMRcbZ/qZER1d2O5ZwEtg22CfpMzoWd5470MwvoA==
X-Google-Smtp-Source: APXvYqzC7z4GICLVjYssHFdixy2m6rtK2W8nOKJiEhbMcitjomj08k+CVwXV93sSXDJ0dWCVXWqimaxLzkSQua3zB10=
X-Received: by 2002:a05:6638:76c:: with SMTP id y12mr10675739jad.95.1576196753710;
 Thu, 12 Dec 2019 16:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20191127001313.183170-1-zenczykowski@gmail.com>
 <20191127131407.GA377783@localhost.localdomain> <CANP3RGePJ+z1t8oq-QS1tcwEYWanPHPargKpHkZZGiT4jMa6xw@mail.gmail.com>
 <20191127230001.GO388551@localhost.localdomain>
In-Reply-To: <20191127230001.GO388551@localhost.localdomain>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Fri, 13 Dec 2019 09:25:42 +0900
Message-ID: <CAKD1Yr1jAv4ouHKu+wA-_basvzY3tN==QMq9u+4fmvpOHLBh1Q@mail.gmail.com>
Subject: Re: [PATCH] net: introduce ip_local_unbindable_ports sysctl
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
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

On Thu, Nov 28, 2019 at 8:00 AM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
> I'm no SELinux expert, but my /etc/ssh/sshd_config has this nice handy
> comment:
> # If you want to change the port on a SELinux system, you have to tell
> # SELinux about this change.
> # semanage port -a -t ssh_port_t -p tcp #PORTNUMBER
>
> The kernel has no specific knowledge of 'ssh_port_t' and all I need to
> do to allow such port, is run the command above. No compiler, etc.
> The distribution would have to have a policy, say,
> 'unbindable_ports_t', and it could work similarly, I suppose, but I
> have no knowledge on this part.

For security reasons, Android does not allow reloading selinux policy
after boot. I'm not a selinux expert either, but semanage-port(8) has:

       -N, --noreload
              Do not reload policy after commit

which suggests that it works by reloading the policy.
