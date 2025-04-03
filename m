Return-Path: <linux-sctp+bounces-477-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E467FA7A9A7
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Apr 2025 20:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D27B03B5584
	for <lists+linux-sctp@lfdr.de>; Thu,  3 Apr 2025 18:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9FC253356;
	Thu,  3 Apr 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0zKHO7+"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04D41A254E;
	Thu,  3 Apr 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705872; cv=none; b=NN4nrohwmm51uqwqE0i9dDJDKxAFbNrzKcwdtdUGgEdjCPLZUZkEDCGctqOuAXMTrFNvuU+yO/pFwvF765fuifsZvV2OjNeh9CWn5lXTCcxKSinGuxKCLyMwOuB9RjTLyMxUMv03czsfMzfnZIoUzsK7Kzo2iaqgEUUnEtQKZFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705872; c=relaxed/simple;
	bh=ZnDAKb4E5SESrBZi2hnMBJ+G8kgc6x5Zm2X/BBtxvSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDGp35OpRdWb8XCDN10YR8H3kpAgVDm0oGitk4dJCJNOfyxgg+2m4uO632rgwRs/j125/EcXqkyZCSI1dVw86fmgv0uHACLE20aA8N9R4Oj/1Qrf6+FfNLtw5q3QSSyFY+3X7mP5kw3HC+VBs5zgywHabU3Nt75vNVr4HQCMaSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0zKHO7+; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d6d6d82633so3943025ab.0;
        Thu, 03 Apr 2025 11:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743705870; x=1744310670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ap0HUHPX7yXUq/lh+vMdCs7sdd0w6Sp3v7hjIJ93Fms=;
        b=b0zKHO7+8Z82dJ+Xvn1FpFRQilI1Z4vgWO5MM4laO9lNrt2kCLULyiSaO//sGUrd1G
         56ZaRJKtc418vQihE1UHZpFAJGj93e3VHuQrFevOSfFJS+Wvv4OqHJerwl2ikKgS7foC
         IqDsUAzhm2/54kHmrUv9giEAbDKeaJuqlPtZqoR7YvpRH6Hga9dR/I/lvYqCRsAvDXQA
         xX+DQuOYWAaW6KbYnoJ3Cc8TEEzc2l6VcJftSepcjYBiR0t9BOwF6yhijG/kIV95W94j
         o5OCHlDQNF1YtSMnPzAUmEwFcgLAZeEKZHwykO40zpfjAsf5oOrZTkFqQJiz4Y3zuH9d
         0Ktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743705870; x=1744310670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ap0HUHPX7yXUq/lh+vMdCs7sdd0w6Sp3v7hjIJ93Fms=;
        b=OFzJl7FdJq14e5EYDg/81JlSIO+wYCLx4+TI8eR5qRTjAZj602IpE+W6RpD0ooJYGb
         hPW6DimLtbsoOH/SocoFpkZjiHVWDQGPvvZTUTJKDY/eMB2WAYcwWzeTX5pVhCPRtwWp
         LD2D3oIzM1emGkCVB2pd5Ye+Wwco53xvGy88rZAvY7d6iSiz4uBA7WrGYa3gfqwLHoeM
         QeNDknkAKa/yTKL+JJl1ERAne9/a2C2cZT0Z+aWnmHVda7raif6nC8aJHHd91oFv3Vu9
         mKnY8ARCeJ0VwiohmAJgPDd327s2tw+ZNRC4V328QNT3Pr3LP3O0RYY1E2+acH387w0V
         m7Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUB3KsBkJK3aVmstXao8RMZ7Z6hi2PpXLxLz72bWW/CTIXY8o5up/VvWt8SpFNZ8xdcRez/0+gmAaPsPo0=@vger.kernel.org, AJvYcCVQrVytZRDzsKsgPKKS3HlwR8dap4siQpyLryFcvvMQu9nHb7be2042dPybdmQFWnR1NH6swsX45TCZiQ==@vger.kernel.org, AJvYcCVRuuv3h5hssXmvQ6cp+/8THI+48prBtiVuJfzOtI4zBUOFHgZ8J42s1QpZ2jBRBip/76iAEDzS@vger.kernel.org, AJvYcCXT3Ch2d41VT8SGZGCxf0vXBcYbB03ghufdbUlK6uTQUx24BAB5WzYZecmwj7o0/7RFknEv+yCf@vger.kernel.org
