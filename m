Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6C31A923A
	for <lists+linux-sctp@lfdr.de>; Wed, 15 Apr 2020 07:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393192AbgDOFBm (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 15 Apr 2020 01:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393186AbgDOFBK (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 15 Apr 2020 01:01:10 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20882C061A0F
        for <linux-sctp@vger.kernel.org>; Tue, 14 Apr 2020 22:01:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb4so232674qvb.7
        for <linux-sctp@vger.kernel.org>; Tue, 14 Apr 2020 22:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ef3HLI/XX5ogd42JRuoGnEbb/Ln3ZxgvuLj5jaeUWkI=;
        b=Tcxzc6xC3iVTZShTUf3CIv3N8B5ZyCbru12fLV5+tpVooL5/Bo3MM2R4w1+y/qKNnw
         9lu0zJBRs+VK1Bc14YzwiZC+K/efs95VT8GzxaoJoz3t2WhfDZxWX+BgsMNU20r8wRPv
         WS98QN/V8NZIzymtO0juNqdA9Tg6/2OTyjU7Zm1KL9ejebzf7wo1d0uOEsRrlg17M8fg
         qYmffi6H6MwGLJe4epZjwPPvjWIdIXS0xtejpuhYYUqQSrz2GfoywvJh6tC6sCJVyKe7
         xzOQhWdIv/o82YQJCk9DtMPUw2B8iLWuNwugd4l1OepDEbLixuOHRPHRALsrInJO+Rsn
         o1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ef3HLI/XX5ogd42JRuoGnEbb/Ln3ZxgvuLj5jaeUWkI=;
        b=emuP8o6cuW+QDmZZxxgWOqZNvM3PE1EY6Vhsg2UPMzH+rtlDi8MAw92RaJEsM1xDws
         9OjSK7ZfYorYdlfkVyWvwxhu4utcfo6DN6R7IVaNubUdsLSCvadCluH/sn58cNJsOfMY
         UZ07Hxzzal+fKHG0HdB2lX1AJu+ConLVoCQJz+3xlQWn4rOrBFg9vJIHKSIU20w4Qaxa
         uYkEofKLXrI0O/3t2TJbDB7HWP1zEO79jPpg8fLwOlpIvGUuzPMzZIpiMAJbDRC9zn7C
         KUU/R/xN/MJ1NAfldPsNr575L9IG4/t3GKCLE4loTIgxTXFiGryDCM1Wm59yrDbAZEvn
         cZ2w==
X-Gm-Message-State: AGi0PuaM8PCmFq+AR2dMsqAEMdt6UQEa/RItZNtTOvA+6jIrzOIfTqYv
        pDDIuyEELHfjRoXAyJbWZGzRhw==
X-Google-Smtp-Source: APiQypJRjg+PyUSZjrIkjpxdMfgyPb9bMEWnffTFRMxoE1aQMUITXzNurR0P/0BN6q0H0W5xTyhSBA==
X-Received: by 2002:a0c:e88d:: with SMTP id b13mr3243342qvo.245.1586926868219;
        Tue, 14 Apr 2020 22:01:08 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id 10sm6168833qtp.4.2020.04.14.22.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 22:01:07 -0700 (PDT)
Date:   Wed, 15 Apr 2020 01:01:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-crypto@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-ppp@vger.kernel.org,
        wireguard@lists.zx2c4.com, linux-wireless@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fscrypt@vger.kernel.org, ecryptfs@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-bluetooth@vger.kernel.org,
        linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-nfs@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        cocci@systeme.lip6.fr, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/2] mm, treewide: Rename kzfree() to kfree_sensitive()
Message-ID: <20200415050106.GA154671@cmpxchg.org>
References: <20200413211550.8307-1-longman@redhat.com>
 <20200413211550.8307-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413211550.8307-2-longman@redhat.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Mon, Apr 13, 2020 at 05:15:49PM -0400, Waiman Long wrote:
> As said by Linus:
> 
>   A symmetric naming is only helpful if it implies symmetries in use.
>   Otherwise it's actively misleading.

As the btrfs example proves - people can be tempted by this false
symmetry to pair kzalloc with kzfree, which isn't what we wanted.

>   In "kzalloc()", the z is meaningful and an important part of what the
>   caller wants.
> 
>   In "kzfree()", the z is actively detrimental, because maybe in the
>   future we really _might_ want to use that "memfill(0xdeadbeef)" or
>   something. The "zero" part of the interface isn't even _relevant_.
> 
> The main reason that kzfree() exists is to clear sensitive information
> that should not be leaked to other future users of the same memory
> objects.
> 
> Rename kzfree() to kfree_sensitive() to follow the example of the
> recently added kvfree_sensitive() and make the intention of the API
> more explicit. In addition, memzero_explicit() is used to clear the
> memory to make sure that it won't get optimized away by the compiler.
> 
> The renaming is done by using the command sequence:
> 
>   git grep -w --name-only kzfree |\
>   xargs sed -i 's/\bkzfree\b/kfree_sensitive/'
> 
> followed by some editing of the kfree_sensitive() kerneldoc and the
> use of memzero_explicit() instead of memset().
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Looks good to me. Thanks for fixing this very old mistake.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
