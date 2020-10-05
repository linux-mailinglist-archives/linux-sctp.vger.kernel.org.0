Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2987283D2C
	for <lists+linux-sctp@lfdr.de>; Mon,  5 Oct 2020 19:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgJERQt (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 5 Oct 2020 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgJERQt (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 5 Oct 2020 13:16:49 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29137C0613CE
        for <linux-sctp@vger.kernel.org>; Mon,  5 Oct 2020 10:16:49 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so6351261qvb.13
        for <linux-sctp@vger.kernel.org>; Mon, 05 Oct 2020 10:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aR37ED40uxPV/5pi9yJ7wpOkFqS0NpGvaU5UESZh1oY=;
        b=jJ+WdrIC6cr/0vn3vHskjO4ageI6PwVXutcEylgqrI41JjoOJjQeu9EGrcM4mpwEsJ
         PigZcvI6Et061IEl9zdyj/lyq87d1xiWHUfF7A7ZUNJ/de9iXGTI9tyb8XExbVS5ZcXj
         kcnYv/6KtnxaSeHxnvHMPdhfE7cHpdGpA+xMng+EmqHJ7fQUU2eGOi9ntTf/UeitOlO2
         ku+pkWybmsKhDktVBkqAEPuHLSIbejW2Zw4UcbGQuzNjdmqq7e0cTXAaKFckrMdjMNiq
         XgPBW2ZGHHcrynNcuBu3eTw+txlKRJAmdScy40VAHUh8RQ1FsnccBoIPG7fkKqVKfG+6
         8+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aR37ED40uxPV/5pi9yJ7wpOkFqS0NpGvaU5UESZh1oY=;
        b=dFvhcFzbUnmN+UlsTIQ5f86dhOxZ8+ht9YT9WDyrX2NKQsrBPOX5difUTlxNl4bWqQ
         mP95kaQYMo5iRayJPSJzTJAECoAlawG+PR0RUGxDWvd1IoGnMaXEtpy4KYqqmQAzXUsX
         iBYTkP2GY/NELrF0uXVVfaGrACNweO9ZlabbRHBZZ7NOxwBjzdzu9PNkS+gI/jh8OWI1
         p5/jQiHpvll+W2VEuB/uIn5wTI3Ehwb5rwKFeu5cTHslRlG/tx5hviYEzLHS4UwRIngE
         Kns4NzYzvUQf2vp2cnIpAzAXRaCbd2QYYGdLm7SJmq4qOLgiVL/T9Oq71CDCgnvv7SNu
         /Grw==
X-Gm-Message-State: AOAM531lqgE4mZBW/W2vp3OBoCNh9D30f2Mb0VrJgjxEPhFrEXcliRSF
        wxdTfFQOPY0Dbn6QJJhzbqUNM8Hm91VK2Q==
X-Google-Smtp-Source: ABdhPJyObRARN0eHDSoVj7XgrsE1PCm9A/C+5nssqwoD2cqn7pZFfB/G4Ac+H1ZcoFvSVI9MaEev+A==
X-Received: by 2002:a0c:c407:: with SMTP id r7mr752393qvi.36.1601918208193;
        Mon, 05 Oct 2020 10:16:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:baaa:60d4:792a:514f:982c])
        by smtp.gmail.com with ESMTPSA id 7sm461838qkc.73.2020.10.05.10.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:16:46 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id DC483C619C; Mon,  5 Oct 2020 14:16:43 -0300 (-03)
Date:   Mon, 5 Oct 2020 14:16:43 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Andreas Fink <afink@list.fink.org>
Cc:     linux-sctp@vger.kernel.org
Subject: Re: Heartbeat on closed SCTP sockets?
Message-ID: <20201005171643.GK70998@localhost.localdomain>
References: <1FB70B30-857C-4CD9-A05C-4BA15F57B1D2@list.fink.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1FB70B30-857C-4CD9-A05C-4BA15F57B1D2@list.fink.org>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

On Mon, Oct 05, 2020 at 06:39:22PM +0200, Andreas Fink wrote:
...
> What we now see in netstat --sctp is:
> 
> we have a LISTEN on port 2010
> we have a  association from port 2010 to the remote in status CLOSED
> 
> in tcpdump we see packets coming in from the remote and heartbeat being acknowledged. However our application is not answering to these packets and the status of the application shows SCTP being down.
> In other words, my application sees the association down. Netstat shows the association as being closed but the kernel seems to continue to entertain this association by continue to send heartbeat ACK and not sending ABORT.

That's weird. If it is in CLOSED, then the stack should be handling
it as an OOTB packet and trigger an Abort.

> 
> We now kill the application
> 
> What we now see in netstat --sctp is:
> we no longer listen on port 2010
> we have a closed association from port 2010 to the remote.
> 
> in tcpdump we however we STILL see packets coming in from the remote and heartbeat being acknowledged, even though no application is listening on this port and no userspace application is using that port.
> We do not see any SHUTDOWN or INIT even if we restart the application.
> 
> Can anyone explain how this can be?

Please check the assoc status as well, via 'ss -a --sctp' and
/proc/net/sctp/assocs . Maybe it got out of sync of the socket status.

  Marcelo
