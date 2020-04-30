Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CBE1BF394
	for <lists+linux-sctp@lfdr.de>; Thu, 30 Apr 2020 10:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgD3Iy1 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 30 Apr 2020 04:54:27 -0400
Received: from mail-eopbgr70107.outbound.protection.outlook.com ([40.107.7.107]:19960
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbgD3Iy0 (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Thu, 30 Apr 2020 04:54:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jr6jYy9LGeqUZ3Dl/Gkq0L1tXQUXfZ+yXfxPk7NzSuynkPArK6hLsJCHWyUf5SAtNMhXGEvMz4bdXSVbJL3oN9Gs6Eff0bzBXXIJoyrac2t1B4z2KQygXX4uUK7RM0gWX9EDtvyRzPikfKTCrDO4nF9ZtxxEc0Uy6mc2BMVFgVyhCFDzf2miXwf2r8yYgq3alf8GDX1uBBpth3c5qVjg3+rJn0xLyeAIeL60/cshwJgdVbSRmq9REq95UKe+ms6sf4/fxfHO6sjuLFhvtwODyUBKWttL/SAfDB4CeT/wnH8GTRUDzapz3S5MhzmawAFjGAdpSDkBXJ2zNlypzn3xEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnXC0CYrF88nKAjmiA6Se2pbGvEVCQfj5ZAFAcS9zjo=;
 b=dlsIuHefy0x5vXsVD47loMSd9ILCwvxL24gMNsfjxFKGaMynIHSuvQwbrCFquCGjKem9OMN5IjXUgIKXe5I8iDyp99nxuDTRTjWVjuaACl4fBIPxIdAZfUxr8r4ivGvnsCwajUBpJpW/h/fvMpJISN1MdWV4Gp21PmzoVyCIsWbuRhuB6m8JKboHvmBLO5Zmhq82i+7pyd9/4W1d1Ys1BV4/DdpKisrz+RBps4pMPWOoNe8Yg4ZLHP1kTJQZAXuLUEoPFjfaaL5V4XA3Vg5i1gSQ5CjGoO3Fw2KTJw3h0IeVClVGel7oMWv7ZeW682tCQtW26l3TMbIQ28eC615yiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnXC0CYrF88nKAjmiA6Se2pbGvEVCQfj5ZAFAcS9zjo=;
 b=C7xKbTQmG7dMYx6ZEhMd46Ozp9Gl+Bha2Rnmhc0cta75xBpamHAEkIp53nk0rdGZ5j0L8x+SDl1AFcGU7LRH8tAWtYcHl/9qMtXZyE7J/xnGC9u6HcH0VQLpsfKCtM8r0SWOe5U5B+ULNLvtRwZyFv3ITbKoSb0gdxHI6u5NyLo=
Authentication-Results: tuxdriver.com; dkim=none (message not signed)
 header.d=none;tuxdriver.com; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR0702MB3818.eurprd07.prod.outlook.com (2603:10a6:7:8c::18)
 by HE1PR0702MB3673.eurprd07.prod.outlook.com (2603:10a6:7:81::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.14; Thu, 30 Apr
 2020 08:54:22 +0000
Received: from HE1PR0702MB3818.eurprd07.prod.outlook.com
 ([fe80::f0bb:b1ae:bf22:4526]) by HE1PR0702MB3818.eurprd07.prod.outlook.com
 ([fe80::f0bb:b1ae:bf22:4526%6]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 08:54:22 +0000
Date:   Thu, 30 Apr 2020 11:54:11 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jere_Lepp=E4nen?= <jere.leppanen@nokia.com>
X-X-Sender: jeleppan@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net
To:     Neil Horman <nhorman@tuxdriver.com>
cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?ISO-8859-15?Q?Jere_Lepp=E4nen?= <jere.leppanen@nokia.com>,
        marcelo.leitner@gmail.com
Subject: Re: [PATCHv2] sctp: Don't add the shutdown timer if its already been
 added
In-Reply-To: <20200429113613.1959665-1-nhorman@tuxdriver.com>
Message-ID: <alpine.LFD.2.21.2004301149120.629159@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net>
References: <20200428165848.1834838-1-nhorman@tuxdriver.com> <20200429113613.1959665-1-nhorman@tuxdriver.com>
Content-Type: multipart/mixed; boundary="352996365-1736932537-1588236862=:629159"
X-ClientProxiedBy: AM4P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::19) To HE1PR0702MB3818.eurprd07.prod.outlook.com
 (2603:10a6:7:8c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net (131.228.2.10) by AM4P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 08:54:20 +0000
X-X-Sender: jeleppan@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net
X-Originating-IP: [131.228.2.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ae3849de-d5c0-49fa-1058-08d7ece4139d
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3673:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB3673B645519AAC0E2978150EECAA0@HE1PR0702MB3673.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB9aPBlBWjbbu/Q69dVwSMxWOyP+d3fdKZYfSxZCj8dwDyIWST3vD4rjPsEeinNvAyEEvJRIrQM/rQakJBsI/IQvYLzpb2qSOP6VZkz2JTcXkEciDEOxV8ItArdb/IewUpwM/WMoyU3vi3492a3q1VN9u9pTxHrgFLxU/RGnCqyq/0sRy+OMc36hoa3nLcu03lbcHyRScb36kVRg6RQspB/G37pBkFpW8Lyw3sX8GGSwLSxi3M/fsW5A3YmeG8nzAucnHnsj3vG8MOwTTdAWOT/iz9evYpP9eQ02V3IUcsuWPTiBVT0Rd5ePzwEwKRl0uuSWdNKIYxYYNkqZLNBwyCqNKdH8Yy2ctfmb05LxtxxdwptK7dIJus/rzVS0vowcc1jh9Hb4B9WFh4lNkdVYTDIFf4+YEhthSCmyA0j+qwg2BuXnYSuOsno8toQjlQeL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0702MB3818.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(376002)(366004)(396003)(26005)(66476007)(66946007)(6666004)(6916009)(9686003)(186003)(16526019)(2906002)(478600001)(66556008)(86362001)(4326008)(8936002)(8676002)(956004)(54906003)(7696005)(316002)(55016002)(33964004)(6506007)(66574012)(52116002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: isQSYbbcrOG++jIjVGg9jAypbs5D49rjurnfH0ay163AwKKxxJcg00VLe8ZirI2DRYwjPzp8DPqU2l3zBu5NFrxfY6C84bV7THBYac0RXSDhHEGdm8mJ3+r4gPjKL9rQ+4UV9S35FrPkiQeDhY/+FeiuQggqicEaGW4AwNH6OjZyYG74lTxA7EHGn/JZaXqJM1Hg/MlRLZHOpvI9tyVlERrObS2qTUc+kl8ALPMdyaV0EHUhVWujsNM0YJ3Ctq9Axi3aVj1MVAUwsqluRG/dC6y1WEj+lbWuVOLdh8KbS8v6KExk/jndcTM6cm2O9+qP5210Wl0WnogWIzds9ncs67gbT0XBoWCunaFdFdVhuWlz5fGVtNyERT1IUFJMWF95VwXDHhBnUxDaMvWV7ujN66YQVPD1T0k27DaKRjpMRA90Eu1YP9RJr/XdCJPWzJODeNd9RlyN+5GGZoWEeEEJ72hcIlHzPuzJwEUOieuCisfZRaJIiUJlIFj5ImWXYay9OTObGSQhsRfUvVsmy44xmd9lgZtCCNjf4vyk6zQ9UqInXmRKCZTJF3AHo+omXAR1UxHMYZ8RqTKZJcmScCcHyNrPl9HICgFVHsTKz04QudBQ+DOq38cquQPJztv1jCkpOzBBo+PweXQDm5ghUWJjw3nxR1hNbv+OakFAhs6ywnQaQjp1ZcDfhFsYa2BkQcePuiHjhoxL3JmRTga4LQERGFFWNpAa7T2J/gnbQGjmKm1ta9So82ahB9WEDG+XrR5pPuKLjGKJvVKGf02jdCet9AaTlSOWvteeL1JCNIeJNMY=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3849de-d5c0-49fa-1058-08d7ece4139d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 08:54:22.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zA84QxT8QCvt38UxL07TbODm5CdobRA8D7tJ7CVr69+qascup3lPiiyTDMNIXnBebhCSrubHu/Gcna4s4vkuSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3673
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--352996365-1736932537-1588236862=:629159
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Apr 2020, Neil Horman wrote:

> This BUG halt was reported a while back, but the patch somehow got
> missed:
> 
> PID: 2879   TASK: c16adaa0  CPU: 1   COMMAND: "sctpn"
>  #0 [f418dd28] crash_kexec at c04a7d8c
>  #1 [f418dd7c] oops_end at c0863e02
>  #2 [f418dd90] do_invalid_op at c040aaca
>  #3 [f418de28] error_code (via invalid_op) at c08631a5
>     EAX: f34baac0  EBX: 00000090  ECX: f418deb0  EDX: f5542950  EBP: 00000000
>     DS:  007b      ESI: f34ba800  ES:  007b      EDI: f418dea0  GS:  00e0
>     CS:  0060      EIP: c046fa5e  ERR: ffffffff  EFLAGS: 00010286
>  #4 [f418de5c] add_timer at c046fa5e
>  #5 [f418de68] sctp_do_sm at f8db8c77 [sctp]
>  #6 [f418df30] sctp_primitive_SHUTDOWN at f8dcc1b5 [sctp]
>  #7 [f418df48] inet_shutdown at c080baf9
>  #8 [f418df5c] sys_shutdown at c079eedf
>  #9 [f418df70] sys_socketcall at c079fe88
>     EAX: ffffffda  EBX: 0000000d  ECX: bfceea90  EDX: 0937af98
>     DS:  007b      ESI: 0000000c  ES:  007b      EDI: b7150ae4
>     SS:  007b      ESP: bfceea7c  EBP: bfceeaa8  GS:  0033
>     CS:  0073      EIP: b775c424  ERR: 00000066  EFLAGS: 00000282
> 
> It appears that the side effect that starts the shutdown timer was processed
> multiple times, which can happen as multiple paths can trigger it.  This of
> course leads to the BUG halt in add_timer getting called.
> 
> Fix seems pretty straightforward, just check before the timer is added if its
> already been started.  If it has mod the timer instead to min(current
> expiration, new expiration)
> 
> Its been tested but not confirmed to fix the problem, as the issue has only
> occured in production environments where test kernels are enjoined from being
> installed.  It appears to be a sane fix to me though.  Also, recentely,
> Jere found a reproducer posted on list to confirm that this resolves the
> issues
> 
> Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> CC: Vlad Yasevich <vyasevich@gmail.com>
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Jere Leppänen <jere.leppanen@nokia.com>
> CC: marcelo.leitner@gmail.com
> 
> ---
> Change notes:
> V2) Updated to use timer_reduce
> ---
>  net/sctp/sm_sideeffect.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> index 2bc29463e1dc..9f36fe911d08 100644
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -1523,9 +1523,17 @@ static int sctp_cmd_interpreter(enum sctp_event_type event_type,
>  			timeout = asoc->timeouts[cmd->obj.to];
>  			BUG_ON(!timeout);
>  
> -			timer->expires = jiffies + timeout;
> -			sctp_association_hold(asoc);
> -			add_timer(timer);
> +			/*
> +			 * SCTP has a hard time with timer starts.  Because we process
> +			 * timer starts as side effects, it can be hard to tell if we
> +			 * have already started a timer or not, which leads to BUG
> +			 * halts when we call add_timer. So here, instead of just starting
> +			 * a timer, if the timer is already started, and just mod
> +			 * the timer with the shorter of the two expiration times
> +			 */
> +			if (!timer_pending(timer))
> +				sctp_association_hold(asoc);
> +			timer_reduce(timer, jiffies + timeout);
>  			break;
>  
>  		case SCTP_CMD_TIMER_RESTART:
> -- 
> 2.25.4

Thanks Neil. This patch works for me, but I only tested the one case I 
posted about.
--352996365-1736932537-1588236862=:629159--
