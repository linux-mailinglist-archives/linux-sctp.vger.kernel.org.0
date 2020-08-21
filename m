Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BD524E1FC
	for <lists+linux-sctp@lfdr.de>; Fri, 21 Aug 2020 22:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgHUURJ (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 21 Aug 2020 16:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgHUURI (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 21 Aug 2020 16:17:08 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA930C061573
        for <linux-sctp@vger.kernel.org>; Fri, 21 Aug 2020 13:17:08 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l13so1186001qvt.10
        for <linux-sctp@vger.kernel.org>; Fri, 21 Aug 2020 13:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JzsH0ilNEjaGy9OTCTCj70bXfI2kjW/e/ywge/KQlx0=;
        b=j4OlOzjf6jVdyzDLJvxh+BkHA66mR4yEpi4h8H27TMtWoanbs3atJ2xC0hqD5H5Xla
         DBs3qcWlZQ9gN3ze54etjcvlQkPoEMO2DgCWtoP/cmeZTm5/BmOIS0a1oMoeb/CkgbP+
         TMI4GOlJXqtNHcNoXv5qVMi9vqNJfgeqjvH2C/AQZsAmiBPWDlnwXxIf1WqKnRjJ/t7R
         OYocsm6CocnwBNV73AI91emgv0Bax5WcetyMaGWFzfgJqx/D60/I78smA8hXHjffCZJy
         mwvcKMh+/LSjnNDEseUF7YJge0E4ObabOnMCl2y8X1JOJX+MjXXKWgUEiVD2+bFnmJNe
         r4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JzsH0ilNEjaGy9OTCTCj70bXfI2kjW/e/ywge/KQlx0=;
        b=Ihq3MNH83NsFgaGpsYHNKQQJF3V+K5Fk3D12KasOPDCPo4fQT314MD3tRUxLJy37rj
         vIX5fdlrFKjcv3XkWFLRKH3UzJrQ0M+fyG/Vd2i/w/4gmFqd5GGTSB3Ew3fod9rIK8SV
         DlYhBxNpda2aq6ointGFDwg6DGLagLzBS8+ZiRok+a1ZDzHF1Yupsyb20vQviw5bo1w5
         +KuCLt2AedqAYu0g9x3YJDRoAYxhDmuaK+LrpWjxlbNE4weUyFtlHNshnmzbOZ8qhwcR
         E0Eb9IAsQzL9yaB7AgvB+jmiTdQyPymfPG2BiTpzBbycuszhGrZ54YB+3YXxNq1B7+3n
         bpCA==
X-Gm-Message-State: AOAM531H9XgvIbRKYfdouwQ+yB22iWtdol4O6r65SnqSnfKFHZun8lcU
        ilvLRTOU2vaKGFoVEroeOnO4Rs34YXLvfg==
X-Google-Smtp-Source: ABdhPJyHtel10olZlrZebQ/zPVxz0M6+faeaPBSqgyTifoug8HzCplstosAx2CCvas86c+Il0wfsfQ==
X-Received: by 2002:ad4:4992:: with SMTP id t18mr3719108qvx.193.1598041027901;
        Fri, 21 Aug 2020 13:17:07 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f013:2454:356e:543a:d702:814e])
        by smtp.gmail.com with ESMTPSA id b8sm2526081qkk.136.2020.08.21.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 13:17:07 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id E34EDC35FC; Fri, 21 Aug 2020 17:17:04 -0300 (-03)
Date:   Fri, 21 Aug 2020 17:17:04 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Pau Espin Pedrol <pespin@sysmocom.de>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: SCTP multi-homed association (::1)->(::1+127.0.0.1) attempting
 HEARTBEAT on 127.0.0.1->127.0.0.1
Message-ID: <20200821201704.GN3399@localhost.localdomain>
References: <552de663-8aeb-ff84-a425-988da88ca5cd@sysmocom.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <552de663-8aeb-ff84-a425-988da88ca5cd@sysmocom.de>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi Pau,

On Thu, Aug 20, 2020 at 01:11:02PM +0200, Pau Espin Pedrol wrote:
> Hi all,
> 
> I just submitted the following SCTP bug in the kernel bugtracker. I
> placed it under "IPV6" category since there's no "SCTP" category
> available there. It may be worth asking whoever is in charge to add the
> category so the relevant maintainer is assigned?

We actually don't use that bugzilla.

> 
> https://bugzilla.kernel.org/show_bug.cgi?id=208969
> 
> PS: I'm not registered to the ML, plese keep me in CC.

Aye. But gotta say, you might want to subscribe. It's really low
volume, and will get you aware of recent fixes.

By your description in the bug, seems we fixed it in June. Can you
confirm that your kernel doesn't have this commit in?
471e39df96b9 ("sctp: Don't advertise IPv4 addresses if ipv6only is set
on the socket")

Regards,
Marcelo
