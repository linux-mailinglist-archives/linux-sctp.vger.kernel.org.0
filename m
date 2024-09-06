Return-Path: <linux-sctp+bounces-247-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C1796F3EF
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96045B22162
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E8A1CC155;
	Fri,  6 Sep 2024 12:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCbbTZ4Y"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE80A1CBE9F
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624183; cv=none; b=DuupdY0jjFEuOXvC22gBYSmoEZp380EfH+jXpQ17GaptcGELlpuuUVLZ2BN0JpZ1CqTWin9PODB8QFHbes8JPb4/HiPqGeqIcrgWIN2IZpwZC+MTMcRbO3rhSeiTkEveN2GT6IiBCRNCYq1VyNdqROeGX6fxPJbuRU6tja8SUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624183; c=relaxed/simple;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IJWByBn0nWYiGnrjUVFwSj+mQbsxJRHaYUOs+0V/K/E+BqMSCoa9sGB81fmhw9z1/XV0QZEWqHEdEF+xeZl6E/qA3hou1IPN2WOIoFkTIUNceYJ4QCFJNOccPY4DHZij2YUBXYdSZvqqLc5dogpP3jpPRtGOdTMNu0/Hb9ilBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCbbTZ4Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725624180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
	b=cCbbTZ4Ypxqo5mGp+SjgEHdXAov3on4FYCa67PLCOq8NNDQLZYEPWrYjWOrtaIiP4VvtZy
	CXyRurLUNibPRU8z7erevNXQ1MdGNo9cX/JwF15MpqGtSRxWSEmhvfQGRJaG+riUmx/+D6
	FBKhjmRp7LU/XMAhYd5qn+9uP2VNqVI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-VG88QT0sPb2RBWY4hccWgg-1; Fri, 06 Sep 2024 08:02:59 -0400
X-MC-Unique: VG88QT0sPb2RBWY4hccWgg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bbd062ac1so15994125e9.0
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 05:02:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624178; x=1726228978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzxUx97+S6KIAnLwmxguKmEFLZ9yAdCsp/nWhUUS7FE=;
        b=u4S2XYW1/hbV13TlMyWxPeCCy3n7vxEmxY2sdayJ6tGNTOHrbqj+Tu0148EZGzhSO2
         zt20r1fEbYmpEMtrJc9Cd7RvrhRHZxVPkPj35lJKrZxlHilxxfZXpHMKA0g6Rnck3+kn
         GrR7ZS9YEWNgUF9j7X3Bhpnc94QUpBWYPX+6mJdaQ+W/ZaXXPx2ikOd5f0AwsCCPQZmR
         7ye81u/OZMJRkItPsk6BpKA6gWVmpmSNQlt/+ZmiLDdlIRIzGKCI/jK9Gp/iIEoNyWft
         aa1ERdy+90z2lTKc7aNAvnt2v9ztiGzV2jGIcmsh16Q6wbUuigigVo6kEfrC6lN/Td2A
         pdhg==
X-Forwarded-Encrypted: i=1; AJvYcCWE9MLcUsEi/vOYh72rSvjxpEz+0Cp4ctY0oATRNuyU5UqHxrVfnUEyS2Yq+SbfU+/8/hKv9aCDpYCx@vger.kernel.org
X-Gm-Message-State: AOJu0YzAPYMfNt+WPMza2dRdKbdDNfqy4KyW3w+SDfNDn+1RY5n5BU2l
	WzmuaKjlDIQML48taXYP7k4Ncvv7EZcbHvW8kMwUrnEuu/JtKHz4jy6udmouoYpboBU224HZIHm
	6h13hixIg15Fvm6D8lQ33W37/k4p+Z3ZFZuU5AqVhHpHyG4R7tVTZvbEfNUY=
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855325e9.24.1725624177991;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoI0DxPX/u6R3aYPAJ18qh/X+91B4iTbd+r7c0r2GHaqUyL4q8mSemuf8LpPqF1l3DBpiAhg==
X-Received: by 2002:a05:600c:4e8c:b0:426:6921:e3e5 with SMTP id 5b1f17b1804b1-42c9f9d6a97mr14855095e9.24.1725624177430;
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788dea8eabsm1004604f8f.114.2024.09.06.05.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:02:57 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:02:55 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 11/12] ipv4: udp_tunnel: Unmask upper DSCP bits
 in udp_tunnel_dst_lookup()
Message-ID: <Ztrvbx3qzXI2VCN8@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-12-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:39PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


