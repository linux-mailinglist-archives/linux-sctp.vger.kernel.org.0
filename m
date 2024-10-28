Return-Path: <linux-sctp+bounces-270-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 122149B30E8
	for <lists+linux-sctp@lfdr.de>; Mon, 28 Oct 2024 13:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955F91F20F36
	for <lists+linux-sctp@lfdr.de>; Mon, 28 Oct 2024 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E621CCECE;
	Mon, 28 Oct 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="UlnESSEN"
X-Original-To: linux-sctp@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CF188010;
	Mon, 28 Oct 2024 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730119763; cv=fail; b=g8iVZj67Ik/ME5GkL0mjNaAhC8YFm4WkOqWB50/Ga0gKs4sA2yzmIUOPgrYdIf0i2oQSx40dPpt9TPqwQao+MyxsPuCFwm1FI5et0qtdqsdXHHxOg3/WnVUke1JzNv8C0iURTwSBH/wY5loGifNjkRdbBkhrjEfO2EMqI9rrzew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730119763; c=relaxed/simple;
	bh=8q/jlIpaa95LTp0epZJOjCFCw2+Pp4QKaIsawnYXXu0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S6q7P84GyRhMSNMhJZ2e955NhQvCn1Cdho/q8DYorDhAqv2HAcN0d7aL6J1F+ZMApaSgRv02ol+UYXjpyJSSBIjiN3z7R9iQi9KfxQf+WLTcxwRTlRp6EhxdxaTWIXKEDW2XoCkFJtESjAl9WCV32m4riNlnHi/MnmUz9ibpsA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=UlnESSEN; arc=fail smtp.client-ip=185.132.181.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05lp2177.outbound.protection.outlook.com [104.47.17.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 524ED6C006C;
	Mon, 28 Oct 2024 12:49:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLvRxCR+5F84NsW+W4Bb0ON3P4AoY7uq17LknmAzu6cA7nXKcTVatLdEdfR/vC7nw5NTkvejTbdyhqAfPdo1iIWZjIFMByDNhdleFjr/u/Q0uk+k6QG/zQms5vGLhP9b37GvG927xoS4Dk1RrxHxHEsWyaK7pMUA1PCVI5qGyE9fm65Fdf11IPGmukoTWKB6J1izD/aCWoT3syvhR2WQNrDvx2ybIaw/EIaIpYnJo+NlAdjjLZHTHUCMjXGMaEb0yCv/5W0dRO4o5e2ZmhBs4/YA2RFwLCWs1OkoaNtzFrY0iPKpj3FXcNKqRdrz9zeceELrWmHAsI18AsXeZ/5H1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=liznEMtDFRnxxSsdPXaA0wGRDNrEisTRT/g7aQMLiw0=;
 b=IpOS93cySGp6mSuu0lptNdJ2gsCwNNjO2qWXM62H44XEapA6b6bbdgOOr8HKzJtqjJlIT210d4zzevhmkPj/8BgCbmg6TEJzrhGA56IpJls49tnxSfySrpLfEShoDEcbWuvjRjqu/+bKSx3jWSsF6Lm1O3X0zr+qxA9C8PRGeIdhZckwuHBR+Kb7iEjXwyyiR9lwTPgW5/OIfrV1LFmqX2rzsh/sqRXaIPcItzz6WhrjwAcrEUWl0kHUBz+VIYBFRsqn7HLTcr7UVrwYeIHw82iGEY9YA+VDkIHoGkXqIgZx7DbkBx4+Y7JmXrnrqKGtPfcVUf9dr7MnDEtjv83w1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=liznEMtDFRnxxSsdPXaA0wGRDNrEisTRT/g7aQMLiw0=;
 b=UlnESSEN1BpBkSZKCoTdjNSOybP3RbmHDnUqc4epMh4pjUFpYNQuqaUvkFGaDkTPXCV0MXBCoZ9OL5VF9bMcyaYeWkPqkuvGmvUyOEZQ7hEEFJsjbU4ZQMu7UCxxuImH/Nn4Pxdf5adQtR1VvqErqmPxBwtu7oe9s9irpaEHYSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU0PR08MB8812.eurprd08.prod.outlook.com (2603:10a6:10:47b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 12:49:14 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 12:49:14 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Gilad Naaman <gnaaman@drivenets.com>
Subject: Solving address deletion bottleneck in SCTP
Date: Mon, 28 Oct 2024 12:48:43 +0000
Message-ID: <20241028124845.3866469-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU0PR08MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 148b361d-3531-4fc8-041c-08dcf74eed33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dXl8+Bx1egetzdNmOXISi9ZCE53s4LGWLCvPXfSTBpxbr9fn7czNqBFddTn7?=
 =?us-ascii?Q?UtaJrhMy485YuOeu/jIp8ywSIp802+EzJxDoDlodbguHeV7uISURr3ZbS2OO?=
 =?us-ascii?Q?F8LaGS1xZtfFIyd17cm+Ci8SGQJNA7Q249vlS5JrxzK0g8kY9fJ6MKuu/6YC?=
 =?us-ascii?Q?JOthzYzJXbb7rQusKEoly8P75DZDRWxniOED84TSzFRBrurb1uZ9voKBydbn?=
 =?us-ascii?Q?bx8jMlvHDUAW/EeW6CCTleWs1+gYb/80EsEkKlOB0WHab3d0aca7TcKB6EP0?=
 =?us-ascii?Q?1+G8BdbHece2m1C7BPdiYB6O+hH5bDC0Z/39xCTb4VRlIpbqaI4AeSa3OtK2?=
 =?us-ascii?Q?70AvXwRL+7VLvraVelK3+9oOmFBRDmw3Qe2bNlIYXgxYM3fUC9PHyizBXFim?=
 =?us-ascii?Q?lQD7OweuxX5WHLT7Fu+yWZGKLYUn7cjfAtr/RS42VVe1fvlGEibUXVXnVW6G?=
 =?us-ascii?Q?8EdiIiPSLHlwCn9q96gUUWtn6zeChKh5U6QYJMfVHrhQbcn56ipp9wYLUs9t?=
 =?us-ascii?Q?/TbeeFMDC6CEBMdp1dgCN9BfVHu3xgPQgxYy0toRDXRQBRi+xr6e5FW7Jd4s?=
 =?us-ascii?Q?h7trNYY9duQ3VMRMJ8J/wA+x2CzVXLXEz14YOlTO/HTAauYjj7B77KMXOR/q?=
 =?us-ascii?Q?6bD2wOOjrQuBKIYMg0afwBRfbiI2DS7IN8xR+dallfhriIj5W6z0FbX5CWVX?=
 =?us-ascii?Q?N508WcWygDpFUZICTtRDs6gxoIlV19g9JvZnwSZPIJaGFPDRU6unhRxRSqT+?=
 =?us-ascii?Q?VtYCjYfx6ApQjcr46ypS7P6ZrGuLipmQw11O+jgj+q/Ce96Q/9Q38m11hmDA?=
 =?us-ascii?Q?ahT00bgHn/DmMi7Mb+b/HjC6imcuvfDq51R0+HolUbrHsx6fxQ8Fn7PxGa74?=
 =?us-ascii?Q?LTJ87RvI3Lq3ZZunIr/kAbOGvSu6wuabWPossG0xjqDK7Mps0S1uuHxwOk+M?=
 =?us-ascii?Q?yc+ZizffG5Povxr8Rhot+eOKTR8S2o52PmDtGQO1OLh4eT6vlzSH87tq0n2D?=
 =?us-ascii?Q?9wF6spcEFA+MU1DLrQcHgQYlvQyy9wsNCulCu+jqBazVAaB4jqK6+Ye/0VIc?=
 =?us-ascii?Q?gTBPoYV+CBhj8bykrj5MiOH4Dd3CnGjq7H/d1B8QwIpOKyTptIYCvw1i6sWp?=
 =?us-ascii?Q?XbyJxFmSU/CrRLEaQEdpTLAknv3zs2Y/ArIZ6+2S5r+JedD40offDsjG+IxY?=
 =?us-ascii?Q?K6kc+geCM+Erf0MkZ7/BDv+Ya4c2yENslzTlsmsekE/AKd0bXUYxkQmF0fMd?=
 =?us-ascii?Q?2UG6kNEsuLWYmSPBCE+8p0b3UWReVZXV0Vae36+YXPTGFPBY265/JEJRS+MM?=
 =?us-ascii?Q?TaPPAGqxOzkAsxCBZHdrq6Ypfsxm4lXuiXbez9D2y+AU4zV6PJwuhpcBnUWs?=
 =?us-ascii?Q?O6dk/Rs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JCOSVR2nLBykunBx0Lb0lwBAuOF5AiXUqD3beX/suiPHYdVtBJyXX7P+qZaT?=
 =?us-ascii?Q?YD+G42mSMJ0IwrKi3Z3CFoGlGBD48VhKd/ZP+JMISySMD/GBtUW0DjTG7F2H?=
 =?us-ascii?Q?BKZxRd+5zxGmy2Fsf/jqAnQokXHTl154c0xZBdHwwF9iI547yszNTSpukdQc?=
 =?us-ascii?Q?T7TDOx80AmmF7EiJ1fzzZwoSXoAMxpBJRkDnqtTf62eb6cIYwV/MsR5rW1Ha?=
 =?us-ascii?Q?Hntz2izQ13KW+Yha52tlSzllAE4X5N8XPCCapZEg8Gu2OzCYSvnSDvbv3C3h?=
 =?us-ascii?Q?gmzy7sKfd94DkgPEUR0rRuGdz9QLgQr6adla4xU4pAugqJJCvgHchMcVLP6o?=
 =?us-ascii?Q?iHtljUcoPU7nzxC9upMy3Tta+YDkKlEz+eimT8g8WMAJFmFscCIGXIrWqA3a?=
 =?us-ascii?Q?D3VJXEl+mJMS+4q/1y6/YY72FBIwqIbPa0kmahFB2BVJ6TGef+jlE8rYfq8V?=
 =?us-ascii?Q?q93aFS7p25H2wd0t+yXGmk2nAdqUACLRi48FpgK5621lFdLXKX3fCRhkX3mQ?=
 =?us-ascii?Q?siX5bse5Fti2b6kQjISd/h2mYwwJDV4rE7cqQIP/WqQJjMklaX0Cdr9VZVQB?=
 =?us-ascii?Q?ib9xK/m+GcD37LZXaBv3sWW7sG8MOQM/yF2Lk7Iodce9oFat9ZNnw3JTh6BW?=
 =?us-ascii?Q?cpvG9piKzMxJQdjVqelJt2RXRW6VMF2liheaCeTN7PmK10bBSIT8LXHIt2lx?=
 =?us-ascii?Q?ejUvLgA8jLGAGdt4/DExTk8AkrRyruD7+qZAA8Sq0/9emvss/xd8F0h7YzTD?=
 =?us-ascii?Q?DetHOjohX3qB4dtKy67L8sA3aFAOH1E6IhaW16bLVHmwz0IuQ9erLrkwWJiJ?=
 =?us-ascii?Q?G07hW2xGR630m0wZVt4sCWgH+ZQezpNtR0X0I+STwwQ7z4z9gxA1PMHSNPv5?=
 =?us-ascii?Q?9s5JoD6TVhFlAfCQftliPLnyeOS9hs9WAhu4RVi1BamhoZ9ME/NZ+iiilJnw?=
 =?us-ascii?Q?tYB/eF/Ni87i1ZzRrlIFLVxfWwX2KOBNl4bMauEpqwWvdBY0eMBmjahuhrYE?=
 =?us-ascii?Q?2t188PKl2LBdziP55S7OEUvxnQqZuQudZMH2uq1/V0DTuUP+4YuKdHakvtX3?=
 =?us-ascii?Q?0rRc49HrgWT0LpByj7aI61SyvuaFNV9UAXvLjiGEwoPJnYaFfVowIvxxGuna?=
 =?us-ascii?Q?+ZRa0olEd6FKddYOGg1caNFJlS3pTX45RleLWWw1bbefnranjDn7NUWUDtpt?=
 =?us-ascii?Q?uNfghOuE63K3UvxM+eJs063JDF6jsRXlaKk3y4hnc7dbYk980Q3JmrxCt3NQ?=
 =?us-ascii?Q?h/bixFHqA5opVzVgkg2yR95uOfyLO9G0kZQQGNtiSIY5fitVK97uvigR2A1k?=
 =?us-ascii?Q?Txq396fNsV6Hm0c4yVhEBc3ZC1VR+eJMBfGnLZBMlpH+Luf9yxgbk1AYLIF1?=
 =?us-ascii?Q?VAtpYYIk4MDYeZkSu5HkwLntgd2NPfuSqrcFIIEpu9IJogfULMFalyTOJMzO?=
 =?us-ascii?Q?BPrq5PZYnra/Q474dTiktgWI+LqkF5IRU3SP0707ZMDUkMnSRRJuugh99T8u?=
 =?us-ascii?Q?6SFvqcGzgQ9Kv1ZGWQOmjITav6l9s2dcWGA0T/bEDuRLjXYRnRcfB28JUUlh?=
 =?us-ascii?Q?DGyAQtGF/nHik8sFPM+2JFXO6D1cDLJRNxJOxrI+?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+YJbsrhfqR3jC2ubJ7E3UpUiVyZyWQohRrYfEc7W1Kv+FWsy5jRjb8XoCW+3zakwAtXvtZKYlWSvols+8DkXJ8C3luwI0ciznoZNsQRW6SaDo0v5KnEJwIrz6HS4PNGyHggggJfaq+5A6H/uF5EY/c2Kxe2hR/0qksrgyvtTS8n5KKPObhq+29mKN7OHXU45UAsBd3fuWXFTaiceG1KZoV+Dxk+ADwzi5QAYWRxynBnxpmDyJuZ6vGVV6SpWGiV9IXTirOZhLkyMbP/UeFwwiOcK0JftzLdqQcYxX0FQ+TVFDXCa94BSF+xKHoBT6nbPS2XNegZ1H1m23EurKXyMyGH3S3DyW6lx+8xamsz1l1DgHON4eWTIyag9A3hZv4TXBqo+JuW8vK4rU7gqJxRNP86PwUM6h/UMjZpNq5TIkkzf3pM7DY88hacOF0HLZUrzh4qVOZMyBwm1viof2G6EzssQI61a7kwFZpyM5yJHUF3YuGTGgoAl/EqQPDmJCUeMd99vKiAg597hWMDkHOpj7js8+CTNArIXbvl547UM2lnAfrh8yTSMSL1ajCw8lpM0TFsAf3hIUihMyX1yubgPqsjZClV53k4CrRQuf7JwhyKNZbnFkahUHFdj2HtN03L4
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148b361d-3531-4fc8-041c-08dcf74eed33
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 12:49:14.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IDpoldOLSJ7o6xhlJH70mkIA4VwKWEF+SHZd5AuqydjSw1f/bI0SVfGzg/+w/t3V5QAqoGsM6FGGLlrNe8BSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8812
X-MDID: 1730119757-lzXIS2pw1Mf9
X-MDID-O:
 eu1;fra;1730119757;lzXIS2pw1Mf9;<gnaaman@drivenets.com>;0fb508fd2d7d252a5b49e2d561d41b8b
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

We've noticed that when a namespace has a large amount of IP addresses,
the list `net->sctp.local_addr_list` gets obscenely long.

This list contains both IPv4 and IPv6 addresses, of all scopes, and it is
a single long list, instead of a hashtable.

In our case we had 12K interfaces, each with an IPv4 and 2 IPv6 addresses
(GUA+LLA), which made deletion of a single address pretty expensive, since
it requires a linear search through 36K addresses.

Internally we solved it pretty naively by turning the list into hashmap, which
helped us avoid this bottleneck:

    + #define SCTP_ADDR_HSIZE_SHIFT	8
    + #define SCTP_ADDR_HSIZE		(1 << SCTP_ADDR_HSIZE_SHIFT)

    - 	struct list_head local_addr_list;
    + 	struct list_head local_addr_list[SCTP_ADDR_HSIZE];


I've used the same factor used by the IPv6 & IPv4 address tables.

I am not entirely sure this patch solves a big enough problem for the greater
general kernel community to warrant the increased memory usage (~2KiB-p-netns),
so I'll avoid sending it.

Recently, though, both IPv4 and IPv6 tables were namespacified, which makes
me think that maybe local_addr_list is no longer necessary, enabling us to
them directly instead of maintaining a separate list.

As far as I could tell, the only field of `struct sctp_sockaddr_entry` that
are used for items of this list, aside from the address itself, is the `valid`
bit, which can probably be folded into `struct in_ifaddr` and `struct inet6_ifaddr`.

What I'm suggesting, in short is:
 - Represent `valid` inside the original address structs.
 - Replace iteration of `local_addr_list` with iteration of ns addr tables
 - Eliminate `local_addr_list`

Is this a reasonable proposal?

Thank you for your time,
Gilad

