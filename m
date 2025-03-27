Return-Path: <linux-sctp+bounces-440-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E1EA736B6
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Mar 2025 17:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C3F189F848
	for <lists+linux-sctp@lfdr.de>; Thu, 27 Mar 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69A22192E1;
	Thu, 27 Mar 2025 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="lyo/ghqz"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166252135A2
	for <linux-sctp@vger.kernel.org>; Thu, 27 Mar 2025 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092417; cv=none; b=kFMUpbcw5WUNaJVJn9pV+VNFjQ+xttXAff8iwW4+z0udGGIhJ/PwZZk+0uKy2k64sMEF6IUAmaashTaLMnRH24lTPj3VGHuzVyy2t9Sw43yxgy9sYe3HRBaqrQoPyru3a2yXAnE1Xa5fUUyKwQAj6beMj1ejIgEHAKo65UH9NdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092417; c=relaxed/simple;
	bh=d7ElXG12q67ts9hPo9D4cCi81eQhC4QyN/csAlxbkk8=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=OfFqD17fzTxbIBoZCYyNMzG73qug7A37YMFQ3SmQDSXnWp+eXfJepWVkNDYVDiZt+Cg5cdWPbEBrCJYEYC8ALGwBdaWdTcrekXiBKBc5qxlCK49NQtrP7ltt0x74Tfj+iDPQHYkD86DWBhE8VuZAUeytR0eDpbItIjYSkv7YVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=lyo/ghqz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224100e9a5cso25643895ad.2
        for <linux-sctp@vger.kernel.org>; Thu, 27 Mar 2025 09:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1743092415; x=1743697215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hQcfqS6ONRy4v+VAuw1r1bUFP3B6ufIgzXQvK3yZp0M=;
        b=lyo/ghqzqUlQQ9ifGnysDhZW7g9yyD6Q7v/RquxMuUK2+4U4OfP4z2RzZhQMF3fOMs
         e2PS4LUFo/oInESou2c2E8LHwu5hBjwDH5SnJA/Q5RmiewHt71894aA3Md0+ui2UIHEl
         Ot6rWrkjL1qC3uQugNvQr/HjKtiGySrePzg16Bg6rdyUZIwLtWVgn32xTfEPfUaT3NUL
         Ub1Ov8LICk8tYkTS5XQiJI4FnlfDx1TgRIOM7jlzmhApcKrbPZ8D0kYiwFJq/7WVhbM/
         l9csm94XZ60aYEDj/LquZUSUN56uLtp+EssFC46gFxIswOo2JUcuFPsZ4cvdpDDq87Xh
         k5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092415; x=1743697215;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQcfqS6ONRy4v+VAuw1r1bUFP3B6ufIgzXQvK3yZp0M=;
        b=rBjFYFfXPeOvF9j2ed+iINNE2CQRn1SDCXw2TSISxhXgQSW76n7c1klRXARRNAQcRo
         PwJOe8rKwg+C8kPS1NWdVuAMrfqZFd49Nd23Q34L0au+iEWC8LTPwZi/Ahzg5qFJSgnB
         +Jin72xOyXY+VS6f3b8Roa97IHoJ66ih9XN6ZxI83edLrUvZ3ssIFP8mvqY23n0+JQ1D
         XRXhIErGMWeLiUvYmYNzlqxv/7gFJl2g2XksyoI5+qpl9tEd1yS7WfHBM6irXookcspA
         xp8BZFenAcYI7hiZT/7dsORSj2WFiXFXz2VnqBFKuYYcxvUKhhRvHmgfhtep4ebX2pM2
         j2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqY6SbgVmIUXZpxaHZcWsMQ1CRRfdlo+VsRWhCseYEE1N979SzfXQ5UMVJkBjq9mRjRk4STkaLpG3x@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNV7IRHrAT1oV3u1gJGFG/bzTW3BFdAxWoL2DdRYfkqSuMPBu
	Id2G7Aen1JKukUUU/dRiUnhpWdyT8mCJqSceuqrojEeMRU5T2r1zkreTJ4QItSQ=
X-Gm-Gg: ASbGncvmeTs0UivFi2Epz4BrZQdemxtwWhOSREx95ZzEcbvvgIAIEDreD1OM1wCQpYk
	mi0D+sDXvL+v10PunlKd3pvWnS/AABS844+HjNf5T0lbUGqACH5ivZPT4NL2SulxoC9THxtAXMW
	56zJSx8CciiSNHpXZDdj7un2D57Di/CHST2L1xjX9CbOfbqiuF7k58ldl2f1K5k7JMAowB/8utj
	Whb9r8ta4NnDRn8Xg5lZ4DkbK7uBeY02dILPWCJhb1eAYsbYsfiWsSNwQ99E6j3DSZ7yrnci92l
	8M3XP6gHwCw4DbeDkTtMYK/iZjYC6Tq7qYRftg==
