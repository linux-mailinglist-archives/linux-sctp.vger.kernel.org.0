Return-Path: <linux-sctp+bounces-246-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C833696F3E1
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B3A1F20EE5
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 11:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A81CC155;
	Fri,  6 Sep 2024 11:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBsrkHWs"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7451CBE9A
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623963; cv=none; b=SD4Ct3Rd+WNghLfWenEs9wvnJsUID/siUjuhlCXucpFKNU+/z5OECWEvijWUM4U4ceW61NvWGSC4AJvFp4VBtBHGmTbnmQ0y8DkS/HBHdKRD5m20x6PcQfOaa37hgDxbuWDg4VPL03FyS5u45DTAldtdrD/CJCiE2IDeq4UrcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623963; c=relaxed/simple;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NwEO4joR/WIlKZvvZXwxZ5izKiRKddr/Z5qTZmeWCrkwLZEdj/OfCW6PbeGu98y2SsfgwkWzUZKceb9oJJndOdEv5Le6ADYqDbdO0bG6eOXDG8rZeXPBI/ZwkFOj+n4iPcPqM6Q5CUE0rq2/PjTslhCsplv/glx7D/PK0uF4wDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBsrkHWs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725623959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
	b=SBsrkHWsCOGQlxVhPyMHDXDGZ8kiTK+eG9zgYRAZXXz0bCx4IrEeFsvhKczPqYMgucRjZ2
	EhX8ElLzOdBVo81C/+uHUHtwe7I0gEiSZ2gxA1vLeopYlvKOtX2Wnpdv/hQWlNV1fl3bIu
	r2THp5EqKARhUDSNvqMFJURm1cr1E9k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-aYXs0o_aNUePN_RavvhNlA-1; Fri, 06 Sep 2024 07:59:18 -0400
X-MC-Unique: aYXs0o_aNUePN_RavvhNlA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42ba94a0555so15643615e9.0
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 04:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623957; x=1726228757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G0nIhs1bi5zMGUov/GDdwukKR4YYpCSt5fRVl7zUl8=;
        b=UAPi48ECBaAkdocTKhsx1BbEPLu3yzXOnLBOg2TMI/V4t7XHKNhvkVN2SQtonO5873
         e3TSuEg+CaNsl1NirJqDUlslVXuS/G8sGUSMXWJ8G2PEZgN+d9+FZC9QAiQd91oPZDgU
         7hBPK9rd7f5EW9LfGOZyB+RAJAjwd0wGmYa6Awz1jIXXzOapkXgHtyF8pOll3H6Na38v
         2PZR0ijKhnhHvSr/5+1tQA57l6Z8I6ugmcJ1NfTgAEdnyzYhYBNsWvglHGgd8BKILx91
         4izTD5upCnPIXBagx0i+uo8JdTH5sbKd0tSbV3JDhah+qu5dQtwCd4xlNczmhvISkWD1
         PvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVthU5t4r1o2+gXJiWYM9rmlx3OpeEjZMYXSQxxai4RU5ZA5yq5wtSeSYKX++bGDlqKEuJdFxwc8aun@vger.kernel.org
X-Gm-Message-State: AOJu0YygGyEsegeQEADSqr7oOvMocyvv4hXxIZBTVy1Sv6OW20r1AGod
	+02p9ACzjEjYUgpTlLoHULm5uMK3YtSfoyUcTt/f0FIsWBHUM/8yoXm1nE/T/TYpE75cg3iFh/J
	3bzzp4sj8Fe0S+Z2xoUBi5BnVQRNOn6jD+GFiy9XwenKmZ0m5yM254pQYnBc=
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589835e9.29.1725623957340;
        Fri, 06 Sep 2024 04:59:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYA3WJyXIhIIDEVufGNxXIOM6KJ1IZ7nsonG5drAh9teOtbcCOcgYplQPKS/qfufalrdR4OA==
X-Received: by 2002:a05:600c:3c88:b0:428:eb6:2e73 with SMTP id 5b1f17b1804b1-42c9f9e0d14mr18589465e9.29.1725623956763;
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d351bsm18481815e9.30.2024.09.06.04.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:59:16 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:59:14 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] netfilter: nf_dup4: Unmask upper DSCP
 bits in nf_dup_ipv4_route()
Message-ID: <ZtruknlefVpreVRQ@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-11-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-11-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:38PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


