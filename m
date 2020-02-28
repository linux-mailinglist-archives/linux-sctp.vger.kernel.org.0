Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEEC173925
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Feb 2020 15:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1N5F (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 28 Feb 2020 08:57:05 -0500
Received: from mail-eopbgr140128.outbound.protection.outlook.com ([40.107.14.128]:42398
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgB1N5E (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 28 Feb 2020 08:57:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVBBz56snqlsb8kQM9o7TVxsCDmou5yIDDs3jzcrA0DJhar0M29gk9dMPw3L0TSl4YEo7RetkZIaDqjtBYaOcOhfMnZgDUhf0yorUiGrgE0ArT/Fvnf77r7I8EvJMRukHdFz+5ctY8x7Z85uUxQ3EfCkGQjJ9XggyAjRqm4ClIZkWNflPY0a7/de0nbAetK/YMxdfBU1bWtfHkAnWd8/ipUvvm7dgv0qQ3Pwb55z0lWZSolweR+g2eH+iJHXfoO+kQnc+t80ky2UkS0e+vTgwMR36OXdQsYLhAkcwKHQ0VVflSTs4A52jbBc9pWAZKjIo3n2oeinWc5uqCnwIQH43w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGdGgKyqIaF+TE46y8CQL7KYMvU3XFgFzkcxWxBi30w=;
 b=QphLnoaEatdNVJrzasjzjre1ANThZfqNAN3DOu88AguvAC2dzuPT6yBJCiRUu1FBHSsSe+GLsu8TZ65l41SFODH03XtrmKQYsfwAXMERCXa/hZujENZwxvLTtNgA0I4lNw8h7VvS2U9/Su5XjE0Ow0KGM0P46+FMNuGkHq+1olWyh65b/LOH5PD6YgQ2KoMFgoiqSuKfTDUPccjlDLFmTWpXpWbrGicNjzTZ/EslA7jeT2B0heqxbktdIHKP4O5WJungKlNVIKI/KvK0cNEnLxnkwJf+fXjSZZvFadcDsgg2CeyJjwm7B/iGxPXwl9qqstK9pOmnRy8aXshzqBZsBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGdGgKyqIaF+TE46y8CQL7KYMvU3XFgFzkcxWxBi30w=;
 b=qHqsK0zhvB2AQoRNlbdOGas5pW82XsdtehmmpVlJnHOE64bZ+pToevlx+UmlT5RrxL3+Wanwh2dol3g/OIX2cOzrY9XJBHOqBhCiJunUP6eUmxpCZP8lhUc64TBmo+dTl5h2DZwrBnH7KnwTgbNbg/h9F49f63f20Wfaup+674Q=
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com (10.167.124.27) by
 HE1PR0702MB3772.eurprd07.prod.outlook.com (52.133.7.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.12; Fri, 28 Feb 2020 13:57:00 +0000
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::fd31:53d3:1e20:be4a]) by HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::fd31:53d3:1e20:be4a%7]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 13:57:00 +0000
From:   "Leppanen, Jere (Nokia - FI/Espoo)" <jere.leppanen@nokia.com>
To:     Xin Long <lucien.xin@gmail.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: Problems with peeled-off sockets
Thread-Topic: Problems with peeled-off sockets
Thread-Index: AQHV5zmMyVOer6MEVEe650Mbn6KYd6gmy8gAgAO3SQyABLwNgIAAIGQc
Date:   Fri, 28 Feb 2020 13:57:00 +0000
Message-ID: <HE1PR0702MB3610F8DFB115DA9D35D71A76ECEB0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
References: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>
 <CADvbK_cmZdbVxpjxuXKaqyjTBSXsRUovxAAxC4syWnmu6Y+9yA@mail.gmail.com>
 <HE1PR0702MB361028B4B8C2E4D03AA23B4EECEC0@HE1PR0702MB3610.eurprd07.prod.outlook.com>,<CADvbK_f=COyrHh+17pdBq=acmR+cbv08quK6qbpHCg7FbwTsNw@mail.gmail.com>
In-Reply-To: <CADvbK_f=COyrHh+17pdBq=acmR+cbv08quK6qbpHCg7FbwTsNw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jere.leppanen@nokia.com; 
x-originating-ip: [91.153.156.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fa899c3-b5fa-4dce-4bdf-08d7bc561541
x-ms-traffictypediagnostic: HE1PR0702MB3772:
x-microsoft-antispam-prvs: <HE1PR0702MB377206788755E8641EDB2154ECE80@HE1PR0702MB3772.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(189003)(199004)(8936002)(9686003)(81166006)(66476007)(66556008)(76116006)(81156014)(64756008)(55016002)(66946007)(4326008)(6916009)(66446008)(8676002)(71200400001)(316002)(186003)(3480700007)(7696005)(33656002)(5660300002)(6506007)(26005)(53546011)(2906002)(86362001)(52536014)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3772;H:HE1PR0702MB3610.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SF1WBEU98Z+zGJow37Edk8aCJXdVbLagAoqZHn/6eA9at+rwJEhaoinPqBNH3zrvHmjBzGzO+DaaMZ6t34iJVF3AwgfNxDV16+PBPY0J70w955J6nVvr9igcNFTfq/Ws+Y0/fxLGCxkuaoJA0gjBToGtvXVr+2wTFCSRdLf9WRLK+U3ntO/9JsLBhL/31ERq2F+okR8lNTauHmItMnPSOWWkoPlb3OLPYikmxxyxY+Qitv+rmjy8N9Obl0DU+qN0UxRuMfpFw8z/gzWiZ47ye7A8tmu7Oh0wIVFhu0LaG/8sk+V9cAbzolS6Ry26LHeNfRvtaU3Y7y/sWUHt73d+mYl5OVGS1nKr8dtFiJLVFjUtvipqtoV9ZmHpR9HpQkq24ImyEE4qeOSOg/oMDBYK2/EtX6o3AGN+lCeY7t8mY5DvRmlsxk0xQJpdRbpn0c3IPbcN1EfpS3ykb8fc7JmkDmb/9gQixzGT8MlJXkUeT4r8Wfv+4BGD9FHOB3QisKN7ZlKv44VfRTNtf9z3wnYwlw==
x-ms-exchange-antispam-messagedata: x6wzfIlKAUI4ZMc+gGcTZcvnk1Z8aoCsOFllCCEqYsQQuHrcdmqc/ejNvIqAEaQUMHUheJWabbwMnO9fSyaakhdkKhXIb75oXXRWfEfSPly66CFjE64ntWO9qOgjOTc96zNEOZ1BTHb+6oD6GUL2bA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa899c3-b5fa-4dce-4bdf-08d7bc561541
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 13:57:00.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2GkASU+OgLi8cmhLwxhCr5GtMmr/jHdG25DYz92ow3lH18/CDfKwr2+eTLw7Y3jUN7BD0LAaWLDCOiC2yXR/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3772
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, 27 Feb 2020, Xin Long wrote:=0A=
=0A=
> On Tue, Feb 25, 2020 at 3:28 AM Leppanen, Jere (Nokia - FI/Espoo)=0A=
> <jere.leppanen@nokia.com> wrote:=0A=
>>=0A=
>> On Sat, 22 Feb 2020, Xin Long wrote:=0A=
>>=0A=
>>> On Thu, Feb 20, 2020 at 5:18 PM Leppanen, Jere (Nokia - FI/Espoo)=0A=
>>> <jere.leppanen@nokia.com> wrote: =0A=
>>>>=0A=
>>>> Hello All,=0A=
>>>>  =0A=
>>>> According to the RFC, a peeled-off socket is a one-to-one socket. But=
=0A=
>>>> in lksctp a peeled-off socket it not TCP style, it's UDP_HIGH_BANDWIDT=
H=0A=
>>>> style. Because of this, shutdown() doesn't work, linger probably=0A=
>>>> doesn't work, and so on.=0A=
>>>>                 =0A=
>>>> For example, in sctp_shutdown():=0A=
>>>> =0A=
>>>> static void sctp_shutdown(struct sock *sk, int how)=0A=
>>>> {=0A=
>>>>         struct net *net =3D sock_net(sk);=0A=
>>>>         struct sctp_endpoint *ep;=0A=
>>>>=0A=
>>>>         if (!sctp_style(sk, TCP))=0A=
>>>>                 return;=0A=
>>>>=0A=
>>>> Here we just bail out, because a peeled-off socket is not TCP style.=
=0A=
>>>>=0A=
>>>> Is this just a bug, or am I missing something? Asking mostly out of  =
=0A=
>>>> personal curiosity.=0A=
>>> I would say, it's because .shutdown is tcp_prot thing and udp_prot does=
n't=0A=
>>> have. sctp doesn't have to implement it for UDP style socket. But for T=
CP-=0A=
>>> style socket, sctp is trying to be compatible with TCP protocol user AP=
I.=0A=
>>> But even though,  sctp's .shutdown is still not fully compatible with T=
CP=0A=
>>> protocol due to sctp's 3-way shakehands for finishing a connection.=0A=
>>=0A=
>> Thanks a bunch for replying, Xin Long. I'm not quite sure what you mean.=
=0A=
>> The actual association shutdown doesn't even come into play here, since=
=0A=
>> shutdown() doesn't do anything with peeled-off sockets.=0A=
> Hi,  Leppanen,=0A=
> sorry for late.=0A=
> =0A=
> SCTP has two types of sockets: UDP and TCP styles.=0A=
> TCP style associations are not allowed to be peeled off.=0A=
> only UDP style associations can be peeled off.=0A=
> =0A=
> Then shutdown can only work for TCP style, this explains=0A=
> why peeled-off sk can use shutdown.=0A=
> =0A=
>=0A=
>> =0A=
>> If you mean that the current implementation of shutdown() might have=0A=
>> some problems with peeled-off sockets; well, that's true, but I suppose =
=0A=
>> that means that there's something to fix somewhere.=0A=
> I think it returns for peeled-off sockets (UDP style sockets) on purpose.=
=0A=
> it's like why you want to use shutdown on a UDP socket?=0A=
> =0A=
>>=0A=
>> It looks like the reason for the peculiar socket style of peeled-off=0A=
>> sockets is that they're created by copying from a one-to-many socket and=
=0A=
>> modified a little to resemble a one-to-one socket. But this leads to   =
=0A=
>> problems in several places in the code. Is this just implementation that=
=0A=
>> was never finalized?  =0A=
> Right, peeled-off will allow users to use a new sk to control that asoc.=
=0A=
> but again, it's a feature UDP style socket.=0A=
> any other problems have you seen?=0A=
=0A=
To clarify, by "peeled-off socket" I mean a socket returned by=0A=
sctp_peeloff(). sctp_peeloff() takes as an argument a=0A=
one-to-many socket, and returns a one-to-one socket.=0A=
=0A=
The RFC (https://tools.ietf.org/html/rfc6458#section-9.2)=0A=
clearly states about the socket returned by sctp_peeloff() that=0A=
"[...] the new socket is a one-to-one style socket."=0A=
