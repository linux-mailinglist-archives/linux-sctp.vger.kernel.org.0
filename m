Return-Path: <linux-sctp+bounces-1162-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KoBMMAdf1Gm6tQcAu9opvQ
	(envelope-from <linux-sctp+bounces-1162-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Tue, 07 Apr 2026 03:33:59 +0200
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBF23A8B8A
	for <lists+linux-sctp@lfdr.de>; Tue, 07 Apr 2026 03:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71144300F5E4
	for <lists+linux-sctp@lfdr.de>; Tue,  7 Apr 2026 01:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D5D1EA7CE;
	Tue,  7 Apr 2026 01:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzSFHsS2"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E83219995E
	for <linux-sctp@vger.kernel.org>; Tue,  7 Apr 2026 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775525635; cv=pass; b=MGx/k4r7CFv9G7l6SwPePPYUpdActeV3zv3dNDfmXFILGTvVVY2WNyDRESx73gPO1YvhmGJI3tf3ufoz+4QAmdPFSS5ybbY7nwZ6xIBSlX1bQIZNcWSYey3ITH9vGoU1TOkLy2iAxrsMNvt/XR7QK0YoitLylkpw6WUmFSw0U0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775525635; c=relaxed/simple;
	bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyhtLqZtsrqVUwS3IXSCONJDBf6wSJgyidFxmIC6e+szyNIaUQm2jQE+76LsQ6w9O1yh7rzOtenGt6v1LO86mCq3ERBuWtYM2s5QIlxOcYTna3d2Xy/S0PmOagrdmFlFLUxdgL0ihn9re+1fELVtREA5/UAZQrVizowRHcHkyXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzSFHsS2; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-89f87257904so40619086d6.1
        for <linux-sctp@vger.kernel.org>; Mon, 06 Apr 2026 18:33:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775525634; cv=none;
        d=google.com; s=arc-20240605;
        b=at6PN+FbC3RSEsmHb5uXkgzhVuWv/onCm94KivQrEzBuIO8W+PE0UU8rmlAr/aW0aR
         /6QvaXq7APZAMwj2Efa0dNHcSvJyBhVgQDJ98Fd3Y4DTUIciHCr0mVv+G8/tXVhDWPQv
         k6zFo4v3fnhkqksDtfdnNokmBychvUsYdmXZLeZAYZOCXDkEyWg+zRPjppseqaBt9XfP
         KpvnJF+uUfaM+Jzs3hA8oFV4E3P0vYJ7i2DLHfgFAeTO0XzKgaRLGk1ctOfaLeKLMBJY
         woNxSasUr7uZ0ouJPMvZKVLX3WfKkMBUzJQBUwwNy8yCum3vaUnq1EIWeRvi5QtytaQ/
         kI0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        fh=HBNVpiw3LHkJUAo5L9QRTQBkXTTJyr07RyK2VYiPaTs=;
        b=AZlAKMH9Q4ahsCxVF+8FNh71ZO0D6087QIEUu7N/AIQtHcN5rchtdUcoBlcxL+iRH1
         /82fFj9i+JhiY0mC9E7upQkc3mJcZWQd98vqkx1fds+4x2qDA1M9SC5EElhpoeg/R2Fn
         QobroJE7gdlnDgbqkAFH/JmJK61bKz41rf1jnXxI8kJVrSIVd/1CwMPtEXhJn/KFRER8
         VjOeRwj7TnSjRb6R0mZXGoYKaYcl7JlILOhfCLc82KZjbU5O+jkb2QPJhZagYumwK9cu
         CxSFLqLARyNsrVeclXClkRBa6BN0mH/DucxCAufWIn31qReZbTCqG847+QX0HHSVf5IA
         78QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775525634; x=1776130434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=gzSFHsS2+LSeEfAyisIiX+v7cGWf53UuxRdlaOdcV+g/gWJY3b7CpLck+aVvS3y5p2
         NP7AnnxXF1/JBg2rEaikZztKBvrGJtbm8oCzR8BcUR9jybpb6iMZVY0pwx1/GoKjfcMa
         yjRNc4FCItEziHOJI8F45l96CuR/3F84lWQDLSPndT0mOzA0kcty+vnejz8cZIKqIWCO
         M30N7623h1KWMOFYPj7KJCpT+K8U3/PY0g0fB1P3WUk80qoyY6Z3Lzgzt4MVzTDkuSiA
         ugvGFaqFJAbjvexFq04TTrMslgppALp/o54V4kWX0UFe1+BKPQTCvRZqyikgtlMy/7lo
         8r8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775525634; x=1776130434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0LoEFDakMTPfi/BP2bcz4FMwGYT8QVcG3BuR0hJpVA=;
        b=p8krxiyID6XzfdZM3Mmzl/TuVoR3yTp8tETHIZPBp2YPzwKuwxOJxglu2olQiFsl1i
         GZeQSAP0SkurxhdDNNE1OuazVE1MFbf/Mv8jixK9O36bu4I0Gf6lnL7ONDQrS7A2/GUp
         i6ipeF5pFCrl9S6pL2qImgCv8cNr+IZIMIcoPFe/7lggNLI+/XXEh8pIyFcG/B7PqT9E
         J73NsGbDb/8Hy08xfD2CSyKWUIBEb8mPfR5CpOeDND3/rQ0phI/s6oqoh+azI5/zPHWl
         mKejM9BWgw4mjNh1H9YCICBA8Xf4wMieSkHtyojQ5rYUzkJlorTgfl+QGq6bd44MWQ35
         pXfw==
X-Forwarded-Encrypted: i=1; AJvYcCVVSrAVtkYAJT2P5Di3xvgUaCjclTnAqUqgXj3CyNSD88uZNthbRiQqGrxdWb7E/pRG9Mg21lsJPuBb@vger.kernel.org
X-Gm-Message-State: AOJu0YzfIxfDNLHzz7RHRywkKDt+8vBl5ErMUJ8wRam2tRyx1dYuZI/L
	tzo4RZM4QMkoEaex8ol8O7QtiztNZkjxwgpTckHrmW/cvPgozceMfj1p2P+CibRp0F3Q7bYeRzy
	w01nRl3cs1mUH3iPZ1Hk1Deu21BDRB58=
X-Gm-Gg: AeBDieu7AgR7pTWoSeIEAMfYLwfmuyldtmqDBiyYIrhEUDkTBxeHuA7eOgO3UEK6ERr
	xZDnsBJ3zp1ZEno/evhTpESRwBGezph95aKJmRMwvtKVXAo+zYq3aIIJaeVabwHJOKnxNqGqiN0
	0SYKH3bbu7w+CfID8o9MYc6iQJxgnF1J94daNtr8U8zHFs096PeALD/wqH3kdPYAGasXBaRSYwd
	45TWaf7wNGtW2WEbnHr1E+OV0oGR3UVRxTc9N+mcksp6m+P1P8rFzPwz6iyOTs7JhqKLB4AfTcB
	LPAWdTGTcnKZbv5bFHw+
X-Received: by 2002:a05:6214:212b:b0:89c:5110:751a with SMTP id
 6a1803df08f44-8a704ac00f3mr250748606d6.44.1775525633467; Mon, 06 Apr 2026
 18:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405154816.4774-1-devnexen@gmail.com>
In-Reply-To: <20260405154816.4774-1-devnexen@gmail.com>
From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 7 Apr 2026 11:33:40 +1000
X-Gm-Features: AQROBzCkX2gE2vUcwz9Vh41Dy86vV6V6vedD5cjTTBBq9Q2y1TRb7sq-3zFQtYQ
Message-ID: <CAGRGNgUpknQi6PzBWQXeAP0Vh7XjntD_-O4QyjU5tAn8_71=eQ@mail.gmail.com>
Subject: Re: [PATCH v3 net-next] net: use get_random_u{16,32,64}() where appropriate
To: David Carlier <devnexen@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Aaron Conole <aconole@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>, Jon Maloy <jmaloy@redhat.com>, netdev@vger.kernel.org, 
	ceph-devel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	mptcp@lists.linux.dev, dev@openvswitch.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-1162-lists,linux-sctp=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juliancalaby@gmail.com,linux-sctp@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,gmail.com,sipsolutions.net,ovn.org,vger.kernel.org,lists.linux.dev,openvswitch.org,lists.sourceforge.net];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-sctp,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1FBF23A8B8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David,

On Mon, Apr 6, 2026 at 1:50=E2=80=AFAM David Carlier <devnexen@gmail.com> w=
rote:
>
> Use the typed random integer helpers instead of
> get_random_bytes() when filling a single integer variable.
> The helpers return the value directly, require no pointer
> or size argument, and better express intent.
>
> Skipped sites writing into __be16 fields (netdevsim) where
> a direct assignment would trigger sparse endianness warnings.

I don't believe that endian swapping significantly affects the
randomness of the data returned, so either:

1. Do something to silence sparse (casts?)
2. Live with the endian swap overhead if they're not in the hot path.

Other than that,

Reviewed-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

