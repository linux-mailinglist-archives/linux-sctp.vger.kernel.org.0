Return-Path: <linux-sctp+bounces-484-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01B3A7E3A7
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Apr 2025 17:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B8E16C3B9
	for <lists+linux-sctp@lfdr.de>; Mon,  7 Apr 2025 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1071EB5DA;
	Mon,  7 Apr 2025 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIbal7lj"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8471FC7CA;
	Mon,  7 Apr 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038336; cv=none; b=WAuellUqHiwkN0oGX8zHz+0MmhXmcPlJ908b6Svbwf0KGhJlwxqxdNCjbkRfwu9yuvYi4iohD1SRhIPcQwsJzNpWYAgZHjT+RcPaLUcPsydJe1sn1mDldwDRQO0MZwTBSKmNFW6gr06lf0OYEzt/oHuU7IdWAyWwCOte40YyWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038336; c=relaxed/simple;
	bh=l5rMPyLON8NGIZfdFdeRiGexk44gSXDJlocK3eGFhGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzMPqPpGM1T0bTQZMnk/kxrSiMC6SYR4g3x2H6fnxSvawGRRGcii3YuL8VMmwtBM35geSuU0czUa9/lkj8oiBx4sAXP7Lm8MGE8MYBKLcqTYMwMwgIy1AfJLt/CeCFBP1kHTtviMS8nKUb8Wi2KAd3U5SXw2pY5L8YuXcjD6iCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIbal7lj; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso143532139f.2;
        Mon, 07 Apr 2025 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744038333; x=1744643133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5rMPyLON8NGIZfdFdeRiGexk44gSXDJlocK3eGFhGQ=;
        b=FIbal7ljCBPTYFq5ev9zJRzyC0NrfLn2sDFrrdM1WHnuLcRAHRoAY+ze8VKNo5c5gU
         uMs1VkOPgodUymSJTd0aiU9DpRTmgpUuaGEK+w13aSr8kBfXBYyyWAEfbkX0U3TdIafN
         lDoMXrLWc94LcpxUlXFcHq5zVVb4ROb/wubBWqX5JR6ewyn7spMpfWanrYol50YJE4Hc
         gpO5RyRjtcqmBs6OHExyfi8maqaU6gC+/p7WchIJN8XsdcsMpqkv1SY57hxP6J0x2D+d
         2zuCZYSBku5lCAWl3d37bb4ttOKCFdpplmPUIxC5uZTnTGJNkh80Xf3BuzHtvlE3Xumx
         xKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744038333; x=1744643133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l5rMPyLON8NGIZfdFdeRiGexk44gSXDJlocK3eGFhGQ=;
        b=X0SpHpVIVEasfeCN6XpCr0xIMYxnwh21/IdyEvUPqw9cajxxVvZgsCuN8+qpPI6W3k
         vd4n42OhTqzxeStxBzYMqsQDhnufWCTA2mkpG6INomQlWXwr06+klMgelII+i0BdjM4M
         tA4iKO25XEi8ZgbgqNbWwa2cVOmrr7vu8l9o8PkWiwq1DwlvJVJBGBzflNhRJRZSzd0P
         1svHUlf3yKr4DmQbKKnUJH492Dey9DX+YHKExyw1iSGa9JNo+IBPEq6zPPEXGGic/RQU
         D92NsotIypqgQ1zgwSegnZzNyTGyuxhWLPhaOobgGquVRyB2IA81CYHPjnTTCu2/VhL1
         aQuA==
X-Forwarded-Encrypted: i=1; AJvYcCUgpong9wWPZpCmlxxPbLcPTjWaJa4N/hHLN6z2VH3Se4UFHgya2aBW5OmvUaB0WadlHlFN7+gGjWUooBw=@vger.kernel.org, AJvYcCXJ2z6Sx8sq6uMvbvmZjHy56OmB/qiTvjjSuHe4CGxrOTptPqk3guzA4QZPbqrRrkE+MFpo7jvB@vger.kernel.org, AJvYcCXWc5jAwt8oGbP4HNon58Ko+CV1Qj8mVp9ZzzmkcDgsjpBJ+S8vaj6G0PiK362WIwC8ZjDILN76lRPNeg==@vger.kernel.org, AJvYcCXzrqqe7ErqxKHN2SgOKaouBsUfibQ0xJr11nWiryOdi0GBW7jrlasP3J32iJ6mXtmCeIB72jS4@vger.kernel.org
X-Gm-Message-State: AOJu0YygR2ma4lKIlsf5hM8r4/2A65vds3pM5241o0vV4dS3yvUfHJG7
	mYx+Ep5nsjF55Dn1Smmqii8Msiw5dPOVkxAYQjQYd3o6/m4VZ2ISakmSx3OVNRL6teUgHNNFkes
	14v+SnbAbfuYDpoZeTviEpMoPrOrdw/Oq
