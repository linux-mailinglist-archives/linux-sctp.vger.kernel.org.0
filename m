Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E370433F91
	for <lists+linux-sctp@lfdr.de>; Tue, 19 Oct 2021 22:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhJSUHv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 Oct 2021 16:07:51 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:15890 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229701AbhJSUHu (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 19 Oct 2021 16:07:50 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JJF4Ge016063;
        Tue, 19 Oct 2021 20:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qqN2FYtKkGpVu6fSc7kty/C1dSxt6otkNvuEX/QmIgw=;
 b=Mto7IGwpsDYXJqCq5UBWjeX57uYqXo/VukkGcNkaZIpSsgyKI9KcNi0ZkEWT62geNjLs
 8qCIONF5cSAkgcuhx+ZC8tYQce9RZMYOF2pVBNhWdHS1SkKS1OU3uNexdKiIdQPg7Fds
 1D26SNe38vjBTk8VQrCJTjC4Oki7MHPrqJNtBu+kVfRw3qBjBvNA3o8l7fBPKm/34a9K
 i5kXkTLUFPzFSdo7ZQvTweyMwW7XJZN2mOzwiX/kZtXGgQDs/sR5DKkk7kok+CPhL2mJ
 w0YR1KzkTx/PHBzJ2SUI7aybcaV2o/Pc9GKsQhokucEwg888+yPbVRQ2shPhrzPSkwCp Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsnjhvnff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:05:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JK5Wv3051418;
        Tue, 19 Oct 2021 20:05:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2042.outbound.protection.outlook.com [104.47.73.42])
        by userp3020.oracle.com with ESMTP id 3br8gsy72d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 20:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b94qRiLFzotzNzLEhUb4J1ij9rJCsArDk5/X3ArBYTLIsDESXO6B1mEi7vXtGruJBF52jHOiorvqLm+IjjWmPufrI9l1OQamZalSSvqWEtMluyRplFZBzI+bSKSCiIqgZ4jwnHhmzU2XQtFQRJakBx3oehpmT4OR2lM0B4o6gnTFWlA3It/2Xrnrzo3PF0ANOU41drqtcBuIb29heaP5l8ZEUsIEP0DoKnafOUV7MdPRsORtv470IH8HxOQtKeErq6TXtqilzZVz1+aVWuitVlfJv037OF9TAZrnC11LDIu4z6tqnezh7cL2bPvzbXLZsX7QJ/bcOurg23ba3UeZ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqN2FYtKkGpVu6fSc7kty/C1dSxt6otkNvuEX/QmIgw=;
 b=MdG9c9Jk9WPzMhEEaw38cU4NA0SFE6bPWwxRLQIAYS4Q9sOfL4HM8LNWKpCoGbkbzGRlLUWFlLS/ExT2Y6BpRI6iXzn3VsJu1XMZWthx0q5/U7T8ggsCtR8zG56JQ8f904X6dyOoiK/SVZEyuh8RiUhVRb93U8kK3OVIPdfTMW+HbfMzZ2Pshgg6QDtxyXOn/IaldvFyFpaW5EIw9BW6a0u9yQkIUd+fI0rYQh2EXYLI7S/TkYQc+BdOjlhwe8CPak1A4Lt7zTOoL0t0H+1+g1eqeNhmRhyghvMGGEHPXWmyzTswaEVz9WCQ2+j8jgaMn7PEbE2IrKzAa9Ad1PjBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqN2FYtKkGpVu6fSc7kty/C1dSxt6otkNvuEX/QmIgw=;
 b=lYuc88YKog/0QgjAuhmCUGFc/jhHv6QaAQXtOvuq18/di4ZZgEgGpnnHT8StS9fJQH+B0zS7a4+pFC8FtQpMcsgRxBhy/g4W8viH7SYDQPV1sUH4hmsmmXAWkR6nCjAkHvPOgyLBysIKSWjVJC5sKqBYNw0x7bS/3koGucGMshk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1504.namprd10.prod.outlook.com (2603:10b6:300:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 20:05:30 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 20:05:30 +0000
Message-ID: <bb302bd6-093b-2d21-801a-4f613ef39098@oracle.com>
Date:   Tue, 19 Oct 2021 15:05:24 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: syzkaller test panic: Linux 5.4.y
Content-Language: en-US
To:     mleitner@redhat.com
Cc:     linux-sctp@vger.kernel.org
References: <4f9d3a13-2104-ec1c-dbc7-12de1f99ea0e@oracle.com>
 <CALnP8ZZ7UbEzc0+VVpwucbBqNfgTqOk-LN8BwjbtL8-CbzOY6Q@mail.gmail.com>
From:   john.p.donnelly@oracle.com
In-Reply-To: <CALnP8ZZ7UbEzc0+VVpwucbBqNfgTqOk-LN8BwjbtL8-CbzOY6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::21) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [192.168.1.127] (47.220.27.44) by YT2PR01CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18 via Frontend Transport; Tue, 19 Oct 2021 20:05:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a51aad76-1086-4de0-3311-08d9933bcce6
X-MS-TrafficTypeDiagnostic: MWHPR10MB1504:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB15044399764E2675CC0B4F2AC7BD9@MWHPR10MB1504.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi6a/gl2Jy5l/nokXh8AGCqxrxh0HIVYvd3KhbdA2B7YnkitBqJtUV0uKxtJH0+fFgUvED9153HbCK0pYxaXqBueLQbnxx2Ednppl21XzhJqjAy/2ucrVvt6oGJNjGeI21SGRuGVw3WqaRHhBLmG4Okgssc7OIoUvfhgVZW6+mfCft9+6wpd+U9zigrozx9mG3v8u900c0QKUb5HVLyar52sB/pgci8LCx7JgdGfgHRt8OtM7v/m6+gLJx5Ok/wXulmHz9zWOGQQkqfZNcSPd/1nFv1oROA6x1YXnzaSsgsqRnFAX0m9LzJLKLYsWE+KoP5StzhX/sXiL8eO5OC5tvsfI7miy9jFeSdumuJkz6dPzzSCAgvPLvwTQmnqdBmyFSFMRynD7whVu5D9vV2hs9VtJO6bozkk0Bnxuro24bhLhwrXQhmxVJydZJh6h+AjDuC1b1/q+zNMprxx5SmWRhqYfs8ctrbLUy1fp6SmPLOGhkuky5ccBFPNAOQaDx/+OjMruB5vIcZYM4aGga89jk/nJGpoMGBUsYnLD9uLdZwu2PMnrujsT95o5EKF6PxfYXeD/3H60IqXI9l/OTul8OpLkTewQZyTI2kTUtZLTAtfBGYTDvn5k8F6siKHx1E02GbJi242nwmNUcQwCa39rZwrjh1IVFs4QOUJS5PPCWs4aU0oB8fzxCG8sWc65tVm4+dVHTRlvjaYDoUw/VeFgpPNbw1y4ANRAduql91u6Rj/TRxEhyRAxWGitqCUOvAYlax1qmNKWFacJYDkxKwEP7ZyAC4mC36Jw6JjcgQWqK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(8936002)(83380400001)(36756003)(4326008)(6666004)(31686004)(186003)(31696002)(16576012)(6916009)(316002)(66556008)(508600001)(86362001)(8676002)(9686003)(2616005)(53546011)(66476007)(38100700002)(66946007)(956004)(2906002)(26005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRlL0xmcnVmR0RNa1FSYTlXdStQUTFHdXdlMmpTeUxweEFiem1UdTEwNWQ0?=
 =?utf-8?B?ZnF0Q25Va3lUY3dqZy9nUzhHUzkxMGZIeUFwOS9qbndaZEZqK0V4cDZPTXM4?=
 =?utf-8?B?dDFYNGY5Wi9aWXBIMGdZT0hlRUNsdzlnMk1sTExyRTJTZlp0V1haNzhpekx1?=
 =?utf-8?B?Wk5OQjkrcnhITmRtYkNmVlJvNjNGWFVhNHJ4YWo3ZHY0WUtVaEJJUlFPZnZt?=
 =?utf-8?B?V01HYk5IZHVnNmpHVHRuWURxRUJheGY2MU9SbnVoY1JWSElzNzdqYTUxT2NM?=
 =?utf-8?B?RDErZmdqLyswNkFOQjJleS8vNjgyY2Mrb3NZbVlMbnEwOGR5K09vY1NISSt0?=
 =?utf-8?B?RFZKOFI0M2lsMWk1b3lOOVNZSGZKc25RNXk3My9STjBtOTAxOHFtQWsvOXJU?=
 =?utf-8?B?VFBvTG9pMWxuN1FLZ1hKUTZaSDRhZ05URHZWdk83U05sNVZZZEUvT0I3WTUr?=
 =?utf-8?B?SWVDL2ZVL2xqNXdyd05DSkVybDYvR09RUDVXMGxLZUQyWHJGL29kc2ZsbzR6?=
 =?utf-8?B?RUwwK2V4SnR6Y21RODNmMDFkU0l6NUpjZTVrTkRqa1piRktKUnkxYW1DbFps?=
 =?utf-8?B?T29EV3NOWTN2SktqdjZRS3NUMGVYR1FnV3JYenVSckRtTkc3dXorRDFyVjRE?=
 =?utf-8?B?MGZJQi9BSE9BeWx2NjNYcXNsTEdoWmZURjNJazFsYUNtVkVNRXkzVmZvVjhh?=
 =?utf-8?B?NnZ4cnhNc2tmVWFHOHBiRFU0ZkhIVC84QUtNcElicUFJMncwY2YzZlZyNHVO?=
 =?utf-8?B?YmxpbGFuWFlueUVITWlvdkJRcTUrVDJoWnh0SC9GQkVwVWY0alA5VXU2REds?=
 =?utf-8?B?cEtQazl0MFZqQnB5djRjRWhkR1BZZXV1d2NsU1ZBbTVkM2drTXUrSTFCUGZD?=
 =?utf-8?B?dFJLdUQwbWdYSFZJVVV1TERobDdWQ2xJT0wzWTRlODBqTTFmQXN0U3FzZGlY?=
 =?utf-8?B?MDY0SFFSOXpNVWRKNSsyZ2lXSXZ5ZWpiV2lrMFVhSXZlemlqYkhvRDZoTFlG?=
 =?utf-8?B?VUlsU2JOUGp6c2h1TzZoekt4dUE4TllMb3JCbEhDeEM4Q3Fvb0lYQWd4bDBX?=
 =?utf-8?B?aENvR3Y2R0kwYXF1TDFqd3pPR1U5TjFtZ3BNWmNRVjAxdHdSc25IZUJGRGNm?=
 =?utf-8?B?NW95citQN2d0VEZTWHF2NWxnSm9qdXBQN05TZ3oyTDFhcFRyOUxsVTNoa2Fa?=
 =?utf-8?B?VW9Ha1pBc29uaFViOXE4VkFOWnBKYmNFRkpjRnZoQjdOYTY1OVJxMjZ4eS9o?=
 =?utf-8?B?bHJ0UzlFN2FqM1ZxZlRkQjhLUFB5ZmdkRTdwWjg5cTlzR09zbE1adDgra2k5?=
 =?utf-8?B?WmY0djY2VkNPYmtnTFhiTUlGYW5oN0VMcGNBb2JYV1NVOHBnTnRiaWoyUmhV?=
 =?utf-8?B?bnBVU1RsYzVFaHRXNmRrdXQ4dXkwTXVSSmxZL01VOGZEcTVYSEJIY01WYTFl?=
 =?utf-8?B?V0ZmbytaVytPUWhGdjBYWXNRa2pjakE5aEZ6MXc0YzJsNGh2WlhmdmkrNkRj?=
 =?utf-8?B?UEZtVm1hNG0vZ0lrc1Z6czBhT292VloybDJoV3BUZ2Yvc0kzREpmTjdPaVNY?=
 =?utf-8?B?RS9UcVhkeTdXY1RrRmZpbStmTVExMUVqd245ZHVVUzVGMFpMSFNHR3pWalBC?=
 =?utf-8?B?NWFwRkxtZVpWZUtQaUkwQmVQTzZOeXFadEFVU210UUFjWitwVXZROHhhVHV5?=
 =?utf-8?B?TEpiYXRXMGxqOVIxLzNxeDV2aHFqRTd3SS8wWFFMZDRhOGVuU014R0Y5THh3?=
 =?utf-8?Q?NzdIDvEGe8w8jOE1BpF1CUKMEolGIqB/qSauiKK?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a51aad76-1086-4de0-3311-08d9933bcce6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 20:05:30.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lkSlyJiNFGUGGAMs09Z/3Fj6T9RiFjM1v8CwrzkMFTDzZd74wUnwvlg0PlPI5UA4Dy2z0sX75yQtjwpOsCQnRUz2fKc3KjJAYOLestieZ+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1504
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190116
X-Proofpoint-ORIG-GUID: BSjXx0Q5q0vyXhZgDwfxJJ1lCwafoa2G
X-Proofpoint-GUID: BSjXx0Q5q0vyXhZgDwfxJJ1lCwafoa2G
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 10/19/21 10:24 AM, mleitner@redhat.com wrote:
> Hi John,
> 
> On Mon, Oct 18, 2021 at 04:29:58PM -0500, john.p.donnelly@oracle.com wrote:
>>    Call Trace:
>>     skb_put+0x4c/0x4c
>>     sctp_addto_chunk+0x59/0xb0 [sctp]
>>     sctp_make_strreset_req+0x166/0x180 [sctp]
>>     sctp_send_reset_streams+0x14d/0x300 [sctp]
>>     sctp_setsockopt.part.21+0x101f/0x1720 [sctp]
>>     sctp_setsockopt+0x99/0xb0 [sctp]
>>     sock_common_setsockopt+0x1a/0x1c
>>     SyS_setsockopt+0x86/0xe6
>>     +0x79/0x1ae
>>     entry_SYSCALL_64_after_hwframe+0x151/0x0
>>   RIP: 0033:0x7f80bdc21be9
>>
>>
>> I am not familar with any of the sctp subsystem. It was found running the
>> syzkaller fuzzing test suite.
>>
>> If there is a more appropriate place to report this I can do that too. This
> 
> Here is fine :)
> 
>> test fails on just about every 4.x and 5.x kernel.  It is not
>> unique to 5.4.
> 
> Did the test kernels include commit "sctp: account stream padding
> length for reconf chunk"? It is a recent fix right on this topic. It
> should be fixed by it, actually.
> 
>    Marcelo
> 


Hi Marcelo

  I can confirm


commit a2d859e3fc97e79d907761550dbc03ff1b36479c
Author: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Date:   Wed Oct 13 17:27:29 2021 -0300

     sctp: account stream padding length for reconf chunk

resolves my panic for 5.4.LTS   wrt to

// autogenerated by syzkaller (https://github.com/google/syzkaller)
//  317ef02b0d5cbd19d445294fed91453c7f970fc3.c



Should be an easy enough fix to apply to older 4.x kernels too.

There is suppose to be a format to cc the syz-kaller bot to mark
317ef02b0d5cbd19d445294fed91453c7f970fc3 fixed with commit 
a2d859e3fc97e79d907761550dbc03ff1b36479c.

Perhaps mentioning it here will be enough ;-) .

Thanks for the quick follow up !

--


JD

Oracle Linux Team.









