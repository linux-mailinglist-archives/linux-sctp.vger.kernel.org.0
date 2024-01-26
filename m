Return-Path: <linux-sctp+bounces-4-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E083D13D
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Jan 2024 01:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCBB31F241D5
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Jan 2024 00:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A57493;
	Fri, 26 Jan 2024 00:01:17 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF17317E9;
	Fri, 26 Jan 2024 00:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706227277; cv=none; b=EcMpxD8k2m5jeChx32NiG0A+rnLNYKYLrwxGSaV5m4xMGtPUr/bDO4z6eXluxC9Si/K5IOEwHo7g2RpSfZk5HiTPChl4s244Y/rYbUg+SWuVSLnJI0ih/G0UWYY/auo3DjpdnDeLlEh6kkSdTZtjuFrH1hEDgnLb/is4Xh4dIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706227277; c=relaxed/simple;
	bh=kz5N6UcXZ8zTFkw6qYL1rBe1E5Mmjq+n97THucvoBdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkSHHRxpFk5Hy/QJl1HSUdS5bSd3IHwy4xHgKqCi7H/LBstopvoEFr7sn8IpvuBeOCEKPkv6UDTDZ9qhKZ3ToCjc4KlDkFTzjKJ3O+9OQExZ2AciZ7MG9ZdD/nyO3/ewJnB3mLmb1JTRwdYIBBTMjtPx82+6jdeS9CzT041wmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rT9eb-0003bT-Py; Fri, 26 Jan 2024 01:01:05 +0100
Date: Fri, 26 Jan 2024 01:01:05 +0100
From: Florian Westphal <fw@strlen.de>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org,
	linux-sctp@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH nf] netfilter: check SCTP_CID_SHUTDOWN_ACK for vtag
 setting in sctp_new
Message-ID: <20240126000105.GC29056@breakpoint.cc>
References: <28d65b0749b8c1a8ae369eec6021248659ba810c.1706221786.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28d65b0749b8c1a8ae369eec6021248659ba810c.1706221786.git.lucien.xin@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Xin Long <lucien.xin@gmail.com> wrote:
> The annotation says in sctp_new(): "If it is a shutdown ack OOTB packet, we
> expect a return shutdown complete, otherwise an ABORT Sec 8.4 (5) and (8)".
> However, it does not check SCTP_CID_SHUTDOWN_ACK before setting vtag[REPLY]
> in the conntrack entry(ct).
> 
> Because of that, if the ct in Router disappears for some reason in [1]
> with the packet sequence like below:
 
Seems to be day 0 bug, so
Fixes: 9fb9cbb1082d ("[NETFILTER]: Add nf_conntrack subsystem.")

