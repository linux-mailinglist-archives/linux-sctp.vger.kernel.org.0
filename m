Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BED51659FD
	for <lists+linux-sctp@lfdr.de>; Thu, 20 Feb 2020 10:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBTJS0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 20 Feb 2020 04:18:26 -0500
Received: from mail-eopbgr10090.outbound.protection.outlook.com ([40.107.1.90]:20705
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbgBTJS0 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 20 Feb 2020 04:18:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HS/r7oGt64HI9yFWpXv75oRZCdtSqWVpWWkUlkyPgrSdswHBZn1xvg0oLNOyHsNkk+dxlK8BDlj52DpRxCuYc3pX1TaBHQov4SqIEerDIEc8/tKnhuWWWAJHe6w9NCbUqOQQx920PJhRbN/wy0n3FwjK5sQYHcCW/rKUmt7uMKXX8jSxVNMYe/eFfZBsMIVj6WEu6s8r3cyRCRTZwR6J7bTY3NHrTmw0ehHxJxNw5MsRSr8tQPYBqI/sUwRzjzMYicN8e/BDGDX+ffr6jZLqSMjNPJNIRV8IZ1hQGwVF0YCDP2RWg6osdMH72VkOKzsiVPFb98U7lRf6RApOWIExLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRniub1DbZA4dAFx+pqRE/z+r7s0edGswnS1OXUpX4Y=;
 b=EIn0a7WZA1MLN7B1h78C8+Qdp38mQO6FiNcvtYU6inzsiXt2mG1+/61nyxvsyk3/zVpUBwVsm/elovj+5Fy0+/abP52VJC5ttDx3qax51ZyayXbQzK47Nw5cyCHq4RhVHltKNwEOajVmi3J2aD2nkx919cTKSVr5TL5W+acQHET8g7WZEYxHcGryxt2hrWAuC16Bwoa0R3f7sYnXPxsmnnobZ3+8aktE/AmYBnnNFAYkcVsRsmRaiUElOciJyuUKn3+Ormw7apwwEIHqJB3c+CpJMzJPzWWtDKFUoyPFGq/OGhZ0dwW2fW8EiAZxMi4y8mNWtJUZ26kY7prc4QZNCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRniub1DbZA4dAFx+pqRE/z+r7s0edGswnS1OXUpX4Y=;
 b=D3HJ6Y8RsI8OdIYCCNUwNhSJIRisXx6Byyk6Qmyqwl9vhZ+zHyNpy+YxD27Uxi3GLvkvJ2Gg/PAD3koiZ2DXjvsv2Fg/GzsR7t6E21gBGSjn9FCXhJAZInkVkBGqeF8T1/aYTaKjgPlOH2QdJ8PenquRpfLZdeo66drsJ4D7sEo=
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com (10.167.124.27) by
 HE1PR0702MB3612.eurprd07.prod.outlook.com (10.167.124.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.8; Thu, 20 Feb 2020 09:18:20 +0000
Received: from HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::fd31:53d3:1e20:be4a]) by HE1PR0702MB3610.eurprd07.prod.outlook.com
 ([fe80::fd31:53d3:1e20:be4a%7]) with mapi id 15.20.2750.016; Thu, 20 Feb 2020
 09:18:21 +0000
From:   "Leppanen, Jere (Nokia - FI/Espoo)" <jere.leppanen@nokia.com>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Problems with peeled-off sockets
Thread-Topic: Problems with peeled-off sockets
Thread-Index: AQHV5zmMyVOer6MEVEe650Mbn6KYdw==
Date:   Thu, 20 Feb 2020 09:18:20 +0000
Message-ID: <HE1PR0702MB36104FDAA4369769A3A69704EC100@HE1PR0702MB3610.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jere.leppanen@nokia.com; 
x-originating-ip: [91.153.156.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a4a68a4-0a81-4b56-d7a9-08d7b5e5d455
x-ms-traffictypediagnostic: HE1PR0702MB3612:
x-microsoft-antispam-prvs: <HE1PR0702MB36120C8EF0EBC33E1325C699EC130@HE1PR0702MB3612.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(189003)(199004)(66476007)(7696005)(86362001)(66446008)(8936002)(64756008)(66556008)(478600001)(26005)(52536014)(66946007)(6506007)(81166006)(76116006)(81156014)(5660300002)(186003)(8676002)(4744005)(316002)(55016002)(9686003)(71200400001)(2906002)(3480700007)(6916009)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0702MB3612;H:HE1PR0702MB3610.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XI2iyJdOsiuKa/5W4u8ij+jYNLSVUW8mFJhg+7fIpZFkcDYM3mVhAZXIq/CgeqA0jDtRDVFrbr9XViWgHtM87zgUbPhU/hpnU3V9e3+ORsQ4F/Xb27ApuzUcWBbQ0iyuYhIos7QVs5zGtdqgeg4sL3NGsq5HWS54pdNZzA/D4e5zaSSTbHPOmOi86StAya1s8r0q/bCigCEduRNeBon8OsTELEPdgL4CBPMwF8gx3s/WfWwsv+X6vGSLb5A51JmfS0clIV9dxE3Fyb1wPrjWWErM5SfZ/QctAs0LoWcLuykdcWxgspQvBU7WF8+Gvk3OXxd5flVhntT87ykjPN67s2CtD6s984Tqy3U9De+NdKS873E2pcQK2sXZnhvFBcLmXfw5XC2BYBlIoULynKYM0AuCDwjAeNfQLSaK/cD0BFT9f/kA8Ajr57VDeWKum2A+
x-ms-exchange-antispam-messagedata: Nau0zPf/Fpx25gfDzjI6L8LXLWhdcv4hdAzy60c25kBxoq4nyynOvsA+qZu+OZtrEfBgBle/b+GUqhzAwV7zaakCFEma3rkgbsGO+FMOukT3fHpBSjECXUa5avTO8Xm4+jC2AG5mwMRXsn9J/EYgGQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4a68a4-0a81-4b56-d7a9-08d7b5e5d455
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 09:18:20.8659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Jw22hwwg9oZpRroyfURAnbQg8u3InN3lj0Lu9ydqcKuNtw4ea75mzGnhEigPZy9uGJUFNK+F7gZsBL8n+8TDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3612
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello All,=0A=
=0A=
According to the RFC, a peeled-off socket is a one-to-one socket. But in lk=
sctp a peeled-off socket it not TCP style, it's UDP_HIGH_BANDWIDTH style. B=
ecause of this, shutdown() doesn't work, linger probably doesn't work, and =
so on.=0A=
=0A=
For example, in sctp_shutdown():=0A=
=0A=
static void sctp_shutdown(struct sock *sk, int how)=0A=
{=0A=
        struct net *net =3D sock_net(sk);=0A=
        struct sctp_endpoint *ep;=0A=
=0A=
        if (!sctp_style(sk, TCP))=0A=
                return;=0A=
=0A=
Here we just bail out, because a peeled-off socket is not TCP style.=0A=
=0A=
Is this just a bug, or am I missing something? Asking mostly out of persona=
l curiosity.=0A=
