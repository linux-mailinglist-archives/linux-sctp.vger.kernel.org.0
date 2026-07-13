Return-Path: <linux-sctp+bounces-1336-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TwnmHvY7VWo5lwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1336-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 21:26:46 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB0C74EB4E
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 21:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=fqXiV7i9;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1336-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1336-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76624306130F
	for <lists+linux-sctp@lfdr.de>; Mon, 13 Jul 2026 19:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B08356757;
	Mon, 13 Jul 2026 19:26:32 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3EF356747
	for <linux-sctp@vger.kernel.org>; Mon, 13 Jul 2026 19:26:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970792; cv=pass; b=fk3uVbNQw3XQa9M8Jc4Bql7q5TqhvV+ft7kr0p3+DL5I7XIyXHcemki/ixIVAhB5ZsvBRdfBgo4ON4vLDAkk9r7GB06XYZlAf27tlOtoIqIbpTE9kp1EVSV4Tb74C+CwAKW24N+DjwqygAMw0FjBEjm6w4B48p5VsTfbS7WMqiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970792; c=relaxed/simple;
	bh=2KfxiWGglcm4SlXzDjy5ADRqYpBoGXK45/8sDX+KhII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LY6lhFdtMKiVQ83kldAFASOceeJ6EGK+5KvxTmSV6lwaNYCTVOu7LOjhumijooSC0JP3ZQISJF7F6W4T4BRN6/f5kg7zuBWh7A9Gzetvj6yuYmVqud+owEuimyOenToKz3Uuc5zYyGG3Jq4NY2tgWJKwaVXOXUaNh66+wqfcXg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqXiV7i9; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8486672f03cso3130465b3a.0
        for <linux-sctp@vger.kernel.org>; Mon, 13 Jul 2026 12:26:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783970790; cv=none;
        d=google.com; s=arc-20260327;
        b=fcnb/hKvMcwMHVB7txpSQ+iZl8l+s7IdlNpI9FC7zERk5rQ/NsB8or2aa0bVQq3el0
         CexHSmv20K+5EA7UP3j9GHaF7LXoWQDBzwhGrEd53qnoehTzknu+AtCYwzGqujk40T7+
         QhMUtL2/qq41kAeOBuCTVlcsqBGTrA82ZcXXkXnLj4/sgcl5r3Z5SRfbtmziK5lN5ujf
         HLqW9dQa8Qygd9fle+m2ssUinV9FXvsU91xrMJEL8FBzEjy2cmvGGgBb4YrU6cfYvaYX
         tLctcKgOtMr1MMC7W4TF/USSPvIEPZXhx/SMkG8n+w3lvf6gscdoo/098Tn6ch7hLUCi
         K8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GD+aEhZoiO03sz92m3wPJhu7G6KGUOHHc44tI5PLjnE=;
        fh=8W+gF+n6fucp/Dni3kZTiCbiSHBw+4eCoJSbs8/dhlA=;
        b=l8gS+RGu2KGpQqVQi2UfjoDNNLZE9kSwVbhh8HtJ+pE3SwMH1lzSfyw5jK+TLTYmA1
         aqdDQwcaxYlq0TKsZwUtBy9qKAKb7vWXy+enLuChMkj9cEfAa47+d8+HDAFX1v7Znkh3
         wuzIbLUYiXXJhVk3ZcqAN04Z+xMjRq8r2TkqDek131/G29MF2q3gafHnAVmLgw8MNOpI
         3IUVrKuVTsuKjPlKdiOt655Jc27bd/Wl/MUWrLnaugq7YSrbyJIK0nWCFsBahvMKCRLP
         aYprqTd1f4Uv18XhsFDjt7oaWRv8CCAMAMk3QVOxMIbFSIe2pR1lGhyQVR5tk/oqD5tN
         H/fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783970790; x=1784575590; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GD+aEhZoiO03sz92m3wPJhu7G6KGUOHHc44tI5PLjnE=;
        b=fqXiV7i94DBUeWhKiBiKN88qiOpnQbzGc86u6p3y0/J1UqEK6LsruYg8b8yzmTuqGt
         spP6QjNA1GWaqLB/cLVhZEp2zlqneN/2b1KIzy6e5FpvbdONS1/P0xRuqRihI2cnMeJy
         AN+qttWqUfJ8sFgUmhmG3QyQiIWZ+C8oRI4JPuJP2lrQmmQuj42PEb2X5ikUHFvJTwhI
         /wK3Rm8dzpYasxKjg3gsYBmdS/PgJDMbKYZ1+e9+dP2jcaeoTN+aLe8CkBtPeMqFE+ZS
         P2+4vFu+vTHA7rZxlBwR76nCO8CPaAJNh+vqPZzBqiEI8i+jwak2aklA5R+NCP8eXRwL
         Sbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970790; x=1784575590;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GD+aEhZoiO03sz92m3wPJhu7G6KGUOHHc44tI5PLjnE=;
        b=bnvDSuO7NOwXJ0DgimL6ciaFgwcI966SWZVNYBRyfW06UL07BByI5EonRbaCiC3Pmr
         wx3EKGxxTVJR6AvOMmdOf1km6Ql36lxB44J35PNTLw/cqOIk4/trTqCLAAUUGZ7wkvOe
         jm8Go9zm1u5U1JGyN9/2TR3neMwpcDfUlKtw/Ytu1ua/b+YXZy6AF2SrJjnHs6jkvQhU
         p8bRy+mvK96g+ItLPDupjRsS85259SyL2ww028iCQxj1CyrzUCjONVobikwXMcfjK7wj
         V09/fy+NcwEtybgcTKAq4FKnrANI2t0h2K7dM7TcgRxw/ZIlHU3vFFeA00M54u4UXLaA
         ZFkg==
