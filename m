Return-Path: <linux-sctp+bounces-348-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD6BA3EA18
	for <lists+linux-sctp@lfdr.de>; Fri, 21 Feb 2025 02:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 754387A5D7B
	for <lists+linux-sctp@lfdr.de>; Fri, 21 Feb 2025 01:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE72AE84;
	Fri, 21 Feb 2025 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC49XDJt"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE8717991;
	Fri, 21 Feb 2025 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101607; cv=none; b=idCNQT17uio/dyHy/TTAvf5ZGf0x/Zm/CM1BlHVgO/xztjYzOEN93wSe9w3IJ2Q2ihiO+VdIMXxqX3jxWmWug3/WTdx7USP7uV9IHLqfrssduneTmRZfrQeAZ9xo4FhT2puIVF/2GwoeXT4W0RDaDskIBm0YoVVf+7f36obR9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101607; c=relaxed/simple;
	bh=bQJH/FIssL3KJG4ZfidMolApnK0ieInyDpttYutmRik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYHngMS8egsf6pkor7Cn5B02xwDKOzJjzsiaUqVLvhfSzKn5kaiyiivmGDu4CePM12daeHbjREv62+5PwX2038lRtQ3v24C1WEAQ+cuBjMOpkxiUs4GTDDXz8o/n34t9KIrplojjYQcv5k6Fn0IvhScKsEcOf8AsCnWriKANaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC49XDJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36408C4CED1;
	Fri, 21 Feb 2025 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740101606;
	bh=bQJH/FIssL3KJG4ZfidMolApnK0ieInyDpttYutmRik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pC49XDJtGAICDewUYtW9kAXXf8f+pvIorspfAtOEww2XHPEQcrULEgOjtHwHAuuog
	 bcXMZ8cw5uBMm0svC4Z8W/BmBfD+wIDJ/X8lj9MA5+6eZnqh0f8lUpnIviBl5l7JEh
	 bEeqwmdVOY1DIpvyQsH7pLsQ0CvQZ4171eCReVG1Ql+dMsw/yrHwiJYp029B1BNxyB
	 1iEQHYtwRFqL4mz8YF+RL4Fi8sqJNlANTu68xsytAWkNFjWB2mgKjhfxETrUOZMeDv
	 sSJRJcFolhQRCqsnwd386fVmm8yqzgvxs74jvf39EMmcr6yVr1eUhJVqaZlFOMhidr
	 uXOdAjLjYksbA==
Date: Thu, 20 Feb 2025 17:33:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 Xin Long <lucien.xin@gmail.com>, Kees Cook <kees@kernel.org>,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] sctp: Replace zero-length array with flexible
 array member
Message-ID: <20250220173325.0349e913@kernel.org>
In-Reply-To: <20250219112637.4319-1-thorsten.blum@linux.dev>
References: <20250219112637.4319-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 12:26:36 +0100 Thorsten Blum wrote:
> Replace the deprecated zero-length array with a modern flexible array
> member in the struct sctp_idatahdr.
> 
> Link: https://github.com/KSPP/linux/issues/78
> Reviewed-by: Kees Cook <kees@kernel.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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

Builds for me with this field completely delete...
I think we should prefer deleting when possible.
-- 
pw-bot: cr

