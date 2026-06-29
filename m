Return-Path: <linux-sctp+bounces-1299-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ri0NLLN8QmqJ8QkAu9opvQ
	(envelope-from <linux-sctp+bounces-1299-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 16:09:55 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440BF6DBC7A
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 16:09:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OeOwTVAE;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1299-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1299-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 718323021CAE
	for <lists+linux-sctp@lfdr.de>; Mon, 29 Jun 2026 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD0D351C35;
	Mon, 29 Jun 2026 14:05:12 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDA234E774
	for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 14:05:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741912; cv=pass; b=NLDIfJpd4QJzep+Cz2HkWr2HUSlA3GNpbs1kvDH93+G6Ft/3hY+1pjh3zF/JJrrzgzCbN3y34mw+SC43DeADePoHacbJVa/1mYhT33WS3IKE2Ritru13RvnUnDEz78chvS0daJL0FbkFqSFgWZdt4QPnkO6uZKPXmaH0DLtzysw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741912; c=relaxed/simple;
	bh=cs1kPtPPS19ArMNxPNUYHq/WmdH96LCYU5yr3oE4dOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8joiWwBe1fMcQO51ZJF6MuZrXXECQdyUPL8A1z+iSNg6Zfp6LPHtbJutQeDlK9MB4mdds//cJuEvKVXiKOdRdeOrkvNe9/usNQEWi+8da2UUEFAbO0Mf5X62GUv643XKCGhU5hu3NoCS822Gay/uyBFo2D4t4lZli6MfDcBsAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeOwTVAE; arc=pass smtp.client-ip=209.85.210.170
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-842338c18e0so2322631b3a.1
        for <linux-sctp@vger.kernel.org>; Mon, 29 Jun 2026 07:05:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782741910; cv=none;
        d=google.com; s=arc-20260327;
        b=kjT7R52fHcVuNbjskWgfbEICxPHj/JjP5ZyyeVlgJ8sfTXsoIsVZlovidxEBBupC08
         KaWkwFzvp3zGmLdl5RPuGmyrzoQVyHYuajRIr3sd8J/38S2jB6LgywhpAnZ6MeKQoc15
         yeBVEaLPoSdWHM27ZRgoHyJA3siPBKk76TiWyDeREYfMlTwsfsVkDmzvU/cwB8rkIhpL
         M8C2gARzujseYJIinacd/IPK0uat2SsTRtcwyRbX2DfZR9tDd35dnxdIWy8d6NkjQmUj
         4JKfkZIWhOfexTD8k8cw+RTh97XSQ2MJzQzFWPXFQfQg9t75wRa0ba9+nR9Xgl4po1Ja
         d0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vjjrnHH03TsaWfGwzNnjbGQph+TjFJTi5n3JvZIW9mk=;
        fh=5mE9YKyD9LnS41mvu0sAy8CWmtzgSGnPk3QqMF0TRQY=;
        b=FwiJ6+peUwWYvEOO2ybEdHYzmbDj1HlFOpSpvz0MIEqFrLTD0Hqmi9hrjb7GxUp2WE
         KIMx3aKKY2mlnU5Y963QjIZckyxICxwwTjTCclphuxPN4AG33kLVWMYEbSPvbQIK87cP
         lQjGtc9BIvHXeGxyx46k4ALNeS6DtNG2hvQCFkZdZif1MXY1bp8FcMyZ4Rbc0vIyKzbj
         zgv4PLjIwmeB6wuN/XA3unnupkbRZ4SW14Uk7KSfQbO56N8MhMCaI2Ki+NDpAkr6XpH2
         GdlorJHXIO3opyOzA/WQLA13rAAvY4JJ7cmVsz6K9yNrdiDiXm1fJSZgfFwtxx3UpMVY
         bBUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782741910; x=1783346710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjjrnHH03TsaWfGwzNnjbGQph+TjFJTi5n3JvZIW9mk=;
        b=OeOwTVAEyW4WN2zX23C8Qll+fVhXa4EH7hfA1XRlHwyjxKr0JgfdNna2o+MsnYcSrG
         kwEwjx3hhNQh27UGDrJWIEZzWPOdl19FBNlk2lJl54oxSq3wtsmC5tSPPobTdcZY8hVs
         yBFhkptkQP2sHmnw9qw7w0yftGS4ZCpcrClxN0GLzwCu2DcZ9R4EicbujXua/gRpI0sm
         wgKwcZ9oxrfjhP7A7WzT/Nt0cDUa2dNJOIQKoX8RbsrfGa4IwGIPX6PJ+qOiFe6CcfzU
         HsVn9YK68ek4PC/hXck6ksVr2WYa2HY1jVNYdo+cqLWZjwDvnY6rPma2/X3SrD3Ga7J6
         qMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782741910; x=1783346710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjjrnHH03TsaWfGwzNnjbGQph+TjFJTi5n3JvZIW9mk=;
        b=fMDPNhM00QjO5M3FsRVfxDzfHumzrYvwzDClXLPKYBHxbeZTYuIRpCLocIDcab0dPe
         1Dom4SxcEOBpGnMVClPQCfuoB5InGqKFf0cvMjT4H3bjZ7o9W+/Nui+T3PBI2yDFsQ62
         HQzNIGLLvdvhrYc45sgryLXYeyu2eAWW88+wJOP82/8vC0kiViZhxQ+vVcl/bEHfx8aJ
         68uT5hS/K3+JPZBpY/Ypxvcy+IM1UsLkagKZn9S7gQz9Ga5V1LcCqR4E8/K4MSbt07ER
         g7I8ocaThf3cjGUlHjCrDizdXZcc6hPtuVdDMrbGF8Tpm9uVy+dtT7yqfIPy5JAz4Lel
         IFOg==
X-Gm-Message-State: AOJu0YzrA1kczJai0Xq2IMpSpGHVL/ERShokNoexi5bOukqZiY7OHsvK
	mFNMXfKBPWIEEmh4aHINX26K1mtgNPD0SeKw9uXcDsSNNRv+gSZRr6ELQNgcazAlz8h4lJWr2NU
	XA7RilupJwvcHGaYVcOulh2xOm10a2QQ=
X-Gm-Gg: AfdE7cnBvDI9LzM4OP/t1J4dMGkPZATfEn/07d0D4riFJVYpX6KHrsgdwl8LJPzJd8l
	8e6CqjYGAUDf7iQhr+FognY/wuHzw/8GXWQn5s6hVhkOaCXnQ/aWbksdfRUbquPqvyFu+bm8P1m
	hZJzeNGTdKActv9On1o0BtRT1jVUfhimj6zdz5kKTDoi4S48M2AzWdUVGlct545bpIunF4Owbs/
	EYWamlyAIrQ7/u3VuniFyIV32zdGhgWaAt1t8363J2uP0VQzcHg2/wzG3BSSDadhW9fl6QSqSyg
	0LkQoTzjd+19lVOnbvhZweygbWJMJXJqTbZPI2jokFQzj6NPBqBHz9NzsobhHQZujRLGTAE=
X-Received: by 2002:a05:6a00:2383:b0:845:e0ee:29ec with SMTP id
 d2e1a72fcca58-845e0ee5b0amr6169787b3a.35.1782741909891; Mon, 29 Jun 2026
 07:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1782585631.git.roxy520tt@gmail.com> <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
In-Reply-To: <b9f1f02b0780ad6a719e2413f5f0bb8eb7702d94.1782585631.git.roxy520tt@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 29 Jun 2026 10:04:58 -0400
X-Gm-Features: AVVi8CcY3NR_-y9qUrLG5IFlanrznpuFWa7VkDonL3QllR3_TapyoSkskTidgUU
Message-ID: <CADvbK_cYeewNprxJ88TdRnCr2QTh1px8vxdqikBovb+dTEtp8Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:matttbe@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-1299-lists,linux-sctp=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 440BF6DBC7A

On Sun, Jun 28, 2026 at 4:40=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Zhiling Zou <roxy520tt@gmail.com>
>
> proc_sctp_do_auth() updates the SCTP control socket after changing
> net.sctp.auth_enable.  The handler gets the per-net SCTP state from
> ctl->data, so an already opened sysctl file can still target a network
> namespace while that namespace is being torn down.
>
> SCTP unregisters its per-net sysctls from sctp_defaults_exit(), but
> sctp_ctrlsock_exit() runs earlier because the control-socket pernet ops
> are registered after the defaults ops.  This leaves a teardown window
> where auth_enable is still writable after inet_ctl_sock_destroy() has
> released net->sctp.ctl_sock, leading to a use-after-free when the sysctl
> handler locks and dereferences the stale socket.
>
> Unregister the per-net SCTP sysctl table before destroying the control
> socket.  Make sctp_sysctl_net_unregister() tolerate a missing header and
> clear the saved pointer so the later defaults exit path and init-error
> path can safely share the same unregister helper.
>
> Fixes: 15649fd5415e ("sctp: sysctl: auth_enable: avoid using current->nsp=
roxy")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sctp/protocol.c | 3 +++
>  net/sctp/sysctl.c   | 9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
> index 587b0017a67d..ae381d304bd5 100644
> --- a/net/sctp/protocol.c
> +++ b/net/sctp/protocol.c
> @@ -1457,8 +1457,11 @@ static int __net_init sctp_ctrlsock_init(struct ne=
t *net)
>
>  static void __net_exit sctp_ctrlsock_exit(struct net *net)
>  {
> +       sctp_sysctl_net_unregister(net);
> +
>         /* Free the control endpoint.  */
>         inet_ctl_sock_destroy(net->sctp.ctl_sock);
> +       net->sctp.ctl_sock =3D NULL;
>  }
>
>  static struct pernet_operations sctp_ctrlsock_ops =3D {
> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index 15e7db9a3ab2..fca840484ebf 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
>
>  void sctp_sysctl_net_unregister(struct net *net)
>  {
> +       struct ctl_table_header *header =3D net->sctp.sysctl_header;
>         const struct ctl_table *table;
>
> -       table =3D net->sctp.sysctl_header->ctl_table_arg;
> -       unregister_net_sysctl_table(net->sctp.sysctl_header);
> +       if (!header)
> +               return;
> +
> +       table =3D header->ctl_table_arg;
> +       unregister_net_sysctl_table(header);
>         kfree(table);
> +       net->sctp.sysctl_header =3D NULL;
>  }
>
>  static struct ctl_table_header *sctp_sysctl_header;
> --
> 2.43.0
>

Please also move sctp_sysctl_net_register() to sctp_ctrlsock_init(), and ca=
ll
it AFTER sctp_ctl_sock_init().

This is not just for being symmetric, but also fixes two problems:

1. A regression caused by this patch:

If sctp_v4_protosw_init() or sctp_v6_protosw_init() fails in sctp_init(),
there's no place to call sctp_sysctl_net_unregister() on the err path.

2. A pre-existing issue reported by sashiko-gemini:

> diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
> index 15e7db9a3ab2e..fca840484ebf7 100644
> --- a/net/sctp/sysctl.c
> +++ b/net/sctp/sysctl.c
> @@ -615,11 +615,16 @@ int sctp_sysctl_net_register(struct net *net)
>
> void sctp_sysctl_net_unregister(struct net *net)
> {
> + struct ctl_table_header *header =3D net->sctp.sysctl_header;
> const struct ctl_table *table;
This is a pre-existing issue, but I noticed a potential race condition
during SCTP module initialization related to the sysctls modified here.
During sctp_init(), sctp_defaults_ops registers the sysctls globally before
sctp_ctrlsock_ops allocates net->sctp.ctl_sock:
sctp_init() {
...
status =3D register_pernet_subsys(&sctp_defaults_ops);
if (status)
goto err_register_defaults;
...
status =3D register_pernet_subsys(&sctp_ctrlsock_ops);
...
}
If userspace accesses the sysctls in this window, proc_sctp_do_auth() could
dereference a NULL pointer since it assumes ctl_sock is ready:
proc_sctp_do_auth() {
...
struct sock *sk =3D net->sctp.ctl_sock;
net->sctp.auth_enable =3D new_value;
/* Update the value in the control socket */
lock_sock(sk);
...
}
Can we hit a kernel panic here if the sysctl is modified during automatic
module loading?
[...]

Thanks.

