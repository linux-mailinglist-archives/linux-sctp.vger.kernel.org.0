Return-Path: <linux-sctp+bounces-115-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB64A8B37C9
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 15:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1B742822D6
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Apr 2024 13:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028171487E3;
	Fri, 26 Apr 2024 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FNcf8GXr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xtXxrnuM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310561487DA;
	Fri, 26 Apr 2024 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136491; cv=fail; b=t3V6ha6UzwX/xWxPvWsyDCOSkvTWp2RjtYDFNdBtAVxA9sJjbRLxD9cq5D0aY0I3h0rybwTdts3PR/MQRWvl8/Jx10+o5eJ4paFukgFSWFkSqcFYlgM6m6lPAfIQZtxG2eTil1+SJpuKlTUsfY10JoU0tfDQhxnFsu+E0CkQGgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136491; c=relaxed/simple;
	bh=w3zC2Rqf2t6ur9TkLgib0djPV1ZnEMmbp3SJV2IoX/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QcCeUj5/7PPpNg1TZIgo7yybxVALG0wpMdVVRCj4TV7NYQYanFQBUD4/HV7oF6DFumI+pyW4oOnjCidrLsHsr37SANH010Ag1shW2/cxcHZnyiUJMz2pvkJhu7aDhejY1IvW56Jg27uqQdgYmSw/tXXXO7NSNMrX4SU5OdhC8bE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FNcf8GXr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xtXxrnuM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8TdCb005272;
	Fri, 26 Apr 2024 12:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=C3D/MoeDppVieN3aOW9k5a2806MAAe2dbAeFC4fMkMw=;
 b=FNcf8GXrE97+lwvp2xfWVVISWg+/aDYcR3Jg1S5etmejOXuiVWTMg5bwddDzj4Bw6uQO
 cU/SuE6WLKdYgMXTKIw95H+/MsXrKqd5BkPWa3xzlKYAsWdt0nNd3Rm3UiZdRAEJTzz9
 Si1kq74eXJXl8d9TQh36o9ccFN0GAeaEyf23LsWc792qY792ge99kD2LiT8MiEkrev1q
 0oNpgEYssgh1fAk1Z5obvopylp3yD1LtZX0NCO76xdqplrsAyyjRwnau35fY3xJ1ia+u
 WaorLOvLmirf6KCf3ZftUzWqZOMIq65T8rWOS/KuOnZhvxwA55mR6bNZ/9yDj9XnjcwD nQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vnxuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 12:59:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43QCMsQt019700;
	Fri, 26 Apr 2024 12:59:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xpbf7ncpj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 12:59:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyspkcOOAIImHr4nFkEYyNrEAAqMNpntSjx57gA0ewsjHiusO5suIl+rELMeYjaCi40/yCtlU7hZ2yrwjHPvpxHlJJJf4I4wdAf+2OL/gkyeCnlQrxYtbS7h23wFsR+bEPzTwWpjpzKVelpDp8w328tZKxy723ajOrkGu+l+rEZJD5k3O8YmLcwO8eHrbvilfBORMVuypwISCUPHFhOVDDGuAR1AGrTOvLPBJ14W++uidZFV/dwbm5bn3xBtkIhd59OZ1sFv6QOwJNsNmj2bgR3GGcIEzsAG1KNnCxFzOkbR7HaqSXCtASU39jlEWD+gIZIy2sugz6o1gDNI4IycXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3D/MoeDppVieN3aOW9k5a2806MAAe2dbAeFC4fMkMw=;
 b=FlQ+oWU4hIB0/i69ywZWdlUT2LkQMTGfL1yQ1CK1WeDARbraumEQsdLQhnSzh+JOOfcf+be6wrqbdrtyWY/EHZUOiIXNUX3u1p5oZ6/csZLl52ze5B7Mcr+8hD1vmUBkzmte8T5asli6n/IjvbcO4xLi4gwjOL/REpLI2dpjBNkNWa4iVlGlduSoBdfA0D7Xf+6bE6YOj9oroFPocxZLetC8q6xFkOaeJ0XrvRb/1e+/LPMpbrnRZ1HiqMXoHuQYOZgqg6TsEfrMXMkFGuPSzC/nzlhaFJcm8FF9vuBK6LDK+QIvvfGwRgUlFTxBh7c6arW/1niDmnpKRD4/ugqqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3D/MoeDppVieN3aOW9k5a2806MAAe2dbAeFC4fMkMw=;
 b=xtXxrnuM+gDAKluD8z9NvP55XeY6IjxOeCKf9QL+FFXEe+aU4Djz64AYzO+2CwLE2vcBOnmAk4Ad/kc3dGxG7qObQL9GOMVQFUMXdP7qU7DLQijyLMj6bBbvAYbE/aRdS3C/iHdm4/9ejF1p4g5kdsg+uUqJHFV3/prkO5e+PSU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB4953.namprd10.prod.outlook.com (2603:10b6:610:de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Fri, 26 Apr
 2024 12:58:59 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 12:58:59 +0000
Date: Fri, 26 Apr 2024 08:58:53 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: j.granados@samsung.com
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        David Ahern <dsahern@kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthieu Baerts <matttbe@kernel.org>,
        Mat Martineau <martineau@kernel.org>,
        Geliang Tang <geliang@kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
        Remi Denis-Courmont <courmisch@gmail.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>,
        Martin Schiller <ms@dev.tdt.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
        Joerg Reuter <jreuter@yaina.de>, Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dccp@vger.kernel.org,
        linux-wpan@vger.kernel.org, mptcp@lists.linux.dev,
        linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-afs@lists.infradead.org,
        linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-x25@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, bridge@lists.linux.dev,
        lvs-devel@vger.kernel.org
Subject: Re: [PATCH v5 4/8] net: sunrpc: Remove the now superfluous sentinel
 elements from ctl_table array
Message-ID: <ZiulDWkL/9UJl+8K@tissot.1015granger.net>
References: <20240426-jag-sysctl_remset_net-v5-0-e3b12f6111a6@samsung.com>
 <20240426-jag-sysctl_remset_net-v5-4-e3b12f6111a6@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426-jag-sysctl_remset_net-v5-4-e3b12f6111a6@samsung.com>
X-ClientProxiedBy: CH2PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:610:20::41) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH0PR10MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9122e5-c8d2-4457-041b-08dc65f0a364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HwjN2VjbkZCwdmZTuF+RNcec8cJFs9r/vG8McfsInMdn2dBr5xv/ijYvzzId?=
 =?us-ascii?Q?UoGlPxx5ofLO+0tsuUeALwxWX0Jlm6ckpXAW56hq4ckCqmMsq1/FvJ/dTGG5?=
 =?us-ascii?Q?Qx43bKfadzJ7CONg6v4KzR4oHflWGfBRmHw2JQR151Tn2GvqNg5DXlj27s2S?=
 =?us-ascii?Q?xgCzwPMkWjI71O5wQb4i9/+8m3MpR4Z2QQuNWbAy6u2DugWMB1j/HVc5TMsT?=
 =?us-ascii?Q?AJV4jHcSF8jlPcfuGA85Rc9VqQV3Kzs3SVqjC+4aqRAgHQvchI4iKi7ocHCc?=
 =?us-ascii?Q?lESOfzQNFOYuUMMTHqLKBli1BuwY10z17Kh/bsEHNFhD3YDC+4Av2QhostyG?=
 =?us-ascii?Q?PUiy2AqoRJcZI9iuwD59aDZGbWV4iANb7Tt2XztEO/Hf9aJkU+eR5SFGz9o0?=
 =?us-ascii?Q?VDhWnHbY2DX8+iJG/MObgWqLiBRLd+S4+NAd27hgTf32Uve5W1Yv9IFMxhqY?=
 =?us-ascii?Q?ENppvwV3KWBHF0Q6unU2771pRhIrKTycH5zraB2uwt9V1A0pPItsMAQ18WL3?=
 =?us-ascii?Q?wIZMsqlYKfo7GlWJu/Z5sZbEygAjv/F6bybgDpb1vuF/UC2xGX9qx7L95R+u?=
 =?us-ascii?Q?2L1Ok/yC+WnrIzXlRroAkinBR91VY/42rmArfHcwCwacf3dgBQlaSubruWqe?=
 =?us-ascii?Q?UQr1WCXGYzI3oLizmO1iSKDZhooCqWNB5HYbBwkVeziwyAIlk3AvObFcD74E?=
 =?us-ascii?Q?/UzjxgbfHYj5XL5ZS9+bm76qgfBmW3LmPqG26JE+xPqNg70KDSDBoxCol83s?=
 =?us-ascii?Q?hgNTNOyjzbYRgiQkF9XfKE1FOKVpPVii5AFshW3c5/GndGCjMJ4yPXBFVzYY?=
 =?us-ascii?Q?dBN3ZGyWjN6x8IZGOY25cZ9usx0XTsrMbX9u9YjGkodrSL9O18+NYMJk/dOn?=
 =?us-ascii?Q?FeoSZAG64pNfY9hoMlExfhAXlGNAjl0beiXNn56QJ/j6IWhZ2lWYTvPdf22f?=
 =?us-ascii?Q?CAC59sB6/9opqBVFpdQcR6DqLNt3cij2+80fvetePBAJvQ8uUW6/SqSZg5uB?=
 =?us-ascii?Q?AJ12iTBzlcf1AqCYv5m4K0X7qwIQy8tVi8T15r+kswzpsnpGIaFTamvhFhDt?=
 =?us-ascii?Q?ytUCy+GIm8umBCkKWPB0vz9K1eGNqRz3x2ZTR/8OTp6VyvoDozKYuZbSyBQn?=
 =?us-ascii?Q?Qken1rPms/H2oSQQBONDrhU4ciASH55DZz353KvhXrVtiMBqVWkJymCA63sA?=
 =?us-ascii?Q?YGSLz6qZdjIeESLlTEGTqme6vohXKuoIAZmStStHvelwUodC6AUDLr5S/wc?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zoJ1SGfaiKySG9ku7QBm69Kc5WlSVMUgmgeiBMEhImHDku/AYco+EU6cOjxl?=
 =?us-ascii?Q?bq7W7YF6MtDXjz2Wt/T7QRMa7RBVPA8IOpw+01Vse+xHYNIUfwS7xKq5gAC0?=
 =?us-ascii?Q?RzG+9haN2MXBGvB7SkXCyrEgfmkKmu+8yVzmzg7OpKW+cB4M9tudUzPh3Vci?=
 =?us-ascii?Q?k2rbdN+4EsAa9YydBC9BGSgo6FQLR+XBW1FT7zAWDuXcGt7HHtv4cLIQrSVq?=
 =?us-ascii?Q?rdqkjbfXuBAuE+6sRw1jLWPOxENSThwn8jrNyYKL0jZDlaTWv3DBK9GPrUqx?=
 =?us-ascii?Q?meGchp5UmiL90VVPzS6eu7gesGoLyiYWnS8jpd0UOJlb52O7FlPj/W442m1u?=
 =?us-ascii?Q?hDPZjuJsWLppDsCCde+8eu0ukZojZrSrFJnpvUsxG1bL2v2zrF60Ok1YaCGn?=
 =?us-ascii?Q?CdnSYn37io3hKlz0oriFNQCxNFuGnp313Xixl2BPIj51KAU55Zqy2LTQi6da?=
 =?us-ascii?Q?o6l45xbLrnaq7g7gC+53qCtygH2+tWWy7zZhCnHb/Em2wgT7BoIwXzpY7+RV?=
 =?us-ascii?Q?veYXrWQSAnGY1hkMOoZlvpMbeCJRaP9lW41xEHPCJE2GRsgqKwYUWx5ZdbBY?=
 =?us-ascii?Q?4cFJmsLyoxYxgzLRkLeraBTMQwdIIYGht4Euqf59cBRbj7uAiPGazLy+exoO?=
 =?us-ascii?Q?p1ZsmPRYXDXe1OgDc5neQV5tDxUw2BZUf1uSC+l6bMdcPE41rUjF6eci04d2?=
 =?us-ascii?Q?80p+Tu83J9mydadYapHuugAxmv6NW0MT8HdevHMNvWaanYRn136mIOdf+7Kt?=
 =?us-ascii?Q?dZNYEpeAnjtKzC2w0shvb0lxIEofPcJ1CqqOMwbWWV/Vh05HAyvZXjZHGw1g?=
 =?us-ascii?Q?NzDS838U2Flrq8cfVlKH4ml5oO0MIUb1MGjEE/0V07RRtibB8WIauNXAgD1c?=
 =?us-ascii?Q?/a8Mk0LcdOlE4T0038HQijYYf3IIfx4YrFmbiu/cNd8fXbRBUG4EvoqHr8ls?=
 =?us-ascii?Q?aWwS22Cubp8KxKol5q7gcyHszIbXzFeDmjtNNtdFgQudR8CBkVhKtzqTgAHq?=
 =?us-ascii?Q?cYHzdwhr9sqqBw8LWzGgmFMToMlu5l2L7z20ycQh5rFqsVg+mL98lEc1V2yi?=
 =?us-ascii?Q?55Ut5H67SZNgS++S8ezvgPPGzWmRC71oANtQKk0NOLBP+LUcsCv5dkfxyurn?=
 =?us-ascii?Q?aFG1TSPGOkNcErIj0NC+kH0BbyyYVn0KDBzqWiCALjC18aLSDaR7+IWf4ILv?=
 =?us-ascii?Q?ewjlLyObmsPkKFHSIaWZ7Sy5L0GT4cDLjRCkVtlYsbMFftyboOEryUghiJ7p?=
 =?us-ascii?Q?Z3haL6MlylkteAHxfcEHbWQ68eFu/Xk18DDqwWi+Japvzhd9arEj8bmNgvSr?=
 =?us-ascii?Q?r8eLcyvSaVBjohlViJEWIys7AQK/5+f8NIFAomPrGgmDKOsrNFG1vV+wYSYY?=
 =?us-ascii?Q?2qOuxnnpta0eIMAGVzvg7qnsnARFD9vj3NyOL+328HFFhNn7VtPhRGL1Ow2a?=
 =?us-ascii?Q?h8mSyBhsMwFKbpf6ufjn4Z6IydWJAKLXy28PkGAcRW+VTbg/jxYiS1685zZz?=
 =?us-ascii?Q?oF0WcrWRRBt/IpWVZy72mTsWtWRTd7vMcTGUv02L750u6Lv/kX9IwEwq9++b?=
 =?us-ascii?Q?c1YLpXGbUL4pIDZ9c9bPH5QlpgkSf3XD4ZZrAQVaTfM1lu2es39JNISwfZ0P?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JXj8JqHN8RpLs5ZhuVvVutVL3qZvKjz+7MQcehGsoFG3N0U9ol3KimfSnr+E2WAPNfwe8+RBJCWzHZFmsYwdFn1FcsWSnR0g6gqkOygggKkSDRvg1qM7Pjrm+rbyA1RFcXU8HMVAgB9Pjb8oYUH5q/s0EVtdDhzaqyuhgzkwOmnMt2GKwkHJ4Zm+T5tDcp55NSoXGORBmkLf7La2JYF3hVEghsFTd46e7QHbFPFzjenWsp3BOvPMR3bGUjuWoAf1FEVatZC2+LIOfudp745Nd4yoDNetCL/rdNVZcWrvolW+edxzVU8jFk3IIuJ0By4lQ1IOLqJ/CDTZbG1f3AELbQ3xQy5d5IU8Pg4TiuOqK0Wy2tBWsApb0wVr+Yesukh4MTcCCXCDu+WFZBEabYcDavi97/9qdUHMZYWQbtDoqbtOwj7dyvT7z7WCFu8/AfyuSp5rFA3fSoVW63Mr+0Ewr0iggu7pmnBKCor+RWCUhM4RKF+orT/TpkvWkQmRwo/Q0wRE68IkcofWpvBJfbLMchWJHP8lIAfcwnZlrXMuwCsyskMIPYG/K/WQT+Pe7b4ubLsx/Dt0SIAzK1vYD7lhBaLkBFkQerltyDIRwiXCOrc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9122e5-c8d2-4457-041b-08dc65f0a364
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 12:58:58.8917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIZMAJ3mBmIqCo0/sEPZKBmw9kVufrlLoxFRgfOuYF8caBTEC6sUCdjXCCDNmwdstU0vL5SCAxpicJxkk7WNwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404260086
X-Proofpoint-GUID: dP7RSDXkZ3DMn6wkxOpoTwe6fxfLIUgJ
X-Proofpoint-ORIG-GUID: dP7RSDXkZ3DMn6wkxOpoTwe6fxfLIUgJ

