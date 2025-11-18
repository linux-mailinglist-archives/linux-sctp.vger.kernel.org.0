Return-Path: <linux-sctp+bounces-746-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A7C6BF2F
	for <lists+linux-sctp@lfdr.de>; Wed, 19 Nov 2025 00:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8753F35CFD4
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Nov 2025 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305B1EFF8D;
	Tue, 18 Nov 2025 23:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XC3COhHJ"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738241A0B15
	for <linux-sctp@vger.kernel.org>; Tue, 18 Nov 2025 23:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763507268; cv=none; b=UrAn6DFf58cnmxg0Fg2BgLNRVWDILaULltDINaUorQJEBwfRpy82KBHJptqAEulWq4agAPkMuuF/WfjxegDdHUKFdrNphK9U+C/+rWWOAElu8SWX+T0JM0qFkykBJyYYPc8Au+tgunNsf+kxjakIsmV7mD6aYDjNvf5euaXI2PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763507268; c=relaxed/simple;
	bh=q2X5fQymA6EO+5qCqRALZP+wK0+T68WCX6fc62Dk3b8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=OmvRaF917a8zyXffNn8EopI96KFGZ0NfZc3fq3lsmWo9QKAbgsp/CN8ybp+2Ss8UOecnVU8cxzUNacMy88gANQE7VlRF90+1AbPrggYbcksmJlolAPogHMMIXiThvzW3bJakULGrO+uYDHDk4Jm9vL5S3Lab1urrVbA2yJfRk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XC3COhHJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-477632b0621so40122045e9.2
        for <linux-sctp@vger.kernel.org>; Tue, 18 Nov 2025 15:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763507265; x=1764112065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ksFmeqyu8C5rdHzmmJq3w1c1/2/t/7WSrGeMx9KcR0A=;
        b=XC3COhHJewOONWC/qhy/3f6H6HPdj3nDLT/M/iJWm6wI+e8mVEakwbwfGwGYKW8X/p
         qYGyxn4HIjGv7KHgwseAbBTfsx7kzKc7I1phGt2yNAb9Y03nf1k6rvEy92FhVkjNkbgG
         OXlF58dYvHvbK7vk4qftA5HpHomLr4XguJTXmbMCFOuj27ClIiG63qf7LoMkSp8kTrpC
         /JhVcFh+je1Jl/dJamzcinXZBCeKtluFFMwC1MNoRQSihGvB+gyEA0WTnH1UO/ZNRy27
         PqIP8SBvU1mp1LP1C9WFzfZykaHyg0EF9J+wSZ1mNysXP4hnYfk78lhyOX+Wic73u81t
         wULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763507265; x=1764112065;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ksFmeqyu8C5rdHzmmJq3w1c1/2/t/7WSrGeMx9KcR0A=;
        b=uT3AxY52tCxO+9VplULU5spEhxDhThJ8QKGSZpfw8tZ/OkH2s55e3gducTywenTZu6
         f2z9CEQB7zu+NLRK4g0yyntYEtk+SO70UlxE0xQzf8W/6smrmUPILIm4p3yCjfGzczzZ
         klc+/lti3n2L5aoxZUfYoC0JZgw6GsOppeBUad63i++rUmmjqjdpgMKDJLcM1iRAnKyP
         zXbw+voVxRkbd2GgV9jk/5Z/wZRY8PdCNu6hTnLEaNKV36G4RQ07vzZ8B6EEadR7ZJjZ
         5BlSMvSWRaW23TaYoUeIUF9PDWTVr72GR+9EBtRwWq7KyM6qPqhtfFvXP4m6N1ecAAZs
         pMWw==
X-Gm-Message-State: AOJu0YyuA4iUy4f7+Uii99/HIDPm5k5/Mudy/IYfJKGhwtec+qqkywl6
	fC80Miqc1EXKBad/h8/2l4tf9cl0pIJTHt+loD3AOd9oUSXv4df4/7pz3MdjNA==
X-Gm-Gg: ASbGncvTEE8VzfViocRdFQ3xZcJ2JXWPMurRzI/gC9BZ0pO3ZxHypiIrZlre6w51Gaa
	tfIWHjsER9IKhOexb9s6K0ntjoCcw2YWCzABKn8hb+SzDj8maFxNNpU0xzbIZq6b24SdsM2j98y
	ha4js1HjvMZJ/x90xfvd3DcZYb1ns2/bozTtdtzIiFerPNN3/XsJbTyTZHuLaS6GTMaq7hQQXWl
	FLKca83Hma5ouwTPhSxzdjpre8YNTCi6Iku3PzVGjT0gNefUWSC2Nws+s3oVyLxJtMAEBn0SRO0
	dPD8n/F87d+ybvb255K7OoC8SXbeKO/XhyYfHjsWwgzH0k7QfebIUke9Ib2iTHdtLrcq/WjoCQ9
	tzzr/uHuTWa3phykXMS0GNBFMXb81uVP5WPIQ7a4aUkD2Sk6XPvhAmBtlEpiJ/W+Juqgz3o9T0e
	ZzROnISF/qV+rbvaU78s6VPsbnklNzwhPIK5L5qFL62apV6qYhJeDGHlvQ09LrUmg=
X-Google-Smtp-Source: AGHT+IH3u2Hh0Q500irAE7p2FhXOoKcFnWHPv5JZqEHtw/BZxIJtdeZXG9SVZ9EsICtAjVmhDVXBcA==
X-Received: by 2002:a05:600c:45d4:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-4778fe5dde3mr224690665e9.16.1763507264744;
        Tue, 18 Nov 2025 15:07:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b103db28sm16733105e9.14.2025.11.18.15.07.44
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 15:07:44 -0800 (PST)
Date: Tue, 18 Nov 2025 23:07:43 +0000
From: David Laight <david.laight.linux@gmail.com>
To: <linux-sctp@vger.kernel.org>
Subject: sctp on RHEL9
Message-ID: <20251118230743.5a862e9a@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

A bit of a gamble...

Anyone any idea why RHEL9 should reject sctp setsockopt() calls like SCTP_INITMSG?

My guess is some security check that doesn't allow for sctp.

I don't have access to the failing system - it is a customer of the company
I used to work for.

	David

