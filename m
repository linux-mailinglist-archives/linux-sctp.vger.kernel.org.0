Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8C117B97
	for <lists+linux-sctp@lfdr.de>; Tue, 10 Dec 2019 00:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbfLIXmV (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 9 Dec 2019 18:42:21 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:41479 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfLIXmU (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 9 Dec 2019 18:42:20 -0500
Received: by mail-pj1-f67.google.com with SMTP id ca19so6567242pjb.8
        for <linux-sctp@vger.kernel.org>; Mon, 09 Dec 2019 15:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=V+QMhx7ddpbkcSbPVKvyp45lyXMPmAo/pgMKOqAodfE=;
        b=fSf1ZGmSL3/xD1sMkMysZYFQFkGtn4G49qvt9u4+83SppEPRq/o5shJLAh1xxMujyM
         VC8EVKvtCCF5tXdXKNzmki+xLo2g7WdS2UrLud6KSRM2ReK0TNZDd+c8F46NbwYLI2vx
         hek5iKYcDWlYOAAR0OSqHN7uIbTW27q7zhQSIGmLub8HR+sjnlIoMrleANj4pX3f7/LS
         M/YbmE76H8VqGGw6nUDGNeHMc5bQDCTZymYFmg4cFyHlPsDIsXN+VSW/W/YA93pUJAme
         c4lOGrIhofDpQupdRbBxJo5Z19M7z5rFb3rGDldu2L/4gXoSmlatMo8R7D47iILS8lzr
         DUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=V+QMhx7ddpbkcSbPVKvyp45lyXMPmAo/pgMKOqAodfE=;
        b=Y0zBAcOx0301cn6pvmbHED4n2eW4J+KFMow6etFohTC0mE5L7Pn24Z5AWsgt59dItv
         fLzGF9punln7PLhmOuTrscDndz/iJNiOMAYLFvwYq9MvzMQfQ8HMTQVPxfIKYwU/JApA
         5vOX0ymAvj4kd9dGfJORVan5ro0QXORICmWfs66TxGRWWNNkLj7irEIZUS+/h9W18dEj
         cSr/KIPWUwSvKX7JqhgHV7JySGMxOxHa0Al2WZuTEhsmbxygpJzV3Q4NIRHMSmou3jLr
         DuJRjz0Dz4X/Zn+YJgYDc/qdXT6JDE2sY0u0laSPVEuRFapQGML8J66/jVgOB/XAOTj7
         egjA==
X-Gm-Message-State: APjAAAUwxFK2TjDyECh9jjSsB590vwU0+1E9W9KI/ehka3SLlucfWOM3
        FQnvliwx5kFvka4pr5PpWMBieg==
X-Google-Smtp-Source: APXvYqyfZb7MEcnxbUPQl2yGD5rqMg8NC6Pf7z6qDPwFCvFdZjlSfWs3Vqyy3mFRXwiM+UpLFcbzCg==
X-Received: by 2002:a17:902:820f:: with SMTP id x15mr32558307pln.125.1575934940114;
        Mon, 09 Dec 2019 15:42:20 -0800 (PST)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id w3sm552243pfd.161.2019.12.09.15.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 15:42:19 -0800 (PST)
Date:   Mon, 9 Dec 2019 15:42:16 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <zenczykowski@gmail.com>
Cc:     Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux SCTP <linux-sctp@vger.kernel.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Subject: Re: [PATCH v2] net: introduce ip_local_unbindable_ports sysctl
Message-ID: <20191209154216.7e19e0c0@cakuba.netronome.com>
In-Reply-To: <20191209224530.156283-1-zenczykowski@gmail.com>
References: <CAHo-OowKQPQj9UhjCND5SmTOergBXMHtEctJA_T0SKLO5yebSg@mail.gmail.com>
        <20191209224530.156283-1-zenczykowski@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon,  9 Dec 2019 14:45:30 -0800, Maciej =C5=BBenczykowski wrote:
> Example use cases might be:
>  - a port being stolen by the nic for remote serial console, remote
>    power management or some other sort of debugging functionality
>    (crash collection, gdb, direct access to some other microcontroller
>    on the nic or motherboard, remote management of the nic itself).

This use case makes me a little uncomfortable.

Could you elaborate what protocols and products are in need of this
functionality?

Why can't the NIC just get its own IP like it usually does with NCSI?
