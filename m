Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D11125DC5
	for <lists+linux-sctp@lfdr.de>; Thu, 19 Dec 2019 10:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLSJf0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 19 Dec 2019 04:35:26 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40858 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLSJf0 (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 19 Dec 2019 04:35:26 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so4303127ilo.7
        for <linux-sctp@vger.kernel.org>; Thu, 19 Dec 2019 01:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2DXLhWG+1I/sxJa6YFBWn4bUqJF9bmSM3jLRi/c7dc=;
        b=TRVX4Lc8Y8ErxPbU6eqBYH6CyQy+QfNXWoP+LLwz0l1EvzGtkuSE2oF7wGtG6hkGcu
         KJFIaAtCUTin8SM+ymwrscIObOxEDQaUA5ficzV/EJiwK9hs6DEpMG5QSDBg5hvdwtxt
         lsOwh05wUG56husmLOH5Jwygk1fBcnrM8r08iBc4MvjoTswR9u+3Q/E7kADToRzUcbCF
         jbcrCR5TgBFdWjYrxP18tic69Ck+5+jggbCGc3gqrtFUuVJfQzfsIjG0qwnJT0AL//Om
         Q5ytQHbplugQ7gkUXICfJ0Cq3FLeXnB0/tDw6Qa2CZFYrHHNnovJjCZt/1zOy7LS9Yeh
         6keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2DXLhWG+1I/sxJa6YFBWn4bUqJF9bmSM3jLRi/c7dc=;
        b=NFl4KVxOFvq7NXjf5G6sPm7vJ0JwpYATdKvvDu8RBnj6aTcqGHip/Bz7JPNWeumcAy
         MzKleSldXlxwT1dyROp6D0GzIfVJbWBXg9+47oe2sKECji5hLRygqDI54a9L3RF6L0RH
         eVTDE6vSh499USNOZ0/KrGHiCU/a4JF4B61MIr6vZo/5a5EH7e3STXzjiWzL5J0gLq9u
         1GQheunlYbZ3hArPg1H9HYlw59ua7wnz/VbWf/+XqtgbIhmK4QrE4F4pUaDhX4VJQGek
         QelFZtIzARTfp0yrYmdabCh16VDgwEG13UfOcgSJQIbjvYauGHejhT+NNhNMLXHUxKIv
         Qilg==
X-Gm-Message-State: APjAAAWZKbe07FbK42fPCa0p29kL8pcKKe+qykxfq/HXtGNacJCN1Wim
        RmABgrAPfQ4Ofuctwq+YEPI0VNq1xtmnJjiYlHDIfg==
X-Google-Smtp-Source: APXvYqxu+jMjNle+ACBvO1nRDbDvShivY/r2tlBkdLEsMASv7gZt8FOunyItaOXZPAMs744KqWkrYdN0Lr/vbe9IxY8=
X-Received: by 2002:a92:ca82:: with SMTP id t2mr6256940ilo.242.1576748125586;
 Thu, 19 Dec 2019 01:35:25 -0800 (PST)
MIME-Version: 1.0
References: <20191127001313.183170-1-zenczykowski@gmail.com> <20191213114934.GB5449@hmswarspite.think-freely.org>
In-Reply-To: <20191213114934.GB5449@hmswarspite.think-freely.org>
From:   Lorenzo Colitti <lorenzo@google.com>
Date:   Thu, 19 Dec 2019 18:35:13 +0900
Message-ID: <CAKD1Yr1m-bqpeZxMRVs84WvvjRE3zp8kJVx57OXf342r2gzVyw@mail.gmail.com>
Subject: Re: [PATCH] net: introduce ip_local_unbindable_ports sysctl
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>,
        =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux NetDev <netdev@vger.kernel.org>,
        Sean Tranchetti <stranche@codeaurora.org>,
        Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>,
        Eric Dumazet <edumazet@google.com>,
        Linux SCTP <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, 13 Dec 2019, 20:49 Neil Horman, <nhorman@tuxdriver.com> wrote:
> Just out of curiosity, why are the portreserve and portrelease utilities not a
> solution to this use case?

As I understand it, those utilities keep the ports reserved by binding
to them so that no other process can. This doesn't work for Android
because there are conformance tests that probe the device from the
network and check that there are no open ports.
