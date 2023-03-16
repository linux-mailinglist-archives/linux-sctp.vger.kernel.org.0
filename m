Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B399D6BCE8C
	for <lists+linux-sctp@lfdr.de>; Thu, 16 Mar 2023 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjCPLke (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 16 Mar 2023 07:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCPLk2 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 16 Mar 2023 07:40:28 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2106.outbound.protection.outlook.com [40.107.215.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ABF570AC;
        Thu, 16 Mar 2023 04:40:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/yR1JB3UxQB/AaPRGf7wgAex4LsRiZrXfAoMXdbnU7kOCZezabHRSU54cLwq10QYo8fz3R/TUC46Hw7cy3gD2E+JM1kM7DgBbQsTX5gZOBGFSwZEdXY+CkD5fbmMddaxJwQN9/zeLMqwCDQbVqq9o8rBbd5rRQJAxeFgWrn9vNQ0dyIaT6k0ljW6bBhwkG78U1/fBLT3mGKUZE/CuCp4ajnFESqeAXuLwWOIr5b7dzsqxYk+OIB65aQjcfFKsCEdR1u6E/uVJyaTJzQ/WZ1bp+7y91Qzcd/hESRjCLdglIwhLmaYjhdtK7mGRktcDxZgJhGiDYFTrX5LMMNDVAxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNjHdA8ArI7Cuj1psguUjBTy7LIFvtfRFFVg9mWk3ZU=;
 b=aoSGtznzDAI1Cxwh3iW32z3AN66hwSd2ceBh5coooJo1u8MY/TAcNtbT95VoejncV9nX+ELcjstEpiRx+t0kUKZpJfAOXFuvxYcF21MPJff8T4KJIoFV+GXuMw6DYQQM2u1akjGMHCV6ZLvp9Zgj/MZPyVTcCKxgaDuLWT5BlwfxptCSd8vpPGCBJEU53hU4WFfjjkJ2R/IpqMV079mmrpq1HOWblj4av+4OdA4xy76lkB4iqSWDwGRv0FRAuXDk72Ro2VxW8sv5FKRSYSgxL3tLsb6Pd0KfcI0BMqdcz1mxMKaAkXrKRoA3BRcQBewRL59FAGwyaBG+QeMFryHLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=coep.ac.in; dmarc=pass action=none header.from=coep.ac.in;
 dkim=pass header.d=coep.ac.in; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=coepac.onmicrosoft.com; s=selector2-coepac-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNjHdA8ArI7Cuj1psguUjBTy7LIFvtfRFFVg9mWk3ZU=;
 b=ESmFWxpCUcUKrJIozWDr3VVq8qYHs2uufBo8tmKvdPLdLBztTDFVLFSaW2HI9XVXFgf1DtRL4QH+cl98b5h65J9K3nhB7qlxAsZme2gVXM2rNw47qvT72o1WBFupMDYZjnTaWwJGCnOax8DIq4yoD+VlwI1fZ8r3QSlytUD5R2M=
Received: from TY2PR0101MB2591.apcprd01.prod.exchangelabs.com
 (2603:1096:404:ab::19) by SI2PR01MB3819.apcprd01.prod.exchangelabs.com
 (2603:1096:4:ed::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.8; Thu, 16 Mar
 2023 11:39:28 +0000
Received: from TY2PR0101MB2591.apcprd01.prod.exchangelabs.com
 ([fe80::9f6c:1351:78bc:13bd]) by
 TY2PR0101MB2591.apcprd01.prod.exchangelabs.com
 ([fe80::9f6c:1351:78bc:13bd%5]) with mapi id 15.20.6178.026; Thu, 16 Mar 2023
 11:39:27 +0000
From:   BHANDKKAR YOGITA TULSHIRAM <bhandkkaryt21.civil@coep.ac.in>
Subject: Request.
Thread-Topic: Request.
Thread-Index: AQHZV/v1IG9Dcr2BnEupbfnFD57NsA==
Date:   Thu, 16 Mar 2023 11:39:25 +0000
Message-ID: <TY2PR0101MB2591D7935D536561479CC33ECDBC9@TY2PR0101MB2591.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=coep.ac.in;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR0101MB2591:EE_|SI2PR01MB3819:EE_
x-ms-office365-filtering-correlation-id: 51f855ec-f491-409e-034d-08db26131839
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kHEU3ppcvq1bImwZB/uDVOKoitGPvKSQMbmQeBOdIL4vLETgV3nuzKhdDi8h8E3NKyk82BPFPP77mt6wbmRT2pPlJs46tQt5LqAV9UzDzGTRVWEXXI53jSzTx4jcstDHPXCgLq4j4U0R5Q5JUft3eXYQpQkBclpJNVLPhjh02oXIK6TKlTGZba0zVXW5eOxv4IG+XSIfnvRyN775XT9V3RauaebssYk4y6l+E1BqtKKv0e6lo/otQ/WZLCuv1iHULols6PrlJpSXIkROK2kmBf0jRJkXcFvfUmzEXwP2vYmDBnLi7OyMrxBCUDrtIMD6UBG4q5cRmjnF8Ire+nmb1OtHkiARzCKBR6j/DumS79WTV3VVBYp98/Ku0SmXysKfbT2IdAdrBEcXYop7a4Faa7E2dVzd6g9g8Xjx8s0iGSaIwkdBWgFNuBXn1KWFSzZCD1RfLYf+E8YLNeenEWTBRZBAUWqUJV0oB6ySSBFXfTAGioSuCRjOoLj+gm8r7xpxVD9JnV7b88T9UwzG0X/0N67MJY1TVZKLGYSXNnCrDHaTta+/zklgOGrVzqE+tE0XKDf/Ly1hOpx/r8uCekH1ti2IFCZNdq36PSnTw+J+ziEyX1B8Nda9Y+NPFe+5qHEslkhyCr2IJDYa8euX2ciLlLcliLVHS481eILclaD6AykkX8sU4UcpUsW0cCffLMan5VigAUwMGI5dcEo4a4JnPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR0101MB2591.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(109986016)(451199018)(7406005)(7366002)(7336002)(7276002)(52536014)(5660300002)(41300700001)(7416002)(8936002)(7116003)(2906002)(7696005)(4744005)(33656002)(122000001)(38070700005)(3480700007)(86362001)(38100700002)(71200400001)(478600001)(66556008)(66476007)(64756008)(66446008)(91956017)(8676002)(89122003)(76116006)(66946007)(9686003)(55016003)(41320700001)(88732003)(786003)(76576003)(316002)(6506007)(26005)(186003)(55236004)(487294008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?YfCQnPT8bx9I/aSPpjhrXwDBZbTP5SjmSBrlcd3Gkk8G9P2hlpzEyXZa?=
 =?Windows-1252?Q?onE/rdsKvjI+kVVUPcHeyYEB7V55/xBOpinhie6lE5cVDJCQbChYaoyM?=
 =?Windows-1252?Q?oi4i0TKLha0netpJzG7GG7/Y/VlXW0zARlLKjEcSjS6WxHMm7R/QDGmL?=
 =?Windows-1252?Q?fgCBSVL4P6saBk4qXSS/ty3telh7oNkeM4e3i7UBu4kIq7eyHHpPBXAt?=
 =?Windows-1252?Q?kNIAzf3albH5tP8biP0d8t9G8BcA4ucA2ofEIYZW8675PfBuI5dqkxFb?=
 =?Windows-1252?Q?/J8anDjeJ82w+rDhtfnc6fsw65/I2a3zdJXwagouWLYhJHz4qLso9nr0?=
 =?Windows-1252?Q?QnpuGBXKN87SBinPwLvshNoi+FqEJDC04yor1nAIAC0UNRxoQRihOt9b?=
 =?Windows-1252?Q?q4mcsqX51jGrRrEjOHvjO8UCnuXoTONow/kCpyWAMrg22CfcnjSv1VDt?=
 =?Windows-1252?Q?DAJecK34PYHhPVh2IwfNzq9aEMWc8vhdUP4FRegVSbWQc+xazbcoYp+s?=
 =?Windows-1252?Q?S137Ozth8rbMozenYMZExq/au/o1zpAs8jW9EPaXC9ijYelCqNbHIANy?=
 =?Windows-1252?Q?b7rh9jcettzbGGstKai5Nm4q3oKuhbSB0CpHNS0ZRh/vse3IC885N5/n?=
 =?Windows-1252?Q?2+5m5mIfOp5vRqtaI8f3+ORnECCzIFTWWkTCKLfqThwmTbzqujkPvZJe?=
 =?Windows-1252?Q?Jszp/K5xmpe7Dkqnfxhyh1AbC3pFhjfE8CWRvfQPmpwpLOPAwE5FUxjX?=
 =?Windows-1252?Q?lFA1dgRqeA/psEkVlqOOiwigiNeZcEM0qp+Jkn59BJzD4ID7VoP5Ek5P?=
 =?Windows-1252?Q?P1jdOPFmnKBf8RKEUVTEQM3EOfdf87IsMK5qG8X/wXI23a1QieYKOWY/?=
 =?Windows-1252?Q?ofQrIzzZ621zyS3ur157875g0MjSaxYdB4UH3OoiVH+nXSHpuwtYzqcd?=
 =?Windows-1252?Q?6e8C9olThXV42g8NUzfJwyTN2nbNHO9NzcuL0TIoDA+2Msx5oJNyKVDn?=
 =?Windows-1252?Q?cS/+spb52a7UBBxzBWWqk/FtlVjeNcohVa7EZMeB/p99Y4vUCw/qJ3QI?=
 =?Windows-1252?Q?M1uPuClxCbY3AH91JD/0Z8HCb2BJVUVcWsJJIiTHm+RbYWIe3N7FOaON?=
 =?Windows-1252?Q?2BspyCeY/qN8W9KCVkfA+wh5hRT6BBpUgEKnJf9wYz5j4kO8pEnOyDMh?=
 =?Windows-1252?Q?rEBhTits7YLpZtotzRVfzbvpvjC9p+QDgCwIeKDDafpOJ9/g+7//xeUF?=
 =?Windows-1252?Q?5JAtyURoHDRfToYPowFrDZnaYq3QjTlkoAh34vdH9/wLyoLWy74UrIkE?=
 =?Windows-1252?Q?zcwm/9CVe5a/ULHuIDl7IqjiS5aWkELwrAMIQ8vU/TUHtGRZw+ojPUuL?=
 =?Windows-1252?Q?+1nZRyxm3Hri77YyE+fCvwM92VTms63yZq+3dPAC5mih7ezdspJf7i2H?=
 =?Windows-1252?Q?CJNg5Cwk5XQ6XxX6kq7HEvpZYCgc2grwGrW3f8Edlgt2ktx+ZclIQhc4?=
 =?Windows-1252?Q?emDJ+LnwKLSa3lkxBWXD4huz/sQd7ZC+b+5GRKaSAQoIgyTKufM6rclu?=
 =?Windows-1252?Q?HEVqDucdFUE2QdJzFTt2NhRTwIApsEO9t5Ztf/kl+zb+hy/hCt/qd8dF?=
 =?Windows-1252?Q?fxOkBJLo/2NeE4vwU0ZNArFvzuOLTSG85bCdor18ppI+bsouuwGhLN06?=
 =?Windows-1252?Q?rd4uPaEkF/EngiGwcswziVLUEX4rZTje?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: coep.ac.in
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR0101MB2591.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f855ec-f491-409e-034d-08db26131839
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 11:39:25.5368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b4c6b754-54e3-41e4-a8da-304355c62816
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOMx61OJfvKlccOGwnig88xYmwvNjol7CF077xe5cchfcVuXLnzxS2txvpHuNmxQmCOOL/8FxolMSuQ3lv5YRLMUnNLIlqwzBcB7JqaRpug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB3819
X-Spam-Status: No, score=2.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,LOTS_OF_MONEY,MISSING_HEADERS,MONEY_FORM_SHORT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I am a private investment consultant in the Netherlands representing the in=
terest of a multinational Russian conglomerate who is desirous to upload fu=
nds into a trust management portfolio. Can you avail my client of an invest=
ment portfolio to nestle the fund of =80150 MILLION EURO? Please contact me=
 back through my private email address for more information: rsevriens3@gma=
il.com =0A=
=0A=
Ryusei Sevriens=0A=
SEVRIENS LAWYERS=0A=
(Email: rsevriens3@gmail.com)=
