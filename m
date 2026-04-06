Return-Path: <linux-sctp+bounces-1161-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBC2ConD02mqlgcAu9opvQ
	(envelope-from <linux-sctp+bounces-1161-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Apr 2026 16:30:33 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C15453A4125
	for <lists+linux-sctp@lfdr.de>; Mon, 06 Apr 2026 16:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23461300D1F9
	for <lists+linux-sctp@lfdr.de>; Mon,  6 Apr 2026 14:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE30E3815CF;
	Mon,  6 Apr 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdGYgMut"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5888C3803F8
	for <linux-sctp@vger.kernel.org>; Mon,  6 Apr 2026 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485738; cv=pass; b=uTfYIIEPUBjiX8se/QDQFsYuo1Inx8rg+vb/Bm3Iu2zx6faM/t04MNH+4xVYjdZuLpLOcNx+x/68gI5nhUbxi2SHGjchVNb9gCdMSBaJOmFiZBd5bSrGw4wvJMshqx93XsAsmPYEGM5s1pHXmSWWOSAAyc3hl71ET5wo35QxsTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485738; c=relaxed/simple;
	bh=RN4e1YhDSg992awiDit4aQ/vN6UYLHpPa8oGR6pnBZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JR2KuvoaDp2QdfqbMn/c6ajdEh/wHGdZj3fbOrNFqpjwVl0l81owMsveBW/yb6dmxYWQaaKmHx6ZqiNwBR+HmHQTV8rEZxtzKIASQkX6hiUfvLG3OREbObmpTp48fdCLO5cLH4zGNOUnKCklruO7DktxpU3HC4HGXnIUYXNBONI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdGYgMut; arc=pass smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-685013eb590so739950eaf.1
        for <linux-sctp@vger.kernel.org>; Mon, 06 Apr 2026 07:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775485736; cv=none;
        d=google.com; s=arc-20240605;
        b=c9NXiJcNeynaQXCgZbcr8F51PkbRp+bkOv0lRmUN4yuGCY1OqhkHjNB51J6abWu63Z
         ajDY7eBl87x6yvWpMXD03TNpEgqQcHC6GWp3BQByy5li+RbBYQi4m0cNGZAEejCeCIdf
         4n+SxFCMvjJ0Bs9zQEBslSkh1WL2IwQsDSpWkgS+2DpiEyKI65aYH6OBf4YxgjCQL/Bj
         hXOTDjC0Cq1zEL2+DcC4WSzCbmcuQORvCelU8eZTQY3n//p29ZANIGNyEkGI0gz86LO6
         CqT0DetMC09gNzn1J0d17LQGozbb95N9YCC30CHHrV05ZIIqV3Ax7TdoQ94IKPjJlEYf
         9rRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        fh=hseoTL6ijnKrtwnK6UmEJyan8lvNI9Lx5bnO6EnW6hU=;
        b=XecWFRNbGVZMZ195m3kxApkhGHJ1PlBnvkbeiSdkZdJWU7AcqwZjPg1ReYMYa+EOLq
         BnWnGfX9gosnJ6epw8tp5jGA2wxk5UVeC9ekjazR37kjUUDZL+zHFzz6TFcg98+GH8PB
         +Oea3/4hTtMrnG0lm2acgDxIts8Ce/1uW3MsDheOQSuiiWY9LQ51hysMamrnLhIbWRtL
         Nmv3GlQrnwaJfmQY7ljScOHUHg48ghwq7k5aYyPXLYXAQ1Uqdq1zfDdLd+OZJZWGTDjW
         wOKOiKnRmyDvT+ZmaFYtblZaGrOhaHSIuoXtveuIA6KMqbWfWnMAjLLrrjDvD1+h9OyH
         oQ/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775485736; x=1776090536; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=XdGYgMutbu3g/mpl/gEpiXrNbPBDV+odsxZL3o8drZUGowzubMADFDSWIXewhj8sHn
         TzV7wY9DGFtzPMZBWkSShrjaDJ/PVYjJRAgXbf/EfCPXJE9BWekaR0/4xoS752TmjwHh
         i3gIgkN3ebcqUw53Cnptdd0imdbSFVFGjZiSNPxZQinfJFxklQEYB9zAAcZwTHh5/L2k
         gzATHJysj74KzKE6lXqI5o9ljoAZaRTfhYkfR+fhohpow5uoUp5OpATFZdp5HVzFFtql
         vr9ECIupiSBNvXPvvOcp3MVtHNMgmRv3cYGFhBItr3vzSj1n5CB6kp7fi8hgmPEHW1Kp
         uTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775485736; x=1776090536;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQmZeSWTgD6teuG9Cb0qg4wDQezIASQrTbGvcOITLWg=;
        b=d+uuPffACjHsFM6UzE/MDM9+/o/UDT2wQ9zMC6OjsjhClT/XVHBlXCrioE9/3ndEl4
         nrP4KDTE4S0+AEbBsJtKdcnTdKZRx8OwHHGlSaup4RdXQsXd49izTpwrB/HKmi/1A0oj
         snrKCJfS+JAvtSx1ki1R7+XJdCc0uOeuv2o1W3M5EuwGGqQ72gg5MFrjlWoLXnSMUvwO
         mGo9Wjcleh92+ft1TX7wZFYS8EOCOzJLG/cE4eJdbs7x7CEPoVbSqgiHOxzeROiP46J8
         yga8U1gDiVk4ygbjuIxz2Tkknt9jQF0AQqLhmlbIuV/ZvgRPKeeBdHrmOu0lGjN0AP2v
         du+g==
X-Forwarded-Encrypted: i=1; AJvYcCX7pDNSk1tpZQ/1uVN+NrT/N58j06zIZnuA9ApygEArNlfmhtNHuYfieVJqdjXF3EtU7iBWRnZnFvlW@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9L/Q3BjGeNvlYtfErMF35VWJGfYBb/4dT8nivkar8wSv/d/DR
	rVAzRXvxmKD7AXzs2TbAVBFlLvVOQiU+84Qxa+JAhJ8k7/2jsyq/lgnhBva+gzZyJdEdp19gN0j
	mKRNRtZ0a2OcAWBzsl2iWozuDkZO1bGE=
X-Gm-Gg: AeBDietIo6apkzc7qyjnv4l6gVb4GBT2uehS7D5N3cU6sJhZ7zyY1o02HgR0BVaYmic
	EOXdND3OwjymZj1BSHrxxb44wGTdbZOYMAt2QRrYEjGsdBPwWyUzRuO8R08ZU3l5lIKLUozrpNy
	okOKRLKt1KvWyxPi4PdZQYWSifaTBGApuHaNLDH6e7yWGQHgQ53NMaqGeDSfPzSZvltma9I2m1K
	ygeEVzf25i+8hmLZ7ofapQs/+0jvmC1mqiKKPWZW+t30mFrzC7r2JdYG9SwuQ/SGaK2fhea4sXD
	D2KWRvjTnpMP3LWHx6nG78iDqvyDxkre0n8Gzg==
X-Received: by 2002:a05:6820:8318:b0:683:6dbf:c6d4 with SMTP id
 006d021491bc7-6836dbfcb7bmr3030718eaf.22.1775485736189; Mon, 06 Apr 2026
 07:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com> <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
In-Reply-To: <268a9951-c1a6-4b24-8578-0a8bf4b957a3@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 6 Apr 2026 15:28:42 +0100
X-Gm-Features: AQROBzCw7pv9Q_nhcb2cp7aOThL8Ubn1v1x8P2vXHbgAOxV1wipCcpu51-53q2E
Message-ID: <CA+XhMqxNzaXZRd0co=_gaJsN4zS9L_4OVqhC174EPxA-pzEUgA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Aaron Conole <aconole@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, mptcp@lists.linux.dev, dev@openvswitch.org, 
	linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1161-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,linux-sctp@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C15453A4125
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Mathieu yes this is indeed a valid point, will address is for next
time. Cheers

On Mon, 6 Apr 2026 at 15:13, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi David,
>
> On 05/04/2026 17:48, David Carlier wrote:
> > Use the typed random integer helpers instead of
> > get_random_bytes() when filling a single integer variable.
> > The helpers return the value directly, require no pointer
> > or size argument, and better express intent.
>
> Regarding the modifications in net/mptcp, it looks good to me:
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org> # net/mptcp
>
> > Skipped sites writing into __be16 fields (netdevsim) where
> > a direct assignment would trigger sparse endianness warnings.
>
> Note that the AI reviews are mentioning that auth->client_challenge from
> net/ceph/auth_x.c is declared as __le64, and it might then also cause
> sparse warnings:
>
>   https://sashiko.dev/#/patchset/20260405154816.4774-1-devnexen%40gmail.com
>
>
> It looks like they are right:
>
>   $ make C=1 net/ceph/auth_x.o
>   net/ceph/auth_x.c:574:40: warning: incorrect type in assignment (different base types)
>   net/ceph/auth_x.c:574:40:    expected restricted __le64 [usertype] client_challenge
>   net/ceph/auth_x.c:574:40:    got unsigned long long
>
>
> Note that the Netdev CI currently doesn't check sparse warnings:
>
>   https://github.com/linux-netdev/nipa/issues/76
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

