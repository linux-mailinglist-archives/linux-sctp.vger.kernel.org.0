Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D12374EC03
	for <lists+linux-sctp@lfdr.de>; Tue, 11 Jul 2023 12:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGKKxH (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 11 Jul 2023 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGKKw7 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 11 Jul 2023 06:52:59 -0400
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2063.outbound.protection.outlook.com [40.107.239.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09858E51
        for <linux-sctp@vger.kernel.org>; Tue, 11 Jul 2023 03:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bfc4R6W/dEwQ8l2An68PfkSlGTUbiuNEP07yR74nQFRf2OGqGCO3sjUmDkytJ1kcVg9l2yKiPiXM458HMBH//ctMsSjGirGEQvSYJW17l5Bz4YLX/lDAtYbauEPYZqAnSQPkIE/YkcntO5gU4v91yECsHsLwAbdzgEaUV53iIPXlZnqW+H6tEI0DoIc6p6+6ZYM9jsWIv4QJ8Jo6L1ctW2rbXJAreYdYqSK4QvjaPLqme52PsBwx5VTQ2/k9EKrwvFU/yRJ4e7DdG6uG4rJi5/Qk9trMNppwoYg5ewLmozV+IgZ8NmCU9U3is+oHvb3uQ4nH19OFg2wuNkLG+/SyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpYytaPLGtN8JrJRay6JnbMcGUF0KuikTbWFiB2R4Z8=;
 b=AYCwSGOtusXQwMUTROWHFgqj8ZVPTTk4NTYcmq+10foyq83gxnbJfqBhNJyjy2/gF6RrUpUg4LzYK/aue4gLi3DgTUXEyR8y1AIzqcQwkPFrs6QL/JdFMxWx2M6EDtMV/Vpon+Vy2Fi+zH3ShxuBW84Ixsc6Jrrj1sjMhmGpnbXLzdOq2XcFpZusfsav/wy6x8NhgByedCwbBNs/gm4MHytKoV0I7aJXHRbtifDgX+uiWsj5Jo72/RJsJAg2ryrTfCFhVMQR/xDqxwM527/lW+OPIzb698MCFxIkLA1g2/Xbvv3iizb50x/6NJggWfOodxvBjir8IRfxVK+ai65GKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=contactmarketinglists.onmicrosoft.com; dmarc=pass action=none
 header.from=contactmarketinglists.onmicrosoft.com; dkim=pass
 header.d=contactmarketinglists.onmicrosoft.com; arc=none
Received: from PN2P287MB0317.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:ed::14)
 by PN0P287MB0184.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Tue, 11 Jul
 2023 10:52:55 +0000
Received: from PN2P287MB0317.INDP287.PROD.OUTLOOK.COM
 ([fe80::9a77:80ad:ae15:46a2]) by PN2P287MB0317.INDP287.PROD.OUTLOOK.COM
 ([fe80::9a77:80ad:ae15:46a2%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 10:52:55 +0000
From:   Julia Anderson 
        <Julia.Anderson@ContactMarketinglists.onmicrosoft.com>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: vger IT Services
Thread-Topic: vger IT Services
Thread-Index: AQHZs+XYcv7nseK84Eq7JGWsFN/nwQ==
Date:   Tue, 11 Jul 2023 10:52:54 +0000
Message-ID: <1e3ce9ea-a595-88d3-018b-e41794d2db31@contactmarketinglists.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=ContactMarketinglists.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB0317:EE_|PN0P287MB0184:EE_
x-ms-office365-filtering-correlation-id: b2d2edd3-5dc1-4525-e1d2-08db81fcfb40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HpA52vT/25yKjjDAYd6ap5tG4kNIrYwPkj8DmYPpgu8iFFtX5WFLP3LwEMfrqy8UEfyWOrLOpLkFIaH7u8z4QBM3AZ8JNlNHxXlMpjrTb8PjhtVAOiHoA+Fmalo+Znv5n2iQWiRKAoAbrVe/h2GqrFcYZix4E+XQtOrLEcVpBeIQ43I6FOGp1VI3JD8s3buqpmf9yL+J8xM+ww7bt9mNKG5VqI9NyNS5ZRMrYCJIja3MP+9WGPueFFEtowELe9HuUjREIyiqk3TlGct/JvB8K5/WSYOb9GmoWcehu/EV5/8A2NOSrJiblZA/g3u1TLaw+8LMCGjCgjG8fqe+sas/WPZbz0kCKnQXr5S4MTiFIamhz882/PTJtTy/lFEZVWATIeQa6wjuRGAJeEDet5L0xHNehSNyaXsw0nNqIs2z1apNqIGg1Xsd1hJ4SlIpu+JTCe1E1kalavwS+XpKyYiq1Gvi9hogjI3xv02ADNYCLxhXqmDdT4SiWrZOrvRdl/erUs6JghKlDgTdnn55WW1jQjkkzEgwEv/0JjUHKixkTLJz87t3U1sM847R4HrWGtn06fhTOnXZXmT+IjVbGbfhMJFCG6Ea+yJmfrDOHj2cBZTfVf71quLE3zw3/I9fN2GVB/SzbIR1yBkUvBEwEUnUxIFlLkjO9XEU3Q7VAz2jul0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB0317.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(366004)(376002)(346002)(396003)(136003)(451199021)(71200400001)(6512007)(316002)(6486002)(76116006)(91956017)(122000001)(38100700002)(38070700005)(478600001)(2906002)(64756008)(66476007)(66446008)(66556008)(66946007)(6916009)(3480700007)(2616005)(83380400001)(186003)(5660300002)(8676002)(8936002)(31686004)(7116003)(31696002)(41300700001)(86362001)(6506007)(45980500001)(6396002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjJYcGpvT2g2ODVkcnlwOFZNdFhMK0l3MjY5d1RvUlpDakExNGJYNkcwTCtm?=
 =?utf-8?B?OWJDemwrRThqaVh1MTFzSk9WaThaZVA3ZktRdDBZVnVKUXk5ODF0dTdUUEpD?=
 =?utf-8?B?eUMxeGVWdU1odUtKV3poUlRrdmNKcHhqajhoa0JySGMvL1h3MHllWmY2VWRN?=
 =?utf-8?B?THZPRmJVbkwwZ1FFYndja3pWMXNuSzB1ZXRLQ2FDeGEyekJqekEwbXROMUIv?=
 =?utf-8?B?YW5qU1cyTU9UL1FCMW9PeGRXS2RobW1FditmQnBZdERDTDB4cmJENWY4eElZ?=
 =?utf-8?B?SkpVMnIyb2hRVkFiSk9yQkZwS3NyWnRWM3lyOTNiUUFhWlkxQTAxRko4ZU1D?=
 =?utf-8?B?ZjczTmRWcnRWUW1VSWkwbUlDL2FhQUtjKzQ0WDRCOUd4QXhHZ3EyeUZQRXlW?=
 =?utf-8?B?TzBpZ0ViOEM0NmdMTkF1TGV3MFVZRVJMUlc4bTJsWS9mR0FqemhPdU9oMnhU?=
 =?utf-8?B?VXltd1dkNVZYU21XZFliQlBtQzFJWkxLL3orRFVZTWllTjdXRHMvQTIvWTBI?=
 =?utf-8?B?MmQ2WGh1ck9CTXFyQ2tsMzVjcEVnYW01QmsrcHdPNStLMGlwd2JjU0RERWhw?=
 =?utf-8?B?UEI2ekMwYWk5a1paQUoyK1dveVc1RXF6dm9pemJHMHlNUUZXVVBaNXUwK0xv?=
 =?utf-8?B?OHd2UjRSd0lKS3kzNjZHTmhRcFpCTm9PbWE2YTRiV2c2MkpmMHI0OVdGOU9x?=
 =?utf-8?B?V3h1dHpRYnpJQ096bDkyRkVtb3FGUmFxRDcvZHVld05JYmQzNFZLb3Zqb0Ju?=
 =?utf-8?B?TU1wU05nWU5PZkdiclN4eHErVTlNeitkWWlGWVRaRVVCNkFxczFVZlVvaTg0?=
 =?utf-8?B?Ky8yVHNaaXNTR0NjY3U5K2hDdXptSVlOZGpIY1ZsVE1XemFLMEsyZCtrRnhF?=
 =?utf-8?B?bU9XTkZaVWZZS1Q0aDFiQVNNMmo2ZG9wZGp1VmpnVkV6cHE1d3VrWkhLc25y?=
 =?utf-8?B?YUxiTFA3SkNpVDFUK0FRQUpNRVRiZTN1VDV6QlZIY2V0ZWFuNzBNMXdqcExj?=
 =?utf-8?B?RGRBUlZORzRFUDVOUHBBaVo3ZkdvOURZTE12ajVWNTV1dUNKREJOSmlyaXZV?=
 =?utf-8?B?OHN0QzhXdnJFOWQ3TjBZVEhnakxVR1JIeUdtQjFBQktPN3FrdG1NM2trWHF4?=
 =?utf-8?B?dTBuSldiZ2FSaVczeHlvS0RXdXRzRzdQVVIrN2NVa1h5SHRjcEFpTnlBMU5Z?=
 =?utf-8?B?L2p4QmZNVlJ4OHNDSHJIYkpoczdhVGlSTVNnN2o0UjNpaU9LZW1qSis3V290?=
 =?utf-8?B?SVc4ejFqUDJnejhQMEdXNVdKcGJIU3U5aEs5enFKNFE0c0FqSUpBU3J5NWVZ?=
 =?utf-8?B?cWxWS0ZNZjVqN0x3QlZROUk3MUJIdnZIK0ZWYUJHOVVPYlZ0bGIyUDB6V1VR?=
 =?utf-8?B?NU9sYkJVZ3NMVmZXcUlCT1UwY0ttU0lsREVCcFVCMGtoWU5EYWc5M1lSazRp?=
 =?utf-8?B?U2F0MEkzZG15c2JSR2c5YWI3aTVpcEgrOVlUQks1ZGZqYmxPcjdQOXJLekow?=
 =?utf-8?B?WFNPczVrRDNZUEt2S0xVQ1JNSzFrR21HZTdyRWsycURtdFo1R2ZFMkxONkRy?=
 =?utf-8?B?OVZBcVZMeE12MkxuWHd2QjRueDlIZkU0UDRsdHQwWWpWd2xFRW0rSEdHTWZH?=
 =?utf-8?B?Q083aDVVa0pxa0pzSllEMnBsTzZmbC9aSkNzSjZBbFVreTJSeGtNSXhhZ3VV?=
 =?utf-8?B?eDFUVFlERU5id3dRZmp5V2JPZzRjQXlpU0tYTk5tUlZRWkplZmFvOURqQllt?=
 =?utf-8?B?MVRpd0VRVlZ1clo1ZkJVc1pXTjdPdi9xNC9HeHRXMnR3L0VOemxCQnlscVZ2?=
 =?utf-8?B?UHBLRVo3akl2RG9mc203Z1p6R3pQaEtsbENhYUdrRGxHcnFaSHQ5N0U4eTFI?=
 =?utf-8?B?UldiSloxSHpXVUVNYmM4aU5QZFF5YnpaTVREWkU5NFVOMXMwYnBCVUtpZ01a?=
 =?utf-8?B?ZDJCSDJialRWL2l6MUowNXI1Uk45VmtrZjlxdGZJU0p3RTBOemttWFk4ZlJW?=
 =?utf-8?B?dFR2SHNMd3dDSERncEFpOW0rbFhxRTgyZkQ5TlgwQmNqTm5GVmpTSmpVektK?=
 =?utf-8?B?MXNaZEZTRDRBWDBJNjZGNTV6U09MYTVmdTlVQllRV3ZzbHNrQXlPWStKTEFH?=
 =?utf-8?B?WkVzb0UwZ3NzbDFLQ3ZLS1B1V25ObnQvcDQ1czV4Q2RFU2p6RkJ3Yk5iK2hB?=
 =?utf-8?B?Z1BTKzFROWRnaW5EZ3VGRGxVaTZiSTFQdExETW44eDhiVFFjV0NkRDNIcjhh?=
 =?utf-8?B?N1VLdldhSHhSVkJLTEp0Sldrbm4zcXZ0Uk94blEra3QwaWZybDhnUXd1V1lL?=
 =?utf-8?B?L2lqR3A1TDBReVB4Wmt4UVNWWEpCQnEvMW1kSjRIYmJxamtvYk05Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <82D4C09ABDDE1F469DB18D2DEB991216@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ContactMarketinglists.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB0317.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d2edd3-5dc1-4525-e1d2-08db81fcfb40
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2023 10:52:54.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 68101ce8-c5a8-4002-874b-83088ee11957
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L0Tq7x7YKDBEnFBDnf2m1px+bxH9BlRbtzIAuNeyLzAdig4Kcb8Fr+lnZVBYu+HuAtpAqM/s7/A8TeVEpm9gCgd0XXKXNDPlaQhApw3rQ99ST1HDQsxBOinDBCsr7jd6zkZy4R4G77igLLPrunyrxlZVNj0jq2efkeOEYfWsd6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0P287MB0184
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

SGksDQoNCldlIGhhZCBzZW50IHlvdSBhbiBlbWFpbCByZWdhcmRpbmcgYSBjdXN0b21pemVkIGxp
c3Qgb2YgSVQsIElTIGFuZCANCnRlY2hub2xvZ3kgY29udGFjdHMuIFlvdSBtYXkgaGF2ZSBtaXNz
ZWQgdGhlIGVtYWlsIGFzIHdlIGRpZCBub3QgcmVjZWl2ZSANCmEgcmVzcG9uc2UgZnJvbSB5b3Vy
IGVuZC4gQmVsb3cgcGxlYXNlIGZpbmQgbXkgbGFzdCBlbWFpbC4NCg0KUGxlYXNlIGxldCBtZSBr
bm93IHlvdXIgdGFyZ2V0IGluZHVzdHJpZXMgYW5kIGpvYiB0aXRsZXMgc28gd2UgY2FuIA0KcHJv
Y2VzcyB0aGUgbnVtYmVycy4NCg0KUmVnYXJkcywNCkp1bGlhIEFuZGVyc29uDQoNCk9uIFR1ZSwg
MzAtMDUtMjAyMyAxMTo0MyBBTSwgSnVsaWEgQW5kZXJzb24gd3JvdGU6DQoNCkhpLA0KDQpXb3Vs
ZCB5b3UgYmUgaW50ZXJlc3RlZCBpbiByZWFjaGluZyBvdXQgdG8gdG9wIGxldmVsIElUIGFuZCBO
ZXR3b3JraW5nIA0KZGVjaXNpb25zIG1ha2Vyc8KgIHRvIHByb21vdGUvc2VsbCB5b3VyIHByb2R1
Y3RzIGFuZCBzZXJ2aWNlcz8NCg0KIMKgwqDCoCBDVkQgVGVjaG5vbG9neSBvZmZpY2VyDQogwqDC
oMKgIENJTywgVlAgb2YgSVQsIERpcmVjdG9yIG9mIElUDQogwqDCoMKgIERhdGEgQ2VudGVyIE1h
bmFnZXINCiDCoMKgwqAgQ09PLCBOZXR3b3JraW5nIE1hbmFnZXJzDQogwqDCoMKgIFNvZnR3YXJl
IEVuZ2luZWVyDQogwqDCoMKgIE93bmVycywgQ0VPLCBQcmVzaWRlbnRzIGV0Yw0KDQpXZSB3b3Vs
ZCBiZSBoYXBweSB0byBjdXN0b21pemUgeW91ciBsaXN0IGFjY29yZGluZ2x5IGZvciBhbnkgb3Ro
ZXIgDQpyZXF1aXJlbWVudHMgdGhhdCB5b3UgaGF2ZS4NCg0KSW5kdXN0cmllczoNCg0KSW5mb3Jt
YXRpb24gVGVjaG5vbG9neSB8RmluYW5jZSB8QWR2ZXJ0aXNpbmcgJiBNYXJrZXRpbmcgfENvbnN0
cnVjdGlvbiANCmFuZCBSZWFsIGVzdGF0ZSB8Q2hhcml0eSBhbmQgTkdP4oCZcyB8RWR1Y2F0aW9u
IHxQdWJsaXNoaW5nIHxSZXRhaWwgfCANCkNvbnN1bWVyIHwgTWFudWZhY3R1cmluZyB8R292ZXJu
bWVudCAmIHB1YmxpYyBhZ2VuY2llcyB8RWxlY3Ryb25pY3MgYW5kIA0KVGVsZWNvbW11bmljYXRp
b25zIHxJbmR1c3RyeSBhc3NvY2lhdGlvbnMgfEhlYWx0aGNhcmUgfCBIb3NwaXRhbGl0eSANCnxM
ZWdhbCBTZXJ2aWNlcyB8Rm9vZCAmIEJldmVyYWdlcyB8TWVkaWEgJiBFbnRlcnRhaW5tZW50IHxF
bmVyZ3kgYW5kIA0KY2hlbWljYWxzIHxBZXJvc3BhY2UgYW5kIERlZmVuc2UgfFRyYW5zcG9ydGF0
aW9uIGFuZCBMb2dpc3RpY3MgRVRDLg0KDQpBcHByZWNpYXRlIHlvdXIgcmVzcG9uc2UuDQoNClJl
Z2FyZHMsDQpKdWxpYSBBbmRlcnNvbiB8IE1hcmtldGluZyBDb25zdWx0YW50DQoNClJlcGx5IG9u
bHkgb3B0LW91dCBpbiB0aGUgc3ViamVjdCBsaW5lIHRvIHJlbW92ZSBmcm9tIHRoZSBtYWlsaW5n
IGxpc3QuDQoNCg==
