Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91218CBA41
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Oct 2019 14:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfJDMV0 (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 4 Oct 2019 08:21:26 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43645 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfJDMVZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 4 Oct 2019 08:21:25 -0400
Received: by mail-qk1-f195.google.com with SMTP id h126so5543771qke.10;
        Fri, 04 Oct 2019 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oW2hdSxUwj6zigjCRdKN/adJRGkeCADTXcLhco9vW8o=;
        b=Z6fi+61dZe9VPNhhV5llPcsEZfTg5MFF+0am3ZP4k17lvg0FUaM6fT+XxbhW+P7XWN
         I7SVB5pRUvtzvobjePjSZRQ3SI+rNiNSxbrNeMRzVa0wxUHHV+IhrY5nqDu/hfy/kz7K
         nWD3mUfnRnD7pl4ZsJDm+47cnf7f3ECTKo0f5R4urJ/6TFbgwByBQtGW4MXNPPgw6E7a
         3onj92FRo9lKo2hx71nW7bLzmWxx+EsjcLlC1SndzhGocDFVCVGSlP7OG1NJwCGKHGKN
         xhFZPGCw4Km9o9kR+44v67NjbtnsfZcihezQF4IuSd3QHVJL6JkucwzYgQ/ZJeKlv4gH
         kOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oW2hdSxUwj6zigjCRdKN/adJRGkeCADTXcLhco9vW8o=;
        b=QxyfFltjUOsN1ZMRyzXBkYEoslj5iL2zWowGB6WAOaE61H3F5jbVVbS6lmXlce/omN
         T8vOVN96lGHGfepjyW0epjXp1er4yr1OSWujkcwlA1YP/7jU0tOF6J7X5QvotcDS7vAN
         65giDdb6f5ZALlGjzqLESnNcTM4PoCExZ6C2K00BI5EYLTZYkFiOWGTpXiasAycM92TR
         ZIXzFwy1uXTmMlpw/1lAatcZ6m9EaTytRob9AJIZOpMLaBP0tmRbfWH8Ax2EdLv9tnbc
         sbHrFvgjL1x8bgsKXsdOHEb4RcukdQ1Wx4FkpQX18eVfT098QB2Rh7Z12Wup5KScyP2P
         ShxQ==
X-Gm-Message-State: APjAAAWG5D128XCZjAUNTcxqfutLgtrzFsdLf681DE6J42q99JBBwQ2r
        rW0hOUJomVN4ngbivrhv2/Q=
X-Google-Smtp-Source: APXvYqy9h9CTrfBdrghAbzD8MXmouTtoRCjXV6Lu5u3/Bq6O4VbODljNgBcCnnzGRkhrH0PW60ZRTQ==
X-Received: by 2002:a37:6713:: with SMTP id b19mr9250779qkc.301.1570191683876;
        Fri, 04 Oct 2019 05:21:23 -0700 (PDT)
Received: from localhost.localdomain ([2001:1284:f016:43d:1f86:9ada:9b75:29f5])
        by smtp.gmail.com with ESMTPSA id x55sm4262933qta.74.2019.10.04.05.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 05:21:23 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id A464AC07B9; Fri,  4 Oct 2019 09:21:20 -0300 (-03)
Date:   Fri, 4 Oct 2019 09:21:20 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] lib/generic-radix-tree.c: add kmemleak annotations
Message-ID: <20191004122120.GP3431@localhost.localdomain>
References: <CACT4Y+aGjg_JTL-OPMSi1wS4=Zy4xFAizWW5fa8_KMOFpfMeXg@mail.gmail.com>
 <20191004065039.727564-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004065039.727564-1-ebiggers@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, Oct 03, 2019 at 11:50:39PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Kmemleak is falsely reporting a leak of the slab allocation in
