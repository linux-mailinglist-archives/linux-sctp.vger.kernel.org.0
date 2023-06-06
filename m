Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198C67240FD
	for <lists+linux-sctp@lfdr.de>; Tue,  6 Jun 2023 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbjFFLf2 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 6 Jun 2023 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbjFFLf1 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 6 Jun 2023 07:35:27 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B7E196
        for <linux-sctp@vger.kernel.org>; Tue,  6 Jun 2023 04:35:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f7368126a6so23383225e9.0
        for <linux-sctp@vger.kernel.org>; Tue, 06 Jun 2023 04:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1686051322; x=1688643322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lvATKcdZSwuPOJh2GRkP6X8hkhA21/bnoihEc7xpbVg=;
        b=kkLLVCklE5BWE+AJ9mXI4TIQutfTJhTLR6Slhen4KahnxjKdtVRy37/sFU0L+Q+db2
         OExJHd2WMUVHHy6wUwwAkaF0vfd6P3q5pVBjt3o7stpyWEZOq3L8HRzNPiMaojaJLjvA
         whYeOY1676CfIKjVytE6OXhftebOvEjMHDq20m/8J6oZs00MR0GXwk1eU3rxIHHGqhh8
         EuxOG3+EJPg4oM57NrpX2KBsoJcBNhnVVlRpCMXbWhC9nT7WpY69fpV4TqBQpCaZrLgy
         nT5NAmrWS8vxhM7J1Fvq3uGiN0E7zVpqBdei+OWDlOZs4r4YLUzw9/phQ76BHDNAFTls
         H0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686051322; x=1688643322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lvATKcdZSwuPOJh2GRkP6X8hkhA21/bnoihEc7xpbVg=;
        b=U0KDWuUX1t6YloXSESBQnW7UlNx84dwr9e4SohWaun5IfAZAuVD8AIb1XWSu4i0NS/
         8Mho1XMbUSKO4fhmV1UaQJ9cYfMMd4aY6bbakwqMz2gdP2xK6FZVFABA/g1x0rINR3dT
         KEL/oeTz912oMhXIYV3SqfdCerxK0ZLepzoPqaOcQPuVpwTIG/6+xOW2VaFlQPJTS1Mb
         4iqa/1PrjgctZhKw2hfM77SmhVzbK+iZ6t+ZaJaZlp1bJRiVacmIwInJUW2WpIOTsHDj
         8iOaM/nDy2pgkFvCFTtgUzZn06yMiTsfhGhzlg149DgF42Wj8621dl72FjKOFguLvM2K
         FHaw==
X-Gm-Message-State: AC+VfDwahY73+S745ESw8d4wwLeFAMXVvMJ6pHOo7p3Ww4zIeHJGJr4Y
        xnlXILjrKb66hvs2D4hM4QhIpQ==
X-Google-Smtp-Source: ACHHUZ5kD2v+8EkF8x2chCUib+bgiV9eyH42+QjLZKwrasuxwl/S8sfhnB72NeeoY1SloBs4skJaXQ==
X-Received: by 2002:a1c:6a12:0:b0:3f0:b1c9:25d4 with SMTP id f18-20020a1c6a12000000b003f0b1c925d4mr1855738wmc.21.1686051322295;
        Tue, 06 Jun 2023 04:35:22 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:426c:bb31:d569:3738? ([2a02:578:8593:1200:426c:bb31:d569:3738])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bcb90000000b003f6028a4c85sm17233920wmi.16.2023.06.06.04.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 04:35:22 -0700 (PDT)
Message-ID: <c709b7d0-6b06-4fc9-a99a-520ec13550ac@tessares.net>
Date:   Tue, 6 Jun 2023 13:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v5] net: ioctl: Use kernel memory on protocol
 ioctl callbacks
Content-Language: en-GB
To:     Breno Leitao <leitao@debian.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Ahern <dsahern@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, axboe@kernel.dk,
        asml.silence@gmail.com, leit@fb.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
        linux-sctp@vger.kernel.org
References: <20230602163044.1820619-1-leitao@debian.org>
 <CAF=yD-Kk9mVWPZN50NUu8uGwEbySNS-WzvJ=1HTTcVsA6OOuvA@mail.gmail.com>
 <ZHxEX0TlXX7VV9kX@gmail.com>
 <CAF=yD-LvTDmWp+wAqwuQ7vKLT0hAHcQjV9Ef2rEag5J4cSZrkA@mail.gmail.com>
 <ZH8Ga15IFIUUA7j8@gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ZH8Ga15IFIUUA7j8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Breno,

On 06/06/2023 12:11, Breno Leitao wrote:
> On Sun, Jun 04, 2023 at 11:17:56AM +0200, Willem de Bruijn wrote:
>>> On Sat, Jun 03, 2023 at 10:21:50AM +0200, Willem de Bruijn wrote:
>>>> On Fri, Jun 2, 2023 at 6:31 PM Breno Leitao <leitao@debian.org> wrote:
>>>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>>>
>>>> Please check the checkpatch output
>>>>
>>>> https://patchwork.hopto.org/static/nipa/753609/13265673/checkpatch/stdout
>>>
>>> I am checking my current checkpatch before sending the patch, but I am
>>> not seeing the problems above.
>>>
>>> My tree is at 44c026a73be8038 ("Linux 6.4-rc3"), and I am not able to
>>> reproduce the problems above.
>>>
>>>         $ scripts/checkpatch.pl v5/v5-0001-net-ioctl-Use-kernel-memory-on-protocol-ioctl-cal.patch
>>>         total: 0 errors, 0 warnings, 0 checks, 806 lines checked
>>>         v5/v5-0001-net-ioctl-Use-kernel-memory-on-protocol-ioctl-cal.patch has no obvious style problems and is ready for submission.
>>>
>>> Let me investigate what options I am missing when running checkpatch.
>>
>> The reference is to the checkpatch as referenced by patchwork:
>>
>> https://patchwork.kernel.org/project/netdevbpf/patch/20230602163044.1820619-1-leitao@debian.org/
>>
>> The 80 character limit is a soft limit. But also note the CHECK
>> statements on whitespace.
> 
> Right. In order to enable the "CHECK" statments, we need to pass the
> "--subjective" parameter to checpatch.pl
> 
> That said, I am able to reproduce the same output now, using the
> following command line:
> 
> 	$ scripts/checkpatch.pl --subjective --max-line-length=80

The different results visible on Patchwork are posted by a CI using
scripts hosted there:

  https://github.com/kuba-moo/nipa

If you are interested to know how checkpatch.pl is executed, you can
have a look there:


https://github.com/kuba-moo/nipa/blob/master/tests/patch/checkpatch/checkpatch.sh#L16

I guess what you need is the "--strict" argument:

>   $ ./scripts/checkpatch.pl --strict --max-line-length=80 \
>       --ignore=COMMIT_LOG_LONG_LINE,MACRO_ARG_REUSE,ALLOC_SIZEOF_STRUCT,NO_AUTHOR_SIGN_OFF,GIT_COMMIT_ID,CAMELCASE \
>       -g HEAD

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
