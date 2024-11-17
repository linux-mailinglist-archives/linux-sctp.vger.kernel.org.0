Return-Path: <linux-sctp+bounces-287-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623489D0210
	for <lists+linux-sctp@lfdr.de>; Sun, 17 Nov 2024 06:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C813AB24F8C
	for <lists+linux-sctp@lfdr.de>; Sun, 17 Nov 2024 05:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8D81D52B;
	Sun, 17 Nov 2024 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1ZcUvPT"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A5212E7E;
	Sun, 17 Nov 2024 05:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731820017; cv=none; b=LR4RwlMHOD+L5dJjC/8m+4FvHq/9RqYY3TaLdMabjbDMPY092Zc+n6kkXVwlQNBTaXietzYJn2NPvCfbQiXmaoxYlNE6522fXOvh6DTf34P8f1ObNRDEoPAuHnqSIkR/M1bmcWG7d1BpFaTqK2WynoRBD4YYrwAkS7Gjmzb4RBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731820017; c=relaxed/simple;
	bh=MWaMj4Aa81MFVm90cBlXRJ3UfjlxbjR3hPsPA1EyjX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Di/+94TLKoZTvLDI4N7/yQHQQS9VG8ZjG5SCwi1KQ0BPPWtHchfscWlmvayyCCc9/gU0qhmynBl/+FIWXh0zo5bQ40Ntvy1bPcHFfV0Rr+yMQqHXOXcr6QjAHoYgNElofsYOMWi5zfOcB22FWZu0F/47ZXh1r5q6m0ldcq5HE7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1ZcUvPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8000EC4CECD;
	Sun, 17 Nov 2024 05:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731820017;
	bh=MWaMj4Aa81MFVm90cBlXRJ3UfjlxbjR3hPsPA1EyjX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1ZcUvPT98aV7d9I+guCefBaLcZBY7ST23hokFc1FWtp/myvgg5zukQR6kxzklGdc
	 FvaRf4US71CEEXwhBEL1y1sIe9nsI12wX36ZV+5udyyOQMyuM09f7+FtnzwfPklvlM
	 C62zORMKpTUiHSzKaYAsi0d9WJU+3j0oKhG9cm/wjakrTqAeDBQu5EHJ6ey1q2nz9x
	 4oaXcRM+z6RRYFqNyZNwuAcu7ADSk7QoAIeWaWBebOdhobaJ+j5KMOz5joaQapaj4v
	 9tk81dmYI2bgHF+v4ncl5wt22pSUm/DMyRhz3YEworPhNt7b/WYyyWBD3ua0p2HGja
	 DQzfLV3izVvMg==
Date: Sat, 16 Nov 2024 21:06:54 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>, linux-hardening@vger.kernel.org,
	linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: Replace zero-length array with flexible array
 member
Message-ID: <202411162106.83A44BB6@keescook>
References: <20241116162825.33164-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116162825.33164-1-thorsten.blum@linux.dev>

On Sat, Nov 16, 2024 at 05:28:24PM +0100, Thorsten Blum wrote:
> Replace the deprecated zero-length array with a modern flexible array
> member in the struct sctp_idatahdr.
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Nothing actually uses "payload" so it could probably just be entirely
removed, but yes, this looks like a no-op change.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

