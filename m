Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E03324E1FB
	for <lists+linux-sctp@lfdr.de>; Fri, 21 Aug 2020 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHUURE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Fri, 21 Aug 2020 16:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUURE (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 21 Aug 2020 16:17:04 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Aug 2020 13:17:03 PDT
Received: from drew.franken.de (drew.ipv6.franken.de [IPv6:2001:638:a02:a001:20e:cff:fe4a:feaa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F973C061573
        for <linux-sctp@vger.kernel.org>; Fri, 21 Aug 2020 13:17:03 -0700 (PDT)
Received: from [IPv6:2a02:8109:1140:c3d:7d61:8d08:31f5:39cc] (unknown [IPv6:2a02:8109:1140:c3d:7d61:8d08:31f5:39cc])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id 90244721E280C;
        Fri, 21 Aug 2020 22:10:21 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: 64k streams not supported
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <bedd13a72afd427ca4dbbdfa61985533@AcuMS.aculab.com>
Date:   Fri, 21 Aug 2020 22:10:20 +0200
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <B2A8B53A-9704-4C42-84C7-05CD9615FC28@lurchi.franken.de>
References: <bedd13a72afd427ca4dbbdfa61985533@AcuMS.aculab.com>
To:     David Laight <David.Laight@ACULAB.COM>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 21. Aug 2020, at 17:59, David Laight <David.Laight@ACULAB.COM> wrote:
> 
> Isn't SCTP supposed to support 65536 data streams?
Since the number of streams is exchanged in the INIT and INIT-ACK chunks
and encoded in a uint16_t, the number is 65535, not 65536.
So an implementation should be able to use up to 65535 incoming and
outgoing streams.

Best regards
Michael
> If I try to enable that many I get 10.
> Not surprising since the number of streams gets stored in a u16.
> 
> The whole code base may need changing to save the highest
> valid stream?
> 
> Since I don't actually need that many I'm not writing the patch.
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 

