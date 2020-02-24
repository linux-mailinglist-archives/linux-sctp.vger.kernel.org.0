Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D96E016B042
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2020 20:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBXT3C (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 24 Feb 2020 14:29:02 -0500
Received: from mail-vi1eur05on2122.outbound.protection.outlook.com ([40.107.21.122]:11802
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgBXT3B (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 24 Feb 2020 14:29:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0oXTh5zAt6PBKjHL1pyNydndU1CanOkzTp+LPZ2rXb3m1ezMlnLuhgjbkeBFcEWB9SyGNMJEJkLQ0TzGdOuYAZLPH6D+whEUiwYWvNZv/DuHiT2ioWJViVnUUVDSn1TSNEABxwPweyK4+zcKrr0G9pUPUAPlubS9sKtiLTt/Hji8716iOd6KNnq4Mi4Pl5N08SDBo1kDbTu0RlUH1m3m0QkawPkVSprxLaQNHtJE+JISxeVfOQWVeVFP5Eq2AfoC+lFF+810MSZSG13PJzM0sdPSs57eHeQAEIf/yl8P45SbkZBRf1ZMrXYmsHGWKnspq+Z26puMksFTw2oMDXI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiW376Wul9kkQMr2tqnjPOLfbPL+0IrlvCJNXM5USyg=;
 b=SnmJMN6NU0RAgqIIGa6EqZYoKJtpWGJuH/EMrRpwQet8ux9lxxVh8padCsJiqSooBBLQilPSJoMNSeqZfuYsY0QLE+DQMoRgBdvcEOoM7PfYSqWShSVf6SU5M4+6zyayn5EaC9ShMxeKJ2xcTl5+H0JGKSYwwEhNsUdSTkw2rgC1emV+L0yBL9mblqNUW6Ss8HcKFUXuJ2yHFfI8s7x1DfpT1+rB6mWdkxcUkpW/gWAiKgtHsnPww+CjQ5P+ZAVU2Vl/qlZsl63qlRmzgQEchsUyDQ+t2i/8rX2nqjYcHb0WTeGLpepqMP33sifYCq1UnDVC2f61y/8JGP59hks5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiW376Wul9kkQMr2tqnjPOLfbPL+0IrlvCJNXM5USyg=;
 b=m9meu+1eXRmz/Om/EzQcuEyBvPw4ppbhNsJXeFsWzh0PxhJ74fkBEcg8m6es043Zvi+8lyfIFawovuM07ExqYGLMuKlDhW4bxfjexcThBqsbFj8qSz/S06bVp7Sf6CgppFqkk5jvV67lajTgCMbgPBiQVyzPf6Nd8l5geHfzTHc=
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com (10.167.124.27) by
 HE1PR0702MB3580.eurprd07.prod.outlook.com (52.133.6.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.11; Mon, 24 Feb 2020 19:28:55 +0000
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::fd31:53d3:1e20:be4a]) by HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::fd31:53d3:1e20:be4a%7]) with mapi id 15.20.2772.010; Mon, 24 Feb 2020
 19:28:55 +0000
