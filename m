Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BADE14340A8
	for <lists+linux-sctp@lfdr.de>; Tue, 19 Oct 2021 23:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhJSViK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 Oct 2021 17:38:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50760 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhJSViK (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 19 Oct 2021 17:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634679356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+z9sUEXeMHBny3A0BMFFE13nfpaVL6iqbt5g5hK0+WQ=;
        b=fzyrvJbMM0QrC7HUxYSnPv+USRuwIIQCjO2Jnf6+prCdVutZbRNZLMJzcq7vT6VtrAakcb
        sIhn8hYJqyRcjIoa69+psgquV900xn1URMsWOhzWsZB9BNKlF48+DrefJsXJxbiTXLSaWQ
        hEaEplgvaU46sif8Xc2raO2SzuZ9ksM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-LeZQOxsNOJKp4SU65C4cvQ-1; Tue, 19 Oct 2021 17:35:54 -0400
X-MC-Unique: LeZQOxsNOJKp4SU65C4cvQ-1
Received: by mail-il1-f198.google.com with SMTP id e2-20020a92de42000000b00259b6803abfso2393324ilr.1
        for <linux-sctp@vger.kernel.org>; Tue, 19 Oct 2021 14:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=+z9sUEXeMHBny3A0BMFFE13nfpaVL6iqbt5g5hK0+WQ=;
        b=oKMDa9ApqcT42+soaaIXQGTIbjVSnyW7DZ/DadjeObfwMNuoqsVVarnonXElp5RCB1
         KbTm75ytKlPRyrexCe8Z+Xa8IhpzMPSudsnhaxYyhO/k9r4q5fkQ/uPkDP3PlJ0fi0sk
         vnQvzEx6DYWqiWGy8PUVM/9L7+Q1RqwJajgBkOWkgtbKnB452JbtUIC3+ReX6MltxwXd
         WhHtG+aDaH5E4Js7XyYTLc+00ysf3B4OmLo0u2i0hfEbhWFSRLknYdxq5b5mIkU8jwyQ
         FlAN5qFkRVBKiTM1rXq/BlXYBR3eZDkEWymQ7Gdqa8e0KKbMOy/WZWTIqpnTKtQ6Jbkf
         fPMg==
X-Gm-Message-State: AOAM533WAtZ7HUXTlZ0ySj1ZN6MfdBtpL3fT6IG1kx02IP29VAD+ulSr
        mzbOfIRNSAfBdTnB5S4JTIMxnHJ2SbdFMWsYoQAxKmy36j2Kz/3rCdk0Nj7/MaMgmqjAJdGGJET
        ms6I26XgKdnsTy4enwHkBJslwwDO3/TzRsO811w==
X-Received: by 2002:a05:6e02:1588:: with SMTP id m8mr20083923ilu.188.1634679353916;
        Tue, 19 Oct 2021 14:35:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyw5ONeJZy+mYcWW1CoSmDnkLeVTp0YYYOQrPNWXVSlllpoHMsXiGQvnX0kmZRAJiCP0i79Pbd4v7ak9gwdwLc=
X-Received: by 2002:a05:6e02:1588:: with SMTP id m8mr20083911ilu.188.1634679353743;
 Tue, 19 Oct 2021 14:35:53 -0700 (PDT)
Received: from 868169051519 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Oct 2021 14:35:53 -0700
From:   Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <4f9d3a13-2104-ec1c-dbc7-12de1f99ea0e@oracle.com>
 <CALnP8ZZ7UbEzc0+VVpwucbBqNfgTqOk-LN8BwjbtL8-CbzOY6Q@mail.gmail.com> <bb302bd6-093b-2d21-801a-4f613ef39098@oracle.com>
MIME-Version: 1.0
In-Reply-To: <bb302bd6-093b-2d21-801a-4f613ef39098@oracle.com>
Date:   Tue, 19 Oct 2021 14:35:53 -0700
Message-ID: <CALnP8Zbc2oxPc8qL-yYqD0a-9eoaLHn0K802kTVjL7igq_SbFw@mail.gmail.com>
Subject: Re: syzkaller test panic: Linux 5.4.y
To:     john.p.donnelly@oracle.com
Cc:     linux-sctp@vger.kernel.org,
        Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mleitner@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Oct 19, 2021 at 03:05:24PM -0500, john.p.donnelly@oracle.com wrote:
> On 10/19/21 10:24 AM, mleitner@redhat.com wrote:
> > Hi John,
> >
> > On Mon, Oct 18, 2021 at 04:29:58PM -0500, john.p.donnelly@oracle.com wrote:
> > >    Call Trace:
> > >     skb_put+0x4c/0x4c
> > >     sctp_addto_chunk+0x59/0xb0 [sctp]
> > >     sctp_make_strreset_req+0x166/0x180 [sctp]
> > >     sctp_send_reset_streams+0x14d/0x300 [sctp]
> > >     sctp_setsockopt.part.21+0x101f/0x1720 [sctp]
> > >     sctp_setsockopt+0x99/0xb0 [sctp]
> > >     sock_common_setsockopt+0x1a/0x1c
> > >     SyS_setsockopt+0x86/0xe6
> > >     +0x79/0x1ae
> > >     entry_SYSCALL_64_after_hwframe+0x151/0x0
> > >   RIP: 0033:0x7f80bdc21be9
> > >
> > >
> > > I am not familar with any of the sctp subsystem. It was found running the
> > > syzkaller fuzzing test suite.
> > >
> > > If there is a more appropriate place to report this I can do that too. This
> >
> > Here is fine :)
> >
> > > test fails on just about every 4.x and 5.x kernel.  It is not
> > > unique to 5.4.
> >
> > Did the test kernels include commit "sctp: account stream padding
> > length for reconf chunk"? It is a recent fix right on this topic. It
> > should be fixed by it, actually.
> >
> >    Marcelo
> >
>
>
> Hi Marcelo
>
>  I can confirm
>
>
> commit a2d859e3fc97e79d907761550dbc03ff1b36479c
> Author: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> Date:   Wed Oct 13 17:27:29 2021 -0300
>
>     sctp: account stream padding length for reconf chunk
>
> resolves my panic for 5.4.LTS   wrt to
>
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> //  317ef02b0d5cbd19d445294fed91453c7f970fc3.c
>

Sweet!

>
>
> Should be an easy enough fix to apply to older 4.x kernels too.

Right. It's currently scheduled for:
 812   C out 18 Greg Kroah-Hart (1,7K) [PATCH 4.14 26/39] sctp:
account stream padding length for re
 813   C out 18 Greg Kroah-Hart (1,7K) [PATCH 4.19 33/50] sctp:
account stream padding length for re
 814   C out 18 Greg Kroah-Hart (1,7K) [PATCH 5.4 45/69] sctp: account
stream padding length for rec
 815   C out 18 Greg Kroah-Hart (1,7K) [PATCH 5.10 068/103] sctp:
account stream padding length for
 817   C out 18 Greg Kroah-Hart (1,7K) [PATCH 5.14 098/151] sctp:
account stream padding length for

>
> There is suppose to be a format to cc the syz-kaller bot to mark
> 317ef02b0d5cbd19d445294fed91453c7f970fc3 fixed with commit
> a2d859e3fc97e79d907761550dbc03ff1b36479c.
>
> Perhaps mentioning it here will be enough ;-) .

Almost :-)

The report I previously had for this issue didn't come from syzkaller.
I'm not sure if 317ef02 above refers to the Google's instance of what.
Anyway, would mind marking it as fixed then?

Thanks!
Marcelo