X-Google-Smtp-Source: AGHT+IGhXmi8JOjZOP3Ikj3wo/1uBU9qt49Ql5SLHckRbeVG8HWYg9iWFYIxA94kzN1K7mL9F21TaQ==
X-Received: by 2002:a17:903:22d2:b0:223:4816:3e9e with SMTP id d9443c01a7336-22804857854mr57168615ad.13.1743092410377;
        Thu, 27 Mar 2025 09:20:10 -0700 (PDT)
Received: from localhost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390618e4b6sm14534202b3a.180.2025.03.27.09.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:20:09 -0700 (PDT)
Date: Thu, 27 Mar 2025 09:20:09 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Mar 2025 09:20:00 PDT (-0700)
Subject:     Re: [RFC PATCH V3 00/43] rv64ilp32_abi: Build CONFIG_64BIT kernel-self with ILP32 ABI
In-Reply-To: <svu4xdeo7a7ve3vorvgbkjxzrqmqk5oztgtfpbg556wjw4x7vc@yg4esoipmt7g>
CC: david@redhat.com, peterz@infradead.org, guoren@kernel.org,
  Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
  Linus Torvalds <torvalds@linux-foundation.org>, Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
  atishp@atishpatra.org, oleg@redhat.com, kees@kernel.org, tglx@linutronix.de,
  Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, brauner@kernel.org,
  akpm@linux-foundation.org, rostedt@goodmis.org, edumazet@google.com, unicorn_wang@outlook.com,
  inochiama@outlook.com, gaohan@iscas.ac.cn, shihua@iscas.ac.cn, jiawei@iscas.ac.cn,
  wuwei2016@iscas.ac.cn, drew@pdp7.com, prabhakar.mahadev-lad.rj@bp.renesas.com, ctsai390@andestech.com,
  wefu@redhat.com, kuba@kernel.org, pabeni@redhat.com, josef@toxicpanda.com, dsterba@suse.com,
  mingo@redhat.com, boqun.feng@gmail.com, xiao.w.wang@intel.com, qingfang.deng@siflower.com.cn,
  leobras@redhat.com, jszhang@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
  samuel.holland@sifive.com, yongxuan.wang@sifive.com, luxu.kernel@bytedance.com, ruanjinjie@huawei.com,
  cuiyunhui@bytedance.com, wangkefeng.wang@huawei.com, qiaozhe@iscas.ac.cn,
  Ard Biesheuvel <ardb@kernel.org>, ast@kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
  kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-mm@kvack.org,
  linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-input@vger.kernel.org,
  linux-perf-users@vger.kernel.org, linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org,
  linux-arch@vger.kernel.org, maple-tree@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
  netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net, linux-btrfs@vger.kernel.org,
  netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-nfs@vger.kernel.org, linux-sctp@vger.kernel.org,
  linux-usb@vger.kernel.org, linux-media@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Liam.Howlett@oracle.com
Message-ID: <mhng-e8248074-b79c-42f6-986f-9993851b6be2@palmer-ri-x1c9a>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 25 Mar 2025 12:23:39 PDT (-0700), Liam.Howlett@oracle.com wrote:
> * David Hildenbrand <david@redhat.com> [250325 14:52]:
>> On 25.03.25 13:26, Peter Zijlstra wrote:
>> > On Tue, Mar 25, 2025 at 08:15:41AM -0400, guoren@kernel.org wrote:
>> > > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>> > >
>> > > Since 2001, the CONFIG_64BIT kernel has been built with the LP64 ABI,
>> > > but this patchset allows the CONFIG_64BIT kernel to use an ILP32 ABI
>> >
>> > I'm thinking you're going to be finding a metric ton of assumptions
>> > about 'unsigned long' being 64bit when 64BIT=y throughout the kernel.
>> >
>> > I know of a couple of places where 64BIT will result in different math
>> > such that a 32bit 'unsigned long' will trivially overflow.

Ya, I write code that assumes "unsigned long" is the size of a register 
pretty regularly.

>> >
>> > Please, don't do this. This adds a significant maintenance burden on all
>> > of us.
>> >
>>
>> Fully agreed.
>
> I would go further and say I do not want this to go in.

Seems reasonable to me, and I think it's also been the general sentiment 
when this stuff comes up.  This specific implementation seems 
particularly clunky, but I agree that it's going to be painful to do 
this sort of thing.

> The open ended maintenance burden is not worth extending hardware life
> of a board with 16mb of ram (If I understand your 2023 LPC slides
> correctly).

We can already run full 32-bit kernels on 64-bit hardware.  The hardware 
needs to support configurable XLEN, but there's systems out there that 
do already.

It's not like any of the existing RISC-V stuff ships in meaningful 
volumes.  So I think it's fine to just say that vendors who want tiny 
memories should build hardware that plays nice with those constraints, 
and vendors who build hardware that doesn't make any sense get to pick 
up the pieces.

I get RISC-V is where people go to have crazy ideas, but there's got to 
be a line somewhere...

>
> Thank you,
> Liam

