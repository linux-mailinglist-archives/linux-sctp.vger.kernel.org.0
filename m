Return-Path: <linux-sctp+bounces-1300-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rQ8KMxqCQmo48wkAu9opvQ
	(envelope-from <linux-sctp+bounces-1300-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 16:32:58 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFDE6DC16B
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 16:32:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VdMXQgGN;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1300-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1300-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D6A030488EC
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 14:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1520A336886;
	Mon, 29 Jun 2026 14:23:08 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDF9356767
	for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 14:23:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742988; cv=pass; b=Qp/t8UNbGaCwhsv2+NpQL1lFtNlmvpq12bEjWk5nwJ4tbUUE5B17rwG7bRmwJszARfXSuUQFGRq+etN1sgcnOnVIy3x2bqQTUfc8irjzQYXrS8hfARaxciGBazBAzBPugmOK07h/pXJ7ENPoPb31MfiG/9HaM3j1gafrzEjasGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742988; c=relaxed/simple;
	bh=wiXq41bdBk83YHqf1MVi12r95Q6R/cZ8huPoVZGBeBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E1xXCNUxV0wMo9hfTKW99H0aXRat2TcoFfH5Jw3x55HIJyvtSPkddnYNX5zH44sfOXfwoYqzkMPcZK1M3sMIcqWm9/XwKHZ87X/m3fWmy5X3+/G4wbpnUei5xG1+Wf1y9m6f6jc+5Zl1L8P0IdcwDv6IqOYuiMVvXH9dnxH6cY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VdMXQgGN; arc=pass smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-847917c3678so287609b3a.1
        for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 07:23:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782742985; cv=none;
        d=google.com; s=arc-20260327;
        b=Awah0e5HVKMQr7HJjpshHeWQtIIbWh9bt1FIOLB1G0fxxV0GB6h88une5ZILRderki
         hTq+TdmmyTmU6lL4l5o+P0xolpAs8ylThgqRMw7xwHdnQtNJCmvIQGPS6P+/7Jh/Wosr
         3/H5u6qRiY1fa2OlwA+OyNcl6cMhrej3Ck/Jz4+R30lDvTxsAXoVh1F/9d3wIrlEs+24
         al6kemusAulH4uMvfL7kGyerybMm45QeOJVHqWAvDbxKsvs1oDSGXmWl02Or5n2R9Pwy
         Mgy/WgB5xMW1H41XNAyE7Y4Z+i/RSVXw0LTF9d7eJlrqwaJNM2tM4r3xYtDVpJmdzrpE
         bAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0cymoUNheibESxQ4Mfp0MF9t6LNlS01Gf5IRX3wTSo=;
        fh=5mE9YKyD9LnS41mvu0sAy8CWmtzgSGnPk3QqMF0TRQY=;
        b=Y4ABjrBdruMjOZx6SjfSP//x1xAl/7tQN/OBqF1kmzwbYPR9x+WBD+IujPX/wE1JL9
         MPAJyFN/MnB6upzLb6MexV6YA2IZm2IrmOAMe73LMIB2Quwd/E+Z3bX0daNi4ak9JTOM
         kdJW3ie5f1bZqFs3b57j4FKHc/9PFpOxjqAA8nsxOjk8nZHxYdtPjTbL1vtB3vVGfIkQ
         /MXIGdmhmFhZ2ZlGq5uBQBjHUpUoU3ujSUt5Zu17kR+upp6PyIzcQ8s19sjmn6h9dJJZ
         4ndwKIj5KS6HF10hmwbNJKlSclENV22AcE2wkIXFYtJzxf4N9XgNdrTwNt8w//PsF71M
         seqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782742985; x=1783347785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0cymoUNheibESxQ4Mfp0MF9t6LNlS01Gf5IRX3wTSo=;
        b=VdMXQgGNdq87zEURJeYmtTrz+9/5t4hCB+f00IjXNGfdAfsqUHYngnt34PZqSjREh0
         ktcME8C6XemNoCisbyI+B8nMwk8ap3qTcTb62sSol/0zD8NEnLR/Y4C0etrKHs3hPM3Q
         KbnqR306u2Cq6liKmuD9cWoB5io7zac8CkovdRWgTsjPETnFIEreP0gVLGYktZgPGCJX
         xDxV/RwMB9QaeNqdJ6MDDy1x9R590QGQ4ipvnUFw4cr1bOaogpImemH62jr7sznzArNz
         iIhBdl2RIjtzbe8toVxmUsmx41alIbv8R59d1rsrUl1weLd4t7FAYq2SxvWXjkZzzOB6
         yCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782742985; x=1783347785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0cymoUNheibESxQ4Mfp0MF9t6LNlS01Gf5IRX3wTSo=;
        b=coqivZljO76fPl0FBkZ8qZmE3PhGqKK7emP7u4uPhscO4hP/2yISNFLsSPWK/goIdG
         QMGURuwoBJs44OKAvRPJovjkDuXBrSzLNUCWJ3mZPpLj6ZBMH0ddlZ47ngYdJ5S4U9rr
         NHnKG4/J+WNy6lzZh5ppUkUTUmOBqUA5yUCx5BKO7XHAvlr2urkAH0MawPe2PDA+diDL
         C4wiI3eWu21G0Deet7WqWaRfPM7y8bH2L72mUcd7SXHFCoxJlPRMfvUtxX2+stjVlLoE
         6ZlnN4G6pm/6ptUgHE3zB+3WbqJX9+yXVCuzImdJeLjX3Jwmhlcu6VuUP8tuK8SKSJWI
         wRBg==
X-Gm-Message-State: AOJu0YxXscxunNhei5YpLQoSz7IpcfY4kUEx0ZwQSL7PG6a5rwYDVJ3V
	V8OV7+UxNaIb2SSJDTyQDuM44Kwu4dPhRXFj+60hV20iNILyAP8H7zGuQxQBnNflbZmzsiNc6rC
	Fabf+VI/D2IpOQBwAbizEeCDqsTL2mnI=
X-Gm-Gg: AfdE7cmBXeH7jD5yn0ZiQn8ej9aE69HKZ8UB5CxEiqdni67KfXAP7/FTQiDOzz04Tod
	emQWulguDvcCPgaJcsvizZEmqaDRGjAcWb7F5xwuYcLRT5inuxSAA1yJnvM0vDG9eQnfGBfXqc4
	MN5Elv9Z3wVj1q5jy2VZXcsRclrm41QF6WW+QwnOTVbLuRoPpzzZUv6O5HlNC4PczJOp/pGqlwV
	jFCU2G+k0o3R9X/Q9uis49xzwi/QAjcxSMt9+xYhtSW0wcKpL40z8MTVHdaMErBmP/ypIjgKw+g
	cSs10SUFcvfmkDnRp+FW3Rbq8kTMoJUybyEkAOBtAmdQ16LqmHINonX229xtqmxDp/xN4WLbyr7
	0eYcxkg==
X-Received: by 2002:a05:6a00:b53:b0:847:8bd0:1b96 with SMTP id
 d2e1a72fcca58-8478bd026dbmr2120595b3a.23.1782742985236; Mon, 29 Jun 2026
 07:23:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782585631.git.roxy520tt@gmail.com> <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
 <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com>
In-Reply-To: <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 29 Jun 2026 10:22:53 -0400
X-Gm-Features: AVVi8Cc0LriEm6penJth8F-rFoWHt7QeBo7GRJOclqZWHvFXGZ2zmHrD3gGImbY
Message-ID: <CADvbK_dn+1qsxgF_LXyBFC+Lep91bCgBDdynx_8c5QnQHp85eA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] sctp: avoid auth_enable sysctl UAF during netns teardown
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	marcelo.leitner@gmail.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, matttbe@kernel.org, yuantan098@gmail.com, 
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn, 
	roxy520tt@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1300-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lzu.edu.cn];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABFDE6DC16B

