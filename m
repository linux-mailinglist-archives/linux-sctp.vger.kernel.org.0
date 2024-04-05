Return-Path: <linux-sctp+bounces-61-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D5F89A743
	for <lists+linux-sctp@lfdr.de>; Sat,  6 Apr 2024 00:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C2F1F24FDD
	for <lists+linux-sctp@lfdr.de>; Fri,  5 Apr 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90706176FB2;
	Fri,  5 Apr 2024 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LMoCvuAv"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCE175557;
	Fri,  5 Apr 2024 22:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712356047; cv=none; b=u+xTbhwsmRezwWfNUAyD1JnRzYl/RJ/gI33aR37BWnetkFsDlfuOE49y0jw4NlmNvPl+IRzp3v9tKVfEynZUheaDyRaLRI7r5G6eGY6/33jNYzyHjj++ENwlF76h46xJp4yZrTbnCZTWPFcbF4NglQgipCGifrHbHr8YbrgMt50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712356047; c=relaxed/simple;
	bh=qrrZBeX1vtGWgwK5O99qDlCfzTKu2CnGs6Zioe/+/30=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0aoUwsMtCAaySyGhoMv85FBhIAl7qXo9RqNcGHUA6nx0srvUfdJ0sUczzXtFonspXftrqI+tIQu3FI9Q5mPxzBi7tsHpXZLaZeA7USE3YTTRH9sj5p2/pxHsoCBKQygnR/hJPHMos+OzJ6ckIQP/hqFBl3Qp1ulx67fVGhsHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LMoCvuAv; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712356045; x=1743892045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MZmfmRuTm98xxNT3u4GoRIvJJsGslBrgcovMMdqPwTw=;
  b=LMoCvuAvAiKpauBjBvG9rZqvq6Adv0g22tVGZIEI0d5TB8C2HlDl1LHj
   ASgigsE0s2Il2hca+iDoCM6AQH10YBXw8e5uCk/kWQjy44Sa3yPPKf9V2
   ge0Y/ag/602Bo2vu9PmOTCQz5V4tyWdDcU0BFbPvDDGjaYJf/FMeOaHPI
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,182,1708387200"; 
   d="scan'208";a="716520780"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 22:27:19 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:33431]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.222:2525] with esmtp (Farcaster)
 id d323b31d-9f42-407f-b466-8125712ac6f4; Fri, 5 Apr 2024 22:27:18 +0000 (UTC)
X-Farcaster-Flow-ID: d323b31d-9f42-407f-b466-8125712ac6f4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 5 Apr 2024 22:27:17 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Fri, 5 Apr 2024 22:27:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <j.granados@samsung.com>
CC: <Dai.Ngo@oracle.com>, <alex.aring@gmail.com>, <alibuda@linux.alibaba.com>,
	<allison.henderson@oracle.com>, <anna@kernel.org>, <bridge@lists.linux.dev>,
	<chuck.lever@oracle.com>, <coreteam@netfilter.org>, <courmisch@gmail.com>,
	<davem@davemloft.net>, <dccp@vger.kernel.org>,
	<devnull+j.granados.samsung.com@kernel.org>, <dhowells@redhat.com>,
	<dsahern@kernel.org>, <edumazet@google.com>, <fw@strlen.de>,
	<geliang@kernel.org>, <guwen@linux.alibaba.com>,
	<herbert@gondor.apana.org.au>, <horms@verge.net.au>, <ja@ssi.bg>,
	<jaka@linux.ibm.com>, <jlayton@kernel.org>, <jmaloy@redhat.com>,
	<jreuter@yaina.de>, <kadlec@netfilter.org>, <keescook@chromium.org>,
	<kolga@netapp.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-afs@lists.infradead.org>, <linux-hams@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-sctp@vger.kernel.org>, <linux-wpan@vger.kernel.org>,
	<linux-x25@vger.kernel.org>, <lucien.xin@gmail.com>,
	<lvs-devel@vger.kernel.org>, <marc.dionne@auristor.com>,
	<marcelo.leitner@gmail.com>, <martineau@kernel.org>, <matttbe@kernel.org>,
	<mcgrof@kernel.org>, <miquel.raynal@bootlin.com>, <mptcp@lists.linux.dev>,
	<ms@dev.tdt.de>, <neilb@suse.de>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <pabeni@redhat.com>,
	<pablo@netfilter.org>, <ralf@linux-mips.org>, <razor@blackwall.org>,
	<rds-devel@oss.oracle.com>, <roopa@nvidia.com>, <stefan@datenfreihafen.org>,
	<steffen.klassert@secunet.com>, <tipc-discussion@lists.sourceforge.net>,
	<tom@talpey.com>, <tonylu@linux.alibaba.com>,
	<trond.myklebust@hammerspace.com>, <wenjia@linux.ibm.com>,
	<ying.xue@windriver.com>
