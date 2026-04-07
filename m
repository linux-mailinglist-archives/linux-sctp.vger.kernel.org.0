Return-Path: <linux-sctp+bounces-1164-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KxhO4Eg1Wnr0wcAu9opvQ
	(envelope-from <linux-sctp+bounces-1164-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 07 Apr 2026 17:19:29 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 985583B0D24
	for <lists+linux-sctp@lfdr.de>; Tue, 07 Apr 2026 17:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07323305CDB6
	for <lists+linux-sctp@lfdr.de>; Tue,  7 Apr 2026 15:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0A635DA67;
	Tue,  7 Apr 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRmp+NzE"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA303DBA0
	for <linux-sctp@vger.kernel.org>; Tue,  7 Apr 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574890; cv=pass; b=GR6zRZwEZOOQp7q2IAzesl9wF/uFPwHrBc/JFIp8CywMc+eMn/kTJRhNyUAu3e8CZjw8cIclNOQ4mmUjmLMra3El1n46m1CLQyZ9RTA29H9BCpPcpeXNX8zmZlt/m15WpYVjZACpqVeMpWlIPdFeUPZ0/je8XHJ8WVDfEWx9mDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574890; c=relaxed/simple;
	bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AIymQdVCOef436tBe8VlM/HvXHw3nuclBYeI/q+KrCdcMybrUS7YHIBSimytNpo73UoSEGL0otz7s3KNSnNTQDL9enbFAkNR/ViS0ZxZpBA29hrOzDg4dh+6eLY2Y0vj4lPFj/E/5OBkexjxgZVzA72AzmVn1y6JLQ+NsZJU/j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRmp+NzE; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-60579b9c066so1685140137.1
        for <linux-sctp@vger.kernel.org>; Tue, 07 Apr 2026 08:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775574887; cv=none;
        d=google.com; s=arc-20240605;
        b=RUAxXmdLs3ezQlj++siNXBBgSR2u6KtE8euR4I1WUOKaOFSt5CvNC6WSoAz11mT+LN
         KW+mSyJGj+u4v88LSTbAv5XVHmKCN7kLQV/iPtzebTHzaqmJEuVA6Ud4EKG3vfqIru7f
         gZX7n4hnnUn63+3g+uUC0PQ95ZL0z1q0SCB2EGkg94eYfRuQDgM3mFoSsMn+tLFsZlT1
         lXdEbFOkUKJ4C0wAIa8aSmUTXm1Oo23jKzRQgKbuqqQiLVIerUtOTzMTM1EIdvh/KdPe
         LEkEmMTgqj1qqYYTTgzGcmPEzw1kqtDLNENnd1qLdQ2hBMCMyo8zDYla2rNBy67QDZ4i
         8s+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        fh=/r56Mg2AKqzIqpEHWstB+afbU6gkkN7iUT7r2udeyXg=;
        b=F/cc+TYExnmWTACZImsz2L6p0l2jP7zFLihY9p9Ej6vymKmslRuLSDfaHg+hkoC8oe
         410dzMsB1IA9jTlyrzcH7ki/ofUhvha+PotikM/BhhoO1HpMxLFMEVl7PACMh7EkTf74
         mxeld/24FLxR6M/wkNIM2BXGzgjj8s7DSLjX3yMNFU5INdsylQEeDXbMlXHf6xFvMAS9
         wIsGX3bENNTtMjH97ur2TVNmSUCMYk8f1kORq8wC9gALH+1/POe+UFUc1IiWFWn80Fo9
         zZrFeo574pWDtyqUZqbck2WOkSTmOgKumSnxrIT+QnIU2WwwkG2rigNIDaiKitsIxKjT
         hhZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775574887; x=1776179687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=bRmp+NzEmiSpEU3/+BkVW49B+fOD00XhLtwdmd5ailgWxEW5PGQ2rW08zarHXY0y+Y
         Zplec1TcjY1Rhy37CPctH0D5FGvPX1N8P6tXvFr8TdpxKegiKiynq3mEpgb8WdwRug3T
         UeyLAnn/I0N2gUfWQJQ7j6WAfIh6QJSLcQtwRmxgGDmuxd3rolh+yebjZuH95SIReZ6j
         +pOKWqLbESKoUWfVnxZf6ypLf+RyKMvD6iAPH4lJXkojDb3tk1gyZ9alVYsfbZZpJ0Lj
         7wZXHS8wDlCYzuJk3EcQD9tV/mAZuOLmGvrvII0XgQqnMmup5/cYSh8luM+6dIaK8smL
         34XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775574887; x=1776179687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SVuB5w4S9g3i2LJVwtkxp4MFM2EaZ8x7Kf0aj1pairU=;
        b=mQIO24bctVEv8W//8y9PBhCLAA7nZA0ttmCI93NjGldVhCOREq2TImDAAv+aruAKiM
         29HMZL6KhSW75uDpIV2aykvqqoVqXvWoZNkr6ldfeXWctEbqNS5Hfu6R7m53i6PcWPFs
         8FDl76HaUINSx9v+aYKw0mMPxj/15PeDVYMgYnA8296eDCXNbzqkbKZhRabWvsHjTMz2
         6AXq4JO8TvfQAQaXFY2/6Jk4jZYhx5bi/DayVuH+GgYM8vAp6RehBSVcHW9u/Z7GAcj6
         gVyc+RjDtjuYdHIqTnsUllGDkHGktMttyYx2ONt9bjpueMRTqaa7GzmBz8z3nSEtF6Oi
         +GoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtth9OGgar+indQUjETF2C2JOhyo4OqNzzl3fWgEAtg9qcBouB6jRVR+EK7tbhfW1iGJyz9O3XU+rX@vger.kernel.org
X-Gm-Message-State: AOJu0YwaNHZ/RFlfgFoi78ObuJyx2WDq29c32OfT3hzdnJR04ISqi6il
	QMy4KvQ8GggadyAxIWMWIkvQ57T8UgFUn2+KT7DZEttQstCNhUDCZ7Ocjp1avdxvlwcE3luGyYo
	KxifLG4f8v8pANjkmRvmgM61o1YiPpQYSVkYvWwy/
X-Gm-Gg: AeBDietrWvD20BxI2jHYU4Csd7BroeaFkOlZJlhgRgCzgvX8PIG4Z6L3v7JX24qe0Ma
	UgZgixW0zHpRrvYChH6ijZ56n1UOI/0z87wq4DlRLPz7yMrcftHkVO2ZNZ/6wbjDeiUrSyeugpx
	AqTd+BBwYEnE+OQrEKtxvZ9hdaBdNHXUQr4sITnd/Ez26rlh5D+SWMjLtNRO6Sl3YtSzKXxP8IG
	Z7ZMg1aWgfKrZ/rlNnOos5A+yVgSwtZ1PwER1Xi9iRXl3ojPma6qkgGxABl4KjeEiafkjDWW4kZ
	19fySrrqI5rvBkokbA==
X-Received: by 2002:a05:6102:8555:20b0:607:97a9:e3e9 with SMTP id
 ada2fe7eead31-60797a9e882mr169043137.23.1775574886413; Tue, 07 Apr 2026
 08:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407150758.5889-1-devnexen@gmail.com>
In-Reply-To: <20260407150758.5889-1-devnexen@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Apr 2026 08:14:35 -0700
X-Gm-Features: AQROBzDVHNhmKDoXWfA937vlS7i5gl0nT_gzqkVTXTlHZU7d9eadHvamrDIvMqU
Message-ID: <CANn89iLweeu08XgFL345k1NVx56=u6RV_GqnfG2ArvLjUwktrA@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1164-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 985583B0D24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 7, 2026 at 8:08=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 (netdevsim) and __le64
> (ceph) fields where a direct assignment would trigger
> sparse endianness warnings.
>
> Signed-off-by: David Carlier <devnexen@gmail.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

