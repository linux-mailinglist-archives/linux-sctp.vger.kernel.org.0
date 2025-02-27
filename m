Return-Path: <linux-sctp+bounces-365-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A80A478AE
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 10:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76A7188B335
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Feb 2025 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D21022618F;
	Thu, 27 Feb 2025 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVx082+a"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1266A1EB5F3;
	Thu, 27 Feb 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647175; cv=none; b=ej8c+BB5QZ25V5JWS+tTemc/bHhy781h3jejSDJqFjiP3WLngqWZ1qk689EEFnxgnq26avNr77AAtB6jMDG5c1EQnClQgk4s/piz2JkKT74lDq6m66K3eW3ejz6F7wZ+PAS2c/AW8OMsNuDNO39q1qEvVFat3pZFvT3vcYBAJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647175; c=relaxed/simple;
	bh=N1M+rRf2NUE4/xDm4cfzB4S+xLOeRa/qlHLE5rAdoGQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BUn801RbioFSG6Eh6frH1HscBUZnG7wv4C0ZkrUifucATKdU8ScOo2JolLyQu0mnv/W7F7iRc92W7F/qruvECtnUqm25rpo2uFKnBVAcmKOsUmg8fElj3CLuqkfdS7VpiPrBOwK28GKct5KqmSmyOEmQryuWcVu9UqsegWnL6xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVx082+a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06683C4CEDD;
	Thu, 27 Feb 2025 09:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740647174;
	bh=N1M+rRf2NUE4/xDm4cfzB4S+xLOeRa/qlHLE5rAdoGQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=WVx082+a/Iiau0I6vbuA3qUcYZM6r2OT/SsccLf/31pd/Afm6BVndj23L4TRxCg90
	 4n6pbSpVfcJuBANbftkZfMHZDiTmoGdI94TQhlDRM5UMgf99oUO6GDL0JYGvvf1Jun
	 J4kQbP0P6VDvR5rH4BgFR5Mf477FjMUzOK3AefhCCHcpyyZb7buqS2nyd5sJxPh2up
	 f0ng3SuchXUESroJwvAxluTB3GwdO8fP6jKrwLezJ9zCAsnIxLgMRZWysEq5EX5t+n
	 5n27nCDyKXpZIOruj1BnHgdfTui1xTfMFco6HWXvIj+75rrBGa5fB2f2xl/bj3/Ipa
	 cJ4bdFET5YG0g==
Message-ID: <89d843e16bd34e760a7ade6f14e46228f1bf56e8.camel@kernel.org>
Subject: Re: [PATCH net-next 4/4] net/tcp_ao: use sock_kmemdup for tcp_ao_key
From: Geliang Tang <geliang@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, David Ahern
 <dsahern@kernel.org>,  Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Marcelo Ricardo Leitner
 <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, Geliang Tang
 <tanggeliang@kylinos.cn>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-sctp@vger.kernel.org
Date: Thu, 27 Feb 2025 17:04:35 +0800
In-Reply-To: <CANn89i+ZLAPPKVCzAMrchJBvisiOsEZyVN-TqGUkEH8EFApbpQ@mail.gmail.com>
References: <cover.1740643844.git.tanggeliang@kylinos.cn>
	 <38054b456a54cc5c7628c81a42816a770f0bff27.1740643844.git.tanggeliang@kylinos.cn>
	 <CANn89i+ZLAPPKVCzAMrchJBvisiOsEZyVN-TqGUkEH8EFApbpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-02-27 at 09:35 +0100, Eric Dumazet wrote:
> On Thu, Feb 27, 2025 at 9:24 AM Geliang Tang <geliang@kernel.org>
> wrote:
> > 
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> > 
> > Instead of using sock_kmalloc() to allocate a tcp_ao_key "new_key"
> > and
> > then immediately duplicate the input "key" to it in
> > tcp_ao_copy_key(),
> > the newly added sock_kmemdup() helper can be used to simplify the
> > code.
> > 
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> >  net/ipv4/tcp_ao.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
> > index bbb8d5f0eae7..d21412d469cc 100644
> > --- a/net/ipv4/tcp_ao.c
> > +++ b/net/ipv4/tcp_ao.c
> > @@ -246,12 +246,11 @@ static struct tcp_ao_key
> > *tcp_ao_copy_key(struct sock *sk,
> >  {
> >         struct tcp_ao_key *new_key;
> > 
> > -       new_key = sock_kmalloc(sk, tcp_ao_sizeof_key(key),
> > +       new_key = sock_kmemdup(sk, key, tcp_ao_sizeof_key(key),
> >                                GFP_ATOMIC);
> >         if (!new_key)
> >                 return NULL;
> > 
> > -       *new_key = *key;
> 
> Note that this only copies 'sizeof(struct tcp_ao_key)' bytes, which
> is
> smaller than tcp_ao_sizeof_key(key)

Yes, indeed. sock_kmemdup() shouldn't be used here then. I'll drop this
patch in v2.

Thanks,
-Geliang


