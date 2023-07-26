Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420FE763E1E
	for <lists+linux-sctp@lfdr.de>; Wed, 26 Jul 2023 20:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjGZSFu (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 26 Jul 2023 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGZSFu (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 26 Jul 2023 14:05:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520801FF5;
        Wed, 26 Jul 2023 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fUdSbyMasri59LIxUKfjb5lu5YYJqsniF6+eeDt322Q=; b=DFkN7+kcpB7N73mFnnGHkptntF
        MyxL56OIeohRI14G30XsmKj0s3vmZhE/AD7bJh8knddWtfQsfV3VeSz0D9bcumOq1hsMyngu9HgYQ
        GL/niposaUkJBmS7Pkw5Kn0Tx6qPabY8YIQTrb0ue7SCCbqteV8F2Uy7/HHgVXPIUQuy4nFAONt9a
        RhZRWNladuq/dGYVRt/HbTKLGLUVnfyYOcp8FtDkB6mlEwOApP1ObsVm+CPTD2MrzCtVc7WVlQ24w
        D/eCeHDxQ3fB3lMWtwityCNHoHCkGCgolBBRmBQ4kjPm4WwOB92HuOuwvip8ulOpRb0+WJRPIgmvD
        NKK9pRhA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qOit2-00BF7a-29;
        Wed, 26 Jul 2023 18:05:24 +0000
Date:   Wed, 26 Jul 2023 11:05:24 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, willy@infradead.org,
        keescook@chromium.org, josh@joshtriplett.org,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wpan@vger.kernel.org,
        mptcp@lists.linux.dev, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 11/14] networking: Update to register_net_sysctl_sz
Message-ID: <ZMFgZHsnhrXNIQ53@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc@eucas1p2.samsung.com>
 <20230726140635.2059334-12-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726140635.2059334-12-j.granados@samsung.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jul 26, 2023 at 04:06:31PM +0200, Joel Granados wrote:
> This is part of the effort to remove the sentinel (last empty) element
> from the ctl_table arrays. We update to the new function and pass it the
> array size. Care is taken to mirror the NULL assignments with a size of
> zero (for the unprivileged users). An additional size function was added
> to the following files in order to calculate the size of an array that
> is defined in another file:
>     include/net/ipv6.h
>     net/ipv6/icmp.c
>     net/ipv6/route.c
>     net/ipv6/sysctl_net_ipv6.c
> 

Same here as with the other patches, the "why" and size impact should go here.
I'll skip mentioning that in the other patches.

> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index bf6e81d56263..5bad14b3c71e 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -1396,6 +1396,40 @@ static const struct ctl_table mpls_dev_table[] = {
>  	{ }
>  };
>  
> +static int mpls_platform_labels(struct ctl_table *table, int write,
> +				void *buffer, size_t *lenp, loff_t *ppos);
> +#define MPLS_NS_SYSCTL_OFFSET(field)		\
> +	(&((struct net *)0)->field)
> +
> +static const struct ctl_table mpls_table[] = {
> +	{
> +		.procname	= "platform_labels",
> +		.data		= NULL,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= mpls_platform_labels,
> +	},
> +	{
> +		.procname	= "ip_ttl_propagate",
> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{
> +		.procname	= "default_ttl",
> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= &ttl_max,
> +	},
> +	{ }
> +};

Unless we hear otherwise from networking folks, I think this move alone
should probably go as a separate patch with no functional changes to
make the changes easier to review / bisect.

  Luis
