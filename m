Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFAC6B157
	for <lists+linux-sctp@lfdr.de>; Tue, 16 Jul 2019 23:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfGPVry (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 16 Jul 2019 17:47:54 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:41682 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbfGPVrx (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 16 Jul 2019 17:47:53 -0400
Received: by mail-qt1-f169.google.com with SMTP id d17so21182945qtj.8
        for <linux-sctp@vger.kernel.org>; Tue, 16 Jul 2019 14:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=rYIv3+f+Wpfnr6NMWCcYLn28y9wrn6a9ojz4c0/+KO0=;
        b=F9QFNRkAj2AxjYTP3v86UzDM1ywEdAFCZVmWrPun7wyBJ/TR3zzJ3lz6DfpmqjzJ2N
         KIJZkSz3rB2cjFNCPF281hvzaUvyn6/aYJPIMY5FVdRUlsGWzbQ9Y8TkcGLvgVJYq5yH
         aiYyPVvmnAJpCUkxriMBcOZrdBT1lkRA0Qz4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=rYIv3+f+Wpfnr6NMWCcYLn28y9wrn6a9ojz4c0/+KO0=;
        b=L08HkvthxmWXdU2srevettCu2HB3zz2QK5Lfn3atF6fBTD5dnHiTWx5AsLktFM7rn6
         wDVt5YBbeWRskC9qY/2nufiHQFpkon1Oz23wmOUFQlRdBCnM2dSHr7exOoCBfvEQ8yTt
         a7mwYt2GtLatmfxYL7BzQ5QXQGQ4K+iWrKiIninHT5ljkLN1SIGH1lLsilYW/I8NzxHC
         Ssz1u2/Vc2obv3pEfeAj2RUjIX/zSlZHEzJDpMJDlak3uLEFQo1jkr0JYX09kxORqsnV
         spUVVbCXMxsoUYhL1WZUhEjuk/t86OihR0GqFj+Phb/g35imm5w8FmZXlM5dXjMYjru1
         qnUg==
X-Gm-Message-State: APjAAAW7AlPxOzH5idDis/EC1MbveFkLc5pF3+M6i1+iy0sV+2+TIIG9
        RgcgJU+Q9R8cy5WdjsKzoufFPneRxzHGWQL1iGmMBQ==
X-Google-Smtp-Source: APXvYqzk2ElYGbmGXakeEof2T6vw9TA+aJreKVj8sfbINfaag8CkplmHATB4jdl8o6M8mE9LH4hDIawBSFfrZ16WjbI=
X-Received: by 2002:ac8:d8:: with SMTP id d24mr25266793qtg.284.1563313671878;
 Tue, 16 Jul 2019 14:47:51 -0700 (PDT)
MIME-Version: 1.0
From:   Marek Majkowski <marek@cloudflare.com>
Date:   Tue, 16 Jul 2019 23:47:40 +0200
Message-ID: <CAJPywTL5aKYB40FsAFYFEuhErhgQpYZP5Q_ipMG9pDxqipcEDg@mail.gmail.com>
Subject: OOM triggered by SCTP
To:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Morning,

My poor man's fuzzer found something interesting in SCTP. It seems
like creating large number of SCTP sockets + some magic dance, upsets
a memory subsystem related to SCTP. The sequence:

 - create SCTP socket
 - call setsockopts (SCTP_EVENTS)
 - call bind(::1, port)
 - call sendmsg(long buffer, MSG_CONFIRM, ::1, port)
 - close SCTP socket
 - repeat couple thousand times

Full code:
https://gist.github.com/majek/bd083dae769804d39134ce01f4f802bb#file-test_sctp-c

I'm running it on virtme the simplest way:
$ virtme-run --show-boot-console --rw --pwd --kimg bzImage --memory
512M --script-sh ./test_sctp

Originally I was running it inside net namespace, and just having a
localhost interface is sufficient to trigger the problem.

Kernel is 5.2.1 (with KASAN and such, but that shouldn't be a factor).
In some tests I saw a message that might indicate something funny
hitting neighbor table:

neighbour: ndisc_cache: neighbor table overflow!

I'm not addr-decoding the stack trace, since it seems unrelated to the
root cause.

Cheers,
    Marek
