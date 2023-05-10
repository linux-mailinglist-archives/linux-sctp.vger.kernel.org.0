Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904A86FE16A
	for <lists+linux-sctp@lfdr.de>; Wed, 10 May 2023 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbjEJPSH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 10 May 2023 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237074AbjEJPSG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 10 May 2023 11:18:06 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F1430C3;
        Wed, 10 May 2023 08:18:04 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1929818d7faso45062241fac.0;
        Wed, 10 May 2023 08:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731883; x=1686323883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vKN1IVVJJS+z5UGi92VgQNhrRecjrmCxzy9d2ybrSU=;
        b=kLZWPcSUTqYtBPEtVChsLoN2op4bc2ZMgpj6sMV12v86NorVv1qrKcLnQNY3I52XVY
         V4yFHcNcraPCvdr+w3Unook3QtAw08GCV7acjTru2e+NSF0AY3y0Kv/8zqOuhfDXri5S
         hJfICSoygrYX/HnmqG6kgMrbEnUnbEqETFudX9zJuzRt87BAszymUNpP0QYzbj0MB4lN
         kqkl4MG794MyEF//hswQXmKS4qo4QGba2Wu90r+MEEnShEF2JoolauPRXCB5afR3vCFd
         hYqugKDulfeejOVNDXn7QMgODdhmAt/wreDbSg6c2xqvC6T0xg60ofDmYmRQSw0E8dH2
         2y1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731883; x=1686323883;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6vKN1IVVJJS+z5UGi92VgQNhrRecjrmCxzy9d2ybrSU=;
        b=Rh3vfpK0R33SA+SJEPA+7V7G+/npDpoJulafMPUNNF7JiD8zjnf/0fjffDDrb52sMA
         Xby7Pm6+hvNCCgOtPQYJfTPJ9gw5OqqMUM1xMWZqzzA/MzWH+B6Rvs0HzUIw2sIKB6E+
         mDrA56FESsWtAme+XSTYqswnPF4LgoURL29VcPuYZe1yqQbaV9ZmZN9UdRuGFa1/GdKd
         0KxTmLtd/3onsiab1ZOVCHSUJnCu/6g5UhRgv+GiqqGMcDSo6MicfZPTC10ErIa8vKfV
         qQ6G+i/SgohPeKwsETRMCjDGG7nUYiNofw7d+ogbTIwmqq6o5WNgVbsLgkxu3m4hHf6m
         gVEQ==
X-Gm-Message-State: AC+VfDyzxuU3ygWln2ZaF6JQvlXP3cpnMRe4D3WJsM8GpUebipyvmlCc
        /r9nOXehNAomtCQti8GzCuU=
X-Google-Smtp-Source: ACHHUZ69TEuCpnFerrE41O2CXpfL+UFB0vPeDxp6ZfC5BeL2c7DdqRmha1tRH/64rklqyV+oTMRCiA==
X-Received: by 2002:a05:6830:310a:b0:6ab:3c0:7fe7 with SMTP id b10-20020a056830310a00b006ab03c07fe7mr3723009ots.14.1683731883250;
        Wed, 10 May 2023 08:18:03 -0700 (PDT)
Received: from t14s.localdomain ([177.92.48.137])
        by smtp.gmail.com with ESMTPSA id d12-20020a05683018ec00b006ab13915cd4sm2118383otf.81.2023.05.10.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 08:18:02 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 349DF616DBA; Wed, 10 May 2023 12:18:00 -0300 (-03)
Date:   Wed, 10 May 2023 12:18:00 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc:     nhorman@tuxdriver.com, davem@davemloft.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: add bpf_bypass_getsockopt proto callback
Message-ID: <ZFu1qNUfV73dLUuo@t14s.localdomain>
References: <20230510131527.1244929-1-aleksandr.mikhalitsyn@canonical.com>
 <ZFusunmfAaQVmBE2@t14s.localdomain>
 <CAEivzxdfZaLD40cBKo7aqiwspwBeqeULR+RAv6jJ_wo-zV6UpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEivzxdfZaLD40cBKo7aqiwspwBeqeULR+RAv6jJ_wo-zV6UpQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 10, 2023 at 04:55:37PM +0200, Aleksandr Mikhalitsyn wrote:
> On Wed, May 10, 2023 at 4:39 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Wed, May 10, 2023 at 03:15:27PM +0200, Alexander Mikhalitsyn wrote:
> > > Add bpf_bypass_getsockopt proto callback and filter out
> > > SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
> > > from running eBPF hook on them.
> > >
> > > These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
> > > hook returns an error after success of the original handler
> > > sctp_getsockopt(...), userspace will receive an error from getsockopt
> > > syscall and will be not aware that fd was successfully installed into fdtable.
> > >
> > > This patch was born as a result of discussion around a new SCM_PIDFD interface:
> > > https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalitsyn@canonical.com/
> >
> > I read some of the emails in there but I don't get why the fd leak is
> > special here. I mean, I get that it leaks, but masking the error
> > return like this can lead to several other problems in the application
> > as well.
> >
> > For example, SCTP_SOCKOPT_CONNECTX3 will trigger a connect(). If it
> > failed, and the hook returns success, the user app will at least log a
> > wrong "connection successful".
> >
> > If the hook can't be responsible for cleaning up before returning a
> > different value, then maybe we want to extend the list of sockopts in
> > here. AFAICT these would be the 3 most critical sockopts.
> >
> 
> Dear Marcelo,

Hello!

> 
> Thanks for pointing this out. Initially this problem was discovered by
> Christian Brauner and for SO_PEERPIDFD (a new SOL_SOCKET option that
> we want to add),
> after this I decided to check if we do fd_install in any other socket
> options in the kernel and found that we have 2 cases in SCTP. It was
> an accidental finding. :)
> 
> So, this patch isn't specific to fd_install things and probably we
> should filter out bpf hook from being called for other socket options
> as well.

Understood.

> 
> So, I need to filter out SCTP_SOCKOPT_CONNECTX3 and
> SCTP_SOCKOPT_PEELOFF* for SCTP, right?

Gotta say, it seems weird that it will filter out some of the most
important sockopts. But I'm not acquainted to bpf hooks so I won't
question (much? :) ) that.

Considering that filtering is needed, then yes, on getsock those are
ones I'm seeing that needs filtering. Otherwise they will either
trigger leakage or will confuse the application.

Should we care about setsock as well? We have SCTP_SOCKOPT_CONNECTX
and SCTP_SOCKOPT_CONNECTX_OLD in there, and well, I guess any of those
would misbehave if they failed and yet the hook returns success.

Thanks,
Marcelo
