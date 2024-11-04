Return-Path: <linux-sctp+bounces-278-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0609BAE3B
	for <lists+linux-sctp@lfdr.de>; Mon,  4 Nov 2024 09:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 655D7B221F9
	for <lists+linux-sctp@lfdr.de>; Mon,  4 Nov 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8E18A947;
	Mon,  4 Nov 2024 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="TnwkGqGq"
X-Original-To: linux-sctp@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB29B18BB8F;
	Mon,  4 Nov 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709376; cv=fail; b=WvRiktL5NG7rZbk6GhfEGYdKMvYjFFB4jTsRnP2iX/w3aGiAWVl1fTijlieL2PyFIsRLowXqN570OQI8SKPO9qR6wb7zQ2E5OEEBNmMwJHyB/FsF+Yz4C2vPpMoLiMWMpUMhc39jApjDZmEoyMTTiDUtHMpc1+qdeNBJYgNUwKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709376; c=relaxed/simple;
	bh=e8ckLH0qbsVA6Uc2j5a+J039QSgse2h/wNmPFYPzwAo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YxJ0HwZ5f9EOhk6vsgewCcpXiHp79Q0P0VNyBnhwdB60mxhCLqSh3JzCNSKB8N3F21OaL/zVbAh72pjnbekBoYpshsKkjhF0CEZI5Fad2Z+mf/N0w5Hoqok9eXPbfUxwNFGyRllSBX60BSr758P/vkll49ncRDku3gIAJGXwMBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=TnwkGqGq; arc=fail smtp.client-ip=185.183.29.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9CA8048005D;
	Mon,  4 Nov 2024 08:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPjHxsep8/KXI5lj7c46VLJ1LZGOnN57ecM02EC6ZfsKumc1CJHf1KRNogKrI5wpvuch5AxF04F9RaK0+FQ9wwet3ZNrzQe/Xzl6Wp6hvQzrCU/lZNj0prg1W69fWMwMT73UFHRzwpqIH1ejMAzvvmxZRspWCnqzy1Yf8jDQ368yctOcFtKVIlqC5VR7eig3+319fbTlAL6fR7kqcOqBmZEwXJHyp9Mla7QrUZQcbj5LHUkolwVak7P1kRo+ehtOoXysv+mj9Ze3Mr+cvoQ4WUJYvtLj253wDhjbTwSiKuuesmscwF7Py35OFEGPMImz4ck6omcOGn5VWR50o1ztLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yblEAxLcdYxN/o41OYtXTNQro+jhX1wIeWn7GbxZDzg=;
 b=aahXlZrN3+FM5JK4i2JtEuku4WfGod+XF7EwolvogY3SaQokAoos6Mu+8gFO8yiu5RJPhND+cWcUkwiOl779Yo3ZytauXIQw9g3ugL0Snf5XtQJgd8DNjPhRyGUrUgcLHW7nKzbNp1cKDgm6V/TACsIj+2WXvegPMzzrGGbJET4A7hGFqa+Xu5d5fixVQd9e2I4FopahR8BhHw58VHW8OftIGt2ioqCu2bGdUfqf90AgT14vndvWj/Y+ed2dS+MH3gy4eiIVIaW0Rjv4A/iW5Fan5TCiLsdliCPrDvt4CGrd5/P189ZtDw+ZMNP/ShPudk0iInd+Vnhd/rOWPKm5lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yblEAxLcdYxN/o41OYtXTNQro+jhX1wIeWn7GbxZDzg=;
 b=TnwkGqGqhJNJTYNwqgV3nASZcDSUhjaYhQTjuFWfLJBLesWnzmOdT97/kWikPUR3uLfldLqaS3Jdg3HBml6VvFYTWTCJGtFR61zGOI0g0fLuJp86ebVE58NbpO3cM/fWjSdKiQ2a9E/izPBCMTEeoMQhMV6oth40Fxiz+jROD8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by GV1PR08MB10671.eurprd08.prod.outlook.com (2603:10a6:150:16e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.28; Mon, 4 Nov
 2024 08:36:06 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 08:36:06 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: [PATCH net-next v2] sctp: Avoid enqueuing addr events redundantly
Date: Mon,  4 Nov 2024 08:35:44 +0000
Message-ID: <20241104083545.114-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0226.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::7) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|GV1PR08MB10671:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b9c4bf-9da4-4f21-f0fc-08dcfcabb970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mgdZF/Khp7dmWAzjPe2NiwIu1NbxWpb47P8r5a8CkR9mmAykgnDSv26X8mvA?=
 =?us-ascii?Q?bkD4k6fWaKi2hTBXVKO8KUGiuJwEtDtFP3/KU76f3b673RktJS6REpDfOOoj?=
 =?us-ascii?Q?xPjrt+IXc7VG6edIhkpvg1khrh7cVmnCeKCFwG/gmqYcItGEliu9HVMut2xO?=
 =?us-ascii?Q?xCfLBizn6qJsGRd/qrIAZhxtnbyWXGWC/JBRg2oujEQ628KezDjcrBFofjYn?=
 =?us-ascii?Q?ilPbHCNN7ic89y3lMu6sM6Pvzd19aWY54N521CdVNEjb15Jeoil3YiN0FvwG?=
 =?us-ascii?Q?iZqpzHxrWfUPu29ZZuk27wttKsYOxYk3W5RosntnIEVrn0f7BawawXB7/AP3?=
 =?us-ascii?Q?gQa5cjotcs/uz1YuIydla6XPIg0k+q4h+yQbxJ+zhhRx/GnWefAXHsmiRYpj?=
 =?us-ascii?Q?kX/H9PH0U+La//sgePo5EeqtT4dVIxrxWKlsqOjoqjWRX4r8wRA+H7HMB6d0?=
 =?us-ascii?Q?oNQSNo1hgDjqnm0dkixElbEvlCv7VfHXGzJZTKOKkzo68oyqd5Jz7d2fzYbu?=
 =?us-ascii?Q?70NhLxllu0oAed4nZYungBQTcT2NpDhilmqHglOQmFkF52jzDIwGR1mHllSM?=
 =?us-ascii?Q?NtJgjx1F7UqFdSAPHjES7uKaSMBurOGix376tYt8GlOziLWJypV8f+jo4YSA?=
 =?us-ascii?Q?IyG8jjb342qGAEphuf/gNzarlp1jaNOJiMtJEBGzbY+tK6RbEcWwvp7aSL2t?=
 =?us-ascii?Q?dknPIdWgmTFSI/qRyUq7AIX2q0vErpPP1NZBDfnjAkzsEFqXt55w8f0/Dx/i?=
 =?us-ascii?Q?HtLKLvcv3HgnfQozeNSq/frPNBaXcgt5uxS7ELQj+JqsotFNwqebg5U//Wol?=
 =?us-ascii?Q?Px0jOBa+p6XoLIPHgRWBCNY4TR6OE0f9K6k8NvYF2eOYmwWFslgt2m/ep7iX?=
 =?us-ascii?Q?vKJzx2pqC8uy9J4LDBd/d0n7p9hxmWLnzZDQes73h4ly2blGS0ZOyXrYsLlS?=
 =?us-ascii?Q?U6TdgIaurzmc1UoJM+Fb64UxMaMnsDAYh9UFzBDpTUOwTw+SKjaHwGbEu2QN?=
 =?us-ascii?Q?9TcAg4rH5ykYigN0bkAAIhf0WiYjZnGFd0BWZuFGiqtAmiyh4p0hfKBjKlzE?=
 =?us-ascii?Q?X2FRYdLImIoIzuzOUGQCS0N0J3cyOlHtdrSZmcgvjjBLdptXZ7L8/Yjq9DGx?=
 =?us-ascii?Q?f8stW4HsnMaIcY0RUby0uAoxg2pCaxRy+T9Tu6fvxcs4apdtglxx8Nw8rVOo?=
 =?us-ascii?Q?EGVr+pxYJ6/LHCQg4MeScQf6zrH1NtoIP/oNwLlXEHWP32z7z/zq1r/lwQ0t?=
 =?us-ascii?Q?u9P3jJZuBpha0ACEW81th3WgyeFN+/TYYdHDBn+ghzmTItx08X+TtSNWXGXS?=
 =?us-ascii?Q?ha44+aIIs+oUtTv1Xt5lWLbXi629S5APb7bklOVt2Hcd52PFwZE8YsAzVisG?=
 =?us-ascii?Q?Gk6azGI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iGD0LbvcZZ4cNX00HAoIC1i0ua0JaTeo7iQLIrZSeUYh+yaouq6VPWrR5B8K?=
 =?us-ascii?Q?mMtsKMNWbRYg21Ev4B+h97mr9oFYxTEniMfrbaaelP8S/0smHtBf2bZDwIvD?=
 =?us-ascii?Q?HZVDI64HxlnoiSoSD5gCqQtXb7ETD5RiBX2WWBjqujeygcvtk1mWF4/xWxLn?=
 =?us-ascii?Q?OMCmr/3UZXwYb3h6vkEi6zxmL6xjE+1mWrE2Zk9WaRbn7G4m+6WlQLuONJXY?=
 =?us-ascii?Q?3lzNo4OqBiPkPLUCC5+cwhdC7nnQL/4ApCWeUx3Tn0XSdr365z35zT6Hw7ig?=
 =?us-ascii?Q?GowRzea9bO+gIrYnEW8K97UaqAzNAQHTFVCBdfNisGXRLBQ6bQhlYIu6JVwE?=
 =?us-ascii?Q?WQphpVIljP4q5XlE5SsJzL6DcT1y8o+C7YD4UQGQ3f2lEL/rL9kaXvF148VM?=
 =?us-ascii?Q?7kdcFOj6q2OkM5zio1HyuX0b4ZJgcj4LwSTXbL662gSd4HAU1t2rqXCjH7wb?=
 =?us-ascii?Q?5pkG1skLaxEbXVCJoUDKV0s8X6hRjpGJAAnyeLEPJY7+Z2/gnUOj4VfZoHWZ?=
 =?us-ascii?Q?eSAB7buKjAFYp9WVUsUs8JSXkXnjueEn3NzQDeGNfpNe/bLrYaV6rNxp7q4T?=
 =?us-ascii?Q?auapRG8yespvhkMjH1QwlR4SHkw+4ri+0Jg0jOmsO78br+gbUuTxIkN4TUAe?=
 =?us-ascii?Q?2b/mIl06fmcUdPoMGIB/CE91Md1gh96a1riCAqoVboiQ6e3ZsjkLuymJZvVY?=
 =?us-ascii?Q?0NwtKKvfSc0j3v5rObxtE9gWzyBsqHJVYPmCZ4SAraROv95+3FA3Lv4R9cRJ?=
 =?us-ascii?Q?PJ1z27zsSCwvhvQq3ReKISsYJM0Ev9dc/ic/b4zZsdYfJz7e2eR0708l//R2?=
 =?us-ascii?Q?+BoGpC56exbSU3Sa3HqgbkrQcojR+El+tRQrgcRyBr33wtVhqwm2eqdtj7TN?=
 =?us-ascii?Q?YKsSNCMWBhIFZaI+Lia+N8LMVArS7v1WTlVPIPTcR7d0V0ATXUl/PZDWBGEE?=
 =?us-ascii?Q?3iUa3Si8ynwPqD6IaXwuT15PDSPymaA8SXv0i1GRFVB4pkyaD8ekPenV9cY6?=
 =?us-ascii?Q?QFNH7avaF6igOXIirtQEOlzTK9JIfSgFuyBnr1867BIB7obh8TKLuttAa6Gz?=
 =?us-ascii?Q?hKpVjfD0NBunYorUB1TKgOcQlL/EfhNpDnhnWAaYM2jNYNiAIJDo1Mn7f4u5?=
 =?us-ascii?Q?xGuFGHKhfe2DkHD4JZ4sWPfdFlvKKG9jcTXyrQI/7ejIyjnYnfmYxwslZPbC?=
 =?us-ascii?Q?6m1mIJlE5rnT2a1kmskU2DPiaY+LI5XLcsKKqF2JmHMjFt3QTDyI+c0UbVIK?=
 =?us-ascii?Q?EKbgwu1gbMwKgtv4on4cN1Nr5O4FUalD+PVXXPrxKjPTopmQqc/u2/ItQfcc?=
 =?us-ascii?Q?Xo89oi4dLdgIVM2FyJzFsE+ioTzAkvX54n34cTBHgfQ/PstTFhAx2tSevS+j?=
 =?us-ascii?Q?vcusQ3or84I/r55PREHjd+omMW8WH6C60r0oOGg1Va+8XmF4WD0iXwlCSrYM?=
 =?us-ascii?Q?R2uUoZj6pC26JNCcq9pFMCmWrSTGeiNBVj5xZ+REwZjn/cJcDQd44NjMzzam?=
 =?us-ascii?Q?GUXNAtYnIsDsVEi8e4HbWT1u6MTzxT9unVK5ErEqrHpZ/g5vR5diGhyuRmdD?=
 =?us-ascii?Q?49irSTAmLfaKLdbZ7+rnnzwMKsZamI+C1TPvfAW39TL8Y3QJHOcbP3K5zw73?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	z7cLkslhZjl5WkVxNY1J7TTqptK5/3gnBcp31rnr1m80LrsfpGns3kqp+m1Hjp94kgQnms4OeQ9V/h+X4Bujog7uI1yxaUP6CVDdLvWDvWCcbc8V7w3fCn4MDHV+HOB9NBq37doRJ8CcaIWMMTV1VaRL6aJGBJQjox0YsV3fLRKUV3arF+BqfMaHYjkV/fTMQmvKfsLF3SJCnFMaOIaqPDkaDVg822cHaRWw0PwIFb1Z9VMr8YQIrc7a9C45TQF8qfVZlHVYqbewewvTkte3+Jw57AzId2+8TLnKbrgaoR6c8rBQDNIokCtKBA8inuhE7zoar5AoeFDjZckBG98qsb+IaEdBjEZ/EakC/Bdb6YXlF8ayZC9FhoStPN71Q3nCWIT85fiKdTOwEfKAIiwF8WIU8O3Oyuscvz3bT+FQ19S5Q4RGaTwQz+eeVsxpUax/T6uEbywdqtWIMJPL40gEq1wL7m7AVmuMJoYDGUKZtnhLHV402XLJ2W1TO8qOWGAvjlH0NlA00KoPHV7RqGmswwb8ItXeRdHTWLBglNBrwM+rmAXL/+G7wPQK43GtX/ZQXLjVdePjMrIACqG+0cdxrIUakScq+Quv0bxnFtLs+uONc3ujxUvtcmcES9WNXl6q
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b9c4bf-9da4-4f21-f0fc-08dcfcabb970
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 08:36:06.1908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DwGpDz2ZTDjY1kYarokn5du8VnPhd3vxSst9PLkZTl7Xr33L2/6XCqwUog4VmsabEfsLTh7qFLA3uD08JbIV4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10671
X-MDID: 1730709372-D4C8o4iEmd-S
X-MDID-O:
 eu1;ams;1730709372;D4C8o4iEmd-S;<gnaaman@drivenets.com>;7bea9940ffb8aa46f58eafa9edde571c
