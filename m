Return-Path: <linux-sctp+bounces-591-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F467B0E45C
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 21:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E3E2548118
	for <lists+linux-sctp@lfdr.de>; Tue, 22 Jul 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA421285406;
	Tue, 22 Jul 2025 19:47:19 +0000 (UTC)
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE728314D
	for <linux-sctp@vger.kernel.org>; Tue, 22 Jul 2025 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753213639; cv=none; b=j4bb4dGLDKebLm1bjnh1iTmdyPaOWaAaceR9F9yhDyzYTHMRLoCBrQ/nfa27TSLWSgPdXr9V1Fbf3dUe6kKcJTMV0o+SZ6I5K2RSF/PtFgxNcqPtL6UoKiZ2mE011sPc59aH2Uw8XEvnmS6lyDeamAQClqieqtwQMRi2ObVfm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753213639; c=relaxed/simple;
	bh=KhAupNvkqYbB+L15tQt/GviWL4AKCEiGwpuo76Nu0v4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Q1IMLKYxTwhfyPD2FMwR9UGrJ4jc5KVff1TS1ijc1XeDsBtHl0KsZanRp8RCEABOhwiGgetnsZ9EejwSTJM6uOtPg+wGJV2Mk9zJJ9WLbI71yh9WGWz2ExuorpbuMm8Se3wIsCuQHVFMV5tJwGJB0Jq3vimrLsar/CEDtdyzHtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-87c24b196cbso362516939f.2
        for <linux-sctp@vger.kernel.org>; Tue, 22 Jul 2025 12:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753213636; x=1753818436;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhAupNvkqYbB+L15tQt/GviWL4AKCEiGwpuo76Nu0v4=;
        b=cFLNWTJEvUVIAProOxt9xfewZ4k/1Kee90xKjNmSkRWg7pFnvhRstDjx+MtQ9N/N2h
         q21vUKjXWSXe4Y0Z2CaLo+v7TpJoqix2tIbq50amTJHZYiZ0SzFXdkJuaOHx9vtVTf/D
         NNiplZ2CJxT5GXFUlCkSFnebahItb2LIX3x+FBVwjfRGW2h/OekOc/hbXxuc6hGuBboj
         ajnku+1uLxHLQiL8Eqb/DTid4o1eeVirnIEJh48VWWdgiglt1xzo9fL9FzQF+Xa+5ZF3
         odCWwMvSBJyXhT0pc/Kv6TMh0grsVzkOtUIvBb3CjGuXI51y9QPepu5e9yO3r5BUrZ8h
         t4Mg==
X-Forwarded-Encrypted: i=1; AJvYcCU1hKUC/q4YCh4CEuaikeJaMuuq9gKHKK4CYo5mdoao+w5nS4h2YtX0VL3U+vWuvYJdwY/qzJIXspFO@vger.kernel.org
X-Gm-Message-State: AOJu0YyoILx/0ZR4u/4bFffvbfP4rv8G3xNrZ0M6ZbpluJO+6Wi+HIzX
	zDW9HD6Q9FDVsz0/N+RoFFZY0S34oHtovXSq2I84Bn7TOh4K3m5YnZB+Mrvn4OTHKhaa67kuzE9
	cC36L8yWfrlvZ40IAEq82n+bvl6C8AVp6h+kqD83JeEJfrx1hqppNHuj8XlA=
X-Google-Smtp-Source: AGHT+IHkT5bOsizzU4GRs55SoiHPfaxYPynREfRYvB8D/6LfMyvr/79oLo0wP85sSp16FuCWGJLBWrzBJ3OdxAlHmMvHFGDxa1eO
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1584:b0:862:fe54:df4e with SMTP id
 ca18e2360f4ac-87c64fd8f3dmr67755639f.7.1753213636550; Tue, 22 Jul 2025
 12:47:16 -0700 (PDT)
Date: Tue, 22 Jul 2025 12:47:16 -0700
In-Reply-To: <CAF3JpA5JPbEByou1OKfuPMKH1o--0q113pNoPyPR-h3QjuZxUg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687feac4.a70a0220.21b99c.0014.GAE@google.com>
Subject: Re: [syzbot] [sctp?] UBSAN: shift-out-of-bounds in sctp_transport_update_rto
From: syzbot <syzbot+2e455dd90ca648e48cea@syzkaller.appspotmail.com>
To: moonhee.lee.ca@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, 
	moonhee.lee.ca@gmail.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main

This crash does not have a reproducer. I cannot test it.


