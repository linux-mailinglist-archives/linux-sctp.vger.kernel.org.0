Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A7429447B
	for <lists+linux-sctp@lfdr.de>; Tue, 20 Oct 2020 23:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387497AbgJTVXn (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 20 Oct 2020 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733224AbgJTVXn (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 20 Oct 2020 17:23:43 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B5DC0613CE;
        Tue, 20 Oct 2020 14:23:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id f5so1709370qvx.6;
        Tue, 20 Oct 2020 14:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cMSYhjEnFDdNhRNe3VJVMFxOtUJLDIrZ6OU7jezubGI=;
        b=GmnkPbZt9ewO5WfeZ5d2ISNg3iVIyOiFRd8xlfp5QpsTv/kQ2mtpJS6T8VKl6hHQOD
         8f/aFP/3PlG/CM/YejFQp+JRFCMQrtcIIABus89qXFfHx8J7WEowlTRlLyXvjaG5K9DT
         PvUGdcLImupCTc1MUBi2QU8WS9G95mNfnLQIi2eowehGqNJl7/0GoCLJGO/Opcj4HNRX
         ZQOj0qSkYqId8ITuFIkC4Qu1KnQPt3RefKctKwQACKoImXoWMBI92hSqi9XRTxq/BG4k
         yMzRTOyG0KXGal4Fcom3maRxOMVop0GYVzWYGAjQYdd03fEgt5cpbma1s1CJ4Qr2XYAB
         3oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cMSYhjEnFDdNhRNe3VJVMFxOtUJLDIrZ6OU7jezubGI=;
        b=AFsYYqtaUdLM2WdYLMwSuVRlVfj2SV0Z2agvfLX4I/tW5uV6b8jFiN+3vunbPAK8Ck
         098RtCA+jD9JtnzdyioHznId4zyWIrtk0mvYbvkumfYDukfzI4/UVYIF1w5cbeFRC22w
         JXaUyoCqeKxFDaU5wkXX3EhMSkZLsdj0mAu3DTpKqtbPOxF48giwf7mOOqn8OIt14zph
         /9brU1ucs2G9fwPaGE/Le1NQfcNwoON/o1dHLjuGk+wLC0S577nVbb0HqjmUEhAki6aP
         UsHiKGkJOKoz9J+Ym0iknoUGV83G3Y6eI/YV0uA4tqcPmpGELi4JJsRUFC9MeRjVkrz6
         Sr8Q==
X-Gm-Message-State: AOAM5308y6CAJZNESA3eVqg6rO3qpae/mZmc0Vq3MbXPpr7hP5InTLYT
        eHPKAoqO7E6XAuVh0bpobyc=
X-Google-Smtp-Source: ABdhPJyXzQIpE2jNOefmtQ3a85elEFOXmy1WEaznBjkmX0vO+7IuwP2CnpOP4Gzz9LAMEFLsPvAD5A==
X-Received: by 2002:a05:6214:4ae:: with SMTP id w14mr5537065qvz.5.1603229022038;
        Tue, 20 Oct 2020 14:23:42 -0700 (PDT)
Received: from localhost.localdomain ([177.220.172.69])
        by smtp.gmail.com with ESMTPSA id o193sm101850qke.12.2020.10.20.14.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 14:23:41 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id C8310C1632; Tue, 20 Oct 2020 18:23:38 -0300 (-03)
Date:   Tue, 20 Oct 2020 18:23:38 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Michael Tuexen <tuexen@fh-muenster.de>
Cc:     Xin Long <lucien.xin@gmail.com>,
        network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        davem <davem@davemloft.net>, Guillaume Nault <gnault@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCHv4 net-next 16/16] sctp: enable udp tunneling socks
Message-ID: <20201020212338.GG11030@localhost.localdomain>
References: <cover.1603110316.git.lucien.xin@gmail.com>
 <b65bdc11e5a17e328227676ea283cee617f973fb.1603110316.git.lucien.xin@gmail.com>
 <20201019221545.GD11030@localhost.localdomain>
 <CADvbK_ezWXMxpKkt3kxbXhcgu73PTJ1zpChb_sCgDu38xcROtA@mail.gmail.com>
 <20201020211108.GF11030@localhost.localdomain>
 <3BC2D946-9EA7-4847-9C6E-B3C9DA6A6618@fh-muenster.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BC2D946-9EA7-4847-9C6E-B3C9DA6A6618@fh-muenster.de>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Oct 20, 2020 at 11:15:26PM +0200, Michael Tuexen wrote:
> > On 20. Oct 2020, at 23:11, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> > 
> > On Tue, Oct 20, 2020 at 05:12:06PM +0800, Xin Long wrote:
> >> On Tue, Oct 20, 2020 at 6:15 AM Marcelo Ricardo Leitner
> >> <marcelo.leitner@gmail.com> wrote:
> >>> 
> >>> On Mon, Oct 19, 2020 at 08:25:33PM +0800, Xin Long wrote:
> >>>> --- a/Documentation/networking/ip-sysctl.rst
> >>>> +++ b/Documentation/networking/ip-sysctl.rst
> >>>> @@ -2640,6 +2640,12 @@ addr_scope_policy - INTEGER
> >>>> 
> >>>>      Default: 1
> >>>> 
> >>>> +udp_port - INTEGER
> >>> 
> >>> Need to be more verbose here, and also mention the RFC.
> >>> 
> >>>> +     The listening port for the local UDP tunneling sock.
> >>>        , shared by all applications in the same net namespace.
> >>>> +     UDP encapsulation will be disabled when it's set to 0.
> >>> 
> >>>        "Note, however, that setting just this is not enough to actually
> >>>        use it. ..."
> >> When it's a client, yes,  but when it's a server, the encap_port can
> >> be got from the incoming packet.
> >> 
> >>> 
> >>>> +
> >>>> +     Default: 9899
> >>>> +
> >>>> encap_port - INTEGER
> >>>>      The default remote UDP encapsalution port.
> >>>>      When UDP tunneling is enabled, this global value is used to set
> >>> 
> >>> When is it enabled, which conditions are needed? Maybe it can be
> >>> explained only in the one above.
> >> Thanks!
> >> pls check if this one will be better:
> > 
> > It is. Verbose enough now, thx.
> > (one other comment below)
> > 
> >> 
> >> udp_port - INTEGER
> >> 
> >> The listening port for the local UDP tunneling sock.
> >> 
> >> This UDP sock is used for processing the incoming UDP-encapsulated
> >> SCTP packets (from RFC6951), and shared by all applications in the
> >> same net namespace. This UDP sock will be closed when the value is
> >> set to 0.
> >> 
> >> The value will also be used to set the src port of the UDP header
> >> for the outgoing UDP-encapsulated SCTP packets. For the dest port,
> >> please refer to 'encap_port' below.
> >> 
> >> Default: 9899
> > 
> > I'm now wondering if this is the right default. I mean, it is the
> > standard port for it, yes, but at the same time, it means loading SCTP
> > module will steal/use that UDP port on all net namespaces and can lead
> > to conflicts with other apps. A more conservative approach here is to
> > document the standard port, but set the default to 0 and require the
> > user to set it in if it is expected to be used.
> > 
> > Did FreeBSD enable it by default too?
> No. The default is 0, which means that the encapsulation is turned off.
> Setting this sysctl variable to a non-zero value enables the UDP tunneling
> with the given port.

Thanks Michael.
Xin, then we should change this default value (and update the
documentation above accordingly, to still have the standard port #
readily available in there).

Cheers,
Marcelo
