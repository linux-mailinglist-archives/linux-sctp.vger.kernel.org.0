Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D766D6B2176
	for <lists+linux-sctp@lfdr.de>; Thu,  9 Mar 2023 11:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjCIKcI (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 9 Mar 2023 05:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCIKcF (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 9 Mar 2023 05:32:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4198A19C46
        for <linux-sctp@vger.kernel.org>; Thu,  9 Mar 2023 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678357876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GLUiKLF9AN3IhID+zo9c93EAAc9beIhHQ9nvddb8ZIk=;
        b=c57S4SzyokZjddSK6r+ATquzT9Y6WZyO2vEuAnE6puIW8Ph/7T2Q/kzx3UnIh6PSGbZQh6
        B+3ViaB5426AeNyQ9IkLTn1p2BvGhbQFbMMH1ODcFkviSWB0HyK5IRgit9j86WdJuwxLjj
        aAnxntN6Hwxr+zpQs7sJ8PuS/DeELMw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-Q9-GzUgTMEiRN-dk_3_6aQ-1; Thu, 09 Mar 2023 05:31:15 -0500
X-MC-Unique: Q9-GzUgTMEiRN-dk_3_6aQ-1
Received: by mail-wr1-f70.google.com with SMTP id x3-20020a5d6503000000b002c8c421fdfaso310089wru.15
        for <linux-sctp@vger.kernel.org>; Thu, 09 Mar 2023 02:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678357874;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n68uNgs6PpJkrH3hTHjafe5p54xSC0RPGEH/q+n6tt8=;
        b=O6AHZGCqHxhz5GJRSOg64cMwt8JVwDNdc1Tkq0XcF52LvSOKk/bVWJWI2W5CiFxc4d
         W2vo2LsZLagIL4e18VYHiyfOrh73uztJyY0Y+T2SszABf7CvvuSmhuOpZ1nI45e6UNjg
         VxU0ERuFChVaP5FRy5nNRSKpUrlMXr3iQwKStzhlTUZLMoIKyw4dKEoEa8663xJRJ6jg
         8LWGVczTs7X/oT33xZzisuo/ih9DkhNQhPGvG9yZ9GYyKxfANBEs97dAJtZtZc9YAAAm
         KHETLnqm2+KdIJAWR3vJhF1SXP0y/WeNzqgFtBGVwSxyFQhFr9JvK5kD7HBeJSvJyLv3
         7DTg==
X-Gm-Message-State: AO0yUKXOhgYt4d9lJhIIu5ZKIH8tLb54sP63fnZ8y9fa264VZBz1lOx6
        CvwgX5hIVoeHD6Tk25EmRWN8AOdKtXBnnKv7LMipfOS+9ABeAGuX+WcfbPJ2Dru1ID1uj1ahjd8
        DkPXtqsmH+XPc1bEYD1tJbw==
X-Received: by 2002:a05:600c:4f50:b0:3eb:42f6:ac55 with SMTP id m16-20020a05600c4f5000b003eb42f6ac55mr17914614wmq.1.1678357873940;
        Thu, 09 Mar 2023 02:31:13 -0800 (PST)
X-Google-Smtp-Source: AK7set+UNKRTpKJwy/t8WZ8m3LFA6MnUeFm4+Nupc8WNJb6zQWAODikVHRL0uNPM96EPioeOKFXiKQ==
X-Received: by 2002:a05:600c:4f50:b0:3eb:42f6:ac55 with SMTP id m16-20020a05600c4f5000b003eb42f6ac55mr17914599wmq.1.1678357873693;
        Thu, 09 Mar 2023 02:31:13 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-28.dyn.eolo.it. [146.241.121.28])
        by smtp.gmail.com with ESMTPSA id w7-20020a5d6087000000b002c567b58e9asm17744677wrt.56.2023.03.09.02.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:31:13 -0800 (PST)
Message-ID: <09cdc1990818a26fd0e3514b7619261ebc0da50f.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] sctp: add fair capacity stream scheduler
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Date:   Thu, 09 Mar 2023 11:31:12 +0100
In-Reply-To: <3e977ca635d6b8ef8440d5eed2617a4f3a04b15b.1678224012.git.lucien.xin@gmail.com>
References: <cover.1678224012.git.lucien.xin@gmail.com>
         <3e977ca635d6b8ef8440d5eed2617a4f3a04b15b.1678224012.git.lucien.xin@gmail.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, 2023-03-07 at 16:23 -0500, Xin Long wrote:
> diff --git a/net/sctp/stream_sched_fc.c b/net/sctp/stream_sched_fc.c
> new file mode 100644
> index 000000000000..b336c2f5486b
> --- /dev/null
> +++ b/net/sctp/stream_sched_fc.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* SCTP kernel implementation
> + * (C) Copyright Red Hat Inc. 2022
> + *
> + * This file is part of the SCTP kernel implementation
> + *
> + * These functions manipulate sctp stream queue/scheduling.
> + *
> + * Please send any bug reports or fixes you make to the
> + * email addresched(es):
> + *    lksctp developers <linux-sctp@vger.kernel.org>
> + *
> + * Written or modified by:
> + *    Xin Long <lucien.xin@gmail.com>
> + */
> +
> +#include <linux/list.h>
> +#include <net/sctp/sctp.h>

Note that the above introduces a new compile warning:

../net/sctp/stream_sched_fc.c: note: in included file (through ../include/n=
et/sctp/sctp.h):
../include/net/sctp/structs.h:335:41: warning: array of flexible structures

that is not really a fault of the new code, it's due to:

=09struct sctp_init_chunk peer_init[];

struct sctp_init_chunk {
        struct sctp_chunkhdr chunk_hdr;
        struct sctp_inithdr init_hdr;
};

struct sctp_inithdr {
        __be32 init_tag;
        __be32 a_rwnd;
        __be16 num_outbound_streams;
        __be16 num_inbound_streams;
        __be32 initial_tsn;
        __u8  params[]; // <- this!
};

Any chance a future patch could remove the 'params' field from the
struct included by sctp_init_chunk?

e.g.=20

struct sctp_inithdr_base {
        __be32 init_tag;
        __be32 a_rwnd;
        __be16 num_outbound_streams;
        __be16 num_inbound_streams;
        __be32 initial_tsn;
};

struct sctp_init_chunk {
        struct sctp_chunkhdr chunk_hdr;
        struct sctp_inithdr_base init_hdr;
};

and then cast 'init_hdr' to 'struct sctp_inithdr' if/where needed.

In any case, the above is not blocking this series.

Cheers,

Paolo

