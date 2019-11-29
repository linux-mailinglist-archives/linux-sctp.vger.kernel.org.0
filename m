Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408F010D80C
	for <lists+linux-sctp@lfdr.de>; Fri, 29 Nov 2019 16:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfK2Pqp (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 29 Nov 2019 10:46:45 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46552 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfK2Pqp (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 29 Nov 2019 10:46:45 -0500
Received: by mail-ot1-f46.google.com with SMTP id n23so25172071otr.13
        for <linux-sctp@vger.kernel.org>; Fri, 29 Nov 2019 07:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=QoFUqGUiuF0JgEkQL4Z1hQmEfCfkdh4ABszsrHTlCNU=;
        b=IXfPFxHK6z42I3ct2ez9OIMjkNmD58DNpPhcrFcC9zqR5cwsBRvEB0mjVpgwwPa44U
         /ccgZy90CkAeZP9W9EA32Grtsc5w2VLo/w968/ZGQxjUfAmnm9IKmbPcqX8Yq99G0+MF
         RMKAtflOJ8m6+JEfW9SuI/nG/I0h55OoEF4gK1igZFk1xhuRnTsCseszHYE8OAacnp4l
         cA54k/HMUg7Tw7qYFnaAUXvsiTCN8tJCohqZ+J+O6MSuBfOEqrRqeN9lh4XSrL9mp2Kx
         pUIESnO+8+GvURRO8DZ8UWwEK5spORRRfugDKKne3B9h1s4VLXMyOcFZ+4K7fyeF4kqO
         gZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=QoFUqGUiuF0JgEkQL4Z1hQmEfCfkdh4ABszsrHTlCNU=;
        b=i2rC94xTfecYSdiJEkrae/r4MqNTMATZtBmRkQ2qOM4RVTha+v2RTkJrRlEiiWKAkf
         mpgu6+EDmCPFuZUb3u7iZP3Icy6pfOsELszm7TnQN6BbVEqzq6vmSk2WR0v1+1qnx+ei
         asc2gngy64LHecV/w9x9UXlfqOCCJayvLvszR+iaFEfvF2UevFIZohJYdCoVSvLJQ7zL
         xksrK7c+8nosckYOZTw0p2fsMjrqbVtXAsrlxbgmnBCUpvDnXZXaFx9tNQiatlKGCr5z
         v/+H7o0zYDfeL4zsTsMVqSpjyNo7DMIFvVpN9n2FNrFXfcjPKimX6PEmTrlggi1znNxk
         wAEQ==
X-Gm-Message-State: APjAAAUalJ73JAcabei1iHrzLuZOhoiEglbB1K0weALCr5cIPmt+RlBh
        fk/a1CxetIyIWGhElt0cfb6npTMEZSuSzhjU9K72wJOc
X-Google-Smtp-Source: APXvYqwZTO4xOyz1p53k5bEY8vy66hMIE3fmaso11fe8RCr3+AHn1LkmF4M178wkCGRtQyAxAWXtlyUe/aGMImNJL1Q=
X-Received: by 2002:a9d:28f:: with SMTP id 15mr11889266otl.311.1575042402176;
 Fri, 29 Nov 2019 07:46:42 -0800 (PST)
MIME-Version: 1.0
References: <CANpxKHFkTApZufGkL-7JSwt0BqTmPpp1=77jVhrqHZdo74e0Sw@mail.gmail.com>
In-Reply-To: <CANpxKHFkTApZufGkL-7JSwt0BqTmPpp1=77jVhrqHZdo74e0Sw@mail.gmail.com>
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Fri, 29 Nov 2019 22:46:31 +0700
Message-ID: <CANpxKHFDw8G9G8Vz3S9ELGSnrkJOV3Paqb9AN-kcd+PzmYy7jg@mail.gmail.com>
Subject: Re: SCTP conntrack does not track init chunk types
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

Could you please help this question?

Many thanks,
Brs
Naruto

On Thu, 28 Nov 2019 at 18:36, Naruto Nguyen <narutonguyen2018@gmail.com> wrote:
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
>
> looks like it cannot drop INIT_ACK and connection from client is setup
> well. Could you please tell me if SCTP conntrack can drop INIT_ACK,
> COOKIE_ACK? My conntrack log does not show any INIT, INIT_ACK,
> COOKIE_ACK
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
>
> Brs,
> Naruto
