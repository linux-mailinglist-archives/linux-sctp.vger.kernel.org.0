Return-Path: <linux-sctp+bounces-720-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0ABC15C9E
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 17:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FCB1C60850
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 16:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37543491F5;
	Tue, 28 Oct 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="lxO7ptvJ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C93347FD0;
	Tue, 28 Oct 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668160; cv=fail; b=oPNDIQkxw6MjfBZdzzQC1T3vfN0Atc+0ro7c/pZvqUSeYsKw5ofFWIMgKhuCtEEdcvxvnsEJvbyrgAQij0cGU3PxYw/BXifTaA8oX1nEIZ/JkxKw5BScmP6MrwN4b+aqzG7UBms0/XRT9bPV9QK02mr2e89Zr2ZgoembzqnXHpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668160; c=relaxed/simple;
	bh=f6COoE/suGtVMFTcgl9zh2hdgjt75Uh8HaDCkC9Oxs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P+oCmA11vwaSIMoehwn8bNHP771VWgQ2i+2OZMzvdNlNqX7up+E1/UqLfIo3FpmK29+thZtD/F1QFqFZtfYstkhITJNZcY0eACJkRH/SIN9c11ZLXmRK5tsy71AbGr87GIKIF9VaKWZblSzgK4mwTx5tNf8O5/evHiUgUItMOIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=lxO7ptvJ; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWlGgm91stXMn4ct+Mjb6fRG0WqfnSZpdr+XmBkrLRV7ubjpDXBrKwHK8KOy11W4sGtOlhUXBbVhp+DjDr+RejZey+92OIKOTEfUt9PX8RwWkc5yuL3N4FIGGO989tCnKI207NDmO/WJ56p/ap/l4OPkP0C/I7m4OcKz/zo/rCujrnX3ozstUUT+M4ihZfSZfNBsRt8N0IfRYcz2DXXa9EQA4rvGfz5AYMltjWQboNAnhuimmTbCQKNErrqg9HuNAw5BZeoeerSH9h8YKNc64dQ3oq4JgdwZ0daIdkjVEkaUerwUPtrcQvkQdqKI1rgJgtVMXi31rVHyO42TI364EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHUiCfDrH+1KJgJ9XrUZJ47ThzNmw2hExd1o34oB3W4=;
 b=syACDFSxY7RTJttmVLhX7IUURu1LDqAFbjKDUu4xE07lde+aJymrxhti0mRfgquBuCd9A0BUCIPzfS0MNLwT2pEeGq5+X24NtsUquXRmwleEQlwJEtHnO+g7698hByjTehzU/elNieKsfWG16lMtFpDbQQsoQOc/sTqoys6gQdF1dRBGcpEHXMvJLv6z7asAISRxFEWtVEHcsy3P6uIQMM8S5QMxhDAnrfaCyDsSPplGcgaN3n+ZZR895ow600Ejy/kpbB5Sj3dVMNUwIceh2/Nj2RRmHgA6YOq+OYiKee301IW7LzVULTNGlY8ro9/ZPeyrlg3PgFeBuUm/rM07mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHUiCfDrH+1KJgJ9XrUZJ47ThzNmw2hExd1o34oB3W4=;
 b=lxO7ptvJOnzR+HyphceVHwO0pdidPahb8AAAQ035xaTlN7c/mewupstZ0mrt4324QUJDH4P7cByguWkNb69Ymvfrabak9nP3mwSANpRrzVcPVNQYxjh7GMh/5zcI0rWS0J6Z5046AC0wG2bYCwJ1AOkSChVmscLTIwscdwd/vwB+0XAdCvvgGOvhoH7p53mu/JMSR+PubYz8pN5O/UpMl0ArvrgWgvtWTk+Y5DNW9Iu7xDHHYNABDTB67NEuY6km5g9pMvRQIyjvokLF9qtAF01udzqaw6yxO9Iijxm8moN65DrvfP9bw+YVx9ZAWXEvCRlZLEKZtnAo90Mmlz6NoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PR3PR07MB6700.eurprd07.prod.outlook.com (2603:10a6:102:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:15:56 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:15:56 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Xin Long <lucien.xin@gmail.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH net v3 2/3] sctp: Prevent TOCTOU out-of-bounds write
