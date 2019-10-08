Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03054CF921
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Oct 2019 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730840AbfJHMEH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Oct 2019 08:04:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22294 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730156AbfJHMEH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 8 Oct 2019 08:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570536245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbJLDy1ZPYHNz2LrI3z0iA4CSqhVHSIrwsz5DE58ic0=;
        b=EMiC6VlZNA9UuItgoZlXiolubZab4wexcT/tWhO/W2ARbE1i7wvpSNod+6WcCbyyyk2RRX
        CcVSS8m/Y7TimqOYpYWAzLW6Fn14qnSJGJ3dymuYGSP61Ctim4HBCs0tC/84xz074qzADR
        JcEOYQQHD/P+CaGqapdfUBTPejWgdg0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221--yVbkSvKNFe0j2mktvDAXQ-1; Tue, 08 Oct 2019 08:04:03 -0400
Received: by mail-oi1-f200.google.com with SMTP id x125so10231962oig.7
        for <linux-sctp@vger.kernel.org>; Tue, 08 Oct 2019 05:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZ3wKA1psc8IuEMyxTFIHivEE24aloWcVuBR0kLF7VU=;
        b=JH33hdzVJBBnGFXjKM4JjYF8nheyVI5iA5zBxQ5kLlEc5H3Top2XmdcGSHG612PwIh
         H2V0tUwHWT0UCZYxZcOEmDSaOBWLAOjb+gJa529xcP5z7QbPmVJ/7N3bG92sr2dsA3l2
         uKNPbekfZSlbBLoL4DsN/JNdt8CjMQ4Pq5rPXz9xgVBtZ0JF9XGXxnnVp7p2UEs9SDJu
         eaOHx5DN64jM41/0jU4dVgVMcE0ItNhFd7iz6sipn9/I65svQRSPgth4j6uoXGpigp9n
         14dUj1Z/LpHeqJpdvbjO6GSNheae7wcHDe0/XJzaRv2u1l/xTh0iJkeCjnTbNg1t0q6b
         9VWQ==
X-Gm-Message-State: APjAAAWgeNVgAHu6yxCGE8s5ZVOK69vz1tmqJD3sLMcGxdA7DX3AzGlI
        FjamdQMnaRfssGsE8tBNnGHKwr2SAYPTVMUs37laxaElZb6rnRjzotxTyESBDSl64MSUL/+mO2G
        R946vIkPxcRiojsRqvkZzkNouJa3sOZGEOHmQRQ==
X-Received: by 2002:a9d:19e2:: with SMTP id k89mr25208996otk.197.1570536242863;
        Tue, 08 Oct 2019 05:04:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzppXdnja8FupoG4zqGbhP+Wg9Igxeu6F+ydYIOK40i2kalVoBoZO3n6CAXDyz/uMWKz+QmQsP1Jr4VTk0HAKI=
X-Received: by 2002:a9d:19e2:: with SMTP id k89mr25208970otk.197.1570536242483;
 Tue, 08 Oct 2019 05:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <d8dd0065232e5c3629bf55e54e3a998110ec1aef.1570532963.git.lucien.xin@gmail.com>
In-Reply-To: <d8dd0065232e5c3629bf55e54e3a998110ec1aef.1570532963.git.lucien.xin@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 8 Oct 2019 14:03:51 +0200
Message-ID: <CAFqZXNu9dFc4uros8CTe7SxJPABzppAir9bpGnVMHge_MqMueQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: add chunks to sk_backlog when the newsk
 sk_socket is not set
