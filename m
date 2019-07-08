Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1ED961EBF
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Jul 2019 14:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfGHMsy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 8 Jul 2019 08:48:54 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:42889 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbfGHMsy (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 8 Jul 2019 08:48:54 -0400
Received: by mail-qk1-f172.google.com with SMTP id 201so10992043qkm.9
        for <linux-sctp@vger.kernel.org>; Mon, 08 Jul 2019 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D/BtmksY7T7i+GBFvgQUZp9h9jnxxqv3MLFxWUUWm8g=;
        b=mXyHZ6DcLq53bsN8A44IiHRdXkMW2zklyqJHQ0JGnrvngcY9puq3lJUznxmwyKltwl
         SYWYliSmTuKnnoQ8GA8yyvLLyTA0NRgG78uK45zx+3+8AGysHqHRDtTXDXkg2DGojoO3
         p1miS0mryqEYypgw14iwncF2iaEJBPnnQck1Y1XMWvd88FLvP1zFFRNtNBX9hDYt1/oM
         070xlr+ypb2W3F/AHprAWPkqpJ8qTnUnMc0pFR+snyPLjGjsmsJDSrOkATNwJ/HH6RDh
         o/UrgbvSVhCXmvUKwIupBDK5pr9Kl22blok4EWXupimRdmyJQiAaazOrMucEjqeo3EqB
         Wnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/BtmksY7T7i+GBFvgQUZp9h9jnxxqv3MLFxWUUWm8g=;
        b=BHJluYBK5wbd5IY5TfBgIURde9KNQE+/TNejw2cqA67Wbu65xDXttMdstzOH/aMhCA
         UtnggwFyXKyoWY3bLRNx5ulRvJgnm4oBWCs0pBBXWP0uLpgkpKOimyP5DEtSk5PUA6pe
         ie6T1mJAqIBAYwtczDlyQuPsjhBW9UX1wZJxK0iYlJhBHojrqbVERE8Jj+usl2FJT56m
         X+HtqtLZ+0h9M4EZ0c/K6oiAkTvymJA8vUNaIW0B/6xmmM3BXrxGtJfTejXk1egpyOvs
         RBPNhqMpywzL8ASOA/Bh1XU7jZBZeFFprJ8K7stnVpE1MCGrnBVW1hLK3clTEVF8SoyP
         auMw==
X-Gm-Message-State: APjAAAW1iUb2JurrcENScxFnCLy3swlpxGfmdSdxJHnsVFKffnFH0X3y
        R56j81tP5PhaByyExkgd4lT+woTcchc=
X-Google-Smtp-Source: APXvYqxmZnOXzcc31BimdwNL2GYpuyxrvPQMbMA8SjvH5249A8mBSphHJvRghYyR3q+9eK0gmZL2cw==
X-Received: by 2002:a05:620a:14ab:: with SMTP id x11mr14071013qkj.186.1562590133531;
        Mon, 08 Jul 2019 05:48:53 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.139])
        by smtp.gmail.com with ESMTPSA id c18sm7223214qkk.73.2019.07.08.05.48.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 05:48:52 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id DFF3CC0A68; Mon,  8 Jul 2019 09:48:49 -0300 (-03)
Date:   Mon, 8 Jul 2019 09:48:49 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Patrick Schultz <Patrick@patfab.net>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: Support for RFC 6951 (UDP encapsulation for SCTP)
Message-ID: <20190708124849.GA3454@localhost.localdomain>
References: <044c9c5b-a7a2-effa-7a07-8bea5edcb9c3@patfab.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <044c9c5b-a7a2-effa-7a07-8bea5edcb9c3@patfab.net>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Jul 08, 2019 at 01:21:20AM +0200, Patrick Schultz wrote:
> Hello all,
> 
> are there already plans to support UDP encapsulation in lksctp-tools according to RFC6951?

Hi,

Not that I'm aware of. As it goes over UDP, you may be able to use
usrsctp instead.

https://github.com/sctplab/usrsctp
https://github.com/sctplab/usrsctp/blob/master/Manual.md#using-udp-encapsulation

  Marcelo
