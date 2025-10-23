Return-Path: <linux-sctp+bounces-689-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BCEC03E73
	for <lists+linux-sctp@lfdr.de>; Fri, 24 Oct 2025 01:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F6723B5822
	for <lists+linux-sctp@lfdr.de>; Thu, 23 Oct 2025 23:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806E2E22BF;
	Thu, 23 Oct 2025 23:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k4wVXkmy"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A24C254876
	for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 23:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761263583; cv=none; b=kPbKbOsHoAn6RaNwH5/pdxZbB6hQ1FCw+8E4Xa2EKAuRakgNC2100pLriYeJydC5Tpfx5IISVbxTBrolBKJcZeM4HeVarHJuw49EcTB0haLAeHb3Lp9UHLJUHS5mbdcqbsScyXOZrU2HrAr/F8/JrJuX1RbC9tXbhXiY0LF3gnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761263583; c=relaxed/simple;
	bh=AT3+wNihqmSYhjuBv/jofqfpVzIh8fFWtMB1yLIwi3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g17zu8KE1vefcPW+FMI6lIKLN8khbtjAYVY5ES4HutxNoj4sj/Qt99qD125nLs2LrhB0osmLyz6pNRimHsym4RTOryOhpX6quD+r5xaKV6SLG0ncx719We4Ohx0OSCxy/mURkrm5ylId3WDUuTcKEAXoiMjByje+lOiE45cunJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k4wVXkmy; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so2405527a91.3
        for <linux-sctp@vger.kernel.org>; Thu, 23 Oct 2025 16:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761263580; x=1761868380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eo2oCT09CGUkGtiJETLA5OKUbDW0FKSCX+nZlCeQsGg=;
        b=k4wVXkmyhyqE9l48IJCLR9XPDG1UoTKsy9jmc5uMJFWTWMywf+DoPWrg2gHCuuqVYr
         LeCUKQ6rVFOZ3IdqCgaf3gLEP+R6kAeYJ6vru8xogcHofAqs0i3RcTgtq150S9d8f6c/
         ysCzsBZGiS4S4Si6DGe2UgqUevd6olZ/o8vgLrI0tZQBYM6rBecHctibwKw6pZMIvTnD
         bQCwq3C6wXXs9Ao6TuO3Hmia2d7HcQiTZGQkXahVHFrXFxzFXOxmi0Wp2prR6ih4UUyG
         T874NM7LkFEuXMv2a21EohwkciFnboHNC/4y9dZQ5fQzxhBkAn3W1viKYTEXDM5jfsKn
         J6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761263580; x=1761868380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eo2oCT09CGUkGtiJETLA5OKUbDW0FKSCX+nZlCeQsGg=;
        b=Y/j2IW3JyeVsS/6t12IjA3YwuqioOfce/6Bd6GnqRAi4nWDD0fe9ItyiVj6uM7U+J5
         a8nztgdMZlYHsR+ELbJkL6O76mQzYiZZ2UrlaEYa0Saqr7AsczeKm5R/P/eZPoCbUXYL
         pakLK1UVqfyg0XIQUy8R3ntzVH3mLwoF0qjLeuLyj8B8RIuDpMSOwzdpf9Qjwu/cF6US
         9Bo7+KJ1IEEu4/KLiQvP0sUZ2kEoDg49MfOICVSO7NHbo1ImnH8ty7xDpWbKQlQxYdWw
         FjxpV9gDJd9LroSzp6tcZIGY9HMSUVrsV+7Jb3xWc9HykdkO7rAGFFWYUSsN5sjtOko9
         jByg==
X-Forwarded-Encrypted: i=1; AJvYcCXpg9Rzqwua/lbo4O1ODcmgXosRSCyBrUaI1Fu00hHCWnp24TurD/tmspJGNGs23ZDMjf4rEaA4J/2B@vger.kernel.org
X-Gm-Message-State: AOJu0YyV74mL3syamhqo34f/ebnPNB6auwXNeE/PNyHp1l70fiGaP0y2
	80bBaig4mavkO/3U4IG7P822Ry7hsvQ6NeFkXTlV/11WUHWDJduegzMxhrGY8Ba/vcMv2FDHAa/
	BfevaQQ==
