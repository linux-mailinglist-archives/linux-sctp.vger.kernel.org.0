Return-Path: <linux-sctp+bounces-1195-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oD3lHkQj7mnYqwAAu9opvQ
	(envelope-from <linux-sctp+bounces-1195-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:37:56 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFFD646A5B2
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 16:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 049EC3004258
	for <lists+linux-sctp@lfdr.de>; Sun, 26 Apr 2026 14:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF1366563;
	Sun, 26 Apr 2026 14:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blWwUekv"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4243659F7
	for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214261; cv=pass; b=DswKnoXvYhDISeCrmtjJFgJ/O0dlqzMnDrI6qoazULUynWkLNgch0d9E0YrSrIZRVfPQEbND2waVKVkn2yFj2ZelFDwRr8gokwOXM/jRXh6ratVxGkR/Ep+vplH7anQnjurt0bEfdS1WtflHTTNYJy0TRvWDxM5EWC6OPWNyxWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214261; c=relaxed/simple;
	bh=xGs9HlAaWh9UwzzisAubXHC6+wSGCrbckBpvHnDMQBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEvrdvqSXeH2WBrFbae3bk6CwPXcUJQdFRIZtQM0Ip/Ba2tTooJzgelZFVbamrZA1EGQEoOwRVBbx9ovr2Q/vopIndVBaWq8oYpbbbY8+WmNAcbpu7B4tPs9mVHtY0omm71VFXvc+nUCvRkIQYjNZFBnv86LXjKsaDVNPtGaQ8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blWwUekv; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so3686379b3a.1
        for <linux-sctp@vger.kernel.org>; Sun, 26 Apr 2026 07:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777214260; cv=none;
        d=google.com; s=arc-20240605;
        b=l1ZfnPiXVc/h3WecvrVtLxxB5+Oi4Mm941BRLfeaq7OEOCYC+r1pLxEB3C0XuX0nex
         hwo8hoxlJp0UixYC+HNdHk7xDcymLq4P7ETCgLCsOe1Smiv+aNzQ3BI3YWn2l6ae/ag1
         p3PK2V65pLYFwj4GPwbx5cIXIOtcJgwi4ghJ0o9Wn0LyM6w+wzGWTM8JpB44sQ8bbx+o
         km1vkvepmt0lWpGE7sevr5BI8Sxr+ZFjk9BNoNLqQ2jHwT+uLMjafZPkc8eyl7MlvFX7
         Z5HNRQ4N//83e1udh/LuUMC7YUBWr2eR7s6DOdRhtDbv+neLdJJpZlJSzv2pecyvK1B5
         q45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VjV9i0zLE+j6+k558H0n59YbfuN4/v5ohF11Cgr5kd8=;
        fh=qkV/380bNK0pZCnffcHtglSEGMjVIM4mEKjuhMwLlwE=;
        b=KoYJn/T/SSG4yLz6Azy4DLbb57IqmVNu7caiMT2occ0agCNjkauhYokUv9/CcixnEW
         1q0H3Z8clt4FGhD1Bcj5G6eMA8m+PZft1WRI+8p0uQR7I1LAeRys/XkmDZfy0WS8+j0X
         RWUdhOJoNAJjiQDAavg4HYG3LfB57RnAFLuXh43jUW9JPIkNer3WP+avIehbHQrd+1mN
         pObsP3190sPBQ+ctyMQVwrUc3CYWM0M7kw48kAn1nWNINfF8OTbJ3RqicFsjhndn9NWR
         nrqIgRnYIXeIFo4ulrrOM/IvU7oZAR721vkwQLa7f9sGIi8UwF8nf4THN2Ye/dlkvtby
         QfYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214260; x=1777819060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VjV9i0zLE+j6+k558H0n59YbfuN4/v5ohF11Cgr5kd8=;
        b=blWwUekvEzmaUp3k30WGpYZ0reVhPhRemF9Z25qnlTtDnm6Saa+B8cYdzgULLRRhHi
         OZrqoV6Nyxo/Y4HEz2Facp6lRIk26jJQsgPX476rFgdv7FEf6UF9aDq3KI84GIEHCcAo
         Buch9zWf+BNlAg9DWemG0kxctSROCg5R/tACCDmszbYD+E6ENvjQ+Ae2DyzjDoe7lo0V
         S/k2klREGDq77fvqdPO6iaEcVOuQ9ObZya7Nbo3k24hsiirubvK2elzQ183ymwElvJ0U
         qBooSBo1zlNimNyLXEgarIQN1wdsS2fu7qHQG9eDfatNj0elEoVzHcvIEPPWuX1CKPZ1
         rnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214260; x=1777819060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjV9i0zLE+j6+k558H0n59YbfuN4/v5ohF11Cgr5kd8=;
        b=LRFY8TArNh6URKJTvAgKsci+gUPeNGiIlbg4YD6IM4oIibvSn9rgHcqSf2TJQ7yJVk
         2kgkLIjTU42jysHk6uOOthzdlvtMvOZx9DulDLr2wO7b3vuJ5ccg8B/eUBTx9+AAEHkp
         R5x9tpnzKei/7GI2qDT1/3fNIUiX7Tclt6tgRIEkgj+t4jqGUFn5CFCxddRs69E/G8DP
         OqagHMVTFoedNopNpgFpqplxm1EXLl7la2HoGGsM/e8RbdzajElK5e55gASvq13bda6B
         zB3SvFCxMhuhUDXzEnM/VX1pwcd784O45xEp95+vjWZzJFsQ8LEkbK/9w/RQY1FybPMt
         lw/w==
X-Forwarded-Encrypted: i=1; AFNElJ+EGqkinMO5euK10H4A7w3xAs4xejeGnJTF5BudnHhyWI1M9d0VwZl7T3Mhd/4KCZeRnqv6xthcel9b@vger.kernel.org
X-Gm-Message-State: AOJu0YxhyuKKq34gjCRonxz/buXxD6FhhuWtYp97ywJieKUwt8WnlPcZ
	oMe1RveYQQA28x2yAjHgGPW/hVUUJKqI3MEaabRI0fptGE/ymn/39yBfNuN+b303H7nue1qAxgc
	osUM4jseO4EwmGZIXoQLqMQoMgwziJTY=
X-Gm-Gg: AeBDiesgSxIXHOLQmZXHw0a+QpH21YJ6059SvvYlzHcp88lWnZta2E8oXz+qyYsHqAR
	JQ76FBsuVNYf+bhx03rdZoTYxbpb3mL6cQ6tTUIbZjSlMQmh2Yvm1QjKiwf5Nok8pHkzKjsEHjY
	V2x8R8IgNCj+vown5mhLS6jEsMQ8qrElydV+OLqRnrvCohRi5JObSEUwOjyEOwfAzV8bb6oZh14
	j8ZuRzAUpgdfLh/GQknPdhUW4RgVacp7jGnPB+XJIW7axs52OFEqVchk1ghogvm0eNmnlYS4M6g
	Jd51cpdQ8qGGh+hmX1AxfUw9wxkSYRuT1kT52F6ApZ3t3q3Pk7npJB2FGy0H7qgqPRFaFMccfbm
	y79+tfMz0mCIkzUoEB4G+IwF+oFjDQnqC/ND9Fk2NN6zS67cKqnY=
X-Received: by 2002:a05:6a00:992:b0:823:9b7:9c0e with SMTP id
 d2e1a72fcca58-82f8c991215mr40886557b3a.34.1777214259616; Sun, 26 Apr 2026
 07:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1775847557.git.lucien.xin@gmail.com> <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
In-Reply-To: <bea8a0dfcc56b9980cb914b54cffa9dd9948ba75.1775847557.git.lucien.xin@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Sun, 26 Apr 2026 10:37:27 -0400
X-Gm-Features: AVHnY4LLUhOITcQWAb8AID_ay9mkKJOFHS3deCCkTNwHYTo-DoTv-l-YqJ2yjo8
Message-ID: <CADvbK_ebPJqKJJNwPXoYj50QtjCSoeE59M6YWYkqk6qBj96vPw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] sctp: discard stale INIT after handshake completion
To: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Florian Westphal <fw@strlen.de>, Yi Chen <yiche@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EFFD646A5B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1195-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com,strlen.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

> This is an AI-generated review of your patch from:
>
>   https://sashiko.dev/#/patchset/cover.1775847557.git.lucien.xin%40gmail.com
>
> > @@ -1556,6 +1556,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
> >   /* Tag the variable length parameters.  */
> >   chunk->param_hdr.v = skb_pull(chunk->skb, sizeof(struct sctp_inithdr));
> >
> > + if (asoc->state >= SCTP_STATE_ESTABLISHED) {
> > + /* Discard INIT matching peer vtag after handshake completion (stale INIT). */
> > + if (chunk->subh.init_hdr->init_tag == asoc->peer.i.init_tag)
> Does this code compare a network-byte-order value directly with a
> host-byte-order value?
> Looking at the structures, chunk->subh.init_hdr->init_tag is a __be32
> extracted directly from the packet, while asoc->peer.i.init_tag is a __u32.
> During handshake initialization, asoc->peer.i.init_tag is populated using
> ntohl().
> On little-endian architectures, will this comparison always fail and allow
> the stale INIT chunks to pass through instead of discarding them?

Will post v2 to fix this.

Thanks.

