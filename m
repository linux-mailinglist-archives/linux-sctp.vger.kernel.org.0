Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40A21F0B25
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 14:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgFGMrk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 08:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgFGMrj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Sun, 7 Jun 2020 08:47:39 -0400
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BE5C08C5C2
        for <linux-sctp@vger.kernel.org>; Sun,  7 Jun 2020 05:47:39 -0700 (PDT)
Received: from [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e] (unknown [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id F1B7F7220B810;
        Sun,  7 Jun 2020 14:47:35 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: EAGAIN
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
Date:   Sun, 7 Jun 2020 14:47:34 +0200
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
References: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
To:     Andreas Fink <afink@list.fink.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 7. Jun 2020, at 14:18, Andreas Fink <afink@list.fink.org> wrote:
> 
> Hello folks,
> 
> I run into a strange issue with SCTP under Linux and I'm not sure whats the right approach to fix this.
> 
> I have a listener thread which listens on a port for multiple inbound connections
> I have a sender thread which sends packets to peers by using the same socket and doing a sctp_sendv call.
> Sockets are always in non blocking mode.
So a single SOCK_SEQPACKET socket for sending and receiving, right?
> 
> When the remote side gets stopped (process killed),  the sctp_sendv starts returning 0 and errno is set to EAGAIN and we constantly retry.
When it returns 0, you can't look at errno. errno is only set to a correct value, if -1 is returned.

If you killed the peer, I would assume that there is an SCTP message containing an
ABORT chunk in the wire. Is that true? If that is true, you could subscribe to
SCTP_ASSOC_CHANGE notification, which should tell you.

Best regards
Michael
> We somehow didn't catch that this socket was down and end up in a busy loop (which we now fail after a certain amount of retries).
> 
> My question to you is whats the correct way to deal with EAGAIN here? Why are we not catching the assoc being down?
> We have a sender thread and a receiver thread. The receiver thread is listening to events and should know.
> Furthermore if the assoc is down the sctp_sendv could simply return something like socket not connected error instead of EAGAIN.
> 
> Or what am I missing here?
> 
> 
> Andreas
> 
> PS: above was under Linux Debian Kernel 5.4.0-0.bpo.4.

