Return-Path: <linux-sctp+bounces-1290-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VJ/FNmg5PWrdzQgAu9opvQ
	(envelope-from <linux-sctp+bounces-1290-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 16:21:28 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1936C6910
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 16:21:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=d9h34WFE;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1290-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1290-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70355311FBEC
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 14:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55A8349CE0;
	Thu, 25 Jun 2026 14:12:54 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778B30FF1D
	for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 14:12:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782396774; cv=pass; b=U3ChtkmRInVtka3BkDWe/MdMqDjziQ+CGtl5FafQIUs2piJI0Y1SRBjnzwk5vxXRZV4gF8zyv/bKsXMr9jxykKejXAo7MDPLw9BnR5Khsl7aiYnwXjBgQUSEPlcHAPrGh5P23VmiMdU/OYnEv6E9kaGVl1wHczIcfC9C0yHhjQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782396774; c=relaxed/simple;
	bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9t/8btOO6eROHLp3C12b8Fbsutd9DZxkjL/BPAcwEgDQX1a8hiqz0duL4OKfjFmxZjSvyCfMhi/fCJd0BWPPThCCEJSs1r9cSRg7rjz8LCNgt5hrRUWPOtgSB1Vjn1gY67+9McyalXmgazUme6X9n4Em5zhNv2UA/a3VG6V0Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d9h34WFE; arc=pass smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845b965c1c4so366051b3a.3
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 07:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782396773; cv=none;
        d=google.com; s=arc-20260327;
        b=cam3gyd7w4pkyCYrFA1l9/+fYABPn8bGM3Bq/1Vi/VzbRb79q2EDHXGlieabD5AZRb
         niKqxqS0i4WgLOV5Kc2Iuh2/g/djkyGpnIRafprCo0MJ4JXpKw2w58y/RGrVDCJnmV9O
         b9PUwHQyfo8m+6svzvIpVtOMyLDTLKAckC3XNze/PasOlkbggcu/jsVpnCPgyITfQPLu
         zk5DeDqM8corwDH++MiXkzpyqZSeu3p4OKNkbr6+dwaJCve+6fYC6IWWLjIjxkjuMiR+
         iIYW9RLoacizi0Aa3AiCoHIBYpP04Z05R3TPIQ+SRJPyxo0K+gVV62sJR16xyErB0jhS
         qLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
        fh=k5mPrR/gFtuP2+JGCnMJGmL7BmE3NqZmtsQUCWooqmI=;
        b=D9IDT2L1j5ItXUe7DgypmtazQW9T5a1lejgGSxSLQEfSC5F1J4o3aNIhgMkU1ZM4kJ
         fULCHXE9KfEKcWctxXo6K1w23z9rTdpz01ct5XQzlScErSJ6kAJJ+QCOmt9P5PTB4hDt
         KA0Kvt+9zBjzdQCkPjtKgKFdBzzsapkZYQbmIy7DkgNyjFYtu19aIa9f6clrfnGKFwBX
         OH3iKLNPVDiNhdyZHaNGncqS3hDHoBa8GIWzK0I5qds10IWoUcBAf+RX0MvVi5pKKlWN
         RSgnoR5Q/ZM/9B3wYNj+sU4XPifNvEHw9Hw98X/7rBMS6BKZPL+ZIj7NOhHd1g1gBkeg
         gtIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782396773; x=1783001573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
        b=d9h34WFEbNocy62+AJy8DzyAoMYMFtpjHZjPQzpUmNzCCczOflHfk5ItZI2vALEZau
         I5PE6oDbr+qQVpLF4XS8Mg4FARJdfs1r1N6NvDmUcEaIiVIrmopNFMMinNhMPnW9+3+X
         /DQhHkn4CBL9wA8FaLW6FEXrVeV2l5uK7uOCwXTJM4RqNdMKw5tuPvuHlO8+Ran3r2M7
         ug1OYDY26R97f4VVJT9Bk0tnCDQ/T3MEUKHaZzvl8NO9uG/WFmutQIiV5ugpnoE1FVQi
         KbgCzKB2jI/iniiBZNWKgY4w+cIO62YmsjuI3HeMGxponZcbj488Jqm5QtFEmFZXW1zf
         jR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782396773; x=1783001573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=933iqY0MeoNdLo0BcwFcmwnkY82X/f5hku8SHN4XI7s=;
        b=asssnhS5wZymJruqro3Bxj1AnLh8NFrrnKcTa/Ozaj0eZ8nbJTe0hU7WZSTtQaJ6EE
         x7C3xt/JiXAXK9fD3almOSdqD+SlA9b1HA3L76WjwdxONBG13yRfs+K6eHfHTrKjREfg
         EJr4jPkkcDmXh8L4GhGTOsiU1hyqxf/y4vxbK/LPq8gB4mYVOCMhnJIeQy2f1CLyCc+c
         MgsMi0S5iDMmPTdjvgssRxmZcfVtGC9QmQCIHgHbnvu7seV9KR6FVaI8Y+cDYsGSfaW9
         b4k5dNIms6luz0Vdds37j4ykwXfny+hvcEjb0M0Ch1SZWhiuOZkCmcC/K0C2pc9If2CR
         PIiw==
X-Forwarded-Encrypted: i=1; AFNElJ/2tic7JXb82vX0MG0ftmzAdcOQbnZdZIqWLxjVeAjUn5slYJno3E4+Ued9rOHyVfaEmbnf6rFuU9S6@vger.kernel.org
X-Gm-Message-State: AOJu0YxXqtKbxgre4EMC6iftk2BaVNmfkrmn06ONDCTZ2qYq/V+uxCaZ
	1T6764ffEQOpABu8DgTcmn+VSLOK3uQYb217Tpaky3GHPVnuVfaJdWZbNfEKYhB31qqAIMvkeOF
	YyoLOGJ27L7wXkJqtuNQ2o8DcSOhNpvU=
X-Gm-Gg: AfdE7clhEoBNYVgKt+9N//gscXlyBx8bbc1Wcl2Gkt2F58+g62PWNKGILl+zZE5VDXF
	Sdul5Wv9MB5dbawZUt3BOFvgz65Qbf5AGNASbxcaAstmTggh/HA7RzhG1/0tzqVq3BfDHxbyb4V
	McywELpHVeyQg9/0YGeQO5qW7jBM2tAIkQ1NcEv0KpMoz9VvqM8YkhL6cImb5ie139WHVbxtaQS
	xoDkR5nAD2Ox9WyrzVpW2K3fWDnW4zGc+XHaaNZgVxzuUWcbTnWTv6U9wd8vidw6AXkBzrSqwGl
	UkCiUzQcTkM7WgGE+09ddoP5xOB0d+BfihlZcguVbfveP/iiA55EaWq/9sxNLRshZ+Vt8zE0x3k
	H1pTEdeYVU9SZuflS73OY0ZNz+z26Fg==
X-Received: by 2002:a05:6a00:6f68:b0:845:b6ff:1fac with SMTP id
 d2e1a72fcca58-845b6ff2223mr2236910b3a.4.1782396772755; Thu, 25 Jun 2026
 07:12:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624122213.4052-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260624122213.4052-1-alhouseenyousef@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 25 Jun 2026 10:12:41 -0400
X-Gm-Features: AVVi8CdHtH6SROInozA5Lodpp3WJq0v7G2r4ylbN0iKz2xUBvNsEFPjhRllOgKg
Message-ID: <CADvbK_fkiQtAM7A7y3P9p4nA==pJpRt3FVeGT0adcs4UoNnAgA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix SCTP_RESET_STREAMS stream list length limit
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1290-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:marcelo.leitner@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-sctp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E1936C6910

On Wed, Jun 24, 2026 at 8:22=E2=80=AFAM Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
>
> SCTP_RESET_STREAMS carries a flexible array of u16 stream IDs, but the
> optlen clamps treat USHRT_MAX as a byte count and then multiply
> sizeof(__u16) by the fixed header size.
>
> That caps the copied and validated option buffer at about 64 KiB, which
> rejects valid requests containing more than about half of the u16 stream
> ID range.
>
> Use struct_size_t() for the maximum struct sctp_reset_streams layout
> instead, so the bound matches the flexible array described by
> srs_number_streams.
>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Fixes: 5960cefab9df ("sctp: add a ceiling to optlen in some sockopts")
Acked-by: Xin Long <lucien.xin@gmail.com>

