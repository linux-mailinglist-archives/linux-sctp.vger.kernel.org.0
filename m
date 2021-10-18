Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D724643290E
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Oct 2021 23:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhJRVcZ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 18 Oct 2021 17:32:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9108 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhJRVcY (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 18 Oct 2021 17:32:24 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ILIjOm004907
        for <linux-sctp@vger.kernel.org>; Mon, 18 Oct 2021 21:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 to : from : subject : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=0b+aBe3VzTvupsQ38e1mYcunoNMpWT091ZJYoYeR8+Q=;
 b=y+I/lNUjvLh9TKbMxB+GaAflA3BbXMDi4ErrfDBRaxsdCfIGbsjRwBGDUASGb76/yU7R
 I3Et8cw15GVAPwh99IIf2VC+lO/IQNbApoQejZZJ7aGWXZ82Q71kl149tGu5VWncji8g
 T2SSKqwNQSVl10vsqKQjoft0VioSJFCtSv/HroFhVAmni3KOeXBAelDNHxGCRcUIS4P+
 7oQuK7d5s0dE39WeRLVAKGSbzbUYCmRSFwpgUuX39hgxn8ypVSWxa8kDpAwCeiqovZj9
 +E6hKfcLucwnh9xmp8M0ZrgIjtBbPOpai3Cc9cBs5uRDE3KODCKsa1gfdQ7+WLH+v/cT GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3brmrkebf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sctp@vger.kernel.org>; Mon, 18 Oct 2021 21:30:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19ILFU0k069406
        for <linux-sctp@vger.kernel.org>; Mon, 18 Oct 2021 21:30:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by userp3020.oracle.com with ESMTP id 3br8gr8s2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sctp@vger.kernel.org>; Mon, 18 Oct 2021 21:30:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmyIOQZRYbLUNRs/A9pi03xBV7JqHypSQGPYFGsyBu3tunOfP5rgdPp9MbLi1N51ztSTqNuN1aclFHB9wRyvDN9wPuDsJLqt46PqUXXydJzlRWpCJoPh3+FBxsmDify8Dme9fuAX60T+TsFZfBXIP21M+x2ezaJdC26sfyXXHQN/7lde8MHFH7TYJVhnbdcV8eGDIBi1pS58vD/Idk4zajJEv7yUIwJRPoUxeGSppgQcITPKFpawVl2+yW709gx39CLfdHGkMKmfRu/IT6gm4mY3AVZcpA17s8o1w1UEF1foL4JYfXTCaa2fi6SHYNnpRPltHYbJHnSMazX/fPJOOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b+aBe3VzTvupsQ38e1mYcunoNMpWT091ZJYoYeR8+Q=;
 b=CL3jdWbI2yMl5LLoiq9DiTcP9KtdCmUpgVoPUQcj0Ng9GHv64VbvgTrl6btREe/TwdMBVSyl5loTbiilCQYzNJvMbNw7uH98QQsv8DMYESCZyxBFMshNscUTLXnWYMGSM5LPj4uaJOVLb6RRN7nnUrVO0p4uvjonhR3ys/urNIcvPJ9i4oE72tXDk3MLpRpWSsned8Ym2wuRDgT3NJFLqKvpjtCQDh/FszpYumzIV2PQ28uw9hU1EGXRovTRqfPz0S/Cd6lEZcUkXTOC8TI5+ce2LXkt/VKWRAIfJgsa74lnor+wHiqJ5rwEPtykXVE0Re6spNIZ8ETTrBLyH8RoXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b+aBe3VzTvupsQ38e1mYcunoNMpWT091ZJYoYeR8+Q=;
 b=LdYAtC0jMb9hojo9TB+wWrglDSQrQ7FP9l9mRTe84C70Ow/bLVsJ5iGuYGe12aMp/0Y5NXJZfVNSBkRevm12lrVPQNnVFbspGa7i7e7OImQKnoFZv4HI7fPVPuNSPUpeq9t3Zk/P0k63wiuLQ/EA82JI1hxzuyy9mUlDFCISjGs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB2031.namprd10.prod.outlook.com (2603:10b6:300:10a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 21:30:08 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 21:30:08 +0000
Message-ID: <4f9d3a13-2104-ec1c-dbc7-12de1f99ea0e@oracle.com>
Date:   Mon, 18 Oct 2021 16:29:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Content-Language: en-US
To:     linux-sctp@vger.kernel.org
From:   john.p.donnelly@oracle.com
Subject: syzkaller test panic: Linux 5.4.y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0138.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::35) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [10.175.46.172] (138.3.203.44) by AM0PR02CA0138.eurprd02.prod.outlook.com (2603:10a6:20b:28c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Mon, 18 Oct 2021 21:30:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16111ab2-fcb7-4f22-c960-08d9927e75a3
X-MS-TrafficTypeDiagnostic: MWHPR10MB2031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB2031548B73355DBFFE307B0BC7BC9@MWHPR10MB2031.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PCjngTwsFE4CzKDSXoWuVDIvekO5g7Ki0YgmscnzWQSDhvP5UsmQoPMDTwK1YYiMsLiJC73f1lM04nePXLwev04J+dWzNV40oN6ZoiHI4p7g/pk1ig2TVdcT9z0CfaEnkFKtAy+8gAWYLkKyFP73bTy61qaqX/Yaj0CjqNEfSXZi6Tj3CdhcNn6KxtY5sXQt7lpV5+b3G/c2gw4xMHci3+zXJe2xbLWY/t2cUgciMo73XgNc53bfK7Us+kn4sMWvavx9RWnUN8e+XHonE4w30q1KgY098dHPoMnnRWjnQ+NJTfk8IrsjLFvELorCjyAo8PieDV9oYc6cAJ+XYI1Jkf3HluWuhfarNyg+64UsqMU+cE+E9v6eLB+wpxI3Z3lXg9uvahi8FuUXB/UhjgNdhYTP43/BAhSzcy0mspaQ5MZE4TGAz4UW9qTj3rLu1PtM/Yj+FjwHBDof8/EvpyVbZcM785KvlyaaLzgicX2Szf/vLMsjIVgiVSrFL01zXgYjM0ca8lJCkB+gWCH4iJNCJjeGZjqnsF8UsSb2vTDZ2MqCNMN5ws1qWzyigEqc3HB506PklKgbTy8BpfMEF/QogwpO8NTSsqpiZpjifrZondU1yDBqZAetXwYKbY3S7w5GCf0QGzKprNP4rXZ0jcuwD9bShSPlXrsk6ZEhBdITDV7Qq5oZPZ5f8FfilVor3WLf1EetrwPRC9fm7P+PZm8ha7EajXFvT0Pwj4IxWuExpMiA3g6s5pyaur8MiLTdvOdsAis3IlZzS1qsHBP0ZicHMMSg4nhblZ/eJksEGQix8k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31696002)(26005)(8936002)(956004)(66556008)(6916009)(5660300002)(186003)(316002)(6486002)(6666004)(38100700002)(16576012)(86362001)(36756003)(83380400001)(30864003)(66946007)(9686003)(2616005)(2906002)(31686004)(8676002)(508600001)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTNDUkNZUVpjNTFwRzhldFNFL2ZWUW5Sb1dZanFZMVFMd2F0aTdtYWdEUS9t?=
 =?utf-8?B?bEUxUTVQZzNHUHk4elBSMTc5U2hBRmVMcmlJQ0FmZ0g1RDhQcmluZ29NNjJU?=
 =?utf-8?B?cFFoNEkwUTBoUUpTNno0d0gyQncwenJ2QmFBL0c3NWJTdGNBWkJFeS9BakVD?=
 =?utf-8?B?OHVtbW12eGE2RWhVSDQ2aHBxeWNiYU5xNzNzb05GdFhseExrNHc4ZHV3M2F1?=
 =?utf-8?B?R2h1RHljS2MzV2RDTDFKcmdrQkJNNnVtdmRZeDdjUDRra2p3ZEk4Q3BFdHpE?=
 =?utf-8?B?TUdndG9KdmxtQW53dE5MNEFGQ0Y5M00xWVBnMUZ6YkNzNFBVMWRHYWlxS1Ro?=
 =?utf-8?B?L2QxQndiMktSTjU2RlRQZHJjQTFDeXBrTEozSFhwcjFkR1lmWFVEalg5K3g4?=
 =?utf-8?B?QmRLTWhNS25lVGJXRGJYOHlvTDlzNURwNkhZeGpXT0FhdlZaWVNQTXg5eXlo?=
 =?utf-8?B?THVuL3RyRlB3MER5cURIUFI2ckRybC9yYjQxeUIvNXNuTUpWYTdmWW9mS0d4?=
 =?utf-8?B?aFdrMnpxRDI2K0tFdVBqVzNKbldXYSswWHA3eVFqbFE4WGhnM2VSZElMdXJP?=
 =?utf-8?B?NkFKNFhmSlJZS1dxS0p3aU14RzFkYmJlOEx2L1JiTEY1YW9xelFKOThLWWVn?=
 =?utf-8?B?emx5MnRQNVlobFhDdm1WUEt5SVpQNDQzK3RkM082dG0rT0hyZXJQbk05VVpO?=
 =?utf-8?B?V01IcGcrdDAxYjNjZFBYQnBmQ3FiazF4ZlJVK1ZaVEhpaFMvb0lLY01VNTUr?=
 =?utf-8?B?bnFSVnYvZk5oTHVGRVNLVnd5aWpZM25nRFpmK2NyemNyVHlteTczbjVHUUZL?=
 =?utf-8?B?Z2hZRy84cFFDcS85SGJ2MjNNcnhBLzdqRlB6bEI0VlI5TFVQR29PQ1lUdkc2?=
 =?utf-8?B?a2M1T2wwR3FEcHFoZnNaanRob2RWYjFmTlBIVUNyZUNMcmFjMDlQaTVFV2ZO?=
 =?utf-8?B?L2huYUwrNHBXdWJTT0lDZ3RlUGxLbXY1WXVzL0JnVTVrZi9yS2VtV3J5RGpp?=
 =?utf-8?B?VVZueWhzOWdWZkZ4YUdWZDhQSmNMdXpLQTBxR1dDakxUMm1hYUtObFJ1Z085?=
 =?utf-8?B?ZVFRQ0xqaGRSNnQzNEVhREpVZnpNT3llaXk0eWJKMnRJemxGS2VkRmp4TG85?=
 =?utf-8?B?MHhlUjZVY3BYOStnSlIwSisxdjV3UlNSUEVBUGZaNlVUUXZYMStUVjY0Tlor?=
 =?utf-8?B?NCs1MnVwUVdvSmVMZmM3MVNyWWxJYVcwWVlmUng2MTNqdzh0YVN2d0ZjeVBW?=
 =?utf-8?B?c2s4SXRXUktJdDZ1VmZMWkU3Szc4b2NBb0o3dDNmQUNhazFnNWR1b3oyRHNW?=
 =?utf-8?B?TmtqWlg1MUJuQS9GWGJjN1h3SlpYSzlwUWtFQTVQREhWeGl3QXMyV1l1ZlVh?=
 =?utf-8?B?V1VUUUU3ZmxMSmR0U055b2FhZnRJc3h2VGFqZFg4Z2lWVzlZL1E1YWdBb2xC?=
 =?utf-8?B?NFoycitmZDBkM1FwZUdHYkdmN2hFU3MvaXgzZ0sxWVFPVEptZlF0ay9ZMjlo?=
 =?utf-8?B?V1VPbm14V0piSlhFTEg1WmdGaTZmZTdsU0IwWUlGRUIrak1BM1BobnNSMENQ?=
 =?utf-8?B?VlhDNUVobXd0OHY5RnoyL1VERzJHV0NHL3lLZk50VTJ5TUVZaW9NV3lhajN6?=
 =?utf-8?B?cUdHdXNWemVNZmlKQjNoSHBTMmNwTHBtc09zcVRtaTljbTVDdzhYd2VIV1Yz?=
 =?utf-8?B?YVVsaXVJbi9VRnZkVDZEQlRqbjN1ZGZGUkVPQzJ0NnBNbG4wVG5CVityTmRX?=
 =?utf-8?Q?RHww2ixQyH1BS8Cl0b0Wy6XOIYqrvHy7z7+3tw0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16111ab2-fcb7-4f22-c960-08d9927e75a3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 21:30:08.7983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: df/S9z8dQpJcXCCoLDYYOzEzWZOJ2X26qlMLO9D/uzjLd3dCDvWjvUWHPR+qa+iLpF3bOl1qh41xjOUurTr9XKp2+P1yRvvVgfgRZJTZkk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2031
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10141 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110180115
X-Proofpoint-ORIG-GUID: mesJAdVl88DDdRkXl5vpo9aWWUAVi_-F
X-Proofpoint-GUID: mesJAdVl88DDdRkXl5vpo9aWWUAVi_-F
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org



Hello,

I like to report a  syzkaller test failure that introduces a panic with 
the Linux-5.4.y kernel:


strace shows this activity ;

#strace ./test-scpt

socket(AF_INET6, SOCK_STREAM, IPPROTO_SCTP) = 3
setsockopt(3, SOL_SCTP, 0x76 /* SCTP_??? */, "\0\0\0\0\7\0\0\0", 8) = 0
setsockopt(3, SOL_SCTP, 0x64 /* SCTP_??? */, 
"\n\0N#\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\1\0\0\0\0", 28) = 0
setsockopt(3, SOL_SCTP, 0x75 /* SCTP_??? */, "\0\0\0\0\0\0\4\20", 8) = 0
connect(3, {sa_family=AF_INET6, sin6_port=htons(20003), 
inet_pton(AF_INET6, "::1", &sin6_addr), sin6_flowinfo=0, 
sin6_scope_id=0}, 28) = 0
setsockopt(3, SOL_SCTP, 0x77 /* SCTP_??? */, 
"\0\0\0\0;\0)\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 734


   CPU: 0 PID: 1358 Comm: skbuff-panic Not tainted 
5.4.17-2136.301.0.el7uek.x86_64 #2
task: ffff880078bb5a00 task.stack: ffffc900006d8000
   RIP: 0010:skb_panic+0x66/0x68
   RSP: 0018:ffffc900006dbcf8 EFLAGS: 00010246
   RAX: 0000000000000086 RBX: 0000000000000000 RCX: 0000000000000000
   RDX: 0000000000000000 RSI: ffff88007e816938 RDI: ffff88007e816938
[ RBP: ffffc900006dbd18 R08: 00000000fffffffe R09: 00000000000001f6
   R10: 0000000000000005 R11: 00000000000001f5 R12: ffff880078512d00
   R13: 0000000000000052 R14: ffff88007827fc00 R15: 0000000000000070
   FS:  00007f80be10a740(0000) GS:ffff88007e800000(0000) 
knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00000000208c0000 CR3: 000000007937c000 CR4: 00000000000006f0
   Call Trace:
    skb_put+0x4c/0x4c
    sctp_addto_chunk+0x59/0xb0 [sctp]
    sctp_make_strreset_req+0x166/0x180 [sctp]
    sctp_send_reset_streams+0x14d/0x300 [sctp]
    sctp_setsockopt.part.21+0x101f/0x1720 [sctp]
    sctp_setsockopt+0x99/0xb0 [sctp]
    sock_common_setsockopt+0x1a/0x1c
    SyS_setsockopt+0x86/0xe6
    +0x79/0x1ae
    entry_SYSCALL_64_after_hwframe+0x151/0x0
  RIP: 0033:0x7f80bdc21be9


I am not familar with any of the sctp subsystem. It was found running 
the syzkaller fuzzing test suite.

If there is a more appropriate place to report this I can do that too. 
This test fails on just about every 4.x and 5.x kernel.  It is not
unique to 5.4.


Thank you.

John.



===

//  gcc -o  test-sctp   317ef02b0d5cbd19d445294fed91453c7f970fc3.c

// autogenerated by syzkaller (https://github.com/google/syzkaller)
//  317ef02b0d5cbd19d445294fed91453c7f970fc3.c



#define _GNU_SOURCE

#include <arpa/inet.h>
#include <endian.h>
#include <fcntl.h>
#include <net/if.h>
#include <netinet/in.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>
#include <sched.h>

#include <linux/genetlink.h>
#include <linux/if_addr.h>
#include <linux/if_link.h>
#include <linux/in6.h>
#include <linux/neighbour.h>
#include <linux/net.h>
#include <linux/netlink.h>
#include <linux/rtnetlink.h>
#include <linux/veth.h>

struct nlmsg {
   char* pos;
   int nesting;
   struct nlattr* nested[8];
   char buf[1024];
};

static struct nlmsg nlmsg;

static void netlink_init(struct nlmsg* nlmsg, int typ, int flags,
                          const void* data, int size)
{
   memset(nlmsg, 0, sizeof(*nlmsg));
   struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
   hdr->nlmsg_type = typ;
   hdr->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags;
   memcpy(hdr + 1, data, size);
   nlmsg->pos = (char*)(hdr + 1) + NLMSG_ALIGN(size);
}

static void netlink_attr(struct nlmsg* nlmsg, int typ, const void* data,
                          int size)
{
   struct nlattr* attr = (struct nlattr*)nlmsg->pos;
   attr->nla_len = sizeof(*attr) + size;
   attr->nla_type = typ;
   memcpy(attr + 1, data, size);
   nlmsg->pos += NLMSG_ALIGN(attr->nla_len);
}

static int netlink_send_ext(struct nlmsg* nlmsg, int sock, uint16_t 
reply_type,
                             int* reply_len)
{
   if (nlmsg->pos > nlmsg->buf + sizeof(nlmsg->buf) || nlmsg->nesting)
     exit(1);
   struct nlmsghdr* hdr = (struct nlmsghdr*)nlmsg->buf;
   hdr->nlmsg_len = nlmsg->pos - nlmsg->buf;
   struct sockaddr_nl addr;
   memset(&addr, 0, sizeof(addr));
   addr.nl_family = AF_NETLINK;
   printf ("sending : %d\n", hdr->nlmsg_len);
   unsigned n = sendto(sock, nlmsg->buf, hdr->nlmsg_len, 0,
                       (struct sockaddr*)&addr, sizeof(addr));
   if (n != hdr->nlmsg_len)
     exit(1);
   n = recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0);
   if (hdr->nlmsg_type == NLMSG_DONE) {
     *reply_len = 0;
     return 0;
   }
   if (n < sizeof(struct nlmsghdr))
     exit(1);
   if (reply_len && hdr->nlmsg_type == reply_type) {
     *reply_len = n;
     return 0;
   }
   if (n < sizeof(struct nlmsghdr) + sizeof(struct nlmsgerr))
     exit(1);
   if (hdr->nlmsg_type != NLMSG_ERROR)
     exit(1);
   return -((struct nlmsgerr*)(hdr + 1))->error;
}

static int netlink_send(struct nlmsg* nlmsg, int sock)
{
   return netlink_send_ext(nlmsg, sock, 0, NULL);
}

static int netlink_next_msg(struct nlmsg* nlmsg, unsigned int offset,
                             unsigned int total_len)
{
   struct nlmsghdr* hdr = (struct nlmsghdr*)(nlmsg->buf + offset);
   if (offset == total_len || offset + hdr->nlmsg_len > total_len)
     return -1;
   return hdr->nlmsg_len;
}

static void netlink_device_change(struct nlmsg* nlmsg, int sock,
                                   const char* name, bool up, const 
char* master,
                                   const void* mac, int macsize,
                                   const char* new_name)
{
   struct ifinfomsg hdr;
   memset(&hdr, 0, sizeof(hdr));
   if (up)
     hdr.ifi_flags = hdr.ifi_change = IFF_UP;
   hdr.ifi_index = if_nametoindex(name);
   netlink_init(nlmsg, RTM_NEWLINK, 0, &hdr, sizeof(hdr));
   if (new_name)
     netlink_attr(nlmsg, IFLA_IFNAME, new_name, strlen(new_name));
   if (master) {
     int ifindex = if_nametoindex(master);
     netlink_attr(nlmsg, IFLA_MASTER, &ifindex, sizeof(ifindex));
   }
   if (macsize)
     netlink_attr(nlmsg, IFLA_ADDRESS, mac, macsize);
   int err = netlink_send(nlmsg, sock);
   (void)err;
}

const int kInitNetNsFd = 239;

#define DEVLINK_FAMILY_NAME "devlink"

#define DEVLINK_CMD_PORT_GET 5
#define DEVLINK_CMD_RELOAD 37
#define DEVLINK_ATTR_BUS_NAME 1
#define DEVLINK_ATTR_DEV_NAME 2
#define DEVLINK_ATTR_NETDEV_NAME 7
#define DEVLINK_ATTR_NETNS_FD 138

static int netlink_devlink_id_get(struct nlmsg* nlmsg, int sock)
{
   struct genlmsghdr genlhdr;
   struct nlattr* attr;
   int err, n;
   uint16_t id = 0;
   memset(&genlhdr, 0, sizeof(genlhdr));
   genlhdr.cmd = CTRL_CMD_GETFAMILY;
   netlink_init(nlmsg, GENL_ID_CTRL, 0, &genlhdr, sizeof(genlhdr));
   netlink_attr(nlmsg, CTRL_ATTR_FAMILY_NAME, DEVLINK_FAMILY_NAME,
                strlen(DEVLINK_FAMILY_NAME) + 1);
   err = netlink_send_ext(nlmsg, sock, GENL_ID_CTRL, &n);
   if (err) {
     return -1;
   }
   attr = (struct nlattr*)(nlmsg->buf + NLMSG_HDRLEN +
                           NLMSG_ALIGN(sizeof(genlhdr)));
   for (; (char*)attr < nlmsg->buf + n;
        attr = (struct nlattr*)((char*)attr + NLMSG_ALIGN(attr->nla_len))) {
     if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
       id = *(uint16_t*)(attr + 1);
       break;
     }
   }
   if (!id) {
     return -1;
   }
   recv(sock, nlmsg->buf, sizeof(nlmsg->buf), 0); /* recv ack */
   return id;
}

static void netlink_devlink_netns_move(const char* bus_name,
                                        const char* dev_name, int netns_fd)
{
   struct genlmsghdr genlhdr;
   int sock;
   int id, err;
   sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
   if (sock == -1)
     exit(1);
   id = netlink_devlink_id_get(&nlmsg, sock);
   if (id == -1)
     goto error;
   memset(&genlhdr, 0, sizeof(genlhdr));
   genlhdr.cmd = DEVLINK_CMD_RELOAD;
   netlink_init(&nlmsg, id, 0, &genlhdr, sizeof(genlhdr));
   netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, 
strlen(bus_name) + 1);
   netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, 
strlen(dev_name) + 1);
   netlink_attr(&nlmsg, DEVLINK_ATTR_NETNS_FD, &netns_fd, sizeof(netns_fd));
   err = netlink_send(&nlmsg, sock);
   if (err) {
   }
