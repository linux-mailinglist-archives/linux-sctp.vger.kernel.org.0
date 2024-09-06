Return-Path: <linux-sctp+bounces-239-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAAA96F28C
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B611F24B20
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE43B1CB31D;
	Fri,  6 Sep 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COUiHW8E"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C561CB14B
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621310; cv=none; b=BLspPIOJzCmoA1/LfDq+vmsy99HAJY69jJJjm3a/gGDYUyKfSq0EKvms3sGGEs4+jRzbRfwgclSwcu7fQuK4yTr/zUu2igG3DUf02fSTEGbVcLncItVmIrQKLvJ1TRb0rNitqQxnxkbVBSsZ3SETUMntkSGuFYNth/NEAZtQgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621310; c=relaxed/simple;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JfkatikOIJSMxwfRp+aZbPVaea7GE7hCqvlArG7wpJ9ZhkViZYTPp3lnyY1YA6Y5IM+Cs2mAcU2OMB6P94wX+x3CeAJaCV9ThdlPWkVkNlKCzSIrhPjiEhVo/BIzPW+aKRzlJo1rymFoocEN2CysgJrCZBc/Rq5KEWJ9ELldcLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COUiHW8E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	b=COUiHW8EvBM6PoV4HjoARUgXVCG8XhghMBYGkt0r0nkt/WuKC5Q3CTlQyr+RCtHgcbjBgY
	ZtfR4o1fq1mzsM8cOEusxr2Hnb07KxNSGoM/kMZ5zzcNRa8JSwMVvYdMWJKfNyAC/fDtDm
	i0MaVoPHx7tkih33Xod+z8+RYIglaDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-33ST1S52MTqnBcicJSuabQ-1; Fri, 06 Sep 2024 07:15:06 -0400
X-MC-Unique: 33ST1S52MTqnBcicJSuabQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb9fa67d7so19345225e9.0
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621305; x=1726226105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
        b=l9Y0y17Dp9t+KE/KOQxFkt4XaoJioLR6PH2rZ2HnqV68oxvLqQpG31buyaVtj37NwZ
         4NvqG4GB1aGs1EY4F2k4h8gQaU3wO4hdCYS4MzhOIgxy/HtF8JuPmlL1lZE8hPXeh0Ao
         T52Uo3aAlJmraFAjFAjYnDsZ/srP3jp5Ts2X4JTMd8ZKZyZMeMYzVTTftNSY2fGwwoMf
         wHrUcQy2NM6MvFykj/+WmlkqoVpgzhGp8aCrLqarTwH6+R54PsEaWhzyTQwFtSmUonRw
         GdPcX5Uahm5F9e5HpFFTXe/fDB23UwYj+MZvQyRE0a7xkLz3rIu95uU4sF84Ubpq8VX+
         PtWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX87eXlLy8X5EsIuDodGy2F3VJkNPZHgltvCf5y2lj1ZAgb4YHdrQWULR0ko6Gi6K54YIPpBtWx4N4P@vger.kernel.org
X-Gm-Message-State: AOJu0YzufJMZ014p8qPF1XRbjJBD8Z3Srn1LiUYBmj+4muO+WkWd+PWk
	1z/VKhIMV84Hfiip0uUExUHwQ3ekOG9yr7aRlChQpr0Kcxla5rDuEi6PlqF99jWjV5ilpKHi96V
	O/o+cYOVTvtFHYHM4HWbUL9ZSz1/f0AeA+VFmMdBsfnB4Us4cQDvHjCq+J3s=
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16075975e9.18.1725621304840;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7vCxT8H4VqHEs2N44xCaNM+DluDvFbOAReI6BECcPwvJ8SnS7DtqOd/aYseydN9zLNtq3KA==
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16075695e9.18.1725621304232;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca8cebd35sm660405e9.0.2024.09.06.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:15:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:15:01 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] netfilter: br_netfilter: Unmask upper
 DSCP bits in br_nf_pre_routing_finish()
Message-ID: <ZtrkNbZcjQrUmdcC@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-2-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:29PM +0300, Ido Schimmel wrote:
> Unmask upper DSCP bits when calling ip_route_output() so that in the
> future it could perform the FIB lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