X-Forwarded-Encrypted: i=1; AHgh+RrCcbWZKBtwvR5tzyTWKf/PSkVJFAIQE8n43Qb+zujOKqAY8P4tX7cvmFs4n8TDAAzK4hbPoXdn0ETU@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQvPvgc3yqehNV/vp9LT/HF71dNJcxALf0pQxHOad3giEqgkb
	NEGmu4nMnVbxjZ8xWF34LzmIyVCpx6QrPVbuUsRE7zGxkHLKh9sHhhFOIY9RLtzAWwSE9/Co6Dr
	+MP9/dT7Kc+uzpdVA6+LZZSFAESQO5+I=
X-Gm-Gg: AfdE7ckb/urCAO4dEpJ+73jfmHROl8du9uDUUuNpDfX1n18jHDyOw3FbIfdHob/nlgl
	5ttah/+R53OSYFglmZ/VzNbFgKsQQxJQk1ZjLjoINTI/4/D9CA6ErDyPHdqhPzHBZJMKJXCBqK+
	yt//M9O148tNyEUW+WQpgGCkItGkKCqSPCCB1e7sF+ATPnysFDsXCL8Dmijxq0pKpiCQsoPN1cc
	uJuzZYqf8WVj0NFHmaxci9HYv6d9tPysFFZWjLa0bDbykhL6UjRpWpdgziS+yz7qTp5QYOVT/0V
	TyyoW9cbAQRKIcswXHxCUaA0a8Isgpg/GS5H9w7kFOGiL3zsILjT/pPQUzA2MySEdtdQfm8=
X-Received: by 2002:a05:6a00:18a0:b0:848:8715:c2cd with SMTP id
 d2e1a72fcca58-848896ddc81mr8903357b3a.47.1783970790259; Mon, 13 Jul 2026
 12:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e0076ec046fbd8a70d4f3facfb701473d08c3ebb.1783632513.git.lucien.xin@gmail.com>
In-Reply-To: <e0076ec046fbd8a70d4f3facfb701473d08c3ebb.1783632513.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 13 Jul 2026 15:26:19 -0400
X-Gm-Features: AUfX_mzkg_FY6Z1VCmwDzHq2AqMN8EPaSs1zICFDhV6On-qXe6SqI8cfSFv0cKM
Message-ID: <CADvbK_e92MPvBRryL_c3D52UtfYKBKjgyH4wb2NGmMDCOAKo1A@mail.gmail.com>
Subject: Re: [PATCH net-next] sctp: replace cb->args[4] with a local variable
 in sctp_diag_dump()
To: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-1336-lists,linux-sctp=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EB0C74EB4E

> diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> index c2a0de2adf6f..a9bb31303613 100644
> --- a/net/sctp/diag.c
> +++ b/net/sctp/diag.c
> @@ -299,18 +299,21 @@ static int sctp_sock_dump_one(struct sctp_endpoint *ep, struct sctp_transport *t
>  static int sctp_sock_dump(struct sctp_endpoint *ep, struct sctp_transport *tsp, void *p)
>  {
>       struct sctp_comm_param *commp = p;
> -     struct sock *sk = ep->base.sk;
> +     struct sock *sk = ep->base.sk, *nsk;
>       struct sk_buff *skb = commp->skb;
>       struct netlink_callback *cb = commp->cb;
>       const struct inet_diag_req_v2 *r = commp->r;
> +     u32 portid = NETLINK_CB(cb->skb).portid;
>       struct sctp_association *assoc;
> -     int err = 0;
> +     int err = 0, idx = 0;
> +
> +     nsk = NETLINK_CB(cb->skb).sk;
>
>       lock_sock(sk);
>       if (ep != tsp->asoc->ep)
>               goto release;
Could the peel-off exit here leave stale state in cb->args[1] across
netlink dump sessions?
Prior to this patch, sctp_diag_dump() always executed:
        cb->args[1] = cb->args[4];
        cb->args[4] = 0;
after sctp_transport_traverse_process() returned.  Because cb->args[4]
was only bumped inside the list_for_each_entry loop and was reset to 0
when the loop completed normally, that outer assignment acted as an
unconditional clear of cb->args[1] whenever no traversal was
interrupted.
After the patch, cb->args[1] is only cleared to 0 when the
list_for_each_entry loop in sctp_sock_dump() runs to completion:
>       list_for_each_entry(assoc, &ep->asocs, asocs) {
> -             if (cb->args[4] < cb->args[1])
> +             if (idx < cb->args[1])
>                       goto next;
[ ... ]
>  next:
> -             cb->args[4]++;
> +             idx++;
>       }
>       cb->args[1] = 0;
>       cb->args[3] = 0;
> -     cb->args[4] = 0;
>  release:
>       release_sock(sk);
>       return err;
If a prior session left cb->args[1] = N > 0 and every sctp_sock_dump()
call in the next session hits the early peel-off exit:
        if (ep != tsp->asoc->ep)
                goto release;
then N is never cleared, and a later invocation on an unrelated
endpoint applies "if (idx < cb->args[1]) goto next;" to its ep->asocs,
silently skipping the first N associations.
The trigger requires a previously interrupted dump plus a peel-off race
across every traversed transport in the subsequent session, so the
practical impact is narrow, but should the end-of-traversal path in
sctp_diag_dump() still guarantee cb->args[1] is reset when no
interruption occurred?
[...]

In this case, both cb->args[1] and cb->args[3] need to be cleared.

Please drop this patch, and I will prepare a new patch for net.git.

Thanks.

