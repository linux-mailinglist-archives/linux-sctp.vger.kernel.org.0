Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E041D1338
	for <lists+linux-sctp@lfdr.de>; Wed, 13 May 2020 14:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgEMMvs (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 13 May 2020 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731773AbgEMMvr (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 13 May 2020 08:51:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0CFC061A0E
        for <linux-sctp@vger.kernel.org>; Wed, 13 May 2020 05:51:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f13so16534353qkh.2
        for <linux-sctp@vger.kernel.org>; Wed, 13 May 2020 05:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I21hL7AkwUgdNPUI4l7KTQwvXQoa/NOyWUo4IiS5Zaw=;
        b=m6ad7mNkFXWQP2LAar13cizth8P3iKliOem15ctBmD+RRB5NWWGZ4hVFaLb43OUHF4
         dEfbKyHnbdTPvph0NO3q6QQG3feEsDR1NN/aDJiylAVOx6elqA7EySRBy4zgPJs7Fz0/
         Wh3NuXdccvtT3AKlZIUnJi/oe7DjFVTOpq20lvPm5ktnPdoP012Lk/9j/pUDGJCnQSsG
         TmFagaUtz3vbm20kiJmFo0AhIIm3asYdCe/QXnsQdcQLCh91UXycsxj5M4FwgjK5Th4v
         OuuA5GD8cz9mUhRoZ9e54BvWpbbFTnY1KxAJWQ9Fh7pEfNmqL/JrbXuEeLjTtGaJiHKf
         PtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I21hL7AkwUgdNPUI4l7KTQwvXQoa/NOyWUo4IiS5Zaw=;
        b=rI4SofdoYSMXbksrGT/NQQg2cEcqYbQUhpFTg8HWFM1SI3CGOs4fK2hfX5DbHdfUn7
         8JYlHiycnamM2a+RZB6PwnWyw2IMDW8NvVkqXxcVQPzG3OgxXAe/m5Qmnrsn9f+8gRw8
         LaRepMnMabf9izjhfU+nDIYYySbR7tFSdGW4noRihREHjRVIZS/hOk23pZXU40m78yci
         YlKwS5kh0TTuVvJOofz4bJY5TUwhiGhAazsxXCH8ILE6MDSUPfUeyiRAi9oyyi42Qrgc
         9g6O9jV1dNlGnfNe+bUBK/1RhMfaVFo4cOI+x74B7VXKSztNzSg1cSYsT/XpDMJrc+c3
         YcCw==
X-Gm-Message-State: AGi0PuZFvIAEgvwf/rBiyErRlcnoipEA84PSz5Xwmx2kAdjfm2LpAh40
        4goCKfqzRIocixAiULDDK5uDgg==
X-Google-Smtp-Source: APiQypKy6izjhUbivG+/I6PWV8eR0peu4dabx2HIoItXGvYLmzKEIJJmSlJIMmuJWfJIdDxUx9gC8w==
X-Received: by 2002:a37:61d8:: with SMTP id v207mr26564281qkb.146.1589374305465;
        Wed, 13 May 2020 05:51:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t67sm13779002qka.17.2020.05.13.05.51.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 05:51:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYqrQ-0008K6-D9; Wed, 13 May 2020 09:51:44 -0300
Date:   Wed, 13 May 2020 09:51:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Jon Maloy <jmaloy@redhat.com>,
        Ying Xue <ying.xue@windriver.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        target-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, netdev@vger.kernel.org,
        linux-sctp@vger.kernel.org, ceph-devel@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 11/33] tcp: tcp_sock_set_nodelay
Message-ID: <20200513125144.GC29989@ziepe.ca>
References: <20200513062649.2100053-1-hch@lst.de>
 <20200513062649.2100053-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513062649.2100053-12-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, May 13, 2020 at 08:26:26AM +0200, Christoph Hellwig wrote:
> Add a helper to directly set the TCP_NODELAY sockopt from kernel space
> without going through a fake uaccess.  Cleanup the callers to avoid
> pointless wrappers now that this is a simple function call.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/drbd/drbd_int.h             |  7 ----
>  drivers/block/drbd/drbd_main.c            |  2 +-
>  drivers/block/drbd/drbd_receiver.c        |  4 +--
>  drivers/infiniband/sw/siw/siw_cm.c        | 24 +++-----------
>  drivers/nvme/host/tcp.c                   |  9 +-----
>  drivers/nvme/target/tcp.c                 | 12 ++-----
>  drivers/target/iscsi/iscsi_target_login.c | 15 ++-------
>  fs/cifs/connect.c                         | 10 ++----
>  fs/dlm/lowcomms.c                         |  8 ++---
>  fs/ocfs2/cluster/tcp.c                    | 20 ++----------
>  include/linux/tcp.h                       |  1 +
>  net/ceph/messenger.c                      | 11 ++-----
>  net/ipv4/tcp.c                            | 39 +++++++++++++++--------
>  net/rds/tcp.c                             | 11 +------
>  net/rds/tcp.h                             |  1 -
>  net/rds/tcp_listen.c                      |  2 +-
>  16 files changed, 49 insertions(+), 127 deletions(-)

No problem with the siw change

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
