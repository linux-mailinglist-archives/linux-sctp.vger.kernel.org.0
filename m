Return-Path: <linux-sctp+bounces-613-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA61B2AFA0
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 19:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2877162447F
	for <lists+linux-sctp@lfdr.de>; Mon, 18 Aug 2025 17:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7C831159E;
	Mon, 18 Aug 2025 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDyNN7LF"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12ED2773D9;
	Mon, 18 Aug 2025 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755538884; cv=none; b=ofzMzIKeWo239mfuzXUgozVHLDIw46rK1GYXQWjfsZ7ihMVTtbZp7IsYXl/V9p1LkzhCi2+ipKUwrZFaaVmgycsjTxBo2l5lNFeNK/WZ+YZe3AkaxeHGfcLvpESdyndpW+EdVsh7hRK/Uqz37nl9BUMlcmV2NvzRd6uSRC6A7us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755538884; c=relaxed/simple;
	bh=BRCDXyDsdBES13f9KmFR7mYxTA+tpPWyzhpBVQAtlIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DECD3ZhNf+I4opIzHWoE4obsQlXVzWWaDH6EecvWpCzWTY/1NvT4qLC7uW1mqn2O2CMKPNZgqq2uxnT3fnvK3dKbtmG6dqWGxIQWah4Y/hjkpZnSVSNszF62YbUVlJO4DvaOgEdL/fOaOKNOxkEIE0zOvYJ6x//5G7TVhtagjG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDyNN7LF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3e66da97a68so4923365ab.3;
        Mon, 18 Aug 2025 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755538882; x=1756143682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cupmWBQaHmjpXgd6pX7tuh2q7xNfoidH73Q/EBmYAB4=;
        b=HDyNN7LFtR7fUu7GFwP07OmzWHtSCJBKMVVPf3ciP4aaZBi202vA2dgYqnXkxVoC6P
         Rmv6Qcf+/IdJ+DHsYzmbdZPvgkU3OmdawoWseNE4JSJCyc5LbjCX3kszoxgDI1ln6DQx
         AkLudrQkrVhV//4l3/Yiy0CrnWUBNUveARWRHAJmA9waXroM3GbOrAuB9Q7oaCU+Yysl
         4lKuasYgdwO66aUrJ2AEr8icTrevZ2zZKx3Pr/cU4SI3RWq0Rhxg99SVUF/ZfOBL7iHf
         vRppRxst4ICb/COMyZKrx5v2n+DdNzsl+1Y2Qp/vGSI5+fjytnmp/BFWcT4z4Swut9vp
         M3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755538882; x=1756143682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cupmWBQaHmjpXgd6pX7tuh2q7xNfoidH73Q/EBmYAB4=;
        b=KTmwyyArYFHIv25+WkkPu6uq404Woh6av0GQO88+tTVaUjUG6xfK6NyyVBvH9V5v6J
         a34oef14ormgM3x55TsNgQvHkHWk+ejM0iS2HbTo/EK5TnEj3xc5I8/eCzc/VQOBPji8
         NfvjWUt87jnViCoscVeEHb8W56E4Qb+rbTbQSJL/aTa8KIV6W2AlaJJC/nomn7l872Jc
         xPhQI6nNgtfqzYX5Dne32yusmb6+Ly56rly28y5O4xWhCwdHcjDcWHtWNaMup+txZ2iE
         UiNWG1SMBWYKhM99M1HADTzaF4GPytURqZjg9ykBjSXl+/yXgLEQ1bpCGOAm9HgUvDZM
         tjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIT7ydu7diLUx/b/REfH3itamX6uZSh3joGSk8OsF3jCneCTn5OtyQ6wijQnMkv1ns+KwGs74iEz7JU58=@vger.kernel.org, AJvYcCVcBL4ON04At+MKLQPEjlT4k4hWVqL3KFPuDmw9oHqj9ZrFp+Sx5KKpHyo8zPCe6+dml07GkY4B@vger.kernel.org, AJvYcCXKYXn42cpwvb0Fs/ogazgYuTAdQxBSCttgH83IaJag2B8PRo9P9SVvjWGCohT4xX7jWLyE8h9wvuywvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzco7vQaJT0tdIRvJkvl6+vG2ZKXMm9QFoQPMDdedF9/xWxL/fO
	NZHiQ4M6Vl1USvJEwA+sM9QoNHp5NMNCziQ2pxyAkcGm1LwwkS2rYnzNha2ZMZdB/iiQGoR1Bn6
	EiU9RYEggwaVkbayYTpzeHzH1oUG+3lo=
