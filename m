Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1570CF96
	for <lists+linux-sctp@lfdr.de>; Tue, 23 May 2023 02:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjEVXeS (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 May 2023 19:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbjEVX2A (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 May 2023 19:28:00 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E471E9
        for <linux-sctp@vger.kernel.org>; Mon, 22 May 2023 16:22:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso42013705e9.2
        for <linux-sctp@vger.kernel.org>; Mon, 22 May 2023 16:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bluerivertech.com; s=google; t=1684797721; x=1687389721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0ezRrv2kYErr3nNhvp9K6N5gLwGXfWht48m1xYMJH0=;
        b=nFl5XPvGzCeDRQkSFEUfCrqWbPcS8PyK/VtGdgpW7UTv6GJfuGooJe40gAYU3Ps2wf
         4Knfc3y3ZwnX4gt+sWWnkV2ZBzmz2EYz56KuRKdaZONaKTUq2BzBaGARAzvgd8842b6X
         JFpryBkbL8KpsW3cmn1GW900c3P7gaAB0HeNp671sarmKIpE0rQ83oghlunvEJ1Qr0Fn
         RrHHxpWJ5sf9VOJjBuWuYQzYDYTT13/5NTbNyZFBWsCWKyKLTGeJUTOVY39hjg4nBQNP
         zyl9yuGi+BQYROLPaI3eqxz81mt2WagJarI69+qo29e2ZOnBuUF/tfnRNA2/jEgBpbEZ
         M8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684797721; x=1687389721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0ezRrv2kYErr3nNhvp9K6N5gLwGXfWht48m1xYMJH0=;
        b=EVzM0nT/ZPT5aAiSS/4/smSY1bN8jVeB+fnvROwNH9vsjgc+2Y9IG7YJs6o3g5Y+oM
         HRjSal2k0Rt4bMtwmu/wijl8aurAn5OvgOUth/bFa1u2EoIoi1wP42Axe+L0HfKapgNz
         TMO2XyqFxOFbUz/jZ6o5HZWFxZ0ICZzdMHaCHZCRM8JyjtdTFm4goNSvhszHEqCqlBUg
         /vJeaSgQR8Rl6KotZBolR4DocLOjByDxn/jTt/2mKJQF6Rx5nmMrp14WOWki5aIzNHe5
         mnrT2PS8Yeh5FeyiTZCt5wUODlOludGeX1uN/yPO4g+iTZwnAM0uEgHl6cOmfKecVmay
         duuA==
X-Gm-Message-State: AC+VfDyFjnbd5S8a3L5D42KxavRwuckVhwpsPTJvpQE/BqSGNk6SFRtt
        WEwcaBHfV1qm4Fm37aSoYeQaoUtIMG4xXxU/O11yhocn2U3Wcdzv
X-Google-Smtp-Source: ACHHUZ4RX0/uyhzriEfU92HJFKAF+57ot++GUYnONGqyEPpvmy2nkSq9jEqvqCodZROoJUZm2/3up4Cr074wsBW0M6I=
X-Received: by 2002:a7b:c7c3:0:b0:3f4:1cd8:3e86 with SMTP id
 z3-20020a7bc7c3000000b003f41cd83e86mr9629860wmk.25.1684797721438; Mon, 22 May
 2023 16:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <CALP-OgmKKFb4gMH0L6WYsxonBLDHbFHgpbc1=QY1N9HnFctWxQ@mail.gmail.com>
 <gthfvvjti4fz3z67373utythbfe5yxxhhayofbzusahy7ii4oq@drabuyrfycig>
 <CALP-OgntP2Tj3H_GK0ZODa95gJb5NnLt26O0YPkgx4VsMF-Yqg@mail.gmail.com> <CADvbK_f=TLj0M7zuF+3sE+91R2c+waDA2t30MvdH7KU619qQYw@mail.gmail.com>
In-Reply-To: <CADvbK_f=TLj0M7zuF+3sE+91R2c+waDA2t30MvdH7KU619qQYw@mail.gmail.com>
From:   Adam Snaider <adam.snaider@bluerivertech.com>
Date:   Mon, 22 May 2023 16:21:50 -0700
Message-ID: <CALP-OgmH8ZegbJDOj6QxXpNaLQT7cnRvBJzJ-67urfqMuWXe-w@mail.gmail.com>
Subject: Re: SCTP Authentication Current State and Examples
To:     Xin Long <lucien.xin@gmail.com>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Ah that makes sense! Thank you

On Mon, May 22, 2023 at 12:58=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> Hi, Adam,
>
> Thanks for the scripts.
>
> In SCTP, after 'sysctl net.sctp.auth_enable=3D1' and
> setsockopt(SCTP_AUTH_CHUNK), it will tell the peer that this side
> supports auth. Meanwhile, the kernel creates a 'null_key' (key_id =3D 0)
> as the default one.
>
> The peer uses the shared key (key_id =3D 0) for the auth chunk if it
> doesn't set up any key, like on your client side. On your server side,
> it added a new shared key (key_id =3D 1), but the server still can
> process the incoming auth chunk with the shared key (key_id =3D 0), even
> if it's not the active key,  unless you deleted the shared key (key_id
> =3D 0).
>
> Just note that it's the peer's choice which sh_key it will use, and it
> uses key_id =3D 0 by default. If you want the authentication to fail in
> your case, try to delete the shared key (key_id =3D 0) after you set up
> the new one (key_id =3D 1):
>
>         authkeyid.scact_keynumber =3D 0;
>         ASSERT(setsockopt(fd, IPPROTO_SCTP, SCTP_AUTH_DELETE_KEY,
> &authkeyid, sizeof(authkeyid)) =3D=3D 0,
>                "fail to del key");
>
> Make sense?
>
> Thanks.
>
> On Mon, May 22, 2023 at 1:52=E2=80=AFPM Adam Snaider
> <adam.snaider@bluerivertech.com> wrote:
> >
> > Hi Marcelo,
> >
> > Thank you for your response. The issue I'm facing is that if I set up a=
 server with authentication using some random key, then I'm still able to r=
eceive data from a client that didn't set up the shared key itself. However=
, if the client also sets up authentication but the key is incorrect, then =
the server refuses the message and it tries again (which is similar to what=
 I would expect).
> > The code I'm using is here: https://gist.github.com/brt-adam-snaider/30=
76ab06f846384f5a7f87ad54ddd276, where the server calls `Bind` and the clien=
t calls `Unbound` to create their respective sockets. (Note how I purposely=
 only set up the authentication key in the `Bind` call). Running tcpdump ho=
wever, I can see that there are authenticated chunks being sent (since the =
chunk type is 0xf), so I'm not sure why the server is receiving those witho=
ut errors.
> >
> > Thank you for the help! And for what it's worth, I would love to contri=
bute some documentation once I'm done working with this :)
> >
> > Best,
> > Adam
> >
> >
> > On Fri, May 19, 2023 at 6:09=E2=80=AFPM Marcelo Ricardo Leitner <marcel=
o.leitner@gmail.com> wrote:
> >>
> >> On Mon, May 15, 2023 at 12:00:00PM -0700, Adam Snaider wrote:
> >> > Hi folks,
> >> >
> >> > I would like to ask what the current state is for SCTP Authenticatio=
n
> >> > in the Linux kernel (as described by rfc4895). I've been attempting =
to
> >> > use an SCTP authenticated socket in the 5.10 kernel but all my effor=
ts
> >> > are fruitless so far. Given the lack of examples around, I'm not sur=
e
> >> > if my setup is incorrect or if the linux implementation is incomplet=
e.
> >> > If there are any references or examples I can look at I would really
> >> > appreciate it.
> >>
> >> Hi Adam,
> >>
> >> The support should be complete, but yeah, I am not aware of examples
> >> with Auth. Would you mind sharing a minimal reproducer that didn't
> >> work for you?
> >>
> >> Thanks,
> >> Marcelo
