Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944625F6794
	for <lists+linux-sctp@lfdr.de>; Thu,  6 Oct 2022 15:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiJFNPy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 6 Oct 2022 09:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiJFNPp (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 6 Oct 2022 09:15:45 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBB5A9246
        for <linux-sctp@vger.kernel.org>; Thu,  6 Oct 2022 06:15:38 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id l27so921082qtv.4
        for <linux-sctp@vger.kernel.org>; Thu, 06 Oct 2022 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=GSOPunDdTF0UIVvBpION9xBpexDiGo+rjOxipFbXtOA=;
        b=j4TXfdYhCC5IuPEKT7c142DGOyyUICiYEJ2rQ5pM4q0yiZx4WA0kHStxgeCysxKdIn
         TuxQmiKuGnCh2iLv5lCSAeVvdfZCgr0gslAO6C/wmbiJpJE+HGv9p0BlGAp2YHTd7MAZ
         JFShEKjZddNRI3EB69zxWrjNCIn5FEtT938q5Kh600byBOTgEAyr3Cw5BxKLykg6qGKZ
         putHsZDuOr6KOj1BUasiDhf52tRH/Ed62HmMrAEpEsYDeTWjqgqViGX5p251folDWhG6
         /9qz6hzxVHLZMa8vddlM+hc6XFLs5D7qWuuoVr7OgpiuiN/JdE0keFKPOZzvhwuMVbjX
         g/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=GSOPunDdTF0UIVvBpION9xBpexDiGo+rjOxipFbXtOA=;
        b=qHFmsh3YT4IEq0GAYykGu7UPL7vt6O0980N7Y+MlyVqrQCoi1g9DMLsrWqtp8a+7AZ
         TCsDEVSMeFV1obD9NfxoxZGx6KEgKiEDQkXwTuwZBX4wHgqKW7HyRyHT4bWMne+bf1Se
         xLIpOxHHOcQ9wHL6jJuceKjLn/GmebVcXTY5wG4kzbuui9AF+h3teVT6Yl5U1sF6Uklq
         m2Sov90ZLoBbRzPI06vMCkPgoG0/TdrFRG1BQqlLqTiAv3RFTsIzOiqxzlO7SG3jidMe
         yCOdpHyV5KaU8Cy7kl35cUdT4Lv6br0Aa+TZYMAd4vNNBbOzE9fxRP2Zy9R/ut/WZdlG
         wpqw==
X-Gm-Message-State: ACrzQf2WgjUXDfErIXYQG0eQu3a2CsoQCEJtUgyNHd/NU6QKddv0isrW
        HnL84Hm5Tlm2nIHo9GB+ioJ4qw==
X-Google-Smtp-Source: AMsMyM4GpHypPhwf4qnIOCDMCCPPCaDHHZXra2UnB6U4hePjwcf7/TKsWZTRJwrBHYFFgt7B+K7zfA==
X-Received: by 2002:ac8:5703:0:b0:35c:c3f6:5991 with SMTP id 3-20020ac85703000000b0035cc3f65991mr3383265qtw.185.1665062137334;
        Thu, 06 Oct 2022 06:15:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006cbc6e1478csm18686320qkh.57.2022.10.06.06.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 06:15:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1ogQit-00A1hY-6O;
        Thu, 06 Oct 2022 10:15:35 -0300
Date:   Thu, 6 Oct 2022 10:15:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
        cake@lists.bufferbloat.net, ceph-devel@vger.kernel.org,
        coreteam@netfilter.org, dccp@vger.kernel.org, dev@openvswitch.org,
        dmaengine@vger.kernel.org, drbd-dev@lists.linbit.com,
        dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com,
        linux-actions@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mm@kvack.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-raid@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-sctp@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-xfs@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, rds-devel@oss.oracle.com,
        SHA-cyfmac-dev-list@infineon.com, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH v1 3/5] treewide: use get_random_u32() when possible
Message-ID: <Yz7U99PPl8uHCLFY@ziepe.ca>
References: <20221005214844.2699-1-Jason@zx2c4.com>
 <20221005214844.2699-4-Jason@zx2c4.com>
 <Yz7OdfKZeGkpZSKb@ziepe.ca>
 <CAHmME9r_vNRFFjUvqx8QkBddg_kQU=FMgpk9TqOVZdvX6zXHNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9r_vNRFFjUvqx8QkBddg_kQU=FMgpk9TqOVZdvX6zXHNg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Oct 06, 2022 at 07:05:48AM -0600, Jason A. Donenfeld wrote:

> > > diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > > index fd9d7f2c4d64..a605cf66b83e 100644
> > > --- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > > +++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
> > > @@ -465,7 +465,7 @@ static int ipoib_cm_req_handler(struct ib_cm_id *cm_id,
> > >               goto err_qp;
> > >       }
> > >
> > > -     psn = prandom_u32() & 0xffffff;
> > > +     psn = get_random_u32() & 0xffffff;
> >
> >  prandom_max(0xffffff + 1)
> 
> That'd work, but again it's not more clear. Authors here are going for
> a 24-bit number, and masking seems like a clear way to express that.

vs just asking directly for a 24 bit number?

Jason