X-Gm-Gg: ASbGncuZ29TMALdk0bScXfjmkC9ApKZN63g1XYrcPPafPDSsVCjJxmobNhLpfAFWEDb
	2ne4iRbTWTGETTY0oTxF435c8s8PovrCS/pPJuXdVpJqCqH0u9xEMwGam+9Vjmec4VM+hY4QBrv
	8RTkkXTKOmzMP3XZDuxMZ/ajbOKU5Ey/vXQf1AZfch4sarERwC4SGBs0Ikog==
X-Google-Smtp-Source: AGHT+IF3I+vQSDuOBedXmdX/T50kiR5ajQm6UKhYNro+XWoy1mIZlzvfqcQuvZhjlXI0EfM2Fa1hvWdDfuhH2H7lIso=
X-Received: by 2002:a05:6e02:260c:b0:3d3:f520:b7e0 with SMTP id
 e9e14a558f8ab-3d6e5307926mr121653945ab.6.1744038333557; Mon, 07 Apr 2025
 08:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-v1-1-5ce4a0b78ef2@igalia.com>
In-Reply-To: <20250404-kasan_slab-use-after-free_read_in_sctp_outq_select_transport__20250404-v1-1-5ce4a0b78ef2@igalia.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 7 Apr 2025 11:05:22 -0400
X-Gm-Features: ATxdqUG_xJ3EtXrPnSfaJh2qYk9eV3oKprtjQm0b6WggPpNLQViQklfMXyzONwQ
Message-ID: <CADvbK_fRgqPTJGK7w_ujuiSVqwt_XPUaisd2Qp_t--yf6NuS8A@mail.gmail.com>
Subject: Re: [PATCH] sctp: detect and prevent references to a freed transport
 in sendmsg
To: =?UTF-8?Q?Ricardo_Ca=C3=B1uelo_Navarro?= <rcn@igalia.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, revest@google.com, kernel-dev@igalia.com, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 4, 2025 at 10:54=E2=80=AFAM Ricardo Ca=C3=B1uelo Navarro <rcn@i=
galia.com> wrote:
>
> sctp_sendmsg() re-uses associations and transports when possible by
> doing a lookup based on the socket endpoint and the message destination
> address, and then sctp_sendmsg_to_asoc() sets the selected transport in
> all the message chunks to be sent.
>
> There's a possible race condition if another thread triggers the removal
> of that selected transport, for instance, by explicitly unbinding an
> address with setsockopt(SCTP_SOCKOPT_BINDX_REM), after the chunks have
> been set up and before the message is sent. This can happen if the send
> buffer is full, during the period when the sender thread temporarily
> releases the socket lock in sctp_wait_for_sndbuf().
>
> This causes the access to the transport data in
> sctp_outq_select_transport(), when the association outqueue is flushed,
> to result in a use-after-free read.
>
> This change avoids this scenario by having sctp_transport_free() signal
> the freeing of the transport, tagging it as "dead". In order to do this,
> the patch restores the "dead" bit in struct sctp_transport, which was
> removed in
> commit 47faa1e4c50e ("sctp: remove the dead field of sctp_transport").
>
> Then, in the scenario where the sender thread has released the socket
> lock in sctp_wait_for_sndbuf(), the bit is checked again after
> re-acquiring the socket lock to detect the deletion. This is done while
> holding a reference to the transport to prevent it from being freed in
> the process.
>
> If the transport was deleted while the socket lock was relinquished,
> sctp_sendmsg_to_asoc() will return -EAGAIN to let userspace retry the
> send.
>
> The bug was found by a private syzbot instance (see the error report [1]
> and the C reproducer that triggers it [2]).
>
> Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-=
after-free_Read_in_sctp_outq_select_transport.txt [1]
> Link: https://people.igalia.com/rcn/kernel_logs/20250402__KASAN_slab-use-=
after-free_Read_in_sctp_outq_select_transport__repro.c [2]
> Cc: stable@vger.kernel.org
> Fixes: df132eff4638 ("sctp: clear the transport of some out_chunk_list ch=
unks in sctp_assoc_rm_peer")
> Suggested-by: Xin Long <lucien.xin@gmail.com>
> Signed-off-by: Ricardo Ca=C3=B1uelo Navarro <rcn@igalia.com>

Acked-by: Xin Long <lucien.xin@gmail.com>

Thanks

