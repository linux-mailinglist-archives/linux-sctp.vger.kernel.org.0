Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 548E410BE47
	for <lists+linux-sctp@lfdr.de>; Wed, 27 Nov 2019 22:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbfK0Vec (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 27 Nov 2019 16:34:32 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34067 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729508AbfK0Uuw (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 27 Nov 2019 15:50:52 -0500
Received: by mail-vs1-f66.google.com with SMTP id y23so16107588vso.1
        for <linux-sctp@vger.kernel.org>; Wed, 27 Nov 2019 12:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bxTp71gDx4DCd0a3JSpVLqspHuGuJwbEEArDGeB+Po8=;
        b=nouOdgGJ3d1+MvP+Ag9r2o6g2+IPm3tn+z+ywoxoQkFIBBb9gRdvxsofgNQvn4UnYT
         EQW44PcvEU1e4QPEt9hnJYJP93TVOlkZjChwmuN2Ms3pxGqc8vDVHTB1EIEj92cx6UyJ
         Bg6cInyUZ/cfRrcunq8PDeKEiASSzIFdKCoiWXtL/YlF1HfVUzWt4h99n0VFRtN3BbSy
         hoEmHY8wVraGA/UqYPLtV01yZfGEGc3+esaXpdZq7+uwJb9BOeBOVSPnX0mTNYaH/Xng
         ArlPzVv1+Ped65fqNx8gDYsfn0CBnDgBLfhNJedffK/s4U868It4RyTiT/KVkGiEU9Ru
         nj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bxTp71gDx4DCd0a3JSpVLqspHuGuJwbEEArDGeB+Po8=;
        b=k1HX2aESQPwkqpLpRYGhsS3s0OZMkahmg6DPI1FFnZoXgrK3qRuTpgyD3OxIuVXJ8C
         rQwwZK0JFN6EhxyfByhuk8JO/skKBzKurxfH3bbqxQCSQ2F2EXtTjZBo022NHv7aMEYC
         Is1Ju25Z7iWmtW1Fi10947ziYEDszldhFqkj4k5ubMrW1k2OD0o4fcMbHF+oSXQa8S4L
         o0ZZgLxyYxD2zDEFIIOjrBLOOhZn2380xppMKDyMI9bnPbliICcsK0Hk4Jf6WbeFC9nY
         zXn6vzh/STL7BUHkJaqZ13rBIX0ZYRtT7VK1Imyc9LRElOmpBNV8HEJQgLr4qAjDdQJg
         NACA==
X-Gm-Message-State: APjAAAWlnmb3dZ3yt8J2fRF1+4ukp1IAjXSl4cr6TIr7FdoXxltPUOOa
        Vxgvd7CGeLqFjYtdWTkIA7023895Y3O8MuHFimdAZQ==
X-Google-Smtp-Source: APXvYqxetDqes9znEtFlShqBOifcylBt1aw/fIhGH+yrmqF47dmU3GgGZnJ/1CzEh0gzLt0sEfge2Ya1weCZFrqELUg=
X-Received: by 2002:a67:e9d6:: with SMTP id q22mr28168421vso.231.1574887850227;
 Wed, 27 Nov 2019 12:50:50 -0800 (PST)
MIME-Version: 1.0
References: <20191127001313.183170-1-zenczykowski@gmail.com> <20191127131407.GA377783@localhost.localdomain>
In-Reply-To: <20191127131407.GA377783@localhost.localdomain>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Wed, 27 Nov 2019 12:50:39 -0800
Message-ID: <CANP3RGePJ+z1t8oq-QS1tcwEYWanPHPargKpHkZZGiT4jMa6xw@mail.gmail.com>
Subject: Re: [PATCH] net: introduce ip_local_unbindable_ports sysctl
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Linux NetDev <netdev@vger.kernel.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux SCTP <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Nov 27, 2019 at 5:14 AM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Tue, Nov 26, 2019 at 04:13:13PM -0800, Maciej =C5=BBenczykowski wrote:
> > From: Maciej =C5=BBenczykowski <maze@google.com>
> >
> > and associated inet_is_local_unbindable_port() helper function:
> > use it to make explicitly binding to an unbindable port return
> > -EPERM 'Operation not permitted'.
> >
> > Autobind doesn't honour this new sysctl since:
> >   (a) you can simply set both if that's the behaviour you desire
> >   (b) there could be a use for preventing explicit while allowing auto
> >   (c) it's faster in the relatively critical path of doing port selecti=
on
> >       during connect() to only check one bitmap instead of both
> ...
> > If we *know* that certain ports are simply unusable, then it's better
> > nothing even gets the opportunity to try to use them.  This way we at
> > least get a quick failure, instead of some sort of timeout (or possibly
> > even corruption of the data stream of the non-kernel based use case).
>
> This is doable with SELinux today, no?

Perhaps, but SELinux isn't used by many distros, including the servers
where I have nics that steal some ports.  It's also much much
more difficult, requiring a policy, compilers, etc... and it gets even
more complex if you need to dynamically modify the set of ports,
which requires extra tools and runtime permissions.
