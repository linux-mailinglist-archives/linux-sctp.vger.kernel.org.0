Return-Path: <linux-sctp+bounces-279-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B889BC88C
	for <lists+linux-sctp@lfdr.de>; Tue,  5 Nov 2024 10:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9137283989
	for <lists+linux-sctp@lfdr.de>; Tue,  5 Nov 2024 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F71C3025;
	Tue,  5 Nov 2024 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="fwbIPGgX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.183.29.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED694317C;
	Tue,  5 Nov 2024 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.29.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797363; cv=fail; b=NuVSn0T2J8VRFUCM0E4YIq9eAM6jjY+9E4LdZ3SLhFO8YpmLNWdbNV/4GG2yL+aTMXbaJwjrs361lwl+HSIiSC/Tg64WvVkLrmLpzh+pY+QCTowsUUJa5TgdXPeC914PSOH0vh5I8lkOTGzCM8XNC3mnURWBaTSUsWjYUQS1Ca8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797363; c=relaxed/simple;
	bh=mps/tRyxdsvvKPB6WhO5CfmhrY+dtlwuC1tvyLikIuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mNjr8LBiekV7xZe1fcwCyTiBvEXIEYKDHM/JHQJZjV/Bt7FCNa47OHKxBzI2fkoo2eJl60xn74K7ldVHeAWkmp34R1XQ1ZhO5O03gYyvaNpY+i2ZtM6QwLLMIKIa3zh7p2Lr+cOxZSny16K56sIAAuVWgKy0gLT2kH9zrhY8mcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=fwbIPGgX; arc=fail smtp.client-ip=185.183.29.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02lp2238.outbound.protection.outlook.com [104.47.11.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 1EADD200069;
	Tue,  5 Nov 2024 09:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hACjiym4eRZRUZFDQ6oAJUTSDs2lSJxoCmEusPZ4Akf16g5td7pXz64g8AI1jzb/UtZivIdDrQ5jKGIjZtCgNzFCh2ShmpybEXay6ocrTqprTPBJw+EI0Frwl8vW3jVGK3+cNtXZB0ZGoZvqYIdC27PjJnSAhGMKVZNjWubVsshQtEHtFEj3DHGn2h+ilYn1ohfJfEepmEnMZTEDJ6y4IBbpXpMV4DMT0QoYAwwgF6kkD9ORQ2ECaJ0Fc0w0MiloSfzCQGdZSoNb9qc77Vgsgvs7EHHmgtyuiY+5jnRfe/oHqRsdwH3aGQEMkKRNu4IFIrS0/YSLcPDR51AMOSHfow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hd+5MwXgyaZaWhCrfoBypdQZfO0c4YblAMhpA6u+Fx4=;
 b=LFAH5pBb9K6nPN2hjorRj1EU5WaPftIsUd8PyzEuGUzBr1d8844DPY7tuJbr6O2Vi6BjWRrkp1K5+05tqTwIU3EpfZKJth3474MtuanTutSsn7vUudKYZPCrgFxzxPdjMAkB6euLQNd43kJ2UYlDfy6wawkc3R4D8fDlG5dAva21GuE5xRzDmoRBIUfh6pArPR0qUZ1G4TTrojAjbjHmQZc1d22oexeVkO4FIwcrdnxHXvr2b7n02t5GEqf4EKlyChNFjP9NWg66TIx8uI5ywXzgbYwLkjybh1hPwOYroNIAUFBjhWBNcaxeT+/IyfVLnL6L7LcbkfmP0ZZRNeiCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hd+5MwXgyaZaWhCrfoBypdQZfO0c4YblAMhpA6u+Fx4=;
 b=fwbIPGgX2SsgYNnr+h+vjUQuZx4V7/DOUOvCjbd9Q2JYcQOMDAVjBvvCf4/Dz3sL48tkagUnlLXJAjq5NDz6cIDwt8mrpb/BFfh0jxKoPWzh+Q4idozf98Ca8AIrbUysbvamMffHoZFnPVSTrMJCYNJjy0dGGGtro69weKk85js=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by PA4PR08MB7569.eurprd08.prod.outlook.com (2603:10a6:102:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 09:02:29 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8114.028; Tue, 5 Nov 2024
 09:02:29 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: lucien.xin@gmail.com
Cc: gnaaman@drivenets.com,
	linux-sctp@vger.kernel.org,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org
Subject: Re: Solving address deletion bottleneck in SCTP
Date: Tue,  5 Nov 2024 09:02:17 +0000
Message-ID: <20241105090218.19-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <CADvbK_c5jNywSZOwSb-qcfxoNwauG1vkQFg6a8h4QOq50Q9uSQ@mail.gmail.com>
References: <CADvbK_c5jNywSZOwSb-qcfxoNwauG1vkQFg6a8h4QOq50Q9uSQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0323.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::23) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|PA4PR08MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ac5911-f197-4d11-97a1-08dcfd789397
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VKhTVsdESgVSuEX9WcNcAXxj/68PVgrKUOmOH3vYQXilg7/e4S76jTX7NjF+?=
 =?us-ascii?Q?f8trQbOT5FxclQl643xTb3NHKHVY5onPCpehnnqr3llYLEOZukeio9qkJHz9?=
 =?us-ascii?Q?r4WyF1pdfQKyvmXQgioQkq9YVYYPdbKteXr7WWPlXsQbAqjfIRrM7JkG3nWa?=
 =?us-ascii?Q?EbSLb4LD9u3zmQLLG+BzgGYJjLE/gYAkIertZt77pc/Ep2LP1f1OD6TeuC/d?=
 =?us-ascii?Q?HNJyPBhaaEwoIbkmgJswK464I9m2naZqQyEhBIDWbOy/kYkuymoW2Zf3PgHO?=
 =?us-ascii?Q?7PcNY1ZmNczYxpYT7Hs+TNS0BIjtYVk/pdHKLwQ0DBLMqbRgnoUmXzjpL0oA?=
 =?us-ascii?Q?noux3qKIHmedC6ChPhwhT+tLb3RTvNI+eo0mPLtJaPFaUE1vWg3XKS7LyJ0q?=
 =?us-ascii?Q?GBLDY0855hGkjyJAykT7zVMBy+v04+mxDtU7RQeE6l2xKQJLtpMtuBIB1Xxs?=
 =?us-ascii?Q?DyEJKuxCoctpr9GL3lcLR3Op2LuLiyrTLgSAqkhmrnvt0Dt/IO2yv2+rnU6p?=
 =?us-ascii?Q?KWri4f/irwU5Q7AD5IRqSUoIL9oV9fJLDrlwe9PlLmopc7vFQb0zQJbyVcip?=
 =?us-ascii?Q?HAvUOR83PbZ2wL5A0w1+zp4yIciaD43lTCaEKE+FUpBzrtOQeOC5WH9RshcY?=
 =?us-ascii?Q?cnPQK2jR0BN6nNf1PLWAqhVDENt84dqaWnz/pjEhW1Hn3nr+YhW/on4gz+v5?=
 =?us-ascii?Q?8Ib0jtGOjywgpm6hEdgPeH/wo9Nuty8fP+RQbxLUXmOqEZMtyGMGE7MDQEFl?=
 =?us-ascii?Q?y+sbaORiz+S5wb0Dkza6ujF+8iwpd2bZq+8AOVJA7u0nWICH8kd/RzvI8Q0Q?=
 =?us-ascii?Q?2S4U62rmjjBNnc/NBwKyX7940dvWRIRqxkl3Xry6NB1lPnyeicO/Y19gSJGs?=
 =?us-ascii?Q?7nXtA1HB5UWCyyBAUh31K6or7kg28IrusNOnwJUNI7bd6frX9YMWCAa07xSF?=
 =?us-ascii?Q?Vp0p+QwhgL0rUEQ8cdYeimiDfYIJAGakSqZyq8LxqaikIxREjAi5CkdYTG+u?=
 =?us-ascii?Q?7PeA6H42stIhM6T0ileH0jCRzOModrWLsKgDCWMGY+2lazvZ9gkPQ5lWQ555?=
 =?us-ascii?Q?FV20iU17NQyatEr8lF7/g078ISkrLEAWjAAEMZ+u3OX2FS8qZ2beNBGAMDC/?=
 =?us-ascii?Q?0X1sS6yGfnRy8wE1kqD6YpvsKzdhFpsiPWhXaElKT3n3T81n9/Ht0msyHC/4?=
 =?us-ascii?Q?q8nBxdiUka+ZfpI/m63xTI74E9ozMXC0Lg+kgNUTmDimvB2609WgNSrUOw22?=
 =?us-ascii?Q?W/a6ie/nIX28zfe1sannUPYccxitmZ/RNNHPItEEd58EC8ZqT9w2G6NUzcCn?=
 =?us-ascii?Q?KESYB0IdaPEOPsPHUg0kfKodYxFU2c+qRwe/zlIEpdn1jShx44soxkO/dEZg?=
 =?us-ascii?Q?t4MDYL0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E2bjlzOSguW0AFF8+td4ayrsguJeEDry5tKGeU+3w9fbF4TcnfuymuwMLW7l?=
 =?us-ascii?Q?IG31PevbfXJHNB1bmAIlCWZFbUa57lovbUMDCyY4ibJ0TiEMovCYV6L2jzmj?=
 =?us-ascii?Q?ZFFxMwT/V41Tfh8z6C3Ep/8neqLF19C2VPFMR6N1OEFTKw+vs7L4v2rnZ7jc?=
 =?us-ascii?Q?Cq/kcT0F/OaojfRqiVp9NZzvucJmEWrnVFEipoJRLGlkBQsKvhMQ6bJ1t3Us?=
 =?us-ascii?Q?DbtOmIIYkII6c9FU+zISIzThqzVaHJYAkokOUqKfh+8+OTxa+AmOCmGAyUDE?=
 =?us-ascii?Q?Y0iRDH+Aon9HVkMRTY34iBJBpQaIYMQXzjhKrDn8ccBrFPZm8r2Mm3v0XGHw?=
 =?us-ascii?Q?XZwDSDP4281glCjbW8zGXBB12xjz2q/aXNZQmdINwPSMeVkwaXR8q8qXZxtf?=
 =?us-ascii?Q?T/2RSDjYgt/JhBjvnRdV0rOy5KcbaBD4x0bU1QUkJhzmivL6lfuDDlweUlTr?=
 =?us-ascii?Q?t0fVCkh5DIAru8+ZGwOvHor/Va3K4BKCKbBoENkWR9X5o1gGBHoRsC8lS+Jn?=
 =?us-ascii?Q?Fnxl3D4ePfj1Y7LuJqAlpPxi6aww1qrBn62oJYIx33MBELjPt0rMKAI9ZtjG?=
 =?us-ascii?Q?lh+myxCRgJ24ws3T3Tz4LPRI3wQ0Xi6rdu8hNRXPcxaqgKFYAttGI4sBt4Oa?=
 =?us-ascii?Q?eY5DvzVwm/30weICP4ebETzXbl7nV/GyTah/P2VqPo3aRKEI8m1gUn7AH5mj?=
 =?us-ascii?Q?yn+TJoqVCMqEcoFxZh011m2F04M6P0L4UhuB4ABu8vpk2Kk2Q7TVsRDIzzxz?=
 =?us-ascii?Q?xDr7kZ//Jg8DoslEd6En/HJ8YHsgWJDKpLUmNEprSB7o+9zgtfNX80oBnfSZ?=
 =?us-ascii?Q?bEKQMZpvfBxH04d6BLvbSDwpty8SiztAOyFeF/vIfKbZw2c/oicDcXjXrklY?=
 =?us-ascii?Q?4Abgi0SrsEjxt3HOVIe/4o2GSwl9mNOQmgEv4fN44kLvyuFkO1tOZsY5aLzi?=
 =?us-ascii?Q?Wc/unOP+MemAOL2T1meFfCzEPiDrl0xjNAx1bgK00NTKhlBiHcxIbPIdde93?=
 =?us-ascii?Q?b5j2ld5WhcYPvsnHLMehCZk1nZh9sIJwzhFBOaTxifplz4gdNwohUgCqiHun?=
 =?us-ascii?Q?mWIgBtuTh4kfMpAaVXFjWp8fSCl03aMn6lgjbDvoJX1ZeULqAX8/A9sFfLU7?=
 =?us-ascii?Q?vgQiHp1WlIzaytP34JuLVWLE26nuKZc8e7HVWmxGag4mEMI7JhFldFjk36cx?=
 =?us-ascii?Q?pwKWbqdnWkUI/R5+cDvWgHnlkE9Hj0UttdqOQy0tYdZDdEMIt7lh6+KOn+Wc?=
 =?us-ascii?Q?nucSKI/NwZm9gMCpPjnLS+DtzfFgn+3V21jMnzAZcVJMmlhnbGd9i3kwid9T?=
 =?us-ascii?Q?a2rM37IZ9JCOM2jyzGoflVwOZuJB86RxfNahLuYi+M1W9xToQX69sfBFQHHC?=
 =?us-ascii?Q?iL9dlH6SsNmd6onmwAU7fwHe8frfsglVnztRwKc6IVGSCUnLJppNwWAEZrza?=
 =?us-ascii?Q?FKNICUrIrjRNWFURiMAj3JYryc8S03pu1/rt4YpWZHgZ54j58dnLQT25fsQw?=
 =?us-ascii?Q?tm7LreMI8uoxWx1gKb6rxl8Y7SBZ5QqRxna0eqFbxdpy2LN2UI7JMR5+Xy6h?=
 =?us-ascii?Q?MBGfftB8NSz1FhkuyxhLFlK2AfUkg6JrYnUr28FJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sAbsjG4Dczso4FosUZTZqA7PTx9fVokvOKbFm7rLPim2O4g+5BEj9s3XoPMG9o74pok+s5ok7dS7A90N8V/IoAH3RyZsi37VmTfxhqroDAeXpdwgVV6MQEEL8WQQ301+w0YjatFTg+ZDOZ3RMs59qiqBxUvKyVJhKKJz6cW+OrGJW28MucqIoBijJHE3u0+haijtqV0GKB156/vPK/uBZZfwOT8inbx/QezaHqnWBYZvhGc/L4UEqP1+z4bk3hf81fgaj6bHSTuKK8kdG5V5NcuG4XxNtU0P9q/zv7DwWup9Tkdw/eAJpeYbvPLCbtxtW1PMkrZDQCAH6RrUFFSHKDiTfO3kg+m0S+WhE64riLc9sQNqcB+HEpXj6GDk4GNcahYLwYQT4GjVFySRlGYs6wfcW7X4hktw45wbWwaVxm9jInWDn2xFlLfe4rQ0gNjbbzSVPL5J4HavG9blvNKNfbSmXbNpobJNLn1AgjROCCIfiglfmjBz9/Ko/WW6sVeQp0DQ8M0vhUEU8Ps65XLewe1+tTc3VqQUXwSk+RPrTFnwItVnHbWE30HyRcuHY5moYX9aiCHtSIHfCDRfS8tIyMdPQzHxCwWPQrtjrsgSbV3ciwrtX0w/0yP3VEQGSVmV
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ac5911-f197-4d11-97a1-08dcfd789397
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 09:02:29.6187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ze62n+dUUmy2bAcIR2HBXsCYbaqN3kijf6a0eud1Jgnfo3A7PfKcqBwmoYMMv8q2LYDPnNuvFAkHvcNMtY90g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7569
X-MDID: 1730797353-GpjuoxE3SDj8
X-MDID-O:
 eu1;ams;1730797353;GpjuoxE3SDj8;<gnaaman@drivenets.com>;0fb508fd2d7d252a5b49e2d561d41b8b
X-PPE-TRUSTED: V=1;DIR=OUT;

> On Mon, Oct 28, 2024 at 8:49 AM Gilad Naaman <gnaaman@drivenets.com> wrote:
> >
> > Hello,
> >
> > We've noticed that when a namespace has a large amount of IP addresses,
> > the list `net->sctp.local_addr_list` gets obscenely long.
> >
> > This list contains both IPv4 and IPv6 addresses, of all scopes, and it is
> > a single long list, instead of a hashtable.
> >
> > In our case we had 12K interfaces, each with an IPv4 and 2 IPv6 addresses
> > (GUA+LLA), which made deletion of a single address pretty expensive, since
> > it requires a linear search through 36K addresses.
> >
> > Internally we solved it pretty naively by turning the list into hashmap, which
> > helped us avoid this bottleneck:
> >
> >     + #define SCTP_ADDR_HSIZE_SHIFT     8
> >     + #define SCTP_ADDR_HSIZE           (1 << SCTP_ADDR_HSIZE_SHIFT)
> >
> >     -   struct list_head local_addr_list;
> >     +   struct list_head local_addr_list[SCTP_ADDR_HSIZE];
> >
> >
> > I've used the same factor used by the IPv6 & IPv4 address tables.
> >
> > I am not entirely sure this patch solves a big enough problem for the greater
> > general kernel community to warrant the increased memory usage (~2KiB-p-netns),
> > so I'll avoid sending it.
> >
> > Recently, though, both IPv4 and IPv6 tables were namespacified, which makes
> > me think that maybe local_addr_list is no longer necessary, enabling us to
> > them directly instead of maintaining a separate list.
> >
> > As far as I could tell, the only field of `struct sctp_sockaddr_entry` that
> > are used for items of this list, aside from the address itself, is the `valid`
> > bit, which can probably be folded into `struct in_ifaddr` and `struct inet6_ifaddr`.
> >
> > What I'm suggesting, in short is:
> >  - Represent `valid` inside the original address structs.
> >  - Replace iteration of `local_addr_list` with iteration of ns addr tables
> >  - Eliminate `local_addr_list`
> >
> > Is this a reasonable proposal?
> This would simplify sctp_inet6addr_event() and sctp_inetaddr_event(),
> but complicate sctp_copy_laddrs() and sctp_copy_local_addr_list().
> 
> Would you like to create a patch for this and let's see how it looks?

I've implemented it, and to be honest, the result is neither here nor there.

Tried first with:

	for (idx = 0; idx < IN4_ADDR_HSIZE; idx++) 
	hlist_for_each_entry_rcu(ifa, &net->ipv4.inet_addr_lst[idx], addr_lst)

But after repeating it 4 times realized it should probably be extracted into
a macro, which didn't turn out that well:

	#define _ifaddr_entry(node) hlist_entry_safe(rcu_dereference_raw(node), struct in_ifaddr, addr_lst)
	#define for_each_inet_addr_rcu(idx, ifa, net) for (							\
		idx = 0,											\
		ifa = _ifaddr_entry(hlist_first_rcu(&(net)->ipv4.inet_addr_lst[idx]));				\
														\
		idx < IN4_ADDR_HSIZE;										\
														\
		ifa = (ifa && ifa->addr_list.next)								\
				? _ifaddr_entry(hlist_next_rcu(&(ifa)->addr_lst))				\
				: (++idx < IN4_ADDR_HSIZE 							\
					? _ifaddr_entry(hlist_first_rcu(&(net)->ipv4.inet_addr_lst[idx]))	\
					: NULL) 								\
	) if (ifa)