On Mon, Jun 29, 2026 at 10:04=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Sun, Jun 28, 2026 at 4:40=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
> >
> > From: Zhiling Zou <roxy520tt@gmail.com>
> >
> > proc_sctp_do_auth() updates the SCTP control socket after changing
> > net.sctp.auth_enable.  The handler gets the per-net SCTP state from
> > ctl->data, so an already opened sysctl file can still target a network
> > namespace while that namespace is being torn down.
> >
> > SCTP unregisters its per-net sysctls from sctp_defaults_exit(), but
> > sctp_ctrlsock_exit() runs earlier because the control-socket pernet ops
> > are registered after the defaults ops.  This leaves a teardown window
> > where auth_enable is still writable after inet_ctl_sock_destroy() has
> > released net->sctp.ctl_sock, leading to a use-after-free when the sysct=
l
> > handler locks and dereferences the stale socket.
> >
> > Unregister the per-net SCTP sysctl table before destroying the control
> > socket.  Make sctp_sysctl_net_unregister() tolerate a missing header an=
d
> > clear the saved pointer so the later defaults exit path and init-error
> > path can safely share the same unregister helper.
> >
> > Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current->n=
sproxy")
> > Cc: stable@vger.kernel.org
> > Reported-by: Yuan Tan <yuantan098@gmail.com>
> > Reported-by: Yifan Wu <yifanwucs@gmail.com>
> > Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> > Reported-by: Xin Liu <bird@lzu.edu.cn>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> > Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> > ---
> >  net/sctp/protocol.c | 3 +++
> >  net/sctp/sysctl.c   | 9 +++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> > index 587b0017a67d..ae381d304bd5 100644
> > --- a/net/sctp/protocol.c
> > +++ b/net/sctp/protocol.c
> > @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct =
net *net)
> >
> >  static void __net_exit sctp_ctrlsock_exit(struct net *net)
> >  {
> > +       sctp_sysctl_net_unregister(net);
> > +
> >         /* Free the control endpoint.  */
> >         inet_ctl_sock_destroy(net->sctp.ctl_sock);
> > +       net->sctp.ctl_sock =3D NULL;
> >  }
> >
> >  static struct pernet_operations sctp_ctrlsock_ops =3D {
> > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > index 15e7db9a3ab2..fca840484ebf 100644
> > --- a/net/sctp/sysctl.c
> > +++ b/net/sctp/sysctl.c
> > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> >
> >  void sctp_sysctl_net_unregister(struct net *net)
> >  {
> > +       struct ctl_table_header *header =3D net->sctp.sysctl_header;
> >         const struct ctl_table *table;
> >
> > -       table =3D net->sctp.sysctl_header->ctl_table_arg;
> > -       unregister_net_sysctl_table(net->sctp.sysctl_header);
> > +       if (!header)
> > +               return;
> > +
> > +       table =3D header->ctl_table_arg;
> > +       unregister_net_sysctl_table(header);
> >         kfree(table);
> > +       net->sctp.sysctl_header =3D NULL;
> >  }
> >
> >  static struct ctl_table_header *sctp_sysctl_header;
> > --
> > 2.43.0
> >
>
> Please also move sctp_sysctl_net_register() to sctp_ctrlsock_init(), and =
call
> it AFTER sctp_ctl_sock_init().
>
> This is not just for being symmetric, but also fixes two problems:
>
> 1. A regression caused by this patch:
>
> If sctp_v4_protosw_init() or sctp_v6_protosw_init() fails in sctp_init(),
> there's no place to call sctp_sysctl_net_unregister() on the err path.
>
> 2. A pre-existing issue reported by sashiko-gemini:
>
> > diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> > index 15e7db9a3ab2e..fca840484ebf7 100644
> > --- a/net/sctp/sysctl.c
> > +++ b/net/sctp/sysctl.c
> > @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
> >
> > void sctp_sysctl_net_unregister(struct net *net)
> > {
> > + struct ctl_table_header *header =3D net->sctp.sysctl_header;
> > const struct ctl_table *table;
> This is a pre-existing issue, but I noticed a potential race condition
> during SCTP module initialization related to the sysctls modified here.
> During sctp_init(), sctp_defaults_ops registers the sysctls globally befo=
re
> sctp_ctrlsock_ops allocates net->sctp.ctl_sock:
> sctp_init() {
> ...
> status =3D register_pernet_subsys(&sctp_defaults_ops);
> if (status)
> goto err_register_defaults;
> ...
> status =3D register_pernet_subsys(&sctp_ctrlsock_ops);
> ...
> }
> If userspace accesses the sysctls in this window, proc_sctp_do_auth() cou=
ld
> dereference a NULL pointer since it assumes ctl_sock is ready:
> proc_sctp_do_auth() {
> ...
> struct sock *sk =3D net->sctp.ctl_sock;
> net->sctp.auth_enable =3D new_value;
> /* Update the value in the control socket */
> lock_sock(sk);
> ...
> }
> Can we hit a kernel panic here if the sysctl is modified during automatic
> module loading?
> [...]
>

Also, if you don't mind, please try to address another issue reported
in sashiko-gemini:

> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 587b0017a67d5..ae381d304bd53 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct ne=
t *net)
>
> static void __net_exit sctp_ctrlsock_exit(struct net *net)
> {
This isn't a bug introduced by this patch, but while reviewing the netns
teardown sequence, I noticed the SCTP UDP tunnel sockets appear to leak.
In sctp_defaults_exit():
sctp_defaults_exit() {
/* Free the local address list */
sctp_free_addr_wq(net);
sctp_free_local_addr_list(net);
...
}
Should sctp_defaults_exit() call sctp_udp_sock_stop(net) to ensure the
UDP tunnel sockets are closed?
If a user creates a network namespace, writes to the net.sctp.udp_port sysc=
tl
to allocate the sockets, and then destroys the namespace, could these socke=
ts
remain active and cause a use-after-free of struct net when packets arrive?
[...]

maybe by adding sctp_udp_sock_stop() in sctp_ctrlsock_exit(), and call it A=
FTER
sctp_sysctl_net_unregister() in a separate patch.

Thanks.

