Return-Path: <linux-sctp+bounces-257-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE80983D11
	for <lists+linux-sctp@lfdr.de>; Tue, 24 Sep 2024 08:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFCBC280E8A
	for <lists+linux-sctp@lfdr.de>; Tue, 24 Sep 2024 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A012F5A79B;
	Tue, 24 Sep 2024 06:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="epN1+ABl"
X-Original-To: linux-sctp@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2089.outbound.protection.outlook.com [40.107.215.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702C3537F8;
	Tue, 24 Sep 2024 06:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158948; cv=fail; b=WmNjY1JhnCoRo0wbFRQsKLGpoOWg31ZkDXiO3vINcDN0ebyy1vdAIPoxjuQcW0aeU8VmDhVcNso3bHRyYt50wCuOw/1xbtgF0ypi0NwUCXOenBD9C4XUcYq+fRsQ6k/bQlzOP/0WgjI//TmFDNvK+depiWD8Mh8VWQ0QK4dlU3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158948; c=relaxed/simple;
	bh=1BkeEFnv6E7Gjrm9zjj69Mq7S74VX78WkUtD/vQ6ECU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=QlAtip2tJ+Qk/ayiw7UPWrCrwqJM9Z8h3gDaExQAouVzusExCrOYIWOMAE+Z/5oXXy7eCwY1cUQwcfBbEU1Gs24xYjfS7WYAZ/oTCE5E/x9R/J0A6OE05Z2wDlEeE2+uIXfv5J2owcaBw7JBDrArw2FGf/FYAg79/w/JFydtUjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=epN1+ABl; arc=fail smtp.client-ip=40.107.215.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+FJemM/Yb9BuYVuiLHcoWwN/rhya+AZSznUD38z6Mw/SYnx/c9OxE8xXR9s/zoIfoeJsKDscRLMMZgz7pAlFVn0yEF33xvwOk9sjihzc26D5t/3DdaKI8Kh+IvsjEp/6KmcuhNZXVlTondpGWYHfB9Gvem8oSQfXW+W1wgXiVAzXj6MsPSTWrXIM2KMRfoLiF/5wcW9yotyYQY6HvxXxJLimQbmnJWSeM4C4vHW7QL13zNImrF3m9HR80e1omI00HZsgGRLyJg5TzdrCzlej3WeIEsbQ/qk+Qs7PF48kEnmdSbvDUj4KRgRDB9h3P7OUrGJPQvSOJlqr6fETP9+mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8KV/k3N/+3bpBPMsYr5+S/50b1GDiRLisJpdvZoBKM=;
 b=xgRCy4JX83tZ5je47LksnlcBTwoawrdrAHzhK+vLgleKmQrDnzW9dSfaaynrPgpeWJeb7vTjINVQA2Wlp+Lqx2Zz6Saq84uluraFzCgHHmcrdhBlBa+O74km9BhZ0X8l8WLLwRhIA9ELM5d0VbawDEcA/Uj3W87DfVT0VMrVY+VRpb+2wajebgFkJ+5xaqzJQAeSRbwTSzZGZIhq4RcUsweai7YwCedqUCdpsSy/6jejpkaggfOHRxVxFMH5czQro2VOmH4iUoQDh8ZOgPcnApNWejABTQo5HQOm7O35N9RXgUzsHA2c6wYm6iqNLai6r1hLtok8hSeJ3egY4FBjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8KV/k3N/+3bpBPMsYr5+S/50b1GDiRLisJpdvZoBKM=;
 b=epN1+ABlNdL5T9OwBr1CK+6HP+JmlpdrsZFmPqZ7MP5gds7FmO9ltGZ9+ZkAki+8AFfgaerbrgYa4HPZuED5X7E5/uFWt7qlQTgqXPITdKUjmmQTmmz4irRLPjecKip4t1lb/Nc/b4DfKcFwJmFNjFxlcx1VE1kUb1cAnWSYTBG46QjVuqPZIhrc7MsnLt7sDDg8XNoqoTq7I7zNb6CUkOuV7Hx7RFRNUvzp9j7ajBCUYL1gr0WT5oHfMW3FvpY1XI2XHB9uhlFKcQYtl+MRq9oAmXWfi0jNKrFqB4u+CFywCg9l2HE7pLcW3mlzvzRLcIDcmcJXrhewiA7tEOIaUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by SEYPR06MB6982.apcprd06.prod.outlook.com (2603:1096:101:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:22:17 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%5]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 06:22:17 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1 net-next] sctp: Fix typos in comments across various files
