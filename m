Return-Path: <linux-sctp+bounces-606-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F586B28622
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Aug 2025 21:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D56141C25702
	for <lists+linux-sctp@lfdr.de>; Fri, 15 Aug 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460B1E231E;
	Fri, 15 Aug 2025 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UujnPyBb"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49B219ABD8;
	Fri, 15 Aug 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755284952; cv=none; b=RBffGcA7zlqNBRT6gUG/yADuDgN6mQwSdzdD4snRU5N6HnwbMPCdFfO/RLw6Yug0ggzB5x5HOPbdm5D/MdTGWW7HaYB5JHsfkFLJGNjOjyK6g5F9nGY93IU4kxs/m96J443s2SmFnP3nkvhcckChblG/FDAwrCw4/1GlgBPXFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755284952; c=relaxed/simple;
	bh=Pigh9D76HNkaQLl9i8pr/Qd1z4qUCLXAUVmyJ26Bld8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gQPJCCNBYW1Lrpg6hNFGvao695IMmWFh311l4+TKF7IBCoVjgrBTXJ0EYVCEopTo6tgZHL9qUQhJ4Noz0MbqYnJJsh1ZjBaVvDikcZMyyQxL70HPJjgzchRvO12KwMAgdHZxZmwIeYd8YIpMKo67eQz1BLN/yE+EBwXwatzhz7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UujnPyBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18E3C4CEEB;
	Fri, 15 Aug 2025 19:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755284951;
	bh=Pigh9D76HNkaQLl9i8pr/Qd1z4qUCLXAUVmyJ26Bld8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UujnPyBbNdtndllgjcysnviJShiXGXOeSuqmm+TztAU3VVYwNjQB2B9/iYbeZKhar
	 NKok0+egKDpBNLjqHdK6RLvEv7gODI2hMSiKsIj7EvOt4XLMjKBfH5rG3M6SHMAJyn
	 kmEJ6WoD569UKPH7H9HdXUoAzq0pecqiwj2nT08mLNoEkEJrUSoC1BqO98GyOHVGik
	 vdq3km/7uVYIioGunUfYo+cbVVeYxs/ZQrlJAoufRHYTGWt1Q09vmpiKmMO93fs7BY
	 E7Znp29CFt/cbmsGCUDnVmEDrNMvoXQ9Q+pjKexJHXkJjLo9xyT0e/pPmT88ndttbr
	 RxS6ybRnjIATg==
Date: Fri, 15 Aug 2025 12:09:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, Xin Long
 <lucien.xin@gmail.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
Message-ID: <20250815120910.1b65fbd6@kernel.org>
In-Reply-To: <20250813040121.90609-4-ebiggers@kernel.org>
References: <20250813040121.90609-1-ebiggers@kernel.org>
	<20250813040121.90609-4-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 21:01:21 -0700 Eric Biggers wrote:
> +	if (net->sctp.cookie_auth_enable)
> +		tbl.data = (char *)"sha256";
> +	else
> +		tbl.data = (char *)"none";
> +	tbl.maxlen = strlen(tbl.data);
> +	return proc_dostring(&tbl, 0, buffer, lenp, ppos);

I wonder if someone out there expects to read back what they wrote,
but let us find out.

It'd be great to get an ack / review from SCTP maintainers, otherwise
we'll apply by Monday..

