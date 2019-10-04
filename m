Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65FB5CB496
	for <lists+linux-sctp@lfdr.de>; Fri,  4 Oct 2019 08:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388195AbfJDGwv (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 4 Oct 2019 02:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728935AbfJDGwu (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Fri, 4 Oct 2019 02:52:50 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEB2E20862;
        Fri,  4 Oct 2019 06:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570171969;
        bh=KjLCSWbNFxhPI0um9Zf+8VBwxs6pN5wnIQdyYL09PKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S2fe1c982Qfk2EPIEelIL45x8L+g2a5shLEP1fdVNxHEsYBk3NHOeNIAlwe1oq6rP
         tuCAwhCBbBvY3bFadYh6ADBrOSLn3yP3xix97xY4a/R45OXU9mj+6/AlLUUQ+MdPKZ
         OAeM6mBxfMBTegWjQxadbXj5XVYjTJhymJYz59J4=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-sctp@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH] lib/generic-radix-tree.c: add kmemleak annotations
Date:   Thu,  3 Oct 2019 23:50:39 -0700
Message-Id: <20191004065039.727564-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <CACT4Y+aGjg_JTL-OPMSi1wS4=Zy4xFAizWW5fa8_KMOFpfMeXg@mail.gmail.com>
References: <CACT4Y+aGjg_JTL-OPMSi1wS4=Zy4xFAizWW5fa8_KMOFpfMeXg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Kmemleak is falsely reporting a leak of the slab allocation in
sctp_stream_init_ext():

BUG: memory leak
unreferenced object 0xffff8881114f5d80 (size 96):
   comm "syz-executor934", pid 7160, jiffies 4294993058 (age 31.950s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000ce7a1326>] kmemleak_alloc_recursive  include/linux/kmemleak.h:55 [inline]
     [<00000000ce7a1326>] slab_post_alloc_hook mm/slab.h:439 [inline]
     [<00000000ce7a1326>] slab_alloc mm/slab.c:3326 [inline]
     [<00000000ce7a1326>] kmem_cache_alloc_trace+0x13d/0x280 mm/slab.c:3553
     [<000000007abb7ac9>] kmalloc include/linux/slab.h:547 [inline]
     [<000000007abb7ac9>] kzalloc include/linux/slab.h:742 [inline]
     [<000000007abb7ac9>] sctp_stream_init_ext+0x2b/0xa0  net/sctp/stream.c:157
     [<0000000048ecb9c1>] sctp_sendmsg_to_asoc+0x946/0xa00  net/sctp/socket.c:1882
     [<000000004483ca2b>] sctp_sendmsg+0x2a8/0x990 net/sctp/socket.c:2102
     [...]

But it's freed later.  Kmemleak misses the allocation because its
pointer is stored in the generic radix tree sctp_stream::out, and the
generic radix tree uses raw pages which aren't tracked by kmemleak.

Fix this by adding the kmemleak hooks to the generic radix tree code.

Reported-by: syzbot+7f3b6b106be8dcdcdeec@syzkaller.appspotmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/generic-radix-tree.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/lib/generic-radix-tree.c b/lib/generic-radix-tree.c
index ae25e2fa2187..f25eb111c051 100644
--- a/lib/generic-radix-tree.c
+++ b/lib/generic-radix-tree.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/generic-radix-tree.h>
 #include <linux/gfp.h>
+#include <linux/kmemleak.h>
 
 #define GENRADIX_ARY		(PAGE_SIZE / sizeof(struct genradix_node *))
 #define GENRADIX_ARY_SHIFT	ilog2(GENRADIX_ARY)
@@ -75,6 +76,27 @@ void *__genradix_ptr(struct __genradix *radix, size_t offset)
 }
 EXPORT_SYMBOL(__genradix_ptr);
 
+static inline struct genradix_node *genradix_alloc_node(gfp_t gfp_mask)
+{
+	struct genradix_node *node;
+
+	node = (struct genradix_node *)__get_free_page(gfp_mask|__GFP_ZERO);
+
+	/*
+	 * We're using pages (not slab allocations) directly for kernel data
+	 * structures, so we need to explicitly inform kmemleak of them in order
+	 * to avoid false positive memory leak reports.
+	 */
+	kmemleak_alloc(node, PAGE_SIZE, 1, gfp_mask);
+	return node;
+}
+
+static inline void genradix_free_node(struct genradix_node *node)
+{
+	kmemleak_free(node);
+	free_page((unsigned long)node);
+}
+
 /*
  * Returns pointer to the specified byte @offset within @radix, allocating it if
  * necessary - newly allocated slots are always zeroed out:
@@ -97,8 +119,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 			break;
 
 		if (!new_node) {
-			new_node = (void *)
-				__get_free_page(gfp_mask|__GFP_ZERO);
+			new_node = genradix_alloc_node(gfp_mask);
 			if (!new_node)
 				return NULL;
 		}
@@ -121,8 +142,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 		n = READ_ONCE(*p);
 		if (!n) {
 			if (!new_node) {
-				new_node = (void *)
-					__get_free_page(gfp_mask|__GFP_ZERO);
+				new_node = genradix_alloc_node(gfp_mask);
 				if (!new_node)
 					return NULL;
 			}
@@ -133,7 +153,7 @@ void *__genradix_ptr_alloc(struct __genradix *radix, size_t offset,
 	}
 
 	if (new_node)
-		free_page((unsigned long) new_node);
+		genradix_free_node(new_node);
 
 	return &n->data[offset];
 }
@@ -191,7 +211,7 @@ static void genradix_free_recurse(struct genradix_node *n, unsigned level)
 				genradix_free_recurse(n->children[i], level - 1);
 	}
 
-	free_page((unsigned long) n);
+	genradix_free_node(n);
 }
 
 int __genradix_prealloc(struct __genradix *radix, size_t size,
-- 
2.23.0

