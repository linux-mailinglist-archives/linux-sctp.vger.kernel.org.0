Return-Path: <linux-sctp+bounces-431-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC83A70BC0
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Mar 2025 21:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648E03B5F08
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Mar 2025 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA672253B75;
	Tue, 25 Mar 2025 20:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BwBX/r7L"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC3213D531
	for <linux-sctp@vger.kernel.org>; Tue, 25 Mar 2025 20:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742935718; cv=none; b=hw4igg6xR7Onw9w22q+QjW6RylHXCkWGoAP0bawOeJwBkJvVNwn0trolVgKf+3S1y/p+F0VG0LFtJGytZHKLvRaK/838C7WqVqu3Dimn8wIhB58RVwk/VBhn1PmFVemOAY1YWLd0IE04ix56l4/xzZuvkdVQ5yvQZYvYwR1GHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742935718; c=relaxed/simple;
	bh=GCAhGVtueceq1ubCUXU7aIifbCxnCpAKEuI8oUAtt/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4C3C/L20TB+O0CPu5an0otM11FIjOSbGCSfZKheMQF0ilmWYYAT9rcz50659HjqGheenHdMkwxVZ9XH8hchnYrB2QvzHevQHWTZp8b8UsqvK3act7bUVPl6DWIlH9Jf6tIrMB6E/k3Q1BmlD3vNIKiK4saT/UL5oAyUClKuYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BwBX/r7L; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54996d30bfbso5658836e87.2
        for <linux-sctp@vger.kernel.org>; Tue, 25 Mar 2025 13:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1742935714; x=1743540514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=BwBX/r7LRw+JdMBbO3yZjl5TdJAnDHrAjHicGjSO7RNOcYcDi6epUg7RSNdGlp7az8
         EHj727W3dV/E/sau0vc9nREr7QYHN4mTrgtWDd/DYTThVcbAcCEkqXB7wWXLnkzMENOP
         mpQlaiX6y91Lv+N12eR553BtUUQsHjG63wjsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742935714; x=1743540514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K52xAWNW5IEkY2W6yv56tbrXz/O78EY3OFwe6Kmcp1A=;
        b=QQpwUyST8ftxqVq1Bt3DNih7MrWzDbCryxJCcXsl5ba8ZXFAe2YqbMpOhdsUYdQ2cp
         LW9uuH65OfxXClbYnHhu+TkI+DYVqU5P/+/pj61osXlE0eajaZ4vSS2pkPtkGJ208sTx
         geaiM/ylF77pQx9+p+iPLurbJNnJnjLNRH4P8XTYi+0X/k0wmBFn3gAAXDTU/xYYtkuh
         lH4asjcTzWBMaXXf3kLdF+HoStzUxsz2fpo+RJkxC4G4cWB/H+P6a03TeQTabgmaPRrM
         6OOtzKd3dQJkxvtU2ayKaPYquONtyeIVvyNYN09HLa+pZD+8wRrhVbOqUi9zSaanPL4n
         c2ew==
X-Forwarded-Encrypted: i=1; AJvYcCUgKrkoXuE0qNUyZ1Q8yyeJQWWkH9CoqyTTb7ZTbD6w28mg6DlMCk6V6ru4T65zKxv/JYQTitUGLad6@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+8JGkaCECyn7sJoOfQBGuveidIFatjgsCSfc9hw8ZRVfBVSI
	/83E1VFSIt74OzmC6qibZRaJLa0phMGrNNxp8bGo4Kpw721z54bWpzrH4N8RUT3gVcdY4L20d1c
	H4mOJmg==
X-Gm-Gg: ASbGnctfmzB0LhiAho6cTK9mIX/JQ3c7lB1pRQRi3lWWeb/+dwkp558y7k9xjQqgx1N
	orPk2Jt25YGt+dobxDKk0ai72dpokNKDRZE/bjlgKjJSoThck02ziuXHsP7Upo71t8mHMiVMUfd
	QD4WpqQt5md/Vfa8c0rmi5K31vPImX84yiDktwXqdAin9bwInshdc4jscZz+Gb3v7w6r0wTeTAS
	lgWpsfU1hjoQBtlGqv40d5mKFT9ElxpnFrirrBjOxduwH1Lb+dlTp4lmPPT4Sk0SIbr130BlGOs
	5HzaztloFUji66FDNhpjU8YJ0qjt6aWgJjQPWLrWVlOvyo8IEiqlCpkUrMuGOpHbXESQ/qYq0dG
	zTnBp5rH2TrQUdU17n/E=
