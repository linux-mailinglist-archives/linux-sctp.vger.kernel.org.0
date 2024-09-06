Return-Path: <linux-sctp+bounces-244-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AFE96F337
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DFC289BC1
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617481CB338;
	Fri,  6 Sep 2024 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOE9rRHz"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8E1CB328
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725622724; cv=none; b=IJhX1fzmGEO3BdZjnCXiB91zxUTKz+qwAXE/1g9dZ0KEddktMwjv48xinzWri6vmAGQSt+HnvwzINl1OMFx262Y4LhLQLCHlHTty3UCPYf0ebrEMb7MP/0q5tjCsIoS3gJf1EJd+AJ5qCDI9CknYvXzgt6vt5uuYQpxYk8e8Djg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725622724; c=relaxed/simple;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=PYUrb86PiqcbS2z/YheUynX41b9TimBb6/1v3RJdrkvOlJzn58SfvVUpufKMBFP23pTEuEPW0EXC/jNh8hIMKCLcA4SvBSgOsKyugqBjc2Nni0zvPITe9jw7ZGnrm7hO1Lo3rSzTJoHvioHFSIP8gAx9E8Mgd94uuqx56i/U8GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOE9rRHz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725622722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
	b=VOE9rRHz4ROsiiUOCIWpi6JMpg1fJQo0nYtIyvHxIufl7on86URuGRBK+IOwFaqf+OtuQa
	fDb3WR0dKsQKG53cG8OJffN2MQow/z8agXKSjHkgIpf9Z0m9K0ivbFZs/uBJ0mELfvQpTm
	ARe88bFmumyOVLpJEyjDeSx35Wap4zs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-rz46BFANOFSTqMbtC7SwsA-1; Fri, 06 Sep 2024 07:38:40 -0400
X-MC-Unique: rz46BFANOFSTqMbtC7SwsA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42c78767b90so15419015e9.1
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725622719; x=1726227519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OSEMPeLSNHVCNVbKv7RAO1iD4GGzvlj38LVpMDyE9k=;
        b=ZlL6JJojzdS/WAIN6LA+A4/KZTGOaoKDfwWB1l9AlKrNpkg3r4KnjhkyIJcjyzsFzV
         wN/2LF5w8Qq02ofZfBwIdoaJeAcFpY1rVKWFW5wwJVTlJulvpUd4wWn4RxDhp+jZ8pKG
         1Ce7nie3AgKOKoGQiSTWlVdp+QOQXNq/O+FZUqo4whI3dpYpjn5S2vnwIbYsDCeSfXz7
         qyZG3kKDDbkBRWTDRNkpOje7TyoQ0dzkZ8Ylkz4nrlyhEwKDiAFxHPdh8nZ0/tsEh6Uw
         NPu94Yx1LC02NdkjMs8Eb1j7S8KOrmdk7ZMFHMYhKvomIu0VgFYJ5vXYC6x6y7Hpp+DN
         23sw==
X-Forwarded-Encrypted: i=1; AJvYcCUDSsBYzIPjH7qlb+GTJWRLwGn3k52DV7+AYUyp9FOiaUdAIqXrffEMiYS6cUzDfP7yWIMD4KWpqJif@vger.kernel.org
X-Gm-Message-State: AOJu0Yynm5e7p5CjonlxdqWbgc6w5sC+DsKuhovNWo8tzqs5smf1Uf6y
	bmTyzpSF+7g4rKolTbws86/fK1cwovVl/KPqBsWxu/7DQBZOmp6KTqCSC04g+Bw4HwzVWg2a7uG
	Ep5eI78tmt3gGAuWtnVroBbhjA7MeL8z3MnEUbeG+pcuOVN+0A5icKqa+JQc=
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302965e9.25.1725622719310;
        Fri, 06 Sep 2024 04:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuAsg7pwxpDVtdYJ/6+D+Ph/FNa76MdgLyOilEwQ/89LMv1D0nMU3M5+amZnhf14vF76nDJg==
X-Received: by 2002:a05:600c:1c1b:b0:426:641f:25e2 with SMTP id 5b1f17b1804b1-42c9f9d7035mr18302555e9.25.1725622718460;
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05cc3dbsm17708455e9.20.2024.09.06.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:38:38 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:38:36 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] ipv4: netfilter: Unmask upper DSCP bits
 in ip_route_me_harder()
Message-ID: <ZtrpvGliOjZzPkyv@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-9-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-9-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:36PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


