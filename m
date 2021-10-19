Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F23C433A3F
	for <lists+linux-sctp@lfdr.de>; Tue, 19 Oct 2021 17:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhJSP0g (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 Oct 2021 11:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbhJSP0f (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 19 Oct 2021 11:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634657062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAnXKuaDbIqa7vOHm5OcOC/bkStWpcxuwC8eXYiB2fg=;
        b=GrnHMySGJl99uep3gKYcTHufmM+1xMZjl0wC1pv/hfw3A/tdkpA9aOVHW/iDBR7dsP4JbW
        dzUyx0dFbxMI8egjlmq+l3u00rCEXnJl0A6kZOESnrCCX64knIt+Wt+ckdWKIHJWaRcM/R
        uWH3ydGnpolw/0RkdLYBWrHCe+63bvg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-tTUMBF9oNfancBo0piVeGQ-1; Tue, 19 Oct 2021 11:24:21 -0400
X-MC-Unique: tTUMBF9oNfancBo0piVeGQ-1
Received: by mail-il1-f200.google.com with SMTP id i15-20020a056e021b0f00b002593fb7cd9eso10401797ilv.14
        for <linux-sctp@vger.kernel.org>; Tue, 19 Oct 2021 08:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=OAnXKuaDbIqa7vOHm5OcOC/bkStWpcxuwC8eXYiB2fg=;
        b=tqP5pSpfVQAt7xG0bkxHv+J8cFocUpcEbe27AORfgB5b2fU4/OPUH6O6e/w/2QenyE
         eMlGD+biIwNV+3OxckX+XY0NZ3A0+oYRpq1ODvFr8TlwkgKtay9smjmOkzhkQqpPsjdg
         29tcmUhRdUiBaJ4MR+lrjJYGkfojGxvSggO4zejzDk0j79YAVjO1gurD9ilgbDbhHxKh
         UkFg80EQtafvpPfpjaFBUYCHp2XY0vQWwVJqo6AG/SR2PAyXKWjLzdRF0akiDfJawmQV
         cK1pTrml/KoXp3K2AWuqvBfODsUejybywkcjvmxz4LBp1pQST1r0NS5dq9emYKz6r8JW
         0HbA==
X-Gm-Message-State: AOAM53115TeHrrFr1OGZgIBALj7/4WJAx5bgYWV+mhDHxARoMpAvqYNJ
        S9EFUkLJB0WYp3mnGFRxyA+xubL+y6cJPUcJMwoglYF+LColf7a4Hqeh9VhKX37EAlxAp1L2hEp
        BECmc+szouqBDldiKZfDRXWVLjhhhh4IiwXJNdQ==
X-Received: by 2002:a5d:8183:: with SMTP id u3mr18970076ion.67.1634657060538;
        Tue, 19 Oct 2021 08:24:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwx9KqlpG/iAuZHwBVjQMW41u6+jI7pLW7fwzbVjd7GBoVJeiCGTWRsh7yVVQ4i1C1zRRNyNGxX/+tEx22Y//8=
X-Received: by 2002:a5d:8183:: with SMTP id u3mr18970056ion.67.1634657060276;
 Tue, 19 Oct 2021 08:24:20 -0700 (PDT)
Received: from 868169051519 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 19 Oct 2021 08:24:19 -0700
From:   mleitner@redhat.com
References: <4f9d3a13-2104-ec1c-dbc7-12de1f99ea0e@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4f9d3a13-2104-ec1c-dbc7-12de1f99ea0e@oracle.com>
Date:   Tue, 19 Oct 2021 08:24:19 -0700
Message-ID: <CALnP8ZZ7UbEzc0+VVpwucbBqNfgTqOk-LN8BwjbtL8-CbzOY6Q@mail.gmail.com>
Subject: Re: syzkaller test panic: Linux 5.4.y
To:     john.p.donnelly@oracle.com
Cc:     linux-sctp@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mleitner@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi John,

On Mon, Oct 18, 2021 at 04:29:58PM -0500, john.p.donnelly@oracle.com wrote:
>   Call Trace:
>    skb_put+0x4c/0x4c
>    sctp_addto_chunk+0x59/0xb0 [sctp]
>    sctp_make_strreset_req+0x166/0x180 [sctp]
>    sctp_send_reset_streams+0x14d/0x300 [sctp]
>    sctp_setsockopt.part.21+0x101f/0x1720 [sctp]
>    sctp_setsockopt+0x99/0xb0 [sctp]
>    sock_common_setsockopt+0x1a/0x1c
>    SyS_setsockopt+0x86/0xe6
>    +0x79/0x1ae
>    entry_SYSCALL_64_after_hwframe+0x151/0x0
>  RIP: 0033:0x7f80bdc21be9
>
>
> I am not familar with any of the sctp subsystem. It was found running the
> syzkaller fuzzing test suite.
>
> If there is a more appropriate place to report this I can do that too. This

Here is fine :)

> test fails on just about every 4.x and 5.x kernel.  It is not
> unique to 5.4.

Did the test kernels include commit "sctp: account stream padding
length for reconf chunk"? It is a recent fix right on this topic. It
should be fixed by it, actually.

  Marcelo

