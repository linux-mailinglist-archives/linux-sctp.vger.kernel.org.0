Return-Path: <linux-sctp+bounces-272-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C429B4CF9
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 16:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85AF5281E7C
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Oct 2024 15:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5518DF60;
	Tue, 29 Oct 2024 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvXhbC4z"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6A19306F;
	Tue, 29 Oct 2024 15:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214376; cv=none; b=k5EHopTA2CYFewf5I8I0HrVrccDq/SSSpyhyigPe1Q7DzR3jqG6M7IMB52aqA+uDHEW2+q7cDfi/l4x+hHw8mMFFBMuis9YXUPbkhu6CX4wOedBrNE4Hbt5X6CaKBrc66SsM7YphXDw7X23i5Lp3HGQ2qgeLMaGVRgiT2J4RCZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214376; c=relaxed/simple;
	bh=OtqMbGEK7ANuRQtRM2dsZgPAopTCBrySCzVv68vLxQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnGE9fNQJImvus2VQGSVez2xqpTp/yEssZPS81m9yT09hRRxSYuyTLkONvEHo7pNT/THXqW1K2zr3VMQ0zw10VMqZlC3pLA7C7SDGnreX3AdJXsOYtjFEfKY4ILvj+spEAPsWPHIEVoTTukXnF3jAQwWSo2JmS8bNMG516Cpdu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvXhbC4z; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a3b7d95a11so18749505ab.2;
        Tue, 29 Oct 2024 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730214373; x=1730819173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFKhKFT9IwpEW5k50b87P0zH8/cUwcz2zc0dijus744=;
        b=FvXhbC4zvVizxPMP5DIzyuvZ9WXQ5WGZqzdMxfp2sTIh4N1stbq+WQHGdb2eLuwucw
         4ObjWZtBXwBsy7HmHWBqqSovr9dO/XK1PvwvPq82IM4/o5fKpAcUAW8nDCXsHn1X3SC/
         dN5kl8W/LwJXtoKAAmwQnNGM+nb6cYBs+Azo9YEtqORc2ONCuiS/OJm1xfcFeVzNTA8d
         sdMPdLlzsoSnddlp3duDJ+gV5+rIQFuhHk+LlKfsC7rCiXQczwPoxjzzghVZtqYX0hFQ
         SqS4xROdK90I9gadrB51owvHxgJdD8WUpc6v8kkL7LRXdncpZ0dEMcQ2vxhEvbZF/Qq6
         MwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214373; x=1730819173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFKhKFT9IwpEW5k50b87P0zH8/cUwcz2zc0dijus744=;
        b=tIXYUZwJ2muIv59YsFhpVXAS3bKGILX7tWMeZcHgt+h9I7kOYhzbmlyPPFKYRhXX3T
         /Xn+Kx+m2Cg2bwc63DDXQau8FLp8vfe7W6tWARqTzRkxzKlKq1MxBnXu9ojZxS0qc70e
         D2ppL/7uuCkORfGZdbVcb5XMfQFAHfEFoezMADIps/IR3+SWwii6AgJ60tuzZ2oXFJ37
         1kcI+ygWwDuxzjoEFq+OYpGwPZNzlrNkWcUHBoYbmPvJSg6UcWJbM+sFK4WXfxUXcIA3
         SYhYjFjaDED0XYsdMQRNX3MQb8V7pvN/HEZlSN0XhVB8rMYuThbibf4/Oi7heyUWuSH7
         blRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNWBr1J2yPPvQ9LtqkKhZnzTh1YsuJGPrmS8UhQh0ENn7ZJV748lDCaeqHhZVQuqbbgEM8oTk0qj/a@vger.kernel.org, AJvYcCX+3vkKkt3p7lJC59VFs7J81ZtdRzYST2bLVW5UF8sKP0JOKpjFyHj/VJaqDl2tWc/GW+YEfGq2@vger.kernel.org
X-Gm-Message-State: AOJu0YzWdnne9Ls5XH5vQPqZeu5KirxFc8wGYThpaWNz6yWOQ9DMqleo
	v6YfLcY741f1iVD/AZ3mX6+E35a5k+s65XI3YwPrxdCjRo9qRa8Is8xpZAHRwcPWacmsnKFy0Gn
	XuZR4X+amFx0mc+f0sdlTElw56ijGJILT
X-Google-Smtp-Source: AGHT+IEtId3Xh1qbzSGoLnduAkX75TeiPCnwGNjI4NvMq/8AWkTjxBY8ZrNKLjXdnNfJebWMgA5p3bsI/GlSN+wT2ws=
X-Received: by 2002:a05:6e02:188c:b0:39b:330b:bb25 with SMTP id
 e9e14a558f8ab-3a4ed2944dbmr114901065ab.12.1730214372590; Tue, 29 Oct 2024
 08:06:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028124845.3866469-1-gnaaman@drivenets.com>
In-Reply-To: <20241028124845.3866469-1-gnaaman@drivenets.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 29 Oct 2024 11:06:00 -0400
Message-ID: <CADvbK_c5jNywSZOwSb-qcfxoNwauG1vkQFg6a8h4QOq50Q9uSQ@mail.gmail.com>
Subject: Re: Solving address deletion bottleneck in SCTP
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:49=E2=80=AFAM Gilad Naaman <gnaaman@drivenets.com=
> wrote:
>
> Hello,
>
> We've noticed that when a namespace has a large amount of IP addresses,
> the list `net->sctp.local_addr_list` gets obscenely long.
>
> This list contains both IPv4 and IPv6 addresses, of all scopes, and it is
> a single long list, instead of a hashtable.
>
> In our case we had 12K interfaces, each with an IPv4 and 2 IPv6 addresses
> (GUA+LLA), which made deletion of a single address pretty expensive, sinc=
e
> it requires a linear search through 36K addresses.
>
> Internally we solved it pretty naively by turning the list into hashmap, =
which
> helped us avoid this bottleneck:
>
>     + #define SCTP_ADDR_HSIZE_SHIFT     8
>     + #define SCTP_ADDR_HSIZE           (1 << SCTP_ADDR_HSIZE_SHIFT)
>
>     -   struct list_head local_addr_list;
>     +   struct list_head local_addr_list[SCTP_ADDR_HSIZE];
>
>
> I've used the same factor used by the IPv6 & IPv4 address tables.
>
> I am not entirely sure this patch solves a big enough problem for the gre=
ater
> general kernel community to warrant the increased memory usage (~2KiB-p-n=
etns),
> so I'll avoid sending it.
>
> Recently, though, both IPv4 and IPv6 tables were namespacified, which mak=
es
> me think that maybe local_addr_list is no longer necessary, enabling us t=
o
> them directly instead of maintaining a separate list.
>
> As far as I could tell, the only field of `struct sctp_sockaddr_entry` th=
at
> are used for items of this list, aside from the address itself, is the `v=
alid`
> bit, which can probably be folded into `struct in_ifaddr` and `struct ine=
t6_ifaddr`.
>
> What I'm suggesting, in short is:
>  - Represent `valid` inside the original address structs.
>  - Replace iteration of `local_addr_list` with iteration of ns addr table=
s
>  - Eliminate `local_addr_list`
>
> Is this a reasonable proposal?
This would simplify sctp_inet6addr_event() and sctp_inetaddr_event(),
but complicate sctp_copy_laddrs() and sctp_copy_local_addr_list().

Would you like to create a patch for this and let's see how it looks?

Note I don't think that that 'valid' bit is useful:

               if (addr->a.sa.sa_family =3D=3D AF_INET &&
                               addr->a.v4.sin_addr.s_addr =3D=3D
                               ifa->ifa_local) {
                       sctp_addr_wq_mgmt(net, addr, SCTP_ADDR_DEL);
                       found =3D 1;
                                      <-------- [1]
                       addr->valid =3D 0;
                       list_del_rcu(&addr->list);
                       break;
               }

'addr' can be copied before "addr->valid =3D 0;" with addr->valid =3D1 in
another thread anyway. I think you can ignore this 'valid' bit.

Thanks.

