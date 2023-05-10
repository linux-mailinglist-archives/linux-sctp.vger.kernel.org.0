Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9906FE616
	for <lists+linux-sctp@lfdr.de>; Wed, 10 May 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjEJVWr (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 10 May 2023 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEJVWq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 10 May 2023 17:22:46 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010AB2711
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 14:22:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so3695795b3a.3
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683753763; x=1686345763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh63bNXirjYlRC/jjf1XoYxHkBysYc037BusnA4bKgc=;
        b=qpFq5DN35+iZ3b0ZEsilIjueJskUlMqkFjMdlpH5/bEyxcnD8iSjOShjB4RwIYMmDA
         U0qcftPEhKVYcefqB6iYXK0jc9GwWazTC+dF+niR9z4xJ8SqKuWhEUDg9MYh0yjfZf4P
         suO1EjZdNi1pTBkecVsut9ZRb8gv/BDyJNkR8glJC2zWC7xlygGf8om6OVeipxO2T/+h
         rpf7sgoMSFKSWFGMYV7KdOkWMg+AMmQ3jb41XT+2tyBBj5j39bVbIMWAdPrMZOXcgG8c
         P2tzR1xJk/YPsfPucN49M9FgQvlJE1NhIzmvkbQh5jfs4eS7EodT3opF+uSjA8qL4TeM
         HpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683753763; x=1686345763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fh63bNXirjYlRC/jjf1XoYxHkBysYc037BusnA4bKgc=;
        b=F6VhnbsHn77Nkpv7ypIYepm63qbdFP7udHGM6XmX2xBZwFgRovMIqfGbjdco5NfGOV
         fFxAq+NT2ksTMJSKFrC5lKDbFKb/LIsaxRArR+uwRuMrslV4SdJNUaTyFMelZuZd9R9C
         lwr0+CYRfFI0C5/xRaOGW5tkQ7rEBUG3uH82Oo35pgxFT5j/jOwdES64jUuaGOLxikHs
         NmImDBuvhMyP8Ru6rTTM16Yg2zNPO0EQ897nmlRM15X94JPj++p361yz8B/wLruVYUKm
         RwuTUPaCknhpHJCroxi9rZfo3t/xS8jja/b7S/WCTr+dgraukydfbzI4XWi29dtUDLf8
         YYJQ==
X-Gm-Message-State: AC+VfDyufvO2aA/bE+NY5E/r1DSRSpetfN0xYcbbvPLn2p2T+Oy3bPF0
        VbZiSxFghK6Bb6oAfaWsLCokF3iMO1qqyvZ6uXMDesQLXThstnFR6LnKPvm+
X-Google-Smtp-Source: ACHHUZ4F60zdJfIGVeCFZMEiO2jO/sYbxXLpD1rC/KOF0HnGT2QEgARPFh8eZpBazOC9fVSVJsCADrLcXeMsvuVsUcg=
X-Received: by 2002:a17:903:1d0:b0:1ac:7624:51d7 with SMTP id
 e16-20020a17090301d000b001ac762451d7mr12148111plh.69.1683753763223; Wed, 10
 May 2023 14:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230510131527.1244929-1-aleksandr.mikhalitsyn@canonical.com>
 <ZFusunmfAaQVmBE2@t14s.localdomain> <CAEivzxdfZaLD40cBKo7aqiwspwBeqeULR+RAv6jJ_wo-zV6UpQ@mail.gmail.com>
 <ZFu1qNUfV73dLUuo@t14s.localdomain>
In-Reply-To: <ZFu1qNUfV73dLUuo@t14s.localdomain>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 10 May 2023 14:22:32 -0700
Message-ID: <CAKH8qBttFS0-82tNFxnVaJfA489WoA=THuc7YzWtYNfatzaaZg@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: add bpf_bypass_getsockopt proto callback
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        nhorman@tuxdriver.com, davem@davemloft.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 10, 2023 at 8:18=E2=80=AFAM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Wed, May 10, 2023 at 04:55:37PM +0200, Aleksandr Mikhalitsyn wrote:
> > On Wed, May 10, 2023 at 4:39=E2=80=AFPM Marcelo Ricardo Leitner
> > <marcelo.leitner@gmail.com> wrote:
> > >
> > > On Wed, May 10, 2023 at 03:15:27PM +0200, Alexander Mikhalitsyn wrote=
:
> > > > Add bpf_bypass_getsockopt proto callback and filter out
> > > > SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
> > > > from running eBPF hook on them.
> > > >
> > > > These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOP=
T
> > > > hook returns an error after success of the original handler
> > > > sctp_getsockopt(...), userspace will receive an error from getsocko=
pt
> > > > syscall and will be not aware that fd was successfully installed in=
to fdtable.
> > > >
> > > > This patch was born as a result of discussion around a new SCM_PIDF=
D interface:
> > > > https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikha=
litsyn@canonical.com/
> > >
> > > I read some of the emails in there but I don't get why the fd leak is
> > > special here. I mean, I get that it leaks, but masking the error
> > > return like this can lead to several other problems in the applicatio=
n
> > > as well.
> > >
> > > For example, SCTP_SOCKOPT_CONNECTX3 will trigger a connect(). If it
> > > failed, and the hook returns success, the user app will at least log =
a
> > > wrong "connection successful".
> > >
> > > If the hook can't be responsible for cleaning up before returning a
> > > different value, then maybe we want to extend the list of sockopts in
> > > here. AFAICT these would be the 3 most critical sockopts.
> > >
> >
> > Dear Marcelo,
>
> Hello!
>
> >
> > Thanks for pointing this out. Initially this problem was discovered by
> > Christian Brauner and for SO_PEERPIDFD (a new SOL_SOCKET option that
> > we want to add),
> > after this I decided to check if we do fd_install in any other socket
> > options in the kernel and found that we have 2 cases in SCTP. It was
> > an accidental finding. :)
> >
> > So, this patch isn't specific to fd_install things and probably we
> > should filter out bpf hook from being called for other socket options
> > as well.
>
> Understood.
>
> >
> > So, I need to filter out SCTP_SOCKOPT_CONNECTX3 and
> > SCTP_SOCKOPT_PEELOFF* for SCTP, right?
>
> Gotta say, it seems weird that it will filter out some of the most
> important sockopts. But I'm not acquainted to bpf hooks so I won't
> question (much? :) ) that.

Thanks for raising this. Alexander, maybe you can respin your v2 to
include these as well?

> Considering that filtering is needed, then yes, on getsock those are
> ones I'm seeing that needs filtering. Otherwise they will either
> trigger leakage or will confuse the application.

[..]

> Should we care about setsock as well? We have SCTP_SOCKOPT_CONNECTX
> and SCTP_SOCKOPT_CONNECTX_OLD in there, and well, I guess any of those
> would misbehave if they failed and yet the hook returns success.

For setsockopt, the bpf program runs before the kernel, so setsockopt
shouldn't have those issues we're observing with getsockopt (which
runs after the kernel and has an option to ignore kernel value).

> Thanks,
> Marcelo
