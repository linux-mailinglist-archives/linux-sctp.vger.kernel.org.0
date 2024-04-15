Return-Path: <linux-sctp+bounces-70-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB2F8A5E2B
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Apr 2024 01:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDF51F229F9
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Apr 2024 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB83158DDC;
	Mon, 15 Apr 2024 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bp98jKkX"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023D61272B8;
	Mon, 15 Apr 2024 23:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223163; cv=none; b=vCJWpovfmVWEPVlrmCxeEBDx9aFIfJMJxfM1+beCfXqDVM1Fk9SV9Xz5/078bIwyy8T6U1m5D27mMc5l//EsJJqES2gdNiLDW5KtWgYQGCcYwy6NEx6c/yQUaThseWbrruzpsONtO5oVlGsNrgpQGpV/xyfEoXB15rJikm2Vd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223163; c=relaxed/simple;
	bh=O7IS3oPlp5+sm72VRPb5jKxSHrI+jlf1vy1OB12Yer0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFNeXMq9GuW2nb6151JrQgcEJpQkBt3lhr/KIQFTJfJ8pcTEW/kqp38+urWP7CJDU2PvNndow8YiAhtN8AW+39D8ecBXhUkbcp3mHtrp8qk0t6yqnnmgAvH20LzCyuX+NT484DQTaHNPIREWAfasfbsAIXrOZf5P3A1whdeKfB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bp98jKkX; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713223161; x=1744759161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nNllzdqzyM5Bz0YxRI8syNc99amIrBzYYq2sTSmZBPw=;
  b=Bp98jKkXt+DWgJMJk/VnC2koZBCdXF3S9UfLHaXWlu2lOD/jHEkaJPiX
   NqB29FKb+Zd+SEVzJ6uzAsCvZ/OEQA8szmWpggCFPh+qW6LgLBlyAc+Hl
   PTSqDmJ6Sxwh9DzQzTiDVil4QvwPFl/KKS1zGzrkCyJ8MPHfLJoPeu923
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,204,1708387200"; 
   d="scan'208";a="652012921"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 23:19:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:43163]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.38:2525] with esmtp (Farcaster)
 id b612ba95-1060-4583-9bf4-c255c8a740ec; Mon, 15 Apr 2024 23:19:15 +0000 (UTC)
X-Farcaster-Flow-ID: b612ba95-1060-4583-9bf4-c255c8a740ec
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 23:19:14 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 15 Apr 2024 23:19:03 +0000
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
Subject: Re: [PATCH v3 4/4] ax.25: Remove the now superfluous sentinel elements from ctl_table array
Date: Mon, 15 Apr 2024 16:18:53 -0700
Message-ID: <20240415231853.23060-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240412-jag-sysctl_remset_net-v3-4-11187d13c211@samsung.com>
References: <20240412-jag-sysctl_remset_net-v3-4-11187d13c211@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Fri, 12 Apr 2024 16:48:32 +0200
> From: Joel Granados <j.granados@samsung.com>
> 
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which will
> reduce the overall build time size of the kernel and run time memory
> bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> Avoid a buffer overflow when traversing the ctl_table by ensuring that
> AX25_MAX_VALUES is the same as the size of ax25_param_table. This is
> done with a BUILD_BUG_ON where ax25_param_table is defined and a
> CONFIG_AX25_DAMA_SLAVE guard in the unnamed enum definition as well as
> in the ax25_dev_device_up and ax25_ds_set_timer functions.
> 
> The overflow happened when the sentinel was removed from
> ax25_param_table. The sentinel's data element was changed when
> CONFIG_AX25_DAMA_SLAVE was undefined. This had no adverse effects as it
> still stopped on the sentinel's null procname but needed to be addressed
> once the sentinel was removed.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


> ---
>  include/net/ax25.h         | 2 ++
>  net/ax25/ax25_dev.c        | 3 +++
>  net/ax25/ax25_ds_timer.c   | 4 ++++
>  net/ax25/sysctl_net_ax25.c | 3 +--
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/ax25.h b/include/net/ax25.h
> index 0d939e5aee4e..eb9cee8252c8 100644
> --- a/include/net/ax25.h
> +++ b/include/net/ax25.h
> @@ -139,7 +139,9 @@ enum {
>  	AX25_VALUES_N2,		/* Default N2 value */
>  	AX25_VALUES_PACLEN,	/* AX.25 MTU */
>  	AX25_VALUES_PROTOCOL,	/* Std AX.25, DAMA Slave, DAMA Master */
> +#ifdef CONFIG_AX25_DAMA_SLAVE
>  	AX25_VALUES_DS_TIMEOUT,	/* DAMA Slave timeout */
> +#endif
>  	AX25_MAX_VALUES		/* THIS MUST REMAIN THE LAST ENTRY OF THIS LIST */
>  };
>  
> diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
> index c5462486dbca..af547e185a94 100644
> --- a/net/ax25/ax25_dev.c
> +++ b/net/ax25/ax25_dev.c
> @@ -78,7 +78,10 @@ void ax25_dev_device_up(struct net_device *dev)
>  	ax25_dev->values[AX25_VALUES_N2]        = AX25_DEF_N2;
>  	ax25_dev->values[AX25_VALUES_PACLEN]	= AX25_DEF_PACLEN;
>  	ax25_dev->values[AX25_VALUES_PROTOCOL]  = AX25_DEF_PROTOCOL;
> +
> +#ifdef CONFIG_AX25_DAMA_SLAVE
>  	ax25_dev->values[AX25_VALUES_DS_TIMEOUT]= AX25_DEF_DS_TIMEOUT;
> +#endif
>  
>  #if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
>  	ax25_ds_setup_timer(ax25_dev);
> diff --git a/net/ax25/ax25_ds_timer.c b/net/ax25/ax25_ds_timer.c
> index c4f8adbf8144..8f385d2a7628 100644
> --- a/net/ax25/ax25_ds_timer.c
> +++ b/net/ax25/ax25_ds_timer.c
> @@ -49,12 +49,16 @@ void ax25_ds_del_timer(ax25_dev *ax25_dev)
>  
>  void ax25_ds_set_timer(ax25_dev *ax25_dev)
>  {
> +#ifdef CONFIG_AX25_DAMA_SLAVE
>  	if (ax25_dev == NULL)		/* paranoia */
>  		return;
>  
>  	ax25_dev->dama.slave_timeout =
>  		msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
>  	mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
> +#else
> +	return;
> +#endif
>  }
>  
>  /*
> diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
> index db66e11e7fe8..fb9966926e90 100644
> --- a/net/ax25/sysctl_net_ax25.c
> +++ b/net/ax25/sysctl_net_ax25.c
> @@ -141,8 +141,6 @@ static const struct ctl_table ax25_param_table[] = {
>  		.extra2		= &max_ds_timeout
>  	},
>  #endif
> -
> -	{ }	/* that's all, folks! */
>  };
>  
>  int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
> @@ -155,6 +153,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
>  	if (!table)
>  		return -ENOMEM;
>  
> +	BUILD_BUG_ON(AX25_MAX_VALUES != ARRAY_SIZE(ax25_param_table));
>  	for (k = 0; k < AX25_MAX_VALUES; k++)
>  		table[k].data = &ax25_dev->values[k];
>  
> 
> -- 
> 2.43.0