Date: Tue, 24 Sep 2024 14:22:03 +0800
Message-Id: <20240924062203.3127621-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0157.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::12) To TYZPR06MB4461.apcprd06.prod.outlook.com
 (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|SEYPR06MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b3a18d-440f-4ec9-4b3f-08dcdc613cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?chIZQL7uA/rj1zw+bNoUNVEH514nP6mkBSeS/Tzx984kBTqsNVpjx6IbKcGO?=
 =?us-ascii?Q?58A1IYnaJcMbaPsyb9Ie4YBVAQWp2UgYVneL6Wjveh+q3G13dIGUkf36zog9?=
 =?us-ascii?Q?FGuLo1qUocdW3w55t+4A4maTLIC3LiS+Sdd95NC2mGgIewviLWwyt0if+OKD?=
 =?us-ascii?Q?EjdyYe0WRJc2qROxaq8yKGtSS5yXHz9z5ingzbAxFOYDP8v7SEVdcdvyAHYk?=
 =?us-ascii?Q?Pj9MZXuFmPbqH9vbpLxBStGsZnuNS2tFSaeMsWmBW2aMtDTHVQZHXvUUj90G?=
 =?us-ascii?Q?476n36Y+MWoKG2nNGXtkaKr2snYbdanFMqpxWsC+0VRUvdNWNwFj51OvRfeT?=
 =?us-ascii?Q?R8moWyXTeSx1OrI/epQoIBvJja8ZB/Imi0UcE04p+DQIfOBT6WPTne7GUNU/?=
 =?us-ascii?Q?eRQVWGYmVjMom3yVLlcdn0t60fcQvP31DP6nNnE7I1AvS2cGb8Z0FUcMSO/d?=
 =?us-ascii?Q?iBMGdmVn8Xtl7CZiNapzIU9+Jmc9uEBVSwXTth+HUdhsmmJNADtEigrAlq7C?=
 =?us-ascii?Q?XoB6HWZNt56KpmjlFterKrcZTi85EA9CBFHQRTtQvO52x+zLDdielj228KZ5?=
 =?us-ascii?Q?KcOaQMyCbB8Tltnbq1WBsTVOvqT93wkoubkb4eIbrCtlOh5p8BAajy4IMXmi?=
 =?us-ascii?Q?hd0GuT7xRyb1YKI0HU7R6p7vi6wiut+k0kSEU8gei5LankMz/pU9w3axzBaD?=
 =?us-ascii?Q?vSScG3M0dicIlEDzaAMpLoJPTqYMHaqh578exR7i37LPO4PEfHkDyeK/ffwI?=
 =?us-ascii?Q?QH2xlANCIgpmrcl1jOX7vxcClXFXspjpfoep3F39HKPAZtzLNUvw2KQNbClT?=
 =?us-ascii?Q?QzlB2HaMcAU8JIWZwVRqhUPvLOpvqnE8pqv2Nm+mKTeJsrUjNdZePaTed2J4?=
 =?us-ascii?Q?1WcZ0F3/AKATMdgbln/z6cbDIfvkEZz7DVpC31YkwB/Gf8eihmNNl5GdnGUU?=
 =?us-ascii?Q?vMRLp8jCGABoHoplpTl68eWPGUygccBQeRaa3lVicDw7u1BX2MA17ONatAgo?=
 =?us-ascii?Q?rbn8YBTKvRWQ/vtABLWI68Ol3kh7DWOelyjTLM82VCDT7teL66xI1WMf4yfL?=
 =?us-ascii?Q?V+remzjuMvpswy2feAVmfclz5KWbbG6PwUa13Z1EUfHz1MEgCzxYiKPEZ+16?=
 =?us-ascii?Q?GJ8xp7bXvEQ+SHZR2YTjxEg/ude0Uhb1MKn0ZGQ6MFuaQYCVGgn8nDrnfaKY?=
 =?us-ascii?Q?05eiTELYgR/Ku7r5a2aUghJRJcx4nKflBD4xO/GlNJvu0tu0EUNLyDXFRm4O?=
 =?us-ascii?Q?3Y5XwLSw+FYgh1VXwNDWa37blQnqnYeZhnW6mN/dlVk2iGwp61kHLXFNg2xE?=
 =?us-ascii?Q?uowcg3inekWtl2MlHkS4glrTp986V8TPOE/wtc8rawKNURX7Gm9rSCCcJlxh?=
 =?us-ascii?Q?fXE5iCBlRIfP6B1r1W5m1JyDk3q0SWYPMjQQWnNDOrRKRtJapQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N9WFRWcyFZB9097c4K7OZjD/9rqAYHKOCCWRbURwH2MDvBONm+SbXrad1z+o?=
 =?us-ascii?Q?UFOJScVP82Vsd9TrBCXHn8J7B6nAS3rvbK9nY//56Ig9/vHiynx5BCv8Zr1I?=
 =?us-ascii?Q?U3KeHpJ/nqFP6Nc9z2Cbt3zZtt0H7mWMTerTmz5zhfRqLVW0xXH3RHIbHdKm?=
 =?us-ascii?Q?r7pUxOCN0pybOYNh+1o12MaTrDsHCtdCE2Xly/Dko7BLuG7ZgLvUtxgOKZub?=
 =?us-ascii?Q?T/KxWvDiL6Mt63enQ3kFtRd4A8cdyCKF4FCJzUmY4HRQ3vpPlqzz7TuKMXZ2?=
 =?us-ascii?Q?ozZDm4Mx1zCt0sC79LMDDlDJGE8lQ2xaB1MYgaSPczH9AKHO3HGAp9BtfST6?=
 =?us-ascii?Q?MnBXcwQQHELmzbtdMomNF1pyaTznhuZ4UR+C16/9i6Xwp9I+LOfNSkzv8U61?=
 =?us-ascii?Q?5VS2FbHVkOp6YJ9DbUS6VGAG8s6FuvUnfr0dkpbxbSdPUb66M2fO2hK4DfuP?=
 =?us-ascii?Q?MPyOD/4+YyHQkKMEQx6HeagO/Seu9jH+918sTah+aVMxpQ/LQUjkZ9XV8D15?=
 =?us-ascii?Q?hGNcyLbUjftP6xyzDclFIFWk97r/MukmgUM8+CuakZosAqk7wUO0V2s+XV+I?=
 =?us-ascii?Q?1S36QyjO/s1hT1SQhC//32Eui7uK/6CVpnBhg3gDjNv9xg3Zr1YoweNtPvQU?=
 =?us-ascii?Q?0pzk2lNodZ7vELSDWpQMIOFs0jsSdh3QlnQ9GefU835Et7czK4NZAPZOJdK3?=
 =?us-ascii?Q?+YmKX7oZOsCqne61vObWTYtwMKvzcs8hhJQCkkWK1KKVRioIOJH6ErMU8+u1?=
 =?us-ascii?Q?GhL9X1FPL65I6NlvMRBk6O9SFTZUzAMt39ZXgAKpzxyobVBhBXcLqENJ28zC?=
 =?us-ascii?Q?wSuBCgU5k+OQvl8YTdLCTOqPayrAPapc7YgPx4cRhx26EfQv5NNx0xyx2KMi?=
 =?us-ascii?Q?CeWl5rFMFyC4i6EdqmKEXsLXzIOrUthjjn1sCIC3mgd6Va3CfNjEOgHEZR1N?=
 =?us-ascii?Q?tvqPs/LEnYmJo1K3fiQHoSFgLqKWH9W0dzFS7zVyhPhFDyRpzNv7qkeq5ElO?=
 =?us-ascii?Q?ofQn3qC51gMKqICs0DTo8P0y190Py9wef9uNeoYm2qEnkC9DLHMe0cyRwiut?=
 =?us-ascii?Q?ZcItRdmPiM6XTc3Gmu2ik5dK9KStOfstBr8r12UWlFBhfP7mARq0Ld59GyOO?=
 =?us-ascii?Q?p1vSmvxkGvl8k1QiV1bAJK1t7Q9yk/FPN6SuUe+Xhy+ptxhTcx3gJij/4urG?=
 =?us-ascii?Q?U08d+4zMMKyu9WqdRgo+nIIjtvnMUgZLilFBGw5dVAu/lcZycETU0X2ib+6s?=
 =?us-ascii?Q?pfAaTH3mfX9XPrCg5nfDxINpLmwYDgOE5KMXWwQJaz2WlkotDxm7Kd7HLMjX?=
 =?us-ascii?Q?mqKATLeT2J6ZWMpL0jsJZ6W6+3Cu18BDfo5MJYegTCjkE3xYRT7EjnC1Cwjb?=
 =?us-ascii?Q?+NFzz4xLVazSamgyshNRa71WDJKRbIAZA4xDgrri8pQNn0snp2mb9ULZC6vh?=
 =?us-ascii?Q?fGwhXqszemyjvK2t4eLa8M2mV94fg60ZOdxhZRdIgsmv0YLK4mxxeRuKYZWh?=
 =?us-ascii?Q?WKOrKq1Itxh0gCzXZGczTpBHaFiP6ooKvJ5yRQAaJHORh8VF0lT1hrM4HN6N?=
 =?us-ascii?Q?V6AtD8LHTdg8XwfVQ/ZFLgN+1doiSnQ/fhvYqGEc?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b3a18d-440f-4ec9-4b3f-08dcdc613cc9
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:22:17.1014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eu9XsQblPc0hhxOQlxeYhzsqOiulgmPw+D48ivQqFhOXBxEkb1Lw2v1LP4WnXdqOqC9q2H9DGL+ZZkug3bjtoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6982

This commit corrects spelling errors in comments
within the stcp subsystem to enhance clarity and
maintainability of the code.

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 net/sctp/auth.c   | 4 ++--
 net/sctp/chunk.c  | 2 +-
 net/sctp/socket.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sctp/auth.c b/net/sctp/auth.c
index c58fffc86a0c..4bec21f8cb36 100644
--- a/net/sctp/auth.c
+++ b/net/sctp/auth.c
@@ -460,7 +460,7 @@ int sctp_auth_init_hmacs(struct sctp_endpoint *ep, gfp_t gfp)
 	if (ep->auth_hmacs)
 		return 0;
 
-	/* Allocated the array of pointers to transorms */
+	/* Allocated the array of pointers to transforms */
 	ep->auth_hmacs = kcalloc(SCTP_AUTH_NUM_HMACS,
 				 sizeof(struct crypto_shash *),
 				 gfp);
@@ -774,7 +774,7 @@ int sctp_auth_ep_add_chunkid(struct sctp_endpoint *ep, __u8 chunk_id)
 	return 0;
 }
 
