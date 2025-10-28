Return-Path: <linux-sctp+bounces-717-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA14EC155DD
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 16:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D00188761C
	for <lists+linux-sctp@lfdr.de>; Tue, 28 Oct 2025 15:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55F23370E2;
	Tue, 28 Oct 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbBhb5LM"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8735D1E0DFE;
	Tue, 28 Oct 2025 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761664474; cv=none; b=SToTtHU2u+Yd+PG9GL5npnc/s55CxmzLVUuylKgejN6OFBQQxOHG4xKChbhSQkBG/QBs7L8k3Wfgfh6MZxIYVTGjIi1i10IN8lcvICFXRZX2kTbJu6aPOAuCciPBucOBlSc+57RR1zrJc0LlLO6Fwt+0efwVegmLl0eFji64Rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761664474; c=relaxed/simple;
	bh=mDhgGul5hx4gdszSsYNQpFYjmNebb6wxY38Qp+v8G9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LNyxASWAdDw/w9maXAgOOMgt4AKd9AcnV7a+HCpw/THW6bW0S7bR37MNPNdn2RoEUz5C9/XzgEeoB5LhJyIAj1iAnZCEpG188vEHKeQn6k78L7ObFvFabY+hnpdrCUgdBHmjNw7I1LgDbAEQNtsdqoiDgDMKFnCKFWNWTjYKQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbBhb5LM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B25EC4CEE7;
	Tue, 28 Oct 2025 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761664474;
	bh=mDhgGul5hx4gdszSsYNQpFYjmNebb6wxY38Qp+v8G9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbBhb5LMDypnzhM3erO305HwnsEZWP9KQF7Fc+xB5TOvs1lfdqJIGZJ817bufANA7
	 1FICaVp2ohB+0de0/hyJnhEbn6Z3IuQjSTXNkiu+hnasiGa2PErCis44RZLcV68OfY
	 Jgl0J8e2F48RwX3ZlTfk9TA+nOA1RFGiwwZk2fIerdD63Bc7eXQGMfJ6Vat/sn3+gW
	 hxGhcyOH5WTSiNv/aQhhULmujsHp0K2bCA5swNJWgguUNvOxDW4ZmJqy/8BObNrWxv
	 MtvQ1EKUr8q99XGEoY3dYlG+MV6YsUGKujkMBOL0b4Ouu9OTBWFzY7sCrfb9LEe9ju
	 kQ6LV/PCwjiWg==
Date: Tue, 28 Oct 2025 15:14:28 +0000
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
Subject: Re: [PATCH v3] net: sctp: fix KMSAN uninit-value in sctp_inq_pop
Message-ID: <aQDd1OCGOiFt_Ntl@horms.kernel.org>
References: <20251026-kmsan_fix-v3-1-2634a409fa5f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026-kmsan_fix-v3-1-2634a409fa5f@gmail.com>

On Sun, Oct 26, 2025 at 10:03:12PM +0530, Ranganath V N wrote:
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
> Closes: https://syzkaller.appspot.com/bug?extid=d101e12bccd4095460e7
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> KMSAN reported an uninitialized-value access in sctp_inq_pop
> ---
> Changes in v3:
> - fixes the patch format like fixes and closes tags.
> - Link to v2: https://lore.kernel.org/r/20251024-kmsan_fix-v2-1-dc393cfb9071@gmail.com

Thanks for the update. This version looks good to me.
And I assume it is for net.

Reviewed-by: Simon Horman <horms@kernel.org>


