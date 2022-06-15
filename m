Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8789D54D40F
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Jun 2022 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350198AbiFOV7z (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 15 Jun 2022 17:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiFOV7v (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 15 Jun 2022 17:59:51 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05hn2242.outbound.protection.outlook.com [52.100.174.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2435955206
        for <linux-sctp@vger.kernel.org>; Wed, 15 Jun 2022 14:59:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1WbBy9SMGvPS8eS0MDXRqcAZpSfiKUY95zXio/vGpWsLBeSdU8jQ5H/i410RGJ30ja9/iKbjFvP2cLtcVGjO3CcMPWMYgWkIxM3z7sArWgNuzbOSZQefYykSmDaqranoQOyeAl/gNZgzPmjZFs8FraNbkLC+zAS/mD/2XOv3czlRrc/gKdGwFZ/2uY3za+ThW1xVFEhnFPt2XD5TMklJ0eBuejLp0t54zIiQUzDORtpS8mSKY4SUeI3LWX3cyoKBZDDwNQiNaKwfpItkVwak+pY9tTQNn4ocrBL9CaakMqA9AHkpbEUwXoeno82h0wyiDR+pq8z/63wnGsIRzFhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=hMqCJsRyuFxQiSjfYTi35xC6rtOeTKnvUL5fPEDkz7umx4ndliIvES5dDGfwD9hQQLUiE+EvtOS+jMD/ERZ7FjBVhb7Nth/Fq008IAyW5TEBNiqzqE8BFRTVeLasYglOUvWF6C3rvqOx81/l1ip6SD7lNWKIvwvDkYUJDQ5j7JDsVr01O34bH/UYGhLNpA9t77SsV1Vey7D45AyTWmWi528R3fRIffKXAjEeFXxVCwhrmXTghxc1lVu4z7jI9hC231McHhUr3jk4e5qaTaa3i5JZtiNfO3yJBzL3uidJcAu3vmhJg6SYayWOb091Tgbb775gFtm+9KiAocIjj9mjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 91.151.71.70) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=solairedirect.co.za; dmarc=none action=none
 header.from=solairedirect.co.za; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solairdirect.onmicrosoft.com; s=selector1-solairdirect-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lQsm62DnO3DRMaTO7/AWxijWtNxIrL/VW/Qe6xhipJU=;
 b=GsItWIge5JUuR8MoXyFeZF+ecFbZSbCIxF/CvvNnEAZAcG2zM5tTBjPTGIFPGWkrOG/nUVXT32qMPl15x+xNZZ12b2TJvVw5/UsRlPE1irjVhojH7fDjaElRRi+7hfWkqKutuYDYD8PEbRrQuzRNcTJzFDVk9KxDsM1FWbLza3A=
Received: from DB6PR0601CA0009.eurprd06.prod.outlook.com (2603:10a6:4:7b::19)
 by AM6PR06MB5654.eurprd06.prod.outlook.com (2603:10a6:20b:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Wed, 15 Jun
 2022 21:59:42 +0000
Received: from DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::46) by DB6PR0601CA0009.outlook.office365.com
 (2603:10a6:4:7b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Wed, 15 Jun 2022 21:59:42 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 91.151.71.70) smtp.mailfrom=solairedirect.co.za; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=solairedirect.co.za;
Received-SPF: PermError (protection.outlook.com: domain of solairedirect.co.za
 used an invalid SPF mechanism)
Received: from SDSV152-VM.solairedirect.lan (91.151.71.70) by
 DB5EUR01FT086.mail.protection.outlook.com (10.152.5.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5353.14 via Frontend Transport; Wed, 15 Jun 2022 21:59:42 +0000
Received: from [206.72.197.122] ([206.72.197.122] unverified) by SDSV152-VM.solairedirect.lan with Microsoft SMTPSVC(8.5.9600.16384);
         Thu, 16 Jun 2022 00:00:12 +0200
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hi
To:     linux-sctp@vger.kernel.org
From:   "Emerald Johansson" <marketing@solairedirect.co.za>
Date:   Wed, 15 Jun 2022 17:59:34 -0400
Reply-To: emjo680@gmail.com
Message-ID: <SDSV152-VMPINE59MnD0004701d@SDSV152-VM.solairedirect.lan>
X-OriginalArrivalTime: 15 Jun 2022 22:00:12.0558 (UTC) FILETIME=[498222E0:01D88103]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da9b3186-1e8d-4e6d-5171-08da4f1a5a04
X-MS-TrafficTypeDiagnostic: AM6PR06MB5654:EE_
X-Microsoft-Antispam-PRVS: <AM6PR06MB5654B7179605BA0E875EE3ACEBAD9@AM6PR06MB5654.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?v132V9YVuZN3veaSfssTo/3vafU80fY61zZjRLd+asnnWivwPUbjZihu4V?=
 =?iso-8859-1?Q?+ZXmnMWi2zf9lCDni+5CzKc92gQe+pBT0yceghJ2GqyCOvquA5KetGk9AE?=
 =?iso-8859-1?Q?Z0xsF3xXEskMICTDdLHCaWnRFRJMA4zb0tQQhODATzwlTDl6S5FUPJqpeX?=
 =?iso-8859-1?Q?M/pH1HZPUG1K/0ky59R22kI1Sf/Rj5xeXsGgokM2PpyGi9WCHfL0cSnnnq?=
 =?iso-8859-1?Q?T/bfhDvhNVdiyskXFIPWaNRw8pB7rABuNJ+FQOo8Z+ccX9IJFdBpbtaCmD?=
 =?iso-8859-1?Q?+i7VVNlY0P/8aprnrBzSWIiA49r1eI9vquVNc4JtEKnsoZLWCxbnPaF6K+?=
 =?iso-8859-1?Q?gXl18R2jTtQBqCjCbdm+QOEFTB2DK5H0eOUUwI/KI0a1mTXgXQ3GwHOJg8?=
 =?iso-8859-1?Q?BVvIAkHP3JmHB+01ShuFBPEnM4YgTw1hyKDYfW73tnjFyaNQi17WZtgIoE?=
 =?iso-8859-1?Q?2jiEsLIV4j9NMHdMXeVWydWQv8Q95ZXpU8FSJgN6kcF6NMRH86KwL41wxH?=
 =?iso-8859-1?Q?m22y37og/E5X43wmJOFxGJqEZQFTHV7Nb0gei4FnYRUrqp5M8kZSVRvTXl?=
 =?iso-8859-1?Q?cY+50+g6VBchzLsJPTWvKkZyXqDI9HR4QGJ9HOHmWUBWtxjtCkVrWKuSqH?=
 =?iso-8859-1?Q?XdwWZQA6HPV2h5Qu72tGmhtmOuAt5CkwAFNj7gtfpw79oIu4vrU6zexz7j?=
 =?iso-8859-1?Q?rn8BVViDfUxbpx2v7/wnjEEWqWI1pbtLq35itYvZ8JE8hAmKCgPLP3T99k?=
 =?iso-8859-1?Q?s0MKTqrXs4BoQORr+puNDcDw00UHYmCndYv/XcYhwkTRatIqKT0hkl8lBQ?=
 =?iso-8859-1?Q?G0nW9oN9p+L7gDgI6/oU7NpTzkRL+rNTSoD5FN5PJPicv3Xro5clEucN2W?=
 =?iso-8859-1?Q?mmBWSkbjJNWzvNLqC3RaF2TTTKdV5rMzXxTLrgVNymWaPhhPvKQkihDsuj?=
 =?iso-8859-1?Q?b4/cjoiVvZ+nhELQo4Zg5LRotkFspPsiDQB+/nhc+NSkt9UxV3blSrXy9J?=
 =?iso-8859-1?Q?JZ8CuhB7+tHvNXf+0fZjpYKuk3kAN1aZXvcJ7i4vFECjiF17WaKRHX+SlE?=
 =?iso-8859-1?Q?VMQiQYy+/AzQsjGJzZZbAyM=3D?=
X-Forefront-Antispam-Report: CIP:91.151.71.70;CTRY:FR;LANG:en;SCL:5;SRV:;IPV:CAL;SFV:SPM;H:SDSV152-VM.solairedirect.lan;PTR:undef-71-70.c-si.fr;CAT:OSPM;SFS:(13230016)(346002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(4744005)(40480700001)(36860700001)(7116003)(3480700007)(508600001)(81166007)(5660300002)(356005)(186003)(40460700003)(47076005)(41300700001)(82310400005)(2906002)(26005)(86362001)(9686003)(956004)(316002)(70586007)(6916009)(8676002)(70206006)(6666004)(8936002)(2860700004)(336012)(16900700008);DIR:OUT;SFP:1501;
X-OriginatorOrg: solairedirect.co.za
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:59:42.3229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9b3186-1e8d-4e6d-5171-08da4f1a5a04
X-MS-Exchange-CrossTenant-Id: 1c138fa9-0b91-4473-baea-5be5feac0f7e
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1c138fa9-0b91-4473-baea-5be5feac0f7e;Ip=[91.151.71.70];Helo=[SDSV152-VM.solairedirect.lan]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5654
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I hope that you are at your best and doing well. The purpose of this letter=
 is seeking for a pen pal like friendship and I'd love to and be honored to=
 be friends with you if you do not mind.. If the Idea sounds OK with you, j=
ust say yes and we can take it on from there. I look forward to hear hearin=
g from you.. My name is Emerald From Sweden 36 years , this will mean a lot=
 to me to hear back from you.

Warm Regards.

Emerald
