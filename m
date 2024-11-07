Return-Path: <linux-sctp+bounces-281-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F209BFFD3
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2024 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B401C213AC
	for <lists+linux-sctp@lfdr.de>; Thu,  7 Nov 2024 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED2019992D;
	Thu,  7 Nov 2024 08:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b="abN/iRRG"
X-Original-To: linux-sctp@vger.kernel.org
Received: from dispatch1-eu1.ppe-hosted.com (dispatch1-eu1.ppe-hosted.com [185.132.181.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1000019882F;
	Thu,  7 Nov 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.181.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730967526; cv=fail; b=hL6l0ZBS1EbtMWKwLfZLW5aRtIQSoV3rAe7IseIH2FGjcQm3LbVcs5ni/TM5HYhU9shtmHg7ZpTnvefRWC+Knzt2yKogXre8HP9riWbq5y3bXVeJVaVTQpzLCD8Hn38Xhmu9iLsbnaCACB1yfH57Tk+SBaIGnVOSHx/lGMkDyqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730967526; c=relaxed/simple;
	bh=+4B/GNlHxw4WOvwnOZK2C9rYX+riDGPX5GFCIrKD9Hs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOyWv766F1f7GKW+ZqNBIIZXWtmC0zfC2yfxF6yguKszNW3MUdtZHJHR5/P72EhPtZGQvdQZ1kOtDyjxAHygYIZ7U8Q2RjFismQpZ7o9XLsSWi59U4uMr6vCkpcmfm0OUFLyMhPt6hB4k0CrT+gmOKcu1SIO7uUs8ypCuo6Q8wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com; spf=pass smtp.mailfrom=drivenets.com; dkim=pass (1024-bit key) header.d=drivenets.onmicrosoft.com header.i=@drivenets.onmicrosoft.com header.b=abN/iRRG; arc=fail smtp.client-ip=185.132.181.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=drivenets.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drivenets.com
Received: from dispatch1-eu1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 91513341F53;
	Thu,  7 Nov 2024 08:18:37 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-eu1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id C038F74006F;
	Thu,  7 Nov 2024 08:18:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kCpU5oKKaPT+J1cB8IlLvxwp3t/bHCrRe1XrDEpBRylZdhWPmP4JFZQx9mNG2FeVsGslWMOIYc8Nn1zhgWfXfrEEVIA9+GU2QNiPPb//bO9UTYjI6NnnCNUwSe00ogQZhmM7zitlHZzgE0yiYyL5UFaxVIhtittoVdvDyAiUjIITOKBdIpNIrbX+g1TnF0vBQfwnH/TZhVuX3pfm5XBeH74Qr3hZO/nQxjbXOwAViFrWeLiURzFRDubnFNn+197Rx7pNoeqMdpc5em+O8GrE3lsjVk+8gWEkEIlDlfQ1hcNMg8aHj5CPTxk8saEKjQc20h5eprYjWJDZWqTAiKfoXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMc3+C57UuwJFxzawZZCUk1PnCLUl+o/uo3D6IUMH0U=;
 b=Hd5TQkJ1CtJgXjP/6cuX40ZoJNv34yuXNUwWQiVBHG0ULfY7UgKi4yuWNmq7K2thsALQlyME98VKgFl28zBKJMvq0Ukm3mp6C+ecytbpVgK3AJ8KmEYVY+aOdVIGSsBaiEcXW3OlBW4qn0HMxN00YAaZeT9Y0whN7RdJitXgknaf9y9Rw3dFXpp/EPq0gebizZc2+f3HIXiN7LUu+AELm46mFIE0UARxeVL1GwiQRcFO5Dz+LkoxGLJ/6j1SiA7J8hw4XBZLqP4PfZyHs8drLywoq32iw9EDL+QsmluGSyKXKK9j46parRzyykwFQu/vjMDqO4TYkqO7lrK9bKPaMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=drivenets.com; dmarc=pass action=none
 header.from=drivenets.com; dkim=pass header.d=drivenets.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=drivenets.onmicrosoft.com; s=selector2-drivenets-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMc3+C57UuwJFxzawZZCUk1PnCLUl+o/uo3D6IUMH0U=;
 b=abN/iRRG0zxSh+GiS2jxLGMJriO6idUgOFZJPJZWuxLRT8DtWsP2Qksi/pvxSUz26NhOmzhsEHqvZp627XDuM1nmWkXWOWytAkx31hag/B1rxocDOxKTrQMT7NjhH7Wm4IT05GHin7MRtBfk4FKS47eFo7lcPl5W38HDgA2z/OM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=drivenets.com;
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com (2603:10a6:10:11c::7)
 by DU2PR08MB7325.eurprd08.prod.outlook.com (2603:10a6:10:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 08:18:26 +0000
Received: from DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e]) by DB8PR08MB5388.eurprd08.prod.outlook.com
 ([fe80::29dd:6773:4977:dc4e%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 08:18:25 +0000
From: Gilad Naaman <gnaaman@drivenets.com>
To: david.laight@aculab.com
Cc: gnaaman@drivenets.com,
	linux-sctp@vger.kernel.org,
	lucien.xin@gmail.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org
Subject: RE: Solving address deletion bottleneck in SCTP
Date: Thu,  7 Nov 2024 08:18:13 +0000
Message-Id: <20241107081813.2095995-1-gnaaman@drivenets.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f94c0197f6c74d7db1f56b82c459c42a@AcuMS.aculab.com>
References: <f94c0197f6c74d7db1f56b82c459c42a@AcuMS.aculab.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::10) To DB8PR08MB5388.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::7)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR08MB5388:EE_|DU2PR08MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d3527b-ccc0-45d6-f99f-08dcff04c0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eK1VsptuWwJt9RZE6bUetMG3rhi/J9OktF3OS490wB4LI9VrTKQcCPH/X/9f?=
 =?us-ascii?Q?HxTe5pQgtGYQL4LmEQsTJf0TTMw/OcpjQtbIXhhHts5Qbv5tO9ANVKElqwIt?=
 =?us-ascii?Q?a0ISLw12R0VPCjf+W9mzvWZxDgJspr0JX7nDrEhr6U0sHhDANi3NHhsDiFeh?=
 =?us-ascii?Q?awaCX1woLBm72RXY39pC3wmKvh2rgcoykqsHD5HBex+3rKkoIeq9/SBdvGS7?=
 =?us-ascii?Q?m09eGRjK4vSm+YHPMkqH8Gj9IW+PX5HjGklcXU6EvKPc+TIeCEAchC6WoYKm?=
 =?us-ascii?Q?zBECawxnLh0uUfiU/9YgsJedjx2IykjYMmOA+nnEn35RJbnK5Vt7DnGS026S?=
 =?us-ascii?Q?jAFKsgjRqiDKZKtK4u9IEvwC0yeiQEMdvhvH8oEp/9KY7iESA3eHYjf44+Zp?=
 =?us-ascii?Q?NgW4UdXjwifdYHmEpVMarRcmL2WrT+CRXqQWk+sa5RnmrVYtRARPOoSMWQOD?=
 =?us-ascii?Q?at9BsaYwrciEsYbkJRFhdRvpCaaQAh8NV3PZIwfcvkPTd4Vt9uwMJQz9C0K2?=
 =?us-ascii?Q?yDdr9k1JxWc+CM89z9gTuvUPW0O6jW9qc6Fk/AFt121nD2xPXrpSnUAEVEOk?=
 =?us-ascii?Q?qnalSVpqGMVR5VWCy+6yWtWv0RlGxyi+NuX0W/V7qnGzNvC+2RYGOFbkSCGb?=
 =?us-ascii?Q?CvISyQ9oPe0H5Ek+4+9pa9SjBEkByhatty2Us9UoNI6berajFo7TG+H/PKOY?=
 =?us-ascii?Q?E2L8JPzB1UWraBy2Kh8KSbpa+DKfCZel/M8h3EUpzQD6InYECywQVava+Xy9?=
 =?us-ascii?Q?E0tRjySPDirYtsSFFa83XYTQABXmgHh7tj+/Y4tQStfZ4KHFeINfQQHeGC0q?=
 =?us-ascii?Q?/PYPQaYl61tbkROgIagRRTPOsyPigHRzI7YaZ0uO8ZP0ObB1hO/w33GA0h3w?=
 =?us-ascii?Q?Q2pS/dRk4krr/aN2HZ/MjiyP0QRVskxjcqyzlAiQwVRKXDzbPEuvMbcVTrYa?=
 =?us-ascii?Q?h2jn4PnXdqFJU7/swRHRHHTJKB+KvJKv3fi3S69mFlD2iCIgeywNPKHUuQSm?=
 =?us-ascii?Q?miQTz5Foz08Cqb7GDZ8rYUKghW8xZ4XmaGJ1dQF557f/dLcbCY2c1irimnX5?=
 =?us-ascii?Q?KDDheJQLbDIF54lETUIsLlev5p6OBhuYeYZoeQgPqNAQ98yU3q85BSbTfI6e?=
 =?us-ascii?Q?d5oPveMIjPZ9Lgg5BHioXiKoBPPH36Ony+eYpl3ZPg2ClmMPkb2nsF1HVSMg?=
 =?us-ascii?Q?/UqQaYq8Bv1DzATzPCH62kSY2Fj92znBnfYOJ2aAKzgi+4AkwOOk867oziCU?=
 =?us-ascii?Q?3HBtzIxQZIxOtp498r9VZ6LWfh+8Eq5rkv0kyP0216pSjs9P7os43HBPtQ71?=
 =?us-ascii?Q?OKBNn7kJMSruVrknK86czOaRjc+FMV3lYdm8vcscDLBjgl0IlFslPg2nZGGa?=
 =?us-ascii?Q?Qp5S8v0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5388.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rDZt5hVRqPJA8fZ/JRGGWT1LKJWnxY9T4obML+82viJDYgvmndoKLRcTFrNL?=
 =?us-ascii?Q?dcA9w5EX+JjcfsFHChkp+lNFsd3G3bl1Vs70zMMwsq62OYhc4YQ0ioVojud+?=
 =?us-ascii?Q?ITo6AwUBgtXqGYPK4FES8GywTQ+NVGco1cmChKI7lAtlgm/XlN7lJ3Y7Xnrv?=
 =?us-ascii?Q?32jI4Kx4U2wNy2veiKRr7/cjCE1TUGGzmevlFc2cnPBv3NGei5NjHaZSAefA?=
 =?us-ascii?Q?pFYmOfrrMwXAYXN2ioVpkZNFUvrmDfZGuyZTFHN/eHcg8A8zOrwtk5bPZkGD?=
 =?us-ascii?Q?Sp/HybLySTvlxlHnOBqkQGIuit9YqNj9Q9SfizfAxAg61s7M9CyStQQrxkvG?=
 =?us-ascii?Q?dyFOROisRKdV4UdrBbQ7Cbxvv4kqFH80YW/oOR5ebh9YCCNNpLF6DEEk51wd?=
 =?us-ascii?Q?zQvTMl2Ocz7fWQrfh5dEcxYT3DsP/1W5wc23JDs7mh9bnLKYfp3Zfi94zS+T?=
 =?us-ascii?Q?vEqQopNnOg7sMcO+2AUe8RriWadZyG9rZHB9x9mnfO/o33dSbl7Zlcv1pfvz?=
 =?us-ascii?Q?al/uqNvlQufa7xWrtP7UfOHpSBIb00MUa24zC1zH0VYpCz9kY494Pj95u+EB?=
 =?us-ascii?Q?w03aIRxBpujQ6bL4DmG93xUEIIXU1Q8LGQuocqHrI2mI9S5W8DRqtVPGZ2Jo?=
 =?us-ascii?Q?4Wmanfi1SF6eISV1mIeP5GRCRJg183FT8NSlav+s/NUBmoENEXTAdFX72H/Z?=
 =?us-ascii?Q?8ZkAbP3JT+pWEGXMligDahOKiS2LooUgkxLlByy2swrHkbGSndVwnTohnaDn?=
 =?us-ascii?Q?CA9R89vSdwdStzxgzEXfxGwbFHj+IvA/O98t9Ni8BL63Wxz3F7xgKuL3HAWx?=
 =?us-ascii?Q?tYQDo557rQGAgS7twvZjUIinizH4DoFGrjxyPFT6DxiX6IktjLeawd6GSZQL?=
 =?us-ascii?Q?KTpf/UNAtD6XAFqwedabRuDeQ7+tkNcnyyMNCASZuCvruwaCWO9gx5Jzcpp4?=
 =?us-ascii?Q?JVRZt0phwPaAK+MyahjS0XXv5ivrGisCV3rkOnGuXosFZhIrL02vnKLswKcY?=
 =?us-ascii?Q?6Ii1Q8Wm6tNpGqdjxseR2xpZM1/ZiRCRfasxAkT78F32NPThuPLgZn+0dUcO?=
 =?us-ascii?Q?wVKfUpW6bO46cvXDPv1NlYGX4msB0oyrHEvU6Yems+wOBLBhDN1ADVw2lQlu?=
 =?us-ascii?Q?CJoK/w1EZRzdqExXbIBaG7LvmHy7eT3zvXKlWUY9fZlBnBOrB1LYxCzAQRgZ?=
 =?us-ascii?Q?DesN5iaAJZ6cA2bHDmOttfUYggigS5LFl9/sgrCUjUvLzA/B4wbiwL4GOlbu?=
 =?us-ascii?Q?JNWelFD0J1s7IJMemDFZC/nZRiOE1IaiQAPHrdEn37++cmLRykscTwigN0Qv?=
 =?us-ascii?Q?5MyYFuiZBpf+pKO2Z0KP1ecpEqAUTEXXkmmiBLibeWRf7L5X1MCZaGJI5NXK?=
 =?us-ascii?Q?4sohK95VPMShxSMtNMKNQbHzwMPr3ESRgUy8jPsukQpzc+6LGZjvuj6A4HjK?=
 =?us-ascii?Q?Ir2jSGO9fSQVJLn4LjlLT96wUGeY/hz+QExVYlY2axkQGE7WSuIiPNCC+fTK?=
 =?us-ascii?Q?R7+DiWXOKqqw6J9cyDgRPiviJy8zNpCPYbOd8miQAVbgrwe/AlsjB7ROqywu?=
 =?us-ascii?Q?ORjPxkPMFvXHDRDerIFViyMvvZ/Ep9WIsULbfdmK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NuF5znc5h4Or/xMxuRtRUF0v/wQHebHNvZvDcp6qEE09C1P3F4TTdRmHPx7WUtd4v/d05Ywuww65fYs81D1xPIQs3ZAA2MkG0PUJTg/cegl6A2tkys7sNlJkHTcmEcTfS2043SaNecY5hP/tfkaGnfwoWF4yRXcg2nHnLk29JB6tvmNf8HB3nqZ2vO1AOm3Q8Zswdc89f3ZgEZmciVFYn8Xkwii+mt8O6EFfci8yFbsm1QWVpvzAcgWtNBFhDxsbOe7PGt4vPqWKxcckzqUoaqPd7EjMRt/7ghWk30As3hjTHwAHz0iz4hNyM5+IZPhrMBa/y2hG/4Fszl0kwG6LTO2FmnQgHB4Q6wdfRclxaZKaE9JPcwLxhBKWukqO1DL3vTIvS2uFGQM1y8uFPIO2ahvLAzBtakLHp1dAhcX8/hG12O0oFn59XsRST8T66lpNbTaQfrYPARDpZJGebmmWCq5LU+KFn6BXJ+NZPKb5MEEbllerMaJEN+iNn67KQNfDmrQBnVArLf1DLfitXiU0D2PXzmBSm2TnvGZQbp9jTIWzLLDewf1eS6XHn3Q8K1ixCpeG9DoJlITlmOW9EBfWjyd4kTJWCRtwna0BaV9aNV1fnu4JO7QKKVGfLYjMb/oO
X-OriginatorOrg: drivenets.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d3527b-ccc0-45d6-f99f-08dcff04c0a8
X-MS-Exchange-CrossTenant-AuthSource: DB8PR08MB5388.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 08:18:25.8947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 662f82da-cf45-4bdf-b295-33b083f5d229
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLXMS015mX2n1tjrix41lIQ7Fe5rGN57hvZ0Qy3otE+AVoUEm7h80DPualHg7pZnU+b+ZAQgBw6FqZ7UYUiu6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7325
X-MDID: 1730967509-YeybqkP6dBAQ
X-MDID-O:
 eu1;fra;1730967509;YeybqkP6dBAQ;<gnaaman@drivenets.com>;fd59ae2a66f8f1b7788a1d9c45168443
X-PPE-TRUSTED: V=1;DIR=OUT;

From: David Laight <David.Laight@ACULAB.COM>
> From: Gilad Naaman
> > Sent: 28 October 2024 12:49
> ...
> > the list `net->sctp.local_addr_list` gets obscenely long.
> > 
> > This list contains both IPv4 and IPv6 addresses, of all scopes, and it is
> > a single long list, instead of a hashtable.
> > 
> > In our case we had 12K interfaces, each with an IPv4 and 2 IPv6 addresses
> > (GUA+LLA), which made deletion of a single address pretty expensive, since
> > it requires a linear search through 36K addresses.
> ...
> 
> Is that the list that SCTP uses in order to pass all of its local addresses
> to the remote system during connection establishment?

Yes, it is exactly that list.

> In which case it really makes no sense to have the list at all if it contains
> more than a handful of addresses.
> 
> Indeed the whole notion of 'send ALL my addresses' is just plain broken.
> What happens in practise is that applications pretty much always have to
> bind to all (typically both) the relevant addresses to stop the system
> sending IP addresses that are unroutable from the remote system - and
> may even refer to an entirely different local network.
>
> Passing this buck to the application isn't really right either.
> It ought to be a property of the network topology.
> But that is hard to describe.
> The two systems 10.1.1.1 and 10.1.1.2 could both have private 192.168.1.x
> networks (without IP forwarding) and other 10.1.1.x hosts could be
> randomly connected to either network.
> 
> 	David

Yeah, I'm not entirely sure what should even happen in this case.

I feel like I could use a CONFIG_SCTP_INIT_ADDRESS and CONFIG_SCTP_AUTO_ASCONF,
where setting both to false removes this behaviour and list.
Not sure if it makes sense, though.

