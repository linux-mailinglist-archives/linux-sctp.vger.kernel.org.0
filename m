Return-Path: <linux-sctp+bounces-478-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D999A7BA61
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Apr 2025 12:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C9E3B9696
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Apr 2025 10:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7197D199E94;
	Fri,  4 Apr 2025 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iZJN6S78"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886C28E8;
	Fri,  4 Apr 2025 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743761117; cv=none; b=ChYUsNSuNsOuXNeY0diBZcgQ+CNBHm70R3QQsFokqDOyXF+8ulJQHbwc7giv9dvuSno3Le6OWH7VoTXbK4ulp77WQYblc9hTUFp6tboG2qA4lMC4s+HmNZnxHYTku0DTvfvhgWHS6qIdrCdNMvxBoDTZIfPhGgCIxi7X+kvx9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743761117; c=relaxed/simple;
	bh=zFq7mQzzUKzXv8BAv4y0LWPUsASDiuJfhCEHgQT2SVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rRuIy8OwpVu5K2kmSwILvbhEkVNROAxVx6m+8Vqdga8dl1v/PEs/YSAEgd0LcfjjqzBi2rtOQzXWGcJbRp36yBP5PRvMUiCaWWnFarHqlIIHULMdLBFzF03l+Vs3h1WBtUq2e0wLDwrTu5d0e78WfQV1fO1YhqCC6N0D+Osxd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iZJN6S78; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SG8iVfOnCjDC7IzPwnGOEf1BZhPJmATD83TCzmahlB4=; b=iZJN6S78C4QR3vLPkGcsCde4Dv
	KhCFXysQVBI3a4rGyA+LslXPNpVBhGEsLxe7ePwztABogCBipl0KDW3QOaZRws8GzUSRyZbIfDkrA
	hX8rIYWKG//JzQG314ip791hQ9szOL41N+ofBKwI44u0DMqYXzCf5mqjCWybpOAkAu+nqjqDxDRuB
	0rMll4dg9zosFy/ha9oKwPb7uJiEsFB2VW1zPmQ5RLIYDm44FobJ8JiJXRYoZX0K36deTR6nutreZ
	DFCUiMeDycfSNXuawNrPq+cPPHVSkj1gwCFHz6kyXJfjm9FF158w1N7J2IWXr4iy/QCnsHf7VqrU6
	hGE5RXSw==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u0duz-00BJ8r-Ro; Fri, 04 Apr 2025 12:04:57 +0200
From: Ricardo =?utf-8?Q?Ca=C3=B1uelo?= Navarro <rcn@igalia.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, kernel-dev@igalia.com, linux-sctp@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] sctp: check transport existence before processing a
 send primitive
In-Reply-To: <CADvbK_d+vr-t7D1GZJ86gG6oS+Nzy7MDVh_+7Je6hqCdez4Axw@mail.gmail.com>
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
 <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com>
 <87tt75efdj.fsf@igalia.com>
 <CADvbK_c69AoVyFDX2YduebF9DG8YyZM7aP7aMrMyqJi7vMmiSA@mail.gmail.com>
 <CADvbK_d+vr-t7D1GZJ86gG6oS+Nzy7MDVh_+7Je6hqCdez4Axw@mail.gmail.com>
Date: Fri, 04 Apr 2025 12:04:57 +0200
Message-ID: <87r028dyye.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for the suggestion!

On Thu, Apr 03 2025 at 14:44:18, Xin Long <lucien.xin@gmail.com> wrote:

> @@ -9234,7 +9236,7 @@ static int sctp_wait_for_sndbuf(struct
> sctp_association *asoc, long *timeo_p,
>                                           TASK_INTERRUPTIBLE);
>                 if (asoc->base.dead)
>                         goto do_dead;
> -               if (!*timeo_p)
> +               if (!*timeo_p || (t && t->dead))
>                         goto do_nonblock;
>                 if (sk->sk_err || asoc->state >= SCTP_STATE_SHUTDOWN_PENDING)
>                         goto do_error;

I suppose checking t->dead should be done after locking the socket
again, where sctp_assoc_rm_peer() may have had a chance to run, rather
than here?

Something like this:

@@ -9225,7 +9227,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 	pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
 		 *timeo_p, msg_len);
 
-	/* Increment the association's refcnt.  */
+	/* Increment the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_hold(transport);
 	sctp_association_hold(asoc);
 
 	/* Wait on the association specific sndbuf space. */
@@ -9252,6 +9256,8 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 		lock_sock(sk);
 		if (sk != asoc->base.sk)
 			goto do_error;
+		if (transport && transport->dead)
+			goto do_nonblock;
 
 		*timeo_p = current_timeo;
 	}
@@ -9259,7 +9265,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
 out:
 	finish_wait(&asoc->wait, &wait);
 
-	/* Release the association's refcnt.  */
+	/* Release the transport and association's refcnt. */
+	if (transport)
+		sctp_transport_put(transport);
 	sctp_association_put(asoc);
 
 	return err;


So by the time the sending thread re-claims the socket lock it can tell
whether someone else removed the transport by checking transport->dead
(set in sctp_transport_free()) and there's a guarantee that the
transport hasn't been freed yet because we hold a reference to it.

If the whole receive path through sctp_assoc_rm_peer() is protected by
the same socket lock, as you said, this should be safe. The tests I ran
seem to work fine. If you're ok with it I'll send another patch to
supersede this one.


> You will need to reintroduce the dead bit in struct sctp_transport and
> set it in sctp_transport_free(). Note this field was previously removed in:
>
> commit 47faa1e4c50ec26e6e75dcd1ce53f064bd45f729
> Author: Xin Long <lucien.xin@gmail.com>
> Date:   Fri Jan 22 01:49:09 2016 +0800
>
>     sctp: remove the dead field of sctp_transport

I understand that none of the transport->dead checks from that commit
are necessary anymore, since they were replaced by refcnt checks, and
that we'll only bring the bit back for this particular check we're doing
now, correct?

Cheers,
Ricardo

