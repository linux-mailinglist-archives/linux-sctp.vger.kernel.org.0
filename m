Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DF1753044
	for <lists+linux-sctp@lfdr.de>; Fri, 14 Jul 2023 05:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjGND7s (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 13 Jul 2023 23:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjGND7r (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 13 Jul 2023 23:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39159172C
        for <linux-sctp@vger.kernel.org>; Thu, 13 Jul 2023 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689307140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0IXrRel0Jf5sI6yYnB7ussn8KJNTKMqE2zSLssKxOs=;
        b=ddcyXoitP7tXQ0P6AR9Kutjwt7zLz6VFa4jvDbDT9heWVmWw9i6hydBHek+RozusxKJobh
        wuH5PCtqvOvuT0GaOCxeO6WcR7TQsw4K/aJ1cNkweC8O2MSikowwNXgGTzjjXQ8IcOLEUX
        yb/mEOmgC0m0ZJTdQLuM0wupYq1w4uM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-7_RtQbYuPFGIawAoJLWhRQ-1; Thu, 13 Jul 2023 23:58:58 -0400
X-MC-Unique: 7_RtQbYuPFGIawAoJLWhRQ-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6ce2f2960so14663381fa.0
        for <linux-sctp@vger.kernel.org>; Thu, 13 Jul 2023 20:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307137; x=1691899137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0IXrRel0Jf5sI6yYnB7ussn8KJNTKMqE2zSLssKxOs=;
        b=STQnUqmGzhacgUWDSL5UPB5P7RitLYwFa1EPcZvHqd6OZ3cDlRB/xqByjxnDICDaES
         V5Vwi98XkkA4YvrMSw57kKYqS1hW9EFn+yC5RlbhhXyPjHlxn3Y5APfsP1hM3KuCnw4Y
         5v6QIazY/BOlwRGew8Cc3VGDBMvx5mLCdR6+rnWbL06dsKHRXG36jzhCQwFXLeZHYnnG
         PtF3v4JyQLOO1cHLG/Qykf2z3aL4Op6bS6NQHmhqN5USe/DimsQMDC+yrqYyWqAG2bkw
         lnR3Z+AieFnEfTERlfo5fNDR30ycJ+17gVFwzxtil3+Px2a42ndQ8Jf2tYdvwp0cJMzI
         0LVg==
X-Gm-Message-State: ABy/qLaVuSBWhbK36+90Ed7KdjuM7N+Hqjn7P0WHflrG8TMmFFH9RKBP
        2jq0FvhReR2fUt+R/6P8foQ2OInqz3W7q2fpLm4Adjq5UCOyGdAMtGB+F5nUVKFKH5/thFD1oDO
        ULcBgSslwnXM3F+Py5a93KRwwS1hNX6hR5Mtuww==
X-Received: by 2002:a2e:2c11:0:b0:2b4:8446:82a9 with SMTP id s17-20020a2e2c11000000b002b4844682a9mr541692ljs.17.1689307137502;
        Thu, 13 Jul 2023 20:58:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHM/PKtNMaPwkVCmNF7IN6cguTIWBujbOGf1vp5W5x6EOmDtNkZ8J0NSeeeKGnFbM4DzMfzYz0QkyDhMOKB7zc=
X-Received: by 2002:a2e:2c11:0:b0:2b4:8446:82a9 with SMTP id
 s17-20020a2e2c11000000b002b4844682a9mr541689ljs.17.1689307137231; Thu, 13 Jul
 2023 20:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZLA0ILTAZsIzxR6c@debian.debian>
In-Reply-To: <ZLA0ILTAZsIzxR6c@debian.debian>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Jul 2023 11:58:46 +0800
Message-ID: <CACGkMEvq8h_yYhxBWD4oPBBwE8xzDMt7VqbW4wz+oqjfYbiQfQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
To:     Yan Zhai <yan@cloudflare.com>
Cc:     "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Melnychenko <andrew@daynix.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jul 14, 2023 at 1:28=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation:
>
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28K=
zYDg+A@mail.gmail.com/
>
> This change restores the expected behavior of GSO_UDP_L4 packets.
>
> Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packet=
s.")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> ---
> v2: dropped modifications to tcp/sctp on DODGY bit removal after
> validating gso_segs. Also moved the UDP header check into
> __udp_gso_segment (per Willem's suggestion).
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

