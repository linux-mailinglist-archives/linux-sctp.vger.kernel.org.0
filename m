Return-Path: <linux-sctp+bounces-1208-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKq8NqFBAmp9pgEAu9opvQ
	(envelope-from <linux-sctp+bounces-1208-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 11 May 2026 22:52:49 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F58C516064
	for <lists+linux-sctp@lfdr.de>; Mon, 11 May 2026 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0806A30406B4
	for <lists+linux-sctp@lfdr.de>; Mon, 11 May 2026 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00963B5846;
	Mon, 11 May 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNL95gjv"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3A03B388E
	for <linux-sctp@vger.kernel.org>; Mon, 11 May 2026 20:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532756; cv=pass; b=M2RiCuDrXs5jiHZ0UmJjRIrDuBFlLpMKyVMjhsc6rR/F7rxLfmBqjsqsG8sxZRZJjzzY8KqPmBEYMp63Di1j8o6dLAUPmuCrqEuXrIPqm20ZD0EVrWn4S7mUTMvJ6FEqSMfGp7PkW0Cd+OgrG7BY+KQR4yIvlkh65AkDvDClWUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532756; c=relaxed/simple;
	bh=DiHWs1sOoiu2X3GZePgpXCTnujQDkMBn+jXMmT4E3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANRfcrQ6WoE0b7AGhFKl4gAIFF0PjpxPpPs481vxXdM/jDcRiUA0JnnQ2p/YDTL/IjcDm2nvYCQueSve3mN7CZNYSp2FnSf1ArGhW766/kIXkhTbWZ+S62qnelQ3nD/VTXIuE/VVZzIAS+YW0+YJQG9WCE0ss0J/BLh3MvexMdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNL95gjv; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-835399c11e0so2152911b3a.0
        for <linux-sctp@vger.kernel.org>; Mon, 11 May 2026 13:52:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778532754; cv=none;
        d=google.com; s=arc-20240605;
        b=WishWMP7lrNk2W/K36Rkneeq527nmlHgChmKQrimhDiZge3P+Lrpm65AWUtUnGjdTw
         7INUzb+EAuDlyxQMzLi/IRo3h4KG/R5ZdTRrzZFh+YJVhRWlkN/oSf4wbdpTQMoOgm89
         q3k1G7C2a9gMa8TXxUwTZYUWmhvw1Py/iWu8VzeHnuKLbmBLKVMQnkyNZqp/iEYd/dRt
         jFIOvW3YPbMF4hAqlOZsfgw8pHIOed84Z19as0QAgVgWHgLYk+GniVifY6M35xZYP0sg
         YUl6ZUEtIBKTiW/u1PTHRDWzGNXixjaBqqbzwzRw52sZOfIcanY/onIwzsJHzBPPr4Mb
         O1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        fh=MSnVzCsGlGJalLfTEh4GHtioGnESK554mNsqsFRV8tE=;
        b=auxJkEUgirKI7s3odau2AGdm+C9JZuy+sTcSXzWXUSIwb1Gh+aara9hZXvZQcz5fTw
         X0BnVkPsA0MrOqows0Skgswbphv+khHP4eefyZOu04b83aQMC0h1IKhVl75k4aEu05eU
         a2fqJmezQ4Rwq6KOm/8fssRSEfj0bjhSGU65+OVvmGw/Tkwj+7SWYmlb0ZAhTVq3wpM8
         ng8zlpQpjM24laormtYiiBh3BPq5RmRZR1bm3t4v9Gi4kMimWN/Y8WhnL7ZI6LRj+bs1
         nQIIaA7W74KpOjmx0RtvBruWlr4wnVGP8fXNuyHdhDxRCoZQaX0LGGzkezyeRoCPA8aP
         6zTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778532754; x=1779137554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        b=KNL95gjvbWQXoawbUCz0Gg17P/zErBroamUNEtu6ucAMcF6gXWEzMI4S4HvYKbMD3C
         apml2UkN5+zj2Ld2qje12S7sXOjZ+h4j71Ou+M8aQ2Nyr7Kd0uU/zCt1ViL0jDNDYR3M
         QmNYjkvu0JUlHXvJ00w3/HjCMo2ou/Ia8+dNmAs82qVSyI1wXd3a/CRMryd1GtoXhpSE
         4hZabtcnSE3sG+G4lcuLorg3wrEb12Xk/l40QaTrI9/amqf9ilHLL6uu9hKPdFR9y9wf
         TqMG3uJUqo+GhNihyFhpWnfEFmXOcrKNNowkVdKOwRe6wpn+M0AfK2iy7dVWZqADjle1
         ExMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532754; x=1779137554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        b=n+zAvNnf/GJU7mH0njncHZsOLN11xwPHVmk7154oIlQJuyeO9EAxG6jA7+kA7d4y6M
         m1nyMrOzlja3WkWrODnRQoLM6Jk5NMndALbbAi9SyRDwd8XRGY1EDWV35h38bC+4u/hg
         LkPdytFnq38BxjYggbj6pOPcnW0h9qpu/JZdiJ2/zBH5IXeKy71W9mozUJQLhJhdbFSl
         4QVnBwSN1didflZv1/VT4ijmPzUsbCffVB1IHlNjXrtDVyDDQcNEYsZ1uEsfxV25vpoR
         inOMsAOe07Qa00wNaCZl4bALRbBehiLpa0QfObN8u2nHZmQ5ySi3+aoyy4i6/9zRcwLJ
         5C6w==
X-Forwarded-Encrypted: i=1; AFNElJ92ji2LcUQX2TzZXa/u/+ISCQ7ffjkb2O+v4WFVR5UMxCxE+xiEU4/Zde3Ctsiy8XKTaaN19zyF8ePA@vger.kernel.org
X-Gm-Message-State: AOJu0YzJWSFauZQQCCHLMr3IuRp/Ks0IEa5KhKQVki7N1vuwYVkykUrZ
	otg3hcTNlWsnaP18vUuMAOxrW1ftjJW+uRoChWW2/IPSg1ZjhmwojXJcj9itsfNSEjrwdWdEr+w
	xYZYlyZdOjuHqWme09C8YDeKHH/aidW/uuA==
X-Gm-Gg: Acq92OE2sG4jN6FxdVM3gsmhnlxhWoTEMwiIekhpqWulq/iCoXSQPspkg+2wTRuaUjf
	B2obL3a/GgH5UeLwYjvHQ1Iky10pYdq5t4sEWUgyUcsbnmq7SVGW0h3mzl9+UVsVijk3AyDWrNm
	oeRSLofIzcPdj4WHe+2dwFHr3hK/GoccMEeSU0qXvSBT5Emh5mPE1RKJLgVk7JRBT2X8wnVpnP9
	21c3pBwK8CZCAHJkg5XkEOqW49TmtJgQIfhg+lDGqEDrZfGBfDNP/raPRQ1QJjNLwqZdXgvY36E
	sUYLxUcMWcCNowJx0BJ2UFQTpReo5+6Vzr/ZL5QN62/rrLqHk3JAsaudhWq2luMq3o0lCJmUOom
	uLZtnzAqQxhqBUnf0NKbjY0LW3ljZr9EJWaGCC88i
X-Received: by 2002:a05:6a00:1bc9:b0:82c:d7c4:4c5c with SMTP id
 d2e1a72fcca58-83a5bae02b6mr23896094b3a.20.1778532754053; Mon, 11 May 2026
 13:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508001455.3137-1-joycathacker@gmail.com> <CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
 <20260508182044.55b567c1@kernel.org>
In-Reply-To: <20260508182044.55b567c1@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 11 May 2026 16:52:21 -0400
X-Gm-Features: AVHnY4K-4oufZ5Bh_ouYXMsrGsz6Jdk671TfT3bU5bBuK9XkaMlt9GEU6bPpSL8
Message-ID: <CADvbK_f0hTB5rsjNO7Mkg69KqTF2QmCKHNH__JCwS5LtfPgRLg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc() in SCTP_SENDALL
To: Jakub Kicinski <kuba@kernel.org>
Cc: joycathacker@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Ben Morris <bmorris@anthropic.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9F58C516064
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1208-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,anthropic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 9:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 8 May 2026 16:35:21 -0400 Xin Long wrote:
> > On Thu, May 7, 2026 at 8:15=E2=80=AFPM <joycathacker@gmail.com> wrote:
> > >
> > > From: Ben Morris <bmorris@anthropic.com>
> > >
> > > The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> > > list_for_each_entry_safe(), which caches the next entry in @tmp befor=
e
> > > the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> > > drop the socket lock inside sctp_wait_for_sndbuf().
> > >
> > > While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF th=
e
> > > association cached in @tmp, migrating it to a new endpoint via
> > > sctp_sock_migrate() (list_del_init() + list_add_tail() to
> > > newep->asocs), and optionally close the new socket which frees the
> > > association via kfree_rcu().  The cached @tmp can also be freed by a
> > > network ABORT for that association, processed in softirq while the
> > > lock is dropped.
> > >
> > > sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lo=
ck
> > > via the "sk !=3D asoc->base.sk" and "asoc->base.dead" checks, but not=
hing
> > > revalidates @tmp.  After a successful return, the iterator advances t=
o
> > > the stale @tmp, yielding either a use-after-free (if the peeled socke=
t
> > > was closed) or a list-walk onto the new endpoint's list head (type
> > > confusion of &newep->asocs as a struct sctp_association *).
> > >
> > > Both are reachable from CapEff=3D0; the type-confusion path gives
> > > controlled indirect call via the outqueue.sched->init_sid pointer.
> > >
> > > Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
> > > returns.  @asoc is known to still be on ep->asocs at that point: the
> > > only callers that list_del an association from ep->asocs are
> > > sctp_association_free() (which sets asoc->base.dead) and
> > > sctp_assoc_migrate() (which changes asoc->base.sk), and
> > > sctp_wait_for_sndbuf() checks both under the lock before any
> > > successful return; a tripped check propagates as err < 0 and the loop
> > > bails before the re-derive.
> > >
> > > The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
> > > loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
> > > the @tmp cached by list_for_each_entry_safe() still covers the
> > > lock-held free that ba59fb027307 ("sctp: walk the list of asoc
> > > safely") was added for.
> > >
> > > Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL pro=
cess in sendmsg")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: claude:mythos
> > > Signed-off-by: Ben Morris <bmorris@anthropic.com>
> >
> > Acked-by: Xin Long <lucien.xin@gmail.com>
>
> FWIW sashiko says there's more?
>
> https://sashiko.dev/#/patchset/20260508001455.3137-1-joycathacker%40gmail=
.com

I will try to verify this and submit a fix if it could be reproduced.

Thanks.

