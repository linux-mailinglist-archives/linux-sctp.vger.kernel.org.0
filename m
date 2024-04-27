Return-Path: <linux-sctp+bounces-120-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A62A8B473F
	for <lists+linux-sctp@lfdr.de>; Sat, 27 Apr 2024 19:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1177BB20F21
	for <lists+linux-sctp@lfdr.de>; Sat, 27 Apr 2024 17:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB4C1428E7;
	Sat, 27 Apr 2024 17:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iDAVWsAR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2016.outbound.protection.outlook.com [40.92.89.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F613C8E8;
	Sat, 27 Apr 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714238637; cv=fail; b=eR1lwKNM4/XzdiQiySYABFJyXz+meAcifkrtdE0GVxmXTswv6o3zyL9Lzg97q/gbIj/MjzV5d2KH9lBfTqclrHJTTwbuOldXfg8sGaig/4swikOVEr192uMIQpRt2xUWTU4Ytxti0+gX6TMy5vpeoJRcujhgfxhp3P/kSIsk1jc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714238637; c=relaxed/simple;
	bh=UIWQY9UA7uNVXLIv0z+MN0djEWyavdwSTTb+Kjq0k9A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O0laRPWw8govla6lMiAFg1/K+kyclPp/n4qTbdLRHEzkrqrHk+K3L4jAIE6dmD2/eRu9007Qz6E7V1Qyw3dIp5Xi5vYHatU/s9NQB1buvPJoubdhGiohUsMlJCvC9AZ7pOuq0FR+L6cufZ0afGWLdzPH+f8vjMReB6H8duhlwY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iDAVWsAR; arc=fail smtp.client-ip=40.92.89.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhfjoBZ4onC4bq9uJGHJq1Ks7l0H+Liwuszk8FJRVwe2A8FqNlBJQkyTDB0E1Lj6oiMzNbr+4S5MqY6t9ZM/89cb9TQZMPWFH/FKbSnna7F2qACMaEkRNutW3HcpgReElCgsmjzU6hn4FvSL1wDnKYtOHsom1nSjfTEZbVm1q6v4csQJqdQlNpHmjhfshrjOLaOwVKjsRVPJgIFdqMsh0Olr3rhgNXfItD0O0LqNCyIs26/KgN52rijiO2Q/poFppNr3wH8LYeNB/xUCJbusCuVc79JcRRVyvQjuwy2o4LZau0LWSNZeFtWEgh/A0PUlBNiUe/gye/YK4fXscm1Dcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jZ3Gvlb4D5c4Cq/jIH9PccxedYYWwdtaM9/3ybmdpo=;
 b=YRZ3RahwsTE2Vr3JD6eF5GAGcu5I6umaES6MiqIqoA6MpE9Dgo+rn1WT/eHMXrNkobkIxn+HAGAzqk4O1qC1qEoeVB2lTQS15UWIfNh0Wq+G4iwVnJuBcz0LMWij3aufwTpsTvgUvaTAsOimR6v9lLtMC32OzjQSGx1IjdnDLP0HEso8ZdDXxxz8bL1PoAbnpo+dtsRov80jTwNu1iPh37T5KBm/7FH9Jtb+hqnMXUtEmB4Gg7yA+FuBvfJJNtvWHe7pWLZKdTC5XXOVSaqazx20eX5Ad9RogHGU5bhmuOYDiWuXhF7ENkG9hsX7KgpSLGHhweDlmcTwvv8DWYrr3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jZ3Gvlb4D5c4Cq/jIH9PccxedYYWwdtaM9/3ybmdpo=;
 b=iDAVWsAROzpPiyCvWjw1c7XEgQxx96G0GBWrWccOtyypheb2psaVLTlNXTObH0FT6C71tTG1e5T+G8zDtbXWpItZCSqeIsir28eQBu5D07/ogKl65pC9jqWQ/p6YrWIuttepSGrEAeBvDnpaMehWTUhuC7reiEPx3euWrXASyCYHmW6YZ8RwFs+CUYrEAKgSQ+uosNdCRNTrJcVlsVxUgNbLV37e+D01vHZi+XHy767uUGhMxTtQxQnaliGVUq0g9vSC0sN+tdR8hBKK3ipRaqdy667rYq0zjQ9lz02LFWXPjPwAvXMjl7IgR1nXsRBhqUJW+5tut0k+9fdjL1bSkA==
Received: from PAXPR02MB7248.eurprd02.prod.outlook.com (2603:10a6:102:1c7::13)
 by AM9PR02MB7268.eurprd02.prod.outlook.com (2603:10a6:20b:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 17:23:52 +0000
Received: from PAXPR02MB7248.eurprd02.prod.outlook.com
 ([fe80::4435:2dba:695f:463f]) by PAXPR02MB7248.eurprd02.prod.outlook.com
 ([fe80::4435:2dba:695f:463f%6]) with mapi id 15.20.7519.031; Sat, 27 Apr 2024
 17:23:52 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sctp: prefer struct_size over open coded arithmetic
Date: Sat, 27 Apr 2024 19:23:36 +0200
Message-ID:
 <PAXPR02MB724871DB78375AB06B5171C88B152@PAXPR02MB7248.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0v/QQGcOmY+BCxYMCxytGcAZGyt2+s64]
X-ClientProxiedBy: MA4P292CA0014.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::7) To PAXPR02MB7248.eurprd02.prod.outlook.com
 (2603:10a6:102:1c7::13)
