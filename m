Return-Path: <linux-sctp+bounces-1099-lists+linux-sctp=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-sctp@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCkkM79rsWkuvAIAu9opvQ
	(envelope-from <linux-sctp+bounces-1099-lists+linux-sctp=lfdr.de@vger.kernel.org>)
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 14:18:55 +0100
X-Original-To: lists+linux-sctp@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 369F52644ED
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 14:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75F4630677B8
	for <lists+linux-sctp@lfdr.de>; Wed, 11 Mar 2026 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDC830ACF2;
	Wed, 11 Mar 2026 13:16:10 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD92FD7BE
	for <linux-sctp@vger.kernel.org>; Wed, 11 Mar 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234970; cv=none; b=DwgHK3mfjNCFbcYMA8HPZ+vjA/0gvgkpRrP7uW5zTc7xJE7APp71LbAb6Pl0ODvnCFbSqIxhlNEVcvS8EE3S/aCnmSpGsMEuv478DI1mKGvNNtsTdXO/3PlD2U5eXsbDiBq3as52ighIIPAomiFvhKqYcBPPzOA2qn1t5r2KzVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234970; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3GqgHlVDsOI44E0xyJcc+Vb68QWR9+I3wYlFBEqyzhegUkLdRdHudPBcHfyfiOgiagfLrp7qHqgseRQEI9HMuUWfRQoyzlUB7IzZSIYCWKkrumLPs90RzxfsuOlUPSYpot0ruAJgbMGP8AhNS2DwJGjnb6J91wXG0PCeVRe/uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-94acb3d6cceso7777834241.2
        for <linux-sctp@vger.kernel.org>; Wed, 11 Mar 2026 06:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234968; x=1773839768;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=RBGHLRMgSy8ZGaKNO3jd7UiBZxi35XEBrjLccKacX6OWQSQQy56aLsjgIRhd/2mmUk
         3XBcFmq+JfsogZYBG5O/OO7MuJZEhcHnuKzCqSDQrwRQOVhAVEFejzU4YnDjvtFKbTTa
         1pU3ldP/QbRbRXvXT3ivCKlkENAEdPA+pCO7nhQ3QxEZ8os+ap+SVDTf5r/3Fyjb4/i+
         g6Rg76xFngrsyMDHyt7M4NymSgV0ooR7nKsGI10JL41NE+9m2hBc3ID7BR+hwhWLu7v+
         wL6+jqOagXr29X5jrrA3fwrKOUUYor54TBJv6tMDYxs/UBaGW/wpZtC7y76oJyaIQfz1
         dRog==
X-Forwarded-Encrypted: i=1; AJvYcCXKMWkaTSty+gSGspBCIRSoFnatzn8/p7K6kbeWX9jBqHDH8n9h6YL5UW8l7qejeSgHTMLfSYYusVLn@vger.kernel.org
X-Gm-Message-State: AOJu0YxRJNUeWo4XPIHwIA1bBThFf4t6hwUXNmh1Uq892JE1sUTAQKIo
	e0WcaS2oPjvfVwYTCCaW5zPET8IE4mLUSOju9AlZS1dIXsb8GdICp91QgKwFuKLxJBo=
X-Gm-Gg: ATEYQzzMz7L0J8nbCyVIXVs7sNrsYdyuW2IRvnRvzPWSpTFp7W1jt+dT0kVBsl5v4rp
	pR9bT5mNNjXrfrd/u5sszfE3WzihMHduqJrCrvZW4l2aPuTXYjSO4d2iTPYxe3CPbtlveX/xm28
	DrTZMuNFa7rjqOEjgHsdS+mzLxeBbGTH1AtOp99apI26w/258/sjTlSBeWwyZJpZ1+/ccstNvoQ
	OdrdOtcDo9j4Izr97PUtDOozkC/oJSguzHGD70LVohLsMpNplSHMIy3G8vDIcWN6n6ksnf3REib
	zAhS0FMRzheDwGxRFET8jh8x/k4xjxU5ibeZxlBwl+5OMBxwhbRAGqqJx3ydEjkz7HSA9yKlWn5
	8yDJtshxDNuK0oFQpxFjsb9EULjOb6d0t2USkr4eHvoow5Y2/KUk5oZPrlH8tJopyzYsP+3+mtc
	TyTGPdsGhnANeyy+xlyO3b6HuNzg6qnI6d0DXKa0yaBYmc5qHiiTHfuXF0mls0zaqv
X-Received: by 2002:a05:6102:54a4:b0:5fd:8175:2eb7 with SMTP id ada2fe7eead31-601df00b047mr1110542137.34.1773234968408;
        Wed, 11 Mar 2026 06:16:08 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-601dea9f6ecsm685193137.10.2026.03.11.06.16.07
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56739adfa1aso10524044e0c.0
        for <linux-sctp@vger.kernel.org>; Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBI8wrBlC/mLD924TDEtVpEXATrovQph7JtjDT2BMts3fz5TpnFI0NLZLsL1u4RsgmxOtSPnXkBrD9@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 369F52644ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-1099-lists,linux-sctp=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-sctp];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-sctp@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,avm.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,libc.org:email,glider.be:email,fu-berlin.de:email]
X-Rspamd-Action: no action

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