X-Gm-Gg: ASbGncsTysvC+L14l1cPg+OH35uwtt9b3ssSIlUyV1U8YGEKlBbqiIp9IrXK4YYx24H
	tlPcATotUoHu3Dkcrzw/6TWq40tstKmPsLCBB8Gh4AedhcjEiK7m5Gd/FfwM6TBm6HqSFcay8ee
	CL4/B2ESGiwTSrSiFwfdGlG1dieIrAJ9nkaWIr34QvECohQuAg5bRSMfr7OgY08ZycYKYN9RHG2
	MOyyk3XKv6oEpWw0hditMlglqMIRVg=
X-Google-Smtp-Source: AGHT+IGG/nkbwhWdA04ID0qu1G89kSKYxtCap80Ns8DEFOpqPanZ0RuEC0EP4IKzHY0+rY/oJNve34YfNKsCQPrR97k=
X-Received: by 2002:a05:6e02:1d89:b0:3e5:7e24:3edc with SMTP id
 e9e14a558f8ab-3e58391e0e7mr175045915ab.20.1755538881258; Mon, 18 Aug 2025
 10:41:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813040121.90609-1-ebiggers@kernel.org> <20250813040121.90609-4-ebiggers@kernel.org>
 <20250815120910.1b65fbd6@kernel.org> <CADvbK_csEoZhA9vnGnYbfV90omFqZ6dX+V3eVmWP7qCOqWDAKw@mail.gmail.com>
 <20250815215009.GA2041@quark> <20250815180617.0bc1b974@kernel.org>
 <CADvbK_fmCRARc8VznH8cQa-QKaCOQZ6yFbF=1-VDK=zRqv_cXw@mail.gmail.com>
 <20250818084345.708ac796@kernel.org> <20250818173158.GA12939@google.com>
In-Reply-To: <20250818173158.GA12939@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 18 Aug 2025 13:41:10 -0400
X-Gm-Features: Ac12FXy-2BAP6rOYHclimGJTrQf4jlwx4S7fJovjnxRkK-zlRwGPdqwxeI7JuTY
Message-ID: <CADvbK_dG74iD7VS7dgS6fXzn5BVez0tzTV3o1x6qKYigt1BLUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/3] sctp: Convert cookie authentication to
 use HMAC-SHA256
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 1:32=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Mon, Aug 18, 2025 at 08:43:45AM -0700, Jakub Kicinski wrote:
> > On Sat, 16 Aug 2025 13:15:12 -0400 Xin Long wrote:
> > > > > Ideally we'd just fail the write and remove the last mentions of =
md5 and
> > > > > sha1 from the code.  But I'm concerned there could be a case wher=
e
> > > > > userspace is enabling cookie authentication by setting
> > > > > cookie_hmac_alg=3Dmd5 or cookie_hmac_alg=3Dsha1, and by just fail=
ing the
> > > > > write the system would end up with cookie authentication not enab=
led.
> > > > >
> > > > > It would have been nice if this sysctl had just been a boolean to=
ggle.
> > > > >
> > > > > A deprecation warning might be a good idea.  How about the follow=
ing on
> > > > > top of this patch:
> > > >
> > > > No strong opinion but I find the deprecation warnings futile.
> > > > Chances are we'll be printing this until the end of time.
> > > > Either someone hard-cares and we'll need to revert, or nobody
> > > > does and we can deprecate today.
> > > Reviewing past network sysctl changes, several commits have simply
> > > removed or renamed parameters:
> > >
> > > 4a7f60094411 ("tcp: remove thin_dupack feature")
> > > 4396e46187ca ("tcp: remove tcp_tw_recycle")
> > > d8b81175e412 ("tcp: remove sk_{tr}x_skb_cache")
> > > 3e0b8f529c10 ("net/ipv6: Expand and rename accept_unsolicited_na to
> > > accept_untracked_na")
> > > 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lif=
etimes")
> > >
> > > It seems to me that if we deprecate something, it's okay to change th=
e
> > > sysctls, so I would prefer rejecting writes with md5 or sha1, or even
> > > better following Eric=E2=80=99s suggestion and turn this into a simpl=
e boolean
> > > toggle.
> >
> > Slight preference towards reject. bool is worse in case we need to
> > revert (if it takes a few releases for the regression report to appear
> > we may have to maintain backward compat with both string and bool
> > formats going forward).
>
> To be clear, by "It would have been nice if this sysctl had just been a
> boolean toggle", I meant it would have been nice if it had been that way
> *originally*.  I wasn't suggesting making that change now.
>
> It would be safest to continue to honor existing attempts to enable
> cookie authentication (by writing md5 or sha1), as this patch does.
>
> If you'd prefer that those attempts be rejected instead, I can do that,
> but how about I do it as a separate patch on top of this one?  That way
> if there's a problem with it, we can just revert that patch, instead of
> the entire upgrade to the cookie auth.
>
Sounds good to me.

Thanks.

