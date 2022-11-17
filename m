Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7AB62DA72
	for <lists+linux-sctp@lfdr.de>; Thu, 17 Nov 2022 13:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiKQMOI (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 17 Nov 2022 07:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiKQMOH (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 17 Nov 2022 07:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504626F35C
        for <linux-sctp@vger.kernel.org>; Thu, 17 Nov 2022 04:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668687185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D5j9DmJftbiNuyWuQp4J4DaVBp6LHbVnovAFrJEquk4=;
        b=AyERdWz9WyjvQxT/gdl+RwEQT6Yf1Q2SRkkjWcBRhhCW4j5tADei8vwroOYgXuPFUIIGlL
        vpwAY21lQR6PoZpMxxrP5Z9AJDOQiW63q/4eo0hrpm7WJb5eZcNdphPGX1p2o8ogOD+6Ns
        JdJWb7N2/evjpqHXOhbNiPUtAAl/K9E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-2htokV1zO4u-jdrcsmkzpw-1; Thu, 17 Nov 2022 07:13:04 -0500
X-MC-Unique: 2htokV1zO4u-jdrcsmkzpw-1
Received: by mail-wr1-f69.google.com with SMTP id i12-20020adfaacc000000b0023cd08e3b56so625001wrc.12
        for <linux-sctp@vger.kernel.org>; Thu, 17 Nov 2022 04:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5j9DmJftbiNuyWuQp4J4DaVBp6LHbVnovAFrJEquk4=;
        b=YSqbkJarPDFr3cAiK79tYLVrQx/2B7adwl7rALOSfpOp0X8UUPuhNAw75KYM0UNZoe
         xLXCL+P/81etVS1LuSTmeZnsJvZt+JeGJlJsNp1Wgjdt2Me2PTssSiZQ5LEJNPp/oIQB
         dxEFHJi/EThT+azy9kwsQYeTxCMkvJunIjvHrrHJEWGWL/7l8LIlq6rkJEblLNKYB0H9
         s+WXWIBg+roTWB1dTdjHtcKqPxmNbqOzjGbnENUjW9/s1Q1aaklZDBmS5s3V2i+AwJUk
         gz9nhqdlePuzy6vyQtvG/yqLFKNOx12P8C/njTDTKM0xxHfY8D5mndK9EwRyw7K+1jvo
         nVIQ==
X-Gm-Message-State: ANoB5pk+0l6gjspzWbOkY7OjNbCRXGc3/fOzNWclTBWNSmWBIBZXK/sU
        wwqQj4dcjPsVTT/GzWVTCjIRv5RjAA810nRe+1asLyINPl3EtOp2fEs4akM1EO6QBU8uhM/7Cwr
        XD57dP1P8XGbhUd5JxzWbdQ==
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id d24-20020a1c7318000000b003cfcb16f24amr4940542wmb.182.1668687183221;
        Thu, 17 Nov 2022 04:13:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf45Fdyv1heAo7QA/P1UGM3QqYUDdP9AyD2QFRZJEGDSgoiGR7WkHocJh68ff65K5BiMjVG/Ig==
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id d24-20020a1c7318000000b003cfcb16f24amr4940530wmb.182.1668687183035;
        Thu, 17 Nov 2022 04:13:03 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003cf7292c553sm1022914wma.13.2022.11.17.04.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:13:02 -0800 (PST)
Message-ID: <1c43f0836d741a575b4805292d6dfff134ef6225.camel@redhat.com>
Subject: Re: [PATCH] sctp: sm_statefuns: Remove unnecessary
 =?UTF-8?Q?=E2=80=98NULL=E2=80=99?= values from Pointer
From:   Paolo Abeni <pabeni@redhat.com>
To:     Li zeming <zeming@nfschina.com>, vyasevich@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Nov 2022 13:13:01 +0100
In-Reply-To: <20221115015508.3054-1-zeming@nfschina.com>
References: <20221115015508.3054-1-zeming@nfschina.com>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

On Tue, 2022-11-15 at 09:55 +0800, Li zeming wrote:
> The packet pointer is assigned first. It does not need to initialize the
> assignment.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

I'm sorry, but IMHO the commit message is quite unclear, I suggest to
re-phrase to something alike:

"""
The 'packet' pointer is always set in the later code, no need to
initialize it at definition time.
"""

Thanks,

Paolo

