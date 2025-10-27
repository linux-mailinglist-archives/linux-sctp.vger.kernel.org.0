Return-Path: <linux-sctp+bounces-706-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5EFC0C83F
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCD4F4F5337
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE502F60A1;
	Mon, 27 Oct 2025 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="WYnIY/vn"
X-Original-To: linux-sctp@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447F827F19B;
	Mon, 27 Oct 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554945; cv=fail; b=VW75HLvvx+IKE8F/uCTbDVN+NaqiGoJt+aL604AZb+cFOlqDoyGvA1RTjEsC7vUScZ+I3SaJm0JlD5bERJytXNXMLchQr08V0en5ztxw4Ch5X9OIoquC12rhSKY9AweHii9RofPLV0PhymOGjn6sUgvfTdl9YNIMd1UybqHUrVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554945; c=relaxed/simple;
	bh=X+3iIOanZZEQ2MpcTfNtqkzjgOkULUxGvQ3/oy6OcnI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AfFSOXW4Xzz3sOqJj5wHVJbNGh+eK1961l85+rF36oKezR8erGp6yjx0RVAxD5GMEACGG/27tB+JW8e/d84A0B6Wn1etZ2pSRdYTek8y9Qjgbw+vTGmdMg/8YuKRmHG7XrIfW+anTYDSi9BSIBTAtJjS5k4KY5Tap9Wl/s084rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=WYnIY/vn; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhRXVP+aYjC8w6KsIw0kkqROEqcjfNjuN5uH8X8PYDaMjwWGqHuYqIjwlEQp8XqsLYM6AAB9WlQMoFzJ9xHbCmntHQZD0X8LIAJ0yamtrI1NjxPA9TGql0y6v1HpdEZQ5x9aPbCH/BAV/ecHpHDwTBGLxSjBxcpI7ret7wacSpyBiyZZ9oxY2LLFwhsLbLps4c24J6Bl/yjXy5FGnP9D7J/t/boFw22UGoE+42+iCnctIlfuxUaaWUaLkIworCdq1QQgY78flfkPtBwBnLvts9vd8DqocoaNgpPKOA3vNO+US0sd2tBnUpPTcVCDGfp14mZzyjrq6m+jmFNKSpMgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9lTYqZsxRBPaBAg3bTDP4D4c07zA80ponOY9GoDhRw=;
 b=J507Bt1X3ilpwTH3cGQATZ6/orkoF7x7XMYn/WG5j/eebqcLQ2XLhvOrS5a5xIECc4z2CccIyi658s7/5BHNDE6lHDHsJH9OvTNV3ilTVlr+R4xMmm7LoCQZIKB5Vocg95ZuDY8V3Q21ILyoPuZcDC4AENXQVqm3nlvTqGKak/GUnL35hnSciWnBfBpJJo0Ffa+HKbBzIqlDqQBjqMcnC1VT1nKBL/wk6Y0HSSGKasO4W21Wv3PGampk3mMPBfqaz71j8D9zGyAMl0NNBUQL2ow1lI04rvEYkAG3mqDHv/ze9zEJX1BUi6MvTYTzk5nGPBudStSgdk65hxJK5nc61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9lTYqZsxRBPaBAg3bTDP4D4c07zA80ponOY9GoDhRw=;
 b=WYnIY/vnxpAqQa81HLCbeGAyLFnkiVUv3yrPWLIfrpFFweDuJZXfYYjMwVqxXpq0onVsLL3IKeAzC7FMp88fVsrfMttwSPWGGOkYuSp4b9Tqpw4UuwnoRUkbcGXGcmIvSR4/Ysl8HVUDQr4Vwk3T0rsNgKpQTxJha6PiJ1kd7cuMqeaEM+aoJjeV1NEYB09tjvFWSceclZ92tJpFtQIwst/zZ2zaMQwQnXwDtthcxIlod8r+nbRKneHRw30zC9cRMVeiuoVZRA4/ILVeikFcrrkEee2gIdg01MN87z49zX1QkVkE/Jmt2s0PSAaRDgZ5mnEbz2Lioli31fodwJGEOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI1PR07MB6448.eurprd07.prod.outlook.com (2603:10a6:800:138::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:48:58 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 08:48:58 +0000
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
Subject: [PATCH net] sctp: Prevent TOCTOU out-of-bounds write
Date: Mon, 27 Oct 2025 09:48:35 +0100
Message-ID: <20251027084835.2257860-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::21) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI1PR07MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 36611bc4-ee28-4779-dc46-08de1535aa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mqkFfSP930DqZ2s+JKG/IuyD5yxZU/eWabyJcszgFLH7reLbSK1fnbF6Vlg+?=
 =?us-ascii?Q?3n6igpVwDC4wowNNqCgG30kQYEh1vc7BTigw3lgNvYBqN4BessJmqKx5on5k?=
 =?us-ascii?Q?MbMEaBRytDF5ryDfYOdZbtN9GLNwhZ98UgCbrIVQgWCTUz8W94ooqaa/tI7n?=
 =?us-ascii?Q?EFmlUEjDq3JA/k7K2iTI4vvdavcl+WEdNk9rKSfGUq5rXqesXZZuc6rxbN2A?=
 =?us-ascii?Q?ytoM+cCoTH9J8Eu0vqknOsgCD/o1rsfKV7dD7OoHNFMal/0R//bI8qfWtkkh?=
 =?us-ascii?Q?jwwCeqeunNN4n86oPrmKyDNYdH5oYQPq1jJ+zo3ZZ8sw2liI6TrjJy8JHfw6?=
 =?us-ascii?Q?VhHEOtuROWOe6XAZGbBD612dy18rp0XQxL/HNYJUXV+y4ie27hYUKPYLhmXG?=
 =?us-ascii?Q?oVetZpK710Lu5+cp+eAM99KCxzeEkKKSsnU6kc80Yxl62qe53FbygbEzlOOs?=
 =?us-ascii?Q?u7RUzdVGC3JubnrIyLJY0Nhd0O49M0Toh/qABFHqSNWz2OB8v8/VrD0u9oEA?=
 =?us-ascii?Q?CJUjnuoPWftWWAw4aWMUOiIB0GAo1L5haI8q8fcYvcXHewlGE9Y3RE/qhYen?=
 =?us-ascii?Q?eMaGfR5YNt7ckL3PLJDDlEHfeinJGi8YZCDH7mcBCFjRlI7aVuqaCujebkUy?=
 =?us-ascii?Q?uFlSMlAM304Xv2ZzSnb20BVgOGL5l4Qkrjwh+VceAHdlTIGYGNgBBE84FKGy?=
 =?us-ascii?Q?AKMaoasmo8paizCXEFFEPujjOtoMN9BhG7OLkZhX0jOhwRw6U0LEBaNZTOJw?=
 =?us-ascii?Q?f+h7PR8p3k6Ni4iaJPkdkLqbI9LZF4viuFXglsdSvWkg3l4X+koQHwS/hzeQ?=
 =?us-ascii?Q?n3ZlkOEH510Ux/KIQBGFEp/GcT0cayvUfqMY0WKOM+fA3wAaw9FV9Ueni1/f?=
 =?us-ascii?Q?ha1AehBiz1WgnFl+CTkyKIg9UhwmqxOnAjHcBJB+VQv+5drF1W7r1bRXcTvJ?=
 =?us-ascii?Q?17SWBHIoRho7zzv2kzcZT/Ddd0YzhmLvx4qE5wRaLY7oGTA4D3TW6q9rB1f3?=
 =?us-ascii?Q?OQtggMG7TS6GwKtYXsTzXiQV0qNLCweJAaWPZc1amfXX8byfLkofBV7scG7R?=
 =?us-ascii?Q?ttlFriihrlSG7MaGdmxGv1hWdpM1SQdfBAE31NFn0dlb1EWZxMpT701E2IGn?=
 =?us-ascii?Q?MwpEBpddyBdNM1K9TFoedmnvOpOLmS46TvFAHlwZqcLLU1UoagLuqWb6D0Ki?=
 =?us-ascii?Q?cQ6/M7j/ON9lUbUiZ5KLQqc6sNBtq/NzTtacB9wMCsLpR0mMnZzBgBcyRBcZ?=
 =?us-ascii?Q?dsA5uwyYMJWsAhW8B9KK/KKT6riSiDq1a4eW3DUhuuZx3Y3eiJY3GT0qQz4f?=
 =?us-ascii?Q?+qBch0CGZ0hfhygMl8ZFJHpgNIK8Tx5kEBR96x8dmdZscFSdSkT62shYEdAD?=
 =?us-ascii?Q?7YoD5T+i8fa8rUlUPlke8fZVcrScW0AD8yvoQPAdJOYNaRHNmSH5+APG8y6R?=
 =?us-ascii?Q?DDNjVqOsvNXSO1mq3DZI0WQFJ/1REoGd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNLGFSHqHe7Iq8d/SVKQAAdzSdLnKRTtwSbMj+CTQrxfjJSQQdWaO/oPVGu4?=
 =?us-ascii?Q?dDIDtnk0ElbWWj8Lktod6SYtf2WcyiRIwydVAiUs/SsR+6cSYuG9M1wNGbL+?=
 =?us-ascii?Q?KF+EXOyVGrXQ02zO4D9a+2dcMFU2j3Avx0UaFon97hHG/LLUgqKk5WTfROzp?=
 =?us-ascii?Q?04fIwXQA9I9ucLHQfmqJTYO79z/XeBp0lvnup1HyBBVKq2+lXKU2PbxP3S5i?=
 =?us-ascii?Q?oAVK2B7vr8GNF5HduJpHf12+bc5131ejCrT+w/bkqMKPQgpit8YXrD5EWvMK?=
 =?us-ascii?Q?JW4H5mestoEXGIG6qA+jHUulW8rXvQw/IJGr9bS+fnoXWtEwEPbWak1Slga5?=
 =?us-ascii?Q?mtWIUHC8ENEsb5QhzN4fgUUuikPyK7JKki7bBCYPQmJSog3nwlMopR5BS/tc?=
 =?us-ascii?Q?2F58AoWiFLHjiYSHlbojFWpaIA4ivZhLwqVlUzfDr6JkhSrHN8hFoxH++EAE?=
 =?us-ascii?Q?VCE42Cth2+doqaAtVhvYOgk7cikY5tjvE5je/JnQJkzoNfRZaaAhCxFaziSS?=
 =?us-ascii?Q?MP2uA2q2kDBUOIXtFL3tg+neA3Xsefl/gEf1/bHad4Ko6rwl5zzE+e8iEMCm?=
 =?us-ascii?Q?AWKtD8a+glZjETEPQMg0ojrQuhv23XpwFNzCEkaz9hK7tnRtN2AW/2407wNk?=
 =?us-ascii?Q?FiM6gULzyf2B8GJT9D7YXRfrTLnN29bpu18vhkFCZ5cA9mjXbneR9G1MPnWV?=
 =?us-ascii?Q?sW6QtSO8LmizE8hrzdiULLlfoPVeAYD4a6UnhrbRsj64xNiipQbbL54cQaUA?=
 =?us-ascii?Q?pO8LFcUDUFFbrWFKKsxmBLzbAnGAtWdfKwz7RM/zHnJvqT6J0hPtwxU7LsI0?=
 =?us-ascii?Q?lCXr+WU6aUIm3eul5a0n1Wzm+w0LwRnAwR5OqDnqc6K93Mcd3j9/w47yE9Ex?=
 =?us-ascii?Q?QAs5JEddOLZMDvqSTvPJfkQqAdy6v1Q0xrQfAdnExu8O5aMxoPiEH3DKnMsC?=
 =?us-ascii?Q?AxwWOxnufQ05PZWGEH4Pw16Dlq3BaCsDO0lYMtUE2cDRXl7Ci9ge4zIvIDpO?=
 =?us-ascii?Q?Ja5norfNJlgikQPAhGwDZKyp1wjaWM6+ZcpMJL13FIOA/Oxxk4pE3cEwKcd9?=
 =?us-ascii?Q?AxPdaCxURWWb1JBGRBJAVQjtq10zXUPj2GkiamvYzn/X9A2yuOUF7h9s+eVO?=
 =?us-ascii?Q?fKfg3YMzeqxQywFaj50VUQwUaDZ8lSM8X0rrjUaX9+M5aKmC8rSjsVXo2h7/?=
 =?us-ascii?Q?ESMuzSt6Zm2OmTk8DJhgIP4swds6HsWse/51VkzEIDCvBHF24P5AlrPOM6Vd?=
 =?us-ascii?Q?g2i6hzHmCEZVJ896YGinVxiTlnysWOXK0ceNnMcysdYG+GlrDI4f+EkOs2jc?=
 =?us-ascii?Q?HRNJHfqejAGyLyTanRuMdalvTyfM8q1p7wJAZB80CS8INiewvagr8lzOZc/p?=
 =?us-ascii?Q?DW6G5adVxSB488rjfvnCixZCOFDV0utRZOB6b44IvodkdtsXbYHtzhukrGmB?=
 =?us-ascii?Q?GeS36qF3lNp9Kdqzfu3UHks3nQd9EGmLw4z1ROCViPltVxzef8Qa+ySLi4G8?=
 =?us-ascii?Q?2qXUryJ470Z+7oiGL7hGrY6ntRCnKnIAT0Nk0kgLAx42n1tDFNmfHd6gRt85?=
 =?us-ascii?Q?IX6Kk+7gFSPUDyePHYmFgBLOBgbxDQb4d7xFG4T/iyw+SpSAJGUpyCkdWX1P?=
 =?us-ascii?Q?DmbNIUNK5o04VbFtxBuu9f7tKFxX6Kbv6YGNIOFjjFaWFs2KVTAfOTYhr8C3?=
 =?us-ascii?Q?BEK2GQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36611bc4-ee28-4779-dc46-08de1535aa9e
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:48:57.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nmx3UBFaPC7Tn3oZwbBASBVifQfEsIEjlYy357BuPjwhIZ71TXHI64DGyz287W6cRe2ZT4vd8SDkIfoRbMjEoXAznmgErZUZ3PtDVm/IMvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6448

Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
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


