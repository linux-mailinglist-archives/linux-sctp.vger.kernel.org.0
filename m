Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85386FE0D6
	for <lists+linux-sctp@lfdr.de>; Wed, 10 May 2023 16:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbjEJOzz (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 10 May 2023 10:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjEJOzy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 10 May 2023 10:55:54 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1362D72
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 07:55:53 -0700 (PDT)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D068F3F202
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683730549;
        bh=REcjCSTFLW6DxVGPSke0wQC0F9pbu2fUgTklQWt5AuI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=fmZ2wIuGSHsU7PDNHnHnmKrmLcbM6T+MeUK+3KcttiBcAzDs5l+HIGD3g8y4y6Uv8
         MBhgdVWG5HVd7I6OKs2pjTURFG5IIgye/TRtjRO7JCbyV26Olpjr6jlDSMeDRKAc8Q
         HJXPcHkZ4VbpyimBEXUBsf7Eyr+r+rUK9pf9ljQ5aSpTVN0EwBUaKWQQjOHXti0uSX
         so9j+v1o5TduuysxpuAOaMbZajY8QflHAoAnVDO5e4R3C9qgRwRpBl5zDvqpIzEEKS
         1grOw5Oh+LWVqukfwb6LY9n4Z0vlymg3UOTT2TENUFF389cgrnS0LHe3j6uPeo6HQc
         i1RCjputSPwpw==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-55a1aec6693so123247887b3.1
        for <linux-sctp@vger.kernel.org>; Wed, 10 May 2023 07:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683730549; x=1686322549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REcjCSTFLW6DxVGPSke0wQC0F9pbu2fUgTklQWt5AuI=;
        b=BYYsJ3VJoFRHcFlSQON6cGsXorwBS2nprr1gbMCdv+9/K1neR86ODHzhtCUdNd5srq
         x47qGVbms0Fg7qjBjOgfMulRTKBp3O09al++6f7saT/lycGYi/bNalnsoo9ofLuOQcNa
         vZls/iMamQg5iIIaopYo0ID60Zz1H09XjzeJmIbmuVdtZhQrpZckLROXLgWTsqcq6S29
         9h7vgmK8oxoDLvrBRJMO8XXvBjTvL9BXjARFwZPeoyFkuwSXSvpoBzRZYfTwLuvl5CFa
         sdrlDCRJ8dunFPZoM+5SOWjwgOyYyl5oE1aQBn9PMV2Vksfembh4egWtN7iAPbHZJeik
         rDDg==
X-Gm-Message-State: AC+VfDzRQUU4/2uXBKOgXjA1J8HBraMDehDv7wbbY0OEFjPubmbIJrCR
        rwns5vdPLM+8G3ZCJEgobNvaf1MpP8/zegCChagFruBtyT6QVkalYJHhpEnDn1AHgnVTv63c0b9
        /j5XPIerVrwjJ8QPnzhL3t+CL2rN9F5xqt4+2pJQt4F3y/Vkt13F63QM=
X-Received: by 2002:a81:83c7:0:b0:559:f029:992d with SMTP id t190-20020a8183c7000000b00559f029992dmr19067709ywf.24.1683730548828;
        Wed, 10 May 2023 07:55:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Hnxj29587wz4D/QOv5wYbNoK5zIRdPowtRAgz0Cdi165hPAX1WVSJsBubNrvNcm9fx26AIHNjd27vMKw8uio=
X-Received: by 2002:a81:83c7:0:b0:559:f029:992d with SMTP id
 t190-20020a8183c7000000b00559f029992dmr19067692ywf.24.1683730548592; Wed, 10
 May 2023 07:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230510131527.1244929-1-aleksandr.mikhalitsyn@canonical.com> <ZFusunmfAaQVmBE2@t14s.localdomain>
In-Reply-To: <ZFusunmfAaQVmBE2@t14s.localdomain>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Wed, 10 May 2023 16:55:37 +0200
Message-ID: <CAEivzxdfZaLD40cBKo7aqiwspwBeqeULR+RAv6jJ_wo-zV6UpQ@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: add bpf_bypass_getsockopt proto callback
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc:     nhorman@tuxdriver.com, davem@davemloft.net,
        Daniel Borkmann <daniel@iogearbox.net>,
        Christian Brauner <brauner@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 10, 2023 at 4:39=E2=80=AFPM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Wed, May 10, 2023 at 03:15:27PM +0200, Alexander Mikhalitsyn wrote:
> > Add bpf_bypass_getsockopt proto callback and filter out
> > SCTP_SOCKOPT_PEELOFF and SCTP_SOCKOPT_PEELOFF_FLAGS socket options
> > from running eBPF hook on them.
> >
> > These options do fd_install(), and if BPF_CGROUP_RUN_PROG_GETSOCKOPT
> > hook returns an error after success of the original handler
> > sctp_getsockopt(...), userspace will receive an error from getsockopt
> > syscall and will be not aware that fd was successfully installed into f=
dtable.
> >
> > This patch was born as a result of discussion around a new SCM_PIDFD in=
terface:
> > https://lore.kernel.org/all/20230413133355.350571-3-aleksandr.mikhalits=
yn@canonical.com/
>
> I read some of the emails in there but I don't get why the fd leak is
> special here. I mean, I get that it leaks, but masking the error
> return like this can lead to several other problems in the application
> as well.
>
> For example, SCTP_SOCKOPT_CONNECTX3 will trigger a connect(). If it
> failed, and the hook returns success, the user app will at least log a
> wrong "connection successful".
>
> If the hook can't be responsible for cleaning up before returning a
> different value, then maybe we want to extend the list of sockopts in
> here. AFAICT these would be the 3 most critical sockopts.
>

Dear Marcelo,

Thanks for pointing this out. Initially this problem was discovered by
Christian Brauner and for SO_PEERPIDFD (a new SOL_SOCKET option that
we want to add),
after this I decided to check if we do fd_install in any other socket
options in the kernel and found that we have 2 cases in SCTP. It was
an accidental finding. :)

So, this patch isn't specific to fd_install things and probably we
should filter out bpf hook from being called for other socket options
as well.

So, I need to filter out SCTP_SOCKOPT_CONNECTX3 and
SCTP_SOCKOPT_PEELOFF* for SCTP, right?

Kind regards,
Alex