-/* Add hmac identifires to the endpoint list of supported hmac ids */
+/* Add hmac identifiers to the endpoint list of supported hmac ids */
 int sctp_auth_ep_set_hmacs(struct sctp_endpoint *ep,
 			   struct sctp_hmacalgo *hmacs)
 {
diff --git a/net/sctp/chunk.c b/net/sctp/chunk.c
index fd4f8243cc35..19f4562a3b7f 100644
--- a/net/sctp/chunk.c
+++ b/net/sctp/chunk.c
@@ -68,7 +68,7 @@ void sctp_datamsg_free(struct sctp_datamsg *msg)
 	sctp_datamsg_put(msg);
 }
 
-/* Final destructruction of datamsg memory. */
+/* Final destruction of datamsg memory. */
 static void sctp_datamsg_destroy(struct sctp_datamsg *msg)
 {
 	struct sctp_association *asoc = NULL;
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 32f76f1298da..9fe18414a355 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -6631,7 +6631,7 @@ static int sctp_getsockopt_associnfo(struct sock *sk, int len,
 	    sctp_style(sk, UDP))
 		return -EINVAL;
 
-	/* Values correspoinding to the specific association */
+	/* Values corresponding to the specific association */
 	if (asoc) {
 		assocparams.sasoc_asocmaxrxt = asoc->max_retrans;
 		assocparams.sasoc_peer_rwnd = asoc->peer.rwnd;
-- 
2.34.1


