Return-Path: <linux-sctp+bounces-673-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 928CCC03293
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 21:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4C904E7840
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E99F34D4E1;
	Thu, 23 Oct 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="c+aCv4Hl"
X-Original-To: linux-sctp@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011063.outbound.protection.outlook.com [40.107.130.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358F334B433;
	Thu, 23 Oct 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761247227; cv=fail; b=TvEC0/uDUS92aj5p/Jv9GSkVPd6M8R4on5zfT3wh1olDEqxfnyZLyW8cWEcfNOB38KD0nFi3a0xJ/QE8ifb3WVA0lLJ7hbGLkRM6GNinNPvD3mCY0HLZIkjNQyMvZ6HnRBmELM7VlAZ9nCMBfFT35aTyVeRf+e0NSq+E68WBG/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761247227; c=relaxed/simple;
	bh=jrk7RulRKUE8I5E6r2p9wbQXu/2oC0s8uImiVbyKt6E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FwQ1dSgI/P7lLJq2Fs7HZf00zdw1ivmJMbBV71Vke8TjLfc69SC8qCCVyj1Jo/kK2yqqBLCzHLwlgp/K6PqAzf7k1BQQXjwQ5Parl562uxeDoCExOVFGREzuAiiOCWgY7rQgr3Q0ZSRCiMXFm5n3M298k3FipklZH+wFIpibeIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=c+aCv4Hl; arc=fail smtp.client-ip=40.107.130.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQaW4TEwTEZKpNPjMdj2hCxdbV5uGjgLlwC3O7YNZvAPDg+n0PbZ2UZSXr01Jn4jmQFP4+zeC8IhOzzzp2mc7WnqDGsp3bo+1WsXXWUdPjFwP/gUVqVSZnQGHNQv540/TglRqftA0cFeUpGEjg6xuGBCByV+xeGi/b+2iMpASFaKcXS1p674Lr6M8Kt7VkVHuODf9OePJ9xjTXe5k+nuaxaYh7pJPoYXBSHmR/18qKa1Ox+WPaQXgmr4zB5OprSAJ2qIO20zxP2MZUGhwSgxsr3DtkGZKmdimT51XfQqHIHPWaUgjv+CYPcejd4MUGqpBQt6tD6ZY6F+yJv2NHDKxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOAtafoXpNylIMTasoshuLCcbQ9mvMLqqyk6aC+6g4w=;
 b=Z710WhRMucrG32dnj0nLK7YLaeqYSoXQEVFLs38veHTlv3HY1xVM8arv6UwxfTo5Fsc/AduxdzlPi86v7OzcRJodTYIskz98Un/TGyKVSsvwMjJxZRwJp6ERDYcPlyPRFvNjqT0oHi7qmZ0Gti6BMCFptqbW7ybi4U/QT/i/agWZgKsdtNApHb2jkoWn5bwqReke7lqLRmPVL3phoZ+e4C82fiY990IZKnqVpGLslbr7Rpp1ESu1i7RJfox35gQYHFxsk0joK/5ZteOIdb8MA4WzNijKtEumO7v2VPIiGBhXGttYnhWaVBbUfIjkjokO6Lvaoh7eJdL9n9mKpbSIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOAtafoXpNylIMTasoshuLCcbQ9mvMLqqyk6aC+6g4w=;
 b=c+aCv4HlPqko2AHgrw4V7817HAQ6N0dPE9D+lyyyRq2PfheLXoZhvrhz9ixwxbGVBQRcAvrRKQy6vx5Fdpn3j0g2/yMnXA/zVV+kqsBjsJG1iFvTT7NhhxChk3Y0asGy9wMUVbnAewBAg75e62xQF8hqZ2S+JXYvw6w66ykkImjV0xbaNHzzoWjndgh3uS6Ho5bRrnZVuV3WKxwowUO94VPdVS1Pn5OlJZaXfUg6kp/jwN7IL5l0YdqlduJhNWISKA20o5n54JTCFWvKynAeFLa9858gXtV1zxgf6H8B0qRYu0vN9Yh7tMXcm712DbGJ1qc10C0QNntamISt1iGgsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by BESPR07MB10713.eurprd07.prod.outlook.com (2603:10a6:b10:e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 19:20:22 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 19:20:21 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Xin Long <lucien.xin@gmail.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net] sctp: Hold RCU read lock while iterating over address list
Date: Thu, 23 Oct 2025 21:18:08 +0200
Message-ID: <20251023191807.74006-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::19) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|BESPR07MB10713:EE_
X-MS-Office365-Filtering-Correlation-Id: 71dfb028-bdbb-41f5-35aa-08de126935d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?995FE2ZWLtuAou+ZhsTKZsj9pfcuEOEKd08NNK5+m+z8S/IU8H24IRnmajpQ?=
 =?us-ascii?Q?q7wVTAtEKw7OuYRcQo9znEdpyPT5e6t1PgvP4zwfkzqDW/fxd1YTu0ByY3Uf?=
 =?us-ascii?Q?6r3Z2racbpU9s797BJmFA0h6gHyiYXjHkzl70MCfxYOKtFwUF8798Nwmnmkx?=
 =?us-ascii?Q?adEOkuR6GY18YYSdfEc5wNw9vH8D/ZaX97z3tSb0txV8xN0ECrz2RBOdQqTE?=
 =?us-ascii?Q?y3It0j9sIO6PI0bC1haMDUV89cN68ZCZi52HyDSt6PEqyqOHRXY/TZhGsSCq?=
 =?us-ascii?Q?ce89HuD57irZENSPHr/7pGXsYjgwDBDJDYYQUf3TnjvEjovhvp0zSswpz9qG?=
 =?us-ascii?Q?cOEFIHLVxIrJ03Fif3eOEf3s5Uw/cD8Pce9je4msyVI9j0mAJ4e+V/KRBrQx?=
 =?us-ascii?Q?jn8nest1AtMv+b1FmfPmWhcwIzqoo68MGZYJJOVK5Og3k0O6rv/Z0G2ma2fN?=
 =?us-ascii?Q?ZbPxj10ILgg78ByyucDG2Hl6JIGESxDoj5CV7ZRHT+WSOz7mftrTfwWn0Oht?=
 =?us-ascii?Q?0DG2I5eIAe1aQZHhCRdh19rFD89M3ai67tJQe/ap/OH32T9UGCW+Uj77yEuF?=
 =?us-ascii?Q?aQdH4VvrQuYFNNKSoVBs+lems+WyKPDg3AEG7iQe3YOKwsa5HE16HUgcPjXI?=
 =?us-ascii?Q?f7fKgLH53M7UGnZ4liMRKHreOF40csjOT6kQP9AjTUKprrLS+jxdAAu59TMB?=
 =?us-ascii?Q?SNnN3BIVFo3DAdXF/j9E+094chooKVzKmPBqw+W8LOX5GHoJFbxQvI5WYtIg?=
 =?us-ascii?Q?N6qrs1jf7zgD+/cdJaIXyysWs8LWzXovrzY0CS6f0eM1O9T/COq9zlMQhwzk?=
 =?us-ascii?Q?75+fNHuBFhIN5w97tn+fbWKFVrDtB3c4i+Muhj1SDjiElbBA9Db88wev0JAz?=
 =?us-ascii?Q?4R4rBkseeijxl70RUq86WJdnvX6SLyXaH1BGEGCtm6Zy1JOU3S+nhBOmnkt5?=
 =?us-ascii?Q?XOlGWG/q4uP19+SF17rNVeQqhL1xz3Yrv4kr+CXpNd4EYNm37jCnCRVl5Sdv?=
 =?us-ascii?Q?ksMN67MMron/EtlYV81Lzx4UqP/0K8cBvu7e69PLMqXUG2nOoWcfPRXs1cIe?=
 =?us-ascii?Q?K8IrUMObYgaVHKi4wkfG6hDaDdaqGOlTgJS7qhDFpd5H5uBnZOJ9XFJfxSiN?=
 =?us-ascii?Q?24rag8R4SM5h6WP2UNz71hZFh8tc7EwtUNWqdc2hKhPApIiFGzumR0aEucZk?=
 =?us-ascii?Q?cdxMx6XGzd4pFZoMLUTy+SCKg2/ELnQqF6ncZv7PlPXhNv2+f0iMb1obAdFI?=
 =?us-ascii?Q?8aoUWuysyY9B4cFsBg22sjXLoksg/pbmMibJr3Ug9gFS0jq6NE+xBeqGtgaN?=
 =?us-ascii?Q?qurK4C7qCsKX2U+C3a9tavPY1ByzKF8w9R1UNMAEbFzMwV/gY62kEUWyJM3T?=
 =?us-ascii?Q?pLCakKZcT3znW4cJdPHRG091d41e8bD2zSnPRi31NjzeO2LGZVrbIWcuRpEN?=
 =?us-ascii?Q?7k4AkJgtUmAM5WegfoZSZyDBuqsQIy3Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xd1OPpSeEOK4VGFl8pmv1N15AURgMrM6uXK4LSuU47J2TDwV1xJo8X2kyJFC?=
 =?us-ascii?Q?JqtLe+yH/bd4YIDvzeQrOKHPj2ZHdBFz9N2xxKoZt08b7Fu3rn5G5UM4WulV?=
 =?us-ascii?Q?2CGKdUyD96gB2APlUUMfVfSdAPFm0h+7ADQUGm5+EAHu1Fhs7rMGvU2NWSwe?=
 =?us-ascii?Q?wflD8A/oN+NTjuTQXqFBhROIIGzd+Jc6/NW7F5c9Qn2eEz//eSnLGFhfMA5J?=
 =?us-ascii?Q?K8eDXFL3KUfIPoZOP41j0uFu2G6ScK5rzFT6/9hEYEYSs7EDhp83pRV1qsdf?=
 =?us-ascii?Q?0CM+LIOPV9LhkO8/SPpZbCIqONKkyDrNlgBH/RZUSx5OJRxveCAVBRpuxN0k?=
 =?us-ascii?Q?DiuI1ysnS18neO4P2oIx/ghMLX6cxu+fj6G2XOGwQlmICMBBQ09+S5pCJxzP?=
 =?us-ascii?Q?m4fXCmDGiZFZkvoT72HKrPj3C/KoleWvSojnQVLXvLBM+svZL93fHXUqLM7i?=
 =?us-ascii?Q?9ueQV2q7+pR6M1tR/5a0Z6Q0506c3PhTPyEkB/Z8qtA7YEAwvtT9iQ5w/jbq?=
 =?us-ascii?Q?jCr40ftILiNchhPPx4gdQGbJ1om/+Ste2Uan0z3XkhaPdz0WYDa7plGYheIe?=
 =?us-ascii?Q?ssRa7WTpcOG7sHd5akjTFy+zHdN2CvL/cjIZEvgZcGdpihcbR/elCUQKItZc?=
 =?us-ascii?Q?hSW9ANgL5dPjVN9g3+7aPlLeMWPWSyyhPDfj9ZZvApNlVauy9LfIcqo3VqyO?=
 =?us-ascii?Q?T4mwvl4C9cMHLDpHi6XpTJki5JNuhXaNFGR7bn/A2/E1l96QR115keGJ2NAA?=
 =?us-ascii?Q?eHWEpLnFV+Xu+jgloJSMsRCpwniHRM6H5vuze4+VIejsuPYy/jgVumgVzhgN?=
 =?us-ascii?Q?ZpJ7V5fzBrRuFoNReU9zf/1CsIyS+P8V0QvK99ynnW+F47mzT5Uo/nSEVqKH?=
 =?us-ascii?Q?+euZg49zz2sBKtuOWmwcCyR5eTmW+sSY6brlJOhvl2/mc+r4W7eO8g/dvGNE?=
 =?us-ascii?Q?ByCzT26XsEeql+IGi/hNKT7WqhBvMwAT6K4yBJP25qG4Zf1xo04nUfe+kR0/?=
 =?us-ascii?Q?gNlyIVUVVyB9i9PKJLter651ncHnVVY1febWLD0WERXS3rukACFP/SH9qGVl?=
 =?us-ascii?Q?HsnLT7D1fnu1dAMx+NGs1DenbawxDkxW4JUl0OnTLyIYaRgWN5ERliOFChfx?=
 =?us-ascii?Q?boFzPvnCGTzvI3MhiGmnaTTnqZwDDY2QUIJn1l0UaFMnxs611aC/0DfF9LhJ?=
 =?us-ascii?Q?M03er0JKPjrdhF8ALLiMnHQAFhALDaZCRM4qI7iHYPq++tjyI+d+tBmZVHr9?=
 =?us-ascii?Q?oUy0O3KZWQcTuZIqC4jI9yu7D1gvNyB5b3PfMGnhlPhYnm8IorO8REF8dLzy?=
 =?us-ascii?Q?MF6dwKjwfXvs3gxWdyyBB7NM40Wzn6+3a/6DW09rigmUsYJcUte5UkhOmU8Y?=
 =?us-ascii?Q?FfOLmpW7+gXcNng1fQC/0euK3MCZHf9UTjyyqG8PXhUZWYdd7TfmhLF4DXDc?=
 =?us-ascii?Q?5VOHH8hjoFlgiB10HcfsSHH36bCPC1ypFXW6e6Mcdzm8VAZplgLp4R/u6ywA?=
 =?us-ascii?Q?fA4ro2vfyek4ybxwFES8CC19uuVcT9OYbAe8JuuZXtUFtTMbvQX4QeavVnmg?=
 =?us-ascii?Q?HfozpTY10VcWxsm4GhbCyHvIlkmWicCa53C4Jftk1eBnangbyu80G2yBjbEX?=
 =?us-ascii?Q?Y5uRFBhbPmagzwTesE5Wf8nn9C6oASdeqLY/ultVk9/ajAfh80iJysuNW73s?=
 =?us-ascii?Q?5DaKlQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71dfb028-bdbb-41f5-35aa-08de126935d3
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 19:20:21.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTIEXi3vZ8MCqndvCdOuNOfUhxAM8BDVf2vDujGrZcJbdgKOWqkTPECCoVY3ivUJwbXCgRnJbREqtkCs1pOEmFTQCka7+w1ib3SOtNJdHgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR07MB10713

