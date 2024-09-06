Return-Path: <linux-sctp+bounces-242-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E396F2F0
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C5CB22DA4
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FAE1CB12E;
	Fri,  6 Sep 2024 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdDwZ68g"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305B1CB324
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621801; cv=none; b=WX72Nv3e4zoG1WDpWg+pyNvrqAxqRZVuHX749UZnrn8utbH9EpKjf4EHosxeaInERTdhHUWMuvzWEnCqcdq7B8/p358xL3Cu8nzZLC01vUleayKFLPwOKtJZk46e3EX243+sQ3M1RAL5cr9i1fpO4whz/WPjQngyP/6lOZSWhRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621801; c=relaxed/simple;
	bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dGMk7NU5M71w3C+qkViHwL+5yh7804KG/jgrwKrNYlBglVpbhTmSnk6bfHKzEuwTu121VBZGn85FJQFxEDCHiUHa08nHYGBEn+3iPpmPVspT7yPR/uABzD0xBITqkFvpRFCh7A5zpHCZxl4HU7vdp79sXRbzC+uUJhYwI/B93S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdDwZ68g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
	b=ZdDwZ68ghWos8n7ZWEbxjQJP9CUA9kxRWMS1aYjdI4ko2L/DRmE2O4EmrTOFESl5JyC95a
	WEMAWK6u4pUEmrVT4Wi1dt5dbuDl+AUyI+c4wweWHiX+xGIsY6Z4iX23zt/zfVjeI7GMkr
	1ODeRkQIgpTYpTIeYV9Kdj3rMhrTEpo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-_-d1D1XaM7anPY9CxXRlEQ-1; Fri, 06 Sep 2024 07:23:15 -0400
X-MC-Unique: _-d1D1XaM7anPY9CxXRlEQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bac946976so15484055e9.2
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:23:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621795; x=1726226595;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppjXtJ7gs7W9QUgkDi7uSrA4aZ6/Z9GMvpuugQHfWxc=;
        b=okKLLQHc4S2s3OhBUHg45vVMmsxIrrNvsjk5Fbesd39ytMjaWKIunZrIrfeDYuQcx7
         yKXxCJqYt94yT4BN8HOZsbXjZuANUVdXXAWLDAFB2eNuU3/+JgvUsFx4Nsv4r362aOw9
         SQb6PoAW/XYYLc8nkBNkEzMsvSyO8zNyyTuzLUNyrTmxCtgb/k+BIM8SRebMYEwzGBhH
         fb3iVaa6mHwnxtzQlqX1eWZ20dwYiHBbUt7Rrbbc/jmeXo6fpqYMjZc5xVSTCoqV1rIB
         KrBSJHbCTFVnr6ljbFNDYeKUu0zufdF3beRO/eCLAsQgiw6Draw9vc9yspBcfC2k6tjC
         tfJg==
X-Forwarded-Encrypted: i=1; AJvYcCXvTIMQzsNwu1JsFRsdhYmcbZDigGGuNdyNBvaXDay5N2abxuucE2rLwqsHt3uYpZz3yD0bRjN46kkd@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBKbOUeYFej0eXIKVOfl2EHRv7ugyvfUTrs11zfWG6IOhGPoQ
	wAWVM23lxjxiO/R4AzV0OUKjN3VQYkon3rV2nfvMQV7xo+8fi4DWwsp9+I3FfLgPDzMGIfOYJZL
	ChgVNLIzs2LOswZeGTUe/PCiTGtsyetVoy+rBO0E2XGLqNVbC0MJ0XtItOJ8=
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-42bb27a9eedmr205061675e9.29.1725621794775;
        Fri, 06 Sep 2024 04:23:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDWt5S+yLwjHr+CBf53VWDHiFksVfZtQBazKOXS3AJWWvyxr4Lz9xJ3DkOyXs6TcqBtg77Kw==
X-Received: by 2002:a05:600c:1914:b0:426:5e91:3920 with SMTP id 5b1f17b1804b1-42bb27a9eedmr205061375e9.29.1725621794156;
        Fri, 06 Sep 2024 04:23:14 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05f847fsm17687305e9.41.2024.09.06.04.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:23:12 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:23:10 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 04/12] ipv4: icmp: Unmask upper DSCP bits in
 icmp_reply()
Message-ID: <ZtrmHrAC40k4hpxe@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-5-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-5-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:32PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