To:     Xin Long <lucien.xin@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
X-MC-Unique: -yVbkSvKNFe0j2mktvDAXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Oct 8, 2019 at 1:09 PM Xin Long <lucien.xin@gmail.com> wrote:
> This patch is to fix a NULL-ptr deref in selinux_socket_connect_helper:
>
>   [...] kasan: GPF could be caused by NULL-ptr deref or user memory acces=
s
>   [...] RIP: 0010:selinux_socket_connect_helper+0x94/0x460
>   [...] Call Trace:
>   [...]  selinux_sctp_bind_connect+0x16a/0x1d0
>   [...]  security_sctp_bind_connect+0x58/0x90
>   [...]  sctp_process_asconf+0xa52/0xfd0 [sctp]
>   [...]  sctp_sf_do_asconf+0x785/0x980 [sctp]
>   [...]  sctp_do_sm+0x175/0x5a0 [sctp]
>   [...]  sctp_assoc_bh_rcv+0x285/0x5b0 [sctp]
>   [...]  sctp_backlog_rcv+0x482/0x910 [sctp]
>   [...]  __release_sock+0x11e/0x310
>   [...]  release_sock+0x4f/0x180
>   [...]  sctp_accept+0x3f9/0x5a0 [sctp]
>   [...]  inet_accept+0xe7/0x720
>
> It was caused by that the 'newsk' sk_socket was not set before going to
> security sctp hook when processing asconf chunk with SCTP_PARAM_ADD_IP
> or SCTP_PARAM_SET_PRIMARY:
>
>   inet_accept()->
>     sctp_accept():
>       lock_sock():
>           lock listening 'sk'
>                                           do_softirq():
>                                             sctp_rcv():  <-- [1]
>                                                 asconf chunk arrives and
>                                                 enqueued in 'sk' backlog
>       sctp_sock_migrate():
>           set asoc's sk to 'newsk'
>       release_sock():
>           sctp_backlog_rcv():
>             lock 'newsk'
>             sctp_process_asconf()  <-- [2]
>             unlock 'newsk'
>     sock_graft():
>         set sk_socket  <-- [3]
>
> As it shows, at [1] the asconf chunk would be put into the listening 'sk'
> backlog, as accept() was holding its sock lock. Then at [2] asconf would
> get processed with 'newsk' as asoc's sk had been set to 'newsk'. However,
> 'newsk' sk_socket is not set until [3], while selinux_sctp_bind_connect()
> would deref it, then kernel crashed.
>
> Here to fix it by adding the chunk to sk_backlog until newsk sk_socket is
> set when .accept() is done.
>
> Note that sk->sk_socket can be NULL when the sock is closed, so SOCK_DEAD
> flag is also needed to check in sctp_newsk_ready().
>
> Thanks to Ondrej for reviewing the code.

And thank you, Long, for tracking it down and finding a fix :)

Cc'ing also SELinux and LSM mailing lists as a heads-up.

>
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Reported-by: Ying Xu <yinxu@redhat.com>
> Suggested-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  include/net/sctp/sctp.h |  5 +++++
>  net/sctp/input.c        | 12 +++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index 5d60f13..3ab5c6b 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -610,4 +610,9 @@ static inline __u32 sctp_min_frag_point(struct sctp_s=
ock *sp, __u16 datasize)
>         return sctp_mtu_payload(sp, SCTP_DEFAULT_MINSEGMENT, datasize);
>  }
>
> +static inline bool sctp_newsk_ready(const struct sock *sk)
> +{
> +       return sock_flag(sk, SOCK_DEAD) || sk->sk_socket;
> +}
> +
>  #endif /* __net_sctp_h__ */
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> index 5a070fb..f277137 100644
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -243,7 +243,7 @@ int sctp_rcv(struct sk_buff *skb)
>                 bh_lock_sock(sk);
>         }
>
> -       if (sock_owned_by_user(sk)) {
> +       if (sock_owned_by_user(sk) || !sctp_newsk_ready(sk)) {
>                 if (sctp_add_backlog(sk, skb)) {
>                         bh_unlock_sock(sk);
>                         sctp_chunk_free(chunk);
> @@ -321,7 +321,7 @@ int sctp_backlog_rcv(struct sock *sk, struct sk_buff =
*skb)
>                 local_bh_disable();
>                 bh_lock_sock(sk);
>
> -               if (sock_owned_by_user(sk)) {
> +               if (sock_owned_by_user(sk) || !sctp_newsk_ready(sk)) {
>                         if (sk_add_backlog(sk, skb, sk->sk_rcvbuf))
>                                 sctp_chunk_free(chunk);
>                         else
> @@ -336,7 +336,13 @@ int sctp_backlog_rcv(struct sock *sk, struct sk_buff=
 *skb)
>                 if (backloged)
>                         return 0;
>         } else {
> -               sctp_inq_push(inqueue, chunk);
> +               if (!sctp_newsk_ready(sk)) {
> +                       if (!sk_add_backlog(sk, skb, sk->sk_rcvbuf))
> +                               return 0;
> +                       sctp_chunk_free(chunk);
> +               } else {
> +                       sctp_inq_push(inqueue, chunk);
> +               }
>         }
>
>  done:
> --
> 2.1.0
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

