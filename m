Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4743CC8A
	for <lists+linux-sctp@lfdr.de>; Wed, 27 Oct 2021 16:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbhJ0OoG (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 27 Oct 2021 10:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237854AbhJ0OoF (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 27 Oct 2021 10:44:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249B3C061745
        for <linux-sctp@vger.kernel.org>; Wed, 27 Oct 2021 07:41:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b63so136115edf.10
        for <linux-sctp@vger.kernel.org>; Wed, 27 Oct 2021 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaiy8iI3KoAyhwe4AaJugOjEos/PZdxnCB8V0KH1Dno=;
        b=CBeBZwBdiZIUZVnM5Khw1ZEjGcdJVEay33Tiq5yOsocJpeWvvFEIKqxKdPJ9KE7dzF
         pShXKIjs5jM0jO1kukrMSxHwPSkmN18a1+FZPMkqZrDgXruCgpnOQ1uXSQ/vzTQ8kLP9
         OqkjFlT64D5zj44wOS1FzCSevHTBuT5V5kTmoDI0HQQQBao8DTa6CcgJBvxIieYDHVUZ
         XX3JPmm+v89PawnpKqt84iEctdnp5mTneda198Y4CIerLDOntkfiq7N4TRk0sK60bTnE
         hJStBgr73WTxL9sNHNg66vKLPDML0GOXTg4QWefV5bJevjkANoWgHqHflMZYNyGNkTFf
         XEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaiy8iI3KoAyhwe4AaJugOjEos/PZdxnCB8V0KH1Dno=;
        b=cH9Avco8c+PQ0HgXdWOi0l+9zTzzU0o8XPYpOg5jeFDGf3N/9oZEFKC885RMxPJCVY
         0+kqjqhPh+MmVy99IgsbTNljpy+S2YQ1kpE5Jc0Uq9fHfUflycum8KvrOMTtMIF0+fJk
         I+rw9k4vsH6LPhXFJefMPN6vtQaPkKYkIuMWLzGQL7g2BcBJh5hkSzEI4W9Ez0lBDCpv
         v8i8j9aSY3sl6/yjSqerwHDn8xdd7xUDibe3iEvxf+7q7UY2gPwkvXXCFH/mzSdmxix+
         xikSNVPaYvVKEihiqfhlTPqaYMttDhN2GMzroUo1eZlZCPxwTDlGTaqw4KBPYK2sNd2k
         iLRw==
X-Gm-Message-State: AOAM5328B0bP6UYqasR4AjJ9vbH8GejpBIu4+cRf8bwRaffFVJSavVDk
        4YBsIRrMg8k263LO6yicGHSG5WFy75Wgl3xHed/V
X-Google-Smtp-Source: ABdhPJwvDV51df1jsbukGYi/QiG9zzLsCbuK6XTvcBu2DkK2prsxWu/++ORqQzcu3+tmw/SVuP3YMDt5c0Vmg4CFG5Q=
X-Received: by 2002:a05:6402:22d6:: with SMTP id dm22mr45319307edb.209.1635345692764;
 Wed, 27 Oct 2021 07:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1634884487.git.lucien.xin@gmail.com> <53026dedd66beeaf18a4570437c4e6c9e760bb90.1634884487.git.lucien.xin@gmail.com>
 <CAFqZXNs89yGcoXumNwavLRQpYutfnLY-SM2qrHbvpjJxVtiniw@mail.gmail.com>
 <CADvbK_djVKxjfRaLS0EZRY2mkzWXTMnwvbe-b7cK-T3BR8jzKQ@mail.gmail.com>
 <CAFqZXNsnEwPcEXB-4O983bxGj5BfZVMB6sor7nZVkT-=uiZ2mw@mail.gmail.com>
 <CADvbK_eE9VhB2cWzHSk_LNm_VemEt9vm=FMMVYzo5eVH=zEhKw@mail.gmail.com>
 <CAHC9VhTfVmcLOG3NfgQ3Tjpe769XzPntG24fejzSCvnZt_XZ9A@mail.gmail.com>
 <CADvbK_dwLCOvS8YzFXcXoDF6F69_sc7voPbxn5Ov4ygBR_5FXw@mail.gmail.com>
 <CAHC9VhREfztHQ8mqA_WM6NF=jKf0fTFTSRp_D5XhOVxckckwzw@mail.gmail.com> <CADvbK_c0CosUo4mMrSYQs_AA2KbB4MdnX5aS0zS0pJBOJV2vUA@mail.gmail.com>
In-Reply-To: <CADvbK_c0CosUo4mMrSYQs_AA2KbB4MdnX5aS0zS0pJBOJV2vUA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Oct 2021 10:41:21 -0400
Message-ID: <CAHC9VhTYNkvqLWA+FXVz=1dL8QvF9AmV7UMgAzNOcj238yjVvw@mail.gmail.com>
Subject: Re: [PATCH net 4/4] security: implement sctp_assoc_established hook
 in selinux
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        network dev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Oct 27, 2021 at 12:00 AM Xin Long <lucien.xin@gmail.com> wrote:
> OK, I think we are on the same page now, I will post v2.

I'm not quite as confident we are on the same page just yet, but I
agree that having a new revision is a good idea; if nothing else it
will help reset the discussion to focus on updated patches - thanks!

-- 
paul moore
www.paul-moore.com
