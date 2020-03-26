Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D067319377D
	for <lists+linux-sctp@lfdr.de>; Thu, 26 Mar 2020 06:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgCZFWv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Thu, 26 Mar 2020 01:22:51 -0400
Received: from cnshjsmin03.nokia-sbell.com ([116.246.26.71]:26562 "EHLO
        cnshjsmin03.nokia-sbell.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725775AbgCZFWv (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 26 Mar 2020 01:22:51 -0400
X-AuditID: ac189297-ec3ff7000000bab2-d7-5e7c3c272b45
Received: from CNSHPPEXCH1609.nsn-intra.net (Unknown_Domain [135.251.51.109])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by cnshjsmin03.nokia-sbell.com (Symantec Messaging Gateway) with SMTP id 9B.71.47794.72C3C7E5; Thu, 26 Mar 2020 13:22:47 +0800 (HKT)
Received: from CNSHPPEXCH1609.nsn-intra.net (135.251.51.109) by
 CNSHPPEXCH1609.nsn-intra.net (135.251.51.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 26 Mar 2020 13:22:46 +0800
Received: from CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) by
 CNSHPPEXCH1609.nsn-intra.net ([135.251.51.109]) with mapi id 15.01.1847.007;
 Thu, 26 Mar 2020 13:22:46 +0800
From:   "Mao, Jinhui (NSB - CN/Hangzhou)" <jinhui.mao@nokia-sbell.com>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: One question regarding the SCTP write buffer free mechanism
Thread-Topic: One question regarding the SCTP write buffer free mechanism
Thread-Index: AdYDLpGaGVoPpsYATP6yhoepKrJy1A==
Date:   Thu, 26 Mar 2020 05:22:46 +0000
Message-ID: <9f7ef2f9a93b420c915a9e130356cdfa@nokia-sbell.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsXS/ts4V1fdpibOYNkMJounC16zOjB6fN4k
        F8AYxWWTkpqTWZZapG+XwJUx651IwU2xiuVnnRoYJ3F1MXJySAiYSJzrf87axcjFISRwiEli
        9vU5zBDOX0aJ/RMnQzmbGCXeNuxgB2lhE3CReLt/L5gtImAr8bJrOhuILQwU/zB5OtAoDqC4
        p8StWZIQJXoSC79vYQKxWQRUJf7+aWEGsXkF7CS6fh4Ba2UUkJWY9ug+WA2zgLjErSfzmSCu
        E5BYsuc8M4QtKvHy8T+w8RICShJ9G6DKdSQW7P7EBmFrSyxb+BpqvKDEyZlPWCYwCs9CMnUW
        kpZZSFpmIWlZwMiyilE6Oa84I6s4NzPPwFgvLz87M1G3OCk1J0cvOT93EyMw0NdITJq+g/HY
        Ae9DjAIcjEo8vBssq+OEWBPLiitzDzFKcDArifBuTq2IE+JNSaysSi3Kjy8qzUktPsQozcGi
        JM7bMnlhrJBAemJJanZqakFqEUyWiYNTqoGRt7/15nzTDIZPZttuFtRcVrr/9MrXRzN9IlYd
        OW9SXWf99U7RycN7vr1wj9/+sdMrku16Dq9/0KabDEfOvD34WlVG7e3R6Pbi1X6vWu2tbt5u
        +NbvEXLyh/65eaqGl3KZdurYJXJwsmf/Kbyy5rltX+os5hChM8X6ls6183XEDMLMGydxql9T
        YinOSDTUYi4qTgQA6FFBjXACAAA=
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Dear Linux SCTP experts. 

Recently we found a SCTP problem in our product, the scenario can be described as follow

Endpoint A                                                                                     Endpoint Z 
{App sends 3 messages; strm 0} DATA [TSN=6] ---------------> (ack) 
                                                     DATA [TSN=7] ---------------> (lost)
                                                     DATA [TSN=8] ---------------> (gap detected,immediately send ack)
                                                                                              /----- SACK [TSN Ack=6,Block=1, Start=2,End=2]
                                                                                    <-----/ 
                                                                                     ......
                                                   DATA [TSN=10] ---------------> (gap detected,immediately send ack)
                                                                                               /----- SACK [TSN Ack=6,Block=1, Start=2,End=4]
                                                                                    <-----/       (3 SACK to indicate that TSN=7 lost, fast re-trans triggered)
                                       Re-trans DATA [TSN=7] ---------------> (also lost)
                                                    DATA [TSN=11] ---------------> (gap detected,immediately send ack)
                                                                                               /----- SACK [TSN Ack=6,Block=1, Start=2,End=5]
                                                                                     <-----/       
                                                                                       ......
                                                  DATA [TSN=340] ---------------> (gap detected,immediately send ack)
                                                                                                /----- SACK [TSN Ack=6,Block=1, Start=2,End=334]
                                                                                      <-----/       
                       Error happened on Endpoint A when calling SCTP sendmsg to send more to Endpoint B, the error is "Resource temporarily unavailable". Association is not destroyed at this time. 
1 second later RTO Timeout 2nd Re-trans DATA [TSN=7] ---------------> (Acked)


So could you please help to comments on the following question?
-	Does this means that if an gap is found in the SACK, those packages sent after this lost packet will stay in the write buffer until the gap is filled? Even if they are successfully SACKed?

Thanks a lot!

Best Regards!

Mao Jinhui
