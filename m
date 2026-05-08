Return-Path: <linux-sctp+bounces-1204-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eL7WFTdJ/mllowAAu9opvQ
	(envelope-from <linux-sctp+bounces-1204-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Fri, 08 May 2026 22:36:07 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CC14FB860
	for <lists+linux-sctp@lfdr.de>; Fri, 08 May 2026 22:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD7F303C036
	for <lists+linux-sctp@lfdr.de>; Fri,  8 May 2026 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A841D3FBED4;
	Fri,  8 May 2026 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfcIzSak"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F57D37DE98
	for <linux-sctp@vger.kernel.org>; Fri,  8 May 2026 20:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778272537; cv=pass; b=iE1OMDEOXdSHnpiAd9D8OJcXRoopgliR4YLLvRkdP82En9Y+SDVDzbCXe0UZ1l+GmC3ptkpJzK27mpoQqJuBYFwj14kQ3s9ZsAovF5NQPPSoNSQMkk76/1t6OltymTQ8oqausOW8ik04iQJak+lFHiOvRFPIJ4Y27idV95CNIXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778272537; c=relaxed/simple;
	bh=tGkZvwR3HBJnT2gUAjQAFsWKSQlCDycL90ho1SbjpNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cmIvhjjFJ5noMw/2uSz3T00PJqON2vHDBWuMo9NcN3OLGipeAXIwUgG4OoQIKMUBHmCBN+gRKX0Aey9xYHqmdDPoVUOvYIcrpoQvqKPVI8cYZqaTDvmsjji9IAUPvUmjNmfGT8dq9kghoQ0Pvrzcgg/r+wSzfwiSlnw9J6DSGH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfcIzSak; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8353dfdad62so1762254b3a.1
        for <linux-sctp@vger.kernel.org>; Fri, 08 May 2026 13:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778272534; cv=none;
        d=google.com; s=arc-20240605;
        b=NpCqL4be0lU2j0KhQUDye1nwC5uAR5OdLcpG7+0Aen/qlGLcXbVmrP1uTVozjxpwXT
         OYxRpcjsA30wsKmrH16S2HdA0rQcFQ6R1j6BI84Q7BrjWelcNiWDr6RQZX56CCSb2rrU
         tFlziYRaFy7tk610Lh1ycuApxvhImxvTS1lZmcpxGwTWwHMZ7p5UhbuT47pj1sSDsYli
         o1ObkrsG2W4vl3Eun1Vhia9TQ2nACXkf18jh1Gasy9aUcpeLz4yIN7w4+l3Q0KCCZWLZ
         YL0WjFZB0X5ULa+iVrRrq9YMetwLodgTnZBWZsMmCheWzjx+OidGT5j/8vSyipzw5Ljk
         6/lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        fh=lrnMXVk/sd2RUhTBmwaANLr/hABcfWsloxHCfQ9cgrs=;
        b=I3Sc1nh1JPWe0KQQ4mIT/FPTSITf9pEeMOvmun6ECNSH8PXm733iJHFROysWjPQXGK
         wlj3BUYCYMSJ9a7xFWKD3hDJk4p9xhBoli8tSGgMhyur0AcLN1CUzZNyFz4rkSjwGnk1
         HUB3W0ps03heR4wKHpYtR3tUEB+SxpEH1o9Z8QIdgCyywIvKCkWW54xmXivFJpaGlsiX
         Vj5uE1YqnfcsNaIFR6galQVz8D9le8mvwYjMX5PBKlb5YBnODfL14cY1CzvdOlerrZyl
         a0MYLVVgjmoBE+h0wIyKV/++plP5kUoI4IFZ94756w8dF9Y31FFHxYr/F6nL51lKgiyW
         Y1Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778272534; x=1778877334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        b=dfcIzSakxh9uQBHhVv1tj//DWz6nTK22aaUQAxyEckytckZ/SHFzUrMFvixsX3IwtZ
         EslM2G4S8cDvB5LFrhUhCdALObKjr/xIYRds4igKxR6mKeGTIWi7jvxQ62aax1KBkZPN
         DcF8VxdUCJRlPyjuBi+Seum4+dEnVMGSpZHgnrZ7P1ix8UU8UtoTn3SzHKTApvhmF+fe
         MT5giEPBUM3hW/69N2QU8wGQVtFfV2XxocXmcsWnLCyTrt7QCKQgSRuUaYg7w8Et+ea3
         bdcjyn0hUZkbtUHF1Hi/LQWoUI5pgfC1pLWHpwP/mvVZZv7wXDYApvq4c8KHIJwkQNNM
         UmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778272534; x=1778877334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+c/Q06nALG4Vh2ue1fjeqFlO+UJffdvyG7yKiqYuccs=;
        b=SvJyaqVQ9VrpEEwupyiIaHBhFKfTJuX03Hv5PXDPI/uC2gGPAIzBE7AgEp02M+gxrk
         jeIuJz9oOnMwAtzpKNd+L9ht5xg5rywRDKVe+Qn1NLomgdCSdjtWflLWRVM1pA0rJ1Qf
         T1Op3Uw1fBOhTaaapfm+/c35zZwG6+Dm7eC8QJ1B5S32Gi3c5eSQp+zxAUNYD9Op9nwB
         GbDxC9CMjD3OidMKdv1x3iLztxeK67xH1YR4rqSl03Blcx9w0SAt5rB317Aq4lyP8+fE
         EMcFjJHZIwFw2j7cT3PTsMT5NkpR+UUwap0p34I8U6l8TcfGHabHQOe5mKw+0p+QCLb0
         j8jA==
X-Forwarded-Encrypted: i=1; AFNElJ8acB9VNVSWCZ5J2CAZ6kB6KRT3gvU9yasbuzK570EORxvF0psA2v8uvHXniZiucqe5h+pcPDQ/Hdce@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgbhl+FBNotiSaanYXX6dbb+HQr/Wq34HRVGOixOXt1IOUDPqY
	Q+lEhdvvJfI8ei6Ey89hMY60M4ewWwtYGla8/ByWdbkAJq3BC17/nI52s6mNOjQBG4/rzX1JSbv
	zs9s+bd4YGFajO+C+zNuzFx+Iqq9Oxg0=
X-Gm-Gg: Acq92OH3cDcC5YeAjCBd78dXgz+kjuUv9e6173gySzeYfvu7vZhsD5jlO4V3JFiunK1
	2JtmEr1ZiwPx5Jc1GxhIeT9CXaPc42iOG4kg8Z9uvpN7ya1VHikGYrF9XiaWb3HGGIyS16qA6OH
	qfAiuO4yZ3tp3aP4k69f3k+UnSIlLBOuk9g/shosrVFTewgTU2EMTNjLiivIP0CedRhpgWyZyNy
	uSbF3PuXlJ35LM57PcuK38XlW7tZJIXVGQdMx+JziQuQIr0XlyDOlteA+KWJYDxGqDThO4i+HKY
	s+BokjIolaAaXLERri21AsTRpT/QLJ+WrJrfYIxkHfcwQ9h0kq7oI6eKm/TVAw7RWBnTFFt57zV
	Wb81P0llJpgdFCHbDSdfosR4YBSGStaULjzMnQAsPTp8dn5tIlOg=
X-Received: by 2002:a05:6a00:2347:b0:837:7e7d:3c8 with SMTP id
 d2e1a72fcca58-83a5df4b883mr14060988b3a.39.1778272534439; Fri, 08 May 2026
 13:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508001455.3137-1-joycathacker@gmail.com>
In-Reply-To: <20260508001455.3137-1-joycathacker@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 8 May 2026 16:35:21 -0400
X-Gm-Features: AVHnY4LqanISktwmN-weO_GvoUqdGbL_ndw_WJ60yora6lW3wrSNlyT6YeLV0Ts
Message-ID: <CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc() in SCTP_SENDALL
To: joycathacker@gmail.com
Cc: marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Ben Morris <bmorris@anthropic.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B8CC14FB860
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1204-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,anthropic.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anthropic.com:email]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 8:15=E2=80=AFPM <joycathacker@gmail.com> wrote:
>
> From: Ben Morris <bmorris@anthropic.com>
>
> The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> list_for_each_entry_safe(), which caches the next entry in @tmp before
> the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> drop the socket lock inside sctp_wait_for_sndbuf().
>
> While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF the
> association cached in @tmp, migrating it to a new endpoint via
> sctp_sock_migrate() (list_del_init() + list_add_tail() to
> newep->asocs), and optionally close the new socket which frees the
> association via kfree_rcu().  The cached @tmp can also be freed by a
> network ABORT for that association, processed in softirq while the
> lock is dropped.
>
> sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lock
> via the "sk !=3D asoc->base.sk" and "asoc->base.dead" checks, but nothing
> revalidates @tmp.  After a successful return, the iterator advances to
> the stale @tmp, yielding either a use-after-free (if the peeled socket
> was closed) or a list-walk onto the new endpoint's list head (type
> confusion of &newep->asocs as a struct sctp_association *).
>
> Both are reachable from CapEff=3D0; the type-confusion path gives
> controlled indirect call via the outqueue.sched->init_sid pointer.
>
> Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
> returns.  @asoc is known to still be on ep->asocs at that point: the
> only callers that list_del an association from ep->asocs are
> sctp_association_free() (which sets asoc->base.dead) and
> sctp_assoc_migrate() (which changes asoc->base.sk), and
> sctp_wait_for_sndbuf() checks both under the lock before any
> successful return; a tripped check propagates as err < 0 and the loop
> bails before the re-derive.
>
> The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
> loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
> the @tmp cached by list_for_each_entry_safe() still covers the
> lock-held free that ba59fb027307 ("sctp: walk the list of asoc
> safely") was added for.
>
> Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL process=
 in sendmsg")
> Cc: stable@vger.kernel.org
> Assisted-by: claude:mythos
> Signed-off-by: Ben Morris <bmorris@anthropic.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

