Return-Path: <linux-sctp+bounces-1212-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fSMNCzisFWoZXwcAu9opvQ
	(envelope-from <linux-sctp+bounces-1212-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 26 May 2026 16:20:40 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C04755D759D
	for <lists+linux-sctp@lfdr.de>; Tue, 26 May 2026 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 346B130054DF
	for <lists+linux-sctp@lfdr.de>; Tue, 26 May 2026 14:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D883DF00D;
	Tue, 26 May 2026 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT7UIhcW"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909AB3B9935
	for <linux-sctp@vger.kernel.org>; Tue, 26 May 2026 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805235; cv=pass; b=dbcXRqP1L+mDGgFy1Jo6PbQ92rqPXjFq4ls/N+ICblmJee9wkNmfsbn6kKTt0Pql3rJWuIifdfBXdOam2yLl0knPJkM1+4jtQbm+Xv/iWSXMuKrtaYBDiUlrlQWINFf5lekGT3ACkyvSPQ/z0sTgXZ5x6ptQDCPEMcqDAOeRg8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805235; c=relaxed/simple;
	bh=IPu2QdiG4hbSIv6sItvth2bvXwd0oUgLrT33xuzL52A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sj5KhBhV8Fy6i7aAszijdIU4I8mdRvdgNc1SIUsnpi1E1Tk0q/LzGm1/p+EAQqSRy0gJLjPI4g7aV8i6nwue8FKKNC8Z8u7VwanFL9fOqzVT+YQ/0XzMBEVctpzFBUgu0fKay+jiwHSW9290ZdGIVK7dusrxUFruZa9H0ZPSBog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pT7UIhcW; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c796163fac5so8392553a12.1
        for <linux-sctp@vger.kernel.org>; Tue, 26 May 2026 07:20:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805234; cv=none;
        d=google.com; s=arc-20240605;
        b=Ysw7YwyYSvRIQDQOS9NT0mfB5KS/pnY9W51Uu61qT3/JD4jZp0HGxyQe+EhlXDOvTx
         wbrcpLAT3XTlkOq43z7hvTqNuuYhQJdZXDhvksrMg5LxOlvlwO4DlHO5ONQCcECoF9vD
         W3cNgsLCAWrBNNiWOgje/O164DR2DTga5C6Fpnyeuu2tV76S+Zm+pQS/NwY7xyT4dQSk
         3Fe2k7dJ+OZnsUFxa4RoaHeHRharfJTyhjjTvbg8v2MDSZNHGGuyHfsGB4uFKKHwMrGB
         3F3MuhubcZSC+3hX0wTrffCi5RJzA485srG2HmxTnmbtgR6eT3v+vUcSpzJTbEB3pmqW
         FuUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0gLD1oBu8xaxaaWp/AILcENQfMPG5Xdvrr1OZeLcKVE=;
        fh=2rY9YaK2X9hQuSawTbJUayAzzkN/FIrdqMPEEimm7C0=;
        b=Dk5wHKi5r3FHvXc6tAszKawOCOj1yHXm75mWau9C2SGyz1yYcOiqRVHQAORDr0ZjDh
         egVp4UGSXJwOK932ZH0gXV7J848Rzb57DDaH0ZZiXlydpbipu8/GXgwe88Cux3PoGFqA
         TSSrhw/YSgoOhRGE19sj2XIKqwTJpkCXjeEWlAD6Sn+6vE8xIh3ch+SFNoClXK/ILeBu
         EsSWVoU/qUW+hyOCcXVebOgYOMUj4UrCZ58hCiI8xSreTA0W78k5RfUGLNg7TBc35gk0
         kqE0XrjFrQxRDHZZdtFv4m0Fi8GA4Ov9JIY65XAQklaKjoc+NwiuOJxe6Anj+KFiwjJ8
         AvsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805234; x=1780410034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gLD1oBu8xaxaaWp/AILcENQfMPG5Xdvrr1OZeLcKVE=;
        b=pT7UIhcWJ++6nskNlbkP+Xz3A+JUgFiUBroFKMvmB242eEOZXPdJF9w0En21L7xh8N
         EDZKK4m63kw7Mr/iOk4HIyv3jXGbyU+2cK8GzILJ8ZtH1AWqJpj/EuJglIi0gw/m4CjR
         7nQBaM2Ozhb/6hppgmIuQLrku6mu7c5qCm8pafBtYzLmWG1vXxDnC0ujBB5NbKPW7AFo
         JjAcBSkeoZhLCooheUzEXqmXnHmsUe5xojUvJjrT/kObheaJTQfvBc4c05N16dU0tr3G
         SQmO4H70s3O0Q5rV1iW/UbQznfbNsE1fxveA2AJao+cCDpJ307PjN7e5PwHO+RInqqGI
         nq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805234; x=1780410034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0gLD1oBu8xaxaaWp/AILcENQfMPG5Xdvrr1OZeLcKVE=;
        b=lnAD8XV/ZLFEcdhmbwgp1J7ckumrvJEaeZyGGWDGyu2+6Twnxr/DfWrp88ra6RcOXL
         UyOdmlD/V6rm/2nNBPpTzX985N6COtlptcjqwCfA+hbZsPx4zCLar7k3f/45A8wvsyMM
         3gsNfVun3qv4QBcrZUd622mzijP9OnabZ5vVWb5ziVbP409K3029VZBPnMcuv6rKigrM
         cqTC8xPMcJvX1XO+C2u3nfQwho70/dWqo7BOth2Js3sYgb2ED84FNw0mcJhQXv93X8NP
         +Bvpy5wE27MAAUz8PYzELyq5/8lNmVQYuK4wRoLKFN49qImdR/GBz2zcCWhcDEK+wLnA
         xlCg==
X-Forwarded-Encrypted: i=1; AFNElJ+xbhcIQ2XFdV39UseaBr9ERqD1B3bhoOypX9IGuG8uturgkEGIJ8Rc5t+tWkKshnptyMi4lVb7V2Y6@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy4UQLqYZRJBTEA2pIpcUP6kLwogyWsL/ZQT/oQnTlGBH7+rbG
	6KlMWXq6m/V848J+XF30POHOwQjq0hVU8uV9XxXmAaWrli3fQyrYzyaIKF1ipPu1GtHFyadSZXW
	3CHVw9+vr2N8Vj8rsCmm1/XLz8j8I7shKxdHV
X-Gm-Gg: Acq92OEaDqLzLCpSWHXAGEuql8ppYiEFw4In8Cc+pgUPuJHylB/MUqvPM6bp/zag0jF
	AVI0E736x9ixulrGh30yzHFAXD6xW+fJ/19wlgW5rEg2NzIQpRau8i04VLqbpHXVGpfHvzBpU10
	Dridweb9aQ7DeppATX4e7DAUyEN7+IwZLI5Z+kh7ucTMn/gJOruAsfJHsFzL9ABd2/zeZRrzpjX
	gXJh5UvOA8kgEQl1azApl8ecmsM0kJCBG8usnIhFvA0fWzeDh/PFRTeHEzvfKF311BNaxAg7Kic
	PVsD3YW6z3TUGb7UX32t4q3KwuLqoYmwDgMhGs/9AiFyo6PMH5DgTEa3sJyZOxd8HzjilnP85r+
	8ewM2c/TEveXNA5bh
X-Received: by 2002:a05:6a21:4a41:b0:398:71e4:6287 with SMTP id
 adf61e73a8af0-3b328cb9cf4mr17689017637.10.1779805233850; Tue, 26 May 2026
 07:20:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526100825.16057-1-kipreyyy@gmail.com>
In-Reply-To: <20260526100825.16057-1-kipreyyy@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 26 May 2026 10:20:22 -0400
X-Gm-Features: AVHnY4J7uVWcWwaDUkS0yIBBYYqAKyoMNYtHetP8QFWsXYa9fHbdGPif8OtLDdw
Message-ID: <CADvbK_fPS_U-kZ-iXm+EaOeWNK+CoygXRLV7Y4qBZYQb9JDX=A@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix race between sctp_wait_for_connect and peeloff
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1212-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,get_maintainer.pl:url]
X-Rspamd-Queue-Id: C04755D759D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 6:08=E2=80=AFAM Zhenghang Xiao <kipreyyy@gmail.com>=
 wrote:
