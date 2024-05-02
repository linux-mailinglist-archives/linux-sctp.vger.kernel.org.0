Return-Path: <linux-sctp+bounces-149-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264518B9A1F
	for <lists+linux-sctp@lfdr.de>; Thu,  2 May 2024 13:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 471A51C20BA1
	for <lists+linux-sctp@lfdr.de>; Thu,  2 May 2024 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281695F874;
	Thu,  2 May 2024 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2x4gEOf"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718C440BF5
	for <linux-sctp@vger.kernel.org>; Thu,  2 May 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714649769; cv=none; b=SIkfAoFiWbVlIw27EuW3xGnwKbT/lymg8330manymoUtcklHTttcGia1n7OhaiJLe3JHe9R82GBHXRUUR5F7vKqZci7z7rxqXEE/qIFapHCJhcTLd3I/Sc1gRoVpRrYEHVfrBBpY7Y7Wuql7IZA00kwKwaUKjY+oEW6y7FZx0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714649769; c=relaxed/simple;
	bh=RPP9S8sv8trdLBe3Fu4hEeLpOL0T5EeSiNUv1Ru0HfM=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=bVfMVWu5NdDRO9xSj2HL89XXc7I46jWpwMkDm/UwVckqdEZcQly4EnCinS3l4h4hdRLkb4dcZfJzI+tanktS2t5e0QAf74N4FRr8CKT34RagRuO73su2ls2P/2XLnBcuzo/5H562V2HuAbMkAPrVRVxX/DkCGivxQo0uxNvZd+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2x4gEOf; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f0feae50fso804065e87.2
        for <linux-sctp@vger.kernel.org>; Thu, 02 May 2024 04:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714649765; x=1715254565; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPwLBpHyjZoZhKVQ1Qadyqxpy260gXEDUSrCz97xsxM=;
        b=P2x4gEOfWkRl39MV/CjuSlhqgB7tumExwUxMb4p/xJ8KJLT+IHgbC75A6cka3SPKV0
         psZZnBZuGOB/Mc63OCPIYgLAsfBo2lkcms2dRXRzy6GRlfD6DXyQ+xL/gmQc6bjHPzV6
         Iu4sUZt6bNM3Pd8tyEuG6H82/y2yFuNfGfn7M9z2dfHh9QPtin+R6lPZ462HmqzTkCg8
         krmcSm0v439MvKD32gGaOB2EjvEt/vueu9ju18r8L29Tg7KYF7Ue4uOhO5RTzudBaV9/
         KSZr1BZ7B6dp8bbNbwouuv2RUoXb7kVkLQ7fr+fVWTwpODfI0m+5gHjhG67y6gn5sDv+
         IWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714649765; x=1715254565;
        h=to:date:message-id:subject:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPwLBpHyjZoZhKVQ1Qadyqxpy260gXEDUSrCz97xsxM=;
        b=gj5HugAX9DAfG9a/Snhu6jOVwa8kwlTghiqEpiLsjjIlc81ToaiXLLqEPVzlEkrO9Y
         9TC1pfJ1htLL1TUMTqWgmqUzpj6JaXMMK1K5CAYhQ5mjPVslwJyDSS0LiCdsrai5YQhj
         WeR9+Nb7waDDcuvn+wedcfNUH59Z9hBvUimvM7yBbUer9mCv9mbLmP2WR2U09LUYuO5B
         TISoEXyzomuoj61EbhOjLvf2qLslVtVhO49dqV3wXdQZW4UCbr+Hzg9kfWUxuvKuJpgQ
         VVweuCsyVbDOG61DF1mG16LanFGAQpeaSBjfOgZA0NqmspTpsZm4irOK4VoXQ0LsU/l9
         bGYQ==
X-Gm-Message-State: AOJu0YzWHsdDmsSmaQvv7ts2FLywn1lCs2RwmkDOjgMHjbDWchxr4spN
	WU144wGCq+PSziAWFe02eHjdxcyJeBkXAzo/rydx/Ta1eDbq5G1cmSr4Aw==
X-Google-Smtp-Source: AGHT+IHJlOWW1CjP70qogruvGgz32rLz+2KgZ1B03rdvCopPUCKQWm9CmvIqEnz10IWH64ZQ5jupqA==
X-Received: by 2002:a05:6512:3e17:b0:51c:d05b:6b8d with SMTP id i23-20020a0565123e1700b0051cd05b6b8dmr1712684lfv.23.1714649765157;
        Thu, 02 May 2024 04:36:05 -0700 (PDT)
Received: from smtpclient.apple ([91.193.176.221])
        by smtp.gmail.com with ESMTPSA id x27-20020ac259db000000b0051ae53e9afbsm143984lfn.92.2024.05.02.04.36.04
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2024 04:36:04 -0700 (PDT)
From: Alexander Petrossian <alexander.petrossian@gmail.com>
Content-Type: multipart/mixed;
	boundary="Apple-Mail=_EA33B074-70EE-476E-BFF3-D1B2A16F145E"
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: INIT_ACK.src  := INIT.dst /*for outdated clients that ignore RFC*/
Message-Id: <1FCE9E8E-003A-4A00-B18E-52EC46D3064E@gmail.com>
Date: Thu, 2 May 2024 14:36:02 +0300
To: linux-sctp@vger.kernel.org
X-Mailer: Apple Mail (2.3774.500.171.1.1)


--Apple-Mail=_EA33B074-70EE-476E-BFF3-D1B2A16F145E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

After digging source code for more than a week I feel I need help :)

We=E2=80=99re creating SCTP server side, when client sends INIT to our =
primary IP things are fine.

But when client sends INIT to our secondary IP=E2=80=A6 Linux 4.18.0 is =
sending INIT_ACK from our primary IP, which clients MUST understand...
https://datatracker.ietf.org/doc/html/rfc4960#section-5.1.2
> D) An INIT or INIT ACK chunk MUST be treated as belonging to an
> already established association (or one in the process of being
> established) if the use of any of the valid address parameters
> contained within the chunk would identify an existing TCB.

=E2=80=A6yet our SCTP client (didn=E2=80=99t read that part of RFC) does =
not understand this INIT_ACK and fails to establish association :(

Client is some outdated soft/hardware that nobody knows how to configure =
properly, if that is at all possible.

So far I=E2=80=99ve found 20+ years old question without good answer
=
https://sourceforge.net/p/lksctp/mailman/lksctp-developers/thread/3E5A330C=
.E292CFDF%40us.ibm.com/#msg5265341

Maybe situation has changed and it became possible to influence the =
Kernel decision=E2=80=A6 so the source IP address of INIT_ACK IP packet =
be equal to destination IP address of INIT IP packet?

Attached a diagram and dump.
In this example we=E2=80=99d like frame 2 to have source address of =
10.25.94.114

Alexander Petrossian

--Apple-Mail=_EA33B074-70EE-476E-BFF3-D1B2A16F145E
Content-Disposition: inline;
	filename*=utf-8''%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202024%2D05%2D02%20%D0%B2%2014.32.12.png
Content-Type: image/png;
	x-mac-hide-extension=yes;
	x-unix-mode=0644;
	name="=?utf-8?B?0KHQvdC40LzQvtC6INGN0LrRgNCw0L3QsCAyMDI0LTA1LTAyINCyIDE0LjMy?=
 =?utf-8?B?LjEyLnBuZw==?="
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAArYAAABkCAYAAABzanPhAAAAAXNSR0IArs4c6QAAAGJlWElmTU0A
KgAAAAgAAYdpAAQAAAABAAAAGgAAAAAABJKGAAcAAAASAAAAUKABAAMAAAABAAEAAKACAAQAAAAB
AAACtqADAAQAAAABAAAAZAAAAABBU0NJSQAAAFNjcmVlbnNob3TtzeT8AAAB1mlUWHRYTUw6Y29t
LmFkb2JlLnhtcAAAAAAAPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0
az0iWE1QIENvcmUgNi4wLjAiPgogICA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMu
b3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPgogICAgICA8cmRmOkRlc2NyaXB0aW9uIHJk
ZjphYm91dD0iIgogICAgICAgICAgICB4bWxuczpleGlmPSJodHRwOi8vbnMuYWRvYmUuY29tL2V4
aWYvMS4wLyI+CiAgICAgICAgIDxleGlmOlBpeGVsWURpbWVuc2lvbj4xMDA8L2V4aWY6UGl4ZWxZ
RGltZW5zaW9uPgogICAgICAgICA8ZXhpZjpQaXhlbFhEaW1lbnNpb24+Njk0PC9leGlmOlBpeGVs
WERpbWVuc2lvbj4KICAgICAgICAgPGV4aWY6VXNlckNvbW1lbnQ+U2NyZWVuc2hvdDwvZXhpZjpV
c2VyQ29tbWVudD4KICAgICAgPC9yZGY6RGVzY3JpcHRpb24+CiAgIDwvcmRmOlJERj4KPC94Onht
cG1ldGE+CuqWPhsAACRESURBVHgB7Z0JdBVF1sdvIGEnCYSwhH1HiKzDsEhENsOqCIIgDDp+KOCC
CoKIiLIoKBJRYY6AEBEcGYGJfIgfCjqAhEVAwGGRfQlbEAKJ7CHpr/8F3fZ7pN8CL9vLv855r6ur
qmv59Tv1bt++dStA04MwkAAJkAAJkAAJkAAJkEAuJ5Avl/ef3ScBEiABEiABEiABEiABRYCCLX8I
JEACJEACJEACJEACfkGAgq1f3EYOggRIgARIgARIgARIgIItfwMkQAIkQAIkQAIkQAJ+QYCCrV/c
Rg6CBEiABEiABEiABEiAgi1/AyRAAiRAAiRAAiRAAn5BgIKtX9xGDoIESIAESIAESIAESCAwsxDc
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
gARIwKcE/h/NhRcTdF+FJwAAAABJRU5ErkJggg==
--Apple-Mail=_EA33B074-70EE-476E-BFF3-D1B2A16F145E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


P.S. Wireshark dump:

No.     Time           Source                Destination           =
Protocol Length Info                                                     =
       otid       dtid       Type       Session
      1 0.000000       10.255.106.145        10.25.94.114          SCTP  =
   156    INIT                                                           =
                                 =20

Frame 1: 156 bytes on wire (1248 bits), 156 bytes captured (1248 bits)
Linux cooked capture v1
Internet Protocol Version 4, Src: 10.255.106.145 (10.255.106.145), Dst: =
10.25.94.114 (10.25.94.114)
Stream Control Transmission Protocol, Src Port: 49139 (49139), Dst Port: =
3875 (3875)
    Source port: 49139
    Destination port: 3875
    Verification tag: 0x00000000
    [Association index: disabled (enable in preferences)]
    Checksum: 0x98d014aa [unverified]
    [Checksum Status: Unverified]
    INIT chunk (Outbound streams: 8, inbound streams: 8)
        Chunk type: INIT (1)
        Chunk flags: 0x00
        Chunk length: 108
        Initiate tag: 0x7ff58ed1
        Advertised receiver window credit (a_rwnd): 1000000
        Number of outbound streams: 8
        Number of inbound streams: 8
        Initial TSN: 457141724
        IPv4 address parameter (Address: 10.255.106.209)
        IPv4 address parameter (Address: 10.255.106.145)
        Supported address types parameter (Supported types: IPv4)
        ECN parameter
        Supported Extensions parameter (Supported types: AUTH)
        Forward TSN supported parameter
        Random parameter
        Requested HMAC Algorithm parameter (Supported HMACs: SHA-1)
        Authenticated Chunk list parameter (Chunk types to be =
authenticated: )

No.     Time           Source                Destination           =
Protocol Length Info                                                     =
       otid       dtid       Type       Session
      2 0.000059       10.25.94.122          10.255.106.145        SCTP  =
   420    INIT_ACK                                                       =
                                 =20

Frame 2: 420 bytes on wire (3360 bits), 420 bytes captured (3360 bits)
Linux cooked capture v1
Internet Protocol Version 4, Src: 10.25.94.122 (10.25.94.122), Dst: =
10.255.106.145 (10.255.106.145)
Stream Control Transmission Protocol, Src Port: 3875 (3875), Dst Port: =
49139 (49139)
    Source port: 3875
    Destination port: 49139
    Verification tag: 0x7ff58ed1
    [Association index: disabled (enable in preferences)]
    Checksum: 0x9df2bf8e [unverified]
    [Checksum Status: Unverified]
    INIT_ACK chunk (Outbound streams: 8, inbound streams: 8)
        Chunk type: INIT_ACK (2)
        Chunk flags: 0x00
        Chunk length: 372
        Initiate tag: 0xded810ed
        Advertised receiver window credit (a_rwnd): 212992
        Number of outbound streams: 8
        Number of inbound streams: 8
        Initial TSN: 676475653
        IPv4 address parameter (Address: 10.25.94.122)
        IPv4 address parameter (Address: 10.25.94.114)
        State cookie parameter (Cookie length: 324 bytes)
        ECN parameter
        Forward TSN supported parameter


--Apple-Mail=_EA33B074-70EE-476E-BFF3-D1B2A16F145E--

