Return-Path: <linux-sctp+bounces-713-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62829C0CF62
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47E184F1A61
	for <lists+linux-sctp@lfdr.de>; Mon, 27 Oct 2025 10:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CE02F6173;
	Mon, 27 Oct 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="iI9O9ykj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D459E10F1;
	Mon, 27 Oct 2025 10:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560943; cv=fail; b=ESUFsnMIGL/zLGSQp85N9J+m8z3RpOSH+zJYGzXAJ2oqFMvZltmHkHCnniknxOLpWoGZ9Bq6CvWsbzfExl8xEZUjn+xJi6u92B5HssouZzYvlZp2G41La4UiTKlYNXrwb0z/rof6/n74z3WfmN1CXn14piwIbgmDkYZhOGfbcBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560943; c=relaxed/simple;
	bh=3kCULEDu/+Kpv/FhzqOmxNeXWesnpFuWKAlnIlLUwbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gwFpqQG81aOQOKxULqJrpHSst2FVBIXtKopExCzNv6xgZPFRQZO2F2GXg1vug4QOPGCbCUYvTiMHW9pQtZlNfYjBJok+lgIBFhY5jhODmTSB6W5FPZJA0BC6nGPiDSZ8dAcqFJLqGTu/yspdXlBL3hRRdBFn201eo+sQh5IRtew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=iI9O9ykj; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWDw39v7vrg0vfhCQ5z3+z1Q4QPHNRFc1gm4S9hcpYxLuzax7t0whMcHsu5pZBWjG+ZY2H1DCZAehHBOZF8f7QKtjROG+Hs6+4T6b+F46kwPYCHeueHzr3aJ5ThiE5IBR96T1FMt9A7PueoXj/NrR91t+VjdvSAuqqG5s9WA+IPCfHHbic+mI5TiTVez5nG3FfKH258Y39p/vrB/hpJ/TSlYOdVJaiNO6c/0iSudH82O8yEa99SpcDvIdG7qu3CyfgbCJdJkpFKKyoUQET5LcU1OdnNxdMAo+VhY0wxAzlcOiGs4q5R4dt+Fdl17B8wh2xIqzG1ThJRjdSC80opKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Az1mZEKieiQdqzD2uJV7NW/8VC6SdI7pWtrCbH/MiJs=;
 b=hTMA2++yOhokXy+Xu1KVGUYDajmR6u4az8K6lEfUmA6DDi/6Ee+U/LH2QcUnVfatt6EZLyNWaih/nWPCFnAuf83H+9Y6ANwQE2uRMevuApwmOHls3mAHn3c9tr/GQVuiT3Xja+iO2nNfpUeAsalDOBCdh2rgQveQk1nOULSIrM9tAH/mvKPkdQlA5N5euQO6MDQUmgYoBRzt/cl31BCda5BuVjR0E+L1f3X3jDWfxgee8iLcdKjfte54fr0D86okIlc+LaWWmkvEx7xiERFXHrRjMAVSEBVzbd8bdKs3Y6DFiezDhZEFy32LPy0+RI/NUzN9mqORYVPu6UsQkS3VAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Az1mZEKieiQdqzD2uJV7NW/8VC6SdI7pWtrCbH/MiJs=;
 b=iI9O9ykj3swFlWjYFdwCNMR1gUMd2JYU2wnRT3WN+Pnqh0EbnKnbvuqIivKCTSeu0nfhb5dXLYo87eu/FAbcsOaR5LORGWpOY/JbXi2cc10HVUUd+zysHEx/KInnI2nHRc98QoxqRQlcMCR0iGz86W74yx0WONPDjw+/dEUpZ1jzqL7tQgFwAW7E+UNPPhhFmTwIDSJQQ8g31+iCafX2Gus86MH4PoAblXokHvAQ9QtUKBfDjjplgAxFaL+eNtLeCYRZZNJQyHZNuRlkyUyHcr1tf6xJmPJzEOs7cirb5WmkBGU01YHrJbEvgsofcGKQs8TggrQ5Qbqn//WVk0lJ9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by VI1PR07MB6672.eurprd07.prod.outlook.com (2603:10a6:800:18f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 10:28:55 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 10:28:55 +0000
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
Subject: [PATCH net v2] sctp: Hold sock lock while iterating over address list
Date: Mon, 27 Oct 2025 11:25:42 +0100
Message-ID: <20251027102541.2320627-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::6) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|VI1PR07MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 108d4798-9a67-49a2-c883-08de1543a1ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?84khXZ0QDObo+nxTzm0Y5v2cHnPWy+qK7RKw2Es+p0H/wZDZYQD64jvoJJXh?=
 =?us-ascii?Q?UASTX14+IHAV3ld3JZrbkqwdLEwKDiThhh2IutzFEeEn9GOC/4Ma3SEaia5J?=
 =?us-ascii?Q?QyKTOQq4T+aBvwNGjFcR9fCfJXCkLz+KYZyUt1jPFbMy7pmpABPpiS2NTGQG?=
 =?us-ascii?Q?08rUFLMXrZraojA4QQEKG8yjOGFdzQz/fOvJJfvsPGyZtHUtq40F/gBYid8A?=
 =?us-ascii?Q?hjRTriy2KX+8kyKdkhfMspLMXwVKJMEsaQM2Gg0MaKJkId/SEcuj/ITTbLab?=
 =?us-ascii?Q?lQY078TguBVvsaP2JtwCbAbM3BEu2UePSq16jMU8kZ/jWbw1c2IbP8ZyX1ey?=
 =?us-ascii?Q?6ESkUlAzCztP8OFPvwbyqSoeMkc5OCa3cchYKEKkiJA9W8enWP5RlOkV8K54?=
 =?us-ascii?Q?VklrSbN4fAM+JmRi8Pqknd+Q7+EC62YCxPsC0JZ271hlIs+sHQCm9FuB4Kza?=
 =?us-ascii?Q?+Pp2d6EXO8wf4YRJoMPTmwIg0XESWTRQfsuO95S6zSDxSr9cR7cYmY2UyRmV?=
 =?us-ascii?Q?8oTY0BueXQ14wHzA7CoEffiJn9FZSo+spB6+TSON964xdpvIbAsxYEdvAfNT?=
 =?us-ascii?Q?fDrOr5TB0jVjFcOazBI1duVfaI0Qh4jUMpoDlixkgPlLxmuPBBWQrz+gk1hz?=
 =?us-ascii?Q?uMqAJ7CY2/d9IUIZ+QNS76s7F4U6/0J9xFDaMq9XrElWOvgr3or6uQY4A2NB?=
 =?us-ascii?Q?8bOKhR518SZy4/Oi1neanMJsExLSn22B4/Iw1626k0/22pgCOb7NJScKez7I?=
 =?us-ascii?Q?ZInyT9jcZ/LGRMjIbhCxPMGOVFFFMvB0Ah25hnfWxvjF3NfGr0yt1n3F9iJy?=
 =?us-ascii?Q?3NgnVy4YDe7zaYe+SZEPaAXE19Uc1yU7GaL+aXi5o415I41TH0799bgo8SRO?=
 =?us-ascii?Q?ZjO0/VGrhYXTNDneqNo4dlaXKj9PMR67L7dSWpGU6fwds0QOgZF5YllzZbcU?=
 =?us-ascii?Q?X0kyb0j6loQ0QskYFNOqznjl6jFNRX056uG+LG2bs7yxuGWZ64juBnEW+dKU?=
 =?us-ascii?Q?N0PT7Gdv5TMexJJH2hSA6Tta/9You8GWBrDLmkjN0wl47ey8pvEgJzla2cYd?=
 =?us-ascii?Q?ZnAGtfMyHx+5PGWErYTjeZBITYDU2kEp4gDoA3l6dg0FdQ23nJHtJQdVHnu3?=
 =?us-ascii?Q?XirTPpwMiaaVTn6H/jCy2q5jy3ZCWy9usd+YFo475Lmywf7yc1zEMBH1izm2?=
 =?us-ascii?Q?mg4qyUHg9oichUI+rAEw8tYERp1SG9wV7Lj7r9n6oIZpSElBUYMXtlVbCKXi?=
 =?us-ascii?Q?oPrglKRc4ud67bZ3FqmIRC0zo+F0+LI8P2WCU64W3PQEpXA42/jZb5BZB2H4?=
 =?us-ascii?Q?2JhqiYkN6z91bc2+t5xYpwsXI3UJyRb8KCKGyANLtzXO+gmHS/HphC7fLIrx?=
 =?us-ascii?Q?a2+WpQSyWwaG8fDezR2ok7a6J/E+3r+vEOghhCg9AxVKa/42TXGgywJfWCpL?=
 =?us-ascii?Q?w2q2Nah3Batey7qgwGnQmCzezVw4iCa3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SXRRfPgdbSjPQObMNGLIqwEw1GGpaduI6Xjd3mmPlsIAECtG8MENvLaiVS8+?=
 =?us-ascii?Q?qbRuny3Ih9Lv1ZMidG3oFNyFIIO0u7xlPotIAPnUVThkWREnaINVeG0KE4Ge?=
 =?us-ascii?Q?3HMIfEC8u+7J8/5G20Pmf1y1Qct08T8Nx5bIpg3TliDBB+aUlQJogXBYqfFa?=
 =?us-ascii?Q?WCoeaOlZCTUskra+mGebaHW4ciEB+hx7Ourxdok7DpoHHWr8W6L4VaAA8uKJ?=
 =?us-ascii?Q?bGo3OHsmA1+awfDAr8wbgITmnG1ZL9sl+iUUKZ91X9cK18cCIgUiO6bUTTZP?=
 =?us-ascii?Q?CSd8uLB82H074OWvCPxWxLU6K6nWDfJi3/xZWNL85cFLENTdc8gx8a1ZLbVg?=
 =?us-ascii?Q?8Enz7+Y4/osG5OyjzgTiLusblt9Bg6KD0B9AF7pugdItZXzcOl2TTCZN/Wch?=
 =?us-ascii?Q?uNQo6JWwFMFd5tSzv4p7rJNuQkLDzmnZcLKVkHJ1IANmxAVhFAuHe1dC+8Mt?=
 =?us-ascii?Q?5EHshED2rHDEXVboQYd1uMf7CezovKMBEaLTN52MArxbidH44tDzGyTu6hUN?=
 =?us-ascii?Q?ts45/0uccOIMRoN/9VvDghUNwhUrIydx4UfBaefWVIspk/xYYNgcvigukew+?=
 =?us-ascii?Q?fT560rj7mQs65P9mxON2onX2n/y0mItmo/7vo1dr0IGQDcbt8EnvE89rE6eN?=
 =?us-ascii?Q?vG8CKhgeHl3vd+sFz4Ompqxe86NnJm2VYiPYry8hBrM9eiGEwz4mDRENDn+S?=
 =?us-ascii?Q?H7w112VcIs3lvqhN8uqZwiSW1V7FTJkhmfVI8jE9nQoQF5X9X7e37dB1LonL?=
 =?us-ascii?Q?TU0qvMSchRfjY2bzxl99F7+moomq/F0E6fa+sf+AYXdiXvLojRX27D0yoKf1?=
 =?us-ascii?Q?RnLATVTdKAJSNp8IcpyKz2wqwr8a98+vQIkqwC0ZMNkZ63SfF6RSkv/yMrsk?=
 =?us-ascii?Q?gjAXlMrwyT2Fr2d+8XV12uzutOrDUszTxOQz/gjzMExVhpUP0rZmhnlNHf5d?=
 =?us-ascii?Q?+z6paZ50hYy+S00t0wqEp4SwZFZJXZhpWtgXveSAzCBnyOVpFzS55WCY9uYA?=
 =?us-ascii?Q?gieJ7nT1+oHzKu0kZW2ihBuguwrIWIzT91LcO2jRF9nVsvPbamrcgC45ZhFo?=
 =?us-ascii?Q?Ym38AwkmBat1ihRg6cZ4IxgKohThgcJYXZ4BB/Z69exw90bYi/+b5T58oQBH?=
 =?us-ascii?Q?iqpjpcEPUlzsgusa8gVMwdhdtrlf4s2vqmfOOPZGHIGUq7q0Jy6Quix1QdYC?=
 =?us-ascii?Q?KxL/SYWosGTHDA9wj6ev6s7K3LEQLEK9p3BRerueVBS07VvGbcOMwrYvvIUk?=
 =?us-ascii?Q?P0bp8QQxpONHlCY0PH81+xHVvSHRaeImeYegO643D2zl+q1snsVP/bht2x4a?=
 =?us-ascii?Q?wrGI00vAg45PHlloqcWFbdGEVNa7Zmsh+soA9LnQEWnSs7augaWBYKtdbLoJ?=
 =?us-ascii?Q?/ZaI9hcOEYvjLTs21PDN5m1N9jkdrbQwBcZgjhvzzTpQRcb5ko69tUvppD84?=
 =?us-ascii?Q?rE6EuKjbki9Wq0ftt29ofigj01MLLVk1aaKlchtxEEin1Rf/REdqey9kYvwW?=
 =?us-ascii?Q?Jm0pmp8thbGkBetzD3X3QuYUJGyqlk7EWN7+QN38cFxW1Jnn+JeB9u9jfSXc?=
 =?us-ascii?Q?7bJnDCnsCFSxJ+y3wD6WZ7/4te0V4U8BckN4bNmQBzUM8uv6ZfWxISEDVdlp?=
 =?us-ascii?Q?82XZd3F/p9bVGFtRjxgttqIl56b+8zAX+a95Zu1nqrZII43lVFQ7SF7KwFBb?=
 =?us-ascii?Q?Pt51Iw=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108d4798-9a67-49a2-c883-08de1543a1ce
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 10:28:55.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xzKcDSsw77q25bS2H9Ir/fLAJBzxWfIf8gCq/M/JLez5V/askGh510eSKZx3DAmvKguX7Q/J/q1KUufGzPj61Y59U6o4d6kTLo3lPeQMbCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6672

