Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B974237F
	for <lists+linux-sctp@lfdr.de>; Thu, 29 Jun 2023 11:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF2JuK (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 29 Jun 2023 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjF2JuH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 29 Jun 2023 05:50:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236382682
        for <linux-sctp@vger.kernel.org>; Thu, 29 Jun 2023 02:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688032156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+plDWhXJtyP1/dor5ycSeAGAv25H1fG419rVN4fUTjE=;
        b=goOCCLAYBGBVdWplg8owaMLfYiSMok2Pg4vbW8AaATMbdTDSeKcNkeOtqJy30rBcknHzkL
        9LOquw2b36iI+Rf98e5dRxQldkKsBGsJ2aPjk6v/bndyUIBSwjgzDm6tYUknhRpA4ywhbh
        xY2AR/BopAsMpv183Xq7/UufZbJrOdI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-9utgwP4cMs2jAhirngALFA-1; Thu, 29 Jun 2023 05:49:14 -0400
X-MC-Unique: 9utgwP4cMs2jAhirngALFA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76716078e78so11582085a.1
        for <linux-sctp@vger.kernel.org>; Thu, 29 Jun 2023 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688032154; x=1690624154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+plDWhXJtyP1/dor5ycSeAGAv25H1fG419rVN4fUTjE=;
        b=FUhH9hkWAcyA+X3QBzSRZdtlz1vCV9hBmaaHM0JFvALd6rDHOLj/ADympgs5U0C54p
         419QaijrTedlTiqiSr39QeGQcCY3SPfuggy1BgYwa104EMRNxjy4WQHqJlqn8GDuOCHp
         2sSlh+siE9SZTALlbldHk3rNgz5lbggcwCT7RToehotde7oCMVrlO7q8RTeIhxXGY9Mb
         0l5VhgurJ/rGrsLvZVAGrPyRxtEVxH1xk4Kt0qZ3e8NhHC7z7KBkUqjiOnAbb3c75X/y
         00R46Ay9Maz9MpvWOceyDDOA1bYBXHP9/t0oN+l903LhmkgbWK1i70iGI96yWTfKb/Qc
         C0PA==
X-Gm-Message-State: AC+VfDw6/N/J+vAOUnJhC24pw/Tm+FWZDFMCLNihlFvyAKVXlIqCx8XR
        fv0OkI6Le4Ogprir7029qjbnweHROYP4TbfusgyyIRjQUT7TCSRQxi6abT63ehQG53L6yf/6mnB
        FGnj0sSAGk05PQQJf3mvD4w==
X-Received: by 2002:a05:620a:17a7:b0:762:63b:e10b with SMTP id ay39-20020a05620a17a700b00762063be10bmr2482832qkb.1.1688032153899;
        Thu, 29 Jun 2023 02:49:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MKPncSPkT64a18nfrR8NCaqw0ntVMDGfolGCj0p8kbs2JxhSlGadGp2eLULzHfa6tC9JYQg==
X-Received: by 2002:a05:620a:17a7:b0:762:63b:e10b with SMTP id ay39-20020a05620a17a700b00762063be10bmr2482821qkb.1.1688032153602;
        Thu, 29 Jun 2023 02:49:13 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-196.dyn.eolo.it. [146.241.231.196])
        by smtp.gmail.com with ESMTPSA id oo26-20020a05620a531a00b0076715ec99dbsm2323858qkn.133.2023.06.29.02.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 02:49:13 -0700 (PDT)
Message-ID: <17efd9ffd0bd8a36e18de587d0fbdb511457559b.camel@redhat.com>
Subject: Re: [PATCH] sctp: fix potential deadlock on &net->sctp.addr_wq_lock
From:   Paolo Abeni <pabeni@redhat.com>
To:     Chengfeng Ye <dg573847474@gmail.com>, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org
Cc:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 29 Jun 2023 11:49:09 +0200
In-Reply-To: <20230627120340.19432-1-dg573847474@gmail.com>
References: <20230627120340.19432-1-dg573847474@gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, 2023-06-27 at 12:03 +0000, Chengfeng Ye wrote:
> As &net->sctp.addr_wq_lock is also acquired by the timer
> sctp_addr_wq_timeout_handler() in protocal.c, the same lock acquisition
> at sctp_auto_asconf_init() seems should disable irq since it is called
> from sctp_accept() under process context.
>=20
> Possible deadlock scenario:
> sctp_accept()
>     -> sctp_sock_migrate()
>     -> sctp_auto_asconf_init()
>     -> spin_lock(&net->sctp.addr_wq_lock)
>         <timer interrupt>
>         -> sctp_addr_wq_timeout_handler()
>         -> spin_lock_bh(&net->sctp.addr_wq_lock); (deadlock here)
>=20
> This flaw was found using an experimental static analysis tool we are
> developing for irq-related deadlock.
>=20
> The tentative patch fix the potential deadlock by spin_lock_bh().

Patch LGTM.

Please note that the above suggests a possible net-next follow-
up/cleanup, replacing the spin_lock_bh() in
sctp_addr_wq_timeout_handler() with a simple/faster spin_lock() - since
sctp_addr_wq_timeout_handler() runs with BH disabled. Anyhow net-next
is closed now, it will have to wait a bit ;)

Cheers,

Paolo

