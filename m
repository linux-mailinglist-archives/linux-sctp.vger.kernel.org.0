Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57833169BB3
	for <lists+linux-sctp@lfdr.de>; Mon, 24 Feb 2020 02:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBXBRA (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 23 Feb 2020 20:17:00 -0500
Received: from act-mtaout3.csiro.au ([150.229.7.39]:46124 "EHLO
        act-MTAout3.csiro.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXBRA (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 23 Feb 2020 20:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1582507018; x=1614043018;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8ozODLngOOXUI2XYS6Jn873Uvxyk6Ns76+dOQRBeiH0=;
  b=o+2AUoLOofRsNCFHJVgFloGdn5eavsYHNVlh4gIwxBfsgtUmqsQ8o3LS
   AHGEQPPctR0yC70UBlXBvN4vMF5gp1zrB9+NV0AJOz0nNiKm7HuCQ7LNK
   XHcJoLh/yhXxjJyNbGE+OZ5Ljjd+o9Gh7zXj5IYPowrKX78M2Pg6hIQ1W
   E=;
IronPort-SDR: OYkSjjZ7LKHaIXG3QAx7NrF7JWxnOYTziAsBBDppnFHeYAZLvYS+pPG5KLju3RkrD2IQ3qeL2O
 UBG0fsf3d/UQ==
X-SBRS: 4.0
IronPort-PHdr: =?us-ascii?q?9a23=3Ai91Vix1p6r0lv6FWsmDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxKDt+51ggrPWoPWo7JfhuzavrqoeFRI4I3J8RVgOIdJSw?=
 =?us-ascii?q?dDjMwXmwI6B8vQJUT9LfPuKQcgFcVNfFR+/mu8d0FIS47z?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+EaAAAYI1NejACwBSSwhIATAJKcgDJ?=
 =?us-ascii?q?lHAEBAQEBBwEBEQEEBAEBgWcHAQELAYFTUF6BCwQ1hBSDRgOEWoYVgl+Pbol?=
 =?us-ascii?q?UgSQDVAkBAQENAS0CBAEBAoQ+AheBdiQ0CQ4CAwEBCwEBBgEBAQEBBQQCAhA?=
 =?us-ascii?q?BAQEmhWcMg1NxAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BBQKBDD4BAQECARIREQwBATcBBAsCAQgOBgYCJgICAjAVEAIEDieDBIJLAw4?=
 =?us-ascii?q?fAQECAqEwAoE5iGEBAXSBMoJ/AQEFhHsYggwJCQGBBCoBjCOCGoERgmUuPoQ?=
 =?us-ascii?q?pAQEgF4J6LoIwkGWfNQcDHoIelmUcgjkBD4gbkEqqNwIEAgQFAg4BAQWBUji?=
 =?us-ascii?q?BWmyDQFAYDY4dBxODWYpVdIEpjVUBAQ?=
X-IPAS-Result: =?us-ascii?q?A+EaAAAYI1NejACwBSSwhIATAJKcgDJlHAEBAQEBBwEBE?=
 =?us-ascii?q?QEEBAEBgWcHAQELAYFTUF6BCwQ1hBSDRgOEWoYVgl+PbolUgSQDVAkBAQENA?=
 =?us-ascii?q?S0CBAEBAoQ+AheBdiQ0CQ4CAwEBCwEBBgEBAQEBBQQCAhABAQEmhWcMg1NxA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQKBDD4BAQECA?=
 =?us-ascii?q?RIREQwBATcBBAsCAQgOBgYCJgICAjAVEAIEDieDBIJLAw4fAQECAqEwAoE5i?=
 =?us-ascii?q?GEBAXSBMoJ/AQEFhHsYggwJCQGBBCoBjCOCGoERgmUuPoQpAQEgF4J6LoIwk?=
 =?us-ascii?q?GWfNQcDHoIelmUcgjkBD4gbkEqqNwIEAgQFAg4BAQWBUjiBWmyDQFAYDY4dB?=
 =?us-ascii?q?xODWYpVdIEpjVUBAQ?=
Received: from exch2-cdc.nexus.csiro.au ([IPv6:2405:b000:601:13::247:32])
  by act-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 24 Feb 2020 12:16:56 +1100
Received: from exch4-cdc.nexus.csiro.au (2405:b000:601:13::247:34) by
 exch2-cdc.nexus.csiro.au (2405:b000:601:13::247:32) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 24 Feb 2020 12:16:56 +1100
Received: from ExEdge1.csiro.au (150.229.7.34) by exch4-cdc.nexus.csiro.au
 (152.83.247.34) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Feb 2020 12:16:56 +1100
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.58)
 by ExEdge1.csiro.au (150.229.7.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 24 Feb 2020 12:16:42 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHJRjLy2SFh81u4WmU8G5Yll8ciqNyh9RNtP1iSkHz+/ZKYhdc5SD3Yomo5Zlot+FZkCs9oVtP4ETCSCMp0sHYik6VDipm28FH5bScXBpvAGozT9oIEGaVDx87y3PtTC/XQKipyj1/zCD+EdxdyxMlatRIvZnCdAJtmagzWEwRDEitbDTmA+t94fN/Ktu4N+Yk35LRMl1NZ0emIdIRdLqz5/D2nOPRAF6LB1lOxXGdAwljoWyqQcSx5/WZGi1fx987c9zF85hOzT7qy2tiohBGkV8LUhI/A8jFGdv9r3DzVmzvKoB8tPpIiGGyet7/4Bd8I7w+kdu6pDdSdpDJFnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ozODLngOOXUI2XYS6Jn873Uvxyk6Ns76+dOQRBeiH0=;
 b=aZus/VtZuN38MC+Xx+pbYaOSB9SoLcovRz7osB4iyuQ+9KwF8aF8ELa7x8ph9Qbw30a5+cIiNhscfYsYSTTG9sGXSth606sshxE7+cP+wnccOJlbz7XfRfgQfVm/oga47RPvxSv6Ap2QdLbFjQbYusu5OfR7HQKpah/2RaaeSv12rF98tU/BkxDf7Z60gkyxi34MnoCGzcgj0kbuPxj2k15vAdSj4AJAQtPl4FeJ7MS8YlwZZYBDqqNtyE5/1a9lUe8LmCPme62JsvVTYLhD+wd1AfUp1oo4ysDhqK8DdjJcg61IBFYOmD7PB1j2RZyC8vnw/76YUtwe46f490aaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csiro.au; dmarc=pass action=none header.from=csiro.au;
 dkim=pass header.d=csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ozODLngOOXUI2XYS6Jn873Uvxyk6Ns76+dOQRBeiH0=;
 b=D8O1pQ9/e/v2ls8/BRbaQ1em1sUQU5K4Grt4Qt5GU7QLtShcjAhFKra5DljSFHuSC9gQr6r1r6/8rLtiDUQ5G4wI3EpSxPjZZuI+Yb1cc2OI9Pi4cXbClY6p/JhxauLfOX5URxnGT+ikiuAu4wKasEFFpYYlXscBZnSOEmCxabk=
Received: from SYAPR01MB2623.ausprd01.prod.outlook.com (52.134.184.142) by
 SYAPR01MB2560.ausprd01.prod.outlook.com (52.134.177.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 01:16:55 +0000
Received: from SYAPR01MB2623.ausprd01.prod.outlook.com
 ([fe80::8cd0:f034:e817:ff08]) by SYAPR01MB2623.ausprd01.prod.outlook.com
 ([fe80::8cd0:f034:e817:ff08%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 01:16:55 +0000
From:   "Craig, Daniel (CASS, Marsfield)" <Daniel.Craig@csiro.au>
To:     Xin Long <lucien.xin@gmail.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: Possible SCTP bug in kernel 4.9.199 and later
Thread-Topic: Possible SCTP bug in kernel 4.9.199 and later
Thread-Index: AQHV6Ds9a4sSF2yyFEaGxsYrR0uOhqgkqK6AgAJkDwCAAoL/AA==
Date:   Mon, 24 Feb 2020 01:16:55 +0000
Message-ID: <etPan.5e532406.7f9fee55.4a7f@csiro.au>
References: <etPan.5e4f04f9.7f1d9184.6626@csiro.au>
 <etPan.5e4f0735.2451de02.6626@csiro.au>
 <CADvbK_c85MCYmT08MxjszFHA-jxqKsFGsWjDdMkGFH9zDr+8bA@mail.gmail.com>
 <CADvbK_c85MCYmT08MxjszFHA-jxqKsFGsWjDdMkGFH9zDr+8bA@mail.gmail.com>
In-Reply-To: <CADvbK_c85MCYmT08MxjszFHA-jxqKsFGsWjDdMkGFH9zDr+8bA@mail.gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Daniel.Craig@csiro.au; 
x-originating-ip: [2405:b000:205:3::199:238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c790341c-6b19-4e2c-0d6e-08d7b8c73cd6
x-ms-traffictypediagnostic: SYAPR01MB2560:
x-microsoft-antispam-prvs: <SYAPR01MB2560B04C2C41591B9DF59253FFEC0@SYAPR01MB2560.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:595;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(5660300002)(86362001)(54906003)(2906002)(36756003)(6916009)(4326008)(8676002)(8936002)(81166006)(478600001)(81156014)(71200400001)(4744005)(66556008)(66476007)(6486002)(76116006)(2616005)(6506007)(186003)(316002)(66946007)(66446008)(64756008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:SYAPR01MB2560;H:SYAPR01MB2623.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +IKUj5npKK2WqGuTJjn2ijOBcyb0lopBNyCDNj08kLlCNs2JayXx0Vw7t5l1ufKF94a2ZEWEa0iKHIgmt8idFLVUKdDY7vrrYT39rQLlitLdjs3H8YktJGPVyc+n3dgsjv5C7A+VrcCD997islqY81jkIzaNGIYS7zOA75l4eJTQd+m4CWXcbv7PF0bjV4Ockhy6xpuKpU9WFhdTUWSND7rFP9wC1Ins3t0KnKuZe/Y9T06aolB+IrzKvEDWNUYvu5zr+I98PFtAS3mwStry8XtWZlJYMpReeHx+YE/WpD7uSpluLvVQTOYUdAGjpg7MjGGeJ8MU+Py9IrpBpKbhZLwMiatWMi+8fi/AwZw3NUoXfBci+86RMGjGcWm1BtVM/xhqGgSkdg/4l0wGocRIK24w9PW4dktaAgm+E8lEri4s5A7U8yvDOJ1KKWgcF3F7
x-ms-exchange-antispam-messagedata: WIdEOt7SP3icoAgNQsJHU2U4siowFz5V8+HiPtHkdA7+Ys7y1TmCiFnHv1jNbDMLYGTNO7InLXwGmzNsG4xZJen9T+w0ZtR9O3Khb/cFrQgCnkrm6PbpnnFyw/lm4fqUJ3VJhXfzlY+LSIAyIhX1yUllHKicVVvUXhAoPZho+9XBvfUS5x+UZbLnl3S0rLGE
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <661F685A45254F45B921A5DB1531608F@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c790341c-6b19-4e2c-0d6e-08d7b8c73cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 01:16:55.3798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OafU5bQDguR7L0SLMazVlt7ZaTSFdFYHxuZ3SSfOIwdkYGW4wkBmHeiJ5iWQ4d/C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYAPR01MB2560
X-OriginatorOrg: csiro.au
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

wqANCkhpLA0KDQooQXBvbG9naWVzIGFnYWluIGZvciBIVE1MIG1haWwpDQoNCj4gUGxlYXNlIGJh
Y2twb3J0IHRoaXMgY29tbWl0OiAgDQo+ICANCj4gY29tbWl0IGRhMzYyN2MzMGQyMjlmZWExZTA3
MGU5ODQzNjZmODBhMWM0ZDkxNjYgIA0KPiBBdXRob3I6IEdhbmcgSGUgIA0KPiBEYXRlOiBUdWUg
TWF5IDI5IDExOjA5OjIyIDIwMTggKzA4MDAgIA0KPiAgDQo+IGRsbTogcmVtb3ZlIE9fTk9OQkxP
Q0sgZmxhZyBpbiBzY3RwX2Nvbm5lY3RfdG9fc29jayAgDQoNCkRMTSBpcyBhYmxlIHRvIGNvbm5l
Y3QgYWdhaW4gaW4gNC45LjE5OSBhZnRlciBhcHBseWluZyB0aGF0IGNoYW5nZS4NCg0KQ2hlZXJz
LA0KRGFuDQoNCkRhbmllbCBDcmFpZyAgDQpTeXN0ZW1zIEFkbWluaXN0cmF0b3IgIA0KQXN0cm9u
b215IGFuZCBTcGFjZSBTY2llbmNlIHwgQ1NJUk8NCg0KDQoNCg==
