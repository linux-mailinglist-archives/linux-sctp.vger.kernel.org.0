Return-Path: <linux-sctp+bounces-726-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 79974C1C28F
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Oct 2025 17:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 25BA3349C2D
	for <lists+linux-sctp@lfdr.de>; Wed, 29 Oct 2025 16:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957B30B501;
	Wed, 29 Oct 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOBbTUuR"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D262212F98;
	Wed, 29 Oct 2025 16:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756043; cv=none; b=hoFuDvJguqXOR6TTftRrcOWhQG77nS/uuMCWHiGznXcCqkbe8tcwlgoggp0ein0M7nlClkhWeSrs7SpTMCaDSkiTLuz+N3Sn0pETMFxyOKBmm89HU0ZTdb2QlI8fPeCNlU/PlYXVAG2wg3jA+aQ3N493G8FeLjY06pRMuFg4znQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756043; c=relaxed/simple;
	bh=OxUOwbrpCvF0HAEQwSURb7tpIIOXs+l5SN/iqW9Rcgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9BtpxD/RaiHEYhNFd6WSlqs76X1pUPkD65Y/qQA2OvhtT2yJXm9B8GEdfkisIl03VtD8slxEF3oxW6JehFetd4HjRHF5S+NaEwmvAhJuE2x12nJCRx0w9A498AJjfCspQXJ0qWnWuuwm2fo2VoJOZDJkCg8xOOQt1+gENw/AG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOBbTUuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A2AC4CEF7;
	Wed, 29 Oct 2025 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761756043;
	bh=OxUOwbrpCvF0HAEQwSURb7tpIIOXs+l5SN/iqW9Rcgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOBbTUuRHOBE1Si9/iKOvYdtrYaI04/EXzOV4MmJIhN8DY/hsUfxhKG2fjXfmQH7U
	 aQoqBTJwlKsAjBrXWHmuDv05s2mdSG8kMhp12mXDZznf1GriIxG3wDkfqW5jBimDvd
	 hfYSZOdRnkyIrSbi+WzsLV7Vnn0NUntjn529W41ivXSzKgiGpYVNdLIpIsDzVLhDGr
	 RUYrv+RyatFkj9yFEnfGDDCiv7d9IuKubNOitwUMI3vNSaQJ5KKsrGLbCVLNHDyaox
	 zARUQ6O0qvphxqYMqo00iDUBhXXcJthWqAjHnkxcV2CFKBQ8zkaHnyn1vuVGQItNwC
	 8Z3BKfONtFrNA==
Date: Wed, 29 Oct 2025 16:40:38 +0000
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
Message-ID: <aQJDhkIsexabyGXf@horms.kernel.org>
References: <20251028161506.3294376-1-stefan.wiehler@nokia.com>
 <20251028161506.3294376-2-stefan.wiehler@nokia.com>
 <aQJDD7FH1EWe2Quc@horms.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJDD7FH1EWe2Quc@horms.kernel.org>

On Wed, Oct 29, 2025 at 04:38:44PM +0000, Simon Horman wrote:
> On Tue, Oct 28, 2025 at 05:12:26PM +0100, Stefan Wiehler wrote:
> > With CONFIG_PROVE_RCU_LIST=y and by executing
> > 
> >   $ netcat -l --sctp &
> >   $ netcat --sctp localhost &
> >   $ ss --sctp
> > 
> > one can trigger the following Lockdep-RCU splat(s):
> 
> ...
> 
> > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> > index 996c2018f0e6..1a8761f87bf1 100644
> > --- a/net/sctp/diag.c
> > +++ b/net/sctp/diag.c
> > @@ -73,19 +73,23 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
> >  	struct nlattr *attr;
> >  	void *info = NULL;
> >  
> > +	rcu_read_lock();
> >  	list_for_each_entry_rcu(laddr, address_list, list)
> >  		addrcnt++;
> > +	rcu_read_unlock();
> >  
> >  	attr = nla_reserve(skb, INET_DIAG_LOCALS, addrlen * addrcnt);
> >  	if (!attr)
> >  		return -EMSGSIZE;
> >  
> >  	info = nla_data(attr);
> 
> Hi Stefan,
> 
> If the number of entries in list increases while rcu_read_lock is not held,
> between when addrcnt is calculated and when info is written, then can an
> overrun occur while writing info?

Oops, I now see that is addressed in patch 2/3.
Sorry for not reading that before sending my previous email.

> 
> > +	rcu_read_lock();
> >  	list_for_each_entry_rcu(laddr, address_list, list) {
> >  		memcpy(info, &laddr->a, sizeof(laddr->a));
> >  		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
> >  		info += addrlen;
> >  	}
> > +	rcu_read_unlock();
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.51.0
> > 

