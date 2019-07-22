Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4475B702AC
	for <lists+linux-sctp@lfdr.de>; Mon, 22 Jul 2019 16:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfGVOw0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 Jul 2019 10:52:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34922 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfGVOw0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 Jul 2019 10:52:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so35629813wmg.0
        for <linux-sctp@vger.kernel.org>; Mon, 22 Jul 2019 07:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OtwL2WXYsGRHVPJPIXi9UPml6pxl+A1wqNFMHbRL99U=;
        b=Zun4WiwRr3wCGBR+CXaL3iAQsr60ULHgg0bxQdha2YqEsZ/HT2oUakW0XodLY191HL
         SApMovHBEDD2Ayg9seU7c3ztX4mgWSKVWL2xzM/XE1irKv0j4Nk74NTZHxRUG/FdZ2RC
         ehGf+67VKNdGk7COitGyn4K3epvISwssSKOz1MKDeC8SYye1Z9bG/P/cFvApyZweeGa2
         DXnrCAiFlE8Ovsr+gWZ3vzZi6P50cBuwDwokzeXzVmvYotja2VZk6jinLnejyVRp/qWX
         e9KXUl+niSuujUY0MgsSR5VzKIVdv7sESCnTHXjyFJjM897f1ndzaf0UJD1VjqeSk2iC
         HFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OtwL2WXYsGRHVPJPIXi9UPml6pxl+A1wqNFMHbRL99U=;
        b=YiZzl4xWz/q+uFUDvS75jk/l1U0bx+ite40Q/NMpP75sAgiXbvKjqZzrzCK4j+Qmqr
         GXLJsmORnDFVWC1TQF/hjlYcWxgm7bDObz2P3tj0zbFkdxXheSohhdeqgyrRIfCU9Khe
         tMnG9nN8e6uy7IK8dGBaCOBAv1FRn1Q7kyHbJYYkCB8UGWGzsTvz3hqaCl1Z5HM2unxQ
         +SUdO5AuS7YbU8h2/4dB6UYcGdXNnEm8xeAj5IPPLbrx+5M/wc3MYQRcRmt49Y/EoUU6
         R1tXY1NrBKDUYhPlSoQGAXhq5qsauOBNM+WplRisqdV5vX4si9Nxo8zSA2BuDUn+2qlf
         bFYQ==
X-Gm-Message-State: APjAAAWaSVIOK8YQQycrMrpT6fdS9A7UkUAEniMQPz6sk5yjn9Mz7Tef
        F2pUKTYl++VS+20yTeo8H0xxG1kljn4vEN/xhFKKxa40
X-Google-Smtp-Source: APXvYqxw6CNoawEekui5DPRAqPAFuCZNAFXzXMoUv4Lq16QLJmw7eJeTbgWV9fpHX2alIaEWaxLYNwuc0QhkhSWHZVg=
X-Received: by 2002:a1c:a6c8:: with SMTP id p191mr60922588wme.99.1563807145259;
 Mon, 22 Jul 2019 07:52:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190718075932.32323-1-jijianwen@gmail.com>
In-Reply-To: <20190718075932.32323-1-jijianwen@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 22 Jul 2019 22:52:13 +0800
Message-ID: <CADvbK_eAirWF0K44K_Ds-TrBZy=LFf7HiyNknGq-v7YcmVjbVg@mail.gmail.com>
Subject: Re: [PATCH lksctp-tools] testlib: improve test_bind function
To:     Jianwen Ji <jijianwen@gmail.com>
Cc:     linux-sctp@vger.kernel.org,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Jul 18, 2019 at 4:00 PM Jianwen Ji <jijianwen@gmail.com> wrote:
>
> Try to bind again if the errno is EADDRINUSE.
> Some tests failed to run sometimes, here is one snapshot:
>
>    ...
>
>    test_sockopt.c 25 PASS : setsockopt(SCTP_PEER_ADDR_PARAMS) - one-to-ma=
ny style invalid hb demand
>    test_sockopt.c 26 BROK : bind: Address already in use
>    DUMP_CORE ../../src/testlib/sctputil.h: 145
>
>    ...
>
>    test_1_to_1_sendmsg.c 10 PASS : sendmsg() on a closed association - EP=
IPE
>    test_1_to_1_sendmsg.c 11 BROK : bind: Address already in use
>    DUMP_CORE ../../src/testlib/sctputil.h: 145
The patch itself works, but there's a warning when I was compiling:
In file included from sctputil.c:54:
./sctputil.h: In function =E2=80=98test_bind=E2=80=99:
./sctputil.h:150:14: warning: implicit declaration of function =E2=80=98sle=
ep=E2=80=99
[-Wimplicit-function-declaration]
   if (i > 0) sleep(1); /* sleep a while before new try... */
              ^~~~~

caused by the lack of '#include <unistd.h>' in src/testlib/sctputil.h

>
> The reason is that it closed a socket and then created a new socket
> to bind the same socket address as before, which was not released
> yet.
>
> Signed-off-by: Jianwen Ji <jijianwen@gmail.com>
> ---
>  src/testlib/sctputil.h | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/src/testlib/sctputil.h b/src/testlib/sctputil.h
> index 9dbabd4..c03ff78 100644
> --- a/src/testlib/sctputil.h
> +++ b/src/testlib/sctputil.h
> @@ -72,6 +72,10 @@ typedef union {
>  #endif
>  #define SCTP_TESTPORT_2 (SCTP_TESTPORT_1+1)
>
> +#ifndef MAX_BIND_RETRYS
> +#define MAX_BIND_RETRYS 10
> +#endif
> +
>  #define SCTP_IP_BCAST          htonl(0xffffffff)
>  #define SCTP_IP_LOOPBACK  htonl(0x7f000001)
>
> @@ -140,9 +144,22 @@ static inline int test_socket(int domain, int type, =
int protocol)
>
>  static inline int test_bind(int sk, struct sockaddr *addr, socklen_t add=
rlen)
>  {
> -       int error =3D bind(sk, addr, addrlen);
> -        if (-1 =3D=3D error)
> -                tst_brkm(TBROK, tst_exit, "bind: %s", strerror(errno));
> +       int error =3D 0, i =3D 0;
> +
> +       do {
> +               if (i > 0) sleep(1); /* sleep a while before new try... *=
/
> +
> +               error =3D bind(sk, addr, addrlen);
> +               if (-1 =3D=3D error && errno !=3D EADDRINUSE) {
> +                       tst_brkm(TBROK, tst_exit, "bind: %s", strerror(er=
rno));
> +               }
> +
> +               i++;
> +               if (i >=3D MAX_BIND_RETRYS) {
> +                       tst_brkm(TBROK, tst_exit, "bind: %s", strerror(er=
rno));
> +               }
> +       } while (error < 0 && i < MAX_BIND_RETRYS);
> +
>         return error;
>  }
>
> --
> 2.14.5
>
