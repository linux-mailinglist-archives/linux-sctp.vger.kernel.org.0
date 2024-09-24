Return-Path: <linux-sctp+bounces-258-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DAE984008
	for <lists+linux-sctp@lfdr.de>; Tue, 24 Sep 2024 10:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 604BAB235B9
	for <lists+linux-sctp@lfdr.de>; Tue, 24 Sep 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A114B08C;
	Tue, 24 Sep 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NCXFga3n"
X-Original-To: linux-sctp@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D2414AD1A;
	Tue, 24 Sep 2024 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727165502; cv=none; b=oVV2qAv2+9z10Ri55cxtQu11iyrjKkROk0v5HgaYsNe/w9a+4ZpDiwsYAngzaRh2hxISyOkwgp4qHIsUIe6Dd6OZVl4C5oV6DhKGfGxCsd+8jK61T5wmlhtXDbYqfmi83SxMhXkDndsr2ux2cdZeqAq2UypqZ35VP6yhQ24+JhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727165502; c=relaxed/simple;
	bh=JoP/JjXp4oilVHOnk4rBm6meqOXrgMfR/lBFeUzDlwU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRtKzCgU1wdZLD6Ilpoa8NsxvxPu15d7BrUC0dVkV/eqXcaqArIEZ4uPvosKViB1BejKgJ4okBKZatZhBgzjSjMMuQBfj73UqCphOALMJifbOaXH5LA4hIid2qva4khZfgaTCR0zCFBTZHOxHWBeyR6h3gW91ebiUyhcXdXjQHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NCXFga3n; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 255F160003;
	Tue, 24 Sep 2024 08:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727165492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4fZ8GEi1hn4SdPeejlhLDirHqt4xQVxPagrDdaW3N8=;
	b=NCXFga3nVGGipwDOmTG/R538KcL1Bfe/rgO2sbEZdF8LDcoI6tdfza/u6MHrl23SSRt4u2
	1DprcuHwqTe5kzjP4d/a+antVA45xbgP1E8NMSEIBVMRWtfX/Um3FbIEbQHAirgu3dis92
	JxL/podjbG6xhBxwPRTojwboRppeJRyi6qa2a2uAWpJGBd9TARIeCnYeunXjGP/FOntHNF
	vLAnHRzmDRukiDTntElOoc7wvZTQtVar4SQCsfCGz5N6X5mB0T+CaBPLkTch3/bTx5FuJe
	MJ4rW8Zit5FPDmKY1Eqf8R0+sbSzE99+Foik2N4u4wEcajx4jd908ntFusV7Tw==
Date: Tue, 24 Sep 2024 10:11:29 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Yu Jiaoliang <yujiaoliang@vivo.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long
 <lucien.xin@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
Subject: Re: [PATCH v1 net-next] sctp: Fix typos in comments across various
 files
Message-ID: <20240924101129.7b911384@fedora.home>
In-Reply-To: <20240924062203.3127621-1-yujiaoliang@vivo.com>
References: <20240924062203.3127621-1-yujiaoliang@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

On Tue, 24 Sep 2024 14:22:03 +0800
Yu Jiaoliang <yujiaoliang@vivo.com> wrote:

> This commit corrects spelling errors in comments
> within the stcp subsystem to enhance clarity and
> maintainability of the code.
> 
> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>

net-next is currently closed, please wait for it to re-open to resend
this.

https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow

Thanks,

Maxime