On Fri, Apr 26, 2024 at 12:46:56PM +0200, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> * Remove sentinel element from ctl_table structs.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  net/sunrpc/sysctl.c             | 1 -
>  net/sunrpc/xprtrdma/svc_rdma.c  | 1 -
>  net/sunrpc/xprtrdma/transport.c | 1 -
>  net/sunrpc/xprtsock.c           | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/net/sunrpc/sysctl.c b/net/sunrpc/sysctl.c
> index 93941ab12549..5f3170a1c9bb 100644
> --- a/net/sunrpc/sysctl.c
> +++ b/net/sunrpc/sysctl.c
> @@ -160,7 +160,6 @@ static struct ctl_table debug_table[] = {
>  		.mode		= 0444,
>  		.proc_handler	= proc_do_xprt,
>  	},
> -	{ }
>  };
>  
>  void
> diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
> index f86970733eb0..474f7a98fe9e 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma.c
> @@ -209,7 +209,6 @@ static struct ctl_table svcrdma_parm_table[] = {
>  		.extra1		= &zero,
>  		.extra2		= &zero,
>  	},
> -	{ },
>  };
>  
>  static void svc_rdma_proc_cleanup(void)
> diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
> index 29b0562d62e7..9a8ce5df83ca 100644
> --- a/net/sunrpc/xprtrdma/transport.c
> +++ b/net/sunrpc/xprtrdma/transport.c
> @@ -137,7 +137,6 @@ static struct ctl_table xr_tunables_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{ },
>  };
>  
>  #endif
> diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> index bb9b747d58a1..f62f7b65455b 100644
> --- a/net/sunrpc/xprtsock.c
> +++ b/net/sunrpc/xprtsock.c
> @@ -160,7 +160,6 @@ static struct ctl_table xs_tunables_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> -	{ },
>  };
>  
>  /*
> 
> -- 
> 2.43.0
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

