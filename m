Return-Path: <linux-sctp+bounces-241-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06796F2C9
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2471C21385
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDD81C9EC2;
	Fri,  6 Sep 2024 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYcw5Jv8"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82AA1CB12E
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621670; cv=none; b=u6/BubqSPsxoUYMI0yZQuMF5usJQUxCMUKXyfB82RK7/ZXLkiu7yq7QkpOnUwzXXsaakA4nL/jnjGSs32jPesMgqTz3m+pUJ3WNT47F7aLb1exsiV+p4yHX6nKHUOyaNQhvF/9TJvblm9YGeO8uDH5bNeclOEDyefDMItaTXAXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621670; c=relaxed/simple;
	bh=XM5romIm4KxJKc2Cm0Xo4inyO+ieNM4r8IJYwcGNYzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UDHdvfYYUPVWyAGJWGf8OP53DQDjKb4zaBw36zvGwpLPn9mo/AU+xM0sZfOyoX626boLo3XOTl7cQmdxR4c5MG0aIKsuG/Cbie2NUbxuu6OKdVr1cdvgysNZeHYBWU2alg2Sd5Xh7bg0Xr3TshxzQrYlgNoSWfx8RtEXwcABVbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYcw5Jv8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XM5romIm4KxJKc2Cm0Xo4inyO+ieNM4r8IJYwcGNYzU=;
	b=CYcw5Jv8BDvU98HiCNiY7to0v1mR5i3UC69SUWW/Q5ehBuvWWpsQSyr8Xj3PBn0bTWVNyi
	iANQgd012t4kzXxd0XKiR3UwYMLTCGJXG/KgW9KUGiC7JXNiIwANvskcLpW74XvFuCIgT5
	almXTJz9J4BXNGYImIy39A30buJ5KJw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ww643PHUMvq0fB-7RcHD6Q-1; Fri, 06 Sep 2024 07:21:06 -0400
X-MC-Unique: ww643PHUMvq0fB-7RcHD6Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb2899d57so15260125e9.3
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621666; x=1726226466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM5romIm4KxJKc2Cm0Xo4inyO+ieNM4r8IJYwcGNYzU=;
        b=EyLNtxnMK/L8FmyuL14xFFOAcTaD9BQm1cEkDYuStZ5tfqTbHBs4lA/1ETpB0kGtAb
         wbnYS2vdgeXIs+RNmoY91ZF/OrgKu26uJOLn8iIDF+4tIqK2cFwsuKdof2YLPeqyzrkj
         3AS3OHhef3r18E2B07+M0zgjWVsA034IC1eGVMQUHLCon4s/uH0hp2JCCj5+1FenLTNQ
         5767PlNRXFLlUtz2EUvA1cNAifFJgm9LxhSwGpLWvpN0ZEgnPOXxmJdW6n6LLn21oQXI
         Lg81zTcatWaRQ6mJbLxRA/HehgollTWd82EbhnOrZJ+EHIDsgjqgx13P4E/SXG78leqC
         r8Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXFwUkBZoiJ6cNsaKgohAVWd6drghyzjXf37xhtpL/wk4aeBqwX8JQBZDKjfypvHvqZuLtFnt3GXQSZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2Qxu8orl/drk6RjzolvR/gpsDnXexP5qmS7qodOAzCjAfisT
	ZVT/GcpKg/eoMm33REqK0aBR1lKCYuADTaipmWzSMfP5MrSpQQGLbFgzwmOvWdhxCbO5Jik4yuv
	0orL1QIwIs3SJx8oCv1lUIMFu4dFjIF1uifvL7uUxcVET/ciEqNtDH8PX0Io=
X-Received: by 2002:a05:600c:5103:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-42c9f9d65cbmr16318185e9.28.1725621665631;
        Fri, 06 Sep 2024 04:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE93E9q/W6NuTuOA8k3tsvdqWAFnV+g/TGFfrApNmc8vSoM76gleN9ntAIhvsJ+eJLqfOgoMQ==
X-Received: by 2002:a05:600c:5103:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-42c9f9d65cbmr16317795e9.28.1725621664988;
        Fri, 06 Sep 2024 04:21:04 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca0606e9dsm17561175e9.45.2024.09.06.04.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:21:04 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:21:02 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 03/12] bpf: lwtunnel: Unmask upper DSCP bits in
 bpf_lwt_xmit_reroute()
Message-ID: <ZtrlnguvBN+BJpFc@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-4-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-4-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:31PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