X-Gm-Message-State: AOJu0YzMGYKMOJJiJ+jJe9lCBuU6ouv7HRt7JPoZIo02lLYc7hDVkh2P
	oIOwlPElCKM8jRjAIn4oWX1iRpFu4zWVE2K/lcrspWBoGq9ZjagXOClYBoFQaw/l6QiKeL5OGLB
	UnL8CvaGBZzClFNR7lGF2tEjOg5Y=
X-Gm-Gg: ASbGncs3jx7CTbbwIoaOwYPtJ7rR4vch9GLJULNkEd0sUKLBH/6Fil2igtsDVs0G7+y
	TOgtj1F05xWFyE2Jw2FG+/V2L/rLC9keLXCll2GoG7oDafw/ZkGOhxb6AGYPzyuGTUc74PY0xyy
	IcS7EWqKZnezmsMrX7hp98Ll7VKXlHHcDl5G0QC2VXazXer5/AWKNt+DJHuQ==
X-Google-Smtp-Source: AGHT+IGy9EpjSboQltyoKMDikw04CcYkoaMH/cZSG5fCTOWx22QAPIh/PUcBjfUk+1NqmiwA4oDxlfqv3yYsBcjaanA=
X-Received: by 2002:a05:6e02:16cb:b0:3d0:4b3d:75ba with SMTP id
 e9e14a558f8ab-3d6e3ee1632mr6821575ab.4.1743705869636; Thu, 03 Apr 2025
 11:44:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-kasan_slab-use-after-free_read_in_sctp_outq_select_transport-v1-1-da6f5f00f286@igalia.com>
 <CADvbK_dTX3c9wgMa8bDW-Hg-5gGJ7sJzN5s8xtGwwYW9FE=rcg@mail.gmail.com>
 <87tt75efdj.fsf@igalia.com> <CADvbK_c69AoVyFDX2YduebF9DG8YyZM7aP7aMrMyqJi7vMmiSA@mail.gmail.com>
