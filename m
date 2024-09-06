Return-Path: <linux-sctp+bounces-245-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D090896F3D7
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F1CAB22292
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F81CBEA1;
	Fri,  6 Sep 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoX4tc6j"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11931CBE80
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623886; cv=none; b=GvxjtNtIklmv/4cC5eXTMm5U9wvrwH2bZHLzjZ3a7JZi44FpcLgaEZVoLy6gW1sUJXVyW6+CXrkPUVTK+o/bzmSwA8b4RJxpxCeJHCZ11HjLwQuV7BViBy54LiaCYtvoEow/EOTpAB4+JRdWtVzPaVMG5ldRU4MIbR7ftFA78bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623886; c=relaxed/simple;
	bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=q+6W9b65Tr87ICJzmzERefMCCDaZFums/2fPcZJCiYwDwMa6hMgHoVnnEgWjNfIUczaSMj01tbbCBVrnOwonrUFISQdnhVQeuG9dleMJw8AFX8blJHWWe3cUuEXJerseyRlpSXOaEqrAPwH4QRu8nP13Pn/sNI4Xi35cfFdq55s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoX4tc6j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
	b=DoX4tc6jNvq1Z3TvK5Aw585LPe3zWgvlgPgSUy315GKI+fUNeD6Vuih0/eKdaIJSNvdpT9
	g7ROwvCgpFT12oLqg3gokVnupB5rcEdAQTJiYm3kQnmB1iMAMr1WHPrbBc2gEQ0wd/JGGy
	P8FdwL+HKGcGjEIn8Jsui5PNG8Xz7os=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-yzGKfhJmMROpet2Ngr2WFA-1; Fri, 06 Sep 2024 07:58:02 -0400
X-MC-Unique: yzGKfhJmMROpet2Ngr2WFA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42ca8037d9aso1390135e9.3
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623881; x=1726228681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwhd6YSUYn0QtaTSPyGtnWCa/URckQRSKwJmnGcYxmQ=;
        b=GimBgWLZJ+NSv4wH4bvA6OiawxKZ9u9tDNIRodzvjYhWiaTZ2ukAy1CTVUs5ZNmMHm
         v2W5zrvB99YmUBQfoVZKL8cTBVp1gqARMAJ2njfXWW25OITvlcWBNyJ/3csa68/617AN
         tl3Tn7ua6+Ct8y2qv9JfOFgP0wD3gnHLc7eWW0xZ+vGjRdnhcvq2xgjPwVq71Nv6usYN
         dYLeJiM5KAUZ0X3vOuaCohQ8RK+d/Enaoi+iVLfCcZ2Uwyz4aqRsQepURERpUu2q+VN/
         mlNsfcwtW+WlWjJ/JKeY5bh1NNCFPnF7sH79akq8GPOOqbBpLkxF7YQ99E4MIfSk2Tli
         O3Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUUC8ZgebFrutJUk2XsigjqPJBCnVo++amL+7ovWwcbOjt7oyQCxWeuuopZLWsRoALfwYo9b8JLC38c@vger.kernel.org
X-Gm-Message-State: AOJu0Yz634QrS6uihA+jUOM4Z724Z1jXvoPf2HYCUlXZSCIqAoJhMCcL
	EfZP64U+MYuENp1IzkcxhitcCN/s5xdgqqf+hAHqenqm9tMPoOOW38G41qvjuoPqHKNBkSean69
	Ov3U2Mm0JTHCXoog9ZLF8yQ9sFy7eoonw7pCsO6oA3tAopfo35ay0iXWkItI=
X-Received: by 2002:a05:600c:1911:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-42c9f9d2fb3mr17165755e9.26.1725623881173;
        Fri, 06 Sep 2024 04:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyiezqnLnx60jEifhUTR30wzAxyOM3WxR1xMKMuwhfruZ0dS+mmwcm4hHOxDzegTtb9NCsoQ==
X-Received: by 2002:a05:600c:1911:b0:426:5c9b:dee6 with SMTP id 5b1f17b1804b1-42c9f9d2fb3mr17165555e9.26.1725623880591;
        Fri, 06 Sep 2024 04:58:00 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42c9bb7d3c6sm31634815e9.1.2024.09.06.04.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:58:00 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:57:58 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 09/12] netfilter: nft_flow_offload: Unmask upper
 DSCP bits in nft_flow_route()
Message-ID: <ZtruRrAazfhcwHJs@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-10-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-10-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:37PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling nf_route() which eventually
> calls ip_route_output_key() so that in the future it could perform the
> FIB lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


