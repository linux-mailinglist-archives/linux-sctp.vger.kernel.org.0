Return-Path: <linux-sctp+bounces-721-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EBDC15C3E
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 17:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 006254EF087
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 16:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022DA34AAEB;
	Tue, 28 Oct 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="M6SNY1UG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AC9347BBB;
	Tue, 28 Oct 2025 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668162; cv=fail; b=RvnvBO/wgTXfjG9CQ4MNCuo9oOrEFDaR9faFecue9SMbceiq+rAK9XD0F8DCNbxw7SGCBWA4Gsb7/69sSsbPsaX56k3il34f6XxpE3JxwxzHKkOjvu+54XW9QVGDLZKC731luO3muzoZYYIVfFU/0MgUrM/WX9k1RW1dUoIToFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668162; c=relaxed/simple;
	bh=r2yDx0bEp+fPb8gdSvtogAQ6Xj69fpn9WGfOeKfP80g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TMBPYa+QxAkX3SiL55XfYzuxQgTsopMLRI9TinH15haG4mo8G/ddaMIGewHhIf1Z5Oz0jZB5kFzobsL6cVYxYb32J1e3RswLBw4CBtGHdyxLaWuQzkw0dCfgunX3CxxyVE34kyFwi609o6tuAaKnVY8aq4ds9MlCrUageJsdDCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=M6SNY1UG; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7Qya1U2HBE7vY2W3mcGX6o3PJ0wzUZEroazqU9Ar7CPb+51VeIm8ZjLdGnP+kN9UoP+n3NaHjSxfd6XDJW94kwGPtId5RJkCRDNePelaHDnj8voFzIf6fBRrCB8qSWe6JTDxPodwq9r3fUuK3qwXAZ8WB42kMm+foNrCo4Tz2UnnyCxLch1hRCLbtQszlzsSWxOKqLvy9Fn3Zt3Nx2byjVZhHOr8IDZ1IYpheEal19MoFds6dUXorpCMPT0qB+bwDGp1j2TLECz65pVhsK0mfx/DyxJ6etGPyksfdmIeM5UgZ5LiPjLH/JRXWX8LdgmKUEl4Wc3cSwoUAoGUAw4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e5/3zdzNq6iIyG42gPPVTF2T2aa7ZKy7W3xb1MYVdK4=;
 b=f0E78+Hp2IThpxOyAVMnbXIjJVZyDXzxfDgLf2X7maOT768nzTUvSzrHPGnz+qQdp0OmInX4zTfC5xYpVJjJtCTh30fdQWAeaNP8msSudPV/1D9xSGGnWinhwCo81rop1o87s3GhRUyWM9Qo56VnVIaBy0zmbtnxs+eyYqz2XEz65rOXXdzSiLtyZRemhpDQKKraTAa/1h1HWhN7+S2KlhntqjJE11Uqem509eMnBcQmnt8EEkLix2pUFt1G6mwBhFs2OUKHmvUubq7lGGlyAGpB8t4WojW+JNJBUJ1BPtPLFsws7ujeypULP96PNAkkXNLoiF21GJtrzyYvwwfUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e5/3zdzNq6iIyG42gPPVTF2T2aa7ZKy7W3xb1MYVdK4=;
 b=M6SNY1UGwdrKU2GuIMFYlp8zw2G1bN/EKh+1SOyzeG2r8EJ9ZuAa0jWOOfly6/cQeCiGTdswVyEGaawRq+uvrgHB2jTMBzJOtnY77JUeHaan53IgWq91pwGYuafSvcYdFNVjTHQOGMAP/UCXN2VjC+zwJqU22qKVqmVnjl8mlVvLd1/CKcCChUKAcCdoxdMha2E3J0xAupzixcK/Cq77YUFcZkJVEUewqC+bIxk8/NM2DY8EWq7XYxAWZ4gZd0Pdz0Ret2xe6G8RnnEoi6iZFSM32HlcBospLJ+WJroyiu8EabIwdshD47Nbr8jWdGdb2hbfdF/1L/rSj7IXt+SQxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by PR3PR07MB6700.eurprd07.prod.outlook.com (2603:10a6:102:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 16:15:58 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::3a2d:5997:c1c7:3809%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 16:15:58 +0000
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
Subject: [PATCH net v3 3/3] sctp: Hold sock lock while iterating over address list
Date: Tue, 28 Oct 2025 17:12:28 +0100
Message-ID: <20251028161506.3294376-4-stefan.wiehler@nokia.com>
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
X-MS-Office365-Filtering-Correlation-Id: da577d46-607e-4ccb-4387-08de163d47a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y78IfEPVRtMeLiXOQ0rg8rYQEV3kVA/vZPESzyWNLtmY3cucPLLSsCmRbtCv?=
 =?us-ascii?Q?OFanU+wNtFrTyYjwY1UZvO6GCiFgOE84Q+jL3PeMn3toRZ7qCmwhVLjAVyfH?=
 =?us-ascii?Q?Uayct1hdEP+DBFzTXaN0bLZ/H/XPtG/Ynw02MpdX1ZVaFe8O/WJ5SjRjO29R?=
 =?us-ascii?Q?3eOvtf4YQjswlj7IAOditsRElpA75Z5V/BRyyq4A/unuIv9aBjMYC85KMNar?=
 =?us-ascii?Q?IOvoROwXYFwztlX8fok6ZoxKya6TBC3lpujyl+ajOvLLEqbUpMjbbxjSH4ft?=
 =?us-ascii?Q?5YFsLPDx98PlYXvZB/f6QfnoBpWxyN8Vg6W0AP3Kzw3Bv1vS5OsDoHk/1H7K?=
 =?us-ascii?Q?If/+0REXA2/gvh/xQVSzKveYapBkVSgrt8jG0HLR3PqUlsalJW81ZUhb8UiX?=
 =?us-ascii?Q?WcbnFL6kyXpC1PDVfy0xTvxr4ywn5NLnF2xLMXA+8CsT6I6eYCqHNgB4ea+y?=
 =?us-ascii?Q?A1GWd7WpCFmFV9ylw/XE08CuPcthlyIXJiO6/AysM5tbqBWD2W+VolN3/dAS?=
 =?us-ascii?Q?udFTZmHsZSD3HDhXj+dEE6BZALU3d8yUzBW0+OHwsy9ziaOp02ot65kuISiR?=
 =?us-ascii?Q?3zyRPF0YRpz7iK6K55J/Lh0mA/Wu7uQJx99cI8kNsHKmEWE6SaMaL7DEz4bT?=
 =?us-ascii?Q?oLAiDJ8msMZ9QQ2uzwjMm93R3mXjmCKCMsEsmcZP4JK7oynMRJPC5QrKJ3Uc?=
 =?us-ascii?Q?trhSaEmdE9Yd9193OuPAagU2tncuI4dAPyco4oNXiYA5BqjSaFCkyZ5IoBRs?=
 =?us-ascii?Q?OtRXIu0QImURjHXAVyvxsbDqe16lp+vkUUAObuPLzYgHQvtyrggbZYtlDaLf?=
 =?us-ascii?Q?prz47jB2Z+PNf7wvAyaLC+3sACm+Y/ZU7c10OzHjvMLPlhWJ3NgMymL4Dd4C?=
 =?us-ascii?Q?b1+/OBwsvf7dmkJm3pShFete4G0jFRT8tsnSZ2z2UnxYf0bZXxYaXinx4Pj6?=
 =?us-ascii?Q?RLrfKOWg0+AbK99cU7CXcHuOEiQb65/Of46AitRG6nPIrMFFk8mbN+wUp/1Y?=
 =?us-ascii?Q?WIs8c48/NxMGISOTe9Nkbz/NVUny5yX23EA6UTAWNUN3uuAHO1kB0/T8rLa0?=
 =?us-ascii?Q?UcmFyOvL5lFarpMT4wDventSCLuHj0skjNJiaPHBPLr/38JfkxOZWfWLfiFj?=
 =?us-ascii?Q?9mYs0VDxLVYwsrvfMyvQT6OghygmEsKJdfJN4UhoBnVKtV4FL7rv0tBow6HD?=
 =?us-ascii?Q?VItP39XRDJPLsAypng4VJhG0AskuuYLJoH6KsSc5Esc/ZHK3Goumpbt9lqlj?=
 =?us-ascii?Q?iJnZvsYzlTydzCeb6xmLnt6Y7GWQD1DxUKxRR7phlpAROoGCDMMn6IgRhRSA?=
 =?us-ascii?Q?F85qS2dkVYQ9Fl1ADJe3MNWJIchYslIX/nNXXPOw59gxT6yn8mPZcj9yUgYW?=
 =?us-ascii?Q?6sJmOEggcgm2hG75tYMQKZXt6uwrnPtuONGBxSJ1eoFQPjkgpTOLFu8ut5+4?=
 =?us-ascii?Q?TD5Z4XAIJsRR5pjrrTwWSynAN77d0H0r?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/64rAmZ62DPm1PV3VN9cmOjQZdvznhIJUcywgCc+T7SxjsSwp2Y02waEVPiZ?=
 =?us-ascii?Q?F53QyTvXDzeJjX3GH8HSxpy1/E/TmezwJlpbxCQM6idVugLKLABEGec5cqtJ?=
 =?us-ascii?Q?2RN8fOo6wC130bhvLaDgtfyd6hQ8x0L3uUnVlMuo18oOzMThU6UXWdvayQ6N?=
 =?us-ascii?Q?3WBooA0gfBLxpYdCw8zqjVoFWUFikyvm2EEDpgHxVeLcbxjEQj5B4YZ4U6Qv?=
 =?us-ascii?Q?BerAKTYc4oRgnKqxxrTBCfcNWuPZ9RFlW+Slzwc9JVr30VuDccaJcsIzFlRo?=
 =?us-ascii?Q?XitVrGhJd5z110R1+sJTeBtqAG0DrZhaUSQEPLYMc2qAwBg9mKA3oD1Nt33p?=
 =?us-ascii?Q?oZonnAd9KfXwf25gfMzGWblA1W8GVMxGv16Q0gbVheqXwSgywKh9gI6tnHd9?=
 =?us-ascii?Q?CRW8HL4ZDV0XFnoJhv9tLonzbDB0YnT56eQxWX3NztD7SJt0hUva9h8QkD3m?=
 =?us-ascii?Q?xNXQ6pcy2yV+aLTSTSV6wTCot7m6wZk+4ai4ygOUxap5/5Xi3cGaUdiQnfzB?=
 =?us-ascii?Q?NeB5fSulG04U0u8o+WXUCAXCZboAi24QUyT4H8Xe/o+d/ITEqUvQs/+BwhGZ?=
 =?us-ascii?Q?ZDOGH8l+c9YpRREqxHTx/7zL6C4fHvQ47rD6oLPdlT1RDQldmuHRBuvXNpdj?=
 =?us-ascii?Q?nRt/7CKr80q6sUirdhMows/UbXrbVJ50wFUWe0SaSJDu9kYOzd0Z88y3RpsI?=
 =?us-ascii?Q?odb9aY1BEyDvOKvEMSfOMsAqQ8/1Q58J/THCqwnXhQWvO7GZNb683pyH+1BQ?=
 =?us-ascii?Q?wJmflMM3iwUEsEIHyklFC7FtAna86mcsReAsdOipEXuJPmcXY1GzMuFLewZe?=
 =?us-ascii?Q?cXlX3x+Q90wFQM9qsCOIB3NQP7qNgJbgU2aY6zK0sdRMfXfKYck/0PKMGQ/9?=
 =?us-ascii?Q?nA7r/9Wa88Y5fR7ZTCvLz6Ac9ctEvY/naxIdpISwEKYAXp3wiZGoUE2swAXE?=
 =?us-ascii?Q?YJrlus5XD1dK1erusu4onKYdBZSpo6leFqzkbTshy26LHvyMNz+EL9MUMb41?=
 =?us-ascii?Q?0XPe8Qi/5z0Mpa91lq/nxKn6GvRx5fgkC5YlcKOkSB59e5NJsjgK4eCWTrel?=
 =?us-ascii?Q?h0vp7ptFv7wSvxJQSXkj9vjpsPu7YxfV/tK7kTyD1gLLht4nQm+i3bt6FB4+?=
 =?us-ascii?Q?f5b54zPUKA9fr883isCkb1aMf6eRwon6tRPduZ9f1Prtdg83wbXdIImgomG0?=
 =?us-ascii?Q?23JGSH7CyVpTJnq5Y/QHg/ZgeC1NojXFV0WEYUfv65AEoW+t28ikL6SDp0yZ?=
 =?us-ascii?Q?gzTtrOLmTaQgB6j86KNu3c5SeQ4X8z49wM+T93Si/8eadHQPNVk19gkcaZe1?=
 =?us-ascii?Q?LRo40JQrzIgR0yVursfrsMcyo9ohMVAitk80mp/TV+WS7fT4bO7uaDgbgRhe?=
 =?us-ascii?Q?3SlXWhemya9kZW2MltZ+GLXh77Qs+CjP6Bsj6i6USZSqyIvJFw01J3XH+LbZ?=
 =?us-ascii?Q?PZuzphmyAJYg/2W8my9r6Hi3shzTOIvrth+mMFwDtR6XlzWNPMVzQREWe5oe?=
 =?us-ascii?Q?9e8yn7scqCMKbA1uUbUTY0WWJP0vGg3fVWDqh7Fa+/yrJWziwYn40hn3ekke?=
 =?us-ascii?Q?HB3EMMXQK/P/iMzxxjgtuzs0RRL/me1FZUeG9rt1oUmjPGn8ElkMsytPY5Gu?=
 =?us-ascii?Q?bAEbdTvc4DmvnVflxWsPFXWubCx//2ASa+eB6azOEuwkG/6O4w8mDGY/uinJ?=
 =?us-ascii?Q?G5s6MQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da577d46-607e-4ccb-4387-08de163d47a0
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:15:58.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHHiDW6itcoAuhzJUqTzJrrBJ/8fX7zB+7fIR11UkL8fsQ+Zk0UN45xhrEuOfHtlLwJysR08toRsPGn6gD7paRfaa2UDCxjltEg+gdfyRYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6700

Move address list traversal in inet_assoc_attr_size() under the sock
lock to avoid holding the RCU read lock.

Suggested-by: Xin Long <lucien.xin@gmail.com>
Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 net/sctp/diag.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/sctp/diag.c b/net/sctp/diag.c
index 5d64dd99ca9a..2afb376299fe 100644
--- a/net/sctp/diag.c
+++ b/net/sctp/diag.c
@@ -230,14 +230,15 @@ struct sctp_comm_param {
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
@@ -263,11 +264,14 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
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


