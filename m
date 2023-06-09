Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3CB72A689
	for <lists+linux-sctp@lfdr.de>; Sat, 10 Jun 2023 01:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjFIXFH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 9 Jun 2023 19:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFIXFG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 9 Jun 2023 19:05:06 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F541BD6;
        Fri,  9 Jun 2023 16:05:03 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565ba53f434so21295047b3.3;
        Fri, 09 Jun 2023 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686351903; x=1688943903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oncrJjFZA1GZlKxOKLKv1IaUd8g/BdW4cvv62JBXVqg=;
        b=GnRyLF1kOkuUQ8h6eyBFN8Kqy+BU3uIqiVC0ddspBTjL2zLUK+b8QorBQWNJikxdfP
         YX1n6MtRY1r6GPfuquXxPn+SQYcV9Vpom5siwolpxOpPALGSESxHBnWkj5aNZXZLVhxs
         GbtPmYXVr3Dr8YsEnevBLOP06G2zan6lLhGwVf+ouNZG30qeyLUurO3v2+IcGMd6MsNV
         yaYFNQ4cVNJwOVk4Q1Gq32OA6/Ppdcfo5WyTlMnty2FMe9LAj9Elujqk24CwEv/cQcyV
         mSuDi1UTWmDUOwnEP9D0WrQFWtdmk95yh8oF3PWI/0fvDQiukbz+aGbq6joz2T/DH/o3
         mrew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686351903; x=1688943903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oncrJjFZA1GZlKxOKLKv1IaUd8g/BdW4cvv62JBXVqg=;
        b=fGp2Fxi+F0ePYgU5iAN5WW/QXSakuQjfs1MiG9f2r94vzhkQYwSAgvJezXnX39Ag3X
         a8kBJ77kTfKgnTR7bd4voCvkSc9V976hFWv/VNaP3WfKJftYzNKK5YmJpin0QgYuZvPe
         /1NOCoCtzdNuZMVdATu0SqfK2K+a2NHzLbwcectwlJN6FBCdeWhOIftIiYoirRbbPs5t
         YiEh2Re6CO9Aw6/qO4jvG+ioT36BZikhIVO8HGs6dEe090wze8r5Nz1HgoPj3r4Wcil6
         RPrBNblnqSHUVDvfyhnlOz6CIglrefWS6eLP8IKHLIooLbkMU8SoMUP06lzNDDePnifL
         cxrw==
X-Gm-Message-State: AC+VfDyTjmEWtGvfe+O/7fegjMwwFVzfWrGjKhoLw8IM6F7hHCBD6gb0
        kwLSQ4+Uvap3zl/vTLfF4u9n1//9r5grEReuyOzPCpPfjEM=
X-Google-Smtp-Source: ACHHUZ6Z849Y02btYZx4czH7qwqvfVQrkYUmf7tcFvvPZQOG3Z4CGE8X1jqRImcg4QCgByH0/Bxlv0jWSeGPBHNhPNE=
X-Received: by 2002:a5b:f8d:0:b0:ba8:ae3a:dd39 with SMTP id
 q13-20020a5b0f8d000000b00ba8ae3add39mr2246245ybh.43.1686351902956; Fri, 09
 Jun 2023 16:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <4629fee1-4c9f-4930-a210-beb7921fa5b3@moroto.mountain>
 <bfb9c077-b9a6-47f4-8cd8-a7a86b056a21@moroto.mountain> <CADvbK_f25PEaR1bSuyqeGQsoOp0v1Psaeu2zPhfEi8Zcu-J5Tw@mail.gmail.com>
 <7899ff13-ab06-4970-a306-85b218486571@kadam.mountain>
In-Reply-To: <7899ff13-ab06-4970-a306-85b218486571@kadam.mountain>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 9 Jun 2023 19:04:17 -0400
Message-ID: <CADvbK_e2JwH3OqFSu89EvrtGbBbuCvD-C=Db_sExjvD1EcVLrw@mail.gmail.com>
Subject: Re: [PATCH 2/2 net] sctp: fix an error code in sctp_sf_eat_auth()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Vlad Yasevich <vladislav.yasevich@hp.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jun 9, 2023 at 12:41=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Jun 09, 2023 at 11:13:03AM -0400, Xin Long wrote:
> > This one looks good to me.
> >
> > But for the patch 1/2 (somehow it doesn't show up in my mailbox):
> >
> >   default:
> >   pr_err("impossible disposition %d in state %d, event_type %d, event_i=
d %d\n",
> >         status, state, event_type, subtype.chunk);
> > - BUG();
> > + error =3D status;
> > + if (error >=3D 0)
> > + error =3D -EINVAL;
> > + WARN_ON_ONCE(1);
> >
> > I think from the sctp_do_sm() perspective, it expects the state_fn
> > status only from
> > enum sctp_disposition. It is a BUG to receive any other values and
> > must be fixed,
> > as you did in 2/2. It does the same thing as other functions in SCTP co=
de, like
> > sctp_sf_eat_data_*(), sctp_retransmit() etc.
>
> It is a bug, sure.  And after my patch is applied it will still trigger
> a stack trace.  But we should only call the actual BUG() function
> in order to prevent filesystem corruption or a privilege escalation or
> something along those lines.
Hi, Dan,

Sorry, I'm not sure about this.

Look at the places where it's using  BUG(), it's not exactly the case, like
in ping_err() or ping_common_sendmsg(), BUG() are used more for
unexpected cases, which don't cause any filesystem corruption or a
privilege escalation.

You may also check more others under net/*.

>
> Calling BUG() makes the system unusable so it makes bugs harder to
> debug.  This is even mentioned in checkpatch.pl "Do not crash the kernel
> unless it is absolutely unavoidable--use WARN_ON_ONCE() plus recovery
> code (if feasible) instead of BUG() or variants".
>
"absolutely unavoidable", I think in a module, if it gets a case that is no=
t
expected at all, and the consequence (it may cause or has caused) is
unsure, WARN_ON_ONCE() is not enough.

Thanks.
