Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A1F5BA3D4
	for <lists+linux-sctp@lfdr.de>; Fri, 16 Sep 2022 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIPBRi (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 15 Sep 2022 21:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIPBRf (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 15 Sep 2022 21:17:35 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01hn2219.outbound.protection.outlook.com [52.100.164.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B8A7757A;
        Thu, 15 Sep 2022 18:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4o83MdUwBzT/yGYHHri9JxKgvKAr1myKifExpoOG6RW/DJ6Hwx/HFWbCRTAcnalNMWZtiCfWWiv5BNRgudbeIRIrFA1aUpAMqgiR637yuSms6do4DF6jNeC1yKumQYHlgZ/a6HhOxwZtpo9C6zkL+bsu0JAtMId5JULDOXnfzA74uvlRxyoZiVHHEh/Uxv1/xdTJ3SjFGvN5cw/tu1nDH1AdI9DEHKG6moY6aDp85uW3+wP2ZL69Kx/X22OyF20hg7Jn3VKP6Yu1kJZQ6g9LvjUj7xhFxAzUAtOtHKQA12ks/Rp4h2PyduF+HYYaHU47spmmHU6GI+HZ8sqNniaWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs10Md+15nMnyayKLyd22Uv+/ZH79IcFcpzuzGLq1Fg=;
 b=Z+6l5XN4eD0pGu0kvU1O/11m+Uv6YQ0Qd0vITH042WwFlhw/RN66l78Gi6CIsx+jk0c6wO03fHHPsVd/vmE9a2h7Z4mu0Dxy/sHonKIToUsqzJPoL2MGFIkZTWulAgfRVhIwUoOa/5+ajfIWHSwxqXysIlktUz9o4p9llcGX2U9ba9l6TAPweWQd0I4uGlHEqoSQkOQAgEuyGJNmlSaLKkSZCV26SzSt+/M0gqI/nHTMnYzNs7Yz1f4/JyocTsAQNUbeUxCBz1zX5m7n0+ACY8fap+nzx488tj/tt2Dh5SJ4O/v7mKBm6RA0+J5XwKp/44GqHMPEdBA/zmASs0FHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 45.14.71.5) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=t4.cims.jp;
 dmarc=bestguesspass action=none header.from=t4.cims.jp; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR02CA0090.apcprd02.prod.outlook.com (2603:1096:4:90::30) by
 PSAPR04MB4296.apcprd04.prod.outlook.com (2603:1096:301:3e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.16; Fri, 16 Sep 2022 01:17:31 +0000
Received: from SG2APC01FT0020.eop-APC01.prod.protection.outlook.com
 (2603:1096:4:90:cafe::f3) by SG2PR02CA0090.outlook.office365.com
 (2603:1096:4:90::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16 via Frontend
 Transport; Fri, 16 Sep 2022 01:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 45.14.71.5)
 smtp.mailfrom=t4.cims.jp; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=t4.cims.jp;
Received-SPF: Pass (protection.outlook.com: domain of t4.cims.jp designates
 45.14.71.5 as permitted sender) receiver=protection.outlook.com;
 client-ip=45.14.71.5; helo=User; pr=M
Received: from mail.prasarana.com.my (58.26.8.159) by
 SG2APC01FT0020.mail.protection.outlook.com (10.13.36.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 01:17:31 +0000
Received: from MRL-EXH-02.prasarana.com.my (10.128.66.101) by
 MRL-EXH-02.prasarana.com.my (10.128.66.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 16 Sep 2022 09:17:00 +0800
Received: from User (45.14.71.5) by MRL-EXH-02.prasarana.com.my
 (10.128.66.101) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Fri, 16 Sep 2022 09:16:31 +0800
Reply-To: <rhashimi202222@kakao.com>
From:   Consultant Swift Capital Loans Ltd <info@t4.cims.jp>
Subject: I hope you are doing well, and business is great!
Date:   Fri, 16 Sep 2022 09:17:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1251"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <b88f6004-1774-41cd-b8dd-c9210b0ec8a2@MRL-EXH-02.prasarana.com.my>
To:     Undisclosed recipients:;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[45.14.71.5];domain=User
X-MS-Exchange-ExternalOriginalInternetSender: ip=[45.14.71.5];domain=User
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2APC01FT0020:EE_|PSAPR04MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa05c1d-b4b1-4479-90f5-08da97813a4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 0
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?windows-1251?Q?Wlj+8wRk159ZZGYOMMQMsVGFU8Q2vffl1gPIM54q/xLej1O0onCPvKJ1?=
 =?windows-1251?Q?db5cTfD+QYb/55NAe1/ezWpdAr4waGSS1/b8XaoOyRaH0SzrivWB8Hxs?=
 =?windows-1251?Q?my4otFyzs/vJHRl1NZ7QJIqBm+gVlmVROAVTiLvr+caZFt0HGaxvP5Qk?=
 =?windows-1251?Q?1+N2FcNB59nGWHDJNH8vMVawO4HRkqa77ryRIzrgxqiJVsmLVueKrjrC?=
 =?windows-1251?Q?kLATBANyE8bLxCCH/E8wLUxkoGthHaJDt9B34muAt1G3Z98SO0B1zsvu?=
 =?windows-1251?Q?99EMUJQIT0aJz5CrgddRkJBq6fRW+LwEF+PhCXPJCeo8Ngk6qO+Z6ey8?=
 =?windows-1251?Q?+HMFsIzLNg3YyfuK5TnIU0jRjcPnLimz9yMBqSxeDovAeuhZujVGaAVh?=
 =?windows-1251?Q?Qsa/el9xd9CwS2KEq+zJ7uoiVgg0zWvb7yzX6EcjY+xiAIWHrlacSlWO?=
 =?windows-1251?Q?KSzRh+qugc79k82JfQQqpuHe/x0i9Xia2UIQFi4xnCZBhH9vJS+w5IGH?=
 =?windows-1251?Q?I99iehXePIc/0eVgvh70AoTRdAP7Nsd/oqNeEeCl4mKQSd/oA8afkXf9?=
 =?windows-1251?Q?TlfNjuN1S+FCG7eDpcKp1UIAxotWqyskoiybPvSrxIh4cYuVnrFAE+V5?=
 =?windows-1251?Q?A5GY2O27nhABEwSTxzPzRhma8CALg00FgAFxtD17cPJuenlM5iPsEdGG?=
 =?windows-1251?Q?QOYXyXHvEmDEEuLssmeeNT4mF3LUYJpgbqlpJ/cP3WrbE+0oobEFy8sV?=
 =?windows-1251?Q?yLx37JE5Fd20f6vu1/egAjVCDR+LHhumsfZeCw8oIe6m8fxkVlIayxdZ?=
 =?windows-1251?Q?RtB23v9WeVdYAFF19SM0RbHcwpOWBOAxxI5Dq1WYFEnOgVCl0/ufRHYZ?=
 =?windows-1251?Q?X/AYDGvljLES7XEfe33NXnph16ztDgch9vkMzdZD04cw4ykMrgFwWh+j?=
 =?windows-1251?Q?/Vl05CV2c0s4lzp+u2CkCbNj4+Ahz3AvOhaF/DFz+vW5od/4Fr4owDM6?=
 =?windows-1251?Q?KV4sat4mdN0skjLoagoe0JiwybH3bjCx0hZFynxLPaB0lTsWGyLYrJ6a?=
 =?windows-1251?Q?ANKe4FMW9yKi//rdG9vlbZYbRtf9jM96z3pDKMzBqSiI0EzwVZvE5jF5?=
 =?windows-1251?Q?6BJhJrWVnVOiKFqGA8ZCU386n82z0lOmgtv9DMEA6zo/rOpXhbIMtd5w?=
 =?windows-1251?Q?fL1OVUtDjLv0it/PB1uYZbTYDbWxF/+H+Sg0GPiVI47CeEJ73lmDGlAu?=
 =?windows-1251?Q?3UQmL+UUzm5SGkBxt+fvyUDkCT5YsFyT0RqMqGEYDLZUwtmX9NGdd6WI?=
 =?windows-1251?Q?sUYC1+yw4eArmU3uoLmLCdtgYwp9Iv1Iwr/q1bUQDSuVW4r1?=
X-Forefront-Antispam-Report: CIP:58.26.8.159;CTRY:JP;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:User;PTR:45.14.71.5.static.xtom.com;CAT:OSPM;SFS:(13230022)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199015)(40470700004)(46966006)(82740400003)(66899012)(2906002)(156005)(32850700003)(31686004)(70586007)(4744005)(9686003)(26005)(70206006)(31696002)(40460700003)(47076005)(81166007)(5660300002)(7416002)(40480700001)(7366002)(86362001)(498600001)(109986005)(6666004)(956004)(7406005)(41300700001)(8936002)(316002)(36906005)(35950700001)(8676002)(82310400005)(336012)(2700400008);DIR:OUT;SFP:1501;
X-OriginatorOrg: myprasarana.onmicrosoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 01:17:31.0458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa05c1d-b4b1-4479-90f5-08da97813a4d
X-MS-Exchange-CrossTenant-Id: 3cbb2ff2-27fb-4993-aecf-bf16995e64c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3cbb2ff2-27fb-4993-aecf-bf16995e64c0;Ip=[58.26.8.159];Helo=[mail.prasarana.com.my]
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT0020.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4296
X-Spam-Status: Yes, score=7.5 required=5.0 tests=AXB_XMAILER_MIMEOLE_OL_024C2,
        AXB_X_FF_SEZ_S,BAYES_50,FORGED_MUA_OUTLOOK,FSL_CTYPE_WIN1251,
        FSL_NEW_HELO_USER,HEADER_FROM_DIFFERENT_DOMAINS,NSL_RCVD_FROM_USER,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [52.100.164.219 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5105]
        *  0.0 NSL_RCVD_FROM_USER Received from User
        *  0.0 FSL_CTYPE_WIN1251 Content-Type only seen in 419 spam
        *  3.2 AXB_X_FF_SEZ_S Forefront sez this is spam
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [52.100.164.219 listed in bl.score.senderscore.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [52.100.164.219 listed in wl.mailspike.net]
        *  0.0 AXB_XMAILER_MIMEOLE_OL_024C2 Yet another X header trait
        *  0.0 FSL_NEW_HELO_USER Spam's using Helo and User
        *  1.9 FORGED_MUA_OUTLOOK Forged mail pretending to be from MS Outlook
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello,

I hope you are doing well, and business is great!
However, if you need working capital to further grow and expand your business, we may be a perfect fit for you. I am Ms. Kaori Ichikawa Swift Capital Loans Ltd Consultant, Our loans are NOT based on your personal credit, and NO collateral is required.

We are a Direct Lender who can approve your loan today, and fund as Early as Tomorrow.

Once your reply I will send you the official website to complete your application

Waiting for your reply.

Regards
Ms. Kaori Ichikawa
Consultant Swift Capital Loans Ltd
