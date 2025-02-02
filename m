Return-Path: <linux-sctp+bounces-322-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1032A24FF9
	for <lists+linux-sctp@lfdr.de>; Sun,  2 Feb 2025 21:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6FE3A46BE
	for <lists+linux-sctp@lfdr.de>; Sun,  2 Feb 2025 20:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC7A2144CF;
	Sun,  2 Feb 2025 20:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="S7mFv4ph"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CA2AEF5;
	Sun,  2 Feb 2025 20:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529249; cv=none; b=aAFaZ1IPRRM1ZizeGXiMRbPvk+WhackGYNMy1D/LpF64vkeQPD4IQTx+SWXtYNnq+eJpgsayMsPt4zNdVkOOMw1+R7r8TyNwGz5ZU7enJHfil19hRadyfjmvqT1quq0gSrUtRzaWQETc5X4qSEOYjMAz2CLMINddVCHBRhAD9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529249; c=relaxed/simple;
	bh=3MEfNaRCZUtDdwOVFQDBrl++ovrUJadOZGif3aGGBoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MYkr8WwqSjBQVI5CzHFgVpveFfko/q7wam9OnIconVFTa73DjOv709zY1EecCVt0UQURZ4YCkjPZTpAR10HS5Y3tfbo3B7kAFa3BSRJt3ttMGt9n7C0i31TAwXNpFtG7BaPnsKBn17YkrQcmVkdkf4pxaogz9KvOuBuTBbOxu60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=S7mFv4ph; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost (unknown [10.10.165.4])
	by mail.ispras.ru (Postfix) with ESMTPSA id 8CF0640777A2;
	Sun,  2 Feb 2025 20:47:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8CF0640777A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738529235;
	bh=cnSkF1PHpAD2qaGhH+7g+leHjcS4sUfxpOS0lKumtXI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S7mFv4phRKsEbezxubMPmFS9RQNbT1nNayJFkF1IvEiL1OAI954tvRYCENbOQa1SH
	 K3Hd0Jc2/SglmMxEJndjrsntuRRkZOslUsptUit0a27RMefZIwfT2bGdOHGTxomPF5
	 kdrq2SkcuwfBavE6VhNHc6WybLxIcwCexI/+iRj4=
Date: Sun, 2 Feb 2025 23:47:15 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: David Laight <david.laight.linux@gmail.com>
Cc: Nikolay Kuratov <kniv@yandex-team.ru>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-sctp@vger.kernel.org, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Neil Horman <nhorman@tuxdriver.com>, Vlad Yasevich <vyasevich@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] net/sctp: Prevent autoclose integer overflow in
 sctp_association_init()
Message-ID: <nifmeonkyceodckvd4t6j7oxjgduu27qm2o7zp4u35niju23js@baisicmrcljd>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241228121018.6b4b78dc@dsl-u17-10>

David Laight wrote:
> That doesn't fix 32bit systems.
> 
> Looking through sctp/structs.h there are a lot of 'long' used for
> timeouts.
> it can't be right that any of these change size between 32bit and 64bit.
> So they should either be __u32 or __u64 (or similar).

I guess all the 'long' timeout values - not only in sctp, this concerns
other modules in general - follow the jiffies thing itself which is
declared as 'unsigned long'.

