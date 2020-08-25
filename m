Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0BE251D41
	for <lists+linux-sctp@lfdr.de>; Tue, 25 Aug 2020 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHYQcf (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 25 Aug 2020 12:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgHYQcb (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 25 Aug 2020 12:32:31 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83111C061574;
        Tue, 25 Aug 2020 09:32:31 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id p4so11504321qkf.0;
        Tue, 25 Aug 2020 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L/YYXtkHKUaPE/tsOglLtbLhqc+vooSNTKXW0aTvskU=;
        b=Ruck6EpDDJUMiWSpUI++B6KFoPI6MKPwhYk0mJmL4hlnavxCeSbo2k1DH0ZyxRdXzw
         C4hwdfBwXC5AZ2aQIDLTDMBI2mV8cSnY0IwKqdBHrKy4mPUSTEi/ozh8ITPSyV1CO+Ow
         9ZaEL7RdIueOtZECnXOyxFtA3068aVVmdBc297+6mdFdQMKMBe6jLn4IC8XVLH9oCQNI
         KK1V5w1hHMD/DSzkL0YJ87fWEMIHqGVdQbsQow33rH3kj4ms9jKoPnE1dqqx6/P0ANFN
         jJEdc9l0+ZlrypGmSkplvwHUtm3oUFF500nTHUUOP+A3v3KY/dnu4TE0QhfnE4iagD6S
         uY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L/YYXtkHKUaPE/tsOglLtbLhqc+vooSNTKXW0aTvskU=;
        b=H8Fnf458XFQGkYL7K3ZH00jUldV7H/VMbEjrmf9OyC3Er7X+uSJ4UmF6aEr6Uro1Vc
         AuAcEkgL3BdMh7Q+EGl8IW0aIM4OErm6HxgXEI78DN2+bTt+R7Vg0EZwAG0RXdZuI6mj
         A34bft841nRwjBXYeID4VDmPLyd76q+WIXstkwidgksxGwCRFnAGcqlSvs1O4oZK+LLR
         Dd+C0ZcfaJBKkP0y1QUPvLaz+VFDFJIduc2MjN3hUMb8jHL7BVxsI0dwJw2IfqoIuyRx
         DJFpfjGe6xMuPAT3of9TdNouzr7Ott0H9mc9qqLKfwB1lV0Dwjp5YK3scbtuAgdys/Ui
         AQXQ==
X-Gm-Message-State: AOAM5303iXBPcRjnDku/c9nU6hbOXvuInG6Et3IYxAhTnM+/JFU27BoS
        WP5ChzFi0UwV38UuauzDyg==
X-Google-Smtp-Source: ABdhPJygG7e+gxhwz0C4hnF5wpa4P6IRvKiDdc3MvmUIWrTHT3KHZ4b7wpFx8V252DTJql45jYyREw==
X-Received: by 2002:a37:9b15:: with SMTP id d21mr10444984qke.9.1598373150483;
        Tue, 25 Aug 2020 09:32:30 -0700 (PDT)
Received: from zaphod.evilpiepirate.org ([2601:19b:c500:a1:144c:c173:c2b9:af15])
        by smtp.gmail.com with ESMTPSA id a3sm13699802qtj.21.2020.08.25.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 09:32:29 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:32:24 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        'Neil Horman' <nhorman@tuxdriver.com>
Subject: Re: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Message-ID: <20200825163224.GA499490@zaphod.evilpiepirate.org>
References: <21289d79b0474811b21ed8478c465159@AcuMS.aculab.com>
 <20200825154127.GB2444@localhost.localdomain>
 <17da427b99b444ce9d310d6542ae197e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17da427b99b444ce9d310d6542ae197e@AcuMS.aculab.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Aug 25, 2020 at 04:00:35PM +0000, David Laight wrote:
> From: 'Marcelo Ricardo Leitner'
> > Sent: 25 August 2020 16:41
> > 
> > On Tue, Aug 25, 2020 at 02:52:34PM +0000, David Laight wrote:
> > > The genradix code is used by SCTP for accessing per-stream data.
> > > This means there are quite a lot of lookups but the code wasn't
> > > really optimised at all.
> > 
> > My test box is down for the moment and will bring it on later today or
> > tomorrow, so I can't test it yet. What should we expect as performance
> > gains here?
> 
> Not sure, probably not much, but it ought to show up :-)
> There'll be bigger gains on a cpu that has software ilog2().
> 
> I've only checked SCTP still works.
> I've requested 32k streams on a listener - to force a level-2 tree.
> I've also done at least one check with a massive pad in the sctp
> stream structure.

Have you benchmarked at all? Or were you looking at the generated assembly?
