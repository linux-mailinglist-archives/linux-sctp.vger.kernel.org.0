Return-Path: <linux-sctp+bounces-240-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B5A96F29E
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD901C20B39
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349F21CB333;
	Fri,  6 Sep 2024 11:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9IpqXIO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8C51C984F
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621413; cv=none; b=NpGoHj1zCndjwgzT+32ODx0W9bqJPbACWIs6TcUZA7xGdi0+qyZ1riDNh+ATwPWaHi6McFHulBvdMilRb6B5gwjhHsuHYyWTMGtIJU+dWkvxGwN5W/qg3wDM/Cj4FxEIhAz/D6Cfd4cpRCP58tpQ7E1aTG19Rp7l2fTSLMpEDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621413; c=relaxed/simple;
	bh=h7oWCjCNEzwxWkQ6zm+j3DwBqzjK9b+0icEOnxXwUl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=b3hpO6ufz7WeUgGm7XBzGk9iJVkXcG43BacyEddh24yGzXxg6VGTFCUomFZPGqM8xcC0F4qMO18TV5pEwBZ7lLU1g0sNlPEskuZsWlVnDsBTb0036C2Fo96Vuk0XsGZcHYP2wrj/sJyme8KUuK0VWGG8v52AmSouW4In838eQWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9IpqXIO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h7oWCjCNEzwxWkQ6zm+j3DwBqzjK9b+0icEOnxXwUl4=;
	b=P9IpqXIOYuPMear7iM/GeJVw+JsOv0jK+iYc2E8/WScE5VelG5B88eHP4LGN21kZGyZ/0S
	0t6GSwMNF5GUTcuucFC6ajmk3lsyBs/CwK9xiom914CNN/DiNwnXUrNX3OdgHKeSmUZDgh
	tEwOy3qdWvK41iM3+FtNYUqg53tpTOU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-XDXqSBm-PvOZ-ABUaS0U1w-1; Fri, 06 Sep 2024 07:16:49 -0400
X-MC-Unique: XDXqSBm-PvOZ-ABUaS0U1w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c301db60so1181264f8f.2
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621408; x=1726226208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7oWCjCNEzwxWkQ6zm+j3DwBqzjK9b+0icEOnxXwUl4=;
        b=IuGmyI33czS0saf38n5n34NhyxgItBYbldBUMUEyOXFOA/VU1V74niQtcCZ6yj6T7S
         f8EZoc2r854u9Xfld8WSjV4oZASEUrqDAvlyip+tmo0H+GOzC4EA5W97Y8A3AhKGiazn
         zMt13on1JwIt3Z1F1uiWkfS3R7RZty0asS4HiW9TBiKhzzQqHbZ35QIIuXc31TCvVXJ6
         sfLiksyC34OKxo9C3kjSYLwcvPMzvAtWvO/cdThcaO2nqF8PBAxC4yHj2vqAuAg9EHUC
         8xuPaNfp1xmk5nw6CyraKDokjzSRb0szpq/kufSK0yeZ5B2vzaWBrZ+WuKfDcn1YEKNo
         Lgkw==
X-Forwarded-Encrypted: i=1; AJvYcCUucLxw7o9rFjAQmKcJ8M804krw6n1kEwjSbYN0A6941/vgPYTJPdsuAbswDY3ipnMJHMzNJaXX+zFM@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3gask+ZNxCzMzzbU5OmFUIPf34YWA6F0ia1e5zFQB4YDd/r8
	p6taJ3pSYfDMSLmsu3qHiWiZXmeoOovaPdZf6l96kUj7GgCn+hGJx/hvheszv+DvUdaGgTUmNux
	4YRALI897QG5LajornOYCh2rruGfpyN1EmaizR4MY6QKYWluHDUIESllpNpE=
X-Received: by 2002:a05:6000:50d:b0:371:a70d:107e with SMTP id ffacd0b85a97d-3749b53169bmr20678058f8f.6.1725621408224;
        Fri, 06 Sep 2024 04:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPw/OgFFvEdcRZzS4cx+Sw6c3PFJDCcVrZn3G7jew1sCdpWo1/ODYEzc7WVrWFytZcY3xxPQ==
X-Received: by 2002:a05:6000:50d:b0:371:a70d:107e with SMTP id ffacd0b85a97d-3749b53169bmr20678030f8f.6.1725621407632;
        Fri, 06 Sep 2024 04:16:47 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4981asm21687261f8f.24.2024.09.06.04.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:16:47 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:16:45 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 02/12] ipv4: ip_gre: Unmask upper DSCP bits in
 ipgre_open()
Message-ID: <ZtrknS7zKAKP6g6l@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-3-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-3-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:30PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_gre() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


