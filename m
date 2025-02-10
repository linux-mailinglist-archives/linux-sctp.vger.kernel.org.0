Return-Path: <linux-sctp+bounces-324-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E1EA2ECD7
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 13:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B58D3A572E
	for <lists+linux-sctp@lfdr.de>; Mon, 10 Feb 2025 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3E1F78E4;
	Mon, 10 Feb 2025 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyJr8BIl"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2AD28E7;
	Mon, 10 Feb 2025 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191914; cv=none; b=Ze2GfV0sDxytNKcPqWS64GwdV50i70SpXmS19zLtw3jIuLF4YMn5a5aLq2I9bypVzhHVHFxAiEogefroKcL2i3pyiW7aMezFIZxqTdxymnGK2pUChJNL1heW0XWLlDrgD8vsFXs/iFbgRxQQn2q1ZFSFOG4EcPR82tV+vrJbsRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191914; c=relaxed/simple;
	bh=vp0pMaSI6e2A5Q2R8B6jf8Qb3Jo7d4cArjy38aOKFro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjembDGmkS86NspkwWeQNRhu39VJf5SJcKx32kqN4ZHIH1jw3DF9fEDxtMySXvs2LqG/2YuYQqVVQC20djyUq7jxaiMZccttIMVmoY1cMjXWWG0BzTNMBbzQUCAnEKBIdljZYmJlo7Jf4EVXWwV+AkGkZX2+g+X9GqhKCuxaUdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lyJr8BIl; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f48ebaadfso68182365ad.2;
        Mon, 10 Feb 2025 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739191911; x=1739796711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iG5F7J2BN/jUR5/s1mlfNl87nG5+zzPkRWq2E/D2h1s=;
        b=lyJr8BIlGRnJl6SqFi9s+Sz3AlCc6nQu4b1aaIgRx9QkGRzB51AVCIE5mai5iQdfdV
         PQNl+tvonuJne4TPernm+CvgULegxDC3dWAV1KMumNJ7yyvnTNvkRrdJCQKjdALoti+G
         GSysNGr0Z2+9p8AcgUmewmWissMwRwqx9C/IYAVr8ls68qZnTSTHIxofDoL5Xxo5P0RQ
         CF+AQ7HiTqssfvtMQroYbY6zjVBfc9RlH2rZK76EFbYYf6cOgrW6fnEys2RKHVQ6YLzp
         vqur347xAFEq8iCK+nZvsnpekxEshUtq+BYOp6TGlcQo/4IxuEoX4nOtv4r5gcAbo7TK
         3VgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739191911; x=1739796711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iG5F7J2BN/jUR5/s1mlfNl87nG5+zzPkRWq2E/D2h1s=;
        b=d2/V5UVma8BxT6Pc0VhHika7JgwPjgKJtweI0SppOxjhZx4hZOdfbVu6OfzAK1aE2p
         dXZHoyNGX1F3/yCXr9fI/lYO0WtXdxrYXSKbQ/2/73hjKNjPnAsWyuj7xPO2ug0nUttp
         7ROaMyBvdbioYWj8AqfeGx5te2WB86QGn4dImbhZPaNSeS2ccNgZJI/Kw4KtYInZS5aU
         /gIGZGDDsLDXbcmqym3csFfmbaLP5x0TN6IGvCOGKCVzjCz9HVvY/03XnhvVLA451Vwx
         ylnfxKIFXuyK5Gmv/iC0OhhXiwvJUOYHu0QHMehDJAcDbtMxvb8lwEKHXEYGqaGAaywj
         /apg==
X-Forwarded-Encrypted: i=1; AJvYcCUTBYYq6zV7AJtAjuNmTZ6ZRdSxuAsnZWbjN34ZVKGSbAHWbZ/xMviGZ7SZkuHpQiIZY336svBOiRroFA==@vger.kernel.org, AJvYcCW/r7eIGRHbr/sY6UASimvgwGnmY10L8F9+E3WjL5bl+P6Rhxvuf18e7X7Q6M79+FmdBdM1WDTG1qrnf8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvmtjEEjbcP1BPu11C4JEHrRR6CH8GROuce8kiHFdSnMzag/ZG
	hCC951IF31nPdXaJ+8l03IL3G6Pa6q3Nh7dpdEGUEGdMpEv1fvd2
X-Gm-Gg: ASbGncvxK0ADa/HHUokvvpt3C7arHxhV+1Q4S13PEbqHj+LmR7aGX5XZ9FSYLLS4gS4
	i3pFPsSkE/EJbN8aTlJKSAoKvGmd99djIkSvYBmcgvcjinmjDcWfRrClMhNreNej0rLM9+czDSv
	LRi5+/V3dRQLL6JMQ0tMRBjrMrYWWv8ZadQQQDMjxHIjv6oZO8fwdmIJTmxjMfe4wWPo2g2aVHo
	NjGCLYislp85SZkCiIjLEhbtW6XkFYgQvCOdJwGrPganVXMdaZkDggIDt6Lnlt3b/brYUsqKOyU
	OidGYEqpO1vSFjF0vYJjnn5IFBBTnQ==
X-Google-Smtp-Source: AGHT+IEGEKBUtc2eZz0jVHkhA2m7MP2cyzPJlPWCdNuCZ6MQO/5x2JBlDK7hFbxtoOBmFkt/91lKfw==
X-Received: by 2002:a05:6a00:3492:b0:730:87b2:e839 with SMTP id d2e1a72fcca58-73087b2f0a3mr10228890b3a.21.1739191911423;
        Mon, 10 Feb 2025 04:51:51 -0800 (PST)
Received: from t14s.localdomain ([177.37.172.166])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf14ebsm7541908b3a.104.2025.02.10.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 04:51:51 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id BEF8BE6F4F9; Mon, 10 Feb 2025 09:51:48 -0300 (-03)
Date: Mon, 10 Feb 2025 09:51:48 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] sctp: Remove commented out code
Message-ID: <Z6n2ZOTs_fKx-w9z@t14s.localdomain>
References: <20250209210024.5413-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250209210024.5413-2-thorsten.blum@linux.dev>

On Sun, Feb 09, 2025 at 10:00:24PM +0100, Thorsten Blum wrote:
> Remove commented out code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Hi Thorsten,

SCTP patches are picked up on the generic networking mailing list.
You need to send this patch towards netdev@vger.kernel.org.
Thanks for your patch, but please post it over there.

Best,
Marcelo

