Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2071219476A
	for <lists+linux-sctp@lfdr.de>; Thu, 26 Mar 2020 20:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCZT3O (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 26 Mar 2020 15:29:14 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:46661 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgCZT3O (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 26 Mar 2020 15:29:14 -0400
Received: by mail-qt1-f178.google.com with SMTP id g7so6458424qtj.13
        for <linux-sctp@vger.kernel.org>; Thu, 26 Mar 2020 12:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ApIJ3D3BsLgxAnnVmGWvkp2bTX7/zWP5u5U3Zw1rG9Q=;
        b=DMtSd6UIV5jvqt41SqWRsVn59gmtMifutF371Uk76KNnI8C5Y9Nr6kzqfMhqi67Qr2
         UvvttKozpmNiqVza2UOI3q097NQoqqGODIYqoROIQJ0FMa3vKRmcGp8mphwe365PE/0B
         0QWM15Ds1iCr41M6b39mPGm3BAMOTw9TLG/iZY6+2HdNVZzwqMjglxclP30xetHMpdjk
         /GnU+powzZ69EP5ivfJVL7WJzA7gwi9mHecQhlrAd4QrV9tpADsyPJQKYy7hp5hQr8pu
         jDZNchc+PzEVRkW1X8z+2TA740hapVb5WjPEVqZiyrSnA9ff98HGgwN8jUip17CxzKlW
         y45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ApIJ3D3BsLgxAnnVmGWvkp2bTX7/zWP5u5U3Zw1rG9Q=;
        b=NPtK4F6FJMgQ2/6pQvTLFYvwSNnSilzESiu09OCa6svKHqq1e8t2Boewb8GXW1YNJE
         ytjayq5wI0grshyKmD9cVLM0Af3mePjmR09EHSRSc4KdYYpn6jrXfJtINk0XPBNQiXuE
         5SlDgKoT/qQ5aEZVSo2PrTMPg8bBZmP8Syh8rW6EQuq1zepk//IVpUiffws5Q+Xyl8h9
         hksoK42hhDsfYcGLkcmI9s82KSlYkBZAZPbu3KlCnLmGVXDCzW5Ak8b8XS256T4s6frh
         nF8SBbMshkUqqvnpWd9OTLJ6ll0IDsCIlSQzadjFnDnB5wFdEKVHfmJSjFrmFu+3Fhfi
         EAkQ==
X-Gm-Message-State: ANhLgQ2Huto6DH2syHKxn2fbuUrtmTTgMJ6PwhOrTlaJ4CrU6tq5kx0s
        EIumDflunXGYasWJw8wNnvsEErzJv90=
X-Google-Smtp-Source: ADFU+vsoXvny4FK6fjFDSoSI+jfKoNz473IfWsJs5UPP4xkch2i4/NiHS4XVVTV8wcsY4/afm3j+ow==
X-Received: by 2002:ac8:6918:: with SMTP id e24mr10061596qtr.141.1585250953038;
        Thu, 26 Mar 2020 12:29:13 -0700 (PDT)
Received: from localhost.localdomain ([168.181.48.248])
        by smtp.gmail.com with ESMTPSA id n74sm2030427qke.125.2020.03.26.12.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:29:12 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 01726C5CE4; Thu, 26 Mar 2020 16:29:09 -0300 (-03)
Date:   Thu, 26 Mar 2020 16:29:09 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     "Mao, Jinhui (NSB - CN/Hangzhou)" <jinhui.mao@nokia-sbell.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: One question regarding the SCTP write buffer free mechanism
Message-ID: <20200326192909.GD3828@localhost.localdomain>
References: <9f7ef2f9a93b420c915a9e130356cdfa@nokia-sbell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f7ef2f9a93b420c915a9e130356cdfa@nokia-sbell.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Mar 26, 2020 at 05:22:46AM +0000, Mao, Jinhui (NSB - CN/Hangzhou) wrote:
...
>                        Error happened on Endpoint A when calling SCTP sendmsg to send more to Endpoint B, the error is "Resource temporarily unavailable". Association is not destroyed at this time. 
> 1 second later RTO Timeout 2nd Re-trans DATA [TSN=7] ---------------> (Acked)
> 
> 
> So could you please help to comments on the following question?
> -	Does this means that if an gap is found in the SACK, those packages sent after this lost packet will stay in the write buffer until the gap is filled? Even if they are successfully SACKed?

Yes and yes. Because the receiver is allowed to drop any data acked in
a gap block if it needs more memory to fill in the gap, and in this
case, the sender would have to retransmit it.

Seems you're using non-block sockets, otherwise that last sendmsg()
would have blocked waiting for the sndbuf space to be available, btw.

Cheers,
  Marcelo
