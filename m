Return-Path: <linux-sctp+bounces-264-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5797398C74F
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Oct 2024 23:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F241C24313
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Oct 2024 21:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B491CC168;
	Tue,  1 Oct 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOmKvQks"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACE1CBEB0;
	Tue,  1 Oct 2024 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816770; cv=none; b=kgfEt58KVZAFlxnGtxTFM/i6IWN97Iu8mbJLMtwFVVMxksDpJbCnluImFAJCIa+e+Q/Dwmcid3YHGggrWOHVn35dNPsfVaQCXSko8QbH434HZuhpGDQlRF8GEPCi0gNm/eZVk3yOluG/evWTvVLUk8RGdjaiW8NGQ84V4EauoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816770; c=relaxed/simple;
	bh=ygVsFvqfx9mZQXXocJ3O3q1iH348nHEOpHOT4JrSZH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuhxegOonfIp7s4LawgNRWUibpYFS2Z8Mt1NrcrCJvpoQv9oVYAiWTR5tqK7KT0Reo74PTzBZqYYO1lsLUV2ShWCgvzy3Gj94Ls+N0LrcWT66nON3hp925MtggDRVZupNqzfkpvy+ptkGo4Z69+gOJwGoeM9xYmcEKKH8WD9Bp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOmKvQks; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e053f42932so4429933a91.0;
        Tue, 01 Oct 2024 14:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816768; x=1728421568; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vYzb86+HBfTUQ86IZPlyeCQbROixki8SUAKB5Xx3/rY=;
        b=kOmKvQks1aXOORn5vCKuplGnTtn2D2mNPfTAsn/gTlSlhpAWyUhUPfomHObmUyVNvI
         Wzr0+8qVOUE98Xl3zjM2tCqDqBaSjMNBWwiCp8+vCY+4cQhd5FH+ku4M2mEcotEsGhzV
         iMrwUkYX40KqFIboOSFoqw0mBIsJh08cbF2pCZLLbtXtsWgIfoswUaYBpa9pcCsknh/k
         9PVSjpRdfbiNNgeAReo4GkfA84zKQS6ynI7rv6YzVp2W9mnf9kKKweTNNdxesH02F5h6
         ZahqWsVki/8vZunXztN0W5aXkOT+zGADkhrlpso0cqNqsebsq+FpK343905xbhpC0plQ
         aQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816768; x=1728421568;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vYzb86+HBfTUQ86IZPlyeCQbROixki8SUAKB5Xx3/rY=;
        b=RnwUfzodkfqPniq7WuPMwcjuxkdf8fgka6n6yKFwnQb1SAEMkFPPnG7tHZI1BOJMqb
         Qac3gn9MjQKOxA/TuzINWcQgR7FcRoCf1u/LqKXm1Ugc2Px73r9STkYSA5iRuCEGHvlp
         iRbRXiMYvH2BQGKv/H0SEXBdvwcHGhrrmQmy2OeQiuGDjV0y2kqoRDpJicRX2Hk1/B+K
         odWY5d9CwujK2OyyJ2OZVr+TUsM2PjmVmHVHDh6t6sPoV+BS7pPWyToPYNmi123r5svm
         JLms8LUfjmpPWj10G9JuJlcTbxzP38Gqa+r0lAe65ERLzBzS8+uQbq+L0SqgOp5pzf0V
         s9mA==
X-Forwarded-Encrypted: i=1; AJvYcCWpD2ji8x1Lq3QfCOFbff464Fw7NkN/DYmwRqS0u/9oHFz66I14nMcwAI44PEOw0ZgMx00V+SXYEOFt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+U+0lO+4E/ktbAzQXX2jN6vWSahALK9YySdHeXz1sUPWxwlFx
	iL9rt6SaSW8LQnphSjfEbo9gJzztNQyNFPIjcDssKC1CdMPrnXCFF/bHw4uj
