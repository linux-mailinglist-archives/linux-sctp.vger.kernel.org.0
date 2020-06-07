Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7101F0B14
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 14:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgFGMSp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 08:18:45 -0400
Received: from mail.fink.org ([79.134.252.20]:37760 "EHLO mail.fink.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgFGMSp (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 7 Jun 2020 08:18:45 -0400
X-Footer: Zmluay5vcmc=
Received: from protopia.fink.org ([79.134.238.50])
        (authenticated user list@fink.org)
        by mail.fink.org (Kerio Connect 9.2.12 patch 1) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
        for linux-sctp@vger.kernel.org;
        Sun, 7 Jun 2020 14:18:41 +0200
From:   Andreas Fink <afink@list.fink.org>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: EAGAIN
Message-Id: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
Date:   Sun, 7 Jun 2020 14:18:40 +0200
Cc:     linux-sctp@vger.kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hello folks,

I run into a strange issue with SCTP under Linux and I'm not sure whats the right approach to fix this.

I have a listener thread which listens on a port for multiple inbound connections
I have a sender thread which sends packets to peers by using the same socket and doing a sctp_sendv call.
Sockets are always in non blocking mode.

When the remote side gets stopped (process killed),  the sctp_sendv starts returning 0 and errno is set to EAGAIN and we constantly retry.
We somehow didn't catch that this socket was down and end up in a busy loop (which we now fail after a certain amount of retries).

My question to you is whats the correct way to deal with EAGAIN here? Why are we not catching the assoc being down?
We have a sender thread and a receiver thread. The receiver thread is listening to events and should know.
Furthermore if the assoc is down the sctp_sendv could simply return something like socket not connected error instead of EAGAIN.

Or what am I missing here?


Andreas

PS: above was under Linux Debian Kernel 5.4.0-0.bpo.4.
