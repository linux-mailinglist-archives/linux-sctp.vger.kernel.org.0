Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A571F0C5F
	for <lists+linux-sctp@lfdr.de>; Sun,  7 Jun 2020 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgFGPRu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Sun, 7 Jun 2020 11:17:50 -0400
Received: from mail-n.franken.de ([193.175.24.27]:60693 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726528AbgFGPRu (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Sun, 7 Jun 2020 11:17:50 -0400
Received: from [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e] (unknown [IPv6:2a02:8109:1140:c3d:bddf:742e:78b5:d32e])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 042CF7220B810;
        Sun,  7 Jun 2020 17:17:46 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: EAGAIN
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <021ba1317114431290cc2aae12a4ee64@AcuMS.aculab.com>
Date:   Sun, 7 Jun 2020 17:17:45 +0200
Cc:     Andreas Fink <afink@list.fink.org>,
        "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <5F3CF6C8-1FE3-48C5-8E6C-2EC35E0E2FBF@lurchi.franken.de>
References: <0D6B7E65-36EC-4132-B02C-0371099E480A@list.fink.org>
 <5025EE9D-20B1-4A7C-B207-A135A082DB92@lurchi.franken.de>
 <021ba1317114431290cc2aae12a4ee64@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 7. Jun 2020, at 16:04, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> From: Michael Tuexen
>> Sent: 07 June 2020 13:48
> ...
>> If you killed the peer, I would assume that there is an SCTP message containing an
>> ABORT chunk in the wire. Is that true? If that is true, you could subscribe to
>> SCTP_ASSOC_CHANGE notification, which should tell you.
> 
> Actually for TCP-style 1-1 connections you must subscribe to
> SCTP_ASSOC_CHANGE.
I guess you are referring to UDP (1-to-many) style sockets.
For 1-to-1 style sockets, the normal error handling should
work, like it does for TCP (returning -1 in a system call
and errno being ETIMEDOUT or ECONNRESET). At least this is
the way intended by the specification and I think Linux
does it that way.

Best regards
Michael
> 
> If you don't and the far end is killed (eg kernel crash) and
> restarts with the same port number pair then you get no
> indication that everything has disconnected and reconnected.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

