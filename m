Return-Path: <linux-sctp+bounces-57-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAA38909A1
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 20:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0A871F234CE
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Mar 2024 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0D213958C;
	Thu, 28 Mar 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kSsq3Ssw"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48F13957C;
	Thu, 28 Mar 2024 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655406; cv=none; b=C2ZKThbQY0sbskjF85FLhOcCLFjW+MeI4k2t9p7CUyCVvA7Fwr6hIZ40yLOxxpOvBXn4Ewh/oZ06sBf3Sg7tmby00JeJpDb54qwebAkoBvnRIA8O/ac8cb+tKI5Xm7wIsoJdYQcYbE9RhMwklBYf5V3jYslxbeqgCg7xm8v/CZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655406; c=relaxed/simple;
	bh=jy7iDHuc6Ej+2jTP9CC2GUNMdvWMnjZbOjyyWldjqgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGlWSCU3hewS85fa+0fXK3PiWedXt3sC0SwKVMFgoa/xq/WNN6+LnunaADVYf/SVA1126JpvS5xxwZ8jdDxu0oETekzJTS8d1U0nja60g2HUHO323OOi0gQfRWWHsb+qggCs8wY0LTe9f8bJqhiO9mxfp0Aqf31j/3E4CI0JwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kSsq3Ssw; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711655404; x=1743191404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJnwU1+gGS+NGNA2zseGcZeJ5QG2IPGlkTTsQ5KCHlw=;
  b=kSsq3SswdfM+s5M8UqDDX85q+IN/9e+Z567+yJm/QP1kNGJtNRgrVEbl
   odpo0TI25iXqMG4FHEkylvhcNAI6R2yWFlh9tcBfJJxN+t0/yvVjL+97g
   tZFDglExU6sH72SoJanz1znpLauXX5knwVJVaV+VuU3Cxnnl9Os8Q5cbG
   c=;
X-IronPort-AV: E=Sophos;i="6.07,162,1708387200"; 
   d="scan'208";a="391312047"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 19:49:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:20037]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.83:2525] with esmtp (Farcaster)
 id 73cfa33f-945b-445c-ba15-2d07ca3a8590; Thu, 28 Mar 2024 19:49:56 +0000 (UTC)
X-Farcaster-Flow-ID: 73cfa33f-945b-445c-ba15-2d07ca3a8590
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 28 Mar 2024 19:49:56 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Thu, 28 Mar 2024 19:49:44 +0000
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
Subject: [PATCH v2 4/4] ax.25: Remove the now superfluous sentinel elements from ctl_table array
Date: Thu, 28 Mar 2024 12:49:34 -0700
Message-ID: <20240328194934.42278-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240328-jag-sysctl_remset_net-v2-4-52c9fad9a1af@samsung.com>
References: <20240328-jag-sysctl_remset_net-v2-4-52c9fad9a1af@samsung.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
Date: Thu, 28 Mar 2024 16:40:05 +0100
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which will
> reduce the overall build time size of the kernel and run time memory
> bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> 
> When we remove the sentinel from ax25_param_table a buffer overflow
> shows its ugly head. The sentinel's data element used to be changed when
> CONFIG_AX25_DAMA_SLAVE was not defined.

I think it's better to define the relation explicitly between the
enum and sysctl table by BUILD_BUG_ON() in ax25_register_dev_sysctl()

  BUILD_BUG_ON(AX25_MAX_VALUES != ARRAY_SIZE(ax25_param_table));

and guard AX25_VALUES_DS_TIMEOUT with #ifdef CONFIG_AX25_DAMA_SLAVE
as done for other enum.


> This did not have any adverse
> effects as we still stopped on the sentinel because of its null
> procname. But now that we do not have the sentinel element, we are
> careful to check ax25_param_table's size.
> 
> Signed-off-by: Joel Granados <j.granados@samsung.com>
> ---
>  net/ax25/sysctl_net_ax25.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
> index db66e11e7fe8..e55be8817a1e 100644
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
> @@ -155,7 +153,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
>  	if (!table)
>  		return -ENOMEM;
>  
> -	for (k = 0; k < AX25_MAX_VALUES; k++)
> +	for (k = 0; k < AX25_MAX_VALUES && k < ARRAY_SIZE(ax25_param_table); k++)
>  		table[k].data = &ax25_dev->values[k];
>  
>  	snprintf(path, sizeof(path), "net/ax25/%s", ax25_dev->dev->name);
> 
> -- 
> 2.43.0