X-Microsoft-Original-Message-ID:
 <20240427172336.11966-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR02MB7248:EE_|AM9PR02MB7268:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ba1916-d61e-4498-1d1d-08dc66decf43
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	5jXq2vmYjVi2yzwPetcvAdgacIgPx4jwcVhB13ldegyxQkraf+Oko+Oub5+sQMO91GjpaueCeym7Iah7GfmMHpLwLhlPSLia1TiOaWqkkKYnPwQ8nAWf6ADQSJTQnDNNwMyXVK2GUsZWO/59/n5UgPStCVgmGoOA3vg+cJwoGzSq9XiviyKFmkU7wqg9u4Lf61CokhVqHVc7dzzRW2i13oyI+FwhaFYgCk8w2cPxgAzjLt06KBRnDjAqbiSMWY8bNwkEJVGsCh0a5rGGLZuU/a0nBIZ+jYwiRbLsBG9qC/0Y5lNQaVvaz5b7bEBIRTayepO70be6J/vcntYBpiLGE2dtJoXGSqldmcVzrNdIVuACoRfUv09DEd22rtNN+VUa1oc89GgVBQNz6A3MZ8HjHu1WZ5uBM6R6Uu/3TKVmLJ2DUhMIN4nX6oZQIA1ORN1KZHjqwrtzgiOAE65Yp5xYpezbESUEIQgAZXWzVGhPj2DaNSYLHhvdo5IhdslCk8em6qBlZm41htqoMFVvJu1VSW/1vH/Uzysj6YpHX4HwHS63UxnWfi/l3rIVFWYxYt3oIYfRp/0O28ZUu2n07iR1Lnrtd/nAuwxfFQi01L0irf3DezDHNPDiQIUUIiklBFMg4DoSuIFfVWmnKuPq8ll4KjTJJO9yfJ49J1SAw38YzSE5R+Q3TUiK3SFQPgzNZck2fCc3zTX8PD/SVD9IwTBkCw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRSfVWSCUUlIHd/HibtuYjnPmCD4kvifXCXWJfeQ3pnYTia1UeHVNpC1gGsz?=
 =?us-ascii?Q?MvuHQQ29+C9BV0ykuPZJ1nJNF6WplJG1hufS19K5/8GPLl9GYHKt+SRfjxD9?=
 =?us-ascii?Q?JXiz2H28SVPKeq+3xqvE9cFio/YFYWVJAUbDGtnIjpeod87sZlbL8XHO0nNf?=
 =?us-ascii?Q?9CKSOhzgSzCExrZMIZY4GVIGV3RKdmG/tt5c/fE5gcMA/l9HnnkLKBxMICFe?=
 =?us-ascii?Q?SWpAC9/lQrac+YZ1GWrAtZJp4dHd0FatV4Zyhulev1QrTBF3sSHY4HF0Hseg?=
 =?us-ascii?Q?KLwY5H4gSnoEoKmzu9rj0lsrQ+KoaH3QIP86hJJQE8DpJsiNXZMt/IFviLxA?=
 =?us-ascii?Q?UXbZwCPKpNSdIIml49LQWEOW8/hwk8rWX8UYLidf/5UqjCBcy9FxkJqBYtkw?=
 =?us-ascii?Q?Y4cDYGWV7trevdmwebduGriEEJFcgFwnIIqwSgSFo58YH9U+WSLXGPPdRXPK?=
 =?us-ascii?Q?JOiVDo0CljuYuIPeWb78jkgnra0oVlXvA2suU8Tv+r3YKxFORBOyi/pPJwRr?=
 =?us-ascii?Q?usvmPq5G10bpYDBWORIaRvtKkfW5/m/MXrwUnC2gIkUmwUC7xtgA5vuJhAqL?=
 =?us-ascii?Q?uyMj18txMTm0gVhbNeGzCK+wA3h3wj3rfRgACMlyTATciH4M4U/Md9eWKaDT?=
 =?us-ascii?Q?YolR2NBvwpwkL5cXzd5iMjpcOtiD8DniNq2xqYZDOYHypjxBnwwn0n7Vax55?=
 =?us-ascii?Q?fHgvl/wgLjHo2HoNaA8UdoVLNHvEgMU3280vvFLLpITtoHk68dgJSwZ1gmq9?=
 =?us-ascii?Q?RcweQJ3077LIxqD+or58lrWe+1m5HLjp6hHvrz0RSMhNJ30mN/CA0VMCxAU7?=
 =?us-ascii?Q?bxqhUy06xRA9IhGWt7RA4yCLA3wP6YibqNqF6nIQbIAwYPeYg03gxvaAV6Pw?=
 =?us-ascii?Q?LlHpDggyzrJdVrtBdsFcHZKZCo1PUVidwuLsEkozLoCPFYz1MkJsInqfN3r8?=
 =?us-ascii?Q?twdXnDdCJmidyCB0pdaLEQeqIvhULdnqsmJdzVvi+pVKldnBCn3huXcp7Jo8?=
 =?us-ascii?Q?Mt1wzeDkAEBO4mDagb43CbZ8gEjEdcS13YU6Ll/4ah3ro3oBvIHeHd5t/CeM?=
 =?us-ascii?Q?5QDZl0U008d/TieIzs2dcKib81jMYVrxZluj7q2RMiJNcS9ZthDQeqvlotek?=
 =?us-ascii?Q?wKM5VJ8qnTSG5qVmJOqmAUWRr0CbNsKEGZ0bZtegtskBRRxTQWVlM77CHH6T?=
 =?us-ascii?Q?gRNVe9uzP0Ew4ehyFG6Apt+0IcDP1qwY8QEbhRJIV95nM4Z3icZJnF8aI6/B?=
 =?us-ascii?Q?JtV8sOcduWySK0epRFG9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ba1916-d61e-4498-1d1d-08dc66decf43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR02MB7248.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2024 17:23:52.7694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7268

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "ids" variable is a pointer to "struct sctp_assoc_ids" and this
structure ends in a flexible array:

