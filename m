Return-Path: <linux-sctp+bounces-475-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18184A7A088
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Apr 2025 11:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C903D1738A6
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Apr 2025 09:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB28224891;
	Thu,  3 Apr 2025 09:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Unq4Y2Ev"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DC13D531;
	Thu,  3 Apr 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674306; cv=none; b=E1PWa908OQ2XqyVi86y8Z0t6YWTJsq/GHfoV9AD0GugutfR24znw0OEVvc8x85Z8Fkt2f2i8JoObkYvIvwd4G5W542NPYftkYoVL0+kx93liYJ0KS/fj5xpWBlCxUi9OWZG89a2KliPu6WhPC5PH5OEiqcD7cl8bVBD8r27bE6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674306; c=relaxed/simple;
	bh=Znl9X9FpTIGF2OsT13x7/fGoEi2ygGGP8eazYnBsR6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZAK7iUvkYXr/ShoipniM3CoH0aCwz4w+jmhGaFaxEQ+hYk6BOM7kPytY8NNbS5CFyijTcdITth1FCRXQ20KqioEEQuGkKMnfaetfd2Cam4miulBO2KmeKUH5NbMONyYeB5pKRPQv0ftgPG99zk3b9eZSNPGKM9Tzvy+8SzgA94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Unq4Y2Ev; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ayy35oKwof2JTIj+vzq+S1Uxz24/XsuIZVSRWIasD48=; b=Unq4Y2EvB3btFhXlJJiS8SM/co
	L1SuZeV2mtqzIQoDm6yRLtSJAvnk23toy7h3vA4nHYWyXe6OCFr8a1hqQawkftGC8NMbRpQTFeZ1C
	ySrqrpHoTvcsMpIdAWAVry/mFFTryMoWaYbgNHsqhblaV3YHSlTjnN+PHCLg8lE1k6ZNDpVpR+8N4
	hVD6dqG22FykwegIrWHkPLSglwor0Nkp3kIt/YWJluyDB8N+FGRvNTN1WZNDJfAEPdGoKc+IqgtFz
	WUuuVmfMkPT6vaF0k9VtEFyWAseniKNrq0MzBZc7AhCHBgaDvb3XE6kPMLZ1fodGv55sNBuVwwHnF
	I15qP7nA==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u0HKp-00AljK-Qd; Thu, 03 Apr 2025 11:58:07 +0200
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
In-Reply-To: <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com>
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
 <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com>
Date: Thu, 03 Apr 2025 11:58:00 +0200
Message-ID: <87tt75efdj.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thanks for reviewing, answers below:

On Wed, Apr 02 2025 at 15:40:56, Xin Long <lucien.xin@gmail.com> wrote:
> The data send path:
>
>   sctp_endpoint_lookup_assoc() ->
>   sctp_sendmsg_to_asoc()
>
> And the transport removal path:
>
>   sctp_sf_do_asconf() ->
>   sctp_process_asconf() ->
>   sctp_assoc_rm_peer()
>
> are both protected by the same socket lock.
>
> Additionally, when a path is removed, sctp_assoc_rm_peer() updates the
> transport of all existing chunks in the send queues (peer->transmitted
> and asoc->outqueue.out_chunk_list) to NULL.
>
> It will be great if you can reproduce the issue locally and help check
> how the potential race occurs.

That's true but if there isn't enough space in the send buffer, then
sctp_sendmsg_to_asoc() will release the lock temporarily.

The scenario that the reproducer generates is the following:

        Thread A                                  Thread B
        --------------------                      --------------------
(1)     sctp_sendmsg()
          lock_sock()
          sctp_sendmsg_to_asoc()
            sctp_wait_for_sndbuf()
              release_sock()
                                                  sctp_setsockopt(SCTP_SOCKOPT_BINDX_REM)
                                                    lock_sock()
                                                    sctp_setsockopt_bindx()
                                                    sctp_send_asconf_del_ip()
                                                      ...
                                                    release_sock()
                                                      process rcv backlog:
                                                        sctp_do_sm()
                                                          sctp_sf_do_asconf()
                                                            ...
                                                              sctp_assoc_rm_peer()
              lock_sock()
(2)          chunk->transport = transport
             sctp_primitive_SEND()
               ...
               sctp_outq_select_transport()
*BUG*            switch (new_transport->state)


Notes:
------

Both threads operate on the same socket.

1. Here, sctp_endpoint_lookup_assoc() finds and returns an existing
association and transport.

2. At this point, `transport` is already deleted. chunk->transport is
not set to NULL because sctp_assoc_rm_peer() ran _before_ the transport
was assigned to the chunk.

> We should avoid an extra hashtable lookup on this hot TX path, as it would
> negatively impact performance.

Good point. I can't really tell the performance impact of the lookup
here, my experience with the SCTP implementation is very limited. Do you
have any suggestions or alternatives about how to deal with this?

Thanks,
Ricardo