X-Google-Smtp-Source: AGHT+IEQOeSykRo4Rj5MaMzLbvjbffFfTFsbM/EOLn0WBNXCeu8l+VNyetqRrDtzeRuqnAV/p+uqxvFuzh4=
X-Received: from pjbsd7.prod.google.com ([2002:a17:90b:5147:b0:33b:b3b8:216b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5105:b0:32e:e3af:45f6
 with SMTP id 98e67ed59e1d1-33bcf87b6a4mr33427079a91.10.1761263580523; Thu, 23
 Oct 2025 16:53:00 -0700 (PDT)
Date: Thu, 23 Oct 2025 23:52:38 +0000
In-Reply-To: <20251023191807.74006-2-stefan.wiehler@nokia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023191807.74006-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251023235259.4179388-1-kuniyu@google.com>
Subject: Re: [PATCH net] sctp: Hold RCU read lock while iterating over address list
From: Kuniyuki Iwashima <kuniyu@google.com>
To: stefan.wiehler@nokia.com
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	lucien.xin@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	kuniyu@google.com
Content-Type: text/plain; charset="UTF-8"

From: Stefan Wiehler <stefan.wiehler@nokia.com>
Date: Thu, 23 Oct 2025 21:18:08 +0200
> With CONFIG_PROVE_RCU_LIST=y and by executing
> 
>   $ netcat -l --sctp &
>   $ netcat --sctp localhost &
>   $ ss --sctp
> 
> one can trigger the following Lockdep-RCU splat(s):
> 
>   WARNING: suspicious RCU usage
>   6.18.0-rc1-00093-g7f864458e9a6 #5 Not tainted
>   -----------------------------
>   net/sctp/diag.c:76 RCU-list traversed in non-reader section!!
> 
>   other info that might help us debug this:
> 
>   rcu_scheduler_active = 2, debug_locks = 1
>   2 locks held by ss/215:
>    #0: ffff9c740828bec0 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{4:4}, at: __netlink_dump_start+0x84/0x2b0
>    #1: ffff9c7401d72cd0 (sk_lock-AF_INET6){+.+.}-{0:0}, at: sctp_sock_dump+0x38/0x200
> 
>   stack backtrace:
>   CPU: 0 UID: 0 PID: 215 Comm: ss Not tainted 6.18.0-rc1-00093-g7f864458e9a6 #5 PREEMPT(voluntary)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x5d/0x90
>    lockdep_rcu_suspicious.cold+0x4e/0xa3
>    inet_sctp_diag_fill.isra.0+0x4b1/0x5d0
>    sctp_sock_dump+0x131/0x200
>    sctp_transport_traverse_process+0x170/0x1b0
>    ? __pfx_sctp_sock_filter+0x10/0x10
>    ? __pfx_sctp_sock_dump+0x10/0x10
>    sctp_diag_dump+0x103/0x140
>    __inet_diag_dump+0x70/0xb0
>    netlink_dump+0x148/0x490
>    __netlink_dump_start+0x1f3/0x2b0
>    inet_diag_handler_cmd+0xcd/0x100
>    ? __pfx_inet_diag_dump_start+0x10/0x10
>    ? __pfx_inet_diag_dump+0x10/0x10
>    ? __pfx_inet_diag_dump_done+0x10/0x10
>    sock_diag_rcv_msg+0x18e/0x320
>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x4d/0x100
>    netlink_unicast+0x1d7/0x2b0
>    netlink_sendmsg+0x203/0x450
>    ____sys_sendmsg+0x30c/0x340
>    ___sys_sendmsg+0x94/0xf0
>    __sys_sendmsg+0x83/0xf0
>    do_syscall_64+0xbb/0x390
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    ...
>    </TASK>
> 
> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
> ---
> It might be sufficient to add a check for one of the already held locks,
> but I lack the domain knowledge to be sure about that...
> ---
>  net/sctp/diag.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
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
> +	rcu_read_lock();
>  	list_for_each_entry_rcu(laddr, address_list, list) {
>  		memcpy(info, &laddr->a, sizeof(laddr->a));
>  		memset(info + sizeof(laddr->a), 0, addrlen - sizeof(laddr->a));
>  		info += addrlen;

looks like TOCTOU issue exists here, we should check
the boundary like this:

		if (!--addrcnt)
			break;

Otherwise KASAN would complain about an out-of-bound write.

>  	}
> +	rcu_read_unlock();
>  
>  	return 0;
>  }
> -- 
> 2.51.0

