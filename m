Return-Path: <linux-sctp+bounces-249-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7EC96F5B6
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 15:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B985B1C233D7
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532C71CEE9F;
	Fri,  6 Sep 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jnmkF4XL"
X-Original-To: linux-sctp@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F331CDFB9;
	Fri,  6 Sep 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630359; cv=fail; b=U5Tms47c+jUBlk/pirrCueezO+BKyDOhkCy0mVqmsYoUJ5KWrOx5e0FXtKFhxnUmsBOa9ijNO4qeV5Q/KZ4KcW/YfyGPV3vjKUfClJXXuFZoAjbV9BKg3SAIXwy9pEv1nSb6p8MY0fnFX7+hdkM11TRMklG0weXb9gMwRImIfK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630359; c=relaxed/simple;
	bh=WDm0nCcKdH1H1OmMwRdRmT6kZymWVYNNw0jaJllOklM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=speeeTEvg4IraUF4iFUGBnSvPMPJpHWr7nDMvbdf11HaY1m2mIE7N/3lKyVNy1h0KvsLjoK5TSsZPAgGmqf2XxUQmPskCUM6ezmJmO/WKwsX7vilRRYSLOVAz13g468qXTeQi96s6T33Vatf4qKANqZMiqRNRgEkAbSlyqgXjGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jnmkF4XL; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb+ljqvpGVnUjfWk9TCwuzULw9l1i+4sSkC/eDVt8GfdW92wj7ampsZVXO7Dew2rRU8V2kE5NFed/LvH2UmIj8zuEjVAJ9xG6Ryy/x8JXLA+wYLccuwh2EElHbNvlNYcamchG7UuL1m2xRgrOWN66u5rGLbRSju8Z65SzSqECnjHZR7jpKvKQlUzZB9fLLFOPiP0xusXE9/XxyNW0LKNO0KCt15LRhWuApEj6mWry7IjJaCzc/RnQogVjy5qy9j33vi9CD2jE3ZMO1OCI58NNwdMI6we8mxEP7VF4kRqb6HtH69JkztzgueZYI0M7OmeXdtb/yoeen3Iva3N/YB7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPyt3VkC9HDXfkm5Y7825vDSDfIOEkyvc14V99gPq4M=;
 b=uRaARNnV5PBMJvSwhpYiTeMAew+YOYC4hFJ9Z0FiOKweLKan/8kbf55sPqGFcJk4dVcEnt3H8maQtP9OEkzH3sFT8dFWFGga7I0dJI0RXkN9cW/pcwyODRoRrWrnlwIIZJcgBnZ9GK/DsES12MIpVGailhQR1YNi/a4lISoBBcMO/aKmowVLCyK3leB+Nmlgf/y19XHG+/06rQhOgGtis/DTxBn4pye0yL44bkjVLPT2VnRxO9bEh+Z4N64GBoQhpF15VREP14Z+KQkhCWucpDthgFPx/hZeyi50njwjyLwc1qaUtwpwzsLmNZBZJ39aVrZf+r924hpivvexosGN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPyt3VkC9HDXfkm5Y7825vDSDfIOEkyvc14V99gPq4M=;
 b=jnmkF4XLrLoptUHWzP8VksM8oeKCtZMBewpNKFxHSv/dZK5bnKy1w4g2I12eCYYjzc7/McCS5Z1h3Yqs9YVc8hEwxe11VgESK/VYKN7YvSruiBo/n7b6lWrCFQARh9B9/axeCKvR6RiIjOyE6bJowrV+5vDLW38OvEWADkJlvvr+rIvR8jMtM7t2AOIWCl7JJ+9dKu/FgEvErQl1W7o7kVaj6A0qwwm69Jsq1/R5D1uoI08laYuTfsiV6YyQyT8rwlUDJgmMCV9h8N7ubbT9vhNKD9BZOhKtg4yW9Udm5hhbdklAfJ4ISLpxEB/5exMBz0evJUVLnAQ/mQixDFYQ5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
 by SA0PR12MB4366.namprd12.prod.outlook.com (2603:10b6:806:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 13:45:52 +0000
Received: from SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95]) by SN6PR12MB2719.namprd12.prod.outlook.com
 ([fe80::1ab4:107a:ae30:2f95%7]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 13:45:45 +0000
Date: Fri, 6 Sep 2024 16:45:35 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Guillaume Nault <gnault@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_bind_dev()
Message-ID: <ZtsHf-TrqA0EWfoj@shredder.lan>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
 <ZtrpQzQYR1yylvi0@debian>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtrpQzQYR1yylvi0@debian>
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:EE_|SA0PR12MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 11719de5-c8b4-4cef-0560-08dcce7a354c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3JpuDRW4ku9+Vh1Isqe+a4kAh/IELvKtNfXlLBMv9UzYwggaEx2dKXSlZq1Q?=
 =?us-ascii?Q?bNbRe6EL85q3DR0w2/FjPNQuPJFDOOtDplACMj0N7HU9cmFYxooaJFEdVhPo?=
 =?us-ascii?Q?yzlS5V5ei8e9RMm2R0+7YE1keKTlb0CBre3Vcoc9a/wKaNLLKmAOoVqNN/nn?=
 =?us-ascii?Q?VYdn1BZZWi7j4NPipUfchtzFKEflnAN9J0obfJEjYOvRweM9nfQJ4cQIJfpp?=
 =?us-ascii?Q?F3X1iYH7OS09jeqY24T+XS1EetPRhe4tLSr8P2V2fYWHK8mo0HCeB74zOCB5?=
 =?us-ascii?Q?5ncqrE/xlfNOL/0bZyuvXUPDH0F7NyCO7t4Q9xD9hz+y1OPMQTpq6EhyTz1X?=
 =?us-ascii?Q?hvoI9/oCLPCjnPPq3gPA8UGL0sOXmoFZOmFRcF8/3D7ggfFVUBNToO8LKAW7?=
 =?us-ascii?Q?B0Rml8WffrTwayCcng6T+a/q0y5pUytk4KxoxZc0da6uYTje5KGjWpl90WT9?=
 =?us-ascii?Q?EeyDBnCXvGHCEa+q3kiNpPRwn5vZWza6NHa9jhBTy9YYJWHA7dKkSqZaTqv1?=
 =?us-ascii?Q?QXJkpJ9GwN0kUYMX0bK0k9xYjzl5JABgxxMMOuBeSSV4MzuvafySQI9k/fLW?=
 =?us-ascii?Q?IwkAh3PAEG44uYUBnUj8tQCpRoWfMrtyeDzGVAzosh9MNgtF1BCk+RhhYoEI?=
 =?us-ascii?Q?vfwVAPvaaJ3bB8zwo90YrK6yJurx7cU2VFZMfyavm4dk7FICinkINBx1ectv?=
 =?us-ascii?Q?LCozGvnD8bG0G8MdBPUetpkVlAIZiRoJEH3NxooLe36jEi8UUDw9gs+zYiAA?=
 =?us-ascii?Q?HNReSIQ7itylgDWgZTRRdKqf5Lr0Nb+Vg9VmfAPXf9e+fEFZUi2JhCOSG+l4?=
 =?us-ascii?Q?sfsYh1sOgm5YQuRNS+T/1Wxoo4K3KkA60XykcoK7fvCpp+oEQw+5+yIWpqE/?=
 =?us-ascii?Q?D5UrkFAg86jEfS+vhpGXjZP/YbHTw/Yj+ZWZs/JMuYAyexF2dIrYXrCE8wuU?=
 =?us-ascii?Q?7++cXBQCmGMYGU02JosQJL7tgVANBTCT9tyO7LiV718VorMEK5aXtdagSOjL?=
 =?us-ascii?Q?q4mn78keIka/wCKFsfoXHXWsjhxtmHXzRNGExufGR56L0mZdnPWTjJqzG871?=
 =?us-ascii?Q?5E2O3bJTqEkMDne4eA0+3RnAlC+rRfPfaF6Fcte49OIMPpDRyjY2JhSkAY1N?=
 =?us-ascii?Q?Tzn5ZJAx+4BfsOU2seiKDLp5GyRdGqPTp124G+AYVxCRG2esEAgqhWuDlmcj?=
 =?us-ascii?Q?kPuje3KXs2UM+CVG6nDwwmc+r/kP9CaueIZdl1PJsVc2ilgsR1Rj6L4OM//I?=
 =?us-ascii?Q?uKGd4NUqkaw05PXWM3rGHWk2X7NfN6yFbZauFrsem9291o8xT3vwo13DK8yQ?=
 =?us-ascii?Q?/mNYTD+Nxdr097La/M1b6fFwZ8LYa+pEsp9DF1CyMnEwuw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xOYwqcpBHGpYqfn2MPBNpmsg1ndt3x94L2QVvCgRbrpJFtMGM9InRtpnbMdS?=
 =?us-ascii?Q?YO4Y7rml6IQ6JIVSaZ57r+zcuTKd/qEObyU2pN5ERSAMH6d6+acHmADXbQed?=
 =?us-ascii?Q?Is/l2b7f0ezjWPnpiLbBjVR6KT8m1GLvXiDedvthleLpXFzyDSK3VFE/RJJ+?=
 =?us-ascii?Q?oVnB1E1ClmJ3ZNzTDQeJxCVE860G83otvTDoX8Y59V5v0p2JExmzdM4IX3Nn?=
 =?us-ascii?Q?1OH5M6VRjHuSYzaqTDoPxs1etQoSZjnM46AYAKtcVOcwUKJ4ARtKSsyXEpaa?=
 =?us-ascii?Q?sVjmTT+RgtXZCeBqsSFObKL6nwhWfbshLZdaxLsDBtWtG6e/S+kiKmx2xH3L?=
 =?us-ascii?Q?N4pRmqvzPf9ozamFG5r2b2Hb+TTqdUNaxe1ALxfc/kAc/dmYqYLiW9Sgj78i?=
 =?us-ascii?Q?oP80FSZt7a7/DR0Ap9KU2j8r9RtqRWXs9+9MTW2QBNJxHNosLq6Kpm3WZe8s?=
 =?us-ascii?Q?ntHLXwRbRNguq/UOBSjgw/fRnGl2kUcbJpomtAn2VJL+089eendi9gILUZ0e?=
 =?us-ascii?Q?n2nTRY7yrIDi8FmhgnxBBWh87uhRlUlpxziKdr2Ab/49N5k1pHn+5wh/dafP?=
 =?us-ascii?Q?wnpaFygGrdceSO5YAd4YWK3/G1Ja0y2ovvgQA7FzuLcU0BMxQDMu+kU5PXel?=
 =?us-ascii?Q?gi7QJp/MgJtQM+CZRga9L78q9OJKcNPGwvRqEQwAmZW/FM18D1YID2CjvIPL?=
 =?us-ascii?Q?5FsIjcWlM+j4zv7Qmc9TDMU6J2eeGbuKX1i6TUKOE3pgzOZ8bgJxRQwKIQX+?=
 =?us-ascii?Q?BfrCAE3+F1llANUP1O9UgSmTf5+D9XSh4iRYzQnL1eZOlvYi/4oHZlEyyQ2g?=
 =?us-ascii?Q?CnXUXCOPZBrhEgVutnNqZ2oIgvo4ZE8yQALRCaUAcrV12V1j23SV10aA5NR6?=
 =?us-ascii?Q?OnGaRAIERG6q8XGPQ7oPLR8XSAVYUyp9DDSqwYyhQRlUDkZmOpElurzSRpe5?=
 =?us-ascii?Q?L/b8UMX6Mqz1oKulvIbQ9dah4D8bz3f0nP/04efO1/oWM2/GOdfP8N7TlwWd?=
 =?us-ascii?Q?nMfYJeYGzDDSiBe/cH02eRKlrrsJB7QP8DU9OKHzUTJyFlGs0sJxpCtlHO0e?=
 =?us-ascii?Q?2z6K5BeVI+e/UVTpBE9APfCBPSpxFfYA3Qidc0SSB3A1p4CGsxuskKPDSDZE?=
 =?us-ascii?Q?+rn1mkYYCjKmpelaeDer29HCOQiLLM/KDE8EaYmozeCTjVqahVeb20HT4o/z?=
 =?us-ascii?Q?2v4zgfYqvKFzDRcllx5Z6zcBjeuPjtZhbu8/q5IZCRKpBO48U48ggSq/r4YP?=
 =?us-ascii?Q?hkHYNKWq3H0UUfxE5hXqcPAVBkkMtjQcsjRcQ3ucgsSWDJAQ/u5L9qmq0ooa?=
 =?us-ascii?Q?UCi1tgIT8kmOEDaKcaaVUOGCx0VGAkUjDJJzxVXkkABI8NtRr5v8efOHTU6R?=
 =?us-ascii?Q?Xah6AiI+nc7ZYeoZWcFbQIr4nEMQwJouSTEEwLnm/k3PyHW0NLLbEFH9OZWe?=
 =?us-ascii?Q?Y5+jALW0Skc+vWdV18WuaN0833Ow2fgUQwUnaGcRcvTHFJkmbiDaRJtCLrDf?=
 =?us-ascii?Q?lmMzf1Z1EVFm+YGJgDB9378q6lqHFSO8CfAgWtkotoyiNi+Z6n8P9sk0sFQ/?=
 =?us-ascii?Q?NoBPLhM2JVDN4+TYRi3oZgUR291pIWGF3XqmL81E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11719de5-c8b4-4cef-0560-08dcce7a354c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 13:45:45.6498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p3lQ7Q/0sIPkYq6eGkAv+SKbr//C3fjsXVDrqiniB0A/JQeUcShXIDrGiCZLj1CGNAwZBpzcKHmvFfOkKW3Iow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4366

On Fri, Sep 06, 2024 at 01:36:35PM +0200, Guillaume Nault wrote:
> On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> > Unmask the upper DSCP bits when initializing an IPv4 flow key via
> > ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> > in the future we could perform the FIB lookup according to the full DSCP
> > value.
> > 
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  net/ipv4/ip_tunnel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > index 18964394d6bd..b632c128ecb7 100644
> > --- a/net/ipv4/ip_tunnel.c
> > +++ b/net/ipv4/ip_tunnel.c
> > @@ -293,7 +293,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
> >  
> >  		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
> >  				    iph->saddr, tunnel->parms.o_key,
> > -				    RT_TOS(iph->tos), dev_net(dev),
> > +				    iph->tos & INET_DSCP_MASK, dev_net(dev),
> 
> The net/inet_dscp.h header file is only included in patch 6, while it's
> needed here in patch 5.

Thanks. Probably happened when I reordered the patches. However, it
doesn't affect bisectability since the header is included via include/net/ip.h

> 
> >  				    tunnel->parms.link, tunnel->fwmark, 0, 0);
> >  		rt = ip_route_output_key(tunnel->net, &fl4);
> >  
> > -- 
> > 2.46.0
> > 
> 

