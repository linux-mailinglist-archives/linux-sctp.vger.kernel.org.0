Return-Path: <linux-sctp+bounces-252-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A856E96F622
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 16:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25654B21D62
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6EE13AA38;
	Fri,  6 Sep 2024 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMv/IHBp"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E61CBE8D
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631299; cv=none; b=FG4l1wMdBXd7vvF8rY4xpNIQQbr9/PbNtR718ZsHYlm+Gu/a5gj6olssCWj5ECJ3AaJH6pDPVkegtz1G5bnuikPCX2C9pe8r1C6tXO7zYpkG9e2ixeASN1nzNp3biSkLn20qFBnEHTUlejKByCDI8cngz6W+RqYprc/iDjnKhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631299; c=relaxed/simple;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QeSRg1C0BKf67MrI9fCEhzTZl5eNFAtc2Mx0K5dvxRb3QgCP9l3Ial4epgFk13WgIAxRBgOVdyJDTV1R+DT5w4IhbfNQ9zselVc/caYYMomD4boRx0eWDexqIwa040+wsS6KuvqJYuUltYWhoDHnQGDVPfUk4aJGxrMuhyphzgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMv/IHBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	b=MMv/IHBp0+sgtSayIpCeaSYj22+gNT2RidcllNXg9f80LxaJaOhCwHomwR8AxHvhEK2//O
	ebD89rpgS/D8FlbGoEEuO1QQb3RNRqwRuU9zqoySOD10WT1v9TH06K1tYhl8yfc3ORVw7Y
	ShVBdtlPVJdEyjUzMJzFCrTZa5z2CoU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-WGHec39EPpWqBe_t7ml3FQ-1; Fri, 06 Sep 2024 10:01:36 -0400
X-MC-Unique: WGHec39EPpWqBe_t7ml3FQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-535682ab6e9so1976024e87.1
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 07:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631294; x=1726236094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
        b=JC9bUu1qqE3gznSAWIQGvhWqOVwM5L+4So0o39/tjaqV63rzOvMCxo9pk+ByjIWYIG
         4ZK7eY/y+e9gSiCn0B5isjoZSzB2bOuYZdavuojcg/Fmi32/gGueSm6ChJzW6mqVLQFF
         1bjOiT/QtlcVZ/EPdGFO+T5hOl9FddtpUcOtAQAzYwRmGlhC+VarV9O29T+lWKkpdKUN
         G7+UKEDTRiTVbNiQQtUvtHTu/kA6ByCb3HESrU0EcLQXg0kgv43f1DapMRRNIBmc7HHR
         6xT+bSwyfCKQJ1hp5SjwFO5j1MaGOShU1Ay197LkE5H+tJNfkL7AxBz5W1G9GbXlnsRV
         g+5w==
X-Forwarded-Encrypted: i=1; AJvYcCXls4SjZXvzd961emjm8z4eJoM/qFx4JAXWoyUMOFhdZxAgvLKRpMVYooLgVpZWHQlInC6tn071Yv75@vger.kernel.org
X-Gm-Message-State: AOJu0YwOxeohUKFZ9tBu61Ld8g84gnO1plRMurTfq0DCcANaIl06BUGh
	5GFH3UGhGHDenhDWFqAiHs/DWROQBMCTI99Y1cLA+GpesrJ/Jsa+hg7EJ+J3SAce13RMo0G5lMJ
	eHxKq96QfwMXdq2Z9FpL0SmUPd3lipgGyBxO6de7AhRkAe837nBMn5vkQFiI=
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730160e87.50.1725631294282;
        Fri, 06 Sep 2024 07:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESh5ryxYIDRtv0PMqngwp2r/5lvvEI+2l0OS3wHQLQGUs23BzE3eAyNjglC8gFpKq8yS+EfQ==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730009e87.50.1725631291471;
        Fri, 06 Sep 2024 07:01:31 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm21647655e9.13.2024.09.06.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:01:30 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:01:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_md_tunnel_xmit()
Message-ID: <ZtsLOBY/jZi7rrvT@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-7-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:34PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


