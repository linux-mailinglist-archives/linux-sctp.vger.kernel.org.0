Return-Path: <linux-sctp+bounces-508-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82864AB5E7E
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 23:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7EF57A73E2
	for <lists+linux-sctp@lfdr.de>; Tue, 13 May 2025 21:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756561FDA6D;
	Tue, 13 May 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtaaJFv4"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BC722338;
	Tue, 13 May 2025 21:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747172421; cv=none; b=kgiOFJveuocyAx98/+TCt3lwGehlM1aFJQw6s1jZlkLmUc/y3zdn2pCgbGH25YggUwUFqP0TWcATfQJr+0keRta9kbWwbqvDbwJ87TSDzzsDe93MrrHcqxR2SDMEUCH3GCLCKZiPXCPzczgFY61hqfPs+Is6jD+yvm8BnjjY2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747172421; c=relaxed/simple;
	bh=QfJ0N0PQ/BWcSw0Db0PnnO9MzicDFrplFsD4HUF2UWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTVysIrso6Tj++OekTQSHHtN0ZB4xP7h6nMGmY1X0ML7/1xao0+ADScq3uqiStyFhOz1uBwExe47TeKd/9fRJH6kLrCH5frGuUMjQxgA6l5PmP3wD5o+aykPca32UUAlQdAzn6UYEbDsJpM07DaHW+zuPMncLf0bfZQwmKmVGz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtaaJFv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB97C4CEEB;
	Tue, 13 May 2025 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747172419;
	bh=QfJ0N0PQ/BWcSw0Db0PnnO9MzicDFrplFsD4HUF2UWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KtaaJFv4gAh/lM3yT000IHrfjiew5Lg7QckUjmVYuvW2dqluxfCiTIaytjZsNkFbr
	 YdHUXgIMgx6/XvUCNYykR16TC8SIvklnQgxTpetniENNFc/3G6JXBtora2Ke/1zjeW
	 QiU5y9ozoruSccWdf0OL0mmTCUbw8kWWjdcE63hU6JOrwhNjKKdHuNlQIyhmhxbExV
	 vmKXRfm3dwiCZiYanwFk0OOG+T4TLI++ggiy+SidtFVnNmvmzznv39m/ke7nN0E4ZN
	 20qQiA1IQYzuDGEhZaFm2nPlCIReyY0P6/OQEiWo/7K5kX75xp3xYGcwM+MfjrP0VE
	 0WA0i15zdowtg==
Date: Tue, 13 May 2025 14:40:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-sctp@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Sagi Grimberg
 <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 00/10] net: faster and simpler CRC32C
 computation
Message-ID: <20250513144018.18770280@kernel.org>
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 17:41:00 -0700 Eric Biggers wrote:
> I'm proposing that this series be taken through net-next for 6.16, but
> patch 9 could use an ack from the NVME maintainers.

And patch 4 from RDMA. Please repost once those were collected and with
the benchmarks you shared on Andrew's request. From networking PoV this
looks good.
-- 
pw-bot: defer

