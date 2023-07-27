Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09397642F8
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Jul 2023 02:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjG0AdG (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 26 Jul 2023 20:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjG0AdF (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 26 Jul 2023 20:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E72135;
        Wed, 26 Jul 2023 17:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D8A061CDB;
        Thu, 27 Jul 2023 00:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317DAC433C7;
        Thu, 27 Jul 2023 00:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690417983;
        bh=n6P4qe025KqZDcXidNutJnxRtfKrqA9LuOQauXyKVKk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Xvd42lmacRzb2qOesWsBKnbDW51xA37uEwZeSCgjpBV7kSwy+Mb1dYN/l1jgVZWVZ
         1fLBKprtmX2FRoaElaLmm9OlF1dIuUWxu2ewwMiTLVnjoWwFv2egVq9SdP2ERnImWR
         OsWyYzYbH0k3i7GTVK40jhxPRQoTwXVHOVyvZLtL4rZx9nBJmahGRwhpQNGgFjs8uB
         FHC2ULtrcuGwSZ74ANAoUqEUdoGPavD+892U0uER+ss5eSTTb6RQdQ0vZ6gjwskjOO
         EQ64vTfr+aettKEw2zQuwQLmbXxi+ckJZpcsYMj8TpTiWTP2avI3PWDPyk+a42VNDN
         Oky7gPtea9Rbg==
Message-ID: <60a508e6-9fa7-215e-99ed-394be6178b12@kernel.org>
Date:   Wed, 26 Jul 2023 18:33:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 11/14] networking: Update to register_net_sysctl_sz
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Joel Granados <j.granados@samsung.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140709eucas1p2033d64aec69a1962fd7e64c57ad60adc@eucas1p2.samsung.com>
 <20230726140635.2059334-12-j.granados@samsung.com>
 <ZMFgZHsnhrXNIQ53@bombadil.infradead.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <ZMFgZHsnhrXNIQ53@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On 7/26/23 12:05 PM, Luis Chamberlain wrote:
> On Wed, Jul 26, 2023 at 04:06:31PM +0200, Joel Granados wrote:
>> This is part of the effort to remove the sentinel (last empty) element
>> from the ctl_table arrays. We update to the new function and pass it the
>> array size. Care is taken to mirror the NULL assignments with a size of
>> zero (for the unprivileged users). An additional size function was added
>> to the following files in order to calculate the size of an array that
>> is defined in another file:
>>     include/net/ipv6.h
>>     net/ipv6/icmp.c
>>     net/ipv6/route.c
>>     net/ipv6/sysctl_net_ipv6.c
>>
> 
> Same here as with the other patches, the "why" and size impact should go here.
> I'll skip mentioning that in the other patches.
> 
>> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
>> index bf6e81d56263..5bad14b3c71e 100644
>> --- a/net/mpls/af_mpls.c
>> +++ b/net/mpls/af_mpls.c
>> @@ -1396,6 +1396,40 @@ static const struct ctl_table mpls_dev_table[] = {
>>  	{ }
>>  };
>>  
>> +static int mpls_platform_labels(struct ctl_table *table, int write,
>> +				void *buffer, size_t *lenp, loff_t *ppos);
>> +#define MPLS_NS_SYSCTL_OFFSET(field)		\
>> +	(&((struct net *)0)->field)
>> +
>> +static const struct ctl_table mpls_table[] = {
>> +	{
>> +		.procname	= "platform_labels",
>> +		.data		= NULL,
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= mpls_platform_labels,
>> +	},
>> +	{
>> +		.procname	= "ip_ttl_propagate",
>> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.ip_ttl_propagate),
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_ONE,
>> +	},
>> +	{
>> +		.procname	= "default_ttl",
>> +		.data		= MPLS_NS_SYSCTL_OFFSET(mpls.default_ttl),
>> +		.maxlen		= sizeof(int),
>> +		.mode		= 0644,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ONE,
>> +		.extra2		= &ttl_max,
>> +	},
>> +	{ }
>> +};
> 
> Unless we hear otherwise from networking folks, I think this move alone
> should probably go as a separate patch with no functional changes to
> make the changes easier to review / bisect.
> 

+1

