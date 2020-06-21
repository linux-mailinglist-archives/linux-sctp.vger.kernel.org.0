Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 096A9202B7D
	for <lists+linux-sctp@lfdr.de>; Sun, 21 Jun 2020 17:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgFUP4J (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Sun, 21 Jun 2020 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729960AbgFUP4I (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 21 Jun 2020 11:56:08 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13FBC061794;
        Sun, 21 Jun 2020 08:56:08 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z127so407572ooa.3;
        Sun, 21 Jun 2020 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=i333d3+kVLv/Hv3Zesle+RAdrXocci4KHB9P1q1EjVk=;
        b=O8QmAiFjluNr6cPL57dujcYNJOsuKxPWTDi+GR8OvAHd0PVN0FQqL89uzo4V9Wi121
         QwGCQlFM1+ctGVAFuDSiVCkpfL5FSQupsthYK0L2LxTnnbqhUsZmDukeNIwq7uFsPkqK
         KQQGNjfiwNdmbJJS6BBhg9WI5Fyhm1VVXTI37+DRglebgWjoHujGUL/Q6stGTS5VuaxN
         9U3r3hdS5OHx5TZmBzLXisRDznu2yVEXLIOgNrAy8ZBWh/eXOGsB983N3yJPga45ZwJe
         o2JEaW7GRB2Eh8HZv5RPRaoBKoboxew4OE3DRZI9YdY7rd/Km0mA6DqdoguEQA5nDAO5
         /lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=i333d3+kVLv/Hv3Zesle+RAdrXocci4KHB9P1q1EjVk=;
        b=ITjfJg9BGzPRr0JcnmsVIOdMs5RO+U5KB+ZDZbVw2fZPVn4pCUN+mZOEYAzLEy9P/z
         7h6rdLcGFkx/5ZcqQKpdH1M50l4wnOQ/7ZLctVSnyd0Uo64B5hbxHdq+RLcAmnIndn4Z
         v+6wuCEmVaFuRFYlc1QBmfGN2BpnX1eOc8rbzDKDsYH9pUa11vjMSLa6++LcN2u98Jo0
         gw+/FgddasP8WNrt6AVYRT+5aceYe3ipmZcIPNt2urVjQwoEoV/B40KJCsa/wCxzaI3c
         qltbYiY25tBRM5BPxd+7J1EKRlC5kHmUbfHMS7aoiUhGwvAiUagYBqRD0ZeHwoadoh0W
         WDlA==
X-Gm-Message-State: AOAM531L1FjxT7Q2usUeizysEYKjTNzDEVlHRS5g6ZpIb9JzxaRTFl/s
        ASxJM09S2ambRaTbIogpWA==
X-Google-Smtp-Source: ABdhPJw7bj4ELePxfxuvLADuxB8L0BDv3JI+ig3SJctaiLL6O7ZtuTcHQkE/nw3BLGUifGNqQkpLhg==
X-Received: by 2002:a4a:4904:: with SMTP id z4mr10933217ooa.63.1592754967659;
        Sun, 21 Jun 2020 08:56:07 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id n9sm2776971oom.45.2020.06.21.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 08:56:06 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:98f8:1e34:b5b7:82f7])
        by serve.minyard.net (Postfix) with ESMTPSA id 65A90180044;
        Sun, 21 Jun 2020 15:56:05 +0000 (UTC)
Date:   Sun, 21 Jun 2020 10:56:04 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Strange problem with SCTP+IPv6
Message-ID: <20200621155604.GA23135@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

I've stumbled upon a strange problem with SCTP and IPv6.  If I create an
sctp listening socket on :: and set the IPV6_V6ONLY socket option on it,
then I make a connection to it using ::1, the connection will drop after
2.5 seconds with an ECONNRESET error.

It only happens on SCTP, it doesn't have the issue if you connect to a
full IPv6 address instead of ::1, and it doesn't happen if you don't
set IPV6_V6ONLY.  I have verified current end of tree kernel.org.
I tried on an ARM system and x86_64.

I haven't dug into the kernel to see if I could find anything yet, but I
thought I would go ahead and report it.  I am attaching a reproducer.
Basically, compile the following code:

  gcc -g -o sctptest -Wall sctptest.c

and run it in one window as a server:

  ./sctptest a

(Pass in any option to be the server) and run the following in another
window as the client:

  ./sctptest

It disconnects after about 2.5 seconds.  If it works, it should just sit
there forever.

-corey


#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/select.h>
#include <arpa/inet.h>
#include <netinet/sctp.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>

static int
getaddr(const char *addr, const char *port, bool listen,
	struct addrinfo **rai)
{
    struct addrinfo *ai, hints;

    memset(&hints, 0, sizeof(hints));
    hints.ai_flags = AI_ADDRCONFIG;
    if (listen)
	hints.ai_flags |= AI_PASSIVE;
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_STREAM;
    hints.ai_protocol = IPPROTO_SCTP;
    if (getaddrinfo(addr, port, &hints, &ai)) {
	perror("getaddrinfo");
	return -1;
    }

    *rai = ai;
    return 0;
}

static int
waitread(int s)
{
    char data[1];
    ssize_t rv;

    rv = read(s, data, sizeof(data));
    if (rv == -1) {
	perror("read");
	return -1;
    }
    printf("Read %d bytes\n", (int) rv);
    return 0;
}

static int
do_server(void)
{
    int err, ls, s, optval;
    struct addrinfo *ai;

    printf("Server\n");

    err = getaddr("::", "3023", true, &ai);
    if (err)
	return err;

    ls = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
    if (ls == -1) {
	perror("socket");
	return -1;
    }

    optval = 1;
    if (setsockopt(ls, SOL_SOCKET, SO_REUSEADDR,
		   (void *)&optval, sizeof(optval)) == -1) {
	perror("setsockopt reuseaddr");
	return -1;
    }

    /* Comment this out and it will work. */
    if (setsockopt(ls, IPPROTO_IPV6, IPV6_V6ONLY, &optval,
		   sizeof(optval)) == -1) {
	perror("setsockopt ipv6 only");
	return -1;
    }

    err = bind(ls, ai->ai_addr, ai->ai_addrlen);
    if (err == -1) {
	perror("bind");
	return -1;
    }

    err = listen(ls, 5);
    if (err == -1) {
	perror("listen");
	return -1;
    }

    s = accept(ls, NULL, NULL);
    if (s == -1) {
	perror("accept");
	return -1;
    }

    close(ls);

    err = waitread(s);
    close(s);
    return err;
}

static int
do_client(void)
{
    int err, s;
    struct addrinfo *ai;

    printf("Client\n");

    err = getaddr("::1", "3023", false, &ai);
    if (err)
	return err;

    s = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
    if (s == -1) {
	perror("socket");
	return -1;
    }

    err = connect(s, ai->ai_addr, ai->ai_addrlen);
    if (err == -1) {
	perror("connect");
	return -1;
    }

    err = waitread(s);
    close(s);
    return err;
}

int
main(int argc, char *argv[])
{
    int err;

    if (argc > 1)
	err = do_server();
    else
	err = do_client();
    return !!err;
}

