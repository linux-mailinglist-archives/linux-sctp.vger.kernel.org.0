Return-Path: <linux-sctp+bounces-26-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B18852552
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Feb 2024 02:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA2B1C240BC
	for <lists+linux-sctp@lfdr.de>; Tue, 13 Feb 2024 01:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096E250F4;
	Tue, 13 Feb 2024 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAEvambO"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0323A0;
	Tue, 13 Feb 2024 00:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783916; cv=none; b=N4F52rp2WBMoYSPL+Jx0/BXSEdIXEaTGL+58ZpbdklydHY9w8VPUtf3uL+PZBkwyBSm0eB28tm+/he1pVdTjWBsC7pIPbtm+ETwc9mDIhbxnanwgwcxesXWp9j8by6qaM/xsWGSEtiK59tiSx+sFhvUoSkgzGxyNcSG4R06B3Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783916; c=relaxed/simple;
	bh=h1ia2yMsTwn3pnNa26/iCE42a3eGlW6c4BPs7MJCPqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bwTa8Cd3j27/VDvcX21JkJ2vZVBXA7G5BrTTIJEQz4e73KvUk96OQlFIIWLtT7+mXRHOumw6Lz9+W4yyRb1uUGGdu9FC6jRRIimyH36Ak1330oX/u369cFSS6FYB/7WRVzBo4Ahqy4ctxtjUYTguHUp7lY21o4bWtx9HQEVpDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAEvambO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEE2C433F1;
	Tue, 13 Feb 2024 00:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783916;
	bh=h1ia2yMsTwn3pnNa26/iCE42a3eGlW6c4BPs7MJCPqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MAEvambO7cYjpsRWEL5Eybxfh/ZAtPCb6MAf1KD+1SdIhrA7W94ShM14T+eea7t79
	 xmgWNAoaSnnDvdg/GjpzNTC6oMVoCLYC+0TM/I7G92UZu93aEJuRJfm5C89npKmCI9
	 +lSdDat5/1ZYh1QyHx0EQZ8vj04wLH2hbH953FIs2xNnWqePc0HYUz7zv5K/MZXQz9
	 beUMrM2FJs5z+X8LihQLdObwhm08zZuSnn69qQI/dcJ+RjJb7RsqqyNjVj+3gETa0y
	 CB/fvyVlI6v0ypCVjqmzvy9903QR2MsfOmvZCgIvykPAZgtK7RmGGDtuDUox/BcyV6
	 9w/Hnvwn9xg6A==
Date: Mon, 12 Feb 2024 16:25:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Xin Long <lucien.xin@gmail.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Subject: Re: [PATCH] [v2] net: sctp: fix skb leak in sctp_inq_free()
Message-ID: <20240212162515.2d7031db@kernel.org>
In-Reply-To: <20240212082202.17927-1-dmantipov@yandex.ru>
References: <20240209134703.63a9167b@kernel.org>
	<20240212082202.17927-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 11:22:02 +0300 Dmitry Antipov wrote:
> In case of GSO, 'chunk->skb' pointer may point to an entry from
> fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
> random fraglist entry (and so undefined behavior and/or memory
> leak), introduce 'sctp_chunk_release()' helper to ensure that
> 'chunk->skb' is set to 'chunk->head_skb' (i.e. fraglist head)
> before calling 'sctp_chunk_free()', and use the aforementioned
> helper in 'sctp_inq_pop()' as well.

Please repost this as a separate thread, per:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#resending-after-review
Xin Long is probably out for New Year celebrations, anyway.
-- 
pw-bot: cr

