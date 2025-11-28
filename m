Return-Path: <linux-sctp+bounces-752-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF2DC91F84
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Nov 2025 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C24E3AA92F
	for <lists+linux-sctp@lfdr.de>; Fri, 28 Nov 2025 12:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3DA30C372;
	Fri, 28 Nov 2025 12:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XaU4kG48"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC730B525
	for <linux-sctp@vger.kernel.org>; Fri, 28 Nov 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764332380; cv=none; b=uWffo+OpQGESEsbAMmk+0P1NtafliBZfhfX4P+RoIxzqsxH7/4NHfbGSdED4Tu7hT0wMqFXaGdlm6YuLIhiE1gUyQrHBpGij98AtbUwk6PCw5ZSbqD6AKxvc6L0gg6bo0JgnsFos0tWt0mYiNLynJK9vVawX7B/cSTpPDQEs/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764332380; c=relaxed/simple;
	bh=4riameGlM0ZpoM1sWTxRFAt04DG3mRNiEWeI7fAV0PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ho7CfMJV/vOQfftcjMvVR3+Y0KgAs9YC8kb87MPasMXDE6AvmZRnkPPjQhrN3iyw1GwYCXn169xPeS+WuvAro83g0u3runLFucv6HUEbr5xfvgzxlDSkzMsv+40+TjCrwrpNRvSUySDXduozZZGSBVk2BzyMR/j/t8oDA5u4/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XaU4kG48; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3437af8444cso2036476a91.2
        for <linux-sctp@vger.kernel.org>; Fri, 28 Nov 2025 04:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764332379; x=1764937179; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBheqsQQGxEUX96/r9+OVrqv02+hgTdT0dhM92aVvHs=;
        b=XaU4kG48kijokh5Xtq3ehqBwo41Frzu6oxoEtcuUcTAO/3LvYwX2sx+1i6gucr05BF
         pfRJWg5crMXPzzEBmAEhGl/IbnMt2bYUDNjxEe1gRS1J7EsCr1nuXmR/vrGl8c1zL6sN
         opTgxSN/JqBGijUkv7ogBe8OnfRRA60Bq1UjiytHkM5c7gsvgswYR7wKOWrbvntFSA6w
         CFFOVxXLLM9kpcs4NNr+NhF8KFRC99RMvmzNrxWw61+cgfvWuI9jagb9E0JXrxxUMO2V
         qqTQkFMuJsAECYVHsqnEb7PV5kZujTQOXCu+PXPa+ORnaAXOltnDfHHx+wgk1vkhc6p0
         Rc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764332379; x=1764937179;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBheqsQQGxEUX96/r9+OVrqv02+hgTdT0dhM92aVvHs=;
        b=chXmkcbaCRqJs09rZ0ABcYhuffiXDPSabbF2UC3U1vWl+67kPdcWsP8Wj8tkYO0nPB
         bDaNC+slI0/5dZ2G6sOXUxvdnCMUwAV9OM+tXqDLTsRlOqLy6y3V/qYVWxBCitlJe/fq
         WWJZYkhvRenm7EIio3U3GCk0umPkuKESG3V+AucM6GZEwg9LrqdI1GShcT5AosuFLaK4
         pjqegwp4aZfFUeLDkV8z6AcSthde4UVKUIuX5OZ55PN25WbyuG61rEACnoEM3EBuB2lB
         Uonem053rHzmfit7yY2THOgfow67awkEmzDWB61DyFHQ2zhDpJHTCTWAQ6X2DCYRNdw+
         rg+Q==
X-Gm-Message-State: AOJu0YwuSrNvWDgoLBiX4AMcBBTyKG6hDBDNu2bvxOIsLtE8/ACKfg5m
	tRcjwNnLYKCMaAAGdfXYFkLtzppot0y2hqQ9frqfwqDYqu7xs3q1vzlsewiUKrbH
X-Gm-Gg: ASbGncsaMvn+G4qN/nRwg8H7rnWBtvNQWB8myLmLPb7zkmnJGqBP8bRp1RbVgQ9SflN
	VcikTOvpMDAhKxKkqGs5PYu/voc2uuTgCtOCpaA5TNpCvBJ48bLExE5oUzfwE7iOG0BVQ/4A2Mq
	QKWNAZWYmaxOimPF7qQnM99XfT4WuiC1MCvQL6mhlA0ge1OP6EjRb0gt1nnsWAKdnIMpURAYY0V
	FDj4Ph2O1cCMmYvyInds769AQRmZZZKpKI1Z2okCyxAruBxsgv4e2ibIovGYKQ4FYZ30Rxlye6+
	MmUvQhjVMs7Xv2VPy0/DBDNIXwXmS/K1FgCiB2R1PC6K5KQCfDyniWxCN0+jSWGQ3ptnNMtbC09
	BIjdLIewCjZcuVENojVtnbB4dUco+U3latOHAQd36+czqipEfzrs0p1AN3atpqg2rczm2JCQlM5
	rGOxX7EtM6yylxW/5R3I59TORqKA==
X-Google-Smtp-Source: AGHT+IE/6aWO2o21z/VFRM3xGQq7lYJ9NyTRBe+r2wP2/uAEeYEg2JmgdhUCTWIETUrX+Oy53ZxG5g==
X-Received: by 2002:a05:7022:4293:b0:11b:7f9a:9f00 with SMTP id a92af1059eb24-11c9d6128f8mr22525687c88.4.1764332378594;
        Fri, 28 Nov 2025 04:19:38 -0800 (PST)
Received: from t14s.localdomain ([177.37.142.105])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcb03cc7dsm18754907c88.5.2025.11.28.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 04:19:38 -0800 (PST)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id F3D0912A9BCD; Fri, 28 Nov 2025 09:19:35 -0300 (-03)
Date: Fri, 28 Nov 2025 09:19:35 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-sctp@vger.kernel.org
Subject: Re: sctp on RHEL9
Message-ID: <aSmTVy97eHmx9GJT@t14s.localdomain>
References: <20251118230743.5a862e9a@pumpkin>
 <pzrmyhcns6wwyiouqashxwryeakcajvxaqwyr7vl2vxvcwkzi4@eltvekq6ok6n>
 <20251128115926.77d8b5a5@pumpkin>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128115926.77d8b5a5@pumpkin>

On Fri, Nov 28, 2025 at 11:59:26AM +0000, David Laight wrote:
> On Fri, 28 Nov 2025 08:45:52 -0300
> Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> 
> > On Tue, Nov 18, 2025 at 11:07:43PM +0000, David Laight wrote:
> > > A bit of a gamble...
> > > 
> > > Anyone any idea why RHEL9 should reject sctp setsockopt() calls like SCTP_INITMSG?  
> > 
> > More likely an invalid buffer as argument. It has to have the exact
> > size of struct sctp_initmsg, and not more than that.
> 
> It was resolved.
> Basically the code is an out of tree driver and they were using an old version
> that calls kernel_setsockopt().
> That was removed from the kernel well before the one RHEL9 is based on, so we'd
> expected they get a build error (the driver usually runs if it builds).
> But it seems RHEL9 has a wrapper for kernel_setsockopt() that doesn't actually work.
> The later driver has its own correct wrapper and worked fine.

Ah ok. kABI can play some tricks, but yeah, this one seems off.

  Marcelo

