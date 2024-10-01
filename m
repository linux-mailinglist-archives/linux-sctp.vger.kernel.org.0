Return-Path: <linux-sctp+bounces-263-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A0898C62A
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Oct 2024 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87581F25C60
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Oct 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4ED1CCEFD;
	Tue,  1 Oct 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOaYH2EH"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3CB19FA9D;
	Tue,  1 Oct 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727811697; cv=none; b=cY7Ry3RkRlXQv65nb19CJFjpTrahJkgpf4Q8nLUkHA9miPqfKryV/qUQYmMtFnky50MPvu8Abvi1gBql4CURsFK+bMviEKTCiJHoQ8PDzWMPk/CIaBg8tT0kXlHAtGpLw8TCzEKU/txLpjb3bnqylv14Zj/kEQGGIqr6vylYJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727811697; c=relaxed/simple;
	bh=T16dC4qgiMjhuxjj795kPmIiFGUxRFKQUf8XvLY4pWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8y4n5IlFJFOAK3bAx+exRI3owxlTiSoxKOHt98DoYYeEPHa78lqLbvuP5dtLjNMlWL4igi04gPv6zOItG79JosXjt4uVjjAdWZsqRuMg8+HxZfcnfjXdkE03gqehHfOI5YbVD8cyoRAX5H0Y5F0HCxoQnynsGqXWU+64z8gUMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOaYH2EH; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-82cd872755dso283682739f.1;
        Tue, 01 Oct 2024 12:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727811694; x=1728416494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eheZ+81CIdm0agzKG85LEBTlX/pbV0fMw4uZzaaH/Ew=;
        b=cOaYH2EH+2BaVnfBJ1trcH164hgtltdwMFR8zFmc0RHJuO4HTtF7MOv+2FRtnqDXR5
         edhbHI3uh8ZlR8DkYIEbtiduTxbsRN8Me5wxUlK+TURxZKphVQGkAjE0lsPLyJ6TITq6
         JpZbaOwPfaO8HADa+lrfFmPiVSlo+GFWYWLV2Ln8hT4txNevvY4OV8sp2Ohkf2dqqfak
         Mw10f4h+SJUKU+GWH5vKbeuwZKs3fqmguE6DTvbTUZmHMZXL0CDUK/vW6LbSfJDafk4E
         G4tcPjmXdqCYW3w2e2yeCXQG5hre8/0VN8XgNycHZ0fiztVv1Ej/HjLRpHk3k+HfW+JK
         dYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727811694; x=1728416494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eheZ+81CIdm0agzKG85LEBTlX/pbV0fMw4uZzaaH/Ew=;
        b=SiCpEC/xmI2Ekfi2EEud76GbHJF7Pd+d8g9XTH/fnNidoviqj1V8oY9UY39WU7BiFO
         T8AsMmGqFAzP3AKuQpEpnTcRXFmTcYOfb8ZWhUW5buIkwocKNjjUxT8xltHcr1fNeDNI
         BGFnVFsMupz8poQSR4VyZASJsAcokAjwQNfxjopxY2F6RzysSyK3iFBX3gSJiiBMQukF
         dof3j6gCaYRr6E6U+4CLQCTxa4B9zHjo3jFxxCz/6We+QHgqhOnGZBiSIzHxyOmbzD7K
         34PThmSF3MHrvPLTYOlnmZ5qTIC6iilj4dsd0J3HcxI+7a0ZDM1fUZO7HDciViRgoVLf
         /Rqw==
X-Forwarded-Encrypted: i=1; AJvYcCVN7lf2Lc+KHEjXIlZFs+2sNf5oesTW6WVCNHcj5ua8bJaJTGjlkrvBHhxYQ0emRR/QRyAQN23eW5cD@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtnogro9uA6nWLugnU1rHVpRal7Tz24TCZx/QfGUHm8DtDX/D
	j85u/vRv4dn5M59zzluVTQj2kIQZ0eT3/oF5fHnyUaBq0ZSsbV3cqGLqNO/kWA4/a8V94Q1r9s+
	IEdP+ds824Zd0k8nyyB81YLiJv+A=
X-Google-Smtp-Source: AGHT+IErX+VcLEtCPGCxUBsgMD/2chditP5dbrtMdqJofM2u5M+j/klz0er312IDo7cFbpgN76Be3AuwUDd9ziDJ600=
X-Received: by 2002:a05:6e02:1c07:b0:3a0:bc89:612 with SMTP id
 e9e14a558f8ab-3a36591aca8mr7527915ab.8.1727811694607; Tue, 01 Oct 2024
 12:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a93e655b3c153dc8945d7a812e6d8ab0d52b7aa0.1727729391.git.lucien.xin@gmail.com>
 <ZvxKVpfDhuYIyXll@t14s.localdomain>
In-Reply-To: <ZvxKVpfDhuYIyXll@t14s.localdomain>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 1 Oct 2024 15:41:23 -0400
Message-ID: <CADvbK_cPTb6YgmSvh=3TpNyYzkZLGP8dv95dHKD5JwpvjxUQhg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: set sk_state back to CLOSED if autobind fails
 in sctp_listen_start
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:15=E2=80=AFPM Marcelo Ricardo Leitner
<marcelo.leitner@gmail.com> wrote:
>
> On Mon, Sep 30, 2024 at 04:49:51PM -0400, Xin Long wrote:
> > In sctp_listen_start() invoked by sctp_inet_listen(), it should set the
> > sk_state back to CLOSED if sctp_autobind() fails due to whatever reason=
.
> >
> > Otherwise, next time when calling sctp_inet_listen(), if sctp_sk(sk)->r=
euse
> > is already set via setsockopt(SCTP_REUSE_PORT), sctp_sk(sk)->bind_hash =
will
> > be dereferenced as sk_state is LISTENING, which causes a crash as bind_=
hash
> > is NULL.
> >
> >   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> >   RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
> >   Call Trace:
> >    <TASK>
> >    __sys_listen_socket net/socket.c:1883 [inline]
> >    __sys_listen+0x1b7/0x230 net/socket.c:1894
> >    __do_sys_listen net/socket.c:1902 [inline]
> >
> > Fixes: 5e8f3f703ae4 ("sctp: simplify sctp listening code")
> > Reported-by: syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com
> > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > ---
> >  net/sctp/socket.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index 32f76f1298da..078bcb3858c7 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -8557,8 +8557,10 @@ static int sctp_listen_start(struct sock *sk, in=
t backlog)
> >        */
> >       inet_sk_set_state(sk, SCTP_SS_LISTENING);
> >       if (!ep->base.bind_addr.port) {
> > -             if (sctp_autobind(sk))
> > +             if (sctp_autobind(sk)) {
> > +                     inet_sk_set_state(sk, SCTP_SS_CLOSED);
> >                       return -EAGAIN;
> > +             }
> >       } else {
> >               if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
> >                       inet_sk_set_state(sk, SCTP_SS_CLOSED);
>
> Then AFAICT the end of the function needs a patch as well, because it
> returns what could be an error directly, without undoing this:
>
>         WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
>         return sctp_hash_endpoint(ep);
> }
>
Right, but this is another issue and won't cause a crash, and the fix will
need a different "Fixes:". I think we should fix it in a separate patch.

