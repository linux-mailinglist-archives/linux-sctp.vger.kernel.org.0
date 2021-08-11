Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102523E96D6
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Aug 2021 19:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhHKR2P (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 11 Aug 2021 13:28:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27927 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229535AbhHKR2P (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 11 Aug 2021 13:28:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628702871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OqXLIC7EcLLh+W8vtswta2rji3gNQCAGuPrp8NpwNIw=;
        b=R5rQPbpriA1rHw2hhuStYdBBh6xdEonRLjpCrO3WXAHYdM05K0jA1pNJL7ZAhuKhRSwLMF
        Toq3lixpoHKC7mztN50AvkJQvdUi/ZGoOnJOU7ItfoHG+g+6hm5mNv2z0W2F+lw6p+ZcQA
        W6GAlyiAiP7vJfiIzCQd4tFbAZGDEAg=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-DW4VjO4_OJOtYhXw946IXQ-1; Wed, 11 Aug 2021 13:27:49 -0400
X-MC-Unique: DW4VjO4_OJOtYhXw946IXQ-1
Received: by mail-io1-f71.google.com with SMTP id n22-20020a6bf6160000b0290520c8d13420so1930873ioh.19
        for <linux-sctp@vger.kernel.org>; Wed, 11 Aug 2021 10:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:mime-version:in-reply-to:date
         :message-id:subject:to:cc;
        bh=OqXLIC7EcLLh+W8vtswta2rji3gNQCAGuPrp8NpwNIw=;
        b=oJoJe+jbygNBR7pnxI1RTq+MiOHHtUiMqNtmOKz1jsHPRCG576k+UjVb3AbhZ1rWJQ
         enqnQ0aupjExJqseOlUqhvi/622pYMeWACajpj4vbyZm+hAkoTEdxwpPz36/icOJrv99
         Wp4Xy8hcRh36gRz35DFT4t/4CicViUdYYyVBR+Opqyp9y1nGjUC5myi1bNgW4Z6ILAAn
         S6Un093CP/75x2tWZ6fV2QdICVHL0+7gy6yqVMG6s+90gvDiSC01Lj08KwVcgAkNttIC
         sXZNtpC+KMHkPgzdSpxdsI47saWkRyVtn0jfivc7pjMMN0H9YtMgtXK77SSg6dz2rPSG
         aUcQ==
X-Gm-Message-State: AOAM531okEz+l33SWNkdqUYpcavFZBZ5YlAHzHN4FBTCEZ2AHBod0yIX
        RGzd1HozdKZmvau76R6LmG1GRKf8LJOLxPRkN64eDWvWuhMtCMD11zdtIEE8URLCGsA/U0GxCOp
        Oo3iCxb+HxgGdmC8lRErfbXfvyKITLweNPbKOBg==
X-Received: by 2002:a6b:f205:: with SMTP id q5mr25685ioh.158.1628702869359;
        Wed, 11 Aug 2021 10:27:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2KlWY6Y80yZlbxpA0xk0ufElQEr/Un9ppHkSB6iW1+HIVOBbi5IADGN3OGQDnwOUb9wgTHE2ohKKSyunp81E=
X-Received: by 2002:a6b:f205:: with SMTP id q5mr25674ioh.158.1628702869208;
 Wed, 11 Aug 2021 10:27:49 -0700 (PDT)
Received: from 868169051519 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Aug 2021 19:27:48 +0200
From:   mleitner@redhat.com
References: <cover.1628076531.git.lucien.xin@gmail.com>
MIME-Version: 1.0
In-Reply-To: <cover.1628076531.git.lucien.xin@gmail.com>
Date:   Wed, 11 Aug 2021 19:27:48 +0200
Message-ID: <CALnP8ZYO8ACkjWMj++6yw6yj068BHgx87CtqTuYiD=KXns8uHw@mail.gmail.com>
Subject: Re: [PATCH lksctp-tools 0/4] lksctp-tools: replace use of deprecated
 gethostbyname with getaddrinfo
To:     Xin Long <lucien.xin@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mleitner@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Aug 04, 2021 at 07:29:12AM -0400, Xin Long wrote:
> This patchset is simply to replace use of deprecated gethostbyname
> with getaddrinfo in myftp, sctp_xconnect, sctp_test and sctp_darn.

Applied. Thanks Xin.

