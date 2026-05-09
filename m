Return-Path: <linux-sctp+bounces-1206-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHEOAvOL/mlasgAAu9opvQ
	(envelope-from <linux-sctp+bounces-1206-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Sat, 09 May 2026 03:20:51 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 764424FD3E2
	for <lists+linux-sctp@lfdr.de>; Sat, 09 May 2026 03:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E22993014506
	for <lists+linux-sctp@lfdr.de>; Sat,  9 May 2026 01:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAE246762;
	Sat,  9 May 2026 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qx7sAKkS"
X-Original-To: linux-sctp@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034161A6828;
	Sat,  9 May 2026 01:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289647; cv=none; b=DSYERb7RDtfMP6PaxSGizVBLGMTnh1ACzS86ekTr+TvTXCB8raaWJq11th091w/KD4B4R30rGRPeCgZ1bjQHWUlyEvqQd3zbCTLMKtPxqp4JNJngKolEpT/MfJARJ65UQfQAWKR2Qd+Qaprjjn7i8pFnUk/Kc88YizpjgaoRLv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289647; c=relaxed/simple;
	bh=ngWZRieocRakAOXz1tz/rs2DBtyC2VDgowa5l0YcfHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmtmERB023DCCEGE7+W8g88bDcp3oeF1syG4+QSF4ZBxVf17VODw4+qKJwlYiRBbaI4mld1h4hT60ylZhTK6R+sjh29EljWtSuKK6fqZxaY5f/+TP4TksLRkVs3FX+Azta6dGDA4tkhgDfOUA+i1uYQXNWJSn5SXLUhlHO5EdHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qx7sAKkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BB4C2BCB0;
	Sat,  9 May 2026 01:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778289646;
	bh=ngWZRieocRakAOXz1tz/rs2DBtyC2VDgowa5l0YcfHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qx7sAKkSMRcEBn6YzbEWweidcl9FDkQZJq6NZEms598/gwzD27H73WFmjw3qFuatk
	 k3mvkSZIsjiSWxf80JXW534TY3S3/4zMyl4vzHK7GDC/Qlat8RMohpJ3pguDW88qPu
	 45J45Nm6kNygQ3Z3fHgy78GtCFiz9lPZnnnLF6YGG6FfV+VL9h3baJ7QF8xtmt8vSj
	 sPfvA5VBUlJs+pOgW4qAolzlC5nnZv1jkAgqswDteKSdTP0aSJi3bU6tlpYiiDjaIo
	 WdiaCtxIBrEzMbpSewV6bF8DSflAwozIUyhLbMDv4suN84bdioReovyGua/A+oMpNo
	 MZ4y18hYkkBMA==
Date: Fri, 8 May 2026 18:20:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: joycathacker@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, security@kernel.org, Ben Morris
 <bmorris@anthropic.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc() in SCTP_SENDALL
Message-ID: <20260508182044.55b567c1@kernel.org>
In-Reply-To: <CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
References: <20260508001455.3137-1-joycathacker@gmail.com>
	<CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 764424FD3E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1206-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,anthropic.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,anthropic.com:email]
X-Rspamd-Action: no action

On Fri, 8 May 2026 16:35:21 -0400 Xin Long wrote:
> On Thu, May 7, 2026 at 8:15=E2=80=AFPM <joycathacker@gmail.com> wrote:
> >
> > From: Ben Morris <bmorris@anthropic.com>
> >
> > The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> > list_for_each_entry_safe(), which caches the next entry in @tmp before
> > the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> > drop the socket lock inside sctp_wait_for_sndbuf().
> >
> > While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF the
> > association cached in @tmp, migrating it to a new endpoint via
> > sctp_sock_migrate() (list_del_init() + list_add_tail() to
> > newep->asocs), and optionally close the new socket which frees the
> > association via kfree_rcu().  The cached @tmp can also be freed by a
> > network ABORT for that association, processed in softirq while the
> > lock is dropped.
> >
> > sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lock
> > via the "sk !=3D asoc->base.sk" and "asoc->base.dead" checks, but nothi=
ng
> > revalidates @tmp.  After a successful return, the iterator advances to
> > the stale @tmp, yielding either a use-after-free (if the peeled socket
> > was closed) or a list-walk onto the new endpoint's list head (type
> > confusion of &newep->asocs as a struct sctp_association *).
> >
> > Both are reachable from CapEff=3D0; the type-confusion path gives
> > controlled indirect call via the outqueue.sched->init_sid pointer.
> >
> > Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
> > returns.  @asoc is known to still be on ep->asocs at that point: the
> > only callers that list_del an association from ep->asocs are
> > sctp_association_free() (which sets asoc->base.dead) and
> > sctp_assoc_migrate() (which changes asoc->base.sk), and
> > sctp_wait_for_sndbuf() checks both under the lock before any
> > successful return; a tripped check propagates as err < 0 and the loop
> > bails before the re-derive.
> >
> > The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
> > loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
> > the @tmp cached by list_for_each_entry_safe() still covers the
> > lock-held free that ba59fb027307 ("sctp: walk the list of asoc
> > safely") was added for.
> >
> > Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL proce=
ss in sendmsg")
> > Cc: stable@vger.kernel.org
> > Assisted-by: claude:mythos
> > Signed-off-by: Ben Morris <bmorris@anthropic.com> =20
>=20
> Acked-by: Xin Long <lucien.xin@gmail.com>

FWIW sashiko says there's more?

https://sashiko.dev/#/patchset/20260508001455.3137-1-joycathacker%40gmail.c=
om

