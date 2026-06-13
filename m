Return-Path: <linux-sctp+bounces-1258-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SQcOCIYCLWruYwQAu9opvQ
	(envelope-from <linux-sctp+bounces-1258-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 13 Jun 2026 09:11:02 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D7E67DEEA
	for <lists+linux-sctp@lfdr.de>; Sat, 13 Jun 2026 09:11:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=1wt.eu header.s=mail header.b=hypIbiDp;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1258-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1258-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=1wt.eu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEF473027327
	for <lists+linux-sctp@lfdr.de>; Sat, 13 Jun 2026 07:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875DB378826;
	Sat, 13 Jun 2026 07:10:56 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C820344D88;
	Sat, 13 Jun 2026 07:10:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781334656; cv=none; b=EVpq1SoSdak2DdcyZOcZeilCtQARsmiQzz3aGqA05yU1Dt33NKnLiihBZAjPbPm+fmsWA54c8pnlCZqqhvprt7iKsp8jhtgeXkVThn993Xnn7GLPQZq01Qdd0Er9YsN1ij5SGHuPhtP/AX1wQzXSb4gguEvoxes6oakJNRJLnTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781334656; c=relaxed/simple;
	bh=3grw9kduE84khsituwhL+xJYIsTlUiGUY48mFXYqFSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPJj6oLU/UVkbZYzpdoupsA0/EzGVSNqQ7cO3wzrstNbe3ut+m1IRjonwSrY3UvWHdvWXjKsZ1pB4E7Qi6yotiYFwImY248Tm53lt4RgZuxZCQILEGaVe7spi78PKbgdQYx1nHCcXpu6DkEnVHBBooejClEoEedM/ec0QMosqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=hypIbiDp; arc=none smtp.client-ip=51.159.59.229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1781334642; bh=gpYoA8lpO7RMfPMs7ezgWwqtS0fIqQiPHRJM2IuWZzs=;
	h=From:Message-ID:From;
	b=hypIbiDpH0jNWBYm2+4r2Izcamp2ANYFSukrIIsga8lzRWyFncAqwHNU2Rw9/EUPE
	 WUoKoYNVqqSc3Wd3Sw80HHg03OF9kawJo3+xUpp9ex1I17htqujBBITwVuU6TBKUxf
	 ZZTdjdHHUS+1iYnmkKs71hzD3KQWv9QWt48Wvgt0=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 724B5C0AD2;
	Sat, 13 Jun 2026 09:10:42 +0200 (CEST)
Date: Sat, 13 Jun 2026 09:10:41 +0200
From: Willy Tarreau <w@1wt.eu>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <horms@kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Zero Day Initiative <zdi-disclosures@trendmicro.com>
Subject: Re: [PATCH net] sctp: hold socket lock when dumping endpoints in
 sctp_diag
Message-ID: <ai0CcdDCkhBO_RF2@1wt.eu>
References: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1258-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:zdi-disclosures@trendmicro.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,trendmicro.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[w@1wt.eu,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[1wt.eu:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1wt.eu:dkim,1wt.eu:mid,1wt.eu:from_mime,trendmicro.com:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84D7E67DEEA

Hi,

On Fri, Jun 12, 2026 at 01:59:38PM -0400, Xin Long wrote:
> SCTP_DIAG endpoint dumping currently walks the endpoint hash table
> without taking the socket lock before calling inet_sctp_diag_fill().
> 
> This is problematic because inet_sctp_diag_fill() eventually calls
> inet_diag_msg_sctpladdrs_fill(), which traverses the endpoint's local
> address list twice: once to count entries for nla_reserve(), and once
> again to copy the addresses into the netlink buffer.
> 
> Since these two traversals are protected only by separate RCU read-side
> critical sections, concurrent socket operations such as
> SCTP_SOCKOPT_BINDX_REM may remove entries from the address list between
> them. In that case, the number of copied addresses becomes smaller than
> the originally reserved buffer size, leaving part of the netlink payload
> uninitialized and potentially leaking kernel memory to user space.
> 
> Fix this by changing sctp_for_each_endpoint() to iterate with net and
> position awareness while taking a reference on each socket, then release
> the endpoint hash bucket read_lock_bh() before invoking the callback.
> 
> A socket reference is required because the callback acquires lock_sock(),
> which must be called outside of read_lock_bh() since lock_sock() may
> sleep. Holding a socket reference ensures the socket remains valid after
> dropping the bucket lock and before acquiring the socket lock.
> 
> With the socket lock held, concurrent bind-address modifications are
> serialized against the diagnostic dump, ensuring the local address list
> remains stable during buffer sizing and initialization.
> 
> This also simplifies endpoint traversal by removing the temporary
> callback local position tracking args[4] and moving dump progress
> tracking into sctp_for_each_endpoint() itself.
> 
> While at it, fix the idiag_states check in sctp_ep_dump() and skip ep
> dumping when non LISTEN|CLOSE states are also requested and the ep has
> assocs, since such cases will be handled later by sctp_sock_dump().
> 
> Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>

Please note that the original report suggested this reporter:

   Nico Yip (@_cyeaa_) working with TrendAI Zero Day Initiative

> Fixes: 8f840e47f190 ("sctp: add the sctp_diag.c file")
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  include/net/sctp/sctp.h |  3 +-
>  net/sctp/diag.c         | 62 +++++++++++++++++++----------------------
>  net/sctp/socket.c       | 34 +++++++++++++++++-----
>  3 files changed, 57 insertions(+), 42 deletions(-)
> 
> diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> index 58242b37b47a..cd82b05354a3 100644
> --- a/include/net/sctp/sctp.h
> +++ b/include/net/sctp/sctp.h
> @@ -111,7 +111,8 @@ int sctp_transport_lookup_process(sctp_callback_t cb, struct net *net,
>  				  const union sctp_addr *paddr, void *p, int dif);
>  int sctp_transport_traverse_process(sctp_callback_t cb, sctp_callback_t cb_done,
>  				    struct net *net, int *pos, void *p);
> -int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *), void *p);
> +int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
> +			   struct net *net, int *pos, void *p);
>  int sctp_get_sctp_info(struct sock *sk, struct sctp_association *asoc,
>  		       struct sctp_info *info);
>  
> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index d758f5c3e06e..9108272ca527 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -92,6 +92,7 @@ static int inet_diag_msg_sctpladdrs_fill(struct sk_buff *skb,
>  		if (!--addrcnt)
>  			break;
>  	}
> +	WARN_ON_ONCE(addrcnt);
>  	rcu_read_unlock();
>  
>  	return 0;
> @@ -373,42 +374,36 @@ static int sctp_ep_dump(struct sctp_endpoint *ep, void *p)
>  	struct sk_buff *skb = commp->skb;
>  	struct netlink_callback *cb = commp->cb;
>  	const struct inet_diag_req_v2 *r = commp->r;
> -	struct net *net = sock_net(skb->sk);
>  	struct inet_sock *inet = inet_sk(sk);
>  	int err = 0;
>  
> -	if (!net_eq(sock_net(sk), net))
> +	lock_sock(sk);
> +	if (sctp_sstate(sk, CLOSED))
>  		goto out;
>  
> -	if (cb->args[4] < cb->args[1])
> -		goto next;
> -
> -	if (!(r->idiag_states & TCPF_LISTEN) && !list_empty(&ep->asocs))
> -		goto next;
> +	if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
> +	    !list_empty(&ep->asocs))
> +		goto out;
>  
>  	if (r->sdiag_family != AF_UNSPEC &&
>  	    sk->sk_family != r->sdiag_family)
> -		goto next;
> +		goto out;
>  
>  	if (r->id.idiag_sport != inet->inet_sport &&
>  	    r->id.idiag_sport)
> -		goto next;
> +		goto out;
>  
>  	if (r->id.idiag_dport != inet->inet_dport &&
>  	    r->id.idiag_dport)
> -		goto next;
> -
> -	if (inet_sctp_diag_fill(sk, NULL, skb, r,
> -				sk_user_ns(NETLINK_CB(cb->skb).sk),
> -				NETLINK_CB(cb->skb).portid,
> -				cb->nlh->nlmsg_seq, NLM_F_MULTI,
> -				cb->nlh, commp->net_admin) < 0) {
> -		err = 2;
>  		goto out;
> -	}
> -next:
> -	cb->args[4]++;
> +
> +	err = inet_sctp_diag_fill(sk, NULL, skb, r,
> +				  sk_user_ns(NETLINK_CB(cb->skb).sk),
> +				  NETLINK_CB(cb->skb).portid,
> +				  cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +				  cb->nlh, commp->net_admin);
>  out:
> +	release_sock(sk);
>  	return err;
>  }
>  
> @@ -479,41 +474,40 @@ static void sctp_diag_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  		.r = r,
>  		.net_admin = netlink_net_capable(cb->skb, CAP_NET_ADMIN),
>  	};
> -	int pos = cb->args[2];
> +	int pos;
>  
>  	/* eps hashtable dumps
>  	 * args:
>  	 * 0 : if it will traversal listen sock
>  	 * 1 : to record the sock pos of this time's traversal
> -	 * 4 : to work as a temporary variable to traversal list
>  	 */
>  	if (cb->args[0] == 0) {
> -		if (!(idiag_states & TCPF_LISTEN))
> -			goto skip;
> -		if (sctp_for_each_endpoint(sctp_ep_dump, &commp))
> -			goto done;
> -skip:
> +		if (idiag_states & TCPF_LISTEN) {
> +			pos = cb->args[1];
> +			if (sctp_for_each_endpoint(sctp_ep_dump, net, &pos,
> +						   &commp)) {
> +				cb->args[1] = pos;
> +				return;
> +			}
> +		}
>  		cb->args[0] = 1;
>  		cb->args[1] = 0;
> -		cb->args[4] = 0;
>  	}
>  
> +	if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> +		return;
> +
>  	/* asocs by transport hashtable dump
>  	 * args:
>  	 * 1 : to record the assoc pos of this time's traversal
>  	 * 2 : to record the transport pos of this time's traversal
>  	 * 3 : to mark if we have dumped the ep info of the current asoc
>  	 * 4 : to work as a temporary variable to traversal list
> -	 * 5 : to save the sk we get from travelsing the tsp list.
>  	 */
> -	if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> -		goto done;
> -
> +	pos = cb->args[2];
>  	sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
>  					net, &pos, &commp);
>  	cb->args[2] = pos;
> -
> -done:
>  	cb->args[1] = cb->args[4];
>  	cb->args[4] = 0;
>  }
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 66e12fb0c646..1ed405dedc01 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -5369,24 +5369,44 @@ struct sctp_transport *sctp_transport_get_idx(struct net *net,
>  }
>  
>  int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
> -			   void *p) {
> -	int err = 0;
> -	int hash = 0;
> -	struct sctp_endpoint *ep;
> +			   struct net *net, int *pos, void *p) {
> +	int err, hash = 0, idx = 0, start;
>  	struct sctp_hashbucket *head;
> +	struct sctp_endpoint *ep;
> +	struct sock *sk;
>  
>  	for (head = sctp_ep_hashtable; hash < sctp_ep_hashsize;
>  	     hash++, head++) {
> +		start = idx;
> +again:
> +		sk = NULL;
>  		read_lock_bh(&head->lock);
>  		sctp_for_each_hentry(ep, &head->chain) {
> -			err = cb(ep, p);
> -			if (err)
> +			if (sock_net(ep->base.sk) != net)
> +				continue;
> +			if (idx++ >= *pos) {
> +				sk = ep->base.sk;
> +				sock_hold(sk);
>  				break;
> +			}
>  		}
>  		read_unlock_bh(&head->lock);
> +
> +		if (sk) {
> +			err = cb(ep, p);
> +			if (err) {
> +				sock_put(sk);
> +				return err;
> +			}
> +			sock_put(sk);
> +			(*pos)++;
> +
> +			idx = start;
> +			goto again;
> +		}
>  	}
>  
> -	return err;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(sctp_for_each_endpoint);
>  
> -- 
> 2.47.1

