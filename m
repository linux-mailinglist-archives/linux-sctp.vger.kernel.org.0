Return-Path: <linux-sctp+bounces-186-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB17941CB1
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Jul 2024 19:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2EA1C21613
	for <lists+linux-sctp@lfdr.de>; Tue, 30 Jul 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474B0187FF6;
	Tue, 30 Jul 2024 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t59KwHv/"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A701A76C5;
	Tue, 30 Jul 2024 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722359227; cv=none; b=W99Tn2MV/015vrasBgLHcGZhFxceiFNFw+4MUmkUmKQau5WZZFPjop0c3JET9R7lVNF2Drt1KQD9/4DSRjy/gTohfK/r0ieiNinz0BT72Eu/kUwMPO6zMU995I2QTgpxgvBvSYLrfDEZQuAv9ZiEfPI9KgKVWCWejo3sbRnN800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722359227; c=relaxed/simple;
	bh=BwPhz46Pv/9n8O4OUErFxxem5iKGGRE9ZwIWiglNi9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiGmPpvcZm89pMPGJLb2f/lCbqk3BdIWh744G0VY6Q1EtwfPTqPkFm2MwwWmfeOTlvl+4aX9EyEwbdf4kp/1yrvD/gb41EP5Phds7TQS2v1uEQMGwd9DdOVvtvgASSINGgkA7Gh+fM33u7mYPGiZEdk27LM9aVDNu6gz/2EGfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t59KwHv/; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722359226; x=1753895226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PVEEMgnEGtmq8qDlsu0ATVdq0/zoYEoE6s3iFr3FO40=;
  b=t59KwHv/gOlcI/h8p3V+ZGh3Sxe5sMpIW3NC2wjdbhsPUyrAtviIfcdl
   cxMCUY8XOAKgjnn0LsaQ9dkfxiTNNtNAvM0TLf0PtIrsnw2+9aS/Q+CrL
   XKB1USBLR64Bhj1QclgNsgzvSwl27V/trOgjWNOlxaKjQNjSZBEzXxTjF
   A=;
X-IronPort-AV: E=Sophos;i="6.09,248,1716249600"; 
   d="scan'208";a="439533385"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:07:00 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:40907]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.1:2525] with esmtp (Farcaster)
 id 64da0d9d-a7e3-42c5-889f-ea875c6e43ab; Tue, 30 Jul 2024 17:06:59 +0000 (UTC)
X-Farcaster-Flow-ID: 64da0d9d-a7e3-42c5-889f-ea875c6e43ab
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 17:06:59 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 17:06:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <dmantipov@yandex.ru>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <linux-sctp@vger.kernel.org>,
	<lucien.xin@gmail.com>, <marcelo.leitner@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+e6979a5d2f10ecb700e4@syzkaller.appspotmail.com>
Subject: Re: [PATCH v1 net] sctp: Fix null-ptr-deref in reuseport_add_sock().
Date: Tue, 30 Jul 2024 10:06:46 -0700
Message-ID: <20240730170646.62951-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240730134605.297494-1-dmantipov@yandex.ru>
References: <20240730134605.297494-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA001.ant.amazon.com (10.13.139.45) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Dmitry Antipov <dmantipov@yandex.ru>
Date: Tue, 30 Jul 2024 16:46:05 +0300
> Hm. Note both 'reuseport_add_sock()' and 'reuseport_detach_sock()' uses
> global 'reuseport_lock' internally. So what about using read lock to protect
> 'sctp_for_each_entry()' loop and upgrade to write lock only if hash bucket
> should be actually updated? E.g.:
> 
> diff --git a/net/sctp/input.c b/net/sctp/input.c
> index 17fcaa9b0df9..4fbff388b1b4 100644
> --- a/net/sctp/input.c
> +++ b/net/sctp/input.c
> @@ -735,6 +735,7 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
>  	struct sock *sk = ep->base.sk;
>  	struct net *net = sock_net(sk);
>  	struct sctp_hashbucket *head;
> +	int err = 0;
>  
>  	ep->hashent = sctp_ep_hashfn(net, ep->base.bind_addr.port);
>  	head = &sctp_ep_hashtable[ep->hashent];
> @@ -743,11 +744,14 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
>  		bool any = sctp_is_ep_boundall(sk);
>  		struct sctp_endpoint *ep2;
>  		struct list_head *list;
> -		int cnt = 0, err = 1;
> +		int cnt = 0;
> +
> +		err = 1;
>  
>  		list_for_each(list, &ep->base.bind_addr.address_list)
>  			cnt++;
>  
> +		read_lock(&head->lock);
>  		sctp_for_each_hentry(ep2, &head->chain) {
>  			struct sock *sk2 = ep2->base.sk;
>  
> @@ -760,25 +764,30 @@ static int __sctp_hash_endpoint(struct sctp_endpoint *ep)
>  						    sctp_sk(sk), cnt);
>  			if (!err) {
>  				err = reuseport_add_sock(sk, sk2, any);
> -				if (err)
> -					return err;
> +				if (err) {
> +					read_unlock(&head->lock);
> +					goto out;
> +				}
>  				break;
>  			} else if (err < 0) {
> -				return err;
> +				read_unlock(&head->lock);
> +				goto out;
>  			}
>  		}
> +		read_unlock(&head->lock);
>  
>  		if (err) {
>  			err = reuseport_alloc(sk, any);

What happens if two sockets matching each other reach here ?

There would be no error but the first hashed socket will be silently
dead as lookup stops at the 2nd sk ?


>  			if (err)
> -				return err;
> +				goto out;
>  		}
>  	}
>  
>  	write_lock(&head->lock);
>  	hlist_add_head(&ep->node, &head->chain);
>  	write_unlock(&head->lock);
> -	return 0;
> +out:
> +	return err;
>  }
>  
>  /* Add an endpoint to the hash. Local BH-safe. */
> 
> Dmitry

