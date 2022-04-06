Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BFA4F6433
	for <lists+linux-sctp@lfdr.de>; Wed,  6 Apr 2022 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237089AbiDFQDY (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 6 Apr 2022 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbiDFQDK (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 6 Apr 2022 12:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 365B74781DF
        for <linux-sctp@vger.kernel.org>; Wed,  6 Apr 2022 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649252051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqJrO6dmU5SvkPcGw8UCuWuh5/5NxvMZsaumTowIu8c=;
        b=XayyjZV8LUoA1PLyX9HsXMdMLGZaFEXs0y+MHC/k2malIRQa8pIxqmDgyGvWDCDryJrUpc
        Enc/tNBWsdHmbB9EHf2l0XJCfsFvXaJl7RKNzwGy3O4DMM+g7mtqAEEbaq2dU9Dukiwd+j
        /qgYJoKIZpq+sZAiLqas7cSpOBdoH8o=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-B1g3sFkHObKafo4nLbZFEQ-1; Wed, 06 Apr 2022 09:34:09 -0400
X-MC-Unique: B1g3sFkHObKafo4nLbZFEQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-2e644c76556so21068597b3.15
        for <linux-sctp@vger.kernel.org>; Wed, 06 Apr 2022 06:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqJrO6dmU5SvkPcGw8UCuWuh5/5NxvMZsaumTowIu8c=;
        b=1YYKlplY9/PEkyB738g0oPdt3eiVxPyyQNpvR2DyhdKoF4xVSnIERy6ydXae5md6zQ
         pJVdWsQFVrS8Msy9QQANVVvwkFsJ0ZXm4CIa2n/WnnhAjbFI6VQLixo3jLyanv0NnpUb
         r9iqjsFuA+P04jzLbsPaE5xvpz6sIbFlWIaGFZ7zOP8TCV1Y+/O/23e+PTsewzQd3Eb5
         1ZaMOekg+2n6QsWc8Dqns+EGSZtd9QAg73HCAsLvBFPq/6+Y8/DLgzPiwUmQagxtvnik
         0io3KmFP6STP6R8NKoQGcUitD1T7Qo8hmcxQO3Pp/dH3ExMWd5lCGZ99+Yh4W+GdNSAb
         HLQQ==
X-Gm-Message-State: AOAM530HrH6eRyv6pwUM0N06R2g18lC24L9rKtBlTdVy+NDPOwRqY/DK
        D9E5d2iP3MG+tJsj5xRHz9L7BTLVRf8gu9kPxkkDZiELGtD3HhTPvp+j3KcXdMYW189/gt5Jae1
        +VlP6gCZ+iVZ3gm2hmdDu26hnRr0vJ/9RwCxAdA==
X-Received: by 2002:a0d:e64d:0:b0:2e6:43f8:234f with SMTP id p74-20020a0de64d000000b002e643f8234fmr7012369ywe.12.1649252049389;
        Wed, 06 Apr 2022 06:34:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVRyzw7tB7nHauTQeSQg7Hj0WMwzeDSc4tOVfXZNCRQWMlZ043KzTYBmx0XGbMf0eIBPqtGUja+rJ6sTcquoA=
X-Received: by 2002:a0d:e64d:0:b0:2e6:43f8:234f with SMTP id
 p74-20020a0de64d000000b002e643f8234fmr7012342ywe.12.1649252049081; Wed, 06
 Apr 2022 06:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com>
 <CAFqZXNt=Ca+x7PaYgc1jXq-3cKxin-_=UNCSiyVHjbP7OYUKvA@mail.gmail.com> <CADvbK_fTnWhnuxR7JkNYeoSB4a1nSX7O0jg4Mif6V_or-tOy3w@mail.gmail.com>
In-Reply-To: <CADvbK_fTnWhnuxR7JkNYeoSB4a1nSX7O0jg4Mif6V_or-tOy3w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 6 Apr 2022 15:33:57 +0200
Message-ID: <CAFqZXNss=7DMb=75ZBDwL9HrrubkxJK=xu7-kqxX-Mw1FtRuuA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: use the correct skb for security_sctp_assoc_request
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=omosnace@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Apr 5, 2022 at 1:58 PM Xin Long <lucien.xin@gmail.com> wrote:
> On Mon, Apr 4, 2022 at 6:15 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Adding LSM and SELinux lists to CC for awareness; the original patch
> > is available at:
> > https://lore.kernel.org/netdev/a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com/T/
> > https://patchwork.kernel.org/project/netdevbpf/patch/a77a584b3ce9761eb5dda5828192e1cab94571f0.1649037151.git.lucien.xin@gmail.com/
> >
> > On Mon, Apr 4, 2022 at 3:53 AM Xin Long <lucien.xin@gmail.com> wrote:
> > >
> > > Yi Chen reported an unexpected sctp connection abort, and it occurred when
> > > COOKIE_ECHO is bundled with DATA Fragment by SCTP HW GSO. As the IP header
> > > is included in chunk->head_skb instead of chunk->skb, it failed to check
> > > IP header version in security_sctp_assoc_request().
> > >
> > > According to Ondrej, SELinux only looks at IP header (address and IPsec
> > > options) and XFRM state data, and these are all included in head_skb for
> > > SCTP HW GSO packets. So fix it by using head_skb when calling
> > > security_sctp_assoc_request() in processing COOKIE_ECHO.
> >
> > The logic looks good to me, but I still have one unanswered concern.
> > The head_skb member of struct sctp_chunk is defined inside a union:
> >
> > struct sctp_chunk {
> >         [...]
> >         union {
> >                 /* In case of GSO packets, this will store the head one */
> >                 struct sk_buff *head_skb;
> >                 /* In case of auth enabled, this will point to the shkey */
> >                 struct sctp_shared_key *shkey;
> >         };
> >         [...]
> > };
> >
> > What guarantees that this chunk doesn't have "auth enabled" and the
> > head_skb pointer isn't actually a non-NULL shkey pointer? Maybe it's
> > obvious to a Linux SCTP expert, but at least for me as an outsider it
> > isn't - that's usually a good hint that there should be a code comment
> > explaining it.
> Hi Ondrej,
>
> shkey is for tx skbs only, while head_skb is for skbs on rx path.

That makes sense, thanks. I would still be happier if this was
documented, but the comment would best fit in the struct sctp_chunk
definition and that wouldn't fit in this patch...

Actually I have one more question - what about the
security_sctp_assoc_established() call in sctp_sf_do_5_1E_ca()? Is
COOKIE ACK guaranteed to be never bundled?

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

