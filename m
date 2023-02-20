Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDB469C605
	for <lists+linux-sctp@lfdr.de>; Mon, 20 Feb 2023 08:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBTHbu (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 20 Feb 2023 02:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjBTHbt (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 20 Feb 2023 02:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2145CFF15
        for <linux-sctp@vger.kernel.org>; Sun, 19 Feb 2023 23:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676878260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e2Kmuoaib0oNG3Oitg5BoZAMA1UnBwRwe43Zl3WNYig=;
        b=fjnUc37rW/VT4MTBajxQhAUyPYHAwlkNpyH2nEEU7MbmFW3jbfisuvfSg9qL8voYjFWFDM
        tSkGvnhALwnH/H34K1Bpuk8y6vVHifAhYTFuo6gbLp6jE7AnYXrjtwKgECHerG0AWrDRxo
        noisvCMRxloEMin92j/rDg/6lGPDZbs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-352-tsxkmBa5N3a3HAgbzBHMpA-1; Mon, 20 Feb 2023 02:30:59 -0500
X-MC-Unique: tsxkmBa5N3a3HAgbzBHMpA-1
Received: by mail-wm1-f69.google.com with SMTP id j6-20020a05600c1c0600b003e1f2de4b2bso250849wms.6
        for <linux-sctp@vger.kernel.org>; Sun, 19 Feb 2023 23:30:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676878257;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WSQ5Ei3Zvz9A/QACc0nBE3Xi0KTGh3+qsOVF5MllOJg=;
        b=Lr8LIDAkaXFD6fY/VmVbwuXlxVFfsVzGYhcIsMEsKq9LkCKiOWR2gm/Oef5PUBqmrX
         8PFH80ln6HYnUV35NW5zmQcr2JyYgCjD9gqPeeDoCejxIBaj8A5uf6SmrO5VLSJH0R/i
         UPkT2wfVy6zSTtcW3Qk3kUHhWaOojecPK69H/j4tRC8bBWhqHrwkN8gJt4co7JWzhuA1
         vejGTQ8ZzNro4ZtOJGBv5ygZykqZHv6Vv3oCoZ31W9ImXN1axJSLgpEh7KOynUDOfEPo
         FWYd3PG2iFpiMHSZPqIXqsRXzjvhhFZu56H19yV4onGWODRw1mqjQ70Fi1X6OSuWmeXw
         +8QQ==
X-Gm-Message-State: AO0yUKWlpiYIRjrcnAgwVh/oJXwSJFlHTPyT3t9WZPLofumtEDO4pk8d
        Ndbj0E2nI0C79miLhhS0YOtPaUGzETXfLLJXbDXpqaMg/RzicL/r6nc7StQ0oQmLOqijJWMMYqo
        bpPJo5MrxMqlwFcXu2JbJ7dYePks=
X-Received: by 2002:a5d:5646:0:b0:2c6:3cec:944f with SMTP id j6-20020a5d5646000000b002c63cec944fmr305971wrw.1.1676878257298;
        Sun, 19 Feb 2023 23:30:57 -0800 (PST)
X-Google-Smtp-Source: AK7set8Hkb2K6ybIPCNlb5y3Oo877yE49uQduXHsl4jNdg2MI8oLixugt2CWr0pfNP8vKiNjBhr4zQ==
X-Received: by 2002:a5d:5646:0:b0:2c6:3cec:944f with SMTP id j6-20020a5d5646000000b002c63cec944fmr305959wrw.1.1676878256983;
        Sun, 19 Feb 2023 23:30:56 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-121-8.dyn.eolo.it. [146.241.121.8])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d654e000000b002c5801aa9b0sm1095103wrv.40.2023.02.19.23.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 23:30:56 -0800 (PST)
Message-ID: <744a8737ce7dc2f149c82738e4ab15233d0b35d9.camel@redhat.com>
Subject: Re: [PATCH net] sctp: add a refcnt in sctp_stream_priorities to
 avoid a nested loop
From:   Paolo Abeni <pabeni@redhat.com>
To:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>
Date:   Mon, 20 Feb 2023 08:30:54 +0100
In-Reply-To: <06ac4e517bff69c23646594d3b404b9ffb51001c.1676491484.git.lucien.xin@gmail.com>
References: <06ac4e517bff69c23646594d3b404b9ffb51001c.1676491484.git.lucien.xin@gmail.com>
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

Hello,

On Wed, 2023-02-15 at 15:04 -0500, Xin Long wrote:
> With this refcnt added in sctp_stream_priorities, we don't need to
> traverse all streams to check if the prio is used by other streams
> when freeing one stream's prio in sctp_sched_prio_free_sid(). This
> can avoid a nested loop (up to 65535 * 65535), which may cause a
> stuck as Ying reported:
>=20
>     watchdog: BUG: soft lockup - CPU#23 stuck for 26s! [ksoftirqd/23:136]
>     Call Trace:
>      <TASK>
>      sctp_sched_prio_free_sid+0xab/0x100 [sctp]
>      sctp_stream_free_ext+0x64/0xa0 [sctp]
>      sctp_stream_free+0x31/0x50 [sctp]
>      sctp_association_free+0xa5/0x200 [sctp]
>=20
> Note that it doesn't need to use refcount_t type for this counter,
> as its accessing is always protected under the sock lock.
>=20
> Fixes: 9ed7bfc79542 ("sctp: fix memory leak in sctp_stream_outq_migrate()=
")
> Reported-by: Ying Xu <yinxu@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  include/net/sctp/structs.h   |  1 +
>  net/sctp/stream_sched_prio.c | 47 +++++++++++++-----------------------
>  2 files changed, 18 insertions(+), 30 deletions(-)
>=20
> diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
> index afa3781e3ca2..e1f6e7fc2b11 100644
> --- a/include/net/sctp/structs.h
> +++ b/include/net/sctp/structs.h
> @@ -1412,6 +1412,7 @@ struct sctp_stream_priorities {
>  =09/* The next stream in line */
>  =09struct sctp_stream_out_ext *next;
>  =09__u16 prio;
> +=09__u16 users;

I'm sorry for the late feedback. Reading the commit message, it looks
like this counter could reach at least 64K. Is a __u16 integer wide
enough?

Thanks!

Paolo

