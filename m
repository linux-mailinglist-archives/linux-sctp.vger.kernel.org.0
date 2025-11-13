Return-Path: <linux-sctp+bounces-743-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B266C59503
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Nov 2025 19:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B55A4F89E2
	for <lists+linux-sctp@lfdr.de>; Thu, 13 Nov 2025 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4C2DC76C;
	Thu, 13 Nov 2025 17:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpkIEYXU"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9BE2609CC;
	Thu, 13 Nov 2025 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054448; cv=none; b=JEtRe0Yvweh9oz64sV60Cpyj9syARSp79adq8sJCclwG0DPmjqqoOdz+XGWQcw5XcRQQQySrYweeaNDGb2myFsAtn2FtriN0OCsBXGvpYk5x9XygtzCild6rFEp/6HbN1RoxhDfMjRe6fQ414b65aSi5D+DFSatECsIrb74tH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054448; c=relaxed/simple;
	bh=e4w8F5T0ln8Rha6zvjUQabjHWXT2GZbMyXlv8D2R2e4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfUmH+2Qgn09m+8gR47+stODgS7p2VQxKSNVzJAGeUdvVYMsCWk4kOUpZWcrw1jqh49GjHfNuf5CVcSy3qCloAOryhfAilyAVfuWmdzqCWCK53BgLpilL3koavR7Ytuwh/7uDwdZmJvKcDc8mOze7KBrtHz8muNud8SnRshmfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpkIEYXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74404C113D0;
	Thu, 13 Nov 2025 17:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763054447;
	bh=e4w8F5T0ln8Rha6zvjUQabjHWXT2GZbMyXlv8D2R2e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpkIEYXUe6cYwg9EkzPKlx03iEjVWmvIjpqVtXudwkoLL4jSSaCkneVYo1rNFLEye
	 Y5SgDZkNqsfqrvLxPWGqOZsIXakpQnHX/X5lMZxFaxRkIcap2TyXcIGU9TtbzAmwMn
	 yDet18iw3ds+dqjzeYN1aMeEj+1jOf3S2/AQ9YNd0itg2U0EKPyzMgkN8YJpo2nLyl
	 3uHISwMmLX9lh3kIFpgIAEVQZRyF9yuP1OHCwjZ8JI0EnTDBZgampMHF+SzsBoLtcS
	 DFFxZ24Dz31mV0rRlopLYDYn8QyI16vtt16yo5StfHuRFPawmW38zmN0QU/QL4d7+i
	 6lGsJF13Ru1aw==
Date: Thu, 13 Nov 2025 09:19:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] sctp: Remove unused declaration
 sctp_auth_init_hmacs()
Message-ID: <20251113171906.GB1792@sol>
References: <20251113114501.32905-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113114501.32905-1-yuehaibing@huawei.com>

On Thu, Nov 13, 2025 at 07:45:01PM +0800, Yue Haibing wrote:
> Commit bf40785fa437 ("sctp: Use HMAC-SHA1 and HMAC-SHA256 library for chunk
> authentication") removed the implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/sctp/auth.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/net/sctp/auth.h b/include/net/sctp/auth.h
> index 3d5879e08e78..6f2cd562b1de 100644
> --- a/include/net/sctp/auth.h
> +++ b/include/net/sctp/auth.h
> @@ -72,7 +72,6 @@ struct sctp_shared_key *sctp_auth_get_shkey(
>  int sctp_auth_asoc_copy_shkeys(const struct sctp_endpoint *ep,
>  				struct sctp_association *asoc,
>  				gfp_t gfp);
> -int sctp_auth_init_hmacs(struct sctp_endpoint *ep, gfp_t gfp);
>  const struct sctp_hmac *sctp_auth_get_hmac(__u16 hmac_id);
>  const struct sctp_hmac *
>  sctp_auth_asoc_get_hmac(const struct sctp_association *asoc);

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric

