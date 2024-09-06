Return-Path: <linux-sctp+bounces-243-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED5196F32A
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F0B1F246EE
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904411CB333;
	Fri,  6 Sep 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DS+H6fgY"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D101C9DF7
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622604; cv=none; b=mSKAfQhBM6igrdk0VuTI8IJkNrTP1PAQD0CCzdWbgFWAeX1+aJqnfuMCAjpjK8P/C8jP9eVMC6aJmLu9LG65ldG6g+C0535x9avQiCFXqLXAot+pxcNZ9Iv6+PXkRulb/x9HZUWHDDU9+1o8RogxioWm3UoInhGRriQvgI8iSRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622604; c=relaxed/simple;
	bh=H/3SLq0dvyRb0LeVyF9BgA30UQ44hQlrC2EyAJ37Cwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Xdv/eIGPe6JxCzJlIkiNAbKeNeozZRMKYZ2xXos/brtL5azkkTNnIhqP8T7WxWxNAnte97QRiMTwZZMD4yX8sPD98836N/AUqOJCxJZR9IIrLHdtc3oWHdNEMzE2aMMOrHYseMA8FPyFbnUDClfGm6GlmzM7upixc0J8PNlxCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DS+H6fgY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725622601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VlxXCUBgluNFhOhUQlRETci2Bz36a3nP0aOKtUXmSaU=;
	b=DS+H6fgYmXjM+Oh7eENp+mFjvf7PrNSLrCYYXn1S36Vy4Pgid8YfhrmKt74l6TJut1cxYj
	lG2q944e87Rz1tmIkXKB7iocF6oao96xHdpqSNPVgcOu/yrQe3dYkBhAjUu9tJ+NNJw6Xd
	K4ZtM7yVdjHGjrILJvelkP4ImN4oc0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-H88YDMilMcu-tvTAOElGBg-1; Fri, 06 Sep 2024 07:36:40 -0400
X-MC-Unique: H88YDMilMcu-tvTAOElGBg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374bfc57e2aso1260210f8f.3
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622599; x=1726227399;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlxXCUBgluNFhOhUQlRETci2Bz36a3nP0aOKtUXmSaU=;
        b=Rt1Z6nfZjh70ZaIxMiVrWowf5E09MKRe7BOMG6pYF2AUzFVSZL/4WxlCzfppsOhQUI
         RH0QlZPne4TmFWXiVDVBndZrp8RKPx+lJeDuOX43sXDkRzfAlQil3wwCt880uStmqYXR
         Z3f11lvTWgE23AUBZF1y6ijYrQ+g+9XhIFZ3zuAOfYFGWZAwsqjDoV0bBvk0ktfDcxAx
         3E8R9mNpaGqL972qU5kqij4BPqkkwNif2tLtUcn+RT9oy1vaKewVcOkGB3BMSGAJuo1n
         JmKHUWE9hpywez+ho7LNYnsCyrAR8AzBXKnvFIakKmnZaYf+IR+lxG36krwPN/LMQXJO
         20DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqzrEdzSwGjLuSh0xrmENAFM26KZyQxbY0yVDw1Ev2pUI4IlcLgrn/evV8yvjViSbIPhXG9LO7x4Pe@vger.kernel.org
X-Gm-Message-State: AOJu0YyLAyG5i5CDoVCvPFhBq/xsMmyocGPkxCgkkyRDaWSv9/Us3REq
	wNgkEOmA3PFxpL9ycQ4sCuKUE4MAILUPt+MnmPLrIs+mmNeB8E7xUa0e0tZk0assvkIcXIZuzu7
	D2qXs2fYBThzZjAmFG0aMhl1gaUOSGEURBGG+TSIZhGMZ1OwkWy92N31MEno=
X-Received: by 2002:a5d:444c:0:b0:374:c6b8:50c3 with SMTP id ffacd0b85a97d-3788960c8c5mr1448838f8f.32.1725622599287;
        Fri, 06 Sep 2024 04:36:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvxtr7JBMGDYXn43/Db5EyNacFUtJy69cDUqld7dUH+RRHTkLZupBqCPcA0/x2kPypfjxAg==
X-Received: by 2002:a5d:444c:0:b0:374:c6b8:50c3 with SMTP id ffacd0b85a97d-3788960c8c5mr1448800f8f.32.1725622598548;
        Fri, 06 Sep 2024 04:36:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm17942975e9.13.2024.09.06.04.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:36:37 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:36:35 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_bind_dev()
Message-ID: <ZtrpQzQYR1yylvi0@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-6-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv4/ip_tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index 18964394d6bd..b632c128ecb7 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -293,7 +293,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
>  
>  		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
>  				    iph->saddr, tunnel->parms.o_key,
> -				    RT_TOS(iph->tos), dev_net(dev),
> +				    iph->tos & INET_DSCP_MASK, dev_net(dev),

The net/inet_dscp.h header file is only included in patch 6, while it's
needed here in patch 5.

>  				    tunnel->parms.link, tunnel->fwmark, 0, 0);
>  		rt = ip_route_output_key(tunnel->net, &fl4);
>  
> -- 
> 2.46.0
> 


