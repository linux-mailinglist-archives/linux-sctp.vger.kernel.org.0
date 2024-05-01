Return-Path: <linux-sctp+bounces-148-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0365C8B9063
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 22:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3BC7284229
	for <lists+linux-sctp@lfdr.de>; Wed,  1 May 2024 20:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7C6161939;
	Wed,  1 May 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G+k+SzpT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307F16191E
	for <linux-sctp@vger.kernel.org>; Wed,  1 May 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593973; cv=none; b=k6+RIITU21Be0VGbFd7qekLra+ppF55eAhtzm0ggjygHIVa7XvurJ+HQnrG1OqCS19v/w+PzpWXu8JHXTnDwkgFksdWUqeqGTnxZK0Jmo1ZZwGSu8Kp8ZzAj6G5lmJeLLqv5X/POVHadNcY/DJce87tSly7YOLvf4vwceNTnuHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593973; c=relaxed/simple;
	bh=MxqZIuh4IKZCsU3TBM1EeIPccCk29czriRckRt4Zj58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnnqrhVBCtiiDH1bDoHOZg0stDVnbnJ3+g8QZ9Bw9GTQix0P9Hx7LuZ+WLBwk6MRnYRblTt6jeeaWP3OCIPDi4UTqRu+GOdayfnJOajpQbMb7G4zXV0rdYU3kBgQEKZp5WDUnIeP4oGnpqrKGUxkQSIrS5hPgY88bjqjJw8C3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G+k+SzpT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4f341330fso66597205ad.0
        for <linux-sctp@vger.kernel.org>; Wed, 01 May 2024 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714593971; x=1715198771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y2o4tlUNctY7U6Cr6T8194ul7f2V0l6ukmfj5Y5+0nw=;
        b=G+k+SzpTdcnn3nLDye9OgNwYBcG/THqUUOQpXY+TgZY6pTLzwHLsDFq7bZMOgA12ns
         TsmKy6pa7AwJzWTOHYcTD6AeTkfWLm1cBvCWC4liXvGlFLSO9fyulf6ytDQiOzDe39Fj
         Ad0+BG+UWTerz8w+WmmDb0zpaHlmDXoqxgocI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714593971; x=1715198771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2o4tlUNctY7U6Cr6T8194ul7f2V0l6ukmfj5Y5+0nw=;
        b=GpCNgUvo3Lzrvbe5tm/MSUNjgQHpRE1Xs19/yDNCYMCkun3fm3d30U7IQ+9Jhcl5J6
         fCK60Uw7F7OZnL/2vlStnZ81iIoCn+HUAZkZ1ukWgqWbI+02/Em0a6atMFNiOI7jDrW9
         ldsLDa7KrlfwCKlmAm5mV67b9nfVaQQQVQC4XjIHLaQnyakiZleTeMULc9XNQxAhgi40
         kO18kxa5R0W4PXDx1GWwKgHt1u3wSefnmr6DYXiDIA/fomPyC8W9gXfyhD2SKKBi+EOd
         nQzx7yQHeGOfo5NeGMk4WgD4Z+waiIRi8owauZ5c3iKaTDIx3tmN0EJKqoHQxX+R524T
         9m4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWScRQfJDVr63oWRDUd/wOYWeRPxkAMFJrdvfZ4dnlLsXrfakVP5rurOvpojFSwCgssspieaLmsyO+xSO3j1jG1OVCxtuxXIYdxWg==
X-Gm-Message-State: AOJu0Yz3tZVKzgx/WqVfHqICypzLz74evUcoawxMUGcBtiAkQH5U/K8O
	5SR9fvY76NMEiC+eFNPxxmppzt5fdNsmJM4cFxOUnbSZg+sfpeLu2MBzjBx9Mg==
X-Google-Smtp-Source: AGHT+IEw1MN7ZWjyOSnwvYGcsH7NwE54BG1k+72eDhYVUcDgtLB0JDZWdDTjdOhh9mn3t7M+X/IQiw==
X-Received: by 2002:a17:902:c213:b0:1e4:24bc:426e with SMTP id 19-20020a170902c21300b001e424bc426emr3467826pll.28.1714593971355;
        Wed, 01 May 2024 13:06:11 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902a50100b001e0e977f655sm24582522plq.159.2024.05.01.13.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 13:06:10 -0700 (PDT)
Date: Wed, 1 May 2024 13:06:10 -0700
From: Kees Cook <keescook@chromium.org>
To: Erick Archer <erick.archer@outlook.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-sctp@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] sctp: annotate struct sctp_assoc_ids with __counted_by()
Message-ID: <202405011306.0B9D906F1@keescook>
References: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB723728DA244A82D97342D6498B192@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Wed, May 01, 2024 at 07:01:22PM +0200, Erick Archer wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