> sctp_stream_init_ext():
> 
> BUG: memory leak
> unreferenced object 0xffff8881114f5d80 (size 96):
>    comm "syz-executor934", pid 7160, jiffies 4294993058 (age 31.950s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<00000000ce7a1326>] kmemleak_alloc_recursive  include/linux/kmemleak.h:55 [inline]
>      [<00000000ce7a1326>] slab_post_alloc_hook mm/slab.h:439 [inline]
>      [<00000000ce7a1326>] slab_alloc mm/slab.c:3326 [inline]
>      [<00000000ce7a1326>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
>      [<000000007abb7ac9>] kmalloc include/linux/slab.h:547 [inline]
>      [<000000007abb7ac9>] kzalloc include/linux/slab.h:742 [inline]
>      [<000000007abb7ac9>] sctp_stream_init_ext+0x2b/0xa0  net/sctp/stream.c:157
>      [<0000000048ecb9c1>] sctp_sendmsg_to_asoc+0x946/0xa00  net/sctp/socket.c:1882
>      [<000000004483ca2b>] sctp_sendmsg+0x2a8/0x990 net/sctp/socket.c:2102
>      [...]
> 
> But it's freed later.  Kmemleak misses the allocation because its
> pointer is stored in the generic radix tree sctp_stream::out, and the
> generic radix tree uses raw pages which aren't tracked by kmemleak.
> 
> Fix this by adding the kmemleak hooks to the generic radix tree code.

Nice, thanks Eric.

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

> 
> Reported-by: syzbot+7f3b6b106be8dcdcdeec@syzkaller.appspotmail.com
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  lib/generic-radix-tree.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
> index ae25e2fa2187..f25eb111c051 100644
> --- a/lib/generic-radix-tree.c
> +++ b/lib/generic-radix-tree.c
> @@ -2,6 +2,7 @@
>  #include <linux/export.h>
>  #include <linux/generic-radix-tree.h>
>  #include <linux/gfp.h>
> +#include <linux/kmemleak.h>
>  
>  #define GENRADIX_ARY		(PAGE_SIZE / sizeof(struct genradix_node *))
>  #define GENRADIX_ARY_SHIFT	ilog2(GENRADIX_ARY)
> @@ -75,6 +76,27 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
>  }
>  EXPORT_SYMBOL(__genradix_ptr);
>  
> +static inline struct genradix_node *genradix_alloc_node(gfp_t gfp_mask)
> +{
> +	struct genradix_node *node;
> +
> +	node = (struct genradix_node *)__get_free_page(gfp_mask|__GFP_ZERO);
> +
> +	/*
> +	 * We're using pages (not slab allocations) directly for kernel data
> +	 * structures, so we need to explicitly inform kmemleak of them in order
> +	 * to avoid false positive memory leak reports.
> +	 */
> +	kmemleak_alloc(node, PAGE_SIZE, 1, gfp_mask);
> +	return node;
> +}
> +
> +static inline void genradix_free_node(struct genradix_node *node)
> +{
> +	kmemleak_free(node);
> +	free_page((unsigned long)node);
> +}
> +
>  /*
>   * Returns pointer to the specified byte @offset within @radix, allocating it if
>   * necessary - newly allocated slots are always zeroed out:
> @@ -97,8 +119,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
>  			break;
>  
>  		if (!new_node) {
> -			new_node = (void *)
> -				__get_free_page(gfp_mask|__GFP_ZERO);
> +			new_node = genradix_alloc_node(gfp_mask);
>  			if (!new_node)
>  				return NULL;
>  		}
> @@ -121,8 +142,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
>  		n = READ_ONCE(*p);
>  		if (!n) {
>  			if (!new_node) {
> -				new_node = (void *)
> -					__get_free_page(gfp_mask|__GFP_ZERO);
> +				new_node = genradix_alloc_node(gfp_mask);
>  				if (!new_node)
>  					return NULL;
>  			}
> @@ -133,7 +153,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
>  	}
>  
>  	if (new_node)
> -		free_page((unsigned long) new_node);
> +		genradix_free_node(new_node);
>  
>  	return &n->data[offset];
>  }
> @@ -191,7 +211,7 @@ static void genradix_free_recurse(struct genradix_node *n, unsigned level)
>  				genradix_free_recurse(n->children[i], level - 1);
>  	}
>  
> -	free_page((unsigned long) n);
> +	genradix_free_node(n);
>  }
>  
>  int __genradix_prealloc(struct __genradix *radix, size_t size,
> -- 
> 2.23.0
> 