With CONFIG_PROVE_RCU_LIST=y and by executing

  $ netcat -l --sctp &
  $ netcat --sctp localhost &
  $ ss --sctp

one can trigger the following Lockdep-RCU splat(s):

  WARNING: suspicious RCU usage
  6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
  -----------------------------
  net/sctp/diag.c:76 RCU-list traversed in non-reader section!!

  other info that might help us debug this:

  rcu_scheduler_active = 2, debug_locks = 1
  2 locks held by ss/215:
   #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0x84/0x2b0
   #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_dump+0x38/0x200

  stack backtrace:
  CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f864458e9a6 #5 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x5d/0x90
   lockdep_rcu_suspicious.cold+0x4e/0xa3
   inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
   sctp_sock_dump+0x131/0x200
   sctp_transport_traverse_process+0x170/0x1b0
   ? __pfx_sctp_sock_filter+0x10/0x10
   ? __pfx_sctp_sock_dump+0x10/0x10
   sctp_diag_dump+0x103/0x140
   __inet_diag_dump+0x70/0xb0
   netlink_dump+0x148/0x490
   __netlink_dump_start+0x1f3/0x2b0
   inet_diag_handler_cmd+0xcd/0x100
   ? __pfx_inet_diag_dump_start+0x10/0x10
   ? __pfx_inet_diag_dump+0x10/0x10
   ? __pfx_inet_diag_dump_done+0x10/0x10
   sock_diag_rcv_msg+0x18e/0x320
   ? __pfx_sock_diag_rcv_msg+0x10/0x10
   netlink_rcv_skb+0x4d/0x100
   netlink_unicast+0x1d7/0x2b0
   netlink_sendmsg+0x203/0x450
   ____sys_sendmsg+0x30c/0x340
   ___sys_sendmsg+0x94/0xf0
   __sys_sendmsg+0x83/0xf0
   do_syscall_64+0xbb/0x390
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   ...
   </TASK>

Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
It might be sufficient to add a check for one of the already held locks,
but I lack the domain knowledge to be sure about that...
---
 net/sctp/diag.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 996c2018f0e6..1a8761f87bf1 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -73,19 +73,23 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 	struct nlattr *attr;
 	void *info = NULL;
 
+	rcu_read_lock();
 	list_for_each_entry_rcu(laddr, address_list, list)
 		addrcnt++;
+	rcu_read_unlock();
 
 	attr = nla_reserve(skb, INET_DIAG_LOCALS, addrlen * addrcnt);
 	if (!attr)
 		return -EMSGSIZE;
 
 	info = nla_data(attr);
+	rcu_read_lock();
 	list_for_each_entry_rcu(laddr, address_list, list) {
 		memcpy(info, &laddr->a, sizeof(laddr->a));
 		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
 		info += addrlen;
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.51.0


