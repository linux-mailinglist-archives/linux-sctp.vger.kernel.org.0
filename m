Return-Path: <linux-sctp+bounces-712-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD4C0CEA6
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 11:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 705B04F028D
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118BC2F28F5;
	Mon, 27 Oct 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="IQ/6Q4LA"
X-Original-To: linux-sctp@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013049.outbound.protection.outlook.com [40.107.159.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB831DFF0;
	Mon, 27 Oct 2025 10:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560178; cv=fail; b=EcPV2zvUE47n7y8JftSAUC5C3CB658pC6tYsQETHDJ1OxxeWjVyGfRKeSZfFVX2NHoTWW5H5weq2KgJdEM09tTCYoKq1POHJxosjpEMJbEdAJTRwl/GJVvEIyxdpn8hj3ULDM+LoUncE2YSXlLj22sOAIdp3/hAJLHFxg/Asrew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560178; c=relaxed/simple;
	bh=zHemGpe9wadVAqZG6/fq9ZZQfRdwjK/o8hzmwaVVGCg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FJ6zvjkTNgv/8wIsLwsbdTZVZa8vq9n+k2iuK8gJeig29xXIXMV6rZBqBgtvTh4liU9MZlQdZxCfHP2uYfxVBe71n6xZcrjZ7LAyxRr9Sp5XvsjwfSBEm0JC0JKsLIEAu7qqUCYCUqaXOeHWAeTPjkUKLv/ON2ZYWLFeGDIlizw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=IQ/6Q4LA; arc=fail smtp.client-ip=40.107.159.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FObPoAKvKhrSt/GvX23gR9hU+e/kHkqSNSI3hDYtFo+jFnGtFQZn6BtnHxZCCqnXb0hZwjDDFkJqB909QoW8ftYAzMn2HXZcj3nBls0+P/SnW2OUKEQtSMDsMvbuu0Ib5dwFNzxOhGnH16cDXeuKV4y4yG7jdtL5SS4RFejsERYJGupD32QPfymrziX2E4d1JEZ1JHfQxQFmLOqLCgiWO/PM+gmbbq3YBhKMyXD3MKKjl0lGhKi8ucLcz1ot5iaDZRO88j06aHIigy+H5ibQfc79CUBNDiXCUP/Z9Rv/ZtXBep8V695D4nelZgYG8ZhsUigAZMdsSwrvYz3Vnkh3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWwgLn+/izdy91Tp4bfYi3nFcJRy365ZxzDd8FwLGB8=;
 b=uGYB6EUMqILH/AtyH9lBn+ZTa6kkz2iu3mUCLI5eK12TEKIKSc4ZZG3gzD6XZaJ47fBB4AUNnVqsesBHrvRzouqEj2OQrRZcq0R15yGuOoxPv0RB0gvTxb1bbO7Vjk5vpJtb2edGuCv43+GTDvYaWpTMMs+ucMwzO4cveoaRsvLbcok4T+SBeCjquuANWooXpMQhQRT2V1WkSUIGTCp6uHfxNuzx13QFHEQPnBtWgB6JcUZ3thTs9y0hwF6wrcrBeN1qK4XTOYtWKVyRsFqJjrN2HVDpvU30ytzTC9i4tYsK7Blg66d4txOp3HbCisnFtKGAaUSDO7RmD7IaQ03jqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWwgLn+/izdy91Tp4bfYi3nFcJRy365ZxzDd8FwLGB8=;
 b=IQ/6Q4LAvUKC/F6ecLFlHY7G3Y2w/R02elUtIDnorZ9MPGuZ+3cNpXzuBgTB4YgA172qK1N/l9TMtZo8J2rJHMHH1ZCc3GPmqiai9SsowlJfLJb0aewXNoqoc9cthkCn5h65xafdpPONQ8YG4lE9LLamWM+0YfpCeSXBcArpVn7FeKyMUJcYliUxlHJfKUP7ZKA/VTc/Xn3fu2/U9ey4GAsdZgqZaovLQhcSwM/ZiIo8P0Kz54yHMH1fAP9E5ll3TYy2jZzyNIFW1H86S6gG55P3ouHg6/Z5fpMO0VpA+bEVsE3n0sP+nBsTuxUM6PgUp6R9pZgBzNGEhfBQnxWDiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by AS8PR07MB8373.eurprd07.prod.outlook.com (2603:10a6:20b:444::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 10:16:14 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 10:16:14 +0000
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
Subject: [PATCH net v2] sctp: Prevent TOCTOU out-of-bounds write
Date: Mon, 27 Oct 2025 11:13:29 +0100
Message-ID: <20251027101328.2312025-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|AS8PR07MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6b2ddc-332a-4282-5f4c-08de1541dbe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?trOrmDMDbGWtcHZNAw820WYPfJeX8EXk14rhF6efWI7yTEGtXxi4lT5pmcYR?=
 =?us-ascii?Q?RqpxvmqsEYwvY2dPKIbAT8Me1x6n7SNvpG1aeGMBC/Aewbco7zyvoNSgBQ7U?=
 =?us-ascii?Q?m1nfVDP5BTCtf0YvAeYe6JMovmw1PAGJRh20I3mP+okm8LMPUqJY3ZC/4+b3?=
 =?us-ascii?Q?5IKudW8e3dxmsLw6fYXg2JmU03d6MEpzSvJEH3fPMyptXYQdGd0x0XB9xLXB?=
 =?us-ascii?Q?V2Jq/NIGWOgy6ohSSjnFwoKTTVFapGxv28biTqS5wFcqrOzLjDK1KR0FnMXe?=
 =?us-ascii?Q?EtSc61PqZn4Rt7Z2kQcqbg44Vf8/ptM4gV4MfIyLhjjZwSjDER3EEwB1u8/c?=
 =?us-ascii?Q?0x6FCLUh12SHWS0p4wIe9WWATVGs47oRaEsHMsoQWtQaw7xSCgqt+yvVl4cn?=
 =?us-ascii?Q?l2rsPHk2REaszHGtvyCaQsLAVgC7lNbKR+GM2xYfBJLsuQCQH/h6hXHpqdVo?=
 =?us-ascii?Q?4iDWvhTBd9HSIdSLcxPaTdKv7Y3WMRju21ssuSWoeITdD1qDqnFGzt44P3xR?=
 =?us-ascii?Q?j4cAEEgLTrkt2DkAwF2sKt0akqD4RJ8xzhtyLuNpab1cpzPPf7zoghFLtTDc?=
 =?us-ascii?Q?jPaWt5dIanpAarL0O8r4koUeBXoEA2Z5MYqvs8H91RxqRQWVj236JGWUnG2C?=
 =?us-ascii?Q?hFo7ENvwpKiuFagwSI2AJcioJ5/Ns86CMTAMRdRvuTGNocORO3qKFS4fXf9s?=
 =?us-ascii?Q?mFGZLRrB2sc+erGZ/fHdmmLeezK4zmI8UvKk3mIbVrOT4/LvnYYaIIhATczd?=
 =?us-ascii?Q?XtSiZVJ96eWyB9hlEs7Z+R2wUCNnuGixxgOXFSasdB1esoivTVGY/00zp3hd?=
 =?us-ascii?Q?sIxEK4/OwRm6aZCXuBaTUUn4kZmQxh7Df1viZZTpIvY/jkLyFY318+tSU9Qc?=
 =?us-ascii?Q?+fDRLfaUTFWL8ogEjjMaiId+/c8nqk1duz2U3xvJz8nwAXaTVFPQkv55BwxD?=
 =?us-ascii?Q?12EAiWmW78uMTFQsy3rQdjkUPmup54PKBShuAIFsWT5sdykzp8nVHf4AiOFS?=
 =?us-ascii?Q?QM0giLFkWuMNRl1cPlIywitFCiz4jmP7ycm4A77rpaTdaU3efARAW10WVjVQ?=
 =?us-ascii?Q?eNKiLRrM2Mlp84djokhVSW0N2fP7GgbIcGuyy5GzMsWuyP9Haq4pqQ/Fojpr?=
 =?us-ascii?Q?XI+leWcUld1Kw2HhXuDxrxKsSx+cZS27m9HZ7pt/qwA4C8HzbWUehGG74Zu0?=
 =?us-ascii?Q?By9d3POjn9Jq9Y9F2Qbaav7VZB37uRyRtnwjfXOl9ZwcoPnPjj5mggXhcd8+?=
 =?us-ascii?Q?s1P0WcfhNoJCmbJdQSM5nJEZI35SD/uIqUw0ZnCszbsxsSyrXAocbMuX/Eec?=
 =?us-ascii?Q?skbhdIOBfLSr8m4O2Qf3IVRvJV1sZFg0PcuN+VfI+GHcoaSzKWFgr8gOkv3r?=
 =?us-ascii?Q?vjIpXY2jo1OVawpbVbdqK6/UsYaPAG7i4IbIs/sSXYxmr7jTiA5MxZSD0c90?=
 =?us-ascii?Q?jGszegH0PDJx100qPj0tN9RpmGgLXJUQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0P+Y8dX8iJhI8/qgxzAcKR1dpGO8DPJeBRq4qPIa+pcTYT3+LhfwrIljDStS?=
 =?us-ascii?Q?o4pTGP/lGcgyhEQTs5a8zKLkmNr4gWng5QVhke+iDIdG5zOFranmAfbO5ssw?=
 =?us-ascii?Q?XpY9Upp4Bhhdxbz39ENzDNuMEa710EEhepAZfhMvkvyJXOprVFGut8ePgHLI?=
 =?us-ascii?Q?LbXFmwMq37uO8l0s3XatMRgKJjaaN3ovk8HtR98wib4VNG7ov14nl9KC2J9q?=
 =?us-ascii?Q?KwOOjNfsjpQh8/VCz7o5pJbP39NIKraVvEdS7mVTY100Qg39wOKqwZu6eZHz?=
 =?us-ascii?Q?//8p0QWtrdT7bKpzytYRCfT5l2V/SN/UFgiZdxUjQ0ctwDjcb1ZZVFuWkQ0M?=
 =?us-ascii?Q?kXikk1wb4mGR4S7Y3dCFOdz/RtO43YrlnFA4/dpKur2WyTa6Bc3rideS/G3h?=
 =?us-ascii?Q?2mL7bf89BbTd83R7VasYv3qnG1L24m3bEx8qskJjELqyMoORVDxSzf3HFt35?=
 =?us-ascii?Q?+dDiuB7Fx525oXI/CV7GsoCqd//VMadhysdHoqS1WaEch1lUTQgmlUftiSTD?=
 =?us-ascii?Q?LhBMi2E/CpvyfHsvPmc78mob/MY+SF5PGUX6LrgbdgqcYieK4nblawPdU1Er?=
 =?us-ascii?Q?d4Uxrgb5Mum3Y7g7yRQ2zLyrK93u1+RoOahGEYKcifwxtdoY1+alV9FlOL0w?=
 =?us-ascii?Q?l/XM4++zmmhdnbiwo9i82qAuAGXxwZIAMUT9twWBxhUKxXuCuyne8zaKP7z2?=
 =?us-ascii?Q?pIElbQa+BEOG1u2qfP0YsngtUKfLYIyQsX58SESMCg+wLYykTiBySQeOMYI3?=
 =?us-ascii?Q?ZjCweOzaQNzk5gYCYlkMPtquoAN1yfCQtKzwCNClu/4/M9cQW5IJe1MBl7Ul?=
 =?us-ascii?Q?09cI5ECmGWCKTCfnPpzgbMHJ1Ky8Bvf5oe0YQgzXVS+tqYp3rfyKOwG6C1Rm?=
 =?us-ascii?Q?1VWYuF4wMbq2rWlb4giCdpOhqoUtl2JcGxnjZ0IlVRUoky6L38AWaJ8j6fJs?=
 =?us-ascii?Q?JU5sBbi/3Uh23lmVV1gtW/b17yzId0Lc/9KSh7MmYTVR7RFZdahTDmfgQi88?=
 =?us-ascii?Q?cjm52XTkrbxsx0BgFKL4zR/nfyEi4dL+X/2+afgkUTKECm0941NA/PC2zR8N?=
 =?us-ascii?Q?7HMkKodclzoqsHbc27dQtbr8jfU8ZarCsOFJLIL4kHseq6n2mYesqXMjMOz/?=
 =?us-ascii?Q?sCnRpa9VuiY8jSru0hKdXH1cQpUlAMKDcOc03LoDgbMj9iTf2cFGSVXixtvV?=
 =?us-ascii?Q?cJ0dm742Gcj6zJvlcVYWUy3mChOPfbm3wEFpm0jE3a+YnBP2pGmMrG+Pm2G9?=
 =?us-ascii?Q?HHyoGVU3Iam4em6nzvQWnsLsIiUyaLairJuvVVmy5z8TQqfZEt3ZGB6e4epv?=
 =?us-ascii?Q?STLUL1whrTMBaydpYTSB6LZCB0tRQV8aPwcpkMBsk3uTpULjPVnOnyE1BUq6?=
 =?us-ascii?Q?Hju/Ho78H8KSGQjkpa4LKPasyXoGKQ4UuC3Qxt9BR725GyPO18Lq3wK1a7Z3?=
 =?us-ascii?Q?PbRXhjeZMxCDUblstPGUqHPiWoJ/WfF5jEEzIiviqy+huBVP53MeMo6DBRVa?=
 =?us-ascii?Q?DZ0wPrcNY9Fax7bAWQFLHRdPBOnqzEJVT8ZyjrNmH64eV3Wop8PKB7FZB8ul?=
 =?us-ascii?Q?gt2bJUMKCsyDF8aoSU3vFVo7mDXZ83iwKa/41OBIdKU6AVWYsD1aQgKZ4fRm?=
 =?us-ascii?Q?/TlRCsAcGPlYxF732sIKs340tz4yCJO+zrKsA7hMc4nO6RY2v9eSSyltmzqr?=
 =?us-ascii?Q?c7F2VA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6b2ddc-332a-4282-5f4c-08de1541dbe4
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 10:16:14.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XXAWhHIhMCZrIaCrzQOyV2z0ytBwaQlh+oU0c0EkfJe+uH55Lsm4Zf4ALXh8+naQFWGQOsxTuetuB/SxPdj5jc2YYvEnC6I/36BsRAALgOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8373

Make sure not to exceed bounds in case the address list has grown
between buffer allocation (time-of-check) and write (time-of-use).

Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
V1 -> V2: Add changelog and credit
---
 net/sctp/diag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 996c2018f0e6..4ee44e0111ae 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -85,6 +85,9 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
 		memcpy(info, &laddr->a, sizeof(laddr->a));
 		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
 		info += addrlen;
+
+		if (!--addrcnt)
+			break;
 	}
 
 	return 0;
-- 
2.51.0


