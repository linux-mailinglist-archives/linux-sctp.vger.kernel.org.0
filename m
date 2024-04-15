Return-Path: <linux-sctp+bounces-69-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F28A5E06
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 01:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054AE2829A8
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Apr 2024 23:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E4158D93;
	Mon, 15 Apr 2024 23:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cDAKbzNS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47451158875;
	Mon, 15 Apr 2024 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713222760; cv=none; b=Ne2071dGbh2OR1LujGwuVaYcCBNj/K0VVrtSLsQyS+DnUQeAu/CmjP4ObHr2UG1iHShazgnM9fF+Rqq5ZKOEDp2AGumlnaaBD0sg9XSnW3upSEQJJ07lyuuD0fDSYFPTdVsWCzCbXtEQs4woFTrE43Lo5o5C9Gzq490fP/04h68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713222760; c=relaxed/simple;
	bh=DzNIwgqXI/I7Ub7SnKCZmI1qTKtKKel4TiLcJBRmrU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lozS5bhq5ogdKkC96i0c9dSuR1xz/YOTlFkevZxb0Rphtmnj0UvsRBV0Dwba9qMG9wUEUujLnxh8+gGyspkOzBSC+g8ynKeqxnsf6S7hnL2fpTqt2iEes/PaHbDNA9aph+2dKtsrT2eoL6jj/jhOgRk4zUf/HVDFbBvj45QxEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cDAKbzNS; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713222759; x=1744758759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RWrGMm52sQk3MHGfuY7+MGkIZRUJe5X2k2ZXeV5yfyI=;
  b=cDAKbzNSW8F+/YZ19UtmrkbJi6CrsbhfDAk45cnIOIKS6Uu3107UrkWC
   9F+KUlsWZ8M94dc/T3wrfXguqLLDFupEOaOkvyXwK5OfSvZiQNmWpzYHc
   I12sbqnig8cQC94FwkuQqseObE7JFn5ZkxCNDHtDrcH9xeVM239Xv6WW1
   8=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="652011921"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:12:31 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:59907]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.38:2525] with esmtp (Farcaster)
 id 0d7ad973-51c9-4931-a2e6-6cb3e66c1692; Mon, 15 Apr 2024 23:12:30 +0000 (UTC)
X-Farcaster-Flow-ID: 0d7ad973-51c9-4931-a2e6-6cb3e66c1692
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 23:12:29 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 23:12:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <devnull+j.granados.samsung.com@kernel.org>
CC: <Dai.Ngo@oracle.com>, <alex.aring@gmail.com>, <alibuda@linux.alibaba.com>,
	<allison.henderson@oracle.com>, <anna@kernel.org>, <bridge@lists.linux.dev>,
	<chuck.lever@oracle.com>, <coreteam@netfilter.org>, <courmisch@gmail.com>,
	<davem@davemloft.net>, <dccp@vger.kernel.org>, <dhowells@redhat.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <fw@strlen.de>,
	<geliang@kernel.org>, <guwen@linux.alibaba.com>,
	<herbert@gondor.apana.org.au>, <horms@verge.net.au>,
	<j.granados@samsung.com>, <ja@ssi.bg>, <jaka@linux.ibm.com>,
	<jlayton@kernel.org>, <jmaloy@redhat.com>, <jreuter@yaina.de>,
	<kadlec@netfilter.org>, <keescook@chromium.org>, <kolga@netapp.com>,
	<kuba@kernel.org>, <linux-afs@lists.infradead.org>,
	<linux-hams@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-nfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-sctp@vger.kernel.org>,
	<linux-wpan@vger.kernel.org>, <linux-x25@vger.kernel.org>,
	<lucien.xin@gmail.com>, <lvs-devel@vger.kernel.org>,
	<marc.dionne@auristor.com>, <marcelo.leitner@gmail.com>,
	<martineau@kernel.org>, <matttbe@kernel.org>, <mcgrof@kernel.org>,
	<miquel.raynal@bootlin.com>, <mptcp@lists.linux.dev>, <ms@dev.tdt.de>,
	<neilb@suse.de>, <netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<pabeni@redhat.com>, <pablo@netfilter.org>, <ralf@linux-mips.org>,
	<razor@blackwall.org>, <rds-devel@oss.oracle.com>, <roopa@nvidia.com>,
	<stefan@datenfreihafen.org>, <steffen.klassert@secunet.com>,
	<tipc-discussion@lists.sourceforge.net>, <tom@talpey.com>,
	<tonylu@linux.alibaba.com>, <trond.myklebust@hammerspace.com>,
	<wenjia@linux.ibm.com>, <ying.xue@windriver.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH v3 1/4] networking: Remove the now superfluous sentinel elements from ctl_table array