X-Google-Smtp-Source: AGHT+IErW1wC9BZlImxpNZFZ7TsQmK11VWpuCbPmEbdh1elZMGjeMyETyeCAY8fsRXbgoRv2/uz9sg==
X-Received: by 2002:a17:90b:3145:b0:2c9:6a38:54e4 with SMTP id 98e67ed59e1d1-2e1849d7a1fmr1028051a91.41.1727816768116;
        Tue, 01 Oct 2024 14:06:08 -0700 (PDT)
Received: from t14s.localdomain ([177.37.172.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa05062sm24377a91.42.2024.10.01.14.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 14:06:07 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 9D0CCD2D3BE; Tue,  1 Oct 2024 18:06:03 -0300 (-03)
Date: Tue, 1 Oct 2024 18:06:03 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] sctp: set sk_state back to CLOSED if autobind fails
 in sctp_listen_start
Message-ID: <ZvxkO_lg6xfkim1m@t14s.localdomain>
References: <a93e655b3c153dc8945d7a812e6d8ab0d52b7aa0.1727729391.git.lucien.xin@gmail.com>
 <ZvxKVpfDhuYIyXll@t14s.localdomain>
 <CADvbK_cPTb6YgmSvh=3TpNyYzkZLGP8dv95dHKD5JwpvjxUQhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_cPTb6YgmSvh=3TpNyYzkZLGP8dv95dHKD5JwpvjxUQhg@mail.gmail.com>

On Tue, Oct 01, 2024 at 03:41:23PM -0400, Xin Long wrote:
> On Tue, Oct 1, 2024 at 3:15 PM Marcelo Ricardo Leitner
> <marcelo.leitner@gmail.com> wrote:
> >
> > On Mon, Sep 30, 2024 at 04:49:51PM -0400, Xin Long wrote:
> > > In sctp_listen_start() invoked by sctp_inet_listen(), it should set the
> > > sk_state back to CLOSED if sctp_autobind() fails due to whatever reason.
> > >
> > > Otherwise, next time when calling sctp_inet_listen(), if sctp_sk(sk)->reuse
> > > is already set via setsockopt(SCTP_REUSE_PORT), sctp_sk(sk)->bind_hash will
> > > be dereferenced as sk_state is LISTENING, which causes a crash as bind_hash
> > > is NULL.
> > >
> > >   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > >   RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
> > >   Call Trace:
> > >    <TASK>
> > >    __sys_listen_socket net/socket.c:1883 [inline]
> > >    __sys_listen+0x1b7/0x230 net/socket.c:1894
> > >    __do_sys_listen net/socket.c:1902 [inline]
> > >
> > > Fixes: 5e8f3f703ae4 ("sctp: simplify sctp listening code")
> > > Reported-by: syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com
> > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > ---
> > >  net/sctp/socket.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > index 32f76f1298da..078bcb3858c7 100644
> > > --- a/net/sctp/socket.c
> > > +++ b/net/sctp/socket.c
> > > @@ -8557,8 +8557,10 @@ static int sctp_listen_start(struct sock *sk, int backlog)
> > >        */
> > >       inet_sk_set_state(sk, SCTP_SS_LISTENING);
> > >       if (!ep->base.bind_addr.port) {
> > > -             if (sctp_autobind(sk))
> > > +             if (sctp_autobind(sk)) {
> > > +                     inet_sk_set_state(sk, SCTP_SS_CLOSED);
> > >                       return -EAGAIN;
> > > +             }
> > >       } else {
> > >               if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
> > >                       inet_sk_set_state(sk, SCTP_SS_CLOSED);
> >
> > Then AFAICT the end of the function needs a patch as well, because it
> > returns what could be an error directly, without undoing this:
> >
> >         WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
> >         return sctp_hash_endpoint(ep);
> > }
> >
> Right, but this is another issue and won't cause a crash, and the fix will
> need a different "Fixes:". I think we should fix it in a separate patch.

Makes sense. Thx.

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

