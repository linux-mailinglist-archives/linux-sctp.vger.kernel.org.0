Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAB10C80C
	for <lists+linux-sctp@lfdr.de>; Thu, 28 Nov 2019 12:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfK1Lgk (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 28 Nov 2019 06:36:40 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:35225 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Lgk (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 28 Nov 2019 06:36:40 -0500
Received: by mail-oi1-f181.google.com with SMTP id k196so6684646oib.2
        for <linux-sctp@vger.kernel.org>; Thu, 28 Nov 2019 03:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kKboKZiLBFlGtToQerR16Wew2tyrYSs0zTwQ0fKA/Y8=;
        b=bLe4TUi/b4pmFU8Ke9vMppZtKyz8R5OEay/KHaKddvUYi9DAml14zg6jsSV7xbql/E
         veG+pemYEa2C+BWimGyZ9K5sK1EgeycKeOofjpBVUuhiSbOo3mr9Ty5IdZK2qbTrPk2b
         BYvnvfkBZtHN2ViTjkBz03SP+NcW9KgXVXpIsUeYNJMWpLxaJw44uFRStztLLZrtfuuC
         XUUkHcnef+sAweX/swPzaRDPojOPAqfM2nwZ0dzPNxBmIb6/bkawFgI+VgVULaLbHErE
         HiVlOIDyH72CTiZZ5Ix8ttPj1Ni58y5VWgl8PfK3Bt1OAbwXNNDz/ESbuKcQqT40bIU4
         Fiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kKboKZiLBFlGtToQerR16Wew2tyrYSs0zTwQ0fKA/Y8=;
        b=qhGJbftyGVv5ew8TS2KGzjcaoygqCQcHvEmZOzTx3UxAToVAB3vz1IRqMurinmxYF9
         Q8GqzSo4OjiVwQm7FiQUwEen7xkRFm2sAAMb2xQrzfVYi9W5aSJnFUZEI5hN6UyZSOif
         bE2bTdzeRTqx7f+ncbtTyoVP1CQ+59/Q3QfYbnaENurCq6Bp08RdxGcjhTfiE19e6Uxn
         qhCwDIfHRUsFEckfegcrDcBATGq/17zHyVzfkSClEyVVsIqiZXDeUvGQ/gFShbZA6Kqx
         5JEdop8Y/JnL5p0RfNdJAjrB562inmbnKXns8vbpwuueQPOEC5qU2SSKF5//Zgznyk4A
         g14g==
X-Gm-Message-State: APjAAAWC7N5WgJw4Pj3YgeiyPhl+B36kdg2YyHkQdxAb8LmLfSIGK16N
        Rj3wScVul4Uu0wfQwNcXv1JHA/8hzVx5b78/R6LyYPb5
X-Google-Smtp-Source: APXvYqxyrqH2KAk+4ZDuY+pLRLvvFUcosIGKmmNZyZUb/BwSefGLippRwpGlz0jRsq1t9rKaeifscDsUy+PNY33bTrg=
X-Received: by 2002:aca:d988:: with SMTP id q130mr7388883oig.133.1574940999203;
 Thu, 28 Nov 2019 03:36:39 -0800 (PST)
MIME-Version: 1.0
From:   Naruto Nguyen <narutonguyen2018@gmail.com>
Date:   Thu, 28 Nov 2019 18:36:28 +0700
Message-ID: <CANpxKHFkTApZufGkL-7JSwt0BqTmPpp1=77jVhrqHZdo74e0Sw@mail.gmail.com>
Subject: SCTP conntrack does not track init chunk types
To:     linux-sctp@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi everyone,

I have followed a simple SCTP server and SCTP client at
http://simplestcodings.blogspot.com/2010/08/sctp-server-client-implementation-in-c.html

It works well. Client and server can communicate successfully. Then I
tried to set up an iptable rule to drop INIT package on server node

iptables -A INPUT -p sctp  -m conntrack --ctstate NEW -m sctp
--chunk-types any INIT -j DROP

It can drop and connection cannot establish from client anymore.
However, when I tried to drop INIT_ACK sent from server by

iptables -A OUTPUT -p sctp  -m conntrack --ctstate NEW -m sctp
--chunk-types any INIT_ACK -j DROP

looks like it cannot drop INIT_ACK and connection from client is setup
well. Could you please tell me if SCTP conntrack can drop INIT_ACK,
COOKIE_ACK? My conntrack log does not show any INIT, INIT_ACK,
COOKIE_ACK

[NEW] sctp     132 3 src=199.569.9.50 dst=199.569.9.51 sport=57295
dport=62324 [UNREPLIED] src=199.569.9.51 dst=199.569.9.50 sport=62324
dport=57295
 [UPDATE] sctp     132 3 src=199.569.9.50 dst=199.569.9.51 sport=57295
dport=62324 src=199.569.9.51 dst=199.569.9.50 sport=62324 dport=57295
 [UPDATE] sctp     132 3 COOKIE_ECHOED src=199.569.9.50
dst=199.569.9.51 sport=57295 dport=62324 src=199.569.9.51
dst=199.569.9.50 sport=62324 dport=57295
 [UPDATE] sctp     132 432000 ESTABLISHED src=199.569.9.50
dst=199.569.9.51 sport=57295 dport=62324 src=199.569.9.51
dst=199.569.9.50 sport=62324 dport=57295 [ASSURED]

Is it expected? In tcp, conntrack log can show SYN_SENT/ SYN_RECEIVED.

Brs,
Naruto
