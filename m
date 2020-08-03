Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE4E23ABC8
	for <lists+linux-sctp@lfdr.de>; Mon,  3 Aug 2020 19:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgHCRmh (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 3 Aug 2020 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCRmg (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 3 Aug 2020 13:42:36 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB29C06174A
        for <linux-sctp@vger.kernel.org>; Mon,  3 Aug 2020 10:42:36 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 77so3607447qkm.5
        for <linux-sctp@vger.kernel.org>; Mon, 03 Aug 2020 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bs6We3ZLpODlu7JZJsSCHbXdmYZgvCjlmRsqx2S8/bc=;
        b=RBOtuppn/beIUkniv+THPjtTnQolx61D3EF1+pZIdvINfco3VB9KGr/7IfddBNpdla
         Ic4DozukMQ3L3y2n/mXrriz+KAsC3iYKYk+0Bs251k/n0Z945fqJ+OVsFYfzYXYZ4+38
         ih7ETVwyFaVONU9m/uvKMPCG4QSYoiVu3TmdJM+d0jLlQaxaab781MWIBRbs7DXH8MmD
         GQpb3u8DcrV/4TLfjTZWvREFt0JGuwwG6cyD+iz4FIjBbKLR8nTJ13WI5Z/ZUJFrv1kV
         WlXg+d+4YeUmv3IjySI4FlJFqgwLC+PKziUTl8lX/u4AIMSFhp/dj4I6umrLDrlhvr4r
         fhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bs6We3ZLpODlu7JZJsSCHbXdmYZgvCjlmRsqx2S8/bc=;
        b=RvD2d/Okm5FtxJyglCMc/f0nKLz5Rh3JYjBqdXgk2LE9zViCMn1Uc7SrD1q9CTqdRJ
         lXbkJjmqbG0Wr/KsoUHXk+jO5WVZ1jBnJcjyt507q3EbgAs018J0QRzHSisSJOnBdCrk
         yMDtg8MIRI0qPs01J0I2FZkUWxXMJe9z+xukw6oOJ53koJ55dUbxihoXgkokLfxcpT32
         585itDzwS5vglpIxxrEAwC+m+HpqS3atNwGWYH2GGIZ9anZzzYjM2pikrxeJ2eEyBQ+K
         /XLWodhE6VfBAZRwnJr6EvLCyIKyf5IJJHoygRhTrLqYfPEcyCF6Rp1mQPs31kD7xLST
         EUOg==
X-Gm-Message-State: AOAM533kjB9F1GOeeY0qH1t7FJ+D+GbQY9wNJpqfgYWfIAEDRovfMn8q
        3C8pWrYRb9v61PRWEPfdOfM=
X-Google-Smtp-Source: ABdhPJzjROiXzrxW3132924pKFEW5bGREo3vNhsA796Oi4t77WMz46PXGDmdcGJWwoAX+Tg2t2hDeQ==
X-Received: by 2002:a37:4d90:: with SMTP id a138mr15797182qkb.363.1596476555771;
        Mon, 03 Aug 2020 10:42:35 -0700 (PDT)
Received: from localhost.localdomain ([138.204.24.108])
        by smtp.gmail.com with ESMTPSA id l13sm20908248qth.77.2020.08.03.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:42:35 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 8F328C08EB; Mon,  3 Aug 2020 14:42:32 -0300 (-03)
Date:   Mon, 3 Aug 2020 14:42:32 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     sonia bhattacharya <soniaruby1@gmail.com>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: Regarding kernel SCTP module compliance to 4960
Message-ID: <20200803174232.GE3399@localhost.localdomain>
References: <CAMyZL9pE+343HvMHuci=+2aKS4HrtuL2GJ2oVwxw7PfL7=doKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMyZL9pE+343HvMHuci=+2aKS4HrtuL2GJ2oVwxw7PfL7=doKQ@mail.gmail.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Aug 03, 2020 at 03:53:35PM +0530, sonia bhattacharya wrote:
> Hi Team,
> 
> 
> 
> Is there a plan to upgrade the linux SCTP kernel module to be
> compliant to RFC 4960?
> 
> Right now, it is compliant to RFC 2960.
> 
> 
> description:    Support for the SCTP protocol (RFC2960)

Hi Sonia,

There are several references to old RFCs throughout the code, just
because they weren't updated to the newer versions. But in regards to
your question, Linux SCTP kernel code is compliant to RFC4960 already.
If you notice anything particular missing, it's a bug. :-)

Thanks,
Marcelo
