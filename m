Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE79E434EC5
	for <lists+linux-sctp@lfdr.de>; Wed, 20 Oct 2021 17:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbhJTPPi (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 20 Oct 2021 11:15:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49206 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230366AbhJTPPh (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Wed, 20 Oct 2021 11:15:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19KExLn4028962;
        Wed, 20 Oct 2021 15:13:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Dvejjd3u7x84Z5ei55h6taU2NpDsLkBHCbLu3kKxrrY=;
 b=0QVZoS2JBX/NCY9+5Xl7BEdu54RxqeDRTaCoybqFRvJhpBfFYANeKtmIBOPN0iWrBq1p
 932s0eEhjvVu3PWMVOFUoQ48M/LQiacAy3zEnlpeYCFfBDDqCX/Ji2HbRKrZ3XU08Xcx
 urU8ZwW84DvVtESScFH/16dMDluUQ5HDt+zwSs+C1HqO00cOXDj79uvBB1nuY+PDlhp8
 TD5UOeUd+s8VggKwUu89hf4vJwEMPXKypjSBBXVJ98cQVBwdjF/TseOkyhSUdbVTS4ec
 m3LZx0zaZ2CLbxyya7KVlyQzaa7vjOryoH+o3jqNgYYbxnILxLYzr3tHYbv5rknkzHHT 5w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsrefhtb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 15:13:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19KF0raQ048147;
        Wed, 20 Oct 2021 15:13:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by aserp3030.oracle.com with ESMTP id 3bqmsgkn1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Oct 2021 15:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo2aANZFSvqhJs6dSo1bAR+NlBjaWHlSqC7/BQ/dtTsTJjc+tRuLab/OMX+TNSrHEsDaHyD04RjDU9Oaa8vgxaFKtnNB+Ihu5FF3fKgBDtaFH+7pkvytND8D2C4lcmsFGPGf+w7g9bAyPIu5EOxYu0ooPYFzHMxktI4ZF1NM8YU2onzNuErofjQTaqtG1rEqlLh5HeV+NLlOtdwFWJItxtpROSn9Y+3LKPvTIJGF73o2YtqQBiC+EPr9tteCyqkwq/1CSMOptnYOVP+bU6ZSBuIpW3okCrbWPxR5SwJN26/PS4v9t0AGM7fVyIF1tWb66KZ2o/WK1X9ZgH4J63S6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvejjd3u7x84Z5ei55h6taU2NpDsLkBHCbLu3kKxrrY=;
 b=I3HnZFZv7vfdtkMrKW7rxIxsXq+MySWypzkLQMOwlcL/dODw1M7xLixhiZx1r3dI4H2dVfNa2qsZLpre0X1oDKiaH//kYeMDT63mXwlOR2jqg0g+Jtj8Qs4DRJPSmzhjx1RPdhm4tsCjY7wqQ40IRdUpa/u+SdbOF8i74MQ/xBYskfyxWSDVyUA7FRPAbIqoblYIFyhPp4QxD6Ugi7sAVrmgOGDlRiv5sxS4fV6dn6Ly0Q27yPUs27k20x1HDA9NEMYXOlFQDEPSqy7gkHNFMDfZZ//pMLpaApZQul9gKkLNxsEAAyTjAG3OslQrDZgK1yOUsvWPdKQBM0XOBMGvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvejjd3u7x84Z5ei55h6taU2NpDsLkBHCbLu3kKxrrY=;
 b=Q1os9djtmmOhEgQJ6Hmref/vXEeK4fKvmtnEbpgU226ErT2m0V4rNqJhnRYh4Xqn51jMlE6Y/Uf9SVHfPv9oFTQKljFKvWFBBOo76cLCR/CnrCQzrNYb8Wsj5eAAcn38n58P+tHkVuET16N/QIowXwTs6gbnifboNfzGeJW8WyA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by CO1PR10MB4482.namprd10.prod.outlook.com (2603:10b6:303:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Wed, 20 Oct
 2021 15:13:16 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 15:13:16 +0000
Message-ID: <9ff56a7b-9677-5692-33cc-3896c29250d6@oracle.com>
Date:   Wed, 20 Oct 2021 10:12:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: syzkaller test panic: Linux 5.4.y
Content-Language: en-US
To:     Marcelo Ricardo Leitner <mleitner@redhat.com>
Cc:     linux-sctp@vger.kernel.org,
        Eiichi Tsukata <eiichi.tsukata@nutanix.com>
References: <4f9d3a13-2104-ec1c-dbc7-12de1f99ea0e@oracle.com>
 <CALnP8ZZ7UbEzc0+VVpwucbBqNfgTqOk-LN8BwjbtL8-CbzOY6Q@mail.gmail.com>
 <bb302bd6-093b-2d21-801a-4f613ef39098@oracle.com>
 <CALnP8Zbc2oxPc8qL-yYqD0a-9eoaLHn0K802kTVjL7igq_SbFw@mail.gmail.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <CALnP8Zbc2oxPc8qL-yYqD0a-9eoaLHn0K802kTVjL7igq_SbFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [10.175.6.191] (138.3.203.63) by SI2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.4 via Frontend Transport; Wed, 20 Oct 2021 15:13:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba9e0b1f-fbff-4e15-1ab9-08d993dc2462
X-MS-TrafficTypeDiagnostic: CO1PR10MB4482:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4482A1344FA43365DF432133C7BE9@CO1PR10MB4482.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1A8W9AUvmtcfw0Y9OTCWZdM614c46988nY0AjBSemI8k8JY1IZYLZ3Qj/Mxo8hrC5BqPhmfXVjPZyEfBIZoe2R3ny2wk0NEsCeUJg0ps6ta1/USm/BSFGGoCWCtRS86grfCIdpCvrv7yo6218rWSeO9jObzNNhnqQYuboMa+jEJrJQP6Dm+jlPjnen89k7Bf1Zc/BXX/A8LQjWLuNa5lA6aZjWH4Yn94AcJXwUuXoVQY77m+6GrwPtLtpsjH5YpBqVoXiUliRN6xnD/h2F2y3FRWeWSgNRJLHaH+Rlt6b/9O4QubiPFDNmU0NtcCoSfJZUbdhZ9UHkxZkwZX6B1r/0ELI0JdjBjKjW5HhRMoQiL5umSukN+gl6EDhhS6t/GBnMXkD2jprBI0l6DGhRwJWnunYYpyPfP5qmjQ8Xtqtca76EGiQZA7c/yRPZPMVbkxjwv1zwCdyvO7sERCd/dQMMen4zO7CaaURIHeGHo+HtYyVifGHxADiTcSbi14WVwYuFQm3iVfJwd6Aq9stiLafjzqMc6igPVm+tG4POyJlPBR7PdZ9e0s13hsaZeR9h+WPRMMci5j2d6HPD8CxEgIXa2jnr1DUZd94kKBDvoGe421nb4PNwNlkdB0+HlHH4rEcDVr20Wd1blvEOlNpmCfcyDgdEI7Cfu2blvfbdgji87R0bvnnLrTWwM0lt7ATVufVHcyrgSqkZSoi4t1A/ut+EB2G/e347+2N79RYtAYLdj8UMS4PN+4oZkdY+/LRzzKbs63bc1sRIVp9PoyUrKvjG8f8SmZCzWT++a3t9qFRyS/d7haJT5BJaeMka40Hqa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(9686003)(966005)(66556008)(16576012)(6916009)(86362001)(508600001)(316002)(66476007)(36756003)(6486002)(186003)(66946007)(8676002)(83380400001)(31686004)(956004)(2616005)(53546011)(31696002)(2906002)(26005)(5660300002)(38100700002)(6666004)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUU0NElnNVByY2FNOGNLMVBVeDFVZmJQSGpDQUlTMTB2SnVFbkQxdSszTWF0?=
 =?utf-8?B?cjk4eFh6OGU2VEFpVnRXdnhrWFdENndVN0doN2VNaGNPWjE1cUdqc2VqZEQ3?=
 =?utf-8?B?V1U3bjdaTTRoSUdFa1FSVk1qSVI2VEVFN05TU0o5alRhN0FVb0ZlZ3dlZmZO?=
 =?utf-8?B?SVhON05ISTNvWVZvSnN2dUJMNVhvSWFuM1pLbG9NaUt0ZXpONHkzbGQ1QTZm?=
 =?utf-8?B?N1B0eHFZREZxMlRmRXZoQW9ZQ2N5NHRWZEl5V0JORHNGUW9jUFVEeFR1SHp4?=
 =?utf-8?B?L3FaNmJxQjk0TFVOcHJTTElzRHVWa2ZWSldLMWVuVlVDcWxpSWtSTUI0ZnA4?=
 =?utf-8?B?SVlDRGxxVjFZem1OUWN0bW5Lb1JTWEtoNmE0dzNDR2duVnBFMTFxSG1OcDFZ?=
 =?utf-8?B?eXVNb2RDVmVjaXlDOURMRnQxaU1Xa0d2ZEZ0T3QybTZmc3VpaEFuS0F5dFdP?=
 =?utf-8?B?NnRaQkhJcE5ldURYNVZMRFVtbFJDTDZZU3RDZlo3YzVOWWVOM0FHK0QxOHJO?=
 =?utf-8?B?UHJrV3VBUjV5TlRiQVY1S2sxUndOcW1GRWRGTjB0ak82MjVLdk4xV3EySStG?=
 =?utf-8?B?aExaeXRSM043Z0NlVDk3U0puL2dRSWpvOEVyaGpuWTJFQ2hQczVQaDh0VEk2?=
 =?utf-8?B?Z05aNDZycUJKc2ZWNklyaDVSUWVlSlREKzVOYnNQc2NPblJvcjMxU1d6bGVW?=
 =?utf-8?B?QStYTytPWnFhblVibG5wTXNRNFhMUkhyYUNZKzdLc09YYS9kR3dHaUpFc2ph?=
 =?utf-8?B?cGJDR3NuOGhDMTJ4MXVvNTE2SU16bUt3NGYvY3k2VEx1dU03Z2FaU0xucFJt?=
 =?utf-8?B?bVZwNnRMVjFreVhpNlROeitsYUNSYTloUE9Pd2QxRXRUT2t5eVdtSGNWMyt6?=
 =?utf-8?B?Vk1WRFFXM3hBMmcvY1JJOHBzcW1rMVlJRFgxbkJnajZ5YnltWTVPQ1dLWkxD?=
 =?utf-8?B?c2JEdmVqaEVjUUdDSS9YRnlmblJJTnNSOVhyU0RHY29yWTlGRG5oVE1abktN?=
 =?utf-8?B?bk5FU2VOOVQ2WFNhMkc2MWU3blhkNUNrMmtGR0RlV0JINkFFUWQycDJ2cmM5?=
 =?utf-8?B?MkZBVHJQT2FNWDdmUnBKOGxYbEgzMW5xeCtmWjJ5UysreUU0QTZXRTJtY3cw?=
 =?utf-8?B?NEUrNG9ORi9SendyVjd2NVZCZXNLbFBIUjhoUWJDK1FON1JpWHlXSGZOWkdj?=
 =?utf-8?B?aEVJeHNpd1VWSGdibXlJL0RZMGI5UWFXWm1iTDhMVHJRWEw4aVVTSUNjbFF3?=
 =?utf-8?B?M0lIdVplOXNtY2ZVdTh3NzNhaUQwdGR6QW5IUmhnSjNtNnhKcEhsbUh5dEpj?=
 =?utf-8?B?S09Gbm5lcG1uU2NiY1V1Y3RsYlMvaUNFQ1ZXYis3bkdDdWZHV2owYnhTaXZY?=
 =?utf-8?B?LzNEZHk5QzNaK0gzcVhUZE5nMG5VM09helVzOVBaQVN4YllMWlhUUWNJWEtu?=
 =?utf-8?B?M1ZiMUVqNDhvakVHaVFqOTgxVEVXYlk1STdScWlLTUg4ckp6U0M5MjZLaXdT?=
 =?utf-8?B?SXBTVGVjcXRGTkk5bkdEeGhKdVJBWTl5OVBwWkVRY2VJTnM2cW83REhpbk9I?=
 =?utf-8?B?M1lhL0thOXdBMWZKM1hsOUVhVkZXdVQwQlE1NXNxMEVzOUsrZWxiRVlXUGpP?=
 =?utf-8?B?Ryt3MkJBcGtrU1VJRERzUDZJYUx2SnM2NVZjMnFHcHR6QUFlcm5WbnJPdGtX?=
 =?utf-8?B?K25BR3JNYVBYRUtZSkh2N1AxTVdOYjhRRnRYM3BISzZlMGMvZXBWSWU1ckNT?=
 =?utf-8?Q?dvLnbxpCuIA2quYr9nC7AaMq8pHLfOxEiumwji+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9e0b1f-fbff-4e15-1ab9-08d993dc2462
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 15:13:16.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: john.p.donnelly@oracle.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10143 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110200088
X-Proofpoint-GUID: ckyJSDjGHzpoLfDa4OAEHRMly4hC6Nnb
X-Proofpoint-ORIG-GUID: ckyJSDjGHzpoLfDa4OAEHRMly4hC6Nnb
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 10/19/21 4:35 PM, Marcelo Ricardo Leitner wrote:
> On Tue, Oct 19, 2021 at 03:05:24PM -0500, john.p.donnelly@oracle.com wrote:
>> On 10/19/21 10:24 AM, mleitner@redhat.com wrote:
>>> Hi John,
>>>
>>> On Mon, Oct 18, 2021 at 04:29:58PM -0500, john.p.donnelly@oracle.com wrote:
>>>>     Call Trace:
>>>>      skb_put+0x4c/0x4c
>>>>      sctp_addto_chunk+0x59/0xb0 [sctp]
>>>>      sctp_make_strreset_req+0x166/0x180 [sctp]
>>>>      sctp_send_reset_streams+0x14d/0x300 [sctp]
>>>>      sctp_setsockopt.part.21+0x101f/0x1720 [sctp]
>>>>      sctp_setsockopt+0x99/0xb0 [sctp]
>>>>      sock_common_setsockopt+0x1a/0x1c
>>>>      SyS_setsockopt+0x86/0xe6
>>>>      +0x79/0x1ae
>>>>      entry_SYSCALL_64_after_hwframe+0x151/0x0
>>>>    RIP: 0033:0x7f80bdc21be9
>>>>
>>>>
>>>> I am not familar with any of the sctp subsystem. It was found running the
>>>> syzkaller fuzzing test suite.
>>>>
>>>> If there is a more appropriate place to report this I can do that too. This
>>>
>>> Here is fine :)
>>>
>>>> test fails on just about every 4.x and 5.x kernel.  It is not
>>>> unique to 5.4.
>>>
>>> Did the test kernels include commit "sctp: account stream padding
>>> length for reconf chunk"? It is a recent fix right on this topic. It
>>> should be fixed by it, actually.
>>>
>>>     Marcelo
>>>
>>
>>
>> Hi Marcelo
>>
>>   I can confirm
>>
>>
>> commit a2d859e3fc97e79d907761550dbc03ff1b36479c
>> Author: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
>> Date:   Wed Oct 13 17:27:29 2021 -0300
>>
>>      sctp: account stream padding length for reconf chunk
>>
>> resolves my panic for 5.4.LTS   wrt to
>>
>> // autogenerated by syzkaller (https://urldefense.com/v3/__https://github.com/google/syzkaller__;!!ACWV5N9M2RV99hQ!bYZk3duFK90mfRvslAzHqUwzeJ2ngHYB0GMAZN3BITINKgzfZfAd5w8W5_OXRmoc_wDB$ )
>> //  317ef02b0d5cbd19d445294fed91453c7f970fc3.c
>>
> 
> Sweet!
> 
>>
>>
>> Should be an easy enough fix to apply to older 4.x kernels too.
> 
> Right. It's currently scheduled for:
>   812   C out 18 Greg Kroah-Hart (1,7K) [PATCH 4.14 26/39] sctp:
> account stream padding length for re
>   813   C out 18 Greg Kroah-Hart (1,7K) [PATCH 4.19 33/50] sctp:
> account stream padding length for re
>   814   C out 18 Greg Kroah-Hart (1,7K) [PATCH 5.4 45/69] sctp: account
> stream padding length for rec
>   815   C out 18 Greg Kroah-Hart (1,7K) [PATCH 5.10 068/103] sctp:
> account stream padding length for
>   817   C out 18 Greg Kroah-Hart (1,7K) [PATCH 5.14 098/151] sctp:
> account stream padding length for
> 
>>
>> There is suppose to be a format to cc the syz-kaller bot to mark
>> 317ef02b0d5cbd19d445294fed91453c7f970fc3 fixed with commit
>> a2d859e3fc97e79d907761550dbc03ff1b36479c.
>>
>> Perhaps mentioning it here will be enough ;-) .
> 
> Almost :-)
> 
> The report I previously had for this issue didn't come from syzkaller.
> I'm not sure if 317ef02 above refers to the Google's instance of what.
> Anyway, would mind marking it as fixed then?
> 
> Thanks!
> Marcelo
> 

Hi Marcelo,

I posted this fix to syzkaller  google group list :

https://groups.google.com/g/syzkaller-bugs/c/8fwxxnZxy4s

Since you fixing it in so many LTS threads I suspect it is covered  for 
the most part.

Thank you && all the best !

JD

...





