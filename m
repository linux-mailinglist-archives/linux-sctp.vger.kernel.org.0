Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6965E4340B5
	for <lists+linux-sctp@lfdr.de>; Tue, 19 Oct 2021 23:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhJSVng (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 Oct 2021 17:43:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47444 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhJSVng (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 19 Oct 2021 17:43:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19JLSwaB024860;
        Tue, 19 Oct 2021 21:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+X7ohY2vkciRza9oHe8ZM6DTrYmMUYrok1zYpNAV5Kw=;
 b=lsAGLMvoDmbv/YwKjE25mW6V2utk4+b1hVM5/G6iaboD3JRgbD8+LUN7RAYcJQC9N7Eq
 3V//mN9tB8AFaY0rfcN3Rbm+1hSUc1dPIimEqxtU8ivzmRdL7uX32j2OiVyvuiu5vB5S
 eD2KxtcieRb5EOPOx/ofAntV65f+iGW82VjoXVwIFOZDT/yNHJpWQTfRGZ1P1ENOVO/H
 LIpuMuxSe2wncqvpmMUcPHTtoEGZmcPaET6I+yo6LyQbwMscWt0MRUAYR7JdEnaNaJV1
 hwZgR8UCwFqJlrVtcr9UIF2J8gwJLiT7xy1APcZuTMhQyw/Jfdr4C2lMAfbKPi1kPh7q eg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bsn7kngyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 21:41:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19JLUotT104555;
        Tue, 19 Oct 2021 21:41:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by aserp3030.oracle.com with ESMTP id 3bqmsff70v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Oct 2021 21:41:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkpK2GqFjiSMrLvFjpK9qyGNy0Fh/A4sfyQgVnsPUtdT7c6kiCc8ZyPVAkM6FHZPbk6dbkQ3wSS2WmqlRCCE5rqNF78UZgAe05twEb/XawzDcUB1dbjjAnDrYNu3eTX7PRWEokkHr+nyHAxxtqYIf7acZGZV/1Ar69KuARTulWo4xTubf5K5fmxwAow32oG6iWL+/Y8c6dgb/ttE7iMUl+bEnru36rn/NRuygBwsCI83BIHdwOGy31zvYdI3KtaabjAqhh7IMrVCgDGlgWyXK6IyVVMpEoyMmC3KCMkQWIsGmzDCyiFa/sLwG3H7kuXDKHp7F/AnPNmBnnO54M6V+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X7ohY2vkciRza9oHe8ZM6DTrYmMUYrok1zYpNAV5Kw=;
 b=aAKIwLTKVpN+D81bxv7P12jjs04qrDqZkjRzQxLXyl08TALtMRoeNCVctI5P630QHAbcJTKFlanL4URQjp5WOe2/As3SWeeaCKsD6eQZQWOo4Q4ih63KPzwtuNnJcUk1zJJfjPPSYbp7Vi5R8OJSvcOPQZLBmhVZ1bHdemVoXve9wihDsbeMP5xtTcKqs25To/dOMICicBV4XSGZSyQ9+3rKZl13mJlsYjLI50vXyojxgkNWWRbH56l1o9trdKS2PXe2uVxgOwkuxlXCqC9p4dF9E8BL3u0NedlymI3CUlf9pZuQ/oDmyMexQwSu5lAkOuRWJErV/eLyrJLj3uBHmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X7ohY2vkciRza9oHe8ZM6DTrYmMUYrok1zYpNAV5Kw=;
 b=uoRSTLLtP/Z83/i6e89RFXmAk7J9JPgnt0jzPXgL/nUGXWXhXgHZf8qcFfZaUSqB2GtwICiAUZ3QD0e4VllG190aLGk3WoGU/5pqkkvLuEiDcLAnPBpxD31lgbXQWCG/nvEgeANPKu0uosEBpSo5xjFBA2lJZVRAHtFNmuy7M98=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4722.namprd10.prod.outlook.com (2603:10b6:303:9e::12)
 by MWHPR10MB1712.namprd10.prod.outlook.com (2603:10b6:301:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 21:41:17 +0000
Received: from CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c]) by CO1PR10MB4722.namprd10.prod.outlook.com
 ([fe80::7cf4:cd06:bb8a:4f2c%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 21:41:17 +0000
Message-ID: <08e2502a-7feb-7e36-2f82-3a152da7925a@oracle.com>
Date:   Tue, 19 Oct 2021 16:41:07 -0500
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
X-ClientProxiedBy: LO4P123CA0301.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::18) To CO1PR10MB4722.namprd10.prod.outlook.com
 (2603:10b6:303:9e::12)
MIME-Version: 1.0
Received: from [10.175.26.179] (138.3.203.51) by LO4P123CA0301.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:196::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15 via Frontend Transport; Tue, 19 Oct 2021 21:41:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e6b5210-67c4-48f9-b5de-08d993492e91
X-MS-TrafficTypeDiagnostic: MWHPR10MB1712:
X-Microsoft-Antispam-PRVS: <MWHPR10MB17127572E563B63507FD7534C7BD9@MWHPR10MB1712.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwmXgMbHL7KovDqDBZ1LMtJzT2eWx5btDUQjy3sCMkJTpuGkWK+jQnnQrMunyX4sbBnfAI7fgGhm1jksBSOGzwae4y89dUldODZanO1poD7j1QEHhP4oB8JzH+tyTxB99x04DknG1nk4OjaDkb5mdLOL8afNW4Cf6b3oBIJJduD+8QjlkyngK9HUp1X8O02TD8etVcgmFsH/kJqymNWmO/u2/GrDCIbCNVfnEFVGRIPjo9Hy2783rCCJN/wrwzN4/dEbIoSkpXqmZQE6Ix/q4gEVfLFrNcAPTzzltb5S7NTjHvYaeHafnvskJwisM35uIdrBcBkq0p9Q+/UvrhVsECM6NcB0Hyj5TXzgxyqTBH0f/AswmH/WPKuAtptS1ys8mjeMbHd2TjWLLx1jzqNGKZbiGFjw44wg6XbPUYUi1Vuihu3YTvOecGjD8X38XgVludUZ2uAdCddbLJ+BdQO37jLvq+DrcpkgN58asTUEXXNWl7BmnKhuWjLJcXlGh+3IUoh4dUdCstnKqxt7HTIYC+zZ1FWfK+Kv8t27hubbEEiZns0df9JvpGa10g9BXw1oImndR2aNkXMtuN+UU19sQK3X5ttX6gh2eLsR46GtZpvg+l0w59e+ezhBx8YfoZOZonTLh8A5GPznebdSbBu2dxY4j3NJqFPtSIqi62W2IznE4P8DAvgnlbuqgy+/KnU33TJLjtZx9o4/+7w9iIVL8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4722.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(38100700002)(316002)(66946007)(66556008)(31686004)(6666004)(36756003)(16576012)(186003)(5660300002)(2906002)(956004)(2616005)(6486002)(6916009)(4326008)(508600001)(9686003)(31696002)(8676002)(4744005)(26005)(8936002)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0hKTWdRNE1KNFI2WkIxVjVsWEx2ZUN1aUIvUTV6dmMxQjJhSTlEMy9YNVRD?=
 =?utf-8?B?UjZYUEp0dmxzY0htY1BWNFNDbE44VnpJL2llZ3hmNWl6amdPblRHaG9mRDVB?=
 =?utf-8?B?MVl6S2lxbUc1VjRwUHN6KysvbEViMm9KZmJscDBDVFkzUVlhUWNTTGxaN1l5?=
 =?utf-8?B?QjRJa3orMXhnUEJjeGRpMFlyMHFCTmloR01hZGkvdGdyQmhKa2I1aUJNUTZD?=
 =?utf-8?B?VlJKbzFGWVZVT1k0dFdaS2NheWdibzdsVitwSWtWemRQWDZ3SjRBVlg1a21r?=
 =?utf-8?B?TE9SbWRBdkJPVDRsMndhRG9DQlFEMUQxTTNFUmFOMHNSWlRhTGZkZmpqT1lY?=
 =?utf-8?B?M01hbWRoRWJHQWZ2Vms2Ti85ZFlaUzRtWE5DS1VYRjNiRXA0cTEyY09zS0kw?=
 =?utf-8?B?RnkyL096Wjgya20reEd0UE81ejRNbTRJSEtaaWsrV2ZBUkw1Nk5VQzlFaUdh?=
 =?utf-8?B?cmpCbEpTUzhMRmFuNlVsT1NueWpldm5CSXFkaXorSXgraHdJdE9PL3U5MzM0?=
 =?utf-8?B?MWZnUk9VMDd4bnpacG9ia21wWk0rdU1wdHEvL3dJOEtJMWFlaUNJeEsxNzZD?=
 =?utf-8?B?Zzg4MVJKTXlLZTNhL2UwaHNNeUFjOE4yODZJUmVUb0xGQmNUekVyMVBpNmRY?=
 =?utf-8?B?cStJdk5naDd3NEJhMHZCWVFZMGozRTJwczRmUEZBcXJtV3pMTFJibVBDT3Q4?=
 =?utf-8?B?MUhJZHhoYmxpWERadU9ZMkFmQ1NZNmp2SGV3U1Z0TXROaXBIY1pnQm81OGJz?=
 =?utf-8?B?cnMva3VjTmNyMVIycDhUblk3eXZPR1dtSHFnSVc5aHRCdEl3WlJkMlFxYi9r?=
 =?utf-8?B?dVRLZDI4Y3F0R1RpdFRCUE4yWGZXT3RyM0kwWnZRa0dPS1lCY0h2OXBRRGhW?=
 =?utf-8?B?M0xnZ2hSL1h2dTVKenI5cnZaR1RSempSRkd4SVgvbGVPc0VPeTlaWGhVcU1U?=
 =?utf-8?B?cm5VM1lQQTBReDFZbzJjUEw0Y1Y5cWhKb1p3SW5BSGtDZ3F6QXBEN0RiZWw0?=
 =?utf-8?B?S1UrOExJbGtrMXF3amFzM0VkTi9uTWRWbUwvRzRrTHhDWjNxQ2E5WjR1SlJP?=
 =?utf-8?B?emFRaUNPRXpJL0V5bnl6Z095SU1qa2pQUXk4aXdveTZaZWQ1cFdRMndnTm5W?=
 =?utf-8?B?SFVaalhqL1pDdlZHeDRQKy9hcFl3RWtHNUtQd2RsVlNnRzNTSXowSEt6V1o0?=
 =?utf-8?B?UW1RSm1Nam5nN2FCQ3hGRzRQUFQrNzluMTNJTUZmaXpIUC9jUzdtSm0ySTFF?=
 =?utf-8?B?dVFTS2FGVkw2c0o5SnJXK2RaL1ZUY1JjSm5BenRPVmdCd0t1aEZoMHA2TVB5?=
 =?utf-8?B?VU5NdHhSYUlpOENxYWNqYjFlYlBzSzFwSEYwbGpsekNUbUV2NUxEdnM5L2dr?=
 =?utf-8?B?WTFhZGlpMXZTQ2g2bDJ4S1J0RUhRNDVwR3lqRzRkOTNOaSszWjRBWFBkaElm?=
 =?utf-8?B?MkFHYXlYL1o3SmtJQ0VOc2R1N0RTUEs4czY3ZXY2bHVHdWUxYTZNdDFrbXdo?=
 =?utf-8?B?ZHBBa2VmbmtHOFB5c25OV1k0bkw0ZVNLVHoyUFZZeDE5OXl0U0lrOUZDMlln?=
 =?utf-8?B?d25pcXhURU9DZ3JFKzJLNEowNE1XVkJGbXRyY09ZNVpmQitYSU5zdTBGT0Rr?=
 =?utf-8?B?TUR0bTFYTVJYdk9lMGhOM21hRVNnclV4Mm5QZEswcjU4N25CZUd6WUhwTndV?=
 =?utf-8?B?Yzc1Z1JWelp6Umg2WVNzVjI0dXlGTHNvWXFMYVcwUWFmWncyQXg5NUVoYWtG?=
 =?utf-8?Q?NMF8vKhHLP6fn/XuLsRO76VZC3eVoL5bNh1qXyX?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6b5210-67c4-48f9-b5de-08d993492e91
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4722.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:41:17.5451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LOo6eNccAmRlnans84z6GzuiO89C56aQpLI2mEDuQaSvCwHOvC63tay9gEyQNGKtAkG4NysKHWw/NeJpq7iHnt4Kkt2LazqV8yeXhdB0M6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1712
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10142 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110190124
X-Proofpoint-ORIG-GUID: MhnFDGBA4bqmEa1CND-EzJcp6qPa8w8F
X-Proofpoint-GUID: MhnFDGBA4bqmEa1CND-EzJcp6qPa8w8F
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org


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
> 
317ef02b0d5cbd19d445294fed91453c7f970fc3  ".c " is the test identifier.

It is the 1st thing people search for in a syzkaller bug-fix hunt ;-)


==

