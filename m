Return-Path: <linux-sctp+bounces-1260-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UkWrKFDcL2ouIAUAu9opvQ
	(envelope-from <linux-sctp+bounces-1260-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 13:04:48 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5656858F5
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 13:04:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gIP2phMA;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1260-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1260-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05989300C015
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED5A3E274D;
	Mon, 15 Jun 2026 11:04:38 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274C2184524;
	Mon, 15 Jun 2026 11:04:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781521478; cv=none; b=qgrM1s1WHbvhvnUQcNgF8GxqKi8c5LWOUX7VDIEVd9rnUaNknXJTHdwiEPnOoNTjk1O8fzNlShaxLopBtW3iulHLPtHDz7ZWOsU1Re8EnMnngtC0oVbBuzmXI0s8siR60cKutEEuNBwhxRMEkji6R6sGdbxNSF64Ra+v1PQmzUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781521478; c=relaxed/simple;
	bh=LGFZYlwtFUjYOoGIPlj99bcTUkCYljLg6LEyaCpWaH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJPK6ZgzoEgAPICcsKxN+dOLZ+GBeV4J1yfB+M/kidNXSpTH5Tssj0eAUmZDSsjovxn1LPlfz7Wmec3Ujm5l5qEcPKAVBsaBb3zNptVqmCgWuqaOZ1/BescZLKFK+fSmHnFK16DeNK4TEQ303zzujK2dijUWD1w5vJMPnyyb1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIP2phMA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B366A1F000E9;
	Mon, 15 Jun 2026 11:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781521476;
	bh=k17Q1r8PFXZh1xa77/C5cYwnq/wQ3L9dzO4gyrjHwO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIP2phMALxM6PhidrUGxUwM+wRDITWsWwf6N6OVGcpSLFOvLrPzEI/PY4ZfjuIJSw
	 feJ0eb4u6MW+Wx3M3y7Yf4gvaDwHCv8m0r++wC3pi6EZ5ut22ZnZ///cS7n4x6MEiB
	 5FzbgnU8NRF7QX/+7mscHaZp/a6ZpaIiS3c566bD2TH673Gv8suPmtCQrMMDImw8CX
	 NBZqJrjr3bUkgfaE837TUcbbe75UBitYzOW97Ycnsa9j1zFjln1KliPWj5FVXxihGY
	 yx1AXvDhvjqeiU2noe3zHAkhcPx08j5J1KAYHQi9uaY++uEcwC2o1ib1ospPpX1qh8
	 XYwzKw+gDKprQ==
From: Simon Horman <horms@kernel.org>
To: lucien.xin@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	marcelo.leitner@gmail.com,
	w@1wt.eu,
	zdi-disclosures@trendmicro.com
Subject: Re: [PATCH net] sctp: hold socket lock when dumping endpoints in sctp_diag
Date: Mon, 15 Jun 2026 12:04:03 +0100
Message-ID: <20260615110402.753443-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
References: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1260-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:w@1wt.eu,m:zdi-disclosures@trendmicro.com,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,gmail.com,1wt.eu,trendmicro.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-sctp@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E5656858F5

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
sctp: hold socket lock when dumping endpoints in sctp_diag

This change reworks SCTP_DIAG endpoint dumping so the socket lock is held
across inet_sctp_diag_fill() to keep the bind address list stable, and
moves position tracking into sctp_for_each_endpoint() which now drops the
bucket read_lock_bh() before invoking the callback.

A few questions on the new iterator and dump callback below.

> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index d758f5c3e06e..9108272ca527 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
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

[Low]
The new unconditional skip on sctp_sstate(sk, CLOSED) does not appear to
be described in the changelog.

SCTP_SS_CLOSED maps to TCP_CLOSE, so a userspace caller that asks for
TCPF_CLOSE in idiag_states will silently receive nothing from the
endpoint hash for entries in that state.

Most hashed endpoints are LISTENING (sctp_hash_endpoint() is called from
sctp_listen_start() right after inet_sk_set_state(sk, SCTP_SS_LISTENING))
so the practical effect is small, but is the intent to filter teardown
windows (in which case ep->base.dead might be a more direct check) or to
honour the user-requested idiag_states bitmask?  Either way, would it be
worth calling this behaviour change out in the commit message?

>  
> -	if (cb->args[4] < cb->args[1])
> -		goto next;
> -
> -	if (!(r->idiag_states & TCPF_LISTEN) && !list_empty(&ep->asocs))
> -		goto next;
> +	if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
> +	    !list_empty(&ep->asocs))
> +		goto out;

