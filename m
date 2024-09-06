Return-Path: <linux-sctp+bounces-251-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA12C96F5DE
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 15:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A071284D76
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0D11CF2BE;
	Fri,  6 Sep 2024 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmElOzuE"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87491CBE8D
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 13:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630755; cv=none; b=s1mqSLIvwfWAvpl9g7uc8N5uI+YIHg4UFzanyiOxp5Qfb/iIxLib/PBQVF/GD7HSnDEiJZWwpG3mWJ4slSXYZxPSFx4CnTT+J+TH3hHR9xuEJscA3Q5FxKJc+9tce4yWrcwALZiMGNtOE9yIDJi+gM3K0xokJjQ93c5qk0k22Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630755; c=relaxed/simple;
	bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=QzBnxJpzDf+nJqthXwh80tPMk2ePT3ZpyKF6hDCAtDr8Ai2Wo4QEoafYZD3wKug2qXJDVW8+NNpCa04W1O0P7N26tLtAFSidfTAlRHWWXB9f3noqMzmns7xsUg4hyGLs3Bc7N8/I7sd8MlAHxP48CmR/jtjimR7WJFcaRhWxjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmElOzuE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725630752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
	b=YmElOzuEZIMloSvfZhWslakP/4yky66hoPwPq7PdYa+6L7T/rA6X6okGUr0jpgfQ6q1Yc8
	trm9GFlARDbWaF99ypIdBmqdZ9gvef0jE/K7lrkmWD3EtnzGnHgnQDvHujCpMs99GNx8tr
	tSdAZnh7N6THiOVY3CYZpgMlU5jhKMw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-OBrRRzTANg2twk7DcgbO0A-1; Fri, 06 Sep 2024 09:52:31 -0400
X-MC-Unique: OBrRRzTANg2twk7DcgbO0A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3771b6da3ceso1247495f8f.3
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 06:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725630750; x=1726235550;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q9aU6MLxmooh2pjhdIX2la9jDmWUIouSae2ZL0rKgsM=;
        b=tvwMM0f9lt9yHb8C5DBWlp2bmxCHMKD+Q3M3E1bCr+2gWlshs/HjxmDHl20shBMc5S
         gcn1RYk2naZOxWuOf1D7nZe8fC4UJ8Uy65og3GNN1pXEhBOOMytVj2L3HX6TkwAasMck
         mI8wX7jQoIoT1TWrQMKOMpKJ71ykKEloiTbLmDN/Xziy+z1AHYo3uUDtO1PsevKeZUKH
         X7ikKb+A7LxJoz4Ohqygsr5aJpdSD1zABN4JdmktFunlklBgMurfV8E7ZZB7IrSnk0wF
         rb0JWis2YmwNcZZdc6QmY9GvAgTFn9Vr/t+hyJZnPApS9NwWcrH5QtXhGQxzGtFoPJ/z
         Uocw==
X-Forwarded-Encrypted: i=1; AJvYcCVakTQoMVp5hFfV+jBDkxWQ8yK/bF5oT5NyrmhkbPINkgKfpAYIeKAoMxTXsigWIHru0x6gFeolpIwn@vger.kernel.org
X-Gm-Message-State: AOJu0Yynh88sUH6v2plJm/cSCPt7vl+VTgPYCPGX2ubdxIbJJxPRLem7
	UYiGD3CO/c0cT/DbMQkdLmodS33kqbFh/w1r/E71d0mIRBC35q2QK25Kh2bkr+trAC54i+bV1fd
	pB+GCOSaLVicqXciP2miSmva52ZPXBPeGVHFeeZJVud2HE2I+0sW5k84N+ZI=
X-Received: by 2002:a5d:5e04:0:b0:374:b5af:710c with SMTP id ffacd0b85a97d-374b5af7510mr12649952f8f.26.1725630750355;
        Fri, 06 Sep 2024 06:52:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7rIucSxMSJNCM9P3fVpLg+fca1j3lilFUPuCE9KWtPYnhwY3r2Fu3rHNI/1QZKG6cYsZRkg==
X-Received: by 2002:a5d:5e04:0:b0:374:b5af:710c with SMTP id ffacd0b85a97d-374b5af7510mr12649933f8f.26.1725630749848;
        Fri, 06 Sep 2024 06:52:29 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3788773ea3csm2131461f8f.54.2024.09.06.06.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:52:29 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:52:27 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 05/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_tunnel_bind_dev()
Message-ID: <ZtsJG3/3syyoQOCH@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-6-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-6-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:33PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


