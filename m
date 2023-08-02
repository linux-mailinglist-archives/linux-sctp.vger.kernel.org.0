Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4216076D4C4
	for <lists+linux-sctp@lfdr.de>; Wed,  2 Aug 2023 19:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjHBRJy (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 2 Aug 2023 13:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjHBRJq (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 2 Aug 2023 13:09:46 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF5B30DB
        for <linux-sctp@vger.kernel.org>; Wed,  2 Aug 2023 10:09:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so797735e9.2
        for <linux-sctp@vger.kernel.org>; Wed, 02 Aug 2023 10:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690996173; x=1691600973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BnnEIIbrY5FsJeRKunlnyzI9oBmYX1hBh5P9hRMui1I=;
        b=Yz8ivhBcbzYRSMLpZKsz1IqPAOf6WuhIdSL/zLG8hM22k5Jxj+maiKpECHgpI5m8yB
         Li681THl05E/qavu2AtvDb6iNPMTAQSPZ6TMlbmRaoTWCpe+2OpVvgIoipCBfZvqUtdn
         wphHenQ5DbbYRDnBspieCR0rvsIxWprbh290E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690996173; x=1691600973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnnEIIbrY5FsJeRKunlnyzI9oBmYX1hBh5P9hRMui1I=;
        b=SR61UUXkImp0r8ZyMiT4bR9tKZ/8hFlcZHE95zO2MWHjYfJQAlFJw7f0s0tiW5ER06
         lQySCP28kLt5/Cwo1C97WV1ZC1KNKlgLMGvoF8iHHCT4+O2e5MZion8xRodY4fpt/Xmm
         VyzNnKKPPbxkmOz4uUXsG0cUiUW09XC1dAvfy++CwKiX1pWzYhKMD49aypN1aJhx3pQw
         TQ7NDTC/RbDlcuO1ne2vnsUEGpHRab1/JZkHFhMBPkuYTitl38xYVLyWOv771ByPuXom
         jBcqN22AuNH/bKMXmeUu9u/IaxzwE6A/lPGOPSCsjUKPaWz+vlt/4rQH0N1uFXKmf5n2
         tKgg==
X-Gm-Message-State: ABy/qLbzFXnhlieiL+HBISIckdXPwXLnIGuKKzod1MqDbRmh8xkxQotr
        raPAaV9Bxxj0lFkH8zq0AXZJWBXqusm8mGJA284=
X-Google-Smtp-Source: APBJJlHci9uBvsEo4MEGhHBA+RJT88066Y+QYNCdSobEy02rNfkd2ZeOviM16csEZTGqQRaC3t/DTg==
X-Received: by 2002:a05:600c:2907:b0:3fb:a62d:1992 with SMTP id i7-20020a05600c290700b003fba62d1992mr5392990wmd.0.1690996172976;
        Wed, 02 Aug 2023 10:09:32 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4fa6:1e54:d09:5ba3])
        by smtp.gmail.com with ESMTPSA id s1-20020a5d4ec1000000b003063db8f45bsm19508396wrv.23.2023.08.02.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:09:32 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sctp@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        hillf.zj@alibaba-inc.com, marcelo.leitner@gmail.com,
        lucien.xin@gmail.com, Florent Revest <revest@chromium.org>
Subject: [RFC 0/1] crypto: Avoid a sleepable operation when freeing a SCTP socket
Date:   Wed,  2 Aug 2023 19:09:22 +0200
Message-ID: <20230802170923.1151605-1-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi!

I found that the following program reliably reproduces a "BUG: sleeping function
called from invalid context" backtrace in crypto code:

#include <sys/socket.h>
#include <linux/in.h>
#include <linux/if_alg.h>

int main(void)
{
	int fd1 = socket(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
	if (fd1 == -1)
		return 1;
	listen(fd1, 1);

	int fd2 = socket(AF_ALG, SOCK_SEQPACKET, 0);
	if (fd2 == -1)
		return 2;
	struct sockaddr_alg addr = {
		.salg_family = AF_ALG,
		.salg_type = "hash",
		.salg_name = "cryptd(md5-generic)",
	};
	bind(fd2, &addr, sizeof(addr));

	return 0;
}

The backtraces look like:

...
 __might_sleep+0x8f/0xe0 kernel/sched/core.c:7260
 down_write+0x78/0x180 kernel/locking/rwsem.c:1556
 crypto_drop_spawn+0x50/0x220 crypto/algapi.c:709
 shash_free_singlespawn_instance+0x19/0x30 crypto/shash.c:621
 crypto_shash_free_instance+0x35/0x40 crypto/shash.c:458
 crypto_free_instance crypto/algapi.c:68 [inline]
 crypto_destroy_instance+0x7d/0xb0 crypto/algapi.c:76
 crypto_alg_put crypto/internal.h:108 [inline]
 crypto_mod_put crypto/api.c:45 [inline]
 crypto_destroy_tfm+0x1f7/0x250 crypto/api.c:573
 crypto_free_shash include/crypto/hash.h:734 [inline]
 sctp_destruct_common net/sctp/socket.c:5003 [inline]
 sctp_v6_destruct_sock+0x40/0x50 net/sctp/socket.c:9436
 __sk_destruct+0x56/0x780 net/core/sock.c:1784
 sk_destruct net/core/sock.c:1829 [inline]
 __sk_free+0x36c/0x470 net/core/sock.c:1840
 sk_free+0x51/0x90 net/core/sock.c:1851
 sock_put include/net/sock.h:1815 [inline]
 sctp_endpoint_destroy_rcu+0xa6/0xf0 net/sctp/endpointola.c:193
 rcu_do_batch kernel/rcu/tree.c:2492 [inline]
 rcu_core+0x7cc/0x1260 kernel/rcu/tree.c:2733
 rcu_core_si+0x9/0x10 kernel/rcu/tree.c:2746
 __do_softirq+0x3dc/0x93b kernel/softirq.c:298
...

My analysis is that, when the process dies, the socket freeing is done in a RCU
callback, therefore under softirq context, therefore sleeping is disabled. As
part of freeing a SCTP socket, we free a cryptographical transform that frees a
"spawn" and this grabs a semaphore which triggers this BUG under
CONFIG_DEBUG_ATOMIC_SLEEP=y.

I believe that we could solve this problem by defering any part of this
backtrace into a worker function. Unfortunately, I have no clue about anything
SCTP nor anything crypto/ so I took a stab at defering... something. :) I marked
this as RFC to make it clear I don't hold strong opinions about what should be
defered exactly and expect this will probably change as a result of code review.

I believe that the same bug has been reported by syzbot twice in the past,
without reproducers and once with a slight twist:
- Once, upon freeing a sctp socket (the backtraces are very similar)
  https://lore.kernel.org/all/00000000000060f19905a74b6825@google.com/T/
  but as far as I can tell the conversation focused on the safety of kfree()
  rather than the semaphore protecting the spawns list (maybe I'm missing
  something here ?)
- Once, upon freeing a tipc socket:
  https://lore.kernel.org/all/000000000000c9257305c61c742c@google.com/T/
  Hillf proposed a fix but, as far as I can tell, it didn't get much attention
  and focused solely on addressing the bug for tipc sockets.
  My fix is inspired by this but further down the backtrace to make the fix work
  for both tipc and sctp (and potentially more ?) sockets freeing.

This patch should apply cleanly on v6.5-rc3.

Florent Revest (1):
  crypto: Defer transforms destruction to a worker function

 crypto/api.c           | 26 ++++++++++++++++++--------
 include/linux/crypto.h |  3 +++
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog

