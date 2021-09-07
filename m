Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD840246F
	for <lists+linux-sctp@lfdr.de>; Tue,  7 Sep 2021 09:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhIGHef (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 7 Sep 2021 03:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhIGHef (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 7 Sep 2021 03:34:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F561C061575
        for <linux-sctp@vger.kernel.org>; Tue,  7 Sep 2021 00:33:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k4so1028812lfj.7
        for <linux-sctp@vger.kernel.org>; Tue, 07 Sep 2021 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:subject:to:organization:message-id:date:user-agent
         :mime-version;
        bh=igAb4trg1dbT8EF9SeDkx1VnDYUVnEKyoEc9JywGNl0=;
        b=fE9bgwGMPZE6aOKcacz5+oWYsi5zc8j022JsNHH4UBQ0JQEpChEoqNIA3Ea8qWSqSU
         +7qezjwFq1Qkut4hph/iMMY0tCb47D+yN1wWGcpREFKc+u8TfLJEcVR+aVRJLzJbkOr5
         H9tGYs3lDgvRd5YVYSfRKBmwqo/RY2pRz8zl5FyqEfko+cUzQBq7dgOTlUgCeOaxQi7U
         v4G0/JF3d4esG2J8vPRBqLZwCeCY09dxn+SMlzrjr4ws/1hG7nNprAcIIbXoHxnhN2sJ
         DKVNVbR6QwZHV6SYI3tEXik3nNjChsQr8YmPZ5RGeCkp0pqshhU+FUy1wa1LLgYXgrBO
         kxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:organization:message-id:date
         :user-agent:mime-version;
        bh=igAb4trg1dbT8EF9SeDkx1VnDYUVnEKyoEc9JywGNl0=;
        b=W9rvtifCE0r0NhmGFx4W+nz23u6Bj2vMf54d5iQGZot44LDUO6Uu7hV/0y+3Zzbf/2
         rEOvOXfu2DCpKHtvQA0/PmqyqOg5RPlgvIUXMzcdW7SGqKPXL6kgeBvJ+EVQCbux42Zt
         YjYywBK+mGXHO4OCR7KThF/54QmCnUPl8UAsPF9WkHE9SHdxTxxfCHBtFUd4YdZ6Ip4X
         fAltjv6BbfNSbVb90ijihS5FpnTpVceVMXb1INdPidjSoMg113n6n1bybLF1YFEVx1rF
         IpntZ81p3KiRvlGXak7xu+XLiaALVTqyyjMEMf3iDM/xmToSQnBPYx+kXVp9SPD0ZqmU
         E5Rw==
X-Gm-Message-State: AOAM532/xBeG/Bse7Av2HWOzBoiDl7ZzO3nz+ZIkC+2DwtzUlBBoS44D
        5YG57Yxy6R1bGWzRribTkeIdcI+G3X4=
X-Google-Smtp-Source: ABdhPJxW6enN16qUlSlQcphROR4yqieoW+CgS7Q5iZLVng3kUr+CrhGadKzFq1qkL0yzb+G9ZoqFXw==
X-Received: by 2002:ac2:46c4:: with SMTP id p4mr12147376lfo.668.1631000007367;
        Tue, 07 Sep 2021 00:33:27 -0700 (PDT)
Received: from [192.168.0.16] ([84.212.157.126])
        by smtp.googlemail.com with ESMTPSA id u3sm1295892lju.107.2021.09.07.00.33.26
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 00:33:26 -0700 (PDT)
From:   Thomas Dreibholz <thomas.dreibholz@googlemail.com>
X-Google-Original-From: Thomas Dreibholz <dreibh@iem.uni-due.de>
Subject: =?UTF-8?Q?Multi-Clouds_and_Mobile_Edge_Computing_=28M=c2=b2EC_2022?=
 =?UTF-8?Q?=29?=
To:     linux-sctp@vger.kernel.org
Organization: University of Duisburg-Essen
Message-ID: <c1f17a7d-d840-6ec9-68ad-14d641041618@iem.uni-due.de>
Date:   Tue, 7 Sep 2021 09:33:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4sqh8poWAaNdqEk5iqEmvPx8KukD5bGyv"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4sqh8poWAaNdqEk5iqEmvPx8KukD5bGyv
Content-Type: multipart/mixed; boundary="olKbIK7p6lQz4cGLcxg5vQD5f9eWb6Vox";
 protected-headers="v1"
From: Thomas Dreibholz <dreibh@iem.uni-due.de>
To: linux-sctp@vger.kernel.org
Message-ID: <c1f17a7d-d840-6ec9-68ad-14d641041618@iem.uni-due.de>
Subject: =?UTF-8?Q?Multi-Clouds_and_Mobile_Edge_Computing_=28M=c2=b2EC_2022?=
 =?UTF-8?Q?=29?=

--olKbIK7p6lQz4cGLcxg5vQD5f9eWb6Vox
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

We apologize if you receive multiple copies of this CFP.


CALL FOR PAPERS

The 4th International Workshop on Recent Advances for Multi-Clouds and
Mobile Edge Computing (M=C2=B2EC 2022)
In conjunction with the 36th International Conference on Advanced
Information Networking and Applications (AINA 2022)
April 13-15, 2022 in Sydney, New South Wales, Australia
https://melodic.cloud/M2EC-2022/


Today, a large number of enterprises and individuals rely on services
offered by clouds to meet their computational and storage demands.
However, in general, no single cloud provider is able to provide all the
features a user may need in a cost-efficient way, while satisfying the
user=E2=80=99s security and performance requirements. For instance, even =
the
most dominant cloud providers have limited geographical presence. Cloud
federation enables end users to integrate segregated resources from
different cloud providers. The use of Multi-Clouds offers more freedom
to the cloud users, and increases the granularity of choices in the
application deployment. Growing interest in Multi-Clouds pushes the need
to investigate a large number of under-explored research topics, ranging
from Multi-Cloud resource provisioning, application deployments,
automated configurations, federated networking, adaptations, security,
and privacy.
Moreover, with the growing need of real-time data analytics and critical
event handling by many modern applications, such as in the Internet of
Things (IoT), it is evident that the centralized compute and storage
model offered by cloud computing is not suitable for such applications,
due to high end-to-end latencies. Mobile Edge Computing (MEC), on the
other hand, enables a computing and storage infrastructure provisioned
closely to the end-users at the edge of a cellular network. Combining
MEC in Multi-Cloud infrastructures can help to combat latency challenges
imposed by the cloud-centric architectures.

The intent of our workshop is to bring together people from research and
industry, in order to provide a discussion forum for state-of-the-art
topics related to cloud, multi-cloud and mobile edge computing
technology, networks and applications. The International Workshop on
Recent Advances for Multi-Clouds and Mobile Edge Computing (M=C2=B2EC 202=
2)
will include full-paper sessions as well as a poster session (with short
presentations) to introduce preliminary ideas as well as work in progress=
=2E

Proceedings of the workshop will be published in Springer Series
=E2=80=9CAdvances in Intelligent Systems and Computing=E2=80=9D. The book=
s of this
series are submitted to ISI Proceedings, EI-Compendex, DBLP, SCOPUS,
Google Scholar and Springerlink.


The main topics to be addressed include (but are not limited to):

=C2=A0=C2=A0=C2=A0 * Design and implementation of Multi-Cloud and Cross-C=
loud systems
=C2=A0=C2=A0=C2=A0 * Networking technologies for Cloud federation
=C2=A0=C2=A0=C2=A0 * Multi-Cloud middleware
=C2=A0=C2=A0=C2=A0 * Cloud/Multi-Cloud resilience, robustness, load balan=
cing, failover
handling
=C2=A0=C2=A0=C2=A0 * Cloud/Multi-Cloud monitoring, adaptation and scalabi=
lity
=C2=A0=C2=A0=C2=A0 * Cloud/Multi-Cloud security and privacy
=C2=A0=C2=A0=C2=A0 * Cloud/Multi-Cloud use-case applications
=C2=A0=C2=A0=C2=A0 * Cloud/Multi-Cloud (application) monitoring, adaptati=
on and scalability
=C2=A0=C2=A0=C2=A0 * Adaptive Multi-Cloud application provisioning
=C2=A0=C2=A0=C2=A0 * Design and provisioning of Big Data, Multi-Cloud app=
lications
=C2=A0=C2=A0=C2=A0 * Inter-operability in Multi-Clouds
=C2=A0=C2=A0=C2=A0 * Mobile Edge Computing systems
=C2=A0=C2=A0=C2=A0 * Mobile Edge Computing for 5G network infrastructures=

=C2=A0=C2=A0=C2=A0 * Design and provisioning of Mobile Edge Computing app=
lications
=C2=A0=C2=A0=C2=A0 * Quality of Service in Multi-Cloud setups
=C2=A0=C2=A0=C2=A0 * Efficient distributed storage techniques
=C2=A0=C2=A0=C2=A0 * Low-latency transport protocols
=C2=A0=C2=A0=C2=A0 * Low-latency storage
=C2=A0=C2=A0=C2=A0 * Resilient networks and systems
=C2=A0=C2=A0=C2=A0 * Multi-homed systems and advanced transport protocols=

=C2=A0=C2=A0=C2=A0 * Applications and algorithms for Big Data and Mobile =
Edge Computing
(Multi-)Clouds
=C2=A0=C2=A0=C2=A0 * Application deployment and support for legacy applic=
ations

GENERAL CHAIRS:

=C2=A0=C2=A0=C2=A0 * Thomas Dreibholz, Simula Metropolitan Centre for Dig=
ital
Engineering (Oslo, Norway)
=C2=A0=C2=A0=C2=A0 * Feroz Zahid, Simula Research Laboratory (Fornebu, Vi=
ken, Norway)

PUBLICITY CHAIRS:

=C2=A0=C2=A0=C2=A0 * Xing Zhou, Hainan University (Haikou, Hainan, China)=

=C2=A0=C2=A0=C2=A0 * Pawe=C5=82 Skrzypek, 7bulls (Warsaw, Poland)

PROGRAM COMMITTEE

=C2=A0=C2=A0 (in alphabetical order)

=C2=A0=C2=A0 * Dimitris Apostolou, Institute of Communication and Compute=
r Systems
(Athens, Greece)
=C2=A0=C2=A0 * J=C3=B6rg Domaschka, Ulm University (Ulm, Baden-W=C3=BCrtt=
emberg, Germany)
=C2=A0=C2=A0 * Thomas Dreibholz, Simula Metropolitan Centre for Digital
Engineering (Oslo, Norway)
=C2=A0=C2=A0 * Ahmed Elmokashfi, Simula Metropolitan Centre for Digital
Engineering (Oslo, Norway)
=C2=A0=C2=A0 * Ernst Gunnar Gran, NTNU (Gj=C3=B8vik, Oppland, Norway)
=C2=A0=C2=A0 * Geir Horn, University of Oslo (Oslo, Norway)
=C2=A0=C2=A0 * Quentin Jacquemart, CRNS (Sophia Antipolis, France)
=C2=A0=C2=A0 * Kyriakos Kritikos, FORTH, Institute of Computer Science (H=
eraklion,
Greece)
=C2=A0=C2=A0 * Somnath Mazumdar, Copenhagen Business School (Copenhagen, =
Denmark)
=C2=A0=C2=A0 * Paresh Saxena, BITS Pilani University (Hyderabad, India)
=C2=A0=C2=A0 * Jawwad Shamsi, FAST NUCES (Karachi, Pakistan)
=C2=A0=C2=A0 * Tor Skeie, Fabriscale Technologies (Fornebu, Viken, Norway=
)
=C2=A0=C2=A0 * Pawe=C5=82 Skrzypek, 7bulls (Warsaw, Poland)
=C2=A0=C2=A0 * Yiannis Verginadis, Institute of Communication and Compute=
r Systems
(Athens, Greece)
=C2=A0=C2=A0 * =C3=98yvind Ytrehus, University of Bergen (Bergen, Hordala=
nd, Norway)
=C2=A0=C2=A0 * Feroz Zahid, Simula Research Laboratory (Fornebu, Viken, N=
orway)
=C2=A0=C2=A0 * Xing Zhou, Hainan University (Haikou, Hainan, China)

IMPORTANT DATES

=C2=A0=C2=A0=C2=A0 * Paper Submission Deadline:=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 November 30, 2021
=C2=A0=C2=A0=C2=A0 * Author Notification:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 January 20, 2022
=C2=A0=C2=A0=C2=A0 * Author Registration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 February 10, 2022
=C2=A0=C2=A0=C2=A0 * Camera-Ready Paper Submission:=C2=A0=C2=A0 February =
10, 2022


CONTACT

For further information, please contact:

=C2=A0=C2=A0=C2=A0 * Thomas Dreibholz, Simula Metropolitan Centre for Dig=
ital
Engineering (Oslo, Norway)
=C2=A0=C2=A0=C2=A0 * Feroz Zahid, Simula Research Laboratory (Fornebu, Vi=
ken, Norway)


WEBSITE

https://melodic.cloud/M2EC-2022/




--olKbIK7p6lQz4cGLcxg5vQD5f9eWb6Vox--

--4sqh8poWAaNdqEk5iqEmvPx8KukD5bGyv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

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
=V1xY
-----END PGP SIGNATURE-----

--4sqh8poWAaNdqEk5iqEmvPx8KukD5bGyv--
