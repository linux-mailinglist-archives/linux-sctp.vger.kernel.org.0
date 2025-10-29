Return-Path: <linux-sctp+bounces-725-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F40BC1C841
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Oct 2025 18:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F206435F0
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Oct 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A78434CFC5;
	Wed, 29 Oct 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiiArGjK"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3142F3C39;
	Wed, 29 Oct 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755924; cv=none; b=t9t79NawgerzkCM4vyEXoUi4asYlok/UiDAnKXt/l9KnTj6eGRo1MManNmXNA8EJ0RnBnvg64UGVISrKmQPBBzur+k5nftkX5ll6vRak0Lap0Djjoh+r0/T3tyLaLWKj27PSxwCpZgjPuYHjXh4yAPgMM1tWMPfZmFnSGvnuJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755924; c=relaxed/simple;
	bh=NpJye4Kg45PtQqDQSfWJQGGDc2/wv57nCBVyYwi1X/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZQ2LfGy39rVjSQCGtrb7da28PEyuMW+A3KFXHkZxyIXKVDJuwhXYnA+lCjF8LYk6eJm50Bi8dc3EAKmxhiTALGuH9qY4y/3gIoJhrz4iah3fdbFJeZqWBteN1DgQCcfA/bMKONaIYGwrquzmnTx9LrIC30cFMyHTkY0yjf2I08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiiArGjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F3AC4CEF7;
	Wed, 29 Oct 2025 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761755923;
	bh=NpJye4Kg45PtQqDQSfWJQGGDc2/wv57nCBVyYwi1X/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiiArGjK7HpD1cID4dWvqnKuJst9muBqYAiRBZ29g+PkVhUN+JayxqUW3Xqeu80ng
	 1Gg/iF8KghUWierQ1+I7Wdb2hWWleaaJVYFAUmboo5fK6/8BSSroGA+xA0c6U0PaJz
	 lIdYzbcZqiu8Yr5Axa8Fn5pptNPloFEQXwNMwgVHATReUwnnSGE5YwYA2cu85XXTJ0
	 l9K5TyFVXKeiXt47lyZ69awvEHn5xhI/X7BCKuTm/EV5ICPireZRzeLo715Wy2PZ/l
	 twkln//Num7bkM7s3GfeEpq12a1vZr4/+MtnFaK/qo9aGUF6OSbQcVd+Kcx8E8GSMb
	 N9ov9eYRr+MnQ==
Date: Wed, 29 Oct 2025 16:38:39 +0000
From: Simon Horman <horms@kernel.org>
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: Xin Long <lucien.xin@gmail.com>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/3] sctp: Hold RCU read lock while iterating over
 address list
Message-ID: <aQJDD7FH1EWe2Quc@horms.kernel.org>
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
 <20251028161506.3294376-2-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028161506.3294376-2-stefan.wiehler@nokia.com>

On Tue, Oct 28, 2025 at 05:12:26PM +0100, Stefan Wiehler wrote:
> With CONFIG_PROVE_RCU_LIST=y and by executing
> 
>   $ netcat -l --sctp &
>   $ netcat --sctp localhost &
>   $ ss --sctp
> 
> one can trigger the following Lockdep-RCU splat(s):

...

> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index 996c2018f0e6..1a8761f87bf1 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -73,19 +73,23 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
>  	struct nlattr *attr;
>  	void *info = NULL;
>  
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(laddr, address_list, list)
>  		addrcnt++;
> +	rcu_read_unlock();
>  
>  	attr = nla_reserve(skb, INET_DIAG_LOCALS, addrlen * addrcnt);
>  	if (!attr)
>  		return -EMSGSIZE;
>  
>  	info = nla_data(attr);

Hi Stefan,

If the number of entries in list increases while rcu_read_lock is not held,
between when addrcnt is calculated and when info is written, then can an
overrun occur while writing info?

> +	rcu_read_lock();
>  	list_for_each_entry_rcu(laddr, address_list, list) {
>  		memcpy(info, &laddr->a, sizeof(laddr->a));
>  		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
>  		info += addrlen;
>  	}
> +	rcu_read_unlock();
>  
>  	return 0;
>  }
> -- 
> 2.51.0
> 