In-Reply-To: <CADvbK_c69AoVyFDX2YduebF9DG8YyZM7aP7aMrMyqJi7vMmiSA@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 3 Apr 2025 14:44:18 -0400
X-Gm-Features: ATxdqUF6iNWCUFr5K6P8ICqDN6O1PHfQdnvpw-okfkrtHPA4T7S5O3Q6KScPzFs
Message-ID: <CADvbK_d+vr-t7D1GZJ86gG6oS+Nzy7MDVh_+7Je6hqCdez4Axw@mail.gmail.com>
Subject: Re: [PATCH] sctp: check transport existence before processing a send primitive
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, kernel-dev@igalia.com, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 10:42=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Thu, Apr 3, 2025 at 5:58=E2=80=AFAM Ricardo Ca=C3=B1uelo Navarro <rcn@=
igalia.com> wrote:
> >
> > Thanks for reviewing, answers below:
> >
> > On Wed, Apr 02 2025 at 15:40:56, Xin Long <lucien.xin@gmail.com> wrote:
> > > The data send path:
> > >
> > >   sctp_endpoint_lookup_assoc() ->
> > >   sctp_sendmsg_to_asoc()
> > >
> > > And the transport removal path:
> > >
> > >   sctp_sf_do_asconf() ->
> > >   sctp_process_asconf() ->
> > >   sctp_assoc_rm_peer()
> > >
> > > are both protected by the same socket lock.
> > >
> > > Additionally, when a path is removed, sctp_assoc_rm_peer() updates th=
e
> > > transport of all existing chunks in the send queues (peer->transmitte=
d
> > > and asoc->outqueue.out_chunk_list) to NULL.
> > >
> > > It will be great if you can reproduce the issue locally and help chec=
k
> > > how the potential race occurs.
> >
> > That's true but if there isn't enough space in the send buffer, then
> > sctp_sendmsg_to_asoc() will release the lock temporarily.
> >
> Oh right, I missed that. Thanks.
>
> > The scenario that the reproducer generates is the following:
> >
> >         Thread A                                  Thread B
> >         --------------------                      --------------------
> > (1)     sctp_sendmsg()
> >           lock_sock()
> >           sctp_sendmsg_to_asoc()
> >             sctp_wait_for_sndbuf()
> >               release_sock()
> >                                                   sctp_setsockopt(SCTP_=
SOCKOPT_BINDX_REM)
> >                                                     lock_sock()
> >                                                     sctp_setsockopt_bin=
dx()
> >                                                     sctp_send_asconf_de=
l_ip()
> >                                                       ...
> >                                                     release_sock()
> >                                                       process rcv backl=
og:
> >                                                         sctp_do_sm()
> >                                                           sctp_sf_do_as=
conf()
> >                                                             ...
> >                                                               sctp_asso=
c_rm_peer()
> >               lock_sock()
> > (2)          chunk->transport =3D transport
> >              sctp_primitive_SEND()
> >                ...
> >                sctp_outq_select_transport()
> > *BUG*            switch (new_transport->state)
> >
> >
> > Notes:
> > ------
> >
> > Both threads operate on the same socket.
> >
> > 1. Here, sctp_endpoint_lookup_assoc() finds and returns an existing
> > association and transport.
> >
> > 2. At this point, `transport` is already deleted. chunk->transport is
> > not set to NULL because sctp_assoc_rm_peer() ran _before_ the transport
> > was assigned to the chunk.
> >
> > > We should avoid an extra hashtable lookup on this hot TX path, as it =
would
> > > negatively impact performance.
> >
> > Good point. I can't really tell the performance impact of the lookup
> > here, my experience with the SCTP implementation is very limited. Do yo=
u
> > have any suggestions or alternatives about how to deal with this?
> >
> I think the correct approach is to follow how sctp_assoc_rm_peer()
> handles this.
>
> You can use asoc->peer.last_sent_to (which isn't really used elsewhere)
> to temporarily store the transport before releasing the socket lock and
> sleeping in sctp_sendmsg_to_asoc(). After waking up and reacquiring the
> lock, restore the transport back to asoc->peer.last_sent_to.
>
> Additionally, during an ASCONF update, ensure asoc->peer.last_sent_to
> is set to a valid transport if it matches the transport being removed.
>
> For example:
>
> in sctp_wait_for_sndbuf():
>
>     asoc->peer.last_sent_to =3D *tp;
>     release_sock(sk);
>     current_timeo =3D schedule_timeout(current_timeo);
>     lock_sock(sk);
>     *tp =3D asoc->peer.last_sent_to;
>     asoc->peer.last_sent_to =3D NULL;
>
> in sctp_assoc_rm_peer():
>
>     if (asoc->peer.last_sent_to =3D=3D peer)
>         asoc->peer.last_sent_to =3D transport;
This change introduces a side effect: when multiple threads send data
on the same asoc using different daddrs, they may interfere with each
other while waiting for buffer space, as each thread updates
asoc->peer.last_sent_to.

You may consider holding a refcnt to the transport (similar to how the
asoc refcnt is held) in sctp_wait_for_sndbuf(), as shown below:

@@ -9225,7 +9225,9 @@ static int sctp_wait_for_sndbuf(struct
sctp_association *asoc, long *timeo_p,
        pr_debug("%s: asoc:%p, timeo:%ld, msg_len:%zu\n", __func__, asoc,
                 *timeo_p, msg_len);

-       /* Increment the association's refcnt.  */
+       /* Increment the transport and association's refcnt.  */
+       if (t)
+               sctp_transport_hold(t);
        sctp_association_hold(asoc);

        /* Wait on the association specific sndbuf space. */
@@ -9234,7 +9236,7 @@ static int sctp_wait_for_sndbuf(struct
sctp_association *asoc, long *timeo_p,
                                          TASK_INTERRUPTIBLE);
                if (asoc->base.dead)
                        goto do_dead;
-               if (!*timeo_p)
+               if (!*timeo_p || (t && t->dead))
                        goto do_nonblock;
                if (sk->sk_err || asoc->state >=3D SCTP_STATE_SHUTDOWN_PEND=
ING)
                        goto do_error;
@@ -9259,7 +9261,9 @@ static int sctp_wait_for_sndbuf(struct
sctp_association *asoc, long *timeo_p,
 out:
        finish_wait(&asoc->wait, &wait);

-       /* Release the association's refcnt.  */
+       /* Release the transport and association's refcnt.  */
+       if (t)
+               sctp_transport_put(t);
        sctp_association_put(asoc);


You will need to reintroduce the dead bit in struct sctp_transport and
set it in sctp_transport_free(). Note this field was previously removed in:

commit 47faa1e4c50ec26e6e75dcd1ce53f064bd45f729
Author: Xin Long <lucien.xin@gmail.com>
Date:   Fri Jan 22 01:49:09 2016 +0800

    sctp: remove the dead field of sctp_transport

Thanks.

