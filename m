Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D95370CA20
	for <lists+linux-sctp@lfdr.de>; Mon, 22 May 2023 21:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjEVT6H (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 22 May 2023 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjEVT6H (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 22 May 2023 15:58:07 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4058895
        for <linux-sctp@vger.kernel.org>; Mon, 22 May 2023 12:58:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ba827a34ba8so9553887276.0
        for <linux-sctp@vger.kernel.org>; Mon, 22 May 2023 12:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684785485; x=1687377485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPKM3v2prU/w1pKOQ2HYDH0rpZOduoVtDnXX+IRYP+Q=;
        b=ChfaiDGySoEl6/jCALtHzIQYFSRZjHUnmUCwIKBMDzWtulksNazFTuh1ih6mTAW1ks
         o346Ca/NU6uD+i4G9/q6au3fOskAgSgIIEyHMihWg4Y8jPnGT9wzSqR/OG/fnWsiIYwP
         9197X4+8CKzDb1EijEJdtfI9Dg4fpa2eCpYleYd+PGh7NI4p/WLMQDnGEwa1jnuRTz6q
         y63pfQdlbYzXQ0BzpJCUbuDkW6UQhrzF9/OFArnowdJxE3+8m965SCbIJQ3g/WGIwknY
         atlznYxM49c6GGyei/AfgtiyT2uwZGxLERJoFYrlkTcbxmF4wtAoQghAjvihRGPP8tbg
         zcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684785485; x=1687377485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPKM3v2prU/w1pKOQ2HYDH0rpZOduoVtDnXX+IRYP+Q=;
        b=AClgbYvDpE9HARTGCf1aGNApesmB5PYDT0BgNB9tn9lT8oyrrW9zHjn2VhrdCOP/Nd
         e3/HZ9kW/dbZByrnr1RbydxQ9FVafI4WC1SqWrb/83MF/dQWynL/mYV6/SosndxrKwsx
         Q4GbcqoExnD+viu7YXQNjBa7Q8KJsCQOFXrUyiqBN7+CHJXJ5o+MGXJmq6zX6t/g1UAB
         /kTCXf1G0DVFIGbYjcB6RBaX735D9BaZHcc/BCxZzb7wqipcU1OOmZ7PRQAu1mVeVh2I
         iOg6Yrs22ix36Ot7woKs0JL89+oGcJm2l9/pUpEmOSh17nzoAzYsJycuRrpfgPp8ZF8C
         vVNA==
X-Gm-Message-State: AC+VfDyXf9GhJebJozasoTZpRTdjt5UtgjPIO+EQ5fSlyoSHd/AkuRz/
        OqKwqYjO++JkLD0XIWa1qiVhcv1r9WmzpH87+VIJCVxaQfY=
X-Google-Smtp-Source: ACHHUZ5mv8D5PQrTbpWUJ0+eRcSARSHDM6OUFkxoPbxNqRxPjkm9+F/3Df8AQN2bzoYPrKzvzt1ZlRquYeq37LxPI08=
X-Received: by 2002:a81:728a:0:b0:55a:4f00:b05c with SMTP id
 n132-20020a81728a000000b0055a4f00b05cmr11741123ywc.33.1684785485422; Mon, 22
 May 2023 12:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <CALP-OgmKKFb4gMH0L6WYsxonBLDHbFHgpbc1=QY1N9HnFctWxQ@mail.gmail.com>
 <gthfvvjti4fz3z67373utythbfe5yxxhhayofbzusahy7ii4oq@drabuyrfycig> <CALP-OgntP2Tj3H_GK0ZODa95gJb5NnLt26O0YPkgx4VsMF-Yqg@mail.gmail.com>
In-Reply-To: <CALP-OgntP2Tj3H_GK0ZODa95gJb5NnLt26O0YPkgx4VsMF-Yqg@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 22 May 2023 15:57:32 -0400
Message-ID: <CADvbK_f=TLj0M7zuF+3sE+91R2c+waDA2t30MvdH7KU619qQYw@mail.gmail.com>
Subject: Re: SCTP Authentication Current State and Examples
To:     Adam Snaider <adam.snaider@bluerivertech.com>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi, Adam,

Thanks for the scripts.

In SCTP, after 'sysctl net.sctp.auth_enable=3D1' and
setsockopt(SCTP_AUTH_CHUNK), it will tell the peer that this side
supports auth. Meanwhile, the kernel creates a 'null_key' (key_id =3D 0)
as the default one.

The peer uses the shared key (key_id =3D 0) for the auth chunk if it
doesn't set up any key, like on your client side. On your server side,
it added a new shared key (key_id =3D 1), but the server still can
process the incoming auth chunk with the shared key (key_id =3D 0), even
if it's not the active key,  unless you deleted the shared key (key_id
=3D 0).

Just note that it's the peer's choice which sh_key it will use, and it
uses key_id =3D 0 by default. If you want the authentication to fail in
your case, try to delete the shared key (key_id =3D 0) after you set up
the new one (key_id =3D 1):

        authkeyid.scact_keynumber =3D 0;
        ASSERT(setsockopt(fd, IPPROTO_SCTP, SCTP_AUTH_DELETE_KEY,
&authkeyid, sizeof(authkeyid)) =3D=3D 0,
               "fail to del key");

Make sense?

Thanks.

On Mon, May 22, 2023 at 1:52=E2=80=AFPM Adam Snaider
<adam.snaider@bluerivertech.com> wrote:
>
> Hi Marcelo,
>
> Thank you for your response. The issue I'm facing is that if I set up a s=
erver with authentication using some random key, then I'm still able to rec=
eive data from a client that didn't set up the shared key itself. However, =
if the client also sets up authentication but the key is incorrect, then th=
e server refuses the message and it tries again (which is similar to what I=
 would expect).
> The code I'm using is here: https://gist.github.com/brt-adam-snaider/3076=
ab06f846384f5a7f87ad54ddd276, where the server calls `Bind` and the client =
calls `Unbound` to create their respective sockets. (Note how I purposely o=
nly set up the authentication key in the `Bind` call). Running tcpdump howe=
ver, I can see that there are authenticated chunks being sent (since the ch=
unk type is 0xf), so I'm not sure why the server is receiving those without=
 errors.
>
> Thank you for the help! And for what it's worth, I would love to contribu=
te some documentation once I'm done working with this :)
>
> Best,
> Adam
>
>
> On Fri, May 19, 2023 at 6:09=E2=80=AFPM Marcelo Ricardo Leitner <marcelo.=
leitner@gmail.com> wrote:
>>
>> On Mon, May 15, 2023 at 12:00:00PM -0700, Adam Snaider wrote:
>> > Hi folks,
>> >
>> > I would like to ask what the current state is for SCTP Authentication
>> > in the Linux kernel (as described by rfc4895). I've been attempting to
>> > use an SCTP authenticated socket in the 5.10 kernel but all my efforts
>> > are fruitless so far. Given the lack of examples around, I'm not sure
>> > if my setup is incorrect or if the linux implementation is incomplete.
>> > If there are any references or examples I can look at I would really
>> > appreciate it.
>>
>> Hi Adam,
>>
>> The support should be complete, but yeah, I am not aware of examples
>> with Auth. Would you mind sharing a minimal reproducer that didn't
>> work for you?
>>
>> Thanks,
>> Marcelo
