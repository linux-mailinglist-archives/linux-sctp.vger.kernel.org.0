Return-Path: <linux-sctp+bounces-248-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B00696F3F9
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 14:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB08228686D
	for <lists+linux-sctp@lfdr.de>; Fri,  6 Sep 2024 12:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B92233B;
	Fri,  6 Sep 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZqdgOBs"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368AD1CBE9A
	for <linux-sctp@vger.kernel.org>; Fri,  6 Sep 2024 12:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624299; cv=none; b=IdoZtqQ6m3f9n1hj6kFJCQNetKTbmCQgIcWHVCRrpUtL16LFYP4v11sF9doHqNgWoATNk/n8ifCd4JQmWGDya1AltAVE983WKQleukVf9/Tjw3Fg/G/ECEXcWO5ZhZDYVNT2+WjkArTMlL/Ii3cjQQyZSqhiKJV5fGHRund31N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624299; c=relaxed/simple;
	bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gxR7lVrDroKhljv8/qFZjETMX1wjpgGYHp6xqKPNrlohf2HqSulE/tM2IXgveVoXlJId1XEXLbETj3gKJWyoEl5673M9A4n0cUv/THAM4tjN9l9s4TBUkIZO6SOhE5i0mHu+umQOnjHAIUTMFzdq8H5U1PWUE0vuBMRPLZAroxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZqdgOBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725624297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
	b=eZqdgOBsO+QSQzGPy1MC8F+My2DdP020oYUbJCUlHfM4pgwcv7JIBECCvtFQJzi9o3pjTC
	0bfbE9EJ4Yh11Mvj74kIsiotAOjn6ciZSWKhXTykv2JwlNcc8qtGj/jfpiQmS1YKUKEGxq
	e6rGagNcD2d/yB/4h8vlwVNOYemLBJ4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-d2fF4rLAOYyO3_OMQYhyiA-1; Fri, 06 Sep 2024 08:04:56 -0400
X-MC-Unique: d2fF4rLAOYyO3_OMQYhyiA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374c35b8e38so1032279f8f.2
        for <linux-sctp@vger.kernel.org>; Fri, 06 Sep 2024 05:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624295; x=1726229095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tc07zvGyCiSLPaYrP+kQC7S675jJOEsGznL3PVrjuoA=;
        b=PIA+vsa6OiPH9CC5TSOr8mfPiuQR8bLr3WHLqMlYG0+YOVF3Guxpsn9NN55EP37s9u
         gDur5YnGJNDJ6BlMwc0G4r6z/cKWPovZJeW1+TCqCwbbWSg5fmKR/Rw48rs5pEDcD/Bi
         k2iwb5p8Py16xgt+qMQ17FlMSmXjRXTynQ+YP4HWzrhh/mkAHHyJCXmMP7i7u2/+lxus
         B8r/3LE0IeyuK0LWSz7rKbdeQRjC08tyvwMZfdtZ92XhxmN/kJwG6WNJ3W2UHwEFeFrw
         NeAIB/gJem1mF2NnMI7f8jcbl150hIKNfXlTq/yYNebBqvACY7i8eNCTzmIBrtClxi7s
         EJww==
X-Forwarded-Encrypted: i=1; AJvYcCX0peEzJg3KglSa+tjEmybr+aDLpnozsJ8bybqFOc86XNsY2cjlka9w14QDYTDRf2vXhX+GqHgCB3ae@vger.kernel.org
X-Gm-Message-State: AOJu0YxcNuF3mhYa74mjXTNaORVwhtMj/u1Y6r6OioSLDTH4RWtMm1Xa
	oh3W7gmKeFrCSQebwF8jEfj2xblL7TsIhybyFBDXAAEI8kYgxkTsTBKOecclYHWvwgmmO7k8zMU
	cDP6X6Sja+LQcz5thEKbihksU6yEyG9RTZJ12TBFC0LTayplVlrfINtHJYro=
X-Received: by 2002:adf:f488:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-378896a3f30mr1662841f8f.46.1725624294908;
        Fri, 06 Sep 2024 05:04:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbR87w40KjGE1b97gvsYds4sMcM1bBpW/FoDG702Xq5HctTZU+3n1iB0oeDTTrGblPjEdGcw==
X-Received: by 2002:adf:f488:0:b0:374:bde6:bff5 with SMTP id ffacd0b85a97d-378896a3f30mr1662799f8f.46.1725624294075;
        Fri, 06 Sep 2024 05:04:54 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374bde83ebdsm16914774f8f.48.2024.09.06.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:04:53 -0700 (PDT)
Date: Fri, 6 Sep 2024 14:04:51 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] sctp: Unmask upper DSCP bits in
 sctp_v4_get_dst()
Message-ID: <Ztrv43ZxmgQRW+Po@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-13-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240905165140.3105140-13-idosch@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2024 at 07:51:40PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when calling ip_route_output_key() so that in
> the future it could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


