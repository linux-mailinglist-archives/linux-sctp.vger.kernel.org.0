Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC96B2D34C2
	for <lists+linux-sctp@lfdr.de>; Tue,  8 Dec 2020 22:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbgLHVAq (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 8 Dec 2020 16:00:46 -0500
Received: from mail-eopbgr30119.outbound.protection.outlook.com ([40.107.3.119]:56478
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729591AbgLHVAq (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 8 Dec 2020 16:00:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKcSZTPIwtPomW5aS/L17opVShKkrcfKgZF8ayCy9uktTO1EgBtnui5QxM3iMAz/U6pZzj316+LCLBHp2lj+biPCkssQC9xt90wSgdvTDm5QH3ZapNwaDb8dE6eNy/uRRoQEkxy3gWTsAbwNxKSLFyd9z4rW/aCX/w9fPuR/ub70oh3cIp1ikG0/JAydg6d4Yqq+e5qWR7xR+ipMLC/9HmM2b+DATMRlsSGfnzYGr2h+8sQmwYsvXix7G7Bv1hbrfKKXmsmbu5xoFRRgpbmlikDr1GTPXqaW64JZKBlkpJ3P0yJxNPVuafLwkMpEZmc4/pvl6MP8VMm/YcUSqtOc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gCoI/QexWJXmpHYELTe+er7iPAiodojcadEil5Itoo=;
 b=lCU3KrLI4wAZWjPJruydapF+kmT/pQn2c0CYKRGMCjMN/lJqcdSvNNIM5+d10GaUV8ox1F6fBKoJ+MV28jRBYqIwzO+EtaQGO1FbxgQHNFW012kAst2jOe+S1dNMhGNNoumtOyawLjjvmZteWpaEp38qEHo3kUFdg5Hap5l5B3lEGnOqATrlvSUoG5O8MtW9A+sjncPPjhTZDtJnoRsLajHEIw3iUfj983juFxWmhn1OJBkSHMb8yq5gXNBCSertXvdCvOzsKyEPzrX6Gzmh6Vemewj4gsVL1vJ8wnawnuiaX1udzeeczBDl2b25Mi5eWNkRCFZZXumQFAiglrcQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gCoI/QexWJXmpHYELTe+er7iPAiodojcadEil5Itoo=;
 b=pDLWKEXHi1GigtEuRkwLssFN22QV6M0CaDXh1onKittUxaUbzEBb7EH56EZHPRqLd5JQCvOnNr/z8DP+a9lpT2fsXY/1iNcuYbtFBQ69+676zD2Sa10e/clVlQJ2SOKxpaOuwwTXhFqHDL4aB444c8P12bkeD3e77VrokVpZ50c=
Authentication-Results: malat.biz; dkim=none (message not signed)
 header.d=none;malat.biz; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB6003.eurprd07.prod.outlook.com (2603:10a6:208:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.9; Tue, 8 Dec
 2020 20:59:55 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::d527:e75b:546c:a85b]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::d527:e75b:546c:a85b%6]) with mapi id 15.20.3654.009; Tue, 8 Dec 2020
 20:59:55 +0000
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Subject: Race of sctp_assoc_control_transport() against sctp_assoc_rm_peer() ?
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Petr Malat <oss@malat.biz>
Message-ID: <86d2a00b-7fba-a539-b1bf-5bacf0443542@nokia.com>
Date:   Tue, 8 Dec 2020 21:59:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.228.32.167]
X-ClientProxiedBy: AM0PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:208:1::15) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.167) by AM0PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:208:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 20:59:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2b1d2d1d-2df3-4d7b-ffd6-08d89bbc36ef
X-MS-TrafficTypeDiagnostic: AM0PR07MB6003:
X-Microsoft-Antispam-PRVS: <AM0PR07MB60039862712769F8152ABC0388CD0@AM0PR07MB6003.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HOyTDPlnNfDoNpmf8eO5iZEYFodw8yKOAbRp35UAZ2L9KMQKO+D74UIYn3sbFQtCt7DbkaAJcMUTHtRrqbNl8SqOh6jECun6qNEyVgv/k2Ja5y3WgByhuv9IsIEVR54eQwyUbhvClQmRUrUIkHRERWw8ZMQhXCKRWZo1Hsi/ntca6Gha3dgWK/ZuMXQE5And4GcGCQaiOq/UaVooGQkhSDAjvYhBrN5iWEp0mIgEHtqEPRIEf1JlYNk+4din2nrC4M9+cqkHCWnW2PUVPPvBTBZhSIsZ/sYE1r2laQCA9px1K6i9+w6cRWiNjJWYvr/z++3IaOu7goVhQ9Yj2Fz2046k/hPm+09zujkTMN45xvvTRPqlp9XUOf+rfFKE9ucvcum5YCeCIOgwnAq2Q+6lkzI06cq+Pn0wNY+YE47UsNPeXUvtqNQ2HvY9eVe8+NQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(6486002)(6666004)(52116002)(31696002)(66556008)(6506007)(66476007)(186003)(16526019)(4326008)(26005)(44832011)(6916009)(36756003)(508600001)(34490700003)(8936002)(31686004)(66946007)(2616005)(86362001)(6512007)(83380400001)(8676002)(5660300002)(54906003)(956004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VTErR0dFRVdDSUp0bmkvNHQxKy9kTTJsN0d3bVA3b1RveGlOdzF2dzBsa0ZK?=
 =?utf-8?B?eTBEY3p4dGdyRnRHWXJXZm9YTnEyRTN0OW9FRXV5OFhCUlJDT1RtZUU0WU93?=
 =?utf-8?B?NEVIUDJwTU5PK1gra3ZJTm5Ga0E2MmF6OHZTaEpHZm9Pb1VMQmlTaDd3amtv?=
 =?utf-8?B?WFZBMEZQK1NveHg1VndXZ0o2cE9KNTE2NVROdS8yL3RIYkM0cERoMjBlcnc5?=
 =?utf-8?B?QWNHK2NuU05CdzJjK3dSMEc4VExKdjRTdWp0R2xSNThDR0s0b0pqNnZvZFNm?=
 =?utf-8?B?My9jMnRPK3p3VzhyNTZ5Uml1NStBcG1RV29QMlhFTW5RQlFaNjJNLzluV0p6?=
 =?utf-8?B?TXNmTk53SFYvRlV5aEhLa1N1RlBBSXloeUpuVkxmYU9JQUxaRGdpSHpWQ3dO?=
 =?utf-8?B?b3FMaTVrUDkyWDV5bXlERHU3a0JRa2tYMmRadXZwTHRjQUcwbUErNFFmMy9S?=
 =?utf-8?B?NEtrRUIzdlhVbTV6aWJMZjF5RlJ6aUdXSWlLaGtUbitjRXVWSEVZbTJ5Rm9T?=
 =?utf-8?B?ajBOVFZXMTZCcnBtU2R4dnYrREVLazRWUHZMaFR3OXRESi8rR1l0N0hPRS9P?=
 =?utf-8?B?Rk5sTGhUVVE4ejFjOFVFRlZFajh6SkdOZFdQaHdlMUtrSnBJU2lXMjVTQVRh?=
 =?utf-8?B?SjFweEMyRlB1ejRlY0IrSStqbUgydHVCV1pVNHNaUm5JcDhpSisyQWlZRzIz?=
 =?utf-8?B?RkJ3ekNXQTJwSWpHRDdyMjdaUE9KM1R3OVBhYkkybUEzMzdseGYvbnFZeGpN?=
 =?utf-8?B?cCtkRjl5Q3hoU0paRGdLWWRLZ2ZJMWtBM21SZmw5OG9kUHh5a3c4YkZDTUhi?=
 =?utf-8?B?c3ZHYTlmRVZKcXk5NHc3eW5VeVB6a2k1RDY2dk83SytKbXhXQS92elQwZWhL?=
 =?utf-8?B?Y2JtY2pxa1B2bkkreTBId25sTk45K2RObEp2R3owZnkvR2IxL0NSdys4RERm?=
 =?utf-8?B?aFZ6WWlUY1pWNzBOc0pNQWxON3kxak4wc1ZQODRVNWt3QVB2R2Y5VEV2bk9x?=
 =?utf-8?B?ZVIzTHpmM0dGTCt3ZmxrZlR0MjQrM3VxTDB3eEZhOVcySUR2NzFBRXRzYVQr?=
 =?utf-8?B?WnRWNC8vd2JxMXdjblRCcEgvdW05aUxYdE5PQ2lTdDJWZHI5ZkdRdUxLN3dT?=
 =?utf-8?B?VEQ0aUxIRlJXTFIzMEVBZm12azZFUU1ROXBZdU5iUlBpeU5RYkVubEFKT1Vw?=
 =?utf-8?B?Yy91SEpzV083Tmw4RmtUd1g2T21TUlRiRDVORnRBaUMwOXFXVTBZbktSeWxQ?=
 =?utf-8?B?aUlhK21jTnYvNlFLV2pxR1FsNFR0NFdhMDErUmVsNS8rWE1YRVJzZlRFN09O?=
 =?utf-8?Q?TVtAD8mQ7H3ZT4VKs5W+zgA8/LtTMquV7t?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 20:59:54.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1d2d1d-2df3-4d7b-ffd6-08d89bbc36ef
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V5nAgLvakl8cOz9PP1UbSH1+nBTY6X4R/WhbUiWP7JRxfEdRxnuBxeXpp0486wZzB+DSPH8mQ9Mhr+iS8ImFHhDUtCBf+eklkGM9clVOK/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6003
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello!

I'm trying to understand the crash we experience with Linux v4.19
(sorry for the ancient codebase, but actually the affected code is largely
unchanged up to now).

This is hard but reproducible:

general protection fault: 0000 [#1] PREEMPT SMP NOPTI
CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O      4.19.155-g...
...
RIP: 0010:sctp_assoc_control_transport+0x1db/0x290 [sctp]
Code: 01 00 00 00 00 00 00 bd 01 00 00 00 31 c0 48 89 e7 b9 10 00 00 00 f3 48 ab 48 8b 86 a8 00 00 00 48 89 e7 48 81 c6 88 00 00 00 <48> 63 90 bc 00 00 00 e8 29 61 2b e1 31 d2 41 b9 20 00 48 00 41 89
RSP: 0018:ffff88846fc43ba8 EFLAGS: 00010286
RAX: 7070682e72656d69 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff8882984b3888 RDI: ffff88846fc43ba8
RBP: 0000000000000001 R08: 0000000000022e80 R09: ffff88846fc43cd8
R10: ffffffffa0562cf0 R11: 0000000000000007 R12: 0000000000000000
R13: ffff88846fc43cd8 R14: ffff8881bd588000 R15: ffff88846fc43e18
FS:  0000000000000000(0000) GS:ffff88846fc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000024b3160 CR3: 000000000320a006 CR4: 00000000003607e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 sctp_do_8_2_transport_strike.isra.10+0xd3/0x1a0 [sctp]
 ? sctp_oname+0x20/0x20 [sctp]
 sctp_do_sm+0x15fb/0x1d00 [sctp]
 ? try_to_wake_up+0x226/0x4b0
 ? __update_load_avg_se+0x219/0x2c0
 ? enqueue_entity+0xc4/0x850
 ? enqueue_entity+0x17f/0x850
 ? enqueue_task_fair+0xe5/0x950
 ? __update_load_avg_cfs_rq+0x1e2/0x280
 ? resched_curr+0x20/0xd0
 ? check_preempt_curr+0x4e/0x90
 ? ttwu_do_wakeup.isra.21+0x19/0x170
 sctp_generate_timeout_event+0xa8/0xf0 [sctp]
 ? sctp_generate_t4_rto_event+0x20/0x20 [sctp]
 ? sctp_generate_t4_rto_event+0x20/0x20 [sctp]
 call_timer_fn+0x32/0x170
 expire_timers+0x9d/0x110
 run_timer_softirq+0x8a/0x160
 ? __hrtimer_run_queues+0x156/0x2e0
 __do_softirq+0xaf/0x33e
 irq_exit+0xbf/0xe0
 smp_apic_timer_interrupt+0x7d/0x170
 apic_timer_interrupt+0xf/0x20
 </IRQ>

The exploding code in sctp_assoc_control_transport() is:

        /* Generate and send a SCTP_PEER_ADDR_CHANGE notification                                                                                                                                                  
         * to the user.                                                                                                                                                                                            
         */                                                                                                                                                                                                        
        if (ulp_notify) {                                                                                                                                                                                          
                memset(&addr, 0, sizeof(struct sockaddr_storage));                                                                                                                                                 
                memcpy(&addr, &transport->ipaddr,                                                                                                                                                                  
                       transport->af_specific->sockaddr_len);                                                                                                                                                      
 
where "transport" pointer seems to be freed and re-used, so the dereference
to obtain "af_specific" leads to the dump above. This memset/memcpy pair
has been factored out into sctp_ulpevent_notify_peer_addr_change(), but
this most probably doesn't solve the problem.

According to the stack above, the race seems to be between this code:

enum sctp_disposition sctp_sf_t4_timer_expire(                                                                                                                                                                     
                                        struct net *net,                                                                                                                                                           
                                        const struct sctp_endpoint *ep,                                                                                                                                            
                                        const struct sctp_association *asoc,                                                                                                                                       
                                        const union sctp_subtype type,                                                                                                                                             
                                        void *arg,                                                                                                                                                                 
                                        struct sctp_cmd_seq *commands)                                                                                                                                             
{                                                                                                                                                                                                                  
        struct sctp_chunk *chunk = asoc->addip_last_asconf;                                                                                                                                                        
        struct sctp_transport *transport = chunk->transport;                                                                                                                                                       
                                                                                                                                                                                                                   
        SCTP_INC_STATS(net, SCTP_MIB_T4_RTO_EXPIREDS);                                                                                                                                                             
                                                                                                                                                                                                                   
        /* ADDIP 4.1 B1) Increment the error counters and perform path failure                                                                                                                                     
         * detection on the appropriate destination address as defined in                                                                                                                                          
         * RFC2960 [5] section 8.1 and 8.2.                                                                                                                                                                        
         */                                                                                                                                                                                                        
        if (transport)                                                                                                                                                                                             
                sctp_add_cmd_sf(commands, SCTP_CMD_STRIKE,                                                                                                                                                         
                                SCTP_TRANSPORT(transport));                                                                                                                                                        


and

void sctp_assoc_rm_peer(struct sctp_association *asoc,                                                                                                                                                             
                        struct sctp_transport *peer)                                                                                                                                                               
{                                                                                                                                                                                                                  
...
        /* If we remove the transport an ASCONF was last sent to, set it to                                                                                                                                        
         * NULL.                                                                                                                                                                                                   
         */                                                                                                                                                                                                        
        if (asoc->addip_last_asconf &&                                                                                                                                                                             
            asoc->addip_last_asconf->transport == peer)                                                                                                                                                            
                asoc->addip_last_asconf->transport = NULL;                                                                                                                                                         
                                                                                                                                                                                                                   
...
        asoc->peer.transport_count--;                                                                                                                                                                              
                                                                                                                                                                                                                   
        sctp_transport_free(peer);                                                                                                                                                                                 
}                                                                                                                                                                                                                  

So instead of doing sctp_transport_hold() on the addip_last_asconf->transport,
the code relies on the NULL assignment to be propagated.

As I do not see any memory barrier or lock here, I have several questions:

- Is it possible that sctp_assoc_control_transport() runs in a timer handler
  in parallel to sctp_assoc_rm_peer() running on a different core?
  In this case there would be no guarantee, that NULL assignment will reach
  another core. 

- What was the designed guarantee, that sctp_assoc_control_transport() will see
  the change to asoc->addip_last_asconf->transport = NULL ? 

- What about all the similar NULL assignments in sctp_assoc_rm_peer()?

-- 
Best regards,
Alexander Sverdlin.
