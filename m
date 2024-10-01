Return-Path: <linux-sctp+bounces-262-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4981598C5DC
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Oct 2024 21:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A571F222CA
	for <lists+linux-sctp@lfdr.de>; Tue,  1 Oct 2024 19:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FF51CB33A;
	Tue,  1 Oct 2024 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dABgeRLZ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724A1B5820;
	Tue,  1 Oct 2024 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810140; cv=none; b=XpQWoYNbfmVfxRDkNPrRqnO1W8Owt0hqmInj1CgFg/9UShDMAFB+wHmE/n+8t/B8NmWAkYEtFz5LhPk5QOHdNJcF/g967+aMQnKTMEaPSKX096nu3hNAbyC9y5N1IyPe7DBEpAnPm54d1VrkkdH1eLSy6p+yuyWZ+ZIeOYNsktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810140; c=relaxed/simple;
	bh=rUn61UMcJ2yst+Nj399aNLS1qHewpf9Sh3UjCcx1zDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1DCGw/mjMUbu1V4b63pSl6nyFi6Pf1wcKU9OUavN62Go+2jRyR/hd3+oKEQqozZsrOIHCeP+SeRlupY/jmyBJyLFuZnpUZgDBNOdq8KxVoSny3Le8rPlcp+8XqtR54zScac6YeYgU7QE44CJ/cxA7/9TPqiwi3snRIfjTjBYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dABgeRLZ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso105897a91.0;
        Tue, 01 Oct 2024 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727810138; x=1728414938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Li5m4BxfOWH4wLYDkqGXI2h8LkbJyVUGskxtRfz0lHw=;
        b=dABgeRLZGVhoi6uKIKF995qweWIGBjjozEpKF7c2WnbaFhKMBF0l/kFYIGAf5boJUZ
         vdfat4hEGnvdutg2u7k3mOiOlJJC/0K6QByFj4Pyw4mBWlNethBptjrfXEFezANagvQM
         pTZ1vBccuHBxWqnx/S+IqyUyfNgn0U7pzjlDufySgkIAhu5Oy+ZcowmzT5URog0uPcJz
         pEC5yzq4yAUPEbpYH1kMAh8smuz4Ujovr/3pFEZ6GgqGsOU/QLdhJUexrqez6w8tdVLr
         rxm1X2nkD8brnUW7Trgum2pp4TITYamEJL/uVKAqKMfti7wRQFHUm+q31HBFtbKyooPO
         RPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810138; x=1728414938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li5m4BxfOWH4wLYDkqGXI2h8LkbJyVUGskxtRfz0lHw=;
        b=h7Kg2To8Q1NUrB/EXJTaXpOGjmTFkk/HydNVod4aIz5UdrZtseaGMTrhR+aejNVIyu
         p1iRGJ0HuugjAnDbiVxLsHRxztsbDlkMnKHusbpwEV0CxI7z8gCZug1XauJ92xmmyzWs
         efJ6zx20xL/IC4atGHJ3kluu8ImGOfE8JRQgnE6t7oIpRhIXl4LMlFj8pfu6MGQ3Rju4
         d50Vt/ge15iQgQBNnrK2sqR8GgjzEKqfpSB0l8yAPnM5jvSnTyrWcUwDC2P6GM9JFTwe
         UbiralRrCygg9vh/zzUq3OStXJPUHGTuQyIeawuD6l1ne2XPNLRFgeCqwynJWBYKzuTa
         rPsA==
X-Forwarded-Encrypted: i=1; AJvYcCXO6ADQ7xj4ix8ICZQYwfdWapOqO6MettklfqkG/5pp4596uTYtRkODArED57fjLq0lPVnp4xKMCKxy@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLpSHRxPgjOIVnX80CPAisN3p8C0h0Akk8Gg0LkWSF5gLW4yy
	UdMqILuw+HnalzAJBBV3IRAIG/s+UCccgdXhrRaXhm8gqUNQZOJlTJ3KuQbn
X-Google-Smtp-Source: AGHT+IGSHsqKlqegjKfUNYFYYTstm5wTs/uLcatyNgLU6F7I3CKPofSsgA3oNpbxlXgDXWp9dKXocg==
X-Received: by 2002:a17:90a:e544:b0:2d8:ea11:b2db with SMTP id 98e67ed59e1d1-2e1853e8fb3mr996677a91.16.1727810138059;
        Tue, 01 Oct 2024 12:15:38 -0700 (PDT)
Received: from t14s.localdomain ([177.37.172.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6e105e4sm10602412a91.37.2024.10.01.12.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 12:15:37 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 8496CD2D3A5; Tue,  1 Oct 2024 16:15:34 -0300 (-03)
Date: Tue, 1 Oct 2024 16:15:34 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] sctp: set sk_state back to CLOSED if autobind fails
 in sctp_listen_start
Message-ID: <ZvxKVpfDhuYIyXll@t14s.localdomain>
References: <a93e655b3c153dc8945d7a812e6d8ab0d52b7aa0.1727729391.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a93e655b3c153dc8945d7a812e6d8ab0d52b7aa0.1727729391.git.lucien.xin@gmail.com>

On Mon, Sep 30, 2024 at 04:49:51PM -0400, Xin Long wrote:
> In sctp_listen_start() invoked by sctp_inet_listen(), it should set the
> sk_state back to CLOSED if sctp_autobind() fails due to whatever reason.
> 
> Otherwise, next time when calling sctp_inet_listen(), if sctp_sk(sk)->reuse
> is already set via setsockopt(SCTP_REUSE_PORT), sctp_sk(sk)->bind_hash will
> be dereferenced as sk_state is LISTENING, which causes a crash as bind_hash
> is NULL.
> 
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:sctp_inet_listen+0x7f0/0xa20 net/sctp/socket.c:8617
>   Call Trace:
>    <TASK>
>    __sys_listen_socket net/socket.c:1883 [inline]
>    __sys_listen+0x1b7/0x230 net/socket.c:1894
>    __do_sys_listen net/socket.c:1902 [inline]
> 
> Fixes: 5e8f3f703ae4 ("sctp: simplify sctp listening code")
> Reported-by: syzbot+f4e0f821e3a3b7cee51d@syzkaller.appspotmail.com
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/sctp/socket.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 32f76f1298da..078bcb3858c7 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -8557,8 +8557,10 @@ static int sctp_listen_start(struct sock *sk, int backlog)
>  	 */
>  	inet_sk_set_state(sk, SCTP_SS_LISTENING);
>  	if (!ep->base.bind_addr.port) {
> -		if (sctp_autobind(sk))
> +		if (sctp_autobind(sk)) {
> +			inet_sk_set_state(sk, SCTP_SS_CLOSED);
>  			return -EAGAIN;
> +		}
>  	} else {
>  		if (sctp_get_port(sk, inet_sk(sk)->inet_num)) {
>  			inet_sk_set_state(sk, SCTP_SS_CLOSED);

Then AFAICT the end of the function needs a patch as well, because it
returns what could be an error directly, without undoing this:

        WRITE_ONCE(sk->sk_max_ack_backlog, backlog);
        return sctp_hash_endpoint(ep);
}


