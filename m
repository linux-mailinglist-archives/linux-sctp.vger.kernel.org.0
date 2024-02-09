Return-Path: <linux-sctp+bounces-18-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 409F784FF1D
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 22:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DAB28CC09
	for <lists+linux-sctp@lfdr.de>; Fri,  9 Feb 2024 21:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53278199B4;
	Fri,  9 Feb 2024 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ng9DbyxR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF16FC6;
	Fri,  9 Feb 2024 21:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707515225; cv=none; b=XHrWQNElkjF9Bp2Z5w8zpMuNbt/5abKCKXWx1Ye4Dsemzg7l7gx7GQ/9An/3WVUdMFuMmt8YmdkJ6E51CKOqQuktv299GOsJSXMLK5ixl7PGGSvAIbNbgEB3s8iaMVTYvF63OX7Tu9AQKCiPgWRZpAtolVNoCrfmH/BdZS2k8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707515225; c=relaxed/simple;
	bh=/tDUPJkwhOx4viRfkJ9TmOy8asfx5XzqzTXyYkx9xGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GM0fcjN98VcBgq/C1w2yltivbkPy942UW7+SFS9Ac0caRC1bq0KRk0vla3eogLrh5c3c3+cV07GMx6zzbKOhRYFQhmfrMq9WqWf9QvaNdXdsWMR1ICt2xvGReK7mHe+OK8Rw4/yI7tcAFDJKJlMMoiRBvNIF8cvybbxfijVtFus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ng9DbyxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75062C433C7;
	Fri,  9 Feb 2024 21:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707515224;
	bh=/tDUPJkwhOx4viRfkJ9TmOy8asfx5XzqzTXyYkx9xGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ng9DbyxRLvw40yr2w632UWwL5d7EnpWq53YPnFTu3xkk668+AUiQSKUOXdPLSjh5K
	 KGCO+gdTia7UAYcqG4W01KZ+DN1JrToh8tDednk6xGy5uqcrMuOWmyNo/8czJWor/T
	 MFU0lO22+RB+pRjKnOiV8cQA48WvBb+GTBxZf8URrpSLeLUjXzrgBlwsRtq9nVm9RH
	 i8LtSlr7bGUyllaaf3q1PGFGgRcCgWshl+CFVAToquFmxnUHAUAY7dyeMmqQFS75RL
	 JRrXeY/IkjXDqizuZJp/h7M3FyM59KmRE8T7WLcN6ZfoVgOdBL3eMuKQCL/HGH5HVF
	 X5IdxrpFDuWTQ==
Date: Fri, 9 Feb 2024 13:47:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Xin Long <lucien.xin@gmail.com>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+8bb053b5d63595ab47db@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: sctp: fix skb leak in sctp_inq_free()
Message-ID: <20240209134703.63a9167b@kernel.org>
In-Reply-To: <20240206092619.74018-1-dmantipov@yandex.ru>
References: <CADvbK_fn+gH=p-OhVXzZtGd+nK6QUKu+F4QLBpcx0c3Pig1oLg@mail.gmail.com>
	<20240206092619.74018-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  6 Feb 2024 12:26:17 +0300 Dmitry Antipov wrote:
> In case of GSO, 'chunk->skb' pointer may point to an entry from
> fraglist created in 'sctp_packet_gso_append()'. To avoid freeing
> random fraglist entry (and so undefined behavior and/or memory
> leak), ensure that 'chunk->skb' is set to 'chunk->head_skb'
> (i.e. fraglist head) before calling 'sctp_chunk_free()'.

The code already exists in another place in this file, let's factor it
out to a helper function.
-- 
pw-bot: cr