error:
   close(sock);
}

static struct nlmsg nlmsg2;

static void initialize_devlink_ports(const char* bus_name, const char* 
dev_name,
                                      const char* netdev_prefix)
{
   struct genlmsghdr genlhdr;
   int len, total_len, id, err, offset;
   uint16_t netdev_index;
   int sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
   if (sock == -1)
     exit(1);
   int rtsock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
   if (rtsock == -1)
     exit(1);
   id = netlink_devlink_id_get(&nlmsg, sock);
   if (id == -1)
     goto error;
   memset(&genlhdr, 0, sizeof(genlhdr));
   genlhdr.cmd = DEVLINK_CMD_PORT_GET;
   netlink_init(&nlmsg, id, NLM_F_DUMP, &genlhdr, sizeof(genlhdr));
   netlink_attr(&nlmsg, DEVLINK_ATTR_BUS_NAME, bus_name, 
strlen(bus_name) + 1);
   netlink_attr(&nlmsg, DEVLINK_ATTR_DEV_NAME, dev_name, 
strlen(dev_name) + 1);
   err = netlink_send_ext(&nlmsg, sock, id, &total_len);
   if (err) {
     goto error;
   }
   offset = 0;
   netdev_index = 0;
   while ((len = netlink_next_msg(&nlmsg, offset, total_len)) != -1) {
     struct nlattr* attr = (struct nlattr*)(nlmsg.buf + offset + 
NLMSG_HDRLEN +
                                            NLMSG_ALIGN(sizeof(genlhdr)));
     for (; (char*)attr < nlmsg.buf + offset + len;
          attr = (struct nlattr*)((char*)attr + 
NLMSG_ALIGN(attr->nla_len))) {
       if (attr->nla_type == DEVLINK_ATTR_NETDEV_NAME) {
         char* port_name;
         char netdev_name[IFNAMSIZ];
         port_name = (char*)(attr + 1);
         snprintf(netdev_name, sizeof(netdev_name), "%s%d", netdev_prefix,
                  netdev_index);
         netlink_device_change(&nlmsg2, rtsock, port_name, true, 0, 0, 0,
                               netdev_name);
         break;
       }
     }
     offset += len;
     netdev_index++;
   }
error:
   close(rtsock);
   close(sock);
}