Date: Mon, 15 Apr 2024 16:12:10 -0700
Message-ID: <20240415231210.22785-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240412-jag-sysctl_remset_net-v3-1-11187d13c211@samsung.com>
References: <20240412-jag-sysctl_remset_net-v3-1-11187d13c211@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 12 Apr 2024 16:48:29 +0200
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> * Remove sentinel element from ctl_table structs.
> * Remove extra element in ctl_table arrays declarations
> * Remove instances where an array element is zeroed out to make it look
>   like a sentinel. This is not longer needed and is safe after commit
>   c899710fe7f9 ("networking: Update to register_net_sysctl_sz") added
>   the array size to the ctl_table registration
> * Replace the for loop stop condition that tests for procname == NULL with
>   one that depends on array size
> * Removed the "-1" that adjusted for having an extra empty element when
>   looping over ctl_table arrays
> * Removing the unprivileged user check in ipv6_route_sysctl_init is
>   safe as it is replaced by calling ipv6_route_sysctl_table_size;
>   introduced in commit c899710fe7f9 ("networking: Update to
>   register_net_sysctl_sz")
> * Replace empty array registration with the register_net_sysctl_sz call.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  net/core/neighbour.c                | 5 +----
>  net/core/sysctl_net_core.c          | 9 ++++-----
>  net/dccp/sysctl.c                   | 2 --
>  net/ieee802154/6lowpan/reassembly.c | 6 +-----
>  net/ipv4/devinet.c                  | 5 ++---
>  net/ipv4/ip_fragment.c              | 2 --
>  net/ipv4/route.c                    | 8 ++------
>  net/ipv4/sysctl_net_ipv4.c          | 7 +++----
>  net/ipv4/xfrm4_policy.c             | 1 -
>  net/ipv6/addrconf.c                 | 5 +----
>  net/ipv6/icmp.c                     | 1 -
>  net/ipv6/reassembly.c               | 2 --
>  net/ipv6/route.c                    | 5 -----
>  net/ipv6/sysctl_net_ipv6.c          | 4 +---
>  net/ipv6/xfrm6_policy.c             | 1 -
>  net/llc/sysctl_net_llc.c            | 8 ++------
>  net/mpls/af_mpls.c                  | 3 +--
>  net/mptcp/ctrl.c                    | 1 -
>  net/netrom/sysctl_net_netrom.c      | 1 -
>  net/phonet/sysctl.c                 | 1 -
>  net/rds/ib_sysctl.c                 | 1 -
>  net/rds/sysctl.c                    | 1 -
>  net/rds/tcp.c                       | 1 -
>  net/rose/sysctl_net_rose.c          | 1 -
>  net/rxrpc/sysctl.c                  | 1 -
>  net/sctp/sysctl.c                   | 6 +-----
>  net/smc/smc_sysctl.c                | 1 -
>  net/sunrpc/sysctl.c                 | 1 -
>  net/sunrpc/xprtrdma/svc_rdma.c      | 1 -
>  net/sunrpc/xprtrdma/transport.c     | 1 -
>  net/sunrpc/xprtsock.c               | 1 -
>  net/tipc/sysctl.c                   | 1 -
>  net/unix/sysctl_net_unix.c          | 1 -
>  net/x25/sysctl_net_x25.c            | 1 -
>  net/xfrm/xfrm_sysctl.c              | 5 +----
>  35 files changed, 20 insertions(+), 81 deletions(-)

You may want to split patch based on subsystem or the type of changes
to make review easier.


> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 552719c3bbc3..b0327402b3e6 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -3728,7 +3728,7 @@ static int neigh_proc_base_reachable_time(struct ctl_table *ctl, int write,
>  
>  static struct neigh_sysctl_table {
>  	struct ctl_table_header *sysctl_header;
> -	struct ctl_table neigh_vars[NEIGH_VAR_MAX + 1];
> +	struct ctl_table neigh_vars[NEIGH_VAR_MAX];
>  } neigh_sysctl_template __read_mostly = {
>  	.neigh_vars = {
>  		NEIGH_SYSCTL_ZERO_INTMAX_ENTRY(MCAST_PROBES, "mcast_solicit"),
> @@ -3779,7 +3779,6 @@ static struct neigh_sysctl_table {
>  			.extra2		= SYSCTL_INT_MAX,
>  			.proc_handler	= proc_dointvec_minmax,
>  		},
> -		{},
>  	},
>  };
>  
> @@ -3807,8 +3806,6 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
>  	if (dev) {
>  		dev_name_source = dev->name;
>  		/* Terminate the table early */

You can remove this comment.


> -		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
> -		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
>  		neigh_vars_size = NEIGH_VAR_BASE_REACHABLE_TIME_MS + 1;
>  	} else {
>  		struct neigh_table *tbl = p->tbl;
> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 6973dda3abda..46f5143e86be 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -660,7 +660,6 @@ static struct ctl_table net_core_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= SYSCTL_ZERO,
>  	},
> -	{ }
>  };
>  
>  static struct ctl_table netns_core_table[] = {
> @@ -697,7 +696,6 @@ static struct ctl_table netns_core_table[] = {
>  		.extra2		= SYSCTL_ONE,
>  		.proc_handler	= proc_dou8vec_minmax,
>  	},
> -	{ }
>  };
>  
>  static int __init fb_tunnels_only_for_init_net_sysctl_setup(char *str)
> @@ -715,7 +713,8 @@ __setup("fb_tunnels=", fb_tunnels_only_for_init_net_sysctl_setup);
>  
>  static __net_init int sysctl_core_net_init(struct net *net)
>  {
> -	struct ctl_table *tbl, *tmp;
> +	struct ctl_table *tbl;
> +	size_t table_size = ARRAY_SIZE(netns_core_table);

When you add a new variable, please keep reverse xmas tree.

Also, you can reuse this variable for the following
register_net_sysctl_sz(), but it's inconsistent in the
this patch..

  table_size
  * sysctl_route_net_init
  * ipv4_sysctl_init_net

  ARRAY_SIZE
  * __addrconf_sysctl_register
  * ipv6_sysctl_net_init
  * mpls_dev_sysctl_register
  * sctp_sysctl_net_register


>  
>  	tbl = netns_core_table;
>  	if (!net_eq(net, &init_net)) {
> @@ -723,8 +722,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
>  		if (tbl == NULL)
>  			goto err_dup;
>  
> -		for (tmp = tbl; tmp->procname; tmp++)
> -			tmp->data += (char *)net - (char *)&init_net;
> +		for (int i = 0; i < table_size; ++i)
> +			(tbl + i)->data += (char *)net - (char *)&init_net;
>  	}
>  
>  	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl,
> diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
> index ee8d4f5afa72..3fc474d6e57d 100644
> --- a/net/dccp/sysctl.c
> +++ b/net/dccp/sysctl.c
> @@ -90,8 +90,6 @@ static struct ctl_table dccp_default_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_ms_jiffies,
>  	},
> -
> -	{ }
>  };
>  
>  static struct ctl_table_header *dccp_table_header;
> diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
> index 6dd960ec558c..09b18ee6df00 100644
> --- a/net/ieee802154/6lowpan/reassembly.c
> +++ b/net/ieee802154/6lowpan/reassembly.c
> @@ -338,7 +338,6 @@ static struct ctl_table lowpan_frags_ns_ctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> -	{ }
>  };
>  
>  /* secret interval has been deprecated */
> @@ -351,7 +350,6 @@ static struct ctl_table lowpan_frags_ctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> -	{ }
>  };
>  
>  static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
> @@ -370,10 +368,8 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
>  			goto err_alloc;
>  
>  		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns) {
> -			table[0].procname = NULL;
> +		if (net->user_ns != &init_user_ns)
>  			table_size = 0;
> -		}
>  	}
>  
>  	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 7a437f0d4190..6195cc5be1fc 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2515,7 +2515,7 @@ static int ipv4_doint_and_flush(struct ctl_table *ctl, int write,
>  
>  static struct devinet_sysctl_table {
>  	struct ctl_table_header *sysctl_header;
> -	struct ctl_table devinet_vars[__IPV4_DEVCONF_MAX];
> +	struct ctl_table devinet_vars[IPV4_DEVCONF_MAX];
>  } devinet_sysctl = {
>  	.devinet_vars = {
>  		DEVINET_SYSCTL_COMPLEX_ENTRY(FORWARDING, "forwarding",
> @@ -2578,7 +2578,7 @@ static int __devinet_sysctl_register(struct net *net, char *dev_name,
>  	if (!t)
>  		goto out;
>  
> -	for (i = 0; i < ARRAY_SIZE(t->devinet_vars) - 1; i++) {
> +	for (i = 0; i < ARRAY_SIZE(t->devinet_vars); i++) {
>  		t->devinet_vars[i].data += (char *)p - (char *)&ipv4_devconf;
>  		t->devinet_vars[i].extra1 = p;
>  		t->devinet_vars[i].extra2 = net;
> @@ -2652,7 +2652,6 @@ static struct ctl_table ctl_forward_entry[] = {
>  		.extra1		= &ipv4_devconf,
>  		.extra2		= &init_net,
>  	},
> -	{ },
>  };
>  #endif
>  
> diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
> index a4941f53b523..e308779ed77b 100644
> --- a/net/ipv4/ip_fragment.c
> +++ b/net/ipv4/ip_fragment.c
> @@ -580,7 +580,6 @@ static struct ctl_table ip4_frags_ns_ctl_table[] = {
>  		.proc_handler	= proc_dointvec_minmax,
>  		.extra1		= &dist_min,
>  	},
> -	{ }
>  };
>  
>  /* secret interval has been deprecated */
> @@ -593,7 +592,6 @@ static struct ctl_table ip4_frags_ctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> -	{ }
>  };
>  
>  static int __net_init ip4_frags_ns_ctl_register(struct net *net)
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index c8f76f56dc16..deecfc0e5a91 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -3509,7 +3509,6 @@ static struct ctl_table ipv4_route_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  static const char ipv4_route_flush_procname[] = "flush";
> @@ -3543,7 +3542,6 @@ static struct ctl_table ipv4_route_netns_table[] = {
>  		.mode       = 0644,
>  		.proc_handler   = proc_dointvec,
>  	},
> -	{ },
>  };
>  
>  static __net_init int sysctl_route_net_init(struct net *net)
> @@ -3561,16 +3559,14 @@ static __net_init int sysctl_route_net_init(struct net *net)
>  
>  		/* Don't export non-whitelisted sysctls to unprivileged users */
>  		if (net->user_ns != &init_user_ns) {
> -			if (tbl[0].procname != ipv4_route_flush_procname) {
> -				tbl[0].procname = NULL;
> +			if (tbl[0].procname != ipv4_route_flush_procname)
>  				table_size = 0;
> -			}
>  		}
>  
>  		/* Update the variables to point into the current struct net
>  		 * except for the first element flush
>  		 */
> -		for (i = 1; i < ARRAY_SIZE(ipv4_route_netns_table) - 1; i++)
> +		for (i = 1; i < table_size; i++)
>  			tbl[i].data += (void *)net - (void *)&init_net;
>  	}
>  	tbl[0].extra1 = net;
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 7e4f16a7dcc1..c8dae8fc682a 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -575,7 +575,6 @@ static struct ctl_table ipv4_table[] = {
>  		.extra1		= &sysctl_fib_sync_mem_min,
>  		.extra2		= &sysctl_fib_sync_mem_max,
>  	},
> -	{ }
>  };
>  
>  static struct ctl_table ipv4_net_table[] = {
> @@ -1502,12 +1501,12 @@ static struct ctl_table ipv4_net_table[] = {
>  		.proc_handler	= proc_dou8vec_minmax,
>  		.extra1		= SYSCTL_ONE,
>  	},
> -	{ }
>  };
>  
>  static __net_init int ipv4_sysctl_init_net(struct net *net)
>  {
>  	struct ctl_table *table;
> +	size_t table_size = ARRAY_SIZE(ipv4_net_table);

nit: keep reverse xmax tree order.


>  
>  	table = ipv4_net_table;
>  	if (!net_eq(net, &init_net)) {
> @@ -1517,7 +1516,7 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
>  		if (!table)
>  			goto err_alloc;
>  
> -		for (i = 0; i < ARRAY_SIZE(ipv4_net_table) - 1; i++) {
> +		for (i = 0; i < table_size; i++) {
>  			if (table[i].data) {
>  				/* Update the variables to point into
>  				 * the current struct net
> @@ -1533,7 +1532,7 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
>  	}
>  
>  	net->ipv4.ipv4_hdr = register_net_sysctl_sz(net, "net/ipv4", table,
> -						    ARRAY_SIZE(ipv4_net_table));
> +						    table_size);
>  	if (!net->ipv4.ipv4_hdr)
c>  		goto err_reg;
>  
> diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
> index c33bca2c3841..4c74fec034c5 100644
> --- a/net/ipv4/xfrm4_policy.c
> +++ b/net/ipv4/xfrm4_policy.c
> @@ -152,7 +152,6 @@ static struct ctl_table xfrm4_policy_table[] = {
>  		.mode           = 0644,
>  		.proc_handler   = proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  static __net_init int xfrm4_net_sysctl_init(struct net *net)
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index 247bd4d8ee45..69619a52d4f8 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7181,9 +7181,6 @@ static const struct ctl_table addrconf_sysctl[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_TWO,
>  	},
> -	{
> -		/* sentinel */
> -	}
>  };
>  
>  static int __addrconf_sysctl_register(struct net *net, char *dev_name,
> @@ -7197,7 +7194,7 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
>  	if (!table)
>  		goto out;
>  
> -	for (i = 0; table[i].data; i++) {
> +	for (i = 0; i < ARRAY_SIZE(addrconf_sysctl); i++) {

                        ^^^


>  		table[i].data += (char *)p - (char *)&ipv6_devconf;
>  		/* If one of these is already set, then it is not safe to
>  		 * overwrite either of them: this makes proc_dointvec_minmax
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 1635da07285f..91cbf8e8009f 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -1206,7 +1206,6 @@ static struct ctl_table ipv6_icmp_table_template[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> -	{ },
>  };
>  
>  struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index acb4f119e11f..afb343cb77ac 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -436,7 +436,6 @@ static struct ctl_table ip6_frags_ns_ctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> -	{ }
>  };
>  
>  /* secret interval has been deprecated */
> @@ -449,7 +448,6 @@ static struct ctl_table ip6_frags_ctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> -	{ }
>  };
>  
>  static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 1f4b935a0e57..b49137c3031b 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -6428,7 +6428,6 @@ static struct ctl_table ipv6_route_table_template[] = {
>  		.extra1		=	SYSCTL_ZERO,
>  		.extra2		=	SYSCTL_ONE,
>  	},
> -	{ }
>  };
>  
>  struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
> @@ -6452,10 +6451,6 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
>  		table[8].data = &net->ipv6.sysctl.ip6_rt_min_advmss;
>  		table[9].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
>  		table[10].data = &net->ipv6.sysctl.skip_notify_on_dev_down;
> -
> -		/* Don't export sysctls to unprivileged users */
> -		if (net->user_ns != &init_user_ns)
> -			table[1].procname = NULL;
>  	}
>  
>  	return table;
> diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
> index 888676163e90..9f40bb12fbdd 100644
> --- a/net/ipv6/sysctl_net_ipv6.c
> +++ b/net/ipv6/sysctl_net_ipv6.c
> @@ -213,7 +213,6 @@ static struct ctl_table ipv6_table_template[] = {
>  		.proc_handler	= proc_doulongvec_minmax,
>  		.extra2		= &ioam6_id_wide_max,
>  	},
> -	{ }
>  };
>  
>  static struct ctl_table ipv6_rotable[] = {
> @@ -248,7 +247,6 @@ static struct ctl_table ipv6_rotable[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif /* CONFIG_NETLABEL */
> -	{ }
>  };
>  
>  static int __net_init ipv6_sysctl_net_init(struct net *net)
> @@ -264,7 +262,7 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
>  	if (!ipv6_table)
>  		goto out;
>  	/* Update the variables to point into the current struct net */
> -	for (i = 0; i < ARRAY_SIZE(ipv6_table_template) - 1; i++)
> +	for (i = 0; i < ARRAY_SIZE(ipv6_table_template); i++)

                        ^^^


>  		ipv6_table[i].data += (void *)net - (void *)&init_net;
>  
>  	ipv6_route_table = ipv6_route_sysctl_init(net);
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index 42fb6996b077..499b5f5c19fc 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -184,7 +184,6 @@ static struct ctl_table xfrm6_policy_table[] = {
>  		.mode		= 0644,
>  		.proc_handler   = proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  static int __net_init xfrm6_net_sysctl_init(struct net *net)
> diff --git a/net/llc/sysctl_net_llc.c b/net/llc/sysctl_net_llc.c
> index 8443a6d841b0..72e101135f8c 100644
> --- a/net/llc/sysctl_net_llc.c
> +++ b/net/llc/sysctl_net_llc.c
> @@ -44,11 +44,6 @@ static struct ctl_table llc2_timeout_table[] = {
>  		.mode		= 0644,
>  		.proc_handler   = proc_dointvec_jiffies,
>  	},
> -	{ },
> -};
> -
> -static struct ctl_table llc_station_table[] = {
> -	{ },
>  };
>  
>  static struct ctl_table_header *llc2_timeout_header;
> @@ -56,8 +51,9 @@ static struct ctl_table_header *llc_station_header;
>  
>  int __init llc_sysctl_init(void)
>  {
> +	struct ctl_table empty[1] = {};
>  	llc2_timeout_header = register_net_sysctl(&init_net, "net/llc/llc2/timeout", llc2_timeout_table);
> -	llc_station_header = register_net_sysctl(&init_net, "net/llc/station", llc_station_table);
> +	llc_station_header = register_net_sysctl_sz(&init_net, "net/llc/station", empty, 0);

Do we really need this ... ??


>  
>  	if (!llc2_timeout_header || !llc_station_header) {
>  		llc_sysctl_exit();
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 6dab883a08dd..e163fac55ffa 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -1393,7 +1393,6 @@ static const struct ctl_table mpls_dev_table[] = {
>  		.proc_handler	= mpls_conf_proc,
>  		.data		= MPLS_PERDEV_SYSCTL_OFFSET(input_enabled),
>  	},
> -	{ }
>  };
>  
>  static int mpls_dev_sysctl_register(struct net_device *dev,
> @@ -2689,7 +2688,7 @@ static int mpls_net_init(struct net *net)
>  	/* Table data contains only offsets relative to the base of
>  	 * the mdev at this point, so make them absolute.
>  	 */
> -	for (i = 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
> +	for (i = 0; i < ARRAY_SIZE(mpls_table); i++)

                        ^^^


>  		table[i].data = (char *)net + (uintptr_t)table[i].data;
>  
>  	net->mpls.ctl = register_net_sysctl_sz(net, "net/mpls", table,
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 13fe0748dde8..8bf7c26a0878 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -156,7 +156,6 @@ static struct ctl_table mptcp_sysctl_table[] = {
>  		.mode = 0644,
>  		.proc_handler = proc_dointvec_jiffies,
>  	},
> -	{}
>  };
>  
>  static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
> diff --git a/net/netrom/sysctl_net_netrom.c b/net/netrom/sysctl_net_netrom.c
> index 79fb2d3f477b..7dc0fa628f2e 100644
> --- a/net/netrom/sysctl_net_netrom.c
> +++ b/net/netrom/sysctl_net_netrom.c
> @@ -140,7 +140,6 @@ static struct ctl_table nr_table[] = {
>  		.extra1		= &min_reset,
>  		.extra2		= &max_reset
>  	},
> -	{ }
>  };
>  
>  int __init nr_register_sysctl(void)
> diff --git a/net/phonet/sysctl.c b/net/phonet/sysctl.c
> index 0d0bf41381c2..82fc22467a09 100644
> --- a/net/phonet/sysctl.c
> +++ b/net/phonet/sysctl.c
> @@ -81,7 +81,6 @@ static struct ctl_table phonet_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_local_port_range,
>  	},
> -	{ }
>  };
>  
>  int __init phonet_sysctl_init(void)
> diff --git a/net/rds/ib_sysctl.c b/net/rds/ib_sysctl.c
> index e4e41b3afce7..2af678e71e3c 100644
> --- a/net/rds/ib_sysctl.c
> +++ b/net/rds/ib_sysctl.c
> @@ -103,7 +103,6 @@ static struct ctl_table rds_ib_sysctl_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  void rds_ib_sysctl_exit(void)
> diff --git a/net/rds/sysctl.c b/net/rds/sysctl.c
> index e381bbcd9cc1..025f518a4349 100644
> --- a/net/rds/sysctl.c
> +++ b/net/rds/sysctl.c
> @@ -89,7 +89,6 @@ static struct ctl_table rds_sysctl_rds_table[] = {
>  		.mode           = 0644,
>  		.proc_handler   = proc_dointvec,
>  	},
> -	{ }
>  };
>  
>  void rds_sysctl_exit(void)
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 2dba7505b414..d8111ac83bb6 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -86,7 +86,6 @@ static struct ctl_table rds_tcp_sysctl_table[] = {
>  		.proc_handler   = rds_tcp_skbuf_handler,
>  		.extra1		= &rds_tcp_min_rcvbuf,
>  	},
> -	{ }
>  };
>  
>  u32 rds_tcp_write_seq(struct rds_tcp_connection *tc)
> diff --git a/net/rose/sysctl_net_rose.c b/net/rose/sysctl_net_rose.c
> index d391d7758f52..d801315b7083 100644
> --- a/net/rose/sysctl_net_rose.c
> +++ b/net/rose/sysctl_net_rose.c
> @@ -112,7 +112,6 @@ static struct ctl_table rose_table[] = {
>  		.extra1		= &min_window,
>  		.extra2		= &max_window
>  	},
> -	{ }
>  };
>  
>  void __init rose_register_sysctl(void)
> diff --git a/net/rxrpc/sysctl.c b/net/rxrpc/sysctl.c
> index c9bedd0e2d86..9bf9a1f6e4cb 100644
> --- a/net/rxrpc/sysctl.c
> +++ b/net/rxrpc/sysctl.c
> @@ -127,7 +127,6 @@ static struct ctl_table rxrpc_sysctl_table[] = {
>  		.extra1		= (void *)SYSCTL_ONE,
>  		.extra2		= (void *)&four,
>  	},
> -	{ }
>  };
>  
>  int __init rxrpc_sysctl_init(void)
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index f65d6f92afcb..6894072af210 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -80,8 +80,6 @@ static struct ctl_table sctp_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> -
> -	{ /* sentinel */ }
>  };
>  
>  /* The following index defines are used in sctp_sysctl_net_register().
> @@ -384,8 +382,6 @@ static struct ctl_table sctp_net_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= &pf_expose_max,
>  	},
> -
> -	{ /* sentinel */ }
>  };
>  
>  static int proc_sctp_do_hmac_alg(struct ctl_table *ctl, int write,
> @@ -604,7 +600,7 @@ int sctp_sysctl_net_register(struct net *net)
>  	if (!table)
>  		return -ENOMEM;
>  
> -	for (i = 0; table[i].data; i++)
> +	for (i = 0; i < ARRAY_SIZE(sctp_net_table); i++)
>  		table[i].data += (char *)(&net->sctp) - (char *)&init_net.sctp;
>  
>  	table[SCTP_RTO_MIN_IDX].extra2 = &net->sctp.rto_max;
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index a5946d1b9d60..bd0b7e2f8824 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -90,7 +90,6 @@ static struct ctl_table smc_table[] = {
>  		.extra1		= &conns_per_lgr_min,
>  		.extra2		= &conns_per_lgr_max,
>  	},
> -	{  }
>  };
>  
>  int __net_init smc_sysctl_net_init(struct net *net)
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
> diff --git a/net/tipc/sysctl.c b/net/tipc/sysctl.c
> index 9fb65c988f7f..30d2e06e3d8c 100644
> --- a/net/tipc/sysctl.c
> +++ b/net/tipc/sysctl.c
> @@ -91,7 +91,6 @@ static struct ctl_table tipc_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_doulongvec_minmax,
>  	},
> -	{}
>  };
>  
>  int tipc_register_sysctl(void)
> diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
> index 3e84b31c355a..ae45d4cfac39 100644
> --- a/net/unix/sysctl_net_unix.c
> +++ b/net/unix/sysctl_net_unix.c
> @@ -19,7 +19,6 @@ static struct ctl_table unix_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec
>  	},
> -	{ }
>  };
>  
>  int __net_init unix_sysctl_register(struct net *net)
> diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
> index e9802afa43d0..643f50874dfe 100644
> --- a/net/x25/sysctl_net_x25.c
> +++ b/net/x25/sysctl_net_x25.c
> @@ -71,7 +71,6 @@ static struct ctl_table x25_table[] = {
>  		.mode = 	0644,
>  		.proc_handler = proc_dointvec,
>  	},
> -	{ },
>  };
>  
>  int __init x25_register_sysctl(void)
> diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
> index 7fdeafc838a7..b0f542805e6e 100644
> --- a/net/xfrm/xfrm_sysctl.c
> +++ b/net/xfrm/xfrm_sysctl.c
> @@ -38,7 +38,6 @@ static struct ctl_table xfrm_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec
>  	},
> -	{}
>  };
>  
>  int __net_init xfrm_sysctl_init(struct net *net)
> @@ -57,10 +56,8 @@ int __net_init xfrm_sysctl_init(struct net *net)
>  	table[3].data = &net->xfrm.sysctl_acq_expires;
>  
>  	/* Don't export sysctls to unprivileged users */
> -	if (net->user_ns != &init_user_ns) {
> -		table[0].procname = NULL;
> +	if (net->user_ns != &init_user_ns)
>  		table_size = 0;
> -	}
>  
>  	net->xfrm.sysctl_hdr = register_net_sysctl_sz(net, "net/core", table,
>  						      table_size);
> 
> -- 
> 2.43.0
B

