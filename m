Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A139B77C904
	for <lists+linux-sctp@lfdr.de>; Tue, 15 Aug 2023 10:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbjHOIAB (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 15 Aug 2023 04:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbjHOH71 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 15 Aug 2023 03:59:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2093.outbound.protection.outlook.com [40.107.7.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF31E198A;
        Tue, 15 Aug 2023 00:59:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUDAWIyZIAigc3nkkpM028UjLvgNn3nhPGhxS0cjEtgwB/IqTkrqwjrHUxbbD4RYUQYG3/AzTZzKWLhRgJ/a1LNC9gKAk/1zi3qYR6YU/mXbgKr19dZNWIIiHTzuybV0vFYFnLGCPJ8R2jzH8LB3ipPdWjfElFhbeex8hfkAFLuqk181kdFdna5qavHyJ6wYAVMZyh7pTkLk9MDkUnnt31nzNPuRfZ2d8KAIEGN6gHIjP027wScniOJvNT9M40M0mhBEk0ra0h4DkmodaMiXfIwOcH5tiskTot7nRBWKjGwgVyEWWMRpaM9x+qoWPuzMeSZN1dGabgDcEIt4LXrPKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jSmcz0IxaDEvTohBWa3fsirQc/G/uUW5RUqNN+seLFY=;
 b=CeLH0ku2P3hPS8s3RlqbCSvvUCuFDORCUKDN+2FSMwl8oCNsc+KscMM4JXEpL8Wh9nlHfH8Xv85CnGzK3FkuzW3kqhZc747G14sfv9kcqnHtsFRUXyo9mOGpV0ZrJn1c7GX/aYDCYEJ3XMTNqO9B+VKed+h6DP92gS/F4ZHQNDvN0isLVK0sHf2mcQdXwwkbm32jnHOulm4os980SUWMFIYjkci/FaVtiuJHT5L+LoluQpn0qqJtSd2WK1TOQCjzBZ8TOY9BxbwJp02MBlFgahpl5/ovf6hqoMp4zDfeTGKjD4QM7knhoweEKxOKXCHjVXI/UHe7BVvcdXF57XeUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com;
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jSmcz0IxaDEvTohBWa3fsirQc/G/uUW5RUqNN+seLFY=;
 b=GtoQcqAxFDKN1s9yVvef09yDapCALg4juMNJDPwAe/M5ufTIDKrvN8L4OiFPDkFTTaTbyu/Z5hZkAw/vdgtbQz4j+SSWs9pRhcaRmt5bxa3HlWfYGs2HMCceClCH5f5ucKqM249CJwhS1FfYPus6nB8p2egJ7o77Rt1yuKM/d2o=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by DU0P189MB2274.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.22; Tue, 15 Aug
 2023 07:59:22 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 07:59:22 +0000
From:   Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: RE: [PATCH nf] netfilter: set default timeout to 3 secs for sctp
 shutdown send and recv state
Thread-Topic: [PATCH nf] netfilter: set default timeout to 3 secs for sctp
 shutdown send and recv state
Thread-Index: AQHZzgb/Yr3wlI6beUyWQActMtf7qK/q+vIQ
Date:   Tue, 15 Aug 2023 07:59:21 +0000
Message-ID: <DBBP189MB1433FD875F0B6859676196489514A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>
In-Reply-To: <4e2e8aad9c4646ec3a51833cbbf95a006a98b756.1691945735.git.lucien.xin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|DU0P189MB2274:EE_
x-ms-office365-filtering-correlation-id: 23137d44-ff18-4311-2345-08db9d65891a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3oYPdKaaXbGTR+FElrZn1krowwqbqSVqx3bVnEEXhNBCn9NF1gW7PWm9LSsoTb53AkZYx2vP6u2fqPI+FdbIRsGSX54T8bCCj18inLspXFFMkbQ+pISdFT6PdgtcT573egGuccm3nR6cobTXfsI1Q4e/+/xg0prCwvi/HY1cx1GrcDCQZ+gMCmFLt4IFWQUo79hGDhzwYVPRoPWCVP2EZqMGgEFNAwJAtgkvnhhf3/b7wSlzmKilGbUBaC6m0lLpzgRE/vNqdQ9ipj2LQdY05HP0Vbh3EaqLDhtiQSU7ze7gMdIGr7odeSzNKmz1ewUETD7QV7a2oeB6gja8x/+2OhW5nHmmjS4ZC5kjFQFYXb2KRSSrIrSzzWsppWcWPTRK3j98Wlu1WQYFxHcurp7hy9iAZjU2o3CdRq7OTpwsThhudq5UBCefhbS8U+GJUsplz65inFwLqCyTn09FbP4CYnzmUszEAqhU3qV1QI+HsCk0Cu/uGxdcWoWGRNMshB5yYVlVzD6+T1t8kCg+S1/H1m0fWN+gE341+b2bvJCpthYXaYh1hBZNgj3mxvFkqtw7Ej0C/0+4YZBpNArMVotuKMz9FHrsf0ifR6atfKE0aNUGboNEDGYRZ0zPna8hXjz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(39830400003)(346002)(451199021)(1800799006)(186006)(52536014)(71200400001)(7696005)(9686003)(54906003)(53546011)(6506007)(478600001)(110136005)(26005)(2906002)(55016003)(316002)(44832011)(4326008)(76116006)(66556008)(5660300002)(66446008)(66476007)(8936002)(8676002)(66946007)(7416002)(41300700001)(38070700005)(38100700002)(33656002)(86362001)(64756008)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UytYVDNQbzNBNkhCM3VuOEJaYThlaFIwOWhVb0VvTW1QTGszNUk0R1NrN1gw?=
 =?utf-8?B?cU1aWnJkUkU4SkhxbE4yanhNbnUwYTJzRzJWbEo4QU1mMENkdWE3VS83aitT?=
 =?utf-8?B?TjJaaTNJVXU1SmhIc0Z2eXc4T1g3cVc4TFA0eDBjNUYvWHJCd2NMMnhFRm9v?=
 =?utf-8?B?Ly83OEFwYXBHVjFwLys5NHFjdTl0aDllUFliMkhPeWdJTkFqano5WmZkTldJ?=
 =?utf-8?B?ZGxyTG9CVTJ4a1VHNlB0eDExVWZxRkJLODBVbEV1TDlpWW41b25JSXY2WXhu?=
 =?utf-8?B?amU1ZzYyejNRY2Viejc4Y2FwWnVBWkN6ZFcxVmJJSU1ZZmxkcjdlNWJ2WE5h?=
 =?utf-8?B?NHplOTJ3YzhlTmp4a3g5QmErNm9vWkZTQWRHOFlqaWY4amlxbzd4VExFN2JN?=
 =?utf-8?B?SXpqak4wM1NNZjBON0NmZVowdVBGQnd0VGhJajhFSGYweE4vTko0QWgxaGRr?=
 =?utf-8?B?N1NPb1V6K0tIVWZUbjhCQmVVWXVBZFN6MTRtai9YRjFmdGdONENLblFtQnds?=
 =?utf-8?B?MW9iYUFqd3hVc0owTVo5cGUvc1pib2lmMzhhU3JQTEtQdEtObkFIeVVIRUVW?=
 =?utf-8?B?N25UQUEzTnRzUndtczh4R2FSTEFnQ2hIRy9yaWFFMW1oM04wVnN6eHNldHp3?=
 =?utf-8?B?S1p1WHBLRnVlZG8zNTNrbFcvZFNxa3J5V25OM1k4cUFpY0FVUnZVaVZUeHJ2?=
 =?utf-8?B?c0d1M0hIOGpONkVUQlowdFAxWWVZdjZnQVJOU1NjRnlNWm50dnErODMwOFZN?=
 =?utf-8?B?dW9KcU9ZTXJ4VCtEejBHTnFCNlh1UGp6RlZyVktWTEJIUEhLZjJsY0RJdjJv?=
 =?utf-8?B?OE9DZVlncTBoUnJqaGUxdVpraGlIbHpMcEZPcHEwS2thSWhZRzVyU0thNnBZ?=
 =?utf-8?B?RDJtSzdiMnMxS3pkakhOd29yRi9tSjVPTVRJSFhKWHB5dmFFcE80cHhxVExw?=
 =?utf-8?B?enBXMDJHR2loNzU5OHl5bmc2SlNNQ2NIMllQbkNaRzcrNUpjSlJWdzRiY3NY?=
 =?utf-8?B?dXVaZTdjYTJ3cG9zTHhiVFAvQkNKSzdweWNFMmYxUUl0d0FhZzJXTXN1VXpi?=
 =?utf-8?B?aitrdWtWekk1QjFUTGpYUlRzZlZhSk1zS3plNUt0dFN1R0k2OHRkcGFHS1lS?=
 =?utf-8?B?eUFmeTB6QUs2MHk0eTRLeWlhWWFrZzZILzc1OURXRlBmYlp2dXpGSWJ2Z3JH?=
 =?utf-8?B?MGlPZVo3UW4vZmo1eGF4TUxRNjFUUVk1czFTYlB6dUlLN0t0ZlBLQ3BkRGN6?=
 =?utf-8?B?ZjU1d3lXRVFOcW5TLzc1enpqWmc0OFdXNVI2cGdhaUhyVlh3eE52QU5jNVM2?=
 =?utf-8?B?ejlaVm1Dc1VFSWE5WHZMRFpiS3g5eTgwS1VrcmpmOXVPbEZ6RFJMNWU0VXFR?=
 =?utf-8?B?QVhORm9YQVFvSEFKUWowajBIY2p6RkI4RUFSLzNzSG5idWlIR1NxeFVlQmxm?=
 =?utf-8?B?QnhXUlgrb2JqaWRXUlVqd3NBbmRmbFlZdnpVbzBCMW03bFhnSHZ4RnRScFdF?=
 =?utf-8?B?Vk1sZHdRVnYwYUQ5WjNkWE9mcDZTd1hQd003cGQ5SkxUOXlQSVNZK3BNWDlJ?=
 =?utf-8?B?a2hjZXV2Z292by9XL1ZiUHFEZEx3d3RReGpldE10SCtFYVdOQXdCUnhpSHRv?=
 =?utf-8?B?QU9BeUxEUno3Uk5wMVJOK0RwZWgrcm1iOElVb2Q2eFFQdDJIS3pBdEhiaXZI?=
 =?utf-8?B?cUVTTnNSaUwxem9OTkFKclc5MmhiMElNc3JvTTFnd2NPaGtQZkFXME96bGMv?=
 =?utf-8?B?RzhNNDhLMWxncGdSSkU5SWFvT0VKT3ZLekJwYzJpZ1k4WElBRXk5a3hpc3pV?=
 =?utf-8?B?c0p1YWswbzNaeWM2am93TVJ1UzFwTG9RU1pzNDhmNjhubCtBelh0Wngvb1Q3?=
 =?utf-8?B?a0RXUjVJZ0pyTDNMTFkxcCtTdHZubGRpdGM3cFA3Z2M2bWJsb3lTT1pROXR0?=
 =?utf-8?B?anAwOGJnSy9oOGVZMFlqMEFTTkFuWVl0anZYZ1FNWDlGKzU5Lzh4NnpRTG15?=
 =?utf-8?B?aXBjN0Jud3J2SWJSdnhGc1pIRUZ6Smp6VUUzakhJdnBiTithb2FJbzJUSVZZ?=
 =?utf-8?B?WHZ1QmhONjZKK2hCSUZYQXM3N0NqbU1aamhhMEhEa2lZKzhUVHFjWkw5cm9W?=
 =?utf-8?Q?MphAs6hbGrpzw2QepmieJ9Jxd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 23137d44-ff18-4311-2345-08db9d65891a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 07:59:21.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T8soKck+P3rRP85eXAtWSR3cFdsnaRjBKRXQyXBaaOng1/O1AQgPEXRVs8ZlPFUJFYFFsyhpthv916hR4oKrxqwXw8lpF37epdo+zmQCs4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2274
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogWGluIExvbmcgPGx1Y2ll
bi54aW5AZ21haWwuY29tPg0KPiBTZW50OiBTdW5kYXksIDEzIEF1Z3VzdCAyMDIzIDE4OjU2DQo+
IFRvOiBuZXR3b3JrIGRldiA8bmV0ZGV2QHZnZXIua2VybmVsLm9yZz47IG5ldGZpbHRlci1kZXZl
bEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LXNjdHBAdmdlci5rZXJuZWwub3JnDQo+IENjOiBk
YXZlbUBkYXZlbWxvZnQubmV0OyBrdWJhQGtlcm5lbC5vcmc7IEVyaWMgRHVtYXpldA0KPiA8ZWR1
bWF6ZXRAZ29vZ2xlLmNvbT47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IFBhYmxv
IE5laXJhDQo+IEF5dXNvIDxwYWJsb0BuZXRmaWx0ZXIub3JnPjsgSm96c2VmIEthZGxlY3NpayA8
a2FkbGVjQG5ldGZpbHRlci5vcmc+OyBGbG9yaWFuDQo+IFdlc3RwaGFsIDxmd0BzdHJsZW4uZGU+
OyBNYXJjZWxvIFJpY2FyZG8gTGVpdG5lcg0KPiA8bWFyY2Vsby5sZWl0bmVyQGdtYWlsLmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIG5mXSBuZXRmaWx0ZXI6IHNldCBkZWZhdWx0IHRpbWVvdXQgdG8g
MyBzZWNzIGZvciBzY3RwIHNodXRkb3duDQo+IHNlbmQgYW5kIHJlY3Ygc3RhdGUNCj4gDQo+IElu
IFNDVFAgcHJvdG9jb2wsIGl0IGlzIHVzaW5nIHRoZSBzYW1lIHRpbWVyIChUMiB0aW1lcikgZm9y
IFNIVVRET1dOIGFuZA0KPiBTSFVURE9XTl9BQ0sgcmV0cmFuc21pc3Npb24uIEhvd2V2ZXIgaW4g
c2N0cCBjb25udHJhY2sgdGhlIGRlZmF1bHQNCj4gdGltZW91dCB2YWx1ZSBmb3IgU0NUUF9DT05O
VFJBQ0tfU0hVVERPV05fQUNLX1NFTlQgc3RhdGUgaXMgMyBzZWNzDQo+IHdoaWxlIGl0J3MgMzAw
IG1zZWNzIGZvciBTQ1RQX0NPTk5UUkFDS19TSFVURE9XTl9TRU5EL1JFQ1Ygc3RhdGUuDQo+IA0K
PiBBcyBQYW9sbyBWYWxlcmlvIG5vdGljZWQsIHRoaXMgbWlnaHQgY2F1c2UgdW53YW50ZWQgZXhw
aXJhdGlvbiBvZiB0aGUgY3QgZW50cnkuDQo+IEluIG15IHRlc3QsIHdpdGggMXMgdGMgbmV0ZW0g
ZGVsYXkgc2V0IG9uIHRoZSBOQVQgcGF0aCwgYWZ0ZXIgdGhlIFNIVVRET1dOIGlzDQo+IHNlbnQs
IHRoZSBzY3RwIGN0IGVudHJ5IGVudGVycyBTQ1RQX0NPTk5UUkFDS19TSFVURE9XTl9TRU5EIHN0
YXRlLg0KPiBIb3dldmVyLCBkdWUgdG8gMzAwbXMgKHRvbyBzaG9ydCkgZGVsYXksIHdoZW4gdGhl
IFNIVVRET1dOX0FDSyBpcyBzZW50DQo+IGJhY2sgZnJvbSB0aGUgcGVlciwgdGhlIHNjdHAgY3Qg
ZW50cnkgaGFzIGV4cGlyZWQgYW5kIGJlZW4gZGVsZXRlZCwgYW5kIHRoZW4NCj4gdGhlIFNIVVRE
T1dOX0FDSyBoYXMgdG8gYmUgZHJvcHBlZC4NCj4gDQo+IEFsc28sIGl0IGlzIGNvbmZ1c2luZyB0
aGVzZSB0d28gc3lzY3RsIG9wdGlvbnMgYWx3YXlzIHNob3cgMCBkdWUgdG8gYWxsIHRpbWVvdXQN
Cj4gdmFsdWVzIHVzaW5nIHNlYyBhcyB1bml0Og0KPiANCj4gICBuZXQubmV0ZmlsdGVyLm5mX2Nv
bm50cmFja19zY3RwX3RpbWVvdXRfc2h1dGRvd25fcmVjZCA9IDANCj4gICBuZXQubmV0ZmlsdGVy
Lm5mX2Nvbm50cmFja19zY3RwX3RpbWVvdXRfc2h1dGRvd25fc2VudCA9IDANCj4gDQo+IFRoaXMg
cGF0Y2ggZml4ZXMgaXQgYnkgYWxzbyB1c2luZyAzIHNlY3MgZm9yIHNjdHAgc2h1dGRvd24gc2Vu
ZCBhbmQgcmVjdiBzdGF0ZSBpbg0KPiBzY3RwIGNvbm50cmFjaywgd2hpY2ggaXMgYWxzbyBSVE8u
aW5pdGlhbCB2YWx1ZSBpbiBTQ1RQIHByb3RvY29sLg0KPiANCj4gTm90ZSB0aGF0IHRoZSB2ZXJ5
IHNob3J0IHRpbWUgdmFsdWUgZm9yDQo+IFNDVFBfQ09OTlRSQUNLX1NIVVRET1dOX1NFTkQvUkVD
ViB3YXMgcHJvYmFibHkgdXNlZCBmb3IgYSByYXJlDQo+IHNjZW5hcmlvIHdoZXJlIFNIVVRET1dO
IGlzIHNlbnQgb24gMXN0IHBhdGggYnV0IFNIVVRET1dOX0FDSyBpcyByZXBsaWVkDQo+IG9uIDJu
ZCBwYXRoLCB0aGVuIGEgbmV3IGNvbm5lY3Rpb24gc3RhcnRlZCBpbW1lZGlhdGVseSBvbiAxc3Qg
cGF0aC4gU28gdGhpcw0KPiBwYXRjaCBhbHNvIG1vdmVzIGZyb20gU0hVVERPV05fU0VORC9SRUNW
IHRvIENMT1NFIHdoZW4gcmVjZWl2aW5nIElOSVQNCj4gaW4gdGhlIE9SSUdJTkFMIGRpcmVjdGlv
bi4NCj4gDQo+IEZpeGVzOiA5ZmI5Y2JiMTA4MmQgKCJbTkVURklMVEVSXTogQWRkIG5mX2Nvbm50
cmFjayBzdWJzeXN0ZW0uIikNCj4gUmVwb3J0ZWQtYnk6IFBhb2xvIFZhbGVyaW8gPHB2YWxlcmlv
QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFhpbiBMb25nIDxsdWNpZW4ueGluQGdtYWls
LmNvbT4NCj4gLS0tDQo+ICBuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90b19zY3RwLmMg
fCA2ICsrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90
b19zY3RwLmMNCj4gYi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19wcm90b19zY3RwLmMNCj4g
aW5kZXggOTFlYWNjOWIwYjk4Li5iNmJjYzhmMmY0NmIgMTAwNjQ0DQo+IC0tLSBhL25ldC9uZXRm
aWx0ZXIvbmZfY29ubnRyYWNrX3Byb3RvX3NjdHAuYw0KPiArKysgYi9uZXQvbmV0ZmlsdGVyL25m
X2Nvbm50cmFja19wcm90b19zY3RwLmMNCj4gQEAgLTQ5LDggKzQ5LDggQEAgc3RhdGljIGNvbnN0
IHVuc2lnbmVkIGludA0KPiBzY3RwX3RpbWVvdXRzW1NDVFBfQ09OTlRSQUNLX01BWF0gPSB7DQo+
ICAJW1NDVFBfQ09OTlRSQUNLX0NPT0tJRV9XQUlUXQkJPSAzIFNFQ1MsDQo+ICAJW1NDVFBfQ09O
TlRSQUNLX0NPT0tJRV9FQ0hPRURdCQk9IDMgU0VDUywNCj4gIAlbU0NUUF9DT05OVFJBQ0tfRVNU
QUJMSVNIRURdCQk9IDIxMCBTRUNTLA0KPiAtCVtTQ1RQX0NPTk5UUkFDS19TSFVURE9XTl9TRU5U
XQkJPSAzMDAgU0VDUyAvDQo+IDEwMDAsDQo+IC0JW1NDVFBfQ09OTlRSQUNLX1NIVVRET1dOX1JF
Q0RdCQk9IDMwMCBTRUNTIC8NCj4gMTAwMCwNCj4gKwlbU0NUUF9DT05OVFJBQ0tfU0hVVERPV05f
U0VOVF0JCT0gMyBTRUNTLA0KPiArCVtTQ1RQX0NPTk5UUkFDS19TSFVURE9XTl9SRUNEXQkJPSAz
IFNFQ1MsDQo+ICAJW1NDVFBfQ09OTlRSQUNLX1NIVVRET1dOX0FDS19TRU5UXQk9IDMgU0VDUywN
Cj4gIAlbU0NUUF9DT05OVFJBQ0tfSEVBUlRCRUFUX1NFTlRdCQk9IDMwIFNFQ1MsDQo+ICB9Ow0K
PiBAQCAtMTA1LDcgKzEwNSw3IEBAIHN0YXRpYyBjb25zdCB1OA0KPiBzY3RwX2Nvbm50cmFja3Nb
Ml1bMTFdW1NDVFBfQ09OTlRSQUNLX01BWF0gPSB7DQo+ICAJew0KPiAgLyoJT1JJR0lOQUwJKi8N
Cj4gIC8qICAgICAgICAgICAgICAgICAgc05PLCBzQ0wsIHNDVywgc0NFLCBzRVMsIHNTUywgc1NS
LCBzU0EsIHNIUyAqLw0KPiAtLyogaW5pdCAgICAgICAgICovIHtzQ0wsIHNDTCwgc0NXLCBzQ0Us
IHNFUywgc1NTLCBzU1IsIHNTQSwgc0NXfSwNCj4gKy8qIGluaXQgICAgICAgICAqLyB7c0NMLCBz
Q0wsIHNDVywgc0NFLCBzRVMsIHNDTCwgc0NMLCBzU0EsIHNDV30sDQo+ICAvKiBpbml0X2FjayAg
ICAgKi8ge3NDTCwgc0NMLCBzQ1csIHNDRSwgc0VTLCBzU1MsIHNTUiwgc1NBLCBzQ0x9LA0KPiAg
LyogYWJvcnQgICAgICAgICovIHtzQ0wsIHNDTCwgc0NMLCBzQ0wsIHNDTCwgc0NMLCBzQ0wsIHND
TCwgc0NMfSwNCj4gIC8qIHNodXRkb3duICAgICAqLyB7c0NMLCBzQ0wsIHNDVywgc0NFLCBzU1Ms
IHNTUywgc1NSLCBzU0EsIHNDTH0sDQo+IC0tDQo+IDIuMzkuMQ0KDQpGV0lXLCBJIGxpa2UgdGhp
cyBwYXRjaC4gU2hvdWxkIERvY3VtZW50YXRpb24vbmV0d29ya2luZy9uZl9jb25udHJhY2stc3lz
Y3RsLnJzdCBiZSB1cGRhdGVkIHRvIHJlZmxlY3QgdGhlIG5ldyB0aW1lb3V0IHZhbHVlcz8NCg==