static void initialize_devlink_pci(void)
{
   int netns = open("/proc/self/ns/net", O_RDONLY);
   if (netns == -1)
     exit(1);
   int ret = setns(kInitNetNsFd, 0);
   if (ret == -1)
     exit(1);
   netlink_devlink_netns_move("pci", "0000:00:10.0", netns);
   ret = setns(netns, 0);
   if (ret == -1)
     exit(1);
   close(netns);
   initialize_devlink_ports("pci", "0000:00:10.0", "netpci");
}

uint64_t r[1] = {0xffffffffffffffff};

int main(void)
{
   syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
   intptr_t res = 0;
   res = syscall(__NR_socket, 0xaul, 0x80000000000001ul, 0x84ul);
   if (res != -1)
     r[0] = res;
   *(uint32_t*)0x20444ff8 = 0;
   *(uint32_t*)0x20444ffc = 7;
   syscall(__NR_setsockopt, r[0], 0x84ul, 0x76ul, 0x20444ff8ul, 8ul);
   *(uint16_t*)0x20cf6fe4 = 0xa;
   *(uint16_t*)0x20cf6fe6 = htobe16(0x4e23);
   *(uint32_t*)0x20cf6fe8 = htobe32(0);
   *(uint64_t*)0x20cf6fec = htobe64(0);
   *(uint64_t*)0x20cf6ff4 = htobe64(1);
   *(uint32_t*)0x20cf6ffc = 0;
   syscall(__NR_setsockopt, r[0], 0x84ul, 0x64ul, 0x20cf6fe4ul, 0x1cul);
   *(uint32_t*)0x20107ff8 = 0;
   *(uint32_t*)0x20107ffc = 0x10040000;
   syscall(__NR_setsockopt, r[0], 0x84ul, 0x75ul, 0x20107ff8ul, 8ul);
   *(uint16_t*)0x208c0000 = 0xa;
   *(uint16_t*)0x208c0002 = htobe16(0x4e23);
   *(uint32_t*)0x208c0004 = htobe32(0);
   *(uint64_t*)0x208c0008 = htobe64(0);
   *(uint64_t*)0x208c0010 = htobe64(1);
   *(uint32_t*)0x208c0018 = 0;
   syscall(__NR_connect, r[0], 0x208c0000ul, 0x1cul);
   *(uint32_t*)0x2081e000 = 0;
   *(uint16_t*)0x2081e004 = 0x3b;
   *(uint16_t*)0x2081e006 = 0x29;
   *(uint16_t*)0x2081e008 = 0;
   syscall(__NR_setsockopt, r[0], 0x84ul, 0x77ul, 0x2081e000ul, 0x2deul);
   return 0;
}