Date: Tue, 28 Oct 2025 17:12:27 +0100
Message-ID: <20251028161506.3294376-3-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::19) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|PR3PR07MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: b9dae2f4-5094-4863-8f65-08de163d4626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1ry79waZhLAVyQCCmL4D7DZOH7wXpJSGcmwExnZTjvDTP/nDKZEZFccSZmy6?=
 =?us-ascii?Q?Jm2FOvPp6oe3B4XKrDM3/9Gr/a0J7h6ZvirtC5cETDB5bDP2NmndO3PZWysl?=
 =?us-ascii?Q?UBfk8LjI+54FIBlpipEWWJqpZdIPtn+ZE0MqA7VYR5GEdTSsjCyus/NM0inP?=
 =?us-ascii?Q?2HkCtEimIN7vO8fx/VH5M63vsI7HyH0sWDURxsgaa20KyCgoKaNj08aq1JRH?=
 =?us-ascii?Q?L0cWs+wlD+DWCatmlaJzn3/+ePozS3sN2bU740GiVLo9Knb94Vh9d7MgMLtj?=
 =?us-ascii?Q?UOnyrAFnerUdSXpdECshbtDGcT+lw1ID9QwCWnWMa89rZgO8kbKMXjGpS45H?=
 =?us-ascii?Q?b/OBpLG3piaiTnbYuvYpT45WbMZsolZzG4ly8hWIDezaHw1QtsidVmeHWyt9?=
 =?us-ascii?Q?SMcdCjFhfZ8dBjxXcxMpiPmWF8/2uY8A3fMBsEFeTIFwVbjVv6MxFMbG5Fqc?=
 =?us-ascii?Q?/KdD6JNvtUy23qu3bvMHlRtoAbdr6/WUjmgUFmxISIfxvTZ/s8cnBLEpTZpY?=
 =?us-ascii?Q?VFG228K1vih3tBpsHT65WfVSqKi2dpM/aKWXbfubP/WOprbTXbCVs3XO4C2j?=
 =?us-ascii?Q?NveTd9giREKV1aFuYYOCoodvzxFCZJssWZcBde6oh24R16/KVXEZmjxQ2HWW?=
 =?us-ascii?Q?dSSQxso5NNLKTn48HnHlvfCFdAYk/wy1H/C7ij5M75X4L79B4LSoO4TLviH4?=
 =?us-ascii?Q?IhdZ15nAXG9QMY2rd9w8K70D957D0vLD/q70jUAitrt1SUZpw8+Ff2cCLgSy?=
 =?us-ascii?Q?3ZX7najeWIjKuCxmWyPbSjE60tyymRhIoieT+klqoOnk97IGvEMp8pPqh72U?=
 =?us-ascii?Q?Qae9KdjNlBJMxqMtSDa1A7y/NSY+aNCsdE1B5pzAfjLbNLu7utZWhfkyLAMW?=
 =?us-ascii?Q?NtIfmVwVBRoT2sKaqdjGgk422azBBZ7NBmtJPkyheLWN5Fwc8F+wi+XJj2NV?=
 =?us-ascii?Q?Hpivmi7c+D0mMTyTk5yk1XhzTBf8zrGUIFdzvKCw3PtE1Arv6rQ5ykR2/0I0?=
 =?us-ascii?Q?gDuB5kZmE3sprF80OGZtsBcjivGBeGI8/HRAvGpMrlpxyzYsZm7qKISm32Mo?=
 =?us-ascii?Q?gjIRcjcwZQLCwsHiIe3g6yQ4hKr5FSYIetttrow7LBR96xkhqsan1i0LI581?=
 =?us-ascii?Q?fR5rIPeOJuhSdsqzc81LxjQKzC2fc21FLo8LdL0i+XW1t4ybHyHYQxjyY7/K?=
 =?us-ascii?Q?Dke3KimxVncQfxT+BQLBWCNEoKtVrPVn5+BnW2to4nk2hEORu/jllHJ1gTVC?=
 =?us-ascii?Q?CuisGPdjYseZOJVcEzCjC+erA4UEdDoFd91Wz7mlATfKn0kd1T3GQo8LBRaX?=
 =?us-ascii?Q?2VyNS0RvjVm5izuZEPRdzeDz0Mo2NkklHfE/RXGYB28htfrFcNZjqYu22w/7?=
 =?us-ascii?Q?YZanlRrFgv02luEyvOzimxaNyAyYevWO5MpTPqTxAq7jC7/Wyr7EZ81/BdSF?=
 =?us-ascii?Q?aU7O8wvdiadJEEtNtLGa3gWcKRHBGJIF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Skp6sgeTbX2lsK59nnj8twYHgHTFZ9+wqJNklTrEzb4Dkw8C6KAKmKrhlXSo?=
 =?us-ascii?Q?5K2hJ6Bk6r0Oh0YPuiarzQEMsudESVDIlVXZzvhcVE5n6QENqMGCjOdBzmTP?=
 =?us-ascii?Q?mFTmOay92nT2QO9VLUIQjQ/AAKu1OyyF0L3DecfhJRyiHjUQlv1o3hge6nrW?=
 =?us-ascii?Q?tbb7mtYMsHTUiHPXSfal2nMvb4GKXPCz2qDC3xs1vDsbhwgdiz6KOSr+2UYN?=
 =?us-ascii?Q?wvqP09HT+1x+kxaZMQsWVRJ7BYIsKUzq60NETt/5rFiMkoeX6v9aD3uhznSB?=
 =?us-ascii?Q?mygPOB0ehvRZ9btllK3aZ3NREQ0uOwJ9aMTGMP6ntlq9oqYK1T0jq6l2+0H2?=
 =?us-ascii?Q?5nFsz9HMzLPxD4gZg8anWAL6+s08aRYmJ0AJy0NDU/Z5NiZfEc72QblSKK8O?=
 =?us-ascii?Q?vzjVKeyMcQwd8mL6cTdncJP7oh9KhNUnIMAbDUhc91bW/fwlI66JW3yTMPLA?=
 =?us-ascii?Q?doJun3xbaCP6QWYA4ZqsYoS9pZyjMteG4SQmEsnNQOsj0TDJbHfmhyCEJyqu?=
 =?us-ascii?Q?3NvJsCcv/1weE83rSxUyPK3TR+7bgTchrSHPXl9YXpPQ7jNwTQ8S2NgCn9cd?=
 =?us-ascii?Q?I2J9RFQAQriDft7CyZw8kbC21XaMyssfwiOKTtKy+eKVmIpClnAJp1B4x98F?=
 =?us-ascii?Q?7IRhJVuYEDj4jdS7HkKftngTo6G9HLVOjNAB4aZTDx8+//20vurIeZGnMxfz?=
 =?us-ascii?Q?K5b1eham928oH25DEB9IrCloqI4wfIH5yfoq5pgXt8SYEHL2rA8bswJWG8G8?=
 =?us-ascii?Q?mYv9bQ7lysMpCYHcXCW/76YiPl+p1iryZQd6s/N3P5mPrt28cfVMtmyB5OIW?=
 =?us-ascii?Q?JyZSlBgRS1jyeJYEHGEDAB84WFuClbIXRxX/xAm7KryTDBhHOZa7FImoFWDm?=
 =?us-ascii?Q?2YS738Bzi6l5sM5DvGNjlyNBvjchPdSpiKKtwiTLnhlSeLgbm/1ipIYErTLs?=
 =?us-ascii?Q?UmcG4uke6X4Ti6+/W0eTkafImGuLd3L2gAaJ4YoFpaG8P+QJUZmXR5y7ZYxK?=
 =?us-ascii?Q?k5d4sPe8CDZuxTtLKu829SVAW+jOy+ZuRem8CQBvzA+H1m4++g6vGdrvbhk/?=
 =?us-ascii?Q?B2+oVmW9Aq3rKl5EH5TPzFzXT95ehLiQcERN5aPckea6ywzYkNxfKSxEm0jv?=
 =?us-ascii?Q?feY/Dna+0x/hilaD7y/68VGN944qiTEV2nh6xFAJ97Xy50UavS++jpStMWry?=
 =?us-ascii?Q?ATFTWHNulAp8f5a6tc9INtaCv6DILC6TNuVJpCuCz80hcqMZsYN/W6Ma4t26?=
 =?us-ascii?Q?IjmsX+9PY8BP+nbzprOvGtDWQRZXEMryedZf+AFOQQ9y3NZ158UiX5VDRNyC?=
 =?us-ascii?Q?NF2TD6Z94S2jqKnijYz89he7wyhfsVHe5T2cmUJlrFHC1jYZauTRdCP84lLJ?=
 =?us-ascii?Q?ZIYY0OgEUcIhtHffZ9zVZVWAdXstaaRVZkvZfVSi8SaTEASEMl9N8pz+nSmr?=
 =?us-ascii?Q?fQH2Jq7MuedkKkM98OKp9IAbXvqBkEpdM2OiJFnMtrD8987EjRsX4u1HMRWi?=
 =?us-ascii?Q?hIxCJHHRke7MRMAAOqcBSSb6LpQ4pIBug1Z+gpzGE8LXLJ3UIh1FFSrmZAA5?=
 =?us-ascii?Q?hFZwmWjMPC3UrgCxnAXYVS4O6VwJGAkLY0fLN1UD/at/SZSb7dbhdr0g8UhW?=
 =?us-ascii?Q?InrgmiKYQcZCPES27mtVueW3g7pX8pmYWx7gkjX3IZG9P/dEsXGoDepJSBJz?=
 =?us-ascii?Q?ZMeVdQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9dae2f4-5094-4863-8f65-08de163d4626
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:15:56.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB1wq+q5ogcTBhrDsRLXgLcYElm/4GucMaLKbTMBRzjT7UfkoA52z18fTxTgobkWKJkKc+L0dH034rZrP+Fj6b1RDeCdMx1qdgY7x0aiQr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6700

For the following path not holding the sock lock,

  sctp_diag_dump() -> sctp_for_each_endpoint() -> sctp_ep_dump()

make sure not to exceed bounds in case the address list has grown
between buffer allocation (time-of-check) and write (time-of-use).

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/sctp/diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 1a8761f87bf1..5d64dd99ca9a 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -88,6 +88,9 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 		memcpy(info, &laddr->a, sizeof(laddr->a));
 		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
 		info += addrlen;
+
+		if (!--addrcnt)
+			break;
 	}
 	rcu_read_unlock();
 
-- 
2.51.0


