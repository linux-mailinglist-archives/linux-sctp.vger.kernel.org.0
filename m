Return-Path: <linux-sctp+bounces-253-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8096F637
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64C99B23C01
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FE61D015C;
	Fri,  6 Sep 2024 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBmMk1Ou"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69DA1CFEDC
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 14:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631475; cv=none; b=YiWflaAnAif04VAwef2FU5EBDS6ufSrf9SQS2u7y8YoeC/XJ2TzUEj8wlVJsnLfArFsMjmH53pRMdByX3y69eaSbwhFTDXNa63f3u+ARcjqed/OnRLE+jPByEkD9Yxg3iMhTvuUJhDwptxpG1xpz1l4lLzTPFvZ/dPsS4q5R4E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631475; c=relaxed/simple;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JunjZx/oMwtilFG/B5XEgCC+boN590gkJEvey/2+fWZ87EcKU+QAfOSmCgWW09qgnOm2K/X8oyhM3Xb3bKKdvt7e2YuWnCxkfPYQvgUqd5BM33Ua1IxMAreFjvQFs1a2vAfGGsOWAVRVthtfVyyWVoL9Z2u832djY5rTnmYJ9jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBmMk1Ou; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
	b=fBmMk1OuJKInELIhlpzCexJZGXO/kgxIv1qn0GmJz9MK8C8R+mjOOoOpqm4Vck/+VSPRSj
	vS6lz5yEZP+5A7cwmOFmKcJWwAblOXX1uCTZEhmK+R45T3ge2sSFrheseIvRHuYGElaB+y
	EC+6vWVQa7lg8x6yUwgyGBeYxomsumk=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-7NfwqFQlMMGpJrTh25NWaA-1; Fri, 06 Sep 2024 10:04:28 -0400
X-MC-Unique: 7NfwqFQlMMGpJrTh25NWaA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53654fd283bso1177589e87.3
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 07:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631467; x=1726236267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHFC+pt8F30hf4thaLXM7MllDwsBRp0xvNHzUpudAOw=;
        b=Cw3DRjZe7gu5AQVku0tZOryLqbLqgFSfbyS6ysnBUGZuDmHvDH1o778JeW1tEgN1YC
         7qjdyootSelDSQWI3uh4Snx8b/UUYr8rkwhx3IG+dQqy3lbOGUJysbtaz81F0vbGWHBp
         cPVgE417vB/uySx/yZa3tk1YqzRmw+cwffbOkz/t7vkJcURFmcxr02mie4CLcwOzz+ij
         BhLw0+3D76hyNZeD08sex3ksJE0tDEpJ/vl3VG3E0Yeow4WmWTbmeKwbWlLOACH0kUQ2
         dCyZ3WZ/Y4v0JBMZTCzSDitHrEk2C8TTqUJJ0v4lem/y8UJCgi+q58JmG7BTHjYwFXf5
         xoGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxCt79Kz8k5QC4oe4uWklNCeYDgY7PYS7EPHjqoQyI4hVOQBzTI4h5YxauxO7q6tbMfutTKo4YAJMD@vger.kernel.org
X-Gm-Message-State: AOJu0YymrTsDQ+0yDZKoQO4xzieP4iZ+qFFMyXogJUfxqOqpIdyti47t
	jfBAhsFZv7Dl1ifH7H2EaGBM2xz6BtQcxtjqI5+At4U5bbJROvg6dM8HoqILc2CF5LnrG8n2fP9
	8gQSdmW8srRIeRQxe7t9+CihihQ8Kqbdaawekql2JC0PAJ6VlI4GQZGo4pcA=
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676566e87.38.1725631467067;
        Fri, 06 Sep 2024 07:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKQ5/38TKV/Y2UqEsgT1myno6QGvAIBzgZWsQu6maWs8a2tVqrqi7GmjJ3p9IQvBhwQGLDzg==
X-Received: by 2002:a05:6512:224f:b0:533:d3e:16fe with SMTP id 2adb3069b0e04-536587fa8e4mr1676511e87.38.1725631466186;
        Fri, 06 Sep 2024 07:04:26 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cee8csm21366785e9.21.2024.09.06.07.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:04:25 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:04:23 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 07/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_xmit()
Message-ID: <ZtsL5+/aztO2HBuR@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-8-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-8-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:35PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