struct sctp_assoc_ids {
	[...]
	sctp_assoc_t	gaids_assoc_id[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + size * count" in
the kmalloc() function.

Also, refactor the code adding the "ids_size" variable to avoid sizing
twice.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Hi,

The Coccinelle script used to detect this code pattern is the following:

virtual report

@rule1@
type t1;
type t2;
identifier i0;
identifier i1;
identifier i2;
identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
position p1;
@@

i0 = sizeof(t1) + sizeof(t2) * i1;
...
i2 = ALLOC@p1(..., i0, ...);

@script:python depends on report@
p1 << rule1.p1;
@@

msg = "WARNING: verify allocation on line %s" % (p1[0].line)
coccilib.report.print_report(p1[0],msg)

Regards,
Erick
---
 net/sctp/socket.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index e416b6d3d270..64196b1dce1d 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7119,6 +7119,7 @@ static int sctp_getsockopt_assoc_ids(struct sock *sk, int len,
 	struct sctp_sock *sp = sctp_sk(sk);
 	struct sctp_association *asoc;
 	struct sctp_assoc_ids *ids;
+	size_t ids_size;
 	u32 num = 0;
 
 	if (sctp_style(sk, TCP))
@@ -7131,11 +7132,11 @@ static int sctp_getsockopt_assoc_ids(struct sock *sk, int len,
 		num++;
 	}
 
-	if (len < sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * num)
+	ids_size = struct_size(ids, gaids_assoc_id, num);
+	if (len < ids_size)
 		return -EINVAL;
 
-	len = sizeof(struct sctp_assoc_ids) + sizeof(sctp_assoc_t) * num;
-
+	len = ids_size;
 	ids = kmalloc(len, GFP_USER | __GFP_NOWARN);
 	if (unlikely(!ids))
 		return -ENOMEM;
-- 
2.25.1


