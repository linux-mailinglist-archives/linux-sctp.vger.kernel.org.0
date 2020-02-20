Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80379166A51
	for <lists+linux-sctp@lfdr.de>; Thu, 20 Feb 2020 23:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgBTWZM (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 20 Feb 2020 17:25:12 -0500
Received: from vic-mtaout3.csiro.au ([150.229.64.39]:47994 "EHLO
        vic-MTAout3.csiro.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgBTWZL (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 20 Feb 2020 17:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=csiro.au; i=@csiro.au; q=dns/txt; s=dkim;
  t=1582237508; x=1613773508;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x87IAZBkoAIuU6Dl1d+SzVtFzgwMsEaFAO1yyk9mlXs=;
  b=hTNBdPjh5Kk6JkLFOtrEWdrftylf4q3es9GhHEbP0qH1Ah9xLBt8+ooY
   w3vMGoZCl3pRrlG+zmfMxzVD4oU1513ow57KPIybljxV7QXjPwdmig/zp
   +lEpa9qUI2iLkOFnCLCpAZ3LKmI7mcKq/ergAl4kv4KrGvGLTNriugfbk
   k=;
IronPort-SDR: +bjv32+CXkdraiK9n/QXFN3KrDWwwW8H+u0YvHLuewoSqvuMf3L/Tm3HAwm/sZdwoiboKM0k//
 GWAuXzLITQJQ==
X-SBRS: 5.1
IronPort-PHdr: =?us-ascii?q?9a23=3AfZ/u0h1wYV2Zj4lEsmDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxKDt+51ggrPWoPWo7JfhuzavrqoeFRI4I3J8RVgOIdJSw?=
 =?us-ascii?q?dDjMwXmwI6B8vQJUT9LfPuKQcgFcVNfFR+/mu8d0FIS47z?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A+EFAACJBk9elwCwBSSYiIBxAISUgiJ?=
 =?us-ascii?q?mGwEBAQEBAQEFAQEBEQEBAwMBAQGBZwYBAQELAYFTUF4TeAQ1hBSDRgOEWoY?=
 =?us-ascii?q?YnCCBJANUCQEBAQ0BJwYCBAEBAoQ+AheBciQ0CQ4CAwEBCwEBBgEBAQEBBQQ?=
 =?us-ascii?q?CAhABAQEBAR4GhWcMg1ZxAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBBQINVCs+AgEDEhERDAEBNwEPAgEIDgwCJgICAjAVEAIEAQ0ngwQ?=
 =?us-ascii?q?BgkoDLQEBAgIKo08CgTmIYQEBdIEygn8BAQWCRIJuGIIMAwYJAYEEKgGMI4I?=
 =?us-ascii?q?agREzgjIuPoJLGQQagScBAQoWgxAugjCQZJ81BwMegh6HUI8UHIJJiBuQSY5?=
 =?us-ascii?q?wiHuSSwIEAgQFAg4BAQWBUjgsgS5sg0BQGA2OHQcTg1mFFIVBdAIBAYElizM?=
 =?us-ascii?q?QF4IbAQE?=
X-IPAS-Result: =?us-ascii?q?A+EFAACJBk9elwCwBSSYiIBxAISUgiJmGwEBAQEBAQEFA?=
 =?us-ascii?q?QEBEQEBAwMBAQGBZwYBAQELAYFTUF4TeAQ1hBSDRgOEWoYYnCCBJANUCQEBA?=
 =?us-ascii?q?Q0BJwYCBAEBAoQ+AheBciQ0CQ4CAwEBCwEBBgEBAQEBBQQCAhABAQEBAR4Gh?=
 =?us-ascii?q?WcMg1ZxAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQINV?=
 =?us-ascii?q?Cs+AgEDEhERDAEBNwEPAgEIDgwCJgICAjAVEAIEAQ0ngwQBgkoDLQEBAgIKo?=
 =?us-ascii?q?08CgTmIYQEBdIEygn8BAQWCRIJuGIIMAwYJAYEEKgGMI4IagREzgjIuPoJLG?=
 =?us-ascii?q?QQagScBAQoWgxAugjCQZJ81BwMegh6HUI8UHIJJiBuQSY5wiHuSSwIEAgQFA?=
 =?us-ascii?q?g4BAQWBUjgsgS5sg0BQGA2OHQcTg1mFFIVBdAIBAYElizMQF4IbAQE?=
Received: from exch2-mel.nexus.csiro.au ([IPv6:2405:b000:302:71::85:122])
  by vic-ironport-int.csiro.au with ESMTP/TLS/ECDHE-RSA-AES256-SHA384; 21 Feb 2020 09:25:07 +1100
Received: from exch2-mel.nexus.csiro.au (2405:b000:302:71::85:122) by
 exch2-mel.nexus.csiro.au (2405:b000:302:71::85:122) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Fri, 21 Feb 2020 09:24:55 +1100
Received: from exedge2.csiro.au (150.229.64.34) by exch2-mel.nexus.csiro.au
 (138.194.85.122) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Fri, 21 Feb 2020 09:24:55 +1100
Received: from AUS01-ME1-obe.outbound.protection.outlook.com (104.47.116.57)
 by exedge2.csiro.au (150.229.64.34) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 21 Feb 2020 09:24:49 +1100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brSb/ANKXt9V+wna0rUTQKgNSntLHXxSP/YUhF/Lb8UQRtAtTejJlbsZVSMpeOBDCur5ICScH8z8Vv2ezRl9qLvYqMnRmL/FETZQjZ8dYkUmTG2QoEHghkVefATwFGiRiUpI8KXJ97vCLLeMI0X+mKHshHMkOVxJubcjtEYqXd7dhbB64Hii50C+NzzFp6i5r1FPvVgIEvbvJFZcPWAejgkEwq7ilsDB4oA+hO3lel/43LRdPl/Vyp5mueY0rrzs4b4u2jbR1WQkQ1qBm1Yo0SaTsD1QZd57sowSjmL6ca4x8/GskQlCPlPTJa+9CgxxKKB9FyI/QuCcPLjPJrcbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x87IAZBkoAIuU6Dl1d+SzVtFzgwMsEaFAO1yyk9mlXs=;
 b=elSaamts8sKUsk6LwUNPCyWq2UYo9QWEDmEBfVo+0ugSy4gg9X2Mr43dJd54IB3ZAgOQSgqQkN/mXcIeIPq4PLYVY1/w4ZuF5DtjSOY6Vo0izUkU9eA0GLOMFz7bI8Kd8xQYKgdAfAfqZlFzZlyDB8w/ErLm+cFfAMpPKVpQlK2YzPvKqz1cvQX2yD2xx/hfm78rWJFDsqU6a/z1H0koLPJ6wi551G5qe0cf58E9VYW/m1Q8UeIFip4qzDg1lihIf8GODZWeSCllO/IPtycb6TMDfaC3WneFTeS5WbWgPbdGXVGs+220rkUsKXpwEz3xyCAA8x3PcSSAK3mEPaY2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csiro.au; dmarc=pass action=none header.from=csiro.au;
 dkim=pass header.d=csiro.au; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CSIROAU.onmicrosoft.com; s=selector1-CSIROAU-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x87IAZBkoAIuU6Dl1d+SzVtFzgwMsEaFAO1yyk9mlXs=;
 b=UQiKmcqhoXGSRCVW+ywiMjJE0yhjcchh1nTq6yuBV9mcB9vtZaX+0cxhsZ/OXmxAAp3Oepm44dDlfP2Pm9lLN2a6pSq0f7XK+XRWxAg2HtM5rkUuA62J92gIOtWHnHfdbvGusEzj8nfS73bv+WN8zx4sl65hKW/TrYbQ3DKrmVQ=
Received: from SYAPR01MB2623.ausprd01.prod.outlook.com (52.134.184.142) by
 SYAPR01MB2621.ausprd01.prod.outlook.com (52.134.182.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Thu, 20 Feb 2020 22:24:53 +0000
Received: from SYAPR01MB2623.ausprd01.prod.outlook.com
 ([fe80::c4b7:ec93:741b:a077]) by SYAPR01MB2623.ausprd01.prod.outlook.com
 ([fe80::c4b7:ec93:741b:a077%6]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 22:24:53 +0000
From:   "Craig, Daniel (CASS, Marsfield)" <Daniel.Craig@csiro.au>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
CC:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: Possible SCTP bug in kernel 4.9.199 and later
Thread-Topic: Possible SCTP bug in kernel 4.9.199 and later
Thread-Index: AQHV6Ds9a4sSF2yyFEaGxsYrR0uOhqgkqK6A
Date:   Thu, 20 Feb 2020 22:24:53 +0000
Message-ID: <etPan.5e4f0735.2451de02.6626@csiro.au>
References: <etPan.5e4f04f9.7f1d9184.6626@csiro.au>
In-Reply-To: <etPan.5e4f04f9.7f1d9184.6626@csiro.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Daniel.Craig@csiro.au; 
x-originating-ip: [2405:b000:205:3::199:238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62d0e9a1-9fa5-4a61-fb9d-08d7b653b558
x-ms-traffictypediagnostic: SYAPR01MB2621:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SYAPR01MB262113E888AC7133920F28CCFF130@SYAPR01MB2621.ausprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(346002)(136003)(39840400004)(366004)(199004)(189003)(4326008)(8936002)(81156014)(8676002)(86362001)(110136005)(5660300002)(81166006)(71200400001)(316002)(36756003)(6486002)(966005)(478600001)(2906002)(6506007)(66946007)(186003)(64756008)(66446008)(66476007)(6512007)(76116006)(66556008)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:SYAPR01MB2621;H:SYAPR01MB2623.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3pN3WY7ugoNKbHk8N6xcpAdNx0IvEDMv6fOuShzKaSm7SZchYFDMVI6k7btbrf+mJ41KtB9hVs0R/LF6IEEJuuzGfMFu7oVhvw7Dn+be0q6G3D6w5ysPoyZASzrXyTMewtyPNQ7kxY/IwSR1IjZoEHuUWeiEZ2hF1qAIPl2dgg+LP2vcYBpl5RLMLeWOtUU+85IOef/8cU/AAmX0lEOdg9EhRPZeaFb8Y9iBr5Wj47Z7CkIqZkQs6iDl647bmTdsRbq4n2nbI/e8Q17eH9LJhJ0YOWGeNlcjauaY/Uua/l576W9Ail4HhRCYhMNdbB1r0m3m+/ruR7LL9STEKpJt+Rzo/PjoHL66AcjxYs4fFigSR3s4cwFFYvmhEOK9FOLQ9Xbu1jDLWPe3U+fqfTt/eJNeLzZwzymkHsum3acCEQhg2p0ugQVYnV2PZ8n6nY26zWiSg9yMCZzpoN9bos/KPBNGPBIT03FpS9yuFS8jw2XJWCdUDW3pvLaFgw+mrKFo9R/3ow27kTOF37rNjv2cSA==
x-ms-exchange-antispam-messagedata: Kx99HSdH3xAAik/rJXlvj+03wShGDnJxrDE65lNx0r73tTQWoQ4jkMCI86EzweCCwRlSrRIPlKYvaq/24gu+aDoASx1hOW5VxlPfo3LB7b0i3OlcLo6DX2SR7KKBT+pAw737THieJWNQ98bkr5QKMYtXLe9oilIq9V6FDO9FsDOfZsGoWJuFNE8Gh9REHRxv
Content-Type: text/plain; charset="utf-8"
Content-ID: <665AF89A4E50634199DC9B3119F29FB9@ausprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d0e9a1-9fa5-4a61-fb9d-08d7b653b558
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 22:24:53.6533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0fe05593-19ac-4f98-adbf-0375fce7f160
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVx8nJCGWVrdDTcN24NfvdQRGQgVfQ6oyMPRk/oUITCeQIjZvi3YodLSml6B+ZE5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYAPR01MB2621
X-OriginatorOrg: csiro.au
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

SGksDQoNCihSZXNlbmRpbmcgaW4gcGxhaW4gSFRUUCBtYWlsKQ0KDQpXZeKAmXZlIGhpdCB3aGF0
IHNlZW1zIHRvIGJlIGEgYnVnIGluIGEgcGF0Y2ggdG8gU0NUUCBpbiB0aGUgNC45IGxvbmd0ZXJt
IGtlcm5lbC4gV2UgYXJlIHVzaW5nIGNsdm0gYXMgYSBrZXkgcGFydCBvZiBhIGR1YWwtbm9kZSBo
aWdoIGF2YWlsYWJpbGl0eSBzZXR1cC4gQ2x2bSB1c2VzIERMTSwgd2hpY2ggaW4gb3VyIGNvbmZp
ZyAodmlhIGNvcm9zeW5jKSB1c2VzIFNDVFAgYXMgaXRzIHVuZGVybHlpbmcgcHJvdG9jb2wuwqAN
Cg0KU2luY2UgZGViaWFuIGtlcm5lbCA0LjkuMC0xMi1hbWQ2NCAoYmFzZWQgb24gNC45LjIxMCkg
d2UgaGF2ZSBhIHByb2JsZW0gd2hlcmUgY2x2bSBmYWlscyB0byBzdGFydCAoaXQgdGltZXMgb3V0
KSBvbiBjbHVzdGVyIHN0YXJ0dXAgYmVjYXVzZSBETE0gYXBwZWFycyB0byBmYWlsIHRvIGNvbm5l
Y3QsIGluIHRoZSBwcm9jZXNzIHNwYW1taW5nIHRoZSBrZXJuZWwgbG9nIHdpdGggbWVzc2FnZXMg
bGlrZSB0aGlzOg0KDQpGZWIgMjAgMTM6MDU6MTggaGF0ZXN0MDAga2VybmVsOiBbIMKgMjgzLjE5
NzM5OV0gZGxtOiBjb25uZWN0aW5nIHRvIDE2ODgyMTM3NA0KRmViIDIwIDEzOjA1OjE4IGhhdGVz
dDAwIGtlcm5lbDogWyDCoDI4My4xOTc0MjJdIGRsbTogY29ubmVjdGluZyB0byAxNjg4MjEzNzQN
CkZlYiAyMCAxMzowNToxOCBoYXRlc3QwMCBrZXJuZWw6IFsgwqAyODMuMTk3NDQzXSBkbG06IGNv
bm5lY3RpbmcgdG8gMTY4ODIxMzc0DQpGZWIgMjAgMTM6MDU6MTggaGF0ZXN0MDAga2VybmVsOiBb
IMKgMjgzLjE5NzQ2NF0gZGxtOiBjb25uZWN0aW5nIHRvIDE2ODgyMTM3NA0KDQphbmQgb24gdGhl
IG90aGVyIG5vZGU6DQoNCkZlYiAyMCAxMzowNToxOCBoYXRlc3QwMSBrZXJuZWw6IFsgwqAyNzku
MTQwNTEzXSBkbG06IGNvbm5lY3RpbmcgdG8gMTY4ODIxMzczDQpGZWIgMjAgMTM6MDU6MTggaGF0
ZXN0MDEga2VybmVsOiBbIMKgMjc5LjE0MDc0MV0gZGxtOiBjb25uZWN0aW5nIHRvIDE2ODgyMTM3
Mw0KRmViIDIwIDEzOjA1OjE4IGhhdGVzdDAxIGtlcm5lbDogWyDCoDI3OS4xNDA5NzhdIGRsbTog
Y29ubmVjdGluZyB0byAxNjg4MjEzNzMNCkZlYiAyMCAxMzowNToxOCBoYXRlc3QwMSBrZXJuZWw6
IFsgwqAyNzkuMTQxMjA5XSBkbG06IGNvbm5lY3RpbmcgdG8gMTY4ODIxMzczDQoNClRoaXMgaGFz
IHRoZSB1bHRpbWF0ZSBlZmZlY3Qgb2YgY2F1c2luZyB0aGUgSEEgY2x1c3RlciB0byBiZSB1bnVz
YWJsZSwgYmVjYXVzZSB3aXRob3V0IGNsdm0gd2UgaGF2ZSBubyBhY2Nlc3MgdG8gdGhlIGNsdXN0
ZXLigJlzIHNoYXJlZCBzdG9yYWdlLg0KDQpUaGUgcHJldmlvdXNseSB3b3JraW5nIGRlYmlhbiBr
ZXJuZWwgcGFja2FnZSA0LjkuMC0xMS1hbWQ2NCBpcyBiYXNlZCBvbiBrZXJuZWwgdmVyc2lvbiA0
LjkuMTk3LiBJ4oCZdmUgdmVyaWZpZWQgdGhhdCB0aGlzIGJlaGF2aW91ciBleGlzdHMgaW4gdGhl
IHZhbmlsbGEga2VybmVsIGluIGFkZGl0aW9uIHRvIHRoZSBkZWJpYW4ga2VybmVsLiBJ4oCZdmUg
YWxzbyB2ZXJpZmllZCB0aGF0IGl0IHN0aWxsIG9jY3VycyBvbiB0aGUgbGF0ZXN0IHZhbmlsbGEg
a2VybmVsIGluIHRoZSBicmFuY2ggLSBjdXJyZW50bHkgNC45LjIxNC4NCg0KT3VyIGluaXRpYWwg
YXR0ZW1wdHMgdG8gZGVidWcgdGhlIHByb2JsZW0gaW52b2x2ZWQgcmV2ZXJ0aW5nIGFsbCBETE0g
cGF0Y2hlcyBtYWRlIGJldHdlZW4gNC45LjE5OCBhbmQgNC45LjIxMCwgdGhpcyBoYWQgbm8gaW1w
YWN0LiBXZSB0aGVuIGxvb2tlZCBhdCBTQ1RQIGFuZCB3ZXJlIGFibGUgdG8gdmVyaWZ5IHRoZSBw
cm9ibGVtIHdhcyBpbnRyb2R1Y2VkIGluIDQuOS4xOTkuIFJldmVydGluZyBib3RoIHBhdGNoZXMg
KGluZGl2aWR1YWxseSkgdG8gU0NUUCBpbiB0aGlzIHNlcmllcyBzZWVtcyB0byBwb2ludCB0byB0
aGUgZm9sbG93aW5nIGNvbW1pdCBhcyBiZWluZyB0aGUgcHJvYmxlbWF0aWMgb25lOg0KDQpodHRw
czovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdGFibGUvbGludXgu
Z2l0L2NvbW1pdC8/aD1saW51eC00LjkueSZpZD1mOGIxNDEwNzdhOWE4ZmQyYTdmNmJhZTQ0N2E3
MTBhNmQyMjRiNDRlwqANCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBtb3Jl
IGluZm9ybWF0aW9uIG9yIHlvdeKAmWQgbGlrZSBtZSB0byBydW4gYW55IHRlc3RzLg0KDQpDaGVl
cnMsDQpEYW4NCg0KRGFuaWVsIENyYWlnDQpTeXN0ZW1zIEFkbWluaXN0cmF0b3INCkFzdHJvbm9t
eSBhbmQgU3BhY2UgU2NpZW5jZSB8IENTSVJPwqA=
