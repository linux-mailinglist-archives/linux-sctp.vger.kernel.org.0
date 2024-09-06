Return-Path: <linux-sctp+bounces-250-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28F796F5D3
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 15:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80E501F2548F
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BADB1CF2B3;
	Fri,  6 Sep 2024 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gfZQrhn8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB91CEE9B
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630732; cv=none; b=ocLEb8Z/yb/XF1H8tX0EAFvKhxDsM48eKctXN8R4+jiARqt1LP8fP5OqhSsoL5Q1Q3eI1/uw3fjdbFYR3F/724VVYEoqxWd7d/m3eEEi7z/eixHlizTnhPqyqUbaMW4Cxg1TlcKmfaEnqzHlaoBZaOnMTglPavcFrWxOjmG7q9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630732; c=relaxed/simple;
	bh=StSQ8Sopl2KUdJyrUIo0Dn6vw18ljtWli0wJa4rE2V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hVqSTqL14rAQYkEE5eMkH7N1V38tcxaNC1Ld/oa+Anr61zxUCV34deGA8R/rLsFqr2biEdz16SvhTKcuI1/3V6f57uEpRn68C2Ohu3vOzOV0FvIgHnGxsCaMry3V4gSuqTF+dq8tIvYpGflGvoyDMduoseExfYbl5xgyutyfJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gfZQrhn8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725630728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruf53o5LMxX7Ic6vKOyaHGTrP4g2JJS9oUvDsEuczC0=;
	b=gfZQrhn8klaHa6/pM7ntOvaJr+ZF4SDXwzgchpiUFWwzsKbTSDshAVvGy/PEcmiD9HEjUH
	+VyyGzg69e70Ft41vtOfrwznOdcHx0JqYEpklwQPWeywoh0U0+Bp2Ym9M0+P/i/JbrB3Nd
	hsmXmdk8VTqueWVW9rBMfA7wuW7pZeA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-DT-yl6vzOg6sQP4wlvZx5w-1; Fri, 06 Sep 2024 09:52:07 -0400
X-MC-Unique: DT-yl6vzOg6sQP4wlvZx5w-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42c7a5563cfso15409425e9.2
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 06:52:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630726; x=1726235526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ruf53o5LMxX7Ic6vKOyaHGTrP4g2JJS9oUvDsEuczC0=;
        b=A0iD4mWAFplnSimIc6ikT7cqaH0gaRwfeEfXbDeIGNaaHlP4DPfXkdundzLIxj+FLK
         VN75pH1FZbGqCJDIg6rc5oGvRujpCPXF+nXwvfLToPY6hztU/sm5e9SzjvfZuTxiGo+4
         iej6mYPFC6ZcRbLEvgFSxqfXIxMhL9dZ8qp0plkjBVdEO8spZXRlM2NxDfxLQJWiBk74
         zgYKU/PJ03caqPFHCGuJbeQ9zPfpDGsV8JpSxi9WksTopDtX4ZKxSeLO/BUv0BEcLEUi
         BgwWgf+RnjWmo6HvFoIFZn9vPOWqU/0EgB+GcdBJjAg88bpszBoaZDQNw2jRJs6sQOjo
         kCXA==
X-Forwarded-Encrypted: i=1; AJvYcCXqWvoAAT31B+gd/i48wttEcgDaox5ZoG1aQrjcHZSIG3VT0FBiY8wFiPshWmOryBbeMVRirX4qva/B@vger.kernel.org
X-Gm-Message-State: AOJu0YxTEbSHJbbYSC0dpBIt5umjJg1AVaHANKn7aV5fMk32Gigppvu6
	w8ydEPg1wLNVi33aFrM9tZhb1m0bvWun5Gzxoowb4qnnxl1l/to+dSPtN5eGTfIEG2Byux5hgbO
	RxzaLLEqnqgC5gSJQE5h8uf2xN/2qHE0SLmNSFLUy15s/Mn+mb5dBGzRkrxk=
X-Received: by 2002:a05:600c:1548:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42bb01bfbfemr196097915e9.17.1725630726460;
        Fri, 06 Sep 2024 06:52:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbxix7jHuJHA8DA4R29fRPu2sTpju4N5w6eH7u3Etcr4F/LL0XbUco3ZYW316eqReHUvTwHA==
X-Received: by 2002:a05:600c:1548:b0:426:6876:83bb with SMTP id 5b1f17b1804b1-42bb01bfbfemr196097425e9.17.1725630725658;
        Fri, 06 Sep 2024 06:52:05 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm21412425e9.13.2024.09.06.06.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:52:05 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:52:03 +0200
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
Message-ID: <ZtsJAxqOaan8Adnz@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
 <ZtrpQzQYR1yylvi0@debian>
 <ZtsHf-TrqA0EWfoj@shredder.lan>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZtsHf-TrqA0EWfoj@shredder.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 06, 2024 at 04:45:35PM +0300, Ido Schimmel wrote:
> On Fri, Sep 06, 2024 at 01:36:35PM +0200, Guillaume Nault wrote:
> > On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> > > Unmask the upper DSCP bits when initializing an IPv4 flow key via
> > > ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> > > in the future we could perform the FIB lookup according to the full DSCP
> > > value.
> > > 
> > > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > > ---
> > >  net/ipv4/ip_tunnel.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> > > index 18964394d6bd..b632c128ecb7 100644
> > > --- a/net/ipv4/ip_tunnel.c
> > > +++ b/net/ipv4/ip_tunnel.c
> > > @@ -293,7 +293,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
> > >  
> > >  		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
> > >  				    iph->saddr, tunnel->parms.o_key,
> > > -				    RT_TOS(iph->tos), dev_net(dev),
> > > +				    iph->tos & INET_DSCP_MASK, dev_net(dev),
> > 
> > The net/inet_dscp.h header file is only included in patch 6, while it's
> > needed here in patch 5.
> 
> Thanks. Probably happened when I reordered the patches. However, it
> doesn't affect bisectability since the header is included via include/net/ip.h

Okay, no need for a v2 then.
I'll ack the remaining patches.

And thanks again for your work!


> > >  				    tunnel->parms.link, tunnel->fwmark, 0, 0);
> > >  		rt = ip_route_output_key(tunnel->net, &fl4);
> > >  
> > > -- 
> > > 2.46.0
> > > 
> > 
> 


