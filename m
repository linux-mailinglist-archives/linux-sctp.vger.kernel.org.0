Return-Path: <linux-sctp+bounces-1301-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FOvUC8aRQmqj9wkAu9opvQ
	(envelope-from <linux-sctp+bounces-1301-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 17:39:50 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1136DCCE8
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 17:39:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Zz8Q8muc;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1301-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1301-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAB91308681D
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6765737C936;
	Mon, 29 Jun 2026 15:31:52 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B7336EDE
	for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 15:31:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747112; cv=pass; b=KoeyVJBkVVYm7vbyW+KDJc3ku0HQ+lmvM/X4D8bCS3WZJrm8krstIZpmL4rnRpdvJeHlfQNCbXyI3sCDWZLZabffDWlM+Y++PKyvahoIUrj5IFSIEoT0iPxbTo4GGelg8U5Oja3m/oIFEJjqm1+LEpMewiWDoPAdZGSfOTNTuB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747112; c=relaxed/simple;
	bh=dgQq7uOtRk1Fieb4AjgFns8G5xGk1jK0JDbMwPCnVVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKUZ6IuimsB/9lgGBD7cnZr2zI4yodTl+JVoHmGiUeRYY46gvGyzUQ7lWXyZio/mG7OW6BwlnP7AQz7NZOK44ovsAzl7YOSZuYXd+4XyisM3ZMr5hIsvh9QajvsGkorYNVefhsmuvmwOMBgJz7N+EFP7IV18dzedkGvNjfciqpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zz8Q8muc; arc=pass smtp.client-ip=209.85.218.67
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-c124c3c876aso270347966b.1
        for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 08:31:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782747109; cv=none;
        d=google.com; s=arc-20260327;
        b=hQ2wzzMQXSMhqRJAPDwyAugWib3VV3IRbkUrAXjmnc9d5TIh13YT+qAKYVNBiRQ/Sy
         geKT+ImTE5G5/nBKxCPYAIfmQs4T3Pk4C/BTc+QWtwtyFBcIEkS6P6kxlRkKUh8HHbd5
         kuhPUtMxUUYqEkEjkha1VBiaDkLGYXBIIiksLWG2epqZDoCg4CkrFbtOAZOOpWC8PEDn
         XpvGJ5YZT+cSq9P8GgixAmOoh4CEMysdVGwFjy6swfoTbRqyyq03ZGi0eKkmpOGH0L+e
         bmjQ7//U91K3AgcukvY49oUN/vrgHE6zFHCXoD5VhDhObNkWhEyPRx0BCJONXQarR8+s
         waSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OfTvysHiKTVLC5lWfMwwQ91YnzE9lVNEHowxJSHj8Q4=;
        fh=ECKTx8cQ4gGpTJSXbJ2B5ITZ9oLp6ptAOIIGRAAHNLI=;
        b=LLvWW7hObxUO5G4VDbyzg0QqDdLYDLOnkhYcLej/ltrgAEVsTSfByfeDubNfRPWrmi
         qxmr9DX7PjzNGhQgZ5z+BbwIPWtFbiJxj+QW+0eC1iNh5JZcsKE8fbxjx/LNUSmPYj+7
         CxQ34grQcOTEsGQP4lamMv9RsT5iL2WN+yAQUy16p7GE7CdkzEVteAXz4cCirw6tPRBP
         NIE8VMHnUDgG1HlqJ3eC9hKvtVese8vSxlB16QuAUrqESkuWsHRnO7GiroE1Jcb3Wb6h
         V5zrmDY/l58p5K4R4jrRsw72gB3NLagbj0e14z8F0bOrmYJYIdHS87YyDn11+LNYE2mC
         /JIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782747109; x=1783351909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfTvysHiKTVLC5lWfMwwQ91YnzE9lVNEHowxJSHj8Q4=;
        b=Zz8Q8mucCXSuIJQ0dFhAbQdvwstPbz0TFHGHqcKaADUqX2zFCgtQHbsQmTjD1z7aIm
         ghy0dU6oeqZjeW0iSPGrtEG+hkWZeDZcVWcgXQmxiAaWD9mcXpsPJC40tBPxTjtg1ZiN
         zMnlRbUuoA34ejRvP0bSfrgEVw9pp7EMTUb3gSA7DHwHSdhCbkzZstvQSfo14FNH4Exr
         hqFrNxjKgivv9iBYksNXnEgJJv37FnmbMzZr8qyozup9jdJT2vCCStxDYpO4Ozk8NFhW
         dSDwIAM/oXuoE8A3D1Ajrmn7GnMMJVaepiGs3qQgiZ+Ubnx6CecBATMyreqHJv8QpDn6
         3PXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782747109; x=1783351909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OfTvysHiKTVLC5lWfMwwQ91YnzE9lVNEHowxJSHj8Q4=;
        b=NTmGbciAFag/TVvm8zSKKgssyMyXmnrZeHp+NB629LOKRz/UWbFwLwFUF8y/TdFg7L
         sxVGBEY2QZW2gyKFSi8gf5V+MI0mhrtBN5o5SaNhSgaUbzlCCR3u1D9/KKc78fz9yV7t
         N13FzoAf7dRvHXxndXRPcCZBrVh2TBfgfL0mtXj7ukMKyxECWlfp9NqtPonv9YM6pELi
         GuSi+rV76EdO9Ch1xE+RUgRmHRvG65BjcOn3LxJplh/g9jhcnpVF2pZa7CWV4JZU7tRE
         43HVvp+lbsjhR5GT/6soMOa3BzQNB5PnrhNJ4myYjoV3XoRYnoai9WqU2PB8QUR+3uqV
         mQxg==
X-Forwarded-Encrypted: i=1; AHgh+Rp4dsyL8pdvZO61FuVS1IY2jDaKev9eTsxzczglNRPvw9qXTNBMaCzOpfjySHI+n/tzRTl8AXzrFlOm@vger.kernel.org
X-Gm-Message-State: AOJu0YwiQpsxzqdC80n5IA59gQWvj4Aoop9nJALmOBGat45m3fdxQxfv
	DmQPt3JsjrtWn69d8bYvv5tBoY3JYpY73rUEKbD2s8obYfr89jjXcyLbzPQo55MI2WEtbP82rP8
	609Y0QEj86NShYrbmm/w2RGjOsiUYcgE=
X-Gm-Gg: AfdE7ckikdZ7+WdLiRDy/5rLJAISLnTWpumxlyYiPnADZJvl3bMd/j22rZ5DHnc6DvT
	thCmuXxwmr+FjVD0N0rFOS5pzFBrkXahwaX8dsB+MvqV5EfzlOr8u5abbSUPoEu5foHYgAhIeb/
	HMsV+aExfLqocFjdqdTZAm1LkoFEu4SLbnMcV9IrPeTapARwfd+Ckx9eqGX0C6Rep29aa1VMyVi
	cLxnR6UCHeFU7360WulTTcGK5HFdTaCd6eL8PpyI0DMAkfMK9KEUgJLlrbqMLFAJJssmlx+6ny4
	BbhB814=
X-Received: by 2002:a17:906:6a0f:b0:c12:67e9:bf25 with SMTP id
 a640c23a62f3a-c1267e9ec2cmr210780766b.42.1782747108817; Mon, 29 Jun 2026
 08:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782585631.git.roxy520tt@gmail.com> <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
 <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com> <CADvbK_dn+1qsxgF_LXyBFC+Lep91bCgBDdynx_8c5QnQHp85eA@mail.gmail.com>
In-Reply-To: <CADvbK_dn+1qsxgF_LXyBFC+Lep91bCgBDdynx_8c5QnQHp85eA@mail.gmail.com>
From: tt roxy <roxy520tt@gmail.com>
Date: Mon, 29 Jun 2026 23:31:35 +0800
X-Gm-Features: AVVi8CcQjQMp_xcdx0xwS5kqGRWw-qKmoeiNy_pIdDDyyaU1tDfx-MgT7CJLDQo
Message-ID: <CALMqdkR5M5oTTLS9Cisq6C5kM4byoCL3XHBWKXdq3awD1j3X9w@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: avoid auth_enable sysctl UAF during netns teardown
To: Xin Long <lucien.xin@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:lucien.xin@gmail.com,m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:lucienxin@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[roxy520tt@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-1301-lists,linux-sctp=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roxy520tt@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD1136DCCE8

On Mon, Jun 29, 2026 at 10:23=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Mon, Jun 29, 2026 at 10:04=E2=80=AFAM Xin Long <lucien.xin@gmail.com> =
wrote:
> >
> > On Sun, Jun 28, 2026 at 4:40=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrot=
e:
> > >
> > > From: Zhiling Zou <roxy520tt@gmail.com>
> > >
> > > proc_sctp_do_auth() updates the SCTP control socket after changing
> > > net.sctp.auth_enable.  The handler gets the per-net SCTP state from
> > > ctl->data, so an already opened sysctl file can still target a networ=
k
> > > namespace while that namespace is being torn down.
> > >
> > > SCTP unregisters its per-net sysctls from sctp_defaults_exit(), but
> > > sctp_ctrlsock_exit() runs earlier because the control-socket pernet o=
ps
> > > are registered after the defaults ops.  This leaves a teardown window
> > > where auth_enable is still writable after inet_ctl_sock_destroy() has
> > > released net->sctp.ctl_sock, leading to a use-after-free when the sys=
ctl
> > > handler locks and dereferences the stale socket.
> > >
> > > Unregister the per-net SCTP sysctl table before destroying the contro=
l
> > > socket.  Make sctp_sysctl_net_unregister() tolerate a missing header =
and
> > > clear the saved pointer so the later defaults exit path and init-erro=
r
> > > path can safely share the same unregister helper.
> > >
> > > Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current-=
>nsproxy")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > > Assisted-by: Codex:gpt-5.4
> > > Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> > > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > > ---
> > >  net/sctp/protocol.c | 3 +++
> > >  net/sctp/sysctl.c   | 9 +++++++--
> > >  2 files changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > > index 587b0017a67d..ae381d304bd5 100644
> > > --- a/net/sctp/protocol.c
> > > +++ b/net/sctp/protocol.c
> > > @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struc=
t net *net)
> > >
> > >  static void __net_exit sctp_ctrlsock_exit(struct net *net)
> > >  {
> > > +       sctp_sysctl_net_unregister(net);
> > > +
> > >         /* Free the control endpoint.  */
> > >         inet_ctl_sock_destroy(net->sctp.ctl_sock);
> > > +       net->sctp.ctl_sock =3D NULL;
> > >  }
> > >
> > >  static struct pernet_operations sctp_ctrlsock_ops =3D {
> > > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > > index 15e7db9a3ab2..fca840484ebf 100644
> > > --- a/net/sctp/sysctl.c
> > > +++ b/net/sctp/sysctl.c
> > > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> > >
> > >  void sctp_sysctl_net_unregister(struct net *net)
> > >  {
> > > +       struct ctl_table_header *header =3D net->sctp.sysctl_header;
> > >         const struct ctl_table *table;
> > >
> > > -       table =3D net->sctp.sysctl_header->ctl_table_arg;
> > > -       unregister_net_sysctl_table(net->sctp.sysctl_header);
> > > +       if (!header)
> > > +               return;
> > > +
> > > +       table =3D header->ctl_table_arg;
> > > +       unregister_net_sysctl_table(header);
> > >         kfree(table);
> > > +       net->sctp.sysctl_header =3D NULL;
> > >  }
> > >
> > >  static struct ctl_table_header *sctp_sysctl_header;
> > > --
> > > 2.43.0
> > >
> >
> > Please also move sctp_sysctl_net_register() to sctp_ctrlsock_init(), an=
d call
> > it AFTER sctp_ctl_sock_init().
> >
> > This is not just for being symmetric, but also fixes two problems:
> >
> > 1. A regression caused by this patch:
> >
> > If sctp_v4_protosw_init() or sctp_v6_protosw_init() fails in sctp_init(=
),
> > there's no place to call sctp_sysctl_net_unregister() on the err path.
> >
> > 2. A pre-existing issue reported by sashiko-gemini:
> >
> > > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > > index 15e7db9a3ab2e..fca840484ebf7 100644
> > > --- a/net/sctp/sysctl.c
> > > +++ b/net/sctp/sysctl.c
> > > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> > >
> > > void sctp_sysctl_net_unregister(struct net *net)
> > > {
> > > + struct ctl_table_header *header =3D net->sctp.sysctl_header;
> > > const struct ctl_table *table;
> > This is a pre-existing issue, but I noticed a potential race condition
> > during SCTP module initialization related to the sysctls modified here.
> > During sctp_init(), sctp_defaults_ops registers the sysctls globally be=
fore
> > sctp_ctrlsock_ops allocates net->sctp.ctl_sock:
> > sctp_init() {
> > ...
> > status =3D register_pernet_subsys(&sctp_defaults_ops);
> > if (status)
> > goto err_register_defaults;
> > ...
> > status =3D register_pernet_subsys(&sctp_ctrlsock_ops);
> > ...
> > }
> > If userspace accesses the sysctls in this window, proc_sctp_do_auth() c=
ould
> > dereference a NULL pointer since it assumes ctl_sock is ready:
> > proc_sctp_do_auth() {
> > ...
> > struct sock *sk =3D net->sctp.ctl_sock;
> > net->sctp.auth_enable =3D new_value;
> > /* Update the value in the control socket */
> > lock_sock(sk);
> > ...
> > }
> > Can we hit a kernel panic here if the sysctl is modified during automat=
ic
> > module loading?
> > [...]
> >
>
> Also, if you don't mind, please try to address another issue reported
> in sashiko-gemini:
>
> > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > index 587b0017a67d5..ae381d304bd53 100644
> > --- a/net/sctp/protocol.c
> > +++ b/net/sctp/protocol.c
> > @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct =
net *net)
> >
> > static void __net_exit sctp_ctrlsock_exit(struct net *net)
> > {
> This isn't a bug introduced by this patch, but while reviewing the netns
> teardown sequence, I noticed the SCTP UDP tunnel sockets appear to leak.
> In sctp_defaults_exit():
> sctp_defaults_exit() {
> /* Free the local address list */
> sctp_free_addr_wq(net);
> sctp_free_local_addr_list(net);
> ...
> }
> Should sctp_defaults_exit() call sctp_udp_sock_stop(net) to ensure the
> UDP tunnel sockets are closed?
> If a user creates a network namespace, writes to the net.sctp.udp_port sy=
sctl
> to allocate the sockets, and then destroys the namespace, could these soc=
kets
> remain active and cause a use-after-free of struct net when packets arriv=
e?
> [...]
>
> maybe by adding sctp_udp_sock_stop() in sctp_ctrlsock_exit(), and call it=
 AFTER
> sctp_sysctl_net_unregister() in a separate patch.
>
> Thanks.

Thanks for the review.

I addressed both comments in v2. Patch 1 moves the per-net SCTP sysctl

registration after sctp_ctl_sock_init() and keeps the unregister before

destroying the control socket. Patch 2 separately stops the SCTP UDP tunnel

sockets after sysctl unregistration during netns teardown.

I will send the v2 series as a new threaded 0/2, 1/2, 2/2 patch series.

Thanks,

Zhiling

