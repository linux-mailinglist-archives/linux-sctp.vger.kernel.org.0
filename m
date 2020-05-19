Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD71D9284
	for <lists+linux-sctp@lfdr.de>; Tue, 19 May 2020 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgESIvi (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 19 May 2020 04:51:38 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com ([40.107.6.98]:29318
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726333AbgESIvi (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Tue, 19 May 2020 04:51:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glo/4rTffCo4i59q7JDJ0JwN/c6xwg7Rr+0GARZtl94q3C4ly7u2E4xW5el8TZIHd9FJKBbiV0SSFqHtycTgTnpezuWPSSt6Qe1nvV1QslzzPc9+NeLajSau2EzZEOln6FTp7MrNsGz9SO34TkOeN36EbcmU0lqNo5j5th6stqlOfG6sYRgtcLNBC2hJ0e8pKQYFI8nT1meAmc3VY3WNS8kFq5Aj9HPvIuzv97ZkAvSS2wvuoLYEQ9SIk9U7ESJRe2xEz4erXX9RRo95qiNZyPDOCmH1aZNYtNY9ymh4NfJRgpuMxi32+qfrttgaUrjYjIut+sCTsbxWjJGcTBYlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4xDH4aVn3sm+B8etKwyf7OsbpJjYuNqZ8jk2x/N7ns=;
 b=GoVm/7ouvzPUbPKQwIKIYC9d6jk4thfyZZ2NYqECDsNMfai+iTUyXV769//nVM67FBoMnDJwqUiPy0gix5lgBq85f904UNlvKATv4rY7wQtjoYAQAoBtQ+yJGakV1ZvaUQ9NbzGCkQMq5T25ZJ7WEBY44Apx9gcxLxPXKZ3aLoUbzyjXZ0yXiymMXt/B8/jwQ5Rm3/0IMbP1o8NXJgmzaL2RBp/hD2nIrUu1dAGf9qNYEHddEGU/wiKaf6WoFRZrmUABkmjmZAEBE35QMQCSXFkZtnCpnPaFrJsRuWlTV/mQymsjpM7xyFJ24e0coMKogX+uNiAGitp0LM9c5A+lGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4xDH4aVn3sm+B8etKwyf7OsbpJjYuNqZ8jk2x/N7ns=;
 b=g/29AOzO/DVyM6y09YKDWpM+p3fDbQnZOePfi34LmrYznITaO9Gx1s4zOSE09oH2Lh/6hNFhd7wFmrsjFV1dJJaZRjK/OV/ggEcTvP1QCAL+QyTUBeV9YQsPIPeOZBzbV6iZjKWvTJ2lMK2dbzCfMOU5pfek4TUcUHzyuU+YAU0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nokia.com;
Received: from HE1PR0702MB3818.eurprd07.prod.outlook.com (2603:10a6:7:8c::18)
 by HE1PR0702MB3754.eurprd07.prod.outlook.com (2603:10a6:7:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11; Tue, 19 May
 2020 08:51:32 +0000
Received: from HE1PR0702MB3818.eurprd07.prod.outlook.com
 ([fe80::f0bb:b1ae:bf22:4526]) by HE1PR0702MB3818.eurprd07.prod.outlook.com
 ([fe80::f0bb:b1ae:bf22:4526%6]) with mapi id 15.20.3021.019; Tue, 19 May 2020
 08:51:32 +0000
Date:   Tue, 19 May 2020 11:51:23 +0300 (EEST)
From:   =?ISO-8859-15?Q?Jere_Lepp=E4nen?= <jere.leppanen@nokia.com>
X-X-Sender: jeleppan@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net
To:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
cc:     linux-sctp@vger.kernel.org, Vlad Yasevich <vyasevich@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        =?ISO-8859-15?Q?Jere_Lepp=E4nen?= <jere.leppanen@nokia.com>
Subject: Re: [PATCHv2] sctp: Don't add the shutdown timer if its already been
 added
In-Reply-To: <20200430135904.GD2688@localhost.localdomain>
Message-ID: <alpine.LFD.2.21.2005191146330.774972@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net>
References: <20200428165848.1834838-1-nhorman@tuxdriver.com> <20200429113613.1959665-1-nhorman@tuxdriver.com> <20200430135904.GD2688@localhost.localdomain>
Content-Type: multipart/mixed; boundary="352996365-948516143-1589878291=:774972"
X-ClientProxiedBy: AM4P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::14) To HE1PR0702MB3818.eurprd07.prod.outlook.com
 (2603:10a6:7:8c::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net (131.228.2.10) by AM4P190CA0004.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Tue, 19 May 2020 08:51:31 +0000
X-X-Sender: jeleppan@sut4-server4-pub.sut-1.archcommon.nsn-rdnet.net
X-Originating-IP: [131.228.2.10]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a6b799b9-114f-4f31-d563-08d7fbd1d3f2
X-MS-TrafficTypeDiagnostic: HE1PR0702MB3754:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0702MB3754FB406241B7677FA5C81FECB90@HE1PR0702MB3754.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu4gjDakUkez4DsK3ek+t21Y+4nbCDRxRF5+CwXh7NvD2XC4ixXVIkwv3h+xRdG/3RTv1LRsalvlOlXVXBFqM5eFaFvWKu0D+W+imfA0wCUkiF/920mrDzVGUiMazKQyVpH45en3hDJaWdRzFiqvTOu7uzSQrzdEDP2m4m0h5mAHL+ru9nf3C7JqLqovLplU/CM6iHSoRp3L+CdW0BXkw2I/bIkBP5loEh2OWXoBTCwQ4H3HjZawb7lkEvORcIHsorwCLptsHyN85CPQiQqLaQ/1Lg8MBs5WHM/t6ZIYvrnLBokf65CYDZLe7o9mKmmMF4x6IIXQQdnihgSkVDMQYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0702MB3818.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(376002)(366004)(136003)(107886003)(316002)(86362001)(186003)(956004)(6506007)(26005)(52116002)(66574014)(54906003)(5660300002)(8936002)(4326008)(7696005)(110136005)(66946007)(66556008)(2906002)(66476007)(8676002)(16526019)(6666004)(9686003)(55016002)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: mK48p+yJl0Uqn2K90d28mYZCy6pE5preimAGATylFGhrTgHKqcq1kyzJM4Jp9uMewBipl+MPHpq70E7FAoptYm9Qhh7ptBZf8ZEDsB2nT2pl7uyXI+1rsq6goqN4vuS7Qev0O3roPG09Srt6OIBCgLKsKsKTL83PKY8P4xc5etTDepC50v/3Fph3a4Fj0xXwdWysdx2muc2yax713XIiwn+u2m3k8mVtAMqZPmC75H9RsiOhgtaKU0ZKfylO6cMqrRcIu2lHXJYR4f/nirQe2jC1CtUQg/L4m7gtowW0jGk27tdx6oq5tN9JOHXobrDp8hajmyhCIHXOM5n4BfjdorQlKO2InLAZapRuvpYClSoIDC6H1b1cXACJPy0kHVO+p9DU+xJR6jiNj9JSAFpPwkqhEt2pj4MetEtfTPDKOC0MD7nYnsOATmWBy0xGP02uJPuc7WbtPFXwmvF6a8+/9ykgKp2LCtEaJTVCmZujKmk=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b799b9-114f-4f31-d563-08d7fbd1d3f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 08:51:32.1406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSX6oCmoHzW7tC+Um/iEG8+4qmmzf4jecK5ehwemRxc/XHzAjteJR2qtHrDjCldvakUE9dwFHW9NFouNL3pkQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0702MB3754
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--352996365-948516143-1589878291=:774972
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 30 Apr 2020, Marcelo Ricardo Leitner wrote:

> On Wed, Apr 29, 2020 at 07:36:13AM -0400, Neil Horman wrote:
> > This BUG halt was reported a while back, but the patch somehow got
> > missed:
> > 
> > PID: 2879   TASK: c16adaa0  CPU: 1   COMMAND: "sctpn"
> >  #0 [f418dd28] crash_kexec at c04a7d8c
> >  #1 [f418dd7c] oops_end at c0863e02
> >  #2 [f418dd90] do_invalid_op at c040aaca
> >  #3 [f418de28] error_code (via invalid_op) at c08631a5
> >     EAX: f34baac0  EBX: 00000090  ECX: f418deb0  EDX: f5542950  EBP: 00000000
> >     DS:  007b      ESI: f34ba800  ES:  007b      EDI: f418dea0  GS:  00e0
> >     CS:  0060      EIP: c046fa5e  ERR: ffffffff  EFLAGS: 00010286
> >  #4 [f418de5c] add_timer at c046fa5e
> >  #5 [f418de68] sctp_do_sm at f8db8c77 [sctp]
> >  #6 [f418df30] sctp_primitive_SHUTDOWN at f8dcc1b5 [sctp]
> >  #7 [f418df48] inet_shutdown at c080baf9
> >  #8 [f418df5c] sys_shutdown at c079eedf
> >  #9 [f418df70] sys_socketcall at c079fe88
> >     EAX: ffffffda  EBX: 0000000d  ECX: bfceea90  EDX: 0937af98
> >     DS:  007b      ESI: 0000000c  ES:  007b      EDI: b7150ae4
> >     SS:  007b      ESP: bfceea7c  EBP: bfceeaa8  GS:  0033
> >     CS:  0073      EIP: b775c424  ERR: 00000066  EFLAGS: 00000282
> > 
> > It appears that the side effect that starts the shutdown timer was processed
> > multiple times, which can happen as multiple paths can trigger it.  This of
> > course leads to the BUG halt in add_timer getting called.
> > 
> > Fix seems pretty straightforward, just check before the timer is added if its
> > already been started.  If it has mod the timer instead to min(current
> > expiration, new expiration)
> > 
> > Its been tested but not confirmed to fix the problem, as the issue has only
> > occured in production environments where test kernels are enjoined from being
> > installed.  It appears to be a sane fix to me though.  Also, recentely,
> > Jere found a reproducer posted on list to confirm that this resolves the
> > issues
> > 
> > Signed-off-by: Neil Horman <nhorman@tuxdriver.com>
> > CC: Vlad Yasevich <vyasevich@gmail.com>
> > CC: "David S. Miller" <davem@davemloft.net>
> > CC: Jere Leppänen <jere.leppanen@nokia.com>
> > CC: marcelo.leitner@gmail.com
> > 
> > ---
> > Change notes:
> > V2) Updated to use timer_reduce
> 
> Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

Hey is this patch falling through the cracks again? No rush, I'm just 
wondering what's going on.
--352996365-948516143-1589878291=:774972--
