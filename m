Return-Path: <linux-sctp+bounces-718-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D0C15C6B
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 17:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC5E406263
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 16:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979762C0286;
	Tue, 28 Oct 2025 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Rnan+xA9"
X-Original-To: linux-sctp@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013030.outbound.protection.outlook.com [52.101.83.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D61274FC1;
	Tue, 28 Oct 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668151; cv=fail; b=MuK+CfQjHQkeFW5pefBP94zimOlB1uaL4zpEL0T0DbIoh55/OHtt04oL+oliTeqtXoKjZx3y+nzLtydnunV5o6sFfk1TlngxXlujpF7k42yxuHreZTFbbLr5w5cg0qUdvy/niiP2hNnbPdr9CDk/2vAWFuXf5s8dOqQGcWZRgng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668151; c=relaxed/simple;
	bh=15Uun+TfWPxE9t4ZBi95mdLDPVZqukoFneDOFkSCuKE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=miy2UYWi2v7SwxF5n2bVKktgNCUqHBOhe4hjLHBlU6fi0GMjBKA/OEQl8jukdAj1hlZmept3cn5Ir/Gc6/WuFpB3fDN5coDay2FTP0XsKWNgxWsEG7NEfYPAhqTBDhq2ofi9sU3yUpzbKlzMUaNTOcMzFYCFDFrnxFLi4UbZv2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Rnan+xA9; arc=fail smtp.client-ip=52.101.83.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgBmcaXZk3H93NsQ9AbT5x1GS/leLg8qjZfr8cIqG7JsE2OCgWwWQ9XRNOA+l9S2fmEZQAeutIZnY0g/sP/FfT+lcQSCS8Rjta446pSeK3BTaIfmrERWNwNJinZ+kc4B6Dvdwpvh7JsRYBWBQMP7/VC9MO0vKqnbla1lDznTp4WWFZKNbF7aj8gJwHX0bwiYwA+C+gTBS5k6HM29XDQ0ezk0kqPnuepjHoN0obucWnXvLeqnfjFNzgY3Qmilys5vx4vkxYt9cdZ/qNx1uw59dlaNEsU1BHCqrcX7he3S9E+fbz5TVxVcnAw9Q32Qa1mm1jlVqo96c+hk3h4JNnqJfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sO0BuLF2bdggtBOt5cPXgU6xJJCPNIDkcLNFXrCL6Rs=;
 b=ZRsSjad5y8Tb/6ZtIPet6v2SOPKcehsGSVqfOCFqkAHNwTd9PCVE9yKy/C4Og5V329WriDCAMVE8GJimrQ1erLqvpUQbDmWCsbvAheOG3/iDlxFHeyCk5QKcp3b2xWkY1IQKarrRVoevHU0Dpfod1Zm6jx0jnldV+SAcrtv48uAb19nVjuQc9zqeFEDmjVD+/Plp8iXXNlhAdjrOxMy9N9RSUz2wF5lzhbQbezHf+9eujadUG/uByeII/G9SFPCmeLAQIcaeX6ynZl1hD2ZEXGqLZxvrD/GQrg446PWkR6zfpj4x90v34MU5u0QpEVtKW76b8KogcVxklJDNWfbxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sO0BuLF2bdggtBOt5cPXgU6xJJCPNIDkcLNFXrCL6Rs=;
 b=Rnan+xA98zAP8rC6SdmocjqknviQi2Mxs0E/ajdn6sv5TxukowbUz2yS0ZYQuKhunLM03WOsFyAOlQoLhCQrT8q1qmFISAgQUBqNyqrbPXVxv47nUT/jjEKwUxyJoUIBBzVWjLuXF4keNY0sCrSUqi0Td31nLq9d8lWVuGRKPOcGYyR97k3D++XSnZ38QxZdQvQGlxSy5lSw9UR8eI2447ne9NPN86aIcaDjRhgrlsn67ROLv8/o7+9FN+L9fkvd2uU5vLrjBDTSo9ebol1lNnuLupbEcQIF6JN9M18qFhTP3pnAoeNATd1/y0n9QZoogf9gLva3vlyaMJ/IZ9S0Pw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PR3PR07MB6700.eurprd07.prod.outlook.com (2603:10a6:102:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:15:44 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:15:44 +0000
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
Subject: [PATCH net v3 0/3] Fix SCTP diag locking issues
Date: Tue, 28 Oct 2025 17:12:25 +0100
Message-ID: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-Office365-Filtering-Correlation-Id: 8275411e-bec7-45b5-b5b9-08de163d3f1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTQDSN0MF8ww6byzPfgRDf1diCzNYCsvlLZv+9cxL3uJYLA6yRoc0rNtCAjw?=
 =?us-ascii?Q?ZTeBeHvTNoRsBvRZ6LKiA+60Yr14kspxrLRAK1sQvp3OrKXLxkaYrWSbqpEX?=
 =?us-ascii?Q?FSVHEe5Ew5h+OjsZgxJlp5m4h9yh/OlNoBUeGNRpJqvxXqQulTcRAMaJCsQw?=
 =?us-ascii?Q?gII2mZggcMSzVbSs6B8vRx2yA/V9FpAGq7t8KJ81YBDeKb3bHza2RpE+QI4T?=
 =?us-ascii?Q?Jqhc09eKP+Js1xiLNyWeDKhWCRiWUt81C3JvnPzQwrDvJQR6ZkN6m60QH4qi?=
 =?us-ascii?Q?ECQZSkTtz00tICfUHqK+/ESTDfNVb/bVquMw+KMO78ignGp5ukt2XUUlmyRE?=
 =?us-ascii?Q?I38/L+T+gtx8CXpAKCnzbyNWB0EMdjimqquvHcCPYUzECYi/6OWBRZN45Jxo?=
 =?us-ascii?Q?ZEJtGJMHitWD5L/tnCdcOUKdb/xZzI/8vUoksQyJyDnWhN8fAE0wXQ1QvYUj?=
 =?us-ascii?Q?vc7PMiNoTQ8A9N8klvxZ4VII88682vuVgMVHLbmP2p08XzMkYfklAkngUncR?=
 =?us-ascii?Q?96iwKLfa3vRaX+6wheNDpiDtWKX2NZ6wzGcZeSA+Is7BEbKOZe6UGm9bDmZ2?=
 =?us-ascii?Q?HPLPIZkRCnrKpEtzvKLY7AmF0oHwh1Qsryol2T7Affd3KvaPIyPeNLNIuyXG?=
 =?us-ascii?Q?kmc+5WHHEw3XUkEqqdB9dOV6baqIvvYDJk6dlo9qGyl630DtBzVuZ32WdJQR?=
 =?us-ascii?Q?L8av6E9O/FtSfRDFIDYWKBOUbFnvwzvMGBfuUBtMYx8RMPu2rv3zu3jMJoXs?=
 =?us-ascii?Q?dWePFOrBgzDdUiHxs8Lz7KdGvyLTGRKo0sF36ZnY8ozZqUR3K83FDqI3UilE?=
 =?us-ascii?Q?eblbk/8dO6BmWwx6AAQ9ZjouavFbRmRuTKaiqo33k+ov9PxiBCLVqpadDG95?=
 =?us-ascii?Q?RVXQ+OfyuY7mv8ye4xscoWdj8/PyG+o4egBj4nv+jszlqRK9bqpthZH4GsFg?=
 =?us-ascii?Q?CeS7xShH4vwNab+Oa/xjnlYHFA3rAji6A2mBxt21N3kg9aksyXa3D8UqYG5S?=
 =?us-ascii?Q?3Upy+OY3DPEfgXODKt80kjRazphM4ZXNY6KbtBoEkFAsb6THB3SPcPkx2umA?=
 =?us-ascii?Q?wruQVGFsuNh4dgC1yNBQscL8e0R8YPxxlAHfkh4dvDfR0BpSTQ0L9s8TWApb?=
 =?us-ascii?Q?VPWiiDp7shykhoObqpVOLVhRPs4Yc6la+NBBLLmZIqyaSBQkFbM87yrykCrI?=
 =?us-ascii?Q?6eTQ3b5U4j+2W+D7vzx3BqSk4wcZ2BWOHbMi5aB/BCBbeAWtmxzI2QuRWQQl?=
 =?us-ascii?Q?KTf7RKiXeybifxWbgFMfk/Lf1BSv1YkRmIlcNxYmo1HaPFHiy8fTXE45g83X?=
 =?us-ascii?Q?nImOjqy9xiZ2jqj+oyvlHa8Lr7scjGSHsai5N4aSfXZpWkz12TApWO+5uh8j?=
 =?us-ascii?Q?Sp/UmX0WMKvtRPLxDf5pqTg5wTYmJPUlMjBRbadb5o46CmU5xBELaJRKCHBs?=
 =?us-ascii?Q?xv4FwopkaIds5Ga4Xl4AnBAHlGOvlYIEzcz5M5LWGZuMM+33F2Aj3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tyykl+qbv4pWeHQnvQMtRsg4vD2rmQlq1rY7ITXPwx1eObTYWm3kg4Q3xJQR?=
 =?us-ascii?Q?/sc7CF67krjwiCIBVJJcGYzgY/3+HvT0GX7s1H4XIkNvR/Yd9yINWSTQS8Rx?=
 =?us-ascii?Q?a8v9WpCGRqFlAXkJo30ik3py1zq1rDAE9bR2RrvVeLEshnIf91XHC5fM5/1s?=
 =?us-ascii?Q?MOjmnqfUEO3zJp9AK/4GHdW30a4awdAcDlWkdREf2+LDtRqDOj3C6npqJwXq?=
 =?us-ascii?Q?w82z8SyveeloRH9AiZZJpUgCObQndollcHoNy6Ot2uygkJH7VrdzGC0avvcB?=
 =?us-ascii?Q?xdUN2+Z6PCs8DB19/+eqwVz5ADr+oEM2N4dm4NLjIVqKq8SA/OdJYDrP/o2S?=
 =?us-ascii?Q?H4RBY0gUn+hlP5OlAqSEzroA/FGphcIV9KAKkx0bENXEv8/tyqvMi7IqI+gH?=
 =?us-ascii?Q?uhDf1fHQOAt0OpKjypVEheoPqScTiP/5AGjampbHIpoG0i9HY53z3Let08m/?=
 =?us-ascii?Q?JzddULB2eL8oVnZ4l6gincVptVbfN/BOWmYu1RvUenaqE25U7OMReIJcH6rW?=
 =?us-ascii?Q?ZwQqhxdLEFMVXMNnNoc4HXGbIDzoySN8ZGb7zySC7QXhIiDmamQ2z84QeBsw?=
 =?us-ascii?Q?dyVmUPUWi2qt/xcIIL2NfLnbE9+4rnDGoW8GkQ+NceI69AmgA6GYhTFmdePJ?=
 =?us-ascii?Q?7lhJrPUjJQCgCF9rTxYdn3sXYZAeprgB2NmYo7F9nwjOl9qkh3QKwftd/4Gd?=
 =?us-ascii?Q?CV/YV6jStauNfDQSbR3x4+E7D0P65mgwlf+Hn2aiK2BPdUHRiTbtMNrhyfo8?=
 =?us-ascii?Q?XScx7g+JFeJztxrMqzRN53xy6rK8LqcY9uYx88OhsXx3MalEToDCbdzLdGgg?=
 =?us-ascii?Q?VGzgIzHzsg+VizWNCq/J+UCtx+fbMcVk72lIKUAITxg2o/6wvofO8Mnz40WF?=
 =?us-ascii?Q?vzhccrXqEt7XdaucM8gO0eKgd3A0DfNwD40pewsFJvddi2vj6s9c4v+/uQTl?=
 =?us-ascii?Q?MgnbskmdcywBzWIjG+TjpyzZEfxKtUrKE2Hv/+E+xUovTg3JfUFCrZjy5bVt?=
 =?us-ascii?Q?Uo7U7/3kHotQvbNqYNNWd0GZWcsi+aiKKLBXuWFPDO7K+WPmIwzfvb3qicCR?=
 =?us-ascii?Q?mMk+ZyVJqm7kA7Zw3Bu1PIWNMq3vQQiAMAmwuA5th2QRYlpbOlYkAs5gpPdn?=
 =?us-ascii?Q?nKougKVXwx2PhAZAl+qtRq9pF2wW7afCfn2eTi/oTYexoRLMiVOoOIqKeGBM?=
 =?us-ascii?Q?Q8Pi38ujww2mHXm78Ji9kV/m2q5IOf0LSH5YFrTt5+xYQiof735AuY6ydsKH?=
 =?us-ascii?Q?kifiMjIJeVBUUuUEDwMbAHztWFgnOEeUgOAPPPOY6E3+0kNWDuMO7B1nZPZB?=
 =?us-ascii?Q?++eFi1hclwaL0fXWx9iBjKwyjinmD+mSc0QmGveBequp7J/enpAK7Sh7/Pri?=
 =?us-ascii?Q?J1/TfGr8mcW5w6NX1sFkoK81jGaxiBF1zEkdaKNKRQgshTUtWVSOCnQtWS8i?=
 =?us-ascii?Q?SykD6yy3LmjtsRIXv71Ax6g8NL3JDeyxpxqrTVc6rT20ck4YToUNX4z/sBh1?=
 =?us-ascii?Q?IgDSjSJcdY5Fie6pVkGQBPeHMqky9GPxnTBM2QODgCa2F8rc+Va5mhFv40HF?=
 =?us-ascii?Q?mJVo8qi1jS20jScwg5+ak815wL6nc80cHiqhhcuAfCDfURt3+9b0qkxW+AhP?=
 =?us-ascii?Q?9NsHzDE8lEVDI2rG7F+Mr8KWdTJXOGwHDXIPu7Kpr4UlX0LtiVcEs7ad1GuK?=
 =?us-ascii?Q?LEtjNA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8275411e-bec7-45b5-b5b9-08de163d3f1a
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:15:44.2604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tTs+Y26SunlFqRLEE5wdblAdx4snugRGD9EAu6KsQsf3iecZqbk8Yj6EeP1GuGy//fGHI1C95hCWW7Fn/7YOTSVSqJfTld/5GQtb+QgkddY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6700

- Hold RCU read lock while iterating over address list in
  inet_diag_msg_sctpaddrs_fill()
- Prevent TOCTOU out-of-bounds write
- Hold sock lock while iterating over address list in sctp_sock_dump_one()

v3:
- Elaborate on TOCTOU call path
- Merge 3 patches into series
v2:
- Add changelog and credit, release sock lock in ENOMEM error path:
  https://patchwork.kernel.org/project/netdevbpf/patch/20251027102541.2320627-2-stefan.wiehler@nokia.com/
- Add changelog and credit:
  https://patchwork.kernel.org/project/netdevbpf/patch/20251027101328.2312025-2-stefan.wiehler@nokia.com/
v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20251023191807.74006-2-stefan.wiehler@nokia.com/
- https://patchwork.kernel.org/project/netdevbpf/patch/20251027084835.2257860-1-stefan.wiehler@nokia.com/
- https://patchwork.kernel.org/project/netdevbpf/patch/20251027085007.2259265-1-stefan.wiehler@nokia.com/

Stefan Wiehler (3):
  sctp: Hold RCU read lock while iterating over address list
  sctp: Prevent TOCTOU out-of-bounds write
  sctp: Hold sock lock while iterating over address list

 net/sctp/diag.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

-- 
2.51.0