[ ... ]

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

[Low]
The commit message states that args[4] tracking is removed, but the
asocs-phase comment block still lists:

	 * 4 : to work as a temporary variable to traversal list

and the trailing epilogue still does:

	cb->args[1] = cb->args[4];
	cb->args[4] = 0;

Are those leftovers from the eps-phase rewrite, or are they still needed
by the asocs phase?  If args[4] is genuinely gone, should the comment
and the epilogue be cleaned up too?

The previous comment also listed:

	 * 5 : to save the sk we get from travelsing the tsp list.

which is dropped here without further mention.  Is args[5] confirmed
unused on the asocs path?

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

[Critical]
Can ep be freed before this cb(ep, p) call?

The bucket read_lock_bh() is dropped above, and only sock_hold(sk) is
taken.  In sctp_endpoint_init() the reference direction is
ep -> sk:

	refcount_set(&ep->base.refcnt, 1);
	...
	sock_hold(sk);

so taking sock_hold(sk) does not pin ep.

A concurrent close(2) on the same socket runs:

  sctp_close()
    -> release_sock()                  /* lock_sock dropped here */
    -> sk_common_release()
       -> sctp_destroy_sock()
          -> sctp_endpoint_free()
             -> sctp_unhash_endpoint()
             -> sctp_endpoint_put()    /* refcount may reach 0 */
                -> call_rcu(&ep->rcu, sctp_endpoint_destroy_rcu)

The destroy callback then does sctp_sk(sk)->ep = NULL; sock_put(sk);
kfree(ep).

Between read_unlock_bh() and cb(ep, p), this iterator is no longer in
any RCU read-side section, and sctp_ep_dump() then calls lock_sock(sk)
which may sleep.  That allows an RCU grace period to elapse before the
callback dereferences ep at:

	struct sock *sk = ep->base.sk;
	...
	if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
	    !list_empty(&ep->asocs))

The sibling helpers in the same file pin the endpoint explicitly to
avoid this:

  sctp_transport_traverse_process()
	if (sctp_endpoint_hold(ep)) { /* asoc can be peeled off */
		ret = cb(ep, tsp, p);
		...
		sctp_endpoint_put(ep);
	}

Should sctp_for_each_endpoint() take sctp_endpoint_hold(ep) inside the
bucket read_lock_bh() (while ep is still hashed and live) and a matching
sctp_endpoint_put(ep) after cb returns?

[Medium]
Can this restart pattern miss or duplicate endpoints when the bucket is
modified concurrently?

After processing one ep the loop does:

			idx = start;
			goto again;

which re-walks the bucket from the head and uses the running counter
idx compared against *pos to skip already-emitted entries.

__sctp_hash_endpoint() inserts at the hlist head and
__sctp_unhash_endpoint() can delete arbitrary nodes, both under the
bucket write_lock that this iterator releases between walks.  A
concurrent listen() on a sibling endpoint shifts every existing entry's
index by +1, and a concurrent close() before the cursor shifts indices
by -1.

Under that pattern, can SCTP_DIAG consumers observe duplicated
endpoints (the previously-emitted entry now sits at the new *pos) or
miss live endpoints (the next un-emitted entry is shifted past the
cursor)?  The pre-patch sweep walked each bucket once with read_lock_bh
held throughout, so this consistency window did not exist.

[Low]
For a bucket that contains N matching endpoints, does this restart
pattern walk the bucket O(N^2) times?

For a bucket {A,B,C} starting from *pos=0 the goto-again loop performs
1+2+3 traversals to dump three entries plus a final 3-entry walk that
finds nothing and terminates with sk == NULL, which is nine list
iterations to dump three endpoints.  The pre-patch code walked each
bucket exactly once because the callback ran while still holding
read_lock_bh().

The commit message describes the change as simplifying endpoint
traversal; could the description also note the new per-bucket scan
cost, or could a cursor that survives unlock/relock be used instead?

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

