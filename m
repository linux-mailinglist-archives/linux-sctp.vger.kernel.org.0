Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8011264B
	for <lists+linux-sctp@lfdr.de>; Wed,  4 Dec 2019 10:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfLDJCZ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 4 Dec 2019 04:02:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33156 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfLDJCZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 4 Dec 2019 04:02:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so7603528wrq.0
        for <linux-sctp@vger.kernel.org>; Wed, 04 Dec 2019 01:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQzcWgNunOSnBB320/YGc4x51+SJPy9UF4Qzva6XEsc=;
        b=CmwcIeFHgkd28HXJlZYQ4jyw7Rqs3PvDXWxQNdMOXYv+9dsGySB/d/A8fThII7kUVH
         ucIdljhs7BdqB2c6lPgcTxexJq7CO1X5RM32FZrkaidozUtOfPfu5dNBcN1IPZqmpXrn
         /D03ucUw8ynxJUs779QeDexPJ6DLJLKoSsiyjIoqPP5A32oZ3VMMIIgkcKdUuq2Fps35
         iwN+6rwrOF0+EoebNxnFoO93O5idK93Pr+CLJGbG85cd9aDR2JCe/GWtQuP+6eBY4R7a
         LLmc8IGqDdKQ9cDqr9ZUb2m1iYQdZ5FWBvVGjU5ovhS1Ir4HAu8hKH6ngdBTJJ26WKl4
         qTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQzcWgNunOSnBB320/YGc4x51+SJPy9UF4Qzva6XEsc=;
        b=TwomIbZwIZ7J3zaD5cjctqiB1vIQEzfv6pqzZ8Jgey/X4dVo08UMOrRB8hSf5ica1I
         xhXc/kKj1i6UiZ1tV8sFMRsW+7A6WOXEdtaWdHiuAwYUmLpDcvI8eX+sajObQnrpXig9
         ekQ4z54L/rWZBUgjE3i/ewIK3q0qIvzY+KgzxJRv7G5EIh2RMebJ8sgUlAABJYAkLAe7
         CmoMdMP9QJ2Mb4SvWr90kORlpte5+yFa06H19Q5ptHR53t1sJpOaGj0+qENtNxoPR6Iw
         xs/T96RU0cv8WX5lNJeVwN6NwByxYmKdPkkIB0xx3Cw2u3A0qx18q0YMtquazms+8beh
         cYXA==
X-Gm-Message-State: APjAAAWbp0M4ML4liS1BDX9SvXpAFKho2AA0Uxjs9IfLwSh3zgukgWxl
        7x20z7PSZRJ+sS2OlsRUBjh+RKiDOzsYxNZOF10UjIxB
X-Google-Smtp-Source: APXvYqzmD4qKpNIGJgtJNwOdnnB53gOVBHT+K3sH0URDGyYarVD3GxSIaoxXBXh2AsFEpIl3EhEmlgvGYGTQPGMiJbI=
X-Received: by 2002:adf:f605:: with SMTP id t5mr2665054wrp.282.1575450142532;
 Wed, 04 Dec 2019 01:02:22 -0800 (PST)
MIME-Version: 1.0
References: <CANpxKHFkTApZufGkL-7JSwt0BqTmPpp1=77jVhrqHZdo74e0Sw@mail.gmail.com>
In-Reply-To: <CANpxKHFkTApZufGkL-7JSwt0BqTmPpp1=77jVhrqHZdo74e0Sw@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 4 Dec 2019 17:02:28 +0800
Message-ID: <CADvbK_frK_WY2=J1MAjG9-f07+WoKjRKiqDjL5YrOFDhd4bk6A@mail.gmail.com>
Subject: Re: SCTP conntrack does not track init chunk types
To:     Naruto Nguyen <narutonguyen2018@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Nov 28, 2019 at 7:37 PM Naruto Nguyen
<narutonguyen2018@gmail.com> wrote:
>
> Hi everyone,
>
> I have followed a simple SCTP server and SCTP client at
> http://simplestcodings.blogspot.com/2010/08/sctp-server-client-implementation-in-c.html
>
> It works well. Client and server can communicate successfully. Then I
> tried to set up an iptable rule to drop INIT package on server node
>
> iptables -A INPUT -p sctp  -m conntrack --ctstate NEW -m sctp
> --chunk-types any INIT -j DROP
>
> It can drop and connection cannot establish from client anymore.
> However, when I tried to drop INIT_ACK sent from server by
>
> iptables -A OUTPUT -p sctp  -m conntrack --ctstate NEW -m sctp
> --chunk-types any INIT_ACK -j DROP
I think INIT_ACK as a reply dir packet, the conntrack ctstate may not be NEW.
can you pls try with others, like ESTABLISHED, RELATED or so.

>
> looks like it cannot drop INIT_ACK and connection from client is setup
> well. Could you please tell me if SCTP conntrack can drop INIT_ACK,
> COOKIE_ACK? My conntrack log does not show any INIT, INIT_ACK,
> COOKIE_ACK
what do you mean, show INIT and INIT_ACK, those are packet types.
you can see the sctp asoc state, like COOKIE_ECHOED, ESTABLISHED.

>
> [NEW] sctp     132 3 src=199.569.9.50 dst=199.569.9.51 sport=57295
> dport=62324 [UNREPLIED] src=199.569.9.51 dst=199.569.9.50 sport=62324
> dport=57295
>  [UPDATE] sctp     132 3 src=199.569.9.50 dst=199.569.9.51 sport=57295
> dport=62324 src=199.569.9.51 dst=199.569.9.50 sport=62324 dport=57295
>  [UPDATE] sctp     132 3 COOKIE_ECHOED src=199.569.9.50
> dst=199.569.9.51 sport=57295 dport=62324 src=199.569.9.51
> dst=199.569.9.50 sport=62324 dport=57295
>  [UPDATE] sctp     132 432000 ESTABLISHED src=199.569.9.50
> dst=199.569.9.51 sport=57295 dport=62324 src=199.569.9.51
> dst=199.569.9.50 sport=62324 dport=57295 [ASSURED]
>
> Is it expected? In tcp, conntrack log can show SYN_SENT/ SYN_RECEIVED.
I think so.