>
> sctp_wait_for_connect() drops and re-acquires the socket lock while
> waiting for the association to reach ESTABLISHED state. During this
> window, another thread can peeloff the association to a new socket via
> getsockopt(SCTP_SOCKOPT_PEELOFF), changing asoc->base.sk. After
> re-acquiring the old socket lock, sctp_wait_for_connect() returns
> success without noticing the migration =E2=80=94 the caller then accesses
> the association under the wrong lock in sctp_datamsg_from_user().
>
> Add the same sk !=3D asoc->base.sk check that sctp_wait_for_sndbuf()
> already has, returning an error if the association was migrated while
> we slept.
>
> Fixes: 668c9beb9020 ("sctp: implement assign_number for sctp_stream_inter=
leave")
> Signed-off-by: Zhenghang Xiao <kipreyyy@gmail.com>
> ---
>  net/sctp/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index 1d2568bb6bc2..66e12fb0c646 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -9403,6 +9403,8 @@ static int sctp_wait_for_connect(struct sctp_associ=
ation *asoc, long *timeo_p)
>                 release_sock(sk);
>                 current_timeo =3D schedule_timeout(current_timeo);
>                 lock_sock(sk);
> +               if (sk !=3D asoc->base.sk)
> +                       goto do_error;
>
>                 *timeo_p =3D current_timeo;
>         }
> --
> 2.50.1 (Apple Git-155)
>

Patch looks good to me.

Please resend it with the recipients from get_maintainer.pl included,
especially netdev@vger.kernel.org.


# ./scripts/get_maintainer.pl net/sctp/socket.c
Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> (maintainer:SCTP PROTOC=
OL)
Xin Long <lucien.xin@gmail.com> (maintainer:SCTP PROTOCOL)
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING [GENERAL])
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
linux-sctp@vger.kernel.org (open list:SCTP PROTOCOL)
netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
linux-kernel@vger.kernel.org (open list)

Thanks.

