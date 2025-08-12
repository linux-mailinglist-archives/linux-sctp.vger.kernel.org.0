Return-Path: <linux-sctp+bounces-601-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74089B2251B
	for <lists+linux-sctp@lfdr.de>; Tue, 12 Aug 2025 12:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44156621E9A
	for <lists+linux-sctp@lfdr.de>; Tue, 12 Aug 2025 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208C52ECD0C;
	Tue, 12 Aug 2025 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XchxYteU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE02ECD17
	for <linux-sctp@vger.kernel.org>; Tue, 12 Aug 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996329; cv=none; b=EUeXnJU5pW4tMSPy4ncjq+kboaFMMUxRireuF7nr8XY0bmwgXModVkcVARmLO8dDTsSzcVfV8Dcw+dQbIXAZhhaEOkYe6Cnw1kIzPs3Kjzveq+sAyEauCezxbBRtCu8/G6wudwu523RfoH0+elFrQcCfaRApRHjcRio0bkPoIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996329; c=relaxed/simple;
	bh=fssQde/Sg8azgjf1FtigOZjekJrxBQbwIuZUbk7COJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xy5/KxziYedp+i/+QTLKSSYJ2wAYPvuUm33znMLSZaAqlOVJn2hPfmILPb7ySDO0MBcA/XEahc7YAiVdJwx/cjZl5jSk9ZFL6NjTB08Z7xkTV7mkaNk+Z+KB0ZsPtTvBdLOqPt2/veKFje5G8aMbQQloSBwjSznYPzvQEWy28dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XchxYteU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754996326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9uA+Q/KvY4vhq9ltJK62pRXDrRMxTY6bCYM1WQ37m8=;
	b=XchxYteUySvqWUwLdjR0bcSAkE33Fs+L8CW3gJfrTtIxgLPWsJSWvNU/mfJukEHTqQxIwh
	WP/PhDG50CfWlnJPiHvW1herB10V5ZWvhrZ+lyQO9W/VW+gAJMWgI4NrINqEG701gdOUs6
	sWNdxdL9Y6QUqgIIqRpCBrkeU6lxaqk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-3mOx7WuSPfCz_ho5XQC6Jg-1; Tue, 12 Aug 2025 06:58:45 -0400
X-MC-Unique: 3mOx7WuSPfCz_ho5XQC6Jg-1
X-Mimecast-MFC-AGG-ID: 3mOx7WuSPfCz_ho5XQC6Jg_1754996324
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e69b0ec62cso1066826285a.3
        for <linux-sctp@vger.kernel.org>; Tue, 12 Aug 2025 03:58:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754996324; x=1755601124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9uA+Q/KvY4vhq9ltJK62pRXDrRMxTY6bCYM1WQ37m8=;
        b=e2SN5POL5WeDcczLclOaYGhXsxgdPXoqgRdtCxyUTK3To+12Ka/YwjhkQ8lxytb4lz
         9tPn7LTm9jIHqpVCgtGMqxBwncAzRzWvno5XIY6cbjrqEO2WcNoy+OxPoBZwv1Ptexvp
         jdoqxogX4hxMd6bGpNtYhgtr1XyLwExqX6dmIn11/dE64yDoPascWJ3eTGGBJXppwKte
         oHHv9NiRewnkUC0mZ3cp3UmhJK7Xusx+Ascv1s9m/Gh272Bk7LATZ1NyYoNC63Aqtg4v
         JbWkG4XFDVt3fdpJuXuUnJ0aI04OwIKDX9fqzvLuj1ssifscfMU6pGb/a2i5DuyT/w0b
         XL7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTHC7GB+dd32oYL078CXgJhIviElvONxeFumeHwpHG/DbkVpv3w5TEOhQeXumsTGC+o3AFKX6EqaG3@vger.kernel.org
X-Gm-Message-State: AOJu0YxcqUfJ0ee9DS5cn98rYjtg01rL/KxCwvv1w0FHDHTSzKWsqKqI
	cVyw4o1I4v4Nqb+MrSGbJDvkkMhn/ChDhGEF/I1T96EqbHx9+U10k6mc753oPG0QPodo3yNQQBw
	oZCkfhMPCqB0LrIPcKSTvJZEuHLuu/yQvUovEJF9q3ufXAqkZwS0BXtlMNxE1DGE=
X-Gm-Gg: ASbGncuUnTD7BR4yNh3LfzX20qc0Xx+NEOKl+43NCEzKHAxdq+k6jZyOjP16cD3aXrA
	6lFWuGf/da/uHQr9799CrvD2SbuLTcmFx8S3tmqjMPFbPgt0q2QtZIh3KJZ78/4/zUFWX5Wcy+Q
	X8NmAx2yY5WDJLBUbmNGs8u6o/vUUt0WwwC4OTYAv4jygKF4Mk5onCqsFQAKPyAes1aE4eU11Z0
	T9PZ7kXhEjMVFeF+9BwtWMbkyhbmI7arELn3NX6AZ6OJKRioTLCC+s45fa7obUR4UaCbvJFfQzP
	dAzgw64tC8VYQ9TozntFZgzjB7GvEGhhvhVsfaOOwmA=
X-Received: by 2002:a05:620a:3b87:b0:7e8:3430:dd31 with SMTP id af79cd13be357-7e8588f3dc8mr382668085a.59.1754996324351;
        Tue, 12 Aug 2025 03:58:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ2Kb71F1OYz0n6ht6HDmFdodCHOGsbxlm/5LmCLfWhlsHczToyr25YdAyLGhBuyVuu2zDRg==
X-Received: by 2002:a05:620a:3b87:b0:7e8:3430:dd31 with SMTP id af79cd13be357-7e8588f3dc8mr382663785a.59.1754996323415;
        Tue, 12 Aug 2025 03:58:43 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e7f79b02bbsm1380966185a.27.2025.08.12.03.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 03:58:43 -0700 (PDT)
Message-ID: <167af41d-5d9e-4526-bdc5-0806a4f3cf36@redhat.com>
Date: Tue, 12 Aug 2025 12:58:39 +0200
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] sctp: Use HMAC-SHA1 and HMAC-SHA256 library
 for chunk authentication
To: Eric Biggers <ebiggers@kernel.org>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: linux-crypto@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20250811193741.412592-1-ebiggers@kernel.org>
 <20250811193741.412592-2-ebiggers@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250811193741.412592-2-ebiggers@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1D9759IsxZPY3-xhReUZ4ItNfNWbWcP2OOW8ERjGUNM_1754996324
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/25 9:37 PM, Eric Biggers wrote:
> diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
> index 24d5a35ce894a..192027555b4d8 100644
> --- a/net/sctp/Kconfig
> +++ b/net/sctp/Kconfig
> @@ -5,13 +5,12 @@
>  
>  menuconfig IP_SCTP
>  	tristate "The SCTP Protocol"
>  	depends on INET
>  	depends on IPV6 || IPV6=n
> -	select CRYPTO
> -	select CRYPTO_HMAC
> -	select CRYPTO_SHA1
> +	select CRYPTO_LIB_SHA1
> +	select CRYPTO_LIB_SHA256
>  	select NET_CRC32C
>  	select NET_UDP_TUNNEL
>  	help
>  	  Stream Control Transmission Protocol
>  

As pinned-out by Florian, the above breaks a few selftests:

https://lore.kernel.org/netdev/aJsaylkoOto0UsTL@strlen.de/T/#m68ce5625633ce065e73cee9e2c13e40772f499c2

could you please add a prereq patch adjusting the self-tests config?

Thanks!

Paolo


