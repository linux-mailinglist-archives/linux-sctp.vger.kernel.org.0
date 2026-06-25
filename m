Return-Path: <linux-sctp+bounces-1295-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +m63ORhwPWqg3AgAu9opvQ
	(envelope-from <linux-sctp+bounces-1295-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 20:14:48 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 881196C81F3
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 20:14:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=YsH+TheN;
	spf=pass (mail.lfdr.de: domain of "linux-sctp+bounces-1295-lists+linux-sctp=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-sctp+bounces-1295-lists+linux-sctp=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D190F301AB9A
	for <lists+linux-sctp@lfdr.de>; Thu, 25 Jun 2026 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE6630C345;
	Thu, 25 Jun 2026 18:14:45 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07D30D3FA
	for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 18:14:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782411285; cv=pass; b=LoHMdufAeISeynf8+nmMIAdT/7iYUb6dYgao5cFbXA9dKPV1eeEGN/dn/DOEKpEXH3xx0wAyj8VUTJMPd/JfoNSGaOlep7GOHo+ULXOtR01a9CgW7q53gFAs5iRu03gilHDj4E4FZr1b7NNkTRMhEHlG1FGVHKBGrEzkFpQNrnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782411285; c=relaxed/simple;
	bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2oFCIdnPi0PZl/jvAqDlLA4q4MJrgqFvEDnk1PFLteNcWQ1PIJ9a2/jmDmC9/URMEF04i2m+Z3I2zNZSFI73EkP4TzKTst1PRjo11IZCvF0QWugV6UzEO2zwjgH/xSxK3N9tqbTIuQYz2zapXbDjiw5L+jdBwn8qByKZ0fNmy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsH+TheN; arc=pass smtp.client-ip=209.85.128.177
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-807bf286000so2449767b3.0
        for <linux-sctp@vger.kernel.org>; Thu, 25 Jun 2026 11:14:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782411284; cv=none;
        d=google.com; s=arc-20260327;
        b=ieH0Lwqu/4aBA5LVjJi+zH9K2gIzLjYuNAOGBbx2kJv80wXQJwzeaSFS+UljUNYeYM
         ACAqxd/5jBqeuxvIas1phT2cn/AFQttaOfgkd39V+J75DgDZJsZYiVf3V0kycQ2n0EN6
         UCzWvZp5pVJLf6wfWSjExUrnfHZdAqr9/RGonAKTdWVKvgMISClANvtXn37QZ1TouCwE
         c1BUQfmTUVN8eGst7z/bMP6yJwHkdEJ/gEEgcvpsjHycmMagnLkWiNl2dnOocfOIdwpF
         7SzEnj80GVsHkZO10udl2yYtEZZExgziBjhAeyBapAjcTlT7hjg6M9z6UmDzaFEo6yOu
         uA2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
        fh=2enDHGiiIO54vU+VEI/ha9tcdAV0gQdt/p2JmOvjnCc=;
        b=YxkW2WHWXqzsNSu9vSGu2OZ2sF/153ZzTkCaNOKhbmewoCyIEvDw0OrUR+8Zjdbxyi
         IfPsYO5xVNbDsWThj82WviPhZFUO/jnDA0dMPEw318pZiQwxlCbM0vB1BY1jOSV3sa2m
         Gbp0wj2kbl7Ds8Q6a+MvUIYz197SN98q2jQV1QNyhQushOu9QC12RrHMT4rnvUmOgJKE
         BLLQUAcpx9aC9AD+gs90b+/prhqFikY/Ti5HHKWq+x0i+udLGOO4i7F0UddaC8EuFbiW
         6UaRPh/K4gnsjUYNr2BuB85vBxfEacflYQsPZRE+2ZsdxGJnIQC13F1hYBf6SYag2evW
         ggZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782411284; x=1783016084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
        b=YsH+TheNLALnL5HxS0Tl3CZNjq8wRWX7pDBCY/7sCkdb2Q/uhULcSAhAv84byNb53R
         WVwpRf8moTZbxckCvWhwAnxbVqU0W9uIWlbqtZKGs1qgA8NYgQq9T9Z7NrK3eRnuFWXQ
         t+/Kh9YgdIqoULm3IC0rR1+AHsE3dAM0Dvkc5Zo4wcwKLH/jDhCk7t59dBUxS4Iq83u/
         CBnsjH2u1JNH3kaAiqIBAG27Q/5YxGnfJiq56oOx1383wwd5rjhbwCHDWW8Pz2BzfT27
         PnACWwqfF+mgA0NKDrz/UT55Yvg+Sjp1zxLype1S7+PeOkKVRMdTxBnF8ccMjZshZ7uo
         0nwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782411284; x=1783016084;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVvC8tioRfUEz/xKMXsRxhh/qnijwu+qPvK3gJ5YWJ0=;
        b=ph33EVI8HOzP2iFGRhPJ2nMTKGW7w49xULwuCx052jgAskNPRgCrZ6qi6+h7MEMYZF
         xyrOsV3tYIJ0X6jaWUQ26cznfBZa96uuKeYQJEKRwkxZuTjOq8MTS6lmsqo3WRR7/rIq
         ffMvyUbOm/6SJlPWWkvP/oEiAM7ydNSDl9a7EK0goT2i47aMOhPgbtWN3Xs8pxjAgh7y
         Q1dPXKtq4p1cmFI0fRMgej5upqqI5ElQb9QXQUbctVn1enm02A16v5SL3rN6AZBsNLyt
         0kiRE0WqN831Lb1q6fb7aRF4gHX6Yi7UB3u2zk8ehVWgm8eJG0kXyWWEOdTVLy/CPCLg
         +Kmg==
X-Forwarded-Encrypted: i=1; AHgh+RqraEapG788DXUVi4Ww7zZQb1z9jB5XaBLNloo/+bzBUizdOZFqJL4XU5ETjRtQuGSjyQlXUg2e/mkK@vger.kernel.org
X-Gm-Message-State: AOJu0YzBSmcPi0tQmkv0D9dN158lGv9R/2KSuOpYe8F458INfIzIf5AO
	Bf3EnRWJ5WJnVywSEU+EqFdhKfsblavefMq1od1HPpSMRVFxH02CLv/XQ3B/haNiRKMsH72nYtF
	mVxK5iiLJc/n9rP3sU9UISV98QFc5stQ=
X-Gm-Gg: AfdE7ck1t3LWxdXQbFjDUDVYVarEtYX/pZKu8Jr5+mnjlnETTkeiUApQ8TTSJPPxzgq
	kea7GGGIp9E12BeLSctBZoDCeG4H8nLiVuunfEL7T1y3xQTiSqnNOxzQ2OKpqJFkpTdz2V7CFfx
	IIqrEVSn1CsOkx7CUK2zNdYy7aH6t6/Q+uU927kLqaZM6iB38xdYAKdHPo7ZRWVdPovCm8qPcpA
	pO1ZHfG+JB1ZsBYtu3tkY0mMgFkxua/aj5JOamCMxzyvRIBdYCM6fBogWg2C12FPfAWuhDXQw==
X-Received: by 2002:a05:690c:e692:10b0:80a:9ff6:c43 with SMTP id
 00721157ae682-80a9ff61205mr25153867b3.55.1782411283461; Thu, 25 Jun 2026
 11:14:43 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 11:14:42 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 25 Jun 2026 11:14:42 -0700
In-Reply-To: <20260625081916.77a017f3@kernel.org>
References: <20260625142354.2600-1-alhouseenyousef@gmail.com> <20260625081916.77a017f3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Thu, 25 Jun 2026 11:14:42 -0700
X-Gm-Features: AVVi8CeRpgsX-IM0rJirJ8x3XArWsDsSY-_wBW5Xm7mk9ypUTgRjoBRQZ1o7Vu0
Message-ID: <CAMuQ4bVM83fGeSRCz0hoB65mjSs204VkDbiojDHn+7ui3Z1qEg@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix SCTP_RESET_STREAMS stream list length limit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-1295-lists,linux-sctp=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:marcelo.leitner@gmail.com,m:lucien.xin@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-sctp@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marceloleitner@gmail.com,m:lucienxin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[alhouseenyousef@gmail.com,linux-sctp@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alhouseenyousef@gmail.com,linux-sctp@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 881196C81F3

Hi Jakub,

Understood, sorry for the extra mail. I will avoid reposting
networking patches only to add tags.

Thanks,
Yousef

On Thu, 25 Jun 2026 08:19:16 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 25 Jun 2026 16:23:54 +0200 Yousef Alhouseen wrote:
> > Changes in v2:
> > - Add Fixes and Acked-by tags from Xin Long.
> > - v1: https://lore.kernel.org/r/20260624122213.4052-1-alhouseenyousef@gmail.com
>
> You don't have to repost patches for networking just to add tags :/

