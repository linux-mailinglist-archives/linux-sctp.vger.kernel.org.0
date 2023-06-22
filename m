Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED9573A3BF
	for <lists+linux-sctp@lfdr.de>; Thu, 22 Jun 2023 16:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjFVOyb (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 22 Jun 2023 10:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbjFVOya (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 22 Jun 2023 10:54:30 -0400
Received: from MW2PR02CU002.outbound.protection.outlook.com (mail-westus2azon11013011.outbound.protection.outlook.com [52.101.49.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E45A1BD1;
        Thu, 22 Jun 2023 07:54:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkFlL1BmcEOZBLOXgNGfCZIXC26+ZG9rWLFFkDUjvtP12KaoM58/2BtBlgEvNRlkFljKiRZuMx9wlq+5dtzXlmj+IXlBpxlSBToDdtG4VQEfmS/8GhoVllNim+0IrJSajZfmxXiu1ykak6Ccj6NVCMB5kKSUtozuIbfALCJIznMkKyFn1qQQMjZGGBgy9Tg4vy7oNmDrFX+YOYyaXt7Li4/GLzmIy8ajxnPM3w2zk1oQlgYJd2QciROZRP0seO/xjOcFNvjhaODUzmKELQNcfIX7V7xDCfVrvjHC+SBDBdxgK2lqOmzutv5JSplHKRnMbehN3l6g1Y2N0RevMWavYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rz6HTRol4AVrVwQ2NZhxzVzW0QkGJ5oDQTxETvofQc=;
 b=S472lWSv+Kq7unfIVy0KUPd5MhrdhINSTjD13jG7QXHwmDIiuLkYHxDxd6ctcM5ZFCiy10QCia3Pbs+P88Akb3kbHB5h/suCXAE7q5EQGJ0/4sLudVhtPS8dRt1wF+Dz/bLLyDEdtSAhZq5/iYyK7hiLnipmc5JYOX6xRNEAXopAbdBc+ouaHtsalXPYNJW5+CeQuFbdmBVXFqejWDdT2mM+wV1n+pEuxIsYonb2gUmWjma6z2RySmq2UitkX4GeLC3ccAKwqdh4MBjywmioDkMI2IHj9aabZiPiPzAEOp9z5l6evb+GpMGfTq/lDBoxhFwpEZF1GKIJlD/UmTvJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rz6HTRol4AVrVwQ2NZhxzVzW0QkGJ5oDQTxETvofQc=;
 b=IHzeHGAgAQgqrEX1bHPjzpSSS9iPAJBe+1YL3Rd/wTS7mFBwLYFUiAVcBy+Y/JS1/eIdhnuivSEDeFzy4+6Vjd2IRvSUGOupAikpuiNtSK75Lg/Rm1Ma299o9+OCGYvyJwGdiF0hf1mLZDXta27oFnwyObTDTGunF7DZcN43GTQ=
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by PH0PR05MB8076.namprd05.prod.outlook.com (2603:10b6:510:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 14:54:24 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::68a4:3da6:4981:4793%7]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 14:54:23 +0000
From:   Ashwin Dayanand Kamat <kashwindayan@vmware.com>
To:     Xin Long <lucien.xin@gmail.com>
CC:     Simon Horman <simon.horman@corigine.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        Tapas Kundu <tkundu@vmware.com>,
        Keerthana Kalyanasundaram <keerthanak@vmware.com>
Subject: Re: [PATCH v3] net/sctp: Make sha1 as default algorithm if fips is
 enabled
Thread-Topic: [PATCH v3] net/sctp: Make sha1 as default algorithm if fips is
 enabled
Thread-Index: AQHZlLVqGf2QnmjSNEO1bZtdH71JDa93oJ6AgACGZICAHuJwgA==
Date:   Thu, 22 Jun 2023 14:54:23 +0000
Message-ID: <7BD8EC18-86EA-411B-9155-8A7633747C7F@vmware.com>
References: <1685643474-18654-1-git-send-email-kashwindayan@vmware.com>
 <ZHoHfcMgYqO3l7Np@corigine.com>
 <CADvbK_fCPPHto4XjPeTJPJ9NTXoJGgO7jjEcy1Bq3nQSFAzR9A@mail.gmail.com>
In-Reply-To: <CADvbK_fCPPHto4XjPeTJPJ9NTXoJGgO7jjEcy1Bq3nQSFAzR9A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5409:EE_|PH0PR05MB8076:EE_
x-ms-office365-filtering-correlation-id: db9bedcc-003b-4fe1-566a-08db73309170
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZB9QAQZmJtOUEk69PsS0VcD7XQCN859aiZDJ4g8wvY+aXKjo1DbfiPLn++pPMAS0j/nS/NkBo+b6xlsmRz9EG6yy7U7fYUhgXGcNB/dlpqC9a4BETFPJVeKNFHKrHiupAkfPeHvSXFDbPn5PjGay43NWoAhICgXzilxgUnjeJuKvfLsvzw+zSuiuOP5SZ8MKQIz1GIcbhL+l894MrMAt9nUJKQPbdWJ9r6OK81PHGaD9Rue0THTFy690Lh0L6UYo8YJVDcKpfUbrADPIxCeAQE/GaieWu7CwGltFFWnYc7KV5KYUyR5aBMRNREVGbszYALZtNsB5P2zZz4Fy9PCb7Q8U85PLuqE4APpfic31gTz97ga6DK42Iy0UQd1Lftjuv9ZdjsQ/aJlR1MoMLRuLmsbn1vYnqNdprVIuY7p7Mb+HQjwZVRs0/GztMbQRrinhUqtEaHm4M/RgczshuBgZLrTsigyfpcTxnTycUCERA5ufzpM+jfqDdU6XEYe1NyUssKi2i+db7KyxStIyFn5zUWWUAmG1JYHPV3zYYqRRoi1v61/szvX1Jf9yKM35ZZShsAtuxFKbcaSUzcuJR4ZGwfppD4g4b3FLQAzX72tUDtPCKLxWeEkCry8ZWuKF0AlVHY71XhPPSqx9VvmTQk+toA3r5dYT5CTHppbGcuDXiRzeBgQ4tWINPH1DyN9ItGjSkrsXgm1badJb9DTjwVo95A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5409.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(107886003)(33656002)(122000001)(53546011)(6512007)(6506007)(71200400001)(186003)(6486002)(478600001)(54906003)(2616005)(86362001)(6916009)(64756008)(66446008)(66476007)(76116006)(66946007)(4326008)(66556008)(83380400001)(7416002)(41300700001)(316002)(5660300002)(2906002)(38100700002)(36756003)(8936002)(8676002)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3hURHppdmt1VmNaYmtnVDdCclM1VFk1eUVEOEJhQ2JSUUNyd2FpSlZiR3lT?=
 =?utf-8?B?L2t4QVh3KzR0c3FlT2NrbmJhRWZzbXJYY01BNUNPWi9VTGhoMGlWL09Zcnhi?=
 =?utf-8?B?dElMc0lINDVDRS8rYkE5cnhYT3BEOUNmNENHdXpTTXlMV1M0SEc2YTFJamRa?=
 =?utf-8?B?bGVuMUhwUzRYZU5neUdpREJ2SE8vNmRtaXl3WUE3bmlDeVdMVUsyUW9vd3A1?=
 =?utf-8?B?VXFycDVldDBwSkZoTnRScEtPRlY4aFdFOWVhdEhmd2RPRk5DcTEzYnArYkpN?=
 =?utf-8?B?aEdNZk93Qk1IcjgzUkxWNWg3bjBVKzY2R2pkbW56bGw0S3kyTFRlOUErUmV1?=
 =?utf-8?B?T3JhdEJJci9TTjhoVlFYUGJmUnFoaTNXZ2NQUTBWWkhFNEVLeGFnMnJtK2cv?=
 =?utf-8?B?Ti9pZU1EMlJBZDFwQTFiTU8rWnF1Y1Jpd1ZCdTk4eXgzd0xLd3huejZMeStS?=
 =?utf-8?B?RC9BRW9UenRSRlhJVTRob2l6OVR1cStzdFJyMERnRVpRMjdrc3ZyeHJjNXVJ?=
 =?utf-8?B?alF5K3JObVVqWU5PYzZjZGJPVDhGYU44Ui9WbHFwUUpIc0lmL2F6UUlMYXRS?=
 =?utf-8?B?QmJieUo2YWI0RlBlR0w1YVJ4dTBibjlzVTFzSS9WQkJ6S2NBWCtWUDVTekZz?=
 =?utf-8?B?TGRFOEExQ0pvUnFnWVkrdndHbnlBYUwxRDNMY0lzMzZpaG0wVzNkN2h0Qmgw?=
 =?utf-8?B?bjVrVWFUYU9jLzhFRFNXSUFRbm1BRjB3SEJHelVzVDZQSFdDTUNqaTV4S3B0?=
 =?utf-8?B?VzZ5cGRYS25jRktxc2tLdDlVbU5PbUtuUlZHUWRNQzNpM3haOXVoVWJvR2Rx?=
 =?utf-8?B?K1pOQ1F3WkZTVmttbmc2WjFSVU82eXlEM1IzTHNoYlVXSCthZFNOUmlqQU8w?=
 =?utf-8?B?c05XTWtsU3FHdTM2cERMMi9jRWFETE1tcmxtVnB5NFdvQ0Y5S1MxSitYekJF?=
 =?utf-8?B?REp1ZzVmR2RCRktaYlBPNFZXdEE5bFBySEtZTzdqWm9zVzcwWG95TFN0eitJ?=
 =?utf-8?B?QlpPa1ZmTVhyOFlKVnB1bE9zTEJiNXZ6UCtvN0pwMlFXRGw3VkdyUmlDNVkv?=
 =?utf-8?B?ZjdrUXFoV1d0eTJEdGRSSjRvdTBoeDRDYklrUXJNclFtQlNoaVBHNTRxRDY4?=
 =?utf-8?B?QWtiSjFmRVVhTHFXVFNDUE0rVzJXc3pHcXVZT0lkVk5Ma1NMS0dVSGhZZ1or?=
 =?utf-8?B?ejNBK1hkcmtZRkpFcDgzenNUaEZoVTYyL2pGNXNkMTA2QWFhVWc4QlRQeEMx?=
 =?utf-8?B?eEZpVG1VcGtocFBRWU9YUk9QekorL1RmSVZqMHJjN1hhWHkxejZPTFJ3Nnp0?=
 =?utf-8?B?cldQcG9aVmp1cjVoS1BDek45NjBQakoydTdGSmpHOWw2Q29ISnBNM2YrV2Fu?=
 =?utf-8?B?cDdDY2duSzlLSmlwYjNZeXZOY0xVVWk3czU4a3ZhSENLbkpsZGIwd0tjR0Y1?=
 =?utf-8?B?V0VNc1NzY2JEalc3QTZpeGNuekdncG5JbWhlUDNIWVAyK3Rla2MrVmNMY1FT?=
 =?utf-8?B?aVRoT2VSOGJyVU50a1VHZ0lkMGtpN0RqbVIraGQwSm1SWWhDai9jRllJaEtE?=
 =?utf-8?B?Q3ZxRUpKREQyZkdRRzFKWlBSS0ptUUVNbDJ1cmkyWm81K2pnVVRnb3Z1RWZQ?=
 =?utf-8?B?TG1oOER6T28wVGl5bWoxY3lXNnBWUTlxMG5maGlURE16VnFJTnV3WENwQTlU?=
 =?utf-8?B?cEM5NEJPeTFDOFYzWEUwUTJFUDF2OUF4WGxqWUlBWjhIei9XWk5GN09YRzcz?=
 =?utf-8?B?VTFiNkFKVGtwajNPUmFnNUN5VVVJZWpqTFpGclkvaXp1RW1MS21Sd2ZjcW1K?=
 =?utf-8?B?K0lvT1BCTHJoYkpmRnVTMEVhRXhOZnd6RjR5Z3BGRUxjdy83Yk83cENsSXNq?=
 =?utf-8?B?KzNaUzRqYllFdkVKajFoTCtZYnBDMTdjV0lWUFpxa3JreUdDVEYxYWQ1cUw3?=
 =?utf-8?B?ZnVreG5Mb0NEcThiMmpYQ1VtTGZESytwaDU3TTI5V280Mm43SlN3Uk5IaVZ3?=
 =?utf-8?B?TXAvV0J2RnZ3d2RMNFRWd2tQMkFRQ2w0VllaeGdnYzBTMTh2WDBNbHZiNnh4?=
 =?utf-8?B?dmM2NUtnZHJYeElxSnhLbGExRm5NZGt4SDk1TnB3bFAvT2t5azlyanAwVktG?=
 =?utf-8?B?OXlFZzg5Lzl1QnMyVzNrVDRuWk1vVnVNVlZ3NHBvM2huYjNmYXB3WlI3S3A2?=
 =?utf-8?B?NjZ3S1UzU256eFd4M1YvcE1FZUJDUGRKODNDRXV0NVUvQ3BOa0l0NW5WaDlI?=
 =?utf-8?B?SlVBWnhwaytlUEdLWlNJSm04Tm1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <32985418D1938E40A243D32C3EEB97B3@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9bedcc-003b-4fe1-566a-08db73309170
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 14:54:23.8648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SgsymRhGeG/j4eRIi250YnGQrikeGqHsm9O2GvLNyC0UpHGl5k/BmPZG6rkyXIt06X3406pZcIGSHazythBhsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB8076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

DQoNCj4gT24gMDMtSnVuLTIwMjMsIGF0IDQ6NDYgQU0sIFhpbiBMb25nIDxsdWNpZW4ueGluQGdt
YWlsLmNvbT4gd3JvdGU6DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gRnJpLCBK
dW4gMiwgMjAyMyBhdCAxMToxNeKAr0FNIFNpbW9uIEhvcm1hbiA8c2ltb24uaG9ybWFuQGNvcmln
aW5lLmNvbT4gd3JvdGU6DQo+PiANCj4+ICsgWGluIExvbmcNCj4+IA0KPj4gT24gVGh1LCBKdW4g
MDEsIDIwMjMgYXQgMTE6NDc6NTRQTSArMDUzMCwgQXNod2luIERheWFuYW5kIEthbWF0IHdyb3Rl
Og0KPj4+IE1ENSBpcyBub3QgRklQUyBjb21wbGlhbnQuIEJ1dCBzdGlsbCBtZDUgd2FzIHVzZWQg
YXMgdGhlDQo+Pj4gZGVmYXVsdCBhbGdvcml0aG0gZm9yIHNjdHAgaWYgZmlwcyB3YXMgZW5hYmxl
ZC4NCj4+PiBEdWUgdG8gdGhpcywgbGlzdGVuKCkgc3lzdGVtIGNhbGwgaW4gbHRwIHRlc3RzIHdh
cw0KPj4+IGZhaWxpbmcgZm9yIHNjdHAgaW4gZmlwcyBlbnZpcm9ubWVudCwgd2l0aCBiZWxvdyBl
cnJvciBtZXNzYWdlLg0KPj4+IA0KPj4+IFsgNjM5Ny44OTI2NzddIHNjdHA6IGZhaWxlZCB0byBs
b2FkIHRyYW5zZm9ybSBmb3IgbWQ1OiAtMg0KPj4+IA0KPj4+IEZpeCBpcyB0byBub3QgYXNzaWdu
IG1kNSBhcyBkZWZhdWx0IGFsZ29yaXRobSBmb3Igc2N0cA0KPj4+IGlmIGZpcHNfZW5hYmxlZCBp
cyB0cnVlLiBJbnN0ZWFkIG1ha2Ugc2hhMSBhcyBkZWZhdWx0IGFsZ29yaXRobS4NCj4+PiBUaGUg
aXNzdWUgZml4ZXMgbHRwIHRlc3RjYXNlIGZhaWx1cmUgImN2ZS0yMDE4LTU4MDMgc2N0cF9iaWdf
Y2h1bmsiDQo+IEhpLCBBc2h3aW4sDQo+IA0KPiBJIGhhdmUgdGhlIHNhbWUgcXVlc3Rpb24gYXMg
UGFvbG8gYWJvdXQgInRoaXMgcGF0Y2ggZ2V0cyBmaXBzIGNvbXBsaWFuY2UNCj4gX2Rpc2FibGlu
Z18gdGhlIGVuY3J5cHRpb24iLCBpcyBpdCBmcm9tIGFueSBzdGFuZGFyZD8NCj4gDQo+IElmIG5v
dCwgIGNhbid0IHlvdSBmaXggdGhlIGx0cCB0ZXN0Y2FzZSBmb3IgZmlwcyBlbnZpcm9ubWVudCBi
eSBzeXNjdGw/DQo+IG9yIHNldCAnQ09ORklHX1NDVFBfREVGQVVMVF9DT09LSUVfSE1BQ19TSEEx
PXknIGluc3RlYWQgaW4gY29uZmlnLg0KPiANCj4gU29ycnkgaWYgSSBkb24ndCB1bmRlcnN0YW5k
IHRoaXMgd2VsbC4gWW91J3JlIHRyeWluZyB0byBhdm9pZCBTQ1RQIGNvZGUNCj4gY2FsbGluZyBj
cnlwdG9fYWxsb2Nfc2hhc2goTUQ1KSwgcmlnaHQ/IFdoYXQgYWJvdXQgb3RoZXIgcGxhY2VzDQo+
IHdoZXJlIGl0IG1heSBhbHNvIGRvIGl0IGluIGtlcm5lbD8gKHdoZXJlIGx0cCBqdXN0IGRvZXNu
J3QgY292ZXIpDQo+IA0KPiBJIGRvbid0IHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGxldCBTQ1RQ
IGhhdmUgc29tZSBjb2RlIHJlcGx5IG9uDQo+IEZJUFMgb25seSB0byBtYWtlIGx0cCB0ZXN0Y2Fz
ZSBoYXBweSwgd2hpbGUgd2UgY2FuIGFjdHVhbGx5IGZpeCBpdA0KPiBpbiBsdHAgYnkgInN5c2N0
bCIuDQo+IA0KPiBUaGFua3MuDQo+IA0KSGkgWGksDQpUaGFua3MgZm9yIHlvdXIgaW5wdXRzLiBJ
IGhhdmUgc2VudCB0aGUgcGF0Y2hlcyB0byBsdHAgdXBzdHJlYW0gdG8gaGFuZGxlIHRoZSBmaXgg
ZnJvbSBsdHAgY29kZWJhc2UuDQoNClJlZ2FyZHMsDQpBc2h3aW4gS2FtYXQNCj4+PiANCj4+PiBT
aWduZWQtb2ZmLWJ5OiBBc2h3aW4gRGF5YW5hbmQgS2FtYXQgPGthc2h3aW5kYXlhbkB2bXdhcmUu
Y29tPg0KPj4+IC0tLQ0KPj4+IHYzOg0KPj4+ICogUmVzb2x2ZWQgaHVuayBmYWlsdXJlcy4NCj4+
PiAqIENoYW5nZWQgdGhlIHJhdGVsaW1pdGVkIG5vdGljZSB0byBiZSBtb3JlIG1lYW5pbmdmdWwu
DQo+Pj4gKiBVc2VkIHRlcm5hcnkgY29uZGl0aW9uIGZvciBpZi9lbHNlIGNvbmR0aW9uLg0KPj4+
IHYyOg0KPj4+ICogVGhlIGxpc3RlbmVyIGNhbiBzdGlsbCBmYWlsIGlmIGZpcHMgbW9kZSBpcyBl
bmFibGVkIGFmdGVyDQo+Pj4gIHRoYXQgdGhlIG5ldG5zIGlzIGluaXRpYWxpemVkLg0KPj4+ICog
Rml4ZWQgdGhpcyBpbiBzY3RwX2xpc3Rlbl9zdGFydCgpIGFzIHN1Z2dlc3RlZCBieQ0KPj4+ICBQ
YW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+PiANCj4+IEZXSUlXLCB0aGlzIHNlZW1z
IHJlYXNvbmFibGUgdG8gbWUuDQo+PiANCj4+IFJldmlld2VkLWJ5OiBTaW1vbiBIb3JtYW4gPHNp
bW9uLmhvcm1hbkBjb3JpZ2luZS5jb20+DQo+IA0KPiAhISBFeHRlcm5hbCBFbWFpbDogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUg
c2VuZGVyLg0KDQo=
