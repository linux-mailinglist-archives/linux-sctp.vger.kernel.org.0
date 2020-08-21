Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10424DBF4
	for <lists+linux-sctp@lfdr.de>; Fri, 21 Aug 2020 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHUQuy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 21 Aug 2020 12:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728737AbgHUQut (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 21 Aug 2020 12:50:49 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA58C061573
        for <linux-sctp@vger.kernel.org>; Fri, 21 Aug 2020 09:50:48 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id b14so1939141qkn.4
        for <linux-sctp@vger.kernel.org>; Fri, 21 Aug 2020 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CDC3PYdoGmkd30PBhrjKlpwuWmwA8di/h1HGcnqH3ZM=;
        b=FJCNchi6oI+s6B+x72qK0N4lqupc2SCo5XffnOlFCCchm1cQTvB5f1WkYzMmofwDld
         bssTmQRGnX8hmxEqO/9NepZ1TwlCAADp0pzQJTYfNMx7QNFQzMN2heeh4LlpT3MI+h7o
         zPR8EVIDDbsZwdkc7b0jiYUeVf11tJA0usnvYceGIefyHqsclJRQzNIBhJ4lfKIOCSNI
         rcbHFdEjVdPxuTmiLwkkzgTFEkuZudPo5W8u1BIt2Lbwj3A7x3xGjERYD/QoYf7d/BKT
         pOuzz6IxCtgQ8+DtF6Lk3NJ74GyFHCERJXvks2g8wTMtSndoLqKyvQ63olQrgvRskLIr
         VAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CDC3PYdoGmkd30PBhrjKlpwuWmwA8di/h1HGcnqH3ZM=;
        b=TJnUrGihB/EC9w4f6L5/vGSpEj5/eaFvn/VzsxyZxCuL/zbnp3qpCJ8CSHCISGBWQP
         zBYbZxcAu5Gv3f/p8yg7W4td7h5L7a1OLtdhi8KB80zaF9GX54bacVPMXNaX6yE9us3h
         dn+iYON+lnAzY82mlK9aRzVMUnxwwF23e0gZjFOkeetWhAyhz2XpixjIzInnac4Otduf
         bkaN/9DCNDRPlpA5aB7rJ/qC8V44yAlCyD7SnY2jDV9NEELk4tjabOIulkwZWXzXxbRT
         gCt8bK/xJSm0uePk0t2vdHW7Oo6C7Ds2K0XVacOINGa38CM0fL1v0HiANSOx7zCB2mVP
         QxBQ==
X-Gm-Message-State: AOAM531tX1HLLNNTug30SYlfWDicUA03BcqGd9ludqamIMujHN1AQOlF
        u6ReU18673fWtKFAg2k9A1KQa906nVHjGw==
X-Google-Smtp-Source: ABdhPJyWlP8QmRJI89DUk7LgcMckFjDeW2b+/VgqspCEwXzVRzKwnyQE8APikpg+ys3oYn/8V2lfXQ==
X-Received: by 2002:a05:620a:15e5:: with SMTP id p5mr3598952qkm.414.1598028648122;
        Fri, 21 Aug 2020 09:50:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:2454:356e:543a:d702:814e])
        by smtp.gmail.com with ESMTPSA id f39sm2571268qta.59.2020.08.21.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 09:50:47 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 20568C35FC; Fri, 21 Aug 2020 13:50:45 -0300 (-03)
Date:   Fri, 21 Aug 2020 13:50:45 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
Subject: Re: 64k streams not supported
Message-ID: <20200821165045.GL3399@localhost.localdomain>
References: <bedd13a72afd427ca4dbbdfa61985533@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bedd13a72afd427ca4dbbdfa61985533@AcuMS.aculab.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Aug 21, 2020 at 03:59:42PM +0000, David Laight wrote:
> Isn't SCTP supposed to support 65536 data streams?

Hm, no? Why?

https://tools.ietf.org/html/rfc4960#section-5.1.1
"After the association is initialized, the valid outbound stream
identifier range for either endpoint shall be 0 to min(local OS,
remote MIS)-1."

Section 3.3.2:
   Number of Outbound Streams (OS): 16 bits (unsigned integer)

      Defines the number of outbound streams the sender of this INIT
      chunk wishes to create in this association.  The value of 0 MUST
      NOT be used.

...

   Number of Inbound Streams (MIS): 16 bits (unsigned integer)


      Defines the maximum number of streams the sender of this INIT
      chunk allows the peer end to create in this association.  The
      value 0 MUST NOT be used.

  Marcelo