From:   "Leppanen, Jere (Nokia - FI/Espoo)" <jere.leppanen@nokia.com>
To:     Xin Long <lucien.xin@gmail.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: Problems with peeled-off sockets
Thread-Topic: Problems with peeled-off sockets
Thread-Index: AQHV5zmMyVOer6MEVEe650Mbn6KYd6gmy8gAgAO3SQw=
Date:   Mon, 24 Feb 2020 19:28:55 +0000
Message-ID: <HE1PR0702MB361028B4B8C2E4D03AA23B4EECEC0@HE1PR0702MB3610.eurprd07.prod.outlook.com>
References: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>,<CADvbK_cmZdbVxpjxuXKaqyjTBSXsRUovxAAxC4syWnmu6Y+9yA@mail.gmail.com>
In-Reply-To: <CADvbK_cmZdbVxpjxuXKaqyjTBSXsRUovxAAxC4syWnmu6Y+9yA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jere.leppanen@nokia.com; 
x-originating-ip: [91.153.156.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb1fb073-7c39-41f1-d3f7-08d7b95fc9a8
x-ms-traffictypediagnostic: HE1PR0702MB3580:
x-microsoft-antispam-prvs: <HE1PR0702MB3580186714012C313B49142FECEC0@HE1PR0702MB3580.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(189003)(199004)(66556008)(4326008)(478600001)(6506007)(71200400001)(6916009)(9686003)(26005)(66446008)(316002)(66476007)(53546011)(8936002)(55016002)(64756008)(2906002)(3480700007)(186003)(81156014)(33656002)(8676002)(5660300002)(7696005)(76116006)(66946007)(52536014)(81166006)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3580;H:HE1PR0702MB3610.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /3d0siOAwpzwiIqo6nSWX1BydlmKtawJrXDvfsuroum89OSgZs5RHV65GMnpUmnGjrvBQbGmxZ4nfegTI2dQ43Hh4V5K8aCbt+bSuM+BRCR//ZwOs8J0XPdk13hMqdAFavE7dbPE7lH3TFcs3s4Yg6rsSxofpTCXb2UgVg1ptm2QA0wU366aJafdru/4Tdp7iMaNtZy2kA39qRALwvPobY2AjGczVpsOsu3YIYuQp8kPcMf1yHcbh5V8j6UuXDpF8lA1jcP5ZFXmV8EMt8j8aVwdEUvWTDRiNODkiEAmFxup5eWrcFx4e60aE53ZhfgZYTreIp0ze1Drfw8qKvUwS2TJQJzAAzCo85WbPEjZzNc3TCU9jRSb9BDU/gvf3eaBCKyh0RHmm9HuRitRUSN9zGanDJT8mTXmMJPRcGgn3tbULkmEapbNnlGcTcJtijKo
x-ms-exchange-antispam-messagedata: Wml8J9jE4Z3e8DYnLrJyb15qepWGT7t4SfuIS7iZmStoywI8MrqEmksM2/30Wh2IEXUWXNrl1Y6xr104rUaZc5r6yfWf0VUg1sJqGraw+kJLeP6Sxxkpi4AorQ6f1+u7+wwFVq9J1HMdGhTCt2ezuQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1fb073-7c39-41f1-d3f7-08d7b95fc9a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 19:28:55.0931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fpLzAfzwoS23INbnzgCpYFTik8fyHblTqJQ2nQUV+X0UNGGdB9HB6oUae0gaPouFK2ST9lijm3Hng8cbuZ8Tkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3580
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, 22 Feb 2020, Xin Long wrote:=0A=
=0A=
> On Thu, Feb 20, 2020 at 5:18 PM Leppanen, Jere (Nokia - FI/Espoo)=0A=
> <jere.leppanen@nokia.com> wrote:=0A=
>>=0A=
>> Hello All,=0A=
>> =0A=
>> According to the RFC, a peeled-off socket is a one-to-one socket. But =
=0A=
>> in lksctp a peeled-off socket it not TCP style, it's UDP_HIGH_BANDWIDTH=
=0A=
>> style. Because of this, shutdown() doesn't work, linger probably=0A=
>> doesn't work, and so on.=0A=
>> =0A=
>> For example, in sctp_shutdown():=0A=
>>         =0A=
>> static void sctp_shutdown(struct sock *sk, int how)=0A=
>> {       =0A=
>>         struct net *net =3D sock_net(sk);=0A=
>>         struct sctp_endpoint *ep;=0A=
>>                 =0A=
>>         if (!sctp_style(sk, TCP))=0A=
>>                 return;=0A=
>> =0A=
>> Here we just bail out, because a peeled-off socket is not TCP style.=0A=
>>=0A=
>> Is this just a bug, or am I missing something? Asking mostly out of =0A=
>> personal curiosity.=0A=
> I would say, it's because .shutdown is tcp_prot thing and udp_prot doesn'=
t=0A=
> have. sctp doesn't have to implement it for UDP style socket. But for TCP=
-=0A=
> style socket, sctp is trying to be compatible with TCP protocol user API.=
 =0A=
> But even though,  sctp's .shutdown is still not fully compatible with TCP=
=0A=
> protocol due to sctp's 3-way shakehands for finishing a connection.=0A=
=0A=
Thanks a bunch for replying, Xin Long. I'm not quite sure what you mean. =
=0A=
The actual association shutdown doesn't even come into play here, since =0A=
shutdown() doesn't do anything with peeled-off sockets.=0A=
=0A=
If you mean that the current implementation of shutdown() might have =0A=
some problems with peeled-off sockets; well, that's true, but I suppose =0A=
that means that there's something to fix somewhere.=0A=
=0A=
It looks like the reason for the peculiar socket style of peeled-off =0A=
sockets is that they're created by copying from a one-to-many socket and =
=0A=
modified a little to resemble a one-to-one socket. But this leads to =0A=
problems in several places in the code. Is this just implementation that =
=0A=
was never finalized?=0A=