Subject: Re: [PATCH v2 4/4] ax.25: Remove the now superfluous sentinel elements from ctl_table array
Date: Fri, 5 Apr 2024 15:26:58 -0700
Message-ID: <20240405222658.3615-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240405071531.fv6smp55znlfnul2@joelS2.panther.com>
References: <20240405071531.fv6smp55znlfnul2@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Joel Granados <j.granados@samsung.com>
Date: Fri, 5 Apr 2024 09:15:31 +0200
> On Thu, Mar 28, 2024 at 12:49:34PM -0700, Kuniyuki Iwashima wrote:
> > From: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>
> > Date: Thu, 28 Mar 2024 16:40:05 +0100
> > > This commit comes at the tail end of a greater effort to remove the
> > > empty elements at the end of the ctl_table arrays (sentinels) which will
> > > reduce the overall build time size of the kernel and run time memory
> > > bloat by ~64 bytes per sentinel (further information Link :
> > > https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
> > > 
> > > When we remove the sentinel from ax25_param_table a buffer overflow
> > > shows its ugly head. The sentinel's data element used to be changed when
> > > CONFIG_AX25_DAMA_SLAVE was not defined.
> > 
> > I think it's better to define the relation explicitly between the
> > enum and sysctl table by BUILD_BUG_ON() in ax25_register_dev_sysctl()
> > 
> >   BUILD_BUG_ON(AX25_MAX_VALUES != ARRAY_SIZE(ax25_param_table));
> > 
> > and guard AX25_VALUES_DS_TIMEOUT with #ifdef CONFIG_AX25_DAMA_SLAVE
> > as done for other enum.
> 
> When I remove AX25_VALUES_DS_TIMEOUT from the un-guarded build it
> complains in net/ax25/ax25_ds_timer.c (ax25_ds_set_timer). Here is the
> report https://lore.kernel.org/oe-kbuild-all/202404040301.qzKmVQGB-lkp@intel.com/.
> 
> How best to address this? Should we just guard the whole function and do
> nothing when not set? like this:

It seems fine to me.

ax25_ds_timeout() checks !ax25_dev->dama.slave_timeout, but it's
initialised by kzalloc() during dev setup, so it will be a noop.


> 
> ```
> void ax25_ds_set_timer(ax25_dev *ax25_dev)
> {
> #ifdef COFNIG_AX25_DAMA_SLAVE
>         if (ax25_dev == NULL)        ···/* paranoia */
>                 return;
> 
>         ax25_dev->dama.slave_timeout =
>                 msecs_to_jiffies(ax25_dev->values[AX25_VALUES_DS_TIMEOUT]) / 10;
>         mod_timer(&ax25_dev->dama.slave_timer, jiffies + HZ);
> #else
>         return;
> #endif
> }
> 
> ```
> 
> I'm not too familiar with this, so pointing me to the "correct" way to
> handle this would be helpfull.

Also, you will need to guard another use of AX25_VALUES_DS_TIMEOUT in
ax25_dev_device_up().

Thanks!

