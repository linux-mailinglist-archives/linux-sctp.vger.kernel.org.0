Return-Path: <linux-sctp+bounces-302-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F925A00C7A
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Jan 2025 18:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5253A0622
	for <lists+linux-sctp@lfdr.de>; Fri,  3 Jan 2025 17:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1118C03E;
	Fri,  3 Jan 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UGRm8iye"
X-Original-To: linux-sctp@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784A2629C
	for <linux-sctp@vger.kernel.org>; Fri,  3 Jan 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735923601; cv=none; b=cCSl/FD1z+jiFCzdwZzWWtTaSxCHBpcAKaPoT1cxGv74lhdVgrJx4Ymly3CCuPPCNuV6aUZrQ/aF1zoQmkBEdCnq8mbTxYtdINHgu4gjGT7WFP6oox1Pd7Bq1ATQN5slDhG9ZVKbVQ+D4ZPqoMubBFNwjXnmfikvvXKdzFBCg0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735923601; c=relaxed/simple;
	bh=Hw4GTu34YXSFDWu6CElfpVBvfdvcBcohLY6hEYoxp5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=NLxV6+B5ia0g7V98dURyjLOd9Pmvknjv6mLshEZHMQLhP2ypHVoKNi855hHLTKth74IXXKFfM+jgJAit5mm2fmXxzDfbDdTrF/PzOOjYTNXp9in9/8OAVROnH4ylqx9WMNm6dlrH8FMW/iNU7sCznGwCbh84C2+CenM+Copq2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGRm8iye; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735923598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XfUlWD9Hczq6KcSfqzg4iPKW3lwUVkATrJJ+x5WCxM=;
	b=UGRm8iyeKf4r1lcf4Ox4pvtaqzHpCN2z+VWOmcrA5lRT0hmeOP57Oeq3tq9cXBSYPLttEI
	lsThUIe5ltqddN/g8am8n3NCJlAiCPuHDlw7fa6FTaIkXC3MIkMe4aOIPILqHHuHMjhkeq
	9F8g4jIz/sIbs86uEc4zXMXtAqaURfE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-wVjrewEUOkG67oz3lIZWZg-1; Fri, 03 Jan 2025 11:59:57 -0500
X-MC-Unique: wVjrewEUOkG67oz3lIZWZg-1
X-Mimecast-MFC-AGG-ID: wVjrewEUOkG67oz3lIZWZg
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4362552ce62so66248765e9.0
        for <linux-sctp@vger.kernel.org>; Fri, 03 Jan 2025 08:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735923596; x=1736528396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XfUlWD9Hczq6KcSfqzg4iPKW3lwUVkATrJJ+x5WCxM=;
        b=DxwHCvawDm0/XWXZKBTwLsvYyLpOlay1wY2bk1yJUlztFjuh7gD47snZG6t90bCyUh
         QOvKwpkRaIz3xnpHZmHneZADCMAmms1XP8/PRoMRIpPRIgG8rtQLnhPrGoVO5FcvD8JU
         eLdDSt2yHeHHKgdFJ1Z6+NOPxjty71u6WrmMV01PJqq+klhKr7ivWeyGS/Tiu8jSTP96
         yV379iipFp8wQvClFmmLiDl++n/NASGvBMTZ/KUb6azeKxDkt4s7voBp4qAF4i4FqDSd
         LncHdaeeqUsrcFFoXIJKUWeuYX7EXBxcMIfxo3oj4OUe9/whOWKouW3XCqM6YPg1GAp8
         PlDA==
X-Forwarded-Encrypted: i=1; AJvYcCWV3xvMVnKLdMlfdtpG5O26DIxB0zrCxxgW3CUt6d2JssqNzmKA0BIjJnTI7yDK7HIskl0IC/tAomrd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6sGrYaq5BWseW8QDDZktlhNVoh+8UFWuU7NVNoS2rHzMQmH/W
	u+D+j8mqkpsEOCXaYFxJrPwGTAA74nilBx5nadY9pjp17yUMzWS7WqEzvSp2B+wH3D0DNn7l/Vn
	dOtPQePW/d6VVXZB2LjpUIEkl/LlNp2aalf7ndNEAivxh0CKVeFZDRcSHdbI=
X-Gm-Gg: ASbGncuYxMKsMwpeqMHkolFafL9HHzZ9Fd3KfynSulTsukIGK/i6dHuY5jCc/ZdPuUB
	PI3bXmr0DfC+EA8+5xdph3b8U2ZdDx6tCpxdRpspbEMt/Uw8sEAgh+P8LG5tOi7pZMF/1aSiDQp
	RLuMsWZIRJZXfJj+rtC6uT6GlWI6AOcneYmnWEiCZ4okI8lrrHdRv9iWxhlHgocaWgq6hu/A4Uy
	vdxxjH6A4hSpQ4uhRshJnTzhdbagNYMG5rhhRAotQnftAnqRqq/rC+4BQBskzmE5QDNmoBrGe7T
	18EjazCaGpiPl9YvsxY2rfPUruKKnXgVEL9h
X-Received: by 2002:a05:600c:46c7:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-43668b5e244mr382242075e9.24.1735923596159;
        Fri, 03 Jan 2025 08:59:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3+VowO+yJ4mAQNn3qzywn/HFa+7FG3OUT+ALv2b7BPPq9p++XlOKrnfrcWNjr2Uj0C6LzbQ==
X-Received: by 2002:a05:600c:46c7:b0:434:a4b3:5ebe with SMTP id 5b1f17b1804b1-43668b5e244mr382241875e9.24.1735923595799;
        Fri, 03 Jan 2025 08:59:55 -0800 (PST)
Received: from debian (2a01cb058918ce0019efe14cc4985863.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:19ef:e14c:c498:5863])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656a0b361sm521357635e9.0.2025.01.03.08.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:59:55 -0800 (PST)
Date: Fri, 3 Jan 2025 17:59:53 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	linux-sctp@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] sctp: Prepare sctp_v4_get_dst() to dscp_t
 conversion.
Message-ID: <Z3gXieFRj+xqozJE@debian>
References: <1a645f4a0bc60ad18e7c0916642883ce8a43c013.1735835456.git.gnault@redhat.com>
 <CADvbK_fsM_EfoNjhybKJr92ojqFo6OdnuA2WiFJyi6Y1=rX4Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADvbK_fsM_EfoNjhybKJr92ojqFo6OdnuA2WiFJyi6Y1=rX4Gw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TSoNJqLiPgYUnKxSJejtJzcIWH2M3mC2oHQQPsUHDZE_1735923596
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Jan 03, 2025 at 10:35:55AM -0500, Xin Long wrote:
> On Thu, Jan 2, 2025 at 11:34 AM Guillaume Nault <gnault@redhat.com> wrote:
> >
> > Define inet_sk_dscp() to get a dscp_t value from struct inet_sock, so
> > that sctp_v4_get_dst() can easily set ->flowi4_tos from a dscp_t
> > variable. For the SCTP_DSCP_SET_MASK case, we can just use
> > inet_dsfield_to_dscp() to get a dscp_t value.
> >
> > Then, when converting ->flowi4_tos from __u8 to dscp_t, we'll just have
> > to drop the inet_dscp_to_dsfield() conversion function.
> With inet_dsfield_to_dscp() && inet_dsfield_to_dscp(), the logic
> looks like: tos(dsfield) -> dscp_t -> tos(dsfield)
> It's a bit confusing, but it has been doing that all over routing places.

The objective is to have DSCP values stored in dscp_t variables in the
kernel and keep __u8 values in user space APIs and packet headers. In
practice this means using inet_dscp_to_dsfield() and
inet_dsfield_to_dscp() at boundaries with user space or networking.

However, since core kernel functions and structures are getting updated
incrementally, some inet_dscp_to_dsfield() and inet_dsfield_to_dscp()
conversions are temporarily needed between already converted and not yet
converted parts of the stack.

> In sctp_v4_xmit(), there's the similar tos/dscp thing, although it's not
> for fl4.flowi4_tos.

The sctp_v4_xmit() case is special because its dscp variable, despite
its name, doesn't only carry a DSCP value, but also ECN bits.
Converting it to a dscp_t variable would lose the ECN information.

To be more precise, this is only the case if the SCTP_DSCP_SET_MASK
flag is not set. That is, when the "dscp" variable is set using
inet->tos. Since inet->tos contains both DSCP and ECN bits, this allows
the socket owner to manage ECN. I don't know if that's intented by the
SCTP code. If that isn't, and the ECN bits aren't supposed to be taken
into account here, then I'm happy to send a patch to convert
sctp_v4_xmit() to dscp_t too.

> Also, I'm curious there are still a few places under net/ using:
> 
>   fl4.flowi4_tos = tos & INET_DSCP_MASK;
> 
> Will you consider changing all of them with
> inet_dsfield_to_dscp() && inet_dsfield_to_dscp() as well?

Yes, I have a few more cases to convert. But some of them will have to
stay. For example, in net/ipv4/ip_output.c, __ip_queue_xmit() has
"fl4->flowi4_tos = tos & INET_DSCP_MASK;", but we can't just convert
that "tos" variable to dscp_t because it carries both DSCP and ECN
values. Although ->flowi4_tos isn't concerned with ECN, these ECN bits
are used later to set the IP header.

There are other cases that I'm not planning to convert, for example
because the value is read from a UAPI structure that can't be updated.
For example the "fl4.flowi4_tos = params->tos & INET_DSCP_MASK;" case
in bpf_ipv4_fib_lookup(), where "params" is a struct bpf_fib_lookup,
exported in UAPI.

To summarise, the plan is to incrementally convert most ->flowi4_tos
assignments, so that we have a dscp_t variable at hand. Then I'll send
a patch converting all ->flowi4_tos users at once. Most of it should
consist of trivial inet_dscp_to_dsfield() removals, thanks to the
previous dscp_t conversions. The cases that won't follow that pattern
will be explained in the commit message, but the idea is to have as few
of them as possible.

BTW, the reason for this work is to avoid having ECN bits interfering
with route lookups. We had several such issues and regressions in the
past because of ->flowi4_tos having ECN bits set in specific scenarios.

> Thanks.


