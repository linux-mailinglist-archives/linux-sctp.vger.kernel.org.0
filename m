Return-Path: <linux-sctp+bounces-146-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF26E8B8EB3
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 19:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EEB1C20D47
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 17:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F9213FF6;
	Wed,  1 May 2024 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rOtq+lVV"
X-Original-To: linux-sctp@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2104.outbound.protection.outlook.com [40.92.75.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CE1F9EC;
	Wed,  1 May 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714582905; cv=fail; b=IDuVwOuUm+9cb/Zk8zh1MHqpEZdHaZuxqRCf1272EiwgNd6Y+ueTAG32AzZOlYgvRoR0BHuv1rkY8zdPTiMOOOrPZeqppuLarL7YnAranAt+F39qkgjvEx3Kejt18iJf3l9ck21el5Gj4V1cw7SlHs9KdBYQ+kmizUr/5WCOa/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714582905; c=relaxed/simple;
	bh=pCO5r+p4FvBcSUCl96Nbjhrag6fEjrbxi7uWE7nxdXs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=os2drOhWR301y//uzrgGHN2LoO2pWdPj1EZuaAoJHArQ6EEfmgIc9Suvu+Sw1zFqL393Y6vuDUvdFNeKHJVHWDP+ro+vNQFuQPKzV7orkhG8zho+QWTn/ffk4DKbtBA1q0pBVAs0cZS1MA/SecJaOHc5i6lEgJKZWneWfSNyBGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rOtq+lVV; arc=fail smtp.client-ip=40.92.75.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMZFK5cwR/aUigwBCTDAWLd8/RO0WnrO8I7Q1sRB7aTPFsuNtIX6uywyqBZdT8LnyxvoHOOTKh3BZH8ZlWSIsoigx3A1zRYYJ6iDm81Jg98QbNJs9RZkNZa+sAJChn718qtC5hM+HJd5Or/1KHEu3znF4ZLrgIPGeA3oyQ5Li3p0+Ke2utn1nPKDkg6JlV889z80shJz+YTUhNOnuVbEryi8suJcLIZyZRUej+OB9UsEPR/vSKvW35yY2SBqqCJrYM07L8xVlasLefUCR1bXwXgY2cRyFlSbdlI02kwb4W7ibFVZsvDoitepYDb1B88CAJwjsrv1jcu1uR8HADRyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7mlIKZRJgwWXbTjrNqFugqoH0VppYOj/q+IrmvAl4c=;
 b=bQ9IIUpB+s36s/IbS7WILv2cUXDPyvGKNfMaU4pvEbWih4FjhDBErM2y3lIHHI40M/5mYrBlgihpGVsKPxdhosHirOqtsV3+Kw16xjIe7aYFjb16J3BB6UrUQn7Pw5HyqZr8uD4PwNu/7WQMQD9EhL2HW7vK5jA5rkT7hwu90zEkzBHq751XkeNEKpaX6eDRWYMjoPTUacY2jibbJdaTmPUI3S4nFJEwlr5PIuRiChslX3fExHUaGFoRSzfTgm1n4Nb/uwfzrpXRRH5B2/kHsFosHAmBP/rOIJmJj3uEliEPONiJCkSKVlKeOYXA3Wr822yILFSgs2H8OGPFGYfmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7mlIKZRJgwWXbTjrNqFugqoH0VppYOj/q+IrmvAl4c=;
 b=rOtq+lVVMdXQN9Zj3JmLQ2FtDNaUQsUqX/2OJbzm9cr/IBzZwfUXqCvuajeepONUBejnw1IqeOjOcA0DoEtxQm1Tvx902LayBIQwjeJreM/MpwwFV47z2Y64AIAlmnADeIj6a3szUhWVL4Nb66w2iryNV1CkS/tjC6gG9lYYxgsg/w56BCXg82dZFA+NGYnt8e4dzG6ev6Lw7NLAOuc9bkrdFHxdjhPPhPteaIVCS4+XkehoCeH1pnj/rhaoc7N1tUC75b/7ub3hMix78GaDVkPAS2NpbZnN3en3i44639Ejb/eocySihOaGEFvGiiPGbAQ8AMrsz0XIXgaZtiXN4A==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS8PR02MB6919.eurprd02.prod.outlook.com (2603:10a6:20b:2e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 17:01:40 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7519.035; Wed, 1 May 2024
 17:01:40 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] sctp: annotate struct sctp_assoc_ids with __counted_by()
Date: Wed,  1 May 2024 19:01:22 +0200
Message-ID:
 <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [a1EBsiubbstgSOqbilm2qzJT1oUFrO2T]
X-ClientProxiedBy: MA4P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240501170122.4901-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS8PR02MB6919:EE_
X-MS-Office365-Filtering-Correlation-Id: 7692cf13-4e20-4313-5678-08dc6a005ed4
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	IG3AXHgw2lnDYgVMA9e35ggZBdk5uM8AAlF/FkQyJWehhGUA7qTHMStXQSG7in67iY6Z2uC3pslI1xPg40Ndw1C6BI8LohSFDRL0qZ9AB+ksbPMQwpi66DEaAe56wqrjVrXad6pEIq1qSC6q7x4yVegASqPfdgRp36fHiID0Sln4Jx0zMIK2+fC5qYkhzplaFaIBgY8lq7gUOrirCL+4IFgWBZEomIm0+lrE9HRyrpxHqHIQwXOKQTy/T7gLd1c1csQx+7vhCj10hX4HpzsrxzYOU7mQSJlAz9VZoWXB2q8lSE/xS80pkpj9MKd0mODhTiquubbTV4uQF3Nb5r+QWwP+SFlCpVfV++xl3Wz347XXbj1Q5Un3htJNremCfJaga54ZFG7Xr0BqUUkrGJqF89dw5e+lrZXSYJ0l1h7D2cq8ZSxXsyqoFfN18nUpNcdkyT9icE+1wTLEh4qhv7New9Qa8yr0OxZQQ82HuJkyYZQobWVjKy0lLZpjmnPawjOErK8RByTZrre8ubHVGCr1ISQQ6/tL61AVeKlPgqJfvk0s4a44TTY0y2r5xKSkzAt6/c/+4kUwXy8W0TffmxB2sXrdhIheUDnS/shgSHjrgZOaSnpYlnb0M/MsTlylTqU3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tzh4PxgKV0/q3UuDo8LCV7D/INgFcpKruzqxxlQqjzKrJTF0qndO0aqS5HQ8?=
 =?us-ascii?Q?XZ6ob9JRvOAnFoSc2nrdJdEGQEchmneYwjprzYUCVfWuYL2RLxl20/wAoNKv?=
 =?us-ascii?Q?OxrkDsvwQkoVziJEWAma6uWOAHSX/1TwCrVSa/aTzM0BTBM6swXMwqgOSw5b?=
 =?us-ascii?Q?3xyjpSDkpdbe8Qou4G9YHBYs4w2B5Rex7K9+ciGFIZlVcFLdGIG+uK7jCOk/?=
 =?us-ascii?Q?X9Qy+H0UOJCdMzFnn18kL2lB5afBfQ1lCpFTv8Hbt6Jt4FKYyCJS/TQz+CxA?=
 =?us-ascii?Q?hEBJfj9BxCXBG5LeAiC07VsuwxzsA80GdvSkPFiwMQJsIgvQaclZONYdjVRR?=
 =?us-ascii?Q?ocYNmpWCjugLFS6RUHBW+ZC5BS1btRhzPQiUAXz54pZ4mPHIoiSMs1ufaeIx?=
 =?us-ascii?Q?elzU8eG6eANt/WcIC/rNcuB8ISAFRz9m4b3KaZTMJqQTnmi4eu4friFHa2LD?=
 =?us-ascii?Q?E1hMsy5Wg7BKmAlF12/HIOaLeDf8/h+LgcA/qmD0tRU8vn+niP5XkorlrB22?=
 =?us-ascii?Q?1aS8uTOmuA4SvsxE5EzOr2CKf0dLu//Lk9g8qd60jhEEVeBoFlNq/kuqWNOC?=
 =?us-ascii?Q?Us7VmO6JQknBjQVPasrrduGFtPLJgStkRJlbvpXpipDDZyGxm4wN+pti/lst?=
 =?us-ascii?Q?du3PZlKlFbIM/JNiysYfpnw/tLV1npBvKipzhfGFwu2v6cJn4u72KCPQFtM9?=
 =?us-ascii?Q?yNbEqLC0k2W48DLj9azuZJ7hpyiGgG9st239lIsnl4qLU/GgNyNsZUervx5j?=
 =?us-ascii?Q?Zu7kI6T/GTrJE5hw/URMLHw5vUV+87EKAFTdh2Wm/7/HZ0E7DTW1urK/3huG?=
 =?us-ascii?Q?Af5SjP2+4o7g5wqo+rBpR/qPFeB+uJO4mJIkatorvkMgyva0DZmBdIbf3j+B?=
 =?us-ascii?Q?dQD+STl5r+VLm0nO3YXMzejYw2f2yiE7MSZZrprhtYzgbpLuHkU2aQ4bYRiX?=
 =?us-ascii?Q?n/DI5GRD1pBpC74UcfNHrxQYvPS3jewOzjc/HPcB61aK+QmdtDI5DdYT8FrL?=
 =?us-ascii?Q?W8qjLKv4guSqIGe6die3wtTvfQC9S+egivmJ4J3Icw1NzYFk/5vJZH71MA1g?=
 =?us-ascii?Q?bJNycFlWi0QHMf3wbt86R1+4pgupb3evCGYzB8pKQzKWk0EIBPLQWDrNO0Aw?=
 =?us-ascii?Q?f1Q5Hg5i77ODP806HhERHCFcqXYLIGP6OgPkTDbYtMxYk7uI++mfI/D3jsRI?=
 =?us-ascii?Q?Pe9MMuGQawrOMJwOcMIcPIupzt7lKL2roOAm7M7CeBw1cUBbyjitBTg4cpqq?=
 =?us-ascii?Q?Yof2/fID6vAgs3NnIG9d?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7692cf13-4e20-4313-5678-08dc6a005ed4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 17:01:40.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB6919

Prepare for the coming implementation by GCC and Clang of the
__counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
(for strcpy/memcpy-family functions).

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 include/uapi/linux/sctp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
index b7d91d4cf0db..836173e73401 100644
--- a/include/uapi/linux/sctp.h
+++ b/include/uapi/linux/sctp.h
@@ -1007,7 +1007,7 @@ enum sctp_sstat_state {
  */
 struct sctp_assoc_ids {
 	__u32		gaids_number_of_ids;
-	sctp_assoc_t	gaids_assoc_id[];
+	sctp_assoc_t	gaids_assoc_id[] __counted_by(gaids_number_of_ids);
 };
 
 /*
-- 
2.25.1