X-Google-Smtp-Source: AGHT+IG0y5e3FwMzog4mXsI7cmVS7EGUjrh72liWn388qc6nhjUeFQk70N3POgBsZUy/SvhMVdj//A==
X-Received: by 2002:a05:6512:31c9:b0:545:5a5:b69f with SMTP id 2adb3069b0e04-54ad64799edmr5821748e87.9.1742935714344;
        Tue, 25 Mar 2025 13:48:34 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad6512520sm1596203e87.245.2025.03.25.13.48.32
        for <linux-sctp@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 13:48:33 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54996d30bfbso5658807e87.2
        for <linux-sctp@vger.kernel.org>; Tue, 25 Mar 2025 13:48:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdhjaZ0nndLrY/oOSUG9kbouP+lcg9/l/6SUed1zNUzjmEBl3QRkkGpCsadz7kTr1k/HbfcyL7keeh@vger.kernel.org
X-Received: by 2002:a17:907:95a4:b0:ac3:48e4:f8bc with SMTP id
 a640c23a62f3a-ac3f27fd3b3mr1859596466b.48.1742935307883; Tue, 25 Mar 2025
 13:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325121624.523258-1-guoren@kernel.org> <20250325121624.523258-2-guoren@kernel.org>
In-Reply-To: <20250325121624.523258-2-guoren@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 25 Mar 2025 13:41:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
X-Gm-Features: AQ5f1JpwFc7ifwGuAhyrs4E5qPgHx1McCR38KFycRhkLFRMKTveHrmoaWi4zba4
Message-ID: <CAHk-=wiVgTJpSxrQbEi28pUOmuWXrox45vV9kPhe9q5CcRxEbw@mail.gmail.com>
Subject: Re: [RFC PATCH V3 01/43] rv64ilp32_abi: uapi: Reuse lp64 ABI interface
To: guoren@kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, anup@brainfault.org, atishp@atishpatra.org, 
	oleg@redhat.com, kees@kernel.org, tglx@linutronix.de, will@kernel.org, 
	mark.rutland@arm.com, brauner@kernel.org, akpm@linux-foundation.org, 
	rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com, 
	inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, 
	jiawei@iscas.ac.cn, wuwei2016@iscas.ac.cn, drew@pdp7.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com, 
	wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, 
	dsterba@suse.com, mingo@redhat.com, peterz@infradead.org, 
	boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn, 
	leobras@redhat.com, jszhang@kernel.org, conor.dooley@microchip.com, 
	samuel.holland@sifive.com, yongxuan.wang@sifive.com, 
	luxu.kernel@bytedance.com, david@redhat.com, ruanjinjie@huawei.com, 
	cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn, 
	ardb@kernel.org, ast@kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-mm@kvack.org, 
	linux-crypto@vger.kernel.org, bpf@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Mar 2025 at 05:17, <guoren@kernel.org> wrote:
>
> The rv64ilp32 abi kernel accommodates the lp64 abi userspace and
> leverages the lp64 abi Linux interface. Hence, unify the
> BITS_PER_LONG = 32 memory layout to match BITS_PER_LONG = 64.

No.

This isn't happening.

You can't do crazy things in the RISC-V code and then expect the rest
of the kernel to just go "ok, we'll do crazy things".

We're not doing crazy __riscv_xlen hackery with random structures
containing 64-bit values that the kernel then only looks at the low 32
bits. That's wrong on *so* many levels.

I'm willing to say "big-endian is dead", but I'm not willing to accept
this kind of crazy hackery.

Not today, not ever.

If you want to run a ilp32 kernel on 64-bit hardware (and support
64-bit ABI just in a 32-bit virtual memory size), I would suggest you

 (a) treat the kernel as natively 32-bit (obviously you can then tell
the compiler to use the rv64 instructions, which I presume you're
already doing - I didn't look)

 (b) look at making the compat stuff do the conversion the "wrong way".

And btw, that (b) implies *not* just ignoring the high bits. If
user-space gives 64-bit pointer, you don't just treat it as a 32-bit
one by dropping the high bits. You add some logic to convert it to an
invalid pointer so that user space gets -EFAULT.

            Linus

