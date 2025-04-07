Return-Path: <linux-sctp+bounces-482-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D69A7D795
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Apr 2025 10:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAA83BBB8F
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Apr 2025 08:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142FE22759B;
	Mon,  7 Apr 2025 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hKV9wWN3"
X-Original-To: linux-sctp@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABC227E86;
	Mon,  7 Apr 2025 08:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744013906; cv=none; b=ZU0aPWMfd3658jbPXMTSVcdGZThhknkTiaiZBhQfYI/zq5PiumZ89EbWXCwlBTek+xkcGu0XdoxlWZ+wMYy014aUmIc15PXQOBRzMX9Iu1nngG1WD95dJ+hs62wc39q1NEixGXvbcUDsncbUgsgbZLNFmKqNbSxx24uRFN3nYBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744013906; c=relaxed/simple;
	bh=RSCsB9LyBZKImdCS3CO3v6PdojzJl9JVl7oocdENeNE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7R4qlUEZFXX3KpdTt8gr6ULQZb5pDc0BeV/Qf4zwNt0kyORjdqGqZkvkNxeEN3leESxd/6JjF9CePlRNackkAhvS60jcVOGui4i86k4ofmk5CY+jyDJ04a99nl1gAxWRirWE4Lu6KseQLx2U0Jf+MAW1I0wKgWSywkNeZnECQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hKV9wWN3; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QLfWDAfI2AnhA5OmyBMH2GN+AZpLJ7m9IQNoTTz/1Q4=; b=hKV9wWN32qu+WchUIFvT0Y/SjM
	2jWOqCMP8azbf0L91SpOxo+jsmyFsk7lkPVPctusn8AFPs+uDq3cXumQ8vwCDqJb37TPEiAKa9bne
	RbbZxzRlPl0klHLLP90DXY7loMrOTto9cmul4NyOA2xrH3CUjNgiBDwKv3Yr2l9GnMefHeXwxxlQv
	ltnzBYGSKj5GRTbbRU+qux7UPNP2AGeKxkMA9Js8C8lFn9OvtxS6X8IqDKekKor8QQdM2E0h+TWb8
	GuzUWCPrSvf0NS6FQ9ojvlb2cFTRyFkE/izVHQN0aBdPIWJ72lnKmNNErX/pewmwHs7Pa7RwoOGht
	Cpjw6ing==;
Received: from 79.red-83-60-111.dynamicip.rima-tde.net ([83.60.111.79] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1u1h3B-00CmbI-HY; Mon, 07 Apr 2025 09:37:45 +0200
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
In-Reply-To: <CADvbK_evR93rj1ZT_bzLKFqNQLPQ2BM0mzKnriGGsO5t07GAHQ@mail.gmail.com>
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
 <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com>
 <87tt75efdj.fsf@igalia.com>
 <CADvbK_c69AoVyFDX2YduebF9DG8YyZM7aP7aMrMyqJi7vMmiSA@mail.gmail.com>
 <CADvbK_d+vr-t7D1GZJ86gG6oS+Nzy7MDVh_+7Je6hqCdez4Axw@mail.gmail.com>
 <87r028dyye.fsf@igalia.com>
 <CADvbK_evR93rj1ZT_bzLKFqNQLPQ2BM0mzKnriGGsO5t07GAHQ@mail.gmail.com>
Date: Mon, 07 Apr 2025 09:37:44 +0200
Message-ID: <87o6x8e81j.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 04 2025 at 10:22:38, Xin Long <lucien.xin@gmail.com> wrote:

>> Something like this:
>>
>> @@ -9225,7 +9227,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
>>         pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
>>                  *timeo_p, msg_len);
>>
>> -       /* Increment the association's refcnt.  */
>> +       /* Increment the transport and association's refcnt. */
>> +       if (transport)
>> +               sctp_transport_hold(transport);
>>         sctp_association_hold(asoc);
>>
>>         /* Wait on the association specific sndbuf space. */
>> @@ -9252,6 +9256,8 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
>>                 lock_sock(sk);
>>                 if (sk != asoc->base.sk)
>>                         goto do_error;
>> +               if (transport && transport->dead)
>> +                       goto do_nonblock;
>>
>>                 *timeo_p = current_timeo;
>>         }
>> @@ -9259,7 +9265,9 @@ static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo_p,
>>  out:
>>         finish_wait(&asoc->wait, &wait);
>>
>> -       /* Release the association's refcnt.  */
>> +       /* Release the transport and association's refcnt. */
>> +       if (transport)
>> +               sctp_transport_put(transport);
>>         sctp_association_put(asoc);
>>
>>         return err;
>>
>>
>> So by the time the sending thread re-claims the socket lock it can tell
>> whether someone else removed the transport by checking transport->dead
>> (set in sctp_transport_free()) and there's a guarantee that the
>> transport hasn't been freed yet because we hold a reference to it.
>>
>> If the whole receive path through sctp_assoc_rm_peer() is protected by
>> the same socket lock, as you said, this should be safe. The tests I ran
>> seem to work fine. If you're ok with it I'll send another patch to
>> supersede this one.
>>
> LGTM.

Good, thanks! I submitted a patch that supersedes this one:
https://lore.kernel.org/linux-sctp/20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-v1-1-5ce4a0b78ef2@igalia.com
so we can drop this.

Cheers,
Ricardo