Move address list traversal in inet_assoc_attr_size() under the sock
lock to avoid holding the RCU read lock.

Suggested-by: Xin Long <lucien.xin@gmail.com>
Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
V1 -> V2: Add changelog and credit, release sock lock in ENOMEM error path
---
 net/sctp/diag.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 996c2018f0e6..2cb5693d6af8 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -223,14 +223,15 @@ struct sctp_comm_param {
 	bool net_admin;
 };
 
-static size_t inet_assoc_attr_size(struct sctp_association *asoc)
+static size_t inet_assoc_attr_size(struct sock *sk,
+				   struct sctp_association *asoc)
 {
 	int addrlen = sizeof(struct sockaddr_storage);
 	int addrcnt = 0;
 	struct sctp_sockaddr_entry *laddr;
 
 	list_for_each_entry_rcu(laddr, &asoc->base.bind_addr.address_list,
-				list)
+				list, lockdep_sock_is_held(sk))
 		addrcnt++;
 
 	return	  nla_total_size(sizeof(struct sctp_info))
@@ -256,11 +257,14 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
 	if (err)
 		return err;
 
-	rep = nlmsg_new(inet_assoc_attr_size(assoc), GFP_KERNEL);
-	if (!rep)
+	lock_sock(sk);
+
+	rep = nlmsg_new(inet_assoc_attr_size(sk, assoc), GFP_KERNEL);
+	if (!rep) {
+		release_sock(sk);
 		return -ENOMEM;
+	}
 
-	lock_sock(sk);
 	if (ep != assoc->ep) {
 		err = -EAGAIN;
 		goto out;
-- 
2.51.0


