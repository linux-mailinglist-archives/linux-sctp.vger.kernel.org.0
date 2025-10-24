Return-Path: <linux-sctp+bounces-703-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE65C075A4
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 18:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAEAD3B731C
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC23627EFEF;
	Fri, 24 Oct 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6RA67Xf"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB327587C;
	Fri, 24 Oct 2025 16:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323946; cv=none; b=Ad5tIlbMBiRYLzPD46PCEWZXy5lHlbN+mZKyXIh/cqzVDas/fFSaq65bWQHX3PMwCaU0u/Cq1ht2eqsJw3FwBcxrNk7GG9Rw6AQhrZYdGjMu9BtR7N2QMcneKcX8sTt9Szvdj/tGMcn28I2gKK29rBCi20hakWavqPHUBc/ifHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323946; c=relaxed/simple;
	bh=rZPzuGrpbN1ns2DrPxp+zGyO8euKRTB+zg/Ttmz+NdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP7PCa7HbpECgJCk6Y3/1KBGntq/Us+TwpxA+zDFkJ5YUgiz0FnlprPqYGC5Oe2ev4W26SbcPfG96mHdTpfTGXZW1Xq6A0z7WLtuAwsneI8/QIBrQJEnQMzQMZ0cj3TltQacsSLSkhrkvoyvxyXQu4o3Julv2ELqJsIo3L38/H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6RA67Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A504BC4CEF1;
	Fri, 24 Oct 2025 16:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761323946;
	bh=rZPzuGrpbN1ns2DrPxp+zGyO8euKRTB+zg/Ttmz+NdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a6RA67XfrZaRX4vYPzUAnK1dKe5neW7QnMfJ1P5tYHWF6Dfyq51IM3akRdeuvZ8Vh
	 Z04RmouNK363a+Hs/TBylmlgrDj+ub2p99s+OiMmCWvBL+i9L1ulLxcDH7AFJnILal
	 h9Ylo99NqFmwVUlyjVbDoTEnsOb9zJ4IqV5y113O51UJgMGauHpIoJQBXx7hXOZ+so
	 33qjTgBAsbdEiw9o9DtqW8zU81HuH/MaD4NJh5l+kPzrYQ+NbSAK6aqfcsOQz3eznj
	 Uckv1aE7p37GtNUHizeJdf9Dabo0A/0fQ6O94duB0I0BsfTEkFO0013krP/TCipjKS
	 XDXY5rs+u6mzA==
Date: Fri, 24 Oct 2025 17:39:01 +0100
From: Simon Horman <horms@kernel.org>
To: Ranganath V N <vnranganath.20@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Message-ID: <aPurpdMe6BHfSHEH@horms.kernel.org>
References: <20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com>

On Fri, Oct 24, 2025 at 05:14:17PM +0530, Ranganath V N wrote:
> Fix an issue detected by syzbot:
> 
> KMSAN reported an uninitialized-value access in sctp_inq_pop
> BUG: KMSAN: uninit-value in sctp_inq_pop
> 
> The issue is actually caused by skb trimming via sk_filter() in sctp_rcv().
> In the reproducer, skb->len becomes 1 after sk_filter(), which bypassed the
> original check:
> 
>         if (skb->len < sizeof(struct sctphdr) + sizeof(struct sctp_chunkhdr) +
>                        skb_transport_offset(skb))
> To handle this safely, a new check should be performed after sk_filter().
> 
> Reported-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
> Tested-by: syzbot+d101e12bccd4095460e7@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7

Hi,

Thanks for your patch.

Unfortunately, this is not the correct format for a fixes tag.
A fixes tag should reference the commit where the bug
was introduced into the tree. In this case, perhaps that
is the beginning of git history. If so:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

I think the URL you provide is appropriate for a Closed tag.

Closes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7

See https://docs.kernel.org/process/submitting-patches.html

> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> KMSAN reported an uninitialized-value access in sctp_inq_pop
> ---
> Changes in v2:
> - changes in commit message as per the code changes.
> - fixed as per the suggestion.
> - Link to v1: https://lore.kernel.org/r/20251023-kmsan_fix-v1-1-d08c18db8877@gmail.com

...