X-PPE-TRUSTED: V=1;DIR=OUT;


Avoid modifying or enqueuing new events if it's possible to tell that no
one will consume them.

Since enqueueing requires searching the current queue for opposite
events for the same address, adding addresses en-masse turns this
inetaddr_event into a bottle-neck, as it will get slower and slower
with each address added.

Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
---
Changes in v2:
 - Reorder list removal to avoid race with new sessions
---
 net/sctp/ipv6.c     |  2 +-
 net/sctp/protocol.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index f7b809c0d142..b96c849545ae 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -103,10 +103,10 @@ static int sctp_inet6addr_event(struct notifier_block *this, unsigned long ev,
 			    ipv6_addr_equal(&addr->a.v6.sin6_addr,
 					    &ifa->addr) &&
 			    addr->a.v6.sin6_scope_id == ifa->idev->dev->ifindex) {
-				sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DEL);
 				found = 1;
 				addr->valid = 0;
 				list_del_rcu(&addr->list);
+				sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DEL);
 				break;
 			}
 		}
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 39ca5403d4d7..8b9a1b96695e 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -738,6 +738,20 @@ void sctp_addr_wq_mgmt(struct net *net, struct sctp_sockaddr_entry *addr, int cm
 	 */
 
 	spin_lock_bh(&net->sctp.addr_wq_lock);
+
+	/* Avoid searching the queue or modifying it if there are no consumers,
+	 * as it can lead to performance degradation if addresses are modified
+	 * en-masse.
+	 *
+	 * If the queue already contains some events, update it anyway to avoid
+	 * ugly races between new sessions and new address events.
+	 */
+	if (list_empty(&net->sctp.auto_asconf_splist) &&
+	    list_empty(&net->sctp.addr_waitq)) {
+		spin_unlock_bh(&net->sctp.addr_wq_lock);
+		return;
+	}
+
 	/* Offsets existing events in addr_wq */
 	addrw = sctp_addr_wq_lookup(net, addr);
 	if (addrw) {
@@ -808,10 +822,10 @@ static int sctp_inetaddr_event(struct notifier_block *this, unsigned long ev,
 			if (addr->a.sa.sa_family == AF_INET &&
 					addr->a.v4.sin_addr.s_addr ==
 					ifa->ifa_local) {
-				sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DEL);
 				found = 1;
 				addr->valid = 0;
 				list_del_rcu(&addr->list);
+				sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DEL);
 				break;
 			}
 		}
-- 
2.34.1


