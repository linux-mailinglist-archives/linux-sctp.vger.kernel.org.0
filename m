Return-Path: <linux-sctp+bounces-1261-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UeQRDJ5DMGo6QgUAu9opvQ
	(envelope-from <linux-sctp+bounces-1261-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 20:25:34 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82678689263
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 20:25:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=c3B3LEhl;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1261-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1261-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722F83088D08
	for <lists+linux-sctp@lfdr.de>; Mon, 15 Jun 2026 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A364313272;
	Mon, 15 Jun 2026 18:24:48 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5C30E859
	for <linux-sctp@vger.kernel.org>; Mon, 15 Jun 2026 18:24:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547888; cv=pass; b=DS3dN7L4BaNX2TsYB14GQjlbGHCJc07IFisY76krgZ8iU6MKbpvnkoYD6FZdV6rJuvhxxOwU4eJrEmn0nw1RJbJsRdewkCkWYenJ/Chp0FQjmr/EdFrFQd3Zcek1NMZIgb8jdmk+wsbEtX7BVd1Yht2d+cMqPx7S+Uja0gjQFhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547888; c=relaxed/simple;
	bh=rQU3+1dptlO7EZ4QftxgAWtETbg9hrrizonkQ/zs6OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LX2h6Zgqoja2sa0ulbQtE6LCRPKfQRvbMx5JVibTjjHt9Zzhuqds0pA3yU6/l95LBk1a9lry/xJvvxuJYwHV+etBO50a0SEmf523e4PVzHx/svGRHicq0DOSKFgLHi2VYesrjvL7AlBO9aoF6ITogLtTla5F+zQGX9xWVedG6/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3B3LEhl; arc=pass smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423f236418so2018406b3a.1
        for <linux-sctp@vger.kernel.org>; Mon, 15 Jun 2026 11:24:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781547886; cv=none;
        d=google.com; s=arc-20240605;
        b=jPvKh/MxR7Dc9jsJ85B9/vsRw6dS9F6pYvbuoWbDXjKSLxWpHeW7HsVLRh/tn0XZI/
         UfiJxrBj9GKc1yuq4EYlrP+57UzUTIoFbqvSVAjViNLAe+cr7uf7EsQwYab0QwKXdYRE
         1wRvw3BQOpNznFv5m925KU40aRLMiFBotqWpbFfw0GHkVIxI+53mmPJBHT7C1H2HThVe
         nQUVg+ZGcDCkYWuF4Y+ShFVh1oN3/s58w6wgBvU+Q/cTMApRxNrHWZOGqbzKXMVjyn1N
         IDfMu6llqRNXVlKHvcxNNDTvo8hhQ0/cNIZj+alUE9Wh3a/CcAaQxvrAsyxNPygeNGNE
         VWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MdJWWPoSwB8kyhwmiLUDez5qJvt2ppiGCDz7WvkQHMY=;
        fh=2xIhaksofRzHNxZYSx08H3j4PONNuj5w30Z1V3aunww=;
        b=IjShOB0kMovrz3I2Is1fA/sqgee7mmUavgaCARkcpoPd3EW+BbouPC5ura1V4N6CLD
         6HNTJnXVvOoit86dOsKGo13Bkkt4+eKCncw3nZho/4Xg/8Khy6p77kkqyxcq1Fqmd7ug
         VU5Nw56/u0AAIjT04nas+eC9X/oIcNi+aDOvHFxajb5dWK24PQpK9ELoDnW7jByOfT8u
         0kJxK6tbq5f+wFKQ+F7kT7KXbD6HncEhB1aK3kgj0sHLYw2u+r7HacoFh3torkG7xEK5
         5GAzGLVq8/DeicbjVczeSUU2R77Ke73Q95t/1s0BWF9HhdiE9VszyN/FxyVvYjMuxtTH
         rRBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781547886; x=1782152686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdJWWPoSwB8kyhwmiLUDez5qJvt2ppiGCDz7WvkQHMY=;
        b=c3B3LEhlHKrq6WtUg5r+iRgRd3EGgVKY7819k6Xrf6BWgL1/z1R9dVTANTGjlbower
         0+Ynx2sRgwt9MyBxY6W0J7D1yhyRCqRHp6CVmmslxpLtZCFtJ4wFRJXB62VTaS4YsCMW
         2QcNMoXVd9XvCmluAWFq5rl+NlD6t8m4nbt6cu1yjW62OUVDhKe1HagcqP5rujiM0NTE
         rH0ziNoaujTd8PpKdHtR1CNe84w58NGg0/fHV4fx6kKpe9PV969v1uoXWew4gcc8o3U8
         JYPRX1INj4ItVAkpLSQCSgbPKdv40eZY/8ROA2Zy4HlIKZbA+VyAowhbFredGsFvBsPM
         pgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781547886; x=1782152686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MdJWWPoSwB8kyhwmiLUDez5qJvt2ppiGCDz7WvkQHMY=;
        b=bXqRG7Pgy7qVJnpfzszwsPKOOEQx9YTCabil0L5S4y3sUyi0HE0qleHwCuT1mDEzvo
         XQJz8wjpM6kqO+wk3CDJB9QlnQcXDmMF+sYkkLXRqbf/Bc3B6U+pw4MSS+G4J6EQEH3s
         lO0Ndwmxcy7s+5TscPfExeUE07zYrLvx3DFX6WH2FMY9p77BPaYJ6NWEG9J85D1JusYV
         IDKmTaxlJGJnOpHyEi3a8S9z5hlXnaJKFhmueP/I6uFwA5mC1SxqfdqbuoB+uxfdR0Lf
         929h5Rvgs8+N1V32+9LgvK2/d5i2c7f2pmmaaN3tWbs8BDU/7tqctP9W0eguhu/aDd28
         ru2A==
X-Forwarded-Encrypted: i=1; AFNElJ/5HZmY2J3+yDjqvLzsDZkxVbJGof9xNvXpnGWOSIhabLfvnZLM1g1s9xucOHC5QB9yHqyvuI+6FiiR@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBISmE7D5FcXVbCYizYe4mn8ZCiqmd5WKUiK+wZg3dzKXM53i
	Vv0shFBPIkIudeTzGinbPdVHt1XluEC1L03rTyByQOiuQYv3gdz/wWAuDgg7dQ32qpjbxRPi505
	+Am/xfC2TUs/qlYYFIter164C1SYwles=
X-Gm-Gg: Acq92OElvwyBzP7XR1x++C2sq36kD6GTI07WsSGaRGfHSRL9Fp2qe1YNOngG3NhNc2h
	o1mHtZMrZNSeeHXIMrC/bHdVFbz+5k37earmmuV2TnFDsuXgpbBS98mpg6G3+6sl8LBfE+RpJ13
	ShzuL4SGXG0D1cV4vGF29iZnpJqO6zZaMDfsRJs5MuocdogvYEv5REYDq4RhYOD1a4kfde0G30f
	Erg8/zRxQrfyFi2MTzujGiO7zSFkTNO5AJF7iDm5VOsD0lNmOpus9bZ+s29llbU+hxvBmUOgepK
	gdcSXcalOrvh7TwR5eX81okkxRFcThRynp6eOoizAyooUdd9qbSivWVMeOInxbsjG7Xcuy8zQSz
	NwdSNwg==
X-Received: by 2002:a05:6a00:c83:b0:842:6004:3fd5 with SMTP id
 d2e1a72fcca58-845154f58d3mr78801b3a.25.1781547886044; Mon, 15 Jun 2026
 11:24:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1bbd999cf88fb1ea93f4a3743047bce9b51adc24.1781287178.git.lucien.xin@gmail.com>
 <20260615110402.753443-2-horms@kernel.org>
In-Reply-To: <20260615110402.753443-2-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 15 Jun 2026 14:24:34 -0400
X-Gm-Features: AVVi8Cdsgr1lIev8i-LOeRjiGsTT6EdjDVWHZXyGUQKfw-EyZyIxlJW6n2LNSZE
Message-ID: <CADvbK_e062WLNVy+BbuNTNoJGBvQBR7PHp_BmxLwwSGq4O9_dw@mail.gmail.com>
Subject: Re: [PATCH net] sctp: hold socket lock when dumping endpoints in sctp_diag
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	marcelo.leitner@gmail.com, w@1wt.eu, zdi-disclosures@trendmicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1261-lists,linux-sctp=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:w@1wt.eu,m:zdi-disclosures@trendmicro.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,1wt.eu,trendmicro.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 82678689263

On Mon, Jun 15, 2026 at 7:04=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> sctp: hold socket lock when dumping endpoints in sctp_diag
>
> This change reworks SCTP_DIAG endpoint dumping so the socket lock is held
> across inet_sctp_diag_fill() to keep the bind address list stable, and
> moves position tracking into sctp_for_each_endpoint() which now drops the
> bucket read_lock_bh() before invoking the callback.
>
> A few questions on the new iterator and dump callback below.
>
> > diff --git a/net/sctp/diag.c b/net/sctp/diag.c
> > index d758f5c3e06e..9108272ca527 100644
> > --- a/net/sctp/diag.c
> > +++ b/net/sctp/diag.c
> > @@ -373,42 +374,36 @@ static int sctp_ep_dump(struct sctp_endpoint *ep,=
 void *p)
> >       struct sk_buff *skb =3D commp->skb;
> >       struct netlink_callback *cb =3D commp->cb;
> >       const struct inet_diag_req_v2 *r =3D commp->r;
> > -     struct net *net =3D sock_net(skb->sk);
> >       struct inet_sock *inet =3D inet_sk(sk);
> >       int err =3D 0;
> >
> > -     if (!net_eq(sock_net(sk), net))
> > +     lock_sock(sk);
> > +     if (sctp_sstate(sk, CLOSED))
> >               goto out;
>
> [Low]
> The new unconditional skip on sctp_sstate(sk, CLOSED) does not appear to
> be described in the changelog.
>
> SCTP_SS_CLOSED maps to TCP_CLOSE, so a userspace caller that asks for
> TCPF_CLOSE in idiag_states will silently receive nothing from the
> endpoint hash for entries in that state.
>
> Most hashed endpoints are LISTENING (sctp_hash_endpoint() is called from
> sctp_listen_start() right after inet_sk_set_state(sk, SCTP_SS_LISTENING))
> so the practical effect is small, but is the intent to filter teardown
> windows (in which case ep->base.dead might be a more direct check) or to
> honour the user-requested idiag_states bitmask?  Either way, would it be
> worth calling this behaviour change out in the commit message?
>
> >
> > -     if (cb->args[4] < cb->args[1])
> > -             goto next;
> > -
> > -     if (!(r->idiag_states & TCPF_LISTEN) && !list_empty(&ep->asocs))
> > -             goto next;
> > +     if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
> > +         !list_empty(&ep->asocs))
> > +             goto out;
>
> [ ... ]
>
> > @@ -479,41 +474,40 @@ static void sctp_diag_dump(struct sk_buff *skb, s=
truct netlink_callback *cb,
> >               .r =3D r,
> >               .net_admin =3D netlink_net_capable(cb->skb, CAP_NET_ADMIN=
),
> >       };
> > -     int pos =3D cb->args[2];
> > +     int pos;
> >
> >       /* eps hashtable dumps
> >        * args:
> >        * 0 : if it will traversal listen sock
> >        * 1 : to record the sock pos of this time's traversal
> > -      * 4 : to work as a temporary variable to traversal list
> >        */
> >       if (cb->args[0] =3D=3D 0) {
> > -             if (!(idiag_states & TCPF_LISTEN))
> > -                     goto skip;
> > -             if (sctp_for_each_endpoint(sctp_ep_dump, &commp))
> > -                     goto done;
> > -skip:
> > +             if (idiag_states & TCPF_LISTEN) {
> > +                     pos =3D cb->args[1];
> > +                     if (sctp_for_each_endpoint(sctp_ep_dump, net, &po=
s,
> > +                                                &commp)) {
> > +                             cb->args[1] =3D pos;
> > +                             return;
> > +                     }
> > +             }
> >               cb->args[0] =3D 1;
> >               cb->args[1] =3D 0;
> > -             cb->args[4] =3D 0;
> >       }
> >
> > +     if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> > +             return;
> > +
> >       /* asocs by transport hashtable dump
> >        * args:
> >        * 1 : to record the assoc pos of this time's traversal
> >        * 2 : to record the transport pos of this time's traversal
> >        * 3 : to mark if we have dumped the ep info of the current asoc
> >        * 4 : to work as a temporary variable to traversal list
> > -      * 5 : to save the sk we get from travelsing the tsp list.
> >        */
> > -     if (!(idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)))
> > -             goto done;
> > -
> > +     pos =3D cb->args[2];
> >       sctp_transport_traverse_process(sctp_sock_filter, sctp_sock_dump,
> >                                       net, &pos, &commp);
> >       cb->args[2] =3D pos;
> > -
> > -done:
> >       cb->args[1] =3D cb->args[4];
> >       cb->args[4] =3D 0;
> >  }
>
> [Low]
> The commit message states that args[4] tracking is removed, but the
> asocs-phase comment block still lists:
>
>          * 4 : to work as a temporary variable to traversal list
>
> and the trailing epilogue still does:
>
>         cb->args[1] =3D cb->args[4];
>         cb->args[4] =3D 0;
>
> Are those leftovers from the eps-phase rewrite, or are they still needed
> by the asocs phase?  If args[4] is genuinely gone, should the comment
> and the epilogue be cleaned up too?
>
> The previous comment also listed:
>
>          * 5 : to save the sk we get from travelsing the tsp list.
>
> which is dropped here without further mention.  Is args[5] confirmed
> unused on the asocs path?
>
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 66e12fb0c646..1ed405dedc01 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -5369,24 +5369,44 @@ struct sctp_transport *sctp_transport_get_idx(s=
truct net *net,
> >  }
> >
> >  int sctp_for_each_endpoint(int (*cb)(struct sctp_endpoint *, void *),
> > -                        void *p) {
> > -     int err =3D 0;
> > -     int hash =3D 0;
> > -     struct sctp_endpoint *ep;
> > +                        struct net *net, int *pos, void *p) {
> > +     int err, hash =3D 0, idx =3D 0, start;
> >       struct sctp_hashbucket *head;
> > +     struct sctp_endpoint *ep;
> > +     struct sock *sk;
> >
> >       for (head =3D sctp_ep_hashtable; hash < sctp_ep_hashsize;
> >            hash++, head++) {
> > +             start =3D idx;
> > +again:
> > +             sk =3D NULL;
> >               read_lock_bh(&head->lock);
> >               sctp_for_each_hentry(ep, &head->chain) {
> > -                     err =3D cb(ep, p);
> > -                     if (err)
> > +                     if (sock_net(ep->base.sk) !=3D net)
> > +                             continue;
> > +                     if (idx++ >=3D *pos) {
> > +                             sk =3D ep->base.sk;
> > +                             sock_hold(sk);
> >                               break;
> > +                     }
> >               }
> >               read_unlock_bh(&head->lock);
> > +
> > +             if (sk) {
> > +                     err =3D cb(ep, p);
>
> [Critical]
> Can ep be freed before this cb(ep, p) call?
>
> The bucket read_lock_bh() is dropped above, and only sock_hold(sk) is
> taken.  In sctp_endpoint_init() the reference direction is
> ep -> sk:
>
>         refcount_set(&ep->base.refcnt, 1);
>         ...
>         sock_hold(sk);
>
> so taking sock_hold(sk) does not pin ep.
>
> A concurrent close(2) on the same socket runs:
>
>   sctp_close()
>     -> release_sock()                  /* lock_sock dropped here */
>     -> sk_common_release()
>        -> sctp_destroy_sock()
>           -> sctp_endpoint_free()
>              -> sctp_unhash_endpoint()
>              -> sctp_endpoint_put()    /* refcount may reach 0 */
>                 -> call_rcu(&ep->rcu, sctp_endpoint_destroy_rcu)
>
> The destroy callback then does sctp_sk(sk)->ep =3D NULL; sock_put(sk);
> kfree(ep).
>
> Between read_unlock_bh() and cb(ep, p), this iterator is no longer in
> any RCU read-side section, and sctp_ep_dump() then calls lock_sock(sk)
> which may sleep.  That allows an RCU grace period to elapse before the
> callback dereferences ep at:
>
>         struct sock *sk =3D ep->base.sk;
>         ...
>         if ((r->idiag_states & ~(TCPF_LISTEN | TCPF_CLOSE)) &&
>             !list_empty(&ep->asocs))
>
> The sibling helpers in the same file pin the endpoint explicitly to
> avoid this:
>
>   sctp_transport_traverse_process()
>         if (sctp_endpoint_hold(ep)) { /* asoc can be peeled off */
>                 ret =3D cb(ep, tsp, p);
>                 ...
>                 sctp_endpoint_put(ep);
>         }
>
> Should sctp_for_each_endpoint() take sctp_endpoint_hold(ep) inside the
> bucket read_lock_bh() (while ep is still hashed and live) and a matching
> sctp_endpoint_put(ep) after cb returns?
>
> [Medium]
> Can this restart pattern miss or duplicate endpoints when the bucket is
> modified concurrently?
>
> After processing one ep the loop does:
>
>                         idx =3D start;
>                         goto again;
>
> which re-walks the bucket from the head and uses the running counter
> idx compared against *pos to skip already-emitted entries.
>
> __sctp_hash_endpoint() inserts at the hlist head and
> __sctp_unhash_endpoint() can delete arbitrary nodes, both under the
> bucket write_lock that this iterator releases between walks.  A
> concurrent listen() on a sibling endpoint shifts every existing entry's
> index by +1, and a concurrent close() before the cursor shifts indices
> by -1.
>
> Under that pattern, can SCTP_DIAG consumers observe duplicated
> endpoints (the previously-emitted entry now sits at the new *pos) or
> miss live endpoints (the next un-emitted entry is shifted past the
> cursor)?  The pre-patch sweep walked each bucket once with read_lock_bh
> held throughout, so this consistency window did not exist.
>
> [Low]
> For a bucket that contains N matching endpoints, does this restart
> pattern walk the bucket O(N^2) times?
>
> For a bucket {A,B,C} starting from *pos=3D0 the goto-again loop performs
> 1+2+3 traversals to dump three entries plus a final 3-entry walk that
> finds nothing and terminates with sk =3D=3D NULL, which is nine list
> iterations to dump three endpoints.  The pre-patch code walked each
> bucket exactly once because the callback ran while still holding
> read_lock_bh().
>
> The commit message describes the change as simplifying endpoint
> traversal; could the description also note the new per-bucket scan
> cost, or could a cursor that survives unlock/relock be used instead?
>
> > +                     if (err) {
> > +                             sock_put(sk);
> > +                             return err;
> > +                     }
> > +                     sock_put(sk);
> > +                     (*pos)++;
> > +
> > +                     idx =3D start;
> > +                     goto again;
> > +             }
> >       }
> >
> > -     return err;
> > +     return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(sctp_for_each_endpoint);

Low: #1, #2, #5, not really issues,
but worth mentioning about it in changelog.

Critical: #3, not valid.
socket refcnt can't be 0 when traversing the chain under read_lock_bh().

But it seems better to hold ep instead sk, and also to check
ep->base.dead instead of sk_state CLOSED.

Medium: #4, not valid.
it's completely okay to dump duplicate or skip socks because of
concurrent close() and listen() in diag.

will post v2 with some improvements mentioned above.

Thanks.

