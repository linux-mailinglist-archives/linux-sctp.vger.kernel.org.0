Return-Path: <linux-sctp+bounces-345-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33234A3CF50
	for <lists+linux-sctp@lfdr.de>; Thu, 20 Feb 2025 03:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4111F1896B7D
	for <lists+linux-sctp@lfdr.de>; Thu, 20 Feb 2025 02:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158301CAA68;
	Thu, 20 Feb 2025 02:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlCu1vZQ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DF0846C;
	Thu, 20 Feb 2025 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740018281; cv=none; b=eWVfdYdlIrbH9UaKR1vf9IrB8gpQ0Rv3bzBb4dMkiQJCR46hEQoHMEwCKrai/bBOIfvG2+r4HtBbu26OcgZYMJERRZc2sJOCnmm1P7ub7UYM/frIM8r21tgvDLAu/i8yPDfX0IMwOdZgJ/LbgLGvDiy5W9LPf9WA/LITb+VrkbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740018281; c=relaxed/simple;
	bh=D8HaFyLCFixdNAkPvuPwXmriIv7spaflkk5QJHmNVMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/ydIMcHQSNui9O3jg1L9i7qfXTmlZ7mzj4xDFoGLCv2cFEo//SbF2dBpSB6MdFaFdrUMcicx+2CNsSG8nMRqDeLSeYhWse8ZKyOC0xVc1NhFL8+5IVuo/CCCFVe2d7FqPoACLtQ211XPaKf/qiMLtt6vIoBsBOhPGd7ASNIf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlCu1vZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F70C4CED6;
	Thu, 20 Feb 2025 02:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740018279;
	bh=D8HaFyLCFixdNAkPvuPwXmriIv7spaflkk5QJHmNVMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jlCu1vZQP6Ykj/XHDqucnpTGp8fXDSxpV5ykkfD64MFKtSJymGmQ+akGHoZACucE2
	 l3ZlGqa9fOshczVmeWxV89qHAcJDsKG/XA4FrcTQO6FWftaDRR9oncJfP7sjqH9u4n
	 eLehE8bGFMc7tVlDMmEJTZNS/NSkdQfHpLdS4JzKGJ+3hVqK8DkY6cEneuHu6OfxCP
	 hXEof0Fc8xUHU5dqmmOugt6HaiRVN0tb+LE5xNPxxee3dLfGETIX/mIeFKx+SFMLcB
	 0A8teV5U+teztAkzk0KHqMFqjRZAOmYfviP5aGtK3+U9lgieW8JxyJWB3JzlDCD+82
	 WUxGJwpILR7Vw==
Date: Wed, 19 Feb 2025 18:24:36 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] sctp: Replace zero-length array with flexible
 array member
Message-ID: <202502191824.74DAF797@keescook>
References: <20250219112637.4319-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219112637.4319-1-thorsten.blum@linux.dev>

On Wed, Feb 19, 2025 at 12:26:36PM +0100, Thorsten Blum wrote:
> Replace the deprecated zero-length array with a modern flexible array
> member in the struct sctp_idatahdr.
> 
> Link: https://github.com/KSPP/linux/issues/78
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

I assume this will be picked up by netdev. I see 2 sctp patches pending
on patchwork:

https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=&state=&q=sctp&archive=&delegate=

-Kees

> ---
>  include/linux/sctp.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sctp.h b/include/linux/sctp.h
> index 836a7e200f39..19eaaf3948ed 100644
> --- a/include/linux/sctp.h
> +++ b/include/linux/sctp.h
> @@ -239,7 +239,7 @@ struct sctp_idatahdr {
>  		__u32 ppid;
>  		__be32 fsn;
>  	};
> -	__u8 payload[0];
> +	__u8 payload[];
>  };
>  
>  struct sctp_idata_chunk {
> -- 
> 2.48.1
> 

-- 
Kees Cook

