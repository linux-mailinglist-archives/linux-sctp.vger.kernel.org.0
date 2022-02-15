Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872744B78F8
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Feb 2022 21:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243968AbiBOUD2 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Feb 2022 15:03:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243954AbiBOUD0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Feb 2022 15:03:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1C74DF7
        for <linux-sctp@vger.kernel.org>; Tue, 15 Feb 2022 12:03:04 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u18so144520edt.6
        for <linux-sctp@vger.kernel.org>; Tue, 15 Feb 2022 12:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=56tbQJVv90RABsQ0i0ptzrDmdvS83ZrjWE0KJ5/Juw8=;
        b=sFifZ3ibKjhu/WnpE7XgZp/C2bXZ7ift+MmeAVSa1hznUw6Wm07gSdft5d2fUe2Vn2
         RjiRCYgEeTYyWMTxD06Z5LMTyKQZ5RluV4mRPZ8hVkTVElWuISequYHNfnVgs1JVpq+h
         xxaHe/Iv+2TTmvgqWPO0LZnQEBReR69V0AMuYUHxpEJAkG1St+MhQIgNHgZL37cOQaFq
         LwC5kUW7OHpEbm/5XIti6ajkRvwQWpQC5DoqvzT+ZOX325bSVD1WtjOMcq8+I+dZAQAv
         QXaY6x7vFTvffge/EC02QtULgmF6djGu6x5pF2BUtiqlB5PHHwiNmQmkGDrJbIl2VAHu
         4iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=56tbQJVv90RABsQ0i0ptzrDmdvS83ZrjWE0KJ5/Juw8=;
        b=sa9yjqz9nBlErjArVuMOBUWhfBZqO7bzoftHYU4HtXEeqmPqaeljC/pDL/CTLaKEDj
         mGxpooMBkvLCeCvYYpzRum4/JZ4ykaTOKRa+dSRsBoGtMsUimc5LFJHTRtDIIyQplG/6
         mDaYap7ZY5pFTpMxjl2MytFXkvRlPiboXYLcslDfMCg9otaeOFMVFTNMtUdXLKHDRmMd
         5HL0DKsMAy+8P4LvG0KEJJdHpG5RwLM+1ULNKZoat7B3EUuvwWlBiCoZlyxzYiVVoNzL
         t0yvsJ4TuchKAWViesXuh987qfxf8BKCjowm4bHmBJ+t6FZTv9PBXFCFKsfLZJ/wnz6F
         nowg==
X-Gm-Message-State: AOAM533lBLG77yMCI5wkDH3VA5zEpiOIit0O1RIFifrqy005/03UG0xR
        c05JuKTIPpE27LRINy0c+XoOl0z5RhvJ+aymHyb2
X-Google-Smtp-Source: ABdhPJwSh+Lbt7VtTxO+bjCuU4YBvFJI07pOtqxY+X5Ac/RcvpsJaiEfY8EBo10iskp6ziZLHDs9nkyLfRPbTaESgFg=
X-Received: by 2002:a05:6402:35ca:: with SMTP id z10mr606628edc.43.1644955382916;
 Tue, 15 Feb 2022 12:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20220212175922.665442-1-omosnace@redhat.com> <20220212175922.665442-3-omosnace@redhat.com>
 <CAHC9VhT90617FoqQJBCrDQ8gceVVA6a1h74h6T4ZOwNk6RVB3g@mail.gmail.com>
 <20220214165436.1f6a9987@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAFSqH7zC-4Ti_mzK4ZrpCVtNVCxD8h729MezG2avJLGJ2JrMTg@mail.gmail.com> <CADvbK_e+TUuWhBQz1NPPS2aE59tzPKXPfUogrZ526hvm6OvY9Q@mail.gmail.com>
In-Reply-To: <CADvbK_e+TUuWhBQz1NPPS2aE59tzPKXPfUogrZ526hvm6OvY9Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Feb 2022 15:02:51 -0500
Message-ID: <CAHC9VhSHxk0MUR1krpmbot6iG-vqH48sRgKOnJQ0LsFTs6Jvqg@mail.gmail.com>
Subject: Re: [PATCH net v3 2/2] security: implement sctp_assoc_established
 hook in selinux
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Prashanth Prahlad <pprahlad@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Feb 14, 2022 at 11:13 PM Xin Long <lucien.xin@gmail.com> wrote:
> Looks okay to me.
>
> The difference from the old one is that: with
> selinux_sctp_process_new_assoc() called in
> selinux_sctp_assoc_established(), the client sksec->peer_sid is using
> the first asoc's peer_secid, instead of the latest asoc's peer_secid.
> And not sure if it will cause any problems when doing the extra check
> sksec->peer_sid != asoc->peer_secid for the latest asoc and *returns
> err*. But I don't know about selinux, I guess there must be a reason
> from selinux side.

Generally speaking we don't want to change any SELinux socket labels
once it has been created.  While the peer_sid is a bit different,
changing it after userspace has access to the socket could be
problematic.  In the case where the peer_sid differs between the two
we have a permission check which allows policy to control this
behavior which seems like the best option at this point.

> I will ACK on patch 0/2.

Thanks, I'm going to go ahead and merge these two patches into
selinux/next right now.

-- 
paul-moore.com