sctp_copy_laddrs() and sctp_copy_local_addr_list() do contain a bit of
duplication now, but I admit I like that we can avoid iterating addresses
when they are not relevant:

	if ((copy_flags & SCTP_ADDR4_ALLOWED) &&
	    (copy_flags & SCTP_ADDR4_PEERSUPP)) {
		error = sctp_copy_local_ipv4_addrs(net, bp, scope);
		if (error)
			goto unlock;
	}

	#if IS_ENABLED(CONFIG_IPV6)
	if ((copy_flags & SCTP_ADDR6_ALLOWED) &&
	    (copy_flags & SCTP_ADDR6_PEERSUPP)) {
		error = sctp_copy_local_ipv6_addrs(net, bp, scope);
		if (error)
			goto unlock;
	}
	#endif

I'll send a patch if I can figure out how to make the for_each macro not
look like a train-wreck.

Thank you!

> Note I don't think that that 'valid' bit is useful:
> 
>                if (addr->a.sa.sa_family == AF_INET &&
>                                addr->a.v4.sin_addr.s_addr ==
>                                ifa->ifa_local) {
>                        sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DEL);
>                        found = 1;
>                                       <-------- [1]
>                        addr->valid = 0;
>                        list_del_rcu(&addr->list);
>                        break;
>                }
> 
> 'addr' can be copied before "addr->valid = 0;" with addr->valid =1 in
> another thread anyway. I think you can ignore this 'valid' bit.
> 
> Thanks.


